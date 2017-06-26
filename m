From: Bich HEMON <bich.hemon-qxv4g6HH51o@public.gmane.org>
Subject: [PATCH 17/20] dt-bindings: serial: stm32: add dma using note
Date: Mon, 26 Jun 2017 12:49:16 +0000
Message-ID: <1498481318-1894-18-git-send-email-bich.hemon@st.com>
References: <1498481318-1894-1-git-send-email-bich.hemon@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1498481318-1894-1-git-send-email-bich.hemon-qxv4g6HH51o@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Maxime Coquelin <mcoquelin.stm32-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alexandre TORGUE <alexandre.torgue-qxv4g6HH51o@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, "linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Bich HEMON <bich.hemon-qxv4g6HH51o@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

From: Bich Hemon <bich.hemon-qxv4g6HH51o@public.gmane.org>

Signed-off-by: Gerald Baeza <gerald.baeza-qxv4g6HH51o@public.gmane.org>
---
 .../devicetree/bindings/serial/st,stm32-usart.txt  | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/st,stm32-usart.txt b/Documentation/devicetree/bindings/serial/st,stm32-usart.txt
index 3b42138..6c1cfc8 100644
--- a/Documentation/devicetree/bindings/serial/st,stm32-usart.txt
+++ b/Documentation/devicetree/bindings/serial/st,stm32-usart.txt
@@ -18,6 +18,28 @@ Optional properties:
 - dmas: phandle(s) to DMA controller node(s). Refer to stm32-dma.txt
 - dma-names: "rx" and/or "tx"
 
+Note for dma using:
+- "tx" dma can be used without any constraint since it uses single
+dma transfers.
+- "rx" dma using requires some attention:
+   1) if you cannot anticipate the length of your received packets
+   and if your usart device embeds an internal fifo, then DON'T use
+   dma mode.
+   2) if you enable dma mode WITHOUT mdma intermediate copy (cf.
+   stm32-dma.txt), then the availability of the received data will
+   depend on the dma driver policy and it may be delayed until dma
+   internal fifo is full. The usart driver will see this checking
+   the dma residue when rx interrupt (RXNE or RTO) occurs.
+   3) if you enable dma mode WITH mdma intermediate copy (cf.
+   stm32-dma.txt) then the usart driver will never see the dma
+   residue becoming smaller than RX_BUF_P but it will get its
+   rx dma complete callback called when the cyclic transfer period
+   (RX_BUF_P) is reached.
+The three possibilities above are ordered from the most cpu time
+consuming one to the least one. The counterpart of this optimisation
+is the reception granularity achievable by the usart driver, from
+one byte up to RX_BUF_P.
+
 Note: Each usart controller should have an alias correctly numbered
 in "aliases" node.
 
-- 
1.9.1
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
