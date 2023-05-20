// get the count from the backend API
const getCount = async () => {
  const response = await fetch(
    "https://j1ys53oi0g.execute-api.ap-southeast-2.amazonaws.com/count"
  );

  const data = await response.json();
  console.log(data);
  return data;
};

// set the visitor count
const setVisitorCount = async () => {
  const count = await getCount();
  const countDiv = document.querySelector(".count-value");
  countDiv.innerText = await count;
};

setVisitorCount();
