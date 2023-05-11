// get the count from the api gateway endpoint
const getCount = async () => {
  const response = await fetch(
    "https://j1ys53oi0g.execute-api.ap-southeast-2.amazonaws.com/count"
  );

  const data = await response.json();
  console.log(data);
  return data;
};

const setVisitorCount = async () => {
  const count = await getCount();

  const countDiv = document.querySelector(".count-value");

  countDiv.innerText = await count;
};

setVisitorCount();
