From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH 4/7] tty: serial: replace del_timer by del_timer_sync
Date: Wed, 26 Mar 2014 22:33:42 +0100
Message-ID: <1395869625-15209-5-git-send-email-Julia.Lawall@lip6.fr>
References: <1395869625-15209-1-git-send-email-Julia.Lawall@lip6.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1395869625-15209-1-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: kernel-janitors@vger.kernel.org, tglx@linutronix.de, Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

From: Julia Lawall <Julia.Lawall@lip6.fr>

Use del_timer_sync to ensure that the timer is stopped on all CPUs before
the driver exists.

This change was suggested by Thomas Gleixner.

The semantic patch that makes this change is as follows:
(http://coccinelle.lip6.fr/)

// <smpl>
@r@
declarer name module_exit;
identifier ex;
@@

module_exit(ex);

@@
identifier r.ex;
@@

ex(...) {
  <...
- del_timer
+ del_timer_sync
    (...)
  ...>
}
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
Not tested.

 drivers/tty/serial/mux.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/mux.c b/drivers/tty/serial/mux.c
index 7fd6aaa..19845e3 100644
--- a/drivers/tty/serial/mux.c
+++ b/drivers/tty/serial/mux.c
@@ -613,7 +613,7 @@ static void __exit mux_exit(void)
 {
 	/* Delete the Mux timer. */
 	if(port_cnt > 0) {
-		del_timer(&mux_timer);
+		del_timer_sync(&mux_timer);
 #ifdef CONFIG_SERIAL_MUX_CONSOLE
 		unregister_console(&mux_console);
 #endif
