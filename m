Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2CE83A48E9
	for <linux-serial@vger.kernel.org>; Thu, 17 Sep 2026 16:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789661041; cv=none; b=XzwBVXUNDxyMTROeqjBz2el5H/Wt1fCQR7TSComuEnahTo1aQtxEYUwbkXbvT6KLj45r3EcpcMeubPaTVQM7wWDk21iBEpCdHaxnDoTv62BJiYcEAyg6RXQFjtD+Cp+pQhe9glzPpBhabeqQARHTpqNoGqZ8ySiZDAe8Oti+0hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789661041; c=relaxed/simple;
	bh=bnDgTnpr/1uvPOEni/TpHX03zgVRHbjyYjybL6+aR0Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=McZGg8FWcgDGrjgX3ejuto6cBUZ5Ay9Uys2wtEo1pR8g0VXQjsJNgNJ1vCUnNIzyF0pTdDLB+iQlahl8FSc/DgCxXvt0ZW0mrYIpEhj1h+tbWsUs/IoxBg2D2AmIJPq7cw9c+QSa4WHjrY/WGSvwFYpiRoMUMYbBK1SwG6d/jNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QgtYdNux; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QgtYdNux"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EAD41F00893;
	Thu, 17 Sep 2026 16:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789661040;
	bh=bnDgTnpr/1uvPOEni/TpHX03zgVRHbjyYjybL6+aR0Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QgtYdNuxsxKkuLphJcFAD4RtOVviuo1u5NVceCiBq19IxLdJRp6vyLsgU1h6IlXc2
	 gQtncHg4a+F/sAheIA61kYGlFD7mOW/bwwxctFCTGRTe8dLYMteAEDk6vyTdq0JvbQ
	 VkCvnbUWVLWwBxL+bJmYGjJbkoTfR+Ptgtx7ETYjt/93EFAldBxIOfXVjRgct39ajL
	 93y/UKTmDvMI5Eszi85m65JKXwRbZlrbPgzJe2Pc9ExZVKueoYcYo3OK1cfkXaqC4/
	 yzalhdAsNajNaRei5msFeoYuSZlEAIXM50zv4YC+lqvEXrBWDj5z9w9MA9Xhts2MTc
	 UYwCT4fWtN2jw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] serial: ma35d1: Fix clock reference leak in
 ma35d1serial_probe()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wentao Liang" <vulab@iscas.ac.cn>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20260917155650.2161274-1-vulab@iscas.ac.cn>
References: <20260917155650.2161274-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 16:03:59 +0000
Message-Id: <20260917160400.5EAD41F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> of_clk_get() returns a clock with a reference that has to be released
> with clk_put(). ma35d1serial_probe() never does that, so the reference
> is leaked on the probe error paths and also when the port is removed.
>=20
> Release it on the error paths and in ma35d1serial_remove().
>=20
> Fixes: 930cbf92db01 ("tty: serial: Add Nuvoton ma35d1 serial driver suppo=
rt")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917155650.2161=
274-1-vulab@iscas.ac.cn?part=3D1

