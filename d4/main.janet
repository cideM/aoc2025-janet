(def parser (peg/compile ~(split :s (any (group (* (line) (column) '1))))))

(def adj-vecs [[-1 -1] [0 -1] [1 -1] [1 0] [1 1] [0 1] [-1 1] [-1 0]])

(defn move [[y x] [dy dx]] [(+ y dy) (+ x dx)])

(defn extract-paper [g]
  (let [todo (seq [[pos v] :in (pairs g)
                   :let [adj (->> (map |(move pos $) adj-vecs)
                                  (map |(g $))
                                  (count |(= "@" $)))]
                   :when (and (= v "@") (< adj 4))] pos)]
    (each pos todo (put g pos nil))
    (length todo)))

(defn extractor [g] (generate [_ :iterate true] (extract-paper g)))

(defn solve [input]
  (let [g (->> (string/trimr input)
               (peg/match parser)
               (map (fn [[y x v]] [[y x] v]))
               from-pairs)
        p1 (extract-paper g)
        p2 (-> (take-until |(= 0 $) (extractor g)) sum (+ p1))]
    [p1 p2]))

(defn main [&] (->> (file/read stdin :all) solve pp))
