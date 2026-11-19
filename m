Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795106941;
	b=aiO8hgMUGRcDZPIyzmBTWwhjBOjar6y8XmHGP000xu19hv8H8Jg/1xzUwsGypr+ijenD
	 VQzPrK9GKxaUqHUF7xxJz9p0X5gTcA8/LeA4+OH3ncAo7n1EqciZFnHwEmciGVS8ID3ey
	 V8zn78uXhLv6e/o1X/lm7/CDsCAjxYNoW0p+jtsGSEJ9UBZFY77KMyBsb3XdY0AIn5ci4
	 9gv2ihW2xBArRQwyiWLONaU1sQzXe/U7V9UWtZkcpQCVeYuhc1TozQNqAeanovAOejWk5
	 QMS1AvoZ32PvKh6FtP7M9ehOea/3DCKdLJjow7e5TfhkNj0Gy1kweguTRK8gZ4W4OzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795106941;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=UTE6svN2s0+nahwFp7g0bjP0WDonauhPr1pgtwrEhDk=;
	b=ygWpxmMz4JHkB9njf9qizwSVIojl8PfxfXh/d1SnvePLSzXlpdQmrf0Op2qb8o35bHN4
	 lt5qgfYTMUSItVkvpLJRw+AVS/W+TTWYDuCsbpi2HVnrQZbYV1EDj18bUwmyQmcHubAVZ
	 CgodzoCryE42NAuyS9xKQGHM2dUUjoIMbdUdPPEdqlqbPt8JXscu7XFk6QLDGTV78uWvA
	 TOeeZAUlXR7w69J8nK82jOP/JXIqLE2bzXbu5s+4IefqDkQNfEOC9uju17xwG5bShN1TK
	 2gm+l1TH7f+BmCZ5Im8siwaDor/i9+AR7JpGcZmePkrmY8jPGpZ9F8MV20Ub+NKk1DQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K3HCoZTG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E4D606A325
	for <linux-serial@vger.kernel.org>; Thu, 19 Nov 2026 16:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K3HCoZTG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 492591F000C7;
	Thu, 19 Nov 2026 16:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795106941;
	bh=UTE6svN2s0+nahwFp7g0bjP0WDonauhPr1pgtwrEhDk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=K3HCoZTGjOOiQUmmC+AVMP6ZqF4ASfadDTpO4kx25T82Dkiof7TaQZ2oUjThkKRof
	 4awHwe/DMjQJUVlskLVWCcuZS5DsfB+54MFX8QN5nrfc8plzrQxM/8mXHgUvSLra26
	 oXtKIYsaRksWlpgDfKhEoytnYOjFXhv6vKaAm9LBGxAQAB00PLROQUg2ZXyUJSmt02
	 GwQf6EQ1fyz5N6AcHwMsYmtZZsuTrhoHeUD6JfdQfl0HaPiO+FTDgGcg2SZdCXzgmU
	 70ZhgsWVSduOAQALTpBBYooGDZd9P04DZ+3YG/HQjlFJJv6UWOlDj6eegAAlule90x
	 WwuOy2soX2lgw==
Message-ID: <sashiko-outbox-223572@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] vt: allocate the screen buffers with kvzalloc()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arun Iyengar" <aiyengar1990@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261119-vt-kvzalloc-v1-1-5e5f59b37f61@gmail.com>
References: <20261119-vt-kvzalloc-v1-1-5e5f59b37f61@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 16:49:00 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [Critical] tty: vt: workqueue list corruption in vc_allocate() [1]
--

commit 8bede9243468256cdb289eb4eeab40a8e30c6847
Author: Arun Iyengar <aiyengar1990@gmail.com>

vt: allocate the screen buffers with kvzalloc()

This commit replaces kzalloc(), kmemdup(), and kfree() with kvzalloc(),
kvmemdup(), and kvfree() for virtual console screen buffers and saved
alternate screen buffers so large allocations can fall back to vmalloc.

> diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
> index 7dbc0072a40a9..cdc862be4d6fd 100644
> --- a/drivers/tty/vt/vt.c
> +++ b/drivers/tty/vt/vt.c

[ ... ]

> @@ -1483,10 +1483,10 @@ struct vc_data *vc_deallocate(unsigned int currco=
ns)
>  		con_free_unimap(vc);
>  		put_pid(vc->vt_pid);
>  		vc_uniscr_set(vc, NULL);
> -		kfree(vc->vc_screenbuf);
> +		kvfree(vc->vc_screenbuf);
>  		vc_cons[currcons].d =3D NULL;
>  		if (vc->vc_saved_screen !=3D NULL) {
> -			kfree(vc->vc_saved_screen);
> +			kvfree(vc->vc_saved_screen);
>  			vc->vc_saved_screen =3D NULL;
>  		}
>  		vc_uniscr_free(vc->vc_saved_uni_lines);

[Severity: Critical]
This problem wasn't introduced by this patch, but can vc_deallocate() leave
vc_cons[currcons].SAK_work pending [1] so that a subsequent
vc_allocate() corrupts the workqueue list?

When a Secure Attention Key event schedules vc_cons[currcons].SAK_work and
userspace immediately disallocates the console via VT_DISALLOCATE,
vc_deallocate() tears down the console without canceling SAK_work.  If the
console is reallocated before the worker runs, vc_allocate() calls
INIT_WORK() on the queued work_struct:

drivers/tty/vt/vt.c:vc_allocate() {
	...
	vc_cons[currcons].d =3D vc;
	tty_port_init(&vc->port);
	vc->port.ops =3D &vc_port_ops;
	INIT_WORK(&vc_cons[currcons].SAK_work, vc_SAK);
	...
}

Reinitializing an active work_struct overwrites its internal list pointers
and corrupts the global workqueue.

[1] https://sashiko.dev/#/bug/linux-5b343630-72f6-4db2-9969-c2c292698bcb

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119-vt-kvzallo=
c-v1-1-5e5f59b37f61@gmail.com?part=3D1
