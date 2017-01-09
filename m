From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 1/2] serial: sh-sci: Fix early deassertion of dedicated RTS
Date: Mon, 09 Jan 2017 13:57:40 +0200
Message-ID: <164893846.trXPIhPmcX@avalon>
References: <1480682111-9299-1-git-send-email-geert+renesas@glider.be> <8834208.BLCpAM3tlx@avalon> <CAMuHMdXfmjqQV6ms-Q21WaQUbEeKNyt5DZ89nV8rifWf-7Ypfg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdXfmjqQV6ms-Q21WaQUbEeKNyt5DZ89nV8rifWf-7Ypfg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Christoph Baumann <cbaumann@visteon.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Hi Geert,

On Monday 09 Jan 2017 10:53:55 Geert Uytterhoeven wrote:
> On Fri, Jan 6, 2017 at 1:30 PM, Laurent Pinchart wrote:
> > On Friday 02 Dec 2016 13:35:10 Geert Uytterhoeven wrote:
> >> If a UART has dedicated RTS/CTS pins, there are some issues:
> >> 1. When changing hardware control flow, the new AUTORTS state is not
> >>    immediately reflected in the hardware, but only when RTS is raised.
> >>    However, the serial core doesn't call .set_mctrl() after
> >>    .set_termios(), hence AUTORTS may only become effective when the port
> >>    is closed, and reopened later.
> >>    Note that this problem does not happen when manually using stty to
> >>    change CRTSCTS, as AUTORTS will work fine on next open.
> >> 
> >> 2. When hardware control flow is disabled (or AUTORTS is not yet
> >>    effective), changing any serial port configuration deasserts RTS, as
> >>    .set_termios() calls sci_init_pins().
> > 
> > Isn't this still a problem with this patch applied ? Calling
> > sci_set_mctrl() should reconfigure the pins properly, but won't there be
> > a short window during which the configuration will be wrong ?
> 
> You mean in between the calls to sci_init_pins() and sci_set_mctrl()?

That's what I mean, yes.

> I don't think _de_asserting RTS for a few microseconds matters much, would
> it? Asserting RTS wrongly would be worse.

It's not the end of the world, but as you're trying to fix this issue, maybe 
it would be a good time to refactor the code properly and fix the core problem 
(.set_termios() calling sci_init_pins()) rather than working around it :-)

-- 
Regards,

Laurent Pinchart
