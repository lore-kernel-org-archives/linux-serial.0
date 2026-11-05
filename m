Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793893625;
	b=0Eb0tsEsxaKOw0cNhf+Wr07YX2xb0yzQ2Uad98H6rH89cGG9zam4DYcOrxhE9WR8kq05
	 qIwfI30G/M0x2Ji+M0Gf2DHPeoDeGd9Wd1M9doCVajQ7lSv4awHk+LXHrGRRI4L5gar0N
	 hRYUy03/hqkt7Z/rhDm2X7URWrPB1weQTl2A6tMy1h46eYiSWnOevMJ2Hqp6f1+mkALY+
	 KbBX3tFOwsLeJsaqyTidi4+d4Ai4XIdXCGBagwLUEnOtUdbTuZJ/XJBYj5yUi7EsOYEtl
	 ChxIyTJEAMrcg8CLCKNWYEfzXT6GLHhhv1Iai7C9wxCUO7kxU0PJbnc2r+Dx51kWvcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793893625;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=O6bILW/g/kskdNqu+4aAR8CuG+uu0iXCPuKUviAfh1g=;
	b=rTEhhWoz0V0hOvkExyrLYq/ye8Beco4eFMgW6KNnATpn2ahjPox5lSQcUaZ/IywIm1WD
	 cADT/LsqbsDklcg7NdJ8jsVe0PXliPK7msKdljcdB3RqChc3mCgNaiGQBRa39Ee6ixf4T
	 IpFzvPiycyugC4mohIFcnAFcPjH4zmmoZH0xNm4rRxI5GZ1X8WJd+q5ErOdznjXFDLRjT
	 TVJYsiUqNK91JAQxEXld3xtdxYE6pzZj0Mt5yx7lzUh81xvVNZc9AbWP9doqq2V3NF/iH
	 wrUqYYnnm4BJ/icCIpt64Gs6ol1bATnv3lLJ2s3TSpr8xhvNhtJxsaBzgSStggOZYXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=d+7efhlJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2352C606A326;
	Thu,  5 Nov 2026 15:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=d+7efhlJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B8F81F000C1;
	Thu,  5 Nov 2026 15:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793893624;
	bh=O6bILW/g/kskdNqu+4aAR8CuG+uu0iXCPuKUviAfh1g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=d+7efhlJvucg2rMp+tvbuEYTiu0sUslTsSso0++OPPE2I/wO3aQKhkMulDIcEkKAQ
	 JoedLjUPeKwcvcvajcOpZ6An2KIeob+dXkPxVIbyWtAYFBYiImHULDhB1Qr/8sFfNs
	 3L4q8oi9OpCvAw1Iu9qBTKZiQevPMtGXBHxlYUhk=
Date: Thu, 5 Nov 2026 10:47:03 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Stefan =?iso-8859-1?Q?B=FChler?= <stefan.buehler@tik.uni-stuttgart.de>
Cc: Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [BUG] kernel.sysrq sysctl race condition(s) / list corruptions
Message-ID: <2026110537-earmark-surgery-163d@gregkh>
References: <ece93045-3df5-4645-8d3e-bc8392c45ed6@tik.uni-stuttgart.de>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ece93045-3df5-4645-8d3e-bc8392c45ed6@tik.uni-stuttgart.de>

