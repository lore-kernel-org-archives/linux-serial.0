Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022130.outbound.protection.outlook.com [52.101.126.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB08A29B229;
	Sun, 30 Nov 2025 10:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764499570; cv=fail; b=inE9HZVmThtBctaq2uhY9/1IoCuCLamlN4DaA47TkrVws/GEM9kQEOCPEaiFroXd0qX8SYy8lcfTHA4ExdAuj+Nc1lBE966JAxi+upIMY+6ofE4yvZ67KueC8VWvxUY980Jbyv5c0BANEavX3QoH2/A5onFhmxifvo5IS3F6MDc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764499570; c=relaxed/simple;
	bh=eqIDt0C3I0ZfV32yuETu3UQVEC/mNtZksEqDPC08bso=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nIKKEbgPMMA43A4bEhBlU1qnwKuKZRYwacj+SOS5gLqptd07/sMdBjqxLcPMoNUPFz5Tvw6xEuw25Mb0sp2PP/22rZyP+OARGF+e0dDF/u50O28redA5GqBjCnRs6wIDui1cFQRjfGc2HFb8xSTKObFlXsVxvTs2YDLmPP7O0z8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com; spf=pass smtp.mailfrom=moxa.com; dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b=NQd+JMRq; arc=fail smtp.client-ip=52.101.126.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moxa.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b="NQd+JMRq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IPDepvqBt+K3A9Pe/7guTdq6GqwpBJrhlYw9RXg/78TT0X9QbIR4UsyYpCNG/kuDU/T41cPvcnn0JH5cO/vH4KjRRBPY/tWkC4nf6BDoFWRXZUgd1dirDHPgGneF/B69fR29QBEZnHGjqGhJ+rmufmHFx6/5x5iPl8HyjebGN0lL7mpvQ6l31smuMjNLFe5yomxHNq56qD0+LgCvNZA3+/q8K6cHUrzdA+h0RTvDc58eoHW9qpycZarfOscJ6As3G/VUd328eHy5O9MX9PEq9pNqgpLTccI8yOJp/DRq5R+zHDUZwjYVTWjTo5QTEvN1zAqyNHtnuHiQyQaauT1oRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tsySM/BVNd6YHtU/UE53frsMpGRj48eAGbCoGwwnLbc=;
 b=APYaLJIHtn9gX+2i2Db4qxk6BD8BLbR6yvrp9RyXCobox5wI3qT8nk+0leUyx+MQir5pmS++7xolj8BidpIHIbtAdChCIuz6dx8RHZRNWqRdkQojyGbGNUj59pqlLyCzIEf58TPquoSwD76iaxyRdKSJ2ZNAwmwy4+Wm23hOENhhKDaAkB6YbNchxJmN7vzeLMypWvdJ/DjO2fk07ccYs1pAdJ1PxK7QdNngBz5a8+8oRzLf9tuMYVztj1eppgd0PMQmt8V5tuINQrSP41VVGQKntGBigdg6Izu3mAaV5XFU6vi6G4vkwd/pJJTxxZ/B+AVcEXgXnMWAeDTBj8XeYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tsySM/BVNd6YHtU/UE53frsMpGRj48eAGbCoGwwnLbc=;
 b=NQd+JMRqMihf1tNofKWdyb1nNzTUY/vpQZiOGpT53tP20Fqfqpu7QaeXFwV9kCo2yAKaYr7GaoSyTfevfJCQwFsGan6UIZHWvHQXZlMVBkn0ffLxIf89MgAmD6MtLu0gKiIhWARI2R4Fd7696/x1J+uEuWTvVIqfBIGyXplFDV4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14) by SEZPR01MB6080.apcprd01.prod.exchangelabs.com
 (2603:1096:101:221::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Sun, 30 Nov
 2025 10:46:01 +0000
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::60ab:8615:ab67:8817]) by PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::60ab:8615:ab67:8817%6]) with mapi id 15.20.9320.013; Sun, 30 Nov 2025
 10:46:01 +0000
