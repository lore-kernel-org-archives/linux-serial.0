From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH/RFC 4/8] serial: pxa: Add fifo-size and {big,native}-endian properties
Date: Wed, 12 Nov 2014 10:08:22 +0100
Message-ID: <1644326.y4vtt1W8M2@wuerfel>
References: <1415781993-7755-1-git-send-email-cernekee@gmail.com> <1415781993-7755-5-git-send-email-cernekee@gmail.com> <5463227E.9050304@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:63719 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751644AbaKLJIm (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 12 Nov 2014 04:08:42 -0500
In-Reply-To: <5463227E.9050304@suse.cz>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Jiri Slaby <jslaby@suse.cz>
Cc: Kevin Cernekee <cernekee@gmail.com>, gregkh@linuxfoundation.org, robh@kernel.org, tushar.behera@linaro.org, daniel@zonque.org, haojian.zhuang@gmail.com, robert.jarzmik@free.fr, grant.likely@linaro.org, f.fainelli@gmail.com, mbizon@freebox.fr, jogo@openwrt.org, linux-mips@linux-mips.org, linux-serial@vger.kernel.org, devicetree@vger.kernel.org

On Wednesday 12 November 2014 10:03:58 Jiri Slaby wrote:
> On 11/12/2014, 09:46 AM, Kevin Cernekee wrote:
> > With a few tweaks, the PXA serial driver can handle other 16550A clones.
> > Add a fifo-size DT property to override the FIFO depth (BCM7xxx uses 32),
> > and {native,big}-endian properties similar to regmap to support SoCs that
> > have BE or "automagic endian" registers.
> > 
> > Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
> > ---
> >  drivers/tty/serial/pxa.c | 16 ++++++++++++++--
> >  1 file changed, 14 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/tty/serial/pxa.c b/drivers/tty/serial/pxa.c
> > index 21b7d8b..78ed7ee 100644
> > --- a/drivers/tty/serial/pxa.c
> > +++ b/drivers/tty/serial/pxa.c
> > @@ -60,13 +60,19 @@ struct uart_pxa_port {
> >  static inline unsigned int serial_in(struct uart_pxa_port *up, int offset)
> >  {
> >       offset <<= 2;
> > -     return readl(up->port.membase + offset);
> > +     if (!up->port.big_endian)
> > +             return readl(up->port.membase + offset);
> > +     else
> > +             return ioread32be(up->port.membase + offset);
> 
> This needn't fly IMO, unless you map the space using iomap (not ioremap).

For all I know, the ioread family is required to work with tokens returned
from ioremap on all architectures. The difference to readl is that it
also works on tokens returned from ioport_map or one of the wrappers
around it.

	Arnd
