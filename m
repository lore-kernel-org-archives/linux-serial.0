Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B16A3382F03
	for <linux-serial@vger.kernel.org>; Tue, 15 Sep 2026 12:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789476022; cv=none; b=DA66hh+Z+SbYsPUPP3Q/he04ANffyfuVsKuuqVpTZ6JKcIAhbze2rzTTOAe4aG4RB+BTqBxJtbYjkPqQn+RBNSdXgHV69Es28NdLJePqz3n39nElLagtZyjz2CWyPGWUWMy0YfEUq/Pm3SijeSRyP8nhsvcJFlHLUeixyvNzOJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789476022; c=relaxed/simple;
	bh=9A/Pt1tNaOnKcBIM88Q53TNuiSpIVnWS86+FC12DOZo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Bx//z9l5sQU+L3UT8SwJW/5FZpGjeWY+qM1VarKyo4lsp2DGfXUqMJi+yODwF0gASKJ+1qWdccsj1DSFPR4PeUpwwH/+Eaqhm/eRlOhXxFv0q+rDdk4IWqhRhGue0pKxE0WtFrztYywbnpakkQ69mfIlgZWsI3DF3HxGhlLhz1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=auiywy+H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="auiywy+H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1195D1F000FF;
	Tue, 15 Sep 2026 12:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789476021;
	bh=9A/Pt1tNaOnKcBIM88Q53TNuiSpIVnWS86+FC12DOZo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=auiywy+HFoPxprf95hwXKdbo9uyOmRvoHbQn4HtreZXCnnBTQg300xtHhMrmU7X35
	 b9prrfQpcMo1DoYYRxGgQT4jFmW0AukalLVmPHyyLET9WFYRHQ3235XqEgc9MstFtx
	 xe+glkr8I6uYN6UGBe7/zwr7gjobH6m1Cw5WDTVUi0qwRpn0LEJQnTAFcRFA75IX1q
	 eexrGvPw4SVMwX6bbmLKeGnw1StAqrN0/QFT0f4lM9YMOqDZmkaROo/SV2yeTCgbpB
	 Ma2yGaxS47bok1dcLEwdwHeScgMMc1qd350SW7N42OJTrXI7pHOju7krD0pC1/ujbT
	 dYwFQJ+dlu9QQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/5] lib/fonts: Add font_glyph_cursor() helper
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org, linux-serial@vger.kernel.org
In-Reply-To: <20260915123304.1027277-5-tzimmermann@suse.de>
References: <20260915123304.1027277-1-tzimmermann@suse.de>
 <20260915123304.1027277-5-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 12:40:20 +0000
Message-Id: <20260915124021.1195D1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> The new helper font_glyph_cursor() fills a glyph with a cursor pattern.
> As with the font_glyph_rotate_*() helpers, the caller has to provide the
> output memory.
>=20
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915123304.1027=
277-1-tzimmermann@suse.de?part=3D4

