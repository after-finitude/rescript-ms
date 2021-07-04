let sec = 1e3
let min = sec *. 60.0
let hour = min *. 60.0
let day = hour *. 24.0
let week = day *. 7.0
let year = day *. 365.25

let parse = str => {
  let rgx = %re(
    "/^(-?(?:\d+)?\.?\d+) *(milliseconds?|msecs?|ms|seconds?|secs?|s|minutes?|mins?|m|hours?|hrs?|h|days?|d|weeks?|w|years?|yrs?|y)?$/i"
  )

  let match = switch rgx->Js.Re.exec_(str) {
  | Some(v) => v->Js.Re.captures
  | None => []
  }

  let n = switch match[1]->Js.Nullable.toOption {
  | Some(v) =>
    switch v->Belt.Float.fromString {
    | Some(v) => v
    | None => 0.0
    }
  | None => 0.0
  }

  let t = switch match[2]->Js.Nullable.toOption {
  | Some(v) => v->Js.String2.toLowerCase
  | None => "ms"
  }

  switch t {
  | "years" | "year" | "yrs" | "yr" | "y" => n *. year
  | "weeks" | "week" | "w" => n *. week
  | "days" | "day" | "d" => n *. day
  | "hours" | "hour" | "hrs" | "hr" | "h" => n *. hour
  | "minutes" | "minute" | "mins" | "min" | "m" => n *. min
  | "seconds" | "second" | "secs" | "sec" | "s" => n *. sec
  | "milliseconds" | "millisecond" | "msecs" | "msec" | "ms" => n
  | _ => 0.0
  }
}

let format = ms => {
  let msAbs = ms->Js.Math.abs_float

  if msAbs >= day {
    (ms /. day)->Js.Math.round->Belt.Float.toString->Js.String2.concat("d")
  } else if msAbs >= hour {
    (ms /. hour)->Js.Math.round->Belt.Float.toString->Js.String2.concat("h")
  } else if msAbs >= min {
    (ms /. min)->Js.Math.round->Belt.Float.toString->Js.String2.concat("m")
  } else if msAbs >= sec {
    (ms /. sec)->Js.Math.round->Belt.Float.toString->Js.String2.concat("s")
  } else {
    ms->Belt.Float.toString->Js.String2.concat("ms")
  }
}