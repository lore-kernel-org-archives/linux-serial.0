Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D4D2F12A1
	for <linux-serial@vger.kernel.org>; Sat, 26 Sep 2026 16:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790440952; cv=none; b=bDMXX2Ybh6PlyM77pistE9V7WuYQYVaeR1NUPlXS36X0V3dpdEXLvxhFouiv/PGkGVshb1j3D9UDUEkd0QiAPM21PFnbMGfQFHU/JBtZgARE/n/XPIMy4Bb25thM7hFJVlrTVvBpljrACvxLOd7IZKio84tB8OmFmh2/nWk/Jp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790440952; c=relaxed/simple;
	bh=UoZmDgjrNHnp9Q20o1HxBv9t/WMYIoCZT1u6WeavFRM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Q+9cYXh+QgfCuilz6pLOhD76b4hLJlzwFBVyfucCVvfN0rw8hwobtj9xyIDPNbjiDsdnEyOwMN5/5uoYy1qSjlNwXg5Vm/BDyVkY3nK9G+phDiC/lJQ8NvPb/pvT/zV9lbzTW38o2O+Xyn7mvWFVfFlybX2cbXJilUS6ldMN3uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l0WHy6LJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l0WHy6LJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E62A01F000FF;
	Sat, 26 Sep 2026 16:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790440951;
	bh=cubAV5cO7eAMnAKB0DmbDWK4VHr6c7S6Z8/VV+BkDqI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=l0WHy6LJtzBR171DqwsrR6X41myTYkRuFniX4dTMKRBkrwmc4TBqsIg7y0FCDvn8S
	 cDUuK/zeYhRpJIyNo+YgbVnjUYoPYN3/FHmKkTHNA3Prj3PAiH2lDFtGC2fdabA7/7
	 QElrij+g/Aiol6pC5o+VVpX+wvhAb1hrrBqNihNgm/LvAWeSUnK9J5oPoUTPZ86kXe
	 /JtKFV7c2M5O+/n3zeCXfPgj6KakRObyCO3g64UDYlhkDCAiARkq+Rysg4K5Hf3fju
	 pqodCVcpai7bA5hngFPnIDuTH6HgK5xF8zNTQD58S8xlLf3YbW28dOxcAqXMur64iO
	 yZeHasQ+TvBLA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] serial: 8250: Fix section mismatch with
 CONFIG_MODULES=n
Reply-To: sashiko-reviews@lists.linux.dev
To: "Danish Khateeb" <danishkhateeb03@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20260926163506.487201-1-danishkhateeb03@gmail.com>
References: <20260926163506.487201-1-danishkhateeb03@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 26 Sep 2026 16:42:30 +0000
Message-Id: <20260926164230.E62A01F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> Without CONFIG_MODULES, __init_or_module means __init, so
> serial8250_pnp_exit() and serial8250_hub6_exit() end up in .init.text.
> They are also called from serial8250_exit(), which is __exit, and
> modpost warns:
>=20
>   WARNING: modpost: vmlinux: section mismatch in reference: serial8250_ex=
it+0x2a (section: .exit.text) -> serial8250_pnp_exit (section: .init.text)
>=20
> The exit code never runs in such a kernel, so nothing breaks at runtime.
> But a function that is called from both __init and __exit code can't
> carry either annotation, so drop it.
>=20
> Fixes: a300273c458c ("serial: 8250: hub6: Add cleanup code")
> Fixes: 4cf187f9dea9 ("serial: 8250: pnp: Annotate init and exit functions=
 for conditional discarding")
> Assisted-by: LLM
> Signed-off-by: Danish Khateeb <danishkhateeb03@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260926163506.4872=
01-1-danishkhateeb03@gmail.com?part=3D1

