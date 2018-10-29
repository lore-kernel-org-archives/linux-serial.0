From: Douglas Anderson <dianders@chromium.org>
Subject: [PATCH 3/7] serial: qcom_geni_serial: Process sysrq at port unlock time
Date: Mon, 29 Oct 2018 11:07:03 -0700
Message-ID: <20181029180707.207546-4-dianders@chromium.org>
References: <20181029180707.207546-1-dianders@chromium.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181029180707.207546-1-dianders@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jason Wessel <jason.wessel@windriver.com>, Daniel Thompson <daniel.thompson@linaro.org>, tglx@linutronix.de, mingo@kernel.org, gregkh@linuxfoundation.org
Cc: linux-arm-msm@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net, Douglas Anderson <dianders@chromium.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, jslaby@suse.com
List-Id: linux-serial@vger.kernel.org

Let's take advantage of the new ("serial: core: Allow processing sysrq
at port unlock time") to handle sysrqs more cleanly.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/tty/serial/qcom_geni_serial.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 3c8e0202da8b..20edce1e222e 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -499,9 +499,7 @@ static int handle_rx_console(struct uart_port *uport, u32 bytes, bool drop)
 					continue;
 			}
 
-			spin_unlock(&uport->lock);
-			sysrq = uart_handle_sysrq_char(uport, buf[c]);
-			spin_lock(&uport->lock);
+			sysrq = uart_prepare_sysrq_char(uport, buf[c]);
 
 			if (!sysrq)
 				tty_insert_flip_char(tport, buf[c], TTY_NORMAL);
@@ -811,7 +809,8 @@ static irqreturn_t qcom_geni_serial_isr(int isr, void *dev)
 		qcom_geni_serial_handle_rx(uport, drop_rx);
 
 out_unlock:
-	spin_unlock_irqrestore(&uport->lock, flags);
+	uart_unlock_and_check_sysrq(uport, flags);
+
 	return IRQ_HANDLED;
 }
 
-- 
2.19.1.568.g152ad8e336-goog
