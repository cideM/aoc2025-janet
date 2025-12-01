(def parser
  (peg/compile
    ~(split "\n" (group (* (<- (+ "L" "R")) (number :d+))))))

(defn rotate [dial [dir distance]]
  (if (= dir "L") (mod (- dial distance) 100)
    (mod (+ dial distance) 100)))

(defn solve [input]
  (var dial 50)
  (var p1 0)
  (var p2 0)
  (loop [rot :in (peg/match parser (string/trimr input))
         :let [[dir distance] rot
               cycles (div distance 100)
               rem (% distance 100)
               next (rotate dial rot)]]
    (do (if (= next 0) (++ p1))
      (+= p2 (cond
               # Remainder can never cross zero if the dial is at 0
               (= dial 0) cycles
               (or (and (= dir "R") (> (+ dial rem) 99))
                   (and (= dir "L") (<= (- dial rem) 0))) (inc cycles)
               cycles))
      (set dial next)))
  [p1 p2])

(defn main [&] (->> (file/read stdin :all) solve pp))
