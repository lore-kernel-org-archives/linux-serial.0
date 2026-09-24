Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3F53FE347
	for <linux-serial@vger.kernel.org>; Thu, 24 Sep 2026 06:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790230258; cv=none; b=MS0dAe2A9DYIn+wksG08PwtgU7YUIZ8LBp5Jxt6WXndNT3vUi3ouvO1xqrH7C7nbSAkgRHdbJQt/TVu8Cjp69Iqu0LKCz8Vlb+SuPl4+5OvJMTU5+A9W8BBV0cqyI/eb/bPzB8KfQ1Rr7PFKwfKKTwg4jfltCcTkZfurrxTKEA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790230258; c=relaxed/simple;
	bh=reJfXYoLr6RH8hn2LxTGpqs3bjStYNLxtDMk/apEKeM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lbLebDDmxLlWo3EoOHlhM+TQ2V6JSpbnYSDUi87tP/qXJZvracv343+qOVZa8JUZFOLP/rZ3L3yWKMoU0gY5fOKpKwMcM8/PYRLKypDhFUdBnJKOnnw5KLhibge6JdWpn4KsiS7UGMzdvqe3aymKflmaVIFJu8Cu3T0886b79fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MNpqttR1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MNpqttR1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DDC91F000FF;
	Thu, 24 Sep 2026 06:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790230255;
	bh=afaAx5NA5aJ2hHWH/bKdR2k7iMvyL98GlKqBVuhTqbo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MNpqttR1w5339dbHUACCCQHD0a80koOdu2FaOwKLdu1guKJCU90TW2SKesysnugr6
	 Y6XmWBHP7MlQzZ6hFeRHBmRCLb8QBFNMYNCn/0YIY5BQiWziY+a/SlUua+C64ZDz1a
	 ju69zQsxCwc7SCX6OxUDMYzZoRJnnN650dGctm21kiGMhGQm8qgppzKbed2MDSE8p8
	 9M87Kyoo2bXAXNQ/tMeCd05H3wCEf3nSygl1dmJgo3HEFrp+EeFAiDxG98dhia+K4r
	 onXXgIBnhDOq7wVHK0hEU7xvsT8TL2HVxS6WgSSbxn1FFNQeELvjFvDy2IQADR69h6
	 xT7FPHGY7NzLw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4] serial: core: reject baud_base values that overflow
 port->uartclk in uart_set_info()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hui Peng" <benquike@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20260924060511.2364717-4-benquike@gmail.com>
References: <90ddd895-856a-f7ae-162b-c80a6042d788@linux.intel.com>
 <20260924060511.2364717-4-benquike@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 06:10:54 +0000
Message-Id: <20260924061055.3DDC91F000FF@smtp.kernel.org>
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
> Assisted-by: LLM
> Signed-off-by: Hui Peng <benquike@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924060511.2364=
717-4-benquike@gmail.com?part=3D1

