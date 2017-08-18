From: Stuart Longland <stuartl-EoQOJlg3kTYQrrorzV6ljw@public.gmane.org>
Subject: [PATCH] USB: serial: ti_usb_3410_5052: Port uart_mode from io_ti.
Date: Fri, 18 Aug 2017 12:56:59 +1000
Message-ID: <20170818025659.4402-1-stuartl@vrt.com.au>
References: <4a469222-d48d-f498-f2db-ca582295adc3@longlandclan.id.au>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4a469222-d48d-f498-f2db-ca582295adc3-3e+Fe6x+DsgJbe36r25VNhCuuivNXqWP@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alborchers-2TsfIrYsZRL7O9PZeWXHPg@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Stuart Longland <stuartl-EoQOJlg3kTYQrrorzV6ljw@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

This introduces the `uart_mode` sysfs attribute as seen in the `io_ti`
USB serial driver, allowing this USB serial interface to be switched
between RS-232, 2-wire RS-485 and 4-wire RS-485.

/sys/class/tty/ttyUSB${num}/device/uart takes a single integer:

	0:	RS-232 mode (default for RS-232-compatible dongles)
	1:	RS-485 2w mode (default for RS-485-only dongles)
	2:	RS-485 4w mode / RS-422 mode

Write this *before* opening your serial device.

This has been successfully tested on a Moxa UPort 1150 in 4-wire RS-485
mode.

Signed-off-by: Stuart Longland <stuartl-EoQOJlg3kTYQrrorzV6ljw@public.gmane.org>
---
 drivers/usb/serial/ti_usb_3410_5052.c | 48 +++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/drivers/usb/serial/ti_usb_3410_5052.c b/drivers/usb/serial/ti_usb_3410_5052.c
index 8fc3854e5e69..fb30d7ff32d7 100644
--- a/drivers/usb/serial/ti_usb_3410_5052.c
+++ b/drivers/usb/serial/ti_usb_3410_5052.c
@@ -514,6 +514,46 @@ MODULE_DEVICE_TABLE(usb, ti_id_table_combined);
 
 module_usb_serial_driver(serial_drivers, ti_id_table_combined);
 
+/* Sysfs Attributes */
+
+static ssize_t uart_mode_show(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	struct usb_serial_port *port = to_usb_serial_port(dev);
+	struct ti_port *tport = usb_get_serial_port_data(port);
+
+	return sprintf(buf, "%d\n", tport->tp_uart_mode);
+}
+
+static ssize_t uart_mode_store(struct device *dev,
+	struct device_attribute *attr, const char *valbuf, size_t count)
+{
+	struct usb_serial_port *port = to_usb_serial_port(dev);
+	struct ti_port *tport = usb_get_serial_port_data(port);
+	unsigned int v = simple_strtoul(valbuf, NULL, 0);
+
+	dev_dbg(dev, "%s: setting uart_mode = %d\n", __func__, v);
+
+	if (v < 256)
+		tport->tp_uart_mode = v;
+	else
+		dev_err(dev, "%s - uart_mode %d is invalid\n", __func__, v);
+
+	return count;
+}
+static DEVICE_ATTR_RW(uart_mode);
+
+static int ti_create_sysfs_attrs(struct usb_serial_port *port)
+{
+	return device_create_file(&port->dev, &dev_attr_uart_mode);
+}
+
+static int ti_remove_sysfs_attrs(struct usb_serial_port *port)
+{
+	device_remove_file(&port->dev, &dev_attr_uart_mode);
+	return 0;
+}
+
 static int ti_startup(struct usb_serial *serial)
 {
 	struct ti_device *tdev;
@@ -607,6 +647,7 @@ static void ti_release(struct usb_serial *serial)
 static int ti_port_probe(struct usb_serial_port *port)
 {
 	struct ti_port *tport;
+	int status;
 
 	tport = kzalloc(sizeof(*tport), GFP_KERNEL);
 	if (!tport)
@@ -628,6 +669,12 @@ static int ti_port_probe(struct usb_serial_port *port)
 
 	usb_set_serial_port_data(port, tport);
 
+	status = ti_create_sysfs_attrs(port);
+	if (status) {
+		kfree(tport);
+		return status;
+	}
+
 	port->port.drain_delay = 3;
 
 	return 0;
@@ -638,6 +685,7 @@ static int ti_port_remove(struct usb_serial_port *port)
 	struct ti_port *tport;
 
 	tport = usb_get_serial_port_data(port);
+	ti_remove_sysfs_attrs(port);
 	kfree(tport);
 
 	return 0;
-- 
2.13.0

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
