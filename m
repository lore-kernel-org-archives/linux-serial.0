From: Bich HEMON <bich.hemon@st.com>
Subject: [PATCH 07/20] serial: stm32: less messages on dma alloc error
Date: Mon, 26 Jun 2017 12:49:11 +0000
Message-ID: <1498481318-1894-8-git-send-email-bich.hemon@st.com>
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

Just display one info (instead of two) in the
log buffer when there is no dma.

Signed-off-by: Gerald Baeza <gerald.baeza@st.com>
---
 drivers/tty/serial/stm32-usart.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index 79ac167..dcc6d1e 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -786,10 +786,8 @@ static int stm32_of_dma_rx_probe(struct stm32_port *stm32port,
 
 	/* Request DMA RX channel */
 	stm32port->rx_ch = dma_request_slave_channel(dev, "rx");
-	if (!stm32port->rx_ch) {
-		dev_info(dev, "rx dma alloc failed\n");
+	if (!stm32port->rx_ch)
 		return -ENODEV;
-	}
 	stm32port->rx_buf = dma_alloc_coherent(&pdev->dev, RX_BUF_L,
 						 &stm32port->rx_dma_buf,
 						 GFP_KERNEL);
@@ -858,10 +856,8 @@ static int stm32_of_dma_tx_probe(struct stm32_port *stm32port,
 
 	/* Request DMA TX channel */
 	stm32port->tx_ch = dma_request_slave_channel(dev, "tx");
-	if (!stm32port->tx_ch) {
-		dev_info(dev, "tx dma alloc failed\n");
+	if (!stm32port->tx_ch)
 		return -ENODEV;
-	}
 	stm32port->tx_buf = dma_alloc_coherent(&pdev->dev, TX_BUF_L,
 						 &stm32port->tx_dma_buf,
 						 GFP_KERNEL);
-- 
1.9.1
