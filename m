Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794727365;
	b=v/I6AbAomZR1TV3Nt7Y+NppjU/1lGCgyKJ8jJyVAOV/ly/s7xSi7IDTmnJZiZ2hrKVZW
	 340eZBRyruyMLHCcEYvImBqBK9s3HZcEkq9O4N1DATB3aU/K7UMaAjb3KPAx9W1sdlsBX
	 BpmpyUSM+myw+omPmyo710vpUM0zro0wOeRO5Enx7g3rXO3ySKGkLx+IErrpojhS2wFO/
	 YoshjSPpxCqBOB2GB3NGZ6HoKvsIqWYahvfyLLQgHs2jUGuZVU8bhCNEs0V3HLF137KgU
	 MMTF3ctYbnUzIh7bDGudkvVOetRWbaUjP3MGl15Gi/rrQvpWvHljkFVibhr3/4Uzq2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794727365;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ByO4pKAyI5Dl1XeFfaagUvjXhpDjn3nH5G0rVfX8VzE=;
	b=fh359kQ4vx4GTwP8N1+DqRUEBEnuL5FcxbQVz/aAIqZCLXJ53VvaF8G1LavCnW01ERDf
	 WSle/L4um/iTXqFThukz3S3iaKonEBRYYIL/fG98POP5bQaSWRSkFr0U9bX1UAoRoAAfn
	 IhQn92dOfHNoGUTxAs1T0IORh+iCOm7Jr9DF3cvS9tUdK+7j3bDN5rnXsr1ZTRprVItOf
	 jQrEArIJMOSbaZLGyDgFQGGqRMruJDg7CEr8oOoPPlhQH5IK9Oz6tvDsrPgNZ5TeL98em
	 j8wra1gVg8RtVkeXD2iK2jPc6MwDGoqftkT2QthMk0Emj/+/qz0kGBw2LYLX3CtXhog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BYB0XHRh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8843A606A31A
	for <linux-serial@vger.kernel.org>; Sun, 15 Nov 2026 07:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BYB0XHRh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FE1B1F000C4;
	Sun, 15 Nov 2026 07:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794727365;
	bh=ByO4pKAyI5Dl1XeFfaagUvjXhpDjn3nH5G0rVfX8VzE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BYB0XHRhs61C9mLKkEN5mg7fBfqq1dmBezBrnqPWpf2rXs8zqJPTEcHKUSUzJpylc
	 U98b0gLSGCa9v3Vbnzaj3IUw5DaJZw/qb7si+Hd5htg6/4tMYv6k7UB3re4IABsqKw
	 rku7nB2nTsPBQz86fUIPNDFwz81SBQhK94xgmmiOKSBWUhtNsme0Nu4qNIx5Zgk9iQ
	 TRmvIQLrMUq4GNxnSTFeqCvz9mm1009Ur6TBnvGWjnXueChwmEGx1rxOq7gevpNhe7
	 DBdSJT4dtXTOvoc/HR/kQBBmSPXoK8i9pieK9jbMQ4ODCTVOq+zmRoG9TiQkbWQocH
	 NX5D87wak15GA==
Message-ID: <sashiko-outbox-215255@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 04/10] dmaengine: dw: extract hardware-LLP residue
 calculation
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261115-submit-dw-dma-synchronize-v1-v7-4-8d58f3d49e4d@gmail.com>
References: <20261115-submit-dw-dma-synchronize-v1-v7-0-8d58f3d49e4d@gmail.com>
 <20261115-submit-dw-dma-synchronize-v1-v7-4-8d58f3d49e4d@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 15 Nov 2026 07:22:44 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> From: Serge Semin <fancer.lancer@gmail.com>
>=20
> Move the hardware-LLP residue calculation into
> dwc_get_hard_llp_desc_residue() so it can be reused independently of
> completion handling.
>=20
> Keep the scanner's LLP snapshot, descriptor updates and early returns
> unchanged. The helper reports whether it found the current descriptor,
> including when that descriptor has zero residue, rather than using the
> residue value as a completion indication.
>=20
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
> [james: extract the calculation without changing scanner behavior]
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261115-submit-dw-=
dma-synchronize-v1-v7-0-8d58f3d49e4d@gmail.com?part=3D4

