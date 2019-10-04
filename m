From: Stefan-gabriel Mirea <stefan-gabriel.mirea@nxp.com>
Subject: [PATCH] tty: serial: Fix PORT_LINFLEXUART definition
Date: Fri, 4 Oct 2019 13:51:13 +0000
Message-ID: <20191004135058.18007-1-stefan-gabriel.mirea@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "jslaby@suse.com" <jslaby@suse.com>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

The port type macros should have different values for different devices.
Currently, PORT_LINFLEXUART conflicts with PORT_SUNIX.

Fixes: 09864c1cdf5c ("tty: serial: Add linflexuart driver for S32V234")
Signed-off-by: Stefan-Gabriel Mirea <stefan-gabriel.mirea@nxp.com>
---
 include/uapi/linux/serial_core.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/serial_core.h b/include/uapi/linux/serial_c=
ore.h
index 0f4f87a6fd54..e7fe550b6038 100644
--- a/include/uapi/linux/serial_core.h
+++ b/include/uapi/linux/serial_core.h
@@ -291,6 +291,6 @@
 #define PORT_SUNIX	121
=20
 /* Freescale Linflex UART */
-#define PORT_LINFLEXUART	121
+#define PORT_LINFLEXUART	122
=20
 #endif /* _UAPILINUX_SERIAL_CORE_H */
--=20
2.22.0
