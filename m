Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A508C433F5
	for <linux-serial@archiver.kernel.org>; Fri, 20 May 2022 15:07:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345536AbiETPHK (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 20 May 2022 11:07:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350586AbiETPHI (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 20 May 2022 11:07:08 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDC3F7CB3E
        for <linux-serial@vger.kernel.org>; Fri, 20 May 2022 08:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653059227; x=1684595227;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=YoA/8EF7WJlK4bb8MjVyzlw4NV8zUKsO6H16v61MCCA=;
  b=Ic44JamB2/b2F4XmvXtPLDKVhq3CLZ4UP6t2frATdLz3FVolLjxVpKnl
   UH25xKVDdgH+5azl6JZORExKNm3DZkT3YpQloQD9yw5fZFg1Zii7V/GVM
   1Sseh9wHUzy1A9pPjSDzH6tdaINwAblbiJgSbvHDpe8hhPVCPkjmz4TVQ
   SwLCMyACQcQIu3G+sDYQ+mZMsONutDP2r6dikMKowz9DyykGtUFjJLSoT
   /dWo3t2ZPBhHCiw8ym/JsM4BMb/6NlrwRAdEs7jE6rIrEZ3nBLWD6ArP6
   hJz4r5ExuFQ9H/Sv5xEzKHIytRy0lpoGMwjOKD4zS7ETlgEYKcyPmu4R9
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10353"; a="260215763"
X-IronPort-AV: E=Sophos;i="5.91,239,1647327600"; 
   d="scan'208";a="260215763"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2022 08:07:07 -0700
X-IronPort-AV: E=Sophos;i="5.91,239,1647327600"; 
   d="scan'208";a="599261329"
Received: from ahuge-mobl.ger.corp.intel.com ([10.252.56.20])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2022 08:07:05 -0700
Date:   Fri, 20 May 2022 18:06:58 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     =?ISO-8859-15?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
cc:     linux-serial <linux-serial@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH] serial: 8250: Store to lsr_save_flags after lsr read
In-Reply-To: <20220520130259.svpf3rei7jx6bsji@pengutronix.de>
Message-ID: <47a2b194-2fc1-3fab-b220-a261cd1f8f29@linux.intel.com>
References: <f4d774be-1437-a550-8334-19d8722ab98c@linux.intel.com> <20220520130259.svpf3rei7jx6bsji@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1087068950-1653059227=:1654"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1087068950-1653059227=:1654
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

On Fri, 20 May 2022, Uwe Kleine-König wrote:

> On Fri, May 20, 2022 at 01:35:41PM +0300, Ilpo Järvinen wrote:
> > Not all LSR register flags are preserved across reads. Therefore, LSR
> > readers must store the non-preserved bits into lsr_save_flags.
> > 
> > This fix was initially mixed into feature commit f6f586102add ("serial:
> > 8250: Handle UART without interrupt on TEMT using em485"). However,
> > that feature change had a flaw and it was reverted to make room for
> > simpler approach providing the same feature. The embedded fix got
> > reverted with the feature change.
> > 
> > Re-add the lsr_save_flags fix and properly mark it's a fix.
> > 
> > Fixes: e490c9144cfa ("tty: Add software emulated RS485 support for 8250")
> > Link: https://lore.kernel.org/all/1d6c31d-d194-9e6a-ddf9-5f29af829f3@linux.intel.com/T/#m1737eef986bd20cf19593e344cebd7b0244945fc
> > Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> > Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > 
> > ---
> > Since Uwe didn't follow up with this fix in an isolated patch, I'm sending 
> > it now so that it doesn't end up falling through cracks.
> 
> Great, thanks. I completely obliterate that one.
> 
> Maybe it would be sensible to wrap reading + updating saved_flags in an
> inline helper?

It's my plan. I just wanted to get the obvious fix out of the way first.

> Other than that:
> 
> Acked-by: Uwe Kleine-König <u.kleine-koenig@penugtronix.de>
>
> > tg: (4419da5d5d4b..) fix/lsr-save-flags (depends on: tty-next)
> 
> Oh wow, you're using topgit? I would be interested in your pain points
> and what made you choose topgit anyhow. Since a longer time I have a few
> ideas for a git helper that uses the good ideas in topgit, but never
> came around to implement it.

Yes, I am. The most problematic case is when I'd want to reorder/relocate 
a patch towards root. I usually end up just creating another one with a 
different name. I've learned to cope most of what I'd assume many people 
would find pain points with manual tg patch | patch -p1 -R trickery 
(possibly combined with git add -i) and reapplying afterwards, it gets me 
quite far already.


-- 
 i.

--8323329-1087068950-1653059227=:1654--
