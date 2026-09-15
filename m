Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12FFB388869
	for <linux-serial@vger.kernel.org>; Tue, 15 Sep 2026 12:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789476079; cv=none; b=lN4Xlwkkm0FPSkdCTnO9zJCFzOnPg14Gp5xw+CHiYDI6d4nGAtC5ec65Sm+hdHnNKeqQprId6ppqUYB63Vq4jix/s8+heQmoxkNBWdIxgWupYMyb+EPDVuu7J2EwuyVio0inMpy82nKHI6ExJtbKqg3p2gsrbjvX6TmM7kBZ/wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789476079; c=relaxed/simple;
	bh=Z6MyVeDiCc735EkNNe/nrN20zgMnw5t5Irauf/OnY+o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dzisWtXhRg1MPNLIH44tLGJyb9VP9zZzAVjWS+lEV6lt6xMDHOzd7jEvh05SVpXJ0j1Znrl34hUIQQ8Qyg7N5bal9DnoXBtgEgqZfrhucQ5XXFjv7mmWLPgArV40PC5j72sIXR50LY2Sc58uybT1KgRnkDggj/6KFgtN7+AYPRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=djeWWO1P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="djeWWO1P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C71641F000FF;
	Tue, 15 Sep 2026 12:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789476077;
	bh=Z6MyVeDiCc735EkNNe/nrN20zgMnw5t5Irauf/OnY+o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=djeWWO1Purud1bY+93tl0fCxcFEPMz4C4/3advyQWSgpFd0ltCnYkEitUL5n4yeY8
	 00Yj0R1I9CHf6ui4SASuZ7WE4Olqis+MTo80F2tbX1dumKxyw645FduxVMk+Lb7D//
	 QUSMMOnBBzfS7+3WQ2I6oOdon61McdYlCEv+VnzqPeNyL8/bdQDjAZf22TgAQhGBXw
	 IDk5MMPzKeRDdFufxlAe2UMvkwibs99WWLy80wqjB3Cmf4wJPG5Cdxv2mfC6VkmljS
	 myBDmm496Me+05ghv2Tz/JOzmTd4xJgbkZ9a0Pm9/Z/NlRVVYKBOZAUsuutSUFh/S3
	 bsEwLAWIJ4w2A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 5/5] fbcon: Replace fbcon_fill_cursor_mask() with
 fbcon_cursor_glyph()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: linux-serial@vger.kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260915123304.1027277-6-tzimmermann@suse.de>
References: <20260915123304.1027277-1-tzimmermann@suse.de>
 <20260915123304.1027277-6-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 12:41:16 +0000
Message-Id: <20260915124116.C71641F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> The kernel's font library provides font_glyph_cursor() to create cursor
> glyphs. Replace fbcon's fbcon_fill_cursor_mask() with a new helper that
> uses font_glyph_cursor().
>=20
> The cursor shapes remain mostly unchanged. The only exception is in
> underline cursors for fonts with a size larger than 10. The underlining
> dash is now one pixel closer to the font-glyph data, so that the cursor
> looks less detached. This follows the style used by vgacon.
>=20
> v2:
> - adapt to new VT interface
>=20
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915123304.1027=
277-1-tzimmermann@suse.de?part=3D5

