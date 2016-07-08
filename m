From: Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH v3 3/3] tty: amba-pl011: probe ZTE device from AMBA bus with a
 pseudo-ID
Date: Fri,  8 Jul 2016 17:00:41 +0800
Message-ID: <1467968441-4056-4-git-send-email-shawn.guo@linaro.org>
References: <1467968441-4056-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1467968441-4056-1-git-send-email-shawn.guo@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King <linux@armlinux.org.uk>
Cc: Peter Hurley <peter@hurleysoftware.com>, Jason Liu <jason.liu@linaro.org>, Andre Przywara <andre.przywara@arm.com>, Timur Tabi <timur@codeaurora.org>, xie.baoyou@zte.com.cn, Russell King <rmk+kernel@armlinux.org.uk>, linux-serial@vger.kernel.org, Jun Nie <jun.nie@linaro.org>, Shawn Guo <shawn.guo@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

There is no Peripheral Identification Registers on ZTE PL011 device, so
although the driver amba-pl011 is ready to work for ZTE device, the
device cannot be probed by the driver at all.

With arm,primecell-periphid DT bindings (bindings/arm/primecell.txt) in
place, it should be the cleanest the way to use a pseudo-ID to probe the
device from AMBA bus.  We create an unofficial vendor number
AMBA_VENDOR_LINUX, which will practically never become an official
vendor ID, and takes Configuration, Revision number, and Part number as
input to compose a pseudo-ID for ZTE device.

Also, since we start using vendor_zte to probe ZTE device, the
__maybe_unused for vendor_zte is removed.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/tty/serial/amba-pl011.c | 7 ++++++-
 include/linux/amba/bus.h        | 6 ++++++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 8b7fb3689ee7..6b349af7fadf 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -209,7 +209,7 @@ static unsigned int get_fifosize_zte(struct amba_device *dev)
 	return 16;
 }
 
-static struct vendor_data vendor_zte __maybe_unused = {
+static struct vendor_data vendor_zte = {
 	.reg_offset		= pl011_zte_offsets,
 	.access_32b		= true,
 	.ifls			= UART011_IFLS_RX4_8|UART011_IFLS_TX4_8,
@@ -2646,6 +2646,11 @@ static struct amba_id pl011_ids[] = {
 		.mask	= 0x00ffffff,
 		.data	= &vendor_st,
 	},
+	{
+		.id	= AMBA_LINUX_ID(0x00, 0x1, 0xffe),
+		.mask	= 0x00ffffff,
+		.data	= &vendor_zte,
+	},
 	{ 0, 0 },
 };
 
diff --git a/include/linux/amba/bus.h b/include/linux/amba/bus.h
index 3d8dcdd1aeae..d143c13bed26 100644
--- a/include/linux/amba/bus.h
+++ b/include/linux/amba/bus.h
@@ -53,8 +53,14 @@ enum amba_vendor {
 	AMBA_VENDOR_ST = 0x80,
 	AMBA_VENDOR_QCOM = 0x51,
 	AMBA_VENDOR_LSI = 0xb6,
+	AMBA_VENDOR_LINUX = 0xfe,	/* This value is not official */
 };
 
+/* This is used to generate pseudo-ID for AMBA device */
+#define AMBA_LINUX_ID(conf, rev, part) \
+	(((conf) & 0xff) << 24 | ((rev) & 0xf) << 20 | \
+	AMBA_VENDOR_LINUX << 12 | ((part) & 0xfff))
+
 extern struct bus_type amba_bustype;
 
 #define to_amba_device(d)	container_of(d, struct amba_device, dev)
-- 
1.9.1
