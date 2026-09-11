Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8843B7742
	for <linux-serial@vger.kernel.org>; Fri, 11 Sep 2026 09:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789120204; cv=none; b=IOSus3Sf+50qhNfzg6EBMGCaO92PIpDPnLO5NWq1l2GwmbQamV4MtEJuUD9cQHoKz5AUfyYhwe3ZQyqUZRuAxZiYODNnOrARSukKY7qBq0JL0SiDWrFBZIFkKOE0wTDoPV+6/5cFfeYhlrAOtOqi/s0gqke3FjkncDJP+pNDewU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789120204; c=relaxed/simple;
	bh=YnSJmZaaxbmrEJwi3S5LtU9SWrehkzPV5AyI6o7bX+k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=l2dTe6sxwo0pGXGNrCZ8ee3Fu+XLdHd8l9Z8ysxesf9xT4kOWbHc/pZ1mSsK17GRQrxby0Lc5ilUN2LVIAnsepHM/odKjJQNs8WK3M8O0JG2chqaSzs06AnMhfeypAiPOQ5XcjgPujsRrYiP0fgWdHomlTvK2C5wy6uQL9UFpwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AbYCAxVL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AbYCAxVL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 406861F000FF;
	Fri, 11 Sep 2026 09:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789120202;
	bh=YnSJmZaaxbmrEJwi3S5LtU9SWrehkzPV5AyI6o7bX+k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AbYCAxVLnTwXyjlF4bW7t4EnKrq+iX2J7JXSwWA7tmB3A0aSIsbPHM3/kUmjCXZPQ
	 QPBXy0FYwRYFpVaUJG/eocYvpSh3wpvUEGB20VcBe/RL/vHBQBKdzh92MJGYlg6yM2
	 E3+i1AvMreXksAHr2VdhqnUBuXRYGXFW0oCGzKGjial+0UEZQ/YGPYFd3u609LbNBb
	 WMXJG7HfLfglfjrSiE1SbWSrcwoCR5XUhHyAiRhnnLD89AZiPMyxR0lDyiJopbTS9k
	 NaZphUkIGvEmWI6AYGfWnApD6Z593AOrHH2ymYDNVo0AZZeMh7+LYQzqzeuY9XLHUT
	 RSUmNWmjDH74A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/5] fbcon: Replace fbcon_fill_cursor_mask() with
 fbcon_cursor_glyph()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: linux-serial@vger.kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260911094518.78093-6-tzimmermann@suse.de>
References: <20260911094518.78093-1-tzimmermann@suse.de>
 <20260911094518.78093-6-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 09:50:01 +0000
Message-Id: <20260911095002.406861F000FF@smtp.kernel.org>
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
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911094518.7809=
3-1-tzimmermann@suse.de?part=3D5

