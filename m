From: Claudio Scordino <claudio@evidence.eu.com>
Subject: atmel_serial: fix RTS high after initialization in RS485 mode
Date: Sun, 24 Oct 2010 12:48:29 +0200
Message-ID: <4CC40EFD.8070000@evidence.eu.com>
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
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, =?UTF-8?B?QXJrYWRpdXN6IEJ1YmHFgmE=?= <arkadiusz.bubala@gmail.com>, linux@maxim.org.za, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Linux Kernel <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Hi Nicolas,

	when working in RS485 mode, the atmel_serial driver keeps RTS
high after the initialization of the serial port. It goes low only after
the first character has been sent. 

This patch fixes this behavior. It has been already tested by Arkadiusz (CC:-ed).

Best regards,

	Claudio


atmel_serial: RTS line low after initialization of the serial port

Signed-off-by: Claudio Scordino <claudio@evidence.eu.com>
Signed-off-by: Arkadiusz Bubala <arkadiusz.bubala@gmail.com>
---
 drivers/serial/atmel_serial.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/drivers/serial/atmel_serial.c b/drivers/serial/atmel_serial.c
index 3892666..85aa66f 100644
--- a/drivers/serial/atmel_serial.c
+++ b/drivers/serial/atmel_serial.c
@@ -1732,6 +1732,15 @@ static int __devinit atmel_serial_probe(struct platform_device *pdev)
 	device_init_wakeup(&pdev->dev, 1);
 	platform_set_drvdata(pdev, port);
 
+	if (port->rs485.flags & SER_RS485_ENABLED) {
+		unsigned int control = 0;
+		unsigned int mode = 0;
+		control |= ATMEL_US_RTSEN;
+		mode |= ATMEL_US_USMODE_NORMAL;
+		UART_PUT_MR(&port->uart, mode);
+		UART_PUT_CR(&port->uart, control);
+	}
+
 	return 0;
 
 err_add_port:
-- 
1.6.0.4
