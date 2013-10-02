From: Hector Palacios <hector.palacios@digi.com>
Subject: [PATCH v2 0/2] serial: mxs-auart: wait for DMA buffer to flush before shutdown
Date: Wed, 2 Oct 2013 14:02:42 +0200
Message-ID: <1380715364-8025-1-git-send-email-hector.palacios@digi.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail1.bemta12.messagelabs.com ([216.82.251.17]:24513 "EHLO
	mail1.bemta12.messagelabs.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753872Ab3JBMDm (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 2 Oct 2013 08:03:42 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: hector.palacios@digi.com, linux-arm-kernel@lists.infradead.org, u.kleine-koenig@pengutronix.de, gregkh@linuxfoundation.org, b32955@freescale.com, marex@denx.de, fabio.estevam@freescale.com, shawn.guo@linaro.org, jslaby@suse.cz

This fixes a bug whereby the AUART was shutdown while bytes 
were still waiting in the DMA buffer to be transmistted.

Changes since v1:
 * Split the patch in two: one to set the fifosize to the 
   DMA buffer size, and another to wait for the FIFO to empty
   before disabling the AUART.
 * The wait for the fifo to empty is now independent of DMA
   being enabled.
 * Fix bug on readl() call
 * Remove bad URL in commit log

Hector Palacios (2):
  serial: mxs-auart: set the FIFO size to DMA buffer size
  serial: mxs-auart: wait for FIFO to flush before shutdown

 drivers/tty/serial/mxs-auart.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

-- 
1.8.4

