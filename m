From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH] serial: samsung: Continue to work if DMA request fails
Date: Sat, 25 Feb 2017 18:24:42 +0200
Message-ID: <20170225162442.31848-1-krzk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Marek Szyprowski <m.szyprowski@samsung.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: linux-samsung-soc@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>, stable@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

If DMA is not available (even when configured in DeviceTree), the driver
will fail the startup procedure thus making serial console not
available.

For example this causes boot failure on QEMU ARMv7 (Exynos4210, SMDKC210):
    [    1.302575] OF: amba_device_add() failed (-19) for /amba/pdma@12680000
    ...
    [   11.435732] samsung-uart 13800000.serial: DMA request failed
    [   72.963893] samsung-uart 13800000.serial: DMA request failed
    [   73.143361] Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000000

DMA is not necessary for serial to work, so continue with UART startup
after emitting a warning.

Fixes: Fixes: 62c37eedb74c ("serial: samsung: add dma reqest/release functions")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/tty/serial/samsung.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
index b4f86c219db1..7a17aedbf902 100644
--- a/drivers/tty/serial/samsung.c
+++ b/drivers/tty/serial/samsung.c
@@ -1031,8 +1031,10 @@ static int s3c64xx_serial_startup(struct uart_port *port)
 	if (ourport->dma) {
 		ret = s3c24xx_serial_request_dma(ourport);
 		if (ret < 0) {
-			dev_warn(port->dev, "DMA request failed\n");
-			return ret;
+			dev_warn(port->dev,
+				 "DMA request failed, DMA will not be used\n");
+			devm_kfree(port->dev, ourport->dma);
+			ourport->dma = NULL;
 		}
 	}
 
-- 
2.9.3
