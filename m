Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E8335C684
	for <linux-serial@vger.kernel.org>; Sat, 26 Sep 2026 17:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790444374; cv=none; b=n2NLPirB/fPW/1lxQB8qVQGjxs7Y0Pw8MrOSBTmB76l/KFw3DToWcNMoYPCEAcpkpr22luJbTbUUmg+rRlElk1mpyR6xxBFhXSxQRM7Vv4cHVbbS037VrUyq5JpvmkVl5fWfyRT2hzPV5PPYNd52uVCwvXMeOMFG1Lle3k5IpBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790444374; c=relaxed/simple;
	bh=7MJGC3JuZSYPdJ3LXgG4Pk8gk/HLzcesZ3rQjiqdmj0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ll1jqWQbvBe4LkHmghiJ7TC4WtcQ+nEXHsrUgzZSm+aKAOFgjXJDW8ISD7CEDRcNcFLEEiZoYiiwtIsa5XyBjtn71esTBVdy0y1ZC2N8cNteRHzEKxQv2qKmKro7Kv54fTJ9/M3FdpmdxQFI50C7LxyuCyofRtiLdf9wpwVarjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GiI84qL8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GiI84qL8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC98D1F000FF;
	Sat, 26 Sep 2026 17:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790444373;
	bh=7MJGC3JuZSYPdJ3LXgG4Pk8gk/HLzcesZ3rQjiqdmj0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GiI84qL8MAc8rmvFyS2BwjOCqrHGrEVpWCtUjKaJJsUgAcb9h3cfDODDqkDgpwxDW
	 4xM0WLGZavfju0ZTMV0UEqgDQxPs+QSPGgVul4Ri/skAsO9GnNOLtKNvtk0cnM9/Ep
	 jHHxOeM/Jhj+1i99Xm27tNK3bGU2MpeyeLDBj3fFH/xB759q3+pfOxdecEqfKTtA3H
	 5nnlo8TJuizABorWxY4uQZ/bKGTrS+bd6o0XPsZyb8fbS/4qaaGW5c999ek+9EPgs1
	 FEiy0YEUZVOyjrreZdqP3FZWvmJdnoPy90Z5c8Xtsc/kgmd5hurbPNCaKNSHCWF/XX
	 0V/WCgnknnjBA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/5] rust: block: gen_disk: use DropGuard
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mohamed Osama" <mohamed.osama189110@gmail.com>
Cc: linux-serial@vger.kernel.org, ojeda@kernel.org, gary@garyguo.net
In-Reply-To: <20260926173315.56772-4-mohamed.osama189110@gmail.com>
References: <20260926173315.56772-1-mohamed.osama189110@gmail.com>
 <20260926173315.56772-4-mohamed.osama189110@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 26 Sep 2026 17:39:32 +0000
Message-Id: <20260926173932.AC98D1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> Replace the ScopeGuard instances in the Rust block layer generic disk
> implementation with DropGuard.
>=20
> DropGuard provides the same scope-exit cleanup behavior while using the
> new Rust kernel memory API.
>=20
> Signed-off-by: Mohamed Osama <mohamed.osama189110@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260926173315.5677=
2-1-mohamed.osama189110@gmail.com?part=3D3

