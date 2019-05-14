From: Serge Semin <fancer.lancer@gmail.com>
Subject: [PATCH 2/7] tty: max310x: Introduce max310x_one port macro-wrapper
Date: Tue, 14 May 2019 13:14:10 +0300
Message-ID: <20190514101415.26754-3-fancer.lancer@gmail.com>
References: <20190514101415.26754-1-fancer.lancer@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190514101415.26754-1-fancer.lancer@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: Serge Semin <Sergey.Semin@t-platforms.ru>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

uart_port structure instance is embedded into the max310x_one
super-structure, which is accessed by some of the uart-port callback
methods. In order to improve the callback's code readability lets
define the to_max310x_port() wrapper which just translates the passed
uart_port pointer to the max310x_one one. It is also going to be
handy in future commits.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 drivers/tty/serial/max310x.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index 4ee805862b68..527f1476c24a 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -259,6 +259,8 @@ struct max310x_one {
 	struct work_struct	md_work;
 	struct work_struct	rs_work;
 };
+#define to_max310x_port(_port) \
+	container_of(_port, struct max310x_one, port)
 
 struct max310x_port {
 	struct max310x_devtype	*devtype;
@@ -765,7 +767,7 @@ static void max310x_handle_tx(struct uart_port *port)
 
 static void max310x_start_tx(struct uart_port *port)
 {
-	struct max310x_one *one = container_of(port, struct max310x_one, port);
+	struct max310x_one *one = to_max310x_port(port);
 
 	schedule_work(&one->tx_work);
 }
@@ -858,7 +860,7 @@ static void max310x_md_proc(struct work_struct *ws)
 
 static void max310x_set_mctrl(struct uart_port *port, unsigned int mctrl)
 {
-	struct max310x_one *one = container_of(port, struct max310x_one, port);
+	struct max310x_one *one = to_max310x_port(port);
 
 	schedule_work(&one->md_work);
 }
@@ -981,7 +983,7 @@ static void max310x_rs_proc(struct work_struct *ws)
 static int max310x_rs485_config(struct uart_port *port,
 				struct serial_rs485 *rs485)
 {
-	struct max310x_one *one = container_of(port, struct max310x_one, port);
+	struct max310x_one *one = to_max310x_port(port);
 
 	if ((rs485->delay_rts_before_send > 0x0f) ||
 	    (rs485->delay_rts_after_send > 0x0f))
-- 
2.21.0
