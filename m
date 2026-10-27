Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793099639;
	b=A0MvHGyrj7TsiPYw/9mr411SSSouaDbwNUZRlJsYUZ8lDZhMyOE7Hwy/+tmBJzuyWc8H
	 VPQu1hkBoABrfkhKKggTrB4Najqt8FoifomNy/qj0Pco9FlZ9s3qc5MSyXbpjU3iQHd8w
	 LxOeWmkxeHiBmZOckN6QFpM/TaIh6/hU5cpanWY969/S9MjWhcpavp/syvPq+h3NRS0RP
	 JCuNTzg7u53vQwceUMwxkzjuIR9N/PQq4m0/6GVwcoKAF6A/sdsncB8Dh1PJxLh9yZvmf
	 bfrP9WGiYwbqjfWAUsyeCKr1zPRgDD6Taabc0TOzsEnw1WKqE/9431KkI6PGIW2GpFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793099639;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ZrnyqN31iOYNqtm6iz43bKsAQDoQgUZjCxx/OCrmaI8=;
	b=MzpCmP56U1Q/1Y4aOSS/cPyqjo56qNHVweTNGUGpecUU94fz4xOUcNNQ54xrndeXfLuf
	 eyWdcsB6uZD/mvE5X4dYDMNLZFD9NJVpM/gNhQNvZFtChp2x9VkAuAEM8C8aY1a1DFSPB
	 B+EIYkG5k6Fpxo1Rjrd9d1qf6XFOBx48aL621e7R9+eCCHWGZeMQHsPrO6HmUBNc8SuGs
	 WxfnacLZ5EhMLEB+ayC8Pwomk4hSeEbWDbEpUWq0rI8dgbDr6knOK7uMdEQ1SHX165Dlx
	 bfFxysgBpQqaWOAbFMjgdsKlg5xOThOfyWgeOwqddN9ZkI12odgbrk8Iac4/3J+bc+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NugUUyf8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD985606A31A
	for <linux-serial@vger.kernel.org>; Tue, 27 Oct 2026 11:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NugUUyf8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CC8E1F01825;
	Tue, 27 Oct 2026 11:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793099638;
	bh=ZrnyqN31iOYNqtm6iz43bKsAQDoQgUZjCxx/OCrmaI8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NugUUyf8mWJu0xCtsviY0PZrkbUQvmfCe9g6Fgn5/losiXutYnUlKdf0J3E/NgSRH
	 tiMwicvJOhw/IQp7HBDgHc+tR8HqKsYHRB6wSJxTXW1GbamYcZuBQigwyMFwRvgaxt
	 oZV8gf9KL9HTz3jIPuOY1yjBCFvnfP/Q69onr6psQUW9OX3YVUSK9FUfSk6GH9gusD
	 v9T9rFPHSyFnIXliNE1jGXjppeHEXH5/LAkyyvTBNLOwICxNo+Yuv8uapZ+WmmdCkW
	 4HsnMMQUrPiPa3rCzgm+VVr+Wf2ByTMW+tfkfI8PUhL5MzIOLZ2VbGGc8GndvJMKko
	 kXJbPrs6PXWug==
Message-ID: <sashiko-outbox-186424@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 22/24] serial: samsung: put the previous baud clock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261027-tty-llm-v1-22-99b0202ae546@linuxfoundation.org>
References: <20261027-tty-llm-v1-0-99b0202ae546@linuxfoundation.org>
 <20261027-tty-llm-v1-22-99b0202ae546@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 11:13:58 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> From: Josef Bacik <josef@toxicpanda.com>
>=20
> s3c24xx_serial_getclk() returns the best baud clock with the reference
> which clk_get() has taken.  s3c24xx_serial_set_termios() stores it in
> ourport->baudclk and disables the clock which was there before, but does
> not put it.
>=20
> clk_get() hands out a new handle on every call, so the new clock never
> equals the old one, and every call of ->set_termios() leaks a handle: a
> struct clk and a copy of the connection name.  Whoever has the port open
> can repeat that at will with tcsetattr().
>=20
> Put the old clock when it is replaced, and the new one in case it is not
> stored.
>=20
> Fixes: 5f5a7a5578c5 ("serial: samsung: switch to clkdev based clock looku=
p")
> Cc: stable <stable@kernel.org>
> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> Cc: Peter Griffin <peter.griffin@linaro.org>
> Cc: Alim Akhtar <alim.akhtar@samsung.com>
> Cc: Jiri Slaby <jirislaby@kernel.org>
> Cc: Kukjin Kim <kgene.kim@samsung.com>
> Cc: Thomas Abraham <thomas.abraham@linaro.org>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027-tty-llm-v1=
-0-99b0202ae546@linuxfoundation.org?part=3D22

