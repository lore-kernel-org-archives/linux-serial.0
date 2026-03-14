Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7917A55;
	Sat, 14 Mar 2026 13:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773496500; cv=none; b=d+gKXNpyGAp+1cGWh9gO4CXgqGvkVeVy3aRr/5aWSjIcJXBoFE55s4vYik9ULRinEDsrE1MBS0nYsFuB6Dm4yo5JunUtFs5byN4lfpqbLP41dg7Rq0UjDzWqVifeC1NP8m2Tybk5u8Bk+5GK0u+FE1lC6kXsLWi/MqeSI2gPasw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773496500; c=relaxed/simple;
	bh=sAMTEduDQF/XO6vZ67QKE40OllCvzxVjOR0BrzBiCrw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=CohzfQZFMcY2mJ9VApQ6FKYeZbWMD3tWb6TQEP5eXHSS/uQ/FlYJ3Sec6w8c+g+VhvBmMY/o/6VMPqE7dwsxqflQtfnHQR9lCz24I/r4SqP2opAI2THcuZHasYHYhZrmlI+Dsj72Pm3026GKa5VJpqqeNUMX9nMLswNCzS6WVeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gcmz6hjM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gcmz6hjM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82EBBC116C6;
	Sat, 14 Mar 2026 13:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773496499;
	bh=sAMTEduDQF/XO6vZ67QKE40OllCvzxVjOR0BrzBiCrw=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=gcmz6hjMsCu2tRXxs1ESmTp/D9o3tfBlJIRK+KsJmUvXZlxhNJNCSqOOs75K0MpG0
	 Ov1Mjm43tjJwnyRvPjWJ4N+kaHfN8nW2cCxKL0sfySXZxnRUXH6f3fmKkTG38Kni2V
	 /gXeatmwpWA8+fA0eToGbDjY7ZdGxl1yVQ/079gjkkDiOlqP+bCSu/X7vDvNvcGXKj
	 5szSuY4auAknrRIciNNoYlh13h8oOWQJTW2nVYJmO+flUXgCLtA5qOc0lyj3uy20fy
	 Ymnff6Aw04DKM56pNohsMh0VtS4XZlY9l0FuhG4SU1sbYAaemBoFgCl+8qGWKoZ1O9
	 xPSNky2yQr4Xw==
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 14 Mar 2026 14:54:53 +0100
Message-Id: <DH2K1DMGFWYR.1E2UZFI1IUZ0N@kernel.org>
Subject: Re: [PATCH v3 2/4] serdev: add rust private data to serdev_device
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rob Herring"
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
To: "Markus Probst" <markus.probst@posteo.de>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260313-rust_serdev-v3-0-c9a3af214f7f@posteo.de>
 <20260313-rust_serdev-v3-2-c9a3af214f7f@posteo.de>
 <2026031402-absence-graph-af5d@gregkh>
 <a9618d034bd48ec21bd26060573770a548619402.camel@posteo.de>
 <2026031422-shaded-matchbook-5078@gregkh>
 <fa25ed4ff4688a40bd601d695804def772e47af9.camel@posteo.de>
 <2026031447-margarita-untamed-e976@gregkh>
 <DH2JS8YL1NXY.VRKLBSTZ5ZYI@kernel.org>
 <cd773d17f15f3f2e5d047236721a882c35f64595.camel@posteo.de>
In-Reply-To: <cd773d17f15f3f2e5d047236721a882c35f64595.camel@posteo.de>

