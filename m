From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 1/1] tty: serial: qcom_geni_serial: simplify getting .driver_data
Date: Sun, 21 Oct 2018 22:00:59 +0200
Message-ID: <20181021200059.2294-2-wsa+renesas@sang-engineering.com>
References: <20181021200059.2294-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181021200059.2294-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

We should get 'driver_data' from 'struct device' directly. Going via
platform_device is an unneeded step back and forth.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Build tested only. buildbot is happy.

 drivers/tty/serial/qcom_geni_serial.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index d3b5261ee80a..4c9dbfe96c1a 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -162,8 +162,7 @@ static struct qcom_geni_serial_port qcom_geni_uart_ports[GENI_UART_PORTS] = {
 static ssize_t loopback_show(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct qcom_geni_serial_port *port = platform_get_drvdata(pdev);
+	struct qcom_geni_serial_port *port = dev_get_drvdata(dev);
 
 	return snprintf(buf, sizeof(u32), "%d\n", port->loopback);
 }
@@ -172,8 +171,7 @@ static ssize_t loopback_store(struct device *dev,
 				struct device_attribute *attr, const char *buf,
 				size_t size)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct qcom_geni_serial_port *port = platform_get_drvdata(pdev);
+	struct qcom_geni_serial_port *port = dev_get_drvdata(dev);
 	u32 loopback;
 
 	if (kstrtoint(buf, 0, &loopback) || loopback > MAX_LOOPBACK_CFG) {
-- 
2.19.0
