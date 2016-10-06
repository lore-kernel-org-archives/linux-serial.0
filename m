From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] serial: stm32: Fix comparisons with undefined register
Date: Thu,  6 Oct 2016 15:42:54 +0200
Message-ID: <1475761374-13576-1-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, Gerald Baeza <gerald.baeza@st.com>
Cc: linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>
List-Id: linux-serial@vger.kernel.org

    drivers/tty/serial/stm32-usart.c: In function ‘stm32_receive_chars’:
    drivers/tty/serial/stm32-usart.c:130: warning: comparison is always true due to limited range of data type
    drivers/tty/serial/stm32-usart.c: In function ‘stm32_tx_dma_complete’:
    drivers/tty/serial/stm32-usart.c:177: warning: comparison is always false due to limited range of data type

stm32_usart_offsets.icr is u8, while UNDEF_REG = ~0 is int, and thus
0xffffffff.

As all registers in stm32_usart_offsets are u8, change the definition of
UNDEF_REG to 0xff to fix this.

Fixes: ada8618ff3bfe183 ("serial: stm32: adding support for stm32f7")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
Untested due to lack of hardware.
---
 drivers/tty/serial/stm32-usart.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/stm32-usart.h b/drivers/tty/serial/stm32-usart.h
index 41d97492310271db..cd97ceb76e4ffe6f 100644
--- a/drivers/tty/serial/stm32-usart.h
+++ b/drivers/tty/serial/stm32-usart.h
@@ -31,7 +31,7 @@ struct stm32_usart_info {
 	struct stm32_usart_config cfg;
 };
 
-#define UNDEF_REG ~0
+#define UNDEF_REG 0xff
 
 /* Register offsets */
 struct stm32_usart_info stm32f4_info = {
-- 
1.9.1