On Sat Mar 14, 2026 at 2:49 PM CET, Markus Probst wrote:
> On Sat, 2026-03-14 at 14:42 +0100, Danilo Krummrich wrote:
>> On Sat Mar 14, 2026 at 2:31 PM CET, Greg Kroah-Hartman wrote:
>> > On Sat, Mar 14, 2026 at 12:08:09PM +0000, Markus Probst wrote:
>> > > On Sat, 2026-03-14 at 12:52 +0100, Greg Kroah-Hartman wrote:
>> > > > On Sat, Mar 14, 2026 at 11:42:02AM +0000, Markus Probst wrote:
>> > > > > On Sat, 2026-03-14 at 09:07 +0100, Greg Kroah-Hartman wrote:
>> > > > > > On Fri, Mar 13, 2026 at 06:12:31PM +0000, Markus Probst wrote:
>> > > > > > > Add rust private data to `struct serdev_device`, as it is re=
quired by the
>> > > > > > > rust abstraction added in the following commit
>> > > > > > > (rust: add basic serial device bus abstractions).
>> > > > > >=20
>> > > > > > why is rust "special" here?  What's wrong with the existing pr=
ivate
>> > > > > > pointer in this structure?  Why must we add another one?
>> > > > > Because in rust, the device drvdata will be set after probe has =
run. In
>> > > > > serdev, once the device has been opened, it can receive data. It=
 must
>> > > > > be opened either inside probe or before probe, because it can on=
ly be
>> > > > > configured (baudrate, flow control etc.) and data written to aft=
er it
>> > > > > has been opened. Because it can receive data before drvdata has =
been
>> > > > > set yet, we need to ensure it waits on data receival for the pro=
be to
>> > > > > be finished. Otherwise this would be a null pointer dereference.=
 To do
>> > > > > this, we need to store a `Completion` for it to wait and a `bool=
` in
>> > > > > case the probe exits with an error. We cannot store this data in=
 the
>> > > > > device drvdata, because this is where the drivers drvdata goes. =
We also
>> > > > > cannot create a wrapper of the drivers drvdata, because
>> > > > > `Device::drvdata::<T>()` would always fail in that case. That is=
 why we
>> > > > > need a "rust_private_data" for this abstraction to store the
>> > > > > `Completion` and `bool`.
>> > > >=20
>> > > > So why is this any different from any other bus type?  I don't see=
 the
>> > > > "uniqueness" here that has not required this to happen for PCI or =
USB or
>> > > > anything else.
>> > > >=20
>> > > > What am I missing?
>> > > In Short:
>> > > In serdev, we have to handle incoming device data (serdev calls on a
>> > > function pointer we provide in advance), even in the case that the
>> > > driver hasn't completed probe yet.
>> >=20
>> > But how is that any different from a USB or PCI driver doing the same
>> > thing?  Why is serdev so unique here?  What specific serdev function
>> > causes this and why isn't it an issue with the C api?  Can we change t=
he
>> > C code to not require this?
>>=20
>> I think the idea is to avoid bugs as in the mhz19b driver [1].
>>=20
>> This driver's probe() looks like this:
>>=20
>>=20
>> 	serdev_device_set_client_ops(serdev, &mhz19b_ops);
>> 	ret =3D devm_serdev_device_open(dev, serdev);
>>=20
>> 	// Lots of other initialization.
>>=20
>> 	serdev_device_set_drvdata(serdev, indio_dev);
>>=20
>> But the receive_buf() callback from mhz19b_ops dereferences the driver's=
 private
>> data.
>>=20
>> Now, maybe this is actually prevented to become an actual race, since so=
me
>> regulator is only enabled subsequently:
>>=20
>> 	devm_regulator_get_enable(dev, "vin");
>>=20
>> But in any case in Rust it would be unsound as with this a driver could =
easily
>> cause undefined behavior with safe APIs.
>>=20
>> Maybe it is as simple as letting the abstraction call serdev_device_open=
() only
>> after the driver's probe() has completed, but maybe there are reasons wh=
y that
>> is not an option, that's a serdev question.
> If we call it after probe, calls to `serdev_device_set_baudrate`,
> `serdev_device_set_flow_control`, `serdev_device_set_parity`,
> `serdev_device_write_buf`, `serdev_device_write`,
> `serdev_device_write_flush`, which are exposed via the rust abstraction
> would result in a null pointer dereference.

Then maybe ensure that the driver's receive_buf() callback can only ever be
called after probe() has been completed? E.g. receive_buf() could be option=
al
and swapped out later on.
