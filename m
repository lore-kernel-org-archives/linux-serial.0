Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB45455607
	for <linux-serial@vger.kernel.org>; Tue, 13 Oct 2026 03:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791863653; cv=none; b=lMCqL1YWUY2FXWQ9dVJavDvwMQZd0qPhvsAcRFntMYTy+keCp7p93G6TqxRwt09sQYjEnUPL7U7T7Yxu4ZFPy3HsphGAmyJ42X4C6SwkSq76ag9etAldGx2XaZ9LuIpbjgnzov1qf7Kxwc0NAyrMdIHtgXIkEh9HmRvcku725jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791863653; c=relaxed/simple;
	bh=MztuJ2vhs+bDjd7P8HX4MBwQZCeWSEXtFo+HFk/qKNE=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=I2+kcM6jNLxD6oxPdJbYvmc202e31JGoFfPX61MJXx+4NtYVRuBRmX8Xgf61w4z483x/kY5wGJ4xMvF/VaCrV0oR/JZKeonHl8tUeEkN/pGj62fIQaUr8ZRmFex/WQs5775Q//oPohIHka8MmwjdCkDVCcxKLbvi/jsW+wuqyhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DHFEX533; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DHFEX533"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39F7A1F000FF;
	Tue, 13 Oct 2026 03:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791863651;
	bh=MztuJ2vhs+bDjd7P8HX4MBwQZCeWSEXtFo+HFk/qKNE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DHFEX533Nbgaq26k6JeLup0qfsDv7UueL+9DXYiL/S2q56dUwqXmjLG0kDLNgNLrb
	 0EQGds7tA3IjZCau8ZaTpux+tyYaO8aoPPqQnB0drVIH4SduRNyzZq+rzt/x+A04Np
	 yTZ+msyyxWoSvlRelJv5vaGq/xHS0vYH7j4w+e+8tktfpS6Im4AXPAYX9TV3SGQZAa
	 3gZOwIZh1+Bi1nuAzFs53Na8FBKZV2rcQAGIWYV0eqYZ+5iFTOVB7Chwcayv6y3tE5
	 /sN5tipjtEAaXl/xN33FSpw5d5Kzw4tSEYrWh/HfsFTAzPnBb3yk0PPs1qrIDAuWe0
	 R4VXqBPXNPBRw==
Message-ID: <sashiko-outbox-168934@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 09/10] ARM: multi_v7_defconfig: Enable Cortina
 Systems CS75xx support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fil Dunsky" <filipp.dunsky@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261013-b4-cs75xx-v5-9-4e72aa383d39@gmail.com>
References: <20261013-b4-cs75xx-v5-0-4e72aa383d39@gmail.com>
 <20261013-b4-cs75xx-v5-9-4e72aa383d39@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 03:54:10 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> From: Fil Dunsky <filipp.dunsky@gmail.com>
>=20
> Enable the Cortina Systems CS75xx platform and its UART driver with
> console support, as used on the Securifi Almond+ router.
>=20
> Reviewed-by: Linus Walleij <linusw@kernel.org>
> Signed-off-by: Fil Dunsky <filipp.dunsky@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013-b4-cs75xx-=
v5-0-4e72aa383d39@gmail.com?part=3D9

