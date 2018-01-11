From: Ed Blake <ed.blake@sondrel.com>
Subject: Re: [PATCH] 8250_dw: do not int overflow when rate can not be aplied
Date: Thu, 11 Jan 2018 17:48:47 +0000
Message-ID: <60dd87e2-ea07-5da3-f426-f39ef3c1addf@sondrel.com>
References: <20180111133832.13125-1-nunojpg@gmail.com>
 <57ef28bd-41da-73c2-3004-f9b2ecd8b102@sondrel.com>
 <CAEXMXLTYFbBraCNHyfc6JpCFwUMVqPeEanCufbKkgW2At7=d0Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAEXMXLTYFbBraCNHyfc6JpCFwUMVqPeEanCufbKkgW2At7=d0Q@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Nuno_Gon=c3=a7alves?= <nunojpg@gmail.com>
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 11/01/18 17:28, Nuno Gonçalves wrote:
> I have to disagree :)
>
> if (rate < i * min_rate) is true to i=a, then
>
> (rate >= i * min_rate && rate <= i * max_rate) will always be false
> for any i=b, where b>a.

No, because 'rate' is assigned from clk_round_rate() each iteration.

The idea of this code is to iterate through integer multiples of baud *
16 until you find an achievable rate that is within the +/- 1.6% range. 
Until then, the rate returned from clk_round_rate() could be lower than
i * min_rate or higher than i * max_rate, in which case you keep going.

> If this condition is true, it means the old condition would be always
> false for the remaining of the iteration.
>
> My patch "only" avoids integer overflow and terminates the search as
> soon as possible, since no need to search for bigger dividers if the
> current one would already mean a rate below min_rate (that it, this is
> the closer).

It terminates the search as soon as the rate returned from
clk_round_rate() is lower than i * min_rate, which is too soon.

> So in fact we also break when the closer divider have been found.
>
> Thanks,
> Nuno
>
> On Thu, Jan 11, 2018 at 6:18 PM, Ed Blake <ed.blake@sondrel.com> wrote:
>> Hi Nuno,
>>
>> Thanks for reporting this and the patch.
>>
>> On 11/01/18 13:38, Nuno Goncalves wrote:
>>> When target_rate is big enough and not permitted in hardware,
>>> then i is looped to UART_DIV_MAX (0xFFFF), and i * max_rate will overflow
>>> (32b signed).
>>>
>>> A fix is to quit the loop early enough, as soon as rate < i * min_rate as it
>>> means the rate is not permitted.
>> 'rate < i * min_rate' does not mean the rate is not permitted.  clk_round_rate() gives the nearest achievable rate to the one requested, which may be lower than i * min_rate.  This is not an error and in this case we want to continue the loop searching for an acceptable rate.
>>
>>
>>> This avoids arbitraty rates to be applied. Still in my hardware the max
>>> allowed rate (1500000) is aplied when a higher is requested. This seems a
>>> artifact of clk_round_rate which is not understood by me and independent of
>>> this fix. Might or might not be another bug.
>>>
>>> Signed-off-by: Nuno Goncalves <nunojpg@gmail.com>
>>> ---
>>>  drivers/tty/serial/8250/8250_dw.c | 8 +++++++-
>>>  1 file changed, 7 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
>>> index 5bb0c42c88dd..a27ea916abbf 100644
>>> --- a/drivers/tty/serial/8250/8250_dw.c
>>> +++ b/drivers/tty/serial/8250/8250_dw.c
>>> @@ -267,7 +267,13 @@ static void dw8250_set_termios(struct uart_port *p, struct ktermios *termios,
>>>
>>>       for (i = 1; i <= UART_DIV_MAX; i++) {
>>>               rate = clk_round_rate(d->clk, i * target_rate);
>>> -             if (rate >= i * min_rate && rate <= i * max_rate)
>>> +
>>> +             if (rate < i * min_rate) {
>>> +                     i = UART_DIV_MAX + 1;
>>> +                     break;
>>> +             }
>>> +
>>> +             if (rate <= i * max_rate)
>>>                       break;
>>>       }
>>>       if (i <= UART_DIV_MAX) {
>> --
>> Ed
>>

-- 
Ed
