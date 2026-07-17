Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0C51F2B8D;
	Fri, 17 Jul 2026 12:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784290831; cv=none; b=WMLAX706BFslliZXrKNK6ihXgWW0hLwtNGbNjeTMVFvcew7mSzUnOTC5S8LvUCvef2Lq2d4Wu6eFfiwyENGUOt76YJ5dRgcNzMuF6xdW6lG3utT+Zj+nf2LBco6QQK3X02/bX7PKM+j+Q2J+1HYaY4sYlm12+ukU1+SiMbhGtWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784290831; c=relaxed/simple;
	bh=OSsYJ0/gsgawmggFSQKGzor9xdhntezQIouMLE96OhE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=pWvzraAdTVBiHEVmiDN24OsH9xFbrO3JoYRpBjEaKCM5Ob/hzqjfzcvjluWwI623gTo81WgXqUPCC3bG+EOGH4W6uBLQ4c4evH4y+f9LrWgcMn+yU82pegPyorYu+cRiZKJAqLuvbVWrVWNcoKngw7D28g4kAD1bcde9DGRZQ50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PJUj1kIZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PJUj1kIZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9D131F000E9;
	Fri, 17 Jul 2026 12:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784290829;
	bh=3zZRRumE1bYiKKWD7igY43RWBksfZ312lkH+RvumdzU=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To;
	b=PJUj1kIZgI7tHJLjsSEFXzZe/B6PsC7PZR8Yl3AinHSLs97AgiIO0zCSmAg3d5nYY
	 LSmWQ7xlpT7892vVtBtQgMVilrYkSdYhTlVrcGFpSZukSQ3EgytGbe5N0hl5xxXUJl
	 evCftt4IH4VmHcsvajxttGCsd6SNWIkl0lfTzjrZcpx//KjjfQoTWjt3EF6p9G+qdF
	 y5tNygDHk0nNP6x7Yq2yDGfV3INf2XYEpMeJmrY51EuTEEDhex7ZWzYTi3+PyMAPoN
	 V70mrE1jdZk55I33VTXze402Qz49QR1CTXMvvZKWeZmpEW3hChZNI78o1AijdVyvUE
	 foX1m9US/waJQ==
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 17 Jul 2026 14:20:23 +0200
Message-Id: <DK0UB4AMYUM9.4T90577F6VAI@kernel.org>
Subject: Re: [PATCH v14 0/3] rust: add basic serial device bus abstractions
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Markus Probst"
 <markus.probst@posteo.de>, "Rob Herring" <robh@kernel.org>, "Jiri Slaby"
 <jirislaby@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Kari
 Argillander" <kari.argillander@gmail.com>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Viresh Kumar" <viresh.kumar@linaro.org>, "Boqun Feng"
 <boqun@kernel.org>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Daniel Almeida" <daniel.almeida@collabora.com>, "Tamir
 Duberstein" <tamird@kernel.org>, "Alexandre Courbot" <acourbot@nvidia.com>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-pm@vger.kernel.org>,
 <driver-core@lists.linux.dev>, <dri-devel@lists.freedesktop.org>
To: "Gary Guo" <gary@garyguo.net>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260715-rust_serdev-v14-0-b4ed5c93606f@posteo.de>
 <2026071747-android-overhead-c927@gregkh>
 <6aafea3fdb0847766787dbe5c7c7dbaad606d649.camel@posteo.de>
 <74213297-d3da-4637-8f31-8fecebd65f60@kernel.org>
 <2026071719-afflicted-eleven-1be9@gregkh>
 <DK0U1G9NCIS9.228MIUKBL4KEL@garyguo.net>
In-Reply-To: <DK0U1G9NCIS9.228MIUKBL4KEL@garyguo.net>

On Fri Jul 17, 2026 at 2:07 PM CEST, Gary Guo wrote:
> FWIW this series will also conflict quite significantly with
> https://lore.kernel.org/driver-core/20260629-id_info-v2-0-56fccbe9c5ef@ga=
ryguo.net/
> which is routed via driver-core tree.

Yeah, but I think it should be trivial (see below)? However, routing serdev
through driver-core does indeed avoid this.

Thanks,
Danilo

diff --git a/rust/kernel/serdev.rs b/rust/kernel/serdev.rs
index 0ffcef1849d2..a1161dd9f37f 100644
--- a/rust/kernel/serdev.rs
+++ b/rust/kernel/serdev.rs
@@ -174,7 +174,8 @@ extern "C" fn probe_callback(sdev: *mut bindings::serde=
v_device) -> kernel::ffi:
         //
         // INVARIANT: `sdev` is valid for the duration of `probe_callback(=
)`.
         let sdev =3D unsafe { &*sdev.cast::<Device<device::CoreInternal<'_=
>>>() };
-        let info =3D <Self as driver::Adapter>::id_info(sdev.as_ref());
+        // SAFETY: `sdev` has been matched by the serial device bus via it=
s device ID table.
+        let info =3D unsafe { <Self as driver::Adapter>::id_info(sdev.as_r=
ef()) };

         from_result(|| {
             sdev.as_ref().set_drvdata(try_pin_init!(PrivateData::<T> {
@@ -334,7 +335,6 @@ macro_rules! module_serdev_device_driver {
 ///
 /// kernel::of_device_table!(
 ///     OF_TABLE,
-///     MODULE_OF_TABLE,
 ///     <MyDriver as serdev::Driver>::IdInfo,
 ///     [
 ///         (of::DeviceId::new(c"test,device"), ())
@@ -343,7 +343,6 @@ macro_rules! module_serdev_device_driver {
 ///
 /// kernel::acpi_device_table!(
 ///     ACPI_TABLE,
-///     MODULE_ACPI_TABLE,
 ///     <MyDriver as serdev::Driver>::IdInfo,
 ///     [
 ///         (acpi::DeviceId::new(c"LNUXBEEF"), ())
diff --git a/samples/rust/rust_driver_serdev.rs b/samples/rust/rust_driver_=
serdev.rs
index a12b1412db30..51b4898cd855 100644
--- a/samples/rust/rust_driver_serdev.rs
+++ b/samples/rust/rust_driver_serdev.rs
@@ -20,14 +20,12 @@ struct SampleDriver {

 kernel::of_device_table!(
     OF_TABLE,
-    MODULE_OF_TABLE,
     <SampleDriver as serdev::Driver>::IdInfo,
     [(of::DeviceId::new(c"test,rust_driver_serdev"), ())]
 );

 kernel::acpi_device_table!(
     ACPI_TABLE,
-    MODULE_ACPI_TABLE,
     <SampleDriver as serdev::Driver>::IdInfo,
     [(acpi::DeviceId::new(c"LNUXBEEF"), ())]
 );
