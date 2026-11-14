Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794663824;
	b=VwTiH2CZV5q3R0g7pW4WrozxcIUA2A4mji8hSmx97VmU3+QaH29S4W3ikXYZW2wr4LbL
	 P6/fjsY+1XbwaHKPPbYBk3NeZ9kmFHJsA9rmlpiBxXkW+yxiNOQUjdlLDOll0LP30d3pa
	 pGbnxv5WCcD5KoMt5d+PC3B1uGUhmmGeQbprOm/zX8IrUe0+f2FwQiCAhL4rQJF8PIgBL
	 vkS2YHGAygq0gsr5FzQU3Ca5Edf1Q28xTxQsAzr2Spe53+AkbC64guayITCzrYe1Zdjfu
	 zYaSDpd2KtV73xW0XnwWvfFhBNJwMfl9mWmU5mR6XKwHfYuXi2xlRWO2M28rJVjfaQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794663824;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=nWHSy+IM9dbuAEjPFZzxCONaJJOV0kxW6GBHqBOoMVU=;
	b=RhELNlUpQyihEzUI0X90bo95jYhXGRFErzpxXbnpCvnk0DvMfkfIbiIlRipXdJ1DgVYu
	 hS5+QiNKoSJryNrYHTOVnn2lsxtefKd6V1y9RrUaklt/gd55hHSoha3eWtJ6WWZeyN3ya
	 U14+krN6/Q6a9TkOeExE/CbTUyY82rYlz/Wpi1pXzyuvVTmweh/RqB2PEZ08iLTudUuaB
	 rPS4irL50uT+zbiGFzoHUPyBSx9jecFa0QG2XcVC4/Y+uYAsn8KzjTeE26TC58Cd7LYph
	 wT0i/huXscfxqNetbWhlHAiOZZ4ZhkVVTPHEgcmSy2VHyX3Xi460qMXqCoQDv9IBDLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iMyMJoOr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768B0606A32D
	for <linux-serial@vger.kernel.org>; Sat, 14 Nov 2026 13:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iMyMJoOr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAC481F000C4;
	Sat, 14 Nov 2026 13:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794663824;
	bh=nWHSy+IM9dbuAEjPFZzxCONaJJOV0kxW6GBHqBOoMVU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iMyMJoOrOrrAuI4zbXl+7Z5Sw8gEmJEzVLe/rCH/vPgFYMvgPb2p5rP0N6lDWWFx0
	 dXd+JH5Vsoi/kcqjrV/7JCwU2EP6zhxSvqnpUVdTSPxlPGhkF22t8ME5W//AmHvHha
	 uwnXcXn4bFuijH1EfTDL4JDEpNWdrfJNkm85UIh5/SyT34FrYlKglWPaCzTd89QRCc
	 nhCuIMJ10PhBO0Dcw/ueFa/LUJuUvIMTs1bnOKRQgp056vn1B9VwoQDfnWUQbPVqYu
	 uc6SZXJLTrnwqDx6zcmjimbLKIEW0vkJ6YQTtSfvvVsr3tPf82CPK1wQo+iW/aoFv/
	 vvR0EPX6F6zeQ==
Message-ID: <sashiko-outbox-214585@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 02/10] dt-bindings: arm: Add Cortina Systems CS7542
 and Securifi Almond+
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fil Dunsky" <filipp.dunsky@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261114-b4-cs75xx-v7-2-8f17f38821b4@gmail.com>
References: <20261114-b4-cs75xx-v7-0-8f17f38821b4@gmail.com>
 <20261114-b4-cs75xx-v7-2-8f17f38821b4@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 13:43:43 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> From: Fil Dunsky <filipp.dunsky@gmail.com>
>=20
> Add the top-level binding for boards built around the Cortina Systems
> CS7542 ("Goldengate G2") network processor, a dual Cortex-A9 SoC, and
> the first such board, the Securifi Almond+ touchscreen router.
>=20
> Reviewed-by: Linus Walleij <linusw@kernel.org>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Fil Dunsky <filipp.dunsky@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114-b4-cs75xx-=
v7-0-8f17f38821b4@gmail.com?part=3D2

