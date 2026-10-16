Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0C65AA664
	for <linux-serial@vger.kernel.org>; Fri, 16 Oct 2026 18:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792173644; cv=none; b=qEfwlK2k9mPV3gfpl5JxgTAuEVNuxZ7Esj5zv2HsrAqdchUvt+U47YJRYPYuwD8Ojmv4R2TEDpOUEW4FG1gqgOqi6C6E6uOGkw4jzYZ1KYC9aTyUzSwkymE/Mhs0PcmeG2UOq63Jf78LUUrHS6Q+0GN/QL8Cd7LG1jrSlvdxyfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792173644; c=relaxed/simple;
	bh=TcY/fwsvwWTyZGT4Q+t3XjtTaR0BxABgEPLqqJD8Ol0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a+N2hmhO5cuYwCYgjDfUWxuC+PPCCnRm6eU2VhdWZPaSpZ7rKtqk2bN8AucV4Xf9jdKdSlr0GglCPSa2hpbFcLsc6ShmcTivusbJYRcYYnapJxmwSC2MFeg4JGUsRxIvnGfxBp94lBe/4xJ4kXaa0pzKTg2gZagSJtCVWF5/jAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=a4M42SlC; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="a4M42SlC"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id A4C6C240112
	for <linux-serial@vger.kernel.org>; Fri, 16 Oct 2026 20:00:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de;
	s=1984.8680eb; t=1792173633;
	bh=ICDgGJRQLw9lW5mPqSb+6EHYmo3Fca+zvavA2Drr16I=;
	h=From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:To:Cc:Autocrypt:OpenPGP:From;
	b=a4M42SlC1KJZB/fXI+tb/XXozQnO9f1IjIx8CvHyVBrPca0xE15mitrCjPyr62yg0
	 jXsbgQum8qab2F2gUumqghlIl6GntYaWzM8fM5FJ4QA3KciiYCIpLIkkiIImNTteqP
	 4d+SWRHAaR0mhjmI02eN4w8tlcR4VPv/R0WWZg+NrqhDHAUbS0GAOSKRvwrOtQo8Gj
	 Oqsl5RhQYQtXpmnXWg7AN0s8zlzdFgZgzdJV25G4XHBXK1+WF64eI7lOS+P0ZEnvmA
	 9U3SAALSt88l65K6e27GJPHmMFlESrGFo4Q3xkU4DG049FHKpHdTHVAFb8ytrYLlq7
	 PySZL5W1vYtVA==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4j5t5T49Lqz9rxG;
	Fri, 16 Oct 2026 20:00:29 +0200 (CEST)
