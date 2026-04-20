Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C0E3CE49F
	for <linux-serial@vger.kernel.org>; Mon, 20 Apr 2026 20:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776715647; cv=none; b=B1QTgrncjakzvi+XW99N77/JkzpzqirYROpmgY8n204tKuX4ujmDhiBY+ZKc22eMzr9MqD+qorXmXGQ4ECNysoGYw7yN5uG420S28wGlpdchcuPqgEQVKsk+xDsW/EZuehnmypF3+GbevVIht6K1Tv1X4wZ5NPPjLIKN32//8+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776715647; c=relaxed/simple;
	bh=ECl35l4KVjDGQ1987vPeXlJAH328JZDbp6x8p1+V+Tw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sMiGRFjZWI+ZUVuqZCg8U556/+WmDcTmPW78fif0klQV8zdgSf0+60cJNVQoWY1k32Am7nKlDx8GDHlQZqYbK55XD0Yg7AvNmZfnqkMuz2eA1tqlLBxzX8Q6sGarRrmFHXrLZ99aXpC+WV1Bzd8kAoo8eGguBdFNGzKRm4KFPi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=C9jC7fvc; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="C9jC7fvc"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 2AF79240103
	for <linux-serial@vger.kernel.org>; Mon, 20 Apr 2026 22:07:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de; s=2017;
	t=1776715644; bh=75iCErYdyp9Wiyr3L13jLe2X/q5ye8h5xDYdqwVoNnc=;
	h=From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:To:Cc:Autocrypt:OpenPGP:From;
	b=C9jC7fvcSWDKE0/nygIIUrJhLbQS2vpQC4vWYnG+2q7WbCleL+PLxl4r9fgzcdAdB
	 xjt0JByazirBydUcx7GIx/5BvgLNYKX5u93LQACA+EKhYb/iLcRqourynjp/eeDYII
	 DQYs2XClCXKqlFGhTbHsCIb3gKPTtE/G/9xjsYUT9V4dRvvuaY6OoGKAbOgvapidTU
	 Sqy/1HArPszkqipWFUY68Q2waChbP+QdACRoV9pi59HiRscn1ppR6aR8byEv/EZnjF
	 iZD9HiAHTNATyFycQaoZ1rcbH/sN/fFmWKM7xZflsyEFrUEPEk/gdPy3g6qS5WT5Az
	 Z8vxI7hBs5N+g==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4fzxNT6Kc9z9rxP;
	Mon, 20 Apr 2026 22:07:21 +0200 (CEST)
From: Markus Probst <markus.probst@posteo.de>
Date: Mon, 20 Apr 2026 20:07:23 +0000
Subject: [PATCH v5 2/4] serdev: add rust private data to serdev_device
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260420-rust_serdev-v5-2-57e8ba0519f3@posteo.de>
References: <20260420-rust_serdev-v5-0-57e8ba0519f3@posteo.de>
In-Reply-To: <20260420-rust_serdev-v5-0-57e8ba0519f3@posteo.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1717;
 i=markus.probst@posteo.de; h=from:subject:message-id;
 bh=ECl35l4KVjDGQ1987vPeXlJAH328JZDbp6x8p1+V+Tw=;
 b=owEBiQJ2/ZANAwAIATR2H/jnrUPSAcsmYgBp5od1wFU2BjgkAwCXkHSHrQ6mmOtQhPWG0ZSjR
 iYFsdtqevOJAk8EAAEIADkWIQSCdBjE9KxY53IwxHM0dh/4561D0gUCaeaHdRsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQNHYf+OetQ9IA9Q/+KliGPWJYDKmrtnnvitJ3KvTF9WNFZyM
 BwUW1VKH3OdFheSJ5Nz7VHExfcnD9B0+g2G4i3D1L+p3JqEflJpav9g40/27gUJfMboTheu8q0T
 azs9S6Q/AnNBdEmix6wDtbdsbTP5LwOx2QRO/BWJG6rVmy+09o3jgzVaIow/Ghc9pfaF84gWM1S
 EjD9lLzAF7FBSk3TYIACahmVSuREQme4pkgkRfKwgOFw1fWFyEpTYXZ8ZzRXovCBBXQfon73DW2
 v6T/R64ndQK8qjRA3XXOs03VB8JZEbsp3q/O52TFfpqS7uOKLAOjmXsjpCvctWSm+ojGQjTVZ0Y
 b/tjjV+lOT6tcdfxC7JA21hjtvXu8qOkSuqdPsSgNblTPf0m0v5RMpeYTccPpOYEoufLOIxZ9uW
 oYhozLqqCY+A7gyfUlKHECMaV2tcc3w1VUCTZbBpPe0RbPhARCzmytbpjGoMm7TUdC5TQ8ulaf2
 xGy2waTyB2r/SnXMz0fcMNV3lagyVf3HNl/C6+x9dZYW9pisPgeRhd4Pta/H7Mg+G/DnXMEAl77
 OBSjBO1RSaK27HzMPq6kpu014Al5bUSAbwqBpE73E1WgVcKN5/5Kht6rI6RnorxNWutHbPaJUqm
 5yDq673WGrmA7XmFt32YtZoznUoF57WPisNBQ20CZGGsS9kbZzQA=
