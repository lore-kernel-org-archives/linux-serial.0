Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793749854;
	b=LUrdL95v5Wf82Dc3OOXTYstJjquJoOm1WUhUN3GGm/wR8vI59jvNfLloVoR4GVSciiyK
	 JTCC66VTU2bJABTUCWvckgNzjr13aqnkU5VDCd2rtKAe7hYEq/4KEyZbZ2FOLIeQm60Og
	 6mwfT51bBo6RzDkckiWD3OR8D4sY2w00h249vbFLCy1TyezJEbaBWeGNKtfH2MAD0LHIH
	 RgLxZKDFTEGLwPmxAPZiE01v2npCuzXBzA5Pu1EbHknDeCZfFPT/0ySWBVdBjkuOgl6A5
	 VXa44O3BeevDn+QCU+ofhFlUsnHMKUzyTHcpxaQf1nckTqcG4StN2+57kiAfNBsCJaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793749854;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=BQjmh7lUaRXkVxdPCN17GuWDcpO/9hO0G1rMr3YpGAA=;
	b=Ik8aJ9nl+ZVbF1+u4cPm/cDJE+d/uKqM0BPiq1NAHjPvZ6qvl/1suWuVAm3/VPnF8Gm0
	 nQvvf0aHryfr6MhsQdNcFiTGW5ko1w1bae1ENAhZYJ/entXkGrU8FuGT6v8HWyQMiKP13
	 tDV/7NQeNF5yKFSe0dFLSYCBKtJHdssWHdiPi4OLei9lQON9BTEvGFhJ2BxsNBNhFb4DH
	 li+1sE2H4ErBesd/eE1Ilx3WEAweUo/vQ4AeOZaQYNqbCeuqUZiPu7Y2THeE/xWzEHeJP
	 vmXIyLs2+VtrhXyLHoRdEAhF3+L00iu53zRWVqnFrsKRwNwuYX6wzxJNF8hmRotqvsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LlcG3QXX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12141606A33F
	for <linux-serial@vger.kernel.org>; Tue,  3 Nov 2026 23:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LlcG3QXX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 899CB1F00919;
	Tue,  3 Nov 2026 23:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793749853;
	bh=BQjmh7lUaRXkVxdPCN17GuWDcpO/9hO0G1rMr3YpGAA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LlcG3QXXudfzTJPrZijcchGeP08Ia/RwbvKIUODxeFPVxSm7jqtGhHJG11LmF1ojz
	 4W+yqybL+4u9nYf+r67YsZNVZIcpu/S3PbmWpGwHKl/e9oobm966d1A6nUW2NHdu3Z
	 4wgHmMrzIigCf0oFbk16x1jvFGSXFLdl6X+4xJPIwMq3f7kNGI0feag6MJLS3RdnBg
	 JC4m3y79XggHNWJ9R0vNTnw6mFDFk6BgUVSzC0tihgHW35ANTIuJtwqAN/MdLbKBxq
	 1HXi11mN1Q2lnKytTyBD4+Hn5iHbZdv2VhtL+zkgFJY63U2672yh7lNj9b+Ad4Lhtn
	 DL5BM2yes+GDg==
Message-ID: <sashiko-outbox-196241@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] serial: 8250: fix use-after-free of IRQ action name on
 port removal
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joas Antonio dos Santos" <joasantonio108@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261103-serial-8250-irq-uaf-v1-1-24223dcc3119@gmail.com>
References: <20261103-serial-8250-irq-uaf-v1-1-24223dcc3119@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 23:50:53 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> From: Joas Antonio dos Santos <joasantonio108@gmail.com>
>=20
> serial_link_irq_chain() passes up->port.name directly to request_irq().
> The IRQ subsystem stores this pointer in irqaction->name without copying
> the string.
>=20
> When the port that originally called request_irq() is removed while
> other ports still share the same IRQ:
>=20
>   1. serial_unlink_irq_chain() removes the port from the shared list
>   2. Since other ports remain, free_irq() is NOT called
>   3. irqaction->name still references the removed port's name string
>   4. serial_core_remove_one_port() frees uport->name (kfree at line 3292)
>   5. irqaction->name becomes a dangling pointer
>=20
> [ ... ]
> Reported-by: syzbot+bc6b37960b1d13f68f9f@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3Dbc6b37960b1d13f68f9f
> Fixes: f7048b15900f ("tty: serial_core: Add name field to uart_port struc=
t")
> Cc: stable@vger.kernel.org
> Signed-off-by: Joas Antonio dos Santos <joasantonio108@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103-serial-825=
0-irq-uaf-v1-1-24223dcc3119@gmail.com?part=3D1

