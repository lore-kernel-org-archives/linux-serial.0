Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F2314A7CBC
	for <linux-serial@vger.kernel.org>; Sun, 18 Oct 2026 13:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792331641; cv=none; b=tg598cjp09G7nl39RiqvbrypNJ7msiO+6hMuaYPa/OyYqpm9wj5Ro6THnDCyM28tsPz5AexUNqDoRg6+Uywt6Vm6xYDDCrazNHE8ruFepfjO6k7z8fnZJw354wySZhtuqwoeGhjGOiBgsL+Wuu7ycqjPJ0G0ZlwSNPSTHLJIs9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792331641; c=relaxed/simple;
	bh=vwEx2zimlIs57TH7GgWLdJdhfVB6bYXR7mhtnB75Le4=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=bSuXJ/XAgg1fzLPo+86rXKMl3Elkk9WYnSRq437lPMAe6jvQhucoyW02CVzpsXDN32/Uyhsiowilbkmhm+6mv5Ou8jky/2r2mSgzi6Wm6Ggb+YqS0VlASfeUEaH8YALkOudJV5lLc8KmL+6uqQHnQKljEGnNnEEHlaaOTwondeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=deSEtafC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="deSEtafC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1A191F000C4;
	Sun, 18 Oct 2026 13:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792331639;
	bh=vwEx2zimlIs57TH7GgWLdJdhfVB6bYXR7mhtnB75Le4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=deSEtafC6eeXZBbO8ZzkjilkVCobyInLuYCFyi+w6S2rvV/yM2KdewBYX5Q1V7UtT
	 05jdKmn5yqCrNcvpHG8Ogbx9yXb5nvgpESJiwALZ3mI33gpKMYnwnY/UGNpOeVTtGS
	 kCQGYtcMwhTHu+cEdGRHW/M+mhYDMUMl7L0Cc648sSUSuIjG1cXXGXEgjLWAilzPWd
	 LegpJ2ia43pDKFISaHPAFtcZUAT+ayj60C0U45KZO4FTstGP+/kSupCb4zKQtB7lHN
	 KsCEJdeGCS5IhadsJnh/Hn6H9bDNJmM9q30eJ8uwZQY+cB/vACT9VDzFPXRj+tg8GV
	 WlTPmZIuY+Afg==
Message-ID: <sashiko-outbox-176165@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 03/10] sparc64: avoid huge kernel PUD mappings with
 small hardware pages
Reply-To: sashiko-reviews@lists.linux.dev
To: "Magnus Lindholm" <linmag7@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261018134738.1016106-4-linmag7@gmail.com>
References: <20261018134738.1016106-1-linmag7@gmail.com>
 <20261018134738.1016106-4-linmag7@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 18 Oct 2026 13:53:59 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> The kernel PUD refill path merges virtual address bits 32:28 into a
> TTE, requiring hardware pages of at least 256MB. Sun4u instead selects
> 4MB pages, losing bits 27:22 when refilling a huge PUD. Sun4v also falls
> back to 4MB pages when neither 256MB nor 2GB pages are selected.
>=20
> Keep PMD mappings when the selected PUD encoding matches the small-page
> entry. The PMD refill path preserves the bits needed by the 4MB TTE;
> sun4v selections of 256MB or larger remain eligible for huge PUDs.
>=20
> Fixes: 0dd5b7b09e13 ("sparc64: Fix physical memory management regressions=
 with large max_phys_bits.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Magnus Lindholm <linmag7@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261018134738.1016=
106-1-linmag7@gmail.com?part=3D3

