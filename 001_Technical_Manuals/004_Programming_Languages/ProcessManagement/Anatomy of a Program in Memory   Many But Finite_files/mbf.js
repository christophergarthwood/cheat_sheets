'use strict';

const signupUrl =
    'https://nbclabinb5.execute-api.us-east-1.amazonaws.com/dev/signup';

function clearFeedback(form)
{
    const feedback = form.querySelectorAll('p');
    for (let el of feedback)
        el.style.display = 'none';
    form.classList.remove('has-error');
}

$(function(){
    $('input.email').on('input', function (event) {
        var form = this.closest('form');
        clearFeedback(form);
    });

    $('form.subscribe').on('submit', function (event) {
        event.preventDefault();

        const form = this;
        clearFeedback(form);
        const input = this.querySelector('input');
        const inputText = input.value.trim();

        if (!/\S+@\S+\.\S+/.test(inputText)) {
            form.querySelector('p.bg-warning').style.display = 'block';
            form.classList.add('has-error');
            return;
        }

        const data = JSON.stringify({
            email: inputText,
            url: document.location.href,
            referrer: document.referrer
        });

        $.ajax(signupUrl, {
            data: data,
            contentType: 'text/plain',
            type: 'POST',
            success: function() {
                form.querySelector('p.bg-primary').style.display = 'block';
            },

            error: function() {
                form.querySelector('p.bg-danger').style.display = 'block';
            }
        });
    });
});
