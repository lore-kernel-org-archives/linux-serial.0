From: Michal Simek <michal.simek@xilinx.com>
Subject: [PATCH v2 1/4] serial: uartps: Add the device_init_wakeup
Date: Tue, 18 Dec 2018 13:18:39 +0100
Message-ID: <439951b77da9a1d4cc0551af41c158ae5908b840.1545135519.git.michal.simek@xilinx.com>
References: <cover.1545135519.git.michal.simek@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1545135519.git.michal.simek@xilinx.com>
In-Reply-To: <cover.1545135519.git.michal.simek@xilinx.com>
References: <cover.1545135519.git.michal.simek@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, monstr@monstr.eu, michal.simek@xilinx.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Cc: Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>

Initialise the device wakeup.

The device_init_wakeup is needed for the wakeup to work by default.
Uart can be configured as the primary wakeup source so it is good to
enable wakeup by default.

The same functionality is enabled also by 8250_omap, atmel_serial,
omap-serial and stm32-usart.

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Changes in v2:
- Change description based on request from Greg

 drivers/tty/serial/xilinx_uartps.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 379242b96790..0140644391df 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -1624,6 +1624,7 @@ static int cdns_uart_probe(struct platform_device *pdev)
 	pm_runtime_set_autosuspend_delay(&pdev->dev, UART_AUTOSUSPEND_TIMEOUT);
 	pm_runtime_set_active(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
+	device_init_wakeup(port->dev, true);
 
 #ifdef CONFIG_SERIAL_XILINX_PS_UART_CONSOLE
 	/*
@@ -1702,6 +1703,7 @@ static int cdns_uart_remove(struct platform_device *pdev)
 	pm_runtime_disable(&pdev->dev);
 	pm_runtime_set_suspended(&pdev->dev);
 	pm_runtime_dont_use_autosuspend(&pdev->dev);
+	device_init_wakeup(&pdev->dev, false);
 
 #ifdef CONFIG_SERIAL_XILINX_PS_UART_CONSOLE
 	if (console_port == port)
-- 
1.9.1
