Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F07F39C00B
	for <linux-serial@vger.kernel.org>; Sat, 18 Jul 2026 14:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784384908; cv=none; b=NiIytbMFoF5Mt0BEppODjf9npDHEeahyK9F2Y1xJmUL7q64Yxp+x8XxEuOS3U/m9ZhfK5QYZlysTQUF+IWiMKJFDlYQo+PP3oL5qwJ+RA+8d9vKuJZd+Z9pH3XVL5IaYCpsKAQ8WzDCiEbLzUcHtyzrEu/TMbntmtMe2yl7Hspk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784384908; c=relaxed/simple;
	bh=Tze8JA4FjsdaVo3W1g2YuWMXBunMoKihkil8k7vCaF4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=NP12FyiONG/2cVEODHpZ6aOz0iRVkg1zypHG93DCmAn5B0s0c+91ER4V6gJi4IbQwHM74XFL6+wonuUCKST5L2NQ8mewanjP7ZMl5OtxORhyA+dEoy1odPtQ2s65VqvLncYkpDybnwGQEOdJ2ILOwUnAXjlO0n3hwROTclx1x4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=LcP7Q0Qq; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="LcP7Q0Qq"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id C8C5624002A
	for <linux-serial@vger.kernel.org>; Sat, 18 Jul 2026 16:28:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de;
	s=1984.8680eb; t=1784384896;
	bh=jPe27Ui+RXv3aP1XufaG9hqdXu+QzdRiJGn3uKKRiyc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:To:Cc:Autocrypt:OpenPGP:From;
	b=LcP7Q0QqyoDb4mloi2Bo1HrY2EWaaGvMkrlAWlWtKv41Zf/CqxM6vzl1QNE0U4RiX
	 pDnDOJoznKhZ2B1x0Z8QOZr/hAfX0gpYNNWbfFgZcsV/VwIfhvnR/DDy0qFOeUx0X2
	 6MMhK32v6d6YVP5VKG6GxfODALeAHtKEZQgo9+8g4qHbEN7JorcbDMJqxnCMO5ws2G
	 veJJW6AEScnOph6yG9AMzcNTX3mUbWjlDhCBCZuDYXBHPRXy5TrfUVGdOZAhUGz0mQ
	 CtnNyWmsVUt0eW6SuHywM7eq+joVmNpr9sudi77d43O8F+K+QYYXKFo6L6evBvkjq0
	 EIf5yn+N1v8ow==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4h2Tf46My0z6tsg;
	Sat, 18 Jul 2026 16:28:12 +0200 (CEST)
From: Markus Probst <markus.probst@posteo.de>
Subject: [PATCH v15 0/3] rust: add basic serial device bus abstractions
Date: Sat, 18 Jul 2026 14:28:15 +0000
Message-Id: <20260718-rust_serdev-v15-0-208ed2e6ec15@posteo.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33T207kMAwG4FcZ9ZqO4iTOYa54D4RQDg5UMFNoS
 7UrxLuvOyyiTSUuG/Vz7fT3RzPS0NHYnA4fzUBzN3b9hR8Abw5NegqXR2q7zAeNFBJBgm2H93F
 6YJVpbolQOyAvHKaGxetApftzLXd3z89P3Tj1w99r9RmW0/91pNjUmaEVLWltNFpjjYTb136cq
 D9mapY6s/y2RihhtlYu1kepopZRItZWrSyorVVskw8qFAm62FJb/WM1wNZqtk4jeSOSMdLWFle
 2nhfZoiUXg0DwRdXWrO32zmfDFqyy3mUkCDtr19ZvrWUrsvPJeoiYXG3dj0VV9ezYyuCxQA5Sh
 t28/hfr2RYXsaQUtU+7nkH8goF7bg1myJijsybtNKx19ZtgyVYmcsSDK1F22YJVuDgilV7SpbQ
 QpUTnIsidXsXL8ttbveRLJs11Y3KkxE7rtcZKLwmLmjImr7i3TTo/v9ZtoLd3Xtrpa+eaM41ju
 O7s6fB9maCkVeaopHeofQttDs/D7TMNF3o59sPjsrgxjNSm/nzuptNhtkeeIyn+yOc/TSL9OyE
 EAAA=
X-Change-ID: 20251217-rust_serdev-ee5481e9085c
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
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 Boqun Feng <boqun@kernel.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, linux-pm@vger.kernel.org, 
 driver-core@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 Markus Probst <markus.probst@posteo.de>
