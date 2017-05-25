From: Rob Herring <robh@kernel.org>
Subject: Re: [BUG] tty/serial: stty hangs for 30 seconds after interrupted transfer
Date: Thu, 25 May 2017 17:34:14 -0500
Message-ID: <CAL_Jsq+EWfeoZL1T5RjU3WXvBu+nFzHGOULa8TK6rZoHLAX-QA@mail.gmail.com>
References: <c87da751-0692-e381-be16-a2adf0f0104f@inbox.lv>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <c87da751-0692-e381-be16-a2adf0f0104f@inbox.lv>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Artamonow <mad_soft@inbox.lv>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Hurley <peter@hurleysoftware.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, Alan Cox <alan@linux.intel.com>
List-Id: linux-serial@vger.kernel.org

On Thu, May 25, 2017 at 8:22 AM, Dmitry Artamonow <mad_soft@inbox.lv> wrote:
> Hello.
>
> While working on i.MX6-based board I found weird problem with serial ports.
> When I do some write in serial port and then interrupt it prematurely with
> Ctrl-C, following call to stty hangs for 30 seconds. Basic reproducing steps:
>
> 1. cat some_large_text_file.txt > /dev/ttymxc1
> 2. Press Ctrl-C
> 3. stty -F /dev/ttymxc1

I've tried this on an db410c and can't reproduce. Different serial
driver though. I do get a few second delay after ctrl-C. Do you get a
delay there?

I couldn't repo with 8250 either, but that was on qemu which is
doesn't have realistic timing.

> If I send some more data over the port afterwards and don't interrupt it,
> following call to stty doesn't hang.

[...]

> I located the place of the hang inside the tty_wait_until_sent() function.
> Looks like it waits for UART to finish sending, but as the UART doesn't
> actually send anything, it exits only after 30 second timeout.

So the only way to get a 30 sec timeout is if tty_chars_in_buffer()
returns that the circular buffer contains some characters.

> After some digging I found that the problem seems to be caused by
> commit 761ed4a94582 ("tty: serial_core: convert uart_close to use
> tty_port_close"). Reverting this and related commits (a5a2b13074fd,
> be2c92b8f164, 4dda864d7307) makes the problem go away.
>
> Also note that statistics seems to be broken in the log above. After
> running "sendandkill" it says that 0 bytes were sent while actually
> about 970 bytes were transferred. And after sending one more character with
> echo, it actually sends 2400+1 characters, i.e. resends the whole previously
> interrupted buffer before sending 'X'. Reverts above fix this only partially.
> UART doesn't resend previous characters anymore, but still statistics is
> wrong about first interrupted transfer. But I suspect this could be a separate
> problem in imx driver.
>
> Any ideas how to fix this hang? I tried to put uart_flush_buffer() into
> uart_close() before call to tty_port_close() and it kind of works, but
> I'm not really sure whether it's a proper fix. Given my lack of experience
> with TTY subsystem and level of its complexity I suspect that I can
> easily miss something.

Kind of works? Is there still some problem beyond the statistics?
uart_flush_buffer would ensure the circular buffer is empty. It seems
like that is getting corrupted.

Can you add some debug prints in open, close and the tx isr with the
circular buffer head and tail values?

Rob