From: Crescent Hsieh <crescentcy.hsieh@moxa.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	andy.shevchenko@gmail.com
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	crescentcy.hsieh@moxa.com
Subject: [PATCH v1 30/31] serial: 8250_mxpcie: Add sysfs to control pull state via CPLD
Date: Sun, 30 Nov 2025 18:42:21 +0800
Message-ID: <20251130104222.63077-31-crescentcy.hsieh@moxa.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251130104222.63077-1-crescentcy.hsieh@moxa.com>
References: <20251130104222.63077-1-crescentcy.hsieh@moxa.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TPYP295CA0001.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:9::18) To PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR01MB5405:EE_|SEZPR01MB6080:EE_
X-MS-Office365-Filtering-Correlation-Id: 58b91b61-b408-4254-20b6-08de2ffda766
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?libA1FY2n+2dJaeUUlUe8e1rXTfJ4Xc4gNyMpd0QAO8Jj6wm5C/jj4ni1DAa?=
 =?us-ascii?Q?8ZA/0rB+aYxOLh0SwKKl86OCoVUirkxniX/xRh7djxvNaskVQTMUekt/nWD6?=
 =?us-ascii?Q?xmvkumtrKoNwFEFi5x/MQQ0Dq87OdLbq6iFYBZwCMNJFeFth2CcijLlAXAmj?=
 =?us-ascii?Q?4JrLGK0ktH5bmCRPqZsydWjq+H1vPEOZk7ue36OSKae/9DbzjN9Z9xKnkXYh?=
 =?us-ascii?Q?ATWACwa8IjDaoItKyFRgsi7cu1k6n94Vj6mAxZUodbxwR6g9QNiuOnDcjMPj?=
 =?us-ascii?Q?5VDujRfYaAFy++OpzyUWxYlS8mapgGMXKZ515+8ZKYDcymn22yZwVu5KSkVJ?=
 =?us-ascii?Q?wmeMiRN3B1GtUB6QmraRGYrQqj4j90sjZS7bBOSdaRVtMYgPDvKLwgMetEm2?=
 =?us-ascii?Q?4whIjLTf5V+LdMHvVATCW6T4RQ3vnk7yadnEGLhX5zNzvPYHzDesC17qONy4?=
 =?us-ascii?Q?KTDZmvXuVa6BIREqJT1woRCWh/7SSpOhO8kQnLnvKULYROiX/z5lved4UFtW?=
 =?us-ascii?Q?v6Sxjve9+o2wYI58vIxm4VKgmL09IjAob2mJKmevILUdn/t1ZoNGmuh4C3CE?=
 =?us-ascii?Q?F2ljIFe2W9O49oHQNR7JEAQPLSm9HsMk0iXy9KOmlx/QVEnx0ovQuInNQO3W?=
 =?us-ascii?Q?oUQPDINKT941eEuLf1gsFj/bspPOxf/etwKHQXEgkWVSVdfyv/F00ifxZfeG?=
 =?us-ascii?Q?ADUSFrU/mQZdp82EyICYLx0KEsfu6ZYFJC8tTDRo7h3mBMO4NPj23+LfXVy2?=
 =?us-ascii?Q?FWnlEZVst91Il01c64qQWA3ro3n5eSrwSLfHptwIDBkq4fiB6MXj1NBWtBoV?=
 =?us-ascii?Q?sAim94dFnj393RWnIdiBCvx22QE6CSWkQc9DWebmaj6WHpqiGbjjVbb6KJNE?=
 =?us-ascii?Q?nqq0g2yjJZxSneukIH1JI4f5A3v8Ij9f72iJeCfYdUmC0yhpn1WocWQ76HuS?=
 =?us-ascii?Q?18kLk5POTh+R1enP3e2RfhMAryaWYwiUEO6xRJlMvmiGrsO1X4DiUN2UXkZJ?=
 =?us-ascii?Q?hsJVKGjrO3HI1cTZ+vLCKPCfSwcoC5K6uOi9R+6OofdQhM7PVUEExNpCYxYN?=
 =?us-ascii?Q?0oxJfOyzD7//dzTAMRlc68wEzfduijfUPM+WAEt3ouJXq0YPPXwaeLBfZK4I?=
 =?us-ascii?Q?04ze0Ep7vrX8cM4ILjK6dpMQyejqi8RiaCMrW0a/akHnD2CDSthRJXcn0I/q?=
 =?us-ascii?Q?NLJPT0lFRQDctugn8GOrSKtBrl55/dSp0YiI/BbJyhu0Y3314bpictBpIonL?=
 =?us-ascii?Q?ST5exTG4Fqn4LEB1gk7k/MjHM5Er9JETf3hk8lWOoy2cnzB5mINWiV/jpXt4?=
 =?us-ascii?Q?CfHckeSRXgWddjnUbHECHj0IzeHUBdu7abLgz8ckXSiqCOfoao0eO0lEsl6E?=
 =?us-ascii?Q?C5F2NnGPfasYYjBcFUJT3LUxeV9kFjMFEh0XAfvWT1ULmDltDLPLl9iZ5LcD?=
 =?us-ascii?Q?HUbZST8jgRfbEYnxXFCigHOh2eO3IcQFHnqVicphTAryLTBCMOqTRLE389yD?=
 =?us-ascii?Q?qoveaDOv85bP+kBg+UcM9kbpI+VK2OKGEW8O?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR01MB5405.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?R+8kSNbefytcqqFbJ7eZkOxF12+DmH1TngW7jm6aSCxVAhdn7Ptn7ii/oyes?=
 =?us-ascii?Q?O4zn34U1JWd2iGg9fi0cpo1LaqKBEpEQycCs8j8rK+fL+m+7of59bjpF/vyE?=
 =?us-ascii?Q?QDm28twt7V6X/hGgs2tDK3AJ9w2Pxzi8wewFuQGv19hnFQfBeV73jazdw1pW?=
 =?us-ascii?Q?yXTV9uT9ufCa6HIRTYjQ4ubDgqhNMqjHONSgNjk3/UJT+KBWFtTCJ0LAO0FN?=
 =?us-ascii?Q?lG1/Kdb6zwP7mJGAV8MG9EYpKv6TxwvOP+2B5J96jux3IqCvgvYDL8VL7h9i?=
 =?us-ascii?Q?6pdeUFhoVXZ4e70ir728URUNAtzCnkHBzk9kCzc8LwTceBED0h/+uhyQB9eV?=
 =?us-ascii?Q?FAgKcfkSxXSeGVBHkNmBNxxwpH1M/kTdKKdWy6D5s9xQRu0E6ycUUVZL+pcU?=
 =?us-ascii?Q?W6XEGScQpvX1m0ZFwbLqnnrB50DwTu2c1w6mRB4fRel9z7H3sIBQ/SaPX8sB?=
 =?us-ascii?Q?u9+FHGIGA3uGXANXGJ90ueXLQOBgnyh5QlUnO5ytLq1/YQFLIeHJbW9S3rpT?=
 =?us-ascii?Q?lCOMKAHRB/f86DAWO9IwG/DklC5D/c3DEYsjv6+zMIZ0ChfXs4zCBr8eSqrJ?=
 =?us-ascii?Q?VckKANOCve6z025nRjR4rBktlpJM8kj0+LOc4Jok8nCwoSQ3sSL2M3C51Kyo?=
 =?us-ascii?Q?G2Y8/vHJ1DqWxXW8ofbEeqKYKQ2sr3jbxpUJxu4qWmjrHIUuCNrcKtJA+LNm?=
 =?us-ascii?Q?bQITXPD1PwzyP7yYIqng2uooTRXJAmUgm5TCxaIfd3pU9mZBv0JBtH1+wstt?=
 =?us-ascii?Q?FpMw1IJ5Q9nc/Wp2ct0/Gp2wk7/061CtIZUhqXcMv/W+ASLzWyKBq7FZtily?=
 =?us-ascii?Q?iHqrQVCGc70VaNR5tCsqmiRWy0fvRi+2kYAAuwqxEzH9wAIKb/Dfc0CW+tSB?=
 =?us-ascii?Q?yh1W/npC0XuYPDNLgvNlxqyWyq1Cr9Td2FUyCkiGo7QVhzMfgWxgjnCQjutd?=
 =?us-ascii?Q?3aT6vOdNKZUCpGZjJDhepu3XZN7fQRYzUCDXPoetpkJR2nZhokZQa40+RnKH?=
 =?us-ascii?Q?mZRP03sSjmZqrXthPdiTn9ntlRw/VjyiGdJqtohKEx1MfDrloBxP174Lak+g?=
 =?us-ascii?Q?XUuiuR5UPnDcG3vy5VyVLUHLfPI+EHDSDq2PJ2vvJ2aBhtBj84g/zzNeClZ1?=
 =?us-ascii?Q?6XWtNInZeD/ILpyZ9uCraYhwqdhRcdN2KYqEkyoTaptep3CprYu2mRMBtMZU?=
 =?us-ascii?Q?ihY+/g3KVzL2Jv9di5CpfXeQauRxz5Vh5UGwewvC8xCEvGmZVudoWhdklEtR?=
 =?us-ascii?Q?ODIwXNEca7A77eKAFaANlbXpNpH9ZZ/nmbvuPhUL5ubN206wvQ5fTf+2r/gy?=
 =?us-ascii?Q?yQ2WXGEE96KbOh18jwZCdclNh1zlDAWuR8TJa9wuCDAK48fuxN8SRTdETUgu?=
 =?us-ascii?Q?HDQrmkUM5PmAkthH9QVcqI8A0CjrcgnUs7OKXOvMGaP7Mz2jamyJA1Ncm93s?=
 =?us-ascii?Q?pBSerlGlFWRpR83/REZ7fATpUCSjakad5xQ1q7aZp7bNQE5oHVtpYCiyAZO1?=
 =?us-ascii?Q?o7h37TGy/J4OHaMgJc5GwEh8P7QYt4Hvd1RUCwkepZSRmVWMqx5zYxlqQzHx?=
 =?us-ascii?Q?aS5OS/FOmi9iCi+lJdIbnbbGDEcM+E3EcxNodszEliKiEwU6s0SW8IIb//lT?=
 =?us-ascii?Q?6g=3D=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58b91b61-b408-4254-20b6-08de2ffda766
