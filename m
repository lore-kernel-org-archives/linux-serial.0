From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH v2 1/7] serial: exar: Fix mapping of port I/O resources
Date: Wed,  8 Feb 2017 17:09:03 +0100
Message-ID: <a359e4d7ce6ba5f2741ead10bdcca4ec5d2477b2.1486570149.git.jan.kiszka@siemens.com>
References: <cover.1486570149.git.jan.kiszka@siemens.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1486570149.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1486570149.git.jan.kiszka@siemens.com>
References: <cover.1486570149.git.jan.kiszka@siemens.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org, Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>, Andy Shevchenko <andy.shevchenko@gmail.com>
List-Id: linux-serial@vger.kernel.org

pcim_iomap_table only returns the table of mapping, it does not perform
them. For that, we need to call pcim_iomap, but only if that mapping was
not done before.

Fixes: d0aeaa83f0b0 ("serial: exar: split out the exar code from 8250_pci")
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/tty/serial/8250/8250_exar.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
index e6b44a7..58469d9 100644
--- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -72,6 +72,9 @@ static int default_setup(struct exar8250 *priv, struct pci_dev *pcidev,
 	const struct exar8250_board *board = priv->board;
 	unsigned int bar = 0;
 
+	if (!pcim_iomap_table(pcidev)[bar] && !pcim_iomap(pcidev, bar, 0))
+		return -ENOMEM;
+
 	port->port.iotype = UPIO_MEM;
 	port->port.mapbase = pci_resource_start(pcidev, bar) + offset;
 	port->port.membase = pcim_iomap_table(pcidev)[bar] + offset;
-- 
2.1.4
