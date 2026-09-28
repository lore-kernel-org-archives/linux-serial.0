Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9DF846D085
	for <linux-serial@vger.kernel.org>; Mon, 28 Sep 2026 08:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790585994; cv=none; b=pvB5Cgvnp/ONmsYNUXRkGYfev7XXqW8y51WuOgPvwh6i9YdJjGkloaVJLuSNBuPgRH+YYw0NfrNInWuO4Poh6Nydw2M4lt7SwtxvEEzYCt034bqo8IY/VbCrjBAecdbuIUSzw4R0hXxQrtpKgSlf7hy8LdpPlvjDX4mqoHrq2qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790585994; c=relaxed/simple;
	bh=ck8y35o2ZZ7l3mFVviLSo2dgGNUb0eLWyy0cSY+w45s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CTsqYkBqDYZ6kNb30pkaVfbFzH2+hXQxmxlY7JruNYw9YuEjrFRlSzfhvccE3Zij9DGp7oHIOcFtFc6VrFMc9TgkU0MAPkom4XZ4D42V7rcyycgUoBSFaj5oCs6V3bdlxDwEY3J1yhhP4uCrK8DyJX2c42XTH018Ef6wQsDCtY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nEcjBERf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nEcjBERf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 023CD1F00893;
	Mon, 28 Sep 2026 08:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790585993;
	bh=ck8y35o2ZZ7l3mFVviLSo2dgGNUb0eLWyy0cSY+w45s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nEcjBERf123jEEO6erfD5iG0qzlqEGOJBAozh0Iy1UD2hir4GsFP5cmkbf7C+9mci
	 Sf/UM7oFlNhRR8gDJ51R1rMPrM6HosQNiaX96OLu3rCHQBIDa7AVslg6YxpZ7A9pzm
	 Xhr3SvKBhHnF9QAMq1fXCpHyS50NRj8hoNO9WK3gc3QSVGeC94eeaHClglyKUFIB6w
	 6PIbCI+zNrKVbr5pya4WvXpV+B0hzUKhaUIKXCoNykdJlv+8sgfxOYI9933rh89aR/
	 uNRDChOfhIre70cgA3IFfAY0xt4Vkk92rUBdhE1e8YNbmUHQ3cp82EH4qGM+Yi2wZ+
	 XCEaMVD0a0PwQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/5] vgacon: Remove trailing whitespaces
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org, linux-serial@vger.kernel.org
In-Reply-To: <20260928085724.41660-3-tzimmermann@suse.de>
References: <20260928085724.41660-1-tzimmermann@suse.de>
 <20260928085724.41660-3-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 08:59:52 +0000
Message-Id: <20260928085953.023CD1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> Fix coding style.
>=20
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928085724.4166=
0-1-tzimmermann@suse.de?part=3D2

