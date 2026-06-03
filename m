Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718673B585D;
	Wed,  3 Jun 2026 15:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780502205; cv=none; b=lj0Ou37LxycZaRLRk8BQqhLLf5dOpYOvYSkVNPPo5ZZvb3lXrBghE2MFeoGwbZ4qBy0iAmH6OfNWKcabwiDHKBKXIZw+EFeihgGOx/QHm7lg6hSOK9hpblqt5Wfyggu/Eoy0dnAlIxhYUgNOURdbXmJlEfLW45u/x6kywgUFYy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780502205; c=relaxed/simple;
	bh=2qaNy0YsgyCw+GORLA2AGxdNjYQI9FkJh3YJE/z36VI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=FrTT/jZdFXid3t7C8yLsF8gkZ3ARg6E9lYDXHMF2aJkJXYqeLFhqkPZ5aPVzjieOhhaGTUURW3GNNN3KnsIRC7gLmUc9mqEn/WGvsACz0rufl25mmii2b8/Ps+pMuFH1sPE7GO+fSL7HM+AC5q/NPNC16MSz9jNGmvgQyfDQMV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rRJpa4Ug; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rRJpa4Ug"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 08CC2C2BCB9;
	Wed,  3 Jun 2026 15:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1780502205;
	bh=2qaNy0YsgyCw+GORLA2AGxdNjYQI9FkJh3YJE/z36VI=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=rRJpa4Ug6fepUhqQ+Un1CxVfaWi2F80kkJmby4PTY+2PGiMSvpS2rdXH8yyaUgj5i
	 y4ysp2I/xI3HIFdT+Nm/tiQmPnbnu/nn8ifB1BH47xIkpk9+z/pKok3cqI0LWnw5My
	 pj9Y3ZTVy2qtriZexhohkkrp+Q7AfaVijY1Puyfpsq6/6s/YpateWciwfmFos5uZfv
	 tzeG9AGfZXO60yA8lz36IU9411B8u071CT+WG5XXyF1f4y2x1oqhZfUAENTTZhBA0o
	 YngGrVmYYq2lIsWDIHhAoShRqXu5dgJZ8DQTZdWq7uutw+IvWKg+LXLEIt/pwz3Lh6
	 rGa1IdSf1kdrA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0736CD6E60;
	Wed,  3 Jun 2026 15:56:44 +0000 (UTC)
From: Markus Probst via B4 Relay <devnull+markus.probst.posteo.de@kernel.org>
Subject: [PATCH v12 0/3] rust: add basic serial device bus abstractions
Date: Wed, 03 Jun 2026 17:56:38 +0200
Message-Id: <20260603-rust_serdev-v12-0-3400ffb88b12@posteo.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALZOIGoC/43S207kMAwG4FcZ9XpbxU6cw1zxHqsVShMXKnam0
 JYKhHh33BkQPazQXlWO9P2Km/+tGLhveSiOh7ei56kd2u4sA+CvQ5Hu4/mOyzbLQYEKCRBc2T8
 P462ozFPJTMYDB+UpFSIee27al0vc7z8y37fD2PWvl/QJ5tPPHFSrnAlKVbIx1pCzziLcPHbDy
 F2VuZhzJvyyVmll1xZnG2rUtcEaibZWLyzotdViU4g6Ngimcc3Wmm9rANbWiPWGOFiVrEW3tbS
 w231JLDn2dVQEodFba5d2/c8nKxacdsFnYog765Y2rK0Tq7IPyQWoKfmt9d+W9ObOXizGQA3ki
 Bh3+4YfbBDb+JqalGoT0u7OoH7AIHcuLWXIlGvvbNppWOrNM8HcrczsWRbXqll16/1a2p6fnqX
 647W5xYmHIV6afzxcQ+WVCI1SlQ4yBFtCmeNDf/PA/Zn/Vl1/N9d/75DkGxAqQGOD/1+mFWh02
 lYagycT/u3qOHCZutOpHY+HyVWyeLKy0/sHVbvHstYDAAA=
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
 Boqun Feng <boqun@kernel.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, linux-pm@vger.kernel.org, 
 driver-core@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 Markus Probst <markus.probst@posteo.de>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6344;
 i=markus.probst@posteo.de; h=from:subject:message-id;
 bh=2qaNy0YsgyCw+GORLA2AGxdNjYQI9FkJh3YJE/z36VI=;
 b=owEBiQJ2/ZANAwAIATR2H/jnrUPSAcsmYgBqIE660Yf11phFRcOxmvBf8zeyNmmsct7vd4NyD
 2SiDly2GO6JAk8EAAEIADkWIQSCdBjE9KxY53IwxHM0dh/4561D0gUCaiBOuhsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQNHYf+OetQ9JxGhAAvBCvBmUB5UJPcildKweYaf10lV+K0Cb
 K691Fk8w+UHrfxgefMTVSlu5MiDK9DwfKk29kkzMaYEAwfDRfXCO9BuFU1YuwlvPbnCp7xD8INn
 aun5eSqb7Ur6SXr6yn7OtTgr0KpZF5SkcTP37rHsKl0FAHGGP6a9wpf5oeoVxKQ/Wl4fECCo2cb
 XOf5jknN494FqtONYcyOZRv81Ehr4HM0kPolTbwWkLaFkcVylWaHXBWI3B5ZluSdDhOI4DAN1tV
 yh5jzmbHJTeZjHu1SFsN7v4aXYEYpxEsyqUixycdg+IEnRWKBiXvKXVvrN/J9iQO+8FmU82soKX
 iAJbXkSuNNYtopcv1byzDDssM4OevzsMZKVuFuohlkItj7RCbYVeDnnsGnYUb4eYzpXusS6Rb86
 Wc5wnKhirQjMifiJfUAqhrOdi44iHZxfKjxs/MN8bfjpspTWOpUSK26Y+pwBjmRUEx0c+4H+kAV
 EFXnlhObjwNCKbHL1slDe9jv+Ch0EmiIpEo7fg3Rjuzzxe4bkqOUAIBMr+GVDj/aGneJCLcDFb9
 IauKeYfgieUHpPVlMuasU5lVIe2N5clUFkHjyEwwmhHgW96P+kWfw75p62+B7g8PMEs7BdPDsfd
 q1GArbKZEqhdmSnZRhiZAh68JZ1E1DRxnsMEY2KB7r+Ro6VJEkiE=
