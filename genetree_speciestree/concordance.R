require(viridis)
require(GGally)
require(entropy)
require(ggtree)
require(treeio)
require(tidytree)
require(ggplot2)
require(dplyr)
require(ggrepel)

# read the data
d = read.delim("out/concordlocus.cf.stat", header = T, comment.char='#')  # concordance statistics
tree <- read.iqtree("out/concordlocus.cf.tree")  # read in tree file
               
names(d)[names(d)=="Label"] = "bootstrap"
names(d)[names(d)=="Length"] = "branchlength"


# plot the values
ggplot(d, aes(x = gCF, y = sCF)) + 
    geom_point(aes(colour = bootstrap)) + 
    scale_colour_viridis(direction = -1) + 
    xlim(0, 100) +
    ylim(0, 100) +
    geom_abline(slope = 1, intercept = 0, linetype = "dashed")

# jitter the points and label
ggplot(d, aes(x = gCF, y = sCF, label = ID)) + 
    geom_jitter(aes(colour = bootstrap)) + 
    scale_colour_viridis(direction = -1) + 
    xlim(0, 100) +
    ylim(0, 100) +
    geom_abline(slope = 1, intercept = 0, linetype = "dashed") +
    geom_text_repel(max.overlaps=25)

# show branches of interest
d[(d$ID==20|d$ID==22),]  # these have lower bootstrap support than the others

# plot the tree

tib <- as_tibble(tree)
d$node <- d$ID + 1 

td <- full_join(tib, d, by = "node")  # combine the tree (tib) and data (d)
td <- as.treedata(td)       # coerce to treedata format (td)

ggtree(td, aes(color=SH_aLRT)) +          # plot tree
	theme(legend.position="right") +
	geom_tiplab(size=2, color="black") +                         # add tip labels
	geom_label2(aes(label=label, subset=!isTip), color="black") + # add node labels 
	geom_label2(aes(label=label, subset= (!isTip & (node==21 | node==23))), color="black", fill="yellow") + 								 # highlight low bootstrap support 
	scale_color_continuous(low="yellow", high="purple") # color the branches by bootstrap

ggtree(td) +                                      # plot tree
	geom_tiplab(size=2) +                               # plot tip labels
#	geom_label2(aes(label=node, subset= !isTip))  # plot node numbers 
	geom_nodelab(aes(label=node), hjust=2, nudge_y=2, size=2)  # plot node numbers 

# test ILS assumptions

# first we use a slightly modified chisq function
# which behaves nicely when you feed it zeros
chisq = function(DF1, DF2, N){
    tryCatch({
        # converts percentages to counts, runs chisq, gets pvalue
        chisq.test(c(round(DF1*N)/100, round(DF2*N)/100))$p.value
    },
    error = function(err) {
        # errors come if you give chisq two zeros
        # but here we're sure that there's no difference
        return(1.0)
    })
}

e = d %>% 
    group_by(ID) %>%
    mutate(gEF_p = chisq(gDF1, gDF2, gN)) %>%
    mutate(sEF_p = chisq(sDF1, sDF2, sN))
    

subset(data.frame(e), (gEF_p < 0.05 | sEF_p < 0.05))



# calculate internode certainty

IC = function(CF, DF1, DF2, N){
    
    # convert to counts
    X = CF * N / 100
    Y = max(DF1, DF2) * N / 100
        
    pX = X/(X+Y)
    pY = Y/(X+Y)
    
    IC = 1 + pX * log2(pX) +
             pY * log2(pY)

    return(IC)
}


e = e %>% 
    group_by(ID) %>%
    mutate(gIC = IC(gCF, gDF1, gDF2, gN)) %>%
    mutate(sIC = IC(sCF, sDF1, sDF2, sN))


# entropy

ENT = function(CF, DF1, DF2, N){
    
    CF = CF * N / 100
    DF1 = DF1 * N / 100
    DF2 = DF2 * N / 100
    
    return(entropy(c(CF, DF1, DF2)))

}

ENTC = function(CF, DF1, DF2, N){
    
    maxent = 1.098612
    
    CF = CF * N / 100
    DF1 = DF1 * N / 100
    DF2 = DF2 * N / 100
    
    ent = entropy(c(CF, DF1, DF2))
    
    entc = 1 - (ent / maxent)
    
    return(entc)
    
}

e = e %>% 
    group_by(ID) %>%
    mutate(sENT = ENT(sCF, sDF1, sDF2, sN)) %>%
    mutate(sENTC = ENTC(sCF, sDF1, sDF2, sN))
    
head(e)

# plot it
ggpairs(e, columns = c("gCF", "sCF", "bootstrap", "gEF_p", "sEF_p", "gIC", "sIC", "sENT", "sENTC"))