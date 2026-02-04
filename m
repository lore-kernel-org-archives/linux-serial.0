Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079D137E311
	for <linux-serial@vger.kernel.org>; Wed,  4 Feb 2026 09:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770199042; cv=none; b=FrwHfQZPUbzd2BW5BOWNQKKsq/FZO+Yq+SBRx9rtndZnvEmr7K3kysEMyAT+UtXfYxupP/82b1b+hOczTPe5EeLSexTM01gHqPykcVN65UW3GlrPwxg0wDJ2YO5LRAc/688lbCyStKPW7wpIFaYZtRJbcFltj1IUUouFKczfgGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770199042; c=relaxed/simple;
	bh=E87cWVCFJzLTYJVMJea/r3v04k72evoo1eXdttyBpbU=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=uYKn45VnwvXin5i1r4Eopxkxzz4Ic8nYNZrWp+kRf5rSxQjqWtwIcG3XNxpfGv9rbs2HHRdJd0/WX8tmRuigVi7p8lqoRGPsBL7VLySM3utvkkB4zYg5XZM0bGbfPfjh1N+ZmTWhkuvN4SUUBR5kqSqyO85HhAODrX6yDfO3T9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=aAUnmqD6; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aAUnmqD6"
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770199039;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GVks+hrwHNkS/Bsg/v01WRdm7TWVt8/VK0HYKFqAIhY=;
	b=aAUnmqD62HhZ7v3ulhTPDelWsRtwQZlEAUGzuUEg3keiToRIdXxbeYBMA7Gx4UDoP4KfYl
	dTtgF9Y6vi5FWmW8GJgWcljV4hXtkTgDxbojZnlWfSLHzlPyDmwG7EYQtj/ysN7AUrlTq9
	AU6LlL/lXkJ3WEkpAuADiXSYo5Sp9IU=
Date: Wed, 04 Feb 2026 09:57:16 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Message-ID: <a8baf6415463d2ad20cf556c8148432e17b211e6@linux.dev>
TLS-Required: No
Subject: Re: [PATCH v1] serial: core: fix infinite loop in handle_tx() for
 PORT_UNKNOWN
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, "Jiayuan Chen" <jiayuan.chen@shopee.com>,
 "Jiri Slaby" <jirislaby@kernel.org>, "Petr Mladek" <pmladek@suse.com>,
 "Marcos Paulo de Souza" <mpdesouza@suse.com>, "Krzysztof Kozlowski"
 <krzysztof.kozlowski@oss.qualcomm.com>, "Dr. David Alan Gilbert"
 <linux@treblig.org>, "Joseph Tilahun" <jtilahun@astranis.com>, "Sjur
 Braendeland" <sjur.brandeland@stericsson.com>, "David S. Miller"
 <davem@davemloft.net>, linux-kernel@vger.kernel.org
In-Reply-To: <2026020453-corrode-lecturer-9b36@gregkh>
References: <20260204074327.226165-1-jiayuan.chen@linux.dev>
 <2026020459-lisp-display-0506@gregkh>
 <fa7e9e86df95ffcc301c60367654e084cbff5d83@linux.dev>
 <2026020453-corrode-lecturer-9b36@gregkh>
X-Migadu-Flow: FLOW_OUT

February 4, 2026 at 16:53, "Greg Kroah-Hartman" <gregkh@linuxfoundation.o=
rg mailto:gregkh@linuxfoundation.org?to=3D%22Greg%20Kroah-Hartman%22%20%3=
Cgregkh%40linuxfoundation.org%3E > wrote:


>=20
>=20On Wed, Feb 04, 2026 at 08:29:06AM +0000, Jiayuan Chen wrote:
>=20
>=20>=20
>=20> 2026/2/4 16:20, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org ma=
ilto:gregkh@linuxfoundation.org?to=3D%22Greg%20Kroah-Hartman%22%20%3Cgreg=
kh%40linuxfoundation.org%3E > wrote:
> >=20=20
>=20>=20=20
>=20>=20=20
>=20>  On Wed, Feb 04, 2026 at 03:43:20PM +0800, Jiayuan Chen wrote:
> >=20=20
>=20>  >=20
>=20>  > From: Jiayuan Chen <jiayuan.chen@shopee.com>
> >  >=20
>=20>  > uart_write_room() and uart_write() behave inconsistently when
> >  > xmit_buf is NULL (which happens for PORT_UNKNOWN ports that were
> >  > never properly initialized):
> >  >=20
>=20>  How does this happen? Why were they not initialized properly, what
> >  drivers/hardware cause this?
> >=20=20
>=20>=20=20
>=20>  In QEMU environment, /dev/ttyS3 is PORT_UNKNOWN type (no real UART=
 hardware).
