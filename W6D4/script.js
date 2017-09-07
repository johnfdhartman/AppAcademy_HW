document.addEventListener("DOMContentLoaded", () => {
  // toggling restaurants

  const toggleLi = (e) => {
    const li = e.target;
    if (li.className === "visited") {
      li.className = "";
    } else {
      li.className = "visited";
    }
  };

  document.querySelectorAll("#restaurants li").forEach((li) => {
    li.addEventListener("click", toggleLi);
  });


  const handleSubmit = function(el) {
    el.preventDefault();
    const input = document.querySelector('.favourite-input');
    const li = document.createElement('li');
    li.textContent = input.value;
    const list = document.getElementById('sf-places');
    list.appendChild(li);
  };

  const submitEvent = document.querySelector('.favourite-submit');
  submitEvent.addEventListener("click", handleSubmit);


  // adding SF places as list items

  // --- your code here!



  // adding new photos

  // --- your code here!



});
