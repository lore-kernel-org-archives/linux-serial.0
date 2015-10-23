From: Huang Shijie <shijie.huang@arm.com>
Subject: [PATCH] Revert "serial: amba-pl011: fix incorrect integer size in
 pl011_fifo_to_tty()"
Date: Fri, 23 Oct 2015 18:00:00 +0800
Message-ID: <1445594400-29095-1-git-send-email-shijie.huang@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: gregkh@linuxfoundation.org, linux-arm-kernel@lists.infradead.org
Cc: Huang Shijie <shijie.huang@arm.com>, timur@codeaurora.org, Dave.Martin@arm.com, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

The commit 71a5cd8a4 makes the console hang for some times.
This reverts commit 71a5cd8a4a2602a6e9010b557a23af0a54df87b6.

Signed-off-by: Huang Shijie <shijie.huang@arm.com>
---
 drivers/tty/serial/amba-pl011.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 899a771..fd27e98 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -191,8 +191,8 @@ struct uart_amba_port {
  */
 static int pl011_fifo_to_tty(struct uart_amba_port *uap)
 {
-	u16 status;
-	unsigned int ch, flag, max_count = 256;
+	u16 status, ch;
+	unsigned int flag, max_count = 256;
 	int fifotaken = 0;
 
 	while (max_count--) {
-- 
2.1.4