> >  When uart_port_startup() sees uport->type =3D=3D PORT_UNKNOWN, it re=
turns early
> >  without allocating xmit_buf:
> >  if (uport->type =3D=3D PORT_UNKNOWN)
> >  return 1; // xmit_buf never allocated
> >  So xmit_buf remains NULL.
> >=20
>=20But the flags for the port will have TTY_IO_ERROR set on it, which
> should hopefully mean that no data is attempted to be sent through this
> (or a ldisc would be bound to it.)
>=20
>=20How does this port work at all? Why is QEMU advertising a broken port
> that can not do anything?
>=20
>=20And is this the only place such a check would ever be needed? What
> changed recently to suddenly require this?


  This is an artificially constructed reproducer. I chose
  /dev/ttyS3 specifically because it's PORT_UNKNOWN in QEMU. In real-worl=
d
  usage, users wouldn't do this intentionally.

> >=20
>=20> >=20
>=20>  > - uart_write_room() returns kfifo_avail() which can be > 0
> >  > - uart_write() checks xmit_buf and returns 0 if NULL
> >  >=20
>=20>  > This inconsistency causes an infinite loop in drivers that rely =
on
> >  > tty_write_room() to determine if they can write:
> >  >=20
>=20>  > while (tty_write_room(tty) > 0) {
> >  > written =3D tty->ops->write(...);
> >  > // written is always 0, loop never exits
> >  > }
> >  >=20
>=20>  > For example, caif_serial's handle_tx() enters an infinite loop w=
hen
> >  > used with PORT_UNKNOWN serial ports, causing system hangs.
> >  >=20
>=20>  > Fix by making uart_write_room() also check xmit_buf and return 0=
 if
> >  > it's NULL, consistent with uart_write().
> >  >=20
>=20>  > Reproducer: https://gist.github.com/mrpre/d9a694cc0e19828ee3bc3b=
37983fde13
> >  >=20
>=20>  > Fixes: 9b27105b4a44 ("net-caif-driver: add CAIF serial driver (l=
disc)")
> >  >=20
>=20>  This really isn't a fix for that driver, but rather something else=
.
> >=20=20
>=20>  You're right, this is awkward. The API inconsistency between uart_=
write_room()
> >  and uart_write() has existed since 2.6.12, but it only became visibl=
e as a
> >  deadloop when CAIF was introduced - because CAIF's handle_tx() relie=
s on
> >  tty_write_room() to decide whether to call write().
> >  The fix location is in uart, but the trigger condition requires CAIF=
 (or
> >  similar drivers). I can remove the Fixes tag if you prefer.
> >=20
>=20Ok, I think this goes a bit deeper. This might be due to the kfifo
> rewrite of the serial drivers, as in older kernels we did not have a
> kfifo, so if it was not initialized the code checking path is much
> different.
>=20
>=20As a "check" can you see if this fails for you on the latest 5.10.y
> tree? That is before the kfifo code was added to the uart layer.

This issue still exists in 5.10.248


[   56.519143] watchdog: BUG: soft lockup - CPU#2 stuck for 22s! [caif_de=
adloop_r:457]
[   56.520868] Modules linked in:
[   56.520903] CPU: 2 PID: 457 Comm: caif_deadloop_r Not tainted 5.10.248=
 #1
[   56.520914] Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX, 1996),=
 BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   56.520971] RIP: 0010:_raw_spin_unlock_irqrestore+0x15/0x20
[   56.520977] Code: e8 a0 5f 38 ff 4c 29 e8 49 39 c6 73 d8 80 0b 04 eb 8=
d cc cc cc 0f 1f 44 00 00 55 48 89 e5 e8 8a 4e 3b ff 66 90 48 89 f7 57 9d=
 <0f> 1f 44 00 00 5d c3 cc cc cc cc 0f 1f 47
