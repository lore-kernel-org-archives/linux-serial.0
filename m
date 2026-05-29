Received: from va-2-47.ptr.blmpb.com (va-2-47.ptr.blmpb.com [209.127.231.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFEBA353ED9
	for <linux-serial@vger.kernel.org>; Fri, 29 May 2026 02:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780020470; cv=none; b=Bs6DLWxaEjofwMLzKgkFK/xbmdKhPEIKf0QFKc9QTV+AF7UBRbt2aW3OW75d1lLpfVc2vRxTDTGYGhKbL+zCAYZuQBT5Qtn5zv6yhNW3xr+kwF6UBbBaSpA/QEENHCMubPOuXwWffyyjgdGUcIlqEj8zAvfnMUs2UA/mIyTKGiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780020470; c=relaxed/simple;
	bh=KDC7m1TM1iq2CG+8y+Nf+EjGHFiR2Rl3IlENzUP5MUo=;
	h=Message-Id:From:Mime-Version:References:In-Reply-To:Content-Type:
	 Date:To:Cc:Subject; b=cLHslYa6Xw5T2+0KcXpLQK2gm59TXNVX4nN56kSHcJjTwSxkfiYxggltH9QrRJ8HMAiHJSomTaP1msgaQP6KeeIZIK+iTvHtEtcWw1IKMn1s/oibQ3cMLnvNIs1hj6Or+hlU7PMz/4cz9F66ODWNgLdXBEOYxffmqQaxzPWqqh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com; spf=pass smtp.mailfrom=fnnas.com; dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b=OTXAbqBY; arc=none smtp.client-ip=209.127.231.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fnnas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b="OTXAbqBY"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fnnas-com.20200927.dkim.feishu.cn; t=1780020455;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=KDC7m1TM1iq2CG+8y+Nf+EjGHFiR2Rl3IlENzUP5MUo=;
 b=OTXAbqBYZv+SMNOnI4pJvdnHheU4sTHnNLhflA5tzu7HGkPhk3D6DOVCPtOlWRlVrLc+0c
 lekVoKMRARLBbcATTVptHr/5PNe1L0othizaNQPTw6KA2hdlGSS+RhU6G1gmVlQaZ3Kceg
 R4AmOsePyx3+JgrhFZukxVw0CRTkEwjZsjUXgA4K7c97FrDP21P8rHe0vuYpK7EsyTAagC
 MtOwKvPpksUb7xtnPfP8gZ3BJuhgtDQ2fP5iSwYi/zzQcDg3fGe8mz7+cD4XlUxWMV32dU
 ckPtBEZngEzF8XpINabm1hZI49FZmJz0p9kvJTwqZIkm51705N3WcCIk5w939w==
Message-Id: <5cf37150673ea4d5c28f94db91cdf68504b50522.22df93db.e9a5.40db.a812.14ba5b63f31b@feishu.cn>
From: =?utf-8?q?=E7=8E=8B=E6=9B=8C=E9=BE=99?= <wangzhaolong@fnnas.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Lms-Return-Path: <lba+16a18f4e5+d92dd9+vger.kernel.org+wangzhaolong@fnnas.com>
References: <20260528-bug-221579-8250-shared-irq-race-v2-1-06531202e54d@gmail.com>
In-Reply-To: <20260528-bug-221579-8250-shared-irq-race-v2-1-06531202e54d@gmail.com>
Content-Type: text/plain; charset=UTF-8
Date: Fri, 29 May 2026 10:07:32 +0800
To: "Qiliang Yuan" <realwujing@gmail.com>
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, 
	"Jiri Slaby" <jirislaby@kernel.org>, 
	"Anton Vorontsov" <avorontsov@ru.mvista.com>, 
	"Alan Cox" <alan@redhat.com>, <linux-kernel@vger.kernel.org>, 
	<linux-serial@vger.kernel.org>, "Qiliang Yuan" <realwujing@gmail.com>
Subject: Re: [PATCH v2] serial: 8250: fix use-after-free in IRQ chain handling
Content-Transfer-Encoding: quoted-printable

Hi Qiliang

> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D221579

This patch does not fix the reported issue.

I tested it with the Bugzilla reproducer, and the "Unbalanced enable for IR=
Q"
warning is still reproducible.

```
chmod +x /tmp/run-tty-open-race.sh
/tmp/run-tty-open-race.sh
racing simultaneous open/close on /dev/ttyS1 and /dev/ttyS3, 100000 iterati=
ons
[ =C2=A0 61.937561][=C2=A0 T915] ------------[ cut here ]------------
[ =C2=A0 61.938276][=C2=A0 T915] Unbalanced enable for IRQ 3
[ =C2=A0 61.938828][=C2=A0 T915] WARNING: kernel/irq/manage.c:774 at __enab=
le_irq+0x33/0x60, CPU#1: tty-open-race/915
[ =C2=A0 61.939978][=C2=A0 T915] Modules linked in: af_packet(E) kvm_amd(E)=
 nfnetlink(E) ahci(E) libahci(E) libata(E) lpc_ich(E) virtio_net(E) net_fai=
lover(E) failover(E) sunrpc(E) dm_mod(E) raid1(E) binfmt_misc(E) md_mod(E) =
9p(E) 9pnet_virtio(E) 9pnet(E) ext4(E) netfs(E) virtio_scsi(E) scsi_mod(E) =
crc16(E) mbcache(E) jbd2(E) virtio_blk(E) scsi_common(E) virtiofs(E) fuse(E=
) vmw_vsock_virtio_transport(E) vmw_vsock_virtio_transport_common(E) vsock(=
E)
[ =C2=A0 61.944542][=C2=A0 T915] CPU: 1 UID: 0 PID: 915 Comm: tty-open-race=
 Tainted: G =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 E =C2=A0 =C2=A0 =C2=A0=
 7.1.0-rc5-trim+ #14 PREEMPT(full)=C2=A0 43dd8c1eb10e193a5538796ee5a4e7f9cf=
3e86f3
[ =C2=A0 61.946304][=C2=A0 T915] Tainted: [E]=3DUNSIGNED_MODULE
[ =C2=A0 61.946866][=C2=A0 T915] Hardware name: QEMU Standard PC (Q35 + ICH=
9, 2009), BIOS Arch Linux 1.17.0-2-2 04/01/2014
[ =C2=A0 61.948045][=C2=A0 T915] RIP: 0010:__enable_irq+0x39/0x60
[ =C2=A0 61.948650][=C2=A0 T915] Code: 85 c0 74 19 83 f8 01 74 0e 83 e8 01 =
89 87 80 00 00 00 e9 d5 52 c8 ff f6 47 7d 08 74 17 48 8d 05 ed 01 2c 02 8b =
77 2c 48 89 c7 <67> 48 0f b9 3a e9 b8 52 c8 ff 81 4f 78 00 04 00 00 ba 01 0=
0 00 00
[ =C2=A0 61.950925][=C2=A0 T915] RSP: 0018:ffffc90000f67858 EFLAGS: 0001004=
6
[ =C2=A0 61.951634][=C2=A0 T915] RAX: ffffffff8373f030 RBX: 000000000000000=
1 RCX: ffff888108912380
[ =C2=A0 61.952574][=C2=A0 T915] RDX: 0000000000000001 RSI: 000000000000000=
3 RDI: ffffffff8373f030
[ =C2=A0 61.953508][=C2=A0 T915] RBP: 0000000000000003 R08: ffff88810891230=
0 R09: 0000000000000001
[ =C2=A0 61.954438][=C2=A0 T915] R10: 0000000000000000 R11: 000000000000000=
0 R12: 0000000000000246
[ =C2=A0 61.955367][=C2=A0 T915] R13: ffff8881242ef000 R14: 000000000000000=
1 R15: 0000000000000002
[ =C2=A0 61.956309][=C2=A0 T915] FS:=C2=A0 00007fba5a6106c0(0000) GS:ffff88=
81eec34000(0000) knlGS:0000000000000000
[ =C2=A0 61.957351][=C2=A0 T915] CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0: 0000=
000080050033
[ =C2=A0 61.958122][=C2=A0 T915] CR2: 000000001d2b1258 CR3: 000000010e5cf00=
0 CR4: 0000000000750ef0
[ =C2=A0 61.959056][=C2=A0 T915] PKRU: 55555554
[ =C2=A0 61.959501][=C2=A0 T915] Call Trace:
[ =C2=A0 61.959913][=C2=A0 T915]=C2=A0 <TASK>
[ =C2=A0 61.960262][=C2=A0 T915]=C2=A0 enable_irq+0x7e/0x100
[ =C2=A0 61.960769][=C2=A0 T915]=C2=A0 serial8250_do_startup+0x7ce/0xa80
[ =C2=A0 61.961395][=C2=A0 T915]=C2=A0 uart_port_startup+0x13d/0x440
[ =C2=A0 61.961981][=C2=A0 T915]=C2=A0 uart_port_activate+0x5b/0xb0
[ =C2=A0 61.962551][=C2=A0 T915]=C2=A0 tty_port_open+0x90/0x110
[ =C2=A0 61.963089][=C2=A0 T915]=C2=A0 ? srso_alias_return_thunk+0x5/0xfbef=
5
[ =C2=A0 61.963747][=C2=A0 T915]=C2=A0 uart_open+0x1e/0x30
```

The problem is that the first-port path still drops hash_mutex before
request_irq() completes:

=C2=A0 i->head =3D &up->list;
=C2=A0 mutex_unlock(&hash_mutex);
=C2=A0 request_irq(..., i);

After i->head is published, another port sharing the IRQ can still join the
chain and run the shared-IRQ THRE test while the IRQ core is starting the
interrupt for the first port.

So the lock has to cover the first request_irq() completion.=C2=A0 Covering=
 only
the i->head check and list_add() is not sufficient.

Test result: still fails with the Bugzilla reproducer.

Thanks,
Wang Zhaolong
