Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7532F25E4;
	Sat, 30 May 2026 16:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780158437; cv=none; b=BWCIr2twuHtCZYrVJnBiYw5CewuZMxfCHqh3Lso9IBctTnRaRzZCUTWafnuxhdDRqrXB6/Vm+lGlsSIL+rYUX4u8O1FizbHOEqcelACrePBrMyupT7MJmBy1P1egKYLR67XRzSg5/a5kaAQxEwZF/h1D9DnQykzfhcE2jRdfzIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780158437; c=relaxed/simple;
	bh=vsKx3540/iKqitsEyzP1xSmy0Z0WswkKSQA5VHp8uSI=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=KFwOe56NsZcuYQdG1ogxO1x2oHB9wKnmD1j6lX9hBtbYHL1xpSzYlKTvUTWXGEO0ZamuOIyWTUek7NRYpqYGHmJrOJulrrkPAN8wjdFJkZiB1ak8aNrw5BeZXqdfykeEqlqtJWa5eup7vRgiJZfja5sKBaw7nS6CMsbfkbjTcTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WAX4c6XY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WAX4c6XY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78D8B1F00898;
	Sat, 30 May 2026 16:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780158436;
	bh=vsKx3540/iKqitsEyzP1xSmy0Z0WswkKSQA5VHp8uSI=;
	h=Date:To:From:Subject:Cc:References:In-Reply-To;
	b=WAX4c6XY7BxHmrJbhT+pVJGq4IxWWnlnNsRh+VUjfyZ29gGf//+SXwQK9iGBzjx61
	 dAFKWWdLKdcKJAl+/t5i4hxEm7hBKa1dqUrKyd7b7jbwSU9epsBbS455vgTZpAS/e7
	 lI7Xtkx7gEHymFuCVUrgayBEl/uME2+PI9hmhaQnQyZvDB51fcMf7P7hKosA0EpHj+
	 hduV17gtcOpD4HzwVdzyRWMTFUeKgQdIBdk65m27m4hEIqDxhRhAPr4/goCz2Dxb3p
	 MnT6W/t7HZsJ7lq0AEsNqjwpPi/lnJsf87BseAWUkxMCfmceDpZ38P8ba725lhl2T9
	 CYuwRijC2uo1g==
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 30 May 2026 18:27:11 +0200
Message-Id: <DIW5HXH3HYDB.17132XFBBDBJL@kernel.org>
To: "Markus Probst" <markus.probst@posteo.de>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v8 3/5] rust: add basic serial device bus abstractions
Cc: "Markus Probst via B4 Relay"
 <devnull+markus.probst.posteo.de@kernel.org>, "Rob Herring"
 <robh@kernel.org>, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Jiri
 Slaby" <jirislaby@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>, "Gary
 Guo" <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Kari Argillander"
 <kari.argillander@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 "Viresh Kumar" <viresh.kumar@linaro.org>, "Boqun Feng" <boqun@kernel.org>,
 "David Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>,
 <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-pm@vger.kernel.org>,
 <driver-core@lists.linux.dev>, <dri-devel@lists.freedesktop.org>
References: <20260530-rust_serdev-v8-0-2a95f1da22a7@posteo.de>
 <20260530-rust_serdev-v8-3-2a95f1da22a7@posteo.de>
 <DIW1B4FUIXO7.28GSUA0CEA4EV@kernel.org>
 <4638946fc49a38797b716ea173c93327eb751479.camel@posteo.de>
 <ad98dfb1d8469022519d37364e8a068bed3b5687.camel@posteo.de>
 <888dc39c52bb6ddac1a1eed7876c4573bdbef002.camel@posteo.de>
 <DIW2JUUL6A6J.96VI4IQN6HYU@kernel.org>
 <55eae11ea68f129508d0f7e30ac457ba919812b2.camel@posteo.de>
 <DIW34DX6BSUS.ANXBOP9687B0@kernel.org>
 <25dc9a4bbde0b542abf608be1b3305f1421a4502.camel@posteo.de>
 <DIW587AGXYCS.39MR1B4TVSO9@kernel.org>
 <6e5fd4275c2bbaeeac95a0ad4fe15bb8237d6a22.camel@posteo.de>
In-Reply-To: <6e5fd4275c2bbaeeac95a0ad4fe15bb8237d6a22.camel@posteo.de>

On Sat May 30, 2026 at 6:23 PM CEST, Markus Probst wrote:
> On Sat, 2026-05-30 at 18:14 +0200, Danilo Krummrich wrote:
>> On Sat May 30, 2026 at 4:51 PM CEST, Markus Probst wrote:
>> > On Sat, 2026-05-30 at 16:35 +0200, Danilo Krummrich wrote:
>> > > On Sat May 30, 2026 at 4:27 PM CEST, Markus Probst wrote:
>> > > > This would work, but I don't see how it would get rid of rust_priv=
ate_data in
>> > > > this way. The device private data will but the private bus abstrac=
tion data
>> > > > needs to outlive the devres callbacks (which is done by rust_priva=
te_data).
>> > >=20
>> > > Why? You only ever use it in the receive callback, which won't be ca=
lled after
>> > > device unbind anymore.
>> > Because the possibility exists that some classdev ops or Drop calls
>> > e.g. sdev.set_baudrate. This is a null pointer dereference after
>> > serdev_device_close has been called. I interpreted it to add a state t=
o
>> > the abstraction private data which would prevent those calls (early
>> > return with error) after serdev_device_close has been called, but this
>> > would only work if it outlives these calls.
>> >=20
>> > But it seems you were refering to something else with the state?
>>=20
>> Yes, but I just notice that I'm a step ahead. With the lifetime model cl=
ass
>> device registrations shouldn't be guarded with Devres anymore, but with =
a
>> lifetime.
>>=20
>> (This also entirely eliminates the need for having different devres stag=
es to
>> prevent drivers from smuggling a newly created Devres object into an exi=
sting
>> Devres<Registration<T>>'s data, which would be unsound for obvious reaso=
ns.)
>>=20
>> With this there is no way there are still class device callbacks after t=
he bus
>> device private data has been dropped in the first place.
> There would still be Drop, which can access the device.
> Drop happens after remove_callback.

But you control drop(), so can order it such that first the driver's bus de=
vice
private data drops and after this the private data of the bus wrapping it (=
which
will also call serdev_device_close()).

> Might be simpler for now: I can use a mutex to prevent calls in
> receive_buf after remove_callback has been called.
>
> Thanks
> - Markus Probst

