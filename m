Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794907415;
	b=aPFEvNtQxWOsdqdYYWTn/zWBRbOSoOuMvAeOK/kK9mOIJfDY+V/o5PeeExic3c0xh3lR
	 XW/CgXCJXc2IHytSrSMqq6AYnp/2GqET8R+mupPt00I6R0j+kJa9mlK8rn/5x2SY5+kxX
	 sZ6+PCAJOtrunCe3S7+DDomJYlly7XUngzk7vJ2nbLYXtbHamM+k+3oakuHYf7aLy8f2z
	 FNakO0aVwI//B2AcefGmz/cRRoR8befIo0OqARV8DLdP1d6sEXxbObO42rIIeLnO3kF2E
	 kdKi1PzhoE6csrxj/wRRhBTZrfOPHoNNw6vKlI5CRxunj6kE/bdP4XwOFoiR2nicxkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794907415;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=WQgcQGYYKn8ae6mZdl1JE2+SueL4iYt7A2bpDNB9b18=;
	b=bdgzTFFCdWRGGSGHtaFLUg1UaxY0NVll7PwM9PKJMK9r7U4yTLn2zEkYhee8LlSoMOWY
	 DKqwMe0IsGjYfPnJ0S0/gOlZZjc3MZdlYd/oxQaLHQTCkF1CmwjKBjIiMyi1BM/ePx49P
	 vIPOIHy5cBaPTdMScRsNZx3WD6k4Lh7VFPKcLieED+zJu3s3u6TTm0GD+x7SleZX2MC+C
	 n6lCLHrpXlo9MjJUT3jzmOld3jOW+WlxHBD9OVM8izP2vkwVssLZnaJX8v+9wXxisCG2Q
	 WqPxkb7nWq+cn2TyyHBPb6SS7Qq+oAPMkskwkRdDawKmvKgC74JmbrzzR+WrTssD9lg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JqmqpIOi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D598606A323
	for <linux-serial@vger.kernel.org>; Tue, 17 Nov 2026 09:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JqmqpIOi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C33EC1F000C6;
	Tue, 17 Nov 2026 09:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794907414;
	bh=WQgcQGYYKn8ae6mZdl1JE2+SueL4iYt7A2bpDNB9b18=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JqmqpIOiiy/99pbq9Y1ACXixlSCl/Y3xQssEpQwd+tivh8j2WO6JZs36rVwp3tyNF
	 RGpnKz+RMVPsjlrWyuAv00uAUKLo127gc2WJcmVm1iF9bHJ+JOZXFqu+Izeb1TMFDT
	 pPSjZ14wok/fo8K08eOuBnC5zCN05zZWO0px5rXjqmiNfTuN59PZqTYIyIxZ4PGsWG
	 GK5Mo17La17hwf6CxAWI3ocIwAsX75DeUIQcOoxLnReBr8JRm2Krqft6uMRDT4WQIZ
	 +aTBXmM1sf7mdkvlCYjYrQf4RQ8bMHc6/FvD8YOEf7hIRNptHQQK3kPA62Gj4/Tcxy
	 8xzot/BpcCFUg==
Message-ID: <sashiko-outbox-218476@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] tty: vt: protect tty lifetime in keyboard path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Haoli Zhang" <26031212468@stu.xidian.edu.cn>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261117091207.3950936-1-26031212468@stu.xidian.edu.cn>
References: <20261117091207.3950936-1-26031212468@stu.xidian.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 09:23:34 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> The KASAN report reaches stop_tty() through fn_hold(). That handler
> reads vc->port.tty and uses it without holding a tty reference. It runs
> under kbd_event_lock, while con_shutdown() clears the port association
> under console_lock; these locks do not protect the tty lifetime.
>=20
> Use the tty_port_tty guard in fn_hold() and keep the reference until
> start_tty() or stop_tty() returns. Keep kbd_keycode()'s existing tty
> reference interval unchanged.
>=20
> Use tty_port_tty_set() when installing and clearing the association so
> that updates use the same port lock as guarded reads and the port holds a
> tty reference while the association is active. A keyboard operation
> that already obtained a reference can then finish safely after shutdown
> clears the association.
>=20
> Reported-by: syzbot+2932e8970a6398db95c3@syzkaller.appspotmail.com
> Closes: https://syzbot.org/bug?extid=3D2932e8970a6398db95c3
> Co-developed-by: Jinning Zhang <25031212117@stu.xidian.edu.cn>
> Signed-off-by: Jinning Zhang <25031212117@stu.xidian.edu.cn>
> Co-developed-by: Bin Yu <byu@xidian.edu.cn>
> Signed-off-by: Bin Yu <byu@xidian.edu.cn>
> Signed-off-by: Haoli Zhang <26031212468@stu.xidian.edu.cn>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117091207.3950=
936-1-26031212468@stu.xidian.edu.cn?part=3D1

