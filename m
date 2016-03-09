From: Jiang Lu <lu.jiang@windriver.com>
Subject: serial_core:recognize invalid pointer from userspace
Date: Wed, 9 Mar 2016 16:02:29 +0800
Message-ID: <1457510549-24801-2-git-send-email-lu.jiang@windriver.com>
References: <1457510549-24801-1-git-send-email-lu.jiang@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1457510549-24801-1-git-send-email-lu.jiang@windriver.com>
Sender: linux-kernel-owner@vger.kernel.org
To: warrick.jiang@gmail.com, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

compat_ioctl use 0xffffffff as a magic number to mark invalid pointer
for iomem_base in serial_struct when truncating a 64bit pointer into
32bit.

Serial driver need recognize this invalid pointer when parsing
serial_struct from userspace.

Signed-off-by: Jiang Lu <lu.jiang@windriver.com>
---
 drivers/tty/serial/serial_core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index a5d545e..7b9ec1b 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -745,6 +745,9 @@ static int uart_set_info(struct tty_struct *tty, struct tty_port *port,
 	 * allocations, we should treat type changes the same as
 	 * IO port changes.
 	 */
+	if ((unsigned long)new_info->iomem_base == 0xffffffff)
+		new_info->iomem_base = (unsigned char *)uport->mapbase;
+
 	change_port = !(uport->flags & UPF_FIXED_PORT)
 		&& (new_port != uport->iobase ||
 		    (unsigned long)new_info->iomem_base != uport->mapbase ||
-- 
1.9.1