X-MS-Exchange-CrossTenant-AuthSource: PUZPR01MB5405.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2025 10:46:01.5752
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v13tzn/qTwLEv9g5tc1D2SsTDHDfKLOTPTzb3y95BJiNC5MEj2dm5D8viIZDEgomn1/Lq4ezHUUhAbLWJ4VGZQPQGQeLRypXwQRut3zQBWE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR01MB6080

Some Moxa PCIe boards provide a CPLD-controlled pull/bias state.
Expose a per-port sysfs attribute to read and set the pull state from
userspace.

This patch:
- Defines MOXA_CPLD_PULL_STATE_FLAG and {ENABLE,DISABLE} values.
- Implements mxpcie8250_cpld_{set,get}_pull_state() with board_lock
  to serialize CPLD access.
- Exports "mxpcie8250_pull_state" in the driver's attr group.
- Restricts support to CPLD-based models (CP118E-A-I, CP138E-A,
  CP134EL-A, CP116E-A-A, CP116E-A-B); return -ENODEV on others.

Example:
  # Enable pull state on ttyS*
  echo 1 > /sys/class/tty/ttyS*/mxpcie8250_pull_state

  # Query pull state
  cat /sys/class/tty/ttyS*/mxpcie8250_pull_state
  enabled

Signed-off-by: Crescent Hsieh <crescentcy.hsieh@moxa.com>
---
 drivers/tty/serial/8250/8250_mxpcie.c | 133 ++++++++++++++++++++++++++
 1 file changed, 133 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_mxpcie.c b/drivers/tty/serial/8250/8250_mxpcie.c
