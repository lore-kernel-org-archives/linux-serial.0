Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9844F5733E
	for <linux-serial@vger.kernel.org>; Sat, 18 Jul 2026 12:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784378873; cv=none; b=KGuBe+sYN0pOB1s3Kc+mWPW8bFrNbb+bQej6Xtt1yP3l+8Ak8vGRqSKl21arByaX1dY1hg7cpx1vMkAn6UcUxczQeB3NGkwJ4CgDnV7gbCJ0PKDZo682bgLQv2kxOTsRjEI/JvAFfA+L58n0zPETHlb2l20dl0v+/OG5VExdorE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784378873; c=relaxed/simple;
	bh=Ut/IRZsxXHW6O61T2pDCsBqDBfWdqPE0u1OY+IFn1Us=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=j9cZjRJ+81V0NTQ1nA2UNDdaNrqmq4u+23PPiARh22rC8c08vCMHr9dBphxatiFl+UlPSmo4sRmls3BsoCxvwr7/EXuODP4/XuozTOBEaaezwD9wVUqSE/Hc6gQ3qzPysSoeivpOxJGSxSwQ9+vsIiONrK1yGX3B4OXMfbBj5fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=Hfo5rWCP; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="Hfo5rWCP"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id C562F240105
	for <linux-serial@vger.kernel.org>; Sat, 18 Jul 2026 14:47:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de;
	s=1984.8680eb; t=1784378867;
	bh=aqspqbMtap3MyUHvygE65AWMHG91QJ7438aDXiT20PA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:To:Cc:Autocrypt:OpenPGP:From;
	b=Hfo5rWCP3ny+crTIZ3nIe5aV0oWFjn4lFPoNppQ5Cl0iynOUM8Hj36jJdUmBh0q8V
	 8vWgDRYXQpIGvWJURUTy4BSQG9ucj2VN4M7fnXUUejxPZzfR9UX44PUDPjON/c37dH
	 0xG/lcOn8zxoWfi1jbW/bUCdpw8KE3bYDu0jgK91BkMrMrqpNKZTh5w0I2lqx66qAg
	 5h/Wsja4QBKL7YfkF6d1HJsdDNKTFdfGab574FW9fihwwaLd/3lRUvYas18GUl8DLL
	 3bx3S7s99mWo+I6floEkYmhDLyPTPjYhTgoZgjQhRW7Jkvzi57xLWRkTXfcaTUMTR3
	 NLaWTiHDmbwkQ==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4h2RQ944V8z6tvx;
	Sat, 18 Jul 2026 14:47:45 +0200 (CEST)
From: Markus Probst <markus.probst@posteo.de>
Subject: [PATCH v2 0/4] rust: serdev: trivial fixes
Date: Sat, 18 Jul 2026 12:47:46 +0000
Message-Id: <20260718-rust_serdev_fixes-v2-0-e5214e03de13@posteo.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22OzQ6CMAzHX4X07HSAinLyPQwhwIrWRKbtWDSEd
 3eABw/e+kv/XwMIMqFAHg3A6EnIdgGSVQTNteouqMgEhkQne53FmeJeXBlMBn3Z0gtFHeuq3bV
 prJPsAMH3YJwfwXYuFpa+vmHjpqCvgvHZhzK3yKCuBFVj73dyeWSYPHJAxs3PrYLYUXeBKfRK4
 iy/590+njO+Ew9/JvpYaZXutmla702Duj09rDi0a4NQjOP4ASw52pMHAQAA
X-Change-ID: 20260717-rust_serdev_fixes-9baf5f310278
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>
Cc: linux-serial@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Markus Probst <markus.probst@posteo.de>, 
 kernel test robot <lkp@intel.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1102;
 i=markus.probst@posteo.de; h=from:subject:message-id;
 bh=Ut/IRZsxXHW6O61T2pDCsBqDBfWdqPE0u1OY+IFn1Us=;
 b=owEBiQJ2/ZANAwAIATR2H/jnrUPSAcsmYgBqW3XpUJy8feyPI6HSGOPW5AGwbaYJxcng7uUW4
 JQr0OazaMaJAk8EAAEIADkWIQSCdBjE9KxY53IwxHM0dh/4561D0gUCalt16RsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQNHYf+OetQ9IJfBAAts1/ifBxizf9uCgCTS8lejNZn560srp
 HA1dCtUf6HHZgstf0w0A0MOV/w/aozYdGH2KGY/3dxnsk/XG9lsWsqqO7LHHrA17BQ09knvvx/3
 IlLw7v9AJ55hF5jDyIa9aGtIJiyKbamWSjK3/htVtvhY5fPV19XF4eLpxtO4gIjV99uMN1CY4FN
 DCCxk7vFLXpjlonAjvqMQ4oUMPBWumpRiNOAqNXVc6i5urU//alg2R22IKBCv3vQxLGzsvD4hrj
 67T/3zBNDBRuhv9fNGsPxGMt4ypzhH725rVi7P9BGhLuPnA9CNt9AY7+5192JfTpb6scp4XgisL
 bifINyQGpFymvfUNII0lisFHCp9KdV2aDOvUzF6HVQggtuHq7kOWLHwfI9YbdsYm/L59bSL62sF
 z1jjlVr0BnML5Jll96azxhdN+Zd5k9XWKibS8dd0eDgFYOUS8JjfV80I03EwP1RZW+gVFXV+nhL
 ODclIKTCTi6CXb1nQ6rJXekEmzjI5UQ10T9lfmrRQ+8Vstlp5LmnVGvQrutICoMDoVN5VZbdRyo
 Qm/PArakNSqqJFvbBRz8PLSMQbazdNNFy6PAT66+Bp4Y8C26lzZapElk/gLtxOcC+P+le5sk2f4
 OCgpKzrQLjt34/alCSDDPJDWJIel4Kt+YJYvKkGRPCyP/kIgK+ko=
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

Those are small fixes discovered by the kernel test robot and Gary Guo
after the serdev rust abstraction have already been merged.

This includes
- a fix for a documentation typo
- adding missing `#[inline]` attributes
- a small structual change for timeout

There is no urgency to merge this.

Signed-off-by: Markus Probst <markus.probst@posteo.de>
---
Changes in v2:
- resolve Sashiko issues:
  - reword small parts of the `PrivateData::active` documentation
  - fix documentation references left to `serdev::Timeout`.
- Link to v1: https://patch.msgid.link/20260718-rust_serdev_fixes-v1-0-35433b6dce0f@posteo.de

---
Markus Probst (4):
      rust: serdev: fix typo in rustdoc
      rust: serdev: mark small functions as `#[inline]`
      rust: serdev: document `PrivateData::active`
      rust: serdev: remove `serdev::Timeout`

 rust/kernel/serdev.rs | 82 +++++++++++++++++++++++++++------------------------
 1 file changed, 44 insertions(+), 38 deletions(-)
---
base-commit: 25acf039a5dbb40b6865d9392e05be8e713a39f3
change-id: 20260717-rust_serdev_fixes-9baf5f310278

