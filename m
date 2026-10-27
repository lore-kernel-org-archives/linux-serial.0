Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793142793;
	b=k5+4muFf6zPdwE/PszZYa6N+cHvIrtFGAZCcR/RecNO2DiVU/6XfOUNp08tk/1AQ6Ull
	 ToSxrYqSHwqJTgGCaMcHSUYZwugG01GrTQw5pAc/GGnehirHluOZwOGlrQpsI8fIrvPcv
	 2Tov03SfyfOSf/QGtLFKSym9okPvXVKEWWjHOpWzfyALYh7IS5U42oIT52SbPFm9yK1RI
	 gAmpSf9L2FOp+wy3xTAVnutcSQ9r576ZT6/++q2Edmz7WZjJB+3p6fXsbylWCP3ADlZ2g
	 D+tRxnsT1/VQ/EzKHNEAoVTe6cVSvAkEZGyPipRPy6D3OurivrfJaa61UNhGLoVQLJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793142793;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=XrzSkyvgoqhCPbaxyWRBC39oe6AfEtdBILqN4CHMmYo=;
	b=wJS+bA+Xw47QOm8/881H7cqevhQEgBx4/Tt14AV1mJ0giU1LFvQ3mCPH5aAdvncE1G9T
	 kQ1tFE8vg8qR40jLmrfBfTZO/rglhoLFXuxNYCmfXG31lJuiJXGh8X7Di9q8uVfO0t+vz
	 cQhUMvp1qjyApYfjoo2uWTFwQdBA2gAJNPw16RaeaX0eQZT3l/cYHI7xVwcUAccFv0F1F
	 FtWz+JHwEYIEiBi26AXP/FAh4VrMg5FsDIdqT5WtXCcbFqD6U6wPG97Z7laDGsT98xWg7
	 tEFsPcyl4MpjAc9VhCHMr+PutTsA28z95jG+0bl9JDymOqrrnEqhXjzkNRvEJJ9tOYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MXAZi3nq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682A4606A31D
	for <linux-serial@vger.kernel.org>; Tue, 27 Oct 2026 23:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MXAZi3nq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB2371F01825;
	Tue, 27 Oct 2026 23:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793142793;
	bh=XrzSkyvgoqhCPbaxyWRBC39oe6AfEtdBILqN4CHMmYo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MXAZi3nqfGWaAMuSvvs6/UnuZssGoddF96lLw6YXbyf29d6Jgnl76xlszInNGekHR
	 dPgKrk8Crt+kOS5faIsghOkSnm3k5gjfWPSVIRCZpaW+AU7J5EcHuycyKXkwnj1bLG
	 3qUr1K+YUBGy+4F7BSZyLCk86apa8IyihjkcWj9FzgzEUwPYmg3aPREPpRdfOt8B6r
	 kiqTf8jOsflCAdItTBnRIKfDS7EPAXSLh9ptjYVfYE/HJCV6/V0gdF6HGNJUtdnLyW
	 D1P4BbdT2xrhyp2IWTTkDYoB7dAeH9GP34MAMNyzU6hOL9hflWBWUdRypPfeWEkWs7
	 QVP8sGUhSvm7g==
Message-ID: <sashiko-outbox-187198@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 5/5] arm64: dts: allwinner: h616: describe the UART
 integration
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261027-submit-h616-uart-fifo-v1-v4-5-d37e018fd0a6@gmail.com>
References: <20261027-submit-h616-uart-fifo-v1-v4-0-d37e018fd0a6@gmail.com>
 <20261027-submit-h616-uart-fifo-v1-v4-5-d37e018fd0a6@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 23:13:12 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> Identify the H616 UART integration on each of the six controllers. The
> specific compatible describes the fixed FIFO capacity, register layout
> and receive-trigger mapping.
>=20
> Retain snps,dw-apb-uart as the generic fallback. H618 includes this DTSI
> and uses the same UART integration.
>=20
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027-submit-h61=
6-uart-fifo-v1-v4-0-d37e018fd0a6@gmail.com?part=3D5