X-Developer-Key: i=markus.probst@posteo.de; a=openpgp;
 fpr=827418C4F4AC58E77230C47334761FF8E7AD43D2
X-Endpoint-Received: by B4 Relay for markus.probst@posteo.de/default with
 auth_id=680
X-Original-From: Markus Probst <markus.probst@posteo.de>
Reply-To: markus.probst@posteo.de

This patch series adds the serdev device bus rust abstraction into the
kernel.

This abstraction will be used by a driver,
which targets the MCU devices in Synology devices.

Kari Argillander also messaged me, stating that he wants to write a
watchdog driver with this abstraction (needing initial device data).

This series depends on [1] and [2].

[1]
https://lore.kernel.org/rust-for-linux/20260525202921.124698-1-dakr@kernel.org/
[2] https://lore.kernel.org/rust-for-linux/20260530132736.3298549-1-dakr@kernel.org/

Signed-off-by: Markus Probst <markus.probst@posteo.de>
---
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
 rust/kernel/serdev.rs              | 590 +++++++++++++++++++++++++++++++++++++
 samples/rust/Kconfig               |  11 +
 samples/rust/Makefile              |   1 +
 samples/rust/rust_driver_serdev.rs |  91 ++++++
 10 files changed, 730 insertions(+), 1 deletion(-)
---
base-commit: 3bc831df9ee16fceee851872315161377ca1417d
change-id: 20251217-rust_serdev-ee5481e9085c
prerequisite-message-id: 20260505152400.3905096-1-dakr@kernel.org
prerequisite-patch-id: d2aebf69b153c039bbed1d0ed26906708fd22534
prerequisite-patch-id: 84b28da2f5de20fc1785095c647b2ffc35d969a5
prerequisite-patch-id: 67318671a5eed5fb4ad23a450f1cf0e442bf8ca2
prerequisite-message-id: 20260525202921.124698-1-dakr@kernel.org
prerequisite-patch-id: b84db329d4372a175cb8d49e4e88c3eecf7eb228
prerequisite-patch-id: 2c30303f409cc8288cc87e241920219f5ddd8390
prerequisite-patch-id: 4e4f0ad370d763ad00b0f75b91fa216f2cc95953
prerequisite-patch-id: 5bcd6b37f3498feebda275dfef78136eba34004e
prerequisite-patch-id: 872b0982f3e5e7d1698d9df3b325e4cd27b27789
prerequisite-patch-id: 3a3c7749e017d9335f58497404d1350e96caf471
prerequisite-patch-id: 3526c9154f581497a11465b936d83ef61a875454
prerequisite-patch-id: 65d8c757b52475c2acc7d22ddc92cd3f0152b55d
prerequisite-patch-id: 4bd31f1414d5248dc080884caadf5f21684a8427
prerequisite-patch-id: 7beadbb0da3e589ed86d12f512d1c83427dd82b4
prerequisite-patch-id: 12cd0f67ffd27347f90c065db491945908206b7f
prerequisite-patch-id: 4642e31f66331f6c3b579377111ea733dbb3a11c
prerequisite-patch-id: 52d67b40b4396c741e2222d6a5bc7927abcb77aa
prerequisite-patch-id: 74ca82ff26cf9c7a993757c87db8be62006e820f
prerequisite-patch-id: 466fb9fa7febbffd8ef51b311c7d9893c11fc0f0
prerequisite-patch-id: e515cd98b06e26721cbbe6a4fbacd251d0073b63
prerequisite-patch-id: 8dc8e75d9f6499a554ef7e474bbacdbf3660a9f2
prerequisite-patch-id: 5fdb9f71dca2f44dd293760a60db125b770f1f55
prerequisite-patch-id: c766a24c2d5064f5ec09daada0b8e8fba862d3aa
prerequisite-patch-id: b768f6456d35fa7a80c015e34bbdba6082dbd593
prerequisite-patch-id: 6a8b17234f12f7084e6e2ce843a7031b0a891ce4
prerequisite-patch-id: 98b2deb9e60c1f28f90c5ee34fd608aaa9fd9420
prerequisite-patch-id: 774b29be66e641ee50cedb4704cf49d8b9fabf50
prerequisite-patch-id: cf95dc936cfc4b3a7a363435a51a48d9009645b3
prerequisite-message-id: 20260530132736.3298549-1-dakr@kernel.org
prerequisite-patch-id: 310c6bee038ca3909a8e5e58ec12b74f7189b869
prerequisite-patch-id: 92812c3d42b29504838e6dc66c307ff5c035bb5e


