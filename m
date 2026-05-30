Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35573AB285
	for <linux-serial@vger.kernel.org>; Sat, 30 May 2026 17:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780162609; cv=none; b=apV3bnokrM5o7tkQZQRjzFdJQi/7/98NkbNgrV3peRPa5Xwm+59m9YTCWoXy1IHHOfjbbqPrZisM8YrDS2JJ0ChcadgOrv0+FBqrcWnAYQkgoOKuPL0G93Y8u7/JiXBmH/ubQbEk0NkNLlHN51tCW+7OgIg4WBakfbr+V0umjyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780162609; c=relaxed/simple;
	bh=kWHqDqopsoLEzI8G/1jRCL4n/V6ei1IvSJlqCr5mfNY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WG6nUVu1aJ9wN091emAvFxGD2DLYC0fJNqumlrm2praLtX74HzNToRGfnuIwitWL35VIuHvaW3fUVwp97cXRxzn/DEkDBzqYL7aYlloUca/1De0iCJtAB1Ra3QlAW3fSUAxV4MLwt6QBep6rLyj39q6bh/juY4GYBeSyBTRy3Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=M6Prz6g0; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="M6Prz6g0"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 8AE18240107
	for <linux-serial@vger.kernel.org>; Sat, 30 May 2026 19:36:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de; s=2017;
	t=1780162606; bh=42VT4Web8p97shcBKx9x37MHs8bYsHswj1i8r6Hcv5s=;
	h=From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:To:Cc:Autocrypt:OpenPGP:From;
	b=M6Prz6g0mTiSnvxfDKggl964jXXxLjW+eYeVr2UcukuV8J4P0r8UqDuH1FTGnIY0v
	 +UE44S7UwAcXGZcRAC4lWn8/byGu39LSFwxXpWEE90qwsi0lqXiYGUaMqku/S5HxPe
	 kFQpZBimF8FfEnGqsIFzllULIjUPoHif8V7+q9B0kKa789qxQll/y7Nq0QbT8VrigU
	 gq5F9eLaQbW8LLqRO2KG2EBl2M22HcKYXQ/Q76NJHsIRlAY/DR/iXDeVnBJgkzoVDb
	 rQ0aegflOyeOZVdztu8MFK1bXXv9DXVdyJGKiX3w6U9pT/P6iM0JZ4hLCXUe4w1bEH
	 2uIgXpYDs3x4w==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4gSS8C6sz0z6v07;
	Sat, 30 May 2026 19:36:43 +0200 (CEST)
From: Markus Probst <markus.probst@posteo.de>
Date: Sat, 30 May 2026 17:36:45 +0000
Subject: [PATCH v9 2/3] samples: rust: add Rust serial device bus sample
 device driver
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260530-rust_serdev-v9-2-f8b5fccb49c3@posteo.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4748;
 i=markus.probst@posteo.de; h=from:subject:message-id;
 bh=kWHqDqopsoLEzI8G/1jRCL4n/V6ei1IvSJlqCr5mfNY=;
 b=owEBiQJ2/ZANAwAIATR2H/jnrUPSAcsmYgBqGyAokNYmsRaMY6YI9zOiGzldLvw7in1VRqGtI
 JTpSct2swOJAk8EAAEIADkWIQSCdBjE9KxY53IwxHM0dh/4561D0gUCahsgKBsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQNHYf+OetQ9K75A/+P2LkdVUThAh6qm88n4leAtDfPjQf1pZ
 TTNrkBdlbHC3Mzxfgnl379cCOXCANOE+Jl+aR2xT7P2QrrQ393oSZKH2y0sMsRHi3an/6H6LwQM
 r3NqJzBzY6PKc/q84osAxLLgd6EUmNx1I7xZiSAbgdWp+LPLiLziuyisgnN4KVmc1CPb6YdIBv+
 21wZmSKOkz71Z1Hntiyq8hyj0gYeVOzrp2l9fg/7hBaGoDoXKJ/3D/4OI8sz8ou75mXkQwheKAN
 M9cT2SxiC9Dpn8UlwZ5x5p9ouHYdrlCWjWaAUtNCqDX1tuh2+qI+cLqMtGKMCMlaiawTcJhfRaX
 lJTPZSKHCnbYDZG337Wsv35LTJC0yqmnJH1fiT8sPL+2TPABHZUpbzeYiGF0PV7kTScRwiE10oP
 M5fIcOE5ePupmWBoVdjLlc3+QpNYOYHlWGcYk48mVV8qlbNZsJ7rR6Qj8lFQ7ZqwcmqIbRS0bP+
 fqoUSMyzI1fZriA3AAAc0Qh1jIy9OUG0Mm5y9n2V80H3p4rIa60fRKu+JLSf6tw3eFmYjtXDBss
 VCjgxQNikjMkw9rSHsEZtg7O5D6sRhvWeB4RqAJVw19kNX4uUta40/EVe1shnAjYRFsd7z6mthM
 qnMSLyrp6by7+jeMlcwFRqsAYKJB9ja8XAG7SPJSzjQQobWz4MdE=
X-Developer-Key: i=markus.probst@posteo.de; a=openpgp;
 fpr=827418C4F4AC58E77230C47334761FF8E7AD43D2
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
  keydata=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
  aBeNN4ijKZchBXHPgVx+YtWRHfcm4l8=
OpenPGP: url=https://posteo.de/keys/markus.probst@posteo.de.asc; preference=encrypt

Add a sample Rust serial device bus device driver illustrating the usage
of the serial device bus abstractions.

This drivers probes through either a match of device / driver name or a
match within the OF ID table.

Signed-off-by: Markus Probst <markus.probst@posteo.de>
---
 MAINTAINERS                        |  1 +
 samples/rust/Kconfig               | 11 +++++
 samples/rust/Makefile              |  1 +
 samples/rust/rust_driver_serdev.rs | 91 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 104 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d2f608ff8ca0..fa3f20f0cc4f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -24278,6 +24278,7 @@ F:	drivers/tty/serdev/
 F:	include/linux/serdev.h
 F:	rust/helpers/serdev.c
 F:	rust/kernel/serdev.rs
+F:	samples/rust/rust_driver_serdev.rs
 
 SERIAL IR RECEIVER
 M:	Sean Young <sean@mess.org>
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
index 000000000000..824affbf6593
--- /dev/null
+++ b/samples/rust/rust_driver_serdev.rs
@@ -0,0 +1,91 @@
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
+    type Data<'bound> = Self;
+    const OF_ID_TABLE: Option<of::IdTable<Self::IdInfo>> = Some(&OF_TABLE);
+    const ACPI_ID_TABLE: Option<acpi::IdTable<Self::IdInfo>> = Some(&ACPI_TABLE);
+
+    fn probe<'bound>(
+        sdev: &'bound serdev::Device<Core<'_>>,
+        _info: Option<&'bound Self::IdInfo>,
+    ) -> impl PinInit<Self, Error> + 'bound {
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
+    fn receive<'bound>(
+        sdev: &'bound serdev::Device<Bound>,
+        _this: Pin<&Self>,
+        data: &[u8],
+    ) -> usize {
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

