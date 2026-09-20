Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B51D38BF76
	for <linux-serial@vger.kernel.org>; Sun, 20 Sep 2026 14:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789914609; cv=none; b=cnAi+Q8Ch90IlAd0SY9B7RrneGD4kp6Gx6tdMtJxqw4yJOKu9zHxaqaL7QgHAPEDPukX397BbvFb66sR++garCvhbPuhEwoxBpfJMwFh7/XsF0jyb9YU3CMJAEjmBETLMhVn3XBGwdOSElK9e0yA1Xmn91VNrVpDdsok2fCMtlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789914609; c=relaxed/simple;
	bh=gtrf5uOt82c7/rVU8WCA3r1r7MxeXQuRVqXxLWgqDhY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=lUK2CMgZhRNlhEWdXpysMdQu99Sw4aqVj0XxzcbQ0wc31kPTER7aCoRhU52CwELIAHuKeWaikMZSclM38TYTiV3dx68iTYH5V2raj5hW7IWmRnVGM7a19+uS54EUgjuVtjGBUteP3vpQres0K0nRpmN/9RLA3LM44pm1wUOl91Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=LSueVZAs; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="LSueVZAs"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 2704D240027
	for <linux-serial@vger.kernel.org>; Sun, 20 Sep 2026 16:29:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de;
	s=1984.8680eb; t=1789914598;
	bh=pgLhCZYOO/PX1JQd43YKhm+MmLsFri71XvNNQdR9VmU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:To:Cc:Autocrypt:OpenPGP:From;
	b=LSueVZAsUSrwmAIU6NwBNP1iwK+0jq4eGoUKVEmcR3XuUzZi2FQU0S0Dm1SNTl+43
	 9gVUj454ybImoMKTiv22k73cfkmVysSqJS9CqG+UNxccz3mPQG85008tyx5VkHWvbn
	 mJDrOd0csoTK/UWcuibGZtwq+JmR/VQrgXSWeaG5k37JOwH2VhktnmF7TWy0jzxIgO
	 ACA0/mK6s+rul4dvllUPJspDwtCBFhjUs3UycWEJvCroLu3oI155wbOTGkM86unR0n
	 lAKSRMMMW70dKllxiF6dYZ1uunS4EsTZrSXhJEg9XScAdifl3OG3TP98HnM6gnsnNe
	 Bm9uYLmsdYL3Q==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4hnpfT4g8dz9rxD;
	Sun, 20 Sep 2026 16:29:53 +0200 (CEST)
From: Markus Probst <markus.probst@posteo.de>
Subject: [PATCH v2 0/3] rust: serdev: Refactor
Date: Sun, 20 Sep 2026 14:29:56 +0000
Message-Id: <20260920-rust_serdev_probe_refactor-v2-0-43b855162f5d@posteo.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32OSw6DIBRFt2LeuBhE1NhR99EYg/BaaaJYQNLGu
 PfiZ9zhyf0u4NBqdHBNFrAYtNNmjMAuCchejE8kWkUGRllJa1oQOzvfxpDC0E7WdNhafAjpjSU
 UWUc5zwsuKogFU1T0Zy+/Nwe7uXuh9Fvj6bD4nuOqP2zQCYdEmmHQ/pqEKs2JlTls6V67OPLdn
 4ZsN5+nyn+nQkYoKWupBFJacZS3yTiPJlUIzbquPxMetNACAQAA
X-Change-ID: 20260905-rust_serdev_probe_refactor-0e2b044354a7
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
 driver-core@lists.linux.dev, Markus Probst <markus.probst@posteo.de>, 
 Sashiko Bot <sashiko-bot@kernel.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1273;
 i=markus.probst@posteo.de; h=from:subject:message-id;
 bh=gtrf5uOt82c7/rVU8WCA3r1r7MxeXQuRVqXxLWgqDhY=;
 b=owEBiQJ2/ZANAwAIATR2H/jnrUPSAcsmYgBqr+3gvTJr6cqaYfz5Vw3yhB7EWtEV/YdSs1AUD
 w6WJRBuo5yJAk8EAAEIADkWIQSCdBjE9KxY53IwxHM0dh/4561D0gUCaq/t4BsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQNHYf+OetQ9KW8w/9HuHjXeOcd92NBg6xAO19K/UFdTR7eDP
 YeteX4wugeC0F6B5C/Ieui0UTiUPkmEFEYPpNy60jJhnuxs+DEsgFXjvASmOL0Wjh1MmD5gqswC
 MovC3dbK2ycM7XR4JF5X6hxnX4wJr2ihAZRALX1Kf4HhZdxFPdH3uST5h37bLakHTUS0O6f7Dxo
 ECRc6t8pp4FwtaVX1+Sb9jhdd9DKFWtI9IS9c/SEJprzlcIX4DqgG/+07fjBzfF/5J1CYLYMZIp
 V63Mh8EGy+pOTP0o+o3NiSu0khNG+bAEiPN0yIJsVIOrip0s1cIj6QBVMA6gg996O/x5VA8Bagn
 2zWeY0GDo9vwdvOY6iQwatlSUIanP7HQ/mlc6HNvqM1FzXlaI+xq/Co78TauyjY0PXkHMj9PO0X
 9IuUlp7eKfJzYQhojxXMaIb059M1tcIiOLeNtqlhQDIytpJlgzoRfmx0+VN0B4PdWvWUfQNwa9a
 Qko141s0mEQMTxs+OA5dfQOBpbNjCUU/bLKFX7mKtlo1kSFUAry8ZzAx8DEBK/9OVnV/P2c6wsU
 0/wlVy+QprhY8DIgjftb8AZ6QM0/zOvfiTEILkBNssT2zeekiKWKGqw4XiBD7+VGm24eHxxNMHQ
 0O/Pgb6iNIAjmgsHXYFphnEU06fKgEgXk/lBXrfzGShLp0n6IdKA=
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

The following has been changed:
- introduce a new C serdev API to fix race conditions and simplify rust
  code. Should also be useful on the C side.
- fix race conditions
- simplify rust code

Signed-off-by: Markus Probst <markus.probst@posteo.de>
---
Changes in v2:
- fix missing memory barriers in serdev apis
- use `tty_buffer_restart_work` instead of `tty_flip_buffer_push`
- use `tty_buffer_flush_work` instead of exclusively locking the mutex
- add `#[inline]` to `PrivateData::driver_data`
- remove patches for mutable references
- Link to v1: https://patch.msgid.link/20260906-rust_serdev_probe_refactor-v1-0-69cdae0074ec@posteo.de

---
Markus Probst (3):
      tty: serdev: Export functions to pause receive_buf callback calls
      rust: serdev: Replace `active` mutex with receive pause
      rust: serdev: Simplify callbacks

 drivers/tty/serdev/core.c           |  50 ++++++++++-
 drivers/tty/serdev/serdev-ttyport.c |  38 ++++++++
 include/linux/serdev.h              |   6 ++
 rust/kernel/serdev.rs               | 167 ++++++++++++------------------------
 4 files changed, 147 insertions(+), 114 deletions(-)
---
base-commit: c2cd463d6ee7d55a3ec0719d93c49ff99022d58f
change-id: 20260905-rust_serdev_probe_refactor-0e2b044354a7

