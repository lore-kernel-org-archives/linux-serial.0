Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F151C77B7C
	for <linux-serial@archiver.kernel.org>; Thu,  4 May 2023 13:03:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230521AbjEDNDA (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 4 May 2023 09:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjEDNC7 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 4 May 2023 09:02:59 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 888536EAD
        for <linux-serial@vger.kernel.org>; Thu,  4 May 2023 06:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683205378; x=1714741378;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=xM64I/nFpNGpCDSu3fNsXJXVdqySKARWapyV+lr8QlI=;
  b=WGcJPxHafj6125HwEg3YLdrkgxVFqtO/aHUXd6NYEhvmDIkwRDidFWa9
   HArUd+DtSH+gupZw6RGiP0RHfGbTIDe5xUWvSkaxAcFzxiIaAN8vYeo2I
   KKAqsWITI2zjVLRrbG5bFeVU96YTlqzZyF/cB3G2dZwYQC537xwla4WOb
   7FiAW376+d/fuyDLguoWVwpaj4+uLlv+dcXaFe+Rc6F7VE5SQEmZyIA2j
   cT8RKivcgbYD5XrTcDOeAZ4oms6HjIZCDjKBsgcPzja6Mvi/BlOSL/PxL
   zRjaiWeBQd3PwxCKC/YHTglJiBqyrRKZWMCHMzpwTsE0LVTJQX2QJAkNS
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10700"; a="376990620"
X-IronPort-AV: E=Sophos;i="5.99,249,1677571200"; 
   d="scan'208";a="376990620"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2023 06:02:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10700"; a="766565895"
X-IronPort-AV: E=Sophos;i="5.99,249,1677571200"; 
   d="scan'208";a="766565895"
Received: from mleshin-mobl2.ger.corp.intel.com ([10.251.217.25])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2023 06:02:25 -0700
Date:   Thu, 4 May 2023 16:02:19 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Shenwei Wang <shenwei.wang@nxp.com>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        "imx@lists.linux.dev" <imx@lists.linux.dev>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [EXT] Re: [PATCH 1/1] tty: serial: fsl_lpuart: optimize the
 timer based EOP logic
In-Reply-To: <PAXPR04MB9185C216231729D3EF8091E3896C9@PAXPR04MB9185.eurprd04.prod.outlook.com>
Message-ID: <6bb5ddbf-580-83a3-766e-108ecfe7d48f@linux.intel.com>
References: <20230502190641.657483-1-shenwei.wang@nxp.com> <2a4bec70-4285-c48c-1bb9-c2e713ce3e0@linux.intel.com> <PAXPR04MB9185C216231729D3EF8091E3896C9@PAXPR04MB9185.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-784435115-1683194076=:1823"
Content-ID: <6b39552-d94-dba8-537-5416e31f27a1@linux.intel.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-784435115-1683194076=:1823
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <70ffbb19-5540-7889-852f-be4c896982f4@linux.intel.com>

On Wed, 3 May 2023, Shenwei Wang wrote:
> From: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > On Tue, 2 May 2023, Shenwei Wang wrote:
> > 
> > > At low baud rates, the DMA transfer may end prematurely due to the
> > > timer, even during an active transfer. This does not accurately
> > > simulate an EOP event as intended. We expect the timer to only
> > > complete a DMA transfer once the idle period satisfies a specified interval.
> > >
> > > The patch checks the DMA residue count before copying data to the TTY
> > > buffer. If the residue count remains unchanged since the last
> > > interrupt, that indicates no new data was received. In this case, the
> > > DMA should complete as an EOP event. Instead, the timer restarts.
> > 
> > This description is lacking something. It does not explain why the stuff in second
> > paragraph is necessary at all as setting a longer timer based on the (lower) baud
> > rate would avoid the need to do the timer restart.
> > 
> 
> Agree. Would add the following to the last sentence: "if no new 
> characters are received, the timer just restarts".  

That, however, is unfortunately not the case I was interested in here. The 
code does restart the timer if new characters _were received_ (residue 
changed), no? So my request for clarification to the changelong still 
stands, why is rearming the timer necessary instead of simply setting a 
longer timeout right from the start?

(In the first paragraph, you stated the problem is about timer triggering 
prematurely with low baud rates.)

This is not to say that the new approach is wrong but the changelog fails 
to explain all facets of what is wrong with the old approach adequately.

> Just had a check with the circ_buf.h, and this piece of codes can be simplified
> with the CIRC_CNT() function.
> 
> The other part you mentioned should be optimized as well. I will submit a separate
> patch to do that after finishing this one.

Okay. You might also find CIRC_CNT_TO_END() useful in those inner 
functions to calculate the length before the wrap.

> > > +
> > > +     /* Check if new data received before copying */
> > > +     if ((count != 0) && (sport->last_residue == state.residue))
> > 
> > I'm unsure about this condition being right.
> > 
> > What will happen when rx_sgl.length (or -1 of that, I'm not sure which way "full
> > size" is here) worth of data has been DMA'ed. Does this condition end up
> > delaying copy such that it's done only on every other call here?
> > 
> 
> The timer function will only complete a DMA transfer when there is new data in the buffer 
> and the data has been idle for the specified interval. 
> 
> The "full buffer" situation should be handled by the DMA completion callback itself.  A "full" buffer 
> means the DMA transaction has received sufficient data and invoked the completion callback.
> 
> > Also, should you reset last_residue in lpuart_start_rx_dma() ? I think that would
> > solve the "full size" problem.

What about this part? If the transfer always does n chars, the left over 
residue can match spuriously for the new transfer and trigger the copy 
because last and current residue happen to match (kinda by chance but 
could be simply due to repetitive transfer pattern)?

> > > +     sport->dma_rx_timeout =
> > > +             msecs_to_jiffies((1000 * 10 * DMA_RX_IDLE_CHARS) / baud
> > > + + 1);
> > 
> > There's ->frame_time these days in uart_port which you should base frame
> > timing related calculations. I wouldn't mind if that existing ->frame_time math
> > that is visible in your patch's context is also converted (in a separate patch).
> > 
> > I'm assuming that magic 10 is assumed number of bits and 1000 MSEC_PER_SEC.
> > That +1 seems odd, did you mean DIV_ROUND_UP() ?
> 
> Yes, it is 10 bits and 1000 ms. +1 here is similar to the result of round up. 
> And also the ->frame_time could be used for simplicity.

Yes, please use ->frame_time. I added it exactly to allow this kind of 
calculations to be easily based on actual frame timing (the other 
questions were just to gauge if I understood right what is behind your 
math).


-- 
 i.
--8323329-784435115-1683194076=:1823--
