Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.67.36.66
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794504619;
	b=SMG0/njdHu7+wFKIlUTUe2cP2QY4UgpjFDzaxGVzjjA7yFtlFf0TLWBarxqPDdIwRrvS
	 yGvdR5hMsYrT59q9lwe9ZtyRYMSdAMcbLG5D2YsPudR1NyPIJQuna9GR+5E4wics0/voE
	 +/jv/l7duVgDYiE6DUnrgJHp1JytEIsW22VDmSmRMOsVaeKp3JcPpxwT5zAzeZyH4FhBg
	 KUqHMZUwRHBJgQvVrMS1EfXVL8Hc5Cjf7ltzr3QXl3FsR/BaLGo0A1SRbvWN/rCG+dM4W
	 soMLS1R2yChWhX05znc0f4TPqAQqAZdtlxhbPLExAImHt0LvEavWu5CWgcpjBFmC1Gw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794504619;
	h=DMARC-Filter:Received:DKIM-Signature:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Developer-Signature:X-Developer-Key:
	 Autocrypt:OpenPGP;
	bh=IYJJYKSjYrP0RZi62K5VPZIlTsOxwDzjSTyNjhgSgv8=;
	b=ujB5bJKClY4e0JquAh0HdEcF7BQSEXxX7kjk9igpESxe3a3rgtZI7PD6g43CQAyn5zxp
	 jJbIL3QMW49B1vzlTNTNV+/kUvYxOWhugSnSIQPv2YFEzNC2ou9HcDo5FNh3QM2D3pAuI
	 yttOlYZ4pgb2J6WNtbBvZiSLrmpeMzTPS7UL9kEyt/IpccXHH5cd9aOnusNfqfqZRFEYi
	 ToTfoSjjRlIGSR8Bi6nzf/8l9Lx05n43FfCwh+tLwDAZU2sDTkezTkyHLBuAYzaVBVlcz
	 uoEH0IwS6TOYBQLgpnAnv9J6Ecx6QVyJ3clzkIYfQIlHIRWP6OrAO2D/TZ7yRbHIokQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=posteo.de;
	spf=pass smtp.mailfrom=posteo.de;
	dkim=pass header.d=posteo.de header.i=@posteo.de header.a=rsa-sha256 header.s=1984.8680eb header.b=BEj23zz2;
	arc=none smtp.remote-ip=185.67.36.66
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C67606A880
	for <linux-serial@vger.kernel.org>; Thu, 12 Nov 2026 17:30:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 54C67606A880
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.a=rsa-sha256 header.s=1984.8680eb header.b=BEj23zz2
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 1BC6A240104
	for <linux-serial@vger.kernel.org>; Thu, 12 Nov 2026 18:30:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de;
	s=1984.8680eb; t=1794504611;
	bh=IYJJYKSjYrP0RZi62K5VPZIlTsOxwDzjSTyNjhgSgv8=;
	h=From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:To:Cc:Autocrypt:OpenPGP:From;
	b=BEj23zz2Nqt74tpmE0Lzb3tgRs7HSTCuqzNp9Vmjh8E26OjON70YWTvUgbcCJ5UTP
	 JCOXqtfS9Ogc3yMyZrq9aUCItPaxA7SHLilOFiuLy5R73mK8rgelogdi2h6VsgzNCE
	 5fplncQ7R6MvgywuoVdIC6vBNGdZlYsaDbgjCpCmZlWAwJbs7AGW+o7u7wWS+IYlRK
	 OV2OfJuGj/CzMHYPh+Y1F+n7VWFDIbR0Yg/O1bwKujrSHkv0rKD5t0VbSg1s2q/I9S
	 9bVWQkLN7pmnGaoEPg/NIecoRFUFqrE7aPV2HQVu7YJN8SyB5viSPhDn/vn+DFRNSb
	 Cg/MIFA5/lH1Q==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4jQS7y5W1wz9rxK;
	Thu, 12 Nov 2026 18:30:06 +0100 (CET)
