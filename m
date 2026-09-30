Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E3223E334
	for <linux-serial@vger.kernel.org>; Wed, 30 Sep 2026 04:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790741957; cv=none; b=Jc6jOu61yHGa3enJEskmH7Ab4sYkAcFBQ5X3KdJYOIGgG7ChLxLb+xxhj0ijd/cAAmQIzEXjO0DiWXYGudG5QFtG8uQi/CqjxmUoUDBQfttJOSq5cUQLl3nlhOyh5mk08Qo7qC5OET1hXO6zn/OLTXvVTb3FDG2cLMOcag67o4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790741957; c=relaxed/simple;
	bh=ZDwv7dffISWhC92KVfd+WseWkgnewn5R8Z2tNEFDBBw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nOr/iotCLM3Rs5EASHjxVK01BZLJL0J0690cL3shUD43jkr14s6VpAbomwW7IzpB8FpNc8Nj91q+JoNs6ahjr5sRlGzTeCJQtAW/hUA8KYhV5zYksSQBB5VaUqquubHg3Zx0ifuy0q4JBxE4m98szj0DDa1ck2ol9EO/rckRFEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aBLkFr/Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aBLkFr/Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23BDC1F000FF;
	Wed, 30 Sep 2026 04:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790741956;
	bh=g5PFDC+ZUn30P6PiFE97/khO2s3xzCBnnN1jU6/U8TA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aBLkFr/ZnkaAuEavh8WYpJCiy00F5Ip2gizxRzEr7Z5vrLF08Mm0t9nq2h0pwYtW7
	 Xw5B7Q6BuweiUDgMnL1Vj+9xey9QRHEx940Dk0rasjsG4ContfNpAyfhqhp69UKe2v
	 umPMnXQ0KR0JxLv3Z6crIDvQjaLogRjcOcSxsPPUw7yEzeslYEdEcR8DK4LPw+tRRT
	 /epKp6acd8haqu6LPvqh79MPuzczO2stqoMyQz+ECPU0gO0P1fwza2VMui76UEQHwH
	 22UhJZdogpKNvJDNRrvQ6s+TCU8XgPRtNU8eGM7ZMyT6W7ob739lG0ySeDKG1fRT+L
	 COmpnOHjXMl/Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 3/3] serial: core: reject baud_base values that
 overflow port->uartclk in uart_set_info()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hui Peng" <benquike@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20260930041216.155911-4-benquike@gmail.com>
References: <20260930041216.155911-1-benquike@gmail.com>
 <20260930041216.155911-4-benquike@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 04:19:15 +0000
Message-Id: <20260930041916.23BDC1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> In uart_set_info(), new_info->baud_base is multiplied by 16 and stored in
> uport->uartclk (an unsigned int):
>=20
>   uport->uartclk =3D new_info->baud_base * 16;
>=20
> While uart_set_info() checks if (uartclk =3D=3D 0) and
> if (new_info->baud_base < 9600), when new_info->baud_base exceeds
> UINT_MAX / 16 with low bits set (for example, 0x10000001), multiplying
> by 16 wraps around in 32-bit unsigned arithmetic to a small non-zero value
> (16), bypassing both uartclk =3D=3D 0 and new_info->baud_base < 9600 and
> setting uport->uartclk =3D 16 (baud_base =3D 1, well below the required
> minimum of 9600 * 16).
>=20
> Reject new_info->baud_base > UINT_MAX / 16 before multiplying by 16 in
> uart_set_info().
>=20
> Tested in QEMU against Linux 7.3.0-rc3 by calling ioctl(fd, TIOCSSERIAL,
> &ss) with ss.baud_base =3D 0x10000001 on /dev/ttyS1: on the unfixed kernel
> TIOCSSERIAL succeeds (ret =3D 0) and wraps uport->uartclk to 16
> (TIOCGSERIAL reports baud_base =3D 1), whereas with the fix applied
> TIOCSSERIAL returns -EINVAL and preserves the existing uport->uartclk.
>=20
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Fixes: 6eabce6608d6 ("serial: core: check uartclk for zero to avoid divid=
e by zero")
> Cc: stable@vger.kernel.org
> Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> Assisted-by: LLM
> Signed-off-by: Hui Peng <benquike@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930041216.1559=
11-1-benquike@gmail.com?part=3D3

