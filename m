Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F089496D2C
	for <linux-serial@vger.kernel.org>; Mon, 19 Oct 2026 09:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792401318; cv=none; b=YJZlXLhU52gwr5bLvszhWD+5ZwLGoIF5Vo85GdaObyi4WGrW+GmaeUt4OhH0lFHguX1V5S/VdIs1Ggto+tF8anU3RIZtSrnvcGWhiCp2Zb0KlRSCZhOjfYHEVAUh70lHpDf6aMrxcmVQtg72AwoXrxZuNpXcJChUq5oMTy/JGKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792401318; c=relaxed/simple;
	bh=ouuw5IdFiWVhrShuN0CWfrbL6TGotUOqfLpyo1Zwwho=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=cSZiFXzqUhObk9OBfHUIQ6bAxJGGm+tkarZ9kshHs4KMDQORv/C2/OZJ4+8H4kRBoz7rWtmeqblBL8CFt5pZjWge5RF428b4LFs+58yOeafTK1mQc0oXaC7PkWVl1nx1MGnT7WxyZ5mw02CcgnE0IvieE9+4sa/fVdmUDZeFeSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pl34QSCf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pl34QSCf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE88A1F000C5;
	Mon, 19 Oct 2026 09:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792401316;
	bh=ouuw5IdFiWVhrShuN0CWfrbL6TGotUOqfLpyo1Zwwho=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Pl34QSCfvBlvGGRsixs68m1Px5dODRPL8GNl/tloy1lmLiDqP/k4fsfKcVLBDNRoM
	 ub0Hiz+xwPWFX37Jaom5BdHBQgWEBoffH5ziGisFSQ1sbH489j19q7hz0ZabFrA06d
	 MousO//8ogwbWTQyrh5S/0/Bgm/GE79COpt9eNoCR5WA5kCRoQ46bZ0B0AF1KreADf
	 mtN8yG6RKg0w0IkNuH8SdG1kTHwkUHSIqHlpGBKspZ1UhQOSUXN9YhNI16eMiqEvbE
	 CJJiEl4k0W3pqpOfkb4hb8tEuZOCAyVGL4nKMTe65gfpqZwUDUtjGkS3McDHc3Fus6
	 lnRIjaeQpU8eg==
Message-ID: <sashiko-outbox-176882@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] [v3] serial: 8250: remove obsolete and broken PORT_RSA
 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnd Bergmann" <arnd@kernel.org>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261019090017.430425-1-arnd@kernel.org>
References: <20261019090017.430425-1-arnd@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 09:15:16 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> From: Arnd Bergmann <arnd@arndb.de>
>=20
> For all I can tell, the RSA support in the 8250 driver is not functional
> and has not been for a long time.
>=20
> The RSA-DV II/S ISA card[1] was sold by IODATA in the 1990s as a faster
> alternative to regular ISA serial ports, and it was discontinued in
> 2002. Linux support was added by Kiyokazu SUTO in 2000.
>=20
> The driver defines an I/O port base address of -8 (negative eight),
> which should always get refused by request_region on all architectures
> for being outside of the valid resource range.
>=20
> Further, it seems that a patch to setserial would be required in order
> to set PORT_RSA when not using autoconfiguration.
>=20
> This patch removes all code related to the RSA support, with the exception
> of the user-visible PORT_RSA definition.
>=20
> Link: http://translate.google.com/translate?hl=3Den&sl=3Dja&u=3Dhttp://ww=
w.iodata.jp/products/network/rsadv2s.htm
> Link: https://lore.kernel.org/all/1309211120-2803-6-git-send-email-arnd@a=
rndb.de/
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019090017.4304=
25-1-arnd@kernel.org?part=3D1

