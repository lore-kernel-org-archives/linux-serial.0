Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794755636;
	b=eBu0/wXu+nCY5hSYk6Ndn5Dp7zZ0MELRX9W8NibSqwyEhpAjy7i0mJVQNJuzBvd07dWN
	 F8BSA5N6dzG68UM94M12cXpR4geWD04v/Nose85cA3wzoy6CM1rIe9oAb+XkbBlimdQa5
	 FMKZiE5v76n9YDouXjGw4kOUk8Kq6hQfOU9sUbENidMGp0b+O2OtDPEZHqMUX/fsRaoV8
	 avJcDL+hQ6zRT2m7hA+ehryX/uFPfKKMJogO7/47d/Ly3DxEzgn+wfYzm8z36jWQQPvkS
	 LAjEbW9bNIivIS22okYNUZWgUocoUBOqaNVkDhglZKsfaq3FbdUCLhZg7Rg+dwiYC3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794755636;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Ie9OjwRjurXn8wv2kvA6y6lvxbTiZIIPIDhESIBU17U=;
	b=1SKAMwdmQJS4qecSjXKN5tOtwP1RRZJbQUxAsrhW17/jIY/bCOA8u3DrZOL7yznNadRl
	 hgakIJznIMwHzv9H4Cp8tVrQ0ERA1sFEFOFa4B8/gj8+8YlXr2OZf41r1mXrQoiTviNga
	 IsEYw093moyTbbj3o60SP3zF0vJ3+YqpQqr8friXCFs8VTcrvV0x4m6v6QbwO9eMQS0q2
	 ZWlVjbsSARKelVgU339GCPhadkaRpLMe62pKFh8isVpIvvYytY6MNIKsTwhdPBmpAWjM9
	 2axqvEkdEENtTnZWHWrjbmbR9KDyjsSwsJcStCQ+dYpG6xDrj8mhS4L0FXAAyJd8oKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WDLG3tRY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF6A606A31A
	for <linux-serial@vger.kernel.org>; Sun, 15 Nov 2026 15:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WDLG3tRY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A08C1F000C4;
	Sun, 15 Nov 2026 15:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794755636;
	bh=Ie9OjwRjurXn8wv2kvA6y6lvxbTiZIIPIDhESIBU17U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WDLG3tRYnq9iI4cMgX7bTaaX/ARN7l3DYJUCQ8ShRGUfKLHgQOl6bfi5gyo9I8NhP
	 OM8bAu890ib+m7V+tJskb87buXPL1tCvaU3mrMS0oePReXoCWAr5Tg8ZVswtFEkA+x
	 uPNpmQXsNA5K7w+4O4i7h40hZZFqCglXUDUSUlQ3OKXhJUMLSyiqryncJ40L9SowGF
	 313fjCz2eeD1fMTdhNHLZup9tf4XQnpDT5tRy4t7NSrpqacFf59AtRkENQytHol6zd
	 KhkEJykXNvSHsftk764mNMrMyCuPMxZtO6x4lUGoAjtzwT09UktZsZoakWdV5TZIGn
	 HsvP0af4UmRQg==
Message-ID: <sashiko-outbox-215615@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] serial: mvebu-uart: drop of_match_ptr for ID table
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bramuel Barack" <bramwelbarack89@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261115150742.24126-1-bramwelbarack89@gmail.com>
References: <20261115150742.24126-1-bramwelbarack89@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 15 Nov 2026 15:13:56 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] serial: mvebu-uart: NULL dereference in mvebu_uart_probe() on
  PRP0001 match
--

commit 3010b076c87d51f51ddcc431e71fb7901421ff0f
Author: Bramuel Barack <bramwelbarack89@gmail.com>

serial: mvebu-uart: drop of_match_ptr for ID table

This commit removes the of_match_ptr() wrapper around mvebu_uart_of_match
in mvebu_uart_platform_driver.

> diff --git a/drivers/tty/serial/mvebu-uart.c b/drivers/tty/serial/mvebu-u=
art.c
> index 8a61517d81f21..4026f4c0bf2cf 100644
> --- a/drivers/tty/serial/mvebu-uart.c
> +++ b/drivers/tty/serial/mvebu-uart.c
> @@ -1015,7 +1015,7 @@ static struct platform_driver mvebu_uart_platform_d=
river =3D {
>  	.probe	=3D mvebu_uart_probe,
>  	.driver	=3D {
>  		.name  =3D "mvebu-uart",
> -		.of_match_table =3D of_match_ptr(mvebu_uart_of_match),
> +		.of_match_table =3D mvebu_uart_of_match,

[Severity: Medium]
Can this cause a NULL pointer dereference in mvebu_uart_probe() when a
device matches via ACPI PRP0001?

drivers/tty/serial/mvebu-uart.c:mvebu_uart_probe() {
	...
	const struct of_device_id *match =3D of_match_device(mvebu_uart_of_match,
							   &pdev->dev);
	...
	mvuart->data =3D (struct mvebu_uart_driver_data *)match->data;
	...
}

When a device binds via ACPI PRP0001 (or when CONFIG_OF is disabled),
of_match_device() returns NULL because pdev->dev.of_node is NULL, and
mvebu_uart_probe() then unconditionally dereferences match->data.  Using
device_get_match_data(&pdev->dev) would support both DT and ACPI PRP0001
matching.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261115150742.2412=
6-1-bramwelbarack89@gmail.com?part=3D1
