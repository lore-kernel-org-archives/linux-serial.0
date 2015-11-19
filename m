From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 09/25] serial: sh-sci: Avoid overflow in sci_baud_calc_hscif()
Date: Thu, 19 Nov 2015 21:50:10 +0100
Message-ID: <CAMuHMdX5d4NinK7sK7bFtKFOj_JEp8NCnd-60dJ=UE+Sny77Pg@mail.gmail.com>
References: <1447958344-836-1-git-send-email-geert+renesas@glider.be>
	<1447958344-836-10-git-send-email-geert+renesas@glider.be>
	<4295635.bqyeD1RN5z@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <4295635.bqyeD1RN5z@avalon>
Sender: linux-sh-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Thu, Nov 19, 2015 at 9:37 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>> --- a/drivers/tty/serial/sh-sci.c
>> +++ b/drivers/tty/serial/sh-sci.c
>> @@ -1870,7 +1870,7 @@ static unsigned int sci_scbrr_calc(struct sci_port *s,
>> unsigned int bps, static void sci_baud_calc_hscif(unsigned int bps,
>> unsigned long freq, int *brr, unsigned int *srr, unsigned int *cks)
>>  {
>> -     unsigned int sr, br, c;
>> +     unsigned int sr, br, a, b, c;
>>       int err, recv_margin;
>>       int min_err = 1000; /* 100% */
>>       int recv_max_margin = 0;
>> @@ -1880,12 +1880,14 @@ static void sci_baud_calc_hscif(unsigned int bps,
>> unsigned long freq, int *brr, for (sr = 8; sr <= 32; sr++) {
>>               for (c = 0; c <= 3; c++) {
>>                       /* integerized formulas from HSCIF documentation */
>> -                     br = DIV_ROUND_CLOSEST(freq, (sr *
>> -                                           (1 << (2 * c + 1)) * bps));
>> +                     a = sr * (1 << (2 * c + 1));
>> +                     if (bps > UINT_MAX / a)
>> +                             break;
>> +
>> +                     b = a * bps;
>
> This is becoming unreadable. Could you please use proper variable names ? A

Sometimes it's different to find good variable names ("t1" and "t2"?).

> comment that explains the calculation would also be useful.

Thanks, that would indeed help.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
