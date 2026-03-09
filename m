Received: from ZRZP278CU001.outbound.protection.outlook.com (mail-switzerlandnorthazon11021134.outbound.protection.outlook.com [40.107.167.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF6E3B893E;
	Mon,  9 Mar 2026 14:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.167.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773066555; cv=fail; b=e/09m3GpimsTXMGrMXJgiruF0dzjZDfGMXc4a4Ja80/jVAAVmLC9nPYS1zKFY1NNJBRXJ5RvqCnnSr7BhJuGXmRJo54knbmVfS+5n2FqD8q6fHNTE43srXNMML8EaNijBGRba8K9yrbhSy7TMz3kLE7c9yDJYndfHNQX8c65QzI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773066555; c=relaxed/simple;
	bh=SUm/YSiPy7FO1j3B2AOnoa0wvY8KIDIeqAUPiLsh0Ys=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=q5FfYhO/2HKjekxjp/r4OqHV80CH1JiP1omoPwsNI9/cQjEk85OK2gSW53xTk0fcjp8mzh/555aMB9ItgP2+dwMU7M4LH5kA1A+jVfrVcfPMo8uVBQVIl7DLFfDaxccx5nZ2J7HZqXgR0AukBmPM53ARaw/QjHfW0o2fnbrygQQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=duagon.com; spf=pass smtp.mailfrom=duagon.com; dkim=pass (1024-bit key) header.d=duagon.com header.i=@duagon.com header.b=F2krkViq; arc=fail smtp.client-ip=40.107.167.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=duagon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=duagon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=duagon.com header.i=@duagon.com header.b="F2krkViq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M42dThjPhUiU/WVmGGPnapieNg4RQTBdBgmcG4XYLAIDr82/gN7eCIGX/YHuZyX6FPS8Yu5Fb+Aq/OfVHLUfWZut5aO7y99SjbaDrEGNtjdniCKfQnfoVB9spUVb62xgHhnCFNSA2U20vzJvP+psKvuj1Ljfic2A5SXY6eBP6r85vxNcWYxZ69K0R0t2ntHAcHFUicNsWwtfLFaqCJZiKieWC6YDYveagMVzqckaRBN4m4GiOX9z7NXqcQUZNFwSWTOKl7zmPVUoYZ4SsQq6IxX0/f9DQPWGGCY8liOAFGMsdQYlVNbxig0agP6JydoYM02cvnT0eG8s1WbZgkbEjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/+RCVrWfMUcRpMcp+l7g8q/dXotLe8fX78SOB0Gxyck=;
 b=W8RkN7pwUXwnkYvhW4kibzuoidGe/IiS7GGm39FUgFB9oPvOJtJRC1s8ucsRr8GrzZioIlbgzf6wnIW7tauBka75DCHbWkddH1qjgRhHcq4CPSfoi0jo+kRQrXNhCJw4C9FKn5zn8MLkL/1zxIRN5dP++ga1bSw7gUjVDQ2oSHN7pFwVASbrxfDXsdJcdUFK4UWxs8qeobvThFZOLRkGOK0GGVxg2S4yzSpKq2D2ojCprXafDma499WN6C7aP9cChfHKq7Q6gCpjf57a0j1oMJjkLcHtH6tBNeDwO9Ug2jHT3wxG0l1KjpYoJhACIrI4fXQQlDnwfQtLn3XLCOvhOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 40.93.85.0) smtp.rcpttodomain=kernel.org smtp.mailfrom=duagon.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=duagon.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duagon.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/+RCVrWfMUcRpMcp+l7g8q/dXotLe8fX78SOB0Gxyck=;
 b=F2krkViqMEwA9ts+GFgf3XEKch6tHpsyiSR3NPg/ZUrM91qgxc8ZvmY7lE6q9N+RwT1+6pAZLgNzktCvsTGi2Cgg3DmzlBG4FhEHELUtbw8Yb5CdcI6zmzadov4gYE79Qn2tkWmr6lNBbkEX4fgsUq4SF3mFmSbsPZfsYs7Jw/U=
Received: from AS4PR10CA0002.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5dc::19)
 by ZRAP278MB0924.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:4c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Mon, 9 Mar
 2026 14:29:07 +0000
Received: from AMS1EPF0000004A.eurprd04.prod.outlook.com
 (2603:10a6:20b:5dc:cafe::ed) by AS4PR10CA0002.outlook.office365.com
 (2603:10a6:20b:5dc::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.25 via Frontend Transport; Mon,
 9 Mar 2026 14:29:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 40.93.85.0)
 smtp.mailfrom=duagon.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=duagon.com;
Received-SPF: Pass (protection.outlook.com: domain of duagon.com designates
 40.93.85.0 as permitted sender) receiver=protection.outlook.com;
 client-ip=40.93.85.0; helo=ZRAP278CU002.outbound.protection.outlook.com; pr=C
