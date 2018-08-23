From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] tty: serial: qcom_geni_serial: Drop useless check for dev.of_node
Date: Thu, 23 Aug 2018 23:30:27 +0200
Message-ID: <20180823213027.18856-1-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Girish Mahadevan <girishm@codeaurora.org>, Mohammed Khajapasha <mkhaja@codeaurora.org>, Karthikeyan Ramasubramanian <kramasub@codeaurora.org>, Jiri Slaby <jslaby@suse.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>
List-Id: linux-serial@vger.kernel.org

With gcc 4.1.2:

    drivers/tty/serial/qcom_geni_serial.c: In function ‘qcom_geni_serial_probe’:
    drivers/tty/serial/qcom_geni_serial.c:1261: warning: ‘drv’ may be used uninitialized in this function

Indeed, if dev.of_node is NULL, drv will be used uninitialized, and
dereferenced in uart_add_one_port().  However, as this driver supports
DT only, dev.of_node will always be valid.

Hence remove the useless check for dev.of_node, killing the warning as a
side effect.

Fixes: 8a8a66a1a18a1dbd ("tty: serial: qcom_geni_serial: Add support for flow control")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/tty/serial/qcom_geni_serial.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 29ec343872466e49..1cfbb6745a8cc7d0 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -1263,14 +1263,12 @@ static int qcom_geni_serial_probe(struct platform_device *pdev)
 	if (of_device_is_compatible(pdev->dev.of_node, "qcom,geni-debug-uart"))
 		console = true;
 
-	if (pdev->dev.of_node) {
-		if (console) {
-			drv = &qcom_geni_console_driver;
-			line = of_alias_get_id(pdev->dev.of_node, "serial");
-		} else {
-			drv = &qcom_geni_uart_driver;
-			line = of_alias_get_id(pdev->dev.of_node, "hsuart");
-		}
+	if (console) {
+		drv = &qcom_geni_console_driver;
+		line = of_alias_get_id(pdev->dev.of_node, "serial");
+	} else {
+		drv = &qcom_geni_uart_driver;
+		line = of_alias_get_id(pdev->dev.of_node, "hsuart");
 	}
 
 	port = get_port_from_line(line, console);
-- 
2.17.1
