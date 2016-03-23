From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH/RFC 5/5] serial: sh-sci: Replace SCIx_HAVE_RTSCTS by
 standard UPF_HARD_FLOW
Date: Wed, 23 Mar 2016 21:00:08 +0100
Message-ID: <CAMuHMdVG=-5BG9N3wSK-sn7i7V3fNDxb83N8Q_uHxBe_FSr2zg@mail.gmail.com>
References: <1458222449-12324-1-git-send-email-geert+renesas@glider.be>
	<1458222449-12324-6-git-send-email-geert+renesas@glider.be>
	<56EC520F.5010101@hurleysoftware.com>
	<CAMuHMdWFyLAg-=y=6=CBaOUeS-WV0wFXos=jBo-MJQiGB=vXmA@mail.gmail.com>
	<56F2CE4F.2010104@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <56F2CE4F.2010104@hurleysoftware.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Magnus Damm <magnus.damm@gmail.com>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, linux-renesas-soc@vger.kernel.org, Linux-sh list <linux-sh@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Hi Peter,

On Wed, Mar 23, 2016 at 6:11 PM, Peter Hurley <peter@hurleysoftware.com> wrote:
> On 03/23/2016 02:33 AM, Geert Uytterhoeven wrote:
>> On Fri, Mar 18, 2016 at 8:07 PM, Peter Hurley <peter@hurleysoftware.com> wrote:
>>> On 03/17/2016 06:47 AM, Geert Uytterhoeven wrote:
>>>> Replace the custom SCIx_HAVE_RTSCTS flag in the
>>>> plat_sci_port.capabilities field by the standard UPF_HARD_FLOW flag in
>>>> the uart_port.flags and plat_sci_port.flags fields.
>>>> Remove the now unused plat_sci_port.capabilities field.
>>>> Legacy pllatform data can enable UPF_HARD_FLOW in plat_sci_port.flags.
>>>
>>> UPF_HARD_FLOW is really for indicating the h/w supports automatic
>>> CTS and RTS signalling; ie., RTS is automatically de-asserted when
>>> rx fifo reaches some threshold and CTS will automatically prevent
>>> tx fifo output.
>>>
>>> There is no serial core flag for indicating the h/w supports (or does not)
>>> RTS and/or CTS signalling.
>>
>> Sorry for not being clearer: Renesas SCIF hardware with dedicated RTS/CTS pins
>> does have support for automatic RTS/CTS signalling. The driver has (unused)
>> support for that (cfr. setting the SCFCR_MCE (Modem Control Enable) flag), but
>> it seems to be busted when enabled.
>
> Ok.
>
> So looking at the code, IIUC, SCIF does not provide a way to directly
> control RTS output or read CTS input when RTS/CTS is pinned (ie, not gpio).
> Is that correct?
> How to support autoRTS/autoCTS depends on the answer to this question.

Actually it does have support for controlling RTS output and reading CTS
input, but that is not yet implemented.

Magnus posted a series touching this a while ago ("serial: sh-sci: Hardware
flow control update", http://www.spinics.net/lists/linux-sh/msg38401.html),
which received some comments.

> Is there a datasheet/trm that I can review describing register layout and
> uart behavior?

I found a public one for an older SoC, see pages starting at (physical) page 849
http://documentation.renesas.com/doc/products/mpumcu/doc/superh/r01uh0048ej0200_sh7268.pdf

  - FIFO Control Register, bit MCE for automatic control
  - Serial Port Register for manual control

>>   2. If the user didn't set CRTSCTS, the RTS output pin should be controlled by
>>      the serial core, through .set_mctrl(),
>
> Not quite.
>
> _Regardless of CRTSCTS setting_, the RTS output pin should be controlled
> through .set_mctrl() method. The serial core takes CRTSCTS into account on
> behalf of the driver when necessary.

What does this mean exactly?
AFAIU, there are three states:
  - Force RTS asserted,
  - Force RTS deasserted,
  - Use hardware-controlled automatic RTS,
while .set_mctrl() just provides the boolean TIOCM_RTS flag?

> gpio-based RTS/CTS is mutually exclusive with autoRTS/autoCTS. But I'm not
> seeing any logic in these patches to prevent that.

Sure. Currently nothing sets SCIx_HAVE_RTSCTS, so this can't happen yet.

I went for GPIO-based RTS/CTS first, as we now have a framework for that,
and I can use it as a known-working base.

> autoCTS without a way to read CTS input level means that although transmission
> stops, the driver has no way to update port->hw_stopped so the write buffer
> will keep filling up until it's full @ 4k.

SCIF allows to read CTS input level, regardless of automatic RTS/CTS is
enabled or not.

> autoRTS without a way to override RTS output complicates throttling.

SCIF allows to override RTS output.

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