Received: from hz-deliver02.de.seppmail.cloud (162.55.72.218) by
 AMS1EPF0000004A.mail.protection.outlook.com (10.167.16.134) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.18
 via Frontend Transport; Mon, 9 Mar 2026 14:29:07 +0000
Received: from hz-glue06.de.seppmail.cloud (unknown [10.11.0.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by hz-deliver02.de.seppmail.cloud (Postfix) with ESMTPS id 4fTzsb10wgz11H3;
	Mon,  9 Mar 2026 15:29:07 +0100 (CET)
Received: from hz-glue06.de.seppmail.cloud (unknown [172.18.0.5])
	by hz-glue06.de.seppmail.cloud (Postfix) with ESMTP id 4fTzsb0mprz20Y7;
	Mon,  9 Mar 2026 15:29:07 +0100 (CET)
X-SEPP-Suspect: 9b993bbcceec47eea4d7bec8f92035f3
Received: from hz-scan10.de.seppmail.cloud (unknown [10.11.0.51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by hz-glue04.de.seppmail.cloud (Postfix) with ESMTPS id 4fTzsb0J3xz27hH;
	Mon,  9 Mar 2026 15:29:07 +0100 (CET)
Received: from hz-scan10 (localhost [127.0.0.1])
	by hz-scan10.de.seppmail.cloud (Postfix) with SMTP id 4fTzsZ6x7Rz4h3d;
	Mon, 09 Mar 2026 15:29:06 +0100 (CET)
Received: from hz-m365gate04.de.seppmail.cloud (unknown [10.11.0.37])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by hz-scan10.de.seppmail.cloud (Postfix) with ESMTPS;
	Mon, 09 Mar 2026 15:29:05 +0100 (CET)
Received: from ZRAP278CU002.outbound.protection.outlook.com (mail-switzerlandnorthazlp17010000.outbound.protection.outlook.com [40.93.85.0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (not verified))
	by hz-m365gate04.de.seppmail.cloud (Postfix) with ESMTPS id 4fTzsX73M6z1y77;
	Mon,  9 Mar 2026 15:29:04 +0100 (CET)
Received: from ZR0P278MB1218.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:80::5) by
 ZR2PPF9EBA01141.CHEP278.PROD.OUTLOOK.COM (2603:10a6:918::2e3) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.25; Mon, 9 Mar 2026 14:28:58 +0000
Received: from ZR0P278MB1218.CHEP278.PROD.OUTLOOK.COM
 ([fe80::311:4b5c:48da:9514]) by ZR0P278MB1218.CHEP278.PROD.OUTLOOK.COM
 ([fe80::311:4b5c:48da:9514%5]) with mapi id 15.20.9678.024; Mon, 9 Mar 2026
 14:28:58 +0000
From: Filip Jensen <dev-Felipe.Jensen@duagon.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	ilpo.jarvinen@linux.intel.com
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Filip Jensen <dev-Felipe.Jensen@duagon.com>,
	Jose Javier Rodriguez Barbarin <dev-josejavier.rodriguez@duagon.com>
Subject: [PATCH v2] serial: 8250: Fix null ptr deref has_acpi_companion
Date: Mon,  9 Mar 2026 15:28:36 +0100
Message-Id: <20260309142836.95514-1-dev-Felipe.Jensen@duagon.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA2P292CA0017.ESPP292.PROD.OUTLOOK.COM (2603:10a6:250::20)
 To ZR0P278MB1218.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:80::5)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	ZR0P278MB1218:EE_|ZR2PPF9EBA01141:EE_|AMS1EPF0000004A:EE_|ZRAP278MB0924:EE_
X-MS-Office365-Filtering-Correlation-Id: 872e185d-e6e9-441e-6b53-08de7de83915
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info-Original:
 rVxEd2MdvlP2mfmwYvn/bEsGYNk0uVGqSnLCnpFcEbN4TQwcy9knqPKn8CDbP++0suRV+PkMv42s6LSI1/FLSN+69t/Gog1U2Z3BmgtGMEjFoLTYvVOQPzNQahzNXnznV6tC9FlAAel7H8EOe70Cncjrg0Qe56u+uUw13SMOoKAWFZQGhk0byNQCEZFPs7l/Goxh6dLxhfYmP7ScPqp3xERtgayPCHpKzBYdys1p0UaXXC7TkR4+4ZVKb8IJQjvLmUQhsBX3CSLMiFCzGTYMy9CA+ucYnBxECksoXgCB/2SBbpKUXBk2AZ8FU8IyA8wok0MgLgoNVTlJGms1puEtBrzBI2bmwW5cqqyTYZYJQyxLrbA4hblTZvXgkqHUhUVbPx9/hAfhzRUwRlGaFaE/uPrK7kXYfmqQDMM74OltqKcktjq4qgqisNryOS1sTZNZ1MkOPI4pblD5HwEMyOvWbMEx5m1UPb2uw3tkOLmDQ/tOviTEqQ2O9lw8LkGe+QYplfUZ5p/XUbij40yjoBjXcx2EU+u9GDf0iVZ2geka4mT+okMvDv/q4BKU/HEkUCx7v3ES8pk0jmhOjNSs5wgnD5pAed5WStgXm0rGe4fU491/hVxlMQx6oPyoBZ/5xhsNrR/qIwl7/05k2vqIaQC+W/DLmzyuVj8/6NPd9vBQz7tq33ipDFq62Fi9kuC39FmtgZRHxUZRF7SW9mKUnZY76dhcph1HRFsPEk5981eCEa2CSil14I0bnW+RkEEwMO5eBnCnzayeg0vzlRte1A/ZRwEwyRxCOTE6ZLxkkn/bm5o=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZR0P278MB1218.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-Exchange-RoutingPolicyChecked:
 skTh2LzyWbULVeshcmEoE2FeWyn5XcjLgPhl23dBMgNSidK++OAG1T6MTCtGtPfyVMSznjnY/lkB7kdlNz973wXor74eMgel3ywdac7//TNNFYzfUXVD0APHm0s2xFfnb5R5fBrPJtd3WBuFqQa58RcOILMcJ4ayfnUetxPRKN4td+FBPCsQP/7AiIr/Q+FpfluI9B6Q0gN56NaPkc3YhWNYDWeiWYI0UHlwAHqg+bposBVcv9CkgN9mpJALnDbb6KGBvm1eb+A/hjqJQAJ8yqljdVFbsx48plZqzOyjX86xGQ4jlHO2z6PXcEN8keNmvOInaQEGpbreBvp5pSMXKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR2PPF9EBA01141
X-SEPP-CCCVersion: 2025-12-11T08:12:51+01:00 9ed91da2
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender:
 ip=[40.93.85.0];domain=ZRAP278CU002.outbound.protection.outlook.com
X-MS-Exchange-ExternalOriginalInternetSender:
 ip=[40.93.85.0];domain=ZRAP278CU002.outbound.protection.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS1EPF0000004A.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	7afc52e5-16ef-496b-e216-08de7de8335f
X-SM-ruleversion: 2.1.0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|14060799003|156008|376014|36860700016|35042699022|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?t+M1MV9dg3yAQZcKKGgDqQ7Ta+SO4hz6Y1COCWkS2oZ1za8fBCQDQ8wU3+CS?=
 =?us-ascii?Q?SpJcDLlA4CMPY5MMus5TRNXfY6U0KeCk476ASQQwahL48rIoxhuMqK/8+Q3i?=
 =?us-ascii?Q?9WVCYnkeo5ysdxHYev1EoFlhpYKW6egVi6yvQ7PsjXm3/b19gscwG6GvrTXt?=
 =?us-ascii?Q?HbpVIiczo3X70+9khNuS4cyH5ya4Vvg8nTK2P+yAdQlD53sOFiffhXL5z6IO?=
 =?us-ascii?Q?PPyd0L5BXDocIYrEAZFDqPF20ePLjrrwg0bPTA9zBn2ZD0wdbqfgcx9Fjpfd?=
 =?us-ascii?Q?H8EVnCL67z4g8FBW0q3YV+DOmF6MbhfRzao56isBrgS0PVejAZPnrqYVZ1Ke?=
 =?us-ascii?Q?AXrmzerpBUMkwuIxsVJcptBLvNH/l72OdgCUqFhKR1gYNDEzeZJInAnZjB98?=
 =?us-ascii?Q?1XQAZZRWUjahQ/xD01qBdcq8O/TairX4rUBkvxfuEbQf82OY/bm7QFtPFN9T?=
 =?us-ascii?Q?YAxTS1p8VUatCv2ojaoqgGtjMq6Yzfa0E3YAObfqkBiBHII2D2PQdXzhqTIX?=
 =?us-ascii?Q?GQn1XHY39XY+ezpqcaLZDlzSTvAa8iTNrly1fsSv2OJLznK4f9AyNF41L4AN?=
 =?us-ascii?Q?EiaeBeEmW4LafuH2sYC6SiEINh/9bB18zWevMXZqAN5ergqWomOWQYWCn/qF?=
 =?us-ascii?Q?JMxwnrB7esnV0VP81dxCQQbZ+VJGqgkK9UJwNcP5miR8fO+MQjt1SsNrMaMY?=
 =?us-ascii?Q?ihqSfR8zlbCjoVN39aos3XLOVfdEo3zZetACZCH6Bp4l5trDwV7Xsps6uTPU?=
 =?us-ascii?Q?RYnO/3EQoJ6MujLGXbRS6Gck9WYddo/E440hNnJHGB0At7gGCig635L8ZXav?=
 =?us-ascii?Q?4vKK97PWKSiclTMa+ESS8O6Yo5JHliN/xWpnF3ldRWLwKL7WlfHSjCuRI2U7?=
 =?us-ascii?Q?jkRzJI0nE9uh4xfkOGvsjT6n5X/geoJ81IT6Dpur7clPoMP05QQBiRiaFqUI?=
 =?us-ascii?Q?jlVOk9sfB9UAm21uPY6anBFNqGcMBTQ+r7gO2UawIYnQFaenvbehhMeM/rN3?=
 =?us-ascii?Q?6E8wIak8ZRQiXXON1OvKc/zGSZ/PTTdBmSsQFoID1t6qvkt4qHwSQV1/pz/v?=
 =?us-ascii?Q?SUrb2Lfpg1y0enrjFA08HUYbeRM/Ig=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:162.55.72.218;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZRAP278CU002.outbound.protection.outlook.com;PTR:mail-switzerlandnorthazlp17010000.outbound.protection.outlook.com;CAT:NONE;SFS:(13230040)(82310400026)(14060799003)(156008)(376014)(36860700016)(35042699022)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	AMYBdyvc5nQhzOvwatUPFiha3zXVghwaW9PlJj9zPynYlFQ3glIf7yv78hGL++oYXUvlc4GG3OzkRlGJR6CIgqFgos0EfOHKHXRxpCf5fSh8A+7aZT2zEl/lslPqhDndBrU0mje1PaFdefmwvMWVZeb6cfUAdh6e554lRoWTci54QK6Nnn84L7w0SlUb1AjI3O3r9a27Z2RU/4oQSu1lqlZqXuTlkTWyrYlaGTJT//mNSBw0B5rZNocJ4A10zeRzTUsW0cR3HB6P4iILfLYVhWEuaxFX7tKdDLqh9x6mz8iy5jFT3r8pp2CWXmT5MkPSr10lfmVvBpJxW6Pc++cUPD9t5OX1cSVkqP2yvivP/fFyxm4f8Z664/ovWbVmTg1f9GGFxXAcNfE4MB48krZZfk751uJS2V+6IcfaUFCSIv3G9smZSOWqcg6fuNQbs4sN
X-OriginatorOrg: duagon.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 14:29:07.5918
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 872e185d-e6e9-441e-6b53-08de7de83915
X-MS-Exchange-CrossTenant-Id: e5e7e96e-8a28-45d6-9093-a40dd5b51a57
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5e7e96e-8a28-45d6-9093-a40dd5b51a57;Ip=[162.55.72.218];Helo=[hz-deliver02.de.seppmail.cloud]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF0000004A.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZRAP278MB0924

uart->port.dev will have a value in serial8250_register_8250_port if the
port number is under the initial CONFIG_SERIAL_8250_RUNTIME_UARTS. If
unset, it will depend upon up->port.dev being set by the particular serial
driver. A faulty driver might not set this value and this leads to null
pointer dereferenced later in has_acpi_companion and later at
uart_add_one_port call:

Oops: general protection fault, probably for non-canonical address
KASAN: null-ptr-deref in range
RIP: 0010:serial8250_register_8250_port+0xd34/0x2030
drivers/tty/serial/8250/8250_core.c

Reviewed-by: Jose Javier Rodriguez Barbarin <dev-josejavier.rodriguez@duagon.com>
Signed-off-by: Filip Jensen <dev-Felipe.Jensen@duagon.com>
---

Thank you very much for the revision, Jiri. As suggested, I have removed
people from the recipients list that have not made relevant changes related
to this patch recently.

V1 -> V2: Fixed that the return value was not setting an error value.
Rewriten the subject to make clear that this is a fix to a posible null
pointer deref and slightly rewriten the description for the changelog.

V1: https://lore.kernel.org/linux-serial/20260305163358.42599-1-dev-Felipe.Jensen@duagon.com/

For a case of a low level driver not setting this, cf.
Link: https://lore.kernel.org/linux-serial/20260305162815.41818-1-dev-Felipe.Jensen@duagon.com/

 drivers/tty/serial/8250/8250_core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index d2e2c5dfef99..d758f871fbbd 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -756,6 +756,8 @@ int serial8250_register_8250_port(const struct uart_8250_port *up)
 		if (ret)
 			goto err;
 	}
+	if (!uart->port.dev)
+		return -EINVAL;
 
 	if (up->port.flags & UPF_FIXED_TYPE)
 		uart->port.type = up->port.type;
-- 
2.34.1
