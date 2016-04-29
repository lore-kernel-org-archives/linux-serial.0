From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2 08/11] serial: sh-sci: Correct pin initialization on (H)SCIF
Date: Fri, 29 Apr 2016 22:00:04 +0200
Message-ID: <CAMuHMdWdWfGOa5iK7pFLuQUv14Yp6Oi8jhsHoSfrLDARfwCfQA@mail.gmail.com>
References: <1461934714-18681-1-git-send-email-geert+renesas@glider.be>
	<1461934714-18681-9-git-send-email-geert+renesas@glider.be>
	<572384E9.9060707@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <572384E9.9060707@hurleysoftware.com>
Sender: linux-sh-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Magnus Damm <magnus.damm@gmail.com>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, linux-renesas-soc@vger.kernel.org, Linux-sh list <linux-sh@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Hi Peter,

On Fri, Apr 29, 2016 at 5:59 PM, Peter Hurley <peter@hurleysoftware.com> wrote:
> On 04/29/2016 05:58 AM, Geert Uytterhoeven wrote:
>> Correct pin initialization on (H)SCIF:
>>   - RTS must be deasserted (it's active low),
>>   - SCK must be an input, as it may be used as the optional external
>>     clock input.
>>
>> Initial pin configuration must always be done:
>>   - Regardless of the presence of dedicated RTS and CTS pins: if the
>>     register exists, the RTS/CTS bits exist, too,
>>   - Regardless of hardware flow control being enabled or not: RTS must
>>     be deasserted.
>
> This is always setting RTS active; why?

No, it deasserts RTS. RTS is active-low, so setting the pin state to 1/high
(setting the SCSPTR_RTSDT bit), makes RTS inactive.

Before, the code didn't set the SCSPTR_RTSDT bit, so the pin might have
been low, i.e. RTS may have been active.

> Normally you want to program RTS only in response to ->set_mctrl()
> from serial core.  For example, this will set RTS active even though
> baud might be set to B0.

Yes, that's also my understanding.

>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> ---
>> v2:
>>   - New.
>> ---
>>  drivers/tty/serial/sh-sci.c | 23 ++++++++---------------
>>  1 file changed, 8 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
>> index ce7bd165929ea078..c46999f20917964e 100644
>> --- a/drivers/tty/serial/sh-sci.c
>> +++ b/drivers/tty/serial/sh-sci.c
>> @@ -712,21 +712,14 @@ static void sci_init_pins(struct uart_port *port, unsigned int cflag)
>>               return;
>>       }
>>
>> -     /*
>> -      * For the generic path SCSPTR is necessary. Bail out if that's
>> -      * unavailable, too.
>> -      */
>> -     if (!sci_getreg(port, SCSPTR)->size)
>> -             return;
>> -
>> -     if ((s->cfg->capabilities & SCIx_HAVE_RTSCTS) &&
>> -         ((!(cflag & CRTSCTS)))) {
>> -             unsigned short status;
>> -
>> -             status = serial_port_in(port, SCSPTR);
>> -             status &= ~SCSPTR_CTSIO;
>> -             status |= SCSPTR_RTSIO;
>> -             serial_port_out(port, SCSPTR, status); /* Set RTS = 1 */
>> +     if (sci_getreg(port, SCSPTR)->size) {
>> +             u16 status = serial_port_in(port, SCSPTR);
>> +
>> +             /* RTS# is output, driven 1 */
>> +             status |= SCSPTR_RTSIO | SCSPTR_RTSDT;
>> +             /* CTS# and SCK are inputs */
>> +             status &= ~(SCSPTR_CTSIO | SCSPTR_SCKIO);
>> +             serial_port_out(port, SCSPTR, status);
>>       }
>>  }

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
