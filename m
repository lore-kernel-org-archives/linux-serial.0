Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.67.36.66
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792669898;
	b=vYCgSqBoF0IRzdea1kxHMxrqZaA4USVceCTcurtaea0J9eHGzjcLc7ajt7LRKlVt/lA/
	 p/umwdB5a4++hlyqrG8Gxrm8URIZHU/mkLbZeerR6q8M14F+ZdPUCzktrKd4NgE3vg3uZ
	 M9XEQRUZ0P/ViFhICHO0k8R7VD3UXVLM6XQ+NfJ3hyN7HtrIrlP0vPVhQw/ppo4IESEYZ
	 fZeHEjNNXaLR2ZpCA/5RQxrdVaL8TaLB2yfLS/efO9i4ZkNVgLWqRrhPXGwt32SvZZsvV
	 q4AZrH7YkJ0x++tD8cbQ+ExPRtBSeFPGXd1AFg4EwbQD4Jtkva2yiUTVLKRm7bLIyrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792669898;
	h=DMARC-Filter:Received:DKIM-Signature:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Developer-Signature:X-Developer-Key:
	 Autocrypt:OpenPGP;
	bh=5Wa+jB46T/psHrPfUTpKP4YlCYHokeX6xqGnHidnuSg=;
	b=jDNm7OwkR1xRI483WjfqWlAokyBAcx/AhvoNjh75dYDyIFA2m0WaE+D9HUVkoSIPgAEj
	 B9OJGDiYmZvKfH9KtO9N5rctgsu2Itsvba9DdigGOYkM6zhe8ijL1Relkpr0mOcGwXBmL
	 QzpdI+ZPhPZtsnBGJ0Ndir9PTn7w4wIdZXaUS70awm+STLMF5Mgpvp713yBAwCjHBWK/1
	 VUKWVjKlgDsB07ZGDm5qf0C0lfN51pQa8hPum+agawB3yIAACfvnf+womIXq77UAJsADm
	 mz2/fSa9qGCfxJaZn5tfNCuTaVbr0Nx3hXWJ6cuXKupdbic+rfONT8AErpHWcpyPqhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=posteo.de;
	spf=pass smtp.mailfrom=posteo.de;
	dkim=pass header.d=posteo.de header.i=@posteo.de header.a=rsa-sha256 header.s=1984.8680eb header.b=b2NJBvk2;
	arc=none smtp.remote-ip=185.67.36.66
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2ABA606A329
	for <linux-serial@vger.kernel.org>; Thu, 22 Oct 2026 11:51:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B2ABA606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=posteo.de header.i=@posteo.de header.a=rsa-sha256 header.s=1984.8680eb header.b=b2NJBvk2
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 429AC24010A
	for <linux-serial@vger.kernel.org>; Thu, 22 Oct 2026 13:51:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de;
	s=1984.8680eb; t=1792669896;
	bh=5Wa+jB46T/psHrPfUTpKP4YlCYHokeX6xqGnHidnuSg=;
	h=From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:To:Cc:Autocrypt:OpenPGP:From;
	b=b2NJBvk2zQ3FWFXX3dcz3ahMP8k4c7ZSb3OMdtMiurf8VaQD3TlDe5dansUXbnrjK
	 pRI2/wiLcC9yrDscXpscrP8uKINNoPLy4jQRUytwNwtXi0QBa8K6cyNrlMgDoppfz6
	 JYyblAwRLeK2NPYsZKIKGppzrPIU5ZWxQl09pjMmeuV7yXIS4xOiuZCbBC6/Pck2hJ
	 MqtsMQLp/4FDa+kolNFO5tzY5bi67kEHdeBLbqD7TAqNRcU/VC1y2GDraY8Fw1/37/
	 IUnVWxW/d4hjFqDM9BotmmxFK0/tL3x6TEEjA/IOcdUAQNnhN3917DzHhOSkpcjSYt
	 7ooq+57MTf8AA==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4j9Pd03MKCz9rxM;
	Thu, 22 Oct 2026 13:51:32 +0200 (CEST)
