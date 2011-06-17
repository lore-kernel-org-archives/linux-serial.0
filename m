From: Uwe Bonnes <bon-1JbLm1bU5j5ZIx36JBfelj3+ndqKAYMe9FMPySWZwLkb1SvskN2V4Q@public.gmane.org>
Subject: Add new FT232H chip to drivers/usb/serial
Date: Fri, 17 Jun 2011 16:05:52 +0200
Message-ID: <19963.24384.862038.745906@elektron.ikp.physik.tu-darmstadt.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

Hello,

appended patch adds support for the new FTDI FT232H chip. This chip is a
single channel version of the dual FT2232H/quad FT4232H, coming with it's
own default PID 0x6014 (FT2232H uses the same PID 0x6010 like FT2232C,
FT4232H has also it's own PID). 

The patch was checked on an UM232H module and a terminal program with TX/RX
shorted to that typing in the terminal reproduced the characters. The patch
was written against the running  2.6.37.6 kernel, but applies to git-head
without errors.

Please review and let me know(CC) of any problems.

-- 
Uwe Bonnes                bon-1JbLm1bU5j5ZIx36JBfelj3+ndqKAYMe9FMPySWZwLkb1SvskN2V4Q@public.gmane.org

Institut fuer Kernphysik  Schlossgartenstrasse 9  64289 Darmstadt
--------- Tel. 06151 162516 -------- Fax. 06151 164321 ----------
>From 8a6a023dfc616a53bb1dd9b989d01276499ce6a4 Mon Sep 17 00:00:00 2001
From: Uwe Bonnes <bon-1JbLm1bU5j5ZIx36JBfelj3+ndqKAYMe9FMPySWZwLkb1SvskN2V4Q@public.gmane.org>
Date: Fri, 17 Jun 2011 15:59:07 +0200
Subject: Add new FT232H chip

---
 drivers/usb/serial/ftdi_sio.c     |   19 ++++++++++++++-----
 drivers/usb/serial/ftdi_sio.h     |    3 ++-
 drivers/usb/serial/ftdi_sio_ids.h |    1 +
 3 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.c
index 1627289..2e06b90 100644
--- a/drivers/usb/serial/ftdi_sio.c
+++ b/drivers/usb/serial/ftdi_sio.c
@@ -179,6 +179,7 @@ static struct usb_device_id id_table_combined [] = {
 	{ USB_DEVICE(FTDI_VID, FTDI_232RL_PID) },
 	{ USB_DEVICE(FTDI_VID, FTDI_8U2232C_PID) },
 	{ USB_DEVICE(FTDI_VID, FTDI_4232H_PID) },
+	{ USB_DEVICE(FTDI_VID, FTDI_232H_PID) },
 	{ USB_DEVICE(FTDI_VID, FTDI_MICRO_CHAMELEON_PID) },
 	{ USB_DEVICE(FTDI_VID, FTDI_RELAIS_PID) },
 	{ USB_DEVICE(FTDI_VID, FTDI_OPENDCC_PID) },
@@ -848,7 +849,8 @@ static const char *ftdi_chip_name[] = {
 	[FT2232C] = "FT2232C",
 	[FT232RL] = "FT232RL",
 	[FT2232H] = "FT2232H",
-	[FT4232H] = "FT4232H"
+	[FT4232H] = "FT4232H",
+	[FT232H]  = "FT232H"
 };
 
 
@@ -1168,6 +1170,7 @@ static __u32 get_ftdi_divisor(struct tty_struct *tty,
 		break;
 	case FT2232H: /* FT2232H chip */
 	case FT4232H: /* FT4232H chip */
+	case FT232H:  /* FT232H chip */
 		if ((baud <= 12000000) & (baud >= 1200)) {
 			div_value = ftdi_2232h_baud_to_divisor(baud);
 		} else if (baud < 1200) {
@@ -1429,9 +1432,12 @@ static void ftdi_determine_type(struct usb_serial_port *port)
 	} else if (version < 0x600) {
 		/* Assume it's an FT232BM (or FT245BM) */
 		priv->chip_type = FT232BM;
-	} else {
-		/* Assume it's an FT232R */
+	} else if (version < 0x900) {
+		/* Assume it's an FT232RL */
 		priv->chip_type = FT232RL;
+	} else {
+		/* Assume it's an FT232H */
+		priv->chip_type = FT232H;
 	}
 	dev_info(&udev->dev, "Detected %s\n", ftdi_chip_name[priv->chip_type]);
 }
@@ -1559,7 +1565,8 @@ static int create_sysfs_attrs(struct usb_serial_port *port)
 		     priv->chip_type == FT2232C ||
 		     priv->chip_type == FT232RL ||
 		     priv->chip_type == FT2232H ||
-		     priv->chip_type == FT4232H)) {
+		     priv->chip_type == FT4232H ||
+		     priv->chip_type == FT232H)) {
 			retval = device_create_file(&port->dev,
 						    &dev_attr_latency_timer);
 		}
@@ -1580,7 +1587,8 @@ static void remove_sysfs_attrs(struct usb_serial_port *port)
 		    priv->chip_type == FT2232C ||
 		    priv->chip_type == FT232RL ||
 		    priv->chip_type == FT2232H ||
-		    priv->chip_type == FT4232H) {
+		    priv->chip_type == FT4232H ||
+                    priv->chip_type == FT232H) {
 			device_remove_file(&port->dev, &dev_attr_latency_timer);
 		}
 	}
@@ -2212,6 +2220,7 @@ static int ftdi_tiocmget(struct tty_struct *tty)
 	case FT232RL:
 	case FT2232H:
 	case FT4232H:
+	case FT232H:
 		len = 2;
 		break;
 	default:
diff --git a/drivers/usb/serial/ftdi_sio.h b/drivers/usb/serial/ftdi_sio.h
index 213fe3d..19584fa 100644
--- a/drivers/usb/serial/ftdi_sio.h
+++ b/drivers/usb/serial/ftdi_sio.h
@@ -156,7 +156,8 @@ enum ftdi_chip_type {
 	FT2232C = 4,
 	FT232RL = 5,
 	FT2232H = 6,
-	FT4232H = 7
+	FT4232H = 7,
+	FT232H  = 8
 };
 
 enum ftdi_sio_baudrate {
diff --git a/drivers/usb/serial/ftdi_sio_ids.h b/drivers/usb/serial/ftdi_sio_ids.h
index ab1fcdf..19156d1 100644
--- a/drivers/usb/serial/ftdi_sio_ids.h
+++ b/drivers/usb/serial/ftdi_sio_ids.h
@@ -22,6 +22,7 @@
 #define FTDI_8U232AM_ALT_PID 0x6006 /* FTDI's alternate PID for above */
 #define FTDI_8U2232C_PID 0x6010 /* Dual channel device */
 #define FTDI_4232H_PID 0x6011 /* Quad channel hi-speed device */
+#define FTDI_232H_PID  0x6014 /* Single channel hi-speed device */
 #define FTDI_SIO_PID	0x8372	/* Product Id SIO application of 8U100AX */
 #define FTDI_232RL_PID  0xFBFA  /* Product ID for FT232RL */
 
-- 
1.7.3.4

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
