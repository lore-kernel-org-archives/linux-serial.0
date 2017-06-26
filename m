From: Bich HEMON <bich.hemon@st.com>
Subject: [PATCH 18/20] serial: stm32: update dma buffers length
Date: Mon, 26 Jun 2017 12:49:16 +0000
Message-ID: <1498481318-1894-19-git-send-email-bich.hemon@st.com>
References: <1498481318-1894-1-git-send-email-bich.hemon@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1498481318-1894-1-git-send-email-bich.hemon@st.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre TORGUE <alexandre.torgue@st.com>, Jiri Slaby <jslaby@suse.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Bich HEMON <bich.hemon@st.com>
List-Id: linux-serial@vger.kernel.org

From: Bich Hemon <bich.hemon@st.com>

When stm32 dma is used alone for rx, meaning that the
third dmamux property in the device tree is 0x0, then
the received data are accumulated in dma internal fifo
until it is full before being transferred to the memory.
This dma fifo is 16 bytes wide on stm32ap1 so the dma
buffer is set to 160 bytes (= 16bytes * 10).

When stm32 dma is used combined with mdma, meaning that
the third dmamux property in the device tree is 0x1, then
the received data are accumulated per 16 bytes packets
(cf. explanation above) until the rx dma transfer period
is reached, so 160 bytes with this patch.

Due to the constraints above, the usart driver should not
be used in dma mode for rx when received data length is
unknown, as this is the case with the console.

There is no constraint for dma mode using for tx: this patch
simply align both rx and tx buffer lengths to the same value.

Signed-off-by: Gerald Baeza <gerald.baeza@st.com>
---
 drivers/tty/serial/stm32-usart.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/stm32-usart.h b/drivers/tty/serial/stm32-usart.h
index 25ed28b..5137e68 100644
--- a/drivers/tty/serial/stm32-usart.h
+++ b/drivers/tty/serial/stm32-usart.h
@@ -238,9 +238,9 @@ struct stm32_usart_info stm32h7_info = {
 #define STM32_SERIAL_NAME "ttyS"
 #define STM32_MAX_PORTS 8
 
-#define RX_BUF_L 200		 /* dma rx buffer length     */
+#define RX_BUF_L 160		 /* dma rx buffer length     */
 #define RX_BUF_P RX_BUF_L	 /* dma rx buffer period     */
-#define TX_BUF_L 200		 /* dma tx buffer length     */
+#define TX_BUF_L RX_BUF_L	 /* dma tx buffer length     */
 
 struct stm32_port {
 	struct uart_port port;
-- 
1.9.1
