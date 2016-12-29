From: "Matwey V. Kornilov" <matwey@sai.msu.ru>
Subject: [PATCH] serial: 8250: moxa: Store num_ports in brd
Date: Thu, 29 Dec 2016 21:48:51 +0300
Message-ID: <1483037331-3002-1-git-send-email-matwey@sai.msu.ru>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: linux-serial@vger.kernel.org, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, m.othacehe@gmail.com
Cc: "Matwey V. Kornilov" <matwey@sai.msu.ru>
List-Id: linux-serial@vger.kernel.org

When struct moxa8250_board is allocated, then num_ports should
be initialized in order to use it later in moxa8250_remove.

Signed-off-by: Matwey V. Kornilov <matwey@sai.msu.ru>
---
 drivers/tty/serial/8250/8250_moxa.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/8250/8250_moxa.c b/drivers/tty/serial/8250/8250_moxa.c
index 26eb539..d5069b2 100644
--- a/drivers/tty/serial/8250/8250_moxa.c
+++ b/drivers/tty/serial/8250/8250_moxa.c
@@ -68,6 +68,7 @@ static int moxa8250_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 			   sizeof(unsigned int) * nr_ports, GFP_KERNEL);
 	if (!brd)
 		return -ENOMEM;
+	brd->num_ports = nr_ports;
 
 	memset(&uart, 0, sizeof(struct uart_8250_port));
 
-- 
2.6.6
