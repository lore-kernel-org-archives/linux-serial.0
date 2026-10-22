Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792696277;
	b=AIHrfznfaWpb0LQ920Rhj6tpkoGs6UyGr3Pz/rfmp//ZnXRajRN+ARiRkhvD9zYSU2bj
	 fliV8aslhAhbGgHSrIOx6Wy9otFCpaOa1kTrBunB57dXlFsxJchdFNKQkJZB47ZSpjQXq
	 +kB2lwMQSXOcMPekfOzekgDs1WZeiXfwaYFzwtzZRSZEibZ7zG1cnGkd4bSq1FTlbAprs
	 LyJBvy+VU8Z9ls6t37W/o4Hf0TLYDqjN+Lbx/+2R71sfa2viw/ilxvO1x7c1jM3WesLNl
	 5ZCfQFshSYGdlGR8dziKHj6H6ykmvY6Z44tHXWP3csY9Gg0tJC8UlBw5IafSu8FDWPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792696277;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=J6pinrhVOsnKvSJPmYy7UcsQfUx7k5exnPqouoMtclg=;
	b=2YGSfEvTKzPOumtg7Eje7VmuUIr60sA4nGQUBXDLqM8B0XnUfOR90q0gRo9TUrXPnD5G
	 17BfeQt9nRX6AOljVNqDtPqW9xNhu3nuokVxDbFk/5sJVkqYAnedFewDmApqHeK3Vz3If
	 hChTwfh0eO6PPDbt/R6tfrZ7EcwI1cweyp3QeOcEDJCqGJqAdEA0Twzg96tdQ4/Nr8oel
	 PkN3Q0I+bX5JdaYEWkGHFMIj2QbfZfbgegRd0yWplDMZLlLtgSjP2frLYPNul9zgMLBLg
	 0mKoXwr6C83+xUml0Dyp/VSJswOX/pB8e8uQ412melRXeslJdV82TLRmVuBT4Srm/4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dI9lWlTx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33CD606A319;
	Thu, 22 Oct 2026 19:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dI9lWlTx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AE781F01825;
	Thu, 22 Oct 2026 19:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792696276;
	bh=J6pinrhVOsnKvSJPmYy7UcsQfUx7k5exnPqouoMtclg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dI9lWlTx8wS3BFDUf+apYF9NcSXDblapOR2zrgmHmFlFdC7o6AOt6kWulnQ/MXVg3
	 xjfThwkSy57Hpat47tcQznyCv9JMj2dST0FJ9fzkluxHguwk/xwu//qzQbAlxxqK7y
	 3N/EH+0hUJDg1llOcNg06cm+OfshQfwtl10ESXVN6MqQbJ4gdh6xePL6OONMffbhOS
	 uV+SLvB9b82+E1knrT1WFQwrsvdxUFbaQ8+At2ZBG5WCUTPn8SBKa+KKr6sYFpv09S
	 758NT3N2eiGhUDv8cafuPngV1K4NbjwMPQVFRC9AlPDohRky/C+cqg2iYFA942oiQi
	 lSwwDYO/0pw8A==
Message-ID: <sashiko-outbox-181953@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/4] dmaengine: dw: Fix XFER bit set, but channel not
 idle error
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: dmaengine@vger.kernel.org, linux-serial@vger.kernel.org, vkoul@kernel.org, Frank.Li@kernel.org
In-Reply-To: <20261022-submit-dw-dma-synchronize-v1-v2-2-5244e94dca8c@gmail.com>
References: <20261022-submit-dw-dma-synchronize-v1-v2-0-5244e94dca8c@gmail.com>
 <20261022-submit-dw-dma-synchronize-v1-v2-2-5244e94dca8c@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 19:11:15 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] dmaengine: dw: use-after-free in dwc_scan_descriptors() after =
CLEAR.XFER
--

commit 72138309eb8e38de489c0fc20421b49827977836
Author: Serge Semin <fancer.lancer@gmail.com>

dmaengine: dw: Fix XFER bit set, but channel not idle error

This commit clears pending channel interrupt bits in dwc_chan_disable()
and inlines dwc_complete_all() into dwc_scan_descriptors() so completion
handling runs under a single critical section.

