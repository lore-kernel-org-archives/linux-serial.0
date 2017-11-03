From: Johan Hovold <johan@kernel.org>
Subject: [PATCH 7/8] serdev: ttyport: ignore carrier detect to avoid hangups
Date: Fri,  3 Nov 2017 15:30:58 +0100
Message-ID: <20171103143059.20749-8-johan@kernel.org>
References: <20171103143059.20749-1-johan@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171103143059.20749-1-johan@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
List-Id: linux-serial@vger.kernel.org

Serdev currently does not support hangups so make sure to set CLOCAL to
prevent loss of carrier from triggering one.

Note however that not all tty drivers honour CLOCAL.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/tty/serdev/serdev-ttyport.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/serdev/serdev-ttyport.c b/drivers/tty/serdev/serdev-ttyport.c
index a8ddcd2ac5ea..727664ef456c 100644
--- a/drivers/tty/serdev/serdev-ttyport.c
+++ b/drivers/tty/serdev/serdev-ttyport.c
@@ -141,6 +141,8 @@ static int ttyport_open(struct serdev_controller *ctrl)
 	ktermios.c_cflag &= ~(CSIZE | PARENB);
 	ktermios.c_cflag |= CS8;
 	ktermios.c_cflag |= CRTSCTS;
+	/* Hangups are not supported so make sure to ignore carrier detect. */
+	ktermios.c_cflag |= CLOCAL;
 	tty_set_termios(tty, &ktermios);
 
 	set_bit(SERPORT_ACTIVE, &serport->flags);
-- 
2.15.0
