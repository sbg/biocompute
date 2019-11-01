# print text
cat_text <- function(...) {
  cat(paste0(..., "\n"), sep = "")
}

# stylize checklist items
cat_checklist <- function(...) {
  cli::cat_bullet(paste0(...), bullet = "tick", bullet_col = "green")
}

# print text with surrounding rules
rule_text <- function(text, ...) {
  cli::cat_rule(left = crayon::bold(text), ...)
}

# stylize input file path
cat_path_input <- function(...) {
  crayon::blue(encodeString(..., quote = '"'))
}

# stylize output file path
cat_path_output <- function(...) {
  crayon::green(encodeString(..., quote = '"'))
}
