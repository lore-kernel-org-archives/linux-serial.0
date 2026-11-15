Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794727767;
	b=s0kR4+aFclEpSVxTiwrTlNqZw22AYT+Xw0/FKl5DhZ+t8U7F2y9JY3gUc4NWbStyVebN
	 kZERFXeHTFsApNRTMOlVFbyaWd0XREgIxPfQ7MNx6Esfq4NS6TtAKi+PWF+POiKTKVlWz
	 YUllQQ0wfbQXDDbFrTybhqRk3v5ncb4Tp5dTtYmV0Uzk4rGHKwYHNIYVlbxSLl9tbbgc7
	 jjdM7Ei6FwTn2JnK3IXWWCnchcNrvP38BwXL/KAVzj9K2+2JQKSi7s+cCH9wXssPgKYBQ
	 QOh684cct4WL54Z1BU+ungGeATSBw2n0WKy0qti8A3bxkMUSqoOFqBZcadWQyrmv4ZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794727767;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=BiVoGrT5t95YJ6IqXKyWpEji0TbnWl7XGvEx0qZAUHE=;
	b=kpDl2cBBWFTXZEW4sHNd2WShscmSln/26ekI0gkflgO4jMtZc+2jqN1ABKV9af0ZjS08
	 A8wyZojPc1/yl4igaBWSZon+0Bcejf4HwNXMDcxTeZzJ8Ob0OV75wsgeusMYqZKJSobxM
	 SXiwUsm1n5knFFWBTU4LH9/2C+616L6IgAQh2tAdtY4N19OHSI/c5ePDXJOebnsfeXI9I
	 04r45Ax4Eefac5XHySNLfFvAoDIqdy4BFxuJtyKFe7DuJZZK/xC4GSG0JTx6RfpX+kn7l
	 hdMrpHyu6+PJNGUPQWUCiPg7iQaMoR21y9NMnloTLNy4XE7gpomdZbGdrVLrIeHmGTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iJmtNOO4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1679F606A31A;
	Sun, 15 Nov 2026 07:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iJmtNOO4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94C111F000C4;
	Sun, 15 Nov 2026 07:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794727766;
	bh=BiVoGrT5t95YJ6IqXKyWpEji0TbnWl7XGvEx0qZAUHE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iJmtNOO41mvjyXfq6yUFrgGmMW1hwoo1e/jsd4QTjjVFgQW8EarH1zN5m1R8HVSSp
	 pU7fxpJqd4CapGBb2quocNxBytnnXUXeWVizhxIiypW0zUjmeeBasYZwp1p2twQA7j
	 f/SXnUb7WtIVAP9dfWXbiKIO7uhvE7coO4K1UyxCHclNaUzHlwEUPuduEgspPlxFe3
	 MTNpfiAwvQVz39gy2BDAquaYLVfCapDS9hSSpNY1/fMqS+YhL424OVPovaHeOhtvuu
	 9QJtnUbUqLcFfjFJNCG4nlA2AO7wan925+WXR+yYkA/BMovdW1nyZoX08GIhROh09F
	 NyWd5hRz9ILnQ==
Message-ID: <sashiko-outbox-215259@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 07/10] dmaengine: dw: report residue for queued
 transfers
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: dmaengine@vger.kernel.org, linux-serial@vger.kernel.org, vkoul@kernel.org, Frank.Li@kernel.org
In-Reply-To: <20261115-submit-dw-dma-synchronize-v1-v7-7-8d58f3d49e4d@gmail.com>
References: <20261115-submit-dw-dma-synchronize-v1-v7-0-8d58f3d49e4d@gmail.com>
 <20261115-submit-dw-dma-synchronize-v1-v7-7-8d58f3d49e4d@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 15 Nov 2026 07:29:26 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] dmaengine: dw: Fixes trailer cites 3bfb1d20b547 instead of
  b68fd0976286
--

commit cea2bb9706ea8fb5c7af2045e48883b9d2da9184
Author: James Hilliard <james.hilliard1@gmail.com>

> dmaengine: dw: report residue for queued transfers
>
> A submitted transfer may still be queued behind the active transaction.
> dwc_find_desc() only searches the active list, so a status query reports
> zero residue for the queued cookie even though none of its data has been
> transferred.
>
> Search the queue as well. The status getter already reports total_len for
> a descriptor that is not the active transaction, giving queued transfers
> their full remaining length.
>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Fixes: 3bfb1d20b547 ("dmaengine: Driver for the Synopsys DesignWare DMA c=
ontroller")
> Cc: stable@vger.kernel.org
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

[Severity: Low]
Should the Fixes: tag point to b68fd0976286 ("dmaengine: dw: move residue
to a descriptor") instead?

Commit 3bfb1d20b547 ("dmaengine: Driver for the Synopsys DesignWare DMA
controller") did not have residue reporting or dwc_find_desc().  Commit
b68fd0976286 ("dmaengine: dw: move residue to a descriptor") added
dwc_find_desc() and the per-descriptor residue lookup, searching only
dwc->active_list after f336e42f73d9 ("dw_dmac: Move single descriptor
from dwc->queue to dwc->active_list in dwc_complete_all") had already
kept queued descriptors on dwc->queue.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261115-submit-dw-=
dma-synchronize-v1-v7-0-8d58f3d49e4d@gmail.com?part=3D7
