Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793080614;
	b=Z65jHKTuShnXYU0CGWETu98nJXihIHJInnueUUd5XiEjN7iDC4V719t7j3jsTYZfJY4S
	 NTwQBvy7WNLOC8YUt2Sz0AdmCeSQPC52pO2U3bPMnLA56JVncB2kAZ62KtO8iqdZYFyCY
	 /Tg7F6+vtt3w1g6YGSeOxuSO1+Xpy8/nInU+IaYkiIl2xfzoBfVJverms4l0YV2F9H4dy
	 Fn3VjDb8wrK7VH1Hm+pKD0z26QYuwxR2NO0BuffaAsEqZIUH/9ugGTUGAOUu+wKjPFc/5
	 rGj58rVAQ8mbOT7dsZArBcRjbPsiUR7jJpHBC4MBxSBwKOekqGVVNS3rJziopd9sl5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793080614;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=QN8oxWLdLEw9peAXXsLw8QZSEZvNg90iKcaYq0zFZV4=;
	b=Y343a8uqxjixa90fZBnhj6soDNZamj6bjGyoUd0H7IUHIiJsFlpSvfBFqASoPDETJ5FF
	 1C67tELmGY5kIVGXGnvy3wmPxKr0G+O7mCOONbHzOxKFueM+/VYHjwpV0+cVZLVzQyFAf
	 FwkDxh1+vhuApSdTdO43aNXTilvHV0ofUQQQT2VB0JX/h1Vx2kMIXRi7RAmBqKFAwcXZB
	 ZscSIhyhwRcsPbOXaK0z7kUIxQbFGzwZXvcbmBkDJN4dXQ61fGMO0CAidHE2TiY81ns+m
	 GOUSAitzydqWMuocrrCjQrLCB7S/RtCa9C0Gy5vS8WdCax3JTZZ7YGsfPF2a1Sw3hNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JnOG5Y1Q;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4C2606A31A
	for <linux-serial@vger.kernel.org>; Tue, 27 Oct 2026 05:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JnOG5Y1Q
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 261A61F01828;
	Tue, 27 Oct 2026 05:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793080613;
	bh=QN8oxWLdLEw9peAXXsLw8QZSEZvNg90iKcaYq0zFZV4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JnOG5Y1QjmMWFuNFLX2nbe/1YRbY1u2cRQpLH/w+1ZwEA3sjqHtkTUORfh12bpH/d
	 Hxm25A2DIlHqmuY1NnfbmIojavLJBknn4qV3UjpUJrmX2s56js2sRt1amNcnd9xx+4
	 5F1itD5Hoib7sK2UPUKi1/aHvBjIWBxya6NbP2IrwWArI/b6aKdy9cZR6/CqHdFwbB
	 4oJVnv2M4qTvAN6gxikn2gBrTK8Syiuol8ZXxSOKDLA4D21HKRZ4++fLZ0kyy1VcHq
	 DNepGa/esz2fgtSfMS3JUNrBHtrR/kzmMZo1uLmNnm8fI8kHx1UQuia8J8evEETVzO
	 kKH6LH+/lba3A==
Message-ID: <sashiko-outbox-186146@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] tty: discard flip-buffer input for TCSAFLUSH
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hungyu Lin" <dennylin0707@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261027054304.35543-1-dennylin0707@gmail.com>
References: <20261027054304.35543-1-dennylin0707@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 05:56:52 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] tty: missing tty_unthrottle() in set_termios() on TERMIOS_FLUSH
--

commit 757d2dda2b0d44401d4d977f6413afe8f7669c45
Author: Hungyu Lin <dennylin0707@gmail.com>

tty: discard flip-buffer input for TCSAFLUSH

This commit updates set_termios() to call tty_buffer_flush() instead of only
invoking the line discipline flush_buffer callback when TERMIOS_FLUSH is se=
t,
so pending input in the tty flip buffers is also discarded on TCSAFLUSH.

> diff --git a/drivers/tty/tty_ioctl.c b/drivers/tty/tty_ioctl.c
> index 90c70d8d14e3a..45cb77185dbb2 100644
> --- a/drivers/tty/tty_ioctl.c
> +++ b/drivers/tty/tty_ioctl.c
> @@ -496,8 +496,8 @@ static int set_termios(struct tty_struct *tty, void _=
_user *arg, int opt)
> =20
>  		ld =3D tty_ldisc_ref(tty);
>  		if (ld !=3D NULL) {
> -			if ((opt & TERMIOS_FLUSH) && ld->ops->flush_buffer)
> -				ld->ops->flush_buffer(tty);
> +			if (opt & TERMIOS_FLUSH)
> +				tty_buffer_flush(tty, ld);

[Severity: High]
Should this path also call tty_unthrottle(tty) after flushing the buffers,
similar to how __tty_perform_flush() handles TCIFLUSH and TCIOFLUSH?

drivers/tty/tty_ioctl.c:__tty_perform_flush() {
	switch (arg) {
	case TCIFLUSH:
		if (ld && ld->ops->flush_buffer) {
			ld->ops->flush_buffer(tty);
			tty_unthrottle(tty);
		}
		break;
}

When a terminal using N_TTY fills ldata->read_buf and queues additional byt=
es
in the flip buffers, n_tty_receive_buf_common() sets ldata->no_room and cal=
ls
n_tty_check_throttle() -> tty_throttle_safe(), which sets TTY_THROTTLED and
throttles the underlying driver (or on a PTY pair, fills port->buf up to
mem_limit so the master blocks on write_wait).

Previously, set_termios() only called ld->ops->flush_buffer(tty), leaving t=
he
flip buffer data intact to refill ldata->read_buf via flush_to_ldisc(), so a
subsequent n_tty_read() would still see input_available_p(tty, 0) and reach
n_tty_check_unthrottle(tty).

With tty_buffer_flush(tty, ld) now emptying both the flip buffers and
ldata->read_buf without calling tty_unthrottle(tty), a subsequent n_tty_rea=
d()
sees no available input and blocks in n_tty_wait_for_input() before reaching
n_tty_check_unthrottle(tty):

drivers/tty/n_tty.c:n_tty_read() {
		if (!input_available_p(tty, 0)) {
			up_read(&tty->termios_rwsem);
			tty_buffer_flush_work(tty->port);
			down_read(&tty->termios_rwsem);
			if (!input_available_p(tty, 0)) {
				int ret =3D n_tty_wait_for_input(tty, file, &wait,
							       &timeout);
				if (ret <=3D 0) {
					retval =3D ret;
					break;
				}
				continue;
			}
		}
}

Can this leave a throttled serial/USB-serial device unable to receive new
input to wake the reader, or leave a PTY master permanently blocked on
write_wait after tcsetattr() with TCSAFLUSH?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027054304.3554=
3-1-dennylin0707@gmail.com?part=3D1
