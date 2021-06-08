Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DCC9C47082
	for <linux-serial@archiver.kernel.org>; Tue,  8 Jun 2021 13:47:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 771C06128E
	for <linux-serial@archiver.kernel.org>; Tue,  8 Jun 2021 13:47:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232917AbhFHNtn (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 8 Jun 2021 09:49:43 -0400
Received: from mga12.intel.com ([192.55.52.136]:44499 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232895AbhFHNtn (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 8 Jun 2021 09:49:43 -0400
IronPort-SDR: EXp7tLtzZOGSv6cADVTANobz2KizRvQKg4EENnuDBpIpAgY80bwCWWpHE4wUkwbdnbmLV/+jSJ
 bPMAt9Pm2NIQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10008"; a="184531871"
X-IronPort-AV: E=Sophos;i="5.83,258,1616482800"; 
   d="scan'208";a="184531871"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2021 06:47:50 -0700
IronPort-SDR: 2ieOlv0/z/4Oxi0MD6Nuh6kz6tOgxHtXUOoPbgcnNhfvolWegqOdPmfifLeeCAlexFaTGoGbZ/
 6UozJD3y390w==
X-IronPort-AV: E=Sophos;i="5.83,258,1616482800"; 
   d="scan'208";a="619306947"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2021 06:47:48 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lqc54-000YnF-8p; Tue, 08 Jun 2021 16:47:46 +0300
Date:   Tue, 8 Jun 2021 16:47:46 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Maxim Levitsky <mlevitsk@redhat.com>,
        Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>,
        linux-serial@vger.kernel.org
Subject: Re: Commit "serial: 8250_exar: Constify the software nodes' breaks
 suspend/resume
Message-ID: <YL91AvvSMdYglcgl@smile.fi.intel.com>
References: <7bb02598035ce2fb2372f97ff531c11357818d1f.camel@redhat.com>
 <YL9xY7jT13ZVRxMW@kuha.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YL9xY7jT13ZVRxMW@kuha.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Jun 08, 2021 at 04:32:19PM +0300, Heikki Krogerus wrote:
> On Tue, Jun 08, 2021 at 04:17:58PM +0300, Maxim Levitsky wrote:
> > Hi!
> > 
> > I happened to own one of Exar's PCI serial adapters, and this commit that I bisected
> > breaks suspend/resume of the host.
> > 
> > The adapter that I have:
> > 
> > 02:00.0 Serial controller [0700]: Exar Corp. XR17V3521 Dual PCIe UART [13a8:0352] (rev 03) (prog-if 02 [16550])
> > 
> > 
> > First suspend of the system works,but on the second suspend, the system hangs until it reboots.
> > Reverting the commit helps.
> > 
> > I attached a backtrace captured with ramoops 
> > (since I ironically use this serial port to capture the oops backtraces otherwise...)
> > 
> > Best regards,
> > 	Maxim Levitsky
> > 
> 
> Maybe we should fix this by making dev_fwnode() NULL safe?
> 
> diff --git a/drivers/base/property.c b/drivers/base/property.c
> index c26370aacdc66..65b866f8bfb1b 100644
> --- a/drivers/base/property.c
> +++ b/drivers/base/property.c
> @@ -20,8 +20,8 @@
>  
>  struct fwnode_handle *dev_fwnode(struct device *dev)
>  {
> -       return IS_ENABLED(CONFIG_OF) && dev->of_node ?
> -               of_fwnode_handle(dev->of_node) : dev->fwnode;
> +       return dev ? IS_ENABLED(CONFIG_OF) && dev->of_node ?
> +               of_fwnode_handle(dev->of_node) : dev->fwnode : NULL;
>  }
>  EXPORT_SYMBOL_GPL(dev_fwnode);
> 
> Andy, comments?

We consider dev_fwnode() API to be similar to, let's say, dev_name(). It means
that caller should guarantee that parameter is not NULL.

-- 
With Best Regards,
Andy Shevchenko