[   56.520986] RSP: 0018:ffffc90000f8bb60 EFLAGS: 00000282
[   56.520988] RAX: 0000000000000001 RBX: ffff888100b984e0 RCX: ffff88810=
24eb800
[   56.520990] RDX: 0000000000000001 RSI: 0000000000000282 RDI: 000000000=
0000282
[   56.520991] RBP: ffffc90000f8bb60 R08: ffff8881024eb800 R09: 000000000=
0000000
[   56.520992] R10: ffff88810086ed00 R11: 0000000000000000 R12: 000000000=
0000080
[   56.520993] R13: ffff888102423e10 R14: ffff8881024eb800 R15: ffffffff8=
41eeb58
[   56.520996] FS:  00007f5c618c7740(0000) GS:ffff888137c00000(0000) knlG=
S:0000000000000000
[   56.520997] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   56.520998] CR2: 00007f1767cce200 CR3: 0000000008622005 CR4: 000000000=
0770ee0
[   56.521003] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000000000=
0000000
[   56.521004] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000000000=
0000400
[   56.521005] PKRU: 55555554
[   56.521010] Call Trace:
[   56.521087]  uart_write+0x1ec/0x240
[   56.521112]  handle_tx+0x9a/0x1a0
[   56.521115]  caif_xmit+0x61/0x70
[   56.521141]  dev_hard_start_xmit+0xa6/0x1e0
[   56.521144]  __dev_queue_xmit+0x7b3/0xaa0
[   56.521165]  ? packet_parse_headers+0x17a/0x250
[   56.521169]  dev_queue_xmit+0x10/0x20
[   56.521175]  packet_sendmsg+0x8eb/0x1740
[   56.521197]  ? __wake_up_common_lock+0x88/0xc0
[   56.521214]  __sock_sendmsg+0x70/0x80
[   56.521217]  __sys_sendto+0x142/0x190
[   56.521223]  __x64_sys_sendto+0x24/0x30
[   56.521233]  do_syscall_64+0x37/0x50
[   56.521236]  entry_SYSCALL_64_after_hwframe+0x67/0xd1
[   56.521251] RIP: 0033:0x7f5c619f60d7
[   56.521276] Code: c7 c0 ff ff ff ff eb be 66 2e 0f 1f 84 00 00 00 00 0=
0 90 f3 0f 1e fa 80 3d 75 ef 0d 00 00 41 89 ca 74 10 b8 2c 00 00 00 0f 05=
 <48> 3d 00 f0 ff ff 77 69 c3 55 48 89 e5 50
[   56.521277] RSP: 002b:00007ffd7a4f64b8 EFLAGS: 00000202 ORIG_RAX: 0000=
00000000002c
[   56.521279] RAX: ffffffffffffffda RBX: 00007ffd7a4f67a8 RCX: 00007f5c6=
19f60d7
[   56.521281] RDX: 0000000000000080 RSI: 00007ffd7a4f64f0 RDI: 000000000=
0000004
[   56.521282] RBP: 00007ffd7a4f6680 R08: 00007ffd7a4f64d0 R09: 000000000=
0000014
[   56.521283] R10: 0000000000000000 R11: 0000000000000202 R12: 000000000=
0000001
[   56.521285] R13: 0000000000000000 R14: 000055c2c648ed58 R15: 00007f5c6=
1b1a000


$ scripts/decode_stacktrace.sh vmlinux < dmesg.txt


[   56.519143] watchdog: BUG: soft lockup - CPU#2 stuck for 22s! [caif_de=
adloop_r:457]
[   56.520868] Modules linked in:
[   56.520903] CPU: 2 PID: 457 Comm: caif_deadloop_r Not tainted 5.10.248=
 #1