X-Developer-Signature: v=1; a=openpgp-sha256; l=5218;
 i=markus.probst@posteo.de; h=from:subject:message-id;
 bh=Tze8JA4FjsdaVo3W1g2YuWMXBunMoKihkil8k7vCaF4=;
 b=owEBiQJ2/ZANAwAIATR2H/jnrUPSAcsmYgBqW417FXI+4VwqIZOwqzfyo4t6ggQn/Duj7LBl7
 h5vMAmWeuaJAk8EAAEIADkWIQSCdBjE9KxY53IwxHM0dh/4561D0gUCaluNexsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQNHYf+OetQ9LLthAAvnlfXKok8+8ZDRPq+qNlmeGWNY1bc8H
 4Xd4Im5KzUa1SqiayEdIBWRUmasL8f1q7k1fMXySGUqAfSIdvKXC9gCD5I8ds9TCoW7EgHMK5pz
 sn89xsSVMLphqZfPRQZnNu+fCrs28C+JpVNaiNkvn2kLGOqxX5/gDrhtdcEMrAJyxYu74A2zCp+
 EQTbKCz7Ni7zuO5PfZuNnM4ctY97WJcsOCRw6MYBCaIr45aBhb08DXRZSE4Gb0AE1tI83bKi853
 qtgbJAypG9RrhIfL3oWnDRQtS2GoIMbh7oJSTHSvOPcQr+NuW+EEEtZIOedUDHDXGGUiDnVOLrE
 QzQNO7aKrzbGPNxMVRabOScjhmMdX5QcJnf5CjG+jcgwULY6YhOOmCSWk98910TjUzslXufSMrS
 /LcOVjmqcLidTVVtAR0WxiowzACzDy+0lpam69gz5OUX/EKHYS2D41SgCUb4C1l0UlvE8wQIT0a
 HyjMMyv8U26vjZnItheO0Eg0pZGOppqSpZwnh1ANCWI3ZK5wH/N1jopB77MzS/rAmjwYqoMuQ0p
 Ca5byZd9IuZQIJJXGYhRwRGvcg/j34XsSZBxDZ6nITbgvVc1j0rPTML6PeFXjXkU95q1lfrlrED
 ZyZKLe7RiMocxw0F0JwX3UVrmU4r4oQp5poJVWigHcA0QgLy0UL0=
X-Developer-Key: i=markus.probst@posteo.de; a=openpgp;
 fpr=827418C4F4AC58E77230C47334761FF8E7AD43D2
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
  keydata=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
  aBeNN4ijKZchBXHPgVx+YtWRHfcm4l8=
OpenPGP: url=https://posteo.de/keys/markus.probst@posteo.de.asc; preference=encrypt

This patch series adds the serdev device bus rust abstraction into the
kernel.

This abstraction will be used by a driver,
which targets the MCU devices in Synology devices.

Kari Argillander also messaged me, stating that he wants to write a
watchdog driver with this abstraction (needing initial device data).

This series depends on [1].

[1] https://lore.kernel.org/rust-for-linux/20260530132736.3298549-1-dakr@kernel.org/

Signed-off-by: Markus Probst <markus.probst@posteo.de>
---
Changes in v15:
- fix documentation typo
- add documentation for `PrivateData::active`
- adding missing `#[inline]` attributes
- replace `serdev::Timeout` with the use of `impl Into<Jiffies>`
- This replaces https://lore.kernel.org/rust-for-linux/20260718-rust_serdev_fixes-v1-0-35433b6dce0f@posteo.de/
- Link to v14: https://patch.msgid.link/20260715-rust_serdev-v14-0-b4ed5c93606f@posteo.de

Changes in v14:
- fix issues reported by Sashiko:
  - fix missing Sync
  - fix write buffers allowed with data.len() > i32::MAX
  - fix sample driver possibly stalling on full tx buffer
- Link to v13: https://patch.msgid.link/20260712-rust_serdev-v13-0-2c4060bc8e30@posteo.de

Changes in v13:
- Added Acked-by trailer from Rob. Consider this a RESEND.
- Link to v12: https://patch.msgid.link/20260603-rust_serdev-v12-0-3400ffb88b12@posteo.de

