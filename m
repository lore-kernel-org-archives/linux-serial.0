Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 949B3C77B62
	for <linux-serial@archiver.kernel.org>; Mon,  3 Apr 2023 21:43:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232797AbjDCVn4 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 3 Apr 2023 17:43:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233433AbjDCVnz (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 3 Apr 2023 17:43:55 -0400
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8FCACA
        for <linux-serial@vger.kernel.org>; Mon,  3 Apr 2023 14:43:26 -0700 (PDT)
Received: by mail-wr1-f47.google.com with SMTP id h17so30775468wrt.8
        for <linux-serial@vger.kernel.org>; Mon, 03 Apr 2023 14:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680557866;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MrV5bCV9hknDEQhFeOhZI56Jg1ZMBo8XEJAj1jo/68E=;
        b=M4yV4yzhn+8f1tbAsS10V8jyL5AjXi4clgKIIks5GHhUOEUyPtuJb2ejQUwkHeUL5c
         TGrtUeyljrhVwwafW29zBzNC80EkGKZeqj33Il38acj0RvcjkjChbMUlYghdHly+Qymy
         mQ3WOL93Jo1TtLr24eGsm4QiGyJHxGbQGH9zlcWvpd/mHQhaIMkQB0aTC+jZV1Dp3cfh
         Tzd663IHtoxhORSldGOLxGYWJwaypQs+VMi273OPz2IPt/v5GC0VkBKCeKV2mjrQbuUR
         5CqRItQt2xTX6bbRJBwoSgf633PKugbqI2+J52kC6nHE+zZEVTjt/ZWUdWnK9NV0kpbe
         vSUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680557866;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MrV5bCV9hknDEQhFeOhZI56Jg1ZMBo8XEJAj1jo/68E=;
        b=y3pS8oWXal0VJTnVfzVJv4d9Coc3j1lnaIu6wdKdnuKQx+/HUBYEqDjz8wnLLNEN0h
         KPBur2C/3o5tTmCTT3Jlj2aZSSkvN1OeZj96hctRSeCgDJKr9ajJZ9T2dJA/46bYDYIg
         OKfexgQ36AxVN83N/rrXqOf6l022WGQnKXLOhlmnlgAq37NGNKooe+vBG5JxI0dLFYT2
         a7FzFBCsoSMRCcsvCAvd4dwdnLzsjT2zEk0xJdBbevi+KUykdFQyU0IzZpDF6DMi43jv
         iflCYBNcIRlQpEAdByuNEOVMgoyL65IT5d8O3oL7jXomH/4MvHy1TBMFq1UAMJrA9bs4
         QUPw==
X-Gm-Message-State: AAQBX9cwmhrT1O6Y9ef8BYzH8ukRHBS5qf86Oa/Zb4t5bTEjKn7UziyA
        bAB+I/tgIIiTXtyuz5H3BYDjLjEtcEc=
X-Google-Smtp-Source: AKy350Y3UgcIg24soqnnFfkMeu8iUq5+d2Bc6XW89cjHpmRj5yKNMCDZtQx8Kl6CwLMkawvMfBOl3g==
X-Received: by 2002:a5d:4fcd:0:b0:2d8:a55e:1fd7 with SMTP id h13-20020a5d4fcd000000b002d8a55e1fd7mr9702wrw.21.1680557866109;
        Mon, 03 Apr 2023 14:37:46 -0700 (PDT)
Received: from ?IPV6:2a01:cb00:41f:1800:6060:c5ff:fe0b:cbb7? (2a01cb00041f18006060c5fffe0bcbb7.ipv6.abo.wanadoo.fr. [2a01:cb00:41f:1800:6060:c5ff:fe0b:cbb7])
        by smtp.gmail.com with ESMTPSA id s16-20020adfea90000000b002d21379bcabsm10544436wrm.110.2023.04.03.14.37.45
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Apr 2023 14:37:45 -0700 (PDT)
Message-ID: <faa4f058-540f-8bd1-0ef0-0d46ba9dd20a@gmail.com>
Date:   Mon, 3 Apr 2023 23:37:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: fr-FR
To:     linux-serial@vger.kernel.org
From:   Caeies <caeies.mail@gmail.com>
Subject: [BUG/8250_pci.c] MosChip Semiconductor Technology Ltd. MCS9922 PCIe
 Multi-I/O Controller
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


Dear all,

I have a dual Asix Electronics Corporation (Wrong ID) MCS9922 PCIe 
Multi-I/O Controller card, with 2 serial ports and some GPIOs since a 
long time. I've tried different drivers & kernel from time to time, with 
the hope that the drivers will be fixed one day, but with no luck.

Long time ago, I've tried the Asix drivers, but they were always ending 
in some kernel Oops, so I gave up with them as they were rather old. So 
I go back to the mainstream serial drivers. But unfortunately they still 
don't work in my case.

I'm running a Debian 5.10.113-1 kernel but some remarks below are valid 
since 3.X linux kernel (at least).

First (new) things seems to be related to the IOMMU DMA R/W protection, 
as I've got this kind of messages in dmesg, when trying to use stty -F 
on associated tty:

DMAR: DRHD: handling fault status reg 2
DMAR: [DMA Write] Request device [03:00.0] PASID ffffffff fault addr 0 
[fault reason 05] PTE Write access is not set

Digging around, it looks like this is probably linked to the lack of 
pci_map_* calls, but I'm a total newbie with X86 PCI/DMA architecture 
and I'm probably totaly wrong.

Second is this kind of messages:
__common_interrupt: 5.33 No irq handler for vector
__common_interrupt: 6.33 No irq handler for vector

When trying to play with the cards. Ending most of the time with :

Mar 29 23:34:23 blhc kernel: [25287447.821957] irq 16: nobody cared (try 
booting with the "irqpoll" option)
Mar 29 23:34:23 blhc kernel: [25287447.821966] CPU: 0 PID: 0 Comm: 
swapper/0 Tainted: G        W  OE     5.10.0-14-amd64 #1 Debian 5.10.113-1
Mar 29 23:34:23 blhc kernel: [25287447.821968] Hardware name: ASUS All 
Series/Z97-E, BIOS XXXX XX/XX/XXXX
Mar 29 23:34:23 blhc kernel: [25287447.821969] Call Trace:
Mar 29 23:34:23 blhc kernel: [25287447.821972]  <IRQ>
Mar 29 23:34:23 blhc kernel: [25287447.821980]  dump_stack+0x6b/0x83
Mar 29 23:34:23 blhc kernel: [25287447.821984]  __report_bad_irq+0x35/0xa7
Mar 29 23:34:23 blhc kernel: [25287447.821987]  note_interrupt.cold+0xb/0x61
Mar 29 23:34:23 blhc kernel: [25287447.821992]  handle_irq_event+0xa8/0xb0
Mar 29 23:34:23 blhc kernel: [25287447.821995] 
handle_fasteoi_irq+0x78/0x1c0
Mar 29 23:34:23 blhc kernel: [25287447.822000] 
asm_call_irq_on_stack+0x12/0x20
Mar 29 23:34:23 blhc kernel: [25287447.822002]  </IRQ>
Mar 29 23:34:23 blhc kernel: [25287447.822007]  common_interrupt+0xb0/0x130
Mar 29 23:34:23 blhc kernel: [25287447.822010] 
asm_common_interrupt+0x1e/0x40
Mar 29 23:34:23 blhc kernel: [25287447.822014] RIP: 
0010:cpuidle_enter_state+0xc7/0x350
Mar 29 23:34:23 blhc kernel: [25287447.822017] Code: 8b 3d ed 17 77 77 
e8 f8 cc a1 ff 49 89 c5 0f 1f 44 00 00 31 ff e8 09 d8 a1 ff 45 84 ff 0f 
85 fa 00 00 00 fb 66 0f 1f 44 00 00 <45> 85 f6 0f 88 06 01 00 00 49 63 
c6 4c 2b 2c 24 48 8d 14 40 48 8d
Mar 29 23:34:23 blhc kernel: [25287447.822020] RSP: 
0018:ffffffff89803e70 EFLAGS: 00000246
Mar 29 23:34:23 blhc kernel: [25287447.822023] RAX: ffff889e9fe2fcc0 
RBX: 0000000000000005 RCX: 000000000000001f
Mar 29 23:34:23 blhc kernel: [25287447.822025] RDX: 0000000000000000 
RSI: 000000002000029f RDI: 0000000000000000
Mar 29 23:34:23 blhc kernel: [25287447.822026] RBP: ffff889e9fe39c00 
R08: 0059d6ccc0b42569 R09: 0059d6a819e269af
Mar 29 23:34:23 blhc kernel: [25287447.822028] R10: 0000000000000001 
R11: 0000000000000001 R12: ffffffff899ae780
Mar 29 23:34:23 blhc kernel: [25287447.822029] R13: 0059d6ccc0b42569 
R14: 0000000000000005 R15: 0000000000000000
Mar 29 23:34:23 blhc kernel: [25287447.822035]  cpuidle_enter+0x29/0x40
Mar 29 23:34:23 blhc kernel: [25287447.822040]  do_idle+0x1ef/0x2b0
Mar 29 23:34:23 blhc kernel: [25287447.822044]  cpu_startup_entry+0x19/0x20
Mar 29 23:34:23 blhc kernel: [25287447.822049]  start_kernel+0x587/0x5a8
Mar 29 23:34:23 blhc kernel: [25287447.822054] 
secondary_startup_64_no_verify+0xb0/0xbb
Mar 29 23:34:23 blhc kernel: [25287447.822057] handlers:
Mar 29 23:34:23 blhc kernel: [25287447.822076] [<00000000bd5696c1>] 
usb_hcd_irq [usbcore]
Mar 29 23:34:23 blhc kernel: [25287447.822079] Disabling IRQ #16
Mar 29 23:42:30 blhc kernel: [25287935.482980] serial 0000:03:00.0: LSR 
safety check engaged!

Of course, IRQ 16 is a shared IRQ with some USB controllers, and this is 
sometimes annoying, but (at least in last kernels) not deadfull.

I would be happy to help to fix these cases, as far as I can. I can even 
try to fix myself some little things if you can pinpoint me were to look 
at and what kind of thing is the way to go. As a bonus I would like to 
add the support to the associated GPIOs, but I'm not sure on "what would 
be the best way to do it".

Here's the current lspci -vvv (I've moved them under the vfio-pci to try 
to play with them with qmeu/kvm to avoid to hard lock my Pc):

