From: Colin King <colin.king@canonical.com>
Subject: [PATCH] tty: serial: jsm: remove redundant pointer ts
Date: Tue,  7 Nov 2017 11:41:07 +0000
Message-ID: <20171107114107.22805-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
Sender: kernel-janitors-owner@vger.kernel.org
To: "Guilherme G . Piccoli" <gpiccoli@linux.vnet.ibm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Pointer ts is assigned a value that is never read, ts is therefore
redundant and can be removed. Cleans up clang warning:

drivers/tty/serial/jsm/jsm_tty.c:285:2: warning: Value stored to 'ts'
is never read

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/tty/serial/jsm/jsm_tty.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/tty/serial/jsm/jsm_tty.c b/drivers/tty/serial/jsm/jsm_tty.c
index e69227cc3827..5ecd878669b8 100644
--- a/drivers/tty/serial/jsm/jsm_tty.c
+++ b/drivers/tty/serial/jsm/jsm_tty.c
@@ -275,14 +275,12 @@ static int jsm_tty_open(struct uart_port *port)
 static void jsm_tty_close(struct uart_port *port)
 {
 	struct jsm_board *bd;
-	struct ktermios *ts;
 	struct jsm_channel *channel =
 		container_of(port, struct jsm_channel, uart_port);
 
 	jsm_dbg(CLOSE, &channel->ch_bd->pci_dev, "start\n");
 
 	bd = channel->ch_bd;
-	ts = &port->state->port.tty->termios;
 
 	channel->ch_flags &= ~(CH_STOPI);
 
-- 
2.14.1

