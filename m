Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2125.outbound.protection.outlook.com [40.107.21.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97636F4F1;
	Sun,  5 Jan 2025 13:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736082744; cv=fail; b=Au02n04r+CnzcuCgcTYVDPCw1Q+IHsu/VXJWDN0UUIxcGGr0aMoWZ3q4w37OOyfkz7cUp7txEpRTK0jP8D2SoWogqZ/Be8PewOUYcxGvIFKMcPIzR3rri5lFKCtTRCRDDwaZZeEOQF+LsQSHW22dW50VkFjDy2jFvNjOwImhD1k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736082744; c=relaxed/simple;
	bh=4juP688yPrVi5A3pPj358BIyOnyKhk5/lVjejl0Kp7g=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=s0KK2Z/hUvm4PPR08+bcyHWLrS8k7uRuhba3zwuJnw/0RFAaXWoKkMnAHUmmBJqWGwYIkXHewieCZixd06lX4QohLfr80xIdYLrukuJODMnj0MCec+DxYR+p8apZGOyaHcF882QGbydL1tFgZeSgbShD2nYj2E+mZYen0RvK0EE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=genexis.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (1024-bit key) header.d=genexis.eu header.i=@genexis.eu header.b=LNpBFAph; arc=fail smtp.client-ip=40.107.21.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=genexis.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=genexis.eu header.i=@genexis.eu header.b="LNpBFAph"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kOo03DBaHqkARbpVBdZxTLjKCDxwxs/6APN6Y5VLgV6HLHzTtzVOwKn3gK1OJOBXB/zq537/MNutw6C5eFGLQcRVCjP4BN4m4LIvtdrBbT1urvJk7HgZfYwktTY3w2ZzDLp336Jf3rZ5H7j/EctQfzQQ+99yBgJGCbUufmgUSrBecJ9099XCK5k05xvFWxfdVO5wx7Bs2vfazWdPmnfvstJLfuE3bD4fEuYcjI5euBRQCDO1Qu/UsNaKpDhqBdlStMT3HFp94H76Q37ilHMrs6OIJI1TSV1QtnvbUxGwPvjlWcYuwnPtvwngW88XPoDG5QPlviBxUCB6j+XC1jHejA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z4wWMnVT2mtBWxvk4vIez5S3/5Dt5Q9nogb6qEele7E=;
 b=f+hrcJeM7xoAsMbLi9WXTFUZ36pP9IiBVtEii1OcAZfP8bfPRTTI5aCJrS4j1aqVBzyvb5ovsTcF7lLKUUXU8zNdMTI2brGRqufuLEm2mPVleB850RRU5UcSt3+31p4UUtcnwzNA41Mzr1c45yHLLqqY595HYcKo9dyWisJ5T7EJRKrmgCJTjV7sE7As/EeY8DK5Uviu5TPDBXlLcicmm4GLiv4Heca7hYGKJgme1vNHtkl6APhzbP0VeFmYdVLFpUSEHW5jKIqInbi1qFc2VYvm2XnSRz1Vk0ZyYh1+q8ozh+6O1w0f5jyq2+3gsRT+cST+4spZXwewrlLEZS74Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=genexis.eu;
 dkim=pass header.d=genexis.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=genexis.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z4wWMnVT2mtBWxvk4vIez5S3/5Dt5Q9nogb6qEele7E=;
 b=LNpBFAphrBCaV+1CgzbYvDUmYrkrfVbEJTXVC9lBVuHLRWmLBZhN3QF0d80nEQLcRRV9o3nZbrlgUsfVrtFvMYZVV/iApr9vk0KCJvmiDJjbb24eOGuVLTleTVTlg7rDoUiWXbZ5C3tHz4I1ww2G/3jNWtyHtxiOtxgYx2Q8pbw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=genexis.eu;
Received: from AM6PR08MB4215.eurprd08.prod.outlook.com (2603:10a6:20b:90::16)
 by PAWPR08MB9613.eurprd08.prod.outlook.com (2603:10a6:102:2e4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.16; Sun, 5 Jan
 2025 13:12:12 +0000
Received: from AM6PR08MB4215.eurprd08.prod.outlook.com
 ([fe80::f8bd:a866:322f:7b42]) by AM6PR08MB4215.eurprd08.prod.outlook.com
 ([fe80::f8bd:a866:322f:7b42%7]) with mapi id 15.20.8314.015; Sun, 5 Jan 2025
 13:12:11 +0000
From: Benjamin Larsson <benjamin.larsson@genexis.eu>
To: linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: ansuelsmth@gmail.com,
	lorenzo@kernel.org,
	Benjamin Larsson <benjamin.larsson@genexis.eu>
Subject: [PATCH 0/2] Airoha UART support
Date: Sun,  5 Jan 2025 14:11:45 +0100
Message-Id: <20250105131147.2290237-1-benjamin.larsson@genexis.eu>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3PEPF00002BAE.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:144:1:0:6:0:8) To AM6PR08MB4215.eurprd08.prod.outlook.com
 (2603:10a6:20b:90::16)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR08MB4215:EE_|PAWPR08MB9613:EE_
X-MS-Office365-Filtering-Correlation-Id: 24a1a0be-6aae-40da-9831-08dd2d8a90d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dwOOpZ4DBaWMNruBQopR4IqMsU2cvtPJl/64f/f+LFQjv+9D+XwB+VQo3mbN?=
 =?us-ascii?Q?jibpdA7Mt6oNThhMhRTGIPL1v9KBa2BbHgjYyoKvRhTiTaX+8QnT4T+1XAPV?=
 =?us-ascii?Q?JmXO6E6OXdR0ff2eEaxok1X+iaPeHNloucXCULX0i7qAwcyM73iIZYNPquMw?=
 =?us-ascii?Q?Helq+d9BZlNxVPx6pH0808sMGSAUZHx1HEGRdENfCd+5pyKa6dhhIqShjqo8?=
 =?us-ascii?Q?+jP7SCKB04TpL5KUU92ltdaeUHFDRaxMbHogbnjMEx5wsITbKglAtha93Bc0?=
 =?us-ascii?Q?P70XKzNMrb+aQr1dRUsvJ9j8uJ9kcU6Gi80ZSH6uQgS6hFYNlZQYwZRqS6jS?=
 =?us-ascii?Q?22hnoEpyGtZSfZ2TccyDFNpzZjpZQJ4QqZhfGgyAtbMm2Ol3tA5M1WWo/d1d?=
 =?us-ascii?Q?MtFiw1BJ6ypB5uuFN1TabLUNXbBH1XTweHNIUSDgdM6Pl24nhE7HDR3VfvdL?=
 =?us-ascii?Q?5sqaTtaSwesbr+ffe5JO3Nfwu/5e5wlKs2NwuTnaID0rZshr6PkJ23bT3lEi?=
 =?us-ascii?Q?Z5B2hMoTxZ9OINpJYoptRmspzeapLeHZuqHLbuqw38+yUsjb/ZIglE6AdEVt?=
 =?us-ascii?Q?eCoJyj2VTdFR4MWc/YJFhsKYU57migV53Z7+OO3h90vAsD0MnUt48Xy9OxWK?=
 =?us-ascii?Q?5IPjBaXnZopHnRmZ2B7s0ryfPGE8JOi7Q9SPcyncDn5NIuTmUcdNH6ltyKL8?=
 =?us-ascii?Q?akEx25g/LESGChUWDKqioh2mfDibXztlGaeSSu60SdCneSlfmwl4W1GWJxTj?=
 =?us-ascii?Q?86pMoZgL+GKtzrQ752Q91w4RAPVYFCsepWGCiZhWJJWPritqC6//p8wZMXj1?=
 =?us-ascii?Q?k9wGH3f45883gXQ7dJWiMJagz6pUrNq/NG7m50GRvBAT4IBvxMSayX89N2tE?=
 =?us-ascii?Q?ivIIqcf2QOscl/1eL4R6unbgiwrjIHHWbqHwLxK0oXzpYmrmR79VVVyK6NA0?=
 =?us-ascii?Q?4V00pIbZIhTmxTxzeNmzI62Ld6zH6XdhH7udhiaHNS5+KFBfoJ5lREjyN74T?=
 =?us-ascii?Q?7lX0Vz9nleIXTcRaN0+j1/gbs54FbVYYIjduxNOV3cJZAtXH4o6MyJFXRhkg?=
 =?us-ascii?Q?k2rStmRDjsvTBMck84feQQc/q4EWoa5TgGkk8wB6CjV91jkrPEb6TP2F2DyU?=
 =?us-ascii?Q?WQnRqdRs2ZDm7Vb5JPDJQJr+uvBzcGikmCu7IzWarxCLCo+uETwIeALaz5Yb?=
 =?us-ascii?Q?Wzyd6ao8gcCY5PKfGT7V0WrpcX86aLkALPMlizdKSpbsQpXBsLlebrymW32U?=
 =?us-ascii?Q?N+hFkzxkqFYYD1EaAqiuY5VeURsVgapYY5l8vSvv6PyoY0+x2lr8q46OnPZn?=
 =?us-ascii?Q?uImh36zifL8eYmuaO6C0A4WIZptSaAtcSxySP21yk/X7S32l327lGmlaMrhx?=
 =?us-ascii?Q?N7a9vOWB6U7a/UCRnKuCdW6zIcyJ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB4215.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(10070799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ReXfoMldqCVTlyG3lPaL86X4od92iLuaC+jVI5tS64WtS1NqFXbqJfiTOZQ3?=
 =?us-ascii?Q?l+I41s0VSm5gzcl7zgL3Hcla8JOoyCIXo6jJBUpEjegUyvLsldEjGMTJ62HY?=
 =?us-ascii?Q?JnVZFrG698985ljA5S7KF+h3sgEb3VTHPFVH46LPPx4BwF+GSPmhRtNx7lD+?=
 =?us-ascii?Q?QXe4F6NWl5gtXVO1wf5THXxiwYfg6chTMCRTkTW825M4W8WK+nud9LJNK1AL?=
 =?us-ascii?Q?zX4NrEUBwCbvfTZhxAO/B1hdu7/rnOEZc6mWc4CxnPGe+EYMos6h9/3vN6ed?=
 =?us-ascii?Q?dVXxh1dLlkCHVWmS/qGwNuAZxUtTm6j6liaT6vT1AJufZO7D6ILUdOMnX8jX?=
 =?us-ascii?Q?K74qTUk31WtdiXGzPs7dKuR2jd4EBJ95rSyT2jzpC2Bw8RZkjMF8dp93lXT5?=
 =?us-ascii?Q?CdRy73/3ArrAMq5M+TVeGam9MrChY2E3v+PTHwaPi2cjXeU6okGaC9TQD4p5?=
 =?us-ascii?Q?vv39qfKFAXcGw62G2b/rtX8+TVIl9DI7r2FV6xWR5aeaTgFIxKczQ4mOuPtm?=
 =?us-ascii?Q?T4b8/U0dnb224C6yHWk0VpFZdJYg4BqQLZ3THFt1PVnw0QXs3OWWcZV4C3T1?=
 =?us-ascii?Q?QIYAniU/Vk38Jvfddao5yNKKlgyKyNjh3/dQ3Ryxi2XRJgDcq/5TDWRaINWp?=
 =?us-ascii?Q?xNMDjHSPyXhUumT3G6se6sRLqv7rxTir+q9+xDIQJcCmEO3sz1FqTWrURtxP?=
 =?us-ascii?Q?RjAXdPeRvxSgBDMOD/5joSNgD7fUDUbR+LMQgp66MwNj2N9QuAbmOd71wN6a?=
 =?us-ascii?Q?h6R1fafYuB24N5C2tRi90Ggoh+Uj4xV/6YxrxjTXLl/xGzFXdmbsmzCB3hJq?=
 =?us-ascii?Q?mLYDfQYY6cPZSVmBFjMel+MKkPSbqhNTr33VQvDolrreA9dqmZKlMPdDoP2T?=
 =?us-ascii?Q?/rmtnpzn8Ifq6jkVMS/U5wjQedwzJ9ShbBZaM7shRrEsr2Eix+zRsXFxeAFW?=
 =?us-ascii?Q?B8fte+BRoZovBO+rPAKmnFSWTH0gpq3KSakXw8Mq6wz4CUTEK3RaKxBGFEcE?=
 =?us-ascii?Q?lVhbEcg84kl3r14d8sekN4KE4GKyIfxmAZfMyIcPzyeRRMeR9eB07JRNrzx5?=
 =?us-ascii?Q?ByuqakZtojx/iKNXXbiBmA4AQV+x/oc6AdYWug3IOJeiAWiCrzN1gE+SfpHo?=
 =?us-ascii?Q?O3hOKlQbCknxS6bYqUZb8QHAGFMZUtfiRNhMWIMErz/rHCIkUpb2kfOiWwGo?=
 =?us-ascii?Q?NPThDciWkeQpS0ThlLisUfwKWr/EQvz4aZJgei+HelKw+GNWrxK3vJmHUjGy?=
 =?us-ascii?Q?pRYcHBh0yfcDw1Zns5vGCSVAgBhenaYvkT/yx7NQmJAiu+hXMkI9WVd35loT?=
 =?us-ascii?Q?1Ui7FeQgvKAKwIolNE9FXzx3hXGCULmcrFb9mqSnECCoMJVoKaZkIE94PqgX?=
 =?us-ascii?Q?w/9POH7hLew2dS7EcuZPl10N5Esin4+h+9H1wV5MuNI34mbFZkwPUPIQYsaU?=
 =?us-ascii?Q?xl5kHqlEDvE+JiBShb3Jw0n8gqoF9aVIbSD5y+4MAMg92B3+6lx43t77BQ2a?=
 =?us-ascii?Q?BkHhMt5DatifexCds6THgXbQY88BxmcCND/I9qrRTNe+Xz/y7An1pFcj/Zn5?=
 =?us-ascii?Q?mlPRCDehefFGTA8IeVzlQJrJbxK1QkDyvb6t+4KPAlhjb4u19lB6kIi0R713?=
 =?us-ascii?Q?Igr/NOSZTYtdUkzF5sB6OMOGt5h1ub+4fb8Kml/usPJvBiKYKx0+wAmmA1Dt?=
 =?us-ascii?Q?hhCWEw=3D=3D?=
X-OriginatorOrg: genexis.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 24a1a0be-6aae-40da-9831-08dd2d8a90d5
X-MS-Exchange-CrossTenant-AuthSource: AM6PR08MB4215.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2025 13:12:11.8297
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zu6R47OUr7XkTqQloSnS2PFdPBIC6k3hkkbKblJ/MpJqQMeGZada6n0j4TXAKUCh/RQIqAN4u1UpFQZOVGz6DLe2z9cqTDJu46hqAiwtFS4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB9613

The Airoha familty of SoCs have a UART hardware that is 16550-compatible
with the exception of the baud rate settings.

This patch implements code for calculating the baud rate for the Airoha
UART and HSUART.

Benjamin Larsson (2):
  dt-bindings: serial: 8250: Add Airoha compatibles
  serial: Airoha SoC UART and HSUART support

 devicetree/bindings/serial/8250.yaml          |  2 +
 drivers/tty/serial/8250/8250_airoha.c         | 85 +++++++++++++++++++
 drivers/tty/serial/8250/8250_of.c             |  2 +
 drivers/tty/serial/8250/8250_port.c           | 26 ++++++
 drivers/tty/serial/8250/Kconfig               | 10 +++
 drivers/tty/serial/8250/Makefile              |  1 +
 include/linux/serial_8250.h                   |  1 +
 include/uapi/linux/serial_core.h              |  6 ++
 include/uapi/linux/serial_reg.h               |  9 ++
 9 files changed, 142 insertions(+)
 create mode 100644 drivers/tty/serial/8250/8250_airoha.c


Signed-off-by: Benjamin Larsson <benjamin.larsson@genexis.eu>
-- 
2.34.1

