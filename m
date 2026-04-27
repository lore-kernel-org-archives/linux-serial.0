Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63BB35C182;
	Mon, 27 Apr 2026 18:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777313151; cv=none; b=c0Typh1GcBNu5EGy4rqlhyX9nIsF55HRZRxOcwjYESBjn8IotKmqyNK+lIYMrBqDGPHuqYPA18Sbbzax7ikdGntj3nDIV5dQgsO5LJC5AIk+T6qlByw66VXyugOaX2GW9D3UGih6eCU+glDt5U60MTJSOSefDEL+Iy5MxOFdsq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777313151; c=relaxed/simple;
	bh=+Q0IVsPy5EjKTMnmjpdabqL8rz9x6TxNbFuyErUFjNM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=DV3HxEb3ZUY9tCvRpvhvNpjdfg05b0kx9+BPUnROXr/6X1JiHUy1TMTbxte0vNTsigXhrvI0BKQScIKxf+kD8vh68SIVx5+786XhSKLrd0KrQEPLSYfuHpb+LMSzpPy+snxVvibUELdAA/Cl4thz58mYBrV/eqU5HgMHt4LA2dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s2rT0hHq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s2rT0hHq"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5CF67C19425;
	Mon, 27 Apr 2026 18:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777313151;
	bh=+Q0IVsPy5EjKTMnmjpdabqL8rz9x6TxNbFuyErUFjNM=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=s2rT0hHqs2RxYAlFwO8unBZKiGgCbFAVZHmdYgFKhcPIo/3JOgvQKgBhN3I0Uqu7S
	 vd+Oo3KCBsGlnNQeYw1hKOT7PSgagZYKr5hJTFs6wI4rO8OSCJUOnkPwSz4GeNCFhc
	 BLrB3qp1RJ6o/tDrjn+nmN8y6CpbttnAVLnxi9UWmDjgQR49aET75WitY8f2tQ5qUG
	 hdZWJ0jXaKxGKfS9EAGep5ONkdy5o10ReIDlOtyf0yfBjHf6AYwYqaJpo1gjLsNNn/
	 Deuh5SA3E0sgOY4SpsRKToTXImnr3tIWSDF7rmNOKkR/nZhomDyzzHhoqRqYhfor2q
	 wcvl8Gf4d6xoA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 450D5FF8865;
	Mon, 27 Apr 2026 18:05:51 +0000 (UTC)
From: Markus Probst via B4 Relay <devnull+markus.probst.posteo.de@kernel.org>
Subject: [PATCH v6 0/4] rust: add basic serial device bus abstractions
Date: Mon, 27 Apr 2026 20:05:40 +0200
Message-Id: <20260427-rust_serdev-v6-0-173798d5e1a3@posteo.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHSl72kC/13RQW7DIBAF0KtYrEvEDAzYWfUeVVXZeNywSJyAg
 1pFuXtx0qq2lx/xvmDmJhLHwEnsq5uInEMK46kE+1IJf2hPnyxDX7JAhQQITsZrmj4K6jlLZjI
 1cKNq8qKIc+QhfD3a3t5LPoQ0jfH7UZ5hPv3tQbXqySCVZGOsIWedRXg9j2nicdezmHsy/lmrt
 LJri7NtOtSdwQ6JtlYvLOi11cX6ptXtgGAGN2yt+bcGYG1NsbUhbqzy1qLbWlrY7X+pWHJcd60
 iaAa9tPfnICNfrmUb03OaomsTSz8ej2HaV9ntymM8lMv3H31IKkPCAQAA
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3366;
 i=markus.probst@posteo.de; h=from:subject:message-id;
 bh=+Q0IVsPy5EjKTMnmjpdabqL8rz9x6TxNbFuyErUFjNM=;
 b=owEBiQJ2/ZANAwAIATR2H/jnrUPSAcsmYgBp76V9j/M+p9viNbc8aF8xk3p4Lo5fNvPF2YUnD
 T20G+NTyy+JAk8EAAEIADkWIQSCdBjE9KxY53IwxHM0dh/4561D0gUCae+lfRsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQNHYf+OetQ9Jf5A//cyDq0cgtBmO1jjmgFCpuB96iGbP7OSI
 tk9hDnGbQTZsPxU0hU+45/oj5o4bY9Tof0E/HFNseSZEeSZ+9bbzm8FVdfzDNqowOdIjGqyKAbI
 i0/NBhgPOBAX+BiMtIgm3HFYiiEa8Pav2xbMR3/blM1hQTCDBwbyBI3P37EIs9Lypg26IGN91cU
 h5hEbLR5ErBW66IbyL/p9nsxLfCg+VDDWzMolixt1oJFonldb2ZFuKm3a4G1YUrf11Sg4D8pVnW
 hIPBqi96U7Ko6NYuysVxNnUApBLF6aH7fpyzu/ONudoShE23eRobFlKdWom9JZn6nl8NZvXw6Tt
 ViB1hLCdsHriv5oXl8QjPRSp2RCZ8m1y7SCV6iLTDioqpM+sfLcn5EBqOhAKdzqwdE8z83rawK7
 uoxzsBM9eHMzjInfJi2+BziJY+nm0BbxosTWl7Y6RU6swRABbhUQ1nhBNXbkI4U/Ik6fAZNjA7b
 R1RFwFW0Gf+c4gekLgj8MzLvjDQrtQil2m1LQs6Hbr6XWChr4XknQ+nEq0Mvaz55gHanqIeuSEg
 RR88pimxjAALxGeIR7jD4A7+tzB7IT3t7xOsv2XobEjuZX1Xt2oRJMoiL9dY/R0oHQ1aZ8DYfXT
 5WqeYm7R5Q2nteFN5LD3kINo25lF//4+eNCPGFmifaDCRNwDgZUU=
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

@Rob: Are you willing to maintain these rust abstractions yourself,
as you are the expert on this subsystem, otherwise I would take care of
it with a "SERIAL DEVICE BUS [RUST]" section in the MAINTAINERS file. In
the second case, I assume you are going to pick those patches as-is into
your tree, after they have been reviewed?

Signed-off-by: Markus Probst <markus.probst@posteo.de>
---
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
Markus Probst (4):
      rust: devres: return reference in `devres::register`
      serdev: add rust private data to serdev_device
      rust: add basic serial device bus abstractions
      samples: rust: add Rust serial device bus sample device driver

 drivers/tty/serdev/Kconfig         |   7 +
 include/linux/serdev.h             |  15 +-
 rust/bindings/bindings_helper.h    |   1 +
 rust/helpers/helpers.c             |   1 +
 rust/helpers/serdev.c              |  22 ++
 rust/kernel/cpufreq.rs             |   3 +-
 rust/kernel/devres.rs              |  15 +-
 rust/kernel/drm/driver.rs          |   3 +-
 rust/kernel/lib.rs                 |   2 +
 rust/kernel/serdev.rs              | 536 +++++++++++++++++++++++++++++++++++++
 samples/rust/Kconfig               |  11 +
 samples/rust/Makefile              |   1 +
 samples/rust/rust_driver_serdev.rs |  86 ++++++
 13 files changed, 693 insertions(+), 10 deletions(-)
---
base-commit: 5e9b7d093f3f77cb0af4409559e3d139babfb443
change-id: 20251217-rust_serdev-ee5481e9085c


