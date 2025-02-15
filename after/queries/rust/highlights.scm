; extend the existing highlight rules
;;extends

; These are S-expressions <https://en.wikipedia.org/wiki/S-expression>

; priority is required so that the highlights from LSP don't take preference. Think of this like !important in css.
(("async") @keyword.async (#set! "priority" 200))
(("await") @keyword.await (#set! "priority" 200))

; [
;   (identifier) @custom_keyword
;   (#match? @custom_keyword "^(unwrap|expect|panic)$")
; ]

