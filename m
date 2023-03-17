Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 232EFC6FD1D
	for <linux-serial@archiver.kernel.org>; Fri, 17 Mar 2023 10:38:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbjCQKi4 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 17 Mar 2023 06:38:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbjCQKiz (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 17 Mar 2023 06:38:55 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFB0B20D11
        for <linux-serial@vger.kernel.org>; Fri, 17 Mar 2023 03:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679049532; x=1710585532;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=PeGYKs2BnUdUCoyJS9fx+TxJ2xHthgeRJfWx/xQX0BY=;
  b=URYO18gLRgqymoY6zFwKMHGkpyxH6YcUg0BBr7aS4rfpaAGjLplJiDjy
   Pg1s7fuFzUBwhXhBVMBIO6fpIpK9S0PfwG2Oek2oIaTuPEylLcibSId59
   I9BaV1Y3v5DDoc/SxvyWqiKxfySJT9O+GynLIaOUYCklfYC7dtBMw7tGP
   FQJWwOVI+lIvY+n5vfYwSrnhnP1/YwPWu+qRUEgFBFkzkiH5J6f2lEy04
   0FRn0ATTErqTRi3lLPpCOXOWEDgnDBxTEOOdvB/hBWY6Hf75E+SA88LrG
   Y3j53df0wiTG9aVKjhgO2e7bZX9M6MKOke3NBwk48F1tw26Gmw9BXMjU+
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="335728079"
X-IronPort-AV: E=Sophos;i="5.98,268,1673942400"; 
   d="scan'208";a="335728079"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2023 03:38:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="790667510"
X-IronPort-AV: E=Sophos;i="5.98,268,1673942400"; 
   d="scan'208";a="790667510"
Received: from bstach-mobl1.ger.corp.intel.com ([10.251.221.222])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2023 03:38:50 -0700
Date:   Fri, 17 Mar 2023 12:38:43 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Subject: Re: [Regression] "serial: 8250: use THRE & __stop_tx also with DMA"
 breaks DMA rx
In-Reply-To: <7ef0037f-c049-b783-b019-c8453801555e@redhat.com>
Message-ID: <3bed4a8-1b36-40fd-ac72-5061a95c9a38@linux.intel.com>
References: <7f18e19d-4072-0609-afd0-244b06103b9c@redhat.com> <dd9ebf9-e2e9-2b6-eec5-6ab152f92032@linux.intel.com> <316ab583-d217-a332-d161-8225b0cee227@redhat.com> <1d7c80cf-cf79-ef1-58ba-e3b99294bb6@linux.intel.com> <9e1e207f-a74f-cedb-6811-993d6b0a26cf@redhat.com>
 <f729bfb4-cde1-9859-f1ff-58716772dfc4@linux.intel.com> <00de13b2-0ed9-efe2-e8d8-c9370c04e80b@redhat.com> <322489-e120-dcbf-fffc-d9df31d8c499@linux.intel.com> <7ef0037f-c049-b783-b019-c8453801555e@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1521408932-1679044248=:2227"
Content-ID: <167b15ea-2330-2163-2dcd-d67d2e7fdac8@linux.intel.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1521408932-1679044248=:2227
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <b8d64882-7a8f-91a-23fe-2a3ef7afa5@linux.intel.com>

On Thu, 16 Mar 2023, Hans de Goede wrote:
> On 3/15/23 15:47, Ilpo Järvinen wrote:
> > On Tue, 14 Mar 2023, Hans de Goede wrote:
> >> On 3/14/23 17:55, Ilpo Järvinen wrote:
> >>> On Tue, 14 Mar 2023, Hans de Goede wrote:
> >>>> On 3/14/23 12:48, Ilpo Järvinen wrote:
> >>>>> On Tue, 14 Mar 2023, Hans de Goede wrote:
> >>>>>> On 3/14/23 11:55, Ilpo Järvinen wrote:
> >>>>>>> On Tue, 14 Mar 2023, Hans de Goede wrote:
> >>>>>>>
> >>>>>>>> I have spend the last couple of days debugging a problem with Bluetooth
> >>>>>>>> adapters (HCIs) connected over an UART connection on Intel Bay Trail
> >>>>>>>> and Cherry Trail devices.
> >>>>>>>>
> >>>>>>>> After much debugging I found out that sometimes the first byte of
> >>>>>>>> a received packet (data[0]) would be overwritten with a 0 byte.
> >>>>>>>>
> >>>>>>>> E.g. this packet received during init of a BCM4324B3 (1) Bluetooth HCI:
> >>>>>>>>
> >>>>>>>> 04 0e 0a 01 79 fc 00 54 fe ff ff 00 00
> >>>>>>>>
> >>>>>>>> would sometimes turn into:
> >>>>>>>>
> >>>>>>>> 00 0e 0a 01 79 fc 00 54 fe ff ff 00 00
> >>>>>>>>
> >>>>>>>> Further investigation revealed that this goes away if I stop
> >>>>>>>> the dw_dmac module from loading, leading to:
> >>>>>>>> "dw-apb-uart 80860F0A:00: failed to request DMA"
> >>>>>>>> and the UART working without DMA support.
> >>>>>>>>
> >>>>>>>> Testing various kernels showed that this problem was introduced
> >>>>>>>> in v5.19, v5.18 - v5.18.19 are fine. An a git bisect points to:
> >>>>>>>>
> >>>>>>>> e8ffbb71f783 ("serial: 8250: use THRE & __stop_tx also with DMA")
> >>>>>>>>
> >>>>>>>> And reverting that on top of v6.3-rc2 indeed solves the problem.
> >>>>>>>
> >>>>>>>> So it seems that that commit somehow interferes with DMA based
> >>>>>>
> >>>>>>> Maybe the the extra interrupt that the tx side change will trigger somehow 
> >>>>>>> causes the confusion on the rx side. So that would be an extra call into 
> >>>>>>> handle_rx_dma() that could either do an extra flush or start DMA Rx that 
> >>>>>>> would not occur w/o that tx side change.
> >>>>>>
> >>>>>> That sounds like a likely candidate for causing this yes, as said
> >>>>>> I'm unfamiliar with the serial-port code, but I did already suspect
> >>>>>> that the change was causing some extra interrupt which somehow
> >>>>>> interfered with the rx side.
> >>>>>>
> >>>>>>>> The issue has been seen on and the revert has been tested on
> >>>>>>>> the following HW:
> >>>>>>>>
> >>>>>>>> Asus T100TA
> >>>>>>>> SoC: Bay Trail UART: 80860F0A WIFI: brcmfmac43241b4-sdio BT: BCM4324B3
> >>>>>>>>
> >>>>>>>> Lenovo Yoga Tablet 2 1051L
> >>>>>>>> SoC: Bay Trail UART: 80860F0A WIFI: brcmfmac43241b4-sdio BT: BCM4324B3
> >>>>>>>>
> >>>>>>>> Lenovo Yoga Book X91F
> >>>>>>>> Soc: Cherry Trail UART: 8086228A WIFI: brcmfmac4356-pcie BT: BCM4356A2
> >>>>>>>>
> >>>>>>>> I have more hw which I believe is affected but these are the models
> >>>>>>>> where I have done detailed testing.
> >>>>>>>>
> >>>>>>>> I would be happy to test any patches, or run a kernel with some extra
> >>>>>>>> debugging added, just let me know what you need to help fixing this.
> > 
> >>> From: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> >>> Subject: [PATCH] serial: 8250: Prevent starting up DMA Rx on THRI interrupt
> >>>
> >>> Hans de Goede reported Bluetooth adapters (HCIs) connected over an UART
> >>> connection failed due corrupted Rx payload. The problem was narrowed
> >>> down to DMA Rx starting on UART_IIR_THRI interrupt. The problem occurs 
> >>> despite LSR having DR bit set, which is precondition for attempting to 
> >>> start DMA Rx.
> >>>
> >>> This problem became apparent after e8ffbb71f783 ("serial: 8250: use
> >>> THRE & __stop_tx also with DMA") changed Tx stopping to get triggered
> >>> using THRI interrupt.
> >>>
> >>> Don't setup DMA Rx on UART_IIR_THRI but leave it to a subsequent
> >>> interrupt which has Rx related IIR value.
> >>>
> >>> Reported-by: Hans de Goede <hdegoede@redhat.com>
> >>> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> >>
> >> I can confirm that this fixes things for me:
> >>
> >> Tested-by: Hans de Goede <hdegoede@redhat.com>
> > 
> > Okay, thanks for testing.
> > 
> > Here's is a slightly improved debug patch which will count how many 
> > characters are received by DMA and non-DMA rx. It should be tested 
> > WITHOUT the fix.
> > 
> > I'm mostly interested in knowing if it's purely DMA Rx issue or whether 
> > the non-DMA rx is muddling the waters too. While investigating other 
> > issues I've seen UART_IIR_TIMEOUT (inter-character timeout) to often come 
> > so early from UART that the tail of characters is left there to be handled 
> > by the non-DMA path.
> 
> Ok, here is a new log:
> 
> https://fedorapeople.org/~jwrdegoede/dmesg-8250-dma-issue-2
> 
> With one successful hci_uart probe and one failed. The failed one looks interesting:
> 
> [  576.808776] 8250irq: iir=cc lsr+saved=60 received=1/12 ier=0d dma_t/rx/err=0/1/0 cnt=-4
> [  576.808870] Bluetooth: hci0: Frame reassembly failed (-84)
> 
> This is the only time that debug message shows anything but 0 for data 
> received over dma.

For the record, there were plenty of =1/6 and a few =224/31.

> It looks like for all these small packets dma simply 
> never kicks in and the extra IRQ from the THRI interrupt somehow starts 
> a DMA transfer for the one byte and for some reason that DMA transfer 
> always reads the byte as 0. 

It would be kind of interesting to know if handle_rx_dma() would never 
call up->dma->rx_dma(up) but return true instead to see if non-DMA Rx gets
a corrupted byte too in the very same scenario (it's not the same test as 
your no DMA test you did initially because only DMA Rx gets disabled so it
hopefully hits the same timing, etc. by keeping DMA Tx on).

> Note that the amount of received bytes is still correct, so the 1 byte 
> transfer by DMA replaces one byte which would be otherwise read from 
> MMIO (I guess its MMIO?), but it has the wrong (all bits 0) content.

Yes, it's certainly is a corruption which shouldn't occur.

I was contemplating whether to apply the fix to all 8250 or just add 
HW specific UART_BUG_xx for this. In the end (especially while looking 
into these most recent debug logs) I think it's generally useful to _not_ 
start DMA on UART_IIR_THRI because it's impossible to make an informed 
decision with it whether to do DMA or not.

I've just sent the cleaned up fix patch out.

Thanks a lot for testing.


-- 
 i.
--8323329-1521408932-1679044248=:2227--