[   56.520914] Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX, 1996),=
 BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   56.520971] RIP: 0010:_raw_spin_unlock_irqrestore (./arch/x86/include/=
asm/paravirt.h:653 ./include/linux/spinlock_api_smp.h:160 kernel/locking/=
spinlock.c:191)
[ 56.520977] Code: e8 a0 5f 38 ff 4c 29 e8 49 39 c6 73 d8 80 0b 04 eb 8d =
cc cc cc 0f 1f 44 00 00 55 48 89 e5 e8 8a 4e 3b ff 66 90 48 89 f7 57 9d <=
0f> 1f 44 00 00 5d c3 cc cc cc cc 0f 1f 47
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:	e8 a0 5f 38 ff       	call   0xffffffffff385fa5
   5:	4c 29 e8             	sub    %r13,%rax
   8:	49 39 c6             	cmp    %rax,%r14
   b:	73 d8                	jae    0xffffffffffffffe5
   d:	80 0b 04             	orb    $0x4,(%rbx)
  10:	eb 8d                	jmp    0xffffffffffffff9f
  12:	cc                   	int3
  13:	cc                   	int3
  14:	cc                   	int3
  15:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  1a:	55                   	push   %rbp
  1b:	48 89 e5             	mov    %rsp,%rbp
  1e:	e8 8a 4e 3b ff       	call   0xffffffffff3b4ead
  23:	66 90                	xchg   %ax,%ax
  25:	48 89 f7             	mov    %rsi,%rdi
  28:	57                   	push   %rdi
  29:	9d                   	popf
  2a:*	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)		<-- trapping instru=
ction
  2f:	5d                   	pop=20   %rbp
  30:	c3                   	ret
  31:	cc                   	int3
  32:	cc                   	int3
  33:	cc                   	int3
  34:	cc                   	int3
  35:	0f                   	.byte 0xf
  36:	1f                   	(bad)
  37:	47                   	rex.RXB

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
   5:	5d                   	pop    %rbp
   6:	c3                   	ret
   7:	cc                   	int3
   8:	cc                   	int3
   9:	cc                   	int3
   a:	cc                   	int3
   b:	0f                   	.byte 0xf
   c:	1f                   	(bad)
   d:	47                   	rex.RXB
[   56.520986] RSP: 0018:ffffc90000f8bb60 EFLAGS: 00000282
[   56.520988] RAX: 0000000000000001 RBX: ffff888100b984e0 RCX: ffff88810=
24eb800
[   56.520990] RDX: 0000000000000001 RSI: 0000000000000282 RDI: 000000000=
0000282
[   56.520991] RBP: ffffc90000f8bb60 R08: ffff8881024eb800 R09: 000000000=
0000000
[   56.520992] R10: ffff88810086ed00 R11: 0000000000000000 R12: 000000000=
0000080
[   56.520993] R13: ffff888102423e10 R14: ffff8881024eb800 R15: ffffffff8=
41eeb58
[   56.520996] FS:  00007f5c618c7740(0000) GS:ffff888137c00000(0000) knlG=
S:0000000000000000
[   56.520997] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   56.520998] CR2: 00007f1767cce200 CR3: 0000000008622005 CR4: 000000000=
0770ee0
[   56.521003] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000000000=
0000000
[   56.521004] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000000000=
0000400
[   56.521005] PKRU: 55555554
[   56.521010] Call Trace:
[   56.521087] uart_write (drivers/tty/serial/serial_core.c:72 drivers/tt=
y/serial/serial_core.c:598)
[   56.521112] handle_tx (drivers/net/caif/caif_serial.c:237)
[   56.521115] caif_xmit (drivers/net/caif/caif_serial.c:284)
[   56.521141] dev_hard_start_xmit (./include/linux/netdevice.h:4833 ./in=
clude/linux/netdevice.h:4847 net/core/dev.c:3601 net/core/dev.c:3617)
[   56.521144] __dev_queue_xmit (./include/linux/netdevice.h:3322 (discri=
minator 25) net/core/dev.c:4204 (discriminator 25))
[   56.521165] ? packet_parse_headers (./include/linux/skbuff.h:2616 (dis=
criminator 1) net/packet/af_packet.c:1954 (discriminator 1))
[   56.521169] dev_queue_xmit (net/core/dev.c:4237)
[   56.521175] packet_sendmsg (net/packet/af_packet.c:3086 (discriminator=
 1) net/packet/af_packet.c:3118 (discriminator 1))
