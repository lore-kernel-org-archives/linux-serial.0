From: Marek Vasut <marex@denx.de>
Subject: Re: [PATCH v2 0/2] serial: mxs-auart: wait for DMA buffer to flush before shutdown
Date: Wed, 2 Oct 2013 15:30:22 +0200
Message-ID: <201310021530.22317.marex@denx.de>
References: <1380715364-8025-1-git-send-email-hector.palacios@digi.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:34596 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754302Ab3JBNaX (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 2 Oct 2013 09:30:23 -0400
In-Reply-To: <1380715364-8025-1-git-send-email-hector.palacios@digi.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Hector Palacios <hector.palacios@digi.com>
Cc: linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, u.kleine-koenig@pengutronix.de, gregkh@linuxfoundation.org, b32955@freescale.com, fabio.estevam@freescale.com, shawn.guo@linaro.org, jslaby@suse.cz

Dear Hector Palacios,

> This fixes a bug whereby the AUART was shutdown while bytes
> were still waiting in the DMA buffer to be transmistted.
> 
> Changes since v1:
>  * Split the patch in two: one to set the fifosize to the
>    DMA buffer size, and another to wait for the FIFO to empty
>    before disabling the AUART.
>  * The wait for the fifo to empty is now independent of DMA
>    being enabled.
>  * Fix bug on readl() call
>  * Remove bad URL in commit log
> 
> Hector Palacios (2):
>   serial: mxs-auart: set the FIFO size to DMA buffer size
>   serial: mxs-auart: wait for FIFO to flush before shutdown
> 
>  drivers/tty/serial/mxs-auart.c | 22 +++++++++++++++++++++-
>  1 file changed, 21 insertions(+), 1 deletion(-)

Looks OK

Reviewed-by: Marek Vasut <marex@denx.de>

Best regards,
Marek Vasut
