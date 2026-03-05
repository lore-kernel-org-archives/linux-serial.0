Received: from ZR1P278CU001.outbound.protection.outlook.com (mail-switzerlandnorthazon11022133.outbound.protection.outlook.com [40.107.168.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CFCB17B50A;
	Thu,  5 Mar 2026 16:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.168.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772728461; cv=fail; b=OE+QJxDLwR9tQTpzpLyXLl1Hh1t1VWr4ya5ycYKE67TytovjjH2lAi5QKrB7S7VFVMs/Aa+GLQwY26N9bnMvUejZe7Ez027I/vn/Momd5fMpZxHqOvY0Q7JfNmh4H8lgPASI26m963gLiMcGDEb8qzAWe1ZTKQw5twWZScR4+Jw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772728461; c=relaxed/simple;
	bh=I3ZvCopaZW8hXNpx1fhU4yVdIdiDKlCqo66Q+v/1U0M=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Zy8OlvR6/EwIlH49Ed+3snCYkNjZzkzZgystdS92YaAVHPc1IrGHDc9iV3nRWFY2hM4+KtZ7NQBeUmECynVrFn3ZAboGShwN5/vhdnToCOYBHm0Ug+CXnBhZ522UMo0u+E4MHe/NoH76Xc5zCytknDLvFAufMsGGmca0F0c24Hw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=duagon.com; spf=pass smtp.mailfrom=duagon.com; dkim=pass (1024-bit key) header.d=duagon.com header.i=@duagon.com header.b=ZxOQyzve; arc=fail smtp.client-ip=40.107.168.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=duagon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=duagon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=duagon.com header.i=@duagon.com header.b="ZxOQyzve"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zvn9exXN0F42cBuvUrjp8LLjz2OppQPRWO49vrobMeZ6wuQiaAc7NcX/94SGLTp8XFGuzrwPuqakOucjpf0CgM+gp2xo/KN4rF+C7yr4ii7z7zHROYNX9S5GZvq/KVYap2KMNUCxtkNcNSsATfJEGNKsWmMuaiDi5cZH3xlwZFrcK8MLsWYBtmdxAVLH2+82clmn2h27iPnSQZ4pP/vq3yKXlEYplOG+3cOp6F/DM/orQ9qjXKClRsCCL35zAn+Hmibt4/+DsCqZ6Avjp+HtZKzB6tj3PI4FmipmRj7I6fZgJgcp4Y2cC8Vlg1WMiZl6Y8Jim8AVzEWs+i/AJhkmDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BfShuYY3ArKQSEOvEGR6e29GcQxAoJZvHmSQpwU5hVA=;
 b=O+U9qvjBt6j3bdCCyEuMN6O6YnYg20DDmLaaC+EMoaJNnc0nMicXfyhTxGRzWzBKRR5ZagmOPxQKL36BvuxDxgjg00uUiAV14KYlMMxtH4P/kz0ovhfkPNjS6+Q/+03Y3/DSxGA1fwpedNiZJq6i4HzVeWVBHUU+PpkCa4pN+2F8jAIhRAw58ejPrNVO78PaPhgNnxr1Wia5rV+m1NzmFgw70+zWI6FOTtWWIYTO8xYz29XmVqctWNbwCcd0cFsVQ7S5Kne3JUbtepLhIw7Id8NpwG4/EkcL6SCtWylErdEP+u8RZ1kx/9tTTYtS9KEkNa+kI4/firpObUuBFmG5Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 40.93.85.2) smtp.rcpttodomain=gmail.com smtp.mailfrom=duagon.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=duagon.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duagon.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BfShuYY3ArKQSEOvEGR6e29GcQxAoJZvHmSQpwU5hVA=;
 b=ZxOQyzvecpZwc6CwRG2PhziE5L5TbHooXJnybVfnK4Oc5lMWEbgf45H/Xwd8IC/M2LEOHvxLicMuF5rDn9wCXOwguZLB3/6D6dha9FxSvZk9SluKeD/xroXmQGytODIWpzpCRmaX+iP1HxWeIYKeksyoHuGV0dNe2wFV0RCYqSI=
Received: from DUZPR01CA0158.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bd::17) by GV0P278MB1766.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:6e::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Thu, 5 Mar
 2026 16:34:12 +0000
Received: from DB1PEPF000509E9.eurprd03.prod.outlook.com
 (2603:10a6:10:4bd:cafe::92) by DUZPR01CA0158.outlook.office365.com
 (2603:10a6:10:4bd::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.23 via Frontend Transport; Thu,
 5 Mar 2026 16:34:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 40.93.85.2)
 smtp.mailfrom=duagon.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=duagon.com;
