Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792445009;
	b=LY4p5G9TYomh+I4UKmTJvk3wkZFWlqQrVkibp2oYvI22AtLlyCQ3C+iaN2CRLFh4xz/c
	 hcnfH2ZMPbQG3Ho1jSeHTuxRld9rrO/7smWLwOokOSRzzSsGfkPqltTmko4BvHE3gcak4
	 a0M5kas4OYP9WVQQmZ5wcpcknApTuHzzEr6z7OC8jKkGVfVgU6oOaU/J2TWq6kTEnhZx+
	 ZgdKGhuR2tPdgCA5gYIgMJUXGHeYWGKWGl62peCYmcUy6JAKzfxTo9mJKIRWaBT+yu92m
	 Bc5fQ0fwoxs0+vT3n80yr5puBrIXIP6cDdH8nl1DG3nbftAUe6ni0ytjr+XDU0I4lYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792445009;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ZZo7inmSxN+chCblHVLN1RZupufBZslF6Tl9KY2WSp0=;
	b=Ar1RDNc2kQhNhL4t0cRQvVSH/rSSVPsMUZEIZfjXEqLFmO1dnNMu+nIc/G3Of+IiNaUp
	 174+aHxxgW31nQEMczXwrI0Cq/0dLaJqcE3EiXPgqWNrBlrDqSB+Kl489y1RPFnEFmGeO
	 DOqd6f6TIyo0zjdqbfyfcWDdEQpJKTidWBLTQ/u9U6s1AN2BtIgT4QZ+2hTH0Pn2LZogH
	 Q2iEQ3totcb7WIrhmwvByn9AVuVVah97jC6PvuNz+mxNizQ8AwM6Dkk3wRGvPYlMIgF5j
	 C/jEXIJRsQ579dLxN5A/XV2nhe7diNtAIKHjNtXStOUPvsjsoLT9gcPdnT7WJEdmzWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e0+jXEOq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4AB5606A319
	for <linux-serial@vger.kernel.org>; Mon, 19 Oct 2026 21:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e0+jXEOq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FEC11F000C4;
	Mon, 19 Oct 2026 21:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792445008;
	bh=ZZo7inmSxN+chCblHVLN1RZupufBZslF6Tl9KY2WSp0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=e0+jXEOqJmX+5PxGp19XgyYehPWHpRjwuMtEgm88KUsmWbhs2LMuhHZT+57ZG49Id
	 GyhyTO3lVR/MZRUM9ZchVBSBQcVX/TXPgY9M3E5Wl07Z/ERdxcYrGIVy7v2jJ68J4l
	 UO9kXF3+jbb9TsTJ2bSpRTSdcXCcCXeK1Rus4x59XLub+NKSTm2b4ZCpx4py6CwiMu
	 YkNn9iNZo89Sf22adsoyF2MSDiTaJ9Zh07yFt90RuwJEbl6cyS5793k0Prr2D74eiU
	 TQ+JgonJrTbBbL/4jw2wc1GH7x04nViSAHzYLerK+Gtfktw71w0pYD8W+QAhjMDYty
	 PTO03dhYRp8Tg==
Message-ID: <sashiko-outbox-178251@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] vt: don't make VS16 widening depend on earlier
 screen contents
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nicolas Pitre" <nico@fluxnic.net>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <b777616c7a63920f36dd34a1ab96e95073d0b013.1792443833.git.npitre@baylibre.com>
References: <cover.1792443833.git.npitre@baylibre.com>
 <b777616c7a63920f36dd34a1ab96e95073d0b013.1792443833.git.npitre@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 21:23:27 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> From: Nicolas Pitre <npitre@baylibre.com>
>=20
> VS16 (U+FE0F) widens the preceding character only when that character
> can be found in the Unicode screen memory. But that memory is allocated
> on demand, when the first double-width character is displayed. Until
> then vc_uniscr_getc() returns 0 and the VS16 is ignored.
>=20
> The same sequence, e.g. U+203C U+FE0F, therefore takes one column on a
> console that hasn't displayed any double-width character yet, and two
> columns afterwards.
>=20
> Allocate the Unicode screen memory when a VS16 shows up so the
> preceding character is always available. vc_uniscr_check() populates
> it from the current screen content, which includes that character.
>=20
> Fixes: 95b05de0a566 ("vt: properly support zero-width Unicode code points=
")
> Assisted-by: LLM
> Signed-off-by: Nicolas Pitre <npitre@baylibre.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1792443833.gi=
t.npitre@baylibre.com?part=3D1

