Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F091C84DC
	for <linux-serial@vger.kernel.org>; Mon, 21 Sep 2026 01:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789954693; cv=none; b=Wh+b+h/3jnabR8yh5RyJf+7zlNwh+gKXrJ3yD5/4eENHqOjciZU0bA3UbTmjsdOnijS+G9IgrE66bSGO+XnPg1AO1fmCR75SW0uLZwwvyWUE0CKef0uWMWudcX800+WakwgrCX5GnTaTTRLLVYRnmSEeP5V+1ohRtCCGLxS1uf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789954693; c=relaxed/simple;
	bh=WjETiEPADSXK19w4WvDHQron2Pm+xsz7eAsQz5mbNU4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=E/70dpgsmBVYC9gmLbu02QmIIHVPjHXvGfem+4zBmEkbHp4rdIadeDrdvrt0CP/CjwfUizaPi1i1+K6Ifek171vFt/PK4vrVpFzF1gSqR1O/mBtwEmwFpU2vrC4q1Xme1NRwG9St/gZxuyK9Xff8W9nTxIDCsuKe9ZSCYu+CgU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NTpM+5rA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NTpM+5rA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD7831F000FF;
	Mon, 21 Sep 2026 01:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789954692;
	bh=AQA5JdIkUrMegSUA2u0oRIifxSsR9tTsPDf3ekASJ88=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NTpM+5rA63waS+iCfjg4GxrTB0jA4SVCiVzsluugl/VVLoUTAoD1GzF4FQR8tfnxl
	 iCC9MIwNpEeGZmtIRYhbNJbSBedE8Xo6b7XRUF0qxJDOMPD6+9YshoH27nvXdRJ9hF
	 nMd10ZfCt9AyvIyKBh8KrdEuuzXnJPVVV4YWtS81KIA+Y310hZO0LHsG5l1OHuEOU9
	 qj6sdyAXWBBPuD+y1za3I9120ygm2gSPq6eVBOvrAhFFbP4brjfZvOgOts9eHL9kHy
	 xPv/kvsvcGrZ3vQYg2Qxln9qW/PSViSMWNluzfj3XjVjoe5asSb5KZa/jaul/8GIxa
	 PI2sMyiw5+zQA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/3] serial: core: reject baud_base values that
 overflow port->uartclk in uart_set_info()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hui Peng" <benquike@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20260921013027.659965-3-benquike@gmail.com>
References: <20260919222627.3797854-1-benquike@gmail.com>
 <20260921013027.659965-3-benquike@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 01:38:11 +0000
Message-Id: <20260921013811.CD7831F000FF@smtp.kernel.org>
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
> Reject new_info->baud_base > UINT_MAX / 16 with -EINVAL in
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
> Assisted-by: LLM
> Signed-off-by: Hui Peng <benquike@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921013027.6599=
65-1-benquike@gmail.com?part=3D3

