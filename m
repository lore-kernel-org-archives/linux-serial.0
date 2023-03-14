Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF84EC6FD1D
	for <linux-serial@archiver.kernel.org>; Tue, 14 Mar 2023 10:55:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbjCNKzq (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 14 Mar 2023 06:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbjCNKzp (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 14 Mar 2023 06:55:45 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CFFA65C4E
        for <linux-serial@vger.kernel.org>; Tue, 14 Mar 2023 03:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678791328; x=1710327328;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=YUEVg8h8pPL4GCcT6a13zB6bRDoBci2PCRWOD3X1ZFI=;
  b=lrbHhmLYHeQgvkBO3jwode316IE3RdbLQ7m5ko3e8XHy2Ziul+/lSO4h
   HuV1VHCtpsFTuit3z4Y0amrufzGzJH5dU9cbdbzxd8zpbvSh8B344k8//
   k+uU1PkSEnDtk+LdxUbgIUuYFoGi88TaEaWIv/lqb7OmQyFQ6rZobmrAZ
   xivuWOxvpHfpPjyNJXWWeDgvzbn4p91A7w4Vj4aFVOMF8AquikWRaeDl1
   7jLss2YhlH396F7+CYG9t7/+isXQbWs2soxazGphaOF0hdTV/vM/LYqFk
   bxR63UeInRgsufNRbkdPQ04mX39i/i4oGhQjBrN6JW+QF/8TBNZ+FH0BU
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="338934362"
X-IronPort-AV: E=Sophos;i="5.98,259,1673942400"; 
   d="scan'208";a="338934362"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2023 03:55:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="672290879"
X-IronPort-AV: E=Sophos;i="5.98,259,1673942400"; 
   d="scan'208";a="672290879"
Received: from npeltier-mobl1.ger.corp.intel.com ([10.252.33.129])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2023 03:55:26 -0700
Date:   Tue, 14 Mar 2023 12:55:22 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Subject: Re: [Regression] "serial: 8250: use THRE & __stop_tx also with DMA"
 breaks DMA rx
In-Reply-To: <7f18e19d-4072-0609-afd0-244b06103b9c@redhat.com>
Message-ID: <dd9ebf9-e2e9-2b6-eec5-6ab152f92032@linux.intel.com>
References: <7f18e19d-4072-0609-afd0-244b06103b9c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, 14 Mar 2023, Hans de Goede wrote:

> Hi Ilpo,

Hi,

Thanks for the report.

> I have spend the last couple of days debugging a problem with Bluetooth
> adapters (HCIs) connected over an UART connection on Intel Bay Trail
> and Cherry Trail devices.
> 
> After much debugging I found out that sometimes the first byte of
> a received packet (data[0]) would be overwritten with a 0 byte.
> 
> E.g. this packet received during init of a BCM4324B3 (1) Bluetooth HCI:
> 
> 04 0e 0a 01 79 fc 00 54 fe ff ff 00 00
> 
> would sometimes turn into:
> 
> 00 0e 0a 01 79 fc 00 54 fe ff ff 00 00
>
> Further investigation revealed that this goes away if I stop
> the dw_dmac module from loading, leading to:
> "dw-apb-uart 80860F0A:00: failed to request DMA"
> and the UART working without DMA support.
> 
> Testing various kernels showed that this problem was introduced
> in v5.19, v5.18 - v5.18.19 are fine. An a git bisect points to:
> 
> e8ffbb71f783 ("serial: 8250: use THRE & __stop_tx also with DMA")
> 
> And reverting that on top of v6.3-rc2 indeed solves the problem.

You did something else too than just that because you cannot cleanly 
revert just e8ffbb71f783. Please indicate what happened to:
  f8d6e9d3ca5c ("serial: 8250: Fix __stop_tx() & DMA Tx restart races")

I guess you reverted that too and forgot to mention about it but I just 
want to be sure we're on the same page?

> So it seems that that commit somehow interferes with DMA based
> data receiving, causing the first byte of a received data transfer
> to get replaced by 0.

Okay, and you're sure the problem/corruption occurs on the receiving side? 

Maybe the the extra interrupt that the tx side change will trigger somehow 
causes the confusion on the rx side. So that would be an extra call into 
handle_rx_dma() that could either do an extra flush or start DMA Rx that 
would not occur w/o that tx side change.

> The issue has been seen on and the revert has been tested on
> the following HW:
> 
> Asus T100TA
> SoC: Bay Trail UART: 80860F0A WIFI: brcmfmac43241b4-sdio BT: BCM4324B3
> 
> Lenovo Yoga Tablet 2 1051L
> SoC: Bay Trail UART: 80860F0A WIFI: brcmfmac43241b4-sdio BT: BCM4324B3
> 
> Lenovo Yoga Book X91F
> Soc: Cherry Trail UART: 8086228A WIFI: brcmfmac4356-pcie BT: BCM4356A2
> 
> I have more hw which I believe is affected but these are the models
> where I have done detailed testing.
> 
> I would be happy to test any patches, or run a kernel with some extra
> debugging added, just let me know what you need to help fixing this.

How easy this is to trigger in general? (Mainly trying to gauge how 
easy it will be to find the read and/or the irq that related to the 
corrupted payload).

> Regards,
> 
> Hans
> 
> 
> p.s.
> 
> I believe that these changes were made to improve the timing of
> disabling the transmitter on tx completion when the UART is used
> for a RS485 bus. So one option to workaround this might be to only
> enable the new behavior when RS485 mode is used ?

That change also removed what IMO was a too early serial8250_rpm_put_tx()
which is not just RS485 related but yes, the main reason was to have the
half-duplex RS485 behave correctly.


-- 
 i.

