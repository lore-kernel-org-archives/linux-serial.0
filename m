Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F509524AE9
	for <linux-serial@vger.kernel.org>; Tue, 22 Sep 2026 08:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790066548; cv=none; b=XTBoPspgUiWxQga4i4KTpe5HvaqvOI2rFP5hzx3fk9qCSUddXuv+gC6qaN2Nac7NPTo0zHFOoWM5ke+/meWao5KONspKJ2R9V11luQDqIxvVW9NR6ufciu18F0Mw/q6QPEp8+ZnZSagSE5UNgHOkCIVBup8sq7v5wDT7snVSKgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790066548; c=relaxed/simple;
	bh=7g+ZcmQ90t/vwf9WN43G2w6y9OTYvJB2XpD+y63PhD0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=O1R3Ev1qhjjWHCPaqgrkxxg/1eeozaS4fGlartT10tvWYjSS7YSXh0Zt+bhqShL/Uh/J+WEEHmu9crQ6p3WfMWizVsBJiOAR8DvJdky8VU2xHAyUqOHKHl53S7lVhbtHyzenh1rX98yDpnH2tyMgPGjNDAQ44LvCaFThXo8osKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ec5GFlpC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ec5GFlpC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A74C81F000FF;
	Tue, 22 Sep 2026 08:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790066546;
	bh=KZeZtpp3ed5sKF+jpfFjNru8P5kc1YgzbnHKql7JyNc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ec5GFlpCGfU84fzcEJGEzMsUCiGAfAJHpw4cQ5xxQX/ielSUMmjkbkzRfJ5mjKYKE
	 KEy8u8K8gc5HWMa019Oc3f1gxoBHh750Kml0vdO52+axUBrI4W6vdUiDqijc2/UfnE
	 FqMHtQP3uYM7ommUJ+S2yZDzdbo2N3OJIUIbW0Ck1bqd4zNO3Mo2+dpFrV0l32So0C
	 E+dNbhdHqme9mwCE6FPtJmEfVVuIGM/BVW3NMtoJSQMkXkP2IVwcxr/5IpkMo+v5xs
	 aYVr2Vw1CpuHSR1Y2IWGz8SVDdx4X1DbiQBohRGyIVZsz2VQMQq7CPLpC8y9bc84y3
	 cPNTsoCPENDTA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/3] serial: core: allow third iteration in
 uart_get_baud_rate() fallback
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hui Peng" <benquike@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20260922083152.4055969-3-benquike@gmail.com>
References: <20260922083152.4055969-1-benquike@gmail.com>
 <20260922083152.4055969-3-benquike@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 08:42:26 +0000
Message-Id: <20260922084226.A74C81F000FF@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922083152.4055=
969-1-benquike@gmail.com?part=3D2

