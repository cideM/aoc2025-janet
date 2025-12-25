(def parser
  ~(split "\n" (group (some (+ (number :d+) '(set "*+") 1)))))

(def ops @{"*" * "+" +})

(defn compute [stream]
  (var results @[])
  (var buf @[])
  (each x stream
    (if (get ops x)
      (do
        (array/push results (apply (get ops x) buf))
        (set buf @[]))
      (array/push buf x)))
  results)

(defn columns* [data]
  (coro (loop [col :range [0 (length (first data))]
               row :range [0 (length data)]]
          (yield (get-in data [row col])))))

(defn rtl [input]
  "Create a new string, as a single line, by
  reading input from right to left and top to bottom"
  (var buf @[])
  (let [lines (string/split "\n" input)]
    (loop [col :down-to [(dec (length (first lines))) 0]
           row :range [0 (dec (length lines))]]
      (array/push buf (string/slice (row lines) col (inc col)))))
  (string ;buf))

(defn solve [input]
  (let [p1 (->> (string/trimr input) (peg/match parser) columns* compute sum)
        p2 (->> (rtl input) (peg/match parser) first compute sum)]
    [p1 p2]))

(defn main [&] (->> (file/read stdin :all) solve pp))
