From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [PATCH stable] serial: samsung: Reorder the sequence of clock control
 when call s3c24xx_serial_set_termios()
Date: Mon, 30 May 2016 16:19:10 +0200
Message-ID: <1464617950-11595-1-git-send-email-k.kozlowski@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Chanwoo Choi <cw00.choi@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, stable@vger.kernel.org, Krzysztof Kozlowski <k.kozlowski@samsung.com>
List-Id: linux-serial@vger.kernel.org

From: Chanwoo Choi <cw00.choi@samsung.com>

commit b8995f527aac143e83d3900ff39357651ea4e0f6 upstream.

This patch fixes the broken serial log when changing the clock source
of uart device. Before disabling the original clock source, this patch
enables the new clock source to protect the clock off state for a split second.

[k.kozlowski]:
On SMP systems this opens a short time window when both clocks (old and
new) are disabled and a second thread uses TTY/UART. This leads to
broken log or imprecise external abort (on one of ARM64 boards):

Unhandled fault: synchronous external abort (0x96000210) at 0xffffff8008080008
Internal error: : 96000210 [#1] PREEMPT SMP
[<ffffff8008427634>] s3c24xx_serial_console_putchar+0x8/0x64
[<ffffff8008427fa0>] s3c24xx_serial_console_write+0x30/0x38
[<ffffff80080f4e68>] call_console_drivers.constprop.22+0x100/0x108
[<ffffff80080f5d34>] console_unlock+0x504/0x58c
[<ffffff80080f6088>] vprintk_emit+0x2cc/0x478
[<ffffff80080f63ac>] vprintk_default+0x38/0x40
[<ffffff800814beb4>] printk+0xac/0xb8
[<ffffff800812f20c>] audit_printk_skb+0x68/0x6c
[<ffffff800812f4ec>] audit_log_end+0x13c/0x188
[<ffffff8008306064>] common_lsm_audit+0xb4/0x618
[<ffffff8008302cb0>] smack_log+0xe8/0x10c
[<ffffff8008303408>] smk_tskacc+0x8c/0xa4
[<ffffff800830344c>] smk_curacc+0x2c/0x34
[<ffffff800830066c>] smack_inode_permission+0x60/0x70
[<ffffff80082fb7d8>] security_inode_permission+0x58/0x80
[<ffffff80081c15a4>] __inode_permission+0x40/0xa0
[<ffffff80081c1618>] inode_permission+0x14/0x4c
[<ffffff80081c1e4c>] may_open+0x5c/0x10c
[<ffffff80081c47e8>] path_openat+0x13c/0xec8
[<ffffff80081c64f8>] do_filp_open+0x64/0xc0
[<ffffff80081b5ea0>] do_sys_open+0x144/0x208
[<ffffff80081b5f9c>] SyS_openat+0x10/0x18
[<ffffff8008085ecc>] __sys_trace_return+0x0/0x4

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
Reviewed-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: <stable@vger.kernel.org>
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
[k.kozlowski: Backport to stable, update commit msg]
Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

---

The original Samsung serial driver was broken so this should be
backported as far as possible including the 2.6.12. :)
---
 drivers/tty/serial/samsung.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
index ac7f8df54406..99bb23161dd6 100644
--- a/drivers/tty/serial/samsung.c
+++ b/drivers/tty/serial/samsung.c
@@ -1271,6 +1271,8 @@ static void s3c24xx_serial_set_termios(struct uart_port *port,
 	/* check to see if we need  to change clock source */
 
 	if (ourport->baudclk != clk) {
+		clk_prepare_enable(clk);
+
 		s3c24xx_serial_setsource(port, clk_sel);
 
 		if (!IS_ERR(ourport->baudclk)) {
@@ -1278,8 +1280,6 @@ static void s3c24xx_serial_set_termios(struct uart_port *port,
 			ourport->baudclk = ERR_PTR(-EINVAL);
 		}
 
-		clk_prepare_enable(clk);
-
 		ourport->baudclk = clk;
 		ourport->baudclk_rate = clk ? clk_get_rate(clk) : 0;
 	}
-- 
1.9.1
