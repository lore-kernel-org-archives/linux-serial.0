From: Douglas Anderson <dianders@chromium.org>
Subject: [PATCH v2 3/5] serial: qcom_geni_serial: Process sysrq at port unlock
 time
Date: Tue, 30 Oct 2018 15:11:05 -0700
Message-ID: <20181030221107.79758-4-dianders@chromium.org>
References: <20181030221107.79758-1-dianders@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20181030221107.79758-1-dianders@chromium.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: dan.carpenter@oracle.com, vigneshr@ti.com, linux-aspeed@lists.ozlabs.org, andrew@aj.id.au, linux-arm-msm@vger.kernel.org, Douglas Anderson <dianders@chromium.org>, tony@atomide.com, joel@jms.id.au, linux-serial@vger.kernel.org, andriy.shevchenko@linux.intel.com, linux-arm-kernel@lists.infradead.org, jk@ozlabs.org
List-Id: linux-serial@vger.kernel.org

Let's take advantage of the new ("serial: core: Allow processing sysrq
at port unlock time") to handle sysrqs more cleanly.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/tty/serial/qcom_geni_serial.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index b83e3554bced..29ddc1fc65f8 100644
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