index 9dcb91b917a0..e9e3d03b7712 100644
--- a/drivers/tty/serial/8250/8250_mxpcie.c
+++ b/drivers/tty/serial/8250/8250_mxpcie.c
@@ -110,6 +110,7 @@
 #define MOXA_CPLD_DATA_MASK	0x1F	/* Pin0 ~ Pin4 */
 #define MOXA_CPLD_CTRL_MASK	0xE0	/* Pin5 ~ Pin7 */
 
+#define MOXA_CPLD_PULL_STATE_FLAG	0x01
 #define MOXA_CPLD_TERMINATOR_FLAG	0x02
 
 #define MOXA_CPLD_READ	0
@@ -121,6 +122,9 @@
 #define MOXA_TERMINATOR_ENABLE	1
 #define MOXA_TERMINATOR_DISABLE	0
 
+#define MOXA_PULL_STATE_ENABLE	1
+#define MOXA_PULL_STATE_DISABLE	0
+
 #define MOXA_UIR_OFFSET		0x04
 #define MOXA_UIR_RS232		0x00
 #define MOXA_UIR_RS422		0x01
@@ -509,6 +513,59 @@ static int mxpcie8250_cpld_get_terminator(resource_size_t iobar_addr, u8 port_id
 	return MOXA_TERMINATOR_DISABLE;
 }
 
