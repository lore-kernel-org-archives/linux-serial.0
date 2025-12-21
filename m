Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E499B301011;
	Sun, 21 Dec 2025 17:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766338844; cv=none; b=NJh+t/3HUoornW+zOa8BKrhkkAW9EJfqE19IIINs8YqjLVdel9vE5AjugqfCFif5CSSiZ0SG2oqHMRJxnlJVfupBo+v6q6706wChGs8ZGp9AXGCvPZADHUfqqrtY2taWToJ9D+nKTXrIyfNtRMtPKys66uXRwHEP2XRAJ+aiVc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766338844; c=relaxed/simple;
	bh=FDRyxWXSy6qOO94+WfHGY0NB0rkXrSvkq8ZlZ06+Kw4=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=DnqeiZo/UwH7xACcSxQL5WIXJFOm3ncddYzPnvWz1lMCFnh1610lM0UBG6ZJ8BmAi6K65cYNVV5y+/w5HiUbAh8qfL+zMqgr8qB/8M9Vbn2j0rjZKHsKVTjUBoWthJxY3CaZRhOLbSZqA7vkxpbGFjP3SSYDjwMTIQZKIslIGlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pjv2PHdP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pjv2PHdP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EC99C4CEFB;
	Sun, 21 Dec 2025 17:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766338843;
	bh=FDRyxWXSy6qOO94+WfHGY0NB0rkXrSvkq8ZlZ06+Kw4=;
	h=Date:From:Subject:Cc:To:References:In-Reply-To:From;
	b=pjv2PHdP3KSNig8+KUy8HNxImpwf/hamC5oIQPuTnCH/OyGb1zZYNWc6zYXtBhGto
	 X7R/VPNe34pgrzM8ENXqzTxk/VZCm/v0aah2gH8/75woGi2C8Oxxu8N1/7KNgYTLif
	 w9UQSldZC972z0gj6jVGz9uIsgTh6XXSZBGXjAONvBgqqqankarJpjyqkWlBS9xBbm
	 w83n0fXZ/AcoudYZmQL9SgLy0VlhjFYdW1ChWPuuqvucoMyp18MEJmtMmLPw53E48q
	 2xLEJ9Y9qwh8ishq3zUB7HZH9kvTHdK0fsReMfEd6BemXGz8C4X9xtU2dXa/JapNkR
	 MRpEhf/hsOicQ==
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 21 Dec 2025 18:40:34 +0100
Message-Id: <DF42UYA8RLDW.GSZ9G1CC03R8@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH RFC 1/4] serdev: Export internal is_serdev_device() for
 drivers
Cc: "Rob Herring" <robh@kernel.org>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Jiri Slaby" <jirislaby@kernel.org>, "Miguel
 Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Kari Argillander"
 <kari.argillander@gmail.com>, <linux-serial@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
To: "Markus Probst" <markus.probst@posteo.de>
References: <20251220-rust_serdev-v1-0-e44645767621@posteo.de>
 <20251220-rust_serdev-v1-1-e44645767621@posteo.de>
In-Reply-To: <20251220-rust_serdev-v1-1-e44645767621@posteo.de>

On Sat Dec 20, 2025 at 7:44 PM CET, Markus Probst wrote:
> diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
> index b33e708cb245..1f6bf8e826d8 100644
> --- a/drivers/tty/serdev/core.c
> +++ b/drivers/tty/serdev/core.c
> @@ -69,10 +69,11 @@ static const struct device_type serdev_device_type =
=3D {
>  	.release	=3D serdev_device_release,
>  };
> =20
> -static bool is_serdev_device(const struct device *dev)
> +bool is_serdev_device(const struct device *dev)
>  {
>  	return dev->type =3D=3D &serdev_device_type;
>  }
> +EXPORT_SYMBOL_GPL(is_serdev_device);
> =20
>  static void serdev_ctrl_release(struct device *dev)
>  {
> diff --git a/include/linux/serdev.h b/include/linux/serdev.h
> index 34562eb99931..0043b6cc6d01 100644
> --- a/include/linux/serdev.h
> +++ b/include/linux/serdev.h
> @@ -116,6 +116,8 @@ static inline struct serdev_controller *to_serdev_con=
troller(struct device *d)
>  	return container_of(d, struct serdev_controller, dev);
>  }
> =20
> +bool is_serdev_device(const struct device *dev);
> +
>  static inline void *serdev_device_get_drvdata(const struct serdev_device=
 *serdev)
>  {
>  	return dev_get_drvdata(&serdev->dev);

Besides what I mentioned in [1] (which should make the patch obsolete anywa=
ys),
I want to point out that such cases should be solved with a helper in
rust/helpers/ instead.

[1] https://lore.kernel.org/lkml/DF42RR0I52L3.1JET4R0KFDPPH@kernel.org/
