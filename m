From: "Tosoni" <jp.tosoni@acksys.fr>
Subject: RE: should RTS init in serial core be tied to CRTSCTS
Date: Mon, 12 Mar 2007 10:22:33 +0100
Message-ID: <000001c76487$f7efd100$2e01a8c0@acksys.local>
References: <m3irdaywwd.fsf@maximus.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S965441AbXCLJXk@vger.kernel.org>
In-Reply-To: <m3irdaywwd.fsf@maximus.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: 'Krzysztof Halasa' <khc@pm.waw.pl>, Jean-Pierre TOSONI <TOSONI@acksys.local>
Cc: 'Carl-Daniel Hailfinger' <c-d.hailfinger.devel.2006@gmx.net>, 'Robin Getz' <rgetz@blackfin.uclinux.org>, 'Oleksiy Kebkal' <kebkal@gmail.com>, 'Mike Frysinger' <vapier.adi@gmail.com>, 'Linux Kernel Mailing List' <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Krzysztof Halasa wrote:

> "Tosoni" <jp.tosoni@acksys.fr> writes:
> > As far as I know in the old times this was the *standard*
> way to use a modem
> > (per CCITT V24), and even nowadays many modems can handle
> this method for
> > transmit, to stay compatible with the standard.
>
> I think it wasn't standard for real modems as they were full-duplex
> (even these 1200/75 or what was that) but it was for other devices
> such as current loops (which were frequently half-duplex).
>

It has always been the standard for all modems. The mistake comes from the
fact that the serial ports has been used extensively to drive things which
are *not* modems (say, printers and VT100 consoles on Unix systems). Such
devices did not need the standard-specified RTS function.

CCITT V24 says about RTS: "...this signal drives the DCE and sets it to
transmit data..." (translated from french)
CCITT V24 does not constraint the DCE to being half or full duplex.
CCITT V24 says nothing about using RTS to handle flow control.

> I've seen such devices quite recently, perhaps ~ 10 years ago.
> OTOH I think even "current" PC BIOSes use such signaling.

Even Windows implements the CCITT view of RTS, via a flag named "RTS_TOGGLE"

>
> > Think of radio modems. Some are inherently half duplex.
>
> Sure. But /dev/ttyS* ports are full-duplex, with CRTSCTS or without,
> so they don't use such handshaking.

A full duplex port can be used for both full- and half- duplex. A half
duplex modem cannot be used on a full-duplex-only port. So Linux should be
adapted to the standard, since we cannot adapt the standard to Linux.

> /proc is probably no-no.

Then sysfs sounds good to me.

>
> For such signaling, it would perhaps be better to invent another flag,
> similar to CRTSCTS. The driver would, of course, need some real code
> for that.

Another flag would help to drive modems, yes. But it would not help keeping
RTS low at open, because we need to open the port (which raises RTS) in
order to set the flag. Hence the need for an extra parameter in sysfs.

Best regards,
Jean-Pierre Tosoni
