Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73851C05027
	for <linux-serial@archiver.kernel.org>; Tue, 14 Mar 2023 16:55:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbjCNQzz (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 14 Mar 2023 12:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbjCNQzx (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 14 Mar 2023 12:55:53 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCE36AFB80
        for <linux-serial@vger.kernel.org>; Tue, 14 Mar 2023 09:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678812951; x=1710348951;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=LxP2OxbBW86+0dVDEEjV1eP9ebv9tFGdzvDx/AY4qQE=;
  b=mXrxv0ECLcM/fc9qIIeWY5sthZU9vAxnnDz+sGKZ/f7pXVly1zKeNAVC
   1PQQ89Oj99LhrlbhxVnPgDmXohqCMvrsYVfDwlrklEfIOEh/eRAYzIxmO
   ZpxD6ASqg1CbNqh2u6tUY1oh0zdMFiQMwtS3RTP6AkwuBCLvo1sYp2CNy
   HIIBJadO+Cbh74ov9/X/lt7wpMsXuAAD5W0bOxxe2QRRzRqn8kXWZx6IH
   7OyLYY46mdcj1BWYvP6lYTAemYMM4pZUFtfgwxbq8rCobtZS/KHK0S0/b
   bNrcYV9FWlDryVq3rrHvZ9benaIBPqBVF5LFGYZjrlLWcgFiUCLB/xuuS
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="339849694"
X-IronPort-AV: E=Sophos;i="5.98,260,1673942400"; 
   d="scan'208";a="339849694"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2023 09:55:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="656420339"
X-IronPort-AV: E=Sophos;i="5.98,260,1673942400"; 
   d="scan'208";a="656420339"
Received: from npeltier-mobl1.ger.corp.intel.com ([10.252.33.129])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2023 09:55:49 -0700
Date:   Tue, 14 Mar 2023 18:55:40 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Subject: Re: [Regression] "serial: 8250: use THRE & __stop_tx also with DMA"
 breaks DMA rx
In-Reply-To: <9e1e207f-a74f-cedb-6811-993d6b0a26cf@redhat.com>
Message-ID: <f729bfb4-cde1-9859-f1ff-58716772dfc4@linux.intel.com>
References: <7f18e19d-4072-0609-afd0-244b06103b9c@redhat.com> <dd9ebf9-e2e9-2b6-eec5-6ab152f92032@linux.intel.com> <316ab583-d217-a332-d161-8225b0cee227@redhat.com> <1d7c80cf-cf79-ef1-58ba-e3b99294bb6@linux.intel.com>
 <9e1e207f-a74f-cedb-6811-993d6b0a26cf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1826783580-1678812950=:80991"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1826783580-1678812950=:80991
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Tue, 14 Mar 2023, Hans de Goede wrote:
> On 3/14/23 12:48, Ilpo Järvinen wrote:
> > On Tue, 14 Mar 2023, Hans de Goede wrote:
> >> On 3/14/23 11:55, Ilpo Järvinen wrote:
> >>> On Tue, 14 Mar 2023, Hans de Goede wrote:
> >>>
> >>>> I have spend the last couple of days debugging a problem with Bluetooth
> >>>> adapters (HCIs) connected over an UART connection on Intel Bay Trail
> >>>> and Cherry Trail devices.
> >>>>
> >>>> After much debugging I found out that sometimes the first byte of
> >>>> a received packet (data[0]) would be overwritten with a 0 byte.
> >>>>
> >>>> E.g. this packet received during init of a BCM4324B3 (1) Bluetooth HCI:
> >>>>
> >>>> 04 0e 0a 01 79 fc 00 54 fe ff ff 00 00
> >>>>
> >>>> would sometimes turn into:
> >>>>
> >>>> 00 0e 0a 01 79 fc 00 54 fe ff ff 00 00
> >>>>
> >>>> Further investigation revealed that this goes away if I stop
> >>>> the dw_dmac module from loading, leading to:
> >>>> "dw-apb-uart 80860F0A:00: failed to request DMA"
> >>>> and the UART working without DMA support.
> >>>>
> >>>> Testing various kernels showed that this problem was introduced
> >>>> in v5.19, v5.18 - v5.18.19 are fine. An a git bisect points to:
> >>>>
> >>>> e8ffbb71f783 ("serial: 8250: use THRE & __stop_tx also with DMA")
> >>>>
> >>>> And reverting that on top of v6.3-rc2 indeed solves the problem.
> >>>
> >>> You did something else too than just that because you cannot cleanly 
> >>> revert just e8ffbb71f783. Please indicate what happened to:
> >>>   f8d6e9d3ca5c ("serial: 8250: Fix __stop_tx() & DMA Tx restart races")
> >>>
> >>> I guess you reverted that too and forgot to mention about it but I just 
> >>> want to be sure we're on the same page?
> >>
> >> I manually fixed up the revert, effectively
> >> dropping the drivers/tty/serial/8250/8250_port.c part of f8d6e9d3ca5c
> >> I did not revert f8d6e9d3ca5c in its entirety.
> >>
> >> I've attached my manual fixed up revert as a patch here.
> >>
> >>>> So it seems that that commit somehow interferes with DMA based
> >>>> data receiving, causing the first byte of a received data transfer
> >>>> to get replaced by 0.
> >>>
> >>> Okay, and you're sure the problem/corruption occurs on the receiving side? 
> >>
> >> What I am sure is that the first byte of a packet has been replaced by 0
> >> by the time drivers/tty/tty_buffer.c: receive_buf() gets called.
> >>
> >> I did not dive into the serial-port code side of this problem since
> >> I'm unfamiliar with that.
> >>
> >>> Maybe the the extra interrupt that the tx side change will trigger somehow 
> >>> causes the confusion on the rx side. So that would be an extra call into 
> >>> handle_rx_dma() that could either do an extra flush or start DMA Rx that 
> >>> would not occur w/o that tx side change.
> >>
> >> That sounds like a likely candidate for causing this yes, as said
> >> I'm unfamiliar with the serial-port code, but I did already suspect
> >> that the change was causing some extra interrupt which somehow
> >> interfered with the rx side.
> >>
> >>>> The issue has been seen on and the revert has been tested on
> >>>> the following HW:
> >>>>
> >>>> Asus T100TA
> >>>> SoC: Bay Trail UART: 80860F0A WIFI: brcmfmac43241b4-sdio BT: BCM4324B3
> >>>>
> >>>> Lenovo Yoga Tablet 2 1051L
> >>>> SoC: Bay Trail UART: 80860F0A WIFI: brcmfmac43241b4-sdio BT: BCM4324B3
> >>>>
> >>>> Lenovo Yoga Book X91F
> >>>> Soc: Cherry Trail UART: 8086228A WIFI: brcmfmac4356-pcie BT: BCM4356A2
> >>>>
> >>>> I have more hw which I believe is affected but these are the models
> >>>> where I have done detailed testing.
> >>>>
> >>>> I would be happy to test any patches, or run a kernel with some extra
> >>>> debugging added, just let me know what you need to help fixing this.
> >>>
> >>> How easy this is to trigger in general? (Mainly trying to gauge how 
> >>> easy it will be to find the read and/or the irq that related to the 
> >>> corrupted payload).
> >>
> >> For the git bisect I did 10 consecutive "rmmod hci_uart; modprobe hci_uart"
> >> calls, re-initializing and re-uploading the BT firmware 10 times and
> >> then looked for "Frame reassembly failed" errors (+ more error caused
> >> by this error) from the drivers/bluetooth/hci_bcm.c code.
> >>
> >> This would usually trigger at least twice with the 10 rmmod + modprobe
> >> calls and typically more often then twice.
> >>
> >> With the revert (and with 5.18.y) I never see a single error even
> >> with more rmmod + modprobe calls. Note it is not just the driver's
> >> probe() which fails, sometimes there are also later errors, this
> >> is just a somewhat convenient way to reproduce.
> >>
> >> So this is somewhat easy to trigger, not trivial to trigger,
> >> but it also does not take waiting many hours before hitting it
> >> once.
> > 
> > Okay, maybe the patch below will manage to filter the interesting part of 
> > it (not tested beyond compiling). It should capture a few irq events after 
> > the THRI is set when DMA Tx completes.
> > 
> > What I'd expect is to have iir value variation between the working and not 
> > working case. Especially, if it's UART_IIR_THRI that shows up that might 
> > be usable as a condition to return from handle_rx_dma() without touching
> > DMA Rx.
> 
> Here are 2 dmesg snippets both are with a 6.3-rc2 kernel *without*
> the revert and with your dmesg patch.
> 
> This is (part of) the HCI init without issues:
> 
> [  733.682492] hci_uart_bcm serial0-0: supply vbat not found, using dummy regulator
> [  733.682628] hci_uart_bcm serial0-0: supply vddio not found, using dummy regulator
> [  733.927142] 8250irq: iir=c2 lsr+saved=20 ier=0f dma_t/rx/err=0/0/0 skiprx=0 cnt=-5
> [  733.928311] 8250irq: iir=cc lsr+saved=60 ier=0d dma_t/rx/err=0/0/0 skiprx=0 cnt=-4
> [  733.932892] 8250irq: iir=c2 lsr+saved=60 ier=0f dma_t/rx/err=0/0/0 skiprx=0 cnt=-5
> [  733.933818] 8250irq: iir=cc lsr+saved=60 ier=0d dma_t/rx/err=0/0/0 skiprx=0 cnt=-4
> [  733.970404] 8250irq: iir=c2 lsr+saved=60 ier=0f dma_t/rx/err=0/0/0 skiprx=0 cnt=-5
> [  733.975558] 8250irq: iir=cc lsr+saved=60 ier=0d dma_t/rx/err=0/0/0 skiprx=0 cnt=-4
> [  734.080290] 8250irq: iir=cc lsr+saved=60 ier=0f dma_t/rx/err=0/0/0 skiprx=0 cnt=-5
> [  734.081300] 8250irq: iir=cc lsr+saved=60 ier=0f dma_t/rx/err=0/0/0 skiprx=0 cnt=-5
> [  734.081492] Bluetooth: hci0: BCM: chip id 101
> 
> Here is another *successful* log with slightly different timing.
> 
> [  737.660532] hci_uart_bcm serial0-0: supply vbat not found, using dummy regulator
> [  737.660681] hci_uart_bcm serial0-0: supply vddio not found, using dummy regulator
> [  737.905238] 8250irq: iir=c2 lsr+saved=20 ier=0f dma_t/rx/err=0/0/0 skiprx=0 cnt=-5
> [  737.906429] 8250irq: iir=cc lsr+saved=60 ier=0d dma_t/rx/err=0/0/0 skiprx=0 cnt=-4
> [  737.907782] 8250irq: iir=c2 lsr+saved=20 ier=0f dma_t/rx/err=0/0/0 skiprx=0 cnt=-5
> [  737.908978] 8250irq: iir=cc lsr+saved=60 ier=0d dma_t/rx/err=0/0/0 skiprx=0 cnt=-4
> [  737.935929] 8250irq: iir=c2 lsr+saved=60 ier=0f dma_t/rx/err=0/0/0 skiprx=0 cnt=-5
> [  737.940976] 8250irq: iir=cc lsr+saved=60 ier=0d dma_t/rx/err=0/0/0 skiprx=0 cnt=-4
> [  738.048476] 8250irq: iir=cc lsr+saved=60 ier=0f dma_t/rx/err=0/0/0 skiprx=0 cnt=-5
> [  738.049530] 8250irq: iir=c2 lsr+saved=60 ier=0f dma_t/rx/err=0/0/0 skiprx=0 cnt=-5
> [  738.049678] 8250irq: iir=cc lsr+saved=60 ier=0d dma_t/rx/err=0/0/0 skiprx=0 cnt=-4
> [  738.050142] Bluetooth: hci0: BCM: chip id 101
> 
> And here is the same part of the init sequence with an error:
> 
> [  771.247538] hci_uart_bcm serial0-0: supply vbat not found, using dummy regulator
> [  771.247656] hci_uart_bcm serial0-0: supply vddio not found, using dummy regulator
> [  771.493259] 8250irq: iir=c2 lsr+saved=20 ier=0f dma_t/rx/err=0/0/0 skiprx=0 cnt=-5
> [  771.494378] 8250irq: iir=cc lsr+saved=60 ier=0d dma_t/rx/err=0/0/0 skiprx=0 cnt=-4
> [  771.495637] 8250irq: iir=c2 lsr+saved=20 ier=0f dma_t/rx/err=0/0/0 skiprx=0 cnt=-5
> [  771.496833] 8250irq: iir=cc lsr+saved=60 ier=0d dma_t/rx/err=0/0/0 skiprx=0 cnt=-4
> [  771.523597] 8250irq: iir=c2 lsr+saved=60 ier=0f dma_t/rx/err=0/0/0 skiprx=0 cnt=-5
> [  771.528708] 8250irq: iir=cc lsr+saved=60 ier=0d dma_t/rx/err=0/0/0 skiprx=0 cnt=-4
> [  771.632340] 8250irq: iir=c2 lsr+saved=61 ier=0f dma_t/rx/err=0/0/0 skiprx=0 cnt=-5
> [  771.632462] 8250irq: iir=cc lsr+saved=60 ier=0d dma_t/rx/err=0/1/0 skiprx=0 cnt=-4
> [  771.632568] Bluetooth: hci0: Frame reassembly failed (-84)
> 
> Here is a full dmesg from several rmmod + modprobes, for the errors look for
> "Frame reassembly failed".
> 
> Note this is from a different boot, I had to add log_buf_len=50M to be able
> to grab a full dmesg:
> 
> https://fedorapeople.org/~jwrdegoede/dmesg-8250-dma-issue

Thanks. I'll try to come up with another debug patch tomorrow to further 
inspect the payload that will be read after that point.

In the meantime you could try if the following patch is enough 
to solve the issue.


From: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH] serial: 8250: Prevent starting up DMA Rx on THRI interrupt

Hans de Goede reported Bluetooth adapters (HCIs) connected over an UART
connection failed due corrupted Rx payload. The problem was narrowed
down to DMA Rx starting on UART_IIR_THRI interrupt. The problem occurs 
despite LSR having DR bit set, which is precondition for attempting to 
start DMA Rx.

This problem became apparent after e8ffbb71f783 ("serial: 8250: use
THRE & __stop_tx also with DMA") changed Tx stopping to get triggered
using THRI interrupt.

Don't setup DMA Rx on UART_IIR_THRI but leave it to a subsequent
interrupt which has Rx related IIR value.

Reported-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

---
 drivers/tty/serial/8250/8250_port.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index fa43df05342b..a3ef2f42a06b 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -1903,6 +1903,8 @@ EXPORT_SYMBOL_GPL(serial8250_modem_status);
 static bool handle_rx_dma(struct uart_8250_port *up, unsigned int iir)
 {
 	switch (iir & 0x3f) {
+	case UART_IIR_THRI:
+		return false;
 	case UART_IIR_RDI:
 		if (!up->dma->rx_running)
 			break;

-- 
tg: (571079f5ba93..) fix/dma-rx-startup (depends on: tty-next)
--8323329-1826783580-1678812950=:80991--
