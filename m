From: =?UTF-8?Q?Nuno_Gon=C3=A7alves?= <nunojpg@gmail.com>
Subject: Re: [PATCH] 8250_dw: do not int overflow when rate can not be aplied
Date: Thu, 11 Jan 2018 18:28:31 +0100
Message-ID: <CAEXMXLTYFbBraCNHyfc6JpCFwUMVqPeEanCufbKkgW2At7=d0Q@mail.gmail.com>
References: <20180111133832.13125-1-nunojpg@gmail.com> <57ef28bd-41da-73c2-3004-f9b2ecd8b102@sondrel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <57ef28bd-41da-73c2-3004-f9b2ecd8b102@sondrel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ed Blake <ed.blake@sondrel.com>
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

I have to disagree :)

if (rate < i * min_rate) is true to i=3Da, then

(rate >=3D i * min_rate && rate <=3D i * max_rate) will always be false
for any i=3Db, where b>a.

If this condition is true, it means the old condition would be always
false for the remaining of the iteration.

My patch "only" avoids integer overflow and terminates the search as
soon as possible, since no need to search for bigger dividers if the
current one would already mean a rate below min_rate (that it, this is
the closer).

So in fact we also break when the closer divider have been found.

Thanks,
Nuno

On Thu, Jan 11, 2018 at 6:18 PM, Ed Blake <ed.blake@sondrel.com> wrote:
> Hi Nuno,
>
> Thanks for reporting this and the patch.
>
> On 11/01/18 13:38, Nuno Goncalves wrote:
>> When target_rate is big enough and not permitted in hardware,
>> then i is looped to UART_DIV_MAX (0xFFFF), and i * max_rate will overflo=
w
>> (32b signed).
>>
>> A fix is to quit the loop early enough, as soon as rate < i * min_rate a=
s it
>> means the rate is not permitted.
>
> 'rate < i * min_rate' does not mean the rate is not permitted.  clk_round=
_rate() gives the nearest achievable rate to the one requested, which may b=
e lower than i * min_rate.  This is not an error and in this case we want t=
o continue the loop searching for an acceptable rate.
>
>
>>
>> This avoids arbitraty rates to be applied. Still in my hardware the max
>> allowed rate (1500000) is aplied when a higher is requested. This seems =
a
>> artifact of clk_round_rate which is not understood by me and independent=
 of
>> this fix. Might or might not be another bug.
>>
>> Signed-off-by: Nuno Goncalves <nunojpg@gmail.com>
>> ---
>>  drivers/tty/serial/8250/8250_dw.c | 8 +++++++-
>>  1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250=
/8250_dw.c
>> index 5bb0c42c88dd..a27ea916abbf 100644
>> --- a/drivers/tty/serial/8250/8250_dw.c
>> +++ b/drivers/tty/serial/8250/8250_dw.c
>> @@ -267,7 +267,13 @@ static void dw8250_set_termios(struct uart_port *p,=
 struct ktermios *termios,
>>
>>       for (i =3D 1; i <=3D UART_DIV_MAX; i++) {
>>               rate =3D clk_round_rate(d->clk, i * target_rate);
>> -             if (rate >=3D i * min_rate && rate <=3D i * max_rate)
>> +
>> +             if (rate < i * min_rate) {
>> +                     i =3D UART_DIV_MAX + 1;
>> +                     break;
>> +             }
>> +
>> +             if (rate <=3D i * max_rate)
>>                       break;
>>       }
>>       if (i <=3D UART_DIV_MAX) {
>
> --
> Ed
>
