Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D943A48987B
	for <linux-serial@vger.kernel.org>; Mon,  5 Oct 2026 13:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791207548; cv=none; b=oeAwy+qO7ZaiLieQauR/Hu2HWbrXglPfSsRHeVp5pp58sM4V2cRd1NJbVpGi3zqW41YOHnztcR4IZKsqBLPc+wANe85SBeic8GLsS5nh/gwF8hBbOhH9tZXGnmiSlyggQ6BBDVNwPGwaV29m0dGqTRijM1RsFcNmxVqqo/1ApCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791207548; c=relaxed/simple;
	bh=/yfP0dlsjq/iF7eC9bG4u/aCL/iHecW5q4fRl0zB7AY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZqBW7qoODbTLeq0Oqii2e+gbRxu65JOGPR86nXs7wUUlI0YXGnRu2+Upn8XGgqTalclkDbCSphKV2/Jcn9BF3WZ/eJvAvRLxNfBQ90xxOeHNlNj9ZiVAnbeVCEKOT4sKUuuz+3xpIzlNgIIohzBK/H3R7j0lJ1ep67HqtBa+yzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZBYeEWLe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZBYeEWLe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FE601F00893;
	Mon,  5 Oct 2026 13:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791207545;
	bh=/yfP0dlsjq/iF7eC9bG4u/aCL/iHecW5q4fRl0zB7AY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZBYeEWLeX2kP48tGD4iPlCsFbpMYXY8HsLAhkwaudqJa0qNm2lKG849X1+nYtJ96b
	 MD3m3+5VRV+91D+OlGKt9eha/L5fRCiLPb5KiVqzspb6vGX3Sgjalri+vEtMtY0Y/m
	 gmmrgmBYizp6bomhjlhJqarOB+yImnUgic4Jly8OGOsQ9L8zaDHda4uFwfb8JdhI9y
	 bSM3FfaztoFj7PEI6zf34By7IzjcrHhxORjQ+6/KCIDmjVKrqEpY/JClbskz4WBIlu
	 MGXwrM6E9YaEcn0tbTLkavX/12AazxZ7CJjZrQu5Oc+4qyC8pTy7UlJvcfKdCVUxmb
	 X+frP0PhnFBKA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 5/5] fbcon: Replace fbcon_fill_cursor_mask() with
 fbcon_cursor_glyph()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org, linux-serial@vger.kernel.org
In-Reply-To: <20261005133335.344302-6-tzimmermann@suse.de>
References: <20261005133335.344302-1-tzimmermann@suse.de>
 <20261005133335.344302-6-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 05 Oct 2026 13:39:05 +0000
Message-Id: <20261005133905.9FE601F00893@smtp.kernel.org>
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
> v4:
> - update for vc_cursor_valid_size()
> v2:
> - adapt to new VT interface
>=20
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261005133335.3443=
02-1-tzimmermann@suse.de?part=3D5

