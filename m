From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.20 44/77] tty: serial: qcom_geni_serial: Allow mctrl when flow control is disabled
Date: Thu, 14 Feb 2019 21:08:22 -0500
Message-ID: <20190215020855.176727-44-sashal@kernel.org>
References: <20190215020855.176727-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190215020855.176727-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Matthias Kaehlcke <mka@chromium.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

From: Matthias Kaehlcke <mka@chromium.org>

[ Upstream commit e8a6ca808c5ed1e2b43ab25f1f2cbd43a7574f73 ]

The geni set/get_mctrl() functions currently do nothing unless
hardware flow control is enabled. Remove this arbitrary limitation.

Suggested-by: Johan Hovold <johan@kernel.org>
Fixes: 8a8a66a1a18a ("tty: serial: qcom_geni_serial: Add support for flow control")
Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/qcom_geni_serial.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index d3b5261ee80a..76e0ad7251e1 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -221,7 +221,7 @@ static unsigned int qcom_geni_serial_get_mctrl(struct uart_port *uport)
 	unsigned int mctrl = TIOCM_DSR | TIOCM_CAR;
 	u32 geni_ios;
 
-	if (uart_console(uport) || !uart_cts_enabled(uport)) {
+	if (uart_console(uport)) {
 		mctrl |= TIOCM_CTS;
 	} else {
 		geni_ios = readl_relaxed(uport->membase + SE_GENI_IOS);
@@ -237,7 +237,7 @@ static void qcom_geni_serial_set_mctrl(struct uart_port *uport,
 {
 	u32 uart_manual_rfr = 0;
 
-	if (uart_console(uport) || !uart_cts_enabled(uport))
+	if (uart_console(uport))
 		return;
 
 	if (!(mctrl & TIOCM_RTS))
-- 
2.19.1
