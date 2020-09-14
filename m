Return-Path: <SRS0=LhIc=CX=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A095C43461
	for <linux-serial@archiver.kernel.org>; Mon, 14 Sep 2020 17:36:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0665820732
	for <linux-serial@archiver.kernel.org>; Mon, 14 Sep 2020 17:36:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ffMCqrPE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726011AbgINRgh (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 14 Sep 2020 13:36:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbgINRgc (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 14 Sep 2020 13:36:32 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39146C06174A
        for <linux-serial@vger.kernel.org>; Mon, 14 Sep 2020 10:36:32 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id g4so539701wrs.5
        for <linux-serial@vger.kernel.org>; Mon, 14 Sep 2020 10:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=0jt/+aSyhg5ihvcDZ3XfwyTyutSv3odQ9jd9Uwy0IRw=;
        b=ffMCqrPEEFlimFK/y9l3PrbQ1xF0Zvdc1M4r8aNSYNQvgYb9Y9wbWBONq1mngiiawt
         oda3FZCc1bxY55DGsLOYnBwJW4S+/cJgXbF3+2RBWDPpCbERVQnDdCLlYs800mZgDETd
         /rrjUGCMi2G6ym0M2VlPXp0D1V81bbwjA5jEDH+Fj/vuqoTeNJ7NEWhzguPgpeXMgQ3A
         xja01xZjOSCEymVMVSNqXc+6EFdd0qBjvcgnNAtG5H1pcJt6GrfyUI8bAqM62s0yfBUd
         Odkg3nmCCCKU1Z0+Eg/lWTt+RYnJ7hYg4sdZL/e90zQ1BF1+WvKuAVzPpryCXiFeEnrW
         yfkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=0jt/+aSyhg5ihvcDZ3XfwyTyutSv3odQ9jd9Uwy0IRw=;
        b=X1w2s3swe15gVUDomb6ly83y2jZ+XteHefVus7fi2Wyg1MCggi6liHSx90w6a+BFsP
         R8KKOUxGV1oaIxmAlwgaVyFEwokfvys4UF7wym9RupMhW8MzRfmu30kEdj5wbxTRMINI
         4RRAvX4Sx9osJjHD8E8oE3rtd0F4yk51FEty/On1+pDQJCaVZhuwJBzOafrvYFXeqgNf
         GIFN17O/T7nRggIpIM5zoReVc0KwSlP+Uv83rPc/XTWP54J+Q3U5BmZ2SJu7XWCqSuA1
         M4YV3Ib5qSdqsl367CekSW21Ej7CPngyUB90FXNc7b5ACdO/8UxjgrVMMR1CXo+f0/1h
         L64A==
X-Gm-Message-State: AOAM530lkVXiq1yAFLwvsu3tHtG0YfDM+9xkAcr/e+Qmo6DnLTynbIsU
        I01ui7XRqZkLrHyUW+VE5XA6AzPsFjdBtA==
X-Google-Smtp-Source: ABdhPJyMNn7bShKupin/1JW7unBk+RHqW9UF2vR8+J3Zbf1YClzl2EKOwn9U7QxyHO/sP023K6r24Q==
X-Received: by 2002:a5d:5042:: with SMTP id h2mr17314047wrt.409.1600104990876;
        Mon, 14 Sep 2020 10:36:30 -0700 (PDT)
Received: from yamamaya.is-a-geek.org (212-51-140-49.fiber7.init7.net. [212.51.140.49])
        by smtp.gmail.com with ESMTPSA id n3sm3537529wmn.39.2020.09.14.10.36.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 10:36:30 -0700 (PDT)
Date:   Mon, 14 Sep 2020 19:36:28 +0200
From:   Tobias Diedrich <tobiasdiedrich@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org
Subject: PATCH: serial: 8250_pci: Add Realtek 816a and 816b
Message-ID: <20200914173628.GA22508@yamamaya.is-a-geek.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

These serial ports are exposed by the OOB-management-engine on
RealManage-enabled network cards (e.g. AMD DASH enabled systems using
Realtek cards).

Because these have 3 BARs, they fail the "num_iomem <= 1" check in
serial_pci_guess_board.

I've manually checked the two IOMEM regions and BAR 2 doesn't seem to
respond to reads, but BAR 4 seems to be an MMIO version of the IO ports
(untested).

With this change, the ports are detected:
0000:02:00.1: ttyS0 at I/O 0x2200 (irq = 82, base_baud = 115200) is a 16550A
0000:02:00.2: ttyS1 at I/O 0x2100 (irq = 55, base_baud = 115200) is a 16550A

lspci output:
02:00.1 0700: 10ec:816a (rev 0e) (prog-if 02 [16550])
        Subsystem: 17aa:5082
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort+ <TAbort- <MAbort- >SERR- <PERR- INTx-
        Interrupt: pin B routed to IRQ 82
        IOMMU group: 11
        Region 0: I/O ports at 2200 [size=256]
        Region 2: Memory at fd715000 (64-bit, non-prefetchable) [size=4K]
        Region 4: Memory at fd704000 (64-bit, non-prefetchable) [size=16K]
        Capabilities: [40] Power Management version 3
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [50] MSI: Enable- Count=1/1 Maskable- 64bit+
                Address: 0000000000000000  Data: 0000
        Capabilities: [70] Express (v2) Endpoint, MSI 01
                DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s unlimited, L1 <64us
                        ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset- SlotPowerLimit 0.000W
                DevCtl: CorrErr- NonFatalErr- FatalErr- UnsupReq-
                        RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop-
                        MaxPayload 128 bytes, MaxReadReq 512 bytes
                DevSta: CorrErr+ NonFatalErr- FatalErr- UnsupReq+ AuxPwr+ TransPend-
                LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s unlimited, L1 <64us
                        ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp+
                LnkCtl: ASPM L1 Enabled; RCB 64 bytes, Disabled- CommClk+
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 2.5GT/s (ok), Width x1 (ok)
                        TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
                DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP- LTR+
                         10BitTagComp- 10BitTagReq- OBFF Via message/WAKE#, ExtFmt- EETLPPrefix-
                         EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
                         FRS- TPHComp- ExtTPHComp-
                         AtomicOpsCap: 32bit- 64bit- 128bitCAS-
                DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR- OBFF Disabled,
                         AtomicOpsCtl: ReqEn-
                LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete- EqualizationPhase1-
                         EqualizationPhase2- EqualizationPhase3- LinkEqualizationRequest-
                         Retimer- 2Retimers- CrosslinkRes: unsupported
        Capabilities: [b0] MSI-X: Enable- Count=4 Masked-
                Vector table: BAR=4 offset=00000000
                PBA: BAR=4 offset=00000800
        Capabilities: [d0] Vital Product Data
                Not readable
        Capabilities: [100 v2] Advanced Error Reporting
                UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
                CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
                CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
                AERCap: First Error Pointer: 00, ECRCGenCap+ ECRCGenEn- ECRCChkCap+ ECRCChkEn-
                        MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
                HeaderLog: 00000000 00000000 00000000 00000000
        Capabilities: [160 v1] Device Serial Number 00-00-00-00-00-00-00-00
        Capabilities: [170 v1] Latency Tolerance Reporting
                Max snoop latency: 0ns
                Max no snoop latency: 0ns
        Capabilities: [178 v1] L1 PM Substates
                L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substates+
                          PortCommonModeRestoreTime=150us PortTPowerOnTime=150us
                L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- ASPM_L1.1-
                           T_CommonMode=0us LTR1.2_Threshold=0ns
                L1SubCtl2: T_PwrOn=10us
02:00.2 0700: 10ec:816b (rev 0e)
[...same...]

Signed-off-by: Tobias Diedrich <tobiasdiedrich@gmail.com>
---
 drivers/tty/serial/8250/8250_pci.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index 3eb2d485eaeb..55bb7b897d97 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -5566,6 +5566,17 @@ static const struct pci_device_id serial_pci_tbl[] = {
 		PCI_ANY_ID, PCI_ANY_ID,
 		0, 0, pbn_wch384_4 },
 
+	/*
+	 * Realtek RealManage
+	 */
+	{	PCI_VENDOR_ID_REALTEK, 0x816a,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0, pbn_b0_1_115200 },
+
+	{	PCI_VENDOR_ID_REALTEK, 0x816b,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0, pbn_b0_1_115200 },
+
 	/* Fintek PCI serial cards */
 	{ PCI_DEVICE(0x1c29, 0x1104), .driver_data = pbn_fintek_4 },
 	{ PCI_DEVICE(0x1c29, 0x1108), .driver_data = pbn_fintek_8 },
-- 
2.28.0

