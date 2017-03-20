library(magick)

gif2c <- list.files("gifs/old/")
start_png <- image_read("screenshots/START1.png")
start_gif <- image_animate(start_png, fps = 1/4)
finish_png <- image_read("screenshots/FINISH1.png")
finish_gif <- image_animate(finish_png, fps = 1/4)

for(i in seq_along(gif2c)){
  right_width <- image_info(image_read(paste0("gifs/old/", gif2c[i])))["width"][[1]][1]
  right_height <- image_info(image_read(paste0("gifs/old/", gif2c[i])))["height"][[1]][1]
  
  width_size <- image_info(start_gif)["width"][[1]][1]
  height_size <- image_info(start_gif)["height"][[1]][1]
  avg <- mean(right_width/width_size, right_height/height_size)
  start_gif <- image_scale(start_gif, paste0(avg * 100, "%"))
  image_write(start_gif, "gifs/START.gif")
  
  width_size <- image_info(finish_gif)["width"][[1]][1]
  height_size <- image_info(finish_gif)["height"][[1]][1]
  avg <- mean(right_width/width_size, right_height/height_size)
  start_gif <- image_scale(start_gif, paste0(avg * 100 + 7, "%"))
  finish_gif <- image_scale(finish_gif, paste0(avg * 100, "%"))
  image_write(finish_gif, "gifs/FINISH.gif")
  
  system(paste0("convert -loop 0 gifs/START.gif", 
    " gifs/old/", gif2c[i],
    " gifs/FINISH.gif",
    " gifs/", gif2c[i])
  )
}
