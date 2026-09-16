Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDBEA3890E4
	for <linux-serial@vger.kernel.org>; Wed, 16 Sep 2026 10:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789553773; cv=none; b=ONTmTVK3j6szTLqH05BpHZAjbE1QDqi9TN0qomESTYda8uNM1gI4e5Z++Lpo3SotcXwnaEjnBQB4Kv8jyAoHQjYWwST5FKKDIs6BC6fisa6vnwgrr5VS+eeenA4TByqdrAg+kPU9GRAxPTCxsWqzGRjVtmKS73jUwH+eFIzqsr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789553773; c=relaxed/simple;
	bh=eRNQFUSTmekSmw5u+gpfCQ0J7f30TbGffowY+XextZY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XLZ76xYpD+gt/fbA8Azv9NcIajaB5ztwICOhgvVY1vpVgM05KKKYNe5eN7Y0sZviq5oN4eMSuD8jJlK9UhuhiXRrV+qQ0xlZg2PdRYX/wYgyZXVDrxhAYsrfTgAp7gczbJBIResHtFv41kX6v3fxo17wHlC4ua1sxbdGbJ3UAlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RcVx4CbV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RcVx4CbV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23DC01F000FF;
	Wed, 16 Sep 2026 10:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789553757;
	bh=eRNQFUSTmekSmw5u+gpfCQ0J7f30TbGffowY+XextZY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RcVx4CbV/0pLU54jmDu5ZciBmsVxKwcRuSsERyelUF7wk88MnC51PDzOVnwyHNsQm
	 9prMh5oi0oaabsJMrQsdjCIuJWMZAJFJ2cCc9SEgpGzmwAUxMFCjkzRorPHHzU+pLE
	 sVyv3Tu2lrWKS5xVgGO8krq3DBs0OIPZ68WTO9KxMDzEsaZg1PoAVM+Z8AlEeK3W7t
	 sKon/MIbBSPQ7CbIcuUK8DszKNRJmRHKWCJGsrKh9M5UbXtL25x6SjOFGjmmLD5NrN
	 yTjh5oy9Fn2MODLqIVjZO2fr2q+yOxyI+6ndFs6HPxnqzKhpow1Al+rCW/IuvJA47r
	 MntrZb/FoNrRw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] rust: mem: add DropGuard
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mohamed Osama" <mohamed.osama189110@gmail.com>
Cc: gary@garyguo.net, linux-serial@vger.kernel.org, ojeda@kernel.org
In-Reply-To: <20260916100937.541933-1-mohamed.osama189110@gmail.com>
References: <20260916100937.541933-1-mohamed.osama189110@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 10:15:56 +0000
Message-Id: <20260916101557.23DC01F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> Add a `DropGuard` type to the Rust kernel memory module for running
> cleanup code when a scope is left.
>=20
> `DropGuard` runs a `FnOnce` callback when dropped and provides
> `dismiss()` to take the wrapped value without running the callback.
>=20
> Replace the current `ScopeGuard` users in `gen_disk`, `serdev`, and
> `sync::lock` with `DropGuard`. Keep `ScopeGuard` since it is still used
> elsewhere.
>=20
> Add KUnit tests for cleanup on drop and `dismiss()`.
>=20
> Tested with:
> - `make LLVM=3D1 -j$(nproc)`
> - KUnit: 8 tests passed
> - `make LLVM=3D1 rustfmtcheck`
> - `git diff --check`
> - `checkpatch.pl`
> - `make LLVM=3D1 rustdoc`
>=20
> Suggested-by: Gary Guo <gary@garyguo.net>
> Link: https://github.com/Rust-for-Linux/linux/issues/1255
> Signed-off-by: Mohamed Osama <mohamed.osama189110@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916100937.5419=
33-1-mohamed.osama189110@gmail.com?part=3D1

