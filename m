From: Jeffy Chen <jeffy.chen@rock-chips.com>
Subject: [PATCH v1] serial: core: support more baud rates when serial console setup
Date: Wed,  9 Dec 2015 15:07:58 +0800
Message-ID: <1449644878-25508-1-git-send-email-jeffy.chen@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, jslaby@suse.com, gregkh@linuxfoundation.org
Cc: rockchip-discuss@chromium.org, Jeffy Chen <jeffy.chen@rock-chips.com>
List-Id: linux-serial@vger.kernel.org

Currently, when tring to set up a serial console with a higher
baud rate, it would fallback to 921600.

So, add more baud rates to the baud rate array.

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>

---

 drivers/tty/serial/serial_core.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index def5199..7da1b7e 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -1898,6 +1898,16 @@ struct baud_rates {
 };
 
 static const struct baud_rates baud_rates[] = {
+#ifndef __sparc__
+	{ 4000000, B4000000 },
+	{ 3500000, B3500000 },
+	{ 3000000, B3000000 },
+	{ 2500000, B2500000 },
+	{ 2000000, B2000000 },
+	{ 1500000, B1500000 },
+	{ 1152000, B1152000 },
+	{ 1000000, B1000000 },
+#endif
 	{ 921600, B921600 },
 	{ 460800, B460800 },
 	{ 230400, B230400 },
-- 
2.1.4
