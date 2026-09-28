Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27DE54848BD
	for <linux-serial@vger.kernel.org>; Mon, 28 Sep 2026 09:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790587267; cv=none; b=GpJfZ3zEdMmJkbocLY/yDxQWxw13T3DUsjmcmChIpgIv48AL94XUCO5cifXHbnBaDEHvRNbBBQ0SaCUmWvvJSFPlincdB9flONTTqNJH6jQEQU0h+Jml+dtuSyqdXCZ/hB70KAuu0yhgW3DISPo+zq5q4F2aoepIkoKrCJIBbpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790587267; c=relaxed/simple;
	bh=41dwQvvAj5dS5fS/OFysaZX9DGzlFq1nkfjLPItyE6Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YRaymxtALTfIWWmU3HFEx5CDN6tT7tGclS85JwhwpWWyAuXZ2BFjITMuMwabqjI7JdovWVfvcAy8gHteRTGUT2h2QYvaQ0/XAvTOLgEpQnDcNwPFmpNJBWujg+LjaSpx23qICsdd6mXxP8tIhf+2gJ5B2MvF+Ss97kw+2raHxWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ORpk0RDv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ORpk0RDv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35A791F000FF;
	Mon, 28 Sep 2026 09:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790587265;
	bh=41dwQvvAj5dS5fS/OFysaZX9DGzlFq1nkfjLPItyE6Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ORpk0RDvH4W932V+TJGbFCcF38wAeXEq6IzHQCm+U8qczj/zQ7/Awyz4mbEs9XDsM
	 /aycQ704LkpLFRkbWvj09dv/w2vj/XJyj5ejTeQLqSPwPfMxkx1FQG8ig0u1pSY3Od
	 8NPD8fYAo5NxZ6u0AVWyEb3CvW4SHzGHXO8NK6VQe6zn1Q8Z7bZZq5r+i8t1tIw85Y
	 POdxfR+RCznaJiK2yhFmKpmwtKr9pH5R+d2hu31ZheJUz4e5iUtOsdyGLeDNRbzVSD
	 CmwwZuu94Gw4fOdd7qy78J563CNvZSe4tp9gv/ydTyefM/M08UHUkMKKCIzsqI/Xmy
	 ZNC+zDbUmfhZg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 5/5] fbcon: Replace fbcon_fill_cursor_mask() with
 fbcon_cursor_glyph()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org, linux-serial@vger.kernel.org
In-Reply-To: <20260928085724.41660-6-tzimmermann@suse.de>
References: <20260928085724.41660-1-tzimmermann@suse.de>
 <20260928085724.41660-6-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 09:21:04 +0000
Message-Id: <20260928092105.35A791F000FF@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928085724.4166=
0-1-tzimmermann@suse.de?part=3D5

