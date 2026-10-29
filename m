Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793260283;
	b=qttYtfW03OEkFFYg89rv8ud62pJOlsdEKmkqeCffFDsHrmwhZjJbGFoxNFQOL1qG2/QS
	 Y6k4F71stnuHk1QVnfQVqBwEfPbANey+uM+SmSSOollY/5gitHNQ/F+QRPTP2qzf6bcKu
	 SlU/hDlbqpW7PqprO66h3H3ti7iCumi/MSNEmUpJwN08XGnmXhy6veHCR1EHNp+CvK2Hn
	 xCJIn+KlR/6yYkRaizLXd6B9+tgqNLD5Qtok7J7Rp9jI4WaP7b628ImUnPsKnIlfz6Hq4
	 ZNJmEVNv0NlBDH5VqXVatYbXH3gZW8kDiBomqYcMN/FMIFlT/fOIpqGctixMTx32aVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793260283;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=gBrJca98Lz6gR/Cvd90FwjRYSqZv7QYOvYNpFY2z+es=;
	b=1TnZ+Z9t6VDtSjT/W6nCyfEMvJDhvWW084f1CTuZ2KJMM86tnOap2WAUjHirOgiYSNFj
	 YPue1ZmgPYenPMVFUmthRG1VvjL8YzaLFoP0mRgVF3Kp0Z+ktxYPalrmIBbvq6mLwk+gg
	 n7IrcdoHHhtVmMiME73uY7wdbQfJ3MAj0Gf9qD18m/yqrduzrlN+IH1FmXpkjnrQuKI3H
	 k/BxRFfl3zgogetTeMlZxNTSBWx3WnZwhEjrOhBn8VFutNa2fhyS5CNNb7FwjRX8bblJL
	 8CTuNPIoxdo0aGqSW3sHsL3nmqq8WQHKr2Hz/XZso1/MCwiFDPcRRSQRI8Jw4/PSMTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MlxQGnA9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B72B606A31A
	for <linux-serial@vger.kernel.org>; Thu, 29 Oct 2026 07:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MlxQGnA9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AA8F1F01825;
	Thu, 29 Oct 2026 07:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793260282;
	bh=gBrJca98Lz6gR/Cvd90FwjRYSqZv7QYOvYNpFY2z+es=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MlxQGnA9rsNWvrCFLGlqHIp5YVi8rxq8Z7IfrMRmGkDbS3P9lgrv9wFUQqgnZf5b0
	 eSfrTeKd22X7w5Oc8/jmXyK+S826IlaaDIwa1d6zcZmFHPriE5aogxxvbkUdfjl+AD
	 O576o6AvaQwNxfBj0qe8UWDWkxQZuuHFiCylCwPPjx7KS3ZKLHEq74Nk8GS52LC4KM
	 BI+4hu/y5/mD/rrl+RVIWEf7345VIoc5kt+nnLUWmD0ifSb/5fP2I8WUhE2iHnsmI0
	 1lXu4TZPMH76mH6jgfG6pxppNAExyXoX1yS3eicZUAxidvfHD7IqkHQ/NW7Q5FOlnZ
	 eiPRhCL2YUtfw==
Message-ID: <sashiko-outbox-188910@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 4/6] serial: 8250: drain canceled TX DMA before
 reusing its buffer
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261029-submit-serial-8250-dma-cancel-v1-v8-4-3fd56ba352ed@gmail.com>
References: <20261029-submit-serial-8250-dma-cancel-v1-v8-0-3fd56ba352ed@gmail.com>
 <20261029-submit-serial-8250-dma-cancel-v1-v8-4-3fd56ba352ed@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 07:51:22 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> uart_flush_buffer() resets the transmit kfifo before calling the driver.
> serial8250_tx_dma_flush() terminates DMA asynchronously and clears
> tx_running, allowing a new write to replace tx_size while a detached
> callback has not yet run. That callback can then consume bytes
> from the new transmission. Reusing the reset kfifo can also overwrite the
> source of a transfer that has not stopped yet.
>=20
> Reserve the flushed FIFO storage through serial core before returning
> from the flush callback. Keep tx_running set until a worker synchronizes
> the terminated channel, suppressing old callbacks and new submissions
> during that interval. Return the mapping to CPU ownership before releasing
> the reservation and waking writers. Normal transfers continue to use the
> FIFO directly.
>=20
> Reuse the locked completion processing after retirement, including OMAP
> [ ... ]
> dmaengine_synchronize() returns; provider callback-lifetime fixes supply
> that guarantee for controllers which previously lacked it.
>=20
> Fixes: a424a34b8fad ("serial: 8250: Fix TX deadlock when using DMA")
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029-submit-ser=
ial-8250-dma-cancel-v1-v8-0-3fd56ba352ed@gmail.com?part=3D4

