From: =?UTF-8?Q?Nuno_Gon=C3=A7alves?= <nunojpg@gmail.com>
Subject: Re: [PATCH] 8250_dw: do not int overflow when rate can not be aplied
Date: Thu, 11 Jan 2018 18:55:06 +0100
Message-ID: <CAEXMXLRV27_GqbiRfGzc+pWLuytw3CesVuN6WdVAUhWvA6zkUQ@mail.gmail.com>
References: <20180111133832.13125-1-nunojpg@gmail.com> <57ef28bd-41da-73c2-3004-f9b2ecd8b102@sondrel.com>
 <CAEXMXLTYFbBraCNHyfc6JpCFwUMVqPeEanCufbKkgW2At7=d0Q@mail.gmail.com> <60dd87e2-ea07-5da3-f426-f39ef3c1addf@sondrel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <60dd87e2-ea07-5da3-f426-f39ef3c1addf@sondrel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ed Blake <ed.blake@sondrel.com>
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

So, for me clk_round_rate() always returns 24000000, and only the loop
variable i changes, so the search is monotonic, from the highest baud
to the lowest (increasing divider).

I am using a Allwiner H2+, with the serial port configuration from
sunxi-h3-h5.dtsi.

Are you sure that clk_round_rate can return differet values? Is that
because some boards might have several clock options beside the
adjustable divider?

I really need to understand what is the problem, to be able to suggest
a solution to the integer overflow that is being allowed to happen.

Thanks,
Nuno



On Thu, Jan 11, 2018 at 6:48 PM, Ed Blake <ed.blake@sondrel.com> wrote:
> On 11/01/18 17:28, Nuno Gon=C3=A7alves wrote:
>> I have to disagree :)
>>
>> if (rate < i * min_rate) is true to i=3Da, then
>>
>> (rate >=3D i * min_rate && rate <=3D i * max_rate) will always be false
>> for any i=3Db, where b>a.
>
> No, because 'rate' is assigned from clk_round_rate() each iteration.
>
> The idea of this code is to iterate through integer multiples of baud *
> 16 until you find an achievable rate that is within the +/- 1.6% range.
> Until then, the rate returned from clk_round_rate() could be lower than
> i * min_rate or higher than i * max_rate, in which case you keep going.
>
>> If this condition is true, it means the old condition would be always
>> false for the remaining of the iteration.
>>
>> My patch "only" avoids integer overflow and terminates the search as
>> soon as possible, since no need to search for bigger dividers if the
>> current one would already mean a rate below min_rate (that it, this is
>> the closer).
>
> It terminates the search as soon as the rate returned from
> clk_round_rate() is lower than i * min_rate, which is too soon.
>
>> So in fact we also break when the closer divider have been found.
>>
>> Thanks,
>> Nuno
>>
>> On Thu, Jan 11, 2018 at 6:18 PM, Ed Blake <ed.blake@sondrel.com> wrote:
>>> Hi Nuno,
>>>
>>> Thanks for reporting this and the patch.
>>>
>>> On 11/01/18 13:38, Nuno Goncalves wrote:
>>>> When target_rate is big enough and not permitted in hardware,
>>>> then i is looped to UART_DIV_MAX (0xFFFF), and i * max_rate will overf=
low
>>>> (32b signed).
>>>>
>>>> A fix is to quit the loop early enough, as soon as rate < i * min_rate=
 as it
>>>> means the rate is not permitted.
>>> 'rate < i * min_rate' does not mean the rate is not permitted.  clk_rou=
nd_rate() gives the nearest achievable rate to the one requested, which may=
 be lower than i * min_rate.  This is not an error and in this case we want=
 to continue the loop searching for an acceptable rate.
>>>
>>>
>>>> This avoids arbitraty rates to be applied. Still in my hardware the ma=
x
>>>> allowed rate (1500000) is aplied when a higher is requested. This seem=
s a
>>>> artifact of clk_round_rate which is not understood by me and independe=
nt of
>>>> this fix. Might or might not be another bug.
>>>>
>>>> Signed-off-by: Nuno Goncalves <nunojpg@gmail.com>
>>>> ---
>>>>  drivers/tty/serial/8250/8250_dw.c | 8 +++++++-
>>>>  1 file changed, 7 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/82=
50/8250_dw.c
>>>> index 5bb0c42c88dd..a27ea916abbf 100644
>>>> --- a/drivers/tty/serial/8250/8250_dw.c
>>>> +++ b/drivers/tty/serial/8250/8250_dw.c
>>>> @@ -267,7 +267,13 @@ static void dw8250_set_termios(struct uart_port *=
p, struct ktermios *termios,
>>>>
>>>>       for (i =3D 1; i <=3D UART_DIV_MAX; i++) {
>>>>               rate =3D clk_round_rate(d->clk, i * target_rate);
>>>> -             if (rate >=3D i * min_rate && rate <=3D i * max_rate)
>>>> +
>>>> +             if (rate < i * min_rate) {
>>>> +                     i =3D UART_DIV_MAX + 1;
>>>> +                     break;
>>>> +             }
>>>> +
>>>> +             if (rate <=3D i * max_rate)
>>>>                       break;
>>>>       }
>>>>       if (i <=3D UART_DIV_MAX) {
>>> --
>>> Ed
>>>
>
> --
> Ed
>
