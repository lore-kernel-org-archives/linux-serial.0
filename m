Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17AB4386C0A
	for <linux-serial@vger.kernel.org>; Sat, 26 Sep 2026 17:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790444565; cv=none; b=NxbEtxJN26swr6S/q47rlpqPE8NdXLdYsHMLO73U76TaTj3B/CqujucrBg7uASBSuFyXCcS7WzRGUNDT2QICqgHGGza73DsUyPzs6mMPdy0kvSs0tDll8XZDm4nvRqP5zxhjqfscDlZ3BFXbwmUQ+8ZkeUJML8fwQNmSGD+qDxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790444565; c=relaxed/simple;
	bh=8qoD2mCQ12+cpVO/l0Uwy474shrirm52OcAu8CkKKvo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IcOMfSTqamLecRKu/QfmeBkyd9JeXjnvFnz2SSH6sH089weyP6TALNvo+uiYL5KSmtEcFdhdc9WsusPxQbE3q6ridRYpBfzZAR9WS/7/ynpZfL58pao42KdDyzd37dAaAc+p2xRdjyJJ03MpwDBR7Mep/ik3fgXOrdo9uuJivKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lii7uunU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lii7uunU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97E7A1F000FF;
	Sat, 26 Sep 2026 17:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790444561;
	bh=CbgVAxwOHOmAIR20pVuwehbaih+KENjqvaY/z+tenIA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lii7uunUeCdqPnVQZqAgFwTQrtimXOPpTmw6o/ytfoXrvGmE6gbNMMF5RKuMJ1g6l
	 wxGvnsX9XSmLH+MeEKxxBj7qJuoYpmtf450ke9GrwuhrSVyNqcBScgibmdQRSk1yBJ
	 SiHlxhfl9RnM2sWduATHlUuagmbmmnOkdh/5p0zVlOpxXpGIp1YI7Cswz4FodWhkFx
	 Hj7niN7vpzZGLCgnyIv4sVY7LzoC8jdbGI2xmX8oYsC9iPxXobSN2G65icSrtJasj4
	 OGqxf+DzYrXIeAXpt2D6/KBYWpLvWSnbnkeV01My3q6U24KmdPxiVNSERNvooNk9va
	 5ti3gJHXIRX7g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/5] rust: mem: add DropGuard
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mohamed Osama" <mohamed.osama189110@gmail.com>
Cc: gary@garyguo.net, linux-serial@vger.kernel.org, ojeda@kernel.org
In-Reply-To: <20260926173315.56772-3-mohamed.osama189110@gmail.com>
References: <20260926173315.56772-1-mohamed.osama189110@gmail.com>
 <20260926173315.56772-3-mohamed.osama189110@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 26 Sep 2026 17:42:41 +0000
Message-Id: <20260926174241.97E7A1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] rust: vertical import style violation for core::ops
--

commit 14b3938196a8942ce3b9aa406f0d5ba59f964b6e
Author: Mohamed Osama <mohamed.osama189110@gmail.com>

rust: mem: add DropGuard

This commit adds DropGuard to the Rust kernel memory module to run a cleanup
callback when dropped, mirroring the upstream core::mem::DropGuard API. It
keeps ScopeGuard for existing users but establishes the new kernel API
alongside it.

> diff --git a/rust/kernel/mem.rs b/rust/kernel/mem.rs
> index f2d4cdf87d00b..e7a84d15f3b38 100644
> --- a/rust/kernel/mem.rs
> +++ b/rust/kernel/mem.rs
> @@ -4,6 +4,93 @@
> =20
>  use crate::prelude::*;
> =20
> +use core::mem::ManuallyDrop;
> +use core::ops::{Deref, DerefMut};

[Severity: Low]
This isn't a bug, but this import statement groups multiple items together,
failing to adhere to the kernel's vertical import style guidelines. Should
Deref and DerefMut be imported on separate lines?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260926173315.5677=
2-1-mohamed.osama189110@gmail.com?part=3D2
