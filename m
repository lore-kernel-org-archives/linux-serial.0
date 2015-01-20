From: Yoshihiro Kaneko <ykaneko0929@gmail.com>
Subject: Re: [PATCH/RFC] serial: sh-sci: Remove overrun message
Date: Tue, 20 Jan 2015 22:56:00 +0900
Message-ID: <CAH1o70+yLWodK1WbuKdyMMtP-6gLR6cTaEn8Xx=7CqqWs=6OSw@mail.gmail.com>
References: <1418652793-6770-1-git-send-email-ykaneko0929@gmail.com>
	<CAMuHMdW6uLoVhyHahWnJrqOe31gfQU9jMipKP7Yrm-o=m=6D=Q@mail.gmail.com>
	<20150120063516.GB22980@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20150120063516.GB22980@verge.net.au>
Sender: linux-sh-owner@vger.kernel.org
To: Simon Horman <horms@verge.net.au>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Magnus Damm <magnus.damm@gmail.com>, Linux-sh list <linux-sh@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

2015-01-20 15:35 GMT+09:00 Simon Horman <horms@verge.net.au>:
> On Tue, Jan 13, 2015 at 08:57:48AM +0100, Geert Uytterhoeven wrote:
>> On Mon, Dec 15, 2014 at 3:13 PM, Yoshihiro Kaneko <ykaneko0929@gmail.com> wrote:
>> > From: Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>
>> >
>> > Since the driver cannot return from overrun error if characters
>> > are output during overrun process, the error message of overrun
>> > is removed.
>> >
>> > Signed-off-by: Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>
>> > Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
>> > ---
>> >
>> > This patch is based on the tty-next branch of Greg Kroah-Hartman's tty
>> > tree.
>> >
>> >  drivers/tty/serial/sh-sci.c | 1 -
>> >  1 file changed, 1 deletion(-)
>> >
>> > diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
>> > index fccebbd..fe2bb08 100644
>> > --- a/drivers/tty/serial/sh-sci.c
>> > +++ b/drivers/tty/serial/sh-sci.c
>> > @@ -858,7 +858,6 @@ static int sci_handle_fifo_overrun(struct uart_port *port)
>> >                 tty_insert_flip_char(tport, 0, TTY_OVERRUN);
>> >                 tty_flip_buffer_push(tport);
>> >
>> > -               dev_notice(port->dev, "overrun error\n");
>> >                 copied++;
>> >         }
>>
>> What about replacing it by a call to dev_dbg() instead?
>> That way it won't be printed during normal use, but depending on the
>> system's setting it can still be logged in syslog.
>>
>> Or do you think it's sufficient to have it in the statistics only?
>
> I like the dev_dbg() idea.
>
> Kaneko-san, could you see about respinning this patch accordingly?

Sure, will do!

Thanks,
Kaneko
