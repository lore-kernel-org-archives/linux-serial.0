Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D0D3B9D97;
	Mon, 27 Apr 2026 18:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777313151; cv=none; b=s899ETDBRCByNndw8s1DJsJiUf1IPgnoU46dWmuufF2NBJNfIGvoTnCWStoofVlkycQQvjs4IdPw8gHDStTSfYZ5e9fftJ10hVUVlrLXjWUrf95bEipP1x6XVhnBABjf021YauLYQ6i4NEd+u/+I0yUzN7v2IftVDBiGUj87GZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777313151; c=relaxed/simple;
	bh=g7dEQSlapKq6RGMjYWiDAE6F4/7WAy4mpD2ViWIE8lc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UekLY74gHGTqIvIz1IlZ6Up5gMBfR2+/arzTjJYnzaf+8r+xKNXqNmwvS1RnbekkWqJ4UxxwBtg41zmyc+uSg9jZzEVCLlGHABFATrIRVn6qLtuW0Ly7PFROIZavoas+balYPCH0SCTIB7lhmXs44HusOtXAkmvU6EEKEP0Om78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=skW/v4/2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="skW/v4/2"
Received: by smtp.kernel.org (Postfix) with ESMTPS id AECF9C2BCF6;
	Mon, 27 Apr 2026 18:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777313151;
	bh=g7dEQSlapKq6RGMjYWiDAE6F4/7WAy4mpD2ViWIE8lc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=skW/v4/2wrw6S+b+TinHxgWt1LUm0zq9kiVWfOTaOWDTi7/e7dj/kFX7yHVYFPpMZ
	 sC4EdA14zbcBuFcvl4mj2yIq1NwneKSCxTLRadxSx9ST3u9F3lnKmZJkNUZRFS8GHa
	 AJ6gM1ykLHBEPiVCasqAKBoZwjB2aVN5RFQcxDpwa3nccYc5uvJlVGUJy8XBadnrej
	 0OF/I+5b9e4Nw0FQHCQZ0CzOEPguMMLaJygmwJdqJ3dMtR+912KZxfnJRXrqjGELfe
	 DQovAr2SE6Xyl3zEoT7ye1SvPuVFGGNHzPhwlFRtckFU/oYPYyG03LxJtFVjRLzgNb
	 WugQbMkdQuT3A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4E4FFF8869;
	Mon, 27 Apr 2026 18:05:51 +0000 (UTC)
From: Markus Probst via B4 Relay <devnull+markus.probst.posteo.de@kernel.org>
Date: Mon, 27 Apr 2026 20:05:44 +0200
Subject: [PATCH v6 4/4] samples: rust: add Rust serial device bus sample
 device driver
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260427-rust_serdev-v6-4-173798d5e1a3@posteo.de>
References: <20260427-rust_serdev-v6-0-173798d5e1a3@posteo.de>
In-Reply-To: <20260427-rust_serdev-v6-0-173798d5e1a3@posteo.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4237;
 i=markus.probst@posteo.de; h=from:subject:message-id;
 bh=6TYBQ32OeKPXuo7r972A3rP9t8yQQXh727SZs49HwIY=;
 b=owEBiQJ2/ZANAwAIATR2H/jnrUPSAcsmYgBp76V9lghfqn38x2LQ2dfJy5nUjDLTxde7mWh7P
 KSxxSrKcaSJAk8EAAEIADkWIQSCdBjE9KxY53IwxHM0dh/4561D0gUCae+lfRsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQNHYf+OetQ9LtNg//YOfRybt6cdFvPowzsGsib73kRTkQLGu
 /RQlyRQDW3VG9uwtcMo4tA42tZ+vJo5WPtKldfRSQEx3SQCW54ZzL9pjihtej7MAWUIHZMvAwzU
 6n+mWojaLeeP5GQodk2bI2VsPipYJW9Qs+fzNDcG55cIPnIwZ5E03hb/FMPgkJEu9HNqcxDx6Xn
 tnx0anxZ5zMSEgikx2tXhDK/ZBLjXtS0vBUKgpeMFrFGSnmdIX8wMM/WLL5gxN8dzDW5SLEe2BD
 wOH6lwMWfxyQJSbfCE1VJ6A/jlHh/IIEa0VZhW7BxB7lnlu4zxb9uxsXe4C7ky+0uqH1h7XqUkV
 Xjlt3Vg5Yl+YEDVV2R+YTiSgP8w1HNebaoc2iraeUGkzJE+9Wb9ucbJbt4Rxb/80eGZZVxPOUJ6
 M4Gtpd4YLcPpqbfSdpnPqD1t75kQPmUwnUud0y32Z3zKU26iNXaUuvOEexEZ2QgG+8jH51neE3t
 COWGiCw2dL/rxHX3OnvQVlbA3cZU+yiCiHHUwgMHeLVdlcffTsYwLmuOvZwPIwVifeVWacP9fVe
 NucNHTn7BA6Ij+J42d5bGtFVgWRKvpEA5w/TONKadhax3VUoXlz3mXG6U8pThc6fppAm8GrRett
 JP9Vms+TsnDzucazyNFuKwm9Gv6VYCRIlLl2tFv7F1GVCUH2haz8=
X-Developer-Key: i=markus.probst@posteo.de; a=openpgp;
 fpr=827418C4F4AC58E77230C47334761FF8E7AD43D2
X-Endpoint-Received: by B4 Relay for markus.probst@posteo.de/default with
 auth_id=680
