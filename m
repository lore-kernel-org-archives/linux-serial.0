Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793099503;
	b=eDVXk69kLnDY+qgCDOTwPD2SCe6bihg/eTJ70fNrwmp2h3Aihp7GyXvSKqCVf3BTPQEs
	 3QdzZmn/VpHwdB0f2FKyHiyEp9RkXRrwat6/dnl9H9ArRxvG4diGixuDthvpbUL8wlu0s
	 x9fLoOWD4+ImTxzAjBNqz8VLl9PAmgh41j07RbUxi96WYpHdEho858wQYkLUOQehu140I
	 wZBGbQFIUdKXywj7zpWAwV2S0RFNzEf6Ofjw8xC0DH+pwPYnsVYlyyctVRnFwSgRu55Si
	 mv4io4SimbOFBqy7lJO9xIoZtkEV9lfwEzAlCR+1hwLXrqDqRpyNiQaMwwUJp+81FaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793099503;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=08A7dV6H4uMwurtC8TdmFouTac4YCtJtJQ/aqzShEHc=;
	b=QYBL4fi8UCzjiucE8YIsNk+B6tPXRuRBScMqxxxeYAs6Wp4QXU0Wp74XSpRv0uyEpptC
	 szeiKIcWki2OJN144SCYItWYnTejselz4wqxDQ2TE+8TwfmeP1qWlbZJXNHJrp0CgoVp6
	 d9hK32CwXZP0zIOKDJu2N+1udPcZ6ikW1GvqqFbR3I5sERyOVtd1dXQGyRKUbaL581ldw
	 IEoRXpCUvZJSsTUnUU9s75w8kYchAuuu+Zs39mrmJkar2eY4LuPmx93iL6ZUdFMylKOp7
	 0sR5glSeldt9eiIVrcKJr+/acmFNvjAeagm9yTJ38boeHB4K6JFPhX3N9Gdqf3EXRLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aZ7i7ewr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0555B606A32E
	for <linux-serial@vger.kernel.org>; Tue, 27 Oct 2026 11:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aZ7i7ewr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7295F1F031E5;
	Tue, 27 Oct 2026 11:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793099502;
	bh=08A7dV6H4uMwurtC8TdmFouTac4YCtJtJQ/aqzShEHc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aZ7i7ewrdsbkIkygomafoKQg+x/vRl9A/fbI+oD6j0zQh9RntRxygYq6QkjQ7NiwF
	 MuKcLa4h+AE0bunwQxg5pBQAlCC+bHXnU8DRez0+A+DrBvUB4moIwXohyZn3UnytE5
	 y/00T11q6MAWV/YQoy+7mZjkgXhdFK4BUpdSw3+U2RGJ+DssNj8HDO9q+bYKxb47oD
	 r/rWXX0UwbsiaAJoe+5BV5BwfSPbO3U+wP7RO/DV5RhAHVPs7xj9uz1y5xrREs2c9w
	 Dy/0DguZA+wpAYJZ9ZsZb5c4NRZbA2jpjbAz7Y+6T16BATPTJLBIKsnoaOQfYG+iWH
	 d3WTN9a3Lyiqw==
Message-ID: <sashiko-outbox-186415@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 21/24] serial: samsung: don't leak the tty on an RX IRQ
Reply-To: sashiko-reviews@lists.linux.dev
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261027-tty-llm-v1-21-99b0202ae546@linuxfoundation.org>
References: <20261027-tty-llm-v1-0-99b0202ae546@linuxfoundation.org>
 <20261027-tty-llm-v1-21-99b0202ae546@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 11:11:42 +0000
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
> s3c24xx_serial_rx_chars_dma() starts by taking a reference to the tty.
> If the interrupt is not a receive timeout, it switches the port from PIO
> back to DMA and leaves through the "finish" label, which does not drop
> the reference.
>=20
> A port with RX DMA changes to PIO on every receive timeout, that is at
> the end of every burst of data, and comes back this way when the next
> burst starts.  So each burst takes a reference which is never dropped,
> and the tty structure is not freed when the port is closed for the last
> time.
>=20
> Drop the reference on both paths.
>=20
> Fixes: b543c301c2c5 ("serial: samsung: add DMA support for RX")
> Cc: stable <stable@kernel.org>
> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> Cc: Peter Griffin <peter.griffin@linaro.org>
> Cc: Alim Akhtar <alim.akhtar@samsung.com>
> Cc: Jiri Slaby <jirislaby@kernel.org>
> Cc: Robert Baldyga <r.baldyga@samsung.com>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027-tty-llm-v1=
-0-99b0202ae546@linuxfoundation.org?part=3D21

