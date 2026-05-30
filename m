Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4DAE3BF66D
	for <linux-serial@vger.kernel.org>; Sat, 30 May 2026 17:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780162611; cv=none; b=HQ9JX+KNXNeYbL3ChA8HwXl/h0c46Ak8Io9iv3KdLDZ5WcbB9io2F8+U1Vsvackmlo6WAyhkhaXjKCiH1sYt/Lm1FFiMoJaQpiplQ3p4wrx0k6/9Z4/Tvw86ZCwa1vPptaxIxfjINF57OkFbIHs78JuFZkFoDoQvbksZ+511RV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780162611; c=relaxed/simple;
	bh=P+qqzzRwhI8B2ZhOfr+PVqRWtfVtS9KesBahL8YX4uk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LHkr2yLxsbMmGvA194mjn1zNAz761w7kX49XgtSmz9ftUUpKafSGnT7SAWct3dTCGxlBe+aMSVlY23+WhjIbYB5wbRE12SV6AR4pq+iu79DO0knVGC+R5AJ5MYeIcikjc1yPZBw4t86TuISL8T3yzZCO5Rogsp6S4ZTjHFoU83E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=r+2Jebq1; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="r+2Jebq1"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id C808224002D
	for <linux-serial@vger.kernel.org>; Sat, 30 May 2026 19:36:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de; s=2017;
	t=1780162607; bh=SqEDsvTehTsmlHRK3kcALX6aeWf55kfJ4Kqinm0z8bs=;
	h=From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:To:Cc:Autocrypt:OpenPGP:From;
	b=r+2Jebq1Q39gri7G7hsVWTCYlXvsmiMaiAmIaE0YvQCN/U/uZBM7JnLS9rVwK0t0b
	 l27Sq6ps66SrbDEfPLmNkyPlm9axOXlHcAUXE1XnxtiP+mj3D8XUcOhF83rLNvgcqc
	 xqoqm2DP3HK0h9ggCHnQT8G+eDtevfHCVntSe6jQ0tXF7M5pNWHr0RV3H2nUCdLgji
	 7uzWkK4MWBIklnLSYiFkqMpzLuNZ/9q9c7dW+tYIYENXLyqJn4OZUfHA4H5Af69ApP
	 M82/xJPgLVFkrdLuHC42a7nmwsbRkeLHfeODO16wGkxTP3zBXrKVhfFLoJ/HmvypD1
	 fDfHqmyc6f6fA==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4gSS8F3zcQz6v0W;
	Sat, 30 May 2026 19:36:45 +0200 (CEST)
From: Markus Probst <markus.probst@posteo.de>
Date: Sat, 30 May 2026 17:36:46 +0000
Subject: [PATCH v9 3/3] MAINTAINERS: serdev: Add self for serdev
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260530-rust_serdev-v9-3-f8b5fccb49c3@posteo.de>
References: <20260530-rust_serdev-v9-0-f8b5fccb49c3@posteo.de>
In-Reply-To: <20260530-rust_serdev-v9-0-f8b5fccb49c3@posteo.de>
To: Rob Herring <robh@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Kari Argillander <kari.argillander@gmail.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Boqun Feng <boqun@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Boqun Feng <boqun@kernel.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, linux-pm@vger.kernel.org, 
 driver-core@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 Markus Probst <markus.probst@posteo.de>
X-Developer-Signature: v=1; a=openpgp-sha256; l=838;
 i=markus.probst@posteo.de; h=from:subject:message-id;
 bh=P+qqzzRwhI8B2ZhOfr+PVqRWtfVtS9KesBahL8YX4uk=;
 b=owEBiQJ2/ZANAwAIATR2H/jnrUPSAcsmYgBqGyAoIhcUAaSlDU2MlqRCuJT00LUPuu+MYG0LM
 TM7Soucq4WJAk8EAAEIADkWIQSCdBjE9KxY53IwxHM0dh/4561D0gUCahsgKBsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQNHYf+OetQ9KybxAAopWipcmgIHW1ywDTnzBJoXkVvvDO6kO
 E0Pl/VlkFAx+6LUyHPscLhoF8OX7H706N+UDTC7gLfeXmK77gwM3VVaQpfqhpOKyUgbFfXNg3wM
 mcn2Tr1S0HX8mbE/DB3xdOHAW3acSi4CjvWewQbTIsAKvtIDE7PlKi1LkulAA04Ja7HKTYGtvj3
 mjiOqN8U7p6Atic/VQxhDKwcXfNDhzMaSBSYvsAU/mgSS6gbWHnpaMkHPocz8SZcr6kT9+n8Z/O
 fj05eLe+Y+AzKSl3VjBTVAHRzxRV1xaJ1sZYCR4Xa61yIekwCP6OwGd6B+Psc5GiA+vdBlXnepy
 R0jQ0kwDLAS5xEFJUpfmg3A3o24ZHHLgTHvvWes0WsYpRL5b1bPgs8HGCwX4dH280kwoXYvqavW
 04UHzPGkT/2MZhgcNySEZoDlULZ2NGz2Yy+VaYtqA3DStGrp4Omf6FVfj6O042awJZljYrzvUV6
 ONTRBTgrly99Ylr1CCbmXCSXEL1+xt0xy8Y54r+8dXKXVOgAryh/r59H8sFTMjPcSiF/fvH9Z4m
 EbkYmtz7VF5Oh/Zp+EJUwdJcahJrSa5lQJlc9dmb6s3SBNuLN84aeR/OWPSnGds9sn+TtLuqk8i
 QU3nMUdoOx4BaK7sMSokDnwUfm2LQG91Y5jF6MUlWJoQPwQf6/Cc=
X-Developer-Key: i=markus.probst@posteo.de; a=openpgp;
 fpr=827418C4F4AC58E77230C47334761FF8E7AD43D2
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
  keydata=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
  aBeNN4ijKZchBXHPgVx+YtWRHfcm4l8=
OpenPGP: url=https://posteo.de/keys/markus.probst@posteo.de.asc; preference=encrypt

Rob mentioned he needs to find someone else to maintain serdev.

Link: https://lore.kernel.org/rust-for-linux/20260430195858.GA1650658-robh@kernel.org/
Link: https://lore.kernel.org/rust-for-linux/da85ceb81f51079d4a8248a1ffde6a27d2ef24ad.camel@posteo.de/
Signed-off-by: Markus Probst <markus.probst@posteo.de>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index fa3f20f0cc4f..58db6aedf45a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -24270,7 +24270,7 @@ F:	drivers/iio/chemical/sps30_i2c.c
 F:	drivers/iio/chemical/sps30_serial.c
 
 SERIAL DEVICE BUS
-M:	Rob Herring <robh@kernel.org>
+M:	Markus Probst <markus.probst@posteo.de>
 L:	linux-serial@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/serial/serial.yaml

-- 
2.53.0

