Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792661864;
	b=u/bALJK+J5p3L53BRG+cz48dQgMCzZqmMDaeSJMcsF2RZbpIL2MZ+Mjstmj7KK12ZhEE
	 6Kf7DcgGMWRTBPy4+FKR2QfQZuF10t+cqFTQzCxZNwonKGKOQtB2qvEA4z7gSbHuXRlP2
	 asYM2CykcEWD7taTGt0VP3p0HITeWjdi2N0LtyodLFGGWI4jF8/96Ew5SacoQaa//dpTK
	 UERVR2tM1JHQqVnyNecbTmJG6rO/AG61d7lXE5aPc4t/kLaDwfaDhNqvD3Mek76YDJJvX
	 4+Tqn/2sFIeD42RcEuONFRcgTr4/O5qftlAibJ5lLQ1p79Z7HT5OxnO/nAAAdHj/qsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792661864;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=nUxwt7K5bsuiMmRd9OYe+IwwtipVJpFPc2UsQ3cfjJg=;
	b=iGL3+txpl20b9AjneSsUCh37RokjAx0tKV20BW1p4D6V0d8HJZp8K7Xvrz2Pcm+NX0hr
	 oo5NsqvnA5GNY7n1iwo8DUze54NnlEXWb5WTomKg48Rr9lBWOLReu9sEDXx+WhzBsXHs/
	 yazDlW/mw50D2aIHipavd/kZ7mF4uTO5TV8lOT9Az2vKiNDGd2Co5AjPiNxUS6Ukv3yW1
	 /wtWjD9ompDWC9HjS85sLK6NECUPB1ASnYKicXbco+vsHo5MtewVW6QCckFMVx2opkXGD
	 dp0ehNDvvTaqVxTHBM/8TGpOp6rli+tQa6auTocEIcAIq6CO0v924dZm7hBYu3PPugA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JTR7Sptt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A606C606A31D;
	Thu, 22 Oct 2026 09:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JTR7Sptt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D40D1F000C1;
	Thu, 22 Oct 2026 09:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792661863;
	bh=nUxwt7K5bsuiMmRd9OYe+IwwtipVJpFPc2UsQ3cfjJg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JTR7Sptt/6NeFZ+GeCbeHAMybFfK3AmL+SbXlXHMYq2f8v8mtyhlzX3DNCQDEeumn
	 1yTWjzf8kUzNec7jHK7EWvqpsrRc+HySl2oof8UryRA6vneSyZyrKGYR1rugx40BMa
	 dllSUaVqf12Sze9sqcjQNIShCW61jpxrBDLeD0E0SK2BJtjhwLfC3zxTKsLuz17rxw
	 OQMeUXiDjqiipnwnlPH1CwZjihxfokk5pdFExjE0YjsNby0LxFe/WOw3pxU8X5XvGP
	 ZnnyGqenHybZWsGXVxkyColQDNqET7RhoI2XxZz714JZscccUfwD1oTwriavFcyTo6
	 bYYeF2g1U4zGw==
Message-ID: <sashiko-outbox-181270@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] usb: gadget: u_serial: pin ports while TTYs are
 installed
Reply-To: sashiko-reviews@lists.linux.dev
To: "Krystian Kaniewski" <krystianmkaniewski@gmail.com>, linux-usb@vger.kernel.org
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261022091359.1187468-1-krystianmkaniewski@gmail.com>
References: <6941beb7-8cae-4cc5-ba07-e1c8a8753fe1@mail.kernel.org>
 <20261022091359.1187468-1-krystianmkaniewski@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 09:37:42 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> A slab-use-after-free can occur when gserial_free_line() frees struct
> gs_port while it is still reachable through an installed TTY. The
> port->port.count value tracks successful opens, but it is zero before
> gs_open() and again after gs_close(), before TTY cleanup has finished.
> Teardown can therefore free gs_port while tty_init_dev() or release_tty()
> still accesses its tty_port.
>=20
> Manage gs_port lifetime with tty_port references. Take a reference in
> gs_install(), drop it in gs_cleanup(), and move the final free to
> gs_port_destruct(). Unregister the TTY device before dropping the owner
> reference.
>=20
> Keep each minor reserved until the old port is destroyed so an installed
> TTY for one generation cannot overlap a replacement at the same minor.
> Publish the new port before device registration so the cdev and add uevent
> [ ... ]
> Reported-by: syzbot+fe63e4d633540f230624@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3Dfe63e4d633540f230624
> Link: https://syzkaller.appspot.com/ai_job?id=3Dec789387-2e7b-4a8f-a7a1-a=
47bf7fa57f5
> Cc: stable@kernel.org
> Signed-off-by: Krystian Kaniewski <krystianmkaniewski@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022091359.1187=
468-1-krystianmkaniewski@gmail.com?part=3D1

