Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792696555;
	b=uAEmlj9EeXRNDmq0PelybHSuUIoB5Q0yg5L5BCKHuAorr74tf8QbsZSTlCOl7UL86gNN
	 qEJABfGTnmwyxDDSA35S4DGkRObGYTqReVf9F34pTkx9A8AJJzhnLXELLbVprPQruiWqr
	 /yLFFhMPkZMk9gMLdgAUGyIyESHyFkDy50mRKzD5TiwB+OVQuu1QFL3tOFaSKe8umFymB
	 /WViEZXkpL490EPRfCiKv9N5kqF93xt3dfzfQumv4FqJasyXfdDWZVma5Lfn4YY1Mi3tD
	 tdXV7YXY0H9RbhS/Gm46N+2axWdMI++kFHaBGHBPIPkdTUObrbKtj+4P56zAkxsaMIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792696555;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=M9TF/oJtNsCW04VyyVA0DTdtkGn3HSYEv0sTZmn7Gk4=;
	b=tAVuBFLrlvU7kfTKNrm4dr1qsF9kfBglJg094QhL+ugPc1ojUPEgh1M8ANjvNBcuzeHK
	 T8vlvuDmZXHlVxoIx1C64fVuLzduscL2/jVAOv9dFUjtG3lX6fkxVVq8mYCnDFWBXsQSg
	 dlxOFhbHmDj10iBGhoEqqGA+C0fd5SOeVuNrt7tPSKObt7+ogwNcazzcCnXU3okt2foSm
	 A+bYqTajG75yMhbsELqfYpRNg3OR0pwLRhX1nlzOrd0QdGvDsYxOsuefi4fDCdacBlaFt
	 kB72PAlorbjYuoNn+PEcE9bSxAjy5fG5BQVdREkQ8tL/HUz2p+gO9IWFoWBXo4So/Sw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dmhPUiHG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E5F606A319;
	Thu, 22 Oct 2026 19:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dmhPUiHG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1C931F01825;
	Thu, 22 Oct 2026 19:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792696555;
	bh=M9TF/oJtNsCW04VyyVA0DTdtkGn3HSYEv0sTZmn7Gk4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dmhPUiHG/8cp+vxzB3k+IQ6pcNdOVFdAjm7KydR3ywBb8p8S7yT4QO1liEC9CadGI
	 3ZyRr8ySqnj7r/Zpsek80xcQH5nbjZiHuGF9Abr6wEt/btvQ5g8oYbALSQ2G/Z8t/B
	 8FJlTiG9uIjLUgznFOtNbkfjZEQiSOqidJ3wYFj1gqToeVrOBKTVufDplerjeYD10r
	 P69vKZPEzjdLp/4bIyNdNFeNca4BgbgDumJVgi+Bj8V4kH+aoZeuIbJ1u6lTWySI0j
	 VsdaL1YcXJtg+t1Ss92DfFSeXwmqdVr5kJDTCnLdFPYmcR80qXDRVLbM6sYemMlU6w
	 A9VDmFAHBLIOA==
Message-ID: <sashiko-outbox-181954@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/4] dmaengine: dw: Prevent tx-status calling
 DMA-desc callback
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: dmaengine@vger.kernel.org, linux-serial@vger.kernel.org, vkoul@kernel.org, Frank.Li@kernel.org
In-Reply-To: <20261022-submit-dw-dma-synchronize-v1-v2-1-5244e94dca8c@gmail.com>
References: <20261022-submit-dw-dma-synchronize-v1-v2-0-5244e94dca8c@gmail.com>
 <20261022-submit-dw-dma-synchronize-v1-v2-1-5244e94dca8c@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 19:15:54 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] dmaengine: dw: premature completion in dwc_scan_descriptors() =
on zero residue
- [High] dmaengine: dw: polled and non-interrupt transfers time out in dwc_=
tx_status()
--

commit 0cd2ee9537c620b0eff806ffd2af94c36f805f91
Author: Serge Semin <fancer.lancer@gmail.com>

dmaengine: dw: Prevent tx-status calling DMA-desc callback

This commit removes the dwc_scan_descriptors() call from dwc_tx_status() to
avoid invoking descriptor completion callbacks while holding consumer locks
such as the 8250 UART port lock. Instead, it introduces helper functions to
compute the residue directly for soft-LLP and hard-LLP transfers and uses
dwc_get_hard_llp_desc_residue() in both dwc_tx_status() and
dwc_scan_descriptors().

