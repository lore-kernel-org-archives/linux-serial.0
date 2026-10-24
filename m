Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792819277;
	b=uIiDXhU4eaSsS8VrZhPdtNRxVpqGjmKNZO+7+av4/daS+uKozhUDaxTEyGct5Uv+q/Ag
	 KIp3m+T3DF/0haj11ZaRxRmUx3+YeeDT0hFVuqszT+DTTxfp8YR9aW/CX9QwBq+O+XpCo
	 lFTcPsZXqYxHg3qOk8G6jKFntwhYGP7qYB6oAktDSJvOcx3QYZ6Jafjz/MiZnRYOm8i1o
	 64/vD2980I5E+9hiT3R925viEj7Wu0eJ16sEIKKW+j0GQAvlWmxAEbF986IxftiNxry7k
	 uv+S0ZFGicjZVCF0+O7vnfrVOipM9llfIT2Xh8vD0dzAzirIT48w0INj64PBwwzcPtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792819277;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=XgBp0uawZT3/67ZPOXJRRpdWfzsbhr6p8/DY7AZyXX0=;
	b=PN7rnzfsh+jsLGHT/6xblHC4H2MHEJnBQBFcad3iR85LG051S/C1v2YbE5pgnXQVDQ+s
	 fiP6o7MKlc77caoz7Ch0nnZI6x9YmezxKmVAT0gTIQgIz3Al7YD/EaukZB2i9jJydhkUD
	 jtdtoC3Cj1oDBDZyoU0Dlvd9LmLv5xHQxP3NCaeZdkl+gDqH0FWNxgtGAt+qNt5+OkXpc
	 mXzGi8cPD9B2KpqWzOgFnTHR8wDEfj54npR4+4Hnhf5ui0su/HgOivLCrf8r01dz88CAf
	 a2qhChBFyjfVL2ZN/gNqF13qFPHRYbvjXWK2XN9rBfMAHDAzvl0qpwyznL0wKj83bfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L4BIj1Q6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C5A606A31A
	for <linux-serial@vger.kernel.org>; Sat, 24 Oct 2026 05:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L4BIj1Q6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15F3D1F01825;
	Sat, 24 Oct 2026 05:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792819277;
	bh=XgBp0uawZT3/67ZPOXJRRpdWfzsbhr6p8/DY7AZyXX0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=L4BIj1Q6BvVAKGxlsewHpToKYQzFDfLQ5wNl5Sq7mUjNw8/v2KIi6UVFpuxuIjjce
	 Ai+7S69zSb+ZkEvF6LcMCyX3kflHDKfnAipGoS9h8dF1P5JPPCF8LXhRAMCUOAylRq
	 brlRmqfq9Lrd9maJMBhzCKeXRAO6N3MLrNVyNt7gGgkOJrJwYbCSv52mH48GtANfVM
	 cJtoUG02TqLT8Zd+YTmDNNXoHAgJ/82z0YzR0x40Oe0TCrzJF5QD+alUt9GGuXQECK
	 x5sLrhCdsecrj5nIJBSVJnX55kULQG6Tvklikjyh0k7xeoHs8qybFGxZAUs64BnfwE
	 sU2pTb9EHPVaw==
Message-ID: <sashiko-outbox-183553@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] serial: 8250_ingenic: Start the X1600 UART from 16
 clocks a bit
Reply-To: sashiko-reviews@lists.linux.dev
To: "Olivier Louvignes" <olivier@mgcrea.io>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261024051515.55639-2-olivier@mgcrea.io>
References: <20261024051515.55639-1-olivier@mgcrea.io>
 <20261024051515.55639-2-olivier@mgcrea.io>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 24 Oct 2026 05:21:16 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> The X1600 UART samples each bit with UMR clocks, adjusted per bit by
> UACR, while the divisor the 8250 core computes assumes 16. The driver
> never sets them, so the UART keeps what ran before it: on a HiBy R1 the
> vendor kernel leaves UART0's UMR at 8, which by the register's meaning
> doubles every rate set here (the line rate itself was not measured). The
> Bluetooth chip on that UART then never answers: "command 0xfc18 tx
> timeout" from hci_bcm.
>=20
> Add an X1600 entry that writes UMR =3D 16 and UACR =3D 0 at probe. The
> offsets come from Rockbox's X1600 register headers and match the UMR
> read on the R1. The X1000, whose compatible the X1600's falls back to,
> may have the same registers, but I could not check one, so it is left
> alone.
>=20
> Tested on a HiBy R1: UMR reads 16 and UACR 0 after probe, and the
> BCM43430A1 on UART0 comes up at 1.5 Mbaud and streams A2DP audio.
>=20
> Signed-off-by: Olivier Louvignes <olivier@mgcrea.io>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261024051515.5563=
9-1-olivier@mgcrea.io?part=3D2