Changes in v12:
- fix CoreInternal instead of BoundInternal
- Link to v11: https://patch.msgid.link/20260531-rust_serdev-v11-0-dee8e0d830f1@posteo.de

Changes in v11:
- redo changes from v9 with the following fixes:
  - fix memory leak on probe failure
  - fix possible access of dropped drvdata from receive_buf
- Link to v10: https://patch.msgid.link/20260530-rust_serdev-v10-0-65d1d5db876c@posteo.de

Changes in v10:
- revert everything from v9, except BoundInternal
- use mutex to ensure receive_buf won't be called on a dropped drvdata.
- Link to v9: https://patch.msgid.link/20260530-rust_serdev-v9-0-f8b5fccb49c3@posteo.de

Changes in v9:
- make use of BoundInternal
- use PrivateData wrapper and drop rust_private_data field
- use non-devm version of serdev_device_open
- Link to v8: https://patch.msgid.link/20260530-rust_serdev-v8-0-2a95f1da22a7@posteo.de

Changes in v8:
- adapted to driver-lifetime v5 patch series
- add MAINTAINERS file patch
- Link to v7: https://patch.msgid.link/20260429-rust_serdev-v7-0-0d89c791b5c8@posteo.de

Changes in v7:
- adapted to driver-lifetime patch series
- Link to v6: https://patch.msgid.link/20260427-rust_serdev-v6-0-173798d5e1a3@posteo.de

Changes in v6:
- rebased onto v7.1-rc1
- Link to v5: https://patch.msgid.link/20260420-rust_serdev-v5-0-57e8ba0519f3@posteo.de

Changes in v5:
- fix typo in documentation
- Link to v4: https://lore.kernel.org/r/20260411-rust_serdev-v4-0-845e960c6627@posteo.de

Changes in v4:
- fixed not selecting rust serdev abstraction in sample
- Link to v3: https://lore.kernel.org/r/20260313-rust_serdev-v3-0-c9a3af214f7f@posteo.de

Changes in v3:
- fix vertical import style
- add Kconfig entry for the rust abstraction
- fix documentation in include/linux/serdev.h
- rename private_data to rust_private_data
- fix `complete_all` <-> `wait_for_completion` typo
- move drvdata_borrow call after the completion
- Link to v2: https://lore.kernel.org/r/20260306-rust_serdev-v2-0-e9b23b42b255@posteo.de

Changes in v2:
- fix documentation in `serdev::Driver::write` and
  `serdev::Driver::write_all`
- remove use of `dev_info` in probe from the sample
- remove `properties_parse` from the sample
- add optional `baudrate` property to the sample
- remove 1. patch
- remove `TryFrom<&device::Device<Ctx>> for &serdev::Device<Ctx>`
  implementation
- fix import style
- add patch to return reference in `devres::register` to fix safety
  issue
- add patch to add private data to serdev_device, to fix
  `Device.drvdata()` from failing
- simplify abstraction by removing ability to receive the initial
  transmission. It may be added later in a separate patch series if
  needed.
- Link to v1: https://lore.kernel.org/r/20251220-rust_serdev-v1-0-e44645767621@posteo.de

---
Markus Probst (3):
      rust: add basic serial device bus abstractions
      samples: rust: add Rust serial device bus sample device driver
      MAINTAINERS: serdev: Add self for serdev

 MAINTAINERS                        |   5 +-
 drivers/tty/serdev/Kconfig         |   7 +
 rust/bindings/bindings_helper.h    |   1 +
 rust/helpers/helpers.c             |   1 +
 rust/helpers/serdev.c              |  22 ++
 rust/kernel/lib.rs                 |   2 +
 rust/kernel/serdev.rs              | 605 +++++++++++++++++++++++++++++++++++++
 samples/rust/Kconfig               |  11 +
 samples/rust/Makefile              |   1 +
 samples/rust/rust_driver_serdev.rs |  90 ++++++
 10 files changed, 744 insertions(+), 1 deletion(-)
---
base-commit: 1137d8b5df06137fb49513cc923b3b24d94cb809
change-id: 20251217-rust_serdev-ee5481e9085c
prerequisite-message-id: 20260530132736.3298549-1-dakr@kernel.org
prerequisite-patch-id: 310c6bee038ca3909a8e5e58ec12b74f7189b869
prerequisite-patch-id: 92812c3d42b29504838e6dc66c307ff5c035bb5e

