(def parser
  (peg/compile
    ~(split "," (group (* (number :d+) "-" (number :d+))))))

(defn filter* [f ds] (coro (each v ds (when (f v) (yield v)))))

(defn chunks [s]
  "Split s into all evenly sized, non-overlapping
  substrings whose length is < (length s)"
  (let [len (length s)
        biggest-chunk-size (math/floor (/ len 2))]
    (coro
      (loop [chunk-size :down-to [biggest-chunk-size 1]
             :when (= 0 (% len chunk-size))]
        (yield (seq [start :range [0 len chunk-size]]
                 (string/slice s start (+ start chunk-size))))))))

(assert (deep= (take 5 (chunks "123123"))
               @[@["123" "123"]
                 @["12" "31" "23"]
                 @["1" "2" "3" "1" "2" "3"]]))

(defn solve [input]
  (var p1 0)
  (var p2 0)
  (let [ranges (peg/match parser (string/trimr input))]
    (loop [[start end] :in ranges num :range-to [start end]]
      (when (->> (chunks (string num))
                 (find |(-> (distinct $) length (= 1))))
        (+= p2 num))
      (when (->> (chunks (string num))
                 (filter* |(= 2 (length $)))
                 (find |(-> (distinct $) length (= 1))))
        (+= p1 num))))
  [p1 p2])

(defn main [&] (->> (file/read stdin :all) solve pp))
