Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6384F2F3C3E
	for <linux-serial@vger.kernel.org>; Tue,  1 Sep 2026 11:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788263716; cv=none; b=fGZvAeQnfx2E3TGzSFuOOBU2/z3oOePjcdMH2JVXKQIiX4+lvWAs8QvGRPYRUnugQuBEoFvTwFDO1ZM7xkTqGfdfXvVdkRefVIQkyy9TXIwyQjoh3jCDBJTatI6jCmqWIGQV7sBG/nsULiIo5GS2Kma/KtQUWk3aJBHZxc13G4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788263716; c=relaxed/simple;
	bh=Q2Cq0UG+GjcVr7yFlst+5qePWYfGSKR0Ad4Uw6PhYNc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RdKAYV9Gi6lZP5PGsWrRMvKPSK0TwQhJfLSGCPSLmp1F6L2g3/e4h2jZFxMMmuCMMDFEc453pDUw8GbEKwr0zC29jlmqE5ifMcbF7HxPx65Uvldk14yUjk4QEVq/bspp+2kAnexQork+5U4AwXipigzbf5WuYbXEl4yA5mMqWaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VM90q8QF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VM90q8QF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B47FF1F000E9;
	Tue,  1 Sep 2026 11:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788263714;
	bh=jd8tZSuu20czVctXie6sfPlxOR/xrEMwjrPSOxaSHRY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VM90q8QF9uEgNdqxNpMOWscgodR+qhA/eScjtkg5lEIoNQw/R6HDEAggsVS24Vspl
	 sp8Eu98iE9ubj7qgfTCHx2JiDDRAytqDysdTcznIKo+UsmQ+u2UTVVn9VdS7TqY+fm
	 t6+QZt547TcJvKZ4/uGjrC7tuZWva1aN0Yzhpf/e4ubRcYdevp2YCiyevRi4nP8jK8
	 HHuEBjTrtmdmesBYhuJeTRsGDsgEgDKdubDDWLcuris5bgMtZjK7sh6Zh5JQ+3nV9m
	 +1BCyxHoEeUFSMIAanffKCFlMJYndYBp9ye82iPdkFS3YEJkeMafQky2lR97IQ/3re
	 W6LJnCy8sW48A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] vc_screen: reload vc pointer before if (ret) in
 vcs_write() to avoid UAF
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yi Yang" <yiyang13@huawei.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20260901113131.2760010-1-yiyang13@huawei.com>
References: <20260901113131.2760010-1-yiyang13@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 11:55:14 +0000
Message-Id: <20260901115514.B47FF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> The reload of 'vc' added by commit 8fb9ea65c9d1 ("vc_screen: reload load
> of struct vc_data pointer in vcs_write() to avoid UAF") sits after the
> 'if (ret)' block, so the copy-failure break path exits the loop without
> reloading vc. If the vc was kfree()'d via vc_port_destruct during the
> unlocked copy_from_user() window, the post-loop
> 'if (written && vc) vcs_scr_updated(vc)' is reached with a stale
> non-NULL vc. The '&& vc' guard from commit a287620312dc ("vc_screen:
> fix null-ptr-deref in vcs_notifier() during concurrent vcs_write") only
> handles the NULL case, not this stale-non-NULL case; vcs_notifier() then
> reads param->vc->vc_num from freed memory:
>=20
>   BUG: KASAN: slab-use-after-free in vcs_notifier+0x7c/0xd0
>   Read of size 2 at addr ffff888007149190
>   Call Trace:
>    vcs_notifier+0x7c/0xd0
>    atomic_notifier_call_chain+0x70/0xa0
>    vcs_scr_updated+0x77/0xa0
>    vcs_write+0x71b/0x7e0
>   Allocated by task: vc_allocate -> con_install -> tty_open
>   Freed by task: kfree <- vt_ioctl (VT_DISALLOCATE -> vc_port_destruct)
>=20
> Move the reload to immediately after console_lock(), before 'if (ret)',
> so every break path below passes a fresh vc to the post-loop
> vcs_scr_updated().
>=20
> Fixes: a287620312dc ("vc_screen: fix null-ptr-deref in vcs_notifier() dur=
ing concurrent vcs_write")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yi Yang <yiyang13@huawei.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901113131.2760=
010-1-yiyang13@huawei.com?part=3D1