Received-SPF: Pass (protection.outlook.com: domain of duagon.com designates
 40.93.85.2 as permitted sender) receiver=protection.outlook.com;
 client-ip=40.93.85.2; helo=ZRAP278CU002.outbound.protection.outlook.com; pr=C
Received: from hz-deliver02.de.seppmail.cloud (2a01:4f8:272:5fe6::218) by
 DB1PEPF000509E9.mail.protection.outlook.com (2603:10a6:18:3::61b) with
 Microsoft SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Thu, 5 Mar 2026 16:34:12 +0000
Received: from hz-glue04.de.seppmail.cloud (unknown [10.11.0.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by hz-deliver02.de.seppmail.cloud (Postfix) with ESMTPS id 4fRZql66dVz11H3;
	Thu,  5 Mar 2026 17:34:11 +0100 (CET)
Received: from hz-glue04.de.seppmail.cloud (unknown [172.18.0.4])
	by hz-glue04.de.seppmail.cloud (Postfix) with ESMTP id 4fRZql5m2Tz27lw;
	Thu,  5 Mar 2026 17:34:11 +0100 (CET)
X-SEPP-Suspect: 1c0a34b3a6274da6b111a96a35a439d6
Received: from hz-scan08.de.seppmail.cloud (unknown [10.11.0.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by hz-glue04.de.seppmail.cloud (Postfix) with ESMTPS id 4fRZql58Zvz246f;
	Thu,  5 Mar 2026 17:34:11 +0100 (CET)
Received: from hz-scan08 (localhost [127.0.0.1])
	by hz-scan08.de.seppmail.cloud (Postfix) with SMTP id 4fRZql4gKJz2kL2;
	Thu, 05 Mar 2026 17:34:11 +0100 (CET)
Received: from hz-m365gate04.de.seppmail.cloud (unknown [10.11.0.37])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by hz-scan08.de.seppmail.cloud (Postfix) with ESMTPS;
	Thu, 05 Mar 2026 17:34:10 +0100 (CET)
Received: from ZRAP278CU002.outbound.protection.outlook.com (mail-switzerlandnorthazlp17010002.outbound.protection.outlook.com [40.93.85.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (not verified))
	by hz-m365gate04.de.seppmail.cloud (Postfix) with ESMTPS id 4fRZqj1sdMz1y53;
	Thu,  5 Mar 2026 17:34:09 +0100 (CET)
Received: from ZR0P278MB1218.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:80::5) by
 GV1PPF532F3E036.CHEP278.PROD.OUTLOOK.COM (2603:10a6:718::213) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18; Thu, 5 Mar 2026 16:34:07 +0000
Received: from ZR0P278MB1218.CHEP278.PROD.OUTLOOK.COM
 ([fe80::311:4b5c:48da:9514]) by ZR0P278MB1218.CHEP278.PROD.OUTLOOK.COM
 ([fe80::311:4b5c:48da:9514%5]) with mapi id 15.20.9678.017; Thu, 5 Mar 2026
 16:34:07 +0000
From: Filip Jensen <dev-Felipe.Jensen@duagon.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	mingo@kernel.org,
	tglx@kernel.org,
	osama.abdelkader@gmail.com,
	kees@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Filip Jensen <dev-Felipe.Jensen@duagon.com>,
	Jose Javier Rodriguez Barbarin <dev-josejavier.rodriguez@duagon.com>
Subject: [PATCH] serial: 8250: null ptr deref in has_acpi_companion
Date: Thu,  5 Mar 2026 17:33:58 +0100
Message-Id: <20260305163358.42599-1-dev-Felipe.Jensen@duagon.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA3P292CA0023.ESPP292.PROD.OUTLOOK.COM
 (2603:10a6:250:47::7) To ZR0P278MB1218.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:80::5)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	ZR0P278MB1218:EE_|GV1PPF532F3E036:EE_|DB1PEPF000509E9:EE_|GV0P278MB1766:EE_
X-MS-Office365-Filtering-Correlation-Id: 48ca7a58-e215-435e-50db-08de7ad5088a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|52116014|366016|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info-Original:
 A99eEKt1BtslbGGN9iGlR3LdpcivngJqgfxSN2gorGT/sKuoukHqfMEM51qm7mDXZsMfipW4aeRXmx1xWAJbuCpa1B0XRol9pwqn/oBXj3ulePiAPu3rZJi9uskrPRh7zNRxsjqOorRDK0QkxDMas8iF98nXBuFRgXLNKIAR+oiy9kr/RmDWWpnBs3YhQ6/TJMUOR5RTwGTeis8UKaISVQtW+9ffU7kpqBq+i3NYO4VDRBYjEgQTPn0+gUbfF1FfS227GtrcvkrExOvTZ4pijJ1LkPfyv0+SGOUS2pX3PvaEP5wH0a2YgP1tftgPEeBvvmEWTrBCcWLjXw4yK/8cumBGXXdZ3hfWn2lJGpSdbqG3sdePdmAL9w+XKQOG7//WOmM+9mLJe2TUY0MO5LUUmJ5PZYexUv3txBu7cHlOCqRJVuo9pNj+0Ib79H/ctRhRy3LzWqK0CJF9DRIwuWvdgL7ffquaEHEK+WX1RPh61ZpkeGpgWY3KrTlSP2xhieayHKI1OlGDGYn6gtC+abhE6Z1naLe/B26HRo43rfXtdQqyiOwrlyRK6U5AnizSwmD6LRyZRA0xi1R0haqJnKvKrEVIS0WwR5PmyDkZKy68arUnyDeauxVbi7Fd0wUz24/Fw3Bs/FhxWffeyztjs5pZbJWcOYOtE0zby04riukmY0M6se84WSVIc/5PhhbekEZI88mb6zG1s9HYGPJ1OVWkDSU7ZQUX0DddUuiEhonRRxrW8G5P7AjMeM3jLPdArdL/7+w4/h4i709AUYikeOFfEjhBjlhKq5Hc3C9g1jli+yU=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZR0P278MB1218.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PPF532F3E036
X-SEPP-CCCVersion: 2025-12-11T08:12:51+01:00 9ed91da2
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender:
 ip=[40.93.85.2];domain=ZRAP278CU002.outbound.protection.outlook.com
X-MS-Exchange-ExternalOriginalInternetSender:
 ip=[40.93.85.2];domain=ZRAP278CU002.outbound.protection.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF000509E9.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	45127269-d420-4d1f-5a5e-08de7ad505b5
X-SM-ruleversion: 2.1.0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35042699022|10070799003|376014|1800799024|14060799003|82310400026|36860700016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vBIkhIuMZtPcQSEkg/x73d37Tz02tDyQjAvigcqUTpum5QxHBoX3KycAm58h?=
 =?us-ascii?Q?hd/kFEkYbJpyUZFam8IWuJZsiYglsFnKA+HCq/Cw+euG6ElWT63Q7YwqOoN6?=
 =?us-ascii?Q?hyt+BSJoqQ52xoCU4S5ZintwskTAprNqdYs3muA1gFVr8EoW6lQICLmIHr3x?=
 =?us-ascii?Q?X14GjshczKkG2CtILnya1JgszQStNRROfktF5kprl2MRrYTgk4QDU6vb0Col?=
 =?us-ascii?Q?VvdIjMKyf5VlefnstOerDHwDGZikeTUtPSS/s0gp2JgCCrw0/U4NBV+16XH6?=
 =?us-ascii?Q?2cwo9RIBIH8bwE/J5b8GgJfpI0sW/GlYMJx4Y1df8Y14RliuSEYh1WWDRm1t?=
 =?us-ascii?Q?4HHmmSx+XMzg+hmmcFf+uNiZ/I7d5xGFPFRP4aTxZctwg65Srlyq51bXIm0K?=
 =?us-ascii?Q?v37YjzqknaQIxqy4Q+b4+HObAQbxv7OaTqsR9FMKQv4KyhxW4Nf/szUBxSv5?=
 =?us-ascii?Q?9CG5wbhrBz8J0nUr5tUVrwk9uB7dpDMQ6ZiWH3HLsFsymrqHz4jeunDmozCE?=
 =?us-ascii?Q?VXBtYa3loEup4OoAg2AEA/WCued/kXjxUcOMmHXThqIogVQV9yoZ0BN/kjj4?=
 =?us-ascii?Q?V8ZdRyvC7qQem086U1AhKRfvXBfuAp88ispn6+bM8DKrlGd7K6i9VjI3rdQj?=
 =?us-ascii?Q?YFHV1MWGAsFkcuV/ItegCjhAydPuOxl4mDp/YAhI5ik71GvTn/9Ok8oE9Jwo?=
 =?us-ascii?Q?OaNWgQcOvIqOBff+BQQBjIFBh/XDncouBXuX+ZEVAfHR1IEOeIZXfau3sd6K?=
 =?us-ascii?Q?Vdn03RURmwbCMJ0KtaLvEKGSszRU9Qr+kjozdKQiCaLuNL8i5osd7lPX7SsI?=
 =?us-ascii?Q?++utFWMUtsImYc6NJyohBeHKHtQbpBPM69jMv0YUvUKUWvY6QrDnNIDBkd4a?=
 =?us-ascii?Q?7sLfZ2KD2w4oLfW6VwL67ANuAUzSKnTSr0f2HsrzSdgzxOc7p0jlPfcax1iS?=
 =?us-ascii?Q?GiuYQY8a31qgNxAAo25fE836kwBGUhaJyxWCXTqxAvXHQSp/NZMS6LYViJ08?=
 =?us-ascii?Q?BPbkVRUcNZ29YcsvKhrPLqcvREnpNm4b5J5wR2TUQr3ggGphzI3I/ioEEyOI?=
 =?us-ascii?Q?zAsCxzoJZIRSXAK0Hg3AxyvYDsvSFQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:2a01:4f8:272:5fe6::218;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZRAP278CU002.outbound.protection.outlook.com;PTR:mail-switzerlandnorthazlp17010002.outbound.protection.outlook.com;CAT:NONE;SFS:(13230040)(35042699022)(10070799003)(376014)(1800799024)(14060799003)(82310400026)(36860700016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	wwUhs8X0xUX7e3Iv41bbsS+XRkg+zNFjY1KDRDsb8RkjzdiVqAxGi1bJE5MxintGlcgSSoTqnq7zRpoPylfHc5p8Cj1Zi3jc/6slW55b464QYwtyDH7+aHNYwTnamzSTfzOpjshQCMt/UgKt5MEISCxNnTFW5xvTaLpO4ZQNU1KUuJktjTIP5Mo1XJSeGKFRK8zgG9DYoXNNwGWoj2SOjzxGfI+GU6MI+VPt7l9LI98OAz6irL1C8Tn78cWQKgNi/ocBlCWAQZJH4N4wjK7fUwCok/+Hbo8I4aueL/q0b9Vd34K2qrhFhQdbCSAq0XkQdXU3iMtGFhK/5AR6q/i5bDYnR5fPQCcgJOHVAx8X5y6Pbre1InkbEiH6NFpc0Gtl3UzRIBGdW0gJEqGDMHwK2PR8ocu6/80Jez+RBBQC0wKsaM0TuQL7EquM3YEmm2uc
X-OriginatorOrg: duagon.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 16:34:12.1696
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 48ca7a58-e215-435e-50db-08de7ad5088a
X-MS-Exchange-CrossTenant-Id: e5e7e96e-8a28-45d6-9093-a40dd5b51a57
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5e7e96e-8a28-45d6-9093-a40dd5b51a57;Ip=[2a01:4f8:272:5fe6::218];Helo=[hz-deliver02.de.seppmail.cloud]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509E9.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB1766

uart->port.dev is set in serial8250_register_8250_port if the port number
is under the initial CONFIG_SERIAL_8250_RUNTIME_UARTS. If unset, it will
depend upon up->port.dev being set by the particular serial driver. A
faulty driver might not set this value and this leads to null pointer
dereferenced later in has_acpi_companion and later at uart_add_one_port
call:

Oops: general protection fault, probably for non-canonical address
KASAN: null-ptr-deref in range
RIP: 0010:serial8250_register_8250_port+0xd34/0x2030
drivers/tty/serial/8250/8250_core.c

Reviewed-by: Jose Javier Rodriguez Barbarin <dev-josejavier.rodriguez@duagon.com>
Signed-off-by: Filip Jensen <dev-Felipe.Jensen@duagon.com>
---

For a case of a low level driver not setting this, cf.
Link: https://lore.kernel.org/linux-serial/20260305162815.41818-1-dev-Felipe.Jensen@duagon.com/

 drivers/tty/serial/8250/8250_core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index d2e2c5dfef99..8ac3f4efa7fd 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -756,6 +756,8 @@ int serial8250_register_8250_port(const struct uart_8250_port *up)
 		if (ret)
 			goto err;
 	}
+	if (!uart->port.dev)
+		goto err;
 
 	if (up->port.flags & UPF_FIXED_TYPE)
 		uart->port.type = up->port.type;
-- 
2.34.1
