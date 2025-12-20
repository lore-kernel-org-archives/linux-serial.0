Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E233112BD
	for <linux-serial@vger.kernel.org>; Sat, 20 Dec 2025 18:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766256256; cv=none; b=oDf351Z+APvqYJIRBrOjGF49L4yQWv+qpl0dqf81xosHplCNd9k2SzLEGN/1Htzilpwbpmv/9KDcjJDaHkO/W36U02kWOCxpULkgTq9kbrM9JlgGKtiXPWlqF+ELrWsYvtX68BGk12f3JwtPWs1AjB7ohcBziL44WCR2im08uos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766256256; c=relaxed/simple;
	bh=aZqeahUjQLCiJk72azPd4I5DmJ0fC6eqFPQ9m57O/Fc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tj/ADnhg7Y+bbpaqt6gIhFJ+v6USeagNpISCouDSx+e0Fkllbvti8VnOgfJB/rH1Qbh7peGGtAkylJe44WIwMmPLJEhc1ro7c0tSgCxgPqWJ4KjRl4lmp+WlqFO9QQzCLXXV8JAwT+JVyOuTFOm42zQnxity0kVJYOeV4OKiqo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=p3ulSR5p; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="p3ulSR5p"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 7009E240106
	for <linux-serial@vger.kernel.org>; Sat, 20 Dec 2025 19:44:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de; s=2017;
	t=1766256248; bh=wOcrld681LngU0MiZ8DHfy9jiZ/IlT36yUJBg6cYTFE=;
	h=From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:To:Cc:Autocrypt:OpenPGP:From;
	b=p3ulSR5p6AeuirYDy53zNUAmAUxXF3w4hKOCUoeEI3qCObtRWT0/gUNutyxWynLuE
	 4zaxAqAEnbGoH0Qbv7R+PNgAfjaQL8Q6xYgebvSGOgiPzfWhEtKF/DVIsZxGEJSk0A
	 MMm0ALjEbHizkq2ZXwT/LAIkoH7LRIiR9QRJBmQVuMZXPdSvfab0pcaDV1OVXF6tc5
	 PbmAeXlqz+1jzuMB4XnIyYvNYc+SxKcaQvW1izSXhXshP38LvsvUe4Sxi4IbM2DSY5
	 AVicaeSaZvBXv+5MsOFPJSahYZLwcbWTM3IOYjoEbCcI72WEySlwxnGgnzq8oSKonz
	 vfdExD9yq3PuQ==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4dYYGG5mCZz9rxN;
	Sat, 20 Dec 2025 19:44:06 +0100 (CET)
From: Markus Probst <markus.probst@posteo.de>
Date: Sat, 20 Dec 2025 18:44:07 +0000
Subject: [PATCH RFC 3/4] samples: rust: add Rust serial device bus sample
 device driver
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251220-rust_serdev-v1-3-e44645767621@posteo.de>
References: <20251220-rust_serdev-v1-0-e44645767621@posteo.de>
In-Reply-To: <20251220-rust_serdev-v1-0-e44645767621@posteo.de>
To: Rob Herring <robh@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Kari Argillander <kari.argillander@gmail.com>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, Markus Probst <markus.probst@posteo.de>
X-Developer-Signature: v=1; a=openpgp-sha256; l=7285;
 i=markus.probst@posteo.de; h=from:subject:message-id;
 bh=aZqeahUjQLCiJk72azPd4I5DmJ0fC6eqFPQ9m57O/Fc=;
 b=owEBiQJ2/ZANAwAIATR2H/jnrUPSAcsmYgBpRu5yHydp1I6kFuWuDobSCuH260q/vBGf+f5cr
 O4mDgJ7vx+JAk8EAAEIADkWIQSCdBjE9KxY53IwxHM0dh/4561D0gUCaUbuchsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMSwyLDIACgkQNHYf+OetQ9Lqdw/+O9fMa5pBmvSfhAVU0AcRAR/y3ymDFiG
 41sXVugZojnAYPqq1BvYvsau0mToX6F8XIPjdXpOSsSYT3462FUOS8nU6s2xWfcaf15tixLESw9
 WzckrC0R7lHkjvn5CMnb8D9qpRBPnfVqMXav+7vuVjxQHoJfv0hBFiTK7Y3BjDh/A4jNnJPq0/l
 s4IrOk/SrmHSjisfT0S3SP45GwRkwYqP1g0WLteoByQicew0zxQM3TbLHOa2oKmvUIDvSElG1o/
 MyTv5LrD7wwbZXBM+D2KYWKTdl2Yd2vCNpj0YxD5HjmvxxYyTf4sTLPg4S6NAWh7KlwC5iI7A6K
 HNs8/ESFTOGyYI/XjG85nQCMeJkuf+C/NzGkG5nbnuquSf12RW4bim/JmATWNJmmSEwUN92QukH
 4Xi4k6qpV/XSir7SYVcv+xPicb7CceOqe+DTXtkh/Qq4dLks1LQXsGYW0SFqyNWRh6a9qGt6Y3t
 BwTsKiHUO3y+KZKyElE9SgTdLKbmoAjNiHxRmzI0JVGEF3igwyadOUdxGiQz3/9X8fOiB3+vE1A
 bVWzGyfjK8aD1msrGtTgXQdXShhDBN3L+zkfsYVESTYZVhsurN/7c3fw900EWPk0ycitj0Ao/I8
 mBQuK2gUnxgTgWVeT/dI/78SEft2uKhOgh57ShjPup8vC4XXpoV8=
