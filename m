From: "Enrico Weigelt, metux IT consult" <info@metux.net>
Subject: [PATCH 7/8] drivers: tty: serial: use memres
Date: Tue, 12 Mar 2019 15:57:39 +0100
Message-ID: <1552402660-31730-8-git-send-email-info@metux.net>
References: <1552402660-31730-1-git-send-email-info@metux.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1552402660-31730-1-git-send-email-info@metux.net>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

---
 drivers/tty/serial/zs.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/zs.c b/drivers/tty/serial/zs.c
index b03d3e4..2fd4821 100644
--- a/drivers/tty/serial/zs.c
+++ b/drivers/tty/serial/zs.c
@@ -986,14 +986,13 @@ static void zs_release_port(struct uart_port *uport)
 {
 	iounmap(uport->membase);
 	uport->membase = 0;
-	release_mem_region(uport->mapbase, ZS_CHAN_IO_SIZE);
+	uart_memres_release(uport);
 }
 
 static int zs_map_port(struct uart_port *uport)
 {
 	if (!uport->membase)
-		uport->membase = ioremap_nocache(uport->mapbase,
-						 ZS_CHAN_IO_SIZE);
+		uport->membase = uart_memres_ioremap_nocache(uport);
 	if (!uport->membase) {
 		printk(KERN_ERR "zs: Cannot map MMIO\n");
 		return -ENOMEM;
@@ -1005,13 +1004,13 @@ static int zs_request_port(struct uart_port *uport)
 {
 	int ret;
 
-	if (!request_mem_region(uport->mapbase, ZS_CHAN_IO_SIZE, "scc")) {
+	if (!uart_memres_request(uport, "scc")) {
 		printk(KERN_ERR "zs: Unable to reserve MMIO resource\n");
 		return -EBUSY;
 	}
 	ret = zs_map_port(uport);
 	if (ret) {
-		release_mem_region(uport->mapbase, ZS_CHAN_IO_SIZE);
+		uart_release_memres(uport);
 		return ret;
 	}
 	return 0;
@@ -1113,9 +1112,12 @@ static int __init zs_probe_sccs(void)
 			uport->flags	= UPF_BOOT_AUTOCONF;
 			uport->ops	= &zs_ops;
 			uport->line	= chip * ZS_NUM_CHAN + side;
-			uport->mapbase	= dec_kn_slot_base +
-					  zs_parms.scc[chip] +
-					  (side ^ ZS_CHAN_B) * ZS_CHAN_IO_SIZE;
+			uart_memres_set(
+				DEFINE_RES_MEM(
+					dec_kn_slot_base +
+					zs_parms.scc[chip] +
+					(side ^ ZS_CHAN_B) * ZS_CHAN_IO_SIZE,
+					ZS_CHAN_IO_SIZE));
 
 			for (i = 0; i < ZS_NUM_REGS; i++)
 				zport->regs[i] = zs_init_regs[i];
-- 
1.9.1
