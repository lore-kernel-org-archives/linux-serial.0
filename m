From: Huang Shijie <b32955@freescale.com>
Subject: Re: [PATCH 0/5] serial: imx: fixes
Date: Thu, 29 May 2014 12:14:58 +0800
Message-ID: <20140529041451.GA4781@shlinux1.ap.freescale.net>
References: <1399648788-26061-1-git-send-email-dean_jenkins@mentor.com>
 <20140528193442.GA7066@kroah.com> <5386BE8F.20605@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from dns-bn1lp0143.outbound.protection.outlook.com ([207.46.163.143]:40820
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932928AbaE2FgG (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 29 May 2014 01:36:06 -0400
Content-Disposition: inline
In-Reply-To: <5386BE8F.20605@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Dirk Behme <dirk.behme@gmail.com>
Cc: dean_jenkins@mentor.com, Greg KH <gregkh@linuxfoundation.org>, dirk.behme@de.bosch.com, s.hauer@pengutronix.de, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, shawn.guo@freescale.com

On Thu, May 29, 2014 at 06:58:55AM +0200, Dirk Behme wrote:
> Am 28.05.2014 21:34, schrieb Greg KH:
> >On Fri, May 09, 2014 at 04:19:43PM +0100, dean_jenkins@mentor.com wrote:
> >>From: Dean Jenkins <Dean_Jenkins@mentor.com>
> >>
> >>The following set of patches were tested on an i.MX6 multi-core platform.
> >>
> >>Patches 1 to 4 were tested using a Bluetooth BCSP UART connection at 115.2kbps
> >>and 4Mbps. The fixes were needed because the i.MX6 UART driver caused spinlock
> >>deadlocks with the HCI TTY layer.
> >>
> >>Patch 5 improves the i.MX6 UART driver for use with kdb.
> >>
> >>Patch 1: serial: imx: remove unneeded imx_transmit_buffer() from imx_start_tx()
> >>Patch 2: serial: imx: remove uart_write_wakeup() from imx_transmit_buffer()
> >>Patch 3: serial: imx: avoid spinlock recursion deadlock
> >>Patch 4: serial: imx: move imx_transmit_buffer() into imx_txint()
> >>Patch 5: serial: imx: clean up imx_poll_get_char()
> >>
> >>The patches are based off 3.15-rc4.
> >>
> >>----------------------------------------------------------------
> >>Andy Lowe (1):
> >>       serial: imx: avoid spinlock recursion deadlock
> >>
> >>Dirk Behme (4):
> >>       serial: imx: remove unneeded imx_transmit_buffer() from imx_start_tx()
> >>       serial: imx: remove uart_write_wakeup() from imx_transmit_buffer()
> >>       serial: imx: move imx_transmit_buffer() into imx_txint()
> >>       serial: imx: clean up imx_poll_get_char()
> >>
> >>  drivers/tty/serial/imx.c |   73 ++++++++++++++--------------------------------
> >>  1 file changed, 22 insertions(+), 51 deletions(-)
> >
> >Given the rather confusing threads based on these patches, I don't know
> >what to apply.
> >
> >Dean, can you respin what patches you want applied
> 
> Well, we think patches #1-#4 are correct and should be applied, but
> Huang has the opinion that this is fixed already in the BT stack. If
> Huang doesn't change his mind, then let's drop #1-#4.
Yes, the BT stack has fixed it. :)

we can drop the #1-#4.	   

thanks
Huang Shijie
 

