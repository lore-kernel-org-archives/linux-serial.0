Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D501BC47082
	for <linux-serial@archiver.kernel.org>; Tue,  8 Jun 2021 14:20:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B87586135A
	for <linux-serial@archiver.kernel.org>; Tue,  8 Jun 2021 14:20:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233272AbhFHOV6 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 8 Jun 2021 10:21:58 -0400
Received: from mga17.intel.com ([192.55.52.151]:47939 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233258AbhFHOV6 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 8 Jun 2021 10:21:58 -0400
IronPort-SDR: g806uxjs5zbsE1QNBA7BhGEbeayVAy6oG/xJCfadcStyrF7U+Zt+ZM41jOLaW/ahYXPGS0UJgz
 dYWkG3jPbpHg==
X-IronPort-AV: E=McAfee;i="6200,9189,10008"; a="185226155"
X-IronPort-AV: E=Sophos;i="5.83,258,1616482800"; 
   d="scan'208";a="185226155"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2021 07:20:05 -0700
IronPort-SDR: uCgwzyqPJ4XRQmpIb2ieE0efazxoDVGKgH9TmRlB9b4uPyrlOplH78KTC+kw+TA0A06Xi8ZhJa
 4Wz56SpmemRg==
X-IronPort-AV: E=Sophos;i="5.83,258,1616482800"; 
   d="scan'208";a="418919601"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2021 07:20:03 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lqcaH-000Z5s-CQ; Tue, 08 Jun 2021 17:20:01 +0300
Date:   Tue, 8 Jun 2021 17:20:01 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Maxim Levitsky <mlevitsk@redhat.com>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>,
        linux-serial@vger.kernel.org
Subject: Re: Commit "serial: 8250_exar: Constify the software nodes' breaks
 suspend/resume
Message-ID: <YL98kaHoDghTRT1K@smile.fi.intel.com>
References: <7bb02598035ce2fb2372f97ff531c11357818d1f.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7bb02598035ce2fb2372f97ff531c11357818d1f.camel@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Jun 08, 2021 at 04:17:58PM +0300, Maxim Levitsky wrote:
> Hi!
> 
> I happened to own one of Exar's PCI serial adapters, and this commit that I bisected
> breaks suspend/resume of the host.
> 
> The adapter that I have:
> 
> 02:00.0 Serial controller [0700]: Exar Corp. XR17V3521 Dual PCIe UART [13a8:0352] (rev 03) (prog-if 02 [16550])
> 
> 
> First suspend of the system works,but on the second suspend, the system hangs until it reboots.
> Reverting the commit helps.
> 
> I attached a backtrace captured with ramoops 
> (since I ironically use this serial port to capture the oops backtraces otherwise...)

Thanks for the report, can you check if adding

	if (pdev)

before

	device_remove_software_node(&pdev->dev);

helps?

-- 
With Best Regards,
Andy Shevchenko


