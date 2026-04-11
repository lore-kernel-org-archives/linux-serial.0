Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE839475;
	Sat, 11 Apr 2026 15:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775920248; cv=none; b=oZUPHIGDx9UXuD8EJf4jpfQcWkk3ekg4NZ4M7vROJcbeAwua972PLLL3k8kvYsXwfyBgPwSYewJmq/lQlpEoK/KEJqeqjQyzTcr5iM6buvYhO745/Yjzri9inomhhe4c6gQ4o+BkQEcemIHYtvdsugRgBQr/XZoA5ZuYIAHFcsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775920248; c=relaxed/simple;
	bh=JuZcZzdMcRrLzA+RbPD3qbxn3xkXQ/wDeielE4KC3Ew=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=YwT9Nxd2Oga0+4FhqmqhaZwjfXmoAgC2nCAV9o8pvMNUc4tc4bUcSmdH5pZ/D2E+aRIxG7XhOgOWbnM/1Ec3LOlb8U31tPmliXaI4Qqzh5CEF+LSGB3U3bEp1dC+EkUvirG8PVk2Pp52erdf/RRCJT0Ilt1pBzMzttFEbCWHYuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F2ihkeyY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F2ihkeyY"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 89B57C2BCB0;
	Sat, 11 Apr 2026 15:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775920247;
	bh=JuZcZzdMcRrLzA+RbPD3qbxn3xkXQ/wDeielE4KC3Ew=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=F2ihkeyYQQCoQIRvxSBUYC9gD/6IkT2xIowLyESnaZOKEng9x4ZUgptyYkuwYBmX4
	 rwiSTa2j0fgikx/lsSi7qsvsVCnU5xd/Zb0E8XdKrA4cZQtvd934pmBAuqLYSq3dSB
	 LxdXNeY7W9BRZUSXqV4KkpnKnbPoEWt17Oq7ZOjfMYs83hpAouWLWw4VA/+jjHzRnx
	 8jwQC2N+zaT8y3hn0jfBdjWrPFehLWQFPfcZOTCCu6E/0w6Qos9BrJJejI/oBLZ9IW
	 NwgZYB2NKuAFyaWirzDkAHYhF7uWY+X6YVPjy3vDerLv2CJqgl4noiL2BRSmZsx9Xx
	 qboIpp+54A3Dw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7406DF3ED50;
	Sat, 11 Apr 2026 15:10:47 +0000 (UTC)
From: Markus Probst via B4 Relay <devnull+markus.probst.posteo.de@kernel.org>
Subject: [PATCH v4 0/4] rust: add basic serial device bus abstractions
Date: Sat, 11 Apr 2026 17:10:34 +0200
Message-Id: <20260411-rust_serdev-v4-0-845e960c6627@posteo.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGpk2mkC/13MSwrCMBSF4a2UjI0kN6/WkfsQkT5ubCamJDUop
 Xs3LQqtw3Pg+ycSMTiM5FRMJGBy0flHHvJQkLavH3ekrsubAAPFgRsannG8ZdRhoohKlhwrVqq
 WZDEEtO611i7XvHsXRx/eazzx5f12gO06iVNGUUotldFGAz8PPo7ojx2SpZPgZzUTTO8tLLZqQ
 DQSGlDq34qN5WJvRbZtVYvaApfW2K2d5/kD2EMq1R4BAAA=
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
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3097;
 i=markus.probst@posteo.de; h=from:subject:message-id;
 bh=JuZcZzdMcRrLzA+RbPD3qbxn3xkXQ/wDeielE4KC3Ew=;
 b=owEBiQJ2/ZANAwAIATR2H/jnrUPSAcsmYgBp2mR0PkwCPw9xoffILIbYfqj8mDwwWNu+k8sFd
 tf+efCo2XGJAk8EAAEIADkWIQSCdBjE9KxY53IwxHM0dh/4561D0gUCadpkdBsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQNHYf+OetQ9IeKA/+PtS/C6x7TV+jdU/RUp9xomoT7Tzb+Lu
 enLDgE3sPSHFPZytWBoWHBgg5yepoQpa+32lVAwKfJ7mZ8CtwrellE1dMiRxPnEAVFdsdoNSzmK
 erLjqrUmzn8046X47U9/6qLalHmb3QjsedlaslSMc/8mJFVd32Lqcj2VRAh2+1AI1dWJ4auOOaQ
 yYjBn18G0XApHHzZ5VObp9PE1L4gzXTXIqX1CeMd8pIG+DkdYrG+FjpCAte6mKP/to9R6PRfk1A
 7eUyQtvz260ntEYDBm/gCyZrDqN0Wkk9/GfchNci4mAFnDIPf/Tv8Zro3WxReb7UEJjSOHM17KW
 xj3CAXdF9I2K9NNqjoFs4MyaLfwEe/KulOkpSqzXO6q8u+wq/PgCtsisvy5X3vJeTy9bIX3xh09
 0xF0hPSSZoHBrb1XTw1wvA9wfPqBII3SaWi56SlSiD81e9tFgxeW6UBlesdjGLyot+F0DW0a4nP
 vzQwY9tfjLKv8YaylUJBDXpV+CV2MB1KipRu5e3qCPQO/6IXZodtlQA46e/dWT2cxzhg7j89lj2
 39G+GkedvFBuSGjDqn9eZjVXdyDEZB4L1JzsU4gye4S60KPgcekD95cUw90slAPY2H0NNpXLz3Q
 /V+GPmeu+GDWCsDsXbNXj1h/CTmnH0IddLoGjKl/eaVulfMTgU9U=
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
base-commit: c369299895a591d96745d6492d4888259b004a9e
change-id: 20251217-rust_serdev-ee5481e9085c


