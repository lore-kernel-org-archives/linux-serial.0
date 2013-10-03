From: Hector Palacios <hector.palacios@digi.com>
Subject: [PATCH v3 0/2] serial: mxs-auart: wait for DMA buffer to flush before shutdown
Date: Thu, 3 Oct 2013 09:32:02 +0200
Message-ID: <1380785524-20490-1-git-send-email-hector.palacios@digi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail1.bemta7.messagelabs.com ([216.82.254.98]:36466 "EHLO
	mail1.bemta7.messagelabs.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752754Ab3JCHcd (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 3 Oct 2013 03:32:33 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: hector.palacios@digi.com, linux-arm-kernel@lists.infradead.org, u.kleine-koenig@pengutronix.de, gregkh@linuxfoundation.org, b32955@freescale.com, marex@denx.de, fabio.estevam@freescale.com, shawn.guo@linaro.org, jslaby@suse.cz

This fixes a bug whereby the AUART was shutdown while bytes
were still waiting in the DMA buffer to be transmistted.

Changes since v2:
 * Added Reviewed/Acked-by tags to first commit.
 * Move tx_empty callback up to avoid forward declaration.
 * Move BUSY flag check to tx_empty callback to avoid check
   on shutdown call.

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

 drivers/tty/serial/mxs-auart.c | 34 +++++++++++++++++++++++++---------
 1 file changed, 25 insertions(+), 9 deletions(-)

-- 
1.8.4

