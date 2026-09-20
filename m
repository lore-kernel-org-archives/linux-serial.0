Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECDC33C7691
	for <linux-serial@vger.kernel.org>; Sun, 20 Sep 2026 14:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789914612; cv=none; b=LF6ljUrNJl1TYTEKx0ppXAzaSNd0Xzwh28iqAumg7wU53/sVyWMr6GNVjPzv/WWyZzX0xF/6fT+LAnY1hHro2j634S34RRECeapAemfeyXidQjHeQThu5QRyhbG8DGpsshgEU3fsWnVtU6s1PKmMBESZppj+bUvYXdhcX8GWD80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789914612; c=relaxed/simple;
	bh=/fMAcO+ftttYi+uUEagRZ+sTL7X7DJ+w5m64YxpfCNE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Hhpdt7W8XCxGxfkykeTtGYjmAixdJjDZqhWJWcUDvmSMBdCKuO2k6icldIgylN3aOOj2VD7qkrQLH9l6EJr5SXwY84o8TEe1xg/3f2IYAQhiOMYZ5SEwJupi5Vt0IzRbKSr1clrkgCMH5ElJlyWXWxiImOCt7l0RJ39vMSI/yw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=Pg1yl4Gv; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="Pg1yl4Gv"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id D7F5624010C
	for <linux-serial@vger.kernel.org>; Sun, 20 Sep 2026 16:29:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de;
	s=1984.8680eb; t=1789914599;
	bh=u0nIJ8CVi5r4jIStW9VLW1QJern+HgJu1P9wDpDmQlM=;
	h=From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:To:Cc:Autocrypt:OpenPGP:From;
	b=Pg1yl4GvPd+psKHFUxLCj/y/tP/5ZMRHm7Htz3yz2O8j7y8SIbWiaLon9GHTBIukO
	 BBjh9GFGtMV82bTvWHTGvdaLWQYgC4Ki1z9VZl+541x4cnBGZ5VgOPAHRJYp8kD9JC
	 HUQHE0tb3oHTv5yIIInrD7/sdzwfHaV07tofAwUjk7TJ7wxNBe0Xq1zf/jVaGaSyt6
	 3U8o69xvusEZyofHfo+3kdvKyLX20HFVqbH1fih0uUK88BaCBskFpQSpPeXvWt46nJ
	 +GAbxNlzAwBe/73ODPBOGwzVaFFiDdokxjtfN416IiepV/ulOxdDt12nms0pC6kO6r
	 rodABtEQ8Dzww==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4hnpfX651Hz9rxM;
	Sun, 20 Sep 2026 16:29:56 +0200 (CEST)
From: Markus Probst <markus.probst@posteo.de>
Date: Sun, 20 Sep 2026 14:29:58 +0000
Subject: [PATCH v2 1/3] tty: serdev: Export functions to pause receive_buf
 callback calls
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260920-rust_serdev_probe_refactor-v2-1-43b855162f5d@posteo.de>
References: <20260920-rust_serdev_probe_refactor-v2-0-43b855162f5d@posteo.de>
In-Reply-To: <20260920-rust_serdev_probe_refactor-v2-0-43b855162f5d@posteo.de>
To: Ayush Singh <ayush@beagleboard.org>, Johan Hovold <johan@kernel.org>, 
 Alex Elder <elder@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 Eric Biggers <ebiggers@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, 
 Lorenzo Stoakes <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Uladzislau Rezki <urezki@gmail.com>, 
 Jiri Slaby <jirislaby@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: greybus-dev@lists.linaro.org, linux-serial@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 driver-core@lists.linux.dev, Markus Probst <markus.probst@posteo.de>
X-Developer-Signature: v=1; a=openpgp-sha256; l=6630;
 i=markus.probst@posteo.de; h=from:subject:message-id;
 bh=/fMAcO+ftttYi+uUEagRZ+sTL7X7DJ+w5m64YxpfCNE=;
 b=owEBiQJ2/ZANAwAIATR2H/jnrUPSAcsmYgBqr+3hy1rIDm+TCAvEEoYJEZLG9954cATfbdvoD
 LAB05EWDUCJAk8EAAEIADkWIQSCdBjE9KxY53IwxHM0dh/4561D0gUCaq/t4RsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQNHYf+OetQ9KoWA//SFTlgv89y/aaUnJxTdL/Q8ObdI9TfbJ
 87ngiOAQ32THMfIIp2Y2vxm/KlnyI4i0jG4YckgkN4e/s4qpZxRbH/1Ihfo5lqXDuzxHiua7tOO
 jnhYHY0lO0gEgiEa+NyDB9Y0CqH+0sCRxsXld9DFduJHMqOjCiiC58LtsrdC72HQQk68f0S/ZwB
 TrRxtcL99N9zbnGmS6mStAcSqLFXablM107M8rINoG6TSRL7ogO1IV7w0Rl6vuPbcM0yMLQTKYk
 tSwLaBrA5XVmuLtix4wfdl7tybWTF2UFvTGwTHu4VptWJYZ1UV7lhluXkZsGfT+7XFIzFR9Mht3
 V3o0KLO2PCqAxlNzudrEanrYKfvGBnkV+Th0XqwVnQbNZH4qZ1qFscYmRkr7QcNEEF05aHdoMG9
 /8ipwAFGUpE/dfK+oT1QQAli0T7Y+bnGXcw81EurvmUKbC+6fJInH0SmzpRR0rEa+zMkfXhm+Fl
 +0z5BifM0w7bPZzLla1T6yTfsQWMTjwd+bB8NXzIrLE1JpSFeZE90hbyhZWtrrNX7iX/Ve+L4ac
 YsbnVXQeL9XCEcwxLi3ueppnjAdGpMgeIpnGQG83gLJ9teyQq0jAJrfHAJ/4BHiNlyeZEEM458f
 O/2LOiVNZya2mJpYgzmr/NQpFU58k7xQnoG2bOSbxxQTrP68FWsA=
