Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793649896;
	b=aRzi6wxEReg6Iv6Hlab/YbSkaSfFUjjClfL+SNOms7TI8yMEz4uK4nh9kj4ErzyPziAQ
	 cGp3pb7dXvYH07tQtpmAXDwL+WDC8faaAOsoPp7fZW1pAwsqy54UzRVF474KJMj6RFcpV
	 15og5/UMTs0UHF86n7P93o9iKjUz9AvIaVBz+EqcZv+NequB2mLFCv4RNVdxDIK4UAtPL
	 y2PkeyzYxSb0osqebCPlfz1yBh0Z4e6UpbA9My1n9TowKJcLDcs+NWN8GBIW/wO57M+OJ
	 bbVMtbtFK6Q7J9Og0jAdHUboIph4AcUY9cdgbrEsEMYIGrG+xxQtmfPKEVjtwFbCIhg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793649896;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=EIEwRZB9XgZ9fVs6hIiZGhz2eSFj7M+YE3TT3bDAnsU=;
	b=VC36MbuH+KMOlEAvHZJ87QzezG7XI2SR34ljvelAV8MEuGUw3YjSyYJbEMoLYWxG2Ke6
	 xLml0FJdMAGqZ5Wkj5PMaVXVzBDi4EcLu3yH2HTBi/vZYz6PKXtJYCfZ7fRu/rXd/bCV1
	 Nnztyf76X7FC1VduzLMt0/VzlOS4ssb1qxJscv+kb1nYmzMKFnU5X4DQftExW16aACJKV
	 n9GdNt878z258DY4WMeG7A5axIC8bA0GIFwmLSc6YqWL0hPG1J9CGd8gxq1qIQubjI2Os
	 oknaJJD9rXigm/1j/hITo1GYDdzr/TrnpGlvXn8oZqXUoUUaP1l/3YrOWuZfV09tgcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C8XfUegY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6E6606A326
	for <linux-serial@vger.kernel.org>; Mon,  2 Nov 2026 20:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C8XfUegY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C6191F00A16;
	Mon,  2 Nov 2026 20:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793649896;
	bh=EIEwRZB9XgZ9fVs6hIiZGhz2eSFj7M+YE3TT3bDAnsU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=C8XfUegYo1nykXBe8u3wRO5C5boPP0IauGEyULi2S9UXv1pe7p2fLeRiiO3Lvf5FF
	 EFfIuP3Rqe+foaJsBb5LGz2YJ/zCdUSHM4CG/KOs5KyQ9esKfUoZQRjHMq190R5Zaz
	 QZDyy5CT6bc+yuqItOMXQmve2JfhTNE5ByddI68QPkydEblieLWm8GLN0m8GPXL7jj
	 6cHuNRLPGGFiHHCw41pBwsMydht7qoXvTp+dpSIsR38NO13mrRDzaMkxveqVcUR2Cv
	 acgAzN7Ze1dc6eNVeEENDNocci/ws0iWOCinRb9tPjtY5S8ha0Mj/iW3+kjlcFSFdm
	 seU9hfdV3pizg==
Message-ID: <sashiko-outbox-194053@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 1/8] serial: 8250_dw: select port setup through
 platform data
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261102-submit-h616-uart-fifo-v1-v6-1-25afcb346b0c@gmail.com>
References: <20261102-submit-h616-uart-fifo-v1-v6-0-25afcb346b0c@gmail.com>
 <20261102-submit-h616-uart-fifo-v1-v6-1-25afcb346b0c@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 20:04:55 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> Select feature discovery and DMA attachment through a platform-data setup
> callback. The generic callback probes the optional registers and attaches
> DMA when a FIFO size is available. Integrations with a fixed configuration
> can supply their own setup before the port is registered. Allow setup to
> return an error so integrations can reject invalid configuration before
> registration.
>=20
> Replace skip_autocfg with the Octeon setup selection. Octeon is a 64-bit
> platform and continues to skip optional-register probing while retaining
> its DMA setup. Select the DMA setup helper directly for this integration.
> Keep generic setup for devices without matched platform data as well.
>=20
> Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-submit-h61=
6-uart-fifo-v1-v6-0-25afcb346b0c@gmail.com?part=3D1

