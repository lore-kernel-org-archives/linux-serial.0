From: Erwan Le Ray <erwan.leray@st.com>
Subject: [PATCH 1/7] serial: stm32: fix word length configuration
Date: Tue, 21 May 2019 17:45:41 +0200
Message-ID: <1558453547-22866-2-git-send-email-erwan.leray@st.com>
References: <1558453547-22866-1-git-send-email-erwan.leray@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1558453547-22866-1-git-send-email-erwan.leray@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>
Cc: linux-serial@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Erwan Le Ray <erwan.leray@st.com>, Fabrice Gasnier <fabrice.gasnier@st.com>
List-Id: linux-serial@vger.kernel.org

STM32 supports either:
- 8 and 9 bits word length (including parity bit) for stm32f4 compatible
  devices
- 7, 8 and 9 bits word length (including parity bit) for stm32f7 and
  stm32h7 compatible devices.

As a consequence STM32 supports the following termios configurations:
- CS7 with parity bit, and CS8 (with or without parity bit) for stm32f4
  compatible devices.
- CS6 with parity bit, CS7 and CS8 (with or without parity bit) for
  stm32f7 and stm32h7 compatible devices.

This patch is fixing word length by configuring correctly the SoC with
supported configurations.

Fixes: ada8618ff3bf ("serial: stm32: adding support for stm32f7")
Signed-off-by: Erwan Le Ray <erwan.leray@st.com>

diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index e8d7a7b..e832185 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -599,6 +599,36 @@ static void stm32_shutdown(struct uart_port *port)
 	free_irq(port->irq, port);
 }
 
+unsigned int stm32_get_databits(struct ktermios *termios)
+{
+	unsigned int bits;
+
+	tcflag_t cflag = termios->c_cflag;
+
+	switch (cflag & CSIZE) {
+	/*
+	 * CSIZE settings are not necessarily supported in hardware.
+	 * CSIZE unsupported configurations are handled here to set word length
+	 * to 8 bits word as default configuration and to print debug message.
+	 */
+	case CS5:
+		bits = 5;
+		break;
+	case CS6:
+		bits = 6;
+		break;
+	case CS7:
+		bits = 7;
+		break;
+	/* default including CS8 */
+	default:
+		bits = 8;
+		break;
+	}
+
+	return bits;
+}
+
 static void stm32_set_termios(struct uart_port *port, struct ktermios *termios,
 			    struct ktermios *old)
 {
@@ -606,7 +636,7 @@ static void stm32_set_termios(struct uart_port *port, struct ktermios *termios,
 	struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
 	struct stm32_usart_config *cfg = &stm32_port->info->cfg;
 	struct serial_rs485 *rs485conf = &port->rs485;
-	unsigned int baud;
+	unsigned int baud, bits;
 	u32 usartdiv, mantissa, fraction, oversampling;
 	tcflag_t cflag = termios->c_cflag;
 	u32 cr1, cr2, cr3;
@@ -632,16 +662,28 @@ static void stm32_set_termios(struct uart_port *port, struct ktermios *termios,
 	if (cflag & CSTOPB)
 		cr2 |= USART_CR2_STOP_2B;
 
+	bits = stm32_get_databits(termios);
+
 	if (cflag & PARENB) {
+		bits++;
 		cr1 |= USART_CR1_PCE;
-		if ((cflag & CSIZE) == CS8) {
-			if (cfg->has_7bits_data)
-				cr1 |= USART_CR1_M0;
-			else
-				cr1 |= USART_CR1_M;
-		}
 	}
 
+	/*
+	 * Word length configuration:
+	 * CS8 + parity, 9 bits word aka [M1:M0] = 0b01
+	 * CS7 or (CS6 + parity), 7 bits word aka [M1:M0] = 0b10
+	 * CS8 or (CS7 + parity), 8 bits word aka [M1:M0] = 0b00
+	 * M0 and M1 already cleared by cr1 initialization.
+	 */
+	if (bits == 9)
+		cr1 |= USART_CR1_M0;
+	else if ((bits == 7) && cfg->has_7bits_data)
+		cr1 |= USART_CR1_M1;
+	else if (bits != 8)
+		dev_dbg(port->dev, "Unsupported data bits config: %u bits\n"
+			, bits);
+
 	if (cflag & PARODD)
 		cr1 |= USART_CR1_PS;
 
diff --git a/drivers/tty/serial/stm32-usart.h b/drivers/tty/serial/stm32-usart.h
index 6f294e2..a70aa50 100644
--- a/drivers/tty/serial/stm32-usart.h
+++ b/drivers/tty/serial/stm32-usart.h
@@ -151,8 +151,7 @@ struct stm32_usart_info stm32h7_info = {
 #define USART_CR1_PS		BIT(9)
 #define USART_CR1_PCE		BIT(10)
 #define USART_CR1_WAKE		BIT(11)
-#define USART_CR1_M		BIT(12)
-#define USART_CR1_M0		BIT(12)		/* F7 */
+#define USART_CR1_M0		BIT(12)		/* F7 (CR1_M for F4) */
 #define USART_CR1_MME		BIT(13)		/* F7 */
 #define USART_CR1_CMIE		BIT(14)		/* F7 */
 #define USART_CR1_OVER8		BIT(15)
-- 
1.9.1
