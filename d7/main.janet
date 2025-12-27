(def cache @{})
(var splits 0)

(defn solve [g y x]
  (or (get cache [y x])
      (if (= y (dec (length g))) 1
        (let [result (cond
                       (and (= "." (get-in g [(inc y) x])))
                       (solve g (inc y) x)
                       (and (= "^" (get-in g [(inc y) x])))
                       (do
                         (+= splits 1)
                         (+ (solve g (inc y) (dec x))
                            (solve g (inc y) (inc x)))))]
          (do (put cache [y x] result) result)))))

(defn main [&]
  (let [g (->> (file/read stdin :all)
               (string/replace "S" "|")
               (peg/match ~(split "\n" (group (some '1)))))
        p2 (solve g 1 (find-index |(= "|" $0) (0 g)))]
    (pp [splits p2])))