03:00.0 Serial controller: MosChip Semiconductor Technology Ltd. MCS9922 
PCIe Multi-I/O Controller (prog-if 02 [16550])
         Subsystem: Asix Electronics Corporation (Wrong ID) MCS9922 PCIe 
Multi-I/O Controller
         Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B- DisINTx-
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx+
         Interrupt: pin A routed to IRQ 16
         IOMMU group: 13
         Region 0: I/O ports at d010 [virtual] [size=8]
         Region 1: Memory at f7803000 (32-bit, non-prefetchable) 
[virtual] [size=4K]
         Region 5: Memory at f7802000 (32-bit, non-prefetchable) 
[virtual] [size=4K]
         Capabilities: [50] MSI: Enable- Count=1/8 Maskable- 64bit+
                 Address: 0000000000000000  Data: 0000
         Capabilities: [78] Power Management version 3
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA 
PME(D0-,D1-,D2-,D3hot+,D3cold+)
                 Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
         Capabilities: [80] Express (v1) Legacy Endpoint, MSI 00
                 DevCap: MaxPayload 512 bytes, PhantFunc 0, Latency L0s 
<1us, L1 <2us
                         ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
                 DevCtl: CorrErr- NonFatalErr- FatalErr- UnsupReq-
                         RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
                         MaxPayload 128 bytes, MaxReadReq 512 bytes
                 DevSta: CorrErr+ NonFatalErr- FatalErr- UnsupReq- 
