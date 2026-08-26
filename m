Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4033A7F5F
	for <linux-serial@vger.kernel.org>; Wed, 26 Aug 2026 06:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787726617; cv=none; b=CVSpNf9hlPP3eSGzawo7V2/YX27RqY1YT/PA/2SXTARIsyDAJgKS6j9DlD3ESStGR9mZQqQC47Cg0Os+XoPqcU9gXmDDMA/baAMeOtf7Q+n+drPeRzuOvcQKxIdPTiH7rH+LUaD4n7YNoPkcReU6ZEljvGvBoqM35Hy8bhAtfPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787726617; c=relaxed/simple;
	bh=toG6c8/w131u2Yc79cBtkAoxDia49aq2xRwcDlUdyek=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ducA54It/S9rVmj/x3JaqbKXtt6FCbLf3ckiYDuewL1WJpCAEnOuT2DhD2Mn2gLf1TpOL/Vl4sjsEVyqwCSCbePCj2loynk+wIe+4ainOJpJQMT8ciStsbUnZYVBu3ngkBpEU6/3cuFaZVPtEykp4rJIVt5hXjJJuQ2L6t2Uh6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KaTwBCv0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KaTwBCv0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B89C81F000E9;
	Wed, 26 Aug 2026 06:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787726615;
	bh=7gaDup9fMxeKy3yKm0qT7olRuyfsqLbM4gUnCcx036Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KaTwBCv0wgRfg1JDuXRZdhOLPnfhRbEYiY7MJ70p/1jMmKh/1MOh6RYioPjzKkVAG
	 frrmnlvd4xzz93s2NIIEw0cl3cyLhj6NoMmfCJ9e2vinPGrkEoxkanLlV0pxSz3x8i
	 acJTViSwqvorpxIqHxXcUGd/ql1guhh4jWj4hfq7LcL4RP74zHoWJdeox31DG5C4sd
	 OEJGueW/QbV18bKgxcfp9UKddmLpzwsGsKGQq1PrYSQnITUnnHCizdNFzffzPBQrVP
	 1FM7tha4gmNFhbHh+CABP5VJJesZpr72ll7QgTZPMzJcNx8t6rjHTKBN6SJXhoOt55
	 cfjwPNEsHF3tg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/1] tty: n_gsm: fix missing modem controls after DLCI
 open in convergence layer type 2
Reply-To: sashiko-reviews@lists.linux.dev
To: "D. Starke" <daniel.starke@siemens.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20260826063026.2472-1-daniel.starke@siemens.com>
References: <20260826063026.2472-1-daniel.starke@siemens.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 26 Aug 2026 06:43:35 +0000
Message-Id: <20260826064335.B89C81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Threads waiting in `gsm_control_wait` may hang forever in `TASK_UN=
INTERRUPTIBLE` if the GSM mux is concurrently shut down, also leading to a =
memory leak of the control object.
- [High] Lockless read-modify-write of `dlci->modem_tx` leading to lost vir=
tual V.24 control signals and broken hardware flow control.
--

commit 94af07ea4775d3698d9b5b43641a19696873abc0
Author: Daniel Starke <daniel.starke@siemens.com>

tty: n_gsm: fix missing modem controls after DLCI open in convergence layer=
 type 2

This commit updates virtual V.24 control signals by transmitting an empty d=
ata
frame in advanced option mode with convergence layer type 2. It introduces a
wait flag to gsm_modem_update() and gsm_modem_upd_via_msc() to control wait=
ing
for the MSC command response. The obsolete gsm_modem_send_initial_msc() is
also removed.

> diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
> --- a/drivers/tty/n_gsm.c
> +++ b/drivers/tty/n_gsm.c

[ ... ]

> @@ -4155,41 +4155,22 @@ static int gsm_modem_upd_via_msc(struct gsm_dlci =
*dlci, u8 brk)
>  		modembits[2] =3D (brk << 4) | 2 | EA; /* Length, Break, EA */
>  		len++;
>  	}
> +	if (!wait)
> +		return gsm_control_command(dlci->gsm, CMD_MSC, modembits, len);
>  	ctrl =3D gsm_control_send(dlci->gsm, CMD_MSC, modembits, len);
>  	if (ctrl =3D=3D NULL)
>  		return -ENOMEM;
>  	return gsm_control_wait(dlci->gsm, ctrl);
>  }

[Severity: High]
This isn't a bug introduced by this patch, but can threads waiting in
gsm_control_wait() hang forever?

If a thread queues a control command here and blocks in gsm_control_wait(),
and the physical serial port is closed concurrently, gsmld_close() will call
gsm_cleanup_mux().

gsm_cleanup_mux() calls timer_delete_sync(&gsm->t2_timer), which cancels the
retransmit timer without aborting the pending command. Does this mean the w=
ake
condition for wait_event(gsm->event, control->done =3D=3D 1) will never be =
met,
leading to an unkillable TASK_UNINTERRUPTIBLE task and leaking the control
object?

[ ... ]

> @@ -4265,7 +4246,7 @@ static void gsm_dtr_rts(struct tty_port *port, bool=
 active)
>  		modem_tx &=3D ~(TIOCM_DTR | TIOCM_RTS);
>  	if (modem_tx !=3D dlci->modem_tx) {
>  		dlci->modem_tx =3D modem_tx;
> -		gsm_modem_update(dlci, 0);
> +		gsm_modem_update(dlci, 0, true);
>  	}
>  }

[Severity: High]
This is a pre-existing issue, but does this lockless read-modify-write of
dlci->modem_tx risk losing virtual V.24 control signals?

If gsmtty_throttle() is called (often from softirq context when receive buf=
fers
fill up) to clear TIOCM_RTS, it updates dlci->modem_tx locklessly.

Concurrently, if a userspace ioctl calls gsmtty_tiocmset(), it also performs
a lockless read-modify-write on dlci->modem_tx.

If these updates overlap, could the throttle state change be overwritten and
lost? This might cause the local system to believe it has throttled the pee=
r,
while the RTS bit remains set, leading to receive buffer overflows.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260826063026.2472=
-1-daniel.starke@siemens.com?part=3D1
