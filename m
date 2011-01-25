From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] serial/mrst_max3110: make buffer larger
Date: Tue, 25 Jan 2011 14:15:11 +0000
Message-ID: <20110125141459.9110.93938.stgit@bob.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:54003 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751977Ab1AYOlz (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 25 Jan 2011 09:41:55 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: greg@kroah.com, linux-serial@vger.kernel.org

From: Dan Carpenter <error27@gmail.com>

This is used to store the spi_device ->modalias so they have to be the same
size.  SPI_NAME_SIZE is 32.

Signed-off-by: Dan Carpenter <error27@gmail.com>
Signed-off-by: Alan Cox <alan@linux.intel.com>
Cc: stable@kernel.org
---

 drivers/tty/serial/mrst_max3110.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)


diff --git a/drivers/tty/serial/mrst_max3110.c b/drivers/tty/serial/mrst_max3110.c
index b62857b..37e13c3 100644
--- a/drivers/tty/serial/mrst_max3110.c
+++ b/drivers/tty/serial/mrst_max3110.c
@@ -51,7 +51,7 @@
 struct uart_max3110 {
 	struct uart_port port;
 	struct spi_device *spi;
-	char name[24];
+	char name[SPI_NAME_SIZE];
 
 	wait_queue_head_t wq;
 	struct task_struct *main_thread;

