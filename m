Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2057.outbound.protection.outlook.com [40.107.247.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A686F07E;
	Tue,  7 May 2024 20:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715114636; cv=fail; b=oR9jjKJlIERTsuUBpLhmMVUcYE7EhhdwXosVrQc2SGEJsiT6a0SGYJXpH43SUkoAXgVRttmnQ35iYwTg3FeMYpZlVNRP7bakrh2ZoE47XtO7uTzQNtKFFhuRiQiLj3c8webd2ggry1XRURw/6HM0HcQLb564gdB/2RVEk1958oM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715114636; c=relaxed/simple;
	bh=twlvfS+FWjMwDC3kb7//kkn7rw7goW19yBCvAjtHOyY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ALY64tTSM9rBlfavAYlQCotn48YfRYVV+7NhDC9G4sBYWSFY3buxc551t6fX8h6uVStSqburgiWrgG9UwCfmTPcsGlRAJoZGncXe5Q+hcdf1wvbj7zNeuCGTe7d9scBgsAqYdSYL93rYPDbyNkqhiO0YeyC/CcqWcwwVPtHNbrY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=mAtWgfJR; arc=fail smtp.client-ip=40.107.247.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="mAtWgfJR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EdrSV9U5tp9/AeTDgRppbITszXcMHGdEZbjp4OdXnNGQ2mKqS74kNX8F56wdS1Fhr/z6HTV6MNitDRNYn1o9kzUmRBmcu3n51gL4m1dGj89DqzxWhXIu00sr1l1vrNpIaqP8UZmkKwGkADhYdqCTsFjq7BsKNdUTI3EdlVS9jM4FgNxKdM989YbfHROtgdAYZnR2AaQYGUlV0hdTKR7BGgmRuExdrtQhwW02xblhqRvmJ1FZcrKBRXLder6GIscvqcsaWBAt/sP1aUfAHjO9+wAWvJcGHJ6qmT/GdZQa3JOIlJaEpeKJLRqWZgw2FeOK2SJYwPk5qF/RzGQ7zts33w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h8/Jktg4nOZYzpDDanG9Yaa3HVjkC1jDypJv3mZp0SU=;
 b=c2bmrtWNZNfC+8GOSIL11sPgQDpc8L9cRldrzWca+m3qOwbmQmEoN1uZ82agatUgOpSNJP/v06YwYvAN+TZ8ILXAfIYmZ3XIPr654vkeHNEwVJ6K20TFxv48U1LAbfWQzJxBJWa6SgcWZcfhxma5zcSaaY2Oy6Y1vscEpX5X9MXQiFo+F9N2KpzKtJ/WUsDaTwCjFM2lZTsCJPqvPvhntRobZ+rlNJ7oZ3hVgvRipKUS6+hboxgj8oA2GZJ9OZ2OUG3N8I5o9Z1Cn2SqddIDL7XGCZZlzU2gsBIw5LLPftXUn4xnGdJLvayFaKBjwqR9oQIWpGc8he37GuFDf6al3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h8/Jktg4nOZYzpDDanG9Yaa3HVjkC1jDypJv3mZp0SU=;
 b=mAtWgfJRsJajs/ddbPfxGqQUQdMTOyAEmm0TQe/jjNMBi0d1H5E+JkmTLt1OZeAu4BNhQOL4hhD+U7muASpxol0BQweOq0+GpkP+kSezX6gKctgyRlTzDKx6UDh4mv4TYKyq3Jw/RlsRwa/RE5HpMGnsgyR3/BBvOUURSP5g0P8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB8576.eurprd04.prod.outlook.com (2603:10a6:102:217::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Tue, 7 May
 2024 20:43:51 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 20:43:51 +0000
From: Frank Li <Frank.Li@nxp.com>
To: alexandre.belloni@bootlin.com
Cc: conor.culhane@silvaco.com,
	devicetree@vger.kernel.org,
	gregkh@linuxfoundation.org,
	ilpo.jarvinen@linux.intel.com,
	imx@lists.linux.dev,
	jirislaby@kernel.org,
	joe@perches.com,
	krzysztof.kozlowski+dt@linaro.org,
	krzysztof.kozlowski@linaro.org,
	linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	miquel.raynal@bootlin.com,
	robh@kernel.org,
	zbigniew.lukwinski@linux.intel.com
Subject: [PATCH resend v9 6/8] i3c: target: func: add tty driver
Date: Tue,  7 May 2024 16:43:09 -0400
Message-Id: <20240507204311.2898714-7-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240507204311.2898714-1-Frank.Li@nxp.com>
References: <20240507204311.2898714-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA1PR02CA0018.namprd02.prod.outlook.com
 (2603:10b6:806:2cf::26) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB8576:EE_
X-MS-Office365-Filtering-Correlation-Id: 25485831-8d77-47ec-4a79-08dc6ed66720
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|7416005|1800799015|376005|52116005|366007|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1avs6uufO8Z8/m2giB/OPKBDcpO2nbUdAjnHfbKhzLfuX5pnaItP1qcmFssH?=
 =?us-ascii?Q?EYxphXmkMoUgh3D/8+6XR+nlGRLTV4ccOS3oA0Sz6YXyjF77w5Q5Hdfwauv1?=
 =?us-ascii?Q?TN6gppXm+BN1DeHbkYih4TtgQg4olzpLUMcXqCnHPF1GzxP+S9t52WmRPFna?=
 =?us-ascii?Q?ewI/CqdSXOEmGjjl1uVQnICkAxI711KkuHpwasFFVvL3Q6Mq4ZAnfOj4DFYz?=
 =?us-ascii?Q?3zLsBokYkosLAoJIFIXLsgY0zvhLADjyvnkVXL3scZX/KUueqFsxowiC4mtk?=
 =?us-ascii?Q?GEABqUvoKrceVSALSd2gQijtNJ0B0rd7tjPkDV+k4J6YVYCPNDxVOZssEkw0?=
 =?us-ascii?Q?+08U1MRSNh3YlYiTSjvmiN4p5KqmpsuAC0HPxXw8R4XNi5c0AYOiwAPCTNzQ?=
 =?us-ascii?Q?5IWoI+RUjkECpivMmOuYhUL1zp2TeC/NK9wBB7sCp3VOqR3Iolf1nh9zRs8F?=
 =?us-ascii?Q?XFAgOy7+4eFFLUhAUGXsffHAQUurItATPXFLofzj+W/b7E76JP8pzwXN2nq/?=
 =?us-ascii?Q?44Lhsdjtpc32I/GeHoNVzLnxl5sN0jETZZDodTmljkgeZgJ8RxSuS3PzgtVP?=
 =?us-ascii?Q?Ohgkf36WlLOCT7t3iW7wFStWpZtw5/copUgTXvkO3rRXFqA3Xvpy8kWgtYeW?=
 =?us-ascii?Q?+mgb1lSbCUeYi7qpmzIWcKgFuf/7LqB8tq6zJ6QxSXtRsi9KMEEHDDjWNyXy?=
 =?us-ascii?Q?qH87eLP2vRya0f9jUzv5MPQMtyWFPMQJYZTe4nRMlt5tfj5ps7DGqS8oGnvg?=
 =?us-ascii?Q?pXEaaMcNk2ASxQziVhy9vnG8qsGGldSeasUFZRbCmFOGk+wV/87vmLAZllby?=
 =?us-ascii?Q?D94F0mlrXUw2H6uhXTWTyv+IXkTrj/nqa62jLfcXc+vvp/nUiyevPp9JlrIO?=
 =?us-ascii?Q?yTIecD7crfSM9h4nmw7zOc35V6T+rXnIkAwmfswKSS6D7iURii32ZXPZQuHS?=
 =?us-ascii?Q?rFrWO2DPYxkreAkiYylhlVxoNAYPMXsYQojI1KWnGnxWWUwmqtL4gM6QQdrv?=
 =?us-ascii?Q?j1wjD8u6utn60OFjanDroFN5IyvKzseLRAxEyljTTszz6AhsjrqBv8OSifDm?=
 =?us-ascii?Q?DZRT6NQKs5yw6FcaCgV0x0PX+mCmnLpvogY2oq8yFXJk4bLP/y0yZHtwlOsz?=
 =?us-ascii?Q?eY4WAvRdgilLIT9KmSafjF9hzGLlGtvgKk0+9x/d0fXEepA5uHuWJHjl6wWw?=
 =?us-ascii?Q?ZXA/B36F4ZOfFfl5QXKLFPQ+jQn2SBniT/0mFmbXi1WL863/HTlsbxgyTJMm?=
 =?us-ascii?Q?cEuqEYmyJCwHi6KeYxHwodKHA8gLQZdf1sBPlUGEaVOvbtZnWApKKCSSRqwu?=
 =?us-ascii?Q?0jRN29Y81vxx7A8ziRuGpixU/wQ5GUlehEUq2Yp838sH/g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(52116005)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sQUVnnzJncWqqgqbkUY0vPLi+WD9Tjfn8V6GPVHYHngG9Laupqd0p20bX66x?=
 =?us-ascii?Q?SODoMp/d7Er8/fKO9E8nhSJnUdSJryCnFZgC7YX/OMRCbo3MamoTq944tyNX?=
 =?us-ascii?Q?sAPoDTab0DJRDPjw3P0b9GRXXVtay/eU9V5STMA7OEPRJiOXTBWySoOcLRt/?=
 =?us-ascii?Q?ct7nJ5v5wbvYXBQYk9sPGC2eEEesrsu3h638nlZl2u+ddoBF7E7zSbXyeLe1?=
 =?us-ascii?Q?42qM8jh3BWXVsF3rIpAIa/3l4tdBKFnmzc9OyLMz0/VpkYD83cJKW51hKHyE?=
 =?us-ascii?Q?p0onDTa7U6avX0Dy4xsscA4OOpkoCfaXevG0DgBRIog3cmeBV+gLxtpRZQNg?=
 =?us-ascii?Q?GE841KOspzX5DuA66glnWsovCw5Xv/S1Kw0M9N3RErfbMe7WgMLbLHU+Q9Pb?=
 =?us-ascii?Q?Ww9z1l2pNyVyQumEZqX96MBJU/0N+S4SvdDfTPSphKugalMSPNe6SpoEEIJZ?=
 =?us-ascii?Q?TlpNAe3LahCkFY18B3Y50VHAUlW9c4UFx7gf46+aGT7+ddS5dBZATN8XQ0Iv?=
 =?us-ascii?Q?qO5ChXiXh3Ff8T11sTsg6SC2ilHcuPywnevVCLavm91uQef/V6nJ7ofuU/p6?=
 =?us-ascii?Q?vpcAHjTR86CtjsfrpB460eGEtiYYeDQ5PH6IU1nz9rTH46VBgXZOHCWcclTU?=
 =?us-ascii?Q?BZsE7LU7zJX+OYqz/SpOFLSDedL+9V7doqCzCImFG5IObCJQm9rGkvCRAkWp?=
 =?us-ascii?Q?UTFUDedrgV2+gAmvFmlnybMH4uAL4gv/acM4LthCqmz0fOPA7/UUKHLRDLlB?=
 =?us-ascii?Q?eqJgBb071N2edPV4BCGH7DFWk03+YLDtfRvT67y+ucqAGgb00MiySzx78Naf?=
 =?us-ascii?Q?YCH+/HwkvVGs3dBC7s0u1yiewkG4BD2ey8nP5xg0f4YcO/cSW9Kp3sqUGT6D?=
 =?us-ascii?Q?96IIWD/rZhWxGtFKFDA+JPURnwXCRbyiPp9dngNaAASHv/J3z8Z3mpjrnGjB?=
 =?us-ascii?Q?ctEX8laXNKYQz/1yi/hF33pU+/k+dIrtiSeDzrDlyfjLhFWg2P9XgwNlUxfl?=
 =?us-ascii?Q?b6GXcwL35zv0odfHvNlwZQ3BlBZzrlk0/CmDtQcxIl+ulenx2lrYfbq2q8+o?=
 =?us-ascii?Q?nFwoub/JiKGhpEQ8K6Y496umNNHAs3bqOMY12bUQFfECheuYWizrP2tRHP0e?=
 =?us-ascii?Q?IGgeVeaTGh4rATFb8+Sw1wV7klesxYD18Q9XA5h6vG4wPlGfdtqy7JHOJ5ou?=
 =?us-ascii?Q?2tu5BWdiGp5G3VsLNJQmDeoxeHQ3SKK/g2lReiUWMD1XZKoUgDnNnHaNlkyC?=
 =?us-ascii?Q?YAy5wE+g0CS8UTHIhRM+8U1CnJxUhpkwncNkJZHOwKK07FWAztQo9TynnQZC?=
 =?us-ascii?Q?qNZSF8wEdTrJDFIK1G6Mjpa73MTHU6OFKhhixcwTS7/Mr+Mmxk38jKS6f/Pl?=
 =?us-ascii?Q?Q6bYjmuGtLAhBdljjpEO9IeGbIsGAfaIRGaanWEV5Edy2KznSBEp0cVrzCIG?=
 =?us-ascii?Q?vyV14/eH1FlAxkyQn6340yvF+GKghlrHdqajEDTebNm1Zllx8Qg3TeDMmeXF?=
 =?us-ascii?Q?sa28bdJ18+rVaW0Cyo2rEaRIcvcRpsPoDlpfWOrpWg4kWHMRuv1vT38wJoWD?=
 =?us-ascii?Q?GzdrPFqtYpxkzxPSCoLKC03v+F//6sXwVzFWgmKo?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25485831-8d77-47ec-4a79-08dc6ed66720
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 20:43:51.3794
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nvzRYorEufhM2vCBP9yw7ZNyB6rinwWdk/W/3F7VgCqfLY4OQO5X7z+On/lhcnpuNBIxNIY3rlolKZVfyhbzeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8576

Add tty over I3C target function driver.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    Change from v8 to v9
    - none
    
    Change from v7 to v8
    - reorder header file
    - add missed header files
    
    Change from v5 to v7
    - none
    Change from v4 to v5
    - remove void*
    - include bitfield.h
    - remove extra ()
    - oneline for struct ttyi3c_port *sport

 drivers/i3c/Kconfig       |   3 +
 drivers/i3c/Makefile      |   1 +
 drivers/i3c/func/Kconfig  |   9 +
 drivers/i3c/func/Makefile |   3 +
 drivers/i3c/func/tty.c    | 481 ++++++++++++++++++++++++++++++++++++++
 5 files changed, 497 insertions(+)
 create mode 100644 drivers/i3c/func/Kconfig
 create mode 100644 drivers/i3c/func/Makefile
 create mode 100644 drivers/i3c/func/tty.c

diff --git a/drivers/i3c/Kconfig b/drivers/i3c/Kconfig
index d59a7eb83d13a..fca808cda87b3 100644
--- a/drivers/i3c/Kconfig
+++ b/drivers/i3c/Kconfig
@@ -48,3 +48,6 @@ config I3C_TARGET_CONFIGFS
 	  the target function and used to bind the function with a target
 	  controller.
 
+if I3C_TARGET
+source "drivers/i3c/func/Kconfig"
+endif # I3C_TARGET
diff --git a/drivers/i3c/Makefile b/drivers/i3c/Makefile
index c275aeae8970c..11f026d6876fe 100644
--- a/drivers/i3c/Makefile
+++ b/drivers/i3c/Makefile
@@ -4,3 +4,4 @@ obj-$(CONFIG_I3C)		+= i3c.o
 obj-$(CONFIG_I3C_TARGET)                += target.o
 obj-$(CONFIG_I3C_TARGET_CONFIGFS)       += i3c-cfs.o
 obj-$(CONFIG_I3C)		+= master/
+obj-$(CONFIG_I3C_TARGET)	+= func/
diff --git a/drivers/i3c/func/Kconfig b/drivers/i3c/func/Kconfig
new file mode 100644
index 0000000000000..7115129eb7d5a
--- /dev/null
+++ b/drivers/i3c/func/Kconfig
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0
+
+config I3C_TARGET_FUNC_TTY
+	tristate "I3C target tty driver"
+	depends on I3C_TARGET
+	help
+	  I3C Target TTY Function Driver.
+
+	  General TTY over I3C target controller function drivers.
diff --git a/drivers/i3c/func/Makefile b/drivers/i3c/func/Makefile
new file mode 100644
index 0000000000000..16b3b9301496b
--- /dev/null
+++ b/drivers/i3c/func/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-$(CONFIG_I3C_TARGET_FUNC_TTY)              += tty.o
diff --git a/drivers/i3c/func/tty.c b/drivers/i3c/func/tty.c
new file mode 100644
index 0000000000000..2cf25c8d49f2b
--- /dev/null
+++ b/drivers/i3c/func/tty.c
@@ -0,0 +1,481 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2023 NXP
+ * Author: Frank Li <Frank.Li@nxp.com>
+ */
+
+#include <linux/bits.h>
+#include <linux/bitfield.h>
+#include <linux/completion.h>
+#include <linux/errno.h>
+#include <linux/idr.h>
+#include <linux/iopoll.h>
+#include <linux/i3c/target.h>
+#include <linux/module.h>
+#include <linux/serial_core.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/tty_flip.h>
+#include <linux/workqueue.h>
+
+static DEFINE_IDR(i3c_tty_minors);
+
+static struct tty_driver *i3c_tty_driver;
+
+#define I3C_TTY_MINORS		8
+
+#define I3C_TX_NOEMPTY		BIT(0)
+#define I3C_TTY_TRANS_SIZE	16
+#define I3C_TTY_IBI_TX		BIT(0)
+
+struct ttyi3c_port {
+	struct tty_port port;
+	int minor;
+	struct i3c_target_func *i3cdev;
+	struct completion txcomplete;
+	spinlock_t xlock;
+	void *buffer;
+	struct work_struct work;
+	u16 status;
+	struct i3c_request *req;
+};
+
+static void i3c_target_tty_rx_complete(struct i3c_request *req)
+{
+	struct ttyi3c_port *port = req->context;
+
+	if (req->status == I3C_REQUEST_CANCEL) {
+		i3c_target_ctrl_free_request(req);
+		return;
+	}
+
+	tty_insert_flip_string(&port->port, req->buf, req->actual);
+	tty_flip_buffer_push(&port->port);
+
+	req->actual = 0;
+	req->status = 0;
+	i3c_target_ctrl_queue(req, GFP_KERNEL);
+}
+
+static void i3c_target_tty_tx_complete(struct i3c_request *req)
+{
+	struct ttyi3c_port *sport = req->context;
+	unsigned long flags;
+
+	if (req->status == I3C_REQUEST_CANCEL) {
+		i3c_target_ctrl_free_request(req);
+		return;
+	}
+
+	spin_lock_irqsave(&sport->xlock, flags);
+	kfifo_dma_out_finish(&sport->port.xmit_fifo, req->actual);
+	sport->req = NULL;
+
+	if (kfifo_is_empty(&sport->port.xmit_fifo))
+		complete(&sport->txcomplete);
+	else
+		queue_work(system_unbound_wq, &sport->work);
+
+	if (kfifo_len(&sport->port.xmit_fifo) < WAKEUP_CHARS)
+		tty_port_tty_wakeup(&sport->port);
+	spin_unlock_irqrestore(&sport->xlock, flags);
+
+	i3c_target_ctrl_free_request(req);
+}
+
+static void i3c_target_tty_i3c_work(struct work_struct *work)
+{
+	struct ttyi3c_port *sport = container_of(work, struct ttyi3c_port, work);
+	struct i3c_request *req = sport->req;
+	struct scatterlist sg[1];
+	unsigned int nents;
+	u8 ibi;
+
+	if (kfifo_is_empty(&sport->port.xmit_fifo))
+		return;
+
+	if (!req) {
+		req = i3c_target_ctrl_alloc_request(sport->i3cdev->ctrl, GFP_KERNEL);
+		if (!req)
+			return;
+
+		sg_init_table(sg, ARRAY_SIZE(sg));
+		nents = kfifo_dma_out_prepare(&sport->port.xmit_fifo, sg, ARRAY_SIZE(sg),
+					      UART_XMIT_SIZE);
+		if (!nents)
+			goto err;
+
+		req->length = sg->length;
+		req->buf =  sg_virt(sg);
+
+		req->complete = i3c_target_tty_tx_complete;
+		req->context = sport;
+		req->tx = true;
+
+		if (i3c_target_ctrl_queue(req, GFP_KERNEL))
+			goto err;
+
+		sport->req = req;
+	}
+
+	ibi = I3C_TTY_IBI_TX;
+	i3c_target_ctrl_raise_ibi(sport->i3cdev->ctrl, &ibi, 1);
+
+	return;
+
+err:
+	i3c_target_ctrl_free_request(req);
+}
+
+static int i3c_port_activate(struct tty_port *port, struct tty_struct *tty)
+{
+	struct ttyi3c_port *sport = container_of(port, struct ttyi3c_port, port);
+	const struct i3c_target_ctrl_features *feature;
+	struct i3c_target_func *func = sport->i3cdev;
+	struct i3c_request *req;
+	int rxfifo_size;
+	int offset = 0;
+	int ret;
+
+	feature = i3c_target_ctrl_get_features(func->ctrl);
+	if (!feature)
+		return -EINVAL;
+
+	ret = tty_port_alloc_xmit_buf(port);
+	if (ret)
+		return ret;
+
+	sport->buffer = (void *)get_zeroed_page(GFP_KERNEL);
+	if (!sport->buffer)
+		goto err_alloc_rx_buf;
+
+	rxfifo_size = feature->rx_fifo_sz;
+
+	if (!rxfifo_size)
+		rxfifo_size = I3C_TTY_TRANS_SIZE;
+
+	do {
+		req = i3c_target_ctrl_alloc_request(func->ctrl, GFP_KERNEL);
+		if (!req)
+			goto err_alloc_req;
+
+		req->buf = sport->buffer + offset;
+		req->length = rxfifo_size;
+		req->context = sport;
+		req->complete = i3c_target_tty_rx_complete;
+		offset += rxfifo_size;
+
+		if (i3c_target_ctrl_queue(req, GFP_KERNEL))
+			goto err_alloc_req;
+	} while (req && offset + rxfifo_size < UART_XMIT_SIZE);
+
+	reinit_completion(&sport->txcomplete);
+
+	return 0;
+
+err_alloc_req:
+	i3c_target_ctrl_cancel_all_reqs(func->ctrl, false);
+	free_page((unsigned long)sport->buffer);
+err_alloc_rx_buf:
+	tty_port_free_xmit_buf(port);
+	return -ENOMEM;
+}
+
+static void i3c_port_shutdown(struct tty_port *port)
+{
+	struct ttyi3c_port *sport = container_of(port, struct ttyi3c_port, port);
+
+	cancel_work_sync(&sport->work);
+
+	i3c_target_ctrl_cancel_all_reqs(sport->i3cdev->ctrl, true);
+	i3c_target_ctrl_cancel_all_reqs(sport->i3cdev->ctrl, false);
+
+	i3c_target_ctrl_fifo_flush(sport->i3cdev->ctrl, true);
+	i3c_target_ctrl_fifo_flush(sport->i3cdev->ctrl, false);
+
+	tty_port_free_xmit_buf(port);
+	free_page((unsigned long)sport->buffer);
+}
+
+static void i3c_port_destruct(struct tty_port *port)
+{
+	struct ttyi3c_port *sport = container_of(port, struct ttyi3c_port, port);
+
+	idr_remove(&i3c_tty_minors, sport->minor);
+}
+
+static const struct tty_port_operations i3c_port_ops = {
+	.shutdown = i3c_port_shutdown,
+	.activate = i3c_port_activate,
+	.destruct = i3c_port_destruct,
+};
+
+static int i3c_target_tty_bind(struct i3c_target_func *func)
+{
+	struct ttyi3c_port *sport;
+	struct device *tty_dev;
+	int minor;
+	int ret;
+
+	sport = dev_get_drvdata(&func->dev);
+
+	if (i3c_target_ctrl_set_config(func->ctrl, func)) {
+		dev_err(&func->dev, "failed to set i3c config\n");
+		return -EINVAL;
+	}
+
+	spin_lock_init(&sport->xlock);
+	init_completion(&sport->txcomplete);
+
+	ret = minor = idr_alloc(&i3c_tty_minors, sport, 0, I3C_TTY_MINORS, GFP_KERNEL);
+
+	if (minor < 0)
+		goto err_idr_alloc;
+
+	tty_port_init(&sport->port);
+	sport->port.ops = &i3c_port_ops;
+
+	tty_dev = tty_port_register_device(&sport->port, i3c_tty_driver, minor,
+					   &func->dev);
+	if (IS_ERR(tty_dev)) {
+		ret = PTR_ERR(tty_dev);
+		goto err_register_port;
+	}
+
+	sport->minor = minor;
+	ret = i3c_target_ctrl_enable(func->ctrl);
+	if (ret)
+		goto err_ctrl_enable;
+
+	return 0;
+
+err_ctrl_enable:
+	tty_port_unregister_device(&sport->port, i3c_tty_driver, sport->minor);
+err_register_port:
+	idr_remove(&i3c_tty_minors, sport->minor);
+err_idr_alloc:
+	i3c_target_ctrl_cancel_all_reqs(func->ctrl, false);
+	dev_err(&func->dev, "bind failure\n");
+
+	return ret;
+}
+
+static void i3c_target_tty_unbind(struct i3c_target_func *func)
+{
+	struct ttyi3c_port *sport;
+
+	sport = dev_get_drvdata(&func->dev);
+
+	cancel_work_sync(&sport->work);
+
+	i3c_target_ctrl_disable(func->ctrl);
+	i3c_target_ctrl_cancel_all_reqs(func->ctrl, 0);
+	i3c_target_ctrl_cancel_all_reqs(func->ctrl, 1);
+
+	tty_port_unregister_device(&sport->port, i3c_tty_driver, sport->minor);
+
+	free_page((unsigned long)sport->buffer);
+}
+
+static struct i3c_target_func_ops i3c_func_ops = {
+	.bind   = i3c_target_tty_bind,
+	.unbind = i3c_target_tty_unbind,
+};
+
+static int i3c_tty_probe(struct i3c_target_func *func)
+{
+	struct device *dev = &func->dev;
+	struct ttyi3c_port *port;
+
+	port = devm_kzalloc(dev, sizeof(*port), GFP_KERNEL);
+	if (!port)
+		return -ENOMEM;
+
+	port->i3cdev = func;
+	dev_set_drvdata(&func->dev, port);
+
+	INIT_WORK(&port->work, i3c_target_tty_i3c_work);
+
+	return 0;
+}
+
+static ssize_t i3c_write(struct tty_struct *tty, const unsigned char *buf, size_t count)
+{
+	struct ttyi3c_port *sport = tty->driver_data;
+	unsigned long flags;
+	bool is_empty;
+	int ret = 0;
+
+	spin_lock_irqsave(&sport->xlock, flags);
+	ret = kfifo_in(&sport->port.xmit_fifo, buf, count);
+	is_empty = kfifo_is_empty(&sport->port.xmit_fifo);
+	i3c_target_ctrl_set_status_format1(sport->i3cdev->ctrl, sport->status | I3C_TX_NOEMPTY);
+	spin_unlock_irqrestore(&sport->xlock, flags);
+
+	if (!is_empty)
+		queue_work(system_unbound_wq, &sport->work);
+
+	return ret;
+}
+
+static int i3c_put_char(struct tty_struct *tty, unsigned char ch)
+{
+	struct ttyi3c_port *sport = tty->driver_data;
+	unsigned long flags;
+	int ret = 0;
+
+	spin_lock_irqsave(&sport->xlock, flags);
+	ret = kfifo_put(&sport->port.xmit_fifo, ch);
+	spin_unlock_irqrestore(&sport->xlock, flags);
+
+	return ret;
+}
+
+static void i3c_flush_chars(struct tty_struct *tty)
+{
+	struct ttyi3c_port *sport = tty->driver_data;
+	unsigned long flags;
+
+	spin_lock_irqsave(&sport->xlock, flags);
+	if (!kfifo_is_empty(&sport->port.xmit_fifo))
+		queue_work(system_unbound_wq, &sport->work);
+	spin_unlock_irqrestore(&sport->xlock, flags);
+}
+
+static unsigned int i3c_write_room(struct tty_struct *tty)
+{
+	struct ttyi3c_port *sport = tty->driver_data;
+
+	return kfifo_avail(&sport->port.xmit_fifo);
+}
+
+static void i3c_throttle(struct tty_struct *tty)
+{
+	struct ttyi3c_port *sport = tty->driver_data;
+
+	i3c_target_ctrl_cancel_all_reqs(sport->i3cdev->ctrl, false);
+}
+
+static void i3c_unthrottle(struct tty_struct *tty)
+{
+	struct ttyi3c_port *sport = tty->driver_data;
+
+	i3c_port_activate(&sport->port, tty);
+}
+
+static int i3c_open(struct tty_struct *tty, struct file *filp)
+{
+	struct ttyi3c_port *sport = container_of(tty->port, struct ttyi3c_port, port);
+	int ret;
+
+	tty->driver_data = sport;
+
+	if (!i3c_target_ctrl_get_addr(sport->i3cdev->ctrl)) {
+		dev_dbg(&sport->i3cdev->dev, "No target addr assigned, try hotjoin");
+		ret = i3c_target_ctrl_hotjoin(sport->i3cdev->ctrl);
+		if (ret) {
+			dev_err(&sport->i3cdev->dev, "Hotjoin failure, check connection");
+			return ret;
+		}
+	}
+
+	return tty_port_open(&sport->port, tty, filp);
+}
+
+static void i3c_close(struct tty_struct *tty, struct file *filp)
+{
+	tty_port_close(tty->port, tty, filp);
+}
+
+static void i3c_wait_until_sent(struct tty_struct *tty, int timeout)
+{
+	struct ttyi3c_port *sport = tty->driver_data;
+	int val;
+	int ret;
+	u8 ibi = I3C_TTY_IBI_TX;
+	int retry = 100;
+
+	if (!kfifo_is_empty(&sport->port.xmit_fifo)) {
+		do {
+			ret = wait_for_completion_timeout(&sport->txcomplete, timeout / 100);
+			if (ret)
+				break;
+			i3c_target_ctrl_raise_ibi(sport->i3cdev->ctrl, &ibi, 1);
+		} while (retry--);
+
+		reinit_completion(&sport->txcomplete);
+	}
+
+	read_poll_timeout(i3c_target_ctrl_fifo_status, val, !val, 100, timeout, false,
+			  sport->i3cdev->ctrl, true);
+
+	i3c_target_ctrl_set_status_format1(sport->i3cdev->ctrl, sport->status & ~I3C_TX_NOEMPTY);
+}
+
+static const struct tty_operations i3c_tty_ops = {
+	.open = i3c_open,
+	.close = i3c_close,
+	.write = i3c_write,
+	.put_char = i3c_put_char,
+	.flush_chars = i3c_flush_chars,
+	.write_room = i3c_write_room,
+	.throttle = i3c_throttle,
+	.unthrottle = i3c_unthrottle,
+	.wait_until_sent = i3c_wait_until_sent,
+};
+
+DECLARE_I3C_TARGET_FUNC(tty, i3c_tty_probe, NULL, &i3c_func_ops);
+
+static int __init i3c_tty_init(void)
+{
+	int ret;
+
+	i3c_tty_driver = tty_alloc_driver(
+		I3C_TTY_MINORS, TTY_DRIVER_REAL_RAW | TTY_DRIVER_DYNAMIC_DEV);
+
+	if (IS_ERR(i3c_tty_driver))
+		return PTR_ERR(i3c_tty_driver);
+
+	i3c_tty_driver->driver_name = "ttySI3C", i3c_tty_driver->name = "ttySI3C",
+	i3c_tty_driver->minor_start = 0,
+	i3c_tty_driver->type = TTY_DRIVER_TYPE_SERIAL,
+	i3c_tty_driver->subtype = SERIAL_TYPE_NORMAL,
+	i3c_tty_driver->init_termios = tty_std_termios;
+	i3c_tty_driver->init_termios.c_cflag = B9600 | CS8 | CREAD | HUPCL |
+					       CLOCAL;
+	i3c_tty_driver->init_termios.c_lflag = 0;
+
+	tty_set_operations(i3c_tty_driver, &i3c_tty_ops);
+
+	ret = tty_register_driver(i3c_tty_driver);
+	if (ret)
+		goto err_register_tty_driver;
+
+	ret = i3c_target_func_register_driver(&ttyi3c_func);
+	if (ret)
+		goto err_register_i3c_driver;
+
+	return 0;
+
+err_register_i3c_driver:
+	tty_unregister_driver(i3c_tty_driver);
+
+err_register_tty_driver:
+	tty_driver_kref_put(i3c_tty_driver);
+
+	return ret;
+}
+
+static void __exit i3c_tty_exit(void)
+{
+	i3c_target_func_unregister_driver(&ttyi3c_func);
+	tty_unregister_driver(i3c_tty_driver);
+	tty_driver_kref_put(i3c_tty_driver);
+	idr_destroy(&i3c_tty_minors);
+}
+
+module_init(i3c_tty_init);
+module_exit(i3c_tty_exit);
+
+MODULE_LICENSE("GPL");
+
-- 
2.34.1

