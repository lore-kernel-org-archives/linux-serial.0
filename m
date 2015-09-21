From: Sudeep Holla <sudeep.holla@arm.com>
Subject: [PATCH 10/17] tty/serial: st-asc: drop the use of IRQF_NO_SUSPEND
Date: Mon, 21 Sep 2015 16:47:06 +0100
Message-ID: <1442850433-5903-11-git-send-email-sudeep.holla@arm.com>
References: <1442850433-5903-1-git-send-email-sudeep.holla@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1442850433-5903-1-git-send-email-sudeep.holla@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@arm.com>, Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Srinivas Kandagatla <srinivas.kandagatla@gmail.com>, Maxime Coquelin <maxime.coquelin@st.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-arm-kernel@lists.infradead.org, kernel@stlinux.com, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

These drivers doesn't claim the serial device to be wakeup source. Even
if it is, it needs to use enable_irq_wake or other related PM wakeup
APIs to enable it.

This patch removes yet another misuse of IRQF_NO_SUSPEND.

Cc: Srinivas Kandagatla <srinivas.kandagatla@gmail.com>
Cc: Maxime Coquelin <maxime.coquelin@st.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: kernel@stlinux.com
Cc: linux-serial@vger.kernel.org
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/tty/serial/st-asc.c      | 2 +-
 drivers/tty/serial/stm32-usart.c | 3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/st-asc.c b/drivers/tty/serial/st-asc.c
index d625664ce1b5..2d78cb3627ae 100644
--- a/drivers/tty/serial/st-asc.c
+++ b/drivers/tty/serial/st-asc.c
@@ -430,7 +430,7 @@ static void asc_break_ctl(struct uart_port *port, int break_state)
  */
 static int asc_startup(struct uart_port *port)
 {
-	if (request_irq(port->irq, asc_interrupt, IRQF_NO_SUSPEND,
+	if (request_irq(port->irq, asc_interrupt, 0,
 			asc_port_name(port), port)) {
 		dev_err(port->dev, "cannot allocate irq.\n");
 		return -ENODEV;
diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index e3de9c6d2226..f89d1f79be18 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -322,8 +322,7 @@ static int stm32_startup(struct uart_port *port)
 	u32 val;
 	int ret;
 
-	ret = request_irq(port->irq, stm32_interrupt, IRQF_NO_SUSPEND,
-			  name, port);
+	ret = request_irq(port->irq, stm32_interrupt, 0, name, port);
 	if (ret)
 		return ret;
 
-- 
1.9.1
