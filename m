Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D9F2C77B7A
	for <linux-serial@archiver.kernel.org>; Thu, 25 May 2023 09:40:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240940AbjEYJkP (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 25 May 2023 05:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233700AbjEYJj3 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 25 May 2023 05:39:29 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A884E1AB
        for <linux-serial@vger.kernel.org>; Thu, 25 May 2023 02:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685007493; x=1716543493;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=VyfzuORKJKvXQVBBnyodKPLxD9U6bTifZe3ZPrii40M=;
  b=SgDANFPmk5cCd1Sp42yhU+jUeG/qwOLLViD2J066hOxSW1n3kunaUEhV
   ydt3rj/jPMU8gqVjEnR0MpPvLTQYLjC+W6oDAEm3uCdBGj2x6zlUiU2uo
   9HV7Edfcr0aQ+Vr+E4Hmjy1wYIr5bpMF1uifPYPb+rpiNpM23VAHZWKnp
   zuZZMLK+nO+RIAEBkGL95a64BjbKv5i1rF98zVjDqRegFMbfCiXSKXL2H
   REL4dlgsQ9gPifUuGs7ULzY8EU46foDujhhjhT1wnunAS5fgsOaAZq6aj
   8mROGECqGJrIRpI1B3JrteAfuhZdUD+zvh7yuhJv7HQvLB9MdRQpRRzK2
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10720"; a="338415374"
X-IronPort-AV: E=Sophos;i="6.00,190,1681196400"; 
   d="scan'208";a="338415374"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2023 02:38:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10720"; a="951388504"
X-IronPort-AV: E=Sophos;i="6.00,190,1681196400"; 
   d="scan'208";a="951388504"
Received: from aghiriba-mobl.ger.corp.intel.com ([10.249.40.17])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2023 02:38:11 -0700
Date:   Thu, 25 May 2023 12:38:09 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Richard Tresidder <rtresidd@electromag.com.au>
cc:     linux-serial <linux-serial@vger.kernel.org>
Subject: Re: Possible regression in 8250_dw driver
In-Reply-To: <def355b6-5573-90ff-a6d0-5174673f1a37@electromag.com.au>
Message-ID: <9aec3419-f971-6d5-ff8b-dd8566742d3a@linux.intel.com>
References: <f8a86ecd-64b1-573f-c2fa-59f541083f1a@electromag.com.au> <f9a5a97c-42e5-bd7a-4a42-a79ab2f7cbad@linux.intel.com> <261812cb-6de4-ec2b-18b0-90b5d9cc83e4@electromag.com.au> <8f778157-43fa-f364-d7e0-a022401b28@linux.intel.com>
 <94bb9b7a-d69e-d578-3787-5a6146ec99dc@electromag.com.au> <559021f9-2831-5840-aee8-23918602f3f@linux.intel.com> <def355b6-5573-90ff-a6d0-5174673f1a37@electromag.com.au>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1921002036-1685007492=:1738"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1921002036-1685007492=:1738
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Thu, 25 May 2023, Richard Tresidder wrote:
> On 25/05/2023 4:43 pm, Ilpo Järvinen wrote:
> > On Thu, 25 May 2023, Richard Tresidder wrote:
> > > On 24/05/2023 6:06 pm, Ilpo Järvinen wrote:
> > > > On Wed, 24 May 2023, Richard Tresidder wrote:
> > > > > So I just started reverting the patches that had been applied to the
> > > > > 8250
> > > > > folder.
> > > > > Worked backwards from head.
> > > > > 
> > > > > After reverting 57e9af7831dcf211c5c689c2a6f209f4abdf0bce
> > > > > serial: 8250_dma: Fix DMA Rx rearm race
> > > > > 
> > > > > Things started to work again.
> > > > > 
> > > > > I reset everything and then just reverted that individual patch and
> > > > > things
> > > > > work.
> > > > > So that looks like the culprit..
> > > > Okay, that also worked great, thanks a lot. It gives something concrete
> > > > to
> > > > work with to find a fix.
> > > > 
> > > > The commit itself looks very much correct, however, my guess is that
> > > > when
> > > > serial8250_rx_dma_flush() does dmaengine_pause() dma_status somehow
> > > > does not become DMA_PAUSED which leads to not properly flushing DMA Rx
> > > > transaction. Can you try the following debug patch (if my guess is
> > > > correct, besides triggering the WARN_ON_ONCE, it also works around the
> > > > issue):
> > > > 
> > > > [PATCH] DEBUG: 8250_dma: Detect DMA_PAUSED vs DMA_IN_PROGRESS
> > > > inconsistency
> > > > 
> > > > Detect DMA state not returning DMA_PAUSED after dmaengine_pause() was
> > > > issued.
> > > > 
> > > > Not intended for upstream.
> > > Thanks Ilpo
> > >     I can confirm that the patch below works. Got the WARN_ON_ONCE dump so
> > > it's
> > > taking that path.
> > > I think the problem here is that the pl330 DMA controller thats in these
> > > SOC's
> > > doesn't "really" support pause according to the driver.
> > For this flush usecase, it is enough to support pause + read residue +
> > terminate which is supported according to the function comment for
> > pl330_pause().
> 
> Yep agree given the 8250 serial code immediately terminates the dma after the
> pause during the flush anyway..
> 
> > > It doesn't look like it can ever set "DMA_PAUSED"
> > Why not? It pauses the transfer and is even able to allow reading the
> > transferred byte count.
> > 
> > What it is claimed to not be able to do is resume. Note that w/o resume
> > serial8250_tx_dma() XON/XOFF processing will not work but that's
> > unrelated to this issue (I'll probably need to do another patch to fix
> > that on 8250 DMA side).
> 
> Yep I just meant it doesn't look capable of reporting DMA_PAUSED
> Which your patch below probably fixes.
> and it kind of does a stop without a resume capability so must be terminated
> after this.
> Though I'm not sure of the implications of reporting paused without resume
> capability.
> Kind of an odd one..

dma_slave_caps has a bool for both pause and resume support (I only found 
out about the second flag for resume today) so not unheard of it seems.

-- 
 i.


> I'll check your pl330 patch out tomorrow, and see what else might break.
>
> > > I'm not sure of the flow through of that though.
> > > There is some commenting in the pl330 driver about the pause routine.
> > Maybe the patch below will help with pl330 DMA status (based on somewhat
> > limited understanding of all the moving parts):
> > 
> > 
> > [PATCH] dmaengine: pl330: Set DMA_PAUSED when pausing
> > 
> > pl330_pause() does not set anything to indicate paused condition which
> > causes pl330_tx_status() to return DMA_IN_PROGRESS. This breaks 8250
> > DMA code after the fix in commit 57e9af7831dc ("serial: 8250_dma: Fix
> > DMA Rx rearm race"). The function comment for pl330_pause() claims
> > pause is supported but resume is not which is enough for 8250 DMA flush
> > to work as long as DMA status is reported correctly when appropriate.
> > 
> > Add PAUSED state for descriptor and mark BUSY descriptors with PAUSED
> > in pl330_pause(). Return DMA_PAUSED from pl330_tx_status() when the
> > descriptor is PAUSED.
> > 
> > Fixes: 88987d2c7534 ("dmaengine: pl330: add DMA_PAUSE feature")
> > Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > 
> > ---
> >   drivers/dma/pl330.c | 18 ++++++++++++++++--
> >   1 file changed, 16 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
> > index 0d9257fbdfb0..daad25f2c498 100644
> > --- a/drivers/dma/pl330.c
> > +++ b/drivers/dma/pl330.c
> > @@ -403,6 +403,12 @@ enum desc_status {
> >   	 * of a channel can be BUSY at any time.
> >   	 */
> >   	BUSY,
> > +	/*
> > +	 * Pause was called while descriptor was BUSY. Due to hardware
> > +	 * limitations, only termination is possible for descriptors
> > +	 * that have been paused.
> > +	 */
> > +	PAUSED,
> >   	/*
> >   	 * Sitting on the channel work_list but xfer done
> >   	 * by PL330 core
> > @@ -2041,7 +2047,7 @@ static inline void fill_queue(struct dma_pl330_chan
> > *pch)
> >   	list_for_each_entry(desc, &pch->work_list, node) {
> >     		/* If already submitted */
> > -		if (desc->status == BUSY)
> > +		if (desc->status == BUSY || desc->status == PAUSED)
> >   			continue;
> >     		ret = pl330_submit_req(pch->thread, desc);
> > @@ -2326,6 +2332,7 @@ static int pl330_pause(struct dma_chan *chan)
> >   {
> >   	struct dma_pl330_chan *pch = to_pchan(chan);
> >   	struct pl330_dmac *pl330 = pch->dmac;
> > +	struct dma_pl330_desc *desc;
> >   	unsigned long flags;
> >     	pm_runtime_get_sync(pl330->ddma.dev);
> > @@ -2335,6 +2342,10 @@ static int pl330_pause(struct dma_chan *chan)
> >   	_stop(pch->thread);
> >   	spin_unlock(&pl330->lock);
> >   +	list_for_each_entry(desc, &pch->work_list, node) {
> > +		if (desc->status == BUSY)
> > +			desc->status = PAUSED;
> > +	}
> >   	spin_unlock_irqrestore(&pch->lock, flags);
> >   	pm_runtime_mark_last_busy(pl330->ddma.dev);
> >   	pm_runtime_put_autosuspend(pl330->ddma.dev);
> > @@ -2425,7 +2436,7 @@ pl330_tx_status(struct dma_chan *chan, dma_cookie_t
> > cookie,
> >   		else if (running && desc == running)
> >   			transferred =
> >   				pl330_get_current_xferred_count(pch, desc);
> > -		else if (desc->status == BUSY)
> > +		else if (desc->status == BUSY || desc->status == PAUSED)
> >   			/*
> >   			 * Busy but not running means either just enqueued,
> >   			 * or finished and not yet marked done
> > @@ -2442,6 +2453,9 @@ pl330_tx_status(struct dma_chan *chan, dma_cookie_t
> > cookie,
> >   			case DONE:
> >   				ret = DMA_COMPLETE;
> >   				break;
> > +			case PAUSED:
> > +				ret = DMA_PAUSED;
> > +				break;
> >   			case PREP:
> >   			case BUSY:
> >   				ret = DMA_IN_PROGRESS;
> > 
> 
--8323329-1921002036-1685007492=:1738--
