Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F07E2EEE62
	for <linux-serial@vger.kernel.org>; Wed, 16 Sep 2026 09:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789552789; cv=none; b=un6+ewfGxtnWJQOzWE25swO9bEi1I3s/Y6e0BJDxZ6DeoN0Z3LVDA01xEnE/0hjcVfZOUcPHQ67j5qy4odt7/gy+9RSy91MB3l4ma8rDVBKA6Blsq6t4osL+YXV79IidBZ5f1bbf26xKJNPqBqctcQl+/cHdkYa/BoUIp7A4B/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789552789; c=relaxed/simple;
	bh=I8Y1co/F4hcIlCYYjHu23k2v+coamxdKDBKDVE1uLB0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=G6+QPL5nCYXg3yH2D3pYoEuRNNYtERuUU+lkhMy8yuYnPiReRiJgRnpSFYjFSzkfhEZnGhgjURuS4hzUG/aW6pm/vGCLBiYoJ7JhdawRguIvLo8OfkOYa2sEk1yMoGkHNIbPWPYqo+djPILsP4H2e1Md23jBLjz5VqVRqzFsQY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C9RD+KCL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C9RD+KCL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E0F21F00893;
	Wed, 16 Sep 2026 09:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789552776;
	bh=1W0wU2ymWpSne5/vtX0EpLMRVBLFML/CvX72K5sK8ow=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=C9RD+KCL2koRXSo7HfDULfjswFzOFQxNnVqh6TGWPBjpxQdy84yElXbo/NX36pNJw
	 o55fFKyJjt7QNLuWmEXdnk3KFBTLig2fCpk9ixtmhR8kfJaoWlzUqCgileGjWgHFPh
	 K18bPGSWuw/3wOSibl/zyEAZbUPCPeny2mYwMYP+8OZWEI/CTDUSPNFrLFij+KbELQ
	 2CxwFJOkNrdWdiqOqA43x3qB4MTMNvMZUr8eH5kiUcStXbO+xk8VUeYWcusLcRLF2j
	 ULRdw/k2FrjqPaNx54DqEgVm+53tcEG6fKm4wuUfORqPM7VWdXyfD6nmXxUeqqruQK
	 tSxb/L1GRpOdA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] serial: 8250_uniphier: Disable clock on probe error
 path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Malathi A" <malathi.a2000@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20260916095438.20837-1-malathi.a2000@gmail.com>
References: <20260916095438.20837-1-malathi.a2000@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 09:59:35 +0000
Message-Id: <20260916095936.1E0F21F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> uniphier_uart_probe() calls clk_prepare_enable() on priv->clk before it
> reads the port properties, but returns directly when
> uart_read_port_properties() fails, leaving the clock prepared and
> enabled.
>=20
> The intent is clear from the surrounding code: the next error path, when
> serial8250_register_8250_port() fails, calls clk_disable_unprepare(), as
> does uniphier_uart_remove(). Add the missing call so the early failure
> behaves the same way.
>=20
> Found by smatch:
>=20
>   drivers/tty/serial/8250/8250_uniphier.c:232 uniphier_uart_probe() warn:=
 'priv->clk' from clk_prepare_enable() not released on lines: 205.
>=20
> Fixes: 26e8349c0d76 ("serial: 8250_uniphier: Switch to use uart_read_port=
_properties()")
> Signed-off-by: Malathi A <malathi.a2000@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916095438.2083=
7-1-malathi.a2000@gmail.com?part=3D1

