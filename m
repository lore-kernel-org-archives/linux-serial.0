Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 231A1C433F5
	for <linux-serial@archiver.kernel.org>; Tue, 23 Nov 2021 15:02:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238272AbhKWPF4 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 23 Nov 2021 10:05:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236016AbhKWPFz (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 23 Nov 2021 10:05:55 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8106EC061574
        for <linux-serial@vger.kernel.org>; Tue, 23 Nov 2021 07:02:47 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id np3so16817888pjb.4
        for <linux-serial@vger.kernel.org>; Tue, 23 Nov 2021 07:02:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=accesio-com.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FXDWe8+ppkpng+DggBlO/+/WWyAutYi8V65mr6mQHTc=;
        b=VRS+hefcM53wF0jBELzimgAQHqQVH7VvBYdg1ugsqTK8+SeFDypGpuAa2Q7IdwHSsA
         OUfzkYqEBM4xS46sDHG3IuH1+bSt9joTfhV/h/XQsGZa3QBgT+sSS3DDGrVP8AIbPbjH
         bO/SgG3nddSls1K4U3d0hKyl2dl+0cSYw0ZS6MgjdWl6au8WBDrTfF+QvudHgd9O8QP4
         3jAw5BuiJz24pHLd2B3NKjm1Gq17Jmk5S8+7iCGLZcfTB+ZAIQMcrWh9ofh+aAecfzJw
         WjAdhlM+9jcRp6u14OpABCWnD5AsMQ36nWP4HSlw8QrEdSVi2MfCn/PCe5RvLVZH1dWE
         Hclw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FXDWe8+ppkpng+DggBlO/+/WWyAutYi8V65mr6mQHTc=;
        b=LZurIhOekliAlQoEOxDoZVUkzGq0pTIae6DiLgLLGq3pBzDUJNY3BwxnxR8WYmb5iN
         MsvsE16ur9PgXrIhstVdsFPwvQisiqSx9l97Xv12kBYV3q4s6KV64ByodUU5256A9yw/
         2e2wsXNDvUPM4QhlYKZoVFCRUul/8M2pKKOHq90EQ46J1YmrKmtO4Dts86aPhCs2Ed1c
         ox4IdmCxB+yX5LPUwEzQdUklpe99ZfeRzVJWZpsBGmd8OoaaDw5eIkAxRIOzazsdkngs
         DbZDb/5//tPMupcmZ1NayspsuL5yiDUgQqJF3Fm5yESb+BtSSLB1wo9YmTMGQJkbhhwq
         DzqQ==
X-Gm-Message-State: AOAM530RDeEGpop2PSFkBdqvFFtLcAvU6h56BdBx8kLW66NdBof/4iSE
        N7IpehS+YkXuN0gntx3cuhDa
X-Google-Smtp-Source: ABdhPJyyWaHeNJAmVlCKocEjNnWASndC63C4wwDwZDYYQan9eRcVh3K1Xdq0E7EZcKr0Ql/PzpF+oQ==
X-Received: by 2002:a17:902:8214:b0:142:61cf:7be with SMTP id x20-20020a170902821400b0014261cf07bemr7889057pln.0.1637679766367;
        Tue, 23 Nov 2021 07:02:46 -0800 (PST)
Received: from [172.16.8.241] ([98.149.220.160])
        by smtp.gmail.com with ESMTPSA id b8sm12447095pfi.103.2021.11.23.07.02.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Nov 2021 07:02:45 -0800 (PST)
Subject: Re: [PATCH v1 0/2] serial: 8250_pci: Split Pericom driver
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Jiri Slaby <jirislaby@kernel.org>
References: <20211117145750.43911-1-andriy.shevchenko@linux.intel.com>
 <b99aabbe-add9-9c1e-ed4b-8850c69233de@accesio.com>
 <YZuRV8ipjcly26HB@smile.fi.intel.com> <YZuRnSaZz04KJIDk@smile.fi.intel.com>
 <ede18fd7-266e-406d-0c9c-570d95ab3673@accesio.com>
 <YZyzmzjVH35U05Wj@smile.fi.intel.com>
From:   Jay Dolan <jay.dolan@accesio.com>
Message-ID: <a4a34fb4-618b-0933-20a9-1e3d23327879@accesio.com>
Date:   Tue, 23 Nov 2021 07:02:44 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YZyzmzjVH35U05Wj@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org



On 11/23/21 1:25 AM, Andy Shevchenko wrote:
> On Mon, Nov 22, 2021 at 09:19:09PM -0800, Jay Dolan wrote:
>> On 11/22/21 4:48 AM, Andy Shevchenko wrote:
>>> On Mon, Nov 22, 2021 at 02:47:20PM +0200, Andy Shevchenko wrote:
>>>> On Thu, Nov 18, 2021 at 10:32:51PM -0800, Jay Dolan wrote:
>>>>> On 11/17/21 6:57 AM, Andy Shevchenko wrote:
>>>>>> Split Pericom driver to a separate module.
>>>>>> While at it, re-enable high baud rates.
>>>>>>
>>>>>> Jay, can you, please, test this on as many hardware as you have?
>>>>
>>>> ...
>>>>
>>>>> * Add in pericom_do_startup() because the UPF_MAGIC_MULTIPLIER doesn't
>>>>> stick.
>>>>
>>>> Can't find an evidence that this is the case. Can you recheck this (reading
>>>> flags back via sysfs or so)? So, for v2 I'll leave my approach.
>>>
>>> Otherwise how the other drivers which are using that flag survive? If it's
>>> indeed an issue, it should be fixed on generic level.
>>>
>>
>> I modified pericom_do_startup to log when the UPF_MAGIC_MULTIPLIER flag was
>> present. Then tried to set the port to 3000000 a few times. The port
>> stayed at 9600. It looks like pericom_do_startup() is getting called twice
>> per port on boot, and the flag is gone with the second one.
>>
>> [    4.925577] [J4D] flag present
>> [    4.926121] [J4D[ flag not present
>> [    4.926843] [J4D] flag present
>> [    4.927415] [J4D[ flag not present
>> [    4.928106] [J4D] flag present
>> [    4.928673] [J4D[ flag not present
>> [    4.929419] [J4D] flag present
>> [    4.930447] [J4D[ flag not present
>>
>> [   49.528504] [J4D[ flag not present
>> [   51.675240] [J4D[ flag not present
>> [   59.617954] [J4D[ flag not present
>>
>> Then I modified it to log when it was adding the flag in. The port was set
>> to 3000000. Also the flag only needed to be added in once. It sticks after
>> the first time.
>>
>> [    4.647546] [J4D] flag present
>> [    4.648119] [J4D] flag not present(adding)
>> [    4.648778] [J4D] flag present
>> [    4.649330] [J4D] flag not present(adding)
>> [    4.650001] [J4D] flag present
>> [    4.650537] [J4D] flag not present(adding)
>> [    4.651192] [J4D] flag present
>> [    4.651718] [J4D] flag not present(adding)
>>
>> [   96.025668] [J4D] flag present
>> [  100.130626] [J4D] flag present
>> [  116.435436] [J4D] flag present
>>
>> I mostly just guessed at do_startup() being the place to set the magic
>> multiplier flag after it didn't stick in quirk in 8250_pci.c.
> 
> Can you share `dmesg` and output of `lspci -nk -vv` on the machine with the
> kernel with patches applied and running?
> 

Provided below. Also, I am going to lose the place for my test station 
to the  family Christmas tree after tomorrow. I'm not sure when or where 
I'm going to get it set back up.

00:00.0 0600: 8086:0100 (rev 09)
	Subsystem: 8086:200b
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort+ >SERR- <PERR- INTx-
	Latency: 0
	Capabilities: [e0] Vendor Specific Information: Len=0c <?>
	Kernel driver in use: snb_uncore

00:01.0 0604: 8086:0101 (rev 09) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 24
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000e000-0000efff
	Memory behind bridge: fe400000-fe4fffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [88] Subsystem: 8086:200b
	Capabilities: [80] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [90] MSI: Enable+ Count=1/1 Maskable- 64bit-
		Address: fee04004  Data: 0021
	Capabilities: [a0] Express (v2) Root Port (Slot+), MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0
			ExtTag- RBE+
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #2, Speed 5GT/s, Width x16, ASPM L0s L1, Exit Latency L0s 
<1us, L1 <4us
			ClockPM- Surprise- LLActRep- BwNot+ ASPMOptComp-
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- 
BWMgmt+ ABWMgmt-
		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
			Slot #0, PowerLimit 10.000W; Interlock- NoCompl+
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
			Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
			Changed: MRL- PresDet+ LinkState-
		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+ CRSVisible-
		RootCap: CRSVisible-
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
		DevCap2: Completion Timeout: Not Supported, TimeoutDis-, LTR+, OBFF 
Not Supported ARIFwd-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF 
Disabled ARIFwd-
		LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- 
ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, 
EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [100 v1] Virtual Channel
		Caps:	LPEVC=0 RefClk=100ns PATEntryBits=1
		Arb:	Fixed- WRR32- WRR64- WRR128-
		Ctrl:	ArbSelect=Fixed
		Status:	InProgress-
		VC0:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
			Arb:	Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
			Status:	NegoPending- InProgress-
	Capabilities: [140 v1] Root Complex Link
		Desc:	PortNumber=02 ComponentID=01 EltType=Config
		Link0:	Desc:	TargetPort=00 TargetComponent=01 AssocRCRB- 
LinkType=MemMapped LinkValid+
			Addr:	00000000fed19000
	Kernel driver in use: pcieport

00:02.0 0300: 8086:0102 (rev 09) (prog-if 00 [VGA controller])
	Subsystem: 8086:200b
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 28
	Region 0: Memory at fe000000 (64-bit, non-prefetchable) [size=4M]
	Region 2: Memory at d0000000 (64-bit, prefetchable) [size=256M]
	Region 4: I/O ports at f000 [size=64]
	[virtual] Expansion ROM at 000c0000 [disabled] [size=128K]
	Capabilities: [90] MSI: Enable+ Count=1/1 Maskable- 64bit-
		Address: fee08004  Data: 0023
	Capabilities: [d0] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [a4] PCI Advanced Features
		AFCap: TP+ FLR+
		AFCtrl: FLR-
		AFStatus: TP-
	Kernel driver in use: i915
	Kernel modules: i915

00:16.0 0780: 8086:1c3a (rev 04)
	Subsystem: 8086:200b
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 27
	Region 0: Memory at fe529000 (64-bit, non-prefetchable) [size=16]
	Capabilities: [50] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [8c] MSI: Enable+ Count=1/1 Maskable- 64bit+
		Address: 00000000fee04004  Data: 0023
	Kernel driver in use: mei_me
	Kernel modules: mei_me

00:19.0 0200: 8086:1503 (rev 04)
	Subsystem: 8086:200b
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 25
	Region 0: Memory at fe500000 (32-bit, non-prefetchable) [size=128K]
	Region 1: Memory at fe528000 (32-bit, non-prefetchable) [size=4K]
	Region 2: I/O ports at f080 [size=32]
	Capabilities: [c8] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=1 PME-
	Capabilities: [d0] MSI: Enable+ Count=1/1 Maskable- 64bit+
		Address: 00000000fee08004  Data: 0024
	Capabilities: [e0] PCI Advanced Features
		AFCap: TP+ FLR+
		AFCtrl: FLR-
		AFStatus: TP-
	Kernel driver in use: e1000e
	Kernel modules: e1000e

00:1a.0 0c03: 8086:1c2d (rev 04) (prog-if 20 [EHCI])
	Subsystem: 8086:200b
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 16
	Region 0: Memory at fe527000 (32-bit, non-prefetchable) [size=1K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [58] Debug port: BAR=1 offset=00a0
	Capabilities: [98] PCI Advanced Features
		AFCap: TP+ FLR+
		AFCtrl: FLR-
		AFStatus: TP-
	Kernel driver in use: ehci-pci

00:1b.0 0403: 8086:1c20 (rev 04)
	Subsystem: 8086:200b
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 29
	Region 0: Memory at fe520000 (64-bit, non-prefetchable) [size=16K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [60] MSI: Enable+ Count=1/1 Maskable- 64bit+
		Address: 00000000fee01004  Data: 0023
	Capabilities: [70] Express (v1) Root Complex Integrated Endpoint, MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0
			ExtTag- RBE-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
	Capabilities: [100 v1] Virtual Channel
		Caps:	LPEVC=0 RefClk=100ns PATEntryBits=1
		Arb:	Fixed- WRR32- WRR64- WRR128-
		Ctrl:	ArbSelect=Fixed
		Status:	InProgress-
		VC0:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
			Arb:	Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=01
			Status:	NegoPending- InProgress-
		VC1:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
			Arb:	Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=1 ArbSelect=Fixed TC/VC=22
			Status:	NegoPending- InProgress-
	Capabilities: [130 v1] Root Complex Link
		Desc:	PortNumber=0f ComponentID=00 EltType=Config
		Link0:	Desc:	TargetPort=00 TargetComponent=00 AssocRCRB- 
LinkType=MemMapped LinkValid+
			Addr:	00000000fed1c000
	Kernel driver in use: snd_hda_intel
	Kernel modules: snd_hda_intel

00:1d.0 0c03: 8086:1c26 (rev 04) (prog-if 20 [EHCI])
	Subsystem: 8086:200b
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 23
	Region 0: Memory at fe526000 (32-bit, non-prefetchable) [size=1K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [58] Debug port: BAR=1 offset=00a0
	Capabilities: [98] PCI Advanced Features
		AFCap: TP+ FLR+
		AFCtrl: FLR-
		AFStatus: TP-
	Kernel driver in use: ehci-pci

00:1e.0 0604: 8086:244e (rev a4) (prog-if 01 [Subtractive decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=32
	Secondary status: 66MHz- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [50] Subsystem: 8086:200b

00:1f.0 0601: 8086:1c50 (rev 04)
	Subsystem: 8086:200b
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Capabilities: [e0] Vendor Specific Information: Len=0c <?>
	Kernel driver in use: lpc_ich
	Kernel modules: lpc_ich

00:1f.2 0106: 8086:1c02 (rev 04) (prog-if 01 [AHCI 1.0])
	Subsystem: 8086:200b
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin B routed to IRQ 26
	Region 0: I/O ports at f0d0 [size=8]
	Region 1: I/O ports at f0c0 [size=4]
	Region 2: I/O ports at f0b0 [size=8]
	Region 3: I/O ports at f0a0 [size=4]
	Region 4: I/O ports at f060 [size=32]
	Region 5: Memory at fe525000 (32-bit, non-prefetchable) [size=2K]
	Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
		Address: fee04004  Data: 0024
	Capabilities: [70] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [a8] SATA HBA v1.0 BAR4 Offset=00000004
	Capabilities: [b0] PCI Advanced Features
		AFCap: TP+ FLR+
		AFCtrl: FLR-
		AFStatus: TP-
	Kernel driver in use: ahci
	Kernel modules: ahci

00:1f.3 0c05: 8086:1c22 (rev 04)
	Subsystem: 8086:200b
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
	Interrupt: pin C routed to IRQ 10
	Region 0: Memory at fe524000 (64-bit, non-prefetchable) [size=256]
	Region 4: I/O ports at f040 [size=32]
	Kernel modules: i2c_i801

01:00.0 0700: 494f:10dc (prog-if 02 [16550])
	Subsystem: 0001:0001
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 16
	Region 0: I/O ports at e000 [size=64]
	Region 1: Memory at fe400000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [80] Power Management version 3
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA 
PME(D0-,D1-,D2-,D3hot+,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [8c] MSI: Enable- Count=1/1 Maskable- 64bit+
		Address: 0000000000000000  Data: 0000
	Capabilities: [9c] Vital Product Data
		Not readable
	Capabilities: [a4] Vendor Specific Information: Len=28 <?>
	Capabilities: [e0] Express (v1) Legacy Endpoint, MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
		LnkCap:	Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit Latency 
L0s <512ns, L1 <1us
			ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp-
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk- DLActive- 
BWMgmt- ABWMgmt-
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- 
MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- 
MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ 
MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		AERCap:	First Error Pointer: 00, GenCap- CGenEn- ChkCap- ChkEn-
	Kernel driver in use: 8250_pericom
	Kernel modules: 8250_pci, 8250_pericom






[    0.000000] microcode: microcode updated early to revision 0x2f, date 
= 2019-02-17
[    0.000000] Linux version 5.16.0-rc1+ (jdolan@work-laptop) (gcc 
(Ubuntu 9.3.0-17ubuntu1~20.04) 9.3.0, GNU ld (GNU Binutils for Ubuntu) 
2.34) #17 SMP PREEMPT Thu Nov 18 16:26:46 PST 2021
[    0.000000] Command line: BOOT_IMAGE=/boot/vmlinuz-5.16.0-rc1+ 
root=UUID=1237a243-bb81-47f8-857d-50bc9ada5b90 ro quiet splash vt.handoff=1
[    0.000000] KERNEL supported cpus:
[    0.000000]   Intel GenuineIntel
[    0.000000]   AMD AuthenticAMD
[    0.000000]   Hygon HygonGenuine
[    0.000000]   Centaur CentaurHauls
[    0.000000]   zhaoxin   Shanghai
[    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating 
point registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.000000] x86/fpu: Enabled xstate features 0x7, context size is 832 
bytes, using 'standard' format.
[    0.000000] signal: max sigframe size: 1776
[    0.000000] reserving inaccessible SNB gfx pages
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009abff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009ac00-0x000000000009ffff] 
reserved
[    0.000000] BIOS-e820: [mem 0x00000000000e0000-0x00000000000fffff] 
reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000001fffffff] usable
[    0.000000] BIOS-e820: [mem 0x0000000020000000-0x00000000201fffff] 
reserved
[    0.000000] BIOS-e820: [mem 0x0000000020200000-0x000000003fffffff] usable
[    0.000000] BIOS-e820: [mem 0x0000000040000000-0x00000000401fffff] 
reserved
[    0.000000] BIOS-e820: [mem 0x0000000040200000-0x00000000bc98dfff] usable
[    0.000000] BIOS-e820: [mem 0x00000000bc98e000-0x00000000bc9d8fff] 
ACPI NVS
[    0.000000] BIOS-e820: [mem 0x00000000bc9d9000-0x00000000bc9e0fff] 
ACPI data
[    0.000000] BIOS-e820: [mem 0x00000000bc9e1000-0x00000000bcad2fff] 
reserved
[    0.000000] BIOS-e820: [mem 0x00000000bcad3000-0x00000000bcad4fff] usable
[    0.000000] BIOS-e820: [mem 0x00000000bcad5000-0x00000000bcbdbfff] 
reserved
[    0.000000] BIOS-e820: [mem 0x00000000bcbdc000-0x00000000bcbdcfff] usable
[    0.000000] BIOS-e820: [mem 0x00000000bcbdd000-0x00000000bcbecfff] 
reserved
[    0.000000] BIOS-e820: [mem 0x00000000bcbed000-0x00000000bcbfafff] 
ACPI NVS
[    0.000000] BIOS-e820: [mem 0x00000000bcbfb000-0x00000000bcc1efff] 
reserved
[    0.000000] BIOS-e820: [mem 0x00000000bcc1f000-0x00000000bcc61fff] 
ACPI NVS
[    0.000000] BIOS-e820: [mem 0x00000000bcc62000-0x00000000bce81fff] 
reserved
[    0.000000] BIOS-e820: [mem 0x00000000bce82000-0x00000000bcffffff] usable
[    0.000000] BIOS-e820: [mem 0x00000000bd800000-0x00000000bf9fffff] 
reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed1c000-0x00000000fed1ffff] 
reserved
[    0.000000] BIOS-e820: [mem 0x00000000ff000000-0x00000000ffffffff] 
reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000013e5fffff] usable
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] SMBIOS 2.6 present.
[    0.000000] DMI:  /DB65AL, BIOS ALB6510H.86A.0055.2011.1003.1116 
10/03/2011
[    0.000000] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.000000] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000000] last_pfn = 0x13e600 max_arch_pfn = 0x400000000
[    0.000000] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- 
WT
[    0.000000] total RAM covered: 4030M
[    0.000000] Found optimal setting for mtrr clean up
[    0.000000]  gran_size: 64K 	chunk_size: 64M 	num_reg: 8  	lose cover 
RAM: 0G
[    0.000000] e820: update [mem 0xbd800000-0xffffffff] usable ==> reserved
[    0.000000] last_pfn = 0xbd000 max_arch_pfn = 0x400000000
[    0.000000] found SMP MP-table at [mem 0x000fce20-0x000fce2f]
[    0.000000] RAMDISK: [mem 0x32d1f000-0x35686fff]
[    0.000000] ACPI: Early table checksum verification disabled
[    0.000000] ACPI: RSDP 0x00000000000F0450 000024 (v02 INTEL )
[    0.000000] ACPI: XSDT 0x00000000BC9D9068 000054 (v01 INTEL  DB65AL 
  01072009 AMI  00010013)
[    0.000000] ACPI: FACP 0x00000000BC9E04B8 0000F4 (v04 INTEL  DB65AL 
  01072009 AMI  00010013)
[    0.000000] ACPI: DSDT 0x00000000BC9D9150 007365 (v02 INTEL  DB65AL 
  00000016 INTL 20051117)
[    0.000000] ACPI: FACS 0x00000000BCBF2F80 000040
[    0.000000] ACPI: APIC 0x00000000BC9E05B0 000072 (v03 INTEL  DB65AL 
  01072009 AMI  00010013)
[    0.000000] ACPI: SSDT 0x00000000BC9E0628 000102 (v01 INTEL  DB65AL 
  00000001 MSFT 03000001)
[    0.000000] ACPI: MCFG 0x00000000BC9E0730 00003C (v01 INTEL  DB65AL 
  01072009 MSFT 00000097)
[    0.000000] ACPI: HPET 0x00000000BC9E0770 000038 (v01 INTEL  DB65AL 
  01072009 AMI. 00000004)
[    0.000000] ACPI: ASF! 0x00000000BC9E07A8 0000A0 (v32 INTEL  DB65AL 
  00000001 TFSM 000F4240)
[    0.000000] ACPI: Reserving FACP table memory at [mem 
0xbc9e04b8-0xbc9e05ab]
[    0.000000] ACPI: Reserving DSDT table memory at [mem 
0xbc9d9150-0xbc9e04b4]
[    0.000000] ACPI: Reserving FACS table memory at [mem 
0xbcbf2f80-0xbcbf2fbf]
[    0.000000] ACPI: Reserving APIC table memory at [mem 
0xbc9e05b0-0xbc9e0621]
[    0.000000] ACPI: Reserving SSDT table memory at [mem 
0xbc9e0628-0xbc9e0729]
[    0.000000] ACPI: Reserving MCFG table memory at [mem 
0xbc9e0730-0xbc9e076b]
[    0.000000] ACPI: Reserving HPET table memory at [mem 
0xbc9e0770-0xbc9e07a7]
[    0.000000] ACPI: Reserving ASF! table memory at [mem 
0xbc9e07a8-0xbc9e0847]
[    0.000000] No NUMA configuration found
[    0.000000] Faking a node at [mem 0x0000000000000000-0x000000013e5fffff]
[    0.000000] NODE_DATA(0) allocated [mem 0x13e5d2000-0x13e5fcfff]
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.000000]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.000000]   Normal   [mem 0x0000000100000000-0x000000013e5fffff]
[    0.000000]   Device   empty
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000001000-0x0000000000099fff]
[    0.000000]   node   0: [mem 0x0000000000100000-0x000000001fffffff]
[    0.000000]   node   0: [mem 0x0000000020200000-0x000000003fffffff]
[    0.000000]   node   0: [mem 0x0000000040200000-0x00000000bc98dfff]
[    0.000000]   node   0: [mem 0x00000000bcad3000-0x00000000bcad4fff]
[    0.000000]   node   0: [mem 0x00000000bcbdc000-0x00000000bcbdcfff]
[    0.000000]   node   0: [mem 0x00000000bce82000-0x00000000bcffffff]
[    0.000000]   node   0: [mem 0x0000000100000000-0x000000013e5fffff]
[    0.000000] Initmem setup node 0 [mem 
0x0000000000001000-0x000000013e5fffff]
[    0.000000] On node 0, zone DMA: 1 pages in unavailable ranges
[    0.000000] On node 0, zone DMA: 102 pages in unavailable ranges
[    0.000000] On node 0, zone DMA32: 512 pages in unavailable ranges
[    0.000000] On node 0, zone DMA32: 512 pages in unavailable ranges
[    0.000000] On node 0, zone DMA32: 325 pages in unavailable ranges
[    0.000000] On node 0, zone DMA32: 263 pages in unavailable ranges
[    0.000000] On node 0, zone DMA32: 677 pages in unavailable ranges
[    0.000000] On node 0, zone Normal: 12288 pages in unavailable ranges
[    0.000000] On node 0, zone Normal: 6656 pages in unavailable ranges
[    0.000000] Reserving Intel graphics memory at [mem 
0xbda00000-0xbf9fffff]
[    0.000000] ACPI: PM-Timer IO Port: 0x408
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xff] high edge lint[0x1])
[    0.000000] IOAPIC[0]: apic_id 0, version 32, address 0xfec00000, GSI 
0-23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] ACPI: Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: HPET id: 0x8086a701 base: 0xfed00000
[    0.000000] TSC deadline timer available
[    0.000000] smpboot: Allowing 4 CPUs, 0 hotplug CPUs
[    0.000000] PM: hibernation: Registered nosave memory: [mem 
0x00000000-0x00000fff]
[    0.000000] PM: hibernation: Registered nosave memory: [mem 
0x0009a000-0x0009afff]
[    0.000000] PM: hibernation: Registered nosave memory: [mem 
0x0009b000-0x0009ffff]
[    0.000000] PM: hibernation: Registered nosave memory: [mem 
0x000a0000-0x000dffff]
[    0.000000] PM: hibernation: Registered nosave memory: [mem 
0x000e0000-0x000fffff]
[    0.000000] PM: hibernation: Registered nosave memory: [mem 
0x20000000-0x201fffff]
[    0.000000] PM: hibernation: Registered nosave memory: [mem 
0x40000000-0x401fffff]
[    0.000000] PM: hibernation: Registered nosave memory: [mem 
0xbc98e000-0xbc9d8fff]
[    0.000000] PM: hibernation: Registered nosave memory: [mem 
0xbc9d9000-0xbc9e0fff]
[    0.000000] PM: hibernation: Registered nosave memory: [mem 
0xbc9e1000-0xbcad2fff]
[    0.000000] PM: hibernation: Registered nosave memory: [mem 
0xbcad5000-0xbcbdbfff]
[    0.000000] PM: hibernation: Registered nosave memory: [mem 
0xbcbdd000-0xbcbecfff]
[    0.000000] PM: hibernation: Registered nosave memory: [mem 
0xbcbed000-0xbcbfafff]
[    0.000000] PM: hibernation: Registered nosave memory: [mem 
0xbcbfb000-0xbcc1efff]
[    0.000000] PM: hibernation: Registered nosave memory: [mem 
0xbcc1f000-0xbcc61fff]
[    0.000000] PM: hibernation: Registered nosave memory: [mem 
0xbcc62000-0xbce81fff]
[    0.000000] PM: hibernation: Registered nosave memory: [mem 
0xbd000000-0xbd7fffff]
[    0.000000] PM: hibernation: Registered nosave memory: [mem 
0xbd800000-0xbf9fffff]
[    0.000000] PM: hibernation: Registered nosave memory: [mem 
0xbfa00000-0xfed1bfff]
[    0.000000] PM: hibernation: Registered nosave memory: [mem 
0xfed1c000-0xfed1ffff]
[    0.000000] PM: hibernation: Registered nosave memory: [mem 
0xfed20000-0xfeffffff]
[    0.000000] PM: hibernation: Registered nosave memory: [mem 
0xff000000-0xffffffff]
[    0.000000] [mem 0xbfa00000-0xfed1bfff] available for PCI devices
[    0.000000] Booting paravirtualized kernel on bare hardware
[    0.000000] clocksource: refined-jiffies: mask: 0xffffffff 
max_cycles: 0xffffffff, max_idle_ns: 7645519600211568 ns
[    0.000000] setup_percpu: NR_CPUS:8192 nr_cpumask_bits:4 nr_cpu_ids:4 
nr_node_ids:1
[    0.000000] percpu: Embedded 61 pages/cpu s212992 r8192 d28672 u524288
[    0.000000] pcpu-alloc: s212992 r8192 d28672 u524288 alloc=1*2097152
[    0.000000] pcpu-alloc: [0] 0 1 2 3
[    0.000000] Fallback order for Node 0: 0
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 
1011034
[    0.000000] Policy zone: Normal
[    0.000000] Kernel command line: BOOT_IMAGE=/boot/vmlinuz-5.16.0-rc1+ 
root=UUID=1237a243-bb81-47f8-857d-50bc9ada5b90 ro quiet splash vt.handoff=1
[    0.000000] Unknown kernel command line parameters "splash 
BOOT_IMAGE=/boot/vmlinuz-5.16.0-rc1+", will be passed to user space.
[    0.000000] Dentry cache hash table entries: 524288 (order: 10, 
4194304 bytes, linear)
[    0.000000] Inode-cache hash table entries: 262144 (order: 9, 2097152 
bytes, linear)
[    0.000000] mem auto-init: stack:off, heap alloc:on, heap free:off
[    0.000000] Memory: 3889572K/4108960K available (16393K kernel code, 
3525K rwdata, 5424K rodata, 2680K init, 5936K bss, 219128K reserved, 0K 
cma-reserved)
[    0.000000] random: get_random_u64 called from 
__kmem_cache_create+0x2d/0x480 with crng_init=0
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
[    0.000000] Kernel/User page tables isolation: enabled
[    0.000000] ftrace: allocating 48411 entries in 190 pages
[    0.000000] ftrace: allocated 190 pages with 6 groups
[    0.000000] Dynamic Preempt: full
[    0.000000] rcu: Preemptible hierarchical RCU implementation.
[    0.000000] rcu: 	RCU restricting CPUs from NR_CPUS=8192 to nr_cpu_ids=4.
[    0.000000] 	Trampoline variant of Tasks RCU enabled.
[    0.000000] 	Rude variant of Tasks RCU enabled.
[    0.000000] 	Tracing variant of Tasks RCU enabled.
[    0.000000] rcu: RCU calculated value of scheduler-enlistment delay 
is 25 jiffies.
[    0.000000] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=4
[    0.000000] NR_IRQS: 524544, nr_irqs: 456, preallocated irqs: 16
[    0.000000] Console: colour dummy device 80x25
[    0.000000] printk: console [tty0] enabled
[    0.000000] ACPI: Core revision 20210930
[    0.000000] clocksource: hpet: mask: 0xffffffff max_cycles: 
0xffffffff, max_idle_ns: 133484882848 ns
[    0.000000] APIC: Switch to symmetric I/O mode setup
[    0.000000] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.024000] tsc: PIT calibration matches HPET. 1 loops
[    0.024000] tsc: Detected 2800.620 MHz processor
[    0.000006] clocksource: tsc-early: mask: 0xffffffffffffffff 
max_cycles: 0x285e8ad1684, max_idle_ns: 440795345134 ns
[    0.000014] Calibrating delay loop (skipped), value calculated using 
timer frequency.. 5601.24 BogoMIPS (lpj=11202480)
[    0.000019] pid_max: default: 32768 minimum: 301
[    0.000063] LSM: Security Framework initializing
[    0.000077] Yama: becoming mindful.
[    0.000113] AppArmor: AppArmor initialized
[    0.000157] Mount-cache hash table entries: 8192 (order: 4, 65536 
bytes, linear)
[    0.000170] Mountpoint-cache hash table entries: 8192 (order: 4, 
65536 bytes, linear)
[    0.000578] CPU0: Thermal monitoring enabled (TM1)
[    0.000611] process: using mwait in idle threads
[    0.000615] Last level iTLB entries: 4KB 512, 2MB 8, 4MB 8
[    0.000617] Last level dTLB entries: 4KB 512, 2MB 32, 4MB 32, 1GB 0
[    0.000624] Spectre V1 : Mitigation: usercopy/swapgs barriers and 
__user pointer sanitization
[    0.000627] Spectre V2 : Mitigation: Full generic retpoline
[    0.000628] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling 
RSB on context switch
[    0.000629] Spectre V2 : Enabling Restricted Speculation for firmware 
calls
[    0.000632] Spectre V2 : mitigation: Enabling conditional Indirect 
Branch Prediction Barrier
[    0.000634] Speculative Store Bypass: Mitigation: Speculative Store 
Bypass disabled via prctl
[    0.000639] MDS: Mitigation: Clear CPU buffers
[    0.006944] Freeing SMP alternatives memory: 40K
[    0.007385] smpboot: Estimated ratio of average max frequency by base 
frequency (times 1024): 1060
[    0.007397] smpboot: CPU0: Intel(R) Core(TM) i5-2300 CPU @ 2.80GHz 
(family: 0x6, model: 0x2a, stepping: 0x7)
[    0.007648] Performance Events: PEBS fmt1+, SandyBridge events, 
16-deep LBR, full-width counters, Intel PMU driver.
[    0.007675] ... version:                3
[    0.007676] ... bit width:              48
[    0.007678] ... generic registers:      8
[    0.007679] ... value mask:             0000ffffffffffff
[    0.007681] ... max period:             00007fffffffffff
[    0.007683] ... fixed-purpose events:   3
[    0.007684] ... event mask:             00000007000000ff
[    0.007931] rcu: Hierarchical SRCU implementation.
[    0.008011] NMI watchdog: Enabled. Permanently consumes one hw-PMU 
counter.
[    0.008011] smp: Bringing up secondary CPUs ...
[    0.008011] x86: Booting SMP configuration:
[    0.008011] .... node  #0, CPUs:      #1 #2 #3
[    0.018704] smp: Brought up 1 node, 4 CPUs
[    0.018704] smpboot: Max logical packages: 1
[    0.018704] smpboot: Total of 4 processors activated (22404.96 BogoMIPS)
[    0.020243] devtmpfs: initialized
[    0.020243] x86/mm: Memory block size: 128MB
[    0.020809] ACPI: PM: Registering ACPI NVS region [mem 
0xbc98e000-0xbc9d8fff] (307200 bytes)
[    0.020809] ACPI: PM: Registering ACPI NVS region [mem 
0xbcbed000-0xbcbfafff] (57344 bytes)
[    0.020809] ACPI: PM: Registering ACPI NVS region [mem 
0xbcc1f000-0xbcc61fff] (274432 bytes)
[    0.020809] clocksource: jiffies: mask: 0xffffffff max_cycles: 
0xffffffff, max_idle_ns: 7645041785100000 ns
[    0.020809] futex hash table entries: 1024 (order: 4, 65536 bytes, 
linear)
[    0.020809] pinctrl core: initialized pinctrl subsystem
[    0.020809] PM: RTC time: 14:56:55, date: 2021-11-23
[    0.020809] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.020903] DMA: preallocated 512 KiB GFP_KERNEL pool for atomic 
allocations
[    0.020965] DMA: preallocated 512 KiB GFP_KERNEL|GFP_DMA pool for 
atomic allocations
[    0.021026] DMA: preallocated 512 KiB GFP_KERNEL|GFP_DMA32 pool for 
atomic allocations
[    0.021038] audit: initializing netlink subsys (disabled)
[    0.021051] audit: type=2000 audit(1637679415.044:1): 
state=initialized audit_enabled=0 res=1
[    0.021051] thermal_sys: Registered thermal governor 'fair_share'
[    0.021051] thermal_sys: Registered thermal governor 'bang_bang'
[    0.021051] thermal_sys: Registered thermal governor 'step_wise'
[    0.021051] thermal_sys: Registered thermal governor 'user_space'
[    0.021051] EISA bus registered
[    0.021051] cpuidle: using governor ladder
[    0.021051] cpuidle: using governor menu
[    0.021051] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.021051] PCI: MMCONFIG for domain 0000 [bus 00-3f] at [mem 
0xe0000000-0xe3ffffff] (base 0xe0000000)
[    0.021051] PCI: not using MMCONFIG
[    0.021051] PCI: Using configuration type 1 for base access
[    0.021051] core: PMU erratum BJ122, BV98, HSD29 workaround disabled, 
HT off
[    0.021051] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
[    0.025820] kprobes: kprobe jump-optimization is enabled. All kprobes 
are optimized if possible.
[    0.025832] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
[    0.025832] ACPI: Added _OSI(Module Device)
[    0.025832] ACPI: Added _OSI(Processor Device)
[    0.025832] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.025832] ACPI: Added _OSI(Processor Aggregator Device)
[    0.025832] ACPI: Added _OSI(Linux-Dell-Video)
[    0.025832] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
[    0.025832] ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)
[    0.036277] ACPI: 2 ACPI AML tables successfully acquired and loaded
[    0.038335] ACPI: Dynamic OEM Table Load:
[    0.038346] ACPI: SSDT 0xFFFF98A7002D3400 00038C (v01 AMI    IST 
  00000001 MSFT 03000001)
[    0.039300] ACPI: Dynamic OEM Table Load:
[    0.039307] ACPI: SSDT 0xFFFF98A700B67CC0 000084 (v01 AMI    CST 
  00000001 MSFT 03000001)
[    0.041648] ACPI: Interpreter enabled
[    0.041675] ACPI: PM: (supports S0 S3 S4 S5)
[    0.041677] ACPI: Using IOAPIC for interrupt routing
[    0.041730] PCI: MMCONFIG for domain 0000 [bus 00-3f] at [mem 
0xe0000000-0xe3ffffff] (base 0xe0000000)
[    0.041897] PCI: MMCONFIG at [mem 0xe0000000-0xe3ffffff] reserved in 
ACPI motherboard resources
[    0.041914] PCI: Using host bridge windows from ACPI; if necessary, 
use "pci=nocrs" and report a bug
[    0.042476] ACPI: Enabled 8 GPEs in block 00 to 3F
[    0.042923] ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
[    0.056573] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.056584] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM 
ClockPM Segments MSI HPX-Type3]
[    0.056781] acpi PNP0A08:00: _OSC: platform does not support 
[SHPCHotplug LTR]
[    0.057129] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug PME 
AER PCIeCapability]
[    0.057144] acpi PNP0A08:00: [Firmware Info]: MMCONFIG for domain 
0000 [bus 00-3f] only partially covers this bridge
[    0.057830] PCI host bridge to bus 0000:00
[    0.057834] pci_bus 0000:00: root bus resource [io  0x0000-0x03af window]
[    0.057838] pci_bus 0000:00: root bus resource [io  0x03e0-0x0cf7 window]
[    0.057841] pci_bus 0000:00: root bus resource [io  0x03b0-0x03df window]
[    0.057843] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.057846] pci_bus 0000:00: root bus resource [mem 
0x000a0000-0x000dffff window]
[    0.057849] pci_bus 0000:00: root bus resource [mem 
0xbfa00000-0xffffffff window]
[    0.057852] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.057875] pci 0000:00:00.0: [8086:0100] type 00 class 0x060000
[    0.057983] pci 0000:00:01.0: [8086:0101] type 01 class 0x060400
[    0.058043] pci 0000:00:01.0: PME# supported from D0 D3hot D3cold
[    0.058188] pci 0000:00:02.0: [8086:0102] type 00 class 0x030000
[    0.058202] pci 0000:00:02.0: reg 0x10: [mem 0xfe000000-0xfe3fffff 64bit]
[    0.058212] pci 0000:00:02.0: reg 0x18: [mem 0xd0000000-0xdfffffff 
64bit pref]
[    0.058219] pci 0000:00:02.0: reg 0x20: [io  0xf000-0xf03f]
[    0.058452] pci 0000:00:16.0: [8086:1c3a] type 00 class 0x078000
[    0.058515] pci 0000:00:16.0: reg 0x10: [mem 0xfe529000-0xfe52900f 64bit]
[    0.058742] pci 0000:00:16.0: PME# supported from D0 D3hot D3cold
[    0.058903] pci 0000:00:19.0: [8086:1503] type 00 class 0x020000
[    0.058946] pci 0000:00:19.0: reg 0x10: [mem 0xfe500000-0xfe51ffff]
[    0.058970] pci 0000:00:19.0: reg 0x14: [mem 0xfe528000-0xfe528fff]
[    0.058994] pci 0000:00:19.0: reg 0x18: [io  0xf080-0xf09f]
[    0.059193] pci 0000:00:19.0: PME# supported from D0 D3hot D3cold
[    0.059372] pci 0000:00:1a.0: [8086:1c2d] type 00 class 0x0c0320
[    0.059419] pci 0000:00:1a.0: reg 0x10: [mem 0xfe527000-0xfe5273ff]
[    0.059668] pci 0000:00:1a.0: PME# supported from D0 D3hot D3cold
[    0.059866] pci 0000:00:1b.0: [8086:1c20] type 00 class 0x040300
[    0.059921] pci 0000:00:1b.0: reg 0x10: [mem 0xfe520000-0xfe523fff 64bit]
[    0.060197] pci 0000:00:1b.0: PME# supported from D0 D3hot D3cold
[    0.060379] pci 0000:00:1d.0: [8086:1c26] type 00 class 0x0c0320
[    0.060430] pci 0000:00:1d.0: reg 0x10: [mem 0xfe526000-0xfe5263ff]
[    0.060695] pci 0000:00:1d.0: PME# supported from D0 D3hot D3cold
[    0.060869] pci 0000:00:1e.0: [8086:244e] type 01 class 0x060401
[    0.061213] pci 0000:00:1f.0: [8086:1c50] type 00 class 0x060100
[    0.061648] pci 0000:00:1f.2: [8086:1c02] type 00 class 0x010601
[    0.061698] pci 0000:00:1f.2: reg 0x10: [io  0xf0d0-0xf0d7]
[    0.061727] pci 0000:00:1f.2: reg 0x14: [io  0xf0c0-0xf0c3]
[    0.061752] pci 0000:00:1f.2: reg 0x18: [io  0xf0b0-0xf0b7]
[    0.061781] pci 0000:00:1f.2: reg 0x1c: [io  0xf0a0-0xf0a3]
[    0.061809] pci 0000:00:1f.2: reg 0x20: [io  0xf060-0xf07f]
[    0.061837] pci 0000:00:1f.2: reg 0x24: [mem 0xfe525000-0xfe5257ff]
[    0.061993] pci 0000:00:1f.2: PME# supported from D3hot
[    0.062158] pci 0000:00:1f.3: [8086:1c22] type 00 class 0x0c0500
[    0.062222] pci 0000:00:1f.3: reg 0x10: [mem 0xfe524000-0xfe5240ff 64bit]
[    0.062293] pci 0000:00:1f.3: reg 0x20: [io  0xf040-0xf05f]
[    0.062531] pci 0000:01:00.0: [494f:10dc] type 00 class 0x070002
[    0.062551] pci 0000:01:00.0: reg 0x10: [io  0xe000-0xe03f]
[    0.062562] pci 0000:01:00.0: reg 0x14: [mem 0xfe400000-0xfe400fff]
[    0.062670] pci 0000:01:00.0: supports D1 D2
[    0.062673] pci 0000:01:00.0: PME# supported from D3hot
[    0.072035] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.072040] pci 0000:00:01.0:   bridge window [io  0xe000-0xefff]
[    0.072044] pci 0000:00:01.0:   bridge window [mem 0xfe400000-0xfe4fffff]
[    0.072108] pci_bus 0000:02: extended config space not accessible
[    0.072244] pci 0000:00:1e.0: PCI bridge to [bus 02] (subtractive decode)
[    0.072275] pci 0000:00:1e.0:   bridge window [io  0x0000-0x03af 
window] (subtractive decode)
[    0.072278] pci 0000:00:1e.0:   bridge window [io  0x03e0-0x0cf7 
window] (subtractive decode)
[    0.072280] pci 0000:00:1e.0:   bridge window [io  0x03b0-0x03df 
window] (subtractive decode)
[    0.072283] pci 0000:00:1e.0:   bridge window [io  0x0d00-0xffff 
window] (subtractive decode)
[    0.072286] pci 0000:00:1e.0:   bridge window [mem 
0x000a0000-0x000dffff window] (subtractive decode)
[    0.072289] pci 0000:00:1e.0:   bridge window [mem 
0xbfa00000-0xffffffff window] (subtractive decode)
[    0.073715] ACPI: PCI: Interrupt link LNKA configured for IRQ 11
[    0.073842] ACPI: PCI: Interrupt link LNKB configured for IRQ 0
[    0.073965] ACPI: PCI: Interrupt link LNKC configured for IRQ 10
[    0.074087] ACPI: PCI: Interrupt link LNKD configured for IRQ 11
[    0.074209] ACPI: PCI: Interrupt link LNKE configured for IRQ 10
[    0.074335] ACPI: PCI: Interrupt link LNKF configured for IRQ 0
[    0.074456] ACPI: PCI: Interrupt link LNKG configured for IRQ 5
[    0.074577] ACPI: PCI: Interrupt link LNKH configured for IRQ 3
[    0.074794] iommu: Default domain type: Translated
[    0.074794] iommu: DMA domain TLB invalidation policy: lazy mode
[    0.074794] pci 0000:00:02.0: vgaarb: setting as boot VGA device
[    0.074794] pci 0000:00:02.0: vgaarb: VGA device added: 
decodes=io+mem,owns=io+mem,locks=none
[    0.074794] pci 0000:00:02.0: vgaarb: bridge control possible
[    0.074794] vgaarb: loaded
[    0.074794] SCSI subsystem initialized
[    0.074794] libata version 3.00 loaded.
[    0.074794] ACPI: bus type USB registered
[    0.074794] usbcore: registered new interface driver usbfs
[    0.074794] usbcore: registered new interface driver hub
[    0.074794] usbcore: registered new device driver usb
[    0.074794] pps_core: LinuxPPS API ver. 1 registered
[    0.074794] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 
Rodolfo Giometti <giometti@linux.it>
[    0.074794] PTP clock support registered
[    0.074794] EDAC MC: Ver: 3.0.0
[    0.074794] NetLabel: Initializing
[    0.074794] NetLabel:  domain hash size = 128
[    0.074794] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
[    0.074794] NetLabel:  unlabeled traffic allowed by default
[    0.076014] PCI: Using ACPI for IRQ routing
[    0.082585] PCI: pci_cache_line_size set to 64 bytes
[    0.082669] e820: reserve RAM buffer [mem 0x0009ac00-0x0009ffff]
[    0.082672] e820: reserve RAM buffer [mem 0xbc98e000-0xbfffffff]
[    0.082676] e820: reserve RAM buffer [mem 0xbcad5000-0xbfffffff]
[    0.082680] e820: reserve RAM buffer [mem 0xbcbdd000-0xbfffffff]
[    0.082683] e820: reserve RAM buffer [mem 0xbd000000-0xbfffffff]
[    0.082685] e820: reserve RAM buffer [mem 0x13e600000-0x13fffffff]
[    0.084307] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0, 0, 0, 0, 0
[    0.084324] hpet0: 8 comparators, 64-bit 14.318180 MHz counter
[    0.086393] clocksource: Switched to clocksource tsc-early
[    0.101517] VFS: Disk quotas dquot_6.6.0
[    0.101545] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 
bytes)
[    0.101731] AppArmor: AppArmor Filesystem Enabled
[    0.101772] pnp: PnP ACPI init
[    0.102043] system 00:00: [mem 0xfed10000-0xfed19fff] has been reserved
[    0.102049] system 00:00: [mem 0xe0000000-0xe3ffffff] has been reserved
[    0.102053] system 00:00: [mem 0xfed90000-0xfed93fff] has been reserved
[    0.102056] system 00:00: [mem 0xfed20000-0xfed3ffff] has been reserved
[    0.102059] system 00:00: [mem 0xfee00000-0xfee0ffff] has been reserved
[    0.102391] system 00:01: [io  0x0290-0x029f] has been reserved
[    0.103016] system 00:03: [io  0x04d0-0x04d1] has been reserved
[    0.103429] pnp 00:04: [dma 0 disabled]
[    0.104126] system 00:05: [io  0x0400-0x0453] has been reserved
[    0.104131] system 00:05: [io  0x0458-0x047f] has been reserved
[    0.104134] system 00:05: [io  0x1180-0x119f] has been reserved
[    0.104137] system 00:05: [io  0x0500-0x057f] has been reserved
[    0.104141] system 00:05: [mem 0xfed1c000-0xfed1ffff] has been reserved
[    0.104145] system 00:05: [mem 0xfec00000-0xfecfffff] could not be 
reserved
[    0.104148] system 00:05: [mem 0xfed08000-0xfed08fff] has been reserved
[    0.104151] system 00:05: [mem 0xff000000-0xffffffff] has been reserved
[    0.104284] system 00:06: [io  0x0454-0x0457] has been reserved
[    0.104731] pnp: PnP ACPI: found 7 devices
[    0.111570] clocksource: acpi_pm: mask: 0xffffff max_cycles: 
0xffffff, max_idle_ns: 2085701024 ns
[    0.111670] NET: Registered PF_INET protocol family
[    0.111767] IP idents hash table entries: 65536 (order: 7, 524288 
bytes, linear)
[    0.113080] tcp_listen_portaddr_hash hash table entries: 2048 (order: 
3, 32768 bytes, linear)
[    0.113125] TCP established hash table entries: 32768 (order: 6, 
262144 bytes, linear)
[    0.113257] TCP bind hash table entries: 32768 (order: 7, 524288 
bytes, linear)
[    0.113343] TCP: Hash tables configured (established 32768 bind 32768)
[    0.113395] UDP hash table entries: 2048 (order: 4, 65536 bytes, linear)
[    0.113422] UDP-Lite hash table entries: 2048 (order: 4, 65536 bytes, 
linear)
[    0.113495] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    0.113506] NET: Registered PF_XDP protocol family
[    0.113519] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.113525] pci 0000:00:01.0:   bridge window [io  0xe000-0xefff]
[    0.113530] pci 0000:00:01.0:   bridge window [mem 0xfe400000-0xfe4fffff]
[    0.113538] pci 0000:00:1e.0: PCI bridge to [bus 02]
[    0.113574] pci_bus 0000:00: resource 4 [io  0x0000-0x03af window]
[    0.113577] pci_bus 0000:00: resource 5 [io  0x03e0-0x0cf7 window]
[    0.113580] pci_bus 0000:00: resource 6 [io  0x03b0-0x03df window]
[    0.113583] pci_bus 0000:00: resource 7 [io  0x0d00-0xffff window]
[    0.113586] pci_bus 0000:00: resource 8 [mem 0x000a0000-0x000dffff 
window]
[    0.113588] pci_bus 0000:00: resource 9 [mem 0xbfa00000-0xffffffff 
window]
[    0.113592] pci_bus 0000:01: resource 0 [io  0xe000-0xefff]
[    0.113594] pci_bus 0000:01: resource 1 [mem 0xfe400000-0xfe4fffff]
[    0.113597] pci_bus 0000:02: resource 4 [io  0x0000-0x03af window]
[    0.113600] pci_bus 0000:02: resource 5 [io  0x03e0-0x0cf7 window]
[    0.113603] pci_bus 0000:02: resource 6 [io  0x03b0-0x03df window]
[    0.113605] pci_bus 0000:02: resource 7 [io  0x0d00-0xffff window]
[    0.113608] pci_bus 0000:02: resource 8 [mem 0x000a0000-0x000dffff 
window]
[    0.113611] pci_bus 0000:02: resource 9 [mem 0xbfa00000-0xffffffff 
window]
[    0.113736] pci 0000:00:02.0: BIOS left Intel GPU interrupts enabled; 
disabling
[    0.113746] pci 0000:00:02.0: Video device with shadowed ROM at [mem 
0x000c0000-0x000dffff]
[    0.244147] pci 0000:00:1a.0: quirk_usb_early_handoff+0x0/0x640 took 
127326 usecs
[    0.376132] pci 0000:00:1d.0: quirk_usb_early_handoff+0x0/0x640 took 
128865 usecs
[    0.376172] PCI: CLS 64 bytes, default 64
[    0.376182] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    0.376184] software IO TLB: mapped [mem 
0x00000000b898e000-0x00000000bc98e000] (64MB)
[    0.376259] Trying to unpack rootfs image as initramfs...
[    0.377008] Initialise system trusted keyrings
[    0.377023] Key type blacklist registered
[    0.377078] workingset: timestamp_bits=36 max_order=20 bucket_order=0
[    0.379422] zbud: loaded
[    0.379893] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[    0.380170] fuse: init (API version 7.35)
[    0.380438] integrity: Platform Keyring initialized
[    0.398198] Key type asymmetric registered
[    0.398201] Asymmetric key parser 'x509' registered
[    0.398248] Block layer SCSI generic (bsg) driver version 0.4 loaded 
(major 245)
[    0.398300] io scheduler mq-deadline registered
[    0.398844] pcieport 0000:00:01.0: PME: Signaling with IRQ 24
[    0.398968] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[    0.399546] input: Power Button as 
/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input0
[    0.399585] ACPI: button: Power Button [PWRB]
[    0.399644] input: Power Button as 
/devices/LNXSYSTM:00/LNXPWRBN:00/input/input1
[    0.399702] ACPI: button: Power Button [PWRF]
[    0.401961] Linux agpgart interface v0.103
[    0.404610] loop: module loaded
[    0.404995] libphy: Fixed MDIO Bus: probed
[    0.404998] tun: Universal TUN/TAP device driver, 1.6
[    0.405061] PPP generic driver version 2.4.2
[    0.405176] VFIO - User Level meta-driver version: 0.3
[    0.405329] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    0.405340] ehci-pci: EHCI PCI platform driver
[    0.405527] ehci-pci 0000:00:1a.0: EHCI Host Controller
[    0.405538] ehci-pci 0000:00:1a.0: new USB bus registered, assigned 
bus number 1
[    0.405568] ehci-pci 0000:00:1a.0: debug port 2
[    0.409515] ehci-pci 0000:00:1a.0: irq 16, io mem 0xfe527000
[    0.424051] ehci-pci 0000:00:1a.0: USB 2.0 started, EHCI 1.00
[    0.424145] usb usb1: New USB device found, idVendor=1d6b, 
idProduct=0002, bcdDevice= 5.16
[    0.424150] usb usb1: New USB device strings: Mfr=3, Product=2, 
SerialNumber=1
[    0.424154] usb usb1: Product: EHCI Host Controller
[    0.424156] usb usb1: Manufacturer: Linux 5.16.0-rc1+ ehci_hcd
[    0.424159] usb usb1: SerialNumber: 0000:00:1a.0
[    0.424441] hub 1-0:1.0: USB hub found
[    0.424457] hub 1-0:1.0: 2 ports detected
[    0.424871] ehci-pci 0000:00:1d.0: EHCI Host Controller
[    0.424883] ehci-pci 0000:00:1d.0: new USB bus registered, assigned 
bus number 2
[    0.424913] ehci-pci 0000:00:1d.0: debug port 2
[    0.428891] ehci-pci 0000:00:1d.0: irq 23, io mem 0xfe526000
[    0.444045] ehci-pci 0000:00:1d.0: USB 2.0 started, EHCI 1.00
[    0.444160] usb usb2: New USB device found, idVendor=1d6b, 
idProduct=0002, bcdDevice= 5.16
[    0.444166] usb usb2: New USB device strings: Mfr=3, Product=2, 
SerialNumber=1
[    0.444169] usb usb2: Product: EHCI Host Controller
[    0.444171] usb usb2: Manufacturer: Linux 5.16.0-rc1+ ehci_hcd
[    0.444174] usb usb2: SerialNumber: 0000:00:1d.0
[    0.444455] hub 2-0:1.0: USB hub found
[    0.444471] hub 2-0:1.0: 2 ports detected
[    0.444712] ehci-platform: EHCI generic platform driver
[    0.444730] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    0.444738] ohci-pci: OHCI PCI platform driver
[    0.444753] ohci-platform: OHCI generic platform driver
[    0.444763] uhci_hcd: USB Universal Host Controller Interface driver
[    0.444845] i8042: PNP: No PS/2 controller found.
[    0.444847] i8042: Probing ports directly.
[    0.448201] serio: i8042 KBD port at 0x60,0x64 irq 1
[    0.448264] serio: i8042 AUX port at 0x60,0x64 irq 12
[    0.448574] mousedev: PS/2 mouse device common for all mice
[    0.449039] rtc_cmos 00:02: RTC can wake from S4
[    0.449597] rtc_cmos 00:02: registered as rtc0
[    0.449690] rtc_cmos 00:02: setting system clock to 
2021-11-23T14:56:55 UTC (1637679415)
[    0.449717] rtc_cmos 00:02: alarms up to one month, y3k, 114 bytes 
nvram, hpet irqs
[    0.449733] i2c_dev: i2c /dev entries driver
[    0.449910] device-mapper: core: CONFIG_IMA_DISABLE_HTABLE is 
disabled. Duplicate IMA measurements will not be recorded in the IMA log.
[    0.449954] device-mapper: uevent: version 1.0.3
[    0.450080] device-mapper: ioctl: 4.45.0-ioctl (2021-03-22) 
initialised: dm-devel@redhat.com
[    0.450111] platform eisa.0: Probing EISA bus 0
[    0.450115] platform eisa.0: EISA: Cannot allocate resource for mainboard
[    0.450118] platform eisa.0: Cannot allocate resource for EISA slot 1
[    0.450120] platform eisa.0: Cannot allocate resource for EISA slot 2
[    0.450123] platform eisa.0: Cannot allocate resource for EISA slot 3
[    0.450125] platform eisa.0: Cannot allocate resource for EISA slot 4
[    0.450127] platform eisa.0: Cannot allocate resource for EISA slot 5
[    0.450129] platform eisa.0: Cannot allocate resource for EISA slot 6
[    0.450132] platform eisa.0: Cannot allocate resource for EISA slot 7
[    0.450134] platform eisa.0: Cannot allocate resource for EISA slot 8
[    0.450136] platform eisa.0: EISA: Detected 0 cards
[    0.450143] intel_pstate: Intel P-state driver initializing
[    0.450484] ledtrig-cpu: registered to indicate activity on CPUs
[    0.450514] vesafb: mode is 640x480x32, linelength=2560, pages=0
[    0.450516] vesafb: scrolling: redraw
[    0.450516] vesafb: Truecolor: size=8:8:8:8, shift=24:16:8:0
[    0.450529] vesafb: framebuffer at 0xd0000000, mapped to 
0x(____ptrval____), using 1216k, total 1216k
[    0.450563] fbcon: Deferring console take-over
[    0.450564] fb0: VESA VGA frame buffer device
[    0.450605] drop_monitor: Initializing network drop monitor service
[    0.450747] NET: Registered PF_INET6 protocol family
[    0.680040] usb 1-1: new high-speed USB device number 2 using ehci-pci
[    0.700040] usb 2-1: new high-speed USB device number 2 using ehci-pci
[    0.836379] usb 1-1: New USB device found, idVendor=8087, 
idProduct=0024, bcdDevice= 0.00
[    0.836385] usb 1-1: New USB device strings: Mfr=0, Product=0, 
SerialNumber=0
[    0.836662] hub 1-1:1.0: USB hub found
[    0.836719] hub 1-1:1.0: 6 ports detected
[    0.856395] usb 2-1: New USB device found, idVendor=8087, 
idProduct=0024, bcdDevice= 0.00
[    0.856401] usb 2-1: New USB device strings: Mfr=0, Product=0, 
SerialNumber=0
[    0.856650] hub 2-1:1.0: USB hub found
[    0.856743] hub 2-1:1.0: 6 ports detected
[    0.932922] Freeing initrd memory: 42400K
[    0.937333] Segment Routing with IPv6
[    0.937350] In-situ OAM (IOAM) with IPv6
[    0.937377] NET: Registered PF_PACKET protocol family
[    0.937448] Key type dns_resolver registered
[    0.937844] microcode: sig=0x206a7, pf=0x2, revision=0x2f
[    0.937931] microcode: Microcode Update Driver: v2.2.
[    0.937936] IPI shorthand broadcast: enabled
[    0.937947] sched_clock: Marking stable (961915720, 
-23988345)->(944920686, -6993311)
[    0.938156] registered taskstats version 1
[    0.938277] Loading compiled-in X.509 certificates
[    0.939142] Loaded X.509 cert 'Build time autogenerated kernel key: 
9da99cac0f9af016fbf48ae3fb417491bf6ed6fa'
[    0.939290] zswap: loaded using pool lzo/zbud
[    0.939575] Key type ._fscrypt registered
[    0.939577] Key type .fscrypt registered
[    0.939578] Key type fscrypt-provisioning registered
[    0.941574] Key type encrypted registered
[    0.941578] AppArmor: AppArmor sha1 policy hashing enabled
[    0.941583] ima: No TPM chip found, activating TPM-bypass!
[    0.941587] Loading compiled-in module X.509 certificates
[    0.942348] Loaded X.509 cert 'Build time autogenerated kernel key: 
9da99cac0f9af016fbf48ae3fb417491bf6ed6fa'
[    0.942351] ima: Allocated hash algorithm: sha1
[    0.942360] ima: No architecture policies found
[    0.942370] evm: Initialising EVM extended attributes:
[    0.942370] evm: security.selinux
[    0.942371] evm: security.SMACK64
[    0.942372] evm: security.SMACK64EXEC
[    0.942373] evm: security.SMACK64TRANSMUTE
[    0.942374] evm: security.SMACK64MMAP
[    0.942375] evm: security.apparmor
[    0.942375] evm: security.ima
[    0.942376] evm: security.capability
[    0.942377] evm: HMAC attrs: 0x1
[    0.943484] PM:   Magic number: 13:136:941
[    0.943620] RAS: Correctable Errors collector initialized.
[    0.944888] Freeing unused decrypted memory: 2036K
[    0.945184] Freeing unused kernel image (initmem) memory: 2680K
[    0.964148] Write protecting the kernel read-only data: 24576k
[    0.964750] Freeing unused kernel image (text/rodata gap) memory: 2036K
[    0.964996] Freeing unused kernel image (rodata/data gap) memory: 720K
[    1.011178] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    1.011180] x86/mm: Checking user space page tables
[    1.055579] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    1.055584] Run /init as init process
[    1.055586]   with arguments:
[    1.055587]     /init
[    1.055588]     splash
[    1.055589]   with environment:
[    1.055590]     HOME=/
[    1.055590]     TERM=linux
[    1.055591]     BOOT_IMAGE=/boot/vmlinuz-5.16.0-rc1+
[    1.130292] e1000e: Intel(R) PRO/1000 Network Driver
[    1.130295] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[    1.130535] e1000e 0000:00:19.0: Interrupt Throttling Rate (ints/sec) 
set to dynamic conservative mode
[    1.144027] usb 2-1.4: new high-speed USB device number 3 using ehci-pci
[    1.168609] ahci 0000:00:1f.2: version 3.0
[    1.180219] ahci 0000:00:1f.2: AHCI 0001.0300 32 slots 6 ports 6 Gbps 
0x31 impl SATA mode
[    1.180224] ahci 0000:00:1f.2: flags: 64bit ncq sntf pm led clo pio 
slum part ems sxs apst
[    1.208692] scsi host0: ahci
[    1.208978] scsi host1: ahci
[    1.209150] scsi host2: ahci
[    1.209345] scsi host3: ahci
[    1.209467] scsi host4: ahci
[    1.209724] scsi host5: ahci
[    1.209767] ata1: SATA max UDMA/133 abar m2048@0xfe525000 port 
0xfe525100 irq 26
[    1.209770] ata2: DUMMY
[    1.209771] ata3: DUMMY
[    1.209772] ata4: DUMMY
[    1.209776] ata5: SATA max UDMA/133 abar m2048@0xfe525000 port 
0xfe525300 irq 26
[    1.209780] ata6: SATA max UDMA/133 abar m2048@0xfe525000 port 
0xfe525380 irq 26
[    1.231983] e1000e 0000:00:19.0 0000:00:19.0 (uninitialized): 
registered PHC clock
[    1.256025] tsc: Refined TSC clocksource calibration: 2800.027 MHz
[    1.256032] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 
0x285c5a560aa, max_idle_ns: 440795284040 ns
[    1.256046] clocksource: Switched to clocksource tsc
[    1.260790] usb 2-1.4: New USB device found, idVendor=1605, 
idProduct=f001, bcdDevice=94.15
[    1.260794] usb 2-1.4: New USB device strings: Mfr=1, Product=2, 
SerialNumber=3
[    1.260796] usb 2-1.4: Product: USB-104-HUB
[    1.260797] usb 2-1.4: Manufacturer: ACCES I/O Products, Inc.
[    1.260799] usb 2-1.4: SerialNumber: 0000209C6DB7
[    1.261080] hub 2-1.4:1.0: USB hub found
[    1.261169] hub 2-1.4:1.0: 4 ports detected
[    1.310513] e1000e 0000:00:19.0 eth0: (PCI Express:2.5GT/s:Width x1) 
00:22:4d:56:46:b5
[    1.310522] e1000e 0000:00:19.0 eth0: Intel(R) PRO/1000 Network 
Connection
[    1.310592] e1000e 0000:00:19.0 eth0: MAC: 10, PHY: 11, PBA No: 
FFFFFF-0FF
[    1.311505] e1000e 0000:00:19.0 eno1: renamed from eth0
[    1.367690] ata6: SATA link down (SStatus 0 SControl 300)
[    1.367733] ata5: SATA link down (SStatus 0 SControl 300)
[    1.367774] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    1.367949] ata1.00: ATA-11: PNY CS900 120GB SSD, CS900612, max UDMA/133
[    1.367983] ata1.00: 234441648 sectors, multi 16: LBA48 NCQ (depth 
32), AA
[    1.368293] ata1.00: configured for UDMA/133
[    1.368451] scsi 0:0:0:0: Direct-Access     ATA      PNY CS900 120GB 
  0612 PQ: 0 ANSI: 5
