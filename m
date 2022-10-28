Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9554ECAAA1
	for <linux-serial@archiver.kernel.org>; Fri, 28 Oct 2022 09:40:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbiJ1Jkc (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 28 Oct 2022 05:40:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbiJ1Jka (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 28 Oct 2022 05:40:30 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44E1D6583D
        for <linux-serial@vger.kernel.org>; Fri, 28 Oct 2022 02:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666950026; x=1698486026;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=8I4+d0CaIZqW1wa1yWm6NW6INdchDftrAiVCea2IjcA=;
  b=cNEvUlsJ0SXqxBp5scqd9MfviO+mcPXzBl/GnVY7k+5J1bYVvZOoPfmo
   30j7/p6CWjGTZ+ItejOSVOiTE2VCxnMwL6ZjByR+6sLRw3aq+9Vh6JLyW
   Xyre+zBrredOD/LsbLElAKWec2ZKHge7gmtlRY9VwF8ICZrEVo5CF9bC9
   sb3Yyr6DWE3DKJA2xz2vpuA+nDxhjd4pQhCv9/S0EYYw0zrjVzqmuXG3l
   Itg0y0sH8fg2PeD5XPejaPf1tXpqtWO6uoJRxx88jRV6JabkIzi4Ine01
   HAdwGe4uSfMb1vHxBAFdvz7PI/Wm9tKpgFo/BQ2jYaQYyZjr08nB3VzO7
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10513"; a="310152093"
X-IronPort-AV: E=Sophos;i="5.95,220,1661842800"; 
   d="scan'208";a="310152093"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2022 02:40:25 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10513"; a="721996084"
X-IronPort-AV: E=Sophos;i="5.95,220,1661842800"; 
   d="scan'208";a="721996084"
Received: from amilburn-mobl.ger.corp.intel.com ([10.252.47.223])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2022 02:40:23 -0700
Date:   Fri, 28 Oct 2022 12:40:17 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     =?ISO-8859-15?Q?Martin_Hundeb=F8ll?= <martin@geanix.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc:     linux-serial <linux-serial@vger.kernel.org>
Subject: Re: [PATCH v3 3/4] serial: 8250: skip platform device registration
 with no runtime ports
In-Reply-To: <b6619d9-5b91-e06c-f2a0-af92128937d2@linux.intel.com>
Message-ID: <d27b3f5d-8766-fa1c-c369-31ebe344f87@linux.intel.com>
References: <20221025073944.102437-1-martin@geanix.com> <20221025073944.102437-3-martin@geanix.com> <c1642f35-6270-7155-795d-a3f7324f799c@linux.intel.com> <b6619d9-5b91-e06c-f2a0-af92128937d2@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-497462886-1666949935=:1762"
Content-ID: <2fd5d5da-a750-1a4-d880-fef44367252f@linux.intel.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-497462886-1666949935=:1762
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <75597efc-8fb-37f5-fc64-68589f43cb8@linux.intel.com>

On Fri, 28 Oct 2022, Ilpo Järvinen wrote:

> On Wed, 26 Oct 2022, Ilpo Järvinen wrote:
> 
> > On Tue, 25 Oct 2022, Martin Hundebøll wrote:
> > 
> > > Skip registration of the platform device used for built-in ports, if no
> > > such ports are configured/created.
> > > 
> > > Signed-off-by: Martin Hundebøll <martin@geanix.com>
> > 
> > For patches 1-3:
> > 
> > Tested-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > 
> > Please include these tags into the next version of your submission.
> > Thank you.
> 
> Actually, I just found out that some set of cmdline parameters do no 
> longer work the same. So I'm retracting both of my tags for now.
> 
> =0 did work as expected due to this change which I tested and some other 
> values >4 but there now seems to be problem of the console not showing up 
> like previously when I don't give nr_uarts at all.

NAK from me until the problem is resolved adequately.

Already the patch 1/4 causes an unacceptable reassignment of ttySx 
targets. This is going to break people's cmdline console setups so you 
need to find a better way.

Before any of these patches:

[    0.000000] Command line: console=ttyS0,115200n8 8250.nr_uarts=4
[    0.021031] Kernel command line: console=ttyS0,115200n8 8250.nr_uarts=4
[    0.441924] printk: console [ttyS0] enabled
[    2.243165] printk: console [ttyS0] disabled
[    2.245682] dw-apb-uart.6: ttyS0 at MMIO 0x4010006000 (irq = 33, base_baud = 115200) is a 16550A
[    4.010237] printk: console [ttyS0] enabled
[    5.933887] dw-apb-uart.7: ttyS1 at MMIO 0x4010007000 (irq = 16, base_baud = 6250000) is a 16550A
[    5.952829] dw-apb-uart.8: ttyS2 at MMIO 0x4010008000 (irq = 17, base_baud = 6250000) is a 16550A

After 1/4 ttyS0 is no longer the same:

[    0.000000] Command line: console=ttyS0,115200n8 8250.nr_uarts=4
[    0.021023] Kernel command line: console=ttyS0,115200n8 8250.nr_uarts=4
[    0.441872] printk: console [ttyS0] enabled
[    2.233584] dw-apb-uart.6: ttyS4 at MMIO 0x4010006000 (irq = 33, base_baud = 115200) is a 16550A
[    2.241955] dw-apb-uart.7: ttyS5 at MMIO 0x4010007000 (irq = 16, base_baud = 6250000) is a 16550A
[    2.249804] dw-apb-uart.8: ttyS6 at MMIO 0x4010008000 (irq = 17, base_baud = 6250000) is a 16550A


-- 
 i.
--8323329-497462886-1666949935=:1762--
