Return-Path: <SRS0=gEyB=IE=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04AA2C433E0
	for <linux-serial@archiver.kernel.org>; Sat,  6 Mar 2021 18:10:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C327364FF2
	for <linux-serial@archiver.kernel.org>; Sat,  6 Mar 2021 18:10:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231241AbhCFSJw (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 6 Mar 2021 13:09:52 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:23179 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231278AbhCFSJf (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Sat, 6 Mar 2021 13:09:35 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4DtCL200JXz9v089;
        Sat,  6 Mar 2021 19:09:30 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id mkl9CLEeLAJH; Sat,  6 Mar 2021 19:09:29 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4DtCL16Fjzz9v085;
        Sat,  6 Mar 2021 19:09:29 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id BB6348B768;
        Sat,  6 Mar 2021 19:09:31 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id vkPrD6uBrmsE; Sat,  6 Mar 2021 19:09:31 +0100 (CET)
Received: from po16121vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 670268B75B;
        Sat,  6 Mar 2021 19:09:31 +0100 (CET)
Received: by localhost.localdomain (Postfix, from userid 0)
        id 4B224674E3; Sat,  6 Mar 2021 18:09:31 +0000 (UTC)
Message-Id: <26bdf034740261a5d144264f150d5ae7d466dad5.1615053848.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1615053848.git.christophe.leroy@csgroup.eu>
References: <cover.1615053848.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v1 3/3] Revert "soc: fsl: qe: introduce qe_io{read,write}*
 wrappers"
To:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Timur Tabi <timur@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org
Date:   Sat,  6 Mar 2021 18:09:31 +0000 (UTC)
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This reverts commit 6ac9b61786cc64ae5cbfb69413137656f72e8204.

This commit was required because at that time, ioread/iowrite
functions were sub-optimal on powerpc/32 compared to the
architecture specific in_/out_ IO accessors.

But there are now equivalent since
commit 894fa235eb4c ("powerpc: inline iomap accessors").

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 include/soc/fsl/qe/qe.h | 34 +++++++++-------------------------
 1 file changed, 9 insertions(+), 25 deletions(-)

diff --git a/include/soc/fsl/qe/qe.h b/include/soc/fsl/qe/qe.h
index 4925a1b59dc9..b02e9fe69146 100644
--- a/include/soc/fsl/qe/qe.h
+++ b/include/soc/fsl/qe/qe.h
@@ -239,37 +239,21 @@ static inline int qe_alive_during_sleep(void)
 #define qe_muram_dma cpm_muram_dma
 #define qe_muram_free_addr cpm_muram_free_addr
 
-#ifdef CONFIG_PPC32
-#define qe_iowrite8(val, addr)     out_8(addr, val)
-#define qe_iowrite16be(val, addr)  out_be16(addr, val)
-#define qe_iowrite32be(val, addr)  out_be32(addr, val)
-#define qe_ioread8(addr)           in_8(addr)
-#define qe_ioread16be(addr)        in_be16(addr)
-#define qe_ioread32be(addr)        in_be32(addr)
-#else
-#define qe_iowrite8(val, addr)     iowrite8(val, addr)
-#define qe_iowrite16be(val, addr)  iowrite16be(val, addr)
-#define qe_iowrite32be(val, addr)  iowrite32be(val, addr)
-#define qe_ioread8(addr)           ioread8(addr)
-#define qe_ioread16be(addr)        ioread16be(addr)
-#define qe_ioread32be(addr)        ioread32be(addr)
-#endif
-
-#define qe_setbits_be32(_addr, _v) qe_iowrite32be(qe_ioread32be(_addr) |  (_v), (_addr))
-#define qe_clrbits_be32(_addr, _v) qe_iowrite32be(qe_ioread32be(_addr) & ~(_v), (_addr))
+#define qe_setbits_be32(_addr, _v) iowrite32be(ioread32be(_addr) |  (_v), (_addr))
+#define qe_clrbits_be32(_addr, _v) iowrite32be(ioread32be(_addr) & ~(_v), (_addr))
 
-#define qe_setbits_be16(_addr, _v) qe_iowrite16be(qe_ioread16be(_addr) |  (_v), (_addr))
-#define qe_clrbits_be16(_addr, _v) qe_iowrite16be(qe_ioread16be(_addr) & ~(_v), (_addr))
+#define qe_setbits_be16(_addr, _v) iowrite16be(ioread16be(_addr) |  (_v), (_addr))
+#define qe_clrbits_be16(_addr, _v) iowrite16be(ioread16be(_addr) & ~(_v), (_addr))
 
-#define qe_setbits_8(_addr, _v) qe_iowrite8(qe_ioread8(_addr) |  (_v), (_addr))
-#define qe_clrbits_8(_addr, _v) qe_iowrite8(qe_ioread8(_addr) & ~(_v), (_addr))
+#define qe_setbits_8(_addr, _v) iowrite8(ioread8(_addr) |  (_v), (_addr))
+#define qe_clrbits_8(_addr, _v) iowrite8(ioread8(_addr) & ~(_v), (_addr))
 
 #define qe_clrsetbits_be32(addr, clear, set) \
-	qe_iowrite32be((qe_ioread32be(addr) & ~(clear)) | (set), (addr))
+	iowrite32be((ioread32be(addr) & ~(clear)) | (set), (addr))
 #define qe_clrsetbits_be16(addr, clear, set) \
-	qe_iowrite16be((qe_ioread16be(addr) & ~(clear)) | (set), (addr))
+	iowrite16be((ioread16be(addr) & ~(clear)) | (set), (addr))
 #define qe_clrsetbits_8(addr, clear, set) \
-	qe_iowrite8((qe_ioread8(addr) & ~(clear)) | (set), (addr))
+	iowrite8((ioread8(addr) & ~(clear)) | (set), (addr))
 
 /* Structure that defines QE firmware binary files.
  *
-- 
2.25.0