AuxPwr- TransPend-
                 LnkCap: Port #1, Speed 2.5GT/s, Width x1, ASPM L0s L1, 
Exit Latency L0s <64ns, L1 unlimited
                         ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp-
                 LnkCtl: ASPM Disabled; RCB 64 bytes, Disabled- CommClk-
                         ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                 LnkSta: Speed 2.5GT/s (ok), Width x1 (ok)
                         TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
         Capabilities: [100 v1] Virtual Channel
                 Caps:   LPEVC=0 RefClk=100ns PATEntryBits=1
                 Arb:    Fixed- WRR32- WRR64- WRR128-
                 Ctrl:   ArbSelect=Fixed
                 Status: InProgress-
                 VC0:    Caps:   PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
                         Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- 
WRR256-
                         Ctrl:   Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
                         Status: NegoPending- InProgress-
                 VC1:    Caps:   PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
                         Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- 
WRR256-
                         Ctrl:   Enable- ID=0 ArbSelect=Fixed TC/VC=00
                         Status: NegoPending- InProgress-
         Capabilities: [800 v1] Advanced Error Reporting
                 UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- 
UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                 UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- 
UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                 UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- 
UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
                 CESta:  RxErr+ BadTLP- BadDLLP- Rollover+ Timeout+ 
AdvNonFatalErr-
                 CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+
                 AERCap: First Error Pointer: 00, ECRCGenCap- ECRCGenEn- 
