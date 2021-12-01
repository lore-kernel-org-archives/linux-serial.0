Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49FD4C4167D
	for <linux-serial@archiver.kernel.org>; Wed,  1 Dec 2021 07:33:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347625AbhLAHgl (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 1 Dec 2021 02:36:41 -0500
Received: from relmlor1.renesas.com ([210.160.252.171]:27177 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S242112AbhLAHgk (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 1 Dec 2021 02:36:40 -0500
X-IronPort-AV: E=Sophos;i="5.87,278,1631545200"; 
   d="scan'208";a="102002988"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 01 Dec 2021 16:33:17 +0900
Received: from localhost.localdomain (unknown [10.166.14.185])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 165E741FE2A9;
        Wed,  1 Dec 2021 16:33:17 +0900 (JST)
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     geert+renesas@glider.be, magnus.damm@gmail.com, robh+dt@kernel.org,
        gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH v2 02/14] dt-bindings: power: Add r8a779f0 SYSC power domain definitions
Date:   Wed,  1 Dec 2021 16:32:56 +0900
Message-Id: <20211201073308.1003945-3-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211201073308.1003945-1-yoshihiro.shimoda.uh@renesas.com>
References: <20211201073308.1003945-1-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Add power domain indices for R-Car S4-8 (r8a779f0).

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 include/dt-bindings/power/r8a779f0-sysc.h | 30 +++++++++++++++++++++++
 1 file changed, 30 insertions(+)
 create mode 100644 include/dt-bindings/power/r8a779f0-sysc.h

diff --git a/include/dt-bindings/power/r8a779f0-sysc.h b/include/dt-bindings/power/r8a779f0-sysc.h
new file mode 100644
index 000000000000..0ec8ad727ed9
--- /dev/null
+++ b/include/dt-bindings/power/r8a779f0-sysc.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: (GPL-2.0 or MIT) */
+/*
+ * Copyright (C) 2021 Renesas Electronics Corp.
+ */
+#ifndef __DT_BINDINGS_POWER_R8A779F0_SYSC_H__
+#define __DT_BINDINGS_POWER_R8A779F0_SYSC_H__
+
+/*
+ * These power domain indices match the Power Domain Register Numbers (PDR)
+ */
+
+#define R8A779F0_PD_A1E0D0C0		0
+#define R8A779F0_PD_A1E0D0C1		1
+#define R8A779F0_PD_A1E0D1C0		2
+#define R8A779F0_PD_A1E0D1C1		3
+#define R8A779F0_PD_A1E1D0C0		4
+#define R8A779F0_PD_A1E1D0C1		5
+#define R8A779F0_PD_A1E1D1C0		6
+#define R8A779F0_PD_A1E1D1C1		7
+#define R8A779F0_PD_A2E0D0		16
+#define R8A779F0_PD_A2E0D1		17
+#define R8A779F0_PD_A2E1D0		18
+#define R8A779F0_PD_A2E1D1		19
+#define R8A779F0_PD_A3E0		20
+#define R8A779F0_PD_A3E1		21
+
+/* Always-on power area */
+#define R8A779F0_PD_ALWAYS_ON		64
+
+#endif /* __DT_BINDINGS_POWER_R8A779A0_SYSC_H__*/
-- 
2.25.1

