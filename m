Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00644282F18
	for <linux-serial@vger.kernel.org>; Sat, 26 Sep 2026 16:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790441216; cv=none; b=Xe+73rMEQqFMQtcSgRxdlb7fU2WOLvJ9sB8d9tFPq3600oNA9dIDcA76ZrShPf+ZtVQtWEpeMMgcOJawIXrIruJpb5SYFDtuXviGEavKs6ekg5aI1EqeUpQRDBfRfSJYOEH9WXr54a7WfgLXY6YWCPjo1E3SNsSFpsS9v3baIj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790441216; c=relaxed/simple;
	bh=ysE8qLtPt2mKpnM3M//R5puNoBAXJfAW/4EwgO4h8EY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=S3qjgKZ+AZmVfwcI+Jjz+yNWwWspXxXbVdmU3htxdAgQbswFZkDGD5On/nupsjW4k/eGTIfpThZdv9SsxpiA9dcZ+emcY6MtOOTwFzPv25ATVxUBypz4ZpF2EBfYwChszi03FIk0pqlAozpFTJKYuXJUUeBI8FBAN/W/w+Us5bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YSLzPeUI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YSLzPeUI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43A501F000FF;
	Sat, 26 Sep 2026 16:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790441214;
	bh=kzghiEOqotEBsvtamnoCFY0q6EB+zdoGq+i0HJj4Op8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YSLzPeUIxQVLrAt4eYNafg88M9VURYnCNHHOZYgs891QvWIIab+H+JosiQDGZgY+u
	 hGsdgFGqlFV4Yms4B7s2ainxMLT38s5/h8VCtjHDFaksJ6KURynzB7uKiSvkN+WPoa
	 a6sn7bxsc7xc+Pxlz+ulIIc+ZWMGeqfAivvjgvYWT+IuvqSBy7ojWSG0yiG/QJ2pB/
	 oeRi4zyMjPXTdNO4+bgsiJ9f7quCdnLkwoYC7efmGFwa7G3dGnFWJA5zcChX08hKDF
	 QrkcDzbtaBhhAhBQBawdOtw0q0Zhvbbjf+T61FNnlW5cAnX7fOLFJz/965x0IVXHph
	 MVa2EPpaMNQrg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/5] rust: mem: add DropGuard
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mohamed Osama" <mohamed.osama189110@gmail.com>
Cc: gary@garyguo.net, ojeda@kernel.org, linux-serial@vger.kernel.org
In-Reply-To: <20260926163551.52371-3-mohamed.osama189110@gmail.com>
References: <20260926163551.52371-1-mohamed.osama189110@gmail.com>
 <20260926163551.52371-3-mohamed.osama189110@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 26 Sep 2026 16:46:53 +0000
Message-Id: <20260926164654.43A501F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] rust: DropGuard duplicates ScopeGuard without justification
- [Low] rust: vertical import style violation in mem.rs
--

commit 5eee6691ffc9502aec33891dcbc8c9eb698eb03a
Author: Mohamed Osama <mohamed.osama189110@gmail.com>

rust: mem: add DropGuard

This commit introduces DropGuard to the Rust kernel memory module to run a
cleanup callback upon dropping. It provides a scope guard API that includes
a dismiss method to take ownership without running the cleanup.

> diff --git a/rust/kernel/mem.rs b/rust/kernel/mem.rs
> index f2d4cdf87d00b..17807c8e67ac0 100644
> --- a/rust/kernel/mem.rs
> +++ b/rust/kernel/mem.rs
> @@ -4,6 +4,95 @@
> =20
>  use crate::prelude::*;
> =20
> +use core::{
> +    mem::ManuallyDrop,
> +    ops::{Deref, DerefMut},
> +};

[Severity: Low]
Is this a regression in code style? The Rust subsystem guide requires one
import per line without nested braces for non-vendored crates, but nested
groups are used here for the core module imports.

> +
> +/// Wraps a value and runs a closure when dropped.
> +///
> +/// This is useful for running cleanup code when leaving a scope.
> +///
> +/// The [`DropGuard::dismiss`] function can be used to take ownership of=
 the wrapped
> +/// value without running the cleanup function.
> +#[doc(alias =3D "ScopeGuard")]
> +#[doc(alias =3D "defer")]
> +pub struct DropGuard<T, F>
> +where
> +    F: FnOnce(T),

[Severity: Medium]
Does this introduce an API regression by duplicating the functionality of t=
he
existing kernel::types::ScopeGuard? Both handle scope guarding via closures
and provide a dismiss method.

The commit message mentions an upstream Rust DropGuard interface, but this
does not seem to exist in standard Rust. If the intention is to avoid Option
overhead in ScopeGuard by using ManuallyDrop, could the existing ScopeGuard
be refactored instead to prevent unnecessary code duplication and API
fragmentation?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260926163551.5237=
1-1-mohamed.osama189110@gmail.com?part=3D2
