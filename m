From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH/RFC 5/5] serial: sh-sci: Replace SCIx_HAVE_RTSCTS by
 standard UPF_HARD_FLOW
Date: Wed, 23 Mar 2016 10:33:50 +0100
Message-ID: <CAMuHMdWFyLAg-=y=6=CBaOUeS-WV0wFXos=jBo-MJQiGB=vXmA@mail.gmail.com>
References: <1458222449-12324-1-git-send-email-geert+renesas@glider.be>
	<1458222449-12324-6-git-send-email-geert+renesas@glider.be>
	<56EC520F.5010101@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <56EC520F.5010101@hurleysoftware.com>
Sender: linux-sh-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Magnus Damm <magnus.damm@gmail.com>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, linux-renesas-soc@vger.kernel.org, Linux-sh list <linux-sh@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Hi Peter,

On Fri, Mar 18, 2016 at 8:07 PM, Peter Hurley <peter@hurleysoftware.com> wrote:
> On 03/17/2016 06:47 AM, Geert Uytterhoeven wrote:
>> Replace the custom SCIx_HAVE_RTSCTS flag in the
>> plat_sci_port.capabilities field by the standard UPF_HARD_FLOW flag in
>> the uart_port.flags and plat_sci_port.flags fields.
>> Remove the now unused plat_sci_port.capabilities field.
>> Legacy pllatform data can enable UPF_HARD_FLOW in plat_sci_port.flags.
>
> UPF_HARD_FLOW is really for indicating the h/w supports automatic
> CTS and RTS signalling; ie., RTS is automatically de-asserted when
> rx fifo reaches some threshold and CTS will automatically prevent
> tx fifo output.
>
> There is no serial core flag for indicating the h/w supports (or does not)
> RTS and/or CTS signalling.

Sorry for not being clearer: Renesas SCIF hardware with dedicated RTS/CTS pins
does have support for automatic RTS/CTS signalling. The driver has (unused)
support for that (cfr. setting the SCFCR_MCE (Modem Control Enable) flag), but
it seems to be busted when enabled.

If I understand it correctly:
  1. Automatic RTS/CTS signalling should be enabled only if the user enabled it
     through termios->c_cflag & CRTSCTS,
  2. If the user didn't set CRTSCTS, the RTS output pin should be controlled by
     the serial core, through .set_mctrl(),
  3. Regardless of the user setting CRTSCTS or not, .get_mctrl() should report
     the current status of the CTS input pin.

Are my assumptions correct?

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
