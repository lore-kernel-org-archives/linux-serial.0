Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3FA13A258
	for <linux-serial@vger.kernel.org>; Sat, 10 Oct 2026 19:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791661756; cv=none; b=qhUafCHRWF9YUsB/ww2EQElHhterET3TJ8RW9l3v6edaS8oadXZLeRrOmMxreS+nwIdOugpMZyldkjCcmAyqXha/g8AUADjKiPkZjTGE9Xusjb87WvgSvxM/jI4tdQeMCw49iKwK63/oHBTQRdT1iCBHlJgGeVyZEcad/uqPfkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791661756; c=relaxed/simple;
	bh=eh9OXsNMS9mRtIC5UkHi+mJ0+6xBIhd7bLz7ifIhkng=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=TaILCCu6Jxja9eo1qoOSmAR2o5Fe085o08p+xI+REAVKCzMDUWKRSsMpI+XO2K9FRF+m7epUMUzcVVJ363XUQHeh1w1fkM2Ys+4yYBg5FVDyXZbQHnTB0IAE8146DiJPALJ78Aftlcho4zzTpPukOPZhaAWl3vIszdoG8HTHS1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T5KVjFgy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T5KVjFgy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CAD71F000FF;
	Sat, 10 Oct 2026 19:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791661754;
	bh=kSEKbPXykgUO8WZssg1XEd7Gh21dWHCpeUUUcchJpVk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=T5KVjFgyQs7QT6j6L5WvS1aoGlbRwT9uxS7Ta4xFolHwnZtnjjke360pWqGdJ9o5E
	 0Mnb40Zdf+agoL9V/ARMb3Icg8Zzlw7rC/+AONgi2BhKuQXMs4+YKnU5R/DrLf5WpU
	 OY4mBUamplRpqO4HKY25PtAddYCg6+0yA3PVJHsF29sKm1q2IjC4OizUz4FLdbBgyk
	 hsjhEEFQ6WWeEgqYWSVtIa6JWh0hjfhEKyIEVQajSHYkyi6+5Q9NBPDGR71+wUyvij
	 z25zXD6HLBgeYoYYu2lIeyIkbg2i+BT11d6e+WyOaZRU7v4Mn9lNPpFYqkF0+HlRpS
	 jg/53I/7n3G0Q==
Message-ID: <sashiko-outbox-166854@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 1/1] Revert "serial: 8250_port: Drop duplicate NULL
 check"
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ferry Toth" <ftoth@exalondelft.nl>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261010193755.187706-2-ftoth@exalondelft.nl>
References: <20261010193755.187706-2-ftoth@exalondelft.nl>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 10 Oct 2026 19:49:13 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> This reverts commit 7885af04df6e4efd72910200c1bfc079d61202e4.
>=20
> Commit 7885af04df6e ("serial: 8250_port: Drop duplicate NULL check")
> added `up->dma =3D NULL;` to serial8250_release_dma(), with the stated
> intent of making sure DMA would not be used again after release.
>=20
> However, up->dma is assigned once at probe time.  serial8250_do_startup()
> only calls serial8250_request_dma() when up->dma is non-NULL, so after
> the first close the pointer stays NULL and DMA is never re-acquired.
>=20
> On Intel Tangier (Edison) with HSU DMA this causes a regression: the
> first port open uses TX DMA, the second and later opens transmit in PIO
> mode, producing 64-byte FIFO bursts with ~50us gaps between them.
>=20
> Fixes: 7885af04df6e ("serial: 8250_port: Drop duplicate NULL check")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ferry Toth <ftoth@exalondelft.nl>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261010193755.1877=
06-2-ftoth@exalondelft.nl?part=3D1

