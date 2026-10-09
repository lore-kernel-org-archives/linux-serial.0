Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50273E40E9;
	Fri,  9 Oct 2026 07:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791529881; cv=none; b=uQMmsg75pb7BjhFH77vevPbAOOVk7Muv82+cIEsfUDhIPmi4vwkOMzEgrmQBkV50mw/JcDshM7Hbe5bx2IrxD4bm+dbcAcswBFWe+XTHyy4euaOCBugaUrEiZxLdLhkDpENuic33rOhK7FhWY4hDxDz170jZPaLZph8K1MLk8+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791529881; c=relaxed/simple;
	bh=VeaCOJa2KJHbBXl++lNveOazRzweLjwBLscMoaSYULE=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=jHuSEP8w+9byUAkaHTbPSqeoqxsYJedH4V/sqybh0G8jMQBjfU3kva/rF2LZK6g9AZpDIGmgV1kkWMH976LaiGLQnpImGBS56UordFgGRl3V8ys5Zq6vM1ZT/8mXQtERw6chMckvWn5GMm6B7TM9HzFOyQHOG6PjSMcnVsQFkMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D57LjQo5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D57LjQo5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 180D71F000FF;
	Fri,  9 Oct 2026 07:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791529880;
	bh=j/fvdRMCyGry5Y+G1XdxEVCtENVnmQ2hdtRGGT3cwVs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=D57LjQo51mpiDQMQDXZX6RJXMiK+O37XzywxxxddL/AOEPYuFFd/xiDpQkAQydkO9
	 rEnOkXslDFogfNyMEoHHV1KO9oIcyL/UxW33fTHzOAnGjzQHq29arpjN9PUD6VwEyu
	 IE/G2AqWf+LZ1o5Qh0XASDTEDhLIDK1ZmCKjK4pl9vmlfW2Ito/Fce3htns0aHFjoe
	 AQzz6xjZOv+tSuPBjFopcPqfbG9hNQeKk9jNrFplUP248vwg2Vr1eYId/h2R1v02Rk
	 ilbdbmjDhyVrbqvyZzbvOMvZ4zXglclIexpF+149HytHqYs9X73NMr15/WYYq1Vw04
	 vsAeSbIkBrMLA==
Message-ID: <sashiko-outbox-164980@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/4] dmaengine: qcom: gpi: Ignore cancelled
 transfer-completion events
Reply-To: sashiko-reviews@lists.linux.dev
To: "Naresh Maramaina" <naresh.maramaina@oss.qualcomm.com>
Cc: vkoul@kernel.org, linux-serial@vger.kernel.org, Frank.Li@kernel.org, dmaengine@vger.kernel.org
In-Reply-To: <20261009-add-gpi-dma-support-for-uart-v1-3-c69e728df686@oss.qualcomm.com>
References: <20261009-add-gpi-dma-support-for-uart-v1-0-c69e728df686@oss.qualcomm.com>
 <20261009-add-gpi-dma-support-for-uart-v1-3-c69e728df686@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 07:11:19 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] dma: qcom/gpi: dropped transfers during pause due to CANCELLED e=
vents
--

commit 4a0fc29a2e60fc21d8e540e5657013e4f69245b6
Author: Naresh Maramaina <naresh.maramaina@oss.qualcomm.com>

dmaengine: qcom: gpi: Ignore cancelled transfer-completion events

Channel cancellation can generate a transfer-completion event marked
with the cancellation status bit. If the event is processed after
the channel has left ACTIVE_STATE, it triggers a false error report.

Ignore transfer-completion events marked as cancellation events when
the channel is no longer active. Continue to report all other
unexpected completion events received on inactive channels.

> diff --git a/drivers/dma/qcom/gpi.c b/drivers/dma/qcom/gpi.c
> index f72b80bf5553c..7e1fa8d249024 100644
> --- a/drivers/dma/qcom/gpi.c
> +++ b/drivers/dma/qcom/gpi.c

[ ... ]

> @@ -1022,7 +1024,15 @@ static void gpi_process_xfer_compl_event(struct gc=
han *gchan,
> =20
>  	/* only process events on active channel */
>  	if (unlikely(gchan->pm_state !=3D ACTIVE_STATE)) {
> -		dev_err(gpii->gpi_dev->dev, "skipping processing event because ch @ %s=
 state\n",
> +		/*
> +		 * A channel cancel may generate a transfer-completion event after
> +		 * the channel has left ACTIVE_STATE. Ignore such events to avoid
> +		 * reporting a spurious error.
> +		 */
> +		if (compl_event->status & GPI_COMPL_STATUS_CANCELLED)
> +			return;
> +

[Severity: Medium]
Will this properly ignore the cancelled event during a pause?

When a client calls gpi_pause(), it stops the channel which generates a
CANCELLED event, but it leaves gchan->pm_state as ACTIVE_STATE:

drivers/dma/qcom/gpi.c:gpi_pause() {
    ...
	for (i =3D 0; i < MAX_CHANNELS_PER_GPII; i++) {
		ret =3D gpi_stop_chan(&gpii->gchan[i]);
    ...
	write_lock_irq(&gpii->pm_lock);
	gpii->pm_state =3D PAUSE_STATE;
    ...
}

Because gchan->pm_state remains ACTIVE_STATE, gpi_process_xfer_compl_event()
will bypass this new check. The function then proceeds to consume the
CANCELLED event and complete the descriptor, permanently dropping the trans=
fer
and breaking the pause/resume state machine.

Should the check for GPI_COMPL_STATUS_CANCELLED be moved outside the pm_sta=
te
check, or should gchan->pm_state be updated in gpi_pause() prior to stopping
the channel?

> +		dev_err(gpii->gpi_dev->dev, "skipping processing xfer completion event=
 because ch @ %s state\n",
>  			TO_GPI_PM_STR(gchan->pm_state));
>  		return;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009-add-gpi-dm=
a-support-for-uart-v1-0-c69e728df686@oss.qualcomm.com?part=3D3
