Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792695654;
	b=wbSdVU68qqIfddLRArSQa01Mx8zR4kHPqHBmHPADpbFkjwFiOhreq0rhWIL0uWzcRN9C
	 /4Z46Wr1bcrvp7jlmzrPm/y4Q1lL3JzYG3qR8JGbHJfeOW/zkAbeIrLHwUsAFfgtrrEvq
	 H3tXO2WF/NruhWna8tHuGvF9mc8UF17xivg+k/re0dCZABFJ8UPSzDaGEOec2QBoqCr2o
	 vC+Lc8JXEOo5bim27pZVd6EjtezHN+GM9QA8BwA/LgEk0KcK1Spo1EagmxQUY2LyjhDY0
	 BjL//2FhWjt4r/dTrJ6D/RtQie6i7musQ/pu1Re0TgvSrafljJAX0blId3xj/pgbN0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792695654;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=vVVT63wdgb7t8pTzrOWANnA9Oj3Jl8xqKPUMuU5y7JU=;
	b=VgCioGCwuIQSieW4nBXtU4NPXZIsG+aR3rwl8wnRQkoJ+fpCcr8Zq/ZbWbnw/NkfDDXp
	 9Pl3jn5sOZapCe+tVi94GuQvRj3TqPDCu2Dt++E86MAqz2tNBJ36/r+Afbzg+Mg/urJ8j
	 fXV3KHgtOp+D0mZO4FmXJh99KI6CN1F0hh4k2VtZ5gNyYNV4pfrWVbBLIVPATndFDnvUf
	 NM0QQgmpccNkZ0FOu5s3rYeptrZUp/rXkQQ37QDl8kqWBjavmKngUiMgBixfs7KIfrPoV
	 f9GVCY4K9zr3hipYlUraj/+exJnDtRB1l9xn+rugpfDqut0FemfxjvwH+TDXLQjfkQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OTrlY3Lh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33370606A319
	for <linux-serial@vger.kernel.org>; Thu, 22 Oct 2026 19:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OTrlY3Lh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C785B1F01825;
	Thu, 22 Oct 2026 19:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792695653;
	bh=vVVT63wdgb7t8pTzrOWANnA9Oj3Jl8xqKPUMuU5y7JU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OTrlY3LhdFuLim6Hesr2tpsmm/vAzF18v6QRJ09IxunsJv8aaIkuYSbQX+yQQR3sO
	 h/Zasz65o3EEkdkwS3PB2QDpRQnU8GskoF6Q8Br+GCIDNfVMGcSuLFsZ6KuwEi0ARM
	 BJvx9mvoKHtqyniV5ZzrX+iaSOOPOztwEK+ZihYOPXLQOsNm7rah1Y/w0wJsLYZBGF
	 mK14UpoFVNooj7oFWHoHataGVV5eAXRKKsjtH29Za6msTHch6mznPQBwZEeWE2osWs
	 Bc+MwGYa0eYMqC+dn9UD/tJnQURJJIvDDBuDWE4rDlJuaEpVYj2X96RcjptJALcjlk
	 m6Iu0+m1A7Eaw==
Message-ID: <sashiko-outbox-181946@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/4] dmaengine: dw: serialize error recovery with
 channel termination
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261022-submit-dw-dma-synchronize-v1-v2-3-5244e94dca8c@gmail.com>
References: <20261022-submit-dw-dma-synchronize-v1-v2-0-5244e94dca8c@gmail.com>
 <20261022-submit-dw-dma-synchronize-v1-v2-3-5244e94dca8c@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 19:00:53 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> The tasklet samples RAW.ERROR before taking the channel lock. A
> concurrent termination can empty the active list before dwc_handle_error()
> uses that cached error to select a descriptor. The list head is then
> interpreted as a descriptor. Even with an active descriptor, moving
> queue.next unconditionally can put an empty queue's head on the active
> list and pass it to dwc_dostart().
>=20
> Recheck the error status under the channel lock and stop the channel
> before selecting its failed descriptor. Only one transaction is issued
> at a time, so take that descriptor directly instead of scanning for
> completions first. The scan can otherwise complete it and start queued
> work before the error handler has identified the failed transaction.
>=20
> Detach the failed descriptor under the same lock and use the queued-start
> helper, which leaves an empty queue alone. Clear the software-LLP flag
> before restarting so a failed multiblock transfer does not prevent the
> next transaction from starting. Keep the completion callback outside the
> lock, with the detached descriptor owned by the tasklet.
>=20
> Fixes: 3bfb1d20b547 ("dmaengine: Driver for the Synopsys DesignWare DMA c=
ontroller")
> Fixes: f336e42f73d9 ("dw_dmac: Move single descriptor from dwc->queue to =
dwc->active_list in dwc_complete_all")
> Cc: stable@vger.kernel.org
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022-submit-dw-=
dma-synchronize-v1-v2-0-5244e94dca8c@gmail.com?part=3D3

