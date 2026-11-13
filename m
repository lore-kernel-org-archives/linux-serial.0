Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794564381;
	b=zbV3CTPS0hf7uceu5p7Xl1Qggu5s/5ADzGyldxMWGd6oa9JCI6oG9XbTRyd/5BL5rXFn
	 Cm7CnpetE+xWBNEennGx5rn3NAjYvniT+he5x/aJC5YDjdEA3+jdHrbTQQiRyt/3rsS8T
	 d1ZOnvO8OUbQg7FiM+rHMtF8dCdMiT7kqHDRMlg4Z4Hoc/Ezz6ghG1ChrK3sJjVohnd92
	 sqJgZlMVgdsPrwHJ9wKL7z7PZgfJUv7GXUTP9n3NMCg4CfPr7K65sMNqA44uMBFCRHJED
	 8DRHw+S9buxh9+CfgpnLiAqe8c8qpNxYztZeUg+MMRFh9w1I2aWZ0ed18hUOllPgWbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794564381;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=NX/Q0VH+in4fVqP2vK5rEAoyRyhTKavFUhbbcPNQSb8=;
	b=N3Y3A2P5gKUx/rEuu255VhsBQ9UTOc1ouFJk1ySEqg3z0tRdbQDO1hQrNw1nXwaHVVBg
	 uPkiYtTE9p2mAUfr3/Twnce3yE04H2xqn3MjTIpLjWEg/qMn41voHJB2ARgWCWuCY+1iY
	 URvipxhSgeX0c6opZ63H0A7hJ+gDAEXLunesr34jf8//TQdJPAel1zJUKdgM0Ye+/bFbg
	 rJoxBO6RL9ePWg9/FwKF4EDWZb6cisMkH9d6qvKFO5321bb7IiATGPNISDVurbhlQ3Pxq
	 N0ZkbQes/Z3LA4/pNKDcmLCIuE8oBTG74Hc7tsyCBP1hXcjo0OR4H23bboYttVQtSaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SogpGqtK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D54606A88B
	for <linux-serial@vger.kernel.org>; Fri, 13 Nov 2026 10:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SogpGqtK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E21CF1F000C8;
	Fri, 13 Nov 2026 10:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794564381;
	bh=NX/Q0VH+in4fVqP2vK5rEAoyRyhTKavFUhbbcPNQSb8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SogpGqtKo8Fxaz5V/hfWwv8n/A4/hxzBfg1wrx+zW2W0VDUyt11vpHaSB3Oar0E0b
	 oTajuxlcOADvZkBu0lRZui98h4OTrKvNTSwurxbGJwFyRMdb1ExmRZMg3XsYNtU82s
	 4zbyh618nIlfH3sOws/VUrcETRcncfVFvXIOdCuV1yvsdbV8+haD7lrDYEByNStWHZ
	 iJr/w/EeXLo8vlIf3tATT8NxHqcWoXPNTzSNBs9y3D9ZpAoPcXoWkr36lcpQfYyDPQ
	 E/WmNHsD3lsG3siWI0xqdTJY9hGxGeLYwF2hCsSGdUY00yZyaUQKK0xTkz33qs5t/Q
	 u+6eac/bGeZUQ==
Message-ID: <sashiko-outbox-212602@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 8/8] serial: 8250: retain DMA resources when
 termination fails
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261113-submit-serial-8250-dma-cancel-v1-v13-8-b857f2617ece@gmail.com>
References: <20261113-submit-serial-8250-dma-cancel-v1-v13-0-b857f2617ece@gmail.com>
 <20261113-submit-serial-8250-dma-cancel-v1-v13-8-b857f2617ece@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 10:06:20 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113-submit-ser=
ial-8250-dma-cancel-v1-v13-0-b857f2617ece@gmail.com?part=3D8

