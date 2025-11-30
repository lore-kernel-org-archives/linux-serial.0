Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022082.outbound.protection.outlook.com [52.101.126.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E1D29A9C3;
	Sun, 30 Nov 2025 10:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764499555; cv=fail; b=gZUC81yv2XCvs7iFC3z5XpVnEcbiJ8pmRgLNn0iOf6WljvuyO2wBcMM+5P2KiU6cLdXd/QVLcSj4N+sctlxivZifniKliZraBOuKuMS4lJcxQ00PcYV4NxbIfPodnInu8QTcNvhvU1nrUIVSBFbsjVbV+2ifBE0dM+xu/zkQ8FM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764499555; c=relaxed/simple;
	bh=nl3k2Mj+c/mNFaNGLjnuWDtymxTzHWdR1zkh1hYCGTo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=The6jbQ1EUNFEId+AhOFwaC9uCG+z8jmBZOUvWZPsZcBsDhR9e5wq7icV6/iCmFIdTowQb8/TNAvrh4lIr6l0KvudZn4CAZGnGXaiafn1AVbRPBOa/h6IOzmrzGwp6VPeddj92l+hAcDCcWaYSlocuh2dXEJ/XkBIEtGsV5avOc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com; spf=pass smtp.mailfrom=moxa.com; dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b=bwbQKwsT; arc=fail smtp.client-ip=52.101.126.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moxa.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b="bwbQKwsT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V/QLEFs3CTg8isBs8BgMXSR+pZaKM+KZNHgHIbxiGzSspOiXNE+fzL1ThMx/df1SzkmtzBmbAzD7/in9w3CFPPJ42Q6pJJR1Pecub8BROrWjcsejl4AuRRAuMSYFwVx6Boy3rtWjH1CjuKthRQxLO2UMr363Cv3gHvmTKFsTTD7c0kbPhMS53j/yIH7wD6UhJuVVJziRf3fFCLw5P+71zsu6sS2bSWx6bU2CPfZkE0ncCXRjkGduVkg+UmGFMBeT21AHZ240bZQVCk5ZMliuCiswtgK42USFbeXJ8Jo6+lWDiR51IlODMUptwVjKXgjY47MJW9zRuAK3l1J+UmrxFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pV89XLRrF9SgxFg7bvnJaNrsTRbOKPOjUimAI+j+AP0=;
 b=tbzXRf534QrqhDRfC3STyQGblbWDeOBVUPGYPmpXy744RpRVXQdQlZlxQr1csDT45xuiHTTQUlhxBueJUqYGWvnE7WpjkbOYZb2NXTAk2IjwUSp4J2OVv0PichDynoJ3LAlFCZBWgm0VZRm3G3ELhkeZYpUe59ZY98+riU3dDPm5TN7Hcus6vBnNl2sk9WCOxVvEPCyTnYD2dbSVwWa2veTTUarHlTVjc7n359dtb8XYwKwF3fUJTOlEcXmRwiOBlafyzEfXwdHAyVB4O5CDfR/Ti/LgcnEedfTsoHt94m6oPArzcpod/BaSXgo5t5EFs5T8rxE/ELnFPAqZUoUMYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pV89XLRrF9SgxFg7bvnJaNrsTRbOKPOjUimAI+j+AP0=;
 b=bwbQKwsT7TLec/qOsNmZjytS3+8M1HnMSxxMPMDdHh0mShM7H67AHX3Aizyo2Bsgkx94VfIwxtMH0xvj1PEPtKYUawd3nCH7kPMvS/c9ZR7Jxm9Lm4F4THQwaqD0Y04yFDXXkRA3N/lrNnFOE5pzk3FX/noF8AJwydGW9HuolMs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14) by SEZPR01MB6080.apcprd01.prod.exchangelabs.com
 (2603:1096:101:221::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Sun, 30 Nov
 2025 10:45:50 +0000
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::60ab:8615:ab67:8817]) by PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::60ab:8615:ab67:8817%6]) with mapi id 15.20.9320.013; Sun, 30 Nov 2025
 10:45:50 +0000
