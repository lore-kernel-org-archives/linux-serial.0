Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115352E6CA8;
	Sat, 30 May 2026 01:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780103634; cv=none; b=oXIjejCj3FpsbaGDdXzi6Hgj4BfTeqtzhqGD1OIE41Zly14F9ASfOtubURFRByXgVjZ2jT2FZtJzKIV5otaIVfgX9CQdOQN/KVQHUKSOTyTlPpW3DCYKdZQTChBt1szoZHtApYkGBj3ajI+3ly1usEs6pojuhnK/ptYv6ozbjhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780103634; c=relaxed/simple;
	bh=gzwQn4QR7YvkVSmraaAW6KXwXLc7aY1SuTuzC9ytKeY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OJaMIiN+AshMArtrEy/0VcDl41lUWrsJBoDoHZrbmDt15OQGx0JngFBS2A6ykGXo22laTXO/cMI8+vTRfeGUHCdsfKumWLB/NMF51Kq4pkwnZHDtqz8wf9DxQwuYY4OY7QM3WQuHBdWA2WbVl7G+ogYXGLklV2txx/gSV0GqdR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hEg8xX1D; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hEg8xX1D"
Received: by smtp.kernel.org (Postfix) with ESMTPS id BD829C2BCFC;
	Sat, 30 May 2026 01:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1780103633;
	bh=gzwQn4QR7YvkVSmraaAW6KXwXLc7aY1SuTuzC9ytKeY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=hEg8xX1DlcMKvY4DHYO805qYw6KD+oO9TKaKQpO+sTctFwAgEAMB49t/SOjm6tyKP
	 15MbHpLYAilrGl9wyJSXBy4nJKQfTsOgZDEADBxXuXRIy7EcbjmhkO339kRVHO2cVL
	 mwAUmEiHbsRCF4KikuFsfUVI6pEMp5vmtQB70m3x/TLoj6H9E18RxStZ1+t5qAKpiW
	 +PV4zyAwaMnms/p7t7Iy+94m3vvDYQ5rChkMOY2I9SRIi/i3uEkXwdGBMTQZsXVMDu
	 K/Y7XY3Xah1HmYja6z2jf7KhqUac/pNbTzJhxK5q8UYGe/74qpgOlKkocZ8/YXirNR
	 83dXRa1I6O5Sw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC13ECD6E55;
	Sat, 30 May 2026 01:13:53 +0000 (UTC)
From: Markus Probst via B4 Relay <devnull+markus.probst.posteo.de@kernel.org>
Date: Sat, 30 May 2026 03:13:52 +0200
Subject: [PATCH v8 4/5] samples: rust: add Rust serial device bus sample
 device driver
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260530-rust_serdev-v8-4-2a95f1da22a7@posteo.de>
References: <20260530-rust_serdev-v8-0-2a95f1da22a7@posteo.de>
In-Reply-To: <20260530-rust_serdev-v8-0-2a95f1da22a7@posteo.de>
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
 b=owEBiQJ2/ZANAwAIATR2H/jnrUPSAcsmYgBqGjnPRNn72Td9zq8gBDeHPnEwMLuEbyhn9QoJV
 7ey3OYIKxWJAk8EAAEIADkWIQSCdBjE9KxY53IwxHM0dh/4561D0gUCaho5zxsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQNHYf+OetQ9ISoBAAiz6b0ORg5BQJX/iNveBI9tafUecjAyu
 c+U6qKgV30WGr5MewI9Iinpt7nsRbnmU+01AjgNMCdx26gWY9FjzkW7+OVWoJ/G9TdVIwAcfvHf
 tnGzhUKll2OWRD4uot1CLYHetld0GYNqvQ1tr4oOijbC2+u02HbIJtno/tJPd0bLB18mBBavOri
 Ky3DQjPm8P8NnL+igy6AF+tLXeazsOnWGL6vcKoOkP4XynqGQhiJ8ijeNrvFVSMBD3c68kaQsr8
 D8KsPLCuEDSpWqu8YaY9AcrsYafKdXxXEVreakOA+xsr78dv5xSzYr52+SNVXY9nIQiex3gsnE9
 q3Z866JASaUXifXzi8mGIPIV8NgRr6UW8G44jS3bI1pxyhnSFEoZcBmbfZDWR+av3A4w56vLgpw
 By5v7d1/dkWZDPwLezSkeA/1ZITL9WrIDlnAmGJUfcpc+a99EgBLzn9WWVuFKH6MXxWOPDCtsLI
 B26Y1p+gzAwDE7LtO4fFZ+siv8nRmN+RJwRJjTpv18ABRdbY1R6h4PaXIIU0njuxI4OiL3S/iYv
 jC06yLDXv6Y/7I8EwC+JC/0CxoVUzX3nbuaqEYpnbh8FkHLOgUOWh5sH2U2Vv71BlwBWy10z/Is
 otrIh140NXGcapzfqqjKzylpF1b7lO54PuzNwRwUZDTr6EDhMJhw=
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


