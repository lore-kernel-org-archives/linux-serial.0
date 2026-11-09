Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794197105;
	b=SjubYSyJ9ljh0tTLJW7q6JauhXOD+7ujf05tGBaHzb2PbXq5+TR57Yx9H11At2Ea9zsx
	 LNKp9vbd4S6xaRCLmCsTZXSURkUwzAe/iw0pncBg7bXyvbVMSDXgYPorsL8tvEOcXHTSF
	 skTQFBsr9Ma3bwpUhev3IeAJLNcPC+tTtt6a1Bb9DVmI6RdNvDyUHCzl+5VFQ/xafkkmg
	 /AiXYAeYcNvZq0I9eJEPa+7crpbyEnykIHOXdPqY7GhYDCD1YRDBoltkoRujsewOZ4QnJ
	 VVcoPXwbRIqwNXAWL2ySwRjBo/b2g7rZ+SS0p/lNVysBAb6DJONtHvYp1ZMgmtcOaGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794197105;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=29Ve/NK+Nc8NojzYkVDtw5h06xD8hVWcp6r1z06QwqY=;
	b=WoYVN0KEXCnDEDLoqSYPa7RkELu8nqCjBsA89KYS892//n0A6QQpKYof+CDuNfnrpS3b
	 EFpzCgMgKUZlJEeKOKbQhELJh8wl2fs+sB7U4Vds2dBaElMIsagaAswiL3sXB9xWex9Q7
	 UxdGio3+KUd53dbxxzy22HS8ztnilDg+TKbN5TrVCXKIcyFnc+1HcOVXn7ZjXqtJXK9Ei
	 A5lrk34E99L1CLx9NwSBffkDIVedVvRhs+4suGGJO+vKXoBJsktsle1+oV3JKHdikuSbT
	 RYwbk0RcLE3a5jWTEXja6yo2U/uIgqyPLWEcESjiNzM755GnG1Kw3VNeNw+wv4ylpXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HWZ6FG1O;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89AA8606A31C
	for <linux-serial@vger.kernel.org>; Mon,  9 Nov 2026 04:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HWZ6FG1O
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC7431F0089F;
	Mon,  9 Nov 2026 04:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794197105;
	bh=29Ve/NK+Nc8NojzYkVDtw5h06xD8hVWcp6r1z06QwqY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HWZ6FG1O0DXiT4Zn72622t5qJJs0OrrXd6h0JqNAM5zn2Ttw3rPGdtwa3J2DN3XMa
	 20eIvOXvPFRqXN9s2+Lbkd69KPgg+vy2YtVOwcxf463a4ScJv77UflE12LKyG+lRI2
	 aGjG0s9AacRO9YtYviqUSMe3PEyr/cDlMUiztHzSobSfgZbFY1MIKKcsAiVPhrlii2
	 GAuzIA48QiGS6uvy4mKqNoWj/cJFPUlNgJbCEWaXwvH3G8WIMRvXgRpHUfvX+bPifO
	 zE/59dGYCoNO6MRHt8HYlC8uoekKQXa+o1nBFMUggk4R+L9l6CfTNOopYjeG9T549J
	 o8FuOedhYrlBA==
Message-ID: <sashiko-outbox-204392@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 8/8] serial: 8250: retain DMA resources when
 termination fails
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261108-submit-serial-8250-dma-cancel-v1-v10-8-e6227ddb95b1@gmail.com>
References: <20261108-submit-serial-8250-dma-cancel-v1-v10-0-e6227ddb95b1@gmail.com>
 <20261108-submit-serial-8250-dma-cancel-v1-v10-8-e6227ddb95b1@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 04:05:04 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> serial8250_release_dma() ignores the return from dmaengine_terminate_sync=
()
> before freeing the coherent RX buffer, unmapping the TX FIFO and releasing
> the channels. If the provider fails to stop a channel, the DMAengine
> wrapper returns the error without synchronizing its callbacks. Hardware
> or a detached callback can then access the released storage and state.
>=20
> Checking the error and returning early would not preserve their lifetime:
> serial core frees the TX FIFO after the driver's shutdown callback return=
s,
> and port removal can then release the callback context as well.
>=20
> Require successful synchronous termination of both channels before
> releasing any DMA resources. Retry failed channels after a sleep outside
> the port lock, leaving channels that have already stopped and drained
> alone. Keep the shutdown gate and storage reservation in place throughout
> the retries.
>=20
> Start retries with a 1 ms sleep and double it up to one second. This
> makes short-lived failures responsive while bounding sustained retry
> activity; neither delay is a hardware timeout. Report the initial failure
> and ongoing failures with the elapsed time and current RX/TX error codes.
> Track the five-second progress-report interval separately for each
> teardown, so failures on different ports are reported independently.
> Report recovery once both channels have stopped and drained.
>=20
> A permanently failed DMA engine blocks close or removal. This deliberately
> retains the buffers, mappings, channels and callback context until the
> provider can establish that they are no longer in use.
>=20
> Fixes: 9ee4b83e51f7 ("serial: 8250: Add support for dmaengine")
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261108-submit-ser=
ial-8250-dma-cancel-v1-v10-0-e6227ddb95b1@gmail.com?part=3D8

