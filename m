From: Borut Seljak <borut.seljak@t-2.net>
Subject: [PATCH v4] serial: stm32: fix a recursive locking in stm32_config_rs485
Date: Fri,  7 Jun 2019 12:53:06 +0200
Message-ID: <20190607105307.31053-1-borut.seljak@t-2.net>
References: <e0f8d4b2-a622-3758-473b-b78bd8949323@st.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <e0f8d4b2-a622-3758-473b-b78bd8949323@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: erwan.leray@st.com
Cc: borut.seljak@t-2.net, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, linux-serial@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Remove spin_lock_irqsave in stm32_config_rs485, it cause recursive locking.
Already locked in uart_set_rs485_config.

Fixes: 1bcda09d291081 ("serial: stm32: add support for RS485 hardware control mode")

Signed-off-by: Borut Seljak <borut.seljak@t-2.net>
---
 drivers/tty/serial/stm32-usart.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index e8d7a7bb4339..5d072ec61071 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -105,9 +105,7 @@ static int stm32_config_rs485(struct uart_port *port,
 	struct stm32_usart_config *cfg = &stm32_port->info->cfg;
 	u32 usartdiv, baud, cr1, cr3;
 	bool over8;
-	unsigned long flags;
 
-	spin_lock_irqsave(&port->lock, flags);
 	stm32_clr_bits(port, ofs->cr1, BIT(cfg->uart_enable_bit));
 
 	port->rs485 = *rs485conf;
@@ -147,7 +145,6 @@ static int stm32_config_rs485(struct uart_port *port,
 	}
 
 	stm32_set_bits(port, ofs->cr1, BIT(cfg->uart_enable_bit));
-	spin_unlock_irqrestore(&port->lock, flags);
 
 	return 0;
 }
-- 
2.17.1
