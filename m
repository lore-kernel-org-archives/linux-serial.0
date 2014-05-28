From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 0/5] serial: imx: fixes
Date: Wed, 28 May 2014 12:34:42 -0700
Message-ID: <20140528193442.GA7066@kroah.com>
References: <1399648788-26061-1-git-send-email-dean_jenkins@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:39663 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751268AbaE1TbH (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 28 May 2014 15:31:07 -0400
Content-Disposition: inline
In-Reply-To: <1399648788-26061-1-git-send-email-dean_jenkins@mentor.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: dean_jenkins@mentor.com
Cc: linux-serial@vger.kernel.org, dirk.behme@de.bosch.com, linux-arm-kernel@lists.infradead.org, shawn.guo@freescale.com, s.hauer@pengutronix.de, b32955@freescale.com

On Fri, May 09, 2014 at 04:19:43PM +0100, dean_jenkins@mentor.com wrote:
> From: Dean Jenkins <Dean_Jenkins@mentor.com>
> 
> The following set of patches were tested on an i.MX6 multi-core platform.
> 
> Patches 1 to 4 were tested using a Bluetooth BCSP UART connection at 115.2kbps
> and 4Mbps. The fixes were needed because the i.MX6 UART driver caused spinlock
> deadlocks with the HCI TTY layer.
> 
> Patch 5 improves the i.MX6 UART driver for use with kdb.
> 
> Patch 1: serial: imx: remove unneeded imx_transmit_buffer() from imx_start_tx()
> Patch 2: serial: imx: remove uart_write_wakeup() from imx_transmit_buffer()
> Patch 3: serial: imx: avoid spinlock recursion deadlock
> Patch 4: serial: imx: move imx_transmit_buffer() into imx_txint()
> Patch 5: serial: imx: clean up imx_poll_get_char()
> 
> The patches are based off 3.15-rc4.
> 
> ----------------------------------------------------------------
> Andy Lowe (1):
>       serial: imx: avoid spinlock recursion deadlock
> 
> Dirk Behme (4):
>       serial: imx: remove unneeded imx_transmit_buffer() from imx_start_tx()
>       serial: imx: remove uart_write_wakeup() from imx_transmit_buffer()
>       serial: imx: move imx_transmit_buffer() into imx_txint()
>       serial: imx: clean up imx_poll_get_char()
> 
>  drivers/tty/serial/imx.c |   73 ++++++++++++++--------------------------------
>  1 file changed, 22 insertions(+), 51 deletions(-)

Given the rather confusing threads based on these patches, I don't know
what to apply.

Dean, can you respin what patches you want applied and resend them so
I'm not so confused?

thanks,

greg k-h
