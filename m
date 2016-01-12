From: Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 3/3] TTY: serial/mpsc, remove unused fields
Date: Tue, 12 Jan 2016 10:49:34 +0100
Message-ID: <1452592174-24805-3-git-send-email-jslaby@suse.cz>
References: <1452592174-24805-1-git-send-email-jslaby@suse.cz>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1452592174-24805-1-git-send-email-jslaby@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>
List-Id: linux-serial@vger.kernel.org

c_iflag and c_cflag are set, but unused. Remove.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/serial/mpsc.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/tty/serial/mpsc.c b/drivers/tty/serial/mpsc.c
index 44a23113f469..4a3021bcc859 100644
--- a/drivers/tty/serial/mpsc.c
+++ b/drivers/tty/serial/mpsc.c
@@ -137,8 +137,6 @@ struct mpsc_port_info {
 	/* Internal driver state for this ctlr */
 	u8 ready;
 	u8 rcv_data;
-	tcflag_t c_iflag;	/* save termios->c_iflag */
-	tcflag_t c_cflag;	/* save termios->c_cflag */
 
 	/* Info passed in from platform */
 	u8 mirror_regs;		/* Need to mirror regs? */
@@ -1407,9 +1405,6 @@ static void mpsc_set_termios(struct uart_port *port, struct ktermios *termios,
 	ulong flags;
 	u32 chr_bits, stop_bits, par;
 
-	pi->c_iflag = termios->c_iflag;
-	pi->c_cflag = termios->c_cflag;
-
 	switch (termios->c_cflag & CSIZE) {
 	case CS5:
 		chr_bits = MPSC_MPCR_CL_5;
-- 
2.7.0