X-Developer-Key: i=markus.probst@posteo.de; a=openpgp;
 fpr=827418C4F4AC58E77230C47334761FF8E7AD43D2
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
  keydata=xsFNBGiDvXgBEADAXUceKafpl46S35UmDh2wRvvx+UfZbcTjeQOlSwKP7YVJ4JOZrVs93qReNLkO
  WguIqPBxR9blQ4nyYrqSCV+MMw/3ifyXIm6Pw2YRUDg+WTEOjTixRCoWDgUj1nOsvJ9tVAm76Ww+
  /pAnepVRafMID0rqEfD9oGv1YrfpeFJhyE2zUw3SyyNLIKWD6QeLRhKQRbSnsXhGLFBXCqt9k5JA
  RhgQof9zvztcCVlT5KVvuyfC4H+HzeGmu9201BVyihJwKdcKPq+n/aY5FUVxNTgtI9f8wIbmfAja
  oT1pjXSp+dszakA98fhONM98pOq723o/1ZGMZukyXFfsDGtA3BB79HoopHKujLGWAGskzClwTjRQ
  xBqxh/U/lL1pc+0xPWikTNCmtziCOvv0KA0arDOMQlyFvImzX6oGVgE4ksKQYbMZ3Ikw6L1Rv1J+
  FvN0aNwOKgL2ztBRYscUGcQvA0Zo1fGCAn/BLEJvQYShWKeKqjyncVGoXFsz2AcuFKe1pwETSsN6
  OZncjy32e4ktgs07cWBfx0v62b8md36jau+B6RVnnodaA8++oXl3FRwiEW8XfXWIjy4umIv93tb8
  8ekYsfOfWkTSewZYXGoqe4RtK80ulMHb/dh2FZQIFyRdN4HOmB4FYO5sEYFr9YjHLmDkrUgNodJC
  XCeMe4BO4iaxUQARAQABzRdtYXJrdXMucHJvYnN0QHBvc3Rlby5kZcLBkQQTAQgAOxYhBIJ0GMT0
  rFjncjDEczR2H/jnrUPSBQJog714AhsDBQsJCAcCAiICBhUKCQgLAgQWAgMBAh4HAheAAAoJEDR2
  H/jnrUPSgdkQAISaTk2D345ehXEkn5z2yUEjaVjHIE7ziqRaOgn/QanCgeTUinIv6L6QXUFvvIfH
  1OLPwQ1hfvEg9NnNLyFezWSy6jvoVBTIPqicD/r3FkithnQ1IDkdSjrarPMxJkvuh3l7XZHo49GV
  HQ8i5zh5w4YISrcEtE99lJisvni2Jqx7we5tey9voQFDyM8jxlSWv3pmoUTCtBkX/eKHJXosgsuS
  B4TGDCVPOjla/emI5c9MhMG7O4WEEmoSdPbmraPw66YZD6uLyhV4DPHbiDWRzXWnClHSyjB9rky9
  lausFxogvu4l9H+KDsXIadNDWdLdu1/enS/wDd9zh5S78rY2jeXaG4mnf4seEKamZ7KQ6FIHrcyP
  ezdDzssPQcTQcGRMQzCn6wP3tlGk7rsfmyHMlFqdRoNNv+ZER/OkmZFPW655zRfbMi0vtrqK2Awm
  9ggobb1oktfd9PPNXMUY+DNVlgR2G7jLnenSoQausLUm0pHoNE8TWFv851Y6SOYnvn488sP1Tki5
  F3rKwclawQFHUXTCQw+QSh9ay8xgnNZfH+u9NY7w3gPoeKBOAFcBc2BtzcgekeWS8qgEmm2/oNFV
  G0ivPQbRx8FjRKbuF7g3YhgNZZ0ac8FneuUtJ2PkSIFTZhaAiC0utvxk0ndmWFiW4acEkMZGrLaM
  L2zWNjrqwsD2zsFNBGiDvXgBEADCXQy1n7wjRxG12DOVADawjghKcG+5LtEf31WftHKLFbp/HArj
  BhkT6mj+CCI1ClqY+FYU5CK/s0ScMfLxRGLZ0Ktzawb78vOgBVFT3yB1yWBTewsAXdqNqRooaUNo
  8cG/NNJLjhccH/7PO/FWX5qftOVUJ/AIsAhKQJ18Tc8Ik73v427EDxuKb9mTAnYQFA3Ev3hAiVbO
  6Rv39amVOfJ8sqwiSUGidj2Fctg2aB5JbeMln0KCUbTD1LhEFepeKypfofAXQbGwaCjAhmkWy/q3
  IT1mUrPxOngbxdRoOx1tGUC0HCMUW1sFaJgQPMmDcR0JGPOpgsKnitsSnN7ShcCr1buel7vLnUMD
  +TAZ5opdoF6HjAvAnBQaijtK6minkrM0seNXnCg0KkV8xhMNa6zCs1rq4GgjNLJue2EmuyHooHA4
  7JMoLVHcxVeuNTp6K2+XRx0Pk4e2Lj8IVy9yEYyrywEOC5XRW37KJjsiOAsumi1rkvM7QREWgUDe
  Xs0+RpxI3QrrANh71fLMRo7LKRF3Gvw13NVCCC9ea20P4PwhgWKStkwO2NO+YJsAoS1QycMi/vKu
  0EHhknYXamaSV50oZzHKmX56vEeJHTcngrM8R1SwJCYopCx9gkz90bTVYlitJa5hloWTYeMD7FNj
  Y6jfVSzgM/K4gMgUNDW/PPGeMwARAQABwsF2BBgBCAAgFiEEgnQYxPSsWOdyMMRzNHYf+OetQ9IF
  AmiDvXgCGwwACgkQNHYf+OetQ9LHDBAAhk+ab8+WrbS/b1/gYW3q1KDiXU719nCtfkUVXKidW5Ec
  Idlr5HGt8ilLoxSWT2Zi368iHCXS0WenGgPwlv8ifvB7TOZiiTDZROZkXjEBmU4nYjJ7GymawpWv
  oQwjMsPuq6ysbzWtOZ7eILx7cI0FjQeJ/Q2baRJub0uAZNwBOxCkAS6lpk5Fntd2u8CWmDQo4SYp
  xeuQ+pwkp0yEP30RhN2BO2DXiBEGSZSYh+ioGbCHQPIV3iVj0h6lcCPOqopZqyeCfigeacBI0nvN
  jHWz/spzF3+4OS+3RJvoHtAQmProxyGib8iVsTxgZO3UUi4TSODeEt0i0kHSPY4sCciOyXfAyYoD
  DFqhRjOEwBBxhr+scU4C1T2AflozvDwq3VSONjrKJUkhd8+WsdXxMdPFgBQuiKKwUy11mz6KQfcR
  wmDehF3UaUoxa+YIhWPbKmycxuX/D8SvnqavzAeAL1OcRbEI/HsoroVlEFbBRNBZLJUlnTPs8ZcU
  4+8rq5YX1GUrJL3jf6SAfSgO7UdkEET3PdcKFYtS+ruV1Cp5V0q4kCfI5jk25iiz8grM2wOzVSsc
  l1mEkhiEPH87HP0whhb544iioSnumd3HJKL7dzhRegsMizatupp8D65A2JziW0WKopa1iw9fti3A
  aBeNN4ijKZchBXHPgVx+YtWRHfcm4l8=
