Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC47A4963B0
	for <linux-serial@vger.kernel.org>; Tue, 13 Oct 2026 06:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791871755; cv=none; b=RGfTP0WtSeEgULBtOgFtH+cfJyXjrj4UMxuzS17vdBHs+wqcL1KcO6AmjKlvN8dDRf3o3Pxy7oeS38hk6eeq6HPLB3GMp8f708o/x/3mvDMW4lgJyy5xRAUyke189186qYVVfH2+Q7D5IEBo64nyhzC9dmteGODDrQioCpNwr4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791871755; c=relaxed/simple;
	bh=o41AOgLkIqjVKdu4EW9vYxHwArgtMNtxUnBqhDsCxds=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=GK62ZsPx4RcLDVAQgKTaPrzcLDgaSfqdVMnBo86FQ0+Bp8zBgcFz50jtG/cJcln7DexVavqIF6NJpml55xXYVfbgx8SEdOkqJf2ay+I3iz/8IpdzMFvuTYH7yMNkYCBRBMfn1rBVOSjY+LokMPN/YKHMbC5zsb8ICprybbO9gpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OG6Qfppp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OG6Qfppp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED2A21F00898;
	Tue, 13 Oct 2026 06:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791871752;
	bh=o41AOgLkIqjVKdu4EW9vYxHwArgtMNtxUnBqhDsCxds=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OG6Qfpppcj15f1sXRZGKYCZ4Ifbfnj1pemwNRFBzBC2Ou78GCUsjN294ItT0sSwMq
	 NIq9nPgSVLs2lwkN9u5K2fbMqb07i5W1h2PIGBvmsD4ino+B4DZeqy0uNfm+VeWpP3
	 dKaSUzY4bMOeuWny4eH4qabWGBAOl5dic9GnqErxm576/tDrPOxGAWDrWzB/OWGhHb
	 2SYC6mFxhty4U8UpE4RHvF1ro9s8VSzGApr+uNUpW/P2Rzm9BI+DmcV5X79b3F7Emp
	 rAFthgwcByhJT03XpCBfFrooCLuQTUlfgUY96r2OhOyvz5FxC3PIKJdJOHAKVWMhHq
	 NWkPD8VcRmerQ==
Message-ID: <sashiko-outbox-169036@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 01/10] dt-bindings: vendor-prefixes: Add Securifi
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fil Dunsky" <filipp.dunsky@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261013-b4-cs75xx-v6-1-37e8f3969b7c@gmail.com>
References: <20261013-b4-cs75xx-v6-0-37e8f3969b7c@gmail.com>
 <20261013-b4-cs75xx-v6-1-37e8f3969b7c@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 06:09:11 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> From: Fil Dunsky <filipp.dunsky@gmail.com>
>=20
> Securifi Ltd. makes the Almond series of touchscreen Wi-Fi routers.
> Add a vendor prefix for it.
>=20
> Reviewed-by: Linus Walleij <linusw@kernel.org>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Fil Dunsky <filipp.dunsky@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013-b4-cs75xx-=
v6-0-37e8f3969b7c@gmail.com?part=3D1

