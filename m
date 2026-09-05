Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90243C10A2
	for <linux-serial@vger.kernel.org>; Sat,  5 Sep 2026 09:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788601240; cv=none; b=XCJDkhlbkiBk3NndwJDM8dpcLgSA12h3LosjcorC5NmkPBU9k/rBB6dOfY8rC/kF+IF768MwTVVp9b+l/a0O2+y23Ww6KQsKR9LmdlYX7t6isuyelk+LjvV/Wg5iGfj8v0UMRtJE6v7fsv2d4iCrF/3xDmEswMUj2dXLJEUeg3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788601240; c=relaxed/simple;
	bh=NJmhAA4eAaUneEuRJnglpao4zpBmxf24iZp5yxwOzRM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ru+PG08dI8bi11vRfUEROZE0CPYpiENqzkmu6InENWKBLEweUrc7PfKy8+h03z9qrss3cuY9IGI2C6tPFWpkJ+RWRysMEtmq+aSH4kGp6DbNYofhIvCa/tH1jqYxafdfIEApy3MuZGRrvPR3YZKo09bKV5TvvmMsmfbyYHQp9Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nO55zyn3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nO55zyn3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3490D1F00A3E;
	Sat,  5 Sep 2026 09:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788601239;
	bh=E9eH8pTZ6mpYq+E9b8sWlGdjmckTYrm71Eeza5X9rek=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nO55zyn36FU1YueuoivGe2d7oI04TfEa+rPKhxvSNc/Obe91K6pZ7E9q0rzWboBgQ
	 a2WFBDh4LDA7NcqCYqKlvge0Erv+2Nl09TzRvoZOfwTeuh7ekdt6Dt/4b7/I38u+i3
	 emXuPjC0/KN+kSkkKfZuleUbNHtqRhA20JZIQw1di2+sS95WlKfRulPNIn6xA0QxR8
	 2J83ROQVgG5SsG6o6ARWXu2LKCD7/4GYNl3DfHCJDIqEoy9PVtqrv5YvTWqTp4QuDC
	 AipbvJHdi5BgEQqYzKAR+ZnuokV5cbAfJxKUrV1Dz8ejxRsVmHtpevfivNA4ISruIe
	 O23KP3P5p1lAA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 5/5] kthread: remove worker->task self assignment
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bradley Morgan" <brads@mainlining.org>
Cc: media-ci@linuxtv.org, linux-serial@vger.kernel.org
In-Reply-To: <c925e99c73bea9e0cdab656ba09453df7e81dcb2.1788513591.git.brads@mainlining.org>
References: <cover.1788513591.git.brads@mainlining.org>
 <c925e99c73bea9e0cdab656ba09453df7e81dcb2.1788513591.git.brads@mainlining.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 05 Sep 2026 09:40:38 +0000
Message-Id: <20260905094039.3490D1F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Removing the self-assignment `worker->task =3D current;` breaks =
out-of-tree (OOT) users of the old `kthread_run(kthread_worker_fn, ...)` AP=
I, causing them to permanently deadlock due to missed wakeups.
--

commit 4e8323d40e4fe5053d4171cbca8193f9bd6080b8
Author: Bradley Morgan <brads@mainlining.org>

kthread: remove worker->task self assignment

All kthread worker users now create their workers with kthread_create_worke=
r*(),
which sets worker->task before the worker starts. The self assignment in
kthread_worker_fn() is removed, leaving a warning check for out-of-tree use=
rs.

> diff --git a/kernel/kthread.c b/kernel/kthread.c
> index 63beb59b7a3d1..643407647e79d 100644
> --- a/kernel/kthread.c
> +++ b/kernel/kthread.c
> @@ -987,12 +987,10 @@ int kthread_worker_fn(void *worker_ptr)
>  	struct kthread_worker *worker =3D worker_ptr;
>  	struct kthread_work *work;
> =20
> -	/*
> -	 * FIXME: Update the check and remove the assignment when all kthread
> -	 * worker users are created using kthread_create_worker*() functions.
> +	/* All workers are created with worker->task set. If this fires,
> +	 * the caller is broken.
>  	 */
> -	WARN_ON(worker->task && worker->task !=3D current);
> -	worker->task =3D current;
> +	WARN_ON(worker->task !=3D current);

[Severity: Medium]
Does removing this assignment cause out-of-tree users of the old
kthread_run() API to hang permanently?

Because the self-assignment is removed, worker->task will remain NULL for a=
ny
callers still using the old API. When new work is inserted, the wakeup will=
 be
silently skipped in kthread_insert_work():

kernel/kthread.c:kthread_insert_work() {
	...
	if (!worker->current_work && likely(worker->task))
		wake_up_process(worker->task);
	...
}

This means the warning intended as a sanity check turns into a silent, fatal
breakage where the worker hangs in TASK_INTERRUPTIBLE and queued work is ne=
ver
processed.

> =20
>  	if (worker->flags & KTW_FREEZABLE)
>  		set_freezable();

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1788513591.gi=
t.brads@mainlining.org?part=3D5
