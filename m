Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D591B30CD81
	for <linux-serial@vger.kernel.org>; Tue, 15 Sep 2026 12:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789476017; cv=none; b=HBE9o+eu10LRIakgmTHk4b1idVJMoAcLy2fFOG24y93R1zoGlpTDrbNL+yWYvDNYz1UQm8V++yEkaTYKlZHVUryuyYy/ooHkjEKB+Pe0dHIkGEZCqDf51eI5lCziljGPUkHv8D0/hhtjO7ohZf08IVK4QSheqkVKac61Xj7ACI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789476017; c=relaxed/simple;
	bh=R0CkVzHy1zDNnuSbzEVvhJ9r9+u1n/AcXLLJBx3kR10=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=clSVSpC2Tbj+6i0oR62l0LpIU1DW5Qi1kKrvapyN08rIuzSjS3dHivTZONVLvNhQCwlEDjBnUwf54dONs/7LBWaJmtODHvOpBX16SqfaiBGLnz149YmdnwHkStCXBLyGYsto7+xchD15Re57TIMmlX3kAoRi3SK3GPLGBOyWMsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OCPuzT+x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OCPuzT+x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CA611F000FF;
	Tue, 15 Sep 2026 12:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789476015;
	bh=R0CkVzHy1zDNnuSbzEVvhJ9r9+u1n/AcXLLJBx3kR10=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OCPuzT+xDttPPVzAhPzCFPhmZp8klBZpEWoH271EZOOwWY+zhUnplkBuzzr5xAqDl
	 HuLToXA66XN8l5erRWA2cG2tiKLipcz36q1fX3CNnDP3N4bbFaARN48U9nMRcU4KOn
	 K1SvrK3jiCMTimAHQ4//J1wG/QnKnzCTG95cJ9Lzq7TK7wE+gfPCbXR7+0V9MXS1p/
	 4beNBeN+64YA53ztFsDVubaOvnSD2gJPpbtDk0mwlkrDkPfNpAwwUndhI4o0Y6vAy9
	 lv2TTe/v8R3cUifAESPmGh7zNWRq+k48vLMDyTgjK7WUrXxGAHZgFekYPPFXqBXWyU
	 n71SSnBrikxBA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/5] vt: Add cursor-size helpers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org, linux-serial@vger.kernel.org
In-Reply-To: <20260915123304.1027277-2-tzimmermann@suse.de>
References: <20260915123304.1027277-1-tzimmermann@suse.de>
 <20260915123304.1027277-2-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 12:40:14 +0000
Message-Id: <20260915124015.5CA611F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> Cursors in the VT subsystem are blocks within a character cell that are
> filled with the foreground color. The new helpers vc_cursor_start() and
> vc_cursor_end() return the scanlines in which the cursor block starts rsp.
> ends. This is compatible with VGA hardware
>=20
> In terms of cursor design, the new cursor-size helpers follow established
> styles in fbcon. The only exception is in underline cursors for fonts with
> a size larger than 10. The underlining dash is now one pixel closer to
> the font-glyph data, so that the cursor looks less detached. This follows
> the style used by vgacon.
>=20
> Similar code in vgacon and fbcon ignores the cursor's default size stored
> in vt.cur_default. The consoles default to full-block cursors, while vt
> defaults to underline cursors. The new helper fall back to cur_default and
> then underline cursors; in this order.
>=20
> v2:
> - export non-font interface for vgacon
> - avoid interference from concurrent user space (Sashiko)
> - fix function docs (Sashiko)
>=20
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915123304.1027=
277-1-tzimmermann@suse.de?part=3D1

