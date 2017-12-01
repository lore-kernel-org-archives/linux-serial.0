From: Ludovic Barre <ludovic.Barre@st.com>
Subject: [PATCH  2/2] serial: stm32: fix name conflict with 8250
Date: Fri, 1 Dec 2017 17:36:51 +0100
Message-ID: <1512146211-29086-3-git-send-email-ludovic.Barre@st.com>
References: <1512146211-29086-1-git-send-email-ludovic.Barre@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1512146211-29086-1-git-send-email-ludovic.Barre@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Rob Herring <robh+dt@kernel.org>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, Ludovic Barre <ludovic.barre@st.com>
List-Id: linux-serial@vger.kernel.org

From: Ludovic Barre <ludovic.barre@st.com>

This patch replaces stm32 tty name ttyS by ttySTM
to avoid a name conflict when Serial: 8250/16550 driver
is activated.

sysfs: cannot create duplicate filename '/class/tty/ttyS3'
Modules linked in:
CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.14.0-12903-gb392521-dirty #1
[<c03118dc>] (unwind_backtrace) from [<c030c950>] (show_stack+0x10/0x14)
[<c030c950>] (show_stack) from [<c0d31e18>] (dump_stack+0x90/0xa4)
[<c0d31e18>] (dump_stack) from [<c03430a0>] (__warn+0xf8/0x110)
[<c03430a0>] (__warn) from [<c03430f0>] (warn_slowpath_fmt+0x38/0x48)
[<c03430f0>] (warn_slowpath_fmt) from [<c04ce574>] (sysfs_warn_dup+0x68/0x78)
[<c04ce574>] (sysfs_warn_dup) from [<c04ce824>] (sysfs_do_create_link_sd+0xb4/0xc4)
[<c04ce824>] (sysfs_do_create_link_sd) from [<c08c60ec>] (device_add+0x204/0x574)
[<c08c60ec>] (device_add) from [<c07a7ddc>] (tty_register_device_attr+0xc8/0x1bc)
[<c07a7ddc>] (tty_register_device_attr) from [<c07c6530>] (uart_add_one_port+0x22c/0x4f4)

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 drivers/tty/serial/stm32-usart.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/stm32-usart.h b/drivers/tty/serial/stm32-usart.h
index 8a5ff54..2294d0f 100644
--- a/drivers/tty/serial/stm32-usart.h
+++ b/drivers/tty/serial/stm32-usart.h
@@ -236,7 +236,7 @@ struct stm32_usart_info stm32h7_info = {
 #define USART_ICR_CMCF		BIT(17)		/* F7 */
 #define USART_ICR_WUCF		BIT(20)		/* H7 */
 
-#define STM32_SERIAL_NAME "ttyS"
+#define STM32_SERIAL_NAME "ttySTM"
 #define STM32_MAX_PORTS 8
 
 #define RX_BUF_L 200		 /* dma rx buffer length     */
-- 
2.7.4
