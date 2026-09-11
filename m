Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F284355F2A
	for <linux-serial@vger.kernel.org>; Fri, 11 Sep 2026 09:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789120325; cv=none; b=gJOMvT3uWCwSrdZ+hqJ5V9fnGO1oigqAsxIrZFOrj6cue5GM3lA5TpfFAQrAgz0gqp0Yp4hkszix4fBImgNokYznI+e5edTWJhbv/xLTm5gMIkI3vUAJrqjbP63Sp1TmC4oi7huD9nSlN8XzXWL0GugifdeyUSg+DrMuvmToqfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789120325; c=relaxed/simple;
	bh=nXsrkjWE4prBXa8s2vKEcY8Cn5cG+6IhnDl61E18dFw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VN5VjEmYo0mGYLpF4kHKALTEuIpUB5elIYAYy18ZMdtkhimNZKo7lveSmhreKumUELQaYR1JcLn8dZaGa4A5AuGvEzOngbNFlLO3lfnTctiJKpOEe9NMv8gedoOHGj/pfmlpxab8e6Cv4k7A38RikXKwgGR2yJGvfjYBL7F1u8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=McH4wbd6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="McH4wbd6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F32891F000FF;
	Fri, 11 Sep 2026 09:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789120324;
	bh=nXsrkjWE4prBXa8s2vKEcY8Cn5cG+6IhnDl61E18dFw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=McH4wbd6Z+QSsKyHkcw/C/St3nLTsYwvseou4LBFRX7kySVZPlxDhynpZrncqFgdi
	 e2xeOAGaiCBMkiRjGjtGf2BF98HlOpzCdx/o+Pn3aLqF3cKMeqHW+pYNKAZHzsm2G8
	 oDPVnOfiHfbbnIoECGv6MU3H1Rjh2aJhjFLmPlP8VIV8Nk2afyfcHCCDTJC4XxcdUz
	 4lEcK/9J/qw8hDGDgqFJcOqRvODt+8rz8z2kss5w3DaWufvFb1XhMKN+DFJan//H8R
	 z+u8mGt5M5h70J79+1myGHYJ5wGJcUBG6oESHpPN+tH6YLreZaWTSlRAo4aZ8+3b/J
	 bbU2Xe09NdMog==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/5] lib/fonts: Add font_glyph_cursor() helper
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: linux-serial@vger.kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260911094518.78093-5-tzimmermann@suse.de>
References: <20260911094518.78093-1-tzimmermann@suse.de>
 <20260911094518.78093-5-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 09:52:03 +0000
Message-Id: <20260911095203.F32891F000FF@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911094518.7809=
3-1-tzimmermann@suse.de?part=3D4

