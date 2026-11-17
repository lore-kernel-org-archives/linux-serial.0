Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794956916;
	b=iVD65QTXjDq25DOEq7LUleiKnFZaIsufHk1wubUdsLm+6QsCI2maOUrEmVVKrBB6sspL
	 E0ShgwtCY0LQGWLlilVJ6AfGNvRADd8TFwJFecYlAiFabgKcygKfGY23uRGMXadzbXKyQ
	 pCJD3594toPPa4qMxUOPSCfYd3Yg1mdmPhMgG9olVT0DqN1wV0jO7RDHQRI1C8mY539eE
	 Z0DqsNvoNG34fgW/faoFJ8xEbHeIugoPPlqYdwbOEx7o5sQq4FfD203pyVN577TL6oso/
	 brSZAo3GkXPXxL97bG0wnxw8fyJ6rGso+2QmWPfJHbccblLQn3O/rp1nmEdAheuzSkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794956916;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=dgGY32TuxXGMlmbrwXD02kNkBgE/4Sl+6Gqrux6fXh8=;
	b=3uAgwlGQXcwFlwXLoSVE5EgRgTjaNpQSWFIO1enxSsor6Zo5tvXU4B1HWWNk2iXlplf4
	 k7Mi3EmqdwaOp4PuVgqjO/BQeEZoWwX/t1bYYPrEI0MIx63zLRBGH7ZAF9zuRdI9VpXtv
	 gSDkYiVB0Vv3IWyuTGARl/96nBcB8vXKkiTBPtwMLl42D4BQ4rJtgeI79unqGvp+FEvaw
	 8DF+GYel6dBJYVdmO5F7bcr5BmrzBFoO6zahkjmwR6pqhAy5OUpu6jvcVeki80NYBkUxr
	 LoWteFNhYYRt1ZPIUr6jvS2yazAstw7XEMwJCm/eDbKZ1Ym1I4o1zugwkTf92mJu7kA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="cjzsP/Zt";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD896606A330
	for <linux-serial@vger.kernel.org>; Tue, 17 Nov 2026 23:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cjzsP/Zt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29F801F000C8;
	Tue, 17 Nov 2026 23:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794956916;
	bh=dgGY32TuxXGMlmbrwXD02kNkBgE/4Sl+6Gqrux6fXh8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cjzsP/ZtmntVk4DVKvzRTpINEuJbd+OHNnNX+RHsuF3m0znYocjxZ+98LulP/3yJU
	 S6eXJcoZd5K7Q02kX21ksAq0f+UPJe0ZRcbNwD8tBRI3lPHUKV24sN//AbaCnS6o3O
	 L03SsiyerFKtqn+0/lGWlmUEJe7N+XUBOpzqOVQjFagOO2KNOGpOCvB8mWv78oH0Om
	 gt/TzesnfmiOIw32OLE/+YIFD9jEVqRyaonTOYgqMe8uduAr257UwnJ9iBPQ0wdEUv
	 9NdpsFZNmz98158i/2z0VWy7nz5WdsZLaj7Y+JAuEkGsEsjB4uoxs2SjUycVC4Cv1e
	 SBDW2TIBir90g==
Message-ID: <sashiko-outbox-219784@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 3/6] dmaengine: dw: use virt-dma for descriptor and
 callback ownership
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261117-submit-dw-dma-synchronize-v1-v9-3-7dc066ed0bcf@gmail.com>
References: <20261117-submit-dw-dma-synchronize-v1-v9-0-7dc066ed0bcf@gmail.com>
 <20261117-submit-dw-dma-synchronize-v1-v9-3-7dc066ed0bcf@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 23:08:35 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> The status getter can invoke a client's completion callback while polling
> the hardware. An 8250 RX timeout calls it with the port lock held, and the
> callback takes that same lock. Termination also lacks a synchronization
> hook to wait for callbacks already detached from the channel's queues.
>=20
> Use virt-dma for transaction queues, cookie completion and callback
> delivery. Keep the active transaction and hardware state under vc.lock.
> Polling still processes RAW.XFER and advances software-LLP blocks, so
> clients such as catpt can complete transfers with the controller interrupt
> masked. Client callbacks run only from the per-channel virt-dma tasklet.
>=20
> Submit only the first block of each transaction to virt-dma. Its child
> LLIs remain on the driver's hardware-chain list and are freed together
> after the callback returns. Keep the controller tasklet for hardware
> event processing and error recovery.
> [ ... ]
> Fixes: b36f09c3c441 ("dmaengine: Add transfer termination synchronization=
 support")
> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Link: https://lore.kernel.org/r/20240911184710.4207-3-fancer.lancer@gmail=
.com
> Link: https://lore.kernel.org/r/avrHOJ-fVZOO32bI@ashevche-desk.local
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117-submit-dw-=
dma-synchronize-v1-v9-0-7dc066ed0bcf@gmail.com?part=3D3

