Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1768754707C
	for <linux-serial@vger.kernel.org>; Sat, 26 Sep 2026 16:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790440906; cv=none; b=sm7dqtkdMoXgVUrD5vxCIh27D9Lu4J0jijs4QAZhgiRWv+2h2Gqh8POJ/2yJBsA9xwS9oMNBtB6OqmsceogiNzGS5X/DzI+n0RCp1bclmdH9BHbb0EI+5ebnRX/SVT0hgSAgdd02eyhySXrsh9aWUtppaYjeK/OwlmBDnrz6do4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790440906; c=relaxed/simple;
	bh=req598AxhlDMdhJsMtAp+L1LerewbavlNSX7NBesgEg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WvP3QgoJucuOJTOCFTMVN90O+R4lSBfT4Jk1TP/j6Ur5d6oG9Vign5JvQ3xkBiHt8hUA1IEBQQ8YhhZjpwKMpWdDr9ResRICl/bydOpxGFECI6o+AYpJqX8/Sc2POcdwgpFFfTMZ8UD1DkwOBFQhesBgXfXhsOnzDCFb6KvubRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UvcJWd8K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UvcJWd8K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34E6B1F000FF;
	Sat, 26 Sep 2026 16:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790440904;
	bh=req598AxhlDMdhJsMtAp+L1LerewbavlNSX7NBesgEg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UvcJWd8K6VUvfpjap78ped3qaTbWNbkeEJBPmzae9DcZZi4OKhsfs6FoDW4TI50ik
	 eI252DpnflOe8/PH9330VH3RbMFsflZHuwvt9R7Hfe8rHncd2tXPEDZYLyfEpnv5kl
	 fvzyLNHEfxUFdnpc9eGyYrhxd9YFpFOdF175GuyirWYBLWoPKNyxwUEIXT4Xna92MU
	 wmG7M8nvhpxMpPSkIsHpWBuA9dxJ3xPo73oS4GjuYsNg2Cc6mEfC1yzJseqx95/xiK
	 24dLoR4iyeMXmGVZIQThkLBLYxQoq1NtxSAqvcB0z343kQNNDoq090O3836PKQpsaC
	 nAuQn4xctGUDA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/5] rust: serdev: use DropGuard
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mohamed Osama" <mohamed.osama189110@gmail.com>
Cc: gary@garyguo.net, linux-serial@vger.kernel.org, ojeda@kernel.org
In-Reply-To: <20260926163551.52371-5-mohamed.osama189110@gmail.com>
References: <20260926163551.52371-1-mohamed.osama189110@gmail.com>
 <20260926163551.52371-5-mohamed.osama189110@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 26 Sep 2026 16:41:43 +0000
Message-Id: <20260926164144.34E6B1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> Replace the ScopeGuard usage in the serial device bus implementation
> with DropGuard.
>=20
> Use DropGuard::dismiss() when ownership of the private data needs to be
> transferred without running the cleanup callback.
>=20
> Signed-off-by: Mohamed Osama <mohamed.osama189110@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260926163551.5237=
1-1-mohamed.osama189110@gmail.com?part=3D4

