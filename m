Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D740817C203;
	Sun,  6 Sep 2026 16:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788711630; cv=none; b=hto0aOv3CJZiG/fuaF5S/sXIqNOy0GiGN++j1HLOPE1Yz6od5uQ9DlnUFzD07iO7lWBCYF/Af5rPWataGm71F4ImwIko+eDDWroMYRvgN8Cnbut4XMOahNmA5uZwX7ctrKkapluP/UlGUP4dVLo5YUtRN1M65B5a0KKd7TfYGr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788711630; c=relaxed/simple;
	bh=QT7nN5WON2NzkJWXv9fiR1RwHI7DN0Q1QR/3Zl5jwro=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=a0trcmzdNzhgLHoybqTYmklgDujG3BZl1CEoKNn0ZGwmCrVvFaZw/oxk6WVw+O/wtNZRu5q9/pvaGYD2CWvxaOl2fmC8kb+zOMu8QzzBV0Kzbft0kOrex9p6zl6N8QvWymQIGU+/RlqV3rlgArzPCTI1r6kqDFi2gHstCXzGs+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ca4e19ua; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ca4e19ua"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 738EE1F00A3A;
	Sun,  6 Sep 2026 16:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788711629;
	bh=r8BD7Gg36Rkj48ZsY4sePRTejSijZrcUy9aN/pN3maU=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To;
	b=ca4e19ua8edo88Q/54qiluW6xUIlEaMb0l273RaAoYEJ6nIh1wlUpglKqj8337Ncc
	 AqhwZyVvswQYvpTKHj3ieRTcevESKrYULF76mx+b98PjfxNRUjuTZqO2gLV2NlUMXr
	 MRU5I26qDJKEyLtZHmbKm1rxr0EER0UeuiMpklsfYLeSBeSuLEgYEu5253Jx2QU1EI
	 WTjrwGIobfLrfjLNUszARgXmV/VfOQkSWbgZQmH624apxCPG5sYQIkxTmrLLkBAOBi
	 p/85mt+CnWqOqyKZm+DT90Bu2fLVzJPMCm4o1Oj5EYXL2JUgnpdjn0fR4BhZlJB1QR
	 OTT7KOUZwcCEA==
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 06 Sep 2026 18:20:23 +0200
Message-Id: <DL8DCNMSENDS.3T14U5W1Y32IX@kernel.org>
Subject: Re: [PATCH 5/5] rust: serdev: Pause receive callback before calling
 unbind
Cc: "Ayush Singh" <ayush@beagleboard.org>, "Johan Hovold"
 <johan@kernel.org>, "Alex Elder" <elder@kernel.org>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun
 Feng" <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Daniel
 Almeida" <daniel.almeida@collabora.com>, "Tamir Duberstein"
 <tamird@kernel.org>, "Alexandre Courbot" <acourbot@nvidia.com>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, "Eric Biggers"
 <ebiggers@kernel.org>, "Ard Biesheuvel" <ardb@kernel.org>, "Lorenzo
 Stoakes" <ljs@kernel.org>, "Vlastimil Babka" <vbabka@kernel.org>, "Liam R.
 Howlett" <liam@infradead.org>, "Uladzislau Rezki" <urezki@gmail.com>, "Jiri
 Slaby" <jirislaby@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 <greybus-dev@lists.linaro.org>, <linux-serial@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <driver-core@lists.linux.dev>
To: "Markus Probst" <markus.probst@posteo.de>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260906-rust_serdev_probe_refactor-v1-0-69cdae0074ec@posteo.de> <20260906-rust_serdev_probe_refactor-v1-5-69cdae0074ec@posteo.de>
In-Reply-To: <20260906-rust_serdev_probe_refactor-v1-5-69cdae0074ec@posteo.de>

On Sun Sep 6, 2026 at 5:55 PM CEST, Markus Probst wrote:
> @@ -200,10 +203,14 @@ extern "C" fn receive_buf_callback(
>          // INVARIANT: `sdev` is valid for the duration of `receive_buf_c=
allback()`.
>          let sdev =3D unsafe { &*sdev.cast::<Device<device::BoundInternal=
>>() };
> =20
> -        // SAFETY: `receive_buf_callback` is only ever called after a su=
ccessful call to
> -        // `probe_callback`, hence it's guaranteed that `Device::set_drv=
data()` has been called
> -        // and stored a `Pin<KBox<PrivateData<'_, T>>>`.
> -        let private_data =3D unsafe { sdev.as_ref().drvdata_borrow::<Pri=
vateData<'_, T>>() };
> +        // SAFETY:
> +        // - `receive_buf_callback` is only ever called after a successf=
ul call to `probe_callback`,
> +        //   hence it's guaranteed that `Device::set_drvdata()` has been=
 called and stored a
> +        //   `Pin<KBox<PrivateData<'_, T>>>`.
> +        // - `unbind_callback` calls `serdev_device_pause_rx` before acc=
essing the driver data,
> +        //   which guarantees that this function will not overlap with i=
t. Thus we have exclusive
> +        //   access.
> +        let private_data =3D unsafe { sdev.as_ref().drvdata_borrow_mut::=
<PrivateData<'_, T>>() };

This would break the driver core's lifetime design. Any kind of registratio=
n
(such as class device, auxiliary, IRQ, etc.) may borrow fields from the bus
device private data. The whole design is based on the guarantee that we nev=
er
construct a mutable reference of the bus device private data.
