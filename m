Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA6539E17C
	for <linux-serial@vger.kernel.org>; Sun, 30 Aug 2026 08:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788077129; cv=none; b=gKc8b7GvCX+nH6blGff+Z+Dx+9h8sPbbjrnYopvGuguMQ2BO20z8rEau5e+Jykxous9g55nQxu6ya3lyUtBJfelVH9J39I4Z3UMBQe/GfgWECfuIj0CWsFXhfGibUQS5Q9h9IT6foaDLBE49Icw3SIHmKjfqmKg0r7GGvG3BSLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788077129; c=relaxed/simple;
	bh=HnjWCqiacH6pxqD0ErzakjOwgtI3TFl0zmSg6E/8yIo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=C1N0UdNC/XDR2jsoOazLcqQtvqJM3T+0XTSaq9Yl84rl8x6ieReF9UfDfe66H+x8J6OHwlnEoFYc/xEJeb2AX1G79qlqAe7QLpUoY8ldW6Gmz2PBlZGiOcplBxBeciGbLPd0ufnaNgcAfaPBT/ju2sjWX3JXyU5morZVzxOBbHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mvlUCPRp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mvlUCPRp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6C4E1F000E9;
	Sun, 30 Aug 2026 08:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788077128;
	bh=WvKx9V2S8X9tSP8kPfStdZ8z+lCnEwlxrGN8f7Zsazc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mvlUCPRplJAZpGL3/7PVrkjTZ6fN9aQYrWRGwckm7tkB9ZAS2eyGJUyNH81woZk7X
	 ihkv6qGT+BuDnJpV3H+1ttBoV2sPyv17nloMLJel/IhcUQEbM7S4ICIiETdis0ouo6
	 Z0vnxxxWrsW0A8UWe+h7FdN/7gNdgQ629sG0xYFKRi1DPE4vjBIVv0KIJTv3+o2emw
	 eLdpKQGDQq9W+PZ1suK815pOPP8hI/jv297lFddLXlTeCE/XADL2tE8WYHQqCHMa8s
	 PsCmxq4qqwZ4gZTnmrzFAmPLWFsZBf9/4aVH2sZM7kHTkv0ZWCkA1JbdOINrW/4K+Y
	 4fWZTPPfgxUtg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] tty: hvcs: replace __get_free_page() with kmalloc()
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWlrZSBSYXBvcG9ydCAoTWljcm9zb2Z0KQ==?= <rppt@kernel.org>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20260830-tty-v1-3-0cbe6170649b@kernel.org>
References: <20260830-tty-v1-0-0cbe6170649b@kernel.org>
 <20260830-tty-v1-3-0cbe6170649b@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 30 Aug 2026 08:05:27 +0000
Message-Id: <20260830080527.E6C4E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Error path in `hvcs_initialize()` leaves `hvcs_task` as an `ERR_PT=
R` and `hvcs_pi_buff` as a dangling pointer, leading to a kernel panic and =
double-free on module exit.
--

commit 9b8103eef858c273046b0b8e782a706cf3628f9a
Author: Mike Rapoport (Microsoft) <rppt@kernel.org>

tty: hvcs: replace __get_free_page() with kmalloc()
   =20
hvcs_initialize() allocates the buffer that receives the partner info
returned by the H_VTERM_PARTNER_INFO hypercall. This buffer can be allocated
with kmalloc() as there's nothing special about it to go directly to the
page allocator.

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
This isn't a bug introduced by this patch, but will this error path leave
hvcs_task as an ERR_PTR and hvcs_pi_buff as a dangling pointer?

If hvcs_initialize() fails at kthread_run(), hvcs_task will hold an ERR_PTR
and hvcs_pi_buff is freed here but not nullified.

>  buff_alloc_fail:
>  	tty_unregister_driver(hvcs_tty_driver);
>  register_fail:
[ ... ]
> @@ -1528,7 +1528,7 @@ static void __exit hvcs_module_exit(void)
>  	kthread_stop(hvcs_task);
> =20
>  	spin_lock(&hvcs_pi_lock);
> -	free_page((unsigned long)hvcs_pi_buff);
> +	kfree(hvcs_pi_buff);

[Severity: High]
This isn't a bug introduced by this patch, but could module unload cause a
kernel panic and a double-free if initialization previously failed?

Since hvcs_task is left as an ERR_PTR on failure rather than being reset to
NULL, the early return check in hvcs_module_exit() fails to catch it:

drivers/tty/hvc/hvcs.c:hvcs_module_exit() {
	if (!hvcs_task)
		return;
    ...
}

This allows execution to proceed to kthread_stop(hvcs_task), which will
dereference the error pointer.

It also proceeds to double-free the dangling hvcs_pi_buff here, and
eventually passes the NULL hvcs_tty_driver to tty_unregister_driver(),
resulting in a NULL pointer dereference panic.

>  	hvcs_pi_buff =3D NULL;
>  	spin_unlock(&hvcs_pi_lock);
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260830-tty-v1-0-0=
cbe6170649b@kernel.org?part=3D3
