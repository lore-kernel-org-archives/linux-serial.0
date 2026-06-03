Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719C13DA5C3;
	Wed,  3 Jun 2026 15:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780502205; cv=none; b=JsYLzSHNwTTYF1kqsMBIZtcdvYCeS7IX3HN41FRVAVpXQ7jvs3itf+wkBQwLo7qwLlA6iyqiVc5hpuMdVIO1iDl1E8pyqf5vgZMkJpeOPEhBobUu53xe4rAX7dp9x/KL5CZ3e/n4vFkk1xjiQ+pwAOpM/Q73hKMmVXzt2Me9Ngw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780502205; c=relaxed/simple;
	bh=r6qS2QK0QDZzI5OPlQCblhpmk0XQ5HoysdLwKjaKnU8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FPBnaCaN/7QheJ5bwQXLHiLbn7KgivFteAdVE7Bx8C/VD16/nhMBM03HYQRUmYqRGb8xzEhtHKS3bhjJoXSYFrmqctLGd41jhRxim/189eYbE4rmlrWReYpc0C8JhiFbYvxpiv8Fx29mJI/Sm/GOFBKh9LLE2zW9Qu0Hu8BMg6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dn2j6fJL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dn2j6fJL"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 25825C2BCC4;
	Wed,  3 Jun 2026 15:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1780502205;
	bh=r6qS2QK0QDZzI5OPlQCblhpmk0XQ5HoysdLwKjaKnU8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Dn2j6fJLSbsHMLbXPGK0B6y5uRtump87IJjsRAmd8kADi2sUnmDE8iDGU+2cEXXZR
	 HmEyf8PAVHykNVQPXg3W0zpMKGct06iH6D3oGR12HXUjC+oEWJpM7jHN22Va0Zuw0J
	 ALMqfjmUO9IDdH7Hw971/ZAOqK7apfgfUrmHieq4gvf42AnX71nGWsL3XMQr3rhjCI
	 l+8dvr7AcCuXT2LcKoOvSipwh10RNYuzTbq/aOTn10ywJJzc4jRn08jgoEH/Wki7RJ
	 iDoNirJr2dAxd4kZOl3ulCmmM4Rhd0e5T534NN5X/okGUl+RuXWpMmX5SLZiNRWTi1
	 6LCcrq7qTCYSQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B209CD6E6D;
	Wed,  3 Jun 2026 15:56:45 +0000 (UTC)
From: Markus Probst via B4 Relay <devnull+markus.probst.posteo.de@kernel.org>
Date: Wed, 03 Jun 2026 17:56:40 +0200
Subject: [PATCH v12 2/3] samples: rust: add Rust serial device bus sample
 device driver
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260603-rust_serdev-v12-2-3400ffb88b12@posteo.de>
References: <20260603-rust_serdev-v12-0-3400ffb88b12@posteo.de>
In-Reply-To: <20260603-rust_serdev-v12-0-3400ffb88b12@posteo.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4748;
 i=markus.probst@posteo.de; h=from:subject:message-id;
 bh=gHj+a0iolyCoCcEpqpsr2jWHjdD96arYc+2miLWbMBc=;
 b=owEBiQJ2/ZANAwAIATR2H/jnrUPSAcsmYgBqIE67tlZHiyRUi+U6ZDY0Ksr4tJ5INiFRt7Enp
 dvQ0rrPHz2JAk8EAAEIADkWIQSCdBjE9KxY53IwxHM0dh/4561D0gUCaiBOuxsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQNHYf+OetQ9JEww//RXScslFa5VWTCnxkwNVZLMT5KqaLWRc
 wWNy0Mew+HT89c4P/ddqB19nwgNgJAlXKQQTN637FI1zTk7PHZgnjtAyJtfV8pGBczxdZrW7lbH
 lL8UmlQnMqshHXhNZxdszh5/BWgdtW1EN4bYRi3Ut1ClEjncDNVsewgT8BVYASYUgACHZds0TUF
 j6iBWn+WbElZFBvcURuIWuF23hNr+eho1BsqVylP9DlUmHh+jrM+UMOwup+hbkngUbH3neCTWew
 ecwRoolu8IObG5Pd+8pUgilC5R4r3hN48IZnVVZkjOV9ombiapCi0jyAhTTrO2uWn/DulTy/OTE
 qqkuQugVVQgAyf8+pxNnAX2fiTW9Q0lpZTPGzCVNFh94y3kltc37jSpk8vgJENuWF2Dg0T/KNf2
 RQpETI8bKNERgKQZaRi/exzm0BLi/p/6RbrlRFlK9B26bYMMm5ZG+4N0xSGIoRWSPeK5/xKzrFR
 vWE0qzptdxLB4gGrPynDI6zaMYZqWEAna3He4OzgENm3fYbdf+Z+Z4aYgB3ogwNADuQ6/VD1qqu
 2i22bC8oik0FcVNYUOhAIXdDxXbffqrRd1InCmQ4IbmDt2Mvlo49+F9Vf5V78CuYmDXhFaV6SSc
 NpYf7w8Goz8R3KyxlJSgVbQeeMylXLuEh7NI33/7lMW3RMY6JsIs=
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
 MAINTAINERS                        |  1 +
 samples/rust/Kconfig               | 11 +++++
 samples/rust/Makefile              |  1 +
 samples/rust/rust_driver_serdev.rs | 91 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 104 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d21be30a2d9d..3b995cb6e902 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -24279,6 +24279,7 @@ F:	drivers/tty/serdev/
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


