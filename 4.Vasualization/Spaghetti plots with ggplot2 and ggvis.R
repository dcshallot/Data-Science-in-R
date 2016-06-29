
# http://www.r-bloggers.com/spaghetti-plots-with-ggplot2-and-ggvis

# the graphics and statistical analysis for 
# a two treatment,two period, two sequence (2x2x2) crossover drug interaction study of
# a new drug versus the standard. 

# dataset description: http://www.amstat.org/publications/jse/datasets/ocdrug.txt




ocdrug <- read.table( 'http://www.amstat.org/publications/jse/datasets/ocdrug.dat.txt',sep="") 
## “workdir” is the name of the variable storing the directory name where the data file is stored 
colnames(ocdrug) <- c("ID","Seq","Period","Tmnt","EE_AUC","EE_Cmax","NET_AUC","NET_Cmax")

## Give nice names to the treatments (OCD and OC) and the treatment sequence 
ocdrug$Seq <- factor(ifelse(ocdrug$Seq == 1,"OCD-OC","OC-OCD"))
ocdrug$Tmnt <- factor(ifelse(ocdrug$Tmnt == 0,"OC","OCD"), levels = c("OCD", "OC"))

head(ocdrug)
summary(ocdrug)
# Columns   Description
# ID  Female Subject Number (1 to 22)
# seq Treatment Sequence (1 = Drug D, placebo; 2 = placebo, Drug D)
# period  Study Period (1, 2)
# Tmnt Treatment (0 = placebo, 1 = Drug D)
# EE - AUC (pg*hr/ml) 药时曲线下面积
# EE - Cmax (pg/ml)
# NET - AUC (pg*hr/ml)
# NET - Cmax (pg/ml)
# uid 实验id

require(ggplot2)
require(ggvis)
require(gridExtra)  ## required to arrange ggplot2 plots in a grid

mytheme <- theme_classic() %+replace% 
  theme(axis.title.x = element_blank(), 
        axis.title.y = element_text(face="bold",angle=90)) 

p1 <- ggplot(data = ocdrug, aes(x = Tmnt, y = EE_AUC, group = ID, colour = Seq)) +
  mytheme +
  coord_trans(y="log10", limy=c(1000,6000)) +
  labs(list(title = "AUC", y = paste("EE","n","pg*hr/mL"))) + 
  geom_line(size=1) + theme(legend.position="none")

p2 <- ggplot(data = ocdrug, aes(x = Tmnt, y = EE_Cmax, group = ID, colour = Seq)) +
  mytheme +
  coord_trans(y="log10", limy=c(100,700)) +
  labs(list(title = "Cmax", y = paste("EE","n","pg/mL"))) + 
  geom_line(size=1) + 
  geom_text(data=subset(ocdrug, ID %in% c(2,20)), aes(Tmnt,EE_Cmax,label=ID)) +
  theme(legend.position="none")

p3 <- ggplot(data = ocdrug, aes(x = Tmnt, y = NET_AUC, group = ID, colour = Seq)) +
  mytheme +
  coord_trans(y="log10", limy=c(80000,300000)) +    
  labs(list(y = paste("NET","n","pg*hr/mL"))) + 
  geom_line(size=1) + 
  geom_text(data=subset(ocdrug, ID %in% c(18,22,20)), aes(label=ID), show_guide = F) +
  scale_colour_discrete(name="Sequence: ", labels=c("OCD then OC", "OC then OCD")) + 
  theme(legend.position="bottom")

p4 <- ggplot(data = ocdrug, aes(x = Tmnt, y = NET_Cmax, group = ID, colour = Seq)) +
  mytheme +
  coord_trans(y="log10", limy=c(10000,60000)) +
  labs(list(y = paste("NET","n","pg/mL"))) + 
  geom_line(size=1) + 
  geom_text(data=subset(ocdrug, ID == 9), aes(label=ID), show_guide = F) +
  scale_colour_discrete(name="Sequence: ", labels=c("OCD then OC", "OC then OCD")) + 
  theme(legend.position="bottom")

# output
# png(filename = paste(workdir,"ByTmnt_ggplot2.png",sep=""), width = 640, height = 640, bg="transparent")
grid.arrange(p1, p2, p3, p4, ncol = 2)
#　dev.off()

# Creating an interactive spaghetti plot with ggvis

ocdrug$uid <- 1:nrow(ocdrug)  # Add an unique id column to use as the key
all_values <- function(x) {
  if(is.null(x)) return(NULL)
  row <- ocdrug[ocdrug$uid == x$uid,]
  paste0(names(row[1]), ": ", format(row[1]))
}


ocdrug <- group_by(ocdrug, ID) ## Data is grouped, by subjects ocdrug %>% 

ocdrug %>% 
  ggvis(x = ~Tmnt, y = input_select(c("EE: AUC" = "EE_AUC", "EE: Cmax" = "EE_Cmax",
                                      "NET: AUC" = "NET_AUC", "NET: Cmax" = "NET_Cmax"), 
                                    label="Y-aixs variable", map = as.name)) %>%    ## choose which graph to display
  layer_paths(stroke = ~Seq) %>%    ## color lines by treatment sequence as before
  layer_points(fill = ~Seq) %>%        ## color points by treatment sequence as before
  layer_points(fill = ~Seq, key := ~uid) %>%    ## having to do it twice, 
  ## else the points just seemed to appear and disappear. Have not understood why?
  add_axis("x", title = "Group", title_offset = 50, grid=FALSE) %>%    ## Axes and legend
  add_axis("y", title = "", grid=FALSE) %>%
  scale_numeric("y", trans="log") %>%
  hide_legend("stroke") %>%
  add_legend("fill", title = "Sequence") %>%
  add_tooltip(all_values, "hover")    ## Finally add the tooltip




