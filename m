Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2052.outbound.protection.outlook.com [40.107.8.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334B414B953;
	Tue,  7 May 2024 20:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715114644; cv=fail; b=MdHeYAUfxetLTpvAj2HV+OsLrHmrP/gWVOMEXPhCgAxfzwO1B1K0HuqWydGnYVFolgBf5bTKTW9pBIB23CsSVuLt9fIB3Uh9Q0eqTB+nztuwi+nAXBlIktuPzZ6LyKDpp9wFo7bO+fOf4Gvqom/X8zV2cvtZMxDijMyy8+3KlQY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715114644; c=relaxed/simple;
	bh=IfWwbZX4or7hvEol/fhI8ZcpCMtDa9+XDI5xhrzMtZY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oUJ/5wCLRP4B7Y/BM3REyJUMfHm03Wqi2+n54PdXtUdIpZa3EcBrLm8cj3Of2CAr/g8UC6bh76Cg4iLW3sFZdanknqnC9g2gNl2bP8oQ668lLRDaFL90oSaln+1dAusHWj0fSeQxz5cjkF+YC/QsKHik0JzGCvWXUxYHXlQw1hQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=QnIOSKub; arc=fail smtp.client-ip=40.107.8.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="QnIOSKub"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hUjjFCvXhPNliSsviEeoVdLgda5neAUTLI2vAtlTYcQ87yAr6xR0ehB4f+/CJl1jwbNjAHEbksryx7LYCcXtAUqK4Uih0dTfdbBnBDECwHtOip2jSetRDGrTkqqWOmx0s60WAofEisDQ4p9HHpmfyIKc/FAwfniEDXKQSc2q3xi04oD9UF/YKZ8UtbQcD+GqZNLnG4qFfqsyaybFcw9c2MwtrkVfNoUc+FMfD/9u8nOvcf2/TUX9yOsLCMnjC0Z0bEb5TrEJuCba4YMWSW0KVO9pk9V2iFL+92NNZJRm5hea7zjfn3+LpC0DqmxJagDGD/i5dX+rwyk5nwG/TLKDlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O+bTdZ1UdLfsIwYPgB9sFk52gudfGp4cK/5ypI+uTOk=;
 b=SUq4p3WqMvWXT1XOBYYGLLX+iGMYdCq97VMpqSlPeeYRrx1OSJiLMvrfAJsYhukwrxxrPvd2MIsyP2Kbci/DQFgOjyXVBhWfdiEg5R8G4KCj9Tc4aRqqte31IOcOm7uJzphByJblMVWVWPBmCi3hTMcOnJXTI3LkSqFhDSCDwCzZ9BqNQKoUA7FpjC7ekboDRNRSKXBdk6kzONBLR8OjmqBQEOovOpzb7wJxFQqzWWudOaen25LDMt+kve8CpQGH+nvx2WxZk2hurTigxefpCnyuPhzkCbBsxCdsX8DatDXjqvvg+PNLCuZ2wTUMH5+IE2eu+HUyWuVhWq1Xufj/3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O+bTdZ1UdLfsIwYPgB9sFk52gudfGp4cK/5ypI+uTOk=;
 b=QnIOSKubmz5KX3Qllna6nw56G4Nbc7yV57LSlxDjjaDZKKOFo1WJmuhj6jZzaEJE2czPc/ZvKnnkYLyEO1XVc19Ld+VBMhjPy3sz6lc0T4woYeNg3Cpw3La3TSqmUeMD9zrGUF5AFUXEaICzCxQxPUMeGPnYODOcW81L+8WISf4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB8545.eurprd04.prod.outlook.com (2603:10a6:20b:420::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.45; Tue, 7 May
 2024 20:43:56 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 20:43:56 +0000
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
Subject: [PATCH resend v9 8/8] tty: i3c: add TTY over I3C master support
Date: Tue,  7 May 2024 16:43:11 -0400
Message-Id: <20240507204311.2898714-9-Frank.Li@nxp.com>
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB8545:EE_
X-MS-Office365-Filtering-Correlation-Id: f2c52470-f2d0-4c84-7935-08dc6ed66a58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|366007|7416005|1800799015|52116005|376005|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/j25g8Ci0K5ZS1VB0ElCFr2z86H0rD+02FoI0TXrXx/Kjdy0tlswyv2Osncf?=
 =?us-ascii?Q?63Sdzxja1B73kh56usovECFn91diTDeBaLiRaFwwkwzJT+I1SUimFCOn9j+D?=
 =?us-ascii?Q?AltzysTSyU5ErBulpSoN21yfoevyNc5sVtKRuVoRbBIotUNgTSyYgUNmZdsB?=
 =?us-ascii?Q?A9sPn/srOwGaOppYmvzkTS85ifbMxcuBd9I39VMf+VHOaK9YEm7VZV9Xxwhs?=
 =?us-ascii?Q?L4+4uwKnY+BOJmL2sJmogtsrX1awdxry317lTTsmEiH2qE+O0Hb0dSyfTF77?=
 =?us-ascii?Q?GjfRWY+tpJmJ5cECVR8/JCI4Ck4tfi7cwsDfQNGJXGKJKY0yj7uLQRcGgmMN?=
 =?us-ascii?Q?8XjonZUp4dnejTkTPfXUUmzRFOr7jIXb3UwGY4vhxs+wrxi38G9wxqxiMKyB?=
 =?us-ascii?Q?0TXS7MyulUwen0r3t68DUzq2c240jp/hXhEnSv1SNTw8lbb2EQlRh3WQj4k6?=
 =?us-ascii?Q?K050sHM28T8H2kmxaUESaqNvfuf8RtG6agqOLSHG2RulVSMrU6Fe//4pv0WF?=
 =?us-ascii?Q?sQsBTNHmKDJA+fDcfnMyTmXW64uI+8U5XTwTkhjJaRNYHxbsPaFQov1aBs+Y?=
 =?us-ascii?Q?PRxf7ECq0qQxjJZeOpBGuEvVuu+EXImxY/KavqEVS3cREr4a/r/3BDPEXchp?=
 =?us-ascii?Q?SFaRj6o5lgFExa8ydFcNWi+zuAmF8UXLxpEa25IY8mcpOuf6LR4bPQAFabDF?=
 =?us-ascii?Q?9i8PiUJwFdc1mPJPZhIHZZDWf1nCWeUG15Ucs5/G2ayCgX/Ge3JgogWG269n?=
 =?us-ascii?Q?sQvMe3XG4Lms/ny3O2MjVCrJZPoBeDmoCydzLJarsK9+cHpPHZNsu5V3ZC0Q?=
 =?us-ascii?Q?cB9fFRlc3/a7tSKuC5ZwtdQSU/Hst8jmRCyUkcj//c2BFYo2PFbUOY7Hoyql?=
 =?us-ascii?Q?qybDksD21HwsZnyh/kW6KAsdsyaKneSMD/HZgbbUuYuKv+CGW+AfEiNAuI7F?=
 =?us-ascii?Q?LW1+0IvvcMt99PaeCYmI+wuiLbJRmLKM71lUbb9hHG6QIEmCkz0EwfjJCIvI?=
 =?us-ascii?Q?rh0srXGoqymlpTkc8A9ksNrpw8DFyNCNVus7mALxZ4dB2ZMv/n4N7MXtHDUS?=
 =?us-ascii?Q?1+ewUHR7o94uhjQR24UyRDB/+yd46rUfAydUisfno3nJA8ggSRKzypXf1LDZ?=
 =?us-ascii?Q?2X0Zw/fvwaq8IUB8iE6mnjsi4tLPgsNfnSbFlIyrlpqCIGs1H9HpZFZqsKxi?=
 =?us-ascii?Q?QJdg5fVL5ew4fr7TmL9qsT8JmoXIDTY6UgD4Ld41bFeOJSJrTEN4As7Uz+zB?=
 =?us-ascii?Q?4JVrFoEosEWjYid0Iqug6Ca4/1fgx6ctgHbzlBFzhw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(1800799015)(52116005)(376005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IFyY46uDeyv30FacGZIos/mWEM3YTAPCYVoix8YNLtjnG5dSE/KKZmIDUj3s?=
 =?us-ascii?Q?Sc1jZMKSHYB8C910/TVYrXBBUh0L/6EgBoP8trd6h2PmkUUL+DYAbdvw/FQB?=
 =?us-ascii?Q?y7L4dWRl/sPTAtMJBSv8SVhHz+MCpfKoCzzycMHTWGid5f1YQosVEaB5RyMZ?=
 =?us-ascii?Q?hVE9e6M98i9lpWOIx2gxur8BCzLat+3IyS6KDcmURRY1iAgL8V5+8l8I2ndh?=
 =?us-ascii?Q?TdCdcjaV80oD8FxPXKuxCy/8zJ8AH8kDRNgtHuoEIHFTPb7/dTSepGV1oxT+?=
 =?us-ascii?Q?6iQJxaBQOxNcjIkWSOMpuUOVmYrH20pdUz1U8fQt7Wx/1yJOZNJdKxGO+LSn?=
 =?us-ascii?Q?5FW1utqg5yQpoe0o03nIYd5CZq6K35qsom9NXDjsAmd3Od3OHzmRE5FbB1GU?=
 =?us-ascii?Q?6j0mk1oYuq5F5pjV1AjtBeNMhgekbGOGNa7OQJTXiqH/zhJXqZhp+TtDezm5?=
 =?us-ascii?Q?qAgGyzD3ts2KEWKPmIKMWTEAF8DliEzPf1E3V968oBwTm9hj9fp+2RMc6bUP?=
 =?us-ascii?Q?eG6V/OwcTdu9SJQ5XxOkwzB8Ki481EKOtrzo6z77pyONigGn276EjYQBpd27?=
 =?us-ascii?Q?Ig6uAmcSjhvRFLLJbsAHCfb9lHM0ywlYUv46yOSl8Yf65bnelyLK9mYjnJgh?=
 =?us-ascii?Q?xwaoSKic2WV1FPO+XPyx1Uh2axeJ10CeUTEi4H9t61q/NMjq04Jh4ow5S2Rs?=
 =?us-ascii?Q?vj0kHV7qYB7Vd5DjymqVGHp6q9T7eOxFZRBYh/EFhs2dvBpHB0eTjEFyJDCc?=
 =?us-ascii?Q?4MyoQGR0+oW+3yKMzjSwt2ox5reeT60dPyRg0ipq2Of+r7PYg0zeBtJUjRIm?=
 =?us-ascii?Q?vImgz07fOwZdacslhGwLKuUNO6K8qi7yvTCbDxElUt1Dkw/VrCxlVh+qrHOf?=
 =?us-ascii?Q?UrjXyYe6q5KnQ8fbTWMzKm+H7RYxchc12b42Oj4bH58QuyXsIZhgbTHeXsCJ?=
 =?us-ascii?Q?G1ewaiguDXvNmJBzwZP53TZC0SXMQ1CPuVdM7x69HpzkOHk1yOn2ihX8sCI7?=
 =?us-ascii?Q?lkvvYRlUtlcaNxv2gJT6z9jBrwnF4ifDilNOUN/GR4uX5t17pIpHfd/hYkfa?=
 =?us-ascii?Q?gexbb1AX3fX2jybJ+9410XEMP4VzQ8BxDqaqgAFRtWBHU1WEklAZo5fvkwSZ?=
 =?us-ascii?Q?aH8WlzjeuQyYn2q1vPR+Ud8P5WwP8CL2drPT2V9WX/1FzfqBvIrMUg/YPro5?=
 =?us-ascii?Q?+udfyQLwxZcPzHGuFumKP2xuYBvWH4aY2qd9Tut6AIWQC2LlDX7JfWV2Xlmp?=
 =?us-ascii?Q?OuDcyB1teHdSbFIKwnCl2Ajo/pHrvdBDpFWJK4Vn2Q8hXbsh6CAsEkIry+MG?=
 =?us-ascii?Q?koZ2HSV6jZfAUbAFVc2WsI+9+6YLqPo2hPAdvUkh5wJVxFgpL+/ygGzi0l7o?=
 =?us-ascii?Q?D4Sh76t545JDnjY7hDxmJ9Mg5yfEWGxf8Mr4y6qn2yGGtbQ6vnVCpj+LtJZE?=
 =?us-ascii?Q?sYP8cET55lUCi6ESGc12sCD/CJ7BbvWjSus1xAWDe+OsvVQYyWq1DNJKaqd6?=
 =?us-ascii?Q?yXv5IjJOAUJkFaYw+HsU/+tYEqUhi+JLf4LPWJ9WXAgFRm5qVOsD+R/l0x1e?=
 =?us-ascii?Q?5DABTgaeCDpHwCMvueikREfx3mN+TdY0ztZXBo2q?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2c52470-f2d0-4c84-7935-08dc6ed66a58
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 20:43:56.7142
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C1LMAXV54znTi/b+YRekSVYCu/8Won8eTfuPJrrtTQciNRR/VPDTc0liz3KzeL+XYcZDHXqECD+tWrP8vhO+bA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8545

In typical embedded Linux systems, UART consoles require at least two pins,
TX and RX. In scenarios where I2C/I3C devices like sensors or PMICs are
present, we can save these two pins by using this driver. Pins is crucial
resources, especially in small chip packages.

This introduces support for using the I3C bus to transfer console tty data,
effectively replacing the need for dedicated UART pins. This not only
conserves valuable pin resources but also facilitates testing of I3C's
advanced features, including early termination, in-band interrupt (IBI)
support, and the creation of more complex data patterns. Additionally,
it aids in identifying and addressing issues within the I3C controller
driver.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    Notes:
        Version number use i3c target patches.
        Change from v8 to v9
        - none
    
        Change from v7 to v8
        - reorder head files
        - add missed head files
    
        Change from v6 to v7
        - try to fixed build warning
    	https://lore.kernel.org/imx/20240202230925.1000659-1-Frank.Li@nxp.com/T/#m4e35da31a4226186b3dc6bc8f2fba28f58be1188
        but I can't reproduce this error in my machine with powerpc-linux-gcc (GCC) 13.2.0
        kernel test robot have not show reproduce step.
        But anyway, status may not init if code through continue branch. So
        Move status = I3C_TTY_TARGET_RX_READY; before continue branch.
    
        Change from v5 to v6
        -none
    
        Change from v4 to v5
        - add missed header file
        - add define for BIT(0)
        - oneline for struct ttyi3c_port *sport
    
        Change from v3 to v4
        - add static at i3c_remove()
        Change v2
        - using system_unbound_wq working queue
        - fixed accoring to Jiri Slaby's comments
    
        Change before send with i3c target support
    
        Change from v4 to v5
        - send in i3c improvememtn patches.
    
        Change from v2 to v4
        - none
    
        Change from v1 to v2
        - update commit message.
        - using goto for err handle
        - using one working queue for all tty-i3c device
        - fixed typo found by js
        - update kconfig help
        - using kfifo
    
        Still below items not be fixed (according to Jiri Slaby's comments)
        - rxwork thread: need trigger from two position.
        - common thread queue: need some suggestion
    
    Notes:
        Version number use i3c target patches.
        Change from v3 to v4
        - add static at i3c_remove()
        Change v2
        - using system_unbound_wq working queue
        - fixed accoring to Jiri Slaby's comments
    
        Change before send with i3c target support
    
        Change from v4 to v5
        - send in i3c improvememtn patches.
    
        Change from v2 to v4
        - none
    
        Change from v1 to v2
        - update commit message.
        - using goto for err handle
        - using one working queue for all tty-i3c device
        - fixed typo found by js
        - update kconfig help
        - using kfifo
    
        Still below items not be fixed (according to Jiri Slaby's comments)
        - rxwork thread: need trigger from two position.
        - common thread queue: need some suggestion

 drivers/tty/Kconfig   |  13 ++
 drivers/tty/Makefile  |   1 +
 drivers/tty/i3c_tty.c | 432 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 446 insertions(+)
 create mode 100644 drivers/tty/i3c_tty.c

diff --git a/drivers/tty/Kconfig b/drivers/tty/Kconfig
index 5646dc6242cd9..9ab4cd480e9f8 100644
--- a/drivers/tty/Kconfig
+++ b/drivers/tty/Kconfig
@@ -412,6 +412,19 @@ config RPMSG_TTY
 	  To compile this driver as a module, choose M here: the module will be
 	  called rpmsg_tty.
 
+config I3C_TTY
+	tristate "TTY over I3C"
+	depends on I3C
+	help
+	  Select this option to use TTY over I3C master controller.
+
+	  This makes it possible for user-space programs to send and receive
+	  data as a standard tty protocol. I3C provide relatively higher data
+	  transfer rate and less pin numbers, SDA/SCL are shared with other
+	  devices.
+
+	  If unsure, say N
+
 endif # TTY
 
 source "drivers/tty/serdev/Kconfig"
diff --git a/drivers/tty/Makefile b/drivers/tty/Makefile
index 07aca5184a55d..f329f9c7d308a 100644
--- a/drivers/tty/Makefile
+++ b/drivers/tty/Makefile
@@ -27,5 +27,6 @@ obj-$(CONFIG_GOLDFISH_TTY)	+= goldfish.o
 obj-$(CONFIG_MIPS_EJTAG_FDC_TTY) += mips_ejtag_fdc.o
 obj-$(CONFIG_VCC)		+= vcc.o
 obj-$(CONFIG_RPMSG_TTY)		+= rpmsg_tty.o
+obj-$(CONFIG_I3C_TTY)		+= i3c_tty.o
 
 obj-y += ipwireless/
diff --git a/drivers/tty/i3c_tty.c b/drivers/tty/i3c_tty.c
new file mode 100644
index 0000000000000..235cd0524b0b7
--- /dev/null
+++ b/drivers/tty/i3c_tty.c
@@ -0,0 +1,432 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2023 NXP.
+ *
+ * Author: Frank Li <Frank.Li@nxp.com>
+ */
+
+#include <linux/bits.h>
+#include <linux/bitops.h>
+#include <linux/completion.h>
+#include <linux/console.h>
+#include <linux/delay.h>
+#include <linux/kernel.h>
+#include <linux/kfifo.h>
+#include <linux/i3c/device.h>
+#include <linux/i3c/master.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/serial_core.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/tty_flip.h>
+#include <linux/tty_port.h>
+#include <linux/workqueue.h>
+
+static DEFINE_IDR(i3c_tty_minors);
+static DEFINE_MUTEX(i3c_tty_minors_lock);
+
+static struct tty_driver *i3c_tty_driver;
+
+#define I3C_TTY_MINORS		8
+#define I3C_TTY_TRANS_SIZE	16
+#define I3C_TTY_RX_STOP		0
+#define I3C_TTY_RETRY		20
+#define I3C_TTY_YIELD_US	100
+#define I3C_TTY_TARGET_RX_READY	BIT(0)
+
+struct ttyi3c_port {
+	struct tty_port port;
+	int minor;
+	spinlock_t xlock; /* protect xmit */
+	u8 tx_buff[I3C_TTY_TRANS_SIZE];
+	u8 rx_buff[I3C_TTY_TRANS_SIZE];
+	struct i3c_device *i3cdev;
+	struct work_struct txwork;
+	struct work_struct rxwork;
+	struct completion txcomplete;
+	unsigned long status;
+	u32 buf_overrun;
+};
+
+static const struct i3c_device_id i3c_ids[] = {
+	I3C_DEVICE(0x011B, 0x1000, NULL),
+	{ /* sentinel */ },
+};
+
+static int i3c_port_activate(struct tty_port *port, struct tty_struct *tty)
+{
+	struct ttyi3c_port *sport = container_of(port, struct ttyi3c_port, port);
+	int ret;
+
+	ret = tty_port_alloc_xmit_buf(port);
+	if (ret < 0)
+		return ret;
+
+	sport->status = 0;
+
+	ret = i3c_device_enable_ibi(sport->i3cdev);
+	if (ret) {
+		tty_port_free_xmit_buf(port);
+		return ret;
+	}
+
+	return 0;
+}
+
+static void i3c_port_shutdown(struct tty_port *port)
+{
+	struct ttyi3c_port *sport = container_of(port, struct ttyi3c_port, port);
+
+	i3c_device_disable_ibi(sport->i3cdev);
+	tty_port_free_xmit_buf(port);
+}
+
+static void i3c_port_destruct(struct tty_port *port)
+{
+	struct ttyi3c_port *sport = container_of(port, struct ttyi3c_port, port);
+
+	mutex_lock(&i3c_tty_minors_lock);
+	idr_remove(&i3c_tty_minors, sport->minor);
+	mutex_unlock(&i3c_tty_minors_lock);
+}
+
+static const struct tty_port_operations i3c_port_ops = {
+	.shutdown = i3c_port_shutdown,
+	.activate = i3c_port_activate,
+	.destruct = i3c_port_destruct,
+};
+
+static ssize_t i3c_write(struct tty_struct *tty, const unsigned char *buf, size_t count)
+{
+	struct ttyi3c_port *sport = tty->driver_data;
+	unsigned long flags;
+	bool is_empty;
+	int ret;
+
+	spin_lock_irqsave(&sport->xlock, flags);
+	ret = kfifo_in(&sport->port.xmit_fifo, buf, count);
+	is_empty = kfifo_is_empty(&sport->port.xmit_fifo);
+	spin_unlock_irqrestore(&sport->xlock, flags);
+
+	if (!is_empty)
+		queue_work(system_unbound_wq, &sport->txwork);
+
+	return ret;
+}
+
+static int i3c_put_char(struct tty_struct *tty, unsigned char ch)
+{
+	struct ttyi3c_port *sport = tty->driver_data;
+	unsigned long flags;
+	int ret;
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
+
+	queue_work(system_unbound_wq, &sport->txwork);
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
+	clear_bit(I3C_TTY_RX_STOP, &sport->status);
+}
+
+static void i3c_unthrottle(struct tty_struct *tty)
+{
+	struct ttyi3c_port *sport = tty->driver_data;
+
+	set_bit(I3C_TTY_RX_STOP, &sport->status);
+
+	queue_work(system_unbound_wq, &sport->rxwork);
+}
+
+static int i3c_open(struct tty_struct *tty, struct file *filp)
+{
+	struct ttyi3c_port *sport = container_of(tty->port, struct ttyi3c_port, port);
+
+	tty->driver_data = sport;
+
+	return tty_port_open(&sport->port, tty, filp);
+}
+
+static void i3c_close(struct tty_struct *tty, struct file *filp)
+{
+	tty_port_close(tty->port, tty, filp);
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
+};
+
+static void i3c_controller_irq_handler(struct i3c_device *dev,
+				       const struct i3c_ibi_payload *payload)
+{
+	struct ttyi3c_port *sport = dev_get_drvdata(&dev->dev);
+
+	/* i3c_unthrottle also queue the work to fetch pending data in target side */
+	queue_work(system_unbound_wq, &sport->rxwork);
+}
+
+static void tty_i3c_rxwork(struct work_struct *work)
+{
+	struct ttyi3c_port *sport = container_of(work, struct ttyi3c_port, rxwork);
+	struct i3c_priv_xfer xfers;
+	u32 retry = I3C_TTY_RETRY;
+	u16 status;
+	int ret;
+
+	memset(&xfers, 0, sizeof(xfers));
+	xfers.data.in = sport->rx_buff;
+	xfers.len = I3C_TTY_TRANS_SIZE;
+	xfers.rnw = 1;
+
+	do {
+		if (test_bit(I3C_TTY_RX_STOP, &sport->status))
+			break;
+
+		i3c_device_do_priv_xfers(sport->i3cdev, &xfers, 1);
+
+		status = I3C_TTY_TARGET_RX_READY;
+
+		if (xfers.actual_len) {
+			ret = tty_insert_flip_string(&sport->port, sport->rx_buff,
+						     xfers.actual_len);
+			if (ret < xfers.actual_len)
+				sport->buf_overrun++;
+
+			retry = I3C_TTY_RETRY;
+			continue;
+		}
+
+		i3c_device_getstatus_format1(sport->i3cdev, &status);
+		/*
+		 * Target side needs some time to fill data into fifo. Target side may not
+		 * have hardware update status in real time. Software update status always
+		 * needs some delays.
+		 *
+		 * Generally, target side have circular buffer in memory, it will be moved
+		 * into FIFO by CPU or DMA. 'status' just show if circular buffer empty. But
+		 * there are gap, especially CPU have not response irq to fill FIFO in time.
+		 * So xfers.actual will be zero, wait for little time to avoid flood
+		 * transfer in i3c bus.
+		 */
+		usleep_range(I3C_TTY_YIELD_US, 10 * I3C_TTY_YIELD_US);
+		retry--;
+
+	} while (retry && (status & I3C_TTY_TARGET_RX_READY));
+
+	tty_flip_buffer_push(&sport->port);
+}
+
+static void tty_i3c_txwork(struct work_struct *work)
+{
+	struct ttyi3c_port *sport = container_of(work, struct ttyi3c_port, txwork);
+	struct i3c_priv_xfer xfers;
+	u32 retry = I3C_TTY_RETRY;
+	unsigned long flags;
+	int ret;
+
+	xfers.rnw = 0;
+	xfers.data.out = sport->tx_buff;
+
+	while (!kfifo_is_empty(&sport->port.xmit_fifo)) {
+		spin_lock_irqsave(&sport->xlock, flags);
+		xfers.len = kfifo_out_peek(&sport->port.xmit_fifo, sport->tx_buff,
+					   I3C_TTY_TRANS_SIZE);
+		spin_unlock_irqrestore(&sport->xlock, flags);
+		ret = i3c_device_do_priv_xfers(sport->i3cdev, &xfers, 1);
+		if (ret) {
+			/*
+			 * Target side may not move data out of FIFO. delay can't resolve problem,
+			 * just reduce some possiblity. Target can't end I3C SDR mode write
+			 * transfer, discard data is reasonable when FIFO overrun.
+			 */
+			usleep_range(I3C_TTY_YIELD_US, 10 * I3C_TTY_YIELD_US);
+			retry--;
+		} else {
+			retry = I3C_TTY_RETRY;
+		}
+
+		if (ret == 0 || retry == 0) {
+			/* when retry == 0, means need discard the data */
+			spin_lock_irqsave(&sport->xlock, flags);
+			ret = kfifo_out(&sport->port.xmit_fifo, sport->tx_buff, xfers.len);
+			spin_unlock_irqrestore(&sport->xlock, flags);
+		}
+	}
+
+	spin_lock_irqsave(&sport->xlock, flags);
+	if (kfifo_len(&sport->port.xmit_fifo) < WAKEUP_CHARS)
+		tty_port_tty_wakeup(&sport->port);
+	spin_unlock_irqrestore(&sport->xlock, flags);
+}
+
+static int i3c_probe(struct i3c_device *i3cdev)
+{
+	struct ttyi3c_port *sport;
+	struct device *tty_dev;
+	struct i3c_ibi_setup req;
+	int minor;
+	int ret;
+
+	sport = devm_kzalloc(&i3cdev->dev, sizeof(*sport), GFP_KERNEL);
+	if (!sport)
+		return -ENOMEM;
+
+	sport->i3cdev = i3cdev;
+
+	dev_set_drvdata(&i3cdev->dev, sport);
+
+	req.max_payload_len = 8;
+	req.num_slots = 4;
+	req.handler = &i3c_controller_irq_handler;
+
+	ret = i3c_device_request_ibi(i3cdev, &req);
+	if (ret)
+		return -EINVAL;
+
+	mutex_lock(&i3c_tty_minors_lock);
+	minor = idr_alloc(&i3c_tty_minors, sport, 0, I3C_TTY_MINORS, GFP_KERNEL);
+	mutex_unlock(&i3c_tty_minors_lock);
+
+	if (minor < 0) {
+		ret = -EINVAL;
+		goto err_idr_alloc;
+	}
+
+	spin_lock_init(&sport->xlock);
+	INIT_WORK(&sport->txwork, tty_i3c_txwork);
+	INIT_WORK(&sport->rxwork, tty_i3c_rxwork);
+	init_completion(&sport->txcomplete);
+
+	tty_port_init(&sport->port);
+	sport->port.ops = &i3c_port_ops;
+
+	tty_dev = tty_port_register_device(&sport->port, i3c_tty_driver, minor,
+					   &i3cdev->dev);
+	if (IS_ERR(tty_dev)) {
+		ret = PTR_ERR(tty_dev);
+		goto err_tty_port_register;
+	}
+
+	sport->minor = minor;
+
+	return 0;
+
+err_tty_port_register:
+	tty_port_put(&sport->port);
+
+	mutex_lock(&i3c_tty_minors_lock);
+	idr_remove(&i3c_tty_minors, minor);
+	mutex_unlock(&i3c_tty_minors_lock);
+
+err_idr_alloc:
+	i3c_device_free_ibi(i3cdev);
+
+	return ret;
+}
+
+static void i3c_remove(struct i3c_device *dev)
+{
+	struct ttyi3c_port *sport = dev_get_drvdata(&dev->dev);
+
+	tty_port_unregister_device(&sport->port, i3c_tty_driver, sport->minor);
+	cancel_work_sync(&sport->txwork);
+
+	tty_port_put(&sport->port);
+
+	mutex_lock(&i3c_tty_minors_lock);
+	idr_remove(&i3c_tty_minors, sport->minor);
+	mutex_unlock(&i3c_tty_minors_lock);
+
+	i3c_device_free_ibi(sport->i3cdev);
+}
+
+static struct i3c_driver i3c_driver = {
+	.driver = {
+		.name = "ttyi3c",
+	},
+	.probe = i3c_probe,
+	.remove = i3c_remove,
+	.id_table = i3c_ids,
+};
+
+static int __init i3c_tty_init(void)
+{
+	int ret;
+
+	i3c_tty_driver = tty_alloc_driver(I3C_TTY_MINORS,
+					  TTY_DRIVER_REAL_RAW | TTY_DRIVER_DYNAMIC_DEV);
+
+	if (IS_ERR(i3c_tty_driver))
+		return PTR_ERR(i3c_tty_driver);
+
+	i3c_tty_driver->driver_name = "ttyI3C";
+	i3c_tty_driver->name = "ttyI3C";
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
+		goto err_tty_register_driver;
+
+	ret = i3c_driver_register(&i3c_driver);
+	if (ret)
+		goto err_i3c_driver_register;
+
+	return 0;
+
+err_i3c_driver_register:
+	tty_unregister_driver(i3c_tty_driver);
+
+err_tty_register_driver:
+	tty_driver_kref_put(i3c_tty_driver);
+
+	return ret;
+}
+
+static void __exit i3c_tty_exit(void)
+{
+	i3c_driver_unregister(&i3c_driver);
+	tty_unregister_driver(i3c_tty_driver);
+	tty_driver_kref_put(i3c_tty_driver);
+	idr_destroy(&i3c_tty_minors);
+}
+
+module_init(i3c_tty_init);
+module_exit(i3c_tty_exit);
+
+MODULE_LICENSE("GPL");
-- 
2.34.1

