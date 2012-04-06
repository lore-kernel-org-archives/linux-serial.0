From: Dan Williams <dan.j.williams@intel.com>
Subject: [RFC PATCH 6/6] serial/8250_pci: fix suspend/resume vs init/exit
 quirks
Date: Fri, 06 Apr 2012 11:50:24 -0700
Message-ID: <20120406185010.22088.3244.stgit@dwillia2-linux.jf.intel.com>
References: <20120406184346.21744.18004.stgit@dwillia2-linux.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120406184346.21744.18004.stgit@dwillia2-linux.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Alan Cox <alan@linux.intel.com>
List-Id: linux-serial@vger.kernel.org

Commit e86ff4a6 "serial/8250_pci: init-quirk msi support for kt serial
controller" introduced a regression in suspend/resume by causing msi's
to be enabled twice without an intervening disable.

That patch has since been reverted, but by inspection it seems that
pciserial_suspend_ports() should be invoking .exit() quirks to release
resources acquired during .init().

Cc: Alan Cox <alan@linux.intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/tty/serial/8250/8250_pci.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index 024551a..24ea98c 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -2814,6 +2814,12 @@ void pciserial_suspend_ports(struct serial_private *priv)
 	for (i = 0; i < priv->nr; i++)
 		if (priv->line[i] >= 0)
 			serial8250_suspend_port(priv->line[i]);
+
+	/*
+	 * Ensure that every init quirk is properly torn down
+	 */
+	if (priv->quirk->exit)
+		priv->quirk->exit(priv->dev);
 }
 EXPORT_SYMBOL_GPL(pciserial_suspend_ports);
 
