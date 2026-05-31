Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6C32E7394;
	Sun, 31 May 2026 22:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780266750; cv=none; b=aYzkDDjEjGUhO2sea/s1GDUJil2p/NqpH26vN00fucEhNmqBGfIdK2kUEF70jAfTLuJgrLr7ilJP99OP0qi7FSCc03jM3Y54HWBf6lfj6i4zkBmLK3f0k9v9khMoWK/RncZDP8Eui37QpfR6Y50Gj1Ss3UMCIZBySElK6BVUmOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780266750; c=relaxed/simple;
	bh=vcFp1FnzgowI5CEPeGbvY1FEl1Xtv8jOy2nKEQc96Uc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=tINxuPB5eJg8763duZ7Rkg8OESk+ezzzq+qXn917SfpbBdQ5VRS0xLX5LMb5Eh7ANwKBE1JOaD8UUvz5hsg5oCvOXve0aFMSVFFFRIcgj6+tvlaMorTZmJl9mEqt5eopdLF+eiPeJhpynDSmZycYZ4EmnFRyVPseJVWTdFZCw7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dQb4UERY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dQb4UERY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 963B11F00893;
	Sun, 31 May 2026 22:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780266749;
	bh=vcFp1FnzgowI5CEPeGbvY1FEl1Xtv8jOy2nKEQc96Uc=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To;
	b=dQb4UERY3czUPIcYQ84ViYrenYD96gobp7DYYDwXzLDED0BnWJmX2wvl8EU4bKuUG
	 4KuOTUZ0frtZ8gYQsYuKpS2v9+5xlB/KOKaqx0SLzKV5n2MVOn5Fo7fBTslN9aakHM
	 3nPJQytyMlCyIe7Sxi0QRrRf7w5Cyoc+KMc5ngExYFssoPfFm0nbSMjdO7TaNEJxla
	 vuHdMLuOv3Zc3/zPNm58yEESI7kM/vy3Fqrt4Pf0/psbAPkJNrZWISDRiP5dZuMKKR
	 d8qhFuDGXO897OadRa/TjK9kJbBLSc55WF2CTCpn8o3qR66I8REiLBwtw7/2+NTk2U
	 5VsW2Fx9+ck6A==
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 01 Jun 2026 00:32:23 +0200
Message-Id: <DIX7W3C7F1UZ.3P1LHOQSD5VMR@kernel.org>
Subject: Re: [PATCH v11 1/3] rust: add basic serial device bus abstractions
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
To: "Markus Probst" <markus.probst@posteo.de>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260531-rust_serdev-v11-0-dee8e0d830f1@posteo.de>
 <20260531-rust_serdev-v11-1-dee8e0d830f1@posteo.de>
 <DIWEXUCNLURG.136XXDBHSBNVR@kernel.org>
 <12fa6237168ecf6dc65ebf46118beeb5c51f3d1c.camel@posteo.de>
 <DIX6YVWRDL67.3TXDMTAMASCVZ@kernel.org>
 <7c30276759aaba8127275e602cb78783ec33bbe9.camel@posteo.de>
In-Reply-To: <7c30276759aaba8127275e602cb78783ec33bbe9.camel@posteo.de>

On Mon Jun 1, 2026 at 12:00 AM CEST, Markus Probst wrote:
> On Sun, 2026-05-31 at 23:49 +0200, Danilo Krummrich wrote:
>> On Sun May 31, 2026 at 9:42 PM CEST, Markus Probst wrote:
>> > I just noticed, is it even possible to use SRCU here? Currently the mu=
tex not
>> > only ensures that no drvdata access happens after drvdata drop, but al=
so that
>> > the receive_buf waits for the probe to complete, as the drvdata hasn't=
 been
>> > initialized yet.
>>=20
>> Yeah, if you drop the completion, you need the mutex.
> Is the performance impact on an mutex or on srcu + completion higher?

Weighing in the completion, the mutex probably wins as it will always be
uncontested under normal operation.

>>=20
>> (In case it wasn't discussed in previous versions already, there is also=
 the
>> option to just attach separate private data to the receive callback, whi=
ch would
>> avoid this synchonization problem in the first place.
>>=20
>> You could have serdev::Device<Core>::open(), which takes its own private=
 data
>> and a corresponding close(), this way you'd allow drivers to control whe=
ther
>> they want the serial line "open" or not. You just need to make sure it i=
s closed
>> eventually.)
> This would add complexity with types, as we need to ensure that write,
> set_baudrate, set_parity etc. does not run when closed.

Right, but looking at a few serdev drivers, there seem to be a few cases wh=
ere
drivers need to close and re-open.

>> That said, I don't know what turns out to be the better approach. And ma=
ybe it
>> simply isn't something this initial series has to tackle? I think your d=
river
>> does not implement the receive callback?
> The initial driver with only leds: no.
>
> That changes once the driver also takes care of hwmon (ADC sensor and
> fan failure) and input (power button and possibly other buttons).

Maybe drop it from this initial series then and revisit with the first user=
?
