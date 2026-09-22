Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A81255C32C
	for <linux-serial@vger.kernel.org>; Tue, 22 Sep 2026 15:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790090836; cv=none; b=l0e7G8qGs7dJ9QkKN1NCkOryPGN0OmfV+2AZuTav/+p7pbP/7ztNo7n/qcQjbKPQxXQmlXI7sNpQ5vNs4VAECYUHLAkaqwmKYMRrrg6QQmx1tRfCpPH0n8ysYZmJdv62CSYCzb+1DcxJ0bVwAz6z7S4pOYfE2aitP7850ZeK5wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790090836; c=relaxed/simple;
	bh=SNGtDKEyemIhCZHS4V6PsUwfSu0zagTEI/djkY7oH+M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=piXZm+VD3k0vLMP4NIeW8ELJPi1Er/n9Rw/0hnPuLDShUOjTZync4jsehEqYkccNdYqXnUbHyEiK/IHdeMMsaomzxmTPJTmo8lWteJR+DsS7PgTXgaYBjO5c9I3DUP48evhhYDaXU+kk/aBvz7QuKzf4P+RPvrK77fHp1Pgqzgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XFnhL+Xi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XFnhL+Xi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE6221F000FF;
	Tue, 22 Sep 2026 15:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790090834;
	bh=SNGtDKEyemIhCZHS4V6PsUwfSu0zagTEI/djkY7oH+M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XFnhL+XitBh/sHTbLIbW/5oB4w8txOQPbyDw0T1LT972URY+qgTZQg3GwJPOn324I
	 uTYZGTV6OF4eQuaA6bMgUPvws2alQMEjAqt/VLR+CRwbwZW/Hjl0Jt++mRuMlx+Ceu
	 2ARmLChNPK9Lg7i97HR9QPZ8bOPn9dBjeJG3IYVdCENNe7WFyrh+QNPT4DRQh5UjdO
	 0x+VeUd0jjoeQnd1gtde1UV25DOZVuf9no+ZbXMeOELpTP4cvSov5QezdgEXjDoLB/
	 LegBJDbp6EU51ZA3d5zcjpbEo/a6lgLzHjOptmmvnI/mCyT1HfUspRhRMYc1wC4ZYV
	 KV+RfGtSELUYQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] tty: rpmsg: close port lookup-to-get race
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sang-Hoon Choi" <csh0052@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20260923001647.1337001-1-csh0052@gmail.com>
References: <179000811428.1227592.8003229121862460039.idr-bug-84@gmail.com>
 <2026092154-anger-sensually-aae8@gregkh>
 <20260923001647.1337001-1-csh0052@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 15:27:14 +0000
Message-Id: <20260922152714.AE6221F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> rpmsg_tty_install() obtains cport from tty_idr before taking a port
> reference. rpmsg_tty_destruct_port() removes the entry under idr_lock
> and frees cport. If channel removal drops the last reference between
> idr_find() and tty_port_get(), the install path dereferences freed
> memory.
>=20
> The first-open path and channel removal can run concurrently. tty_mutex
> serializes TTY initialization, but rpmsg_tty_remove() does not take that
> mutex. tty_unregister_device() prevents later opens through cdev_del(),
> but cdev_del() does not wait for an open which has already entered the
> driver. Before rpmsg_tty_install() finishes, the port is not attached to
> the new TTY, so tty_port_tty_hangup() does not close this interval.
>=20
> RPMsg channel removal may be initiated asynchronously by the remote
> processor or transport. In the test, the local process only needs
> [ ... ]
> Fixes: 7c0408d80579 ("tty: add rpmsg driver")
> Reported-by: Changyul Lee <lcy8047@gmail.com>
> Link: https://lore.kernel.org/all/179000811428.1227592.800322912186246003=
9.idr-bug-84@gmail.com/
> Assisted-by: LLM
> Signed-off-by: Sang-Hoon Choi <csh0052@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923001647.1337=
001-1-csh0052@gmail.com?part=3D1

