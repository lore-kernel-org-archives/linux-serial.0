Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2344E3BB9E0
	for <linux-serial@vger.kernel.org>; Sun, 27 Sep 2026 10:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790506380; cv=none; b=mY5GmXlR757TfiUKRtp07u959+nsfc/HQ9U1HZNtNO1649k7j7l9BDHyLXa4qL/V0EcpwEhqB47moWMUXq43jWMVyntipsc/46Egs8rklze8q5nE8RWzOakqJLE9+yQus3pplsHpVsQazsDRlJQd1xB/krZqxOn3nBJ++2GwjZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790506380; c=relaxed/simple;
	bh=ybJ9czVzv72vXJsp07MJHyLrCo5DMj9B+PnTp3OXpNY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VsoequdsB1cszxaSwtHmNgQJ+YqR/w0PfBF7y6EYRA1cvraYtNSojakzCxu9Aul52ly4pOeYcD9Obh0VDX+byJHVV898EB0VSWk6rBEeCs03vwjHXrjMMQJdsHTbAjozUSUsqPE5eQcC+bSm2ZvbkVIXelcGtbwxG9kt5lJ8moc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jBXQvwcL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jBXQvwcL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D8631F000FF;
	Sun, 27 Sep 2026 10:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790506378;
	bh=xB6rvmAw5bHQBt2FyC7uPTpV2dCx5kWtbPBstfuzAsE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jBXQvwcL8xilnG9FGzl8heHeePu6Db8947KsjIWqnNO8g804js6KVz28dp4smNCmg
	 btXexDQTss2nRgzYJOlodJjf/4YMP51k4cUvhQI7kE5TEKj5HsJFa3e/SWvbdPqs0a
	 f+zzWmcQwfEebbkZBqT9sJEfNvehk4v+NV849jFkUs5eWNQsPuAIEm6padTXfunkTT
	 Ux1Jr5boioWjraFBrcdXSWF106lttoNcFpMqAnDCz0E29gvYtrt1gDh6GLEmRCKraG
	 RseF2aq2Z+esEGl+HZUwe2aprhTnvfg08gWeid9qtHp+qf99icdrN+XDsxULIvvRGv
	 QqfMZer3HY2Ng==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/4] rust: mem: add DropGuard
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mohamed Osama" <mohamed.osama189110@gmail.com>
Cc: ojeda@kernel.org, gary@garyguo.net, linux-serial@vger.kernel.org
In-Reply-To: <20260927104528.103881-2-mohamed.osama189110@gmail.com>
References: <20260927104528.103881-1-mohamed.osama189110@gmail.com>
 <20260927104528.103881-2-mohamed.osama189110@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 27 Sep 2026 10:52:57 +0000
Message-Id: <20260927105258.5D8631F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] rust: import does not follow vertical import style
--

commit 4ef060000d9f83c4c9fca329ddeac4824d4432ca
Author: Mohamed Osama <mohamed.osama189110@gmail.com>

rust: mem: add DropGuard

Vendor DropGuard from the Rust standard library and re-export it
from kernel::mem.

> diff --git a/rust/kernel/std_vendor.rs b/rust/kernel/std_vendor.rs
> index abbab5050cc50..21a26b4eec71c 100644
> --- a/rust/kernel/std_vendor.rs
> +++ b/rust/kernel/std_vendor.rs
> @@ -7,6 +7,9 @@
>  //! "Apache-2.0 OR MIT" and adapted for kernel use. For copyright detail=
s,
>  //! see <https://github.com/rust-lang/rust/blob/master/COPYRIGHT>.
> =20
> +use core::mem::ManuallyDrop;
> +use core::ops::{Deref, DerefMut};

[Severity: Low]
This isn't a bug, but does this import follow the vertical import style?

The kernel coding guidelines specify that when braces are used for importing
multiple items from the same module, each item must go on its own line.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260927104528.1038=
81-1-mohamed.osama189110@gmail.com?part=3D1