From: Markus Probst <markus.probst@posteo.de>
Date: Thu, 12 Nov 2026 17:30:09 +0000
Subject: [PATCH v6 1/4] tty: serdev: Add mutex lock
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261112-rust_serdev_probe_refactor-v6-1-3568ed56264c@posteo.de>
References: <20261112-rust_serdev_probe_refactor-v6-0-3568ed56264c@posteo.de>
In-Reply-To: <20261112-rust_serdev_probe_refactor-v6-0-3568ed56264c@posteo.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5493;
 i=markus.probst@posteo.de; h=from:subject:message-id;
 bh=nlroOpwgoIkgLKv6whLds/yWA7a+Z/hs3CfwInm5QJo=;
 b=owEBiQJ2/ZANAwAIATR2H/jnrUPSAcsmYgBq9feZ+15T9pIdk89Wd9N4yNQ3LCgmNyuOWp8IS
 hrpW82Is7uJAk8EAAEIADkWIQSCdBjE9KxY53IwxHM0dh/4561D0gUCavX3mRsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQNHYf+OetQ9KC+w//eqA0lnVb5oM2EpfKxxro0R3FSt7Uhsy
 RWqJblo1QfAl3w9RN/2EzoYUkCZcT6JS+c+4HBN/Gyr2UAALNemrRmmvaAJ+yDfvAxaFDTSi6tI
 KCtQUUXEu9EgYdY3n1lLZnqC+TQXuv/HoeoNv9mPpS0rJqN5R50hfZdoGhLFumc2ARU6tnFDrbE
 cXZmmlHblB1VSUGMuvhpGM0uIOB9LtR/pgvblbcsvVY8mkDQgD72apLy6ak6aNeLCXY4sVOprmV
 XD+mhz/EC5CtI3hNSt0Xp/mY1N61HBL71Cmm4Y4lHBYIv6oqF6/00KNWJ1bsl4Fdm8y+X+0dsSE
 Ghu+zQPnleviFcp97/vWIAoaLVCDXPs2dMq9uy/LWvZuJvZqm9E89Lsd8Z2PCmOg78x+JHhS+gW
 LY0tu98UH34cEaR/ardYtwKaxpu7sulZZeoYdNmEJcZuf9lUcQsmNJTCc99i2lBiVxojkSOpW6J
 k/U8KOKlJ7Gh8BDdmYob80FlszNIdEDrE2CGHloIRtTo0TE/qO8KBLxQ92KDJCApPwCd34gNb4D
 ktkZ7uZopo3W30lvuNdX+ecXWdCBW7FKsR8Vpfm+S5OqzpmunE4jgMPsSzXL0aCyA3V5SPtRdmy
 JGg7SAm0gGHkbVMT5nMVwOtdO4oRngfTvHFMG+nqnnng1gpf0w34=
X-Developer-Key: i=markus.probst@posteo.de; a=openpgp;
 fpr=827418C4F4AC58E77230C47334761FF8E7AD43D2
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
  keydata=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
  aBeNN4ijKZchBXHPgVx+YtWRHfcm4l8=
OpenPGP: url=https://posteo.de/keys/markus.probst@posteo.de.asc; preference=encrypt

Besides more predictable behaviour, this allows for several hardened
behaviour changes:

Return -EALREADY in `serdev_device_open` if the device is already open
instead of causing undefined behaviour.

Allow calling `serdev_device_close`, even if the device is already
closed instead of causing a null pointer dereference.

If the device is left open by the driver after remove, close it and warn
instead of leaving it in a invalid state.

Signed-off-by: Markus Probst <markus.probst@posteo.de>
---
 drivers/tty/serdev/core.c           | 12 +++++++---
 drivers/tty/serdev/serdev-ttyport.c | 44 +++++++++++++++++++++++++++++++------
 include/linux/serdev.h              |  2 +-
 3 files changed, 47 insertions(+), 11 deletions(-)

diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
index 7500efcdfc21..86d9cf8215ed 100644
--- a/drivers/tty/serdev/core.c
+++ b/drivers/tty/serdev/core.c
@@ -142,6 +142,13 @@ void serdev_device_remove(struct serdev_device *serdev)
 	struct serdev_controller *ctrl = serdev->ctrl;
 
 	device_unregister(&serdev->dev);
+
+	/* Warn if driver did not close the serial device. */
+	if (ctrl->ops->close && ctrl->ops->close(ctrl)) {
+		dev_WARN(&ctrl->dev, "Child driver did not close the serial device");
+		pm_runtime_put(&ctrl->dev);
+	}
+
 	ctrl->serdev = NULL;
 }
 EXPORT_SYMBOL_GPL(serdev_device_remove);
@@ -181,9 +188,8 @@ void serdev_device_close(struct serdev_device *serdev)
 	if (!ctrl || !ctrl->ops->close)
 		return;
 
-	pm_runtime_put(&ctrl->dev);
-
-	ctrl->ops->close(ctrl);
+	if (ctrl->ops->close(ctrl))
+		pm_runtime_put(&ctrl->dev);
 }
 EXPORT_SYMBOL_GPL(serdev_device_close);
 
