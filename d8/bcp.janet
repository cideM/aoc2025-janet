(def parser (peg/compile ~(split :s (group (split "," (number :d+))))))

(defn dist [[x y z] [x2 y2 z2]]
  (math/sqrt (+ (math/pow (- x2 x) 2)
                (math/pow (- y2 y) 2)
                (math/pow (- z2 z) 2))))

(defn main [&]
  (var t @{}) # point -> circuit ID
  (var id 0)
  (let [points (->> (file/read stdin :all) string/trimr (peg/match parser))
        dists (sorted-by 1 (seq [i :range [0 (length points)]
                                 j :range [(inc i) (length points)]
                                 :let [p1 (i points) p2 (j points)]]
                             [[p1 p2] (dist p1 p2)]))
        [[x _ _] [x2 _ _]]
        (last (seq [i :range [0 (length dists)]
                    :let [[[p1 p2]] (i dists) c1 (get t p1) c2 (get t p2)]
                    :after (when (= i 999)
                             (pp (as-> (frequencies t) _ (values _) (sorted _ >)
                                       (take 3 _) (* ;_))))
                    :until (and (= 1 (length (distinct (values t))))
                                (= (length points) (length (keys t))))]
                (do (cond
                      (and c1 c2 (not= c1 c2)) # different circuits
                      (loop [[p circ] :in (pairs t) :when (= circ c2)] (put t p c1))
                      (and (= c1 nil) (= c2 nil)) # both not in a circuit
                      (do (+= id 1) (put t p1 id) (put t p2 id))
                      (do (put t p1 (or c1 c2)) (put t p2 (or c1 c2))))
                  [p1 p2])))]
    (print (* x x2))))
