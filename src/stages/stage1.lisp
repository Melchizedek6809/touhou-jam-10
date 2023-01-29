;; Some strange quirks to be aware of:
;; Every symbol/literal needs to be at least 2 characters long, even numbers
;; So instead of writing 0 you need to write 0.0
;; This is also why we use (add) instead of (+)
;; Might fix this after the Jam is done

(deffiber fairy-top (xpos interval)
          (spawn fairy (add xpos 200) -64)
          (move xpos 500 (add xpos 200) 350)
          (wait 1500)
          (shoot-every interval)
          (move (add xpos 100) 800 (add xpos 200) 860)
          (wait 3000))

(deffiber fairy-top-easy (xpos xpos-end interval speed)
          (spawn fairy xpos -32)
          (shoot-every interval)
          (move xpos-end 756 (add xpos-end 200) 360)
          (wait speed))

(deffiber fairy-bot-easy (xpos xpos-end interval speed)
          (spawn fairy xpos 756)
          (shoot-every interval)
          (move xpos-end -32 (add xpos-end 200) 360)
          (wait speed))

(deffiber fairy-bot (xpos interval)
          (spawn fairy (add xpos 200) 800)
          (move (add xpos 50) 400 (add xpos -100) 550)
          (wait 1500)
          (shoot-every interval)
          (move (add xpos 100) -64 (add xpos 300) 120)
          (wait 3000))

(deffiber fairy-swing-bot (xpos interval width height)
          (spawn fairy (add xpos width) 752)
          (move xpos (add 752 height) (add xpos 100) (add 752 height -100))
          (wait 1000)
          (move (add xpos (sub 0.0 width)) 752 (add xpos 200) 752)
          (shoot-every interval)
          (wait 2000))

(deffiber fairy-swing-top (xpos interval width height)
          (spawn fairy (add xpos width) -32)
          (move xpos height (add xpos 200) (add height 50))
          (wait 1000)
          (shoot-every interval)
          (move (add xpos (sub 0.0 width)) -32 (add xpos -150) 32)
          (wait 2000))

(deffiber fairy-swing-top-shoot (xpos interval width height)
          (spawn fairy (add xpos width) -32)
          (move xpos height)
          (wait 1000)
          (move xpos height)
          (shoot-every interval)
          (wait 1000)
          (shoot-every 0)
          (move (add xpos (sub 0.0 width)) -32)
          (wait 1000))

(deffiber boss-fa-icicle-daisies ()
          (begin-spell-card)

          (move 1100 160 1300 260)
          (wait 2100)
          (shoot-every 66.0 wave)
          (wait-here 700)
          (shoot-every 0.0 wave)

          (move 1100 360 900 260)
          (wait 2100)
          (shoot-every 66.0 wave)
          (wait-here 700)
          (shoot-every 0.0 wave)

          (move 1100 560 1300 460)
          (wait 2100)
          (shoot-every 66.0 wave)
          (wait-here 700)
          (shoot-every 0.0 wave)

          (move 1100 360 900 460)
          (wait 2100)
          (shoot-every 66.0 wave)
          (wait-here 700)
          (shoot-every 0.0 wave))


(deffiber boss-fa-frozen-tea ()
          (begin-spell-card)

          (move 1050 560 1200 560)
          (wait 2100)
          (shoot-every 300.0 tea)
          (wait-here 700)
          (shoot-every 100.0 projectile)

          (move 1050 160 1200 360)
          (wait 2100)
          (shoot-every 300.0 tea)
          (wait-here 700)
          (shoot-every 100.0 projectile)

          (move 1200 360 1200 160)
          (wait 2100)
          (shoot-every 300.0 tea)
          (wait-here 700)
          (shoot-every 100.0 projectile))


(deffiber boss-first-appearance ()
          (spawn boss 1400 500 5)
          (move 1100 360 1000 540)
          (wait 1000)
          (interpolate 0)

          (boss-fa-icicle-daisies)
          (wait-spell-end)
          (stop-spell)

          (interpolate 1)
          (wait 200)
          (move 1100 360)
          (wait 400)
          (interpolate 0)

          (boss-fa-frozen-tea)
          (wait-spell-end)
          (stop-spell)

          (interpolate 1)
          (move 1400 200)
          (wait 700)

          (despawn))


(wait 3000)

;; WAVE ONE
(fairy-top-easy 800 900 0.0 6000)
(wait 1000)
(fairy-top-easy 820 920 0.0 6000)
(wait 1000)
(fairy-top-easy 840 940 0.0 6000)
(wait 1000)
(fairy-top-easy 860 960 1000 6000)
(wait 1000)
(fairy-top-easy 880 980 1000 6000)
(wait 1000)

(wait 5000)
(fairy-bot-easy 800 900 1000 6000)
(wait 1000)
(fairy-bot-easy 820 920 1000 6000)
(wait 1000)
(fairy-bot-easy 840 940 1000 6000)
(wait 1000)
(fairy-bot-easy 860 960 1000 6000)
(wait 1000)
(fairy-bot-easy 880 980 1000 6000)
(wait 3000)
;; END WAVE ONE

;; Wave 2
(dotimes (iter 5)
         (fiber (wait (mul iter 1000))
                (fairy-bot (add 800 (mul iter 20)) 1000)))
(wait 5000)
(wait 3000)



(dotimes (iter 5)
         (fiber (wait (mul iter 1000))
                (fairy-swing-bot (add 800 (mul iter 20)) 350 200 -200)))
(wait 5000)
(wait 3000)



(dotimes (iter 5)
         (fiber (wait (mul iter 1000))
                (fairy-top (add 600 (mul iter 20)) 5000)
                (wait 500)
                (fairy-bot (add 800 (mul iter 20)) 1000)))
(wait 5000)
(wait 3000)

(dotimes (iter 5)
         (fiber (wait (mul iter 1000))
                (fairy-swing-top (add 800 (mul iter 20)) 1000 200 200)
                (wait 500)
                (fairy-swing-bot (add 800 (mul iter 20)) 1000 200 -200)))
(wait 5000)
(wait 3000)



(dotimes (iter 10)
         (fiber (wait (mul iter 50))
                (fairy-top (add 700 (mul iter 40)) 1000)))
(wait 2000)
(wait 3000)


(dotimes (iter 10)
         (fiber (wait (mul iter 50))
                (fairy-bot (add 700 (mul iter 40)) 1000)))
(wait 2000)
(wait 3000)

(dotimes (iter 10)
         (fiber (wait (mul iter 400))
                (fairy-top (add 700 (mul iter 40)) 1000)
                (wait 200)
                (fairy-bot (add 700 (mul iter 40)) 1000)))
(wait 4000)
(wait 2000)

(dotimes (iter 10)
         (fiber (wait (mul iter 100))
                (fairy-top (add 800 (mul iter 40)) 1000)
                (wait 50)
                (fairy-bot (add 800 (mul iter 40)) 1000)))
(wait 3000)
(wait 3000)

;; END WAVE 2

;;; FIRST MID BOSS!!!
(boss-first-appearance)
(wait 1000)
(wait-no-boss)



(comment
(fairy-swing-top-shoot (add 800 (mul iter 20)) 200 200 100)
(wait 500)
(fairy-swing-top (add 800 (mul iter 20)) 200 200 100)
(wait 500)
(wait 7000)
)


;(wait 1000)
;(fairy-top 600 200)
;(fairy-bot 600 200)

;(wait 3000)
;(fairy-top 600 200)
;(fairy-top 700 200)
;(fairy-bot 600 200)
;(fairy-bot 700 200)

