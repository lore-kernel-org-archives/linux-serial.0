From: "Gustavo F. Padovan" <gustavo@las.ic.unicamp.br>
Subject: [PATCH] 8250: remove ununsed variable
Date: Tue, 14 Oct 2008 23:12:18 -0300
Message-ID: <1224036738-16613-1-git-send-email-gustavo@las.ic.unicamp.br>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754036AbYJOCSt@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-serial@vger.kernel.org, gregkh@suse.de
List-Id: linux-serial@vger.kernel.org

'i' isn't used in serial8250_init()

Signed-off-by: Gustavo F. Padovan <gustavo@las.ic.unicamp.br>
---
 drivers/serial/8250.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/serial/8250.c b/drivers/serial/8250.c
index d4104a3..625fc20 100644
--- a/drivers/serial/8250.c
+++ b/drivers/serial/8250.c
@@ -2960,7 +2960,7 @@ EXPORT_SYMBOL(serial8250_unregister_port);
 
 static int __init serial8250_init(void)
 {
-	int ret, i;
+	int ret;
 
 	if (nr_uarts > UART_NR)
 		nr_uarts = UART_NR;
-- 
1.5.6.4
