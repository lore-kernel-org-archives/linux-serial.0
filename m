Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.67.36.66
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794504619;
	b=0c9vozGfC+z8TxPNOm4auDb8bQO0pqavIKlMHfWTtHcSz4x01LAZUsYG8qy8kdB+c5kX
	 wXHl1dKnbTSAYoShnEx5bCKrFl0vTDjyzMucO/QcXodVgEImKJnN2qL/If067Jsj57br4
	 C/IgAEulxQg0+RdAaitMMKoU8/11UQOSU++OZPRld75xCkmvRF9WQTqUq72FLT3PBQ4kU
	 qQRXUfLpLCX/QOdblzLR+dUVuXNxvitR5VkyNtzy8vqSiTMDWBY2xvbJvSD4ukoLBqWst
	 WtxiXBiibCOphngh1jQWD7JlvYcY7RNXEvJSp36HuwSz8p5vaf3WcfdWLZrtq10yADg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794504619;
	h=DMARC-Filter:Received:DKIM-Signature:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Developer-Signature:X-Developer-Key:
	 Autocrypt:OpenPGP;
	bh=2JO/Motb2GirPcC9hddjrSwtj0PJxjzuXL2/YxkpOUg=;
	b=fYG8EXenkvx3XontM0cLFc8BTRCQc6veat1w+WPRfr6ErwWnrNnVq8g8Z/uUlMzQRnON
	 0p2r7f6vIiaeDQB92ODrxWj0B2S4o9dCT/SKoox2inYVWWSl44DU3EsCCay0CFaH1zjIy
	 HO3nB9TiQHDh2jOTiC4kxstRARmkZBJnkvEdQ/fK3gJx4+m7656rM2FXrfwfkkpjT7GaS
	 rk+zwu3669i4nGTUUsiOBsRSfwXXWjArNSs0zIybp76wYtk9aj87CZM1jasNUZkHLTFOG
	 AhSIfWuTWgB6aZmp50KM3wqnSjZ8EeXFOVjEsVFKb/CjJ1tDluux1HRMAqP1rNzDtUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=posteo.de;
	spf=pass smtp.mailfrom=posteo.de;
	dkim=pass header.d=posteo.de header.i=@posteo.de header.a=rsa-sha256 header.s=1984.8680eb header.b=N86xMvso;
	arc=none smtp.remote-ip=185.67.36.66
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B13606A884
	for <linux-serial@vger.kernel.org>; Thu, 12 Nov 2026 17:30:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 77B13606A884
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.a=rsa-sha256 header.s=1984.8680eb header.b=N86xMvso
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 57F9924010A
	for <linux-serial@vger.kernel.org>; Thu, 12 Nov 2026 18:30:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de;
	s=1984.8680eb; t=1794504614;
	bh=2JO/Motb2GirPcC9hddjrSwtj0PJxjzuXL2/YxkpOUg=;
	h=From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:To:Cc:Autocrypt:OpenPGP:From;
	b=N86xMvsozSocZvYEyOxp8daA5scIXooSIX3yGNo+JLukjNNz2vNkoftAaC09OpX8I
	 scHBghBg5fGwTfKEQd0pdPO9bvYxECnS4FPb87Pl2JqY7o24GNdNdx+U/OviRn6dmU
	 KIN+BNzDAGgnNoDh6hOX/pa04ZE33QOvtNWIMjchARMuY7UMhBmvrzjChODPB3YrO3
	 X60+g+5Ku5ScVXi0JmXJltQIt7I1Ks82J+l7k9Qy67Jq4usQp6KXA34sqogPKOjEfF
	 twDoc5bsQokXRo8kjvBgFtBw3215PLK/C5TkrZuaAkozFgFoSDZEGgxcniLW0Dbo1J
	 gcmk+alUPYoDQ==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4jQS8201KGz9rxQ;
	Thu, 12 Nov 2026 18:30:09 +0100 (CET)
From: Markus Probst <markus.probst@posteo.de>
Date: Thu, 12 Nov 2026 17:30:12 +0000
Subject: [PATCH v6 2/4] tty: serdev: Export functions to pause receive_buf
 callback calls
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
Message-Id: <20261112-rust_serdev_probe_refactor-v6-2-3568ed56264c@posteo.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6268;
 i=markus.probst@posteo.de; h=from:subject:message-id;
 bh=PKa3wcoCH2wHJkmcs/mXYYpls+IcD7g7mkDOeKBFHEI=;
 b=owEBiQJ2/ZANAwAIATR2H/jnrUPSAcsmYgBq9fea6DB54ww5B9+/Z8v/ugnQKgb7UdH35K6r1
 JCpHjrAJIOJAk8EAAEIADkWIQSCdBjE9KxY53IwxHM0dh/4561D0gUCavX3mhsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQNHYf+OetQ9Ihvg//Wt8RJ8ULVpkjtTrdl/SNtQsylHQPO2y
 yAaxUNPTGo/uP1yQ37LTjrSLN+QphMqq0jZiMDfgPQrlYJkydU3KxoDcbT5rNQlInQbMDgRbekH
 Rf83RowBsIkpmaKip/TyGC+JuKuYUBJXP7znm2ZYVCJXWNKJJoW77V1+M+PfKvKEKRCtCHLDXQP
 VwbcQDOQIhh8Q5tEv33gy/A6dxfE1BXOFwt1qgWFP538cLN0LEuaESMSFA2/Gw8ydIuMq2vJ/R7
 jW/pPVW1397lYXNmvQk1qdTebI/Id/A/mkymPK4gkv8hx+0ZFUAqkA6Rw+PaQWxHbmvOdgY6T7v
 oUVVvAZNJ09PmxhOwLHNTzP9X+Q3XHmv5PC5oIo0n4Kiio1RmfKmW/236I+QPfPbLZVr574XOs+
 u5e4GMtxvmN6+KPypDTOlkVuDoXkT8ofLYtD7MjX2v71hoqt9fSMLln//JjtjlaALG3gCH8TcmV
 tcvltOzv7x9Z6Dn7NMu1YG7/UOxc6/0l4ovkTA0PNwsH2Tvumn1AQOFM/f1UPYPH7okxj1bYp4c
 OdA4keqERzAI0XDf9omcKKsoDzfxRu5qeRqHrAZ7p4LK1D8ehKtSVcv4dpp2iQTxxSUq9J7W65V
 KklMWJ+27a7Cl6rtk6+kVYjg3wi/IR28SGpN4oGxO9m4Avuf56xA=
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
 drivers/tty/serdev/core.c           | 44 ++++++++++++++++++++++++++++++++++++-
 drivers/tty/serdev/serdev-ttyport.c | 36 ++++++++++++++++++++++++++++++
 include/linux/serdev.h              |  6 +++++
 3 files changed, 85 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
