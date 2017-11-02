From: Colin King <colin.king@canonical.com>
Subject: [PATCH] tty: max3100: remove unused variable rts and remove unused assignment
Date: Thu,  2 Nov 2017 14:01:44 +0000
Message-ID: <20171102140144.21514-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Variable rts is being assigned but it is never read, hence it can be
removed.  The assignment to param_new to zero is redundant as it is
being updates a few statements later, so remove this redundant
assignment. Cleans up two clang warnings:

drivers/tty/serial/max3100.c:277:3: warning: Value stored to 'rts'
is never read
drivers/tty/serial/max3100.c:439:2: warning: Value stored to 'param_new'
is never read

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/tty/serial/max3100.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/tty/serial/max3100.c b/drivers/tty/serial/max3100.c
index b6b3453e8c1f..f691f3cdb5b1 100644
--- a/drivers/tty/serial/max3100.c
+++ b/drivers/tty/serial/max3100.c
@@ -263,7 +263,7 @@ static void max3100_work(struct work_struct *w)
 	struct max3100_port *s = container_of(w, struct max3100_port, work);
 	int rxchars;
 	u16 tx, rx;
-	int conf, cconf, rts, crts;
+	int conf, cconf, crts;
 	struct circ_buf *xmit = &s->port.state->xmit;
 
 	dev_dbg(&s->spi->dev, "%s\n", __func__);
@@ -274,7 +274,6 @@ static void max3100_work(struct work_struct *w)
 		conf = s->conf;
 		cconf = s->conf_commit;
 		s->conf_commit = 0;
-		rts = s->rts;
 		crts = s->rts_commit;
 		s->rts_commit = 0;
 		spin_unlock(&s->conf_lock);
@@ -436,7 +435,6 @@ max3100_set_termios(struct uart_port *port, struct ktermios *termios,
 	dev_dbg(&s->spi->dev, "%s\n", __func__);
 
 	cflag = termios->c_cflag;
-	param_new = 0;
 	param_mask = 0;
 
 	baud = tty_termios_baud_rate(termios);
-- 
2.14.1
