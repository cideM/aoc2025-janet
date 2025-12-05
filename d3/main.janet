(def parser (peg/compile ~(split "\n" (group (any (number :d))))))

(defn max-joltage [arr-init size]
  (var arr arr-init)
  (->> (seq [n :down-to [size 1]
             :let [choice (array/slice arr 0 (- (length arr) (dec n)))
                   max-n (max ;choice)
                   max-i (find-index |(= $ max-n) choice)
                   remaining (array/slice arr (inc max-i))]
             :after (set arr remaining)] max-n)
       (map string) string/join scan-number))

(defn solve [input]
  (let [banks (peg/match parser (string/trimr input))]
    [(sum (map |(max-joltage $ 2) banks))
     (sum (map |(max-joltage $ 12) banks))]))

(defn main [&] (->> (file/read stdin :all) solve pp))
