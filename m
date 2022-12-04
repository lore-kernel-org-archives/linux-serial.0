Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB8F0C4321E
	for <linux-serial@archiver.kernel.org>; Sun,  4 Dec 2022 16:42:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbiLDQmf (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 4 Dec 2022 11:42:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbiLDQmf (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 4 Dec 2022 11:42:35 -0500
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E382104
        for <linux-serial@vger.kernel.org>; Sun,  4 Dec 2022 08:42:32 -0800 (PST)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-381662c78a9so96378387b3.7
        for <linux-serial@vger.kernel.org>; Sun, 04 Dec 2022 08:42:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HwkSfDUBv9Y67rCvHVzdoFQuaJzztTOha8cs+7JK3KM=;
        b=iAL6dTBTCzFj8aMyDXA0Km1RZDIoGOVRTXS1chCrJW++Zs/m+PhmjyRyotFBZ78zzV
         MSxjX6ExMa0ooXXDhAZ+LMpoDhstHSbW9sbQAzj0ehfRhMU0ROAb/En4slIQHUZctGuk
         28HdqzwTYAdixFKmR2nobNB8TT2zbCKJayb2HRTws+CK0VDYibsrpuc20usnc/noebFv
         Qj4pJl8ewaPgk943s4DyZb2wCrPc/KlMkGYruhDKuPDphw1EtP6T+yvZjymWrW7Wk5gP
         H9ZXw2zbytqbOEJJqgflNxrx+v+ZpOdp6v+/qPIjFtCz2Jqf5lBGIkaCqxf4nLHvTr4N
         sYsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HwkSfDUBv9Y67rCvHVzdoFQuaJzztTOha8cs+7JK3KM=;
        b=oOfm1wb+3q+AY/Q0hRdPetO7p4y7Rrm/ieTXmmalxOb+QVGMLX4hiCgvyeEGQlTl4T
         J2G6/kOMEUvhv+OEIfAvXL6VMTPeG7SY9a+2ViRvQ18sjp9Clr+/UYWBbnCrqLnoHNOX
         XOR8dpSG2zaqBjAxVsoRQDx9t1Jvxtr/6GshMCqW8oKcPoXyV2fLysEXvq7AWuZuBn20
         xG5b9dh7htu+NqMQEsGcg7mnBrM7X62ZaYJBccEhYBWP5bmC0YDZjeLVFvJjpuXRdlio
         wvPZFbavqFx8LUxFYQmI5ho+WKr90if/KATxpkLaDT6YujSRN6o7gh6dfAznqrDuYi6D
         erSw==
X-Gm-Message-State: ANoB5pmFCLKCybOOMGiY9yWZ4rGP7a2rd0daUAi3Uoea6YAgffW6mxyS
        E2Xjr8d7KhGeWyeRgFA1elw5MmYR/cZCHBQcOfgZyWouXveSLw==
X-Google-Smtp-Source: AA0mqf7tdgBp4NOZz7voP83K2h6qRhhL030124BpAVkHHGCkxn7hNCP3nkthu9zmy24cXDxqxxmDAK6SgSTyfyy/rBQ=
X-Received: by 2002:a81:628b:0:b0:38a:acf5:8dee with SMTP id
 w133-20020a81628b000000b0038aacf58deemr59729419ywb.161.1670172151389; Sun, 04
 Dec 2022 08:42:31 -0800 (PST)
MIME-Version: 1.0
From:   Oleksii Hryhorovych <alexcatze@gmail.com>
Date:   Sun, 4 Dec 2022 18:42:19 +0200
Message-ID: <CAB6k_g0siQ7O3LSBGAMUB0OFFn6MCAurXFohRSZaJyxjfneZ9Q@mail.gmail.com>
Subject: serial driver issue
To:     linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi. I have a problem with linux "serial" driver. I`m using a MosChip
9901 based ExpressCard 34 dual rs-232 controller. When I plugged this
card into my PC, the system detected it, but when I tried to send or
read something from one of the ports, there was silence. Loopback test
also fails. On windows this card works perfectly, so this is not a
hardware issue. My kernel version is "5.15.78-1-MANJARO".

"dmesg" output about this card:

[64329.311478] pcieport 0000:00:1c.1: pciehp: Slot(1): Card present
[64329.311485] pcieport 0000:00:1c.1: pciehp: Slot(1): Link Up
[64329.442833] pci 0000:02:00.0: [9710:9901] type 00 class 0x070002
[64329.442867] pci 0000:02:00.0: reg 0x10: [io  0x0000-0x0007]
[64329.442883] pci 0000:02:00.0: reg 0x14: [mem 0x00000000-0x00000fff]
[64329.442922] pci 0000:02:00.0: reg 0x20: [mem 0x00000000-0x00000fff]
[64329.443096] pci 0000:02:00.0: supports D1 D2
[64329.443099] pci 0000:02:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[64329.443402] pci 0000:02:00.1: [9710:9901] type 00 class 0x070002
[64329.443434] pci 0000:02:00.1: reg 0x10: [io  0x0000-0x0007]
[64329.443451] pci 0000:02:00.1: reg 0x14: [mem 0x00000000-0x00000fff]
[64329.443495] pci 0000:02:00.1: reg 0x20: [mem 0x00000000-0x00000fff]
[64329.443679] pci 0000:02:00.1: supports D1 D2
[64329.443683] pci 0000:02:00.1: PME# supported from D0 D1 D2 D3hot D3cold
[64329.443948] pci 0000:02:00.0: BAR 1: assigned [mem 0xd0000000-0xd0000fff]
[64329.443960] pci 0000:02:00.0: BAR 4: assigned [mem 0xd0001000-0xd0001fff]
[64329.443969] pci 0000:02:00.1: BAR 1: assigned [mem 0xd0002000-0xd0002fff]
[64329.443979] pci 0000:02:00.1: BAR 4: assigned [mem 0xd0003000-0xd0003fff]
[64329.443987] pci 0000:02:00.0: BAR 0: assigned [io  0x2000-0x2007]
[64329.443995] pci 0000:02:00.1: BAR 0: assigned [io  0x2008-0x200f]
[64329.444006] pcieport 0000:00:1c.1: PCI bridge to [bus 02-22]
[64329.444012] pcieport 0000:00:1c.1:   bridge window [io  0x2000-0x3fff]
[64329.444017] pcieport 0000:00:1c.1:   bridge window [mem
0xd0000000-0xd3ffffff]
[64329.444023] pcieport 0000:00:1c.1:   bridge window [mem
0xbfb00000-0xbfcfffff 64bit pref]
[64329.444110] serial 0000:02:00.0: enabling device (0000 -> 0003)
[64329.444690] 0000:02:00.0: ttyS6 at I/O 0x2000 (irq = 17, base_baud
= 115200) is a 16550A
[64329.448040] serial 0000:02:00.1: enabling device (0000 -> 0003)
[64329.452843] 0000:02:00.1: ttyS7 at I/O 0x2008 (irq = 18, base_baud
= 115200) is a 16550A

"lspci -vvv" output about this card:

02:00.0 Serial controller: MosChip Semiconductor Technology Ltd. PCIe
9901 Multi-I/O Controller (prog-if 02 [16550])
       Subsystem: Asix Electronics Corporation (Wrong ID) Device 1000
       Physical Slot: 1
       Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
       Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
       Interrupt: pin A routed to IRQ 17
       Region 0: I/O ports at 2000 [size=8]
       Region 1: Memory at d0000000 (32-bit, non-prefetchable) [size=4K]
       Region 4: Memory at d0001000 (32-bit, non-prefetchable) [size=4K]
       Capabilities: [80] Power Management version 3
               Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
               Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=1 PME-
       Capabilities: [88] MSI: Enable- Count=1/32 Maskable- 64bit+
               Address: 0000000000000000  Data: 0000
       Capabilities: [c0] Express (v1) Legacy Endpoint, MSI 00
               DevCap: MaxPayload 256 bytes, PhantFunc 0, Latency L0s
<64ns, L1 <1us
                       ExtTag- AttnBtn+ AttnInd+ PwrInd+ RBE- FLReset-
               DevCtl: CorrErr- NonFatalErr- FatalErr- UnsupReq-
                       RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
                       MaxPayload 128 bytes, MaxReadReq 512 bytes
               DevSta: CorrErr- NonFatalErr+ FatalErr- UnsupReq+
AuxPwr- TransPend-
               LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1,
Exit Latency L0s unlimited, L1 unlimited
                       ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp-
               LnkCtl: ASPM Disabled; RCB 64 bytes, Disabled- CommClk+
                       ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
               LnkSta: Speed 2.5GT/s, Width x1
                       TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
       Capabilities: [100 v1] Power Budgeting <?>
       Capabilities: [200 v1] Device Serial Number 88-99-ff-ee-dd-cc-bb-aa
       Kernel driver in use: serial

02:00.1 Serial controller: MosChip Semiconductor Technology Ltd. PCIe
9901 Multi-I/O Controller (prog-if 02 [16550])
       Subsystem: Asix Electronics Corporation (Wrong ID) Device 1000
       Physical Slot: 1
       Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
       Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
       Interrupt: pin B routed to IRQ 18
       Region 0: I/O ports at 2008 [size=8]
       Region 1: Memory at d0002000 (32-bit, non-prefetchable) [size=4K]
       Region 4: Memory at d0003000 (32-bit, non-prefetchable) [size=4K]
       Capabilities: [80] Power Management version 3
               Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
               Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=1 PME-
       Capabilities: [88] MSI: Enable- Count=1/32 Maskable- 64bit+
               Address: 0000000000000000  Data: 0000
       Capabilities: [c0] Express (v1) Legacy Endpoint, MSI 00
               DevCap: MaxPayload 256 bytes, PhantFunc 0, Latency L0s
<64ns, L1 <1us
                       ExtTag- AttnBtn+ AttnInd+ PwrInd+ RBE- FLReset-
               DevCtl: CorrErr- NonFatalErr- FatalErr- UnsupReq-
                       RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
                       MaxPayload 128 bytes, MaxReadReq 512 bytes
               DevSta: CorrErr- NonFatalErr+ FatalErr- UnsupReq+
AuxPwr- TransPend-
               LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1,
Exit Latency L0s unlimited, L1 unlimited
                       ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp-
               LnkCtl: ASPM Disabled; RCB 64 bytes, Disabled- CommClk+
                       ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
               LnkSta: Speed 2.5GT/s, Width x1
                       TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
       Capabilities: [100 v1] Power Budgeting <?>
       Capabilities: [200 v1] Device Serial Number 00-00-00-00-00-00-00-00
       Kernel driver in use: serial
