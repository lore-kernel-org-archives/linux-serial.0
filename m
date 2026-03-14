Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7647F258EE0;
	Sat, 14 Mar 2026 13:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773495784; cv=none; b=OPa5rEkrkOVF9vYNxzuvuMgF109gQ70FxGY9az/hlRmbMXQ0C2y4LE7kc2NFp1d4x8vsnEettBMjrKnF1F+7/uJLS+sgF83KWTNhwcqzLjkFHMYeYWTggfS1679jRDzfKjjX8V4UNzhLbSRpoApqct23InpEd5zlND+J2+CAIj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773495784; c=relaxed/simple;
	bh=g5Do5nZMKHEtNCoQ4h79Z8jl0PjbdYhB40fwSrssP/w=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=ri2Dp5g8V3RIDfhRpM62BB3YIWIv2wNcxK5pKiB9Yx92hNJVGK2GQV6tJ4y7h7eGHo7Ma8zsxHof24ZCaHbRLTq9Vv9DKOCmLJroumxWkQFY4ZL2KB7dGPRCFN0AS+Jwg3xoVfRkoTx/vq3jWvjU4jNj01LciHGhB/vQnzcEs/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NLXHBWRy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NLXHBWRy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9FCAC116C6;
	Sat, 14 Mar 2026 13:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773495784;
	bh=g5Do5nZMKHEtNCoQ4h79Z8jl0PjbdYhB40fwSrssP/w=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=NLXHBWRymRglNmukchM7+o+TYhS8fPRLo7Vungti5SkzeEgqAroZ1RigMKmYG2UfO
	 fNRHHmQyBL0PBSTHFFNV8n6oOOSzP1Z3K01V1LxaEv7X96oES5Gj78RwwBp4FKBjFI
	 JaHxLO1vBwlc61SXH8XyXq/ZyHKa5q75xoA99rM8Pu3pXENCY2rXVNiCrfrNgVC6Jk
	 H9UVotUkq8slM8TD2n6qwq+Ut1xqIz+zE16RAJVd7ZqM0JdwTkAP19xIx3GdDp3SrP
	 2ZAT4A6PfTxJSYiKDyMkmSgLs3R9pD2ZmJzIExv9JSc3TlimEd2dMXG5w6lGNULYYa
	 jmVEdkUwVsblw==
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 14 Mar 2026 14:42:58 +0100
Message-Id: <DH2JS8YL1NXY.VRKLBSTZ5ZYI@kernel.org>
Subject: Re: [PATCH v3 2/4] serdev: add rust private data to serdev_device
Cc: "Markus Probst" <markus.probst@posteo.de>, "Rob Herring"
 <robh@kernel.org>, "Jiri Slaby" <jirislaby@kernel.org>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Kari
 Argillander" <kari.argillander@gmail.com>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Viresh Kumar" <viresh.kumar@linaro.org>, "Boqun Feng"
 <boqun@kernel.org>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, <linux-serial@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-pm@vger.kernel.org>, <driver-core@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260313-rust_serdev-v3-0-c9a3af214f7f@posteo.de>
 <20260313-rust_serdev-v3-2-c9a3af214f7f@posteo.de>
 <2026031402-absence-graph-af5d@gregkh>
 <a9618d034bd48ec21bd26060573770a548619402.camel@posteo.de>
 <2026031422-shaded-matchbook-5078@gregkh>
 <fa25ed4ff4688a40bd601d695804def772e47af9.camel@posteo.de>
 <2026031447-margarita-untamed-e976@gregkh>
In-Reply-To: <2026031447-margarita-untamed-e976@gregkh>

On Sat Mar 14, 2026 at 2:31 PM CET, Greg Kroah-Hartman wrote:
> On Sat, Mar 14, 2026 at 12:08:09PM +0000, Markus Probst wrote:
>> On Sat, 2026-03-14 at 12:52 +0100, Greg Kroah-Hartman wrote:
>> > On Sat, Mar 14, 2026 at 11:42:02AM +0000, Markus Probst wrote:
>> > > On Sat, 2026-03-14 at 09:07 +0100, Greg Kroah-Hartman wrote:
>> > > > On Fri, Mar 13, 2026 at 06:12:31PM +0000, Markus Probst wrote:
>> > > > > Add rust private data to `struct serdev_device`, as it is requir=
ed by the
>> > > > > rust abstraction added in the following commit
>> > > > > (rust: add basic serial device bus abstractions).
>> > > >=20
>> > > > why is rust "special" here?  What's wrong with the existing privat=
e
>> > > > pointer in this structure?  Why must we add another one?
>> > > Because in rust, the device drvdata will be set after probe has run.=
 In
>> > > serdev, once the device has been opened, it can receive data. It mus=
t
>> > > be opened either inside probe or before probe, because it can only b=
e
>> > > configured (baudrate, flow control etc.) and data written to after i=
t
>> > > has been opened. Because it can receive data before drvdata has been
>> > > set yet, we need to ensure it waits on data receival for the probe t=
o
>> > > be finished. Otherwise this would be a null pointer dereference. To =
do
>> > > this, we need to store a `Completion` for it to wait and a `bool` in
>> > > case the probe exits with an error. We cannot store this data in the
>> > > device drvdata, because this is where the drivers drvdata goes. We a=
lso
>> > > cannot create a wrapper of the drivers drvdata, because
>> > > `Device::drvdata::<T>()` would always fail in that case. That is why=
 we
>> > > need a "rust_private_data" for this abstraction to store the
>> > > `Completion` and `bool`.
>> >=20
>> > So why is this any different from any other bus type?  I don't see the
>> > "uniqueness" here that has not required this to happen for PCI or USB =
or
>> > anything else.
>> >=20
>> > What am I missing?
>> In Short:
>> In serdev, we have to handle incoming device data (serdev calls on a
>> function pointer we provide in advance), even in the case that the
>> driver hasn't completed probe yet.
>
> But how is that any different from a USB or PCI driver doing the same
> thing?  Why is serdev so unique here?  What specific serdev function
> causes this and why isn't it an issue with the C api?  Can we change the
> C code to not require this?

I think the idea is to avoid bugs as in the mhz19b driver [1].

This driver's probe() looks like this:


	serdev_device_set_client_ops(serdev, &mhz19b_ops);
	ret =3D devm_serdev_device_open(dev, serdev);

	// Lots of other initialization.

	serdev_device_set_drvdata(serdev, indio_dev);

But the receive_buf() callback from mhz19b_ops dereferences the driver's pr=
ivate
data.

Now, maybe this is actually prevented to become an actual race, since some
regulator is only enabled subsequently:

	devm_regulator_get_enable(dev, "vin");

But in any case in Rust it would be unsound as with this a driver could eas=
ily
cause undefined behavior with safe APIs.

Maybe it is as simple as letting the abstraction call serdev_device_open() =
only
after the driver's probe() has completed, but maybe there are reasons why t=
hat
is not an option, that's a serdev question.

[1] https://elixir.bootlin.com/linux/v6.19.7/source/drivers/iio/chemical/mh=
z19b.c#L260
