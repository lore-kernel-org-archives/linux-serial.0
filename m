From: Greg KH <greg@kroah.com>
Subject: Re: LAVA PCIe serial card problem
Date: Thu, 10 Mar 2011 12:16:43 -0800
Message-ID: <20110310201643.GB30927@kroah.com>
References: <4D62F593.4010103@cfa.harvard.edu>
 <20110222220548.GB4530@kroah.com>
 <4D79278A.9010007@cfa.harvard.edu>
 <20110310194828.GA29495@kroah.com>
 <4D792FC3.4090905@cfa.harvard.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:59560 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751137Ab1CJUS0 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 10 Mar 2011 15:18:26 -0500
Content-Disposition: inline
In-Reply-To: <4D792FC3.4090905@cfa.harvard.edu>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Tamas Szklenar <tszklenar@cfa.harvard.edu>
Cc: linux-serial@vger.kernel.org

On Thu, Mar 10, 2011 at 03:08:35PM -0500, Tamas Szklenar wrote:
> Dear Greg,
> 
> This was my original message:
> 
> We bought two PCIe serial cards from LAVA, one dual and one quad port card.
> 
> My problem is that the devices are visible in lspci, but no module
> is loaded to the cards. I have other PCI card from this manufacturer
> and they are working well and the necessary module is loaded fine. I
> can't use these cards because of this problem.
> 
> Our linux is using the 2.6.35.7 kernel version. I checked the source
> code and the cards are already there in the necessary c files.

If the device ids are in the driver for this device, are you sure the
driver is loaded?

What driver should be controlling it?

> 
> Could you help me to fix these card?
> 
> I attached the output of the dmesg and the lspci to my mail.
> 
> Thank you very much!
> 
> 
> Tamas
> 
> ===============================
> ===============================
> 
> Here is the output of the lspci -vv:
> 
> 07:00.0 Serial controller: NetMos Technology PCIe 9901 Multi-I/O
> Controller (prog-if 02 [16550])
>         Subsystem: Lava Computer mfg Inc Device 0104
>         Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B- DisINTx-
>         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast
> >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>         Interrupt: pin A routed to IRQ 17
>         Region 0: I/O ports at 8f00 [size=8]
>         Region 1: Memory at fd6ff000 (32-bit, non-prefetchable) [size=4K]
>         Region 4: Memory at fd6fe000 (32-bit, non-prefetchable) [size=4K]
>         Capabilities: [80] Power Management version 3
>                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
> PME(D0+,D1+,D2+,D3hot+,D3cold+)
>                 Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=1 PME-
>         Capabilities: [88] MSI: Enable- Count=1/32 Maskable- 64bit+
>                 Address: 0000000000000000  Data: 0000
>         Capabilities: [c0] Express (v1) Legacy Endpoint, MSI 00
>                 DevCap: MaxPayload 256 bytes, PhantFunc 0, Latency
> L0s <64ns, L1 <1us
>                         ExtTag- AttnBtn+ AttnInd+ PwrInd+ RBE- FLReset-
>                 DevCtl: Report errors: Correctable- Non-Fatal-
> Fatal- Unsupported-
>                         RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
>                         MaxPayload 128 bytes, MaxReadReq 512 bytes
>                 DevSta: CorrErr- UncorrErr+ FatalErr- UnsuppReq+
> AuxPwr+ TransPend-
>                 LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s
> L1, Latency L0 unlimited, L1 unlimited
>                         ClockPM- Surprise- LLActRep- BwNot-
>                 LnkCtl: ASPM Disabled; RCB 64 bytes Disabled-
> Retrain- CommClk-
>                         ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>                 LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train-
> SlotClk+ DLActive- BWMgmt- ABWMgmt-
>         Capabilities: [100 v1] Power Budgeting <?>
>         Capabilities: [200 v1] Device Serial Number 88-99-ff-ee-dd-cc-bb-aa
> 
> 07:00.1 Serial controller: NetMos Technology PCIe 9901 Multi-I/O
> Controller (prog-if 02 [16550])
>         Subsystem: Lava Computer mfg Inc Device 0105
>         Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B- DisINTx-
>         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast
> >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>         Interrupt: pin B routed to IRQ 17
>         Region 0: I/O ports at 8e00 [size=8]
>         Region 1: Memory at fd6fd000 (32-bit, non-prefetchable) [size=4K]
>         Region 4: Memory at fd6fc000 (32-bit, non-prefetchable) [size=4K]
>         Capabilities: [80] Power Management version 3
>                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
> PME(D0+,D1+,D2+,D3hot+,D3cold+)
>                 Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=1 PME-
>         Capabilities: [88] MSI: Enable- Count=1/32 Maskable- 64bit+
>                 Address: 0000000000000000  Data: 0000
>         Capabilities: [c0] Express (v1) Legacy Endpoint, MSI 00
>                 DevCap: MaxPayload 256 bytes, PhantFunc 0, Latency
> L0s <64ns, L1 <1us
>                         ExtTag- AttnBtn+ AttnInd+ PwrInd+ RBE- FLReset-
>                 DevCtl: Report errors: Correctable- Non-Fatal-
> Fatal- Unsupported-
>                         RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
>                         MaxPayload 128 bytes, MaxReadReq 512 bytes
>                 DevSta: CorrErr- UncorrErr+ FatalErr- UnsuppReq+
> AuxPwr+ TransPend-
>                 LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s
> L1, Latency L0 unlimited, L1 unlimited
>                         ClockPM- Surprise- LLActRep- BwNot-
>                 LnkCtl: ASPM Disabled; RCB 64 bytes Disabled-
> Retrain- CommClk-
>                         ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
> 
> ===============================
> 
> This is the output of the dmesg:
> 
> [    6.249634] serial 0000:08:00.0: PCI INT A -> GSI 17 (level, low)
> -> IRQ 17
> [    6.249641] serial 0000:08:00.0: PCI INT A disabled
> [    6.249654] serial 0000:08:00.1: PCI INT B -> GSI 17 (level, low)
> -> IRQ 17
> [    6.249659] serial 0000:08:00.1: PCI INT B disabled
> [    6.249671] serial 0000:08:00.2: PCI INT C -> GSI 17 (level, low)
> -> IRQ 17
> [    6.249676] serial 0000:08:00.2: PCI INT C disabled
> [    6.249687] serial 0000:08:00.3: PCI INT D -> GSI 17 (level, low)
> -> IRQ 17
> [    6.249692] serial 0000:08:00.3: PCI INT D disabled


This doesn't look like your PCI devices above, as the pci device bus
numbers don't match.

Can you provide the output of:
	lspci -n
	lspci
	lspci -k
for us?

as well as the full boot log?

thanks,

greg k-h
