Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E26DFA373D
	for <linux-serial@archiver.kernel.org>; Tue,  1 Nov 2022 11:49:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231396AbiKALtt (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 1 Nov 2022 07:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231365AbiKALtc (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 1 Nov 2022 07:49:32 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 262791C904
        for <linux-serial@vger.kernel.org>; Tue,  1 Nov 2022 04:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667303071; x=1698839071;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=5PWmVZZRWPmrYaN5LF35mHfXIHpuH+toMhVTrlQpUXU=;
  b=dJuHQJJvNuvQJ4q1YN3rJS7+VfZFIY2VMzKyS6GfUHkOgSuOMLTmnSCO
   SMm1txHzNpnVS+aTAxG1JCvdhCGhXOK4wjF0jGUN8RvA8xGlFCqHyjmXL
   LHEQyoxlug/XxUWl7tXpOusLv67sbg7PzQj/Y/yS1266ZT0ijx4GbH8aE
   cKOsJB/3RbJ0LQcdwVpSHEJDw13BJgPR6UiZcl4TUiQEHb4ltIifbY1lw
   ESjRFOqULLa4lqaKrq+DCNXnsi/VPjUApBtVnBFhhrq7ixLq3IAm97FdI
   kgYdZBsFencArN4/UVGy2RXgaacL/5ttH+w15c6qhLYBkDORAk8rYI3Ow
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10517"; a="310213569"
X-IronPort-AV: E=Sophos;i="5.95,230,1661842800"; 
   d="scan'208";a="310213569"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2022 04:44:30 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10517"; a="759156085"
X-IronPort-AV: E=Sophos;i="5.95,230,1661842800"; 
   d="scan'208";a="759156085"
Received: from mweigler-mobl.ger.corp.intel.com ([10.249.40.213])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2022 04:44:29 -0700
Date:   Tue, 1 Nov 2022 13:44:22 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     =?ISO-8859-15?Q?Martin_Hundeb=F8ll?= <martin@geanix.com>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>
Subject: Re: [PATCH v3 3/4] serial: 8250: skip platform device registration
 with no runtime ports
In-Reply-To: <9320837b-1b8a-9ddf-7de8-d75816fb209b@geanix.com>
Message-ID: <7ba1dd5b-7b9e-50a1-7539-41533c8d4c94@linux.intel.com>
References: <20221025073944.102437-1-martin@geanix.com> <20221025073944.102437-3-martin@geanix.com> <c1642f35-6270-7155-795d-a3f7324f799c@linux.intel.com> <b6619d9-5b91-e06c-f2a0-af92128937d2@linux.intel.com> <d27b3f5d-8766-fa1c-c369-31ebe344f87@linux.intel.com>
 <9320837b-1b8a-9ddf-7de8-d75816fb209b@geanix.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1231565451-1667300374=:1608"
Content-ID: <3c9a9628-d229-a373-6fe-efa44e901988@linux.intel.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1231565451-1667300374=:1608
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <d26dc45f-b958-92c-6494-227efec5d53a@linux.intel.com>

On Tue, 1 Nov 2022, Martin Hundebøll wrote:

> On 28/10/2022 11.40, Ilpo Järvinen wrote:
> > On Fri, 28 Oct 2022, Ilpo Järvinen wrote:
> > 
> > > On Wed, 26 Oct 2022, Ilpo Järvinen wrote:
> > > 
> > > > On Tue, 25 Oct 2022, Martin Hundebøll wrote:
> > > > 
> > > > > Skip registration of the platform device used for built-in ports, if
> > > > > no
> > > > > such ports are configured/created.
> > > > > 
> > > > > Signed-off-by: Martin Hundebøll <martin@geanix.com>
> > > > 
> > > > For patches 1-3:
> > > > 
> > > > Tested-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > > > Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > > > 
> > > > Please include these tags into the next version of your submission.
> > > > Thank you.
> > > 
> > > Actually, I just found out that some set of cmdline parameters do no
> > > longer work the same. So I'm retracting both of my tags for now.
> > > 
> > > =0 did work as expected due to this change which I tested and some other
> > > values >4 but there now seems to be problem of the console not showing up
> > > like previously when I don't give nr_uarts at all.
> > 
> > NAK from me until the problem is resolved adequately.
> > 
> > Already the patch 1/4 causes an unacceptable reassignment of ttySx
> > targets. This is going to break people's cmdline console setups so you
> > need to find a better way.
> > 
> > Before any of these patches:
> > 
> > [    0.000000] Command line: console=ttyS0,115200n8 8250.nr_uarts=4
> > [    0.021031] Kernel command line: console=ttyS0,115200n8 8250.nr_uarts=4
> > [    0.441924] printk: console [ttyS0] enabled
> > [    2.243165] printk: console [ttyS0] disabled
> > [    2.245682] dw-apb-uart.6: ttyS0 at MMIO 0x4010006000 (irq = 33,
> > base_baud = 115200) is a 16550A
> > [    4.010237] printk: console [ttyS0] enabled
> > [    5.933887] dw-apb-uart.7: ttyS1 at MMIO 0x4010007000 (irq = 16,
> > base_baud = 6250000) is a 16550A
> > [    5.952829] dw-apb-uart.8: ttyS2 at MMIO 0x4010008000 (irq = 17,
> > base_baud = 6250000) is a 16550A
> > 
> > After 1/4 ttyS0 is no longer the same:
> > 
> > [    0.000000] Command line: console=ttyS0,115200n8 8250.nr_uarts=4
> > [    0.021023] Kernel command line: console=ttyS0,115200n8 8250.nr_uarts=4
> > [    0.441872] printk: console [ttyS0] enabled
> > [    2.233584] dw-apb-uart.6: ttyS4 at MMIO 0x4010006000 (irq = 33,
> > base_baud = 115200) is a 16550A
> > [    2.241955] dw-apb-uart.7: ttyS5 at MMIO 0x4010007000 (irq = 16,
> > base_baud = 6250000) is a 16550A
> > [    2.249804] dw-apb-uart.8: ttyS6 at MMIO 0x4010008000 (irq = 17,
> > base_baud = 6250000) is a 16550A
> 
> Thanks for testing this.
> 
> The old behavior is wrong: your designware ports replace the built-in ones (0
> to 3) instead of using the unused ones (4 to 31). With these patches, it acts
> as I'd expect: the built-in ports are kept, and any later discovered ports
> follow.
> 
> Yes, breaking existing systems in this way is unacceptable. I'm not sure how
> to approach this, but I'm inclined to introduce a new config variable to keep
> the broken behavior?

To me this looks now more an attempt to repurpose the nr_uarts to mean 
something it really hasn't. Clearly it hasn't meant non-discoverable 
ports earlier but something related to the maximum number ports. This also 
explains why we had that misunderstanding about the meaning of nr_uarts 
between us earlier.

The code which makes this "wrong behavior" to happen is the last loop in 
serial8250_find_match_or_unused(). Given its comment, I think it has been 
very much intentional behavior. Pretending that non-discoverable port is 
more real/precious than a port that was later _discovered_ and is very 
much a real one is what brings you to this renumbering issue.

I'm not anymore sure about your goals really. Now it sounds one of the 
goals is preserving the non-discoverable ports, whereas previously it was 
just about allowing 0 of them.

How about you add entirely new CONFIG and/or param for this minimum number 
of non-discoverable ports and make the last resort loop (or perhaps all 
but the first loop) in serial8250_find_match_or_unused() to honor that 
(start looking only from port above that index). If it defaults to 0, I 
think this renumbering issue is avoided. Would it work for all the goals 
you have? 

With that change, I don't know what condition should trigger what you do 
in 3/4 though.


-- 
 i.
--8323329-1231565451-1667300374=:1608--
