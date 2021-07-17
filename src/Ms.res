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
  | Some(v) => v->Js.Re.captures->Belt.List.fromArray
  | None => list{}
  }

  let n = switch match->Belt.List.get(1) {
  | Some(v) =>
    switch v->Js.Nullable.toOption {
    | Some(v) =>
      switch v->Belt.Float.fromString {
      | Some(v) => v
      | None => 0.0
      }
    | None => 0.0
    }
  | None => 0.0
  }

  let t = switch match->Belt.List.get(2) {
  | Some(v) =>
    switch v->Js.Nullable.toOption {
    | Some(v) => v->Js.String2.toLowerCase
    | None => "ms"
    }
  | None => ""
  }

  let result = switch t {
  | "years" | "year" | "yrs" | "yr" | "y" => n *. year
  | "weeks" | "week" | "w" => n *. week
  | "days" | "day" | "d" => n *. day
  | "hours" | "hour" | "hrs" | "hr" | "h" => n *. hour
  | "minutes" | "minute" | "mins" | "min" | "m" => n *. min
  | "seconds" | "second" | "secs" | "sec" | "s" => n *. sec
  | "milliseconds" | "millisecond" | "msecs" | "msec" | "ms" => n
  | _ => 0.0
  }

  if result === 0.0 {
    Js.Exn.raiseError("Invalid value")
  }

  result
}

let format = ms => {
  let msAbs = ms->Js.Math.abs_float

  let calculate = (timeUnit, prefix) =>
    (ms /. timeUnit)->Js.Math.round->Belt.Float.toString->Js.String2.concat(prefix)

  if msAbs >= day {
    calculate(day, "d")
  } else if msAbs >= hour {
    calculate(hour, "h")
  } else if msAbs >= min {
    calculate(min, "m")
  } else if msAbs >= sec {
    calculate(sec, "s")
  } else {
    calculate(1.0, "ms")
  }
}