ECRCChkCap- ECRCChkEn-
                         MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
                 HeaderLog: 00000000 00000000 00000000 00000000
         Kernel driver in use: vfio-pci

03:00.1 Serial controller: MosChip Semiconductor Technology Ltd. MCS9922 
PCIe Multi-I/O Controller (prog-if 02 [16550])
         Subsystem: Asix Electronics Corporation (Wrong ID) MCS9922 PCIe 
Multi-I/O Controller
         Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B- DisINTx-
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
         Interrupt: pin B routed to IRQ 17
         IOMMU group: 13
         Region 0: I/O ports at d000 [virtual] [size=8]
         Region 1: Memory at f7801000 (32-bit, non-prefetchable) 
[virtual] [size=4K]
         Region 5: Memory at f7800000 (32-bit, non-prefetchable) 
[virtual] [size=4K]
         Capabilities: [50] MSI: Enable- Count=1/8 Maskable- 64bit+
                 Address: 0000000000000000  Data: 0000
         Capabilities: [78] Power Management version 3
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA 
PME(D0-,D1-,D2-,D3hot+,D3cold+)
                 Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
         Capabilities: [80] Express (v1) Legacy Endpoint, MSI 00
                 DevCap: MaxPayload 512 bytes, PhantFunc 0, Latency L0s 
<1us, L1 <2us
                         ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
                 DevCtl: CorrErr- NonFatalErr- FatalErr- UnsupReq-
                         RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
                         MaxPayload 128 bytes, MaxReadReq 512 bytes
                 DevSta: CorrErr+ NonFatalErr- FatalErr- UnsupReq- 
AuxPwr- TransPend-
                 LnkCap: Port #1, Speed 2.5GT/s, Width x1, ASPM L0s L1, 
Exit Latency L0s <64ns, L1 unlimited
                         ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp-
                 LnkCtl: ASPM Disabled; RCB 64 bytes, Disabled- CommClk-
                         ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                 LnkSta: Speed 2.5GT/s (ok), Width x1 (ok)
                         TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
         Capabilities: [100 v1] Advanced Error Reporting
                 UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- 
UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                 UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- 
UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                 UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- 
UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
                 CESta:  RxErr+ BadTLP- BadDLLP- Rollover+ Timeout+ 
AdvNonFatalErr-
                 CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+
                 AERCap: First Error Pointer: 00, ECRCGenCap- ECRCGenEn- 
ECRCChkCap- ECRCChkEn-
                         MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
                 HeaderLog: 00000000 00000000 00000000 00000000
         Kernel driver in use: vfio-pci


Please keep me in copy as I'm not (yet) a subscriber to the list.

Thanks for your help,

Best regards,

Caeies.