[    1.368672] sd 0:0:0:0: Attached scsi generic sg0 type 0
[    1.368705] sd 0:0:0:0: [sda] 234441648 512-byte logical blocks: (120 
GB/112 GiB)
[    1.368723] sd 0:0:0:0: [sda] Write Protect is off
[    1.368725] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    1.368739] sd 0:0:0:0: [sda] Write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA
[    1.407537]  sda: sda1 sda2 < sda5 >
[    1.420168] sd 0:0:0:0: [sda] Attached SCSI disk
[    1.507604] process '/bin/fstype' started with executable stack
[    1.539364] fbcon: Taking over console
[    1.539444] Console: switching to colour frame buffer device 80x30
[    1.564641] EXT4-fs (sda5): mounted filesystem with ordered data 
mode. Opts: (null). Quota mode: none.
[    1.653437] random: fast init done
[    1.875965] systemd[1]: systemd 237 running in system mode. (+PAM 
+AUDIT +SELINUX +IMA +APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP 
+GCRYPT +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD -IDN2 +IDN 
-PCRE2 default-hierarchy=hybrid)
[    1.896192] systemd[1]: Detected architecture x86-64.
[    1.918093] systemd[1]: Set hostname to <jdolan-desktop>.
[    2.266193] random: systemd: uninitialized urandom read (16 bytes read)
[    2.266409] systemd[1]: Created slice System Slice.
[    2.266458] random: systemd: uninitialized urandom read (16 bytes read)
[    2.266589] systemd[1]: Created slice User and Session Slice.
[    2.266607] random: systemd: uninitialized urandom read (16 bytes read)
[    2.266673] systemd[1]: Listening on udev Control Socket.
[    2.266692] systemd[1]: Reached target Slices.
[    2.266847] systemd[1]: Set up automount Arbitrary Executable File 
Formats File System Automount Point.
[    2.266926] systemd[1]: Listening on Journal Socket (/dev/log).
[    2.266946] systemd[1]: Reached target Remote File Systems.
[    2.442357] lp: driver loaded but no devices found
[    2.451275] ppdev: user-space parallel port driver
[    2.459763] EXT4-fs (sda5): re-mounted. Opts: errors=remount-ro. 
Quota mode: none.
[    2.485797] systemd-journald[274]: Received request to flush runtime 
journal from PID 1
[    2.486754] Adding 2097148k swap on /swapfile.  Priority:-2 extents:6 
across:2260988k SSFS
[    2.526738] loop0: detected capacity change from 0 to 8
[    2.544238] loop1: detected capacity change from 0 to 126632
[    2.544295] loop2: detected capacity change from 0 to 1912
[    2.568335] loop3: detected capacity change from 0 to 1096
[    2.596118] loop4: detected capacity change from 0 to 66440
[    2.596200] loop5: detected capacity change from 0 to 494312
[    2.596283] loop6: detected capacity change from 0 to 5088
[    2.596359] loop7: detected capacity change from 0 to 4992
[    2.616145] loop8: detected capacity change from 0 to 448512
[    2.616752] loop9: detected capacity change from 0 to 66368
[    2.633795] loop13: detected capacity change from 0 to 113536
[    2.633796] loop11: detected capacity change from 0 to 5192
[    2.634157] loop12: detected capacity change from 0 to 113656
[    2.634391] loop10: detected capacity change from 0 to 133320
[    2.634707] loop15: detected capacity change from 0 to 5192
[    2.634796] loop14: detected capacity change from 0 to 126632
[    2.634919] loop16: detected capacity change from 0 to 1408
[    2.635001] loop17: detected capacity change from 0 to 496320
[    2.635023] loop18: detected capacity change from 0 to 1408
[    2.652414] loop19: detected capacity change from 0 to 523400
[    2.660400] loop20: detected capacity change from 0 to 133552
[    2.865383] audit: type=1400 audit(1637679417.910:2): 
apparmor="STATUS" operation="profile_load" profile="unconfined" 
name="/usr/bin/man" pid=401 comm="apparmor_parser"
[    2.865831] audit: type=1400 audit(1637679417.910:3): 
apparmor="STATUS" operation="profile_load" profile="unconfined" 
name="man_filter" pid=401 comm="apparmor_parser"
[    2.865843] audit: type=1400 audit(1637679417.910:4): 
apparmor="STATUS" operation="profile_load" profile="unconfined" 
name="man_groff" pid=401 comm="apparmor_parser"
[    2.866957] audit: type=1400 audit(1637679417.910:5): 
apparmor="STATUS" operation="profile_load" profile="unconfined" 
name="libreoffice-oopslash" pid=402 comm="apparmor_parser"
[    2.871137] audit: type=1400 audit(1637679417.914:6): 
apparmor="STATUS" operation="profile_load" profile="unconfined" 
name="libreoffice-senddoc" pid=405 comm="apparmor_parser"
[    2.876970] audit: type=1400 audit(1637679417.922:7): 
apparmor="STATUS" operation="profile_load" profile="unconfined" 
name="libreoffice-xpdfimport" pid=407 comm="apparmor_parser"
[    2.878664] audit: type=1400 audit(1637679417.922:8): 
apparmor="STATUS" operation="profile_load" profile="unconfined" 
name="/sbin/dhclient" pid=398 comm="apparmor_parser"
[    2.879103] audit: type=1400 audit(1637679417.922:9): 
apparmor="STATUS" operation="profile_load" profile="unconfined" 
name="/usr/lib/NetworkManager/nm-dhcp-client.action" pid=398 
comm="apparmor_parser"
[    2.879114] audit: type=1400 audit(1637679417.922:10): 
apparmor="STATUS" operation="profile_load" profile="unconfined" 
name="/usr/lib/NetworkManager/nm-dhcp-helper" pid=398 comm="apparmor_parser"
[    2.926192] 8250_base: loading out-of-tree module taints kernel.
[    2.926226] 8250_base: module verification failed: signature and/or 
required key missing - tainting kernel
[    2.927496] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
[    2.927703] 00:04: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) 
is a 16550A
[    2.979481] 0000:01:00.0: ttyS4 at I/O 0xe000 (irq = 16, base_baud = 
921600) is a 16550A
[    2.979487] 0000:01:00.0: ttyS4 extra baud rates supported: 1843200, 
3686400
[    2.979822] 0000:01:00.0: ttyS5 at I/O 0xe008 (irq = 16, base_baud = 
921600) is a 16550A
[    2.979825] 0000:01:00.0: ttyS5 extra baud rates supported: 1843200, 
3686400
[    2.982020] 0000:01:00.0: ttyS6 at I/O 0xe010 (irq = 16, base_baud = 
921600) is a 16550A
[    2.982025] 0000:01:00.0: ttyS6 extra baud rates supported: 1843200, 
3686400
[    2.982256] 0000:01:00.0: ttyS7 at I/O 0xe038 (irq = 16, base_baud = 
921600) is a 16550A
[    2.982259] 0000:01:00.0: ttyS7 extra baud rates supported: 1843200, 
3686400
[    3.025249] ACPI: bus type drm_connector registered
[    3.077352] RAPL PMU: API unit is 2^-32 Joules, 3 fixed counters, 
163840 ms ovfl timer
[    3.077356] RAPL PMU: hw unit of domain pp0-core 2^-16 Joules
[    3.077358] RAPL PMU: hw unit of domain package 2^-16 Joules
[    3.077359] RAPL PMU: hw unit of domain pp1-gpu 2^-16 Joules
[    3.159644] cryptd: max_cpu_qlen set to 1000
[    3.182831] AVX version of gcm_enc/dec engaged.
[    3.182855] AES CTR mode by8 optimization enabled
[    3.205537] checking generic (d0000000 130000) vs hw (fe000000 400000)
[    3.205542] checking generic (d0000000 130000) vs hw (d0000000 10000000)
[    3.205543] fb0: switching to i915 from VESA VGA
[    3.228102] Console: switching to colour dummy device 80x25
[    3.229925] i915 0000:00:02.0: vgaarb: deactivate vga console
[    3.249265] [drm] Initialized i915 1.6.0 20201103 for 0000:00:02.0 on 
minor 0
[    3.261541] i915 0000:00:02.0: [drm] Cannot find any crtc or sizes
[    3.283083] snd_hda_intel 0000:00:1b.0: bound 0000:00:02.0 (ops 
i915_audio_component_bind_ops [i915])
[    3.286925] i915 0000:00:02.0: [drm] Cannot find any crtc or sizes
[    3.290206] i915 0000:00:02.0: [drm] Cannot find any crtc or sizes
[    3.316582] gpio_ich gpio_ich.2.auto: GPIO from 948 to 1023
[    3.335512] snd_hda_codec_realtek hdaudioC0D2: autoconfig for ALC888: 
line_outs=1 (0x14/0x0/0x0/0x0/0x0) type:line
[    3.335519] snd_hda_codec_realtek hdaudioC0D2:    speaker_outs=1 
(0x17/0x0/0x0/0x0/0x0)
[    3.335521] snd_hda_codec_realtek hdaudioC0D2:    hp_outs=1 
(0x1b/0x0/0x0/0x0/0x0)
[    3.335523] snd_hda_codec_realtek hdaudioC0D2:    mono: mono_out=0x0
[    3.335525] snd_hda_codec_realtek hdaudioC0D2:    dig-out=0x1e/0x0
[    3.335526] snd_hda_codec_realtek hdaudioC0D2:    inputs:
[    3.335528] snd_hda_codec_realtek hdaudioC0D2:      Front Mic=0x19
[    3.335530] snd_hda_codec_realtek hdaudioC0D2:      Rear Mic=0x18
[    3.335531] snd_hda_codec_realtek hdaudioC0D2:      Line=0x1a
[    3.355954] input: HDA Intel PCH Front Mic as 
/devices/pci0000:00/0000:00:1b.0/sound/card0/input5
[    3.356006] input: HDA Intel PCH Rear Mic as 
/devices/pci0000:00/0000:00:1b.0/sound/card0/input6
[    3.356070] input: HDA Intel PCH Line as 
/devices/pci0000:00/0000:00:1b.0/sound/card0/input7
[    3.356118] input: HDA Intel PCH Line Out as 
/devices/pci0000:00/0000:00:1b.0/sound/card0/input8
[    3.356163] input: HDA Intel PCH Front Headphone as 
/devices/pci0000:00/0000:00:1b.0/sound/card0/input9
[    3.593655] intel_rapl_common: Found RAPL domain package
[    3.593660] intel_rapl_common: Found RAPL domain core
[    3.593661] intel_rapl_common: Found RAPL domain uncore
[    3.593666] intel_rapl_common: RAPL package-0 domain package locked 
by BIOS
[    4.165346] [J4D] flag present
[    4.165902] [J4D] flag not present(adding)
[    4.166561] [J4D] flag present
[    4.167096] [J4D] flag not present(adding)
[    4.167753] [J4D] flag present
[    4.168298] [J4D] flag not present(adding)
[    4.168953] [J4D] flag present
[    4.169483] [J4D] flag not present(adding)
[    6.357984] loop21: detected capacity change from 0 to 8
[    8.296025] random: crng init done
[    8.296029] random: 7 urandom warning(s) missed due to ratelimiting
[    8.950174] e1000e 0000:00:19.0 eno1: NIC Link is Up 1000 Mbps Full 
Duplex, Flow Control: Rx/Tx
[    8.950227] IPv6: ADDRCONF(NETDEV_CHANGE): eno1: link becomes ready
[   42.730050] 8250_pericom 0000:01:00.0: VPD access failed.  This is 
likely a firmware bug on this device.  Contact the card vendor for a 
firmware update
