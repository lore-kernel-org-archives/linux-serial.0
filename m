From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH 2/4] tty: serial: samsung: Properly set flags in autoCTS
 mode
Date: Fri, 14 Dec 2018 12:34:08 +0100
Message-ID: <20181214113410.22848-3-m.szyprowski@samsung.com>
References: <20181214113410.22848-1-m.szyprowski@samsung.com>
        <CGME20181214113417eucas1p2624705c077ae79267082bbf4628951ed@eucas1p2.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20181214113410.22848-1-m.szyprowski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Beomho Seo <beomho.seo@samsung.com>, Seung-Woo Kim <sw0312.kim@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Lee Jones <lee.jones@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-serial@vger.kernel.org

From: Beomho Seo <beomho.seo@samsung.com>

Commit 391f93f2ec9f ("serial: core: Rework hw-assited flow control support")
has changed the way the autoCTS mode is handled.

According to that change, serial drivers which enable H/W autoCTS mode must
set UPSTAT_AUTOCTS to prevent the serial core from inadvertently disabling
TX. This patch adds proper handling of UPSTAT_AUTOCTS flag.

Signed-off-by: Beomho Seo <beomho.seo@samsung.com>
[mszyprow: rephrased commit message]
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/tty/serial/samsung.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
index da1bd4bba8a9..2a49b6d876b8 100644
--- a/drivers/tty/serial/samsung.c
+++ b/drivers/tty/serial/samsung.c
@@ -1365,11 +1365,14 @@ static void s3c24xx_serial_set_termios(struct uart_port *port,
 	wr_regl(port, S3C2410_ULCON, ulcon);
 	wr_regl(port, S3C2410_UBRDIV, quot);
 
+	port->status &= ~UPSTAT_AUTOCTS;
+
 	umcon = rd_regl(port, S3C2410_UMCON);
 	if (termios->c_cflag & CRTSCTS) {
 		umcon |= S3C2410_UMCOM_AFC;
 		/* Disable RTS when RX FIFO contains 63 bytes */
 		umcon &= ~S3C2412_UMCON_AFC_8;
+		port->status = UPSTAT_AUTOCTS;
 	} else {
 		umcon &= ~S3C2410_UMCOM_AFC;
 	}
-- 
2.17.1
