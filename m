Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2768937E5C7
	for <linux-serial@vger.kernel.org>; Wed, 15 Jul 2026 21:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784149219; cv=none; b=PA2/QvcBlXp4W8n1X3ZzNfdwMyay4E6BKj6Y33NF6j0qb5S6QsQQpnwlEdQdofWWIZXTAqbVlbxpnsSAzjFafG1yTt84wbmzLiXzlncskQdQ32a9JMBQH3dpgUlAjRsWS6x3tJH53jTiLy1BvfHlWIzGxEsVXdzgiHWJJpEE+Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784149219; c=relaxed/simple;
	bh=xZiQuQmKXBg8xRZVBYMava9XBcpTnYDvAlvLnwC5EuQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=LmHJe3T1h5NRPcNBxkwBaUL8lXAoRP5jsSduBRsVxVJX+l8JMaXjdn1tcWYaOf2KSrLlI9YivYwWXpn4WlPg1F0q46r9Ie1zBrn+H9+dIPYEGEXNX/8A/7bePyS9nTZGe57xLo+o2Fl7S+Lq4A2jAvLr6rotw6YvY4NDaaIVuJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=gLkZb4/g; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="gLkZb4/g"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 0D5C324002D
	for <linux-serial@vger.kernel.org>; Wed, 15 Jul 2026 23:00:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de;
	s=1984.8680eb; t=1784149215;
	bh=MpjNY5IInl4AXezLvpp//D60MOxckmr9BaeSeASTsOA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:To:Cc:Autocrypt:OpenPGP:From;
	b=gLkZb4/gJp1fql5AYPvEKsT9+PexA2Rk4Ss240aLeHmWPC3T39hoRvNZAKLQ8g80P
	 xE8KXjzhKhoqHeEoa4UvrfPqBwIvqgvKpDWHFpthyGST/zJgsx9nmcwAI/6fkQw4Sa
	 cQlceLOGZj3R8wCzMeRlCVuj6d313WNUKlYeYscjJ6J+VG6URw9agp0MFHLbUsf5p7
	 Vj0bGIoYr7BQ83djY19YGyEOFGgDCk/b+vLLkYZU2UELHXqzOlIUZwYeKvlPhcy+A6
	 hnpszbAy7HtIjQ+yb/CU7rZkrOsgcnnze5NREMJKIoJ5Nu1M89D1opHeRxJJukX4lv
	 1kKNlBlAB6+wg==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4h0pTl0kTxz6tsb;
	Wed, 15 Jul 2026 23:00:11 +0200 (CEST)
From: Markus Probst <markus.probst@posteo.de>
Subject: [PATCH v14 0/3] rust: add basic serial device bus abstractions
Date: Wed, 15 Jul 2026 21:00:14 +0000
Message-Id: <20260715-rust_serdev-v14-0-b4ed5c93606f@posteo.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33T227bMAwG4FcJfD0HIiXqkKu+x1AUOlCt0SXu7
 NTYUPTdR6cr6gPQSwn+aEr6+daMPHQ8NqfDWzPw1I1df5EFmB+HJj/FyyO3XZGNBhUSILh2eB2
 vD6IKTy0zGQ8clKfciHgZuHZ/buV+3sv6qRuv/fD3Vn2Cefd/HVSrOhO0qmVjrCFnnUW4e+nHK
 /fHws1cZ8JPa5VWdm1xtiGhTgYTEm2tXljQa6vF5hB1rAimurq15ssagLU1Yr0hDlZla9FtLS3
 s9rwklhz7FBVBqHpr7dKu73yyYsFpF3whhrizbmnD2jqxqviQXYBE2W+t/7KkNz17sRgDVSgRM
 e7OG76xQWz1iWrOyYS86xnUNxik59ZSgUIleWfzTsNSb54J5mwVZs9ycK3qLluwCJdEZKPndGm
 jVK3J+wS404t4Ofl6red8YTZSN2XPWi31+8fADPz7Vcbu+jE1zZnHMd6m7nT4vA7Q6LQ9agyeT
 GihLfF5uHvm4cK/jv3wOI9eiiO3uT+fu+vpMLmjdJK1/OT9H0PvQNzjAwAA
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4816;
 i=markus.probst@posteo.de; h=from:subject:message-id;
 bh=xZiQuQmKXBg8xRZVBYMava9XBcpTnYDvAlvLnwC5EuQ=;
 b=owEBiQJ2/ZANAwAIATR2H/jnrUPSAcsmYgBqV/TaEGcRk7r6YvYvp6PZJcM/gXRQ71pj6Oont
 2JNI52P3ymJAk8EAAEIADkWIQSCdBjE9KxY53IwxHM0dh/4561D0gUCalf02hsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQNHYf+OetQ9KNsg//R2WvEI6+9A40HiLi63FY/ONWYq2PSTA
 6eejsCdbLQDdFa6iRuMtGImYR/hOsMlC7kGtRCRVvV1Kkc88Qx29eo3DxIDAOk2ja2God9xgIKt
 cajR9tuAw9yBkHNBcP5RhQAxn/z6v2jEBZFoU5uqItWaJ6M3D+PAvyRISAyTwe9fyRyfQOxQGOz
 h0JrWS0ufojhszVCQsXIdLlXLd8rOv7a8Ca/fA1aBVJXYQ65tE87cylm21rWR0Czn04uHWEIs8S
 yeY24s1OxXzbb1uqxhpS80161PEiPMU0Pen2OI6gS4ZfOykN0kXXYA9koXk5iQbBPuCQJA8shiE
 fIFUU6GHdFdYSYfpbaxl4ON99ce18QD1DImdU6chgG4vhWkaFEfTB9UA//84hHOe9ekErcVtGOU
 Ew6Zya3FQPzgL8kYOcEOaj3Nt5Y/o7XSNSLiBORAJ74z0ZfaHMzVpE9Z20nMCles745CQDgMvjQ
 YxDKBu7RYTXCCuYCmrSudiK70vjileoPbdmUFnxfVpkR9n9XR15EB0upPhVLUv9xbQWi+N1sCc1
 zN4k73c4DlHVk+iA21sH5HaRYcIlJ8qx/CZj33hsiuL/nt9thui7iayvQi5h0+zE1z8TO9VGnhP
 hirPco5s8F45ue/bM+xA/vc124jLowIwbzKXziNe8pnisomfNFrQ=
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
 rust/kernel/serdev.rs              | 599 +++++++++++++++++++++++++++++++++++++
 samples/rust/Kconfig               |  11 +
 samples/rust/Makefile              |   1 +
 samples/rust/rust_driver_serdev.rs |  90 ++++++
 10 files changed, 738 insertions(+), 1 deletion(-)
---
base-commit: 1137d8b5df06137fb49513cc923b3b24d94cb809
change-id: 20251217-rust_serdev-ee5481e9085c
prerequisite-message-id: 20260530132736.3298549-1-dakr@kernel.org
prerequisite-patch-id: 310c6bee038ca3909a8e5e58ec12b74f7189b869
prerequisite-patch-id: 92812c3d42b29504838e6dc66c307ff5c035bb5e

