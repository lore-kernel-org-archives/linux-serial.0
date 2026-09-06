Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC9A37A85C
	for <linux-serial@vger.kernel.org>; Sun,  6 Sep 2026 15:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788710142; cv=none; b=J7q+9TFZ2uvWjWIuqQVz7R5evpT8bUTy5uIwCk/1WzKyTzQLtLRtzo0oi4vwzWKfG21JAfzkg/rpT/UGMPA5bJ3FCwqrJiDq2H8RYo+snT9VLP+Rp6IX2hr+ZWwaoD2UsfxwnyxL6+0YeSJ2f5qFUF2h+XulAWNAvCHApU0RfzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788710142; c=relaxed/simple;
	bh=luUTVGwG8dPS2B8m7mVwkqSNgqVUD/fDXzGfu/5fGnE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ndVFTY9Iblmzo3cUPPY/Bhc6C4moa5ZfBwgwWc3BJ9t9erferufHVBFWS4w9f9GQ5KXbLWwDR91FA8vJrrZGzTiGXrWZplUmalIuBFsjw2JM1DdYmqPSevhZGyr38ajbA1x0QSsu8/yPhVrAhIeLEx9i83GmjoduKpfocKzWDvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=HwMzHudi; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="HwMzHudi"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id AF17B240106
	for <linux-serial@vger.kernel.org>; Sun,  6 Sep 2026 17:55:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de;
	s=1984.8680eb; t=1788710131;
	bh=OPTurngmT4y7HRgllpu2hIi/AvbYo/blTgxsel8dS9c=;
	h=From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:To:Cc:Autocrypt:OpenPGP:From;
	b=HwMzHudi95cq5VYiePpx2p50lL5CBHi6JsmzE5N4JsAPR3kXRyvYB0CF+m18VpG8k
	 pjVFppDF2ltxDWYimzucv5L05sE59uILGQt06HVH7fEQdSN8aSkwtjDaG3V1bGEXmh
	 LFAGRglnOfZ4QSlrjwzzyhHZHAYLR0s9pLNPASVh2BQ/+rT+cxbfATdg8Fe0LIdgL9
	 yvmt/0A3sMhxy1YEUPiWXUvb1lFX9D6hcDKFKFTzHjG1WkYB/Y26osuXany06sVKnJ
	 HpCqtZ6aw22B0MlsTrafQT19LdjC5YNES6a+nyIm0J35zm+EJjIb1WXZF8anq8Gr2h
	 7KYYhxZ1iVYmQ==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4hdFCd6f9cz6tvk;
	Sun,  6 Sep 2026 17:55:25 +0200 (CEST)
