### Violin plot

res_dir <- '/Users/casu/Yttri'
setwd(res_dir)

spikes1 <- read.table('/Users/casu/Yttri/spikes1.txt')
spikes2 <- read.table('/Users/casu/Yttri/spikes2.txt')

type1 <- read.table('/Users/casu/Yttri/type1.txt')
type2 <- read.table('/Users/casu/Yttri/type2.txt')

# Convert the variable spikes from a numeric to a factor variable
type1 <- as.factor((unlist(type1)))
type2 <- as.factor((unlist(type2)))

t1 <- data.frame("celltype" = type1, "spike" = spikes1)
colnames(t1) <- c("celltype", "spike")
t2 <- data.frame("celltype" = type2, "spike" = spikes2)
colnames(t2) <- c("celltype", "spike")
# Convert the variable dose from a numeric to a factor variable
ToothGrowth$dose <- as.factor(ToothGrowth$dose)
head(ToothGrowth)

# Basic violin plot
ggplot(ToothGrowth, aes(x=dose, y=len)) + 
  geom_violin(trim=FALSE, fill="gray")+
  labs(title="Plot of length  by dose",x="Dose (mg)", y = "Length")+
  geom_boxplot(width=0.1)+
  theme_classic()
# Change color by groups
library(ggplot2)
dp <- ggplot(t1, aes(x=celltype, y=spike, fill=celltype)) + 
  geom_violin(trim=FALSE)+
  ylim(-10, 100)+
  geom_boxplot(width=0.1, fill="white")+
  scale_x_discrete(labels=c("ventral", "dorsal", "motor"))+
  labs(title="Plot of spike distribution (M1)",x="Celltype", y = "Spike per 500ms")
dp + scale_fill_brewer(palette="RdBu") + theme(axis.title.x =element_blank(),
                                               legend.position="none",
                                               plot.title = element_text(size = 14, face = "bold", hjust = 0.5))
