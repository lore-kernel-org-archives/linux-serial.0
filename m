Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D5EBC433F5
	for <linux-serial@archiver.kernel.org>; Wed, 25 May 2022 11:21:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234586AbiEYLVZ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 25 May 2022 07:21:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231203AbiEYLVY (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 25 May 2022 07:21:24 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA95487A09
        for <linux-serial@vger.kernel.org>; Wed, 25 May 2022 04:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653477683; x=1685013683;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=iRlD7ypje9lRnsZ3t0wAS8o3qfAvjVBDNa5Wtxw1khA=;
  b=FDM4nOVMslHo2oo7y8KJRP/Cn5SAjvbnQMbVQjysbDyHLpAbMzbqrJ0q
   1aPtP4JwVfsHKxH12WVzQc4gL4jCbnSABIfOHoLwBkzMOg3Bqtz55lvEq
   xXSiRcE5Ld7amHqcAJdzJK3ky5xU4bQp5tk2fDzf52Hm1K//fBpozqq3B
   EPKU04epW6zGeHON1W7Mz6SqqXjRz3rJhDM/3nUtRD3d93vnu+kqKTjr7
   5gERWLj0tNZ3d8rOavqz5d2ROPuFvODqH84rT5VdayXY98wBPWFkiFgRf
   /IkJVAcpxJNdRMdpGBvLaXD0DrVZxaiXhh68jFZo3c180iUTiaa3m5/g7
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10357"; a="273514603"
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="273514603"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2022 04:21:23 -0700
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="573188910"
Received: from gbocksch-mobl.ger.corp.intel.com ([10.252.55.246])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2022 04:21:21 -0700
Date:   Wed, 25 May 2022 14:21:16 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     cael <juanfengpy@gmail.com>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>
Subject: Re: tty: fix a possible hang on tty device
In-Reply-To: <CAPmgiULo4h8bOrzL+XJ5Pndw0kz80fBPfH_KNLx3c5j-Yj04SA@mail.gmail.com>
Message-ID: <269a9a97-dc62-a89-d978-3be8e9d1f7e4@linux.intel.com>
References: <CAPmgiU+HucpCLvEyre9GHj7S1K0smnUfbhG2HLCQb8x1LpVr_Q@mail.gmail.com> <b316c623-ca11-716f-4445-9b35e075630@linux.intel.com> <CAPmgiU+=uA9DrN13kAYb7VQ0xmfEA+xUduu+qEvp75qxFpZq7g@mail.gmail.com> <707c16ca-1610-68b1-fc96-4c5906f2c86@linux.intel.com>
 <CAPmgiUKar69xaRJ5F2oXBx+WPjSipqKjth85bm+NHZsmzsb+pg@mail.gmail.com> <c4de15d1-547d-eefe-eb43-c2e9da8f57ed@linux.intel.com> <CAPmgiULo4h8bOrzL+XJ5Pndw0kz80fBPfH_KNLx3c5j-Yj04SA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, 25 May 2022, cael wrote:

> >Now you switched to an entirely different case, not the one we were
> >talking about. ...There is no ldisc->no_room = true race in the case
> >you now described.
> So, I think we should back to the case ldata->no_room=true as
> ldata->no_room=false seems harmless.
> 
> >I'm not worried about the case where both cpus call n_tty_kick_worker but
> >the case where producer cpu sees chars_in_buffer() > 0 and consumer cpu
> >!no_room.
>
> As ldata->no_room=true is set before checking chars_in_buffer()

Please take a brief look at Documentation/memory-barriers.txt and then 
tell me if you still find this claim to be true.

> if producer
> finds chars_in_buffer() > 0, then if reader is currently in n_tty_read,

...Then please do a similar analysis for ldata->read_tail. What guarantees 
its update is seen by the producer cpu when the reader is already past the 
point you think it still must be in?

> when reader quits n_tty_read, n_tty_kick_worker will be called. If reader
> has already exited n_tty_read, which means that reader still has data to read,
> next time reader will call n_tty_kick_worker inside n_tty_read too.

C-level analysis alone is not going to be very useful here given you're 
dealing with a concurrency challenge here.


-- 
 i.


