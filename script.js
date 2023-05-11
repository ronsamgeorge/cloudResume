// get the count from the api gateway endpoint
const getCount = async () => {
  const response = await fetch(
    "https://j1ys53oi0g.execute-api.ap-southeast-2.amazonaws.com/count"
  );

  const data = await response.json();
  console.log(data);
};

getCount();
