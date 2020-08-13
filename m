Return-Path: <SRS0=hLv5=BX=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1397C433DF
	for <linux-serial@archiver.kernel.org>; Thu, 13 Aug 2020 13:51:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4F1B20774
	for <linux-serial@archiver.kernel.org>; Thu, 13 Aug 2020 13:51:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726142AbgHMNvQ (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 13 Aug 2020 09:51:16 -0400
Received: from mga09.intel.com ([134.134.136.24]:54292 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726131AbgHMNvP (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 13 Aug 2020 09:51:15 -0400
IronPort-SDR: qD9sjMBWMgaSO+LXfYbMd+ReuGZtYLDdLgm4OlAUG2nDr/Y9LNcXUWQdZ75ROWIm5lGb8FIzP9
 h9/q5/bz//XQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9711"; a="155341057"
X-IronPort-AV: E=Sophos;i="5.76,308,1592895600"; 
   d="scan'208";a="155341057"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2020 06:51:14 -0700
IronPort-SDR: FR4PNwRGmn8oieSuw46S5w2XlooEvdCKuORVYF+Ozok78st7CYMHWG05PjSx/T6pFtcDFWrqZv
 u/e80o/z5EZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,308,1592895600"; 
   d="scan'208";a="325415495"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008.jf.intel.com with ESMTP; 13 Aug 2020 06:51:12 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1k6DdP-008S57-4o; Thu, 13 Aug 2020 16:51:11 +0300
Date:   Thu, 13 Aug 2020 16:51:11 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Valmer Huhn <valmer.huhn@concurrent-rt.com>
Cc:     gregkh@linuxfoundation.org, sudip.mukherjee@codethink.co.uk,
        jan.kiszka@siemens.com, linux-serial@vger.kernel.org
Subject: Re: [PATCH] serial: 8250_exar: Bug fix for determination of number
 of ports for Commtech PCIe cards
Message-ID: <20200813135111.GW1891694@smile.fi.intel.com>
References: <20200812214937.GA332930@icarus.concurrent-rt.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200812214937.GA332930@icarus.concurrent-rt.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Aug 12, 2020 at 05:49:37PM -0400, Valmer Huhn wrote:

Thanks for the report. It needs a slight corrections I tell about below.

> serial: 8250_exar: Bug fix for determination of number of ports for
> Commtech PCIe cards

This should not be present in the body.
And in the subject it would be better to reduce the text to something like

serial: 8250_exar: Fix number of ports for Commtech PCIe cards

> The following line is used to determine the number of ports for each exar
> board in a/drivers/tty/serial/8250/8250_exar.c:589

There is no a/ folder and we don't need the full path anyway, just something
like '8250_exar.c line 589' is enough.

Also refer to Exar with capitalized name.

> nr_ports = board->num_ports ? board->num_ports : pcidev->device & 0x0f;
> 
> If the number of ports a card has is not explicitly specified, it defaults
> to the rightmost 4 bits of the PCI device ID. This is prone to error since
> not all PCI device IDs contain a number which corresponds to the number of
> ports that card provides.
> 
> This particular case involves COMMTECH_4224PCIE and COMMTECH_4228PCIE
> cards with device ID 0x0020 and 0x0021. Currently the multiport cards

'...with device IDs 0x0020, 0x0021 and 0x0022.'

> receive 0 and 1 port instead of 4 and 8 ports respectively.

and update this accordingly.

> To fix this, each Commtech Fastcom PCIe card is given a struct where the
> number of ports is explicitly specified. This ensures 'board->num_ports'
> is used instead of the default 'pcidev->device & 0x0f'.

Please, add a Fixes tag.

Fixes: d0aeaa83f0b0 ("serial: exar: split out the exar code from 8250_pci")

> Signed-off-by: Valmer Huhn <valmer.huhn@concurrent-rt.com>
> Tested-by: Valmer Huhn <valmer.huhn@concurrent-rt.com>

...

> -	EXAR_DEVICE(COMMTECH, 4222PCIE, pbn_exar_XR17V35x),
> -	EXAR_DEVICE(COMMTECH, 4224PCIE, pbn_exar_XR17V35x),
> -	EXAR_DEVICE(COMMTECH, 4228PCIE, pbn_exar_XR17V35x),
> +	EXAR_DEVICE(COMMTECH, 4222PCIE, pbn_fastcom_XR17V352),
> +	EXAR_DEVICE(COMMTECH, 4224PCIE, pbn_fastcom_XR17V354),
> +	EXAR_DEVICE(COMMTECH, 4228PCIE, pbn_fastcom_XR17V358),

For sake of the consistency I would rather see them as

pbn_fastcom35x_2/4/8.

>  	EXAR_DEVICE(COMMTECH, 4222PCI335, pbn_fastcom335_2),
>  	EXAR_DEVICE(COMMTECH, 4224PCI335, pbn_fastcom335_4),

-- 
With Best Regards,
Andy Shevchenko