diff --git a/drivers/tty/serdev/serdev-ttyport.c b/drivers/tty/serdev/serdev-ttyport.c
index b6638f9f40d2..17c18d4b0cb8 100644
--- a/drivers/tty/serdev/serdev-ttyport.c
+++ b/drivers/tty/serdev/serdev-ttyport.c
@@ -16,6 +16,8 @@ struct serport {
 	struct tty_driver *tty_drv;
 	int tty_idx;
 	unsigned long flags;
+	struct mutex lock; /* lock preventing modification of flags */
+	struct mutex receive_lock; /* lock preventing execution of serdev_controller_receive_buf */
 };
 
 /*
@@ -29,6 +31,8 @@ static size_t ttyport_receive_buf(struct tty_port *port, const u8 *cp,
 	struct serport *serport = serdev_controller_get_drvdata(ctrl);
 	size_t ret;
 
+	guard(mutex)(&serport->receive_lock);
+
 	if (!test_bit(SERPORT_ACTIVE, &serport->flags))
 		return 0;
 
@@ -99,14 +103,23 @@ static int ttyport_open(struct serdev_controller *ctrl)
 	struct ktermios ktermios;
 	int ret;
 
+	mutex_lock(&serport->lock);
+
+	if (test_bit(SERPORT_ACTIVE, &serport->flags)) {
+		ret = -EALREADY;
+		goto err_flags_unlock;
+	}
+
 	tty = tty_init_dev(serport->tty_drv, serport->tty_idx);
-	if (IS_ERR(tty))
-		return PTR_ERR(tty);
+	if (IS_ERR(tty)) {
+		ret = PTR_ERR(tty);
+		goto err_flags_unlock;
+	}
 	serport->tty = tty;
 
 	if (!tty->ops->open || !tty->ops->close) {
 		ret = -ENODEV;
-		goto err_unlock;
+		goto err_tty_unlock;
 	}
 
 	ret = tty->ops->open(serport->tty, NULL);
@@ -128,26 +141,38 @@ static int ttyport_open(struct serdev_controller *ctrl)
 	ktermios.c_cflag |= CLOCAL;
 	tty_set_termios(tty, &ktermios);
 
+	mutex_lock(&serport->receive_lock);
 	set_bit(SERPORT_ACTIVE, &serport->flags);
+	mutex_unlock(&serport->receive_lock);
+
+	mutex_unlock(&serport->lock);
 
 	return 0;
 
 err_close:
 	tty->ops->close(tty, NULL);
-err_unlock:
+err_tty_unlock:
 	tty_unlock(tty);
 	tty_release_struct(tty, serport->tty_idx);
 	serport->tty = NULL;
+err_flags_unlock:
+	mutex_unlock(&serport->lock);
 
 	return ret;
 }
 
-static void ttyport_close(struct serdev_controller *ctrl)
+static bool ttyport_close(struct serdev_controller *ctrl)
 {
 	struct serport *serport = serdev_controller_get_drvdata(ctrl);
-	struct tty_struct *tty = serport->tty;
+	struct tty_struct *tty;
+
+	guard(mutex)(&serport->lock);
 
-	clear_bit(SERPORT_ACTIVE, &serport->flags);
+	tty = serport->tty;
+
+	scoped_guard(mutex, &serport->receive_lock)
+		if (!__test_and_clear_bit(SERPORT_ACTIVE, &serport->flags))
+			return false;
 
 	tty_lock(tty);
 	if (tty->ops->close)
@@ -156,6 +181,8 @@ static void ttyport_close(struct serdev_controller *ctrl)
 
 	tty_release_struct(tty, serport->tty_idx);
 	serport->tty = NULL;
+
+	return true;
 }
 
 static unsigned int ttyport_set_baudrate(struct serdev_controller *ctrl, unsigned int speed)
@@ -290,6 +317,9 @@ struct device *serdev_tty_port_register(struct tty_port *port,
 	port->client_ops = &client_ops;
 	port->client_data = ctrl;
 
+	mutex_init(&serport->lock);
+	mutex_init(&serport->receive_lock);
+
 	ret = serdev_controller_add(ctrl);
 	if (ret)
 		goto err_reset_data;
diff --git a/include/linux/serdev.h b/include/linux/serdev.h
index b6c3d957ec15..0f4e81c0950d 100644
--- a/include/linux/serdev.h
+++ b/include/linux/serdev.h
@@ -81,7 +81,7 @@ struct serdev_controller_ops {
 	ssize_t (*write_buf)(struct serdev_controller *, const u8 *, size_t);
 	void (*write_flush)(struct serdev_controller *);
 	int (*open)(struct serdev_controller *);
-	void (*close)(struct serdev_controller *);
+	bool (*close)(struct serdev_controller *);
 	void (*set_flow_control)(struct serdev_controller *, bool);
 	int (*set_parity)(struct serdev_controller *, enum serdev_parity);
 	unsigned int (*set_baudrate)(struct serdev_controller *, unsigned int);

-- 
2.56.1

