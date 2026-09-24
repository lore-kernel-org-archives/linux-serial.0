Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C301349CFF
	for <linux-serial@vger.kernel.org>; Thu, 24 Sep 2026 06:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790230441; cv=none; b=s8Kkapw6aQRyuRtbYkatfhPDm0XI8gqU2NTAup863CnzAyiRX233E6idFiii73oYXJ91hdD3SKVY5RYn7A+uNAFawiL85QLtjUgkWDboqL6347LOXr2PR902htliTqnsH+j2BTtOBnSM0Il8ewhGSgRK0+pwARE+G/MXOygGZAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790230441; c=relaxed/simple;
	bh=n+8Frwb8wt36yw0KB56tBje8i26n+iKtfc9R77i09J0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gDuwkqZtwuikO4Aoo2e1WY7StTXfj3EoTZIuLEJh/L3RZub1YohlmRMQVa6IlPkkB76uXO/m5O44vuC8obx5q56lL4cFwaZBetRvt01dozv/ld217xiAM7z61glpFv44Y+zDeZFE9tTl/gVVFiKIfME/RdgjQoVHfFNr5cYa8i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZMStX1LR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZMStX1LR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFB821F000FF;
	Thu, 24 Sep 2026 06:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790230438;
	bh=IpQ4U5Ixr5kAVaL8UEoyKGg9qh0FmtvH2TNiWXvw31c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZMStX1LRQrML5UGr2C2wlcSApyek6h0nXvrdaPd8Pb1dwDlQ7zF1rBSnJ13I0ljQx
	 kBjFh0XacN3XgKVYPcUilluSb9QMtYES3nWazwViIHoWN4BMw75EzhGwE5q6PZWcBQ
	 u7lGJsc5jOLpakoOvCFBxK5R8Q3oEupIuvNBbeJcmewijazMlUS1UzXyUo8vJs0m57
	 XXhRIddsBBP7oGxYetBIFbVX0nqRxiJ236iZMHoSBbDAwQLP3meqETJPPWRHpBBFYa
	 +m60XQHwdzpyZsLfq56RVkTqjQ3JStmHFwcShBaLNPBDBmRx+3wn9nLxDmyikaoWxD
	 LuWmuL2iA1UHA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/3] serial: core: allow third iteration in
 uart_get_baud_rate() fallback
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hui Peng" <benquike@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20260924060511.2364717-3-benquike@gmail.com>
References: <20260924060511.2364717-1-benquike@gmail.com>
 <20260924060511.2364717-3-benquike@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 06:13:57 +0000
Message-Id: <20260924061357.EFB821F000FF@smtp.kernel.org>
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
> Fixes: 091ea8e5d34e ("serial: core: prevent division by zero by always re=
turning non-zero baud rate")
> Cc: stable@vger.kernel.org
> Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> Assisted-by: LLM
> Signed-off-by: Hui Peng <benquike@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924060511.2364=
717-1-benquike@gmail.com?part=3D2

