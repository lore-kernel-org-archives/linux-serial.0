From: Hariprasad Kelam <hariprasad.kelam@gmail.com>
Subject: [PATCH] tty: serial_core: Spelling correction
Date: Fri, 22 Mar 2019 08:31:59 +0530
Message-ID: <20190322030159.GA6551@hari-Inspiron-1545>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

fix spelling mistake "overriden" -> "overridden"
This fix resolves warning reported by checkpatch tool

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 drivers/tty/serial/serial_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 351843f..69f4871 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -1514,7 +1514,7 @@ static void uart_set_termios(struct tty_struct *tty,
 	}
 
 	uart_change_speed(tty, state, old_termios);
-	/* reload cflag from termios; port driver may have overriden flags */
+	/* reload cflag from termios; port driver may have overridden flags */
 	cflag = tty->termios.c_cflag;
 
 	/* Handle transition to B0 status */
-- 
2.7.4
