
generate_csv <- function(object_file, image_file)
{
  
  
  df = read.csv(file = object_file)
  img_rows = select(df, contains("Classify"))
  img_rows <- img_rows %>% 
    select_all(~str_replace(.,'Classify_', ''))
  
  dfr = img_rows
  dfr$ImageNumber <- df$ImageNumber
  dfr$ObjectNumber <- df$ObjectNumber
  dfr$Area <- df$AreaShape_Area
  df = dfr
  
  
  
  image_names = read.csv(image_file)
  image_df <- image_names[,c("FileName_original", "ImageNumber")]
  df <- merge(df, image_df, by="ImageNumber")
  
  
  
  dfs <- list()
  
  for(r in colnames(img_rows))
  {
    
    
    row <- df %>% filter(.[[r]]==1) 
    if(nrow(row) > 0)
    {
      agg <- aggregate(row$Area, by = list(FileName_original = row$FileName_original), FUN=sum)
      colnames(agg) <- c("FileName_original", r)
      
      dfs <- c(dfs, list(agg))
    }
    
  }
  
  

  
  rowareas <- Reduce(function(left,right) merge(left,right, by="FileName_original", all.x=TRUE, all.y=TRUE), dfs)
  return(rowareas)

}







