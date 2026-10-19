Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7AB22E2852
	for <linux-serial@vger.kernel.org>; Mon, 19 Oct 2026 00:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792370521; cv=none; b=ejEqG4HBP43Ekldh17vGM6JkaN5m/CxzWNaez82DVsVOc8SgaadMnaa90rAGGnGyHnmzmTm46WSXuEeAAPXZcLbSRvtF804F8cKGeRCe42bQQTT9DZ0BUil/GnhMYNqC2q4OFB5EXMC0OVV2PlDtRooYv8tyGLz3PO4WCzsbhCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792370521; c=relaxed/simple;
	bh=gP+lPEJYGphKBukbWKGgx0a40gguz+B7NMR1+Tl2V7k=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=c7usiDlFBsD9D2U1fVAryQw+CJPukMRvpmCaoOPAhX04v3DFTWKeGv3U90FJcEB5UlA7H6aZljwC8ocfKiCVKj99nleg8fviolfigd3SrKVEBIzH/UunAplrDQ7JRmhgrvTEli3aFdvmeMtkb4orJJUHSCzwK+9C5QQOiyTEmds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=STdNODIz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="STdNODIz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BA971F000C4;
	Mon, 19 Oct 2026 00:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792370520;
	bh=gP+lPEJYGphKBukbWKGgx0a40gguz+B7NMR1+Tl2V7k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=STdNODIzWtPzkBvSGOjsCifx0aOj+WCrKawQrlCyWG2SYJ7B9ERgLzBhK1wTGmfpE
	 riZIs0GeFeP7gwiXozKNbBUALkiQK1X1SaENApfA5kYcPMsPP0+G2cIHlFf37BKqHm
	 /+qmFJdxgj31Zr/iTXPC78DCm8nugbCwYSmI0FM4FiUAUhko+7OeP9sE+DgZei8pYi
	 43bNTbLNyWZVO3q5lum18uzb/856dnNI2YUfcddIcTTcsIOpYU3hl3mHqWDTLuu/yw
	 s+ftscmc7NZR4XA1Gx1HMM8TkoPmqdEx2HZ/jEyfeFU/8fV4sZihy2khrxzjmNu/dE
	 6Pst2pM9KiK1g==
Message-ID: <sashiko-outbox-176468@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/8] dt-bindings: arm: mediatek: Add MT8163 Amazon Echo
 Dot (2016)
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ben Grisdale" <bengris32@protonmail.ch>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261019-arm64-initial-support-for-mediatek-mt8163-soc-v1-1-f2462b2d2437@protonmail.ch>
References: <20261019-arm64-initial-support-for-mediatek-mt8163-soc-v1-0-f2462b2d2437@protonmail.ch>
 <20261019-arm64-initial-support-for-mediatek-mt8163-soc-v1-1-f2462b2d2437@protonmail.ch>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 00:41:59 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> From: Ben Grisdale <bengris32@protonmail.ch>
>=20
> Add compatible strings for the MediaTek MT8163 SoC and the Amazon Echo
> Dot (2nd generation, 2016), codenamed "biscuit".
>=20
> Signed-off-by: Ben Grisdale <bengris32@protonmail.ch>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019-arm64-init=
ial-support-for-mediatek-mt8163-soc-v1-0-f2462b2d2437@protonmail.ch?part=3D1

