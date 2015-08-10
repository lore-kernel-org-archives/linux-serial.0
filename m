From: =?UTF-8?Q?Janusz_U=c5=bcycki?= <j.uzycki@elpromaelectronics.com>
Subject: Re: [PATCH RFC] serial: mxs-auart: fix baud rate range
Date: Mon, 10 Aug 2015 19:01:27 +0200
Message-ID: <55C8D8E7.9090103@elpromaelectronics.com>
References: <1439208767-29152-1-git-send-email-stefan.wahren@i2se.com>
 <CAOMZO5CscLv+v=8QA-zchR3EeNogpwGRRARJo8qPROLwcBXTUg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAOMZO5CscLv+v=8QA-zchR3EeNogpwGRRARJo8qPROLwcBXTUg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>, Stefan Wahren <stefan.wahren@i2se.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Janusz Uzycki <j.uzycki@elproma.com.pl>, Fabio Estevam <fabio.estevam@freescale.com>, Juergen Beisert <jbe@pengutronix.de>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org



W dniu 2015-08-10 o 14:22, Fabio Estevam pisze:
> On Mon, Aug 10, 2015 at 9:12 AM, Stefan Wahren <stefan.wahren@i2se.com> wrote:
>
>>          /* set baud rate */
>> -       baud = uart_get_baud_rate(u, termios, old, 0, u->uartclk);
>> +       baud_min = u->uartclk * 32 / 0x3fffc0;
>> +       baud_max = u->uartclk * 32 / 0xec;
>> +       baud = uart_get_baud_rate(u, termios, old, baud_min, baud_max);
> Looks good. It would be nice to replace 0x3fffc0 and 0xec with defines though.

I agree with Fabio.

In addition let's look at the example for uartclk = 24MHz:
baud_max = 3,254,237.29 => will be rounded down to 3,254,237bauds and it 
is OK
baud_min = 183.1 => will be rounded to 183 bauds. To avoid div=0x400971 
it should be 184
so DIV_ROUND_UP() macro could be used.

best regards
Janusz

>
> Regards,
>
> Fabio Estevam