From: Markus Probst <markus.probst@posteo.de>
Date: Fri, 16 Oct 2026 18:00:32 +0000
Subject: [PATCH v4 1/4] tty: serdev: Add mutex lock
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261016-rust_serdev_probe_refactor-v4-1-46832e034757@posteo.de>
References: <20261016-rust_serdev_probe_refactor-v4-0-46832e034757@posteo.de>
In-Reply-To: <20261016-rust_serdev_probe_refactor-v4-0-46832e034757@posteo.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5400;
 i=markus.probst@posteo.de; h=from:subject:message-id;
 bh=TcY/fwsvwWTyZGT4Q+t3XjtTaR0BxABgEPLqqJD8Ol0=;
 b=owEBiQJ2/ZANAwAIATR2H/jnrUPSAcsmYgBq0mY4iygoYy5F91Yd8Oh74dJE6qds/6G2jV13c
 tGbZwWFx/qJAk8EAAEIADkWIQSCdBjE9KxY53IwxHM0dh/4561D0gUCatJmOBsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQNHYf+OetQ9JJoxAAh/QgZidUVSxiALIfcJ2P5+8jSXCoCXr
 6ia8cj4a5jIvH3ZAPlEo3cDcijnBPwG5nf594ZQ0hMW68sL881OcDzro38kcF9XLnOM1oBVJQrg
 j835uti6ka9HDnS878KK66r0A+H9iS/so+T8XmU3vDk8rACkccn7p8Smew3lkyRNUi1MFnudJLj
 ErGDPTChcIimout2DUDlwKkZf392+MuiywNFiykusGCKeS53Ai91RQ1oqhiPgRpY7hc4tJJJLbr
 3XlfsDGrXOK8XTLPaNWiUgKs4XCpUx2a2P+yhcUQpCpPVsh5jewFA8ii1R29g25qy8CxT/5ZI6m
 NqNo3a64j5j3gOG+z6spaO+CuskZ/5rWDGG2QvSYhu6qBjTooy6Jtel/WkJGeWnR4gDFOJAxHTS
 77sWR0ffrO9GGRkNS8zjaZeXDuWudlD3/cstbp4nWIp2/NYBlM/jl0Y6KJATkal+He4UQDXGisg
 +MS+zLQS/OIg/+ojyPuQtnt5rJx2itW3C0klL90SWpZDMhjxUn6sD7IDih7WYCcCNZs2meuo7PR
 4tyqGOnM68zeNs0s5guD+YnYBtcox4BYV8QQTBMFcPVLgtHwbFzzAKwL8OJH/t0F+JA1WT/nTLq
 DwZxMA5roK8vmrdz+V5gv6xMjU0SENyLUDlNA8H6YHhRWcosu9kk=
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
 drivers/tty/serdev/core.c           | 10 +++++---
 drivers/tty/serdev/serdev-ttyport.c | 46 +++++++++++++++++++++++++++++++------
 include/linux/serdev.h              |  2 +-
 3 files changed, 47 insertions(+), 11 deletions(-)

diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
index 7500efcdfc21..77e8e1d4d2a6 100644
--- a/drivers/tty/serdev/core.c
+++ b/drivers/tty/serdev/core.c
@@ -142,6 +142,11 @@ void serdev_device_remove(struct serdev_device *serdev)
 	struct serdev_controller *ctrl = serdev->ctrl;
 
 	device_unregister(&serdev->dev);
+
+	/* Warn if driver did not close the serial device. */
+	if (ctrl->ops->close && WARN_ON(ctrl->ops->close(ctrl)))
+		pm_runtime_put(&ctrl->dev);
+
 	ctrl->serdev = NULL;
 }
 EXPORT_SYMBOL_GPL(serdev_device_remove);
@@ -181,9 +186,8 @@ void serdev_device_close(struct serdev_device *serdev)
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
index bab1b143b8a6..125a17a0bea5 100644
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
 
@@ -99,16 +103,27 @@ static int ttyport_open(struct serdev_controller *ctrl)
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
 
+	mutex_lock(&serport->receive_lock);
+
 	ret = tty->ops->open(serport->tty, NULL);
 	if (ret)
 		goto err_close;
@@ -130,23 +145,35 @@ static int ttyport_open(struct serdev_controller *ctrl)
 
 	set_bit(SERPORT_ACTIVE, &serport->flags);
 
+	mutex_unlock(&serport->receive_lock);
+	mutex_unlock(&serport->lock);
+
 	return 0;
 
 err_close:
 	tty->ops->close(tty, NULL);
-err_unlock:
+	mutex_unlock(&serport->receive_lock);
+err_tty_unlock:
 	tty_unlock(tty);
 	tty_release_struct(tty, serport->tty_idx);
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
@@ -154,6 +181,8 @@ static void ttyport_close(struct serdev_controller *ctrl)
 	tty_unlock(tty);
 
 	tty_release_struct(tty, serport->tty_idx);
+
+	return true;
 }
 
 static unsigned int ttyport_set_baudrate(struct serdev_controller *ctrl, unsigned int speed)
@@ -288,6 +317,9 @@ struct device *serdev_tty_port_register(struct tty_port *port,
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
2.55.0

