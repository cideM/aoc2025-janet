(def parser
  (peg/compile
    ~{:main (* :fresh-ids :sep :available-ids)
      :sep "\n\n"
      :fresh-ids (sub (to :sep) (group (split "\n" (group :range))))
      :range (* (number :d+) "-" (number :d+))
      :available-ids (group (split "\n" (number :d+)))}))

(defn fresh? [n ranges]
  (truthy? (find (fn [[a b]] (and (>= n a) (<= n b))) ranges)))

(defn range< [[a b] [a2 b2]] (if (= a a2) (< b b2) (< a a2)))

(defn overlap? [[a b] [a2 b2]]
  (or (and (>= a2 a) (<= a2 b)) (and (>= b2 a) (<= b2 b))))

(defn merge-ranges [[x & xs]]
  (reduce |(let [r1 (last $0) r2 $1 [a b] r1 [a2 b2] r2]
             (if (overlap? r1 r2)
               (array ;(slice $0 0 -2) [(min a a2) (max b b2)])
               (array ;$0 r2))) [x] xs))

(defn solve [input]
  (let [[fresh-ids available-ids] (peg/match parser (string/trimr input))
        p1 (count |(fresh? $0 fresh-ids) available-ids)
        p2 (->> (sorted fresh-ids range<)
                merge-ranges
                (map (fn [[from to]] (inc (- to from))))
                sum)]
    [p1 p2]))

(defn main [&] (->> (file/read stdin :all) solve pp))
