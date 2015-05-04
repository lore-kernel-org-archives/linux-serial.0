From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] serial: 8250: Prevent kernel crash with nr_uarts=0
Date: Mon, 04 May 2015 18:01:24 +0200
Message-ID: <554797D4.5080704@siemens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

When nr_uarts was set to 0 (via config or 8250_core.nr_uarts), we crash
early on x86 because serial8250_isa_init_ports dereferences base_ops
which remains NULL. In fact, there is nothing to do for that function if
there are no uarts.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 drivers/tty/serial/8250/8250_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index 4506e40..e1363a40 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -3256,7 +3256,7 @@ static void __init serial8250_isa_init_ports(void)
 	static int first = 1;
 	int i, irqflag = 0;
 
-	if (!first)
+	if (!first || nr_uarts == 0)
 		return;
 	first = 0;
 
-- 
2.1.4
