Return-Path: <SRS0=YMt1=X2=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4703C352AA
	for <linux-serial@archiver.kernel.org>; Tue,  1 Oct 2019 11:09:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B051E21924
	for <linux-serial@archiver.kernel.org>; Tue,  1 Oct 2019 11:09:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726000AbfJALJ6 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 1 Oct 2019 07:09:58 -0400
Received: from mga09.intel.com ([134.134.136.24]:32551 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725900AbfJALJ6 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 1 Oct 2019 07:09:58 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Oct 2019 04:09:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,571,1559545200"; 
   d="scan'208";a="274962720"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga001.jf.intel.com with ESMTP; 01 Oct 2019 04:09:56 -0700
Received: from andy by smile with local (Exim 4.92.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1iFG2V-0007tK-09; Tue, 01 Oct 2019 14:09:55 +0300
Date:   Tue, 1 Oct 2019 14:09:54 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Felipe Balbi <felipe.balbi@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org
Subject: Re: [PATCH] serial: 8250_lpss: Switch over to MSI interrupts
Message-ID: <20191001110954.GH32742@smile.fi.intel.com>
References: <20191001081617.766084-1-felipe.balbi@linux.intel.com>
 <20191001085940.GE32742@smile.fi.intel.com>
 <877e5ox0yf.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877e5ox0yf.fsf@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Oct 01, 2019 at 12:35:36PM +0300, Felipe Balbi wrote:
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:
> > On Tue, Oct 01, 2019 at 11:16:17AM +0300, Felipe Balbi wrote:
> >> Some devices support MSI interrupts. Let's at least try to use them in
> >> platforms that provide MSI capability.
> >
> > Thanks for the patch!
> >
> > I think you may clean up qrk_serial_setup() as well.
> 
> That would break qrk_serial_setup_dma(), though.

Hmm... I don't see how.

The DMA setup is called after allocation of IRQ vector and the device in use is
the same, i.e. PCI device.

-- 
With Best Regards,
Andy Shevchenko


