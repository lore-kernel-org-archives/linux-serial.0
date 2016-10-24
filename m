From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 1/4] serial: 8250_uniphier: fix more unterminated string
Date: Mon, 24 Oct 2016 17:00:27 +0900
Message-ID: <1477296030-7517-2-git-send-email-yamada.masahiro@socionext.com>
References: <1477296030-7517-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1477296030-7517-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Denys Vlasenko <dvlasenk@redhat.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

From: Denys Vlasenko <dvlasenk@redhat.com>

Commit 1681d2116c96 ("serial: 8250_uniphier: add "\n" at the end of
error log") missed this.

Signed-off-by: Denys Vlasenko <dvlasenk@redhat.com>
[masahiro: add commit log]
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

---

 drivers/tty/serial/8250/8250_uniphier.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_uniphier.c b/drivers/tty/serial/8250/8250_uniphier.c
index b8d9c8c..a8babb0 100644
--- a/drivers/tty/serial/8250/8250_uniphier.c
+++ b/drivers/tty/serial/8250/8250_uniphier.c
@@ -199,7 +199,7 @@ static int uniphier_uart_probe(struct platform_device *pdev)
 
 	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!regs) {
-		dev_err(dev, "failed to get memory resource");
+		dev_err(dev, "failed to get memory resource\n");
 		return -EINVAL;
 	}
 
-- 
1.9.1
