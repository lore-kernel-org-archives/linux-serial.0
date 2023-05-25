Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DC42C7EE2C
	for <linux-serial@archiver.kernel.org>; Thu, 25 May 2023 08:44:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240326AbjEYIoH (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 25 May 2023 04:44:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238947AbjEYIoD (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 25 May 2023 04:44:03 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB0F41B5
        for <linux-serial@vger.kernel.org>; Thu, 25 May 2023 01:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685004233; x=1716540233;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=lRvJvFqBTTpjjutFjPbFJeVNDnWz0n+FbRDdnVZuovI=;
  b=BwSP50tNCBCydDBy+BiZL6Kz6P6tUjQrIVXxmjleF09eqAbqetU4tY4x
   wH3xVtF6v0B0H113KwAX+DRZDnaHsug4btaJn9bwpe7RMqcKepR+x8a0p
   OO1oj55Ps8daqjlrWVtxIYRDyYrU+VRzlkBBbPHlbwm6Op6PZsyvOaKED
   rT17KyQTqCHJNNTaZLDAC+dButtELtqWoYnh3C0yIZhSKrQM1qW8X3pta
   Cr4k+Fs2Kza4DVdOFWA3ZjBCjbOWbf81SKjb0iN1jL37vVyowauhwreCf
   4cSbahCNIY/Ti/Vu9BkU4ob0xvvbpCAKr192ABVYCieTbtU4iR3sEqclJ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10720"; a="338403522"
X-IronPort-AV: E=Sophos;i="6.00,190,1681196400"; 
   d="scan'208";a="338403522"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2023 01:43:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10720"; a="849105775"
X-IronPort-AV: E=Sophos;i="6.00,190,1681196400"; 
   d="scan'208";a="849105775"
Received: from aghiriba-mobl.ger.corp.intel.com ([10.249.40.17])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2023 01:43:51 -0700
Date:   Thu, 25 May 2023 11:43:49 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Richard Tresidder <rtresidd@electromag.com.au>
cc:     linux-serial <linux-serial@vger.kernel.org>
Subject: Re: Possible regression in 8250_dw driver
In-Reply-To: <94bb9b7a-d69e-d578-3787-5a6146ec99dc@electromag.com.au>
Message-ID: <559021f9-2831-5840-aee8-23918602f3f@linux.intel.com>
References: <f8a86ecd-64b1-573f-c2fa-59f541083f1a@electromag.com.au> <f9a5a97c-42e5-bd7a-4a42-a79ab2f7cbad@linux.intel.com> <261812cb-6de4-ec2b-18b0-90b5d9cc83e4@electromag.com.au> <8f778157-43fa-f364-d7e0-a022401b28@linux.intel.com>
 <94bb9b7a-d69e-d578-3787-5a6146ec99dc@electromag.com.au>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1199346738-1685004232=:1738"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1199346738-1685004232=:1738
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Thu, 25 May 2023, Richard Tresidder wrote:

> 
> 
> 
> 
> Richard Tresidder
> 
> 
> 
> 
> 
> 
> 
> 
> **
> 
> 
> 
> 
> 
> 
> On 24/05/2023 6:06 pm, Ilpo Järvinen wrote:
> 
> > On Wed, 24 May 2023, Richard Tresidder wrote:
> > > On 23/05/2023 7:13 pm, Ilpo Järvinen wrote:
> > > > On Tue, 23 May 2023, Richard Tresidder wrote:
> > > > 
> > > > > background:
> > > > > I'm attempting to use 6.3.3 as a new base for one of our systems.
> > > > > Previously it was using 5.1.7 as a base.
> > > > > The uart in question is one of the two in the Cyclone V SOC HPS.
> > > > > And to muddy the waters the linux console TTYS0 is the other Uart from
> > > > > the
> > > > > same HPS core
> > > > > Yet the console appears to be working ok.
> > > > Maybe some of the DMA related changes triggering some unexpected
> > > > behavior.
> > > > 
> > > > Console doesn't use DMA so that could explain the difference.
> > > > 
> > > > > Note all other libs and apps are at the same revision and build, it is
> > > > > only
> > > > > the kernel that is different.
> > > > > Both versions of the kernel are also built using the same bitbake
> > > > > bsdk..
> > > > > 
> > > > > 
> > > > > As you can see it looks like the frame thats received on the 6.3.3
> > > > > kernel
> > > > > is
> > > > > mangled?
> > > > > This same message is just being requested over and over again from the
> > > > > GPS
> > > > > unit.
> > > > > 
> > > > > The offset where the tears occur looks to be pretty similar between
> > > > > each
> > > > > poll
> > > > > request.
> > > > > Usually the 1 at the end of the (75331 is where the first tear occurs.
> > > > > 
> > > > > I'd appreciate some quidance in how to track this down as there
> > > > > appears to
> > > > > have been a reasonable amount of work done to this driver and the
> > > > > serial
> > > > > core
> > > > > between these two versions.
> > > > A few ideas:
> > > > - try without dma_rx_complete() calling p->dma->rx_dma(p)
> > > > - revert 90b8596ac46043e4a782d9111f5b285251b13756
> > > > - Try the revert in
> > > > https://lore.kernel.org/all/316ab583-d217-a332-d161-8225b0cee227@redhat.com/2-0001-Revert-serial-8250-use-THRE-__stop_tx-also-with-DMA.patch
> > > >     (for e8ffbb71f783 and f8d6e9d3ca5c)
> > > > 
> > > > But finding the culprit with git bisect would be the most helpful here.
> > > > 
> > > Bisect wasn't an easy option as I'd applied a pile of patches after the
> > > interesting commits for our system to run.
> > > I'm not a git master :)
> > > 
> > > So I just started reverting the patches that had been applied to the 8250
> > > folder.
> > > Worked backwards from head.
> > > 
> > > After reverting 57e9af7831dcf211c5c689c2a6f209f4abdf0bce
> > > serial: 8250_dma: Fix DMA Rx rearm race
> > > 
> > > Things started to work again.
> > > 
> > > I reset everything and then just reverted that individual patch and things
> > > work.
> > > So that looks like the culprit..
> > Okay, that also worked great, thanks a lot. It gives something concrete to
> > work with to find a fix.
> > 
> > The commit itself looks very much correct, however, my guess is that when
> > serial8250_rx_dma_flush() does dmaengine_pause() dma_status somehow
> > does not become DMA_PAUSED which leads to not properly flushing DMA Rx
> > transaction. Can you try the following debug patch (if my guess is
> > correct, besides triggering the WARN_ON_ONCE, it also works around the
> > issue):
> > 
> > [PATCH] DEBUG: 8250_dma: Detect DMA_PAUSED vs DMA_IN_PROGRESS inconsistency
> > 
> > Detect DMA state not returning DMA_PAUSED after dmaengine_pause() was
> > issued.
> > 
> > Not intended for upstream.
> 
> Thanks Ilpo
>    I can confirm that the patch below works. Got the WARN_ON_ONCE dump so it's
> taking that path.
> I think the problem here is that the pl330 DMA controller thats in these SOC's
> doesn't "really" support pause according to the driver.

For this flush usecase, it is enough to support pause + read residue +
terminate which is supported according to the function comment for
pl330_pause().

> It doesn't look like it can ever set "DMA_PAUSED"

Why not? It pauses the transfer and is even able to allow reading the 
transferred byte count.

What it is claimed to not be able to do is resume. Note that w/o resume
serial8250_tx_dma() XON/XOFF processing will not work but that's 
unrelated to this issue (I'll probably need to do another patch to fix 
that on 8250 DMA side).

> I'm not sure of the flow through of that though.
> There is some commenting in the pl330 driver about the pause routine.

Maybe the patch below will help with pl330 DMA status (based on somewhat 
limited understanding of all the moving parts):


[PATCH] dmaengine: pl330: Set DMA_PAUSED when pausing

pl330_pause() does not set anything to indicate paused condition which
causes pl330_tx_status() to return DMA_IN_PROGRESS. This breaks 8250
DMA code after the fix in commit 57e9af7831dc ("serial: 8250_dma: Fix
DMA Rx rearm race"). The function comment for pl330_pause() claims
pause is supported but resume is not which is enough for 8250 DMA flush
to work as long as DMA status is reported correctly when appropriate.

Add PAUSED state for descriptor and mark BUSY descriptors with PAUSED
in pl330_pause(). Return DMA_PAUSED from pl330_tx_status() when the
descriptor is PAUSED.

Fixes: 88987d2c7534 ("dmaengine: pl330: add DMA_PAUSE feature")
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

---
 drivers/dma/pl330.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
index 0d9257fbdfb0..daad25f2c498 100644
--- a/drivers/dma/pl330.c
+++ b/drivers/dma/pl330.c
@@ -403,6 +403,12 @@ enum desc_status {
 	 * of a channel can be BUSY at any time.
 	 */
 	BUSY,
+	/*
+	 * Pause was called while descriptor was BUSY. Due to hardware
+	 * limitations, only termination is possible for descriptors
+	 * that have been paused.
+	 */
+	PAUSED,
 	/*
 	 * Sitting on the channel work_list but xfer done
 	 * by PL330 core
@@ -2041,7 +2047,7 @@ static inline void fill_queue(struct dma_pl330_chan *pch)
 	list_for_each_entry(desc, &pch->work_list, node) {
 
 		/* If already submitted */
-		if (desc->status == BUSY)
+		if (desc->status == BUSY || desc->status == PAUSED)
 			continue;
 
 		ret = pl330_submit_req(pch->thread, desc);
@@ -2326,6 +2332,7 @@ static int pl330_pause(struct dma_chan *chan)
 {
 	struct dma_pl330_chan *pch = to_pchan(chan);
 	struct pl330_dmac *pl330 = pch->dmac;
+	struct dma_pl330_desc *desc;
 	unsigned long flags;
 
 	pm_runtime_get_sync(pl330->ddma.dev);
@@ -2335,6 +2342,10 @@ static int pl330_pause(struct dma_chan *chan)
 	_stop(pch->thread);
 	spin_unlock(&pl330->lock);
 
+	list_for_each_entry(desc, &pch->work_list, node) {
+		if (desc->status == BUSY)
+			desc->status = PAUSED;
+	}
 	spin_unlock_irqrestore(&pch->lock, flags);
 	pm_runtime_mark_last_busy(pl330->ddma.dev);
 	pm_runtime_put_autosuspend(pl330->ddma.dev);
@@ -2425,7 +2436,7 @@ pl330_tx_status(struct dma_chan *chan, dma_cookie_t cookie,
 		else if (running && desc == running)
 			transferred =
 				pl330_get_current_xferred_count(pch, desc);
-		else if (desc->status == BUSY)
+		else if (desc->status == BUSY || desc->status == PAUSED)
 			/*
 			 * Busy but not running means either just enqueued,
 			 * or finished and not yet marked done
@@ -2442,6 +2453,9 @@ pl330_tx_status(struct dma_chan *chan, dma_cookie_t cookie,
 			case DONE:
 				ret = DMA_COMPLETE;
 				break;
+			case PAUSED:
+				ret = DMA_PAUSED;
+				break;
 			case PREP:
 			case BUSY:
 				ret = DMA_IN_PROGRESS;

-- 
tg: (5af9d9508d7d..) fix/pl330-paused (depends on: debug/dma-paused)
--8323329-1199346738-1685004232=:1738--
