Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792762585;
	b=CuZfiWKBKMR2LhPFiYMO24hD9X+ZW7r/EaB1T1V6XeTMkBSqlrgtG7MHzngXwycXIP1H
	 7pqV6B86J3zXt/iGk9gtrcmTIhLPQyIwu1g3+l5+HE+4WdCmehkEfjFBKW32z07U6ADiB
	 aRx1LFsrZvUrtLyNfcT2pjtZZzRRG7JwSU9hBxefZyqHnFBfVWJcwtMGyswDdUp13myyT
	 fGstGEQLRfg7tkC1MzqUp0+K0DlmuJwnSPjaTkDUzwOGdvsAdrRl9kGNBw6ogu85TfyN8
	 YeqISZnmRcXRkwh7qXmP84+cKw+WP5oPy+X8KZ3OcnsW/mDkzTIM8Rrvaj3DuNkzk2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792762585;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=2TYb2DM6zFqwlGUTCsigboYuapCa6CjWpFUapsFxeMc=;
	b=WZ/vqkEKCiQ2090Un6R4qGRGlvDiieYzwyzYszs1sqjcUWZTYh/eWpcH6rfH9xBxlpG/
	 Mqy7BuY2Y0NtBAiDFIJaHzXo8+FalR4DpIcFyt3g1nrZB9kOVXxEyNZTv0EiO4UI1dba+
	 BQ2uvkST8GVJS+vDsAt8UI9auZGjCPht8fxUNTJ0+lMz2a+otsuk1X4dKwTIMwj3BCsHM
	 Wt3dnLBbjvxjZQSpF6mdCGlatomY0RDfjx+dIekdQuhVHlNGYaSTwkTtQhPOAGjWO4AJW
	 qxOgNivg+JqDmaHsto3cF9LSWLgA+bRbjJvD6SJlqIJUQQZ1I1dqJJUwN1lzeuky2EA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NPlWTxro;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81143606A31A
	for <linux-serial@vger.kernel.org>; Fri, 23 Oct 2026 13:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NPlWTxro
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7C961F01825;
	Fri, 23 Oct 2026 13:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792762585;
	bh=2TYb2DM6zFqwlGUTCsigboYuapCa6CjWpFUapsFxeMc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NPlWTxrocy0HsTg9Ulvl8jWH+lgZ93BOfECWYyniMk26nEJw8bIa3SgiqF1qxXhiA
	 k7f8yeTgJqP4kYmj9FHVvMIf0Z0gJ5ARVu6JIzDX/VAax2BxYNDPe+CAadEp72dca4
	 boUWarNMilJjhdnaROUowzNzc0ZtIePn/tG7h0eqwF0HTeXpHoFRCv70lYTrbd/wnf
	 NlqM3hFBZSD+tLAJ2QXd/qpRVIA2Tp4pxDrjEB4ufJrwN8LTOXL1RKahw6dhhiRilg
	 JBcu3paTgFVKpC8Yd3C3YYvb8PDrJKz3pXBVq3G96+skwHO34t04pv6I2s7iZGIzzH
	 C2RnJVKabfk8g==
Message-ID: <sashiko-outbox-182827@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/7] newport_con: Implement struct consw.con_unblank
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261023132448.115747-5-tzimmermann@suse.de>
References: <20261023132448.115747-1-tzimmermann@suse.de>
 <20261023132448.115747-5-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 13:36:24 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> Implement con_unblank from struct consw with the VESA_NO_BLANKING
> branch from newport_blank(). Remove that code from the blank helper.
>=20
> Both helpers, newport_blank() and newport_unbank(), clear or set
> a single flag in a hardware register. No further VESA DPMS blanking
> is supported.
>=20
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261023132448.1157=
47-1-tzimmermann@suse.de?part=3D4

