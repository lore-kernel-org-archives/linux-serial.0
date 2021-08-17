Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69AA5C4320A
	for <linux-serial@archiver.kernel.org>; Tue, 17 Aug 2021 17:39:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CD1560EE5
	for <linux-serial@archiver.kernel.org>; Tue, 17 Aug 2021 17:39:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232230AbhHQRjc (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 17 Aug 2021 13:39:32 -0400
Received: from mga04.intel.com ([192.55.52.120]:2277 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232256AbhHQRj1 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 17 Aug 2021 13:39:27 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10079"; a="214307359"
X-IronPort-AV: E=Sophos;i="5.84,329,1620716400"; 
   d="scan'208";a="214307359"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2021 10:38:53 -0700
X-IronPort-AV: E=Sophos;i="5.84,329,1620716400"; 
   d="scan'208";a="676598040"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2021 10:38:51 -0700
Received: from andy by smile with local (Exim 4.94.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mG32y-00ApCu-WF; Tue, 17 Aug 2021 20:38:45 +0300
Date:   Tue, 17 Aug 2021 20:38:44 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Utkarsh Verma <utkarshverma294@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Valmer Huhn <valmer.huhn@concurrent-rt.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH] serial: 8250_exar: Add missing call to
 pci_free_irq_vectors()
Message-ID: <YRv0JO64HRHrl7Gb@smile.fi.intel.com>
References: <20210817170057.16783-1-utkarshverma294@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210817170057.16783-1-utkarshverma294@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Aug 17, 2021 at 10:30:57PM +0530, Utkarsh Verma wrote:
> Free the pci irq vectors if the call to pci_alloc_irq_vectors() fails
> or if the device is removed.

...

>  	rc = pci_alloc_irq_vectors(pcidev, 1, 1, PCI_IRQ_ALL_TYPES);
> -	if (rc < 0)
> +	if (rc < 0) {

> +		pci_free_irq_vectors(pcidev);

Why?

-- 
With Best Regards,
Andy Shevchenko


