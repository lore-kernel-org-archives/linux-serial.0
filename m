Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E33C1EB1AA
	for <linux-serial@vger.kernel.org>; Sun,  6 Sep 2026 16:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788710885; cv=none; b=QjpbpAnjIcgrM9vaymXXxW+OUdAyef0IoF9Cw6LKvTvToNhJRtKCx2iUgZzF+5/tuFYw5n0Qs4Uk9R6NhjI6iNZtDSbgZofRByCb7M2rNX7KId4mkL6GtfjEVHU1aLo5dh8lkuStB4OhIVTMs+3IZc7Nsh7PKRPUpSD/tQmeOBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788710885; c=relaxed/simple;
	bh=/w9CU2yxUJnubuQ1dk2MAaVPwqErsbarDDgHznez5b4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nUZetl/yqU5DPEzWfeCtMObXdIbUKFke/y0e/Z/8S8WCyRAWXlpxFMyycvMlnD9NW0P1KfiBlloPizRnsZyRCvr8EY/aMaCl3nFAPVIlrx9Q8fip6bXrNzKMDQk1unfZSn54AKi3M+g0gOxwGj+awcurHfIF+HC2R4GHYMlE4tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N/hA8TWu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N/hA8TWu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13C1E1F00A3A;
	Sun,  6 Sep 2026 16:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788710883;
	bh=SQNATHjjezlbycFEzO7rZaOcvrcDOldNvq0klqToASU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=N/hA8TWuFbzvZtPjNivga+kjs7EQQfP+o3bKF0HkV/2n1Dse4GjPjZFRZ+UW05Ruw
	 +e3SeD0aOwPUHbZnQ6qFi7jO0gH3C2iHgjfccLBPaeChZIODQNG+F1//Yd4VgT++fL
	 kCuAZ3aS0ZPAELKIYM5XfIdP+mBx90hGFg7RgGk1w96nnd1MNO/5EQsN8E3wgfsJ4p
	 Xyg0HU/trDmts7f9Lg9H19ut0mSBRMgIHYcXiHAPkKR87GDsBiSPMzngNGmaidTfdU
	 LwcSdD7xQuJRG7JNBwDR/5/+U0df3hQTHQAgt4sXmCZ1FH/lss9dcKqJJdnbfJp/We
	 gr7Aqx6c+MZTQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/5] tty: serdev: Export functions to pause receive_buf
 callback calls
Reply-To: sashiko-reviews@lists.linux.dev
To: "Markus Probst" <markus.probst@posteo.de>
Cc: ojeda@kernel.org, linux-serial@vger.kernel.org
In-Reply-To: <20260906-rust_serdev_probe_refactor-v1-1-69cdae0074ec@posteo.de>
References: <20260906-rust_serdev_probe_refactor-v1-0-69cdae0074ec@posteo.de>
 <20260906-rust_serdev_probe_refactor-v1-1-69cdae0074ec@posteo.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 06 Sep 2026 16:08:02 +0000
Message-Id: <20260906160803.13C1E1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] ttyport_resume_rx calls the producer API tty_flip_buffer_push from=
 the consumer side, racing with active producers and exposing uninitialized=
 memory.
--

commit bcc044ef1e478c63e3d04ef2d46ec10ebc5b78ee
Author: Markus Probst <markus.probst@posteo.de>

tty: serdev: Export functions to pause receive_buf callback calls
   =20
These functions will be used to simply the serdev rust abstraction. It
also contributes to the fixing of 2 race conditions in the serdev rust
abstraction.

> diff --git a/drivers/tty/serdev/serdev-ttyport.c b/drivers/tty/serdev/ser=
dev-ttyport.c
> index bab1b143b8a68..85ab454c2f13a 100644
> --- a/drivers/tty/serdev/serdev-ttyport.c
> +++ b/drivers/tty/serdev/serdev-ttyport.c
[ ... ]
> @@ -156,6 +161,31 @@ static void ttyport_close(struct serdev_controller *=
ctrl)
>  	tty_release_struct(tty, serport->tty_idx);
>  }
> =20
> +static void ttyport_pause_rx(struct serdev_controller *ctrl)
> +{
[ ... ]
> +}
> +
> +static void ttyport_resume_rx(struct serdev_controller *ctrl)
> +{
> +	struct serport *serport =3D serdev_controller_get_drvdata(ctrl);
> +	struct tty_struct *tty =3D serport->tty;
> +
> +	clear_bit(SERPORT_PAUSE_RX, &serport->flags);
> +
> +	if (test_bit(SERPORT_ACTIVE, &serport->flags))
> +		tty_flip_buffer_push(tty->port);

[Severity: High]
Does calling tty_flip_buffer_push() from the consumer context create a data
race on the tail->commit index?

Because tty_flip_buffer_push() commits unwritten buffer space (moving
tail->used to tail->commit), this could cause the consumer worker to read
uninitialized memory and pass garbage data to the receive_buf callback.

For example, if the serdev consumer calls serdev_device_resume_rx(), and
concurrently a UART hardware IRQ receives data and calls
tty_prepare_flip_string() (which increments tb->used).

If this call to tty_flip_buffer_push() executes before the UART driver writ=
es
data to the buffer, it commits the pre-incremented tb->used.

Is there a way for the consumer to wake up the worker without committing
unwritten data, rather than invoking producer APIs directly?

> +}
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260906-rust_serde=
v_probe_refactor-v1-0-69cdae0074ec@posteo.de?part=3D1
