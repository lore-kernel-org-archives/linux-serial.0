Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45EDD225A38
	for <linux-serial@vger.kernel.org>; Wed, 30 Sep 2026 04:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790742119; cv=none; b=bvo5gDzCT1RDLTGMq5VGX/JMQGzOCJYEQWhTf0RSBu1CHvOrhFH294xqAoQdT5rr1weYEr1+DxMU8ZjS3zjs9DARTfuVW99QMr1xi0Jl2x9tgZjMd7umqEF9Sf/9u0wNt0eKbncZmxC1WKDkuMTFqi5kOoWbAw8n6Zf/V9kf7Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790742119; c=relaxed/simple;
	bh=8RzTOwucw2ZSQglIrOkYHE+Swl4AHPhdl9uYDldQ50M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=r/c8aLszI19ut3OjdZNUciPnP81aHIWLnhyY/S9GCFQZP8kE/XyaJEqQECMFz2I6r67D3UbeqLIDw2UJ+VsooRbZzQeBdORYRPs3dQi65KDaNTPURN5Dqt72HaQj1T/xqCQnaSNuKnT60JfzO6kqBMDhu2Q4SLIszJB561zPpfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HdjJ25EU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HdjJ25EU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 913CE1F000FF;
	Wed, 30 Sep 2026 04:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790742117;
	bh=JdIIGmAin8rAdeGUzNtIzk1+G2YCiaKfCEPe/i+1a/A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HdjJ25EUGRbOAUSAZhCogjt4Acv0fMx9ieXXViYiPxxrVHjxnoY4EtqOgqoj336zJ
	 Ns6XmUisTYv+dPHJZu+2SdXbrAAHoxaQfNm9yd4AV6ONMK5d8TBWMrrADUDrX2k99R
	 HoLMy197YwfqSE+07/IOKF7BC73E6HAVKfr3wx/Axx5U/U3/ON1VJ++G9fKMisQaea
	 1zFh18hBaswrHozmFcZMGwTFaEOWeFo3WrSCDM8ytXsqz68z+B9bS6HdMJtCE2//bD
	 DtxKOjhftQPTNm0dmnlz4GLEIoF4No0tnkLt1w7i3okycB+WbKj5s45rn0JDTnEOAk
	 f9IDqrNftjSOA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1] rust: serdev: use Delta<Jiffy> for timeouts
Reply-To: sashiko-reviews@lists.linux.dev
To: "FUJITA Tomonori" <tomo@flapping.org>
Cc: gary@garyguo.net, linux-serial@vger.kernel.org, ojeda@kernel.org
In-Reply-To: <20260930041339.1551129-1-tomo@flapping.org>
References: <20260930041339.1551129-1-tomo@flapping.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 04:21:57 +0000
Message-Id: <20260930042157.913CE1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] rust: serdev: negative timeout clamped to 0 causes infinite wait
--

commit 68348e8f0bd03a5788e4d72cf264605070a06317
Author: FUJITA Tomonori <fujita.tomonori@gmail.com>

rust: serdev: use Delta<Jiffy> for timeouts

write_all() and wait_until_sent() take the timeout as a raw Jiffies,
which is a c_ulong alias. The type does not show the unit.

> diff --git a/rust/kernel/serdev.rs b/rust/kernel/serdev.rs
> index 17ca504b7f8d6..094503f059ff5 100644
> --- a/rust/kernel/serdev.rs
> +++ b/rust/kernel/serdev.rs

[ ... ]

> @@ -481,22 +484,19 @@ pub fn set_parity(&self, parity: Parity) -> Result {
>      /// [`kernel::error::code::ETIMEDOUT`] or [`kernel::error::code::ERE=
STARTSYS`] if interrupted
>      /// before any bytes were written. [`kernel::error::code::EINVAL`] i=
f `data.len() > i32::MAX`.
>      #[inline]
> -    pub fn write_all(&self, data: &[u8], timeout: Jiffies) -> Result<usi=
ze> {
> +    pub fn write_all(&self, data: &[u8], timeout: Delta<Jiffy>) -> Resul=
t<usize> {
>          if data.len() > i32::MAX as usize {
>              return Err(EINVAL);
>          }
> =20
> +        let timeout =3D isize::max(timeout.as_jiffies(), 0);

[Severity: High]
Does this cause an unintended infinite wait when a negative timeout is pass=
ed?

When a driver calculates a deadline that is already in the past, it will
produce a negative Delta<Jiffy>, which this clamps to 0.

However, the underlying C function serdev_device_write() treats a timeout of
0 as an infinite wait:

drivers/tty/serdev/core.c:serdev_device_write() {
    ...
	if (timeout =3D=3D 0)
		timeout =3D MAX_SCHEDULE_TIMEOUT;
    ...
}

Should negative timeouts instead return immediately or fail with -ETIMEDOUT
rather than causing the thread to hang indefinitely?

> +
>          // SAFETY:
>          // - `self.as_raw()` is guaranteed to be a pointer to a valid `s=
erdev_device`.
>          // - `data.as_ptr()` is guaranteed to be a valid array pointer w=
ith the size of
>          //   `data.len()`.
>          let ret =3D unsafe {
> -            bindings::serdev_device_write(
> -                self.as_raw(),
> -                data.as_ptr(),
> -                data.len(),
> -                isize::try_from(timeout).unwrap_or_default(),
> -            )
> +            bindings::serdev_device_write(self.as_raw(), data.as_ptr(), =
data.len(), timeout)
>          };

[ ... ]

> @@ -547,14 +547,11 @@ pub fn write_flush(&self) {
>      ///
>      /// Use a timeout of 0 to wait indefinitely.
>      #[inline]
> -    pub fn wait_until_sent(&self, timeout: Jiffies) {
> +    pub fn wait_until_sent(&self, timeout: Delta<Jiffy>) {
> +        let timeout =3D isize::max(timeout.as_jiffies(), 0);

[Severity: High]
Can this also cause an unintended infinite wait?

Similar to write_all(), if wait_until_sent() is called with a negative time=
out,
it is clamped to 0.

The underlying C implementation tty_wait_until_sent() treats a timeout of 0
as an infinite wait:

drivers/tty/tty_ioctl.c:tty_wait_until_sent() {
    ...
	if (!timeout)
		timeout =3D MAX_SCHEDULE_TIMEOUT;
    ...
}

Would it be safer to handle expired deadlines without waiting indefinitely?

> +
>          // SAFETY: `self.as_raw()` is guaranteed to be a pointer to a va=
lid `serdev_device`.
> -        unsafe {
> -            bindings::serdev_device_wait_until_sent(
> -                self.as_raw(),
> -                isize::try_from(timeout).unwrap_or_default(),
> -            )
> -        };
> +        unsafe { bindings::serdev_device_wait_until_sent(self.as_raw(), =
timeout) };
>      }
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930041339.1551=
129-1-tomo@flapping.org?part=3D1
