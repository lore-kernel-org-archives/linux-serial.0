Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45A04BCABE
	for <linux-serial@vger.kernel.org>; Thu, 27 Aug 2026 19:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787858557; cv=none; b=UqCtmYVTdizUJEIC/0kB70GMhGCBOy5t5uio3fVwj3ODkkmc3qlgCp4bdlOSwzEa4LEw+ujvi/bPIlZsETWe/EHvsBuK6dE3aB9HYOHbGJf1RNTq9N9yg5viSCBYkO2XmintT88wYckTVRPHfYXyXkcVqd5cSUbj5vRX1PLMtHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787858557; c=relaxed/simple;
	bh=Pi7StiO52nrIaJocR7894LKY4OJH0svOVSowFddPScA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FP7YB8hZlwQakL8i+eWvczzTW+X0fYQFBTDbtwOh2YnTNY8dmmTziNep/TLCiH+Mwr2Ew/gqybYu6I6+VmiilZOLg7lY5jeVsT5s+aMvu9+6j7pJdIfqUWYQXbmaKkGiF1cyAP6yLsidtXI+VHV0mtPPCwmV7bpIoB95gcN7WEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CpfH2Ji5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CpfH2Ji5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5AD41F000E9;
	Thu, 27 Aug 2026 19:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787858553;
	bh=Pi7StiO52nrIaJocR7894LKY4OJH0svOVSowFddPScA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CpfH2Ji5Zm0RlqvqvSUKyL9vLgz5sD5mqrS+xdNY61iIOmv+z4/axcYs4NQS8ny6e
	 j3Vjby/XZUQu7aznq9ajLxL7A5OgnAsrMvgPA0XMfFqA2aVl6JlwltphZ91tJ32sqM
	 ianOb3mNenoGPlBOWGS9eMLg9RSefe1CnxokXJcFDvlA/3okxf8f4r9F4oJMFmLIli
	 Ox3Grr/Ji6eAPKF3/GqbSHjM1e7304x5gFW+mvLvG/Wx5SPgponUYS35ixxN540xE1
	 SdBm9S63W/uB+KKugRZ3VgwkBsOf8WqTsnu7BfuEOnk3VSalqqjXZl1TDc6BbYF927
	 n7WR5sw06KleQ==
From: sashiko-bot@kernel.org
Subject: Re: [Patch 2/9]: Glyph size: Use GLYPH_SZ/HW rather than hardcoded
 2, 1
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alan Mackenzie" <acm@muc.de>
Cc: dri-devel@lists.freedesktop.org, linux-serial@vger.kernel.org
In-Reply-To: <apCFsX_JXJ9m3vpr@MAC.fritz.box>
References: <apCEDM2sWv_M354-@MAC.fritz.box>
 <apCFsX_JXJ9m3vpr@MAC.fritz.box>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 19:22:33 +0000
Message-Id: <20260827192233.A5AD41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

>=20
> vt: 32b glyph: 2. Use GLYPH_SZ, GLYPH_HW rather than hardcoded 2, 1.
>=20
> These #defines enable the console to be built for either 16-bit or
> 32-bit glyphs.
>=20
> Signed-off-by: Alan Mackenzie <acm@muc.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/apCEDM2sWv_M354-@MA=
C.fritz.box?part=3D2

