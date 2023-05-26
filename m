Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74FB3C7EE23
	for <linux-serial@archiver.kernel.org>; Fri, 26 May 2023 10:16:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236835AbjEZKQT (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 26 May 2023 06:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242528AbjEZKQS (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 26 May 2023 06:16:18 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61E18195
        for <linux-serial@vger.kernel.org>; Fri, 26 May 2023 03:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685096174; x=1716632174;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=fMvQzvD4B9Y6AFznqRUw0DCfTLmUmPl9nHIajPJ8AEE=;
  b=f3RgDkpQ8WzHoiQufOXg3I57w6MxTXxIJhPakkkWKQM5bQV0iQ19EX+I
   KPOhWe3fN36XyC4REtFPH4fzOj/OC75YqMC7lsnUU3n7g6yo7O6K9+8nW
   hv8FwPnb4nVmYrVmIFyWlEhDIeMsKVgjSRg5/nkNoydqngHipmRBJkyQU
   Ih9k6QQYczCHpK8H6FXm6W7vEzS+e1TIP6movFNXqdBllthngQ1CINmql
   wvNCzqQanJxinbtjzGnNjXzKjYN/mVJKPkzSlBGnp0Q36yG/Okzc8r/Fk
   0HV2NVkjEuP9pwGKD2LWliitnP7/P3MiSePKevE5JFqTECiLUmpqAstN8
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10721"; a="382414360"
X-IronPort-AV: E=Sophos;i="6.00,193,1681196400"; 
   d="scan'208";a="382414360"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2023 03:16:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10721"; a="699378579"
X-IronPort-AV: E=Sophos;i="6.00,193,1681196400"; 
   d="scan'208";a="699378579"
Received: from eandrei-mobl5.ger.corp.intel.com ([10.252.53.213])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2023 03:16:12 -0700
Date:   Fri, 26 May 2023 13:16:09 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Richard Tresidder <rtresidd@electromag.com.au>
cc:     linux-serial <linux-serial@vger.kernel.org>
Subject: Re: Possible regression in 8250_dw driver
In-Reply-To: <2d86b525-b9e3-6e8c-3b1a-922fff68b83d@electromag.com.au>
Message-ID: <916c5ab-f7c8-8842-f8de-6f1aaea04edf@linux.intel.com>
References: <f8a86ecd-64b1-573f-c2fa-59f541083f1a@electromag.com.au> <f9a5a97c-42e5-bd7a-4a42-a79ab2f7cbad@linux.intel.com> <261812cb-6de4-ec2b-18b0-90b5d9cc83e4@electromag.com.au> <8f778157-43fa-f364-d7e0-a022401b28@linux.intel.com>
 <94bb9b7a-d69e-d578-3787-5a6146ec99dc@electromag.com.au> <559021f9-2831-5840-aee8-23918602f3f@linux.intel.com> <def355b6-5573-90ff-a6d0-5174673f1a37@electromag.com.au> <9aec3419-f971-6d5-ff8b-dd8566742d3a@linux.intel.com>
 <2d86b525-b9e3-6e8c-3b1a-922fff68b83d@electromag.com.au>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1915643853-1685096173=:1602"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1915643853-1685096173=:1602
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Fri, 26 May 2023, Richard Tresidder wrote:

> On 25/05/2023 5:38 pm, Ilpo Järvinen wrote:
> 
> > On Thu, 25 May 2023, Richard Tresidder wrote:
> > > On 25/05/2023 4:43 pm, Ilpo Järvinen wrote:
> > > > On Thu, 25 May 2023, Richard Tresidder wrote:
> > > > > On 24/05/2023 6:06 pm, Ilpo Järvinen wrote:
> > > > > > On Wed, 24 May 2023, Richard Tresidder wrote:
> > > > > > > So I just started reverting the patches that had been applied to
> > > > > > > the
> > > > > > > 8250
> > > > > > > folder.
> > > > > > > Worked backwards from head.
> > > > > > > 
> > > > > > > After reverting 57e9af7831dcf211c5c689c2a6f209f4abdf0bce
> > > > > > > serial: 8250_dma: Fix DMA Rx rearm race
> > > > > > > 
> > > > > > > Things started to work again.
> > > > > > > 
> > > > > > > I reset everything and then just reverted that individual patch
> > > > > > > and
> > > > > > > things
> > > > > > > work.
> > > > > > > So that looks like the culprit..
> > > > > > Okay, that also worked great, thanks a lot. It gives something
> > > > > > concrete
> > > > > > to
> > > > > > work with to find a fix.
> > > > > > 
> > > > > > The commit itself looks very much correct, however, my guess is that
> > > > > > when
> > > > > > serial8250_rx_dma_flush() does dmaengine_pause() dma_status somehow
> > > > > > does not become DMA_PAUSED which leads to not properly flushing DMA
> > > > > > Rx
> > > > > > transaction. Can you try the following debug patch (if my guess is
> > > > > > correct, besides triggering the WARN_ON_ONCE, it also works around
> > > > > > the
> > > > > > issue):
> > > > > > 
> > > > > > [PATCH] DEBUG: 8250_dma: Detect DMA_PAUSED vs DMA_IN_PROGRESS
> > > > > > inconsistency
> > > > > > 
> > > > > > Detect DMA state not returning DMA_PAUSED after dmaengine_pause()
> > > > > > was
> > > > > > issued.
> > > > > > 
> > > > > > Not intended for upstream.
> > > > > Thanks Ilpo
> > > > >      I can confirm that the patch below works. Got the WARN_ON_ONCE
> > > > > dump so
> > > > > it's
> > > > > taking that path.
> > > > > I think the problem here is that the pl330 DMA controller thats in
> > > > > these
> > > > > SOC's
> > > > > doesn't "really" support pause according to the driver.
> > > > For this flush usecase, it is enough to support pause + read residue +
> > > > terminate which is supported according to the function comment for
> > > > pl330_pause().
> > > Yep agree given the 8250 serial code immediately terminates the dma after
> > > the
> > > pause during the flush anyway..
> > > 
> > > > > It doesn't look like it can ever set "DMA_PAUSED"
> > > > Why not? It pauses the transfer and is even able to allow reading the
> > > > transferred byte count.
> > > > 
> > > > What it is claimed to not be able to do is resume. Note that w/o resume
> > > > serial8250_tx_dma() XON/XOFF processing will not work but that's
> > > > unrelated to this issue (I'll probably need to do another patch to fix
> > > > that on 8250 DMA side).
> > > Yep I just meant it doesn't look capable of reporting DMA_PAUSED
> > > Which your patch below probably fixes.
> > > and it kind of does a stop without a resume capability so must be
> > > terminated
> > > after this.
> > > Though I'm not sure of the implications of reporting paused without resume
> > > capability.
> > > Kind of an odd one..
> > dma_slave_caps has a bool for both pause and resume support (I only found
> > out about the second flag for resume today) so not unheard of it seems.
> 
> I've just tested the pl330 patch and it looks good.
> No longer get the WARN_ON_ONCE triggered in the 8250_dma driver so it looks
> like
> Paused is correctly being set now and we're avoiding that path.

Thanks a lot for testing the fix and also for your invaluable help in 
narrowing down the problem. It would have been very hard to find the 
culprit otherwise.

Can I add your Tested-by tag before sending the official version of the 
fix out?

> Wonder how many others dma drivers are afflicted in the same manner?
> A quick grep seems to infer a lot more drivers set the pause function then
> have
> something in them setting the status to DMA_PAUSED so probably good to keep
> the
> 8250 fix in also for the time being.

There might be others, but then the patch which covered the issue has gone
to stables already months ago and you're the first to report it AFAIK so 
perhaps not that wide-spread.

I'll think how to deal with this on 8250_dma side.


-- 
 i.

--8323329-1915643853-1685096173=:1602--
