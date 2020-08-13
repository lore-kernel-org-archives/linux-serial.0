Return-Path: <SRS0=hLv5=BX=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71BDAC433DF
	for <linux-serial@archiver.kernel.org>; Thu, 13 Aug 2020 19:28:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50E9620774
	for <linux-serial@archiver.kernel.org>; Thu, 13 Aug 2020 19:28:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbgHMT2s (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 13 Aug 2020 15:28:48 -0400
Received: from mga07.intel.com ([134.134.136.100]:9950 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726305AbgHMT2s (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 13 Aug 2020 15:28:48 -0400
IronPort-SDR: 8w2jiLh4DfVH2x7bvkSj+fZdfwxlccrRHWTC1pmTOXGamcSNZdpaRrL5j2OAz7ISK6tvOTOUlx
 7tcr1ZJLMA+Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9712"; a="218643688"
X-IronPort-AV: E=Sophos;i="5.76,309,1592895600"; 
   d="scan'208";a="218643688"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2020 12:28:48 -0700
IronPort-SDR: VQvO+yA9XjTerJo0UIBz6/8/USCuZfIyqlBcAs9RvIEorU0qHE9kLZMbaAE/bwq58d64uHW1lq
 3MoJk9eBCC7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,309,1592895600"; 
   d="scan'208";a="325515256"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008.jf.intel.com with ESMTP; 13 Aug 2020 12:28:46 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1k6Iu5-008VGP-Eq; Thu, 13 Aug 2020 22:28:45 +0300
Date:   Thu, 13 Aug 2020 22:28:45 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Valmer Huhn <valmer.huhn@concurrent-rt.com>
Cc:     gregkh@linuxfoundation.org, sudip.mukherjee@codethink.co.uk,
        jan.kiszka@siemens.com, linux-serial@vger.kernel.org
Subject: Re: [PATCH] serial: 8250_exar: Fix number of ports for Commtech PCIe
 cards
Message-ID: <20200813192845.GJ1891694@smile.fi.intel.com>
References: <20200813165255.GC345440@icarus.concurrent-rt.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200813165255.GC345440@icarus.concurrent-rt.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Aug 13, 2020 at 12:52:55PM -0400, Valmer Huhn wrote:

Thanks for an update, my comments below.

> The following in 8250_exar.c line 589 is used to determine the number
> of ports for each Exar board:
> 
> nr_ports = board->num_ports ? board->num_ports : pcidev->device & 0x0f;
> 
> If the number of ports a card has is not explicitly specified, it defaults
> to the rightmost 4 bits of the PCI device ID. This is prone to error since
> not all PCI device IDs contain a number which corresponds to the number of
> ports that card provides.
> 
> This particular case involves COMMTECH_4222PCIE, COMMTECH_4224PCIE and
> COMMTECH_4228PCIE cards with device IDs 0x0022, 0x0020 and 0x0021.
> Currently the multiport cards receive 2, 0 and 1 port instead of 2, 4 and
> 8 ports respectively.
> 
> To fix this, each Commtech Fastcom PCIe card is given a struct where the
> number of ports is explicitly specified. This ensures 'board->num_ports'
> is used instead of the default 'pcidev->device & 0x0f'.

...

> Fixes: d0aeaa83f0b0 ("serial: exar: split out the exar code from 8250_pci")

> 

Shouldn't be blank line here.

> Signed-off-by: Valmer Huhn <valmer.huhn@concurrent-rt.com>

...

> Tested-by: Valmer Huhn <valmer.huhn@concurrent-rt.com>

This tag (Tested-by: Author_of_the_patch) is implied. We don't want patches
that weren't tested by authors.

After cutter line '---' you missed to provide a changelog along with bumping
patch version. Hint, use -v<X> when run `git format-patch ...`

P.S. Next should be v3, so `git format-patch -v3 ...`.

-- 
With Best Regards,
Andy Shevchenko


