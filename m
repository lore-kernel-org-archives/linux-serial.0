Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE902F7EE7
	for <linux-serial@vger.kernel.org>; Thu,  1 Oct 2026 17:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790874735; cv=none; b=Z6OpSCw4w6GJtGnMOtwrVRpjudSN4cUZ6YQGUEeRMqM1kWl/5+BAVU5kwVbPaK2K+HA5VEY390uX4jUu05uwUor6t2mC6aaafjPMMMBsgmmFzmexWk7mklBJqU6HixTTTikC8PQgXqXcG0XxcCVEVfApsMv6oyEgJ8QCno/oIpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790874735; c=relaxed/simple;
	bh=v56FAGdnn5fqH6ehk3IrB7DeP25LUPguoeNACe0L5vI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rQcWdtwplqIJ3tmkAWijEOQaquir+7VCz6FMTUdRasGUUmCk7T5EwWeBwCHzvBGsPiQWEzqUyIlYEhCf3wCpYEWScIgW2+2hx6Bi55gH+gMVsuSHbd26dU4xSPHiLbqydjQ5uRX8dPG/7dfF3fpMJVfmax8EKWh/O18WzSbnbS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m4tPmvCF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m4tPmvCF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29CFB1F000FF;
	Thu,  1 Oct 2026 17:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790874726;
	bh=BoHFsLwDHloPKbIW64lOfb0cqCyxHnnrwTCb2/14KyU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=m4tPmvCFGekHIDwev9jD7ToyRft3xFi6JSYofPbIJnFDrtoWgg4tbAnKxUVvoQSuG
	 PXU1z3Lhh62Igamd45YxDLc+2iHe8InM0eAL7zjrScDCsXj/F6cLq/eovH14o0WOPn
	 32PsotNjRIjfWMYeV8t4LDOLtxucFq9KTejGMNL7R7TCsQrs8cldLAvCFmUIqPvu27
	 tuDweWas4DDU7qxI96h4L8zAKcme309cMt+uuUFD0otEhZoOdL/gxN1oCzCfy/Dxr+
	 5wXNN0bU3hAVcViilp+8RJK+RLb1/5mJvkfKvLv6ectBFc8iGeb5zd7bGJNGNNP5NI
	 3aTc3WyOJVosw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] tty: pty: preserve open slaves after rejected locked
 open
Reply-To: sashiko-reviews@lists.linux.dev
To: "Akira Patafio" <kokokoala4211@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261001165552.2439-1-kokokoala4211@gmail.com>
References: <20261001165552.2439-1-kokokoala4211@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 17:12:05 +0000
Message-Id: <20261001171206.29CFB1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] tty: NULL pointer dereference in pty_open and pty_close
- [Medium] tty: logic error tearing down active kernel PTY clients
--

commit f8d6871959bd3ab3965cd6aaf18087ecb7ef411f
Author: Akira Patafio <kokokoala4211@gmail.com>

tty: pty: preserve open slaves after rejected locked open

This commit tracks which PTY slave files were successfully opened to avoid
spurious IO errors or premature master closures during locked slave opens.
A selftest is also added to verify this behavior.

> diff --git a/drivers/tty/pty.c b/drivers/tty/pty.c
> index cc7f7091ed9a2..3cc149445993e 100644
> --- a/drivers/tty/pty.c
> +++ b/drivers/tty/pty.c
> @@ -46,12 +46,29 @@ static DEFINE_MUTEX(devpts_mutex);
> =20
>  static void pty_close(struct tty_struct *tty, struct file *filp)
>  {
> +	struct tty_file_private *priv =3D filp->private_data;

[Severity: High]
Can this unconditionally dereference a NULL pointer? In-kernel TTY clients
such as speakup or serdev can manually invoke the driver's close callback
using tty->ops->close(tty, NULL).=20

If an in-kernel client opens a PTY, calling pty_close() with filp =3D=3D NU=
LL
will cause a kernel panic here.

> +	struct tty_file_private *other;
> +	bool another_open =3D false;
> +
>  	if (tty->driver->subtype =3D=3D PTY_TYPE_MASTER)
>  		WARN_ON(tty->count > 1);
>  	else {
> -		if (tty_io_error(tty))
> +		/* tty_release() also calls close after an unsuccessful open. */
> +		if (!priv->pty_opened)
> +			return;
> +		/* tty->count includes opens that have not succeeded yet. */
> +		spin_lock(&tty->files_lock);
> +		priv->pty_opened =3D false;
> +		list_for_each_entry(other, &tty->tty_files, list) {
> +			if (other->pty_opened) {
> +				another_open =3D true;
> +				break;
> +			}
> +		}

[Severity: Medium]
Will this loop correctly account for in-kernel PTY clients?=20

If a client like speakup has the PTY open, its open is not backed by a
struct file and is absent from tty->tty_files.

> +		spin_unlock(&tty->files_lock);
> +		if (another_open)
>  			return;

If an in-kernel client is the only remaining open, another_open will
evaluate to false here. Could this prematurely tear down the master
connection despite the kernel client still actively using the slave?

[ ... ]

> @@ -223,14 +240,23 @@ static int pty_open(struct tty_struct *tty, struct =
file *filp)
> =20
>  	if (test_bit(TTY_OTHER_CLOSED, &tty->flags))
>  		goto out;
> +	/* A rejected open must not disrupt already-open slave descriptors. */
>  	if (test_bit(TTY_PTY_LOCK, &tty->link->flags))
> -		goto out;
> +		return -EIO;
>  	if (tty->driver->subtype =3D=3D PTY_TYPE_SLAVE && tty->link->count !=3D=
 1)
>  		goto out;
> =20
>  	clear_bit(TTY_IO_ERROR, &tty->flags);
>  	clear_bit(TTY_OTHER_CLOSED, &tty->link->flags);
>  	set_bit(TTY_THROTTLED, &tty->flags);
> +	/* Record a successful open before another slave can close. */
> +	if (tty->driver->subtype =3D=3D PTY_TYPE_SLAVE) {
> +		struct tty_file_private *priv =3D filp->private_data;

[Severity: High]
Can filp be NULL here?=20

Similar to pty_close(), in-kernel clients can call tty->ops->open(tty, NULL=
).
This could cause a kernel panic due to a NULL pointer dereference.

> +
> +		spin_lock(&tty->files_lock);
> +		priv->pty_opened =3D true;
> +		spin_unlock(&tty->files_lock);
> +	}
>  	return 0;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001165552.2439=
-1-kokokoala4211@gmail.com?part=3D1
