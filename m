Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0905E3009E2
	for <linux-serial@vger.kernel.org>; Sun, 13 Sep 2026 22:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789339037; cv=none; b=UhlWRIqyriNdo/3dUEl4BKXW2NaS3K24sumvnRNhv5bvEL4B0XS0tb5l/kbiQEIf3rqB8uP77EwB0bnf+c3tgo/3RgU4+b4kJxbGa7E3Ky77cKgpHCU+eNYvjQWKUd5+G0CSkG0IbzHra0z4/ofZsJbUSAW7rkr/zwyKUpEDtXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789339037; c=relaxed/simple;
	bh=u3dNJgxGdVfs7gxObeCmtDXtxsKA5/J42iBhzvOhYGY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=T1c0JhevxVO65gkMeVcXAsq58IeCxgUuhIz/AIusrYYtMVTgItPQFwSpy/9+100Xh5cRR8bj89QWg9IR8eq/9P63YCJi/TYRAExPKaLdo8FzVYBTG1KNKUmuMs6OvjAQrByyLRjUUD3ITjBHU2iynGMgycQBmGokzd04g1/zTiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GNecb6XV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GNecb6XV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8E511F000FF;
	Sun, 13 Sep 2026 22:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789339035;
	bh=4uXEVTP4N99JIK/V2aVBsFSE4fs/pC9x1OL6Q9LdmIA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GNecb6XVA1IMG72llpsBXL18UyWt4y9O1yreHfCWK4VUolfBVU/XKNEg4GMRmFaR/
	 uUiBoLBF1/QOJZu54GLF+WlM+IRtNksgolaRIPE4A+yYZmd9OA7czwVzWdbfQIp5jf
	 Bf5sPJY4KF7ZzGP4kMA3qVlYlW7nW93BYiiRd2qiIO1lDtyGZBTjVD7MwqabU4ZFpw
	 xciWJ27Y7ZZWdoJLQ65ZeHSCmtlvrErbyFwElqt3rjYOPc9sQhdBmaYd3E+VzQ5sfX
	 /o3C+yRz+o14poiS6gmiD25CBhU4SJ8SeXnE9VNph8bvBoY4VRt9sQhqcEfZ6ECK4H
	 GUUuCQKVWAGtQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 1/2] tty: mediate TIOCSIG through task_kill LSM
 hooks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christopher Lusk" <clusk@northecho.dev>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20260913221958.839429-2-clusk@northecho.dev>
References: <20260913221958.839429-1-clusk@northecho.dev>
 <20260913221958.839429-2-clusk@northecho.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 13 Sep 2026 22:37:15 +0000
Message-Id: <20260913223715.B8E511F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Passing SEND_SIG_PRIV (1) directly to the task_kill LSM hook cause=
s a kernel panic when dereferenced by an eBPF LSM program.
--

commit 0444b1560acb73813cdf2e4fa3082c4f0aaf7e00
Author: Christopher Lusk <clusk@northecho.dev>

tty: mediate TIOCSIG through task_kill LSM hooks

This commit changes the pty_signal() function to invoke the task_kill LSM h=
ook
before delivering signals to the process group. It introduces kill_pgrp_lsm=
()
and __kill_pgrp_info_filtered() to perform this check while holding
tasklist_lock.

Link: https://lore.kernel.org/r/56bffc24f3d0d08b45a686a48e99766b0a0821fa.17=
80614610.git.hexlabsecurity@proton.me

> diff --git a/drivers/tty/pty.c b/drivers/tty/pty.c
> index cc7f7091ed9a2..8f5eea156ce4c 100644
> --- a/drivers/tty/pty.c
> +++ b/drivers/tty/pty.c
[ ... ]
> @@ -195,10 +196,13 @@ static int pty_signal(struct tty_struct *tty, int s=
ig)
>  	if (tty->link) {
>  		pgrp =3D tty_get_pgrp(tty->link);
>  		if (pgrp)
> -			kill_pgrp(pgrp, sig, 1);
> +			ret =3D kill_pgrp_lsm(pgrp, sig, 1);
>  		put_pid(pgrp);
>  	}
[ ... ]
> diff --git a/kernel/signal.c b/kernel/signal.c
> index a5e15bf09d319..758393b7257d6 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
[ ... ]
> @@ -1426,13 +1426,22 @@ int group_send_sig_info(int sig, struct kernel_si=
ginfo *info,
[ ... ]
> +static int __kill_pgrp_info_filtered(int sig, struct kernel_siginfo *inf=
o,
> +				     struct pid *pgrp, bool check_lsm)
>  {
>  	struct task_struct *p =3D NULL;
>  	int ret =3D -ESRCH;
> =20
>  	do_each_pid_task(pgrp, PIDTYPE_PGID, p) {
> -		int err =3D group_send_sig_info(sig, info, p, PIDTYPE_PGID);
> +		int err =3D 0;
> +
> +		if (check_lsm) {
> +			rcu_read_lock();
> +			err =3D security_task_kill(p, info, sig, NULL);

[Severity: High]
Does this pass SEND_SIG_PRIV ((void *)1) directly to the task_kill LSM hook?

pty_signal() initiates this by calling kill_pgrp_lsm() with priv=3D1, which
translates to SEND_SIG_PRIV via __si_special(priv). This invalid pointer is
then passed directly as the `info` argument to security_task_kill().

When an eBPF LSM program is attached to bpf_lsm_task_kill, it receives `inf=
o`
as a PTR_TO_BTF_ID | PTR_TRUSTED pointer. The PTR_TRUSTED flag disables BPF=
's
PROBE_MEM fault protection, as the pointer is assumed safe to dereference.

If the eBPF program attempts to read info->si_signo, it will execute a norm=
al
kernel memory load from address 0x1, causing an immediate kernel panic.

Before this patch, check_kill_permission() filtered out SEND_SIG_PRIV via
si_fromuser(), preventing it from ever reaching the LSM hook.

> +			rcu_read_unlock();
> +		}
> +		if (!err)
> +			err =3D group_send_sig_info(sig, info, p, PIDTYPE_PGID);
[ ... ]
> @@ -1886,6 +1900,18 @@ int kill_pgrp(struct pid *pid, int sig, int priv)
>  }
>  EXPORT_SYMBOL(kill_pgrp);
> =20
> +int kill_pgrp_lsm(struct pid *pid, int sig, int priv)
> +{
> +	int ret;
> +
> +	read_lock(&tasklist_lock);
> +	ret =3D __kill_pgrp_info_filtered(sig, __si_special(priv), pid, true);
> +	read_unlock(&tasklist_lock);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(kill_pgrp_lsm);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260913221958.8394=
29-1-clusk@northecho.dev?part=3D1
