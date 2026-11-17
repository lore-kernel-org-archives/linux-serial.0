Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794956606;
	b=4b78eBHIxU9O89rQuI+oAC04nQVoHBK9IS1srQpKAujdqA3mfJ8sS7WxBTu8+7rOjH3H
	 QdiKQzwZL1YcYC9fR8yyVmL+lHHPTkjQm4R7x1Tip+3breljb82PTP0pET9EKUytvUSTk
	 pKDFZ6O/mGp9j3cuCG6xP2p+ASckzcfVuWT7BK/K8T2EH1LjqqPHPkEXORN+ACcSwDYTl
	 n9ZHPZQOnWqlmgMvOVHJ98Ggerbx1RTg2NKVRy/hJ3HEQp2PeleJ3d1qcvMNi+5Zdx+j9
	 tRZodM25nmmZPQdkd5i+NyypGq6GGlKIuqSUjHttmLQK6kG1SJUrcOCSvjExtEuKm6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794956606;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=93gLBBLjjGOxT6iBPFwFD+5qAbvfntNlyfwIlZdNFL8=;
	b=ZV2Kw05nJwzYsEQ16jW3vJRLnRwzdH7YIT3H2QHzxpR0Ph54n+2htYYi9b+jiDSrzFTb
	 HMV9tE7U0ADYaa41IlMo+itVTTLqU1JB1o+WydneXXeezAr+/P5+gfjU6AjY+vGGlte/3
	 S5nfZdXlN6+tMBOLnrFOviwijBrDprYEOGXIqEADYu/FWZRVBo/xQeee5M8GuDvdlxCZi
	 CsnLPLxXfX5uRthOiMlIP0AaIKPXdYFJFzaPqLfK7JfLSQ3SC/+X6MF26P5qZK96Qjj7v
	 eLbxQPTWffwgmf2DjHmNRi2BQ+Y27C0jda6eYOJ/N5mHd8HoPx6uJI5i/u7FzCrIcRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hjNr+fYG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76EC3606A31C
	for <linux-serial@vger.kernel.org>; Tue, 17 Nov 2026 23:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hjNr+fYG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF5EB1F000C4;
	Tue, 17 Nov 2026 23:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794956606;
	bh=93gLBBLjjGOxT6iBPFwFD+5qAbvfntNlyfwIlZdNFL8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hjNr+fYGKac8flUnmU5IGNUPz2uWbtWeiV6fxk7l/wKmb9JW/xjgqfjyYoFHW2jUN
	 oZbCRM5yS5LhvdEDdj26MVSiTOVQZlojMASPdTmvHwHAgCHi3juibbAEZXCGsOKzgS
	 j6c4j2ag1uhpHPbp13FPRaIjIGNKAXmZbXVOBEhPfkIOJ/vEe7CwfXpllJog1Dtu7i
	 +bejPlM/oHEdQqzfErY8vU/aPccUiSJlnwMV8OCUPAB6uM8SSKkjFn7lrHgbYGx3mV
	 iOhupnZb2IGlJ+1T7WWcU8wpnJTQD8Q3/fl85NWSqUmnnSMaWekNfeZY2H/USGZRby
	 gPzrwvBHstlyg==
Message-ID: <sashiko-outbox-219772@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 5/6] dmaengine: dw: calculate residue in the status
 getter
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261117-submit-dw-dma-synchronize-v1-v9-5-7dc066ed0bcf@gmail.com>
References: <20261117-submit-dw-dma-synchronize-v1-v9-0-7dc066ed0bcf@gmail.com>
 <20261117-submit-dw-dma-synchronize-v1-v9-5-7dc066ed0bcf@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 23:03:25 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> From: Serge Semin <fancer.lancer@gmail.com>
>=20
> Calculate hardware-LLP residue while looking up the requested cookie under
> the channel lock. The descriptor scanner updates cached residue only when
> no transfer-complete event is pending. If a status query completes the
> current transaction and starts the next one, that new transaction's cached
> residue has not been initialized and a query for its cookie reports zero.
>=20
> Have dwc_get_hard_llp_desc_residue() return a local residue value from a
> fresh LLP snapshot. Keep the persistent residue field for software-LLP
> block accounting, subtracting the current block's progress when reporting
> status. The descriptor scanner continues to advance software-LLP blocks
> and complete cookies from RAW.XFER, including for polled transfers.
>=20
> Fixes: 4702d5244ca9 ("dw_dmac: return proper residue value")
> Cc: stable@vger.kernel.org
> Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
> [james: retain polled completion and software-LLP progress]
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117-submit-dw-=
dma-synchronize-v1-v9-0-7dc066ed0bcf@gmail.com?part=3D5

