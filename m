From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 2/2] serial: sh-sci: Fix hang in sci_reset()
Date: Wed, 11 Jan 2017 10:04:27 +0100
Message-ID: <CAMuHMdWXjz69eRmT-RrvAhK_Xjnxz_FAy0WC9hw4=U0MOhJgUA@mail.gmail.com>
References: <1480682111-9299-1-git-send-email-geert+renesas@glider.be>
 <1480682111-9299-3-git-send-email-geert+renesas@glider.be> <52992122.70bgT4fDeQ@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <52992122.70bgT4fDeQ@avalon>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Christoph Baumann <cbaumann@visteon.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Hi Laurent,

On Fri, Jan 6, 2017 at 1:31 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Friday 02 Dec 2016 13:35:11 Geert Uytterhoeven wrote:
>> When the .set_termios() callback resets the UART, it first waits until
>> all characters in the transmit FIFO have been transmitted, to prevent a
>> port configuration change from impacting these characters.
>>
>> However, if the previous user of the UART had dedicated RTS/CTS hardware
>> flow control enabled, these characters may have been stuck in the FIFO
>> due to CTS not being asserted. When the new user opens the port,
>> .set_termios() is called while transmission is still disabled, leading
>> to an infinite loop:
>>
>>     NMI watchdog: BUG: soft lockup - CPU#0 stuck for 22s!
>>
>> This has been observed with SCIFA (on r8a7740/armadillo) and SCIFB (on
>> r8a7791/koelsch).
>>
>> The issue does not seem to happen when using:
>>   - GPIO RTS/CTS hardware flow control,
>>   - No hardware flow control,
>>   - HSCIF (on r8a7791/koelsch).
>>
>> To fix this, wait for the draining of the transmit FIFO only if
>> transmission is already enabled.
>>
>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> ---
>> To reproduce:
>>
>>     stty -echo < /dev/scifb0
>>     stty crtscts < /dev/scifb0
>>     echo hello > /dev/scifb0  # returns early (wrote to FIFO)
>>     echo hello > /dev/scifb0  # hangs
>>
>>  drivers/tty/serial/sh-sci.c | 8 +++++---
>>  1 file changed, 5 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
>> index c503db1900f003ed..db5de80c5399a7bd 100644
>> --- a/drivers/tty/serial/sh-sci.c
>> +++ b/drivers/tty/serial/sh-sci.c
>> @@ -2137,9 +2137,11 @@ static void sci_reset(struct uart_port *port)
>>       const struct plat_sci_reg *reg;
>>       unsigned int status;
>>
>> -     do {
>> -             status = serial_port_in(port, SCxSR);
>> -     } while (!(status & SCxSR_TEND(port)));
>> +     if (serial_port_in(port, SCSCR) & SCSCR_TE) {
>> +             do {
>> +                     status = serial_port_in(port, SCxSR);
>> +             } while (!(status & SCxSR_TEND(port)));
>
> Won't we still loop forever if the remote side never asserts CTS ?

Thanks, you're right.

While my patch fixes the issue for a new user opening the port, I managed
to trigger the issue when changing the UART speed after writing some data
to an otherwise disconnected SCIFB0.

Now, how do other drivers handle this (if they handle it at all)?
As CTS is under control of the remote side, set_termios() may be blocked
for an arbitrary period of time. set_termios() also returns void, so it
cannot return e.g. -ERESTARTSYS from wait_event_interruptible().

Or is it considered a bug for userspace to change the terminal settings
without flushing the output buffer? In that case, we can just drop the
loop, and zap the FIFO regardless.

Thanks for your comments!

>
>> +     }
>>
>>       serial_port_out(port, SCSCR, 0x00);     /* TE=0, RE=0, CKE1=0 */

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
