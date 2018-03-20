From: Daniel Kurtz <djkurtz@chromium.org>
Subject: [PATCH v2 1/2] serial: sh-sci: Remove __initdata attribute for struct 'port_cfg'
Date: Tue, 20 Mar 2018 11:57:11 -0600
Message-ID: <20180320175712.201572-2-djkurtz@chromium.org>
References: <20180320175712.201572-1-djkurtz@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180320175712.201572-1-djkurtz@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Matthias Kaehlcke <mka@chromium.org>, Guenter Roeck <groeck@chromium.org>
Cc: adurbin@chromium.org, linux-kernel@vger.kernel.org, Daniel Kurtz <djkurtz@chromium.org>, Jiri Slaby <jslaby@suse.com>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Commit dd076cffb8cd ("serial: sh-sci: Fix init data attribute for struct
'port_cfg'") properly removed the __init attribute, and changed it to
__initdata.

The __init function early_console_setup() takes the address of global
port_cfg and assigns it to a field in another global, sci_ports:

static int __init early_console_setup(struct earlycon_device *device,
      int type)
{
...
port_cfg.type = type;
sci_ports[0].cfg = &port_cfg;
...
}

port_cfg, however, is now in __initdata:
static struct plat_sci_port port_cfg __initdata;

... but sci_ports is not:
static struct sci_port sci_ports[SCI_NPORTS];

Thus, there is a non-__initdata variable containing the address of a
__initdata struct.

Fix this section type conflict by just removing the __initdata attribute.

Fixes: dd076cffb8cd ("serial: sh-sci: Fix init data attribute for struct 'port_cfg'")
Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
---
 drivers/tty/serial/sh-sci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 44adf9db38f8..ff4e1012ed76 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -3277,7 +3277,7 @@ early_platform_init_buffer("earlyprintk", &sci_driver,
 			   early_serial_buf, ARRAY_SIZE(early_serial_buf));
 #endif
 #ifdef CONFIG_SERIAL_SH_SCI_EARLYCON
-static struct plat_sci_port port_cfg __initdata;
+static struct plat_sci_port port_cfg;
 
 static int __init early_console_setup(struct earlycon_device *device,
 				      int type)
-- 
2.16.2.804.g6dcf76e118-goog