On Thu, Nov 05, 2026 at 03:29:54PM +0100, Stefan Bühler wrote:
> Hi,
> 
> we have `kernel.sysrq = 0` in /etc/sysctl.d/, and run `sysctl --system`
> multiple times, possibly concurrently.  This week I found the system in a
> weird state, and one `sysctl --system` process that couldn't be killed, with
> a "list_del corruption" in the kernel log pointing to
> `input_unregister_handle`.
> 
> This was on a debian stable 6.12.115+deb13.1-amd64, I think the most
> interesting part of the logs is:
> 
> ---
> list_del corruption. prev->next should be ffff8d6e4324d040, but was
> ffffffff915cf038. (prev=ffffffff915cf038)
> ------------[ cut here ]------------
> kernel BUG at lib/list_debug.c:62!
> Oops: invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
> CPU: 0 UID: 0 PID: 1454 Comm: sysctl Not tainted 6.12.115+deb13.1-amd64 #1
> Debian 6.12.115-2
> ...
> Call Trace:
>  <TASK>
>  input_unregister_handle+0x1b/0x90
>  sysrq_disconnect+0x33/0x40
>  input_unregister_handler+0x3d/0xc0
>  sysrq_toggle_support+0x48/0x70
> ---
> 
> I can easily reproduce it by running two copies of this script (even on a
> single CPU):
> 
> ---
> #!/usr/bin/env python3
> 
> with open("/proc/sys/kernel/sysrq", "w") as sysctl:
>     while True:
>         sysctl.write("0\n")
>         sysctl.seek(0)
>         sysctl.write("1\n")
>         sysctl.seek(0)
> ---
> 
> I think I can see how `sysrq_toggle_support` has a race condition; I don't
> understand how that (in my original scenario that only tried setting it to
> 0) could end in problems, even if it ran sysrq_unregister_handler() multiple
> times without sysrq_register_handler() between (the code looks like it
> should leave a clean input_handler, and not do anything bad when passed a
> clean input_handler).
> 
> I see how it could run sysrq_register_handler() multiple times without
> sysrq_unregister_handler() between when using my python script, and how that
> is going to be a problem - and when I tried it with vanilla
> 7.4.0~rc1-g05441d697f7f (on a different system), I actually get a "list_add
> double add":
> 
> ---
> list_add double add: new=ffffffffa9bea108, prev=ffffffffa9bea108,
> next=ffffffffa9c09b20.
> ------------[ cut here ]------------
> kernel BUG at lib/list_debug.c:35!
> Oops: invalid opcode: 0000 [#1] SMP NOPTI
> CPU: 0 UID: 0 PID: 1392 Comm: python3 Not tainted 7.4.0-rc1+ #3
> PREEMPT(lazy)
> Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference
> Platform, BIOS 6.00 11/12/2020
> RIP: 0010:__list_add_valid_or_report.cold+0x15/0x33
> Code: 36 fe ff e9 de 84 7d 00 4c 89 e6 bf 0f 00 00 00 e8 2e ff ff ff 48 89
> f2 48 89 d9 48 89 fe 48 c7 c7 d0 d4 7b a9 e8 69 36 fe ff <0f> 0b 48 c7 c7 f8
> d3 7b a9 e8 5b 36 fe ff 0f 0b 48 c7 c7 d0 d3 7b
> RSP: 0018:ffffd485c2f97a20 EFLAGS: 00010246
> RAX: 0000000000000058 RBX: ffffffffa9c09b20 RCX: 0000000000000000
> RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffffffffa9a5b680
> RBP: ffffffffa9bea0a0 R08: 3fffffffffff7fff R09: 0000000000000577
> R10: ffffd485c2f97840 R11: 0000000000000002 R12: ffffffffaa78ad50
> R13: ffffffffa9bea108 R14: ffffffffa92f4e00 R15: 0000000000000002
> FS:  00007f78eb9b9780(0000) GS:ffff8ce9cf828000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00000000007132b0 CR3: 00000001041a2006 CR4: 0000000000770ef0
> PKRU: 55555554
> Call Trace:
>  <TASK>
>  input_register_handler+0x89/0x130
>  sysrq_toggle_support+0x5f/0x70
>  sysrq_sysctl_handler+0xb0/0xc0
>  ? __pfx_sysrq_sysctl_handler+0x10/0x10
> ...
> ---
> 
> It seems `input_register_handler` is usually called from module __init, with
> freshly allocated data, or with a mutex being held - afaict only sysrq is
> potentially calling it with an already registered handler.
> 
> `sysrq_toggle_support` probably should use a mutex too.
> 
> 
> Summary:
> 
> * my python script (run two instances) triggers a kernel BUG on both
>   debian stable 6.12.115+deb13.1 and vanilla 7.4.0~rc1-g05441d697f7f
>   within seconds
> * 6.12.155 shows a "list_del corruption" in `input_unregister_handle`,
>   which I can't explain (especially not in the original environment)
> * 7.4.0~rc1-g05441d697f7f shows "list_add double add" in
>   `input_register_handler`, which is kinda expected
> * sometimes a python script segfaults, sometimes it ends up unkillable
> * I don't think this is accessible from unprivileged userns / containers

Can you try this patch out:
	https://lore.kernel.org/r/20261030123640.263164-1-zhanxusheng1024@gmail.com
as it seems to describe the issue you are seeing here.

Or am I mistaken?

thanks,

greg k-h
