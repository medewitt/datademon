library(tidyverse)
library(ggthemes)

theme_wake <- function () {
  theme_bw(base_size=20, base_family="Avenir") %+replace%
    theme(
      panel.background  = element_blank(),
      plot.background = element_rect(fill="gray96", colour=NA),
      legend.background = element_rect(fill="transparent", colour=NA),
      legend.key = element_rect(fill="transparent", colour=NA)
    )
}

theme_wake_prop <- function () {
  theme_bw(base_size=20, base_family="Palatino") %+replace%
    theme(
      panel.background  = element_blank(),
      plot.background = element_rect(fill="gray96", colour=NA),
      legend.background = element_rect(fill="transparent", colour=NA),
      legend.key = element_rect(fill="transparent", colour=NA)
    )
}

wfu_palette <- c("#9E7E38", "#000000","#82231C", "#511536", "#443E67", "#375669", "#456525", "#59786C", "#3D3C1D", "#625750")
wfu_palette_neutral <- c("#9E7E38", "#000000", "#FFFDE8", "#E7DCBA", "#E5E0D9", "#C1B58A", "#C2BDAD")
wfu_colour_palette_primary <- c("#9E7E38", "#000000")

# ggplot(mtcars, aes(x = disp, y = mpg, color = as.factor(carb)))+
#   geom_point(size= 3)+
#   #scale_fill_manual(values = wfu_palette)+
#   #scale_colour_manual(values = wfu_palette)+
#   ggtitle("Test of the Different Wake Forest Colors")+
#   theme_wake_tufte()+
#   labs(
#     subtitle = "Test"
#   )
# mtcars

theme_wake_tufte <- function () {
  theme_tufte(base_size=20, base_family="Avenir") %+replace%
    theme(
      panel.background  = element_blank(),
      plot.background = element_rect(fill="gray96", colour=NA),
      legend.background = element_rect(fill="transparent", colour=NA),
      legend.key = element_rect(fill="transparent", colour=NA)
    )
}

theme_wake_prop_tufte <- function () {
  theme_tufte(base_size=20, base_family="Palatino") %+replace%
    theme(
      panel.background  = element_blank(),
      plot.background = element_rect(fill="gray96", colour=NA),
      legend.background = element_rect(fill="transparent", colour=NA),
      legend.key = element_rect(fill="transparent", colour=NA)
    )
}