X-Developer-Key: i=markus.probst@posteo.de; a=openpgp;
 fpr=827418C4F4AC58E77230C47334761FF8E7AD43D2
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
  keydata=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
  aBeNN4ijKZchBXHPgVx+YtWRHfcm4l8=
OpenPGP: url=https://posteo.de/keys/markus.probst@posteo.de.asc; preference=encrypt

Add a sample Rust serial device bus device driver illustrating the usage
of the platform bus abstractions.

This drivers probes through either a match of device / driver name or a
match within the OF ID table.
---
 samples/rust/Kconfig               |  10 +++
 samples/rust/Makefile              |   1 +
 samples/rust/rust_driver_serdev.rs | 175 +++++++++++++++++++++++++++++++++++++
 3 files changed, 186 insertions(+)

diff --git a/samples/rust/Kconfig b/samples/rust/Kconfig
index 3efa51bfc8ef..3b6663b4bc9b 100644
--- a/samples/rust/Kconfig
+++ b/samples/rust/Kconfig
@@ -161,6 +161,16 @@ config SAMPLE_RUST_DRIVER_AUXILIARY
 
 	  If unsure, say N.
 
+config SAMPLE_RUST_DRIVER_SERDEV
+	tristate "Serial Device Bus Device Driver"
+	help
+	  This option builds the Rust serial device bus driver sample.
+
+	  To compile this as a module, choose M here:
+	  the module will be called rust_driver_serdev.
+
+	  If unsure, say N.
+
 config SAMPLE_RUST_HOSTPROGS
 	bool "Host programs"
 	help
diff --git a/samples/rust/Makefile b/samples/rust/Makefile
index f65885d1d62b..ec5cb8065fb7 100644
--- a/samples/rust/Makefile
+++ b/samples/rust/Makefile
@@ -14,6 +14,7 @@ obj-$(CONFIG_SAMPLE_RUST_DRIVER_PLATFORM)	+= rust_driver_platform.o
 obj-$(CONFIG_SAMPLE_RUST_DRIVER_USB)		+= rust_driver_usb.o
 obj-$(CONFIG_SAMPLE_RUST_DRIVER_FAUX)		+= rust_driver_faux.o
 obj-$(CONFIG_SAMPLE_RUST_DRIVER_AUXILIARY)	+= rust_driver_auxiliary.o
+obj-$(CONFIG_SAMPLE_RUST_DRIVER_SERDEV)		+= rust_driver_serdev.o
 obj-$(CONFIG_SAMPLE_RUST_CONFIGFS)		+= rust_configfs.o
 
 rust_print-y := rust_print_main.o rust_print_events.o
