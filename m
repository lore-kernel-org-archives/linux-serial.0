From: Bich HEMON <bich.hemon-qxv4g6HH51o@public.gmane.org>
Subject: [PATCH 3/9] serial: stm32: Increase maximum number of ports
Date: Thu, 13 Jul 2017 15:08:27 +0000
Message-ID: <1499958494-19354-4-git-send-email-bich.hemon@st.com>
References: <1499958494-19354-1-git-send-email-bich.hemon@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1499958494-19354-1-git-send-email-bich.hemon-qxv4g6HH51o@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Maxime Coquelin <mcoquelin.stm32-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alexandre TORGUE <alexandre.torgue-qxv4g6HH51o@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, "linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Bich HEMON <bich.hemon-qxv4g6HH51o@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

From: Gerald Baeza <gerald.baeza-qxv4g6HH51o@public.gmane.org>

Increase max number of ports for stm32h7
which supports up to 8 uart and usart instances.

Signed-off-by: Gerald Baeza <gerald.baeza-qxv4g6HH51o@public.gmane.org>
Signed-off-by: Bich Hemon <bich.hemon-qxv4g6HH51o@public.gmane.org>
---
 drivers/tty/serial/stm32-usart.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/stm32-usart.h b/drivers/tty/serial/stm32-usart.h
index 65b4ffa..6092789 100644
--- a/drivers/tty/serial/stm32-usart.h
+++ b/drivers/tty/serial/stm32-usart.h
@@ -206,7 +206,7 @@ struct stm32_usart_info stm32f7_info = {
 #define USART_ICR_CMCF		BIT(17)		/* F7 */
 
 #define STM32_SERIAL_NAME "ttyS"
-#define STM32_MAX_PORTS 6
+#define STM32_MAX_PORTS 8
 
 #define RX_BUF_L 200		 /* dma rx buffer length     */
 #define RX_BUF_P RX_BUF_L	 /* dma rx buffer period     */
-- 
1.9.1
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
