Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 040D0C433F5
	for <linux-serial@archiver.kernel.org>; Tue, 23 Nov 2021 15:39:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238502AbhKWPmJ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 23 Nov 2021 10:42:09 -0500
Received: from mga07.intel.com ([134.134.136.100]:54611 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238499AbhKWPmI (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 23 Nov 2021 10:42:08 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10176"; a="298452739"
X-IronPort-AV: E=Sophos;i="5.87,258,1631602800"; 
   d="scan'208";a="298452739"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2021 07:39:00 -0800
X-IronPort-AV: E=Sophos;i="5.87,258,1631602800"; 
   d="scan'208";a="674502303"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2021 07:38:58 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mpXsk-009ofI-V4;
        Tue, 23 Nov 2021 17:38:54 +0200
Date:   Tue, 23 Nov 2021 17:38:54 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jay Dolan <jay.dolan@accesio.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v1 0/2] serial: 8250_pci: Split Pericom driver
Message-ID: <YZ0LDmSH9jfw8/Es@smile.fi.intel.com>
References: <20211117145750.43911-1-andriy.shevchenko@linux.intel.com>
 <b99aabbe-add9-9c1e-ed4b-8850c69233de@accesio.com>
 <YZuRV8ipjcly26HB@smile.fi.intel.com>
 <YZuRnSaZz04KJIDk@smile.fi.intel.com>
 <ede18fd7-266e-406d-0c9c-570d95ab3673@accesio.com>
 <YZyzmzjVH35U05Wj@smile.fi.intel.com>
 <a4a34fb4-618b-0933-20a9-1e3d23327879@accesio.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4a34fb4-618b-0933-20a9-1e3d23327879@accesio.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Nov 23, 2021 at 07:02:44AM -0800, Jay Dolan wrote:
> On 11/23/21 1:25 AM, Andy Shevchenko wrote:
> > On Mon, Nov 22, 2021 at 09:19:09PM -0800, Jay Dolan wrote:
> > > On 11/22/21 4:48 AM, Andy Shevchenko wrote:
> > > > On Mon, Nov 22, 2021 at 02:47:20PM +0200, Andy Shevchenko wrote:
> > > > > On Thu, Nov 18, 2021 at 10:32:51PM -0800, Jay Dolan wrote:
> > > > > > On 11/17/21 6:57 AM, Andy Shevchenko wrote:
> > > > > > > Split Pericom driver to a separate module.
> > > > > > > While at it, re-enable high baud rates.
> > > > > > > 
> > > > > > > Jay, can you, please, test this on as many hardware as you have?
> > > > > 
> > > > > ...
> > > > > 
> > > > > > * Add in pericom_do_startup() because the UPF_MAGIC_MULTIPLIER doesn't
> > > > > > stick.
> > > > > 
> > > > > Can't find an evidence that this is the case. Can you recheck this (reading
> > > > > flags back via sysfs or so)? So, for v2 I'll leave my approach.
> > > > 
> > > > Otherwise how the other drivers which are using that flag survive? If it's
> > > > indeed an issue, it should be fixed on generic level.
> > > > 
> > > 
> > > I modified pericom_do_startup to log when the UPF_MAGIC_MULTIPLIER flag was
> > > present. Then tried to set the port to 3000000 a few times. The port
> > > stayed at 9600. It looks like pericom_do_startup() is getting called twice
> > > per port on boot, and the flag is gone with the second one.
> > > 
> > > [    4.925577] [J4D] flag present
> > > [    4.926121] [J4D[ flag not present
> > > [    4.926843] [J4D] flag present
> > > [    4.927415] [J4D[ flag not present
> > > [    4.928106] [J4D] flag present
> > > [    4.928673] [J4D[ flag not present
> > > [    4.929419] [J4D] flag present
> > > [    4.930447] [J4D[ flag not present
> > > 
> > > [   49.528504] [J4D[ flag not present
> > > [   51.675240] [J4D[ flag not present
> > > [   59.617954] [J4D[ flag not present
> > > 
> > > Then I modified it to log when it was adding the flag in. The port was set
> > > to 3000000. Also the flag only needed to be added in once. It sticks after
> > > the first time.
> > > 
> > > [    4.647546] [J4D] flag present
> > > [    4.648119] [J4D] flag not present(adding)
> > > [    4.648778] [J4D] flag present
> > > [    4.649330] [J4D] flag not present(adding)
> > > [    4.650001] [J4D] flag present
> > > [    4.650537] [J4D] flag not present(adding)
> > > [    4.651192] [J4D] flag present
> > > [    4.651718] [J4D] flag not present(adding)
> > > 
> > > [   96.025668] [J4D] flag present
> > > [  100.130626] [J4D] flag present
> > > [  116.435436] [J4D] flag present
> > > 
> > > I mostly just guessed at do_startup() being the place to set the magic
> > > multiplier flag after it didn't stick in quirk in 8250_pci.c.
> > 
> > Can you share `dmesg` and output of `lspci -nk -vv` on the machine with the
> > kernel with patches applied and running?

> Provided below.

Thanks!

> Also, I am going to lose the place for my test station to
> the  family Christmas tree after tomorrow. I'm not sure when or where I'm
> going to get it set back up.

Understood, in case you still have time to test one idea below. As far as I
understand current state of affairs the problematic part is the magic
multiplier.

> 01:00.0 0700: 494f:10dc (prog-if 02 [16550])
> 	Subsystem: 0001:0001
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
> 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort- >SERR- <PERR- INTx-
> 	Latency: 0, Cache Line Size: 64 bytes
> 	Interrupt: pin A routed to IRQ 16
> 	Region 0: I/O ports at e000 [size=64]
> 	Region 1: Memory at fe400000 (32-bit, non-prefetchable) [size=4K]

Okay, we are interested so far in IO bar (which is BAR0).
Do you know what is the BAR1 for?

> 	Capabilities: [80] Power Management version 3
> 		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA
> PME(D0-,D1-,D2-,D3hot+,D3cold-)
> 		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
> 	Capabilities: [8c] MSI: Enable- Count=1/1 Maskable- 64bit+
> 		Address: 0000000000000000  Data: 0000
> 	Capabilities: [9c] Vital Product Data
> 		Not readable
> 	Capabilities: [a4] Vendor Specific Information: Len=28 <?>
> 	Capabilities: [e0] Express (v1) Legacy Endpoint, MSI 00
> 		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
> 			ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
> 		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
> 			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
> 			MaxPayload 128 bytes, MaxReadReq 128 bytes
> 		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
> 		LnkCap:	Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s
> <512ns, L1 <1us
> 			ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp-
> 		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- CommClk-
> 			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
> 		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk- DLActive- BWMgmt-
> ABWMgmt-
> 	Capabilities: [100 v1] Advanced Error Reporting
> 		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP-
> ECRC- UnsupReq- ACSViol-
> 		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP-
> ECRC- UnsupReq- ACSViol-
> 		UESvrt:	DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+
> ECRC- UnsupReq- ACSViol-
> 		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
> 		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
> 		AERCap:	First Error Pointer: 00, GenCap- CGenEn- ChkCap- ChkEn-
> 	Kernel driver in use: 8250_pericom
> 	Kernel modules: 8250_pci, 8250_pericom

Yep, two drivers matches and only 8250_pericom is in use. All good here.

> [    0.062531] pci 0000:01:00.0: [494f:10dc] type 00 class 0x070002
> [    0.062551] pci 0000:01:00.0: reg 0x10: [io  0xe000-0xe03f]
> [    0.062562] pci 0000:01:00.0: reg 0x14: [mem 0xfe400000-0xfe400fff]
> [    0.062670] pci 0000:01:00.0: supports D1 D2
> [    0.062673] pci 0000:01:00.0: PME# supported from D3hot

Yeah, this interesting layout with 64 bytes and gap in UARTs 3-6.

> [    2.927496] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
> [    2.927703] 00:04: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a
> 16550A
> [    2.979481] 0000:01:00.0: ttyS4 at I/O 0xe000 (irq = 16, base_baud =
> 921600) is a 16550A
> [    2.979487] 0000:01:00.0: ttyS4 extra baud rates supported: 1843200,
> 3686400
> [    2.979822] 0000:01:00.0: ttyS5 at I/O 0xe008 (irq = 16, base_baud =
> 921600) is a 16550A
> [    2.979825] 0000:01:00.0: ttyS5 extra baud rates supported: 1843200,
> 3686400
> [    2.982020] 0000:01:00.0: ttyS6 at I/O 0xe010 (irq = 16, base_baud =
> 921600) is a 16550A
> [    2.982025] 0000:01:00.0: ttyS6 extra baud rates supported: 1843200,
> 3686400
> [    2.982256] 0000:01:00.0: ttyS7 at I/O 0xe038 (irq = 16, base_baud =
> 921600) is a 16550A
> [    2.982259] 0000:01:00.0: ttyS7 extra baud rates supported: 1843200,
> 3686400

This is most important part. The code autodetects 16550A. Now I'm wondering
if the following change will keep MAGIC multiplier untouched (instead of
current patch):

-   uart.port.flags = UPF_SKIP_TEST | UPF_BOOT_AUTOCONF | UPF_SHARE_IRQ;
+   uart.port.flags = UPF_FIXED_PORT | UPF_FIXED_TYPE | UPF_SHARE_IRQ | UPF_MAGIC_MULTIPLIER;
+   uart.port.type = PORT_16550A;

> [   42.730050] 8250_pericom 0000:01:00.0: VPD access failed.  This is likely
> a firmware bug on this device.  Contact the card vendor for a firmware
> update

Not sure what is this and how it may affect anything.

-- 
With Best Regards,
Andy Shevchenko


