// const formatAmFM = (hours, minutes, seconds) => {
//   var dd = "AM";
//   let m = parseInt(minutes);
//   let s = parseInt(seconds);
//   let hh = parseInt(hours);
//   console.log(s);

//   var h = hh;
//   if (h >= 12) {
//     h = hh - 12;
//     dd = "PM";
//   }
//   if (h === 0) {
//     h = 12;
//   }
//   m = m < 10 ? "0" + m : m;

//   s = s < 10 ? "0" + s : s;

//   // /* if you want 2 digit hours:
//   h = h < 10 ? "0" + h : h;

//   var pattern = new RegExp("0?" + hh + ":" + m + ":" + s);

//   var replacement = h + ":" + m;
//   /* if you want to add seconds
//   replacement += ":"+s;  */
//   replacement += " " + dd;

//   return replacement;
// };
const formatCompleteDate = (timeString, dateString) => {
  const timeArrayDot = timeString.split(".");
  timeArrayDot[1] && timeArrayDot.pop(); //remove the numbers after seconds
  const timeArrayColon = timeArrayDot.join("").split(":");
  // const dateArray = dateString.split("-");
  // return formatAmFM(timeArrayColon[0], timeArrayColon[1], timeArrayColon[2]);
  const completeDate = dateString + " " + timeArrayColon.join(":");
  return new Date(completeDate).toLocaleString("UTC", {
    year: "numeric",
    month: "2-digit",
    day: "2-digit",
    weekday: "short",
    hour: "numeric",
    minute: "numeric",
    second: "numeric",
    hour12: true
  });
};
// const formatTime = (timeString, dateString = "") => {
//   const timeArrayDot = timeString.split(".");
//   timeArrayDot[1] && timeArrayDot.pop(); //remove the numbers after seconds
//   const timeArrayColon = timeArrayDot.join("").split(":");
//   // const dateArray = dateString.split("-");
//   // return formatAmFM(timeArrayColon[0], timeArrayColon[1], timeArrayColon[2]);
//   return new Date(completeDate);
// };

// export default formatTime;
export { formatCompleteDate };