index 86d9cf8215ed..ca20304c7b20 100644
--- a/drivers/tty/serdev/core.c
+++ b/drivers/tty/serdev/core.c
@@ -193,6 +193,45 @@ void serdev_device_close(struct serdev_device *serdev)
 }
 EXPORT_SYMBOL_GPL(serdev_device_close);
 
+/**
+ * serdev_device_pause_rx() - pause data receive
+ * @serdev:	serdev device
+ *
+ * Pause calls to receive_buf.
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
@@ -404,6 +443,7 @@ EXPORT_SYMBOL_GPL(serdev_device_break_ctl);
 static int serdev_drv_probe(struct device *dev)
 {
 	const struct serdev_device_driver *sdrv = to_serdev_device_driver(dev->driver);
+	struct serdev_device *sdev = to_serdev_device(dev);
 	int ret;
 
 	ret = dev_pm_domain_attach(dev, PD_FLAG_ATTACH_POWER_ON |
@@ -411,7 +451,9 @@ static int serdev_drv_probe(struct device *dev)
 	if (ret)
 		return ret;
 
-	return sdrv->probe(to_serdev_device(dev));
+	serdev_device_resume_rx(sdev);
+
+	return sdrv->probe(sdev);
 }
 
 static void serdev_drv_remove(struct device *dev)
diff --git a/drivers/tty/serdev/serdev-ttyport.c b/drivers/tty/serdev/serdev-ttyport.c
index 17c18d4b0cb8..6e1134976996 100644
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
@@ -36,6 +38,9 @@ static size_t ttyport_receive_buf(struct tty_port *port, const u8 *cp,
 	if (!test_bit(SERPORT_ACTIVE, &serport->flags))
 		return 0;
 
+	if (test_bit(SERPORT_PAUSE_RX, &serport->flags))
+		return 0;
+
 	ret = serdev_controller_receive_buf(ctrl, cp, count);
 
 	dev_WARN_ONCE(&ctrl->dev, ret > count,
@@ -185,6 +190,35 @@ static bool ttyport_close(struct serdev_controller *ctrl)
 	return true;
 }
 
+static void ttyport_pause_rx(struct serdev_controller *ctrl)
+{
+	struct serport *serport = serdev_controller_get_drvdata(ctrl);
+
+	guard(mutex)(&serport->lock);
+
+	scoped_guard(mutex, &serport->receive_lock)
+		set_bit(SERPORT_PAUSE_RX, &serport->flags);
+
+	if (test_bit(SERPORT_ACTIVE, &serport->flags))
+		tty_buffer_cancel_work(serport->tty->port);
+}
+
+static void ttyport_resume_rx(struct serdev_controller *ctrl)
+{
+	struct serport *serport = serdev_controller_get_drvdata(ctrl);
+
+	guard(mutex)(&serport->lock);
+
+	if (!test_bit(SERPORT_PAUSE_RX, &serport->flags))
+		return;
+
+	scoped_guard(mutex, &serport->receive_lock)
+		clear_bit(SERPORT_PAUSE_RX, &serport->flags);
+
+	if (test_bit(SERPORT_ACTIVE, &serport->flags))
+		tty_buffer_restart_work(serport->tty->port);
+}
+
 static unsigned int ttyport_set_baudrate(struct serdev_controller *ctrl, unsigned int speed)
 {
 	struct serport *serport = serdev_controller_get_drvdata(ctrl);
@@ -289,6 +323,8 @@ static const struct serdev_controller_ops ctrl_ops = {
 	.get_tiocm = ttyport_get_tiocm,
 	.set_tiocm = ttyport_set_tiocm,
 	.break_ctl = ttyport_break_ctl,
+	.pause_rx = ttyport_pause_rx,
+	.resume_rx = ttyport_resume_rx,
 };
 
 struct device *serdev_tty_port_register(struct tty_port *port,
diff --git a/include/linux/serdev.h b/include/linux/serdev.h
index 0f4e81c0950d..02773554e759 100644
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
2.56.1

