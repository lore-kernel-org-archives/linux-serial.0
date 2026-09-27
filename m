Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391453BB9E0
	for <linux-serial@vger.kernel.org>; Sun, 27 Sep 2026 10:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790506314; cv=none; b=Ac+WN4NvxxSkIc9IVCnjMSzgBrkx3HG1Rw0RgsKp7F3T5ASjiRr+ASsNOrVvGCKDfTAjk5xhY2dB2wv2KbsfPaLIZmUcBBuXuv2XEw1ayyxtfHZfOrfXIc50ET1xQ+6NR0HlcolK3cG7PI3s72wvxeeh21LjN3/CKDnx40RtCHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790506314; c=relaxed/simple;
	bh=1mM0w2usnsASH1x398jcZJi/IOPT5ciipDAetRPBPI8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=h2VDNmdErc9aIrJhjaNYNF2UptSE8Kz3bii4lBHtrQnpKpDCdnZlDdrwm58WS8m+EYHYw0vZWyPkKcvq/F30N/UBlA4pLpri4LR3y6QtCacLZiw4V64ocolK0jlgpgNW2+accfCQWQq9yOA1sU0UgK4HAHRF/CdugnZn+CfWEBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WbTNTOVR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WbTNTOVR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F08C1F000FF;
	Sun, 27 Sep 2026 10:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790506312;
	bh=fydeYH6lGSVS256s2+vHf9eVI+qfokZ8tydMXKCUWGg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WbTNTOVRy1ui0nKsm9gV97eDLTWwGwWrgjxPVFYULiR8zqQ+Os7vl4Q6TkykGOVK3
	 +zWWX1KHDI/kQTEhq1ImNoehVxSfpGuvfvKLBpSTQQojqjVdZ4ob2s/w4/8BxEdZLf
	 9b1G/VF3h7J7pOm2mt3HXiz9obaO5bKthRKvSVTPlAw3bbexXjJshNpPJQtx4ULPdN
	 w5FCdI8g9CsDmSWYKqy9VRHOYm/iDc5Pft1LNYenIbUaZJe8euO/vN+u7i/juf992X
	 udc5ArO/dOkpeBCgEb+s8nZWXfFtIT0nqnGzpqjbH+XXbYeeWpw+1+kR1oNErB30yO
	 2J82pEgVcU9NQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/4] rust: sync: lock: use DropGuard
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mohamed Osama" <mohamed.osama189110@gmail.com>
Cc: gary@garyguo.net, linux-serial@vger.kernel.org, ojeda@kernel.org
In-Reply-To: <20260927104528.103881-5-mohamed.osama189110@gmail.com>
References: <20260927104528.103881-1-mohamed.osama189110@gmail.com>
 <20260927104528.103881-5-mohamed.osama189110@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 27 Sep 2026 10:51:52 +0000
Message-Id: <20260927105152.8F08C1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] rust: sync: horizontal import style used in touched import block
--

commit 67d0667c81a937f6d37a9c9023076060bd4316d7
Author: Mohamed Osama <mohamed.osama189110@gmail.com>

rust: sync: lock: use DropGuard

Replace the ScopeGuard usage in the Rust locking implementation with DropGu=
ard.
The guard preserves the existing scope-exit cleanup behavior while using the
DropGuard API from the Rust kernel memory module.

> diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
> --- a/rust/kernel/sync/lock.rs
> +++ b/rust/kernel/sync/lock.rs
> @@ -7,8 +7,9 @@
> =20
>  use super::LockClassKey;
>  use crate::{
> +    mem::DropGuard,
>      str::{CStr, CStrExt as _},
> -    types::{NotThreadSafe, Opaque, ScopeGuard},
> +    types::{NotThreadSafe, Opaque},

[Severity: Low]
This isn't a bug, but since this patch modifies the import block here,
shouldn't it be updated to follow the kernel vertical import style?=20

The modified crate::types import leaves the items grouped horizontally
instead of formatting them vertically with one item per line.

>  };

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260927104528.1038=
81-1-mohamed.osama189110@gmail.com?part=3D4
