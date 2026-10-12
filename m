Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443A34BA1D3;
	Mon, 12 Oct 2026 17:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791827456; cv=none; b=JjIS+w0bt1IfQdkXnnbngaAmX1Ivc1iOUt+hscy+fjN5E6dTEbuqYn6X+D7nMRdgO2tehRdtV+1eQ44izb7yzlko0spkVfhm8QJpwljZX4b6ypAnlEIKrnA6KHmiTwx5gauUuY7BOFcqXGY+8pOGLHPcVYeAtYeqj4rimL+Q3Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791827456; c=relaxed/simple;
	bh=sV9J93VRQ5LWjYZBxpR0YBG/TuVFimyHvdMWuprvAeE=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=hiqxyVf1sSff8A86uomTHmquDQ+eHO8YQQAShq+jbYw1TAKDg/+BiJ97RmLaNglYmfhRfmBjSU8aeKCxj+sQrNy8Yt/GleMIkmlQPesKvSX3iHh7hUKVB+wx0sWUau46rvkjkB1iyxdn/603MrftN5SGaLUo1/ckYwxJ3c4iNfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GBWeksnO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GBWeksnO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49B931F008A1;
	Mon, 12 Oct 2026 17:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791827453;
	bh=nPH9ZE9v33MHk+0119CZXqcrWJC/PIYuu3eRUpnsnUA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GBWeksnOIyYUwzYvgczQApk2Zc/dJceoxOwUHZqbIJZ1cg1PJzNm8UYVCc4Qc7oUi
	 3T8PNnlzLCbr8XZjd3MvllYT9ZdeqdY9EeHWjdj0EllhgIAFOfVjqY2AICZvoR5+B5
	 6gkz8qF/CWg32c1Ytt9z4//+sPN0pB4OZq7FJZA5SAxRNOaTpHo+Jrtft0QlqeYzSJ
	 e8w0VJAbJqThLgNcmctQihvUBtufAo2cxJaLlUTTeKaucQ6pjduppBm5mC6YBQKN1B
	 B3Jr7qKj36viltlS2VnliT2gNtPjMH6B2RGYjOEerKLDpX4aQkCZ1QETATockIfES/
	 jzSV/LjQUJT7g==
Message-ID: <sashiko-outbox-168497@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 10/11] tty: Add NVIDIA LSTP UART driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Adrian Ambrozewicz" <aambrozewicz@nvidia.com>
Cc: linux-usb@vger.kernel.org, linux-serial@vger.kernel.org
In-Reply-To: <20261012-lstp-usb-adapter-v1-10-aambrozewicz@nvidia.com>
References: <20261012-lstp-usb-adapter-v1-0-aambrozewicz@nvidia.com>
 <20261012-lstp-usb-adapter-v1-10-aambrozewicz@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 17:50:52 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] tty: silent data loss and false success on persistent firmware NACK
- [High] tty: Use-After-Free of ctx due to missing cancel_work_sync in dest=
ruct
--

commit dd0d55ce97ca80c844bb25609ee855296bb6dd01
Author: Adrian Ambrozewicz <aambrozewicz@nvidia.com>

tty: Add NVIDIA LSTP UART driver

This commit adds a tty driver for the UART channels of NVIDIA LSTP USB
adapters. The driver handles firmware configurations, modem control lines,
and coalesced transmit buffers sent over the USB channel.

> diff --git a/drivers/tty/lstp_tty.c b/drivers/tty/lstp_tty.c
> index 0000000000000..64894eca16ee1
> --- /dev/null
> +++ b/drivers/tty/lstp_tty.c
> @@ -187,27 +187,27 @@ static int lstp_uart_send_with_retry(struct lstp_ua=
rt_ctx *ctx, u8 cmd, const vo
>  	int attempt;
> =20
>  	for (attempt =3D 0; lstp_status =3D=3D LSTP_NACK && attempt < LSTP_UART=
_NAK_MAX_RETRIES;
>  	     attempt++) {
>  		if (attempt)
>  			fsleep(LSTP_UART_NAK_RETRY_DELAY_MS * USEC_PER_MSEC);
> =20
>  		ret =3D lstp_request(ch, cmd, payload, len, NULL, 0, NULL, &lstp_statu=
s);
>  	}
> =20
>  	if (ret && ret !=3D -ENODEV)
>  		dev_warn_ratelimited(ch->dev,
>  				     "%s: ch_%d: Failed to write after %d attempt(s) (%pe)\n",
>  				     __func__, ch->ch_id, attempt, ERR_PTR(ret));
> =20
>  	return ret;
>  }

