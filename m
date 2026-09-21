Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D714369A
	for <linux-serial@vger.kernel.org>; Mon, 21 Sep 2026 01:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789954617; cv=none; b=XemQjsQBvngFZhcp2/I40keNlHiPvlk38Igp5MeV7kS2zwk/Hpqhu3o3S6BXWhi2PdOhn5cEuWr6njMsLzkm/aFdHZXWl6n/YaKMcuMJtk63MMX9XPTnEGgd2Wv0AAj8/DCb671usvhapEfTYRQNJy1t8/QXmi1OmXC4FS/yPyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789954617; c=relaxed/simple;
	bh=WlKYSUIzNZQpbkqxOBfmKtGfgnHYPVY6crJVXdMFNug=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IJJLVLFBSH8w3io84z28QUtMkDUscX752J81zWO3R5F+nWcARJkTGhhmU8VoiOJr5L/d+iw7SVcm154tzJKzhc7uuzoXd1Cdj3xkg4WLDT7ia/cLAndfefCMKt6jaJeQM2ynCNslpF3BqQ1UgpgA5f6L8BhPKMZZjheMd5fd+Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=exJO5CSQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="exJO5CSQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21ED41F000FF;
	Mon, 21 Sep 2026 01:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789954616;
	bh=+mS6ddZYozGmSADd2LV5LeQbFsGvdi4leKHIWUVo7Ug=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=exJO5CSQCPvP2MiVrVT9T/UeNQeIRrPAeYXaSfk7EmjCOCyUdi6pIITNf9eV3DkCv
	 m5yqC0erVu3T3XaloiqwMmOBck1mGZOMerdpxk0VJa92NxB+LRZGWpkU/A0Q84Yn7A
	 qZR0zz9eyzvGgciTRnXdEX72pz7QoD4nh0d4y8eXLtXgKs5fJLwya0nafRLsqfKOJX
	 oew11JYHiF8/mz7nvt8CrTv5eUg2A8x+2h7XHGSWltpTmsrQWwitaQxG7ysG4fo03a
	 mCczpH2YMEaFHa+nnMRHD7btrCRsCMIuPETI/vO+uKk1RVOoVPDn33hGD5VcRx/IMN
	 iUEfBYxmvMwzQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/3] serial: core: allow third iteration in
 uart_get_baud_rate() fallback
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hui Peng" <benquike@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20260921013027.659965-2-benquike@gmail.com>
References: <20260919222627.3797854-1-benquike@gmail.com>
 <20260921013027.659965-2-benquike@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 01:36:55 +0000
Message-Id: <20260921013656.21ED41F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> In uart_get_baud_rate(), when the requested baud rate is out of range
> (try =3D=3D 0) and old is non-NULL, the function copies the old termios b=
aud
> rate into termios, sets old =3D NULL, and continues to try =3D=3D 1. If t=
he
> old baud rate is also out of range (for instance, after uport->uartclk
> was lowered via TIOCSSERIAL so max =3D uport->uartclk / 16 is smaller than
> both the old and new baud rates), try =3D=3D 1 clips baud to [min + 1,
> max - 1] and encodes it into termios via tty_termios_encode_baud_rate().
>=20
> However, because the loop bound is for (try =3D 0; try < 2; try++), the
> loop terminates immediately after try =3D=3D 1 without re-evaluating
> baud =3D tty_termios_baud_rate(termios) for the clipped rate, hitting
> WARN_ON(1) and returning 0, which then triggers a fatal divide-by-zero
> (Oops: divide error) in uart_get_divisor():
>=20
>   WARNING: drivers/tty/serial/serial_core.c:548 at uart_get_baud_rate+0x1=
36/0x260, CPU#1: init/1
> [ ... ]
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Fixes: 091ea8e5d34e ("serial: core: prevent division by zero by always re=
turning non-zero baud rate")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Hui Peng <benquike@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921013027.6599=
65-1-benquike@gmail.com?part=3D2