From: Markus Probst <markus.probst@posteo.de>
Date: Thu, 22 Oct 2026 11:51:34 +0000
Subject: [PATCH v5 2/4] tty: serdev: Export functions to pause receive_buf
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
Message-Id: <20261022-rust_serdev_probe_refactor-v5-2-a27d862a415a@posteo.de>
References: <20261022-rust_serdev_probe_refactor-v5-0-a27d862a415a@posteo.de>
In-Reply-To: <20261022-rust_serdev_probe_refactor-v5-0-a27d862a415a@posteo.de>
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
 bh=TBEbgKOahK8kpVp88wqvmv/91b5jYLtnVvGf2tHuz4k=;
 b=owEBiQJ2/ZANAwAIATR2H/jnrUPSAcsmYgBq2fi+Bqgij8RdrzDtg7mPSPGO055Q7+5HNm3IG
 Xif1xCg2UuJAk8EAAEIADkWIQSCdBjE9KxY53IwxHM0dh/4561D0gUCatn4vhsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQNHYf+OetQ9L/Ug//daH9RZgDWNZYQxrfFNvaQ0wmv5Q841c
 t63byVRLuzVTAvg75v9H1KVpx1CCJK/gIll6wMxbILCSgqbvWpQdXw/PkTZky15GtvDLe0LdHdk
 p7aVY4x+eBeYxIdESPaYdbWhKgxx8MusSScEwJLzzQswrGqPG+ZzBmqurc0mw+bCHwsHn/qzDWR
 XDQzkefJ0cU7S38Pn6Us6iF1YuMrb2hEyERvWmkXuwlpqtWeIUcKpM04NnFNVdIP7w7T2XYMvYG
 ruU5ZtaeeXxJPrSwfMy13SvseTXNBSgQuAGdSU6uSYgQ7HIYC2a01QlX9xt+PcLXAj94f3oliv2
 9pu31zeWeIlTvr6YKe6jhVSrFYqDMGOzsBxJpIL4FRsaiFiRl72wYcW0lHE4jNL3bhP5iESZy4W
 /TYVeoOFPOaxkNC0apNXxDx7c/3RojG/ianhaUTfu55cL8r8n865bAl1UNhIiHWg8tN514oPsU2
 GkvnMYt29JiDNd7G+tZQ+jinPUBN3pUDZt56FQ6HTL5A463D+yLerEmGkx38qEDxH7aviladQDA
 8+OIpjmpMggvP564BHAlhnL6uRpnUnc6cewFfHBm1GOEm+CoOL7eRbKniFxyCrjF7KhKEhDuVpk
 VBhZb/yUYoEUJ9Grz8aeul4iuA15g1qpyx7rChXCB0sSn5D4s2U0=
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
index 77e8e1d4d2a6..af1470e33620 100644
--- a/drivers/tty/serdev/core.c
+++ b/drivers/tty/serdev/core.c
@@ -191,6 +191,45 @@ void serdev_device_close(struct serdev_device *serdev)
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
@@ -402,6 +441,7 @@ EXPORT_SYMBOL_GPL(serdev_device_break_ctl);
 static int serdev_drv_probe(struct device *dev)
 {
 	const struct serdev_device_driver *sdrv = to_serdev_device_driver(dev->driver);
+	struct serdev_device *sdev = to_serdev_device(dev);
 	int ret;
 
 	ret = dev_pm_domain_attach(dev, PD_FLAG_ATTACH_POWER_ON |
@@ -409,7 +449,9 @@ static int serdev_drv_probe(struct device *dev)
 	if (ret)
 		return ret;
 
-	return sdrv->probe(to_serdev_device(dev));
+	serdev_device_resume_rx(sdev);
+
+	return sdrv->probe(sdev);
 }
 
 static void serdev_drv_remove(struct device *dev)
diff --git a/drivers/tty/serdev/serdev-ttyport.c b/drivers/tty/serdev/serdev-ttyport.c
index 7d2d50d7e1a4..8fce7daa619f 100644
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
@@ -183,6 +188,35 @@ static bool ttyport_close(struct serdev_controller *ctrl)
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
@@ -287,6 +321,8 @@ static const struct serdev_controller_ops ctrl_ops = {
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
2.55.0

