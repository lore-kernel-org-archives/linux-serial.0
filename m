Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706E33B6BE8
	for <linux-serial@vger.kernel.org>; Mon, 31 Aug 2026 08:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788165607; cv=none; b=uDddQBg7E9y23zNy5OYiZCBlPelvHfXbB2QhnknTCL8j0LSOYscwrsDK5wvnQd85jZJ0V/U0FmNLKozlRFFb/6FnXtmt4G8qrOz41+a+Yc54W4t85xwSxpuFf91vrV1WQwzFzNoDC0B3kZZMC3S09dlJSDgt1hpC+oKc61q2+G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788165607; c=relaxed/simple;
	bh=a6EPY4mANlE93fsw6M13GJ+g7rMfWI7xdtF5yZnJznQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=R5RA5VYBSEe4tjuo5O9XUYAQut6SAH4rnZ5QkaDsrInMmFAORVa1xvmLb1c+8YmImxyJ/SVI/VfXg/y0APKlCoPnrQFPN4us8pX0oQQcKBF3Uy8+3M1PWT3htyn2uvCNQvunTaOHA2CpH2wuONzFqygSTbsIBNXGmbSP2lJ1FsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XFsP0WFc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XFsP0WFc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC0AC1F000E9;
	Mon, 31 Aug 2026 08:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788165606;
	bh=5RJIAD8NMuGMXbn9V/G2Ja859uw4ry6bn/0J4h0X/xc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XFsP0WFcGps43t3nGp1nYHaX6RpLEFjOait+RMS7cLTzrwXWa7sr+zGFOJFQkWTsF
	 nMfUn1ZSTV5HTInh+SSdka9AQW1eZfH4IM+il+SZGDb5ojG8koM2+8Tci45inNpiWK
	 iFdaubK88w2dKJI7xtMbjFmXglL9QUJvpmd6rMnu7YaMMlhYgw2sSpVZ4TK5ATX231
	 ewXYuznAnypJo6OcHAK7SNYwoKTRXr00mGRUbE+jUpfRbOzNXS9Qh0rG0taLmsY7jJ
	 5mWLnhJnifCVr+Ygork6VzKa39RAQTke0Wf0nHH4lYuYM6xpsQa3DQlEdmE1Wa5xOW
	 ootTtHXpxuxTg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/3] tty: hvcs: replace __get_free_page() with
 kmalloc()
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWlrZSBSYXBvcG9ydCAoTWljcm9zb2Z0KQ==?= <rppt@kernel.org>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20260831-tty-v2-3-88cd58c3c640@kernel.org>
References: <20260831-tty-v2-0-88cd58c3c640@kernel.org>
 <20260831-tty-v2-3-88cd58c3c640@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 08:40:05 +0000
Message-Id: <20260831084005.DC0AC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Failure in kthread_run leaves global variables dangling and pointi=
ng to an ERR_PTR, bypassing initialization checks on subsequent probes (lea=
ding to UAF) and causing a kernel panic on module unload.
--

commit b1538891a24d98413046b6d1a4fb966407282fe0
Author: Mike Rapoport (Microsoft) <rppt@kernel.org>

tty: hvcs: replace __get_free_page() with kmalloc()

This patch replaces the use of __get_free_page() and free_page() with
kmalloc() and kfree() respectively for the hvcs_pi_buff allocation. It
simplifies the API usage and removes the need for size tracking during
deallocation.

Link: https://lore.kernel.org/all/635405e4-9423-4a25-a6e7-e03c8ea0bcbe@redh=
at.com

> diff --git a/drivers/tty/hvc/hvcs.c b/drivers/tty/hvc/hvcs.c
> index d32b1e3c50bfd..b94d59fa36274 100644
> --- a/drivers/tty/hvc/hvcs.c
> +++ b/drivers/tty/hvc/hvcs.c
[ ... ]
> @@ -1486,7 +1486,7 @@ static int hvcs_initialize(void)
>  	return 0;
> =20
>  kthread_fail:
> -	free_page((unsigned long)hvcs_pi_buff);
> +	kfree(hvcs_pi_buff);

[Severity: High]
This isn't a bug introduced by this patch, but it looks like the error hand=
ling=20
here leaves global variables dangling.

If kthread_run() fails earlier in hvcs_initialize(), it returns an ERR_PTR=
=20
which is assigned to the global hvcs_task pointer. In this error path,=20
hvcs_pi_buff is freed, but neither hvcs_task nor hvcs_pi_buff are reset to=
=20
NULL.

Since hvcs_task is not NULL (it holds the ERR_PTR), a subsequent call to=20
hvcs_initialize() might bypass initialization:

	if (hvcs_task) {
		mutex_unlock(&hvcs_init_mutex);
		return 0;
	}

Could this lead to use-after-free bugs if later code tries to use the freed=
=20
hvcs_pi_buff?

[ ... ]
> @@ -1528,7 +1528,7 @@ static void __exit hvcs_module_exit(void)
>  	kthread_stop(hvcs_task);
> =20
>  	spin_lock(&hvcs_pi_lock);
> -	free_page((unsigned long)hvcs_pi_buff);
> +	kfree(hvcs_pi_buff);

[Severity: High]
This is a pre-existing issue, but does this cleanup path attempt to derefer=
ence=20
an invalid pointer if hvcs_initialize() previously failed during kthread_ru=
n()?

If hvcs_task contains an ERR_PTR, calling kthread_stop(hvcs_task) could cau=
se=20
an invalid dereference.

Also, because hvcs_pi_buff was already freed in the kthread_fail path and n=
ever=20
set to NULL, would this result in a double free?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831-tty-v2-0-8=
8cd58c3c640@kernel.org?part=3D3
