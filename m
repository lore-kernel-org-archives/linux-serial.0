Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC7C39EF0A
	for <linux-serial@vger.kernel.org>; Sat,  3 Oct 2026 17:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791050180; cv=none; b=LEqoKhThH5htQjbPETIqUYZvkE7wuDpg72cNkC6ofAEoop1b/pu/Zv2ZmOav2iwAohYkv/dKLUlX0S3GakhKepRptiIUZdtpZvIr0RtiABGOSLvkcOKSHyC9gFVFz8xBib0c2LbHi6N+QD0BKk/1cL5juVUtGGUXOO91KgDfxZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791050180; c=relaxed/simple;
	bh=3byUJSO70jvNCJgGshnzjP5Bnzxo9ss2H2zLfkRbgrU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CF2GCgFlY2Hu+XQiRW4d2cBWYcBdQ+yJH3zFdYpzWUdwb4GPW6fn0DYXNi+lS4eGF1e3Z3ZtWcQ6jSa7DxaQbShiUiYyWEjue791+xF2w5+vTXXYYEP1/phiITiZ+CBps/Kt1g9iie/5xdqaH55pX/bCBhfIg+mDzxXMoBUGv5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UK3knZ4d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UK3knZ4d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE5831F0089B;
	Sat,  3 Oct 2026 17:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791050178;
	bh=3byUJSO70jvNCJgGshnzjP5Bnzxo9ss2H2zLfkRbgrU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UK3knZ4dos4rs4HBS8K7el+px7ZFrGoDoe7rwoUyTn1g0qIwlO99cPyCNemf3e5fU
	 Haw4jq5ANjqCcc/vejkdRc1V74EtcMJ5bEy7vA+R52dmbV8ConuDvo3IfsU5j31yQi
	 V3rbdE9ITzPVF5co7YEFvmfwy+XG2ceCWtJEpFlscwxM9uRBpVpWLa9m94u8R7ai8u
	 3FjB6FxI/ePh7QvCg2DapV9UQIjKaTCH4T9OhahN8N6vx2NoLj0BlmqDK7Ikw10jSF
	 Wmq0UBnkpYRPdY7whn1qDi7R/LWYwSARzWsxpjTSsqKca62Nx8tZuS0W1gpyEJjTpR
	 9GCBIZTz5tpzA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 7/7] hvc: add an M3000 firmware console backend
Reply-To: sashiko-reviews@lists.linux.dev
To: "Magnus Lindholm" <linmag7@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261002161515.932316-8-linmag7@gmail.com>
References: <20261002161515.932316-1-linmag7@gmail.com>
 <20261002161515.932316-8-linmag7@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Oct 2026 17:56:18 +0000
Message-Id: <20261003175618.BE5831F0089B@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> Provide hvc0 through the IKKAKU Open Firmware pseudo-console, validating
> model and console properties before matching. Serialize firmware calls,
> keep the bounce buffer in locked mappings and poll input each open tick.
>=20
> Keep output buffers const and bound no-progress retries because HVC
> retries EAGAIN indefinitely. A stalled firmware call remains unbounded.
> Use the existing SPARC p1275 interface and HVC output contract.
>=20
> Signed-off-by: Magnus Lindholm <linmag7@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261002161515.9323=
16-1-linmag7@gmail.com?part=3D7