OpenPGP: url=https://posteo.de/keys/markus.probst@posteo.de.asc; preference=encrypt

Add rust private data to `struct serdev_device`, as it is required by the
rust abstraction added in the following commit
(rust: add basic serial device bus abstractions).

Signed-off-by: Markus Probst <markus.probst@posteo.de>
---
 include/linux/serdev.h | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/include/linux/serdev.h b/include/linux/serdev.h
index 5654c58eb73c..c74c345d60ae 100644
--- a/include/linux/serdev.h
+++ b/include/linux/serdev.h
@@ -33,12 +33,14 @@ struct serdev_device_ops {
 
 /**
  * struct serdev_device - Basic representation of an serdev device
- * @dev:	Driver model representation of the device.
- * @nr:		Device number on serdev bus.
- * @ctrl:	serdev controller managing this device.
- * @ops:	Device operations.
- * @write_comp	Completion used by serdev_device_write() internally
- * @write_lock	Lock to serialize access when writing data
+ * @dev:	       Driver model representation of the device.
+ * @nr:		       Device number on serdev bus.
+ * @ctrl:	       serdev controller managing this device.
+ * @ops:	       Device operations.
+ * @write_comp:	       Completion used by serdev_device_write() internally
+ * @write_lock:	       Lock to serialize access when writing data
+ * @rust_private_data: Private data for the rust abstraction. This should
+ *		       not be used by the C drivers.
  */
 struct serdev_device {
 	struct device dev;
@@ -47,6 +49,7 @@ struct serdev_device {
 	const struct serdev_device_ops *ops;
 	struct completion write_comp;
 	struct mutex write_lock;
+	void *rust_private_data;
 };
 
 static inline struct serdev_device *to_serdev_device(struct device *d)

-- 
2.52.0

