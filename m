From: "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>
Subject: [PATCH V1 1/1] serial: 8250_fintek: Fix finding base_port with activated SuperIO
Date: Tue, 17 Oct 2017 14:23:08 +0800
Message-ID: <1508221388-25001-1-git-send-email-hpeter+linux_kernel@gmail.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: jslaby@suse.com, rel+kernel@agilox.net, stable@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, hpeter+linux_kernel@gmail.com, peter_hong@fintek.com.tw
List-Id: linux-serial@vger.kernel.org

The SuperIO will be configured at boot time by BIOS, but some BIOS
will not deactivate the SuperIO when the end of configuration. It'll
lead to mismatch for pdata->base_port in probe_setup_port(). So we'll
deactivate all SuperIO before activate special base_port in
fintek_8250_enter_key().

Tested on iBASE MI802.

Cc: stable@vger.kernel.org
Tested-by: Ji-Ze Hong (Peter Hong) <hpeter+linux_kernel@gmail.com>
Signed-off-by: Ji-Ze Hong (Peter Hong) <hpeter+linux_kernel@gmail.com>
---
 drivers/tty/serial/8250/8250_fintek.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_fintek.c b/drivers/tty/serial/8250/8250_fintek.c
index 96cc45f25ee9..b34623914413 100644
--- a/drivers/tty/serial/8250/8250_fintek.c
+++ b/drivers/tty/serial/8250/8250_fintek.c
@@ -128,6 +128,9 @@ static int fintek_8250_enter_key(u16 base_port, u8 key)
 	if (!request_muxed_region(base_port, 2, "8250_fintek"))
 		return -EBUSY;
 
+	/* Force to deactive all SuperIO in this base_port */
+	outb(EXIT_KEY, base_port + ADDR_PORT);
+
 	outb(key, base_port + ADDR_PORT);
 	outb(key, base_port + ADDR_PORT);
 	return 0;
-- 
2.7.4
