Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01EC352021;
	Sat, 30 May 2026 22:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780181470; cv=none; b=B3G9KjAndXHK3BuPHxm+PaLApyV2xaWK5R3dZU3PIJ8EsHmyfNbYS5oSI42QzVN56Rgu1k9sGXOgTw7GzLSaQgZn9f2IgaGus6Qi2idrIqy9fxKVIA6RYBGCUEno55pFiO/ge3iUrOnAw2pa3JuGpNaejIZTcAacPUp082t8Rxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780181470; c=relaxed/simple;
	bh=gzwQn4QR7YvkVSmraaAW6KXwXLc7aY1SuTuzC9ytKeY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ViXzYZwyl8Xg9RUcGlVixg+nqy6lka7w+7sOBLNz9+sp04mefrhCQHj95Jy4relAPyQWjGGHHt2hWT4/5j0nKWURsXYDkhDXgyFepRJPU54prM76gdNLUH5G8asrDMvIhP6I6ZcMUipa/+LgebQb2nJk+jBFmlYI4axC0LwaVzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cQ8OvSIk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cQ8OvSIk"
Received: by smtp.kernel.org (Postfix) with ESMTPS id AE0ACC2BCC4;
	Sat, 30 May 2026 22:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1780181469;
	bh=gzwQn4QR7YvkVSmraaAW6KXwXLc7aY1SuTuzC9ytKeY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=cQ8OvSIkfIF8bvyR7DRehuwvI8NJqr6C3+tqmN13jSYeJBVws4ZllBnZDLHMhihHi
	 OlL59y7hGjoWqwKEkROAZBPqA1jVoDLhH42ARQKu+qUaTTbOdgP76bBNIVsu11G1F3
	 VhDWzXg0g7oUGIZiGGLCG+B3k71CHgl//6wl4EZEP+L4Dhyhn70HVl8FUQg4LbwlE+
	 3IEW4JchJaszQxnnRhlwi92J6iFm4ZpHxvhPAr6LBw1IKyjhbc/r0l+Ffldj22jwiV
	 ovJBb77qHzKdKfSUpCUUsfebF6T/CiFYddPfmVw2CrWH8Bpb7k6CzwX8O0eFpNdRcq
	 L6C8tGxW34tNw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9804ECD6E55;
	Sat, 30 May 2026 22:51:09 +0000 (UTC)
From: Markus Probst via B4 Relay <devnull+markus.probst.posteo.de@kernel.org>
Date: Sun, 31 May 2026 00:51:03 +0200
Subject: [PATCH v11 2/3] samples: rust: add Rust serial device bus sample
 device driver
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260531-rust_serdev-v11-2-dee8e0d830f1@posteo.de>
References: <20260531-rust_serdev-v11-0-dee8e0d830f1@posteo.de>
In-Reply-To: <20260531-rust_serdev-v11-0-dee8e0d830f1@posteo.de>
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
 bh=kWHqDqopsoLEzI8G/1jRCL4n/V6ei1IvSJlqCr5mfNY=;
 b=owEBiQJ2/ZANAwAIATR2H/jnrUPSAcsmYgBqG2nbjiYLz8DJL150lcAUNv4Gdkk1J36FrBI3N
 8Scnj7RpEuJAk8EAAEIADkWIQSCdBjE9KxY53IwxHM0dh/4561D0gUCahtp2xsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQNHYf+OetQ9LAUBAAtjx50q2pO9XPqqeOXWI/58jaPZGuHk/
 iXi13/cmxV6uPdYz6Bwv1VqiPRY1n8I3UTa70jP5TLilvtoQIlRGEwwHsSkAeAwQq/3zPwo4sv+
 C5Jxk6/v9vJU+Wl3g4zT3o/cIbaKS+nsOvwV9jsyVY7agtBbzhASR3pjwEUhDnFuvunbhPWe33u
 uFC5+idDJP8ZA4W0vmLAWoNxlIPwkcuboDwgPPvCDOutoKBu3lskYwcYirQedhhxGY/oqRBqc7S
 5xr1vVyt+Cwe4hhNcDocjm+nn99Po6qD7uV5DFspWedFBUq7jCqoddMcI8JC58k6vaEjWf17Yoo
 jelV9mITG5WHNMCjkhOGlvfuveTgqSqHxFr5Zv3mjWM9QF2wxk8fOjSe2dWH21NrtrrFNwSRbIV
 XD4VdT3DZzc+eZF+FxSobTPlSDv9/wj7tlcX/f+azDvf6MAUSqWbYeuL5WouY4jls2z15cF0Hwv
 CGO+6LY1PtwFlY/WgN3lo2hPHdMjb50Q5UunxTlyjHySEOyeMzNJSEj9MSvsYVO098BwYfdEZ1S
 jK4TfXlCh2NHj03CsDOocdpfX9pXOkkk9lfMQ6akmBXeQDb/xR0n0o6s2+UGziIm/vAdaVagOfj
 JhOWjjEF8S6mp0eDbFJztPh4k/xaQZfxfYnTKXlgFSo4GbHGvTWg=
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