> diff --git a/drivers/dma/dw/core.c b/drivers/dma/dw/core.c
> index af1871646eb9e..fbc46cbfe2591 100644
> --- a/drivers/dma/dw/core.c
> +++ b/drivers/dma/dw/core.c
> @@ -143,6 +143,12 @@ static inline void dwc_chan_disable(struct dw_dma *d=
w, struct dw_dma_chan *dwc)
>  	channel_clear_bit(dw, CH_EN, dwc->mask);
>  	while (dma_readl(dw, CH_EN) & dwc->mask)
>  		cpu_relax();
> +
> +	dma_writel(dw, CLEAR.XFER, dwc->mask);
> +	dma_writel(dw, CLEAR.BLOCK, dwc->mask);
> +	dma_writel(dw, CLEAR.SRC_TRAN, dwc->mask);
> +	dma_writel(dw, CLEAR.DST_TRAN, dwc->mask);
> +	dma_writel(dw, CLEAR.ERROR, dwc->mask);
>  }

[Severity: Critical]
Could clearing CLEAR.XFER in dwc_chan_disable() cause dwc_scan_descriptors()
to fall through into the hard-LLP scan loop and free an active descriptor
without unlinking it from dwc->active_list?

In drivers/dma/dw/core.c, dw_dma_tasklet() samples RAW.XFER without holding
dwc->lock before calling dwc_scan_descriptors():

	status_xfer =3D dma_readl(dw, RAW.XFER);
	status_err =3D dma_readl(dw, RAW.ERROR);
	...
	for (i =3D 0; i < dw->dma.chancnt; i++) {
		...
		else if (status_xfer & (1 << i))
			dwc_scan_descriptors(dw, dwc);
	}

If a client calls dwc_terminate_all() -> dwc_chan_disable() and immediately
starts a new hard-LLP transfer via dwc_issue_pending() after dw_dma_tasklet=
()
reads RAW.XFER, but before dwc_scan_descriptors() acquires dwc->lock,
dwc_chan_disable() clears RAW.XFER while dwc->active_list is populated with
the newly started descriptor.

When dwc_scan_descriptors() then acquires dwc->lock and re-reads RAW.XFER,
status_xfer & dwc->mask is 0. Instead of returning, it falls through to the
hard-LLP loop over dwc->active_list (which is also reached via
dwc_handle_error() prior to commit "dmaengine: dw: serialize error recovery
with channel termination"):

	list_for_each_entry_safe(desc, _desc, &dwc->active_list, desc_node) {
		desc->residue =3D dwc_get_hard_llp_desc_residue(dwc, desc);
		if (desc->residue) {
			spin_unlock_irqrestore(&dwc->lock, flags);
			return;
		}

		/* No data left to be send. Finalize the transfer then */
		spin_unlock_irqrestore(&dwc->lock, flags);
		dwc_descriptor_complete(dwc, desc, true);
		spin_lock_irqsave(&dwc->lock, flags);
	}

	dev_err(chan2dev(&dwc->chan),
		"BUG: All descriptors done, but channel not idle!\n");

	/* Try to continue after resetting the channel... */
	dwc_chan_disable(dw, dwc);

If dwc_get_hard_llp_desc_residue(dwc, desc) returns 0 (for example, once the
DMAC has read the last block's source items into the channel FIFO so
dwc_get_sent(dwc) equals desc->len while the peripheral is still draining t=
he
FIFO, or if the new transfer completes between reading RAW.XFER and reading
LLP/CTL_HI), dwc_scan_descriptors() calls dwc_descriptor_complete(dwc, desc,
true) without removing desc->desc_node from dwc->active_list.

Since dwc_descriptor_complete() -> dwc_desc_put() frees desc back to
dw->desc_pool via dma_pool_free() without unlinking desc->desc_node, doesn't
this leave a freed dw_desc linked on dwc->active_list while also prematurely
disabling the channel, leading to a use-after-free and double-free on
subsequent completions, status queries, or terminations?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022-submit-dw-=
dma-synchronize-v1-v2-0-5244e94dca8c@gmail.com?part=3D2
