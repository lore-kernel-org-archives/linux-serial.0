From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 00/25] serial: sh-sci: Add external clock and BRG Support
Date: Sat, 12 Dec 2015 22:43:48 -0800
Message-ID: <20151213064348.GC16326@kroah.com>
References: <1447958344-836-1-git-send-email-geert+renesas@glider.be>
 <CAMuHMdVGni+uTcFzMwnjJ2R_K-FiHpzeEioMMmqwXzdnOYu30g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdVGni+uTcFzMwnjJ2R_K-FiHpzeEioMMmqwXzdnOYu30g@mail.gmail.com>
Sender: linux-sh-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Fri, Nov 20, 2015 at 10:09:24AM +0100, Geert Uytterhoeven wrote:
> On Thu, Nov 19, 2015 at 7:38 PM, Geert Uytterhoeven
> <geert+renesas@glider.be> wrote:
> > This patch series adds support to the Renesas SCI serial driver for
> >   - the optional external clock on (H)SCI(F) and some SCIFA, where this
> >     pin can serve as a clock input,
> >   - the optional clock sources for the Baud Rate Generator for External
> >     Clock (BRG), as found on some SCIF variants and on HSCIF.
> > Using external clocks increases the range and accuracy of supported baud
> > rates. Please see the descriptions of the DTS patches for more detailed
> > information regarding the impact on the supported platforms.
> 
> For the consumers: I've pushed this (incl. the dependencies and a few
> WIP patches) to the scif-brg branch of my renesas-drivers repo.

I don't know what I can do with this series given the dependancies, but
if it helps, you can add:
	Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
to the serial patches and take them through what ever tree you want to.

thanks,

greg k-h
