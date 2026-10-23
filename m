Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792740967;
	b=BzQDZ7Dc0vI3+E0iwZc8Is5kShyq1B/i8B09B7YjwYDFdh6/H0puRLQ/QWMncnYG2/ZP
	 3QiHOKyWNvEWKbnU5u94mqJQtyEJKxvhvuMUDarwIw8s0IrhanICNEPr+rD9Krrb/m9ID
	 bccorSgF/p58jDHA7ot8k/bg3o3ZenU9R0jP3Vvlh02Ubd6T2nObeK1UHlryil1cEJ4Q1
	 sehkDp71rUoN4hi1/xYeL6f0IhWaILvxRp0UET65mT6ksReU8HExRsV1KbNyNjkag79Rf
	 HSbxpFoUX1h6x9Zlo2kmnFHhyNUMqUDhiuxlawDxTIM1UBfIFmtMQ4Dbxv01lEPN/Zg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792740967;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=sW/Tufy9D1ExbWf/cUppq6W+XfKf6sszR0HuzitkdI4=;
	b=OEuVwjy7aCvx0p9oz/l2nTHLSgGvhdXPTSN0cZlk0KfDTcSCcAOMIFRWLONNyO2+wD3E
	 h/SSb6V3X8Mlhj4L4vajKsKFHSYe4NFFJDN8g3dTar8pKgVbzvCvYsSwnY3wcD/X04zzu
	 ZqB4ia5rJQ2ulJRR+wE5hS1/Pj8NstlA8ECd3peYp9oAsmD/tdRoVDGywuN/GDxSPtBMi
	 8AhhkRG80S1FLJMFGSBos6PwUSAV6aMrMpsvtOc3iNr1hgoyV7hDaxaX4BU+S1KipNgOg
	 MYWcoN2CpBg9ruEhoOxwOEIPotiM01XCIjdC/21LDbevDo1P83mW8Z3bahdR2xxjc9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UQsGliBj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24882606A31E
	for <linux-serial@vger.kernel.org>; Fri, 23 Oct 2026 07:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UQsGliBj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 972381F01828;
	Fri, 23 Oct 2026 07:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792740966;
	bh=sW/Tufy9D1ExbWf/cUppq6W+XfKf6sszR0HuzitkdI4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UQsGliBj8LdIecfB1CG71vs4VJ8ILFk5mMwGOardk4+vgC1gxKDXokM1bbTkHOi6h
	 iPKVUWVidIZJH9Wbz+4UzfJeAaWwEjvGWlOCcDxV6E+KXev4cqppd3EjitGWEaElka
	 R8KyIVIvhc1W6B+tuq45Keyu83h2IXHpMl9hTd5bnAkhOMnSehinBXGH8xyxsFWACS
	 Nq0I+Vp//2RzU3B0g1p4NJskimzT3GmpOa1o8F71ACyegUKxh8pu8s2ahcb/JRufzK
	 tPcQjEXyy8DEdeCQ6WJlSpTHu7VPl3ClA6WKSX3DB43rZfb2DEhpHAIxPyvB4l4dil
	 Al3MZxOAp72Dg==
Message-ID: <sashiko-outbox-182420@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: serial: snps-dw-apb-uart: add
 Allwinner H616
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261023-submit-h616-uart-fifo-v1-v1-1-e4a3bae2eba8@gmail.com>
References: <20261023-submit-h616-uart-fifo-v1-v1-0-e4a3bae2eba8@gmail.com>
 <20261023-submit-h616-uart-fifo-v1-v1-1-e4a3bae2eba8@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 07:36:06 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> The Allwinner H616 UART has 256-byte FIFOs but does not implement the
> DesignWare component parameter register used to discover their size.
>=20
> Add a compatible to identify this integration and its fixed FIFO
> configuration. Retain snps,dw-apb-uart as a fallback.
>=20
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261023-submit-h61=
6-uart-fifo-v1-v1-0-e4a3bae2eba8@gmail.com?part=3D1

