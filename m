Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C984C61DA4
	for <linux-serial@archiver.kernel.org>; Thu,  2 Feb 2023 12:09:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231939AbjBBMJp (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 2 Feb 2023 07:09:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231949AbjBBMJo (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 2 Feb 2023 07:09:44 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3750189367
        for <linux-serial@vger.kernel.org>; Thu,  2 Feb 2023 04:09:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675339783; x=1706875783;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=tybr/ioLU2IhberAFsiwRc2T/3mIJ9lOy7g2m9JrZF0=;
  b=ErePRHzDmh26M64RDiccCDg72UNtbCz2WwYibdtTyaf9oTq7Tdds2EU3
   dsPtofMY/GdG2MX8pkJKnWE0MSukXsJM2Kps/9l8GSqn9Rm2KICtvJH5e
   kJed9fmck9sYbdXIKvLRAXoTe9VcPvEmiDabW6o3haTuTuYt8fVIdVjAq
   h/qNGxz8h2AxkCO3tnMYJHzGT7GXWDNlxzDMx6FnkqG8fYSpeiQasTVdD
   OGrD+j+dO4EjkpBpcpTj6yVLwv3wRb63/Rrf07NnDCc4HxzWUgX7m9pGz
   adk/YQlh8cntD2E/413NKeOP4RsrwCoWGwEEOcpxY7tvcvreUu0O3rzTe
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="308768158"
X-IronPort-AV: E=Sophos;i="5.97,267,1669104000"; 
   d="scan'208";a="308768158"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2023 04:09:42 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="658699049"
X-IronPort-AV: E=Sophos;i="5.97,267,1669104000"; 
   d="scan'208";a="658699049"
Received: from apaczko-mobl3.ger.corp.intel.com ([10.252.36.45])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2023 04:09:40 -0800
Date:   Thu, 2 Feb 2023 14:09:38 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     =?ISO-8859-15?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        kernel@pengutronix.de, linux-serial <linux-serial@vger.kernel.org>
Subject: Re: [PATCH] serial: 8250: Fix mismerge regarding serial_lsr_in()
In-Reply-To: <20230202120428.fo5fswdwki46vnjz@pengutronix.de>
Message-ID: <af49e8f-6c1b-39fa-923e-f0a99edab17c@linux.intel.com>
References: <20230202104501.264686-1-u.kleine-koenig@pengutronix.de> <f157ed1b-3856-7ac9-f054-265536ba3b3@linux.intel.com> <20230202120428.fo5fswdwki46vnjz@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1588438286-1675339782=:2215"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1588438286-1675339782=:2215
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

On Thu, 2 Feb 2023, Uwe Kleine-König wrote:

> On Thu, Feb 02, 2023 at 01:26:08PM +0200, Ilpo Järvinen wrote:
> > On Thu, 2 Feb 2023, Uwe Kleine-König wrote:
> > 
> > > The relevant history introducing serial_lsr_in() looks as follows:
> > > 
> > > 	$ git log --graph --oneline --boundary 9fafe733514b..df36f3e3fbb7 -- drivers/tty/serial/8250/8250_port.c
> > > 	*   df36f3e3fbb7 Merge tag 'v5.19-rc3' into tty-next
> > > 	|\
> > > 	| * be03b0651ffd serial: 8250: Store to lsr_save_flags after lsr read
> > > 	* | ...
> > > 	* | bdb70c424df1 serial: 8250: Create serial_lsr_in()
> > > 	* | ce338e4477cf serial: 8250: Store to lsr_save_flags after lsr read
> > > 	* | ...
> > > 	|/
> > > 	o 9fafe733514b tty: remove CMSPAR ifdefs
> > > 
> > > So the patch "serial: 8250: Store to lsr_save_flags after lsr read" was
> > > introduced twice and in one branch it was followed up by commit
> > > bdb70c424df1 ("serial: 8250: Create serial_lsr_in()") which moved
> > > explicit lsr_saved_flags handling into a new function serial_lsr_in().
> > > When the two branches were merged in commit df36f3e3fbb7, we got both,
> > > serial_lsr_in() and the explicit lsr_saved_flags handling.
> > > 
> > > So drop the explicit lsr_saved_flags handling.
> > > 
> > > Fixes: df36f3e3fbb7 ("Merge tag 'v5.19-rc3' into tty-next")
> > > Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> > > ---
> > >  drivers/tty/serial/8250/8250_port.c | 2 --
> > >  1 file changed, 2 deletions(-)
> > > 
> > > diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> > > index 33be7aad11ef..e61753c295d5 100644
> > > --- a/drivers/tty/serial/8250/8250_port.c
> > > +++ b/drivers/tty/serial/8250/8250_port.c
> > > @@ -1512,8 +1512,6 @@ static inline void __stop_tx(struct uart_8250_port *p)
> > >  		u16 lsr = serial_lsr_in(p);
> > >  		u64 stop_delay = 0;
> > >  
> > > -		p->lsr_saved_flags |= lsr & LSR_SAVE_FLAGS;
> > > -
> > >  		if (!(lsr & UART_LSR_THRE))
> > >  			return;
> > >  		/*
> > 
> > I don't know if Fixes tag is appropriate here. This fixes the mismerge 
> > yes, however, the removed line itself seems harmless so there's no real 
> > problem to fix.
> 
> It might make a difference if LSR_SAVE_FLAGS != p->lsr_save_mask.

But currently lsr_save_mask always has at least LSR_SAVE_FLAGS bits so 
that OR is no-op.

-- 
 i.

--8323329-1588438286-1675339782=:2215--
