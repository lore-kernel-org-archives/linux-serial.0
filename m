From: Kees Cook <keescook@chromium.org>
Subject: [PATCH] serial: sccnxp: Convert timers to use timer_setup()
Date: Tue, 24 Oct 2017 02:59:49 -0700
Message-ID: <20171024095949.GA67852@beast>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

In preparation for unconditionally passing the struct timer_list pointer to
all timer callbacks, switch to using the new timer_setup() and from_timer()
to pass the timer pointer explicitly.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: linux-serial@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/tty/serial/sccnxp.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/sccnxp.c b/drivers/tty/serial/sccnxp.c
index b9c7a904c1ea..ba43ed159b6a 100644
--- a/drivers/tty/serial/sccnxp.c
+++ b/drivers/tty/serial/sccnxp.c
@@ -465,9 +465,9 @@ static void sccnxp_handle_events(struct sccnxp_port *s)
 	} while (1);
 }
 
-static void sccnxp_timer(unsigned long data)
+static void sccnxp_timer(struct timer_list *t)
 {
-	struct sccnxp_port *s = (struct sccnxp_port *)data;
+	struct sccnxp_port *s = from_timer(s, t, timer);
 	unsigned long flags;
 
 	spin_lock_irqsave(&s->lock, flags);
@@ -987,8 +987,7 @@ static int sccnxp_probe(struct platform_device *pdev)
 
 		dev_err(&pdev->dev, "Unable to reguest IRQ %i\n", s->irq);
 	} else {
-		init_timer(&s->timer);
-		setup_timer(&s->timer, sccnxp_timer, (unsigned long)s);
+		timer_setup(&s->timer, sccnxp_timer, 0);
 		mod_timer(&s->timer, jiffies +
 			  usecs_to_jiffies(s->pdata.poll_time_us));
 		return 0;
-- 
2.7.4


-- 
Kees Cook
Pixel Security
