Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793581130;
	b=1DQICf6l0dvHn4UpKcADRBqVRqtjdsuy+oIDQ+dPdx0VLTtdw6eVqT9WxEvuASuMXocY
	 zHjJNTM/9GAqT011lRbPvy3J9+DkeCm9OhSooHjgmn6Tyf98TiemIretFBE6KtxaR9DnH
	 CdJl1Kx/BdLFQ333C4O4luwpO6T+HNFgRiPUlBhrdpvspRs+wpqvsvIjbNhT0SPlS/0QH
	 rWl2+61RUYvv57zOZanAjethEvqLsF5/H7gb1/X8pNqGw6W/oXmJLWvYpmkAhCnsS20hK
	 hMSzMXNgluC1pHOgP2Nylw6+7HRljApZHJYy/liohtq8IfWxLZWOdkUM3H8W/4ebWcw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793581130;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=TN44hQqJg+MxDhnBmo+LrjPKOyiGZgH/b6zzrYiYI2E=;
	b=S6E7zh8p2CZv+MPjzH3gzZidB+QR5nKexVDeoABXIIy0MM9WK4lXjN6W/WTQ63EMf+lu
	 XfTXYlt52qdyiDyCYpSQayC2PDMZhWKlamB9tZ0Dpbf9c4pOvaRZlmQkcrr0VfXyBLotl
	 fK2JP3NKNgCEZ3l8X/67rxiofEat14JlUxx1kj9O/AJYddv8hYXYQNcO/vplueBhv0Gfl
	 ORcVk4RqhWfG47Bg834NiXuP4gIk5zngiL4IZkX7AFEbdW+H3BvE7xu4BmH43KMbU5ced
	 8iRbhOj2N1xijB5GDaXXJxBXWnTEbekGXHP4BMDNXwdHaUotLvdobStW+m/B0dwLsdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L0DVxHun;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D840E606A324
	for <linux-serial@vger.kernel.org>; Mon,  2 Nov 2026 00:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L0DVxHun
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 469CB1F000C1;
	Mon,  2 Nov 2026 00:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793581129;
	bh=TN44hQqJg+MxDhnBmo+LrjPKOyiGZgH/b6zzrYiYI2E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=L0DVxHun9odfaS+mBS7FYF5s4sWjpqj1mdiE9suoZn84pEQIZAbYw40vC6+86rwom
	 ldU6B9RHyigXhePWb9LYIMqY15w10HSN0asvUfOHzpx6VLj0Rj2mMKf2OnOFjoIktW
	 hDFx7hIG7ARC8ifa63C+HADspzHN9Ec+ydEDG+ojl6pcpJDiSYfU0dKA/dLgkAjUlT
	 nmoCLCXxjLTGKUrCAPj9Yg+8NFV7zNZVCPcqw8jPfwW+WKaj1vgWIfVCZFvycZw/mC
	 WdkCBsvGvQGd1wSlMTXUSmZr32GlNAN6/avjyEnuEXMABQgsfMFj4zBFArFUtqBOzX
	 8QVRHCM4rXu/A==
Message-ID: <sashiko-outbox-192799@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] rust: serdev: use Delta<Jiffy> for timeouts
Reply-To: sashiko-reviews@lists.linux.dev
To: "FUJITA Tomonori" <tomo@flapping.org>
Cc: linux-serial@vger.kernel.org, ojeda@kernel.org, gary@garyguo.net
In-Reply-To: <20261102005125.626125-1-tomo@flapping.org>
References: <20261102005125.626125-1-tomo@flapping.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 00:58:48 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] rust: serdev: outdated timeout type in Driver doctest for write_all=
()
--

commit 2726c2fee6d94012455c660974ada63f17dd12c7
Author: FUJITA Tomonori <fujita.tomonori@gmail.com>

rust: serdev: use Delta<Jiffy> for timeouts

This commit updates serdev::Device::write_all() and
serdev::Device::wait_until_sent() to accept a Delta<Jiffy> timeout instead
of a raw Jiffies value, rounding non-positive timeouts up to one jiffy.

> diff --git a/rust/kernel/serdev.rs b/rust/kernel/serdev.rs
> index 17ca504b7f8d6..656598602d7a9 100644
> --- a/rust/kernel/serdev.rs
> +++ b/rust/kernel/serdev.rs

[ ... ]

> @@ -475,28 +488,26 @@ pub fn set_parity(&self, parity: Parity) -> Result {
>      /// [`Device::wait_until_sent`] to make sure the controller write bu=
ffer has actually been
>      /// emptied.
>      ///
> -    /// Use a timeout of 0 to wait indefinitely.
> +    /// A `timeout` of 0 or negative is rounded up to one jiffy. Pass
> +    /// `Delta::from_jiffies(isize::MAX)` to wait indefinitely.
>      ///
>      /// Returns the number of bytes written (less than `data.len()` if i=
nterrupted).
>      /// [`kernel::error::code::ETIMEDOUT`] or [`kernel::error::code::ERE=
STARTSYS`] if interrupted
>      /// before any bytes were written. [`kernel::error::code::EINVAL`] i=
f `data.len() > i32::MAX`.
>      #[inline]
> -    pub fn write_all(&self, data: &[u8], timeout: Jiffies) -> Result<usi=
ze> {
> +    pub fn write_all(&self, data: &[u8], timeout: Delta<Jiffy>) -> Resul=
t<usize> {

[Severity: Low]
Does the rustdoc example on the serdev::Driver trait in rust/kernel/serdev.=
rs
also need to be updated for this signature change?

///     fn probe<'bound>(
///         sdev: &'bound serdev::Device<Core<'_>>,
///         _id_info: Option<&'bound Self::IdInfo>,
///     ) -> impl PinInit<Self::Data<'bound>, Error> + 'bound {
///         sdev.set_baudrate(115200);
///         sdev.write_all(b"Hello\n", 0)?;
///         Ok(MyDriver)
///     }

It still passes an integer literal 0 to sdev.write_all(), which fails to
compile when building with CONFIG_RUST_SERIAL_DEV_BUS_ABSTRACTIONS=3Dy and
CONFIG_RUST_KERNEL_DOCTESTS=3Dy.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102005125.6261=
25-1-tomo@flapping.org?part=3D1
