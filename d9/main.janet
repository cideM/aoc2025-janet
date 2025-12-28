(def parser (peg/compile ~(split "\n" (group (split "," (number :d+))))))

(defn walk-perimeter [points]
  (catseq [i :range [0 (length points)]
           :let [[x1 y1] (i points)
                 i2 (mod (inc i) (length points))
                 [x2 y2] (i2 points)]]
    (if (= x1 x2)
      (seq [y :range-to [(min y1 y2) (max y1 y2)]] [x1 y])
      (seq [x :range-to [(min x1 x2) (max x1 x2)]] [x y1]))))

(defn compress-numbers [nums]
  (var counter 0)
  (array/concat
    @[0]
    (seq [i :range [1 (length nums)] :let [prev ((dec i) nums) cur (i nums)]
          :before (do (++ counter) (when (> (- cur prev) 1) (++ counter)))]
      counter)))

(defn to-rect [[x1 y1] [x2 y2]] [[x1 y1] [x2 y1] [x2 y2] [x1 y2]])

(defn points [[[x1 y1] _ [x2 y2] _]]
  (seq [x :range-to [(min x1 x2) (max x1 x2)]
        y :range-to [(min y1 y2) (max y1 y2)]] [x y]))

(defn state [tiles]
  (let [border (->> (walk-perimeter tiles) (map |[$0 true]) from-pairs)
        min-x (dec (min-of (map 0 tiles))) max-x (inc (max-of (map 0 tiles)))
        min-y (dec (min-of (map 1 tiles))) max-y (inc (max-of (map 1 tiles)))]
    (->> (catseq [y :range-to [min-y max-y]]
           (var crossings 0)
           (seq [x :range-to [min-x max-x]
                 :let [prev (get border [(dec x) y])]
                 :before (when (and (not prev) (get border [x y]))
                           (++ crossings))]
             [[x y] (not= 0 (% crossings 2))]))
         from-pairs)))

(defn compress-area [tiles]
  (let [ys (distinct (sorted (map 1 tiles))) ys_ (compress-numbers ys)
        ycomp (zipcoll ys ys_) uny (zipcoll ys_ ys)
        xs (distinct (sorted (map 0 tiles))) xs_ (compress-numbers xs)
        xcomp (zipcoll xs xs_) unx (zipcoll xs_ xs)]
    {:tiles (map (fn [[x y]] [(x xcomp) (y ycomp)]) tiles)
     :un (fn [[[x y] [x2 y2]]] [[(x unx) (y uny)] [(x2 unx) (y2 uny)]])}))

(defn area [[[x1 y1] [x2 y2]]]
  (* (inc (math/abs (- x1 x2)))
     (inc (math/abs (- y1 y2)))))

(defn main [&]
  (let [{:tiles tiles_ :un uncompress} (->> (file/read stdin :all)
                                            string/trimr
                                            (peg/match parser)
                                            compress-area)
        by-area (->> (seq [i :range-to [0 (length tiles_)]
                           j :range-to [(inc i) (dec (length tiles_))]]
                       [(i tiles_) (j tiles_)])
                     (sorted-by (comp area uncompress))
                     reverse)
        p1 (->> (first by-area) uncompress area)
        in? (state tiles_)
        p2 (->> (filter |(all |(get in? $0) (to-rect ;$0)) by-area)
                (find |(all |(get in? $0) (points (to-rect ;$0))))
                uncompress
                area)]
    (pp [p1 p2])))