+/**
+ * mxpcie8250_cpld_set_pull_state() - Set the pull state of the specified port
+ * @iobar_addr:	The base address of the GPIO I/O region
+ * @port_idx:	The port index (0 to 7)
+ * @state:	Desired pull state (MOXA_PULL_STATE_ENABLE or MOXA_PULL_STATE_DISABLE)
+ *
+ * Updates the pull state setting in the CPLD for the specified port by reading
+ * the current state, modifying the pull state bit, and writing the updated
+ * state back to the CPLD.
+ */
+static void mxpcie8250_cpld_set_pull_state(resource_size_t iobar_addr, u8 port_idx, u8 state)
+{
+	u8 addr, data;
+
+	addr = MOXA_CPLD_GET_STATE_BASE + port_idx;
+	mxpcie8250_cpld_read(iobar_addr, addr, &data);
+
+	data = data & MOXA_CPLD_STATE_MASK;
+
+	if (state == MOXA_PULL_STATE_ENABLE)
+		data |= MOXA_CPLD_PULL_STATE_FLAG;
+	else
+		data &= ~MOXA_CPLD_PULL_STATE_FLAG;
+
+	addr = MOXA_CPLD_SET_STATE_BASE + port_idx;
+	mxpcie8250_cpld_write(iobar_addr, addr, data);
+}
+
+/**
+ * mxpcie8250_cpld_get_pull_state() - Get the pull state of the specified port
+ * @iobar_addr:	The base address of the GPIO I/O region
+ * @port_idx:	The port index (0 to 7)
+ *
+ * Reads the pull state from the CPLD by accessing the appropriate GET_STATE
+ * register for the specified port using GPIO-based communication.
+ *
+ * Returns:
+ * 	MOXA_PULL_STATE_ENABLE  if pull state is enabled,
+ * 	MOXA_PULL_STATE_DISABLE if pull state is disabled.
+ */
+static int mxpcie8250_cpld_get_pull_state(resource_size_t iobar_addr, u8 port_idx)
+{
+	u8 addr, data;
+
+	addr = MOXA_CPLD_GET_STATE_BASE + port_idx;
+	mxpcie8250_cpld_read(iobar_addr, addr, &data);
+
+	if (data & MOXA_CPLD_PULL_STATE_FLAG)
+		return MOXA_PULL_STATE_ENABLE;
+
+	return MOXA_PULL_STATE_DISABLE;
+}
+
 static bool mxpcie8250_is_mini_pcie(unsigned short device)
 {
 	if (device == PCI_DEVICE_ID_MOXA_CP102N ||
@@ -1003,10 +1060,86 @@ static ssize_t mxpcie8250_terminator_show(struct device *dev,
 	return sysfs_emit(buf, "disabled\n");
 }
 
+static ssize_t mxpcie8250_pull_state_store(struct device *dev,
+					   struct device_attribute *attr,
+					   const char *buf,
+					   size_t count)
+{
+	struct tty_port *tport = dev_get_drvdata(dev);
+	struct uart_state *ustate = container_of(tport, struct uart_state, port);
+	struct uart_port *port = ustate->uart_port;
+	struct pci_dev *pdev = to_pci_dev(port->dev);
+	struct mxpcie8250 *priv = pci_get_drvdata(pdev);
+	resource_size_t iobar_addr = pci_resource_start(pdev, 2);
+	int ret;
+	u8 state;
+
+	if (!count)
+		return -EINVAL;
+
+	ret = kstrtou8(buf, 10, &state);
+
+	if (ret < 0)
+		return ret;
+
+	if (state != MOXA_PULL_STATE_ENABLE && state != MOXA_PULL_STATE_DISABLE)
+		return -EINVAL;
+
+	if (priv->port[port->port_id].interface == MOXA_UIR_RS232) {
+		dev_warn(dev, "The serial interface of this port cannot be RS232\n");
+		return -EINVAL;
+	}
+	if (pdev->device == PCI_DEVICE_ID_MOXA_CP118E_A_I ||
+	    pdev->device == PCI_DEVICE_ID_MOXA_CP138E_A   ||
+	    pdev->device == PCI_DEVICE_ID_MOXA_CP134EL_A  ||
+	    pdev->device == PCI_DEVICE_ID_MOXA_CP116E_A_A ||
+	    pdev->device == PCI_DEVICE_ID_MOXA_CP116E_A_B) {
+		spin_lock(&priv->board_lock);
+		mxpcie8250_cpld_set_pull_state(iobar_addr, port->port_id, state);
+		spin_unlock(&priv->board_lock);
+
+		return count;
+	}
+
+	return -ENODEV;
+}
+
+static ssize_t mxpcie8250_pull_state_show(struct device *dev,
+					  struct device_attribute *attr,
+					  char *buf)
+{
+	struct tty_port *tport = dev_get_drvdata(dev);
+	struct uart_state *ustate = container_of(tport, struct uart_state, port);
+	struct uart_port *port = ustate->uart_port;
+	struct pci_dev *pdev = to_pci_dev(port->dev);
+	struct mxpcie8250 *priv = pci_get_drvdata(pdev);
+	resource_size_t iobar_addr = pci_resource_start(pdev, 2);
+	int ret;
+
+	if (pdev->device == PCI_DEVICE_ID_MOXA_CP118E_A_I ||
+	    pdev->device == PCI_DEVICE_ID_MOXA_CP138E_A   ||
+	    pdev->device == PCI_DEVICE_ID_MOXA_CP134EL_A  ||
+	    pdev->device == PCI_DEVICE_ID_MOXA_CP116E_A_A ||
+	    pdev->device == PCI_DEVICE_ID_MOXA_CP116E_A_B) {
+		spin_lock(&priv->board_lock);
+		ret = mxpcie8250_cpld_get_pull_state(iobar_addr, port->port_id);
+		spin_unlock(&priv->board_lock);
+
+		if (ret == MOXA_PULL_STATE_ENABLE)
+			return sysfs_emit(buf, "enabled\n");
+
+		return sysfs_emit(buf, "disabled\n");
+	}
+
+	return -ENODEV;
+}
+
 static DEVICE_ATTR_RW(mxpcie8250_terminator);
+static DEVICE_ATTR_RW(mxpcie8250_pull_state);
 
 static struct attribute *mxpcie8250_dev_attrs[] = {
 	&dev_attr_mxpcie8250_terminator.attr,
+	&dev_attr_mxpcie8250_pull_state.attr,
 	NULL
 };
 
-- 
2.45.2

