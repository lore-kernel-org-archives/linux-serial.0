From: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 09/10] serdev: add serdev_device_set_rts
Date: Sat,  4 Mar 2017 12:58:32 +0100
Message-ID: <20170304115833.3538-10-sre@kernel.org>
References: <20170304115833.3538-1-sre@kernel.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170304115833.3538-1-sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>, Gustavo Padovan <gustavo-THi1TnShQwVAfugRpC6u6w@public.gmane.org>, Johan Hedberg <johan.hedberg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

Add function to enable/disable RTS line.

Signed-off-by: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/tty/serdev/core.c           | 11 +++++++++++
 drivers/tty/serdev/serdev-ttyport.c | 32 ++++++++++++++++++++++++++++++++
 include/linux/serdev.h              |  3 +++
 3 files changed, 46 insertions(+)

diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
index 36eb3dfb1477..f08fe257dadb 100644
--- a/drivers/tty/serdev/core.c
+++ b/drivers/tty/serdev/core.c
@@ -195,6 +195,17 @@ bool serdev_device_get_cts(struct serdev_device *serdev)
 }
 EXPORT_SYMBOL_GPL(serdev_device_get_cts);
 
+void serdev_device_set_rts(struct serdev_device *serdev, bool enable)
+{
+	struct serdev_controller *ctrl = serdev->ctrl;
+
+	if (!ctrl || !ctrl->ops->set_rts)
+		return;
+
+	return ctrl->ops->set_rts(ctrl, enable);
+}
+EXPORT_SYMBOL_GPL(serdev_device_set_rts);
+
 static int serdev_drv_probe(struct device *dev)
 {
 	const struct serdev_device_driver *sdrv = to_serdev_device_driver(dev->driver);
diff --git a/drivers/tty/serdev/serdev-ttyport.c b/drivers/tty/serdev/serdev-ttyport.c
index 3eaca7560e2e..06a7d9131181 100644
--- a/drivers/tty/serdev/serdev-ttyport.c
+++ b/drivers/tty/serdev/serdev-ttyport.c
@@ -193,6 +193,37 @@ static bool ttyport_get_cts(struct serdev_controller *ctrl)
 	return !!(status & TIOCM_CTS);
 }
 
+static void ttyport_set_rts(struct serdev_controller *ctrl, bool enable)
+{
+	struct serport *serport = serdev_controller_get_drvdata(ctrl);
+	struct tty_struct *tty = serport->tty;
+	int status = tty->driver->ops->tiocmget(tty);
+	unsigned int set = 0;
+	unsigned int clear = 0;
+
+	if (enable) {
+		set |= (TIOCM_OUT2 | TIOCM_RTS);
+		clear = ~set;
+		set &= TIOCM_DTR | TIOCM_RTS | TIOCM_OUT1 |
+		       TIOCM_OUT2 | TIOCM_LOOP;
+		clear &= TIOCM_DTR | TIOCM_RTS | TIOCM_OUT1 |
+			 TIOCM_OUT2 | TIOCM_LOOP;
+		status = tty->driver->ops->tiocmset(tty, set, clear);
+	} else {
+		set &= ~(TIOCM_OUT2 | TIOCM_RTS);
+		clear = ~set;
+		set &= TIOCM_DTR | TIOCM_RTS | TIOCM_OUT1 |
+		       TIOCM_OUT2 | TIOCM_LOOP;
+		clear &= TIOCM_DTR | TIOCM_RTS | TIOCM_OUT1 |
+			 TIOCM_OUT2 | TIOCM_LOOP;
+		status = tty->driver->ops->tiocmset(tty, set, clear);
+	}
+
+	if (status)
+		dev_err(&ctrl->dev, "failed to %s RTS: %d",
+			enable ? "enable" : "disable", status);
+}
+
 static const struct serdev_controller_ops ctrl_ops = {
 	.write_buf = ttyport_write_buf,
 	.write_flush = ttyport_write_flush,
@@ -203,6 +234,7 @@ static const struct serdev_controller_ops ctrl_ops = {
 	.set_baudrate = ttyport_set_baudrate,
 	.wait_until_sent = ttyport_wait_until_sent,
 	.get_cts = ttyport_get_cts,
+	.set_rts = ttyport_set_rts,
 };
 
 struct device *serdev_tty_port_register(struct tty_port *port,
diff --git a/include/linux/serdev.h b/include/linux/serdev.h
index b0c47402d84a..f520565f9a61 100644
--- a/include/linux/serdev.h
+++ b/include/linux/serdev.h
@@ -83,6 +83,7 @@ struct serdev_controller_ops {
 	unsigned int (*set_baudrate)(struct serdev_controller *, unsigned int);
 	void (*wait_until_sent)(struct serdev_controller *, long);
 	bool (*get_cts)(struct serdev_controller *);
+	void (*set_rts)(struct serdev_controller *, bool);
 };
 
 /**
@@ -190,6 +191,7 @@ unsigned int serdev_device_set_baudrate(struct serdev_device *, unsigned int);
 void serdev_device_set_flow_control(struct serdev_device *, bool);
 void serdev_device_wait_until_sent(struct serdev_device *, long);
 bool serdev_device_get_cts(struct serdev_device *);
+void serdev_device_set_rts(struct serdev_device *, bool);
 int serdev_device_write_buf(struct serdev_device *, const unsigned char *, size_t);
 void serdev_device_write_flush(struct serdev_device *);
 int serdev_device_write_room(struct serdev_device *);
@@ -232,6 +234,7 @@ static inline bool serdev_device_get_cts(struct serdev_device *serdev)
 {
 	return false;
 }
+static inline void serdev_device_set_rts(struct serdev_controller *serdev, bool) {}
 static inline int serdev_device_write_buf(struct serdev_device *sdev, const unsigned char *buf, size_t count)
 {
 	return -ENODEV;
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