From: Markus Probst <markus.probst@posteo.de>
Date: Sun, 06 Sep 2026 15:55:28 +0000
Subject: [PATCH 1/5] tty: serdev: Export functions to pause receive_buf
 callback calls
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260906-rust_serdev_probe_refactor-v1-1-69cdae0074ec@posteo.de>
References: <20260906-rust_serdev_probe_refactor-v1-0-69cdae0074ec@posteo.de>
In-Reply-To: <20260906-rust_serdev_probe_refactor-v1-0-69cdae0074ec@posteo.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6513;
 i=markus.probst@posteo.de; h=from:subject:message-id;
 bh=luUTVGwG8dPS2B8m7mVwkqSNgqVUD/fDXzGfu/5fGnE=;
 b=owEBiQJ2/ZANAwAIATR2H/jnrUPSAcsmYgBqnYzqu6+T7ygJPm+wsJS3Z4RFKLAdDXaJ446Hn
 o6LlYuKuaKJAk8EAAEIADkWIQSCdBjE9KxY53IwxHM0dh/4561D0gUCap2M6hsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQNHYf+OetQ9JP4xAAi1LAZhadIsbkrEyaO1Ov9n9QoVSQOwW
 wD4xbm6qiViBtokWNRL4/sDm69q5g63ktU7c2IWCDZdRx/KNgbHNBDAudtZuHmw5+AY6Kmvi9SV
 HuIvaWtVaQ/1KXcYN2HaE2bHctn4yq9r+fqy4N9xlsjW+HjyZlR8okB39fPyVDjaLxODlWZmp7v
 Pb2leGIImsP1m8gHNWRjTGs//H4cgWqmNY4LPSC8w7Grkfg+G+h84ncFPty/YpR5IYgwExkKW50
 U3dfz62zydfthWGU6CZvS5GOaTXr3EPiIiQ7mSWI4rDNczds9gGkDGEyucLLwlkFkYfik/+ZJZO
 ZiUsJ0Gds2zofgsXfpJmnenqL1miouPwigHl/tvye0OBYXSlhDd/V8pHlGkWE2vMdwfVKEuAr31
 byRVrEm9F4GwTAOXQw2YbLTwOdBoNN4c83c33j3mj59NKOJheehkNUoK/4OkUCXVfot90+8m9Wo
 ogDbn5fVOAkGXVhMPADWvmDWkWFCiRv563M1d32zw/Arkzs5dkHXeEU1lAtHv8DThDmCl8g56iB
 ud1T8fSPa/VuX556xxkqjEoc0IhtByqzGRe5vrc7xvertfdS8eCgnkCcTbeC97UcaK5nzapeRf9
 IqPL9gls3ZYs6KUjYxKftQuHs+zNmdfZMOdUxVtPUKGKnblplv9g=
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
 drivers/tty/serdev/serdev-ttyport.c | 32 ++++++++++++++++++++++++
 include/linux/serdev.h              |  6 +++++
 3 files changed, 87 insertions(+), 1 deletion(-)

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
index bab1b143b8a6..85ab454c2f13 100644
--- a/drivers/tty/serdev/serdev-ttyport.c
+++ b/drivers/tty/serdev/serdev-ttyport.c
@@ -6,9 +6,11 @@
 #include <linux/serdev.h>
 #include <linux/tty.h>
 #include <linux/tty_driver.h>
+#include <linux/tty_flip.h>
 #include <linux/poll.h>
 
 #define SERPORT_ACTIVE		1
+#define SERPORT_PAUSE_RX	2
 
 struct serport {
 	struct tty_port *port;
@@ -32,6 +34,9 @@ static size_t ttyport_receive_buf(struct tty_port *port, const u8 *cp,
 	if (!test_bit(SERPORT_ACTIVE, &serport->flags))
 		return 0;
 
+	if (test_bit(SERPORT_PAUSE_RX, &serport->flags))
+		return 0;
+
 	ret = serdev_controller_receive_buf(ctrl, cp, count);
 
 	dev_WARN_ONCE(&ctrl->dev, ret > count,
@@ -156,6 +161,31 @@ static void ttyport_close(struct serdev_controller *ctrl)
 	tty_release_struct(tty, serport->tty_idx);
 }
 
+static void ttyport_pause_rx(struct serdev_controller *ctrl)
+{
+	struct serport *serport = serdev_controller_get_drvdata(ctrl);
+	struct tty_struct *tty = serport->tty;
+
+	if (test_bit(SERPORT_ACTIVE, &serport->flags))
+		tty_buffer_lock_exclusive(tty->port);
+
+	set_bit(SERPORT_PAUSE_RX, &serport->flags);
+
+	if (test_bit(SERPORT_ACTIVE, &serport->flags))
+		tty_buffer_unlock_exclusive(tty->port);
+}
+
+static void ttyport_resume_rx(struct serdev_controller *ctrl)
+{
+	struct serport *serport = serdev_controller_get_drvdata(ctrl);
+	struct tty_struct *tty = serport->tty;
+
+	clear_bit(SERPORT_PAUSE_RX, &serport->flags);
+
+	if (test_bit(SERPORT_ACTIVE, &serport->flags))
+		tty_flip_buffer_push(tty->port);
+}
+
 static unsigned int ttyport_set_baudrate(struct serdev_controller *ctrl, unsigned int speed)
 {
 	struct serport *serport = serdev_controller_get_drvdata(ctrl);
@@ -260,6 +290,8 @@ static const struct serdev_controller_ops ctrl_ops = {
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

