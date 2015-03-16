From: Yoshihiro Kaneko <ykaneko0929@gmail.com>
Subject: Re: [PATCH/RFC] serial: sh-sci: Update calculation of timeout for DMA
Date: Mon, 16 Mar 2015 22:58:26 +0900
Message-ID: <CAH1o70Ku+8W04oNyBABLSF5qMO2KPyn4VEWdC2OH61XHmD=-qA@mail.gmail.com>
References: <1426429742-3041-1-git-send-email-ykaneko0929@gmail.com>
	<5505A5B2.2020600@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <5505A5B2.2020600@cogentembedded.com>
Sender: linux-sh-owner@vger.kernel.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Linux-sh list <linux-sh@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Hello,

2015-03-16 0:30 GMT+09:00 Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>:
> On 3/15/2015 5:29 PM, Yoshihiro Kaneko wrote:
>
>> From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
>
>
>> The current calculation method in the case of 9600bps, rounding error
>> occurs
>> has become setting that occur timeout faster than the required time. When
>> we
>> use 9600bps, 32byte buffer, 10 bit (CS8) and 100 HZ, it becomes 3 jiffies
>> (30msec). In fact it is necessary 33msec. This updates to the calculation
>> that are not actually less than the value set by the rounding error.
>> Also, this is nothing will be calculated value when there is no load. If
>> there
>> are a lot of case load, overrun error will occur immediately.
>> This is by the buffer size to be calculated twice the DMA buffer, and add
>> the
>> change of setting a sufficient time-out value.
>
>
>> Signedroff-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
>> Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
>> ---
>
>
>> This patch is based on the tty-next branch of Greg Kroah-Hartman's tty
>> tree.
>
>
>>   drivers/tty/serial/sh-sci.c | 38 ++++++++++++++++++++++++++++++--------
>>   1 file changed, 30 insertions(+), 8 deletions(-)
>
>
>> diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
>> index 5b50c79..891116c 100644
>> --- a/drivers/tty/serial/sh-sci.c
>> +++ b/drivers/tty/serial/sh-sci.c
>> @@ -1967,18 +1967,40 @@ static void sci_set_termios(struct uart_port
>> *port, struct ktermios *termios,
>
> [...]
>>
>>         if (s->chan_rx) {
>> -               s->rx_timeout = (port->timeout - HZ / 50) * s->buf_len_rx
>> * 3 /
>> -                       port->fifosize / 2;
>> +               unsigned int bits;
>> +
>> +               /* byte size and parity */
>> +               switch (termios->c_cflag & CSIZE) {
>> +                       case CS5:
>
>
>    *case* should at the same indentation level as *switch*. I guess you
> haven't run the patch thru scripts/checkpatch.pl?

Sorry, I forgot to run the script.

Thanks,
Kaneko

>
>> +                               bits = 7;
>> +                               break;
>> +                       case CS6:
>> +                               bits = 8;
>> +                               break;
>> +                       case CS7:
>> +                               bits = 9;
>> +                               break;
>> +                       default:
>> +                               bits = 10;
>> +                               break;
>> +               }
>
> [...]
>
> WBR, Sergei
>
