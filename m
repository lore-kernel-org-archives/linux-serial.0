From: Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 1/3] TTY: serial/mpsc, stop leaking mappings
Date: Tue, 12 Jan 2016 10:49:32 +0100
Message-ID: <1452592174-24805-1-git-send-email-jslaby@suse.cz>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>
List-Id: linux-serial@vger.kernel.org

When mpsc_routing_base, sdma_intr_base, mpsc_base, sdma_base, and
brg_base are mapped, they are never unmapped. The condition in the
free paths is always 'if (!XXX_base) { unmap }'. Fix it by inverting
the condition.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/serial/mpsc.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/mpsc.c b/drivers/tty/serial/mpsc.c
index cadfd1cfae2b..363772992acc 100644
--- a/drivers/tty/serial/mpsc.c
+++ b/drivers/tty/serial/mpsc.c
@@ -1870,12 +1870,12 @@ static int mpsc_shared_map_regs(struct platform_device *pd)
 
 static void mpsc_shared_unmap_regs(void)
 {
-	if (!mpsc_shared_regs.mpsc_routing_base) {
+	if (mpsc_shared_regs.mpsc_routing_base) {
 		iounmap(mpsc_shared_regs.mpsc_routing_base);
 		release_mem_region(mpsc_shared_regs.mpsc_routing_base_p,
 				MPSC_ROUTING_REG_BLOCK_SIZE);
 	}
-	if (!mpsc_shared_regs.sdma_intr_base) {
+	if (mpsc_shared_regs.sdma_intr_base) {
 		iounmap(mpsc_shared_regs.sdma_intr_base);
 		release_mem_region(mpsc_shared_regs.sdma_intr_base_p,
 				MPSC_SDMA_INTR_REG_BLOCK_SIZE);
@@ -2011,15 +2011,15 @@ err:
 
 static void mpsc_drv_unmap_regs(struct mpsc_port_info *pi)
 {
-	if (!pi->mpsc_base) {
+	if (pi->mpsc_base) {
 		iounmap(pi->mpsc_base);
 		release_mem_region(pi->mpsc_base_p, MPSC_REG_BLOCK_SIZE);
 	}
-	if (!pi->sdma_base) {
+	if (pi->sdma_base) {
 		iounmap(pi->sdma_base);
 		release_mem_region(pi->sdma_base_p, MPSC_SDMA_REG_BLOCK_SIZE);
 	}
-	if (!pi->brg_base) {
+	if (pi->brg_base) {
 		iounmap(pi->brg_base);
 		release_mem_region(pi->brg_base_p, MPSC_BRG_REG_BLOCK_SIZE);
 	}
-- 
2.7.0
