Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1CB923536B
	for <linux-serial@vger.kernel.org>; Sat, 20 Dec 2025 18:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766256251; cv=none; b=FjlM4uESw7uwg51CgX7JNSTA9+zzUyVxr157FzMNKGyW3YYiN53cE7qGX/wlMKuQ/t9AquldvZMnq0iAJsZzlreMRIj4HLCBug0zcsWR1J8TF3P7oPIi8aBEunIcUAV0k9xCfCvIzfyQJrNb5zFMPFruBsZY3TMv5S5pnRgHwEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766256251; c=relaxed/simple;
	bh=N5q2aEiYe7dgto/kG9UiDYXhU/zMXYlCm50QX5ilJsE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hdohsT49auAXavVU9T2sqCly3/tjLSiaxwOjCkEo8l8/9bEn+zmsmNrwOFheHYOH2c9PsSuELdfevJ2yP5/fuLsg7G/DUpZR+ImkicZIod737SHiGCG9VrBD4sWArLoROR5thDL2yAK05CpRgVipfpI3E6ymmPKpKEbiibThPqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=c4nDwN9a; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="c4nDwN9a"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 081E224002D
	for <linux-serial@vger.kernel.org>; Sat, 20 Dec 2025 19:44:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de; s=2017;
	t=1766256246; bh=IvztXzr5xSlHP9rpeQ5k1NFXGf6NuK8FLPWZGuMt0S0=;
	h=From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:To:Cc:Autocrypt:OpenPGP:From;
	b=c4nDwN9aebbDi6Pk0uwxKQgMcQJV2t6EgIG93DFKX4SjEezNf9LmtW1FBXhPkr401
	 uhysKbqHZGahaycHhyo87xBY20rcCQpHlihQfHEoytwpTu3gHZeQCd5Mrp82aYmULa
	 eWwuvleYB+9Yc+p1vC547ilUporotuIwt9ZwY1mr/I06+754gsBaab99Jh7bdxNkU+
	 eqg2NPmueY2GmmTQY00EV8fzNy1xsyTqmOJSyXFcC/rrQLGWqw0gbqo4VCiX4DEcUD
	 svOVyFNNoVjhY+XWtOdNprEUGybzjIhEf8Y56MP6/rOjuvG++vldUmvNOdsxR+0fzo
	 rw9WJdu7QceBg==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4dYYGD2Tl8z9rxN;
	Sat, 20 Dec 2025 19:44:04 +0100 (CET)
From: Markus Probst <markus.probst@posteo.de>
Date: Sat, 20 Dec 2025 18:44:05 +0000
Subject: [PATCH RFC 1/4] serdev: Export internal is_serdev_device() for
 drivers
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251220-rust_serdev-v1-1-e44645767621@posteo.de>
References: <20251220-rust_serdev-v1-0-e44645767621@posteo.de>
In-Reply-To: <20251220-rust_serdev-v1-0-e44645767621@posteo.de>
To: Rob Herring <robh@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Kari Argillander <kari.argillander@gmail.com>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, Markus Probst <markus.probst@posteo.de>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1853;
 i=markus.probst@posteo.de; h=from:subject:message-id;
 bh=dYFpooORdHMyhcZP4v33hyOyTm3wYSwyKARxxeg2xIc=;
 b=owEBiQJ2/ZANAwAIATR2H/jnrUPSAcsmYgBpRu5yl6wQmQUeaaTJM4cF/Q03svMC58ZXTxkQ8
 tEFtxj7ODSJAk8EAAEIADkWIQSCdBjE9KxY53IwxHM0dh/4561D0gUCaUbuchsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMSwyLDIACgkQNHYf+OetQ9JFzA/+OsLIgvC+njN1ddsjPMl+QJCmHCg6Ibi
 fCuHCmGgIaAgTku4IwW9j225EBAjVAAN8sS0R07fTZpdAuYDzK7xTOtl4mPJj9Z1UvO/1THLrMy
 WUp3uHeByhRcsy2MxrzKJOk+GznMA4Nq3A8yKaRMf9pnLyKC7yDrcjvPNirCDjE4ebrWmLORrDJ
 UNay7UFMCvKWwdlySNkNPReyJC6JfZtxV+vdYZjyhG9QqgFsbsOyGpHac6YW46K5cIXxWLReOx0
 ZOATSsyCqutWrG/D4zkSqEeXax1k0yow4ZR2JX2a0y32iHdc1NXZNVb4SbuYoudcs/AqhmvWp4i
 j+V2YQvk3+t7i+25Jc0dEAd7Y3J0i5NsrcWJEDTQmLMQiZW2jKmD1W4gdA2pJx5PFXc7u1bu+vS
 +Zxo3rCpf/PKwBaDXzyEOqUBxY+3juvA/rZlsy9Hjmp4Bf82NHXpKxhqL3VoZiw86iPu3wvj/AR
 Hbwj11GJNr3bmYW1+L7+0BqPJzi6dytZbf5geoK+YxSZdaf/9SPejKM+iE1c2WIODqg8pfBsInq
 nwocIfdcoAFykGZ7kc9E5gBNjnN0PNShDNXJcjbQ6QLxex6E5mtePU7bUHpoHs0Cnz4Gg5bFghY
 Rr/1t5L/CJ8EZpDJg5s88liGgaQaTMjTTMBsqzJE1UGQd0LuQn0c=
X-Developer-Key: i=markus.probst@posteo.de; a=openpgp;
 fpr=827418C4F4AC58E77230C47334761FF8E7AD43D2
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
  keydata=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
  aBeNN4ijKZchBXHPgVx+YtWRHfcm4l8=
OpenPGP: url=https://posteo.de/keys/markus.probst@posteo.de.asc; preference=encrypt

From: Kari Argillander <kari.argillander@gmail.com>

The serdev core has an internal is_serdev_device() helper, but it was
not accessible to drivers. Make it public by declaring it in serdev.h
and exporting the symbol so that modular serdev drivers can rely on it
instead of duplicating type checks.

This allows example future Rust serdev abstraction to have

    TryFrom<&device::Device<Ctx>> for &serdev::Device<Ctx>

That way using bus is easy for other substystems. Also some other
subsystems expose similar function:

  - bool is_usb_device(const struct device *dev)
  - bool dev_is_pci(const struct device *dev)

Signed-off-by: Kari Argillander <kari.argillander@gmail.com>
---
 drivers/tty/serdev/core.c | 3 ++-
 include/linux/serdev.h    | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
index b33e708cb245..1f6bf8e826d8 100644
--- a/drivers/tty/serdev/core.c
+++ b/drivers/tty/serdev/core.c
@@ -69,10 +69,11 @@ static const struct device_type serdev_device_type = {
 	.release	= serdev_device_release,
 };
 
-static bool is_serdev_device(const struct device *dev)
+bool is_serdev_device(const struct device *dev)
 {
 	return dev->type == &serdev_device_type;
 }
+EXPORT_SYMBOL_GPL(is_serdev_device);
 
 static void serdev_ctrl_release(struct device *dev)
 {
diff --git a/include/linux/serdev.h b/include/linux/serdev.h
index 34562eb99931..0043b6cc6d01 100644
--- a/include/linux/serdev.h
+++ b/include/linux/serdev.h
@@ -116,6 +116,8 @@ static inline struct serdev_controller *to_serdev_controller(struct device *d)
 	return container_of(d, struct serdev_controller, dev);
 }
 
+bool is_serdev_device(const struct device *dev);
+
 static inline void *serdev_device_get_drvdata(const struct serdev_device *serdev)
 {
 	return dev_get_drvdata(&serdev->dev);

-- 
2.51.2