X-Original-From: Markus Probst <markus.probst@posteo.de>
Reply-To: markus.probst@posteo.de

From: Markus Probst <markus.probst@posteo.de>

Add a sample Rust serial device bus device driver illustrating the usage
of the serial device bus abstractions.

This drivers probes through either a match of device / driver name or a
match within the OF ID table.

Signed-off-by: Markus Probst <markus.probst@posteo.de>
---
 samples/rust/Kconfig               | 11 +++++
 samples/rust/Makefile              |  1 +
 samples/rust/rust_driver_serdev.rs | 86 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 98 insertions(+)

diff --git a/samples/rust/Kconfig b/samples/rust/Kconfig
index c49ab9106345..31d62533ef25 100644
--- a/samples/rust/Kconfig
+++ b/samples/rust/Kconfig
@@ -161,6 +161,17 @@ config SAMPLE_RUST_DRIVER_AUXILIARY
 
 	  If unsure, say N.
 
+config SAMPLE_RUST_DRIVER_SERDEV
+	tristate "Serial Device Bus Device Driver"
+	select RUST_SERIAL_DEV_BUS_ABSTRACTIONS
+	help
+	  This option builds the Rust serial device bus driver sample.
+
+	  To compile this as a module, choose M here:
+	  the module will be called rust_driver_serdev.
+
+	  If unsure, say N.
+
 config SAMPLE_RUST_SOC
 	tristate "SoC Driver"
 	select SOC_BUS
diff --git a/samples/rust/Makefile b/samples/rust/Makefile
index 6c0aaa58cccc..b986b681cde5 100644
--- a/samples/rust/Makefile
+++ b/samples/rust/Makefile
@@ -14,6 +14,7 @@ obj-$(CONFIG_SAMPLE_RUST_DRIVER_PLATFORM)	+= rust_driver_platform.o
 obj-$(CONFIG_SAMPLE_RUST_DRIVER_USB)		+= rust_driver_usb.o
 obj-$(CONFIG_SAMPLE_RUST_DRIVER_FAUX)		+= rust_driver_faux.o
 obj-$(CONFIG_SAMPLE_RUST_DRIVER_AUXILIARY)	+= rust_driver_auxiliary.o
+obj-$(CONFIG_SAMPLE_RUST_DRIVER_SERDEV)		+= rust_driver_serdev.o
 obj-$(CONFIG_SAMPLE_RUST_CONFIGFS)		+= rust_configfs.o
 obj-$(CONFIG_SAMPLE_RUST_SOC)			+= rust_soc.o
 
diff --git a/samples/rust/rust_driver_serdev.rs b/samples/rust/rust_driver_serdev.rs
new file mode 100644
index 000000000000..8cf3fb451b22
--- /dev/null
+++ b/samples/rust/rust_driver_serdev.rs
@@ -0,0 +1,86 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Rust Serial device bus device driver sample.
+
+use kernel::{
+    acpi,
+    device::{
+        Bound,
+        Core, //
+    },
+    of,
+    prelude::*,
+    serdev,
+    sync::aref::ARef, //
+};
+
+struct SampleDriver {
+    sdev: ARef<serdev::Device>,
+}
+
+kernel::of_device_table!(
+    OF_TABLE,
+    MODULE_OF_TABLE,
+    <SampleDriver as serdev::Driver>::IdInfo,
+    [(of::DeviceId::new(c"test,rust_driver_serdev"), ())]
+);
+
+kernel::acpi_device_table!(
+    ACPI_TABLE,
+    MODULE_ACPI_TABLE,
+    <SampleDriver as serdev::Driver>::IdInfo,
+    [(acpi::DeviceId::new(c"LNUXBEEF"), ())]
+);
+
+#[vtable]
+impl serdev::Driver for SampleDriver {
+    type IdInfo = ();
+    const OF_ID_TABLE: Option<of::IdTable<Self::IdInfo>> = Some(&OF_TABLE);
+    const ACPI_ID_TABLE: Option<acpi::IdTable<Self::IdInfo>> = Some(&ACPI_TABLE);
+
+    fn probe(
+        sdev: &serdev::Device<Core>,
+        _info: Option<&Self::IdInfo>,
+    ) -> impl PinInit<Self, Error> {
+        let dev = sdev.as_ref();
+
+        dev_dbg!(dev, "Probe Rust Serial device bus device driver sample.\n");
+
+        if sdev
+            .set_baudrate(
+                dev.fwnode()
+                    .and_then(|fwnode| fwnode.property_read(c"baudrate").optional())
+                    .unwrap_or(115200),
+            )
+            .is_err()
+        {
+            return Err(EINVAL);
+        }
+        sdev.set_flow_control(false);
+        sdev.set_parity(serdev::Parity::None)?;
+
+        Ok(Self { sdev: sdev.into() })
+    }
+
+    fn receive(sdev: &serdev::Device<Bound>, _this: Pin<&Self>, data: &[u8]) -> usize {
+        let _ = sdev.write_all(data, serdev::Timeout::Max);
+        data.len()
+    }
+}
+
+impl Drop for SampleDriver {
+    fn drop(&mut self) {
+        dev_dbg!(
+            self.sdev.as_ref(),
+            "Remove Rust Serial device bus device driver sample.\n"
+        );
+    }
+}
+
+kernel::module_serdev_device_driver! {
+    type: SampleDriver,
+    name: "rust_driver_serdev",
+    authors: ["Markus Probst"],
+    description: "Rust Serial device bus device driver",
+    license: "GPL v2",
+}

-- 
2.53.0


