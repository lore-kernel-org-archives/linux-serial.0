From: Alan Cox <alan@linux.jf.intel.com>
Subject: [PATCH] 8250_pci: Fix missing const from merges
Date: Tue, 24 May 2011 12:35:48 +0100
Message-ID: <20110524113545.18907.2712.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:60471 "EHLO
	localhost.localdomain" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753127Ab1EXLxh (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 24 May 2011 07:53:37 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: greg@kroah.com, linux-serial@vger.kernel.org

Signed-off-by: Alan Cox <alan@linux.intel.com>
---

 drivers/tty/serial/8250_pci.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/tty/serial/8250_pci.c b/drivers/tty/serial/8250_pci.c
index 4b4968a..78e98a5 100644
--- a/drivers/tty/serial/8250_pci.c
+++ b/drivers/tty/serial/8250_pci.c
@@ -973,7 +973,7 @@ ce4100_serial_setup(struct serial_private *priv,
 
 static int
 pci_omegapci_setup(struct serial_private *priv,
-		      struct pciserial_board *board,
+		      const struct pciserial_board *board,
 		      struct uart_port *port, int idx)
 {
 	return setup_port(priv, port, 2, idx * 8, 0);

