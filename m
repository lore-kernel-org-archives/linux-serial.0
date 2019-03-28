From: Hariprasad Kelam <hariprasad.kelam@gmail.com>
Subject: [PATCH v2] tty:serial_core: Spelling mistake
Date: Thu, 28 Mar 2019 08:47:33 +0530
Message-ID: <20190328031733.GA13375@hari-Inspiron-1545>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

fix spelling mistake "overriden" -> "overridden"

This fix resolves warning reported by checkpatch tool.

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
Changes in V2:
              -Make commit message more clear
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
