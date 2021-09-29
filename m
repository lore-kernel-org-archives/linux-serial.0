Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14354C433EF
	for <linux-serial@archiver.kernel.org>; Wed, 29 Sep 2021 16:48:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1A9E6142A
	for <linux-serial@archiver.kernel.org>; Wed, 29 Sep 2021 16:48:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244727AbhI2Qug (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 29 Sep 2021 12:50:36 -0400
Received: from mga18.intel.com ([134.134.136.126]:13625 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229561AbhI2Quf (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 29 Sep 2021 12:50:35 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10122"; a="212071027"
X-IronPort-AV: E=Sophos;i="5.85,332,1624345200"; 
   d="scan'208";a="212071027"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2021 09:48:54 -0700
X-IronPort-AV: E=Sophos;i="5.85,332,1624345200"; 
   d="scan'208";a="479333203"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2021 09:48:51 -0700
Received: from andy by smile with local (Exim 4.95-RC2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mVclE-006sM6-Fc;
        Wed, 29 Sep 2021 19:48:48 +0300
Date:   Wed, 29 Sep 2021 19:48:48 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     LakshmiPraveen Kopparthi <LakshmiPraveen.Kopparthi@microchip.com>
Cc:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        macro@orcam.me.uk, zev@bewilderbeest.net, vigneshr@ti.com,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        UNGLinuxDriver@microchip.com
Subject: Re: [PATCH v1 0/3] serial:8250:Add driver support for MCHP PCI1XXXX
 UART module
Message-ID: <YVSY8L6A6H71DvM5@smile.fi.intel.com>
References: <20210929113049.64557-1-LakshmiPraveen.Kopparthi@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210929113049.64557-1-LakshmiPraveen.Kopparthi@microchip.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Sep 29, 2021 at 05:00:46PM +0530, LakshmiPraveen Kopparthi wrote:
> PCI1XXXX UART is a PCIe to UART module. It has 5 SKUs, each is
> differentiated by the device IDs in the PCIe config space. Each
> SKU supports a maximum of 4 UART ports(UART0,1,2,3) with fixed 
> offests.Based on the sub device ID, the combinations of UART 
> ports shall be enumerated.
> 
> The UART port is compatible with the standard 16550A, but has some 
> modifications.The modifications includes a change in the baud rate
> settings,auto control of RTS signal for RS485 feature and an
> increase of TX & RX FIFO size to 256 Bytes.Also, it has a capability
> to wake up the CPU. 
> 
> These patches adds the support to enumerate and exercise all the
> combinations of UART ports in all the SKUs.

>  drivers/tty/serial/8250/8250_pci.c  | 384 ++++++++++++++++++++++++++++

Please, do not add this to 8250_pci.c. Use separate quirk driver as it's done
in plenty of examples:

	8250_lpss.c, 8250_mid.c, 8250_exar.c, ...

-- 
With Best Regards,
Andy Shevchenko