[Severity: High]
If the firmware persistently responds with LSTP_NACK and the loop exhausts
all LSTP_UART_NAK_MAX_RETRIES, does this exit with ret equal to 0 instead of
an error code? When lstp_request transmits successfully over USB but the
firmware NACKs, it populates lstp_status with LSTP_NACK and returns 0. If
ret remains 0, the error warning is bypassed.

> =20
>  /* @tx_snapshot is written only here, so it stays stable across the retr=
y loop. */
>  static void lstp_uart_write_work(struct work_struct *work)
>  {
>  	struct lstp_uart_ctx *ctx =3D container_of(work, struct lstp_uart_ctx, =
write_work);
>  	size_t len;
[ ... ]
>  	int ret =3D lstp_uart_send_with_retry(ctx, LSTP_UART_CMD_WRITE, ctx->tx=
_snapshot, len);
> =20
>  	scoped_guard(spinlock_irqsave, &ctx->write_lock) {
>  		ctx->tx_in_flight =3D false;
>  		if (!ret)
>  			WRITE_ONCE(ctx->iocount.tx, ctx->iocount.tx + len);

[Severity: High]
Does this treat the NACK timeout from lstp_uart_send_with_retry as a
success? Because ret is 0, it appears the driver will increment iocount.tx,
clear tx_in_flight, and permanently discard the tx_snapshot buffer. Could
this cause silent data loss under backpressure, falsely informing the TTY
layer that bytes were successfully sent?

[ ... ]
> @@ -389,17 +389,17 @@ static void lstp_port_shutdown(struct tty_port *por=
t)
>  {
>  	struct lstp_uart_ctx *ctx =3D container_of(port, struct lstp_uart_ctx, =
port);
> =20
>  	cancel_work_sync(&ctx->write_work);
> =20
>  	/*
>  	 * Normally already empty. What survives the close drain and the hangup
>  	 * flush is a drain still stalled when closing_wait expires: bytes queu=
ed
>  	 * with no worker after the cancel above, so write_room() would stay
>  	 * short by that much for the life of the port.
>  	 */
>  	scoped_guard(spinlock_irqsave, &ctx->write_lock) {
>  		ctx->coal_len =3D 0;
>  		ctx->tx_inflight_len =3D 0;
>  	}
>  }

[Severity: High]
Since cancel_work_sync is called outside the write_lock critical section,
is it possible for a concurrent lstp_tty_write to schedule new work
immediately after the cancellation completes?

[ ... ]
> @@ -490,20 +490,20 @@ static ssize_t lstp_tty_write(struct tty_struct *tt=
y, const unsigned char *buf, size_t count)
>  {
>  	struct lstp_uart_ctx *ctx =3D tty->driver_data;
>  	struct lstp_channel *ch =3D ctx->ch;
[ ... ]
>  	count =3D min(count, room);
>  	memcpy(ctx->coal_buf + ctx->coal_len, buf, count);
>  	ctx->coal_len +=3D count;
> =20
>  	schedule_work(&ctx->write_work);
> =20
>  	return count;
>  }
[ ... ]
> @@ -407,9 +407,9 @@ static void lstp_port_destruct(struct tty_port *port)
>  {
>  	struct lstp_uart_ctx *ctx =3D container_of(port, struct lstp_uart_ctx, =
port);
>  	struct lstp_channel *ch =3D ctx->ch;
> =20
>  	lstp_free_minor(ctx);
>  	kfree(ctx->tx_snapshot);
>  	kfree(ctx->coal_buf);
>  	kfree(ctx);

[Severity: High]
Is a final cancel_work_sync needed here before freeing ctx?

If lstp_port_shutdown cancels the work locklessly, a concurrent
lstp_tty_write could acquire write_lock, see the channel as still connected,
and call schedule_work on ctx->write_work.

If lstp_port_shutdown then acquires write_lock, clears the lengths, and
returns, the TTY port could eventually be put and destructed. Without a
final cancel_work_sync in lstp_port_destruct, would the queued work execute
on the freed ctx memory, causing a use-after-free crash?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012-lstp-usb-a=
dapter-v1-0-aambrozewicz@nvidia.com?part=3D10
