Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282F913FEE;
	Sun, 21 Dec 2025 17:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766338590; cv=none; b=YZ5q3KuSZbWJ0E9BeRKzYQg3b1k8PfDRlv13pkLs/ZkNvJ76D7pTl5EVqzJVFieO6F9//YFpfvMAbU0uFpXOwsAC/fJ12Z1n7zKvApa1Lb3mmZmyjxMerWydNJw7azMc61egkrSCjUSrH8QvAylDJJOMQJtag/Y9xKQJXhu256Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766338590; c=relaxed/simple;
	bh=vZCQS0fw5gRvGz1ubZ1ANhPnSR+k/aLrZRJroX7zCXY=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=thCIqX7z0aIs07wqJPWBemKsKzMDe7zVjip3WsURwxNEmvfXbHxSL/bjnU8vDEffHWC7T5BA1dW5lXeb0ohzHkhSqUhppwGaL/vrysMDVOEjsmobuhM+vSndF0WVG37h8M868zAn1zgH630VqeNRok6iLQnlCM11dMcDlU20uSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r9Ypkt9E; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r9Ypkt9E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA900C4CEFB;
	Sun, 21 Dec 2025 17:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766338589;
	bh=vZCQS0fw5gRvGz1ubZ1ANhPnSR+k/aLrZRJroX7zCXY=;
	h=Date:To:From:Subject:Cc:References:In-Reply-To:From;
	b=r9Ypkt9ESvt7sVUHBS2oA4ypFwcVLhG8ba4E87eU2C3wGDnJQwUTtJ2XNXmcalFUA
	 ph0fF1u+gGXByE74Ns79m3u4493mXctPeb8WLrmO5XHWTSNeUrrs19IK9s0xhK2Mmm
	 iBCjk4sAQPr1mMkR2qaThdNfmbBJc9lK4Qr7TAO3kUJTJj67mRzMzRQ6yNYDactK0g
	 KxlXb+YElYJDKWQV4pr7BTfaUUG/ZdKzosKdylpZbf9TKt7oW5doFCK9N0reTQeCnn
	 PwFXrcil10PJ44/YudB2Twb4rieaPt5vLjzWCZhwbay/Ma+ZynfkGOF7DJT/kCsLYG
	 csPVYxH+xBmxA==
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 21 Dec 2025 18:36:23 +0100
Message-Id: <DF42RR0I52L3.1JET4R0KFDPPH@kernel.org>
To: "Markus Probst" <markus.probst@posteo.de>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH RFC 1/4] serdev: Export internal is_serdev_device() for
 drivers
Cc: "Rob Herring" <robh@kernel.org>, "Jiri Slaby" <jirislaby@kernel.org>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun.feng@gmail.com>,
 "Gary Guo" <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Kari Argillander"
 <kari.argillander@gmail.com>, <linux-serial@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
References: <20251220-rust_serdev-v1-0-e44645767621@posteo.de>
 <20251220-rust_serdev-v1-1-e44645767621@posteo.de>
 <2025122138-saucy-unexpired-0b98@gregkh>
 <4b55501e500edb8416ed690757f72752f1c49517.camel@posteo.de>
In-Reply-To: <4b55501e500edb8416ed690757f72752f1c49517.camel@posteo.de>

On Sun Dec 21, 2025 at 5:28 PM CET, Markus Probst wrote:
> On Sun, 2025-12-21 at 17:10 +0100, Greg Kroah-Hartman wrote:
>> Yes, and usually that's not a good idea, unless you have a bus with
>> multiple types of devices on it.  I don't think serdev has that, does
>> it?
>>=20
>> Only under special circumstances should this be required, so I'm curious
>> as to why you would ever have a pointer to a struct device and not
>> "know" that it is of this type?  Who is passing that to you?
> For example, the pwm rust abstraction currently only provides a
> `device::Device<device::Bound>` reference in callbacks [1]. If we want
> to write data to the serial device in one of the pwm callbacks, we need
> to convert the `device::Device<device::Bound>` reference to
> `serdev::Device<device::Bound>`. The TryFrom implementation provides a
> *safe* abstraction.
>
> At least in the pwm example, this could/should be circumvented with the
> `AsBusDevice` trait [2].

Yes, class device implementations should start using AsBusDevice, so you do=
n't
need the TryFrom upcast.

> But this technically also applies to all other bus device abstractions
> and they also have a `TryFrom<&device::Device<Ctx>>` implementation, so
> with this it would be consistent across all rust bus device
> abstractions.

It should only be PCI and platform and they have it for a reason ()which is=
 the
one Greg already mentioned, i.e. when you potentially have multiple device =
types
on a bus).

The concrete use-case that motivated adding those for PCI and platform is w=
hen
they interact with the auxiliary bus: Imagine a driver that supports device=
s
from the platform bus and the PCI bus and exports an auxiliary device.

In this case, when you call back into the parent driver from the auxiliary
device the parent driver has to upcast.

This exact constellation is what is implemented by nova-core and nova-drm.

However, outside of such a constellation we should avoid doing upcasts with
TryFrom and make the correct type available in the first place.

- Danilo