From: Crescent Hsieh <crescentcy.hsieh@moxa.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	andy.shevchenko@gmail.com
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	crescentcy.hsieh@moxa.com
Subject: [PATCH v1 28/31] serial: 8250_mxpcie: Track current serial interface for later feature gating
Date: Sun, 30 Nov 2025 18:42:19 +0800
Message-ID: <20251130104222.63077-29-crescentcy.hsieh@moxa.com>
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
X-MS-Office365-Filtering-Correlation-Id: 4f642d06-5050-4938-152e-08de2ffda081
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?P2yCoYD9yU1rTaBw+roZ6kIFqHl2tx9SOTEieLHSn2eTGu+YTpqWB8lE5t1a?=
 =?us-ascii?Q?/C/so/0sqT5i7Wxqv2QXC8Y/pmvJHH6Fp+3mYd6+rhyZKg1rN79FrWro5SX3?=
 =?us-ascii?Q?QQQm/zOhdld52G5juV7n5ahxxSbVGTLkRDRfJaLeWcyudaobBwslCcMvC5c4?=
 =?us-ascii?Q?xyd0MJSf8qnTZssRRbQ1Ju1yAP6RGGHsQiVlFL1R07pkZgwJHia13ftOj0nd?=
 =?us-ascii?Q?fyqyqnUpPns/TiMU8QcArInnqem3eJ2QRe8iLySCMqrR9ZUEKu3SAmylKCJR?=
 =?us-ascii?Q?N/OfDMhu79DoXFjGXDaxY81xkt0f9PtMxhEz8krxuPcoURlZWR5DuJtI0KA2?=
 =?us-ascii?Q?96+JD+n+ap95OTYkYoDYPafRYydpQeBPe0N6OZf8uKZylZ8a4GurFT0FwFqL?=
 =?us-ascii?Q?BQL34MIfC7YM9qpxzn9mIAA10DyJJdw+WLEQdHxUNNtOg6O3jWsRLExWx7zC?=
 =?us-ascii?Q?wT3NGdEa63jyQ31jVXVh4GXEMj8AQtvIYXUiH97jqBAmgRZ1KDGlhZ3sYXSD?=
 =?us-ascii?Q?3SciChH5eBBmxkc1GPxLKzNezoPXPd6xvE22NFG8wN5nWMRfJoEG2tzw9ZTc?=
 =?us-ascii?Q?Tx+etcFmh28apokaTWC0vlnpxgzfH3UEMZj9ewk14RtrLNa65vpNpzcYxlp0?=
 =?us-ascii?Q?xlFGBgQdho4gGEEUYf9yQlG80wVfle9LMGa4M188Rg+/IbVsTGg+4g5xBu4I?=
 =?us-ascii?Q?Zc6iX8IGMj2bmv99acgYMnsjvKfdrUY4Um8f8QxqbokPpPzlA+FH/xBXPFw4?=
 =?us-ascii?Q?CB+2gUR1zply4bfIFB6JnmMYCwHoYQ+OtMY+qGOAqV63S1z6NUz9a/wWCHez?=
 =?us-ascii?Q?QUhguIDkvx2eYgXsREQuRDJ6OCI3uea+PlJ8+20XmhNfjThH5NZo7mPtKGOO?=
 =?us-ascii?Q?+6hMtYSepvUNtBcQguWhx4urWOOXVY+yTh7aUo18uXGz/sLFQXHZCrP+a0hb?=
 =?us-ascii?Q?4k5if047xSjlzdMrjEMZeorn9F3WAnhPsvXW64XoJ3zjnL8Tradcp9Ay3z/N?=
 =?us-ascii?Q?+Gy2gbRyaZwxE+000RG2u87N6gdhmIoOhJzuIjn+K8ojVXi06ebW3jCkSOrp?=
 =?us-ascii?Q?32VMDYqskfv2yPtNAYHNojaK5itYTXgKILUvA52uPVEM7drVxeuOeprBzuBA?=
 =?us-ascii?Q?QuauTax4RBJGgWNir5Cv8sD0tGKOHn/ubH93Cp4O9eaZojATmcffkbtIPlpj?=
 =?us-ascii?Q?/a7OJ7UCDJjHj4qDYaJbZOTgbaDwG14CUTED8T1lIO9vb7STQLdkLD9B50G0?=
 =?us-ascii?Q?TkDG3/Ob/n4EE3lztjqShE4+eaTm7WidFcSDFIOJCbQdYdYjkBvAA8OpTTdx?=
 =?us-ascii?Q?qV6m9Cw+ax8lVLlHE5TWHclJ7cN0DIJnack1xBWMIYJLkcWbWurVtjUfwSZx?=
 =?us-ascii?Q?uK4jL8atj/I8wna2Y6MTX8eZyEQXwn/sXbqqmT5zagVQX1gTYQ2+grs2Cxat?=
 =?us-ascii?Q?MqjFuBD1Fzsh6VKq6BSKMEdasLYjI46m2qyWS8LLokqYEicLRb0pHXEZw4ia?=
 =?us-ascii?Q?8rFyFjLqmxEcoWR89VjEa9tOLecGyPLOEA+0?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR01MB5405.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FAR+BTirzJ9DDagFZwwqBoGxWAEFfi7nD5fRtOom9ms9mujfF7/FgmTGk+J7?=
 =?us-ascii?Q?KjtkUWsOtz5LLed1CKCs5OI+4SfyD/q6wzGWc2ge+/bzPEyfwrO29uegMVPY?=
 =?us-ascii?Q?1S6npkvZ1BviMkYQXEtzvZakMARsbY5DSSaa+ZUGEctf/eb9yRnmXIkgVPlj?=
 =?us-ascii?Q?OWL7gCUvdUPh34T5JaHsv+CzXS0VShSM4Dkg+IXZiacefpmGyvCRE0j/xTGH?=
 =?us-ascii?Q?/UE4X0j1yKbFlWB1iz+PX2IMcBG+KIl1QYtVXmlNfgNRM9sDX1tOoSJ6/+fL?=
 =?us-ascii?Q?MNg2Vz3z3h5Iw4e11kWn+cVmaomf1TDFKNUpsDQHrcD+5PCjtwvT1BJSH7D2?=
 =?us-ascii?Q?I4Pi7WAbSfDu9QEKQsYD8dsIDVTmObtsM5jjQF+UiKeXHMIfk7us+nymsEbT?=
 =?us-ascii?Q?PIGGLXiJmWUkyQ8nUiRoIqQ/D1XWF/fmqjsWriM2E6EMbTe3bND87x0jKEHB?=
 =?us-ascii?Q?Tcu9/I73YhrjBMLydyXFtbvjB2t15UtW51zdC91Hn5YZmAK3znUgf79VKBn+?=
 =?us-ascii?Q?ueB+7H1lxEBIc+jFUnSSwBZ+ygNnvB/aKgDsQvAQdoOOKm8fCRhjmOKKE3AB?=
 =?us-ascii?Q?qh7chHj0aNhb6aqYm4TDEyQwEDbsSI91e0Wz3/F2mCPk/JrWWSud++vmHH4f?=
 =?us-ascii?Q?68XHNmjlIoQDbiOfxm/nZcHwEq9muhPjEYtyBbo4w6U8VqRNjUm5c5zun8+E?=
 =?us-ascii?Q?G2AjNUNVKcZzp+VoV/XwgKSRLquQoBPI22UlU5BbKfYDLy2FZhngTVTsvwim?=
 =?us-ascii?Q?4V9xFNLRS2fqYBmi7mrPiYc2I7cyxyu4cw6k/uitd4pX3l2cVvEyTrYmECHh?=
 =?us-ascii?Q?73gNdQYFwCtfT2hUhJFRhXF/UrORdmGTmb794PHDyko00Cxwm1IEEsbef1YG?=
 =?us-ascii?Q?/Yopt2LNBXkxOuiN11lrIan+UATz0mWHx5qzjM4iZhYSXxR6GyQ1ODVjew2m?=
 =?us-ascii?Q?ffriUhDVgeEPRhS0ZnEyQGr/eihrOa7fhwGOqzupKkddV3ylawZDphdTFjyc?=
 =?us-ascii?Q?DZIH4eYHoklyTKYpi6n4nBgXvbvArTyI+NL6yEF7/jViR7TJ6sGbqv7yt1p5?=
 =?us-ascii?Q?Qm6Txtqg7x6PUEOfHkKdYTjkY6MpUHK4FRZ8EAf0JL9RuTZ7l9Bk6xIWWnSx?=
 =?us-ascii?Q?7QkiqtcsBznJ8fXqoY/J8Fz4N3QwW2TUaim38evhEZD8on3R5hI6AASrtr3Z?=
 =?us-ascii?Q?9oqLTL1kzYQnUgS3YGVCh4xAEXpspodzpUEXoufpb/5Lx1PH51Vq0o2CzeOf?=
 =?us-ascii?Q?junmSdsk9CiQZiLk3kS3MDkZ525Lm1We6ymtB7mHnH9kWsciwEbL7tD1Tu0Z?=
 =?us-ascii?Q?eZyOzs545XuvW5wSEBhlppls0UYBbQ6o38l6KsOCKILhdMBmHBjrovn1T6Qw?=
 =?us-ascii?Q?rj7zTcYDeeI6ynrLcgyRuaRIsNWmEnZ/kDAX49tD+KzBWw5Wts7arL6UMKk/?=
 =?us-ascii?Q?YaIIccRXNUure1gyhuT2ei+rj8OEkQn/z0yj/ytWTSSm8lQCHwbxZ/HEKjqk?=
 =?us-ascii?Q?6E+JobzjTpvKUg8BvjYmxsncCfWz4Mota+AqX/N6EWv12YTH+RqYOIW8t16b?=
 =?us-ascii?Q?xJO6yqxGBZrrjv+I2JAlY6seJtTsExYWFpSi2zeQ8b0Imw6SduHBMMPaGWZP?=
 =?us-ascii?Q?4g=3D=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f642d06-5050-4938-152e-08de2ffda081