[   56.521197] ? __wake_up_common_lock (kernel/sched/wait.c:126 (discrimi=
nator 1))
[   56.521214] __sock_sendmsg (net/socket.c:651 (discriminator 1) net/soc=
ket.c:663 (discriminator 1))
[   56.521217] __sys_sendto (./include/linux/file.h:33 net/socket.c:2008)
[   56.521223] __x64_sys_sendto (net/socket.c:2013)
[   56.521233] do_syscall_64 (arch/x86/entry/common.c:46 (discriminator 1=
))
[   56.521236] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:=
117)
[   56.521251] RIP: 0033:0x7f5c619f60d7
[ 56.521276] Code: c7 c0 ff ff ff ff eb be 66 2e 0f 1f 84 00 00 00 00 00 =
90 f3 0f 1e fa 80 3d 75 ef 0d 00 00 41 89 ca 74 10 b8 2c 00 00 00 0f 05 <=
48> 3d 00 f0 ff ff 77 69 c3 55 48 89 e5 50
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:	c7 c0 ff ff ff ff    	mov    $0xffffffff,%eax
   6:	eb be                	jmp    0xffffffffffffffc6
   8:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
   f:	00 00 00
  12:	90                   	nop
  13:	f3 0f 1e fa          	endbr64
  17:	80 3d 75 ef 0d 00 00 	cmpb   $0x0,0xdef75(%rip)        # 0xdef93
  1e:	41 89 ca             	mov    %ecx,%r10d
  21:	74 10                	je     0x33
  23:	b8 2c 00 00 00       	mov    $0x2c,%eax
  28:	0f 05                	syscall
  2a:*	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax		<-- trappin=
g instruction
  30:	77 69                	ja     0x9b
  32:	c3                   	ret
  33:	55                   	push   %rbp
  34:	48 89 e5             	mov    %rsp,%rbp
  37:	50                   	push   %rax

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
   6:	77 69                	ja     0x71
   8:	c3                   	ret
   9:	55                   	push   %rbp
   a:	48 89 e5             	mov    %rsp,%rbp
   d:	50                   	push   %rax
[   56.521277] RSP: 002b:00007ffd7a4f64b8 EFLAGS: 00000202 ORIG_RAX: 0000=
00000000002c
[   56.521279] RAX: ffffffffffffffda RBX: 00007ffd7a4f67a8 RCX: 00007f5c6=
19f60d7
[   56.521281] RDX: 0000000000000080 RSI: 00007ffd7a4f64f0 RDI: 000000000=
0000004
[   56.521282] RBP: 00007ffd7a4f6680 R08: 00007ffd7a4f64d0 R09: 000000000=
0000014
[   56.521283] R10: 0000000000000000 R11: 0000000000000202 R12: 000000000=
0000001
[   56.521285] R13: 0000000000000000 R14: 000055c2c648ed58 R15: 00007f5c6=
1b1a000

> >=20
>=20> > ---
> >  > drivers/tty/serial/serial_core.c | 5 ++++-
> >  > 1 file changed, 4 insertions(+), 1 deletion(-)
> >  >=20
>=20>  > diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/seri=
al/serial_core.c
> >  > index 2805cad10511..0b2edf185cc7 100644
> >  > --- a/drivers/tty/serial/serial_core.c
> >  > +++ b/drivers/tty/serial/serial_core.c
> >  > @@ -643,7 +643,10 @@ static unsigned int uart_write_room(struct tt=
y_struct *tty)
> >  > unsigned int ret;
> >  >=20
>=20>  > port =3D uart_port_ref_lock(state, &flags);
> >  > - ret =3D kfifo_avail(&state->port.xmit_fifo);
> >  > + if (!state->port.xmit_buf)
> >  >=20
>=20>  This feels odd. What ports have no transmit buffers? And why would
> >  this be the only check that is needed for such broken devices?
> >=20=20
>=20>  Maybe let's fix the root cause here, the driver that does not have=
 a
> >  transmit buffer at all?
> >=20=20
>=20>=20=20
>=20>  Do you suggest we should prevent setting line discipline (like N_C=
AIF)
> >  on PORT_UNKNOWN ports? Or should CAIF check the port type before usi=
ng it?
> >  Note that CAIF is currently in orphan status (no active maintainer),=
 so
> >  I'm not sure about the process for modifying it. The serial core fix
> >  might be more straightforward.
> >=20
>=20I think you found a real bug here, that is independent of the caif co=
de,
> and might just be due to the kfifo stuff. See above for my questions
> here, and if so, your patch is correct, it's just that the Fixes: tag i=
s
> a bit off.
>=20
>=20thanks,
>=20
>=20greg k-h
>
