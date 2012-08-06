From: Ying Xue <ying.xue@windriver.com>
Subject: [PATCH] USB: ftdi_sio: Quiet sparse noise about using plain integer was NULL pointer
Date: Mon, 6 Aug 2012 17:46:37 +0800
Message-ID: <1344246397-1604-1-git-send-email-ying.xue@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Pointers should not be compared to plain integers.
Quiets the sparse warning:
warning: Using plain integer as NULL pointer

Signed-off-by: Ying Xue <ying.xue@windriver.com>
---
 drivers/usb/serial/ftdi_sio.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.c
index bc912e5..70688cb 100644
--- a/drivers/usb/serial/ftdi_sio.c
+++ b/drivers/usb/serial/ftdi_sio.c
@@ -2106,7 +2106,7 @@ static void ftdi_set_termios(struct tty_struct *tty,
 
 	cflag = termios->c_cflag;
 
-	if (old_termios == 0)
+	if (!old_termios)
 		goto no_skip;
 
 	if (old_termios->c_cflag == termios->c_cflag
-- 
1.6.2.3
