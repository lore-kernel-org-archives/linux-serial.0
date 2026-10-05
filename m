Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DCEA488232
	for <linux-serial@vger.kernel.org>; Mon,  5 Oct 2026 13:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791207615; cv=none; b=LZwqSEHeOcn7AHfXpGySo+cJxzb+fyPrNJd2b2Qa5iPIGNHm0JTExaVDSVaVX6uxqAOrLgWnnSSzxc+6p2ydJofxa5DHIMTeF5dthNrnOf9Ne6HsCwLWamRLuPaQWzmcKmvlqdKZHpOmcmXNU8ogCfjSRz7JnStWo5eYgQlfm6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791207615; c=relaxed/simple;
	bh=qxSkt2toSMrZ8nqbkOoynppQDZQIepmbKUSPVoEmZ2Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TBf1vg/qipDK+2BM6wSjHyFE+mvMwIqnMshbRDMMSzLHgdfs91rCJlzmPU9WjZcMD8BBIFmLk14eW84jHg9RTEcuhtr5sLc4XKH0ZRBWuskmHEFPusV39B+GnZcv3XFDNB1vmRs8hMGaJdJVykFNVxuocPyM4tnsJiQ8gMkVWaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XcIi7jK+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XcIi7jK+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61F1E1F000FF;
	Mon,  5 Oct 2026 13:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791207613;
	bh=qxSkt2toSMrZ8nqbkOoynppQDZQIepmbKUSPVoEmZ2Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XcIi7jK+Gv9MoPtP3NTHwUa8UlfYJKxITEgomKbtYi2LpjJhLrEdGX8m3KykkqvtN
	 UwrU4AhQVLGVKCjfkWHNScTbOBSgB6ouWuFvlHEi4vr8FxnA4dhi/d9sIRqIclJC/k
	 A8pY97zzyK0nJcAl2YgFBTpEQXDNcfiInCdJkklgMtmtcTIr7qUzq8MJD0C34c91WV
	 iFcJsGmM3o6Rc5Jjexti4FA4lXi8Ht79V/dCpaP0GBxJWXvMDy3WrkzScgXXbl50bq
	 AqNYVm7dBwzgWE6l14O15oYThPebmiSIfSXx2UxWCQcDJXFUThmEiC1tE8sUhBe5m+
	 3rbPNDfqL6HTQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 4/5] lib/fonts: Add font_glyph_cursor() helper
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: linux-serial@vger.kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20261005133335.344302-5-tzimmermann@suse.de>
References: <20261005133335.344302-1-tzimmermann@suse.de>
 <20261005133335.344302-5-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 05 Oct 2026 13:40:13 +0000
Message-Id: <20261005134013.61F1E1F000FF@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261005133335.3443=
02-1-tzimmermann@suse.de?part=3D4

