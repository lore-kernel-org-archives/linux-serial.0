Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853E4489FB0
	for <linux-serial@vger.kernel.org>; Mon,  5 Oct 2026 13:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791207552; cv=none; b=NJDg/pMdolaardh3KTAw/FJ1V3lLtlOojTYkfmmjbdGibvCaorzOF1fMTGA5ElWMuTpoMS7ZO2ZVxjfohXb6Un216Y87mWFR9td32nrK1tFshK22BUWEWni5wXl1LunUjxfWjSFukq/pUycGWMmya/IJp3DYnj1XkiB8YNT9wTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791207552; c=relaxed/simple;
	bh=nUIc+37affsky57nZc3dwmQYZNxio4Szojhmgj4S1mk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=V5i1oH9ZRaoOCjwVAvMiWsoaIZiMZHQgoDz80rnQluIEH5w/H8z5h1otp4aOxsUR7PchOgKZnELEfsyXSzPl77VgP4WFPK3MY+aN6c7LXbIGrDbHzn/doQyHyVAbf92dn5rXu3iCwWxZTpngUNutXmKMs+6dX8vaVCj2hNpV2Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XLGHq2LX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XLGHq2LX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41C8D1F000FF;
	Mon,  5 Oct 2026 13:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791207551;
	bh=nUIc+37affsky57nZc3dwmQYZNxio4Szojhmgj4S1mk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XLGHq2LXDVAsojGEFZ4CUi8YJ0Fa3DHpptM0kMsr4/yiVAg6FHgra/ZVshW5Z9i0k
	 4g2cjvQU4JhLnLa1PRiIQVWaC0lfykTj/6Tob4ekElaAJ3+DorfYq5QrfeOdez2itu
	 tA3r+H7Lbjp7qx86Q6Yc17Nm2Fy4kDWF6g706zq9LZEKY9ohdVMj6Q+pINQsJ+HwFr
	 /5dnR1d2lzezf4Ph7tRtzXEKm+72KM+UgDshmOawn66XD54tAp0MiD+d5pjNOQoINp
	 b3NURM0HkYCibupzc2yYfr4KKAFrnfoORRfuZ9nJKRL/CTW05etCRT5PnyfSJnh0te
	 jbtBycjhsjPYw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/5] vt: Add cursor-size helpers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: linux-serial@vger.kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20261005133335.344302-2-tzimmermann@suse.de>
References: <20261005133335.344302-1-tzimmermann@suse.de>
 <20261005133335.344302-2-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 05 Oct 2026 13:39:10 +0000
Message-Id: <20261005133911.41C8D1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> Cursors in the VT subsystem are blocks within a character cell that are
> filled with the foreground color. The new helpers vc_cursor_start() and
> vc_cursor_end() return the scanlines in which the cursor block starts rsp.
> ends. This is compatible with VGA hardware.
>=20
> In terms of cursor design, the new cursor-size helpers follow established
> styles in fbcon. The only exception is in underline cursors for fonts with
> a size larger than 10. The underlining dash is now one pixel closer to
> the font-glyph data, so that the cursor looks less detached. This follows
> the style used by vgacon.
>=20
> Users control the cursor size with the vt module's parameter cur_default
> or with the ESC sequence \e[?Nc, where N is the cursor-size constant. In
> case of an invalid setting, the new helpers fall back to cur_default and
> then underline cursors; in this order.
> [ ... ]
> - export non-font interface for vgacon
> - avoid interference from concurrent user space (Sashiko)
> - fix function docs (Sashiko)
>=20
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261005133335.3443=
02-1-tzimmermann@suse.de?part=3D1

