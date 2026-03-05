Received: from ZRAP278CU002.outbound.protection.outlook.com (mail-switzerlandnorthazon11020093.outbound.protection.outlook.com [52.101.186.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132A53A63F0;
	Thu,  5 Mar 2026 16:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.186.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772728130; cv=fail; b=WzYye86msgbMtOulrBVdT5B+59bgRKVlDD0EVaGOjXnOInhsZpbVcpKwmXFrNr4GInUw6Ise5olXAsbOWY+GYZ6NvobJ7aJb5EqrsStjkAXR6D5d0xlZty4qbfHBsQGD/bERGUmUO3XeNmARtV4p2Pp8JKQdl1gwT8hSkBL3v+I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772728130; c=relaxed/simple;
	bh=N7eXw9nXxhTQgTSJHWhOJakN1qzyEF1EoqpHfSoZdgo=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Os5jKAWcHihHr9ciZG+hD3p1RotMJkX/95EaAzozqz+Jbr4DQUE4btDP8fwF2jITYRud9qB4u1bUhpn/7yaASku6iLF5HPPRNilGNL+7Y07H7xcf1QS63VSHZ21wNl5vBdkjQlmCTL+LewpzT16bhPmLrSiALdU8IWUImR5rguw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=duagon.com; spf=pass smtp.mailfrom=duagon.com; dkim=pass (1024-bit key) header.d=duagon.com header.i=@duagon.com header.b=biEWMUUe; arc=fail smtp.client-ip=52.101.186.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=duagon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=duagon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=duagon.com header.i=@duagon.com header.b="biEWMUUe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gIFYnSdS6WGrytGtKW9tACtxCb9lrkRL1N4Pdt9hizCd5qRO8bzpNqjEWh97lxEcWG1jhuaxbCjgKAuAff8fQpYafLjJn1GUfc/lV6w2KV4a6uqMvFtnFnZQaTEZftCNc1SOm2GISuiZ+Wd0V1bvX5Wq9e55g2s6bdgehlj2NrBFvhE2ts8zsenqn0Tge+vvoByBNFXFx4t4kJOiuQ+W+d8z+++iO9s0TIrQ+rf91CMTOtEAbLGfEmhLEMrTgcD0gyZz/klpjg+NoEZVDWCyfRY856ClQoi87y8pvxdMhedp6u+r6kJiPCcyvdGe1+fHzEHyqDUAce6np8SQka0gcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0/p6pHaKU17UeeYAgNMEMkiNd+icesdlfThcKtAGgkA=;
 b=u4w0TSMW0NCob/QWt88nN4s0W/QnlxTpp0ggsNzU5CSQRqFIbFuCHZpfefIoFcnh88774M2jn3MYd56zj99mJt2oLXVdFqSdO3zUgbMGYaFJTD6inLnxLZGIW0dQcPXEzTH6A1fuljiFZHBDQ+rmZJerRSHakEboKxbFIHcD/y2twcx4quFMqOZdlXTKnVgBGmO+AYXBTWN55+GkwZUBJ9VvpzOChKop+w21gPcYYmbQa+BI2JRR3C5t5WB0s0LuunPv8iQZKhrJVoXfZK6c4O7Ggh+gAfISvqvMlreVGJ63fJKKr+64YnYuSTmW2ITj6ySnfqEzROatcrdn6jZ3EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 40.93.85.5) smtp.rcpttodomain=kernel.org smtp.mailfrom=duagon.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=duagon.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duagon.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0/p6pHaKU17UeeYAgNMEMkiNd+icesdlfThcKtAGgkA=;
 b=biEWMUUexeMcVaId4+3x1vGJfvMh6mXapCR712WuzZurFDurOSr1zP5sFLfqCoX2K40JwQfom12SGX3Iu8RLnUojw8nL6nNO9qXRT+NFrXzZGz+/SiK/kEw8oyyZe8ghrjuV/UH0+Ww2X3sD4v2PCOhy0H6r1n2auNnjTMUCbo0=
Received: from DU2P251CA0017.EURP251.PROD.OUTLOOK.COM (2603:10a6:10:230::16)
 by GV0P278MB0162.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:2d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Thu, 5 Mar
 2026 16:28:46 +0000
Received: from DB1PEPF000509EA.eurprd03.prod.outlook.com
 (2603:10a6:10:230:cafe::d4) by DU2P251CA0017.outlook.office365.com
 (2603:10a6:10:230::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.22 via Frontend Transport; Thu,
 5 Mar 2026 16:28:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 40.93.85.5)
 smtp.mailfrom=duagon.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=duagon.com;
Received-SPF: Pass (protection.outlook.com: domain of duagon.com designates
 40.93.85.5 as permitted sender) receiver=protection.outlook.com;
 client-ip=40.93.85.5; helo=ZRAP278CU002.outbound.protection.outlook.com; pr=C
Received: from hz-deliver02.de.seppmail.cloud (2a01:4f8:272:5fe6::218) by
 DB1PEPF000509EA.mail.protection.outlook.com (2603:10a6:18:3::624) with
 Microsoft SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Thu, 5 Mar 2026 16:28:45 +0000
Received: from hz-glue04.de.seppmail.cloud (unknown [10.11.0.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by hz-deliver02.de.seppmail.cloud (Postfix) with ESMTPS id 4fRZjT1HCgz11H3;
	Thu,  5 Mar 2026 17:28:45 +0100 (CET)
Received: from hz-glue04.de.seppmail.cloud (unknown [172.18.0.4])
	by hz-glue04.de.seppmail.cloud (Postfix) with ESMTP id 4fRZjT0z8Xz246f;
	Thu,  5 Mar 2026 17:28:45 +0100 (CET)
X-SEPP-Suspect: 7b7e739509f241d684272cb32b4c05e6
Received: from hz-scan08.de.seppmail.cloud (unknown [10.11.0.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by hz-glue02.de.seppmail.cloud (Postfix) with ESMTPS id 4fRZjT0NGzz1x9X;
	Thu,  5 Mar 2026 17:28:45 +0100 (CET)
Received: from hz-scan08 (localhost [127.0.0.1])
	by hz-scan08.de.seppmail.cloud (Postfix) with SMTP id 4fRZjS71WJz2kL2;
	Thu, 05 Mar 2026 17:28:44 +0100 (CET)
Received: from hz-m365gate02.de.seppmail.cloud (unknown [10.11.0.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by hz-scan08.de.seppmail.cloud (Postfix) with ESMTPS;
	Thu, 05 Mar 2026 17:28:42 +0100 (CET)
Received: from ZRAP278CU002.outbound.protection.outlook.com (mail-switzerlandnorthazlp17010005.outbound.protection.outlook.com [40.93.85.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (not verified))
	by hz-m365gate02.de.seppmail.cloud (Postfix) with ESMTPS id 4fRZjQ12Fyz2x5X;
	Thu,  5 Mar 2026 17:28:42 +0100 (CET)
Received: from ZR0P278MB1218.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:80::5) by
 GV1PPF532F3E036.CHEP278.PROD.OUTLOOK.COM (2603:10a6:718::213) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18; Thu, 5 Mar 2026 16:28:39 +0000
Received: from ZR0P278MB1218.CHEP278.PROD.OUTLOOK.COM
 ([fe80::311:4b5c:48da:9514]) by ZR0P278MB1218.CHEP278.PROD.OUTLOOK.COM
 ([fe80::311:4b5c:48da:9514%5]) with mapi id 15.20.9678.017; Thu, 5 Mar 2026
 16:28:39 +0000
From: Filip Jensen <dev-Felipe.Jensen@duagon.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	dev-jorge.sanjuangarcia@duagon.com
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Filip Jensen <dev-Felipe.Jensen@duagon.com>,
	Jose Javier Rodriguez Barbarin <dev-josejavier.rodriguez@duagon.com>
Subject: [PATCH] 8250_men_mcb: port.dev unset can entail a null ptr deref
Date: Thu,  5 Mar 2026 17:28:15 +0100
Message-Id: <20260305162815.41818-1-dev-Felipe.Jensen@duagon.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA2P292CA0009.ESPP292.PROD.OUTLOOK.COM
 (2603:10a6:250:1::14) To ZR0P278MB1218.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:80::5)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	ZR0P278MB1218:EE_|GV1PPF532F3E036:EE_|DB1PEPF000509EA:EE_|GV0P278MB0162:EE_
X-MS-Office365-Filtering-Correlation-Id: 6dc48de0-9012-40f8-8e85-08de7ad445f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|52116014|366016|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info-Original:
 k+v2eoOqO8a2qjodaKqnABKQwj2X9o+vcEgemtuxAx53TQh+wey1v7bNEmqsx/4WJUngJSc/QjtF1nsqS42C7G4AiOtp/l0KFxWbzd3B3Yme1aLh8sE/C/z3zMa5w7svZu5ZcYZVfvyR8QF1aRm7eYdzVZNhBxi5bBgVKxSytnokjQPOVr6a8ItoG/iryqtI4Zj/DWhK/48szh6j9Offl61dc8utktN4SRHijMzC8ROPUTGVaiw6VIZC7X4t4fIgZmibs4l49IZQU1BrdAI6YwREYXCsko36k8ENVz1uBKKDoBh12ftxkSRQOuYzJMRNYmWVqEBqzuKZqYjDx0wZXQX48PVM0K5UoCSQ4Pk6fGLLI/xZxFsonNnEOyZs6IHWUFJNPmAcrY/7NJ0J0RQUhXZzhdAno9sFlVHEbXgfwPrmzooR47TED9xqLamv1R4Ib6v74bxUPIuk1UNFXkNxfC69vWFcsIZAfZPFpw511eky8LHIhLQDWOLakCj/3k3RlkcJ9MA+cTES9M06FGjIxp8d1XSnmMWFDCQxNwWhEQaYR5PApCsCZqI+zt71Xn5mK7AMD5T4pOKtGnBCUY31LnsmrnIvpyN1uWctCf+YKXHytsrHST5vuONHYB+eYlPwFpUk/X1t/sf+cPN1nev9II+NMLzHReR6R25MXtxfNRAEXo4MbV8Bo2exWnC7S2IdhBR+I//qQBSZrp5KliA9wCycnrIs3YVNUe19i1Wr61zamNC8LGEfr1+yYT7OsBa1zX8yFflRd2IxTAM7Pa/STEah3EviberCB/vkWja4TOA=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZR0P278MB1218.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PPF532F3E036
X-SEPP-CCCVersion: 2025-12-11T08:12:51+01:00 9ed91da2
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender:
 ip=[40.93.85.5];domain=ZRAP278CU002.outbound.protection.outlook.com
X-MS-Exchange-ExternalOriginalInternetSender:
 ip=[40.93.85.5];domain=ZRAP278CU002.outbound.protection.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF000509EA.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	25cf13bf-b5c9-4f03-a40e-08de7ad44217
X-SM-ruleversion: 2.1.0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|14060799003|36860700016|376014|10070799003|35042699022|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gJ/HXY68+RYMMRQjXHEB8lbXde1jO+hBNMYR+AIEqPDlkJkLowPW4H3tWX5I?=
 =?us-ascii?Q?5SzsZ2yQFjLxjJaaM6P4hpQ4zmEVdQenX3Nff4RCGWvGBZ1q1EOyIqeR+3tM?=
 =?us-ascii?Q?jKqfSewgsBFFnDgM+bMlXu2sCCKRYeP4g0jsZhvvpB3fJvWzFY5NIzOkmiaX?=
 =?us-ascii?Q?utHzC1dxFAOQ9MM4Fob/hoIA8CiG5PTXK7niMcPKtWzUA1Z71OEGhZnZ+5ST?=
 =?us-ascii?Q?zqeclNyxXktHh5TlrqEgkIhVbtQhOp00pyX3w9qgrLuUEaVT8mZgnobqAWqY?=
 =?us-ascii?Q?gwTEE1kOHV/vohkgIFi/UhJ24jYQby2r99L6MvpecZ49IBdPgUbpGIX7tHN9?=
 =?us-ascii?Q?QtVFKTsHbfeJnXEv3pDVZpphSn0FqRMbICuOfCSqLLfha8gSwOkxj3BeX0Xs?=
 =?us-ascii?Q?8gRuKydkOJPXd7ufl7wTygLJl+D/SHvoIw2GXFVm8FvxTvDMSvPZqG8V9v5O?=
 =?us-ascii?Q?6aYuMtkvOD9FWhAWNmwCYCU1KRRxvvVpBuBL0A2uWeS/WT36uaS9AX5m96PD?=
 =?us-ascii?Q?7zxj0K9n3ORwZZz/qymfdcmsBtW9MEhOxDMnJVshGKnZ7e1g1GjvXkPw7ma6?=
 =?us-ascii?Q?9z3vblqAfKW2y8JkKz5OdxqU2gP+5kfO83zM4vYztChRsVs0lbiuZ15zaI9q?=
 =?us-ascii?Q?6/QEigFNzwcSkBxID/Fn0GFGHC7+DXOLLiQ+tG56t+vfOtzpw/g7TE4wMFc9?=
 =?us-ascii?Q?wjQ8ObrvBuDBVS+zE9/M582nPBMsU4K7kJm+5l/eVIh6wZke0uGbsfJhqd0r?=
 =?us-ascii?Q?KkSLTBFYcmpS3yCvMZ0rYNPbYKHjqaBzyiQceMzEe4Q6zrRbxtAiDJ+CbG8F?=
 =?us-ascii?Q?dfhnjkUuvCpQgU5M8t3JwBAzHqvm8f/f7pkWgbonxr4HB/3D/wHANSxJxbGc?=
 =?us-ascii?Q?qQL/mBZHlpB8TDVQa6s7IIcoKcNRnQ655vy3PT7/1STRjACDZw2VD2/KU4ql?=
 =?us-ascii?Q?tSSWt4x8BgvcPFBBMw77W65VFvCwLRDtAPzLNCKwUFpOEFqFbW3d+W6F4v+R?=
 =?us-ascii?Q?XiIRg1qCACLbSRfizWnuaO1jERQN/11O50TRt4seEWsu26Et3nZmcXCLBZPD?=
 =?us-ascii?Q?TuBjViQj?=
X-Forefront-Antispam-Report:
	CIP:2a01:4f8:272:5fe6::218;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZRAP278CU002.outbound.protection.outlook.com;PTR:mail-switzerlandnorthazlp17010005.outbound.protection.outlook.com;CAT:NONE;SFS:(13230040)(82310400026)(14060799003)(36860700016)(376014)(10070799003)(35042699022)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	+yJpOaABb9PERpeNhKWWrMR9lEZE+HliqggiUzbtW6sNfFYuBgCbulz1IkS4bdKIRfVCHvcrilSJSecoknd67pSUhxCmGWf6C3aD+gBV1S3me7ZCmBQXP4vxHOpdSl6t5KRRpl5ipJh0DXiFKiYkiHKdDx0vOOF88YK8ejzKDa96AMovpLYu6rYrqHACLIWjfa9EBnrM7KZdxOOuggRJrfs90UC/fzGSsE6UIxfgA0bUrjNIONEx3tEnAQOPSzQeIp9eJ31qkcmlsYKoQNyiGEB2h9ms9f6OXMPGprFtUdiz3RQZnVZSdKNv52lLpI1JS8avz6rYGVlLmeeYU1qHwfl/mUQkdtr2T3+XD5Y2RiO66LXLBt9L119zAGzYBRGLmS71o0Dmih40eCNYcjQwpb1Z9feDoj6jDdNYmcV2KdvmmgV19EWxUrUsilYPeyJp
X-OriginatorOrg: duagon.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 16:28:45.7167
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dc48de0-9012-40f8-8e85-08de7ad445f3
X-MS-Exchange-CrossTenant-Id: e5e7e96e-8a28-45d6-9093-a40dd5b51a57
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5e7e96e-8a28-45d6-9093-a40dd5b51a57;Ip=[2a01:4f8:272:5fe6::218];Helo=[hz-deliver02.de.seppmail.cloud]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509EA.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB0162

The dev field of the uart_port structure is needed in the later call to
serial8250_register_8250_port and unless the port is part of the initial
registered ports (cf. CONFIG_SERIAL_8250_RUNTIME_UARTS) with a dev
already set, it will make a null pointer deref in has_acpi_companion
and could also later at uart_add_one_port call:

Oops: general protection fault, probably for non-canonical address
KASAN: null-ptr-deref in range
RIP: 0010:serial8250_register_8250_port+0xd34/0x2030
drivers/tty/serial/8250/8250_core.c

A proposal for a security check against this missing field in any driver
for the 8250_core.c will be sent in another patch.

Reviewed-by: Jose Javier Rodriguez Barbarin <dev-josejavier.rodriguez@duagon.com>
Signed-off-by: Filip Jensen <dev-Felipe.Jensen@duagon.com>
---
 drivers/tty/serial/8250/8250_men_mcb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/8250/8250_men_mcb.c b/drivers/tty/serial/8250/8250_men_mcb.c
index 6373234da03d..259516078793 100644
--- a/drivers/tty/serial/8250/8250_men_mcb.c
+++ b/drivers/tty/serial/8250/8250_men_mcb.c
@@ -214,6 +214,7 @@ static int serial_8250_men_mcb_probe(struct mcb_device *mdev,
 		uart.port.iotype = UPIO_MEM;
 		uart.port.uartclk = men_lookup_uartclk(mdev);
 		uart.port.irq = mcb_get_irq(mdev);
+		uart.port.dev = &mdev->dev;
 		uart.port.mapbase = (unsigned long) mem->start
 					    + data->offset[i];
 
-- 
2.34.1