diff --git a/samples/rust/rust_driver_serdev.rs b/samples/rust/rust_driver_serdev.rs
new file mode 100644
index 000000000000..f23b38a26c32
--- /dev/null
+++ b/samples/rust/rust_driver_serdev.rs
@@ -0,0 +1,175 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Rust Serial device bus device driver sample.
+
+use kernel::{
+    acpi,
+    device::{
+        self,
+        property::{
+            FwNodeReferenceArgs,
+            NArgs, //
+        },
+        Bound,
+        Core, //
+    },
+    of,
+    prelude::*,
+    serdev,
+    str::CString,
+    sync::aref::ARef, //
+};
+
+struct SampleDriver {
+    sdev: ARef<serdev::Device>,
+}
+
+struct Info(u32);
+
+kernel::of_device_table!(
+    OF_TABLE,
+    MODULE_OF_TABLE,
+    <SampleDriver as serdev::Driver>::IdInfo,
+    [(of::DeviceId::new(c"test,rust_driver_serdev"), Info(42))]
+);
+
+kernel::acpi_device_table!(
+    ACPI_TABLE,
+    MODULE_ACPI_TABLE,
+    <SampleDriver as serdev::Driver>::IdInfo,
+    [(acpi::DeviceId::new(c"LNUXBEEF"), Info(0))]
+);
+
+#[vtable]
+impl serdev::Driver for SampleDriver {
+    type IdInfo = Info;
+    type InitialData = ();
+    type LateProbeData = ();
+    const OF_ID_TABLE: Option<of::IdTable<Self::IdInfo>> = Some(&OF_TABLE);
+    const ACPI_ID_TABLE: Option<acpi::IdTable<Self::IdInfo>> = Some(&ACPI_TABLE);
+
+    fn probe(sdev: &serdev::Device, info: Option<&Self::IdInfo>) -> impl PinInit<Self, Error> {
+        let dev = sdev.as_ref();
+
+        dev_dbg!(dev, "Probe Rust Serial device bus device driver sample.\n");
+
+        if let Some(info) = info {
+            dev_info!(dev, "Probed with info: '{}'.\n", info.0);
+        }
+
+        if dev.fwnode().is_some_and(|node| node.is_of_node()) {
+            Self::properties_parse(dev)?;
+        }
+
+        Ok(Self { sdev: sdev.into() })
+    }
+
+    fn configure(
+        sdev: &serdev::Device<Core>,
+        _this: Pin<&Self>,
+        _id_info: Option<&Self::IdInfo>,
+    ) -> Result {
+        dev_dbg!(
+            sdev.as_ref(),
+            "Configure Rust Serial device bus device driver sample.\n"
+        );
+
+        sdev.set_baudrate(115200);
+        sdev.set_flow_control(false);
+        sdev.set_parity(serdev::Parity::None)?;
+        Ok(())
+    }
+
+    fn late_probe(
+        sdev: &serdev::Device<Bound>,
+        _this: Pin<&Self>,
+        _initial_data: Self::InitialData,
+    ) -> impl PinInit<Self::LateProbeData, Error> {
+        dev_dbg!(
+            sdev.as_ref(),
+            "Late Probe Rust Serial device bus device driver sample.\n"
+        );
+        Ok(())
+    }
+
+    fn receive(
+        sdev: &serdev::Device<Bound>,
+        _this: Pin<&Self>,
+        _late_probe_this: Pin<&Self::LateProbeData>,
+        data: &[u8],
+    ) -> usize {
+        let _ = sdev.write_all(data, serdev::Timeout::MaxScheduleTimeout);
+        data.len()
+    }
+}
+
+impl SampleDriver {
+    fn properties_parse(dev: &device::Device) -> Result {
+        let fwnode = dev.fwnode().ok_or(ENOENT)?;
+
+        if let Ok(idx) = fwnode.property_match_string(c"compatible", c"test,rust-device") {
+            dev_info!(dev, "matched compatible string idx = {}\n", idx);
+        }
+
+        let name = c"compatible";
+        let prop = fwnode.property_read::<CString>(name).required_by(dev)?;
+        dev_info!(dev, "'{name}'='{prop:?}'\n");
+
+        let name = c"test,bool-prop";
+        let prop = fwnode.property_read_bool(c"test,bool-prop");
+        dev_info!(dev, "'{name}'='{prop}'\n");
+
+        if fwnode.property_present(c"test,u32-prop") {
+            dev_info!(dev, "'test,u32-prop' is present\n");
+        }
+
+        let name = c"test,u32-optional-prop";
+        let prop = fwnode.property_read::<u32>(name).or(0x12);
+        dev_info!(dev, "'{name}'='{prop:#x}' (default = 0x12)\n");
+
+        // A missing required property will print an error. Discard the error to
+        // prevent properties_parse from failing in that case.
+        let name = c"test,u32-required-prop";
+        let _ = fwnode.property_read::<u32>(name).required_by(dev);
+
+        let name = c"test,u32-prop";
+        let prop: u32 = fwnode.property_read(name).required_by(dev)?;
+        dev_info!(dev, "'{name}'='{prop:#x}'\n");
+
+        let name = c"test,i16-array";
+        let prop: [i16; 4] = fwnode.property_read(name).required_by(dev)?;
+        dev_info!(dev, "'{name}'='{prop:?}'\n");
+        let len = fwnode.property_count_elem::<u16>(name)?;
+        dev_info!(dev, "'{name}' length is {len}\n");
+
+        let name = c"test,i16-array";
+        let prop: KVec<i16> = fwnode.property_read_array_vec(name, 4)?.required_by(dev)?;
+        dev_info!(dev, "'{name}'='{prop:?}' (KVec)\n");
+
+        for child in fwnode.children() {
+            let name = c"test,ref-arg";
+            let nargs = NArgs::N(2);
+            let prop: FwNodeReferenceArgs = child.property_get_reference_args(name, nargs, 0)?;
+            dev_info!(dev, "'{name}'='{prop:?}'\n");
+        }
+
+        Ok(())
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
2.51.2

