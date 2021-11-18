like_contribution = (id,token) =>{
        var origin = window.location.origin;
        var arrow = document.getElementById(id);
        arrow.style.visibility = "hidden";
        fetch(`${origin}/contributions/${id}/like`,{
        method: 'PUT',
        headers:{
            'Content-Type':'application/json',
            'Authorization': token
        }
        }).then(response =>{
        if(response.statusText === "Unprocessable Entity"){
            var url = `${origin}/users/sign_in`
            location.replace(url);
        }else{
            var unvote = document.getElementById(`${id}_unvote`);
            unvote.style.display = "block";
            location.reload();
        }
        
        })

    }

    dislike_contribution = (id,token) =>{
        var origin = window.location.origin;
        var arrow = document.getElementById(id);
        arrow.style.visibility = "visible";
        fetch(`${origin}/contributions/${id}/dislike`,{
        method: 'PUT',
        headers:{
            'Content-Type':'application/json',
            'Authorization': token
        }
        }).then(response =>{

        if(response.statusText === "Unprocessable Entity"){
            var url = `${origin}/users/sign_in`;
            location.replace(url);
        }else{
            var unvote = document.getElementById(`${id}_unvote`);
            unvote.style.display = "none";
            location.reload();
        }
        })
    }