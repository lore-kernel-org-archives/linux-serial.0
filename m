Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794959266;
	b=qkxkyzNpgE485i2PJy85aDx5w87BA1SsGH8bbZkqGi1x29JxtHXDjOmSZKDIpEHkatHN
	 jx+8qC2OWsF0T+dWXsdIUscWAmsJ5PEcNGqFxcP8CoolGlgo996MIVBvYgtEvBGpILFE1
	 edgydvzanHx/JN8NuzmdAcdXy9ePhWdTqBa3+fJHhxZ8/RtXy8l7R8aL7QLT3wN3g4L3i
	 yo09Tx3xR07+4sUDew9UmblF88aJMtFQPG6CM9cS1WZxaecAC0wNgodJ+RM25of7cR1Ol
	 dEIJ8L+fY+HHFiDnkSb7eAw/bAX9bxEYaHApWLvjIq+z1UdtP6r36mTpg0XJoWA/Wjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794959266;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=kuA4i0hG3XzeI+gFpMUV/vzgD2CZhwVj8iRBxZsj2zY=;
	b=xPcTsjJj23TmlBywRNOfMmiN3WYVh58D67kui+e1/XyEQTrBd305ey6VdzBUcMc9nxek
	 Ob/I5cPezIoms4uynKx9S8IutkAaP5YIqke+ZZKKKiFyTce76hjCDxB8qI3IqbScK4tRZ
	 QK7MK7ycZCsyxqGy5QYFhn3HDvcm5nj50C9w5cjEX/YRTtEwtI55PmDkjKkktPI3i6Hfd
	 oPzGhva2KePScqtLz4xWZ9h+X+NT8hG/mNgfyX0at6ZiE0mC7LMeF0IkjbNwtUWOaARDz
	 5v290a6rL4cWYKtK0WN7LSwZq67guqLW8fS3cIIRp2mTQbyzaxrPnYxNHTtDVF0aHww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DLYCIGl3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4F4606A32A
	for <linux-serial@vger.kernel.org>; Tue, 17 Nov 2026 23:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DLYCIGl3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA31A1F000C4;
	Tue, 17 Nov 2026 23:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794959265;
	bh=kuA4i0hG3XzeI+gFpMUV/vzgD2CZhwVj8iRBxZsj2zY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DLYCIGl3YtrTVjYUWWR2PUHY94Lccufy3dYXE1HN+RzLfhjMFI+2m4dsUdBJapLdp
	 HVM7QQA0GwMbtDwkhpsziHN3nBBE99u8FVAv6tl3mULU+kUf9kvafJDH4Z4jYjesOx
	 H1BgqWrnFdtB624gwNln7qvfI/HbH0Ay+ovaa557FWJOeBGg7Bhz/VsBOaiQi17tJU
	 hImbW0PfQcCnuRsapO4MKetwEATJo849pLS4nupXVGTb1WP3Ss4ntmozbk2wNLZR0W
	 0HVhw/o4LGgrzMUquz2Bu9VvBCRRAvKckGicloC1quAnrEoNM2vgHgCVWV4eUGRjTh
	 AELM0CZOuRLlQ==
Message-ID: <sashiko-outbox-219806@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 3/7] serial: rsci: Enable transmit end interrupt in
 rsci_stop_tx()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Diogo Ivo" <diogo.ivo.sx@renesas.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261117-g2ul_sci-v5-3-30b58ea18923@renesas.com>
References: <20261117-g2ul_sci-v5-0-30b58ea18923@renesas.com>
 <20261117-g2ul_sci-v5-3-30b58ea18923@renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 23:47:45 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> Currently, rsci_stop_tx() clears CCR0.TIE without enabling CCR0.TEIE.
> If transmission is stopped while CCR0.TE is set (for example, via
> TCOOFF), the hardware FIFO drains and sets CSR.TDRE while CCR0.TIE is 0,
> and no TEI (Transmit End) interrupt is generated to clear CCR0.TE.
>=20
> However, on RSCI setting TIE while TE is already set does not generate a
> TXI interrupt. Thus, if transmission is later resumed via rsci_start_tx(),
> setting CCR0.TIE while CCR0.TE and CSR.TDRE are already 1 fails to call
> into rsci_transmit_chars(), permanently stalling subsequent transmissions.
>=20
> Fix this by setting CCR0.TEIE in rsci_stop_tx() whenever CCR0.TE is
> set, ensuring sci_tx_end_interrupt() fires once the hardware finishes
> shifting out in-flight data and clears CCR0.TE.
>=20
> Fixes: 0666e3fe95ab ("serial: sh-sci: Add support for RZ/T2H SCI")
> Cc: stable@vger.kernel.org
> Signed-off-by: Diogo Ivo <diogo.ivo.sx@renesas.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117-g2ul_sci-v=
5-0-30b58ea18923@renesas.com?part=3D3

