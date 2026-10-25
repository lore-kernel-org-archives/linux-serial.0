Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792969982;
	b=De5BlL3vs1r0rYmiThm/jc9L1BXF4sr2NVRIT6eihSBfuXSFqeC5eXxJskh9XO9lkVjf
	 wSpBuD/VTmUHzoJ+8e4INUxws2pmtvA627yr5NA0DtWDQJrpg507S/d/zbESM/4a2bofX
	 ZkykAV2gicLXp6ktvfT/3BSHK1Uf4qZySBgXtjH/em8uK2lof2svnAKLZHMMYw7sSD2W3
	 6iv753tjyBJpWeVLZyWyipTJ7FPBbWF65ezpN62FA7+jRYB/9eO5/3YjNxzLPnXqNH7N6
	 8MKigOrAHztlTEFvUidlKx39i9qB/JotkhxgG/zdRQslL2Dexhg1cLwxaAo01E80IJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792969982;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=mMv7zhwehuLmRAntlR9maYJn78qQTfxh4CiiQFQ3p0Y=;
	b=VLrjpx1ydUeijk6ec2cwxna9JDCdHUUZ+/IMXi1baPlQZfMrNLTso3G1PeY9Go5eBbge
	 pm/BUREvtughIfIfhM/y0VU8aKxdk1D9lB7jrLoDTfD/oWeIh5PaERfvzBCYx45k+wUFL
	 cOtfarUZlAlzi7WKPjkbMFckNXtH/9x70+hx6or+wf80sX3IGXrxoTR6TWKt87+obI7ht
	 e3syhY4bCKmEQYihqwG3J6bhWrUolfqoQfXbJGT1W9GMZTSyMc4dgrdu/67oE4YSrxncf
	 gQVCdmXtMBVfjLj8fa7oersynSlj0YBstnJ3lCNWdJMuH3ZpHf7pvZx7USFNHGUw9mg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jJdKpd61;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17DBC606A31A
	for <linux-serial@vger.kernel.org>; Sun, 25 Oct 2026 23:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jJdKpd61
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 852FE1F01825;
	Sun, 25 Oct 2026 23:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792969981;
	bh=mMv7zhwehuLmRAntlR9maYJn78qQTfxh4CiiQFQ3p0Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jJdKpd61Iou2fGRegbfEXk233HLUy6v3LInSjQcjloNAM/r/sqkyqDGH7SfgW+c2H
	 4T6mXb9AjYtuZzM4buPxEEca8T8gXBJkmAtiOuHzZJyXiY85NhSW80grOEF9utVCvl
	 d3d7ySV3kbukc8sm4pomwVPUeF418yZbxiH1McWVxeoe4s0oFcM5kCCrYupq6Ww1lS
	 Mlz7j5PbSlf7ejZnzWhzP5OqkwPSQxr++gWIxv4GkYhg4JvK2bKxfU+MctAs0iTrjZ
	 tOplwP9pcoqg3VvvmeQ1X3Ye9egFvW8VbYfImDsyde5rBUK14F3jF7de9/KdFZ8ks8
	 kXhy/qALYy0Aw==
Message-ID: <sashiko-outbox-184520@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] serial: tegra: Fix overflow in
 tegra_get_tolerance_rate()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Patrick Fischer" <admin@tsv-stahl-riesa.de>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261025-upstream-serial-tegra-overflow-v1-1-267b5b7a79ee@tsv-stahl-riesa.de>
References: <20261025-upstream-serial-tegra-overflow-v1-0-267b5b7a79ee@tsv-stahl-riesa.de>
 <20261025-upstream-serial-tegra-overflow-v1-1-267b5b7a79ee@tsv-stahl-riesa.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 25 Oct 2026 23:13:01 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> From: Patrick Fischer <admin@tsv-stahl-riesa.de>
>=20
> tegra_get_tolerance_rate() raises or lowers the UART clock rate by the
> tolerance from "nvidia,adjust-baud-rates", given in units of 0.01 %. It
> calculates rate * tolerance in a long, which is only 32 bits wide on
> 32-bit ARM. With a tolerance of 136 this overflows from a clock rate of
> about 15.8 MHz, i.e. from about 1 Mbaud, and the rate ends up adjusted
> in the wrong direction.
>=20
> The Tegra Note 7 (Tegra114) uses a tolerance of 136 for 1 to 4 Mbaud on
> its Bluetooth UART, as in the downstream device tree. For 3 Mbaud the
> driver asks for 47.79 MHz instead of 48.65 MHz, the clock rounds that
> down to 408 MHz / 9 =3D 45.33 MHz (-5.6 %), and the WL1801 controller
> stops answering after the switch to 3 Mbaud (HCI commands time out
> with -110). The same overflow gives 23.31 MHz instead of 24 MHz at
> 1.5 Mbaud; both rates were confirmed on the device.
>=20
> Do the multiplication in 64 bits. With that the driver asks for
> 48.65 MHz at 3 Mbaud and gets 48.00 MHz.
>=20
> Tested on the Tegra Note 7 with the tolerance of 136: Bluetooth comes
> up at 3 Mbaud, scans and connects to a paired device, and the HCI
> counters show no errors.
>=20
> 64-bit platforms are not affected.
>=20
> Fixes: f04a3cc8d455 ("serial: tegra: add support to adjust baud rate")
> Cc: stable@vger.kernel.org
> Signed-off-by: Patrick Fischer <admin@tsv-stahl-riesa.de>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261025-upstream-s=
erial-tegra-overflow-v1-0-267b5b7a79ee@tsv-stahl-riesa.de?part=3D1

