Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5672489863
	for <linux-serial@vger.kernel.org>; Mon,  5 Oct 2026 13:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791207324; cv=none; b=BlkPS/Rh7SXCUExv2+EnPS1WdIKSLaFliB0QUbwHfb5s7Vu9jweOV3eTMgk/Qh+F+xm59ObT7tzvw161CI17gy9Pj9b9m+aIs9dMmZL/md9MEwpacAmiQzkgQXENZN98x/PrtnIGCXThC6upkbf3zaqt1IPnx8nJol3EVwbvDEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791207324; c=relaxed/simple;
	bh=drDTHZXJJjUYfOxaT94bjl7XeRp11f4RZ7YY4F2GMig=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HQfZH4tpsE7/NjdDkBTYEWg0WAnDfB7uR19gDZY2kbXjYtiSmO9ggb0QPAuU2XIg14zFr9mztvNX6PjG2QhYwy6tLJvs5m/gd8sBqSbyMU0E5jS6sfwms51VLHI/RwcymuUoekzeMPo/4uV9dEPmFfRYcDaNwmPTjZtLD8AlDPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TvKeMfOu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TvKeMfOu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FB781F000FF;
	Mon,  5 Oct 2026 13:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791207322;
	bh=drDTHZXJJjUYfOxaT94bjl7XeRp11f4RZ7YY4F2GMig=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TvKeMfOugFVoJ11748OnUQ4r18JWCxu3BnrnkSsfL6T53aSo96W0wNmtcIwtKssUf
	 R0xu6HRwpjxs58IfzM0qM8BMKUIFPnABLOZYVi4o4wEF56LBZjpoJZJRbcZziozFoI
	 WNWNTYA1oOilUKSlMNvU1Wg3GRp877xtmh/5RYCRFNibyvWhc5UTUowYI0hbKdMPp3
	 7qs0I/hkodIx6UyNtTbMIkajQDRXnjHCBuuJiyA0jJaEWJCEAqnSAa5VWEwE03rtq8
	 dqmmms6GoW/lvHfJN8irz2FFo+R68sQGapf30Qw64UHcmM7nS620T2Nb2Fhd/xLe/S
	 AyxLlELm9Zx7Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/5] vgacon: Remove trailing whitespaces
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org, linux-serial@vger.kernel.org
In-Reply-To: <20261005133335.344302-3-tzimmermann@suse.de>
References: <20261005133335.344302-1-tzimmermann@suse.de>
 <20261005133335.344302-3-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 05 Oct 2026 13:35:21 +0000
Message-Id: <20261005133522.4FB781F000FF@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261005133335.3443=
02-1-tzimmermann@suse.de?part=3D2

