Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94957365A12
	for <linux-serial@vger.kernel.org>; Sun, 12 Jul 2026 16:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783875522; cv=none; b=munSjyjeR5Uuh8nQVlxFIjV4/57JcLljPvYE61uDd///Jh2nckAFIOa5XDsuSA4c9EYM+KW9nAfx8oqM2kUDiRMubAKvbw4Fp0sY/6uscas5FmwZk64CL+/A2LRI8MApTl2k/7/12XEB8E9zqL2vsEY56Upw7Gx+K/EAjgszuZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783875522; c=relaxed/simple;
	bh=AgFBRrHt1TqcrdJFwcowItxaZJRCaTsR6tDpLp4DgGE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tGPUQ4WUQ5evyUwl4TFB9T0V0SNbPw5ta+CrokFVaFnTmG4qoUkJISIAGdpBlnOrEvF57LlY3QNCVm/8yJekF45K4B8e234EQp9bpINnq0b3TStv8EOGn15T4zMDtQwdPL1Eoqb68wxLp6aelf6C/uFZ/1A7e40gyjaxk0q1AvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=dBBNj8j/; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="dBBNj8j/"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 0B0A2240101
	for <linux-serial@vger.kernel.org>; Sun, 12 Jul 2026 18:58:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de;
	s=1984.8680eb; t=1783875519;
	bh=RQ552J6AxBWAYVe8umfL7ZMuLqs5AWVzKrIxu2FHMdE=;
	h=From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:To:Cc:Autocrypt:OpenPGP:From;
	b=dBBNj8j/kqfw05wFwOMF1eKtG9XHp7BLwxc40RyE9BGoFxSNWS2MRy5ElkzXdl+7i
	 IxHOqT9VrVYAqXXLHv5q87kSpiYVWttjKBow8sqz6I1pWUzvJFh21F46wAKnjHvLJ/
	 0EVx13ybf1ycHETjBWyOa14bxsHh+I6dsE3khEtF+08v3/BAzpSSMMAJAqvvrGzcby
	 E+9GVDFzaYlFLJxsos2Owtej/FThZPFimWzpdvADf/W9iUpW1tuQpUCzSQzOMrM7G2
	 +Ja0mC6CJWLqYqLDNGLB63vanV7c+JEFD3hswMotqQriuDFLgfEshfzA+YHIjJCxle
	 3i/YAfIB8vL9A==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4gysGM4NNlz6tsg;
	Sun, 12 Jul 2026 18:58:35 +0200 (CEST)
From: Markus Probst <markus.probst@posteo.de>
Date: Sun, 12 Jul 2026 16:58:37 +0000
Subject: [PATCH v13 2/3] samples: rust: add Rust serial device bus sample
 device driver
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260712-rust_serdev-v13-2-2c4060bc8e30@posteo.de>
References: <20260712-rust_serdev-v13-0-2c4060bc8e30@posteo.de>
In-Reply-To: <20260712-rust_serdev-v13-0-2c4060bc8e30@posteo.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4748;
 i=markus.probst@posteo.de; h=from:subject:message-id;
 bh=AgFBRrHt1TqcrdJFwcowItxaZJRCaTsR6tDpLp4DgGE=;
 b=owEBiQJ2/ZANAwAIATR2H/jnrUPSAcsmYgBqU8e0dY8i5gXyQ8FzV0LCshGZ+5islVQmwKivm
 RMWJuk8fUWJAk8EAAEIADkWIQSCdBjE9KxY53IwxHM0dh/4561D0gUCalPHtBsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQNHYf+OetQ9JHYg/9H272RYC+tcVLafoI+CHscq4w2XX7Pxc
 E4bk7xb6GZqTshjQ7kiaBltMLiDD0CAQ58VUWzZBGE68dhw2LKPYr+cYXqAbVnuTCF/gRPQI8nV
 z+HOQ3KwoeGTgVu5rV0E1Bh2MtFNyyUf0+sbsRYaJLeXXxSdeoNqKlqLjYgNNOtkfNp9uXiuJeo
 aXIqrSXapkXp8y0QWcy0kokaJgmPUWke53rC1WdyGX59T28UGKyLKu7kpYHctZjnSi5xXWpp1vQ
 lBAgYcgdPrE9oWs7nZr6eQOI879B1nVn2yOhHYndsAXEt787GEm3ctFMJ9DHrRwtEPag+CHQXml
 LSpPP7sVjG+Az+eIA0uEB9z5mS7enF3woeHFuRs+/LXCHBDRl1h2vas+rj9M8AkiQy0/HdVELYA
 2x+IwiEoyCJJD7hlC15Fy4Jp47YexdTjziycSchHl/8egsEJwUeeBb9/G/Aake1uXsS2GPMcLib
 rrqEv4DOVCR6MdFrJIRjhmtbeqWZswusmLgpqDacj3ba6lZbnQA7RC19MF7r4dQLObdbZ7xaiPP
 qrrxkeqnS10YmBvaLxL2qwRKSjKHmNmbwIkv4226bRlcp3foOfPBS8yrvJUNy5LF96a2scMF9K0
 jIYY87BVAfl14sI62Tjl/kyVTRHDIUHWOeaPfGHGfFdl2BJ+JGbQ=
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
index 00d977ce7028..ed4f8f2f17d5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -24569,6 +24569,7 @@ F:	drivers/tty/serdev/
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
2.54.0