X-Developer-Key: i=markus.probst@posteo.de; a=openpgp;
 fpr=827418C4F4AC58E77230C47334761FF8E7AD43D2
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
  keydata=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
  aBeNN4ijKZchBXHPgVx+YtWRHfcm4l8=
OpenPGP: url=https://posteo.de/keys/markus.probst@posteo.de.asc; preference=encrypt

These functions will be used to simply the serdev rust abstraction. It
also contributes to the fixing of 2 race conditions in the serdev rust
abstraction.

Signed-off-by: Markus Probst <markus.probst@posteo.de>
---
 drivers/tty/serdev/core.c           | 50 ++++++++++++++++++++++++++++++++++++-
 drivers/tty/serdev/serdev-ttyport.c | 38 ++++++++++++++++++++++++++++
 include/linux/serdev.h              |  6 +++++
 3 files changed, 93 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
index 7500efcdfc21..7d24f16710cb 100644
--- a/drivers/tty/serdev/core.c
+++ b/drivers/tty/serdev/core.c
@@ -187,6 +187,51 @@ void serdev_device_close(struct serdev_device *serdev)
 }
 EXPORT_SYMBOL_GPL(serdev_device_close);
 
+/**
+ * serdev_device_pause_rx() - pause data receive
+ * @serdev:	serdev device
+ *
+ * Pause calls to receive_buf.
+ *
+ * The caller must guarantee that this does not run concurrently with
+ * `serdev_device_open` or `serdev_device_close`.
+ *
+ * Note that if a call to receive_buf is currently executed, the function will
+ * sleep until it has finished.
+ */
+void serdev_device_pause_rx(struct serdev_device *serdev)
+{
+	struct serdev_controller *ctrl = serdev->ctrl;
+
+	if (!ctrl || !ctrl->ops->pause_rx)
+		return;
+
+	ctrl->ops->pause_rx(ctrl);
+}
+EXPORT_SYMBOL_GPL(serdev_device_pause_rx);
+
+/**
+ * serdev_device_resume_rx() - resume data receive
+ * @serdev:	serdev device
+ *
+ * Resume calls to receive_buf.
+ *
+ * The caller must guarantee that this does not run concurrently with
+ * `serdev_device_open` or `serdev_device_close`.
+ *
+ * This can be called even if not paused to ensure data receive is active.
+ */
+void serdev_device_resume_rx(struct serdev_device *serdev)
+{
+	struct serdev_controller *ctrl = serdev->ctrl;
+
+	if (!ctrl || !ctrl->ops->resume_rx)
+		return;
+
+	ctrl->ops->resume_rx(ctrl);
+}
+EXPORT_SYMBOL_GPL(serdev_device_resume_rx);
+
 static void devm_serdev_device_close(void *serdev)
 {
 	serdev_device_close(serdev);
@@ -398,6 +443,7 @@ EXPORT_SYMBOL_GPL(serdev_device_break_ctl);
 static int serdev_drv_probe(struct device *dev)
 {
 	const struct serdev_device_driver *sdrv = to_serdev_device_driver(dev->driver);
+	struct serdev_device *sdev = to_serdev_device(dev);
 	int ret;
 
 	ret = dev_pm_domain_attach(dev, PD_FLAG_ATTACH_POWER_ON |
@@ -405,7 +451,9 @@ static int serdev_drv_probe(struct device *dev)
 	if (ret)
 		return ret;
 
-	return sdrv->probe(to_serdev_device(dev));
+	serdev_device_resume_rx(sdev);
+
+	return sdrv->probe(sdev);
 }
 
 static void serdev_drv_remove(struct device *dev)
diff --git a/drivers/tty/serdev/serdev-ttyport.c b/drivers/tty/serdev/serdev-ttyport.c
index bab1b143b8a6..e8aa89e733bd 100644
--- a/drivers/tty/serdev/serdev-ttyport.c
+++ b/drivers/tty/serdev/serdev-ttyport.c
@@ -7,8 +7,10 @@
 #include <linux/tty.h>
 #include <linux/tty_driver.h>
 #include <linux/poll.h>
+#include "../tty.h"
 
 #define SERPORT_ACTIVE		1
+#define SERPORT_PAUSE_RX	2
 
 struct serport {
 	struct tty_port *port;
@@ -32,6 +34,14 @@ static size_t ttyport_receive_buf(struct tty_port *port, const u8 *cp,
 	if (!test_bit(SERPORT_ACTIVE, &serport->flags))
 		return 0;
 
+	if (test_bit(SERPORT_PAUSE_RX, &serport->flags))
+		return 0;
+
+	/*
+	 * Ensure writes by the driver are visible before allowing traffic to resume.
+	 */
+	smp_mb__after_atomic();
+
 	ret = serdev_controller_receive_buf(ctrl, cp, count);
 
 	dev_WARN_ONCE(&ctrl->dev, ret > count,
@@ -156,6 +166,32 @@ static void ttyport_close(struct serdev_controller *ctrl)
 	tty_release_struct(tty, serport->tty_idx);
 }
 
+static void ttyport_pause_rx(struct serdev_controller *ctrl)
+{
+	struct serport *serport = serdev_controller_get_drvdata(ctrl);
+	struct tty_struct *tty = serport->tty;
+
+	set_bit(SERPORT_PAUSE_RX, &serport->flags);
+
+	if (test_bit(SERPORT_ACTIVE, &serport->flags))
+		tty_buffer_flush_work(tty->port);
+}
+
+static void ttyport_resume_rx(struct serdev_controller *ctrl)
+{
+	struct serport *serport = serdev_controller_get_drvdata(ctrl);
+	struct tty_struct *tty = serport->tty;
+
+	/*
+	 * Ensure writes by the driver are visible before allowing traffic to resume.
+	 */
+	smp_mb__before_atomic();
+	clear_bit(SERPORT_PAUSE_RX, &serport->flags);
+
+	if (test_bit(SERPORT_ACTIVE, &serport->flags))
+		tty_buffer_restart_work(tty->port);
+}
+
 static unsigned int ttyport_set_baudrate(struct serdev_controller *ctrl, unsigned int speed)
 {
 	struct serport *serport = serdev_controller_get_drvdata(ctrl);
@@ -260,6 +296,8 @@ static const struct serdev_controller_ops ctrl_ops = {
 	.get_tiocm = ttyport_get_tiocm,
 	.set_tiocm = ttyport_set_tiocm,
 	.break_ctl = ttyport_break_ctl,
+	.pause_rx = ttyport_pause_rx,
+	.resume_rx = ttyport_resume_rx,
 };
 
 struct device *serdev_tty_port_register(struct tty_port *port,
diff --git a/include/linux/serdev.h b/include/linux/serdev.h
index b6c3d957ec15..5cf05df17ddf 100644
--- a/include/linux/serdev.h
+++ b/include/linux/serdev.h
@@ -89,6 +89,8 @@ struct serdev_controller_ops {
 	int (*get_tiocm)(struct serdev_controller *);
 	int (*set_tiocm)(struct serdev_controller *, unsigned int, unsigned int);
 	int (*break_ctl)(struct serdev_controller *ctrl, unsigned int break_state);
+	void (*pause_rx)(struct serdev_controller *ctrl);
+	void (*resume_rx)(struct serdev_controller *ctrl);
 };
 
 /**
@@ -194,6 +196,8 @@ static inline size_t serdev_controller_receive_buf(struct serdev_controller *ctr
 int serdev_device_open(struct serdev_device *);
 void serdev_device_close(struct serdev_device *);
 int devm_serdev_device_open(struct device *, struct serdev_device *);
+void serdev_device_pause_rx(struct serdev_device *serdev);
+void serdev_device_resume_rx(struct serdev_device *serdev);
 unsigned int serdev_device_set_baudrate(struct serdev_device *, unsigned int);
 void serdev_device_set_flow_control(struct serdev_device *, bool);
 int serdev_device_write_buf(struct serdev_device *, const u8 *, size_t);
@@ -233,6 +237,8 @@ static inline int serdev_device_open(struct serdev_device *sdev)
 	return -ENODEV;
 }
 static inline void serdev_device_close(struct serdev_device *sdev) {}
+static inline void serdev_device_pause_rx(struct serdev_device *serdev) {}
+static inline void serdev_device_resume_rx(struct serdev_device *serdev) {}
 static inline unsigned int serdev_device_set_baudrate(struct serdev_device *sdev, unsigned int baudrate)
 {
 	return 0;

-- 
2.55.0

