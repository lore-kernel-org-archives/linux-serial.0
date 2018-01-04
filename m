From: Wei Yongjun <weiyongjun1@huawei.com>
Subject: [PATCH -next] serial: 8250_uniphier: fix error return code in
 uniphier_uart_probe()
Date: Thu, 4 Jan 2018 07:42:15 +0000
Message-ID: <1515051735-59992-1-git-send-email-weiyongjun1@huawei.com>
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
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Wei Yongjun <weiyongjun1@huawei.com>, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Fix to return a negative error code from the port register error
handling case instead of 0, as done elsewhere in this function.

Fixes: 39be40ce066d ("serial: 8250_uniphier: fix serial port index in private data")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/tty/serial/8250/8250_uniphier.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_uniphier.c b/drivers/tty/serial/8250/8250_uniphier.c
index 45ef506..28d88ccf 100644
--- a/drivers/tty/serial/8250/8250_uniphier.c
+++ b/drivers/tty/serial/8250/8250_uniphier.c
@@ -250,12 +250,13 @@ static int uniphier_uart_probe(struct platform_device *pdev)
 	up.dl_read = uniphier_serial_dl_read;
 	up.dl_write = uniphier_serial_dl_write;
 
-	priv->line = serial8250_register_8250_port(&up);
-	if (priv->line < 0) {
+	ret = serial8250_register_8250_port(&up);
+	if (ret < 0) {
 		dev_err(dev, "failed to register 8250 port\n");
 		clk_disable_unprepare(priv->clk);
 		return ret;
 	}
+	priv->line = ret;
 
 	platform_set_drvdata(pdev, priv);