X-MS-Exchange-CrossTenant-AuthSource: PUZPR01MB5405.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2025 10:45:50.0774
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /IpTzPYMYYRWoJL59QZ1CdKAzEMzxFowQkguSMVV3X3UYPnk77VgQnXTCV3GY9yE2plUtJZbuYIM1VOCHccqJRY94nTlUHfrsA0yqZo6N90=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR01MB6080

Introduce an `interface` field in struct mxpcie8250_port and update it
whenever the serial interface is switched via mxpcie8250_set_interface().

This allows runtime checks based on the active interface (e.g. RS-232 vs
RS-422/485) in later patches, where features such as terminator, pull
state, or auto mode must only be enabled for differential modes.

Signed-off-by: Crescent Hsieh <crescentcy.hsieh@moxa.com>
---
 drivers/tty/serial/8250/8250_mxpcie.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_mxpcie.c b/drivers/tty/serial/8250/8250_mxpcie.c
index 88ab918fd000..7a1030a47b00 100644
--- a/drivers/tty/serial/8250/8250_mxpcie.c
+++ b/drivers/tty/serial/8250/8250_mxpcie.c
@@ -128,6 +128,7 @@
 
 struct mxpcie8250_port {
 	int line;
+	int interface;
 	unsigned long event_flags;
 	u8 rx_trig_level;
 	struct uart_port *uport;
@@ -505,6 +506,8 @@ static int mxpcie8250_set_interface(struct mxpcie8250 *priv,
 	}
 	outb(cval, UIR_addr);
 
+	priv->port[port_idx].interface = mode;
+
 	return 0;
 }
 
-- 
2.45.2