> diff --git a/drivers/dma/dw/core.c b/drivers/dma/dw/core.c
> index dd75f97a33b3d..af1871646eb9e 100644
> --- a/drivers/dma/dw/core.c
> +++ b/drivers/dma/dw/core.c

[ ... ]

> @@ -358,41 +358,16 @@ static void dwc_scan_descriptors(struct dw_dma *dw,=
 struct dw_dma_chan *dwc)
>  		return;
>  	}
> =20
> -	dev_vdbg(chan2dev(&dwc->chan), "%s: llp=3D%pad\n", __func__, &llp);
> +	dev_vdbg(chan2dev(&dwc->chan), "%s: hard LLP mode\n", __func__);
> =20
>  	list_for_each_entry_safe(desc, _desc, &dwc->active_list, desc_node) {
> -		/* Initial residue value */
> -		desc->residue =3D desc->total_len;
> -
> -		/* Check first descriptors addr */
> -		if (desc->txd.phys =3D=3D DWC_LLP_LOC(llp)) {
> -			spin_unlock_irqrestore(&dwc->lock, flags);
> -			return;
> -		}
> -
> -		/* Check first descriptors llp */
> -		if (lli_read(desc, llp) =3D=3D llp) {
> -			/* This one is currently in progress */
> -			desc->residue -=3D dwc_get_sent(dwc);
> +		desc->residue =3D dwc_get_hard_llp_desc_residue(dwc, desc);
> +		if (desc->residue) {
>  			spin_unlock_irqrestore(&dwc->lock, flags);
>  			return;
>  		}
> =20
> -		desc->residue -=3D desc->len;
> -		list_for_each_entry(child, &desc->tx_list, desc_node) {
> -			if (lli_read(child, llp) =3D=3D llp) {
> -				/* Currently in progress */
> -				desc->residue -=3D dwc_get_sent(dwc);
> -				spin_unlock_irqrestore(&dwc->lock, flags);
> -				return;
> -			}
> -			desc->residue -=3D child->len;
> -		}
> -
> -		/*
> -		 * No descriptors so far seem to be in progress, i.e.
> -		 * this one must be done.
> -		 */
> +		/* No data left to be send. Finalize the transfer then */
>  		spin_unlock_irqrestore(&dwc->lock, flags);
>  		dwc_descriptor_complete(dwc, desc, true);
>  		spin_lock_irqsave(&dwc->lock, flags);

[Severity: Critical]
Can checking only if (desc->residue) here cause an in-progress descriptor to
be completed and freed prematurely while still linked on dwc->active_list?

Previously, dwc_scan_descriptors() returned immediately whenever an LLI
matched the channel LLP register (desc->txd.phys =3D=3D DWC_LLP_LOC(llp) or
lli_read(..., llp) =3D=3D llp), even if desc->residue -=3D dwc_get_sent(dwc)
evaluated to 0.

In the DesignWare AHB DMAC, dwc_get_sent(dwc) reads CTL_HI (BLOCK_TS), which
counts bytes fetched from the source into the channel FIFO. On a single-blo=
ck
descriptor or the final LLI of a multi-block descriptor (where lli.llp =3D=
=3D 0
and hardware LLP =3D=3D 0), once all source bytes have been read into the F=
IFO,
dwc_get_sent(dwc) equals the block length and dwc_get_hard_llp_desc_residue=
()
returns 0 while destination writes are still draining from the FIFO
(RAW.XFER =3D=3D 0) or when a destination bus error (RAW.ERROR) halts the c=
hannel
with RAW.XFER =3D=3D 0.

When dwc_get_hard_llp_desc_residue() returns 0, dwc_scan_descriptors() now
falls through to dwc_descriptor_complete(dwc, desc, true), which sets
desc->txd.cookie =3D 0 via dma_cookie_complete() and frees desc (and its
tx_list children) to dw->desc_pool via dwc_desc_put() without removing
desc->desc_node from dwc->active_list. It then disables the channel via
dwc_chan_disable() and calls dwc_dostart_first_queued(dwc) with the freed
descriptor still on dwc->active_list.

In particular, when reached via dw_dma_tasklet()->dwc_handle_error():

drivers/dma/dw/core.c:dwc_handle_error() {
	dwc_scan_descriptors(dw, dwc);

	spin_lock_irqsave(&dwc->lock, flags);

	bad_desc =3D dwc_first_active(dwc);
	list_del_init(&bad_desc->desc_node);
	list_move(dwc->queue.next, dwc->active_list.prev);
	...
	dwc_descriptor_complete(dwc, bad_desc, true);
}

dwc_handle_error() will pop the already-freed bad_desc from dwc->active_lis=
t,
dereference it in dwc_dump_lli() (use-after-free), and pass it to
dwc_descriptor_complete() a second time, triggering
BUG_ON(tx->cookie < DMA_MIN_COOKIE) in dma_cookie_complete() and
double-freeing bad_desc to dw->desc_pool.

Note that while a later commit in this series ("dmaengine: dw: serialize
error recovery with channel termination") removes the dwc_scan_descriptors()
call from dwc_handle_error(), the if (desc->residue) check and missing
list_del(&desc->desc_node) in dwc_scan_descriptors() remain and can still be
reached from dw_dma_tasklet()->dwc_scan_descriptors() if a concurrent
dwc_terminate_all() and transfer restart clear RAW.XFER before
dwc_scan_descriptors() acquires dwc->lock.

[ ... ]

> @@ -1012,12 +1028,6 @@ dwc_tx_status(struct dma_chan *chan,
>  	struct dw_dma_chan	*dwc =3D to_dw_dma_chan(chan);
>  	enum dma_status		ret;
> =20
> -	ret =3D dma_cookie_status(chan, cookie, txstate);
> -	if (ret =3D=3D DMA_COMPLETE)
> -		return ret;
> -
> -	dwc_scan_descriptors(to_dw_dma(chan->device), dwc);
> -
>  	ret =3D dma_cookie_status(chan, cookie, txstate);
>  	if (ret =3D=3D DMA_COMPLETE)
>  		return ret;

[Severity: High]
What happens for polled transfers or descriptors prepared without
DMA_PREP_INTERRUPT now that dwc_tx_status() no longer calls
dwc_scan_descriptors()?

In drivers/dma/dw/core.c, both dwc_prep_dma_memcpy() and dwc_prep_slave_sg()
only enable the descriptor completion interrupt when DMA_PREP_INTERRUPT is
set:

	if (flags & DMA_PREP_INTERRUPT)
		/* Trigger interrupt after last block */
		lli_set(prev, ctllo, DWC_CTLL_INT_EN);

When DMA_PREP_INTERRUPT is not set in hard-LLP mode (or when DMAC interrupts
are masked at the wrapper level), the controller sets RAW.XFER when the
transfer finishes, but never raises an interrupt to run dw_dma_interrupt()
and dw_dma_tasklet(). Without dwc_scan_descriptors() in dwc_tx_status(),
chan->completed_cookie is never updated, completed descriptors remain on
dwc->active_list, and dwc_tx_status() continues to return DMA_IN_PROGRESS
even after the residue reaches 0.

Several in-tree callers rely on polling completion without
DMA_PREP_INTERRUPT:

1. sound/soc/intel/catpt/dsp.c:catpt_dma_memcpy() prepares memcpy transfers
with DMA_CTRL_ACK (and with DMAC interrupts masked in CATPT_SHIM_IMC) and
waits via dma_wait_for_async_tx():

	desc =3D dmaengine_prep_dma_memcpy(chan, dst_addr, src_addr, size,
					 DMA_CTRL_ACK);
	...
	status =3D dma_wait_for_async_tx(desc);
	ret =3D (status =3D=3D DMA_COMPLETE) ? 0 : -EPROTO;

When dma_wait_for_async_tx() times out and returns -EPROTO to
catpt_request_dma_load_firmware(), releasing the channel via
dma_release_channel()->dwc_free_chan_resources() then hits
BUG_ON(!list_empty(&dwc->active_list)).

2. drivers/dma/dmatest.c:dmatest_func() in polled mode prepares transfers
with flags =3D DMA_CTRL_ACK and waits via dma_sync_wait().

3. crypto/async_tx/async_memcpy.c:async_memcpy() omits DMA_PREP_INTERRUPT
when submit->cb_fn is NULL.

Could dwc_tx_status() still finalize descriptors that did not request an
interrupt (or when no callback is registered), or otherwise update completi=
on
state for polled transfers?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022-submit-dw-=
dma-synchronize-v1-v2-0-5244e94dca8c@gmail.com?part=3D1
