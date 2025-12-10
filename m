Received: from ZRZP278CU001.outbound.protection.outlook.com (mail-switzerlandnorthazon11021110.outbound.protection.outlook.com [40.107.167.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D952ED168;
	Wed, 10 Dec 2025 16:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.167.110
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765385327; cv=fail; b=ooqiESNwxXg2mQ0/Tq/gG20uLJn5B0vFMurliCArzcD9S+14Dc5czduCMxrkDZacdquGDPwYMmuy0RP71Xtz0yH9kkrZfbzggUCSop4qf6MdtjLoM5fLBu43CNfqp5RCjhowT9Rtg/AMec8hj+LiRv1n3eqcYT3+BeLS7myTCBQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765385327; c=relaxed/simple;
	bh=b9evncw4gyOaeewJw+fNZ0Qf+lGkAmyinpjbmP7pbqQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fQFXsjBj9BJg3LZ3s3QeyzNDqAJeQLW76rjOxJBfLjnAQsNP9/ZSY+DFyQjfue8xiN3Jx0Nh7gy/wqBi6109k5DVun+tegGsGhHSTPeTAJCXzlZIfaZ3hjF+PaVJprTCcBTtkunDaMQWiB9NWYECXCLeFgM+0UHPcByJkK604KE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=duagon.com; spf=pass smtp.mailfrom=duagon.com; dkim=pass (1024-bit key) header.d=duagon.com header.i=@duagon.com header.b=be2Bl2oG; arc=fail smtp.client-ip=40.107.167.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=duagon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=duagon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=duagon.com header.i=@duagon.com header.b="be2Bl2oG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xI8Jms/7i2HqWTuX/1ug2mDQAUOBIs8FvikJtE48YF5uDDbZ2KF1/XFUmhM6ROPwm3t9aIn1OzIS2RDCH0vGZ+9DEHbpEA+MNCB3CuT2Rj9avPZPTLfqdK4lz+0w61Ea0IW9gN3+hit5N2XTGUv0KAfAcOs2Vh5arBiUPnoeLXjTlxOOs92HfAXR1xv+2z849gm1VjOQrjtbOvVKzCRIs6pPCbSvEGU3U1EoiuEP8UIvwPOKX4YuWNfjxr2vK2jLAUjnjcroQfmAWsr2beEv6K5Nbny1COsFNlNM/bZnok8LawP7oWsWF0m9065m9AzZbMlhqTxTPjzpKvdIriNpVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8oXl5ZOG6uh1JNvGyJJXNuv0LWR5+pMwhAKsYN3ruu4=;
 b=D5OAeC/jyPYVKVIUKxTansGhMylGs1DVenl4E5pN3CuAPHr1LkjpzqTDHhi96tqPzcTEZaHNZCKCbxKO/DcMPi99wHsnX9RsT3STZ9w2qb4JoANS2d5aeibRfWD1wpWWyt3iOlt2cqHXIPHc+ehkFnCjcheNuFHJf3eQieLIxwIi2UhsqNGWqVrjXSh2NFLL7TOMI2mwxx2U6swRgts7vH/DOj0IUSttrOPuC6/Ox4wyYP/Hc3fJBbYRbPYcHxfPA609qRCy9xkEBRjyKZz19I4q/ZhG6rxKjHQnpKOxiWO7D/PeUBqGD+TMUwSiE4z52iaw25pSfzITeX34gDI3iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 40.93.85.30) smtp.rcpttodomain=kernel.org smtp.mailfrom=duagon.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=duagon.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duagon.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8oXl5ZOG6uh1JNvGyJJXNuv0LWR5+pMwhAKsYN3ruu4=;
 b=be2Bl2oGDp1EdAhIAu3/yM0/QJxpw1rsFnV5P9rdQbBkJpo6aB88r39nef6i274TiO0XPep+ZyvcDtz71rw3aqx1UcqsCWq1TE50rAgnZiIb6YqOLJCcx+dMUYSEz/Sl/o8xEwvAk5FvcOjx1gOXW3LTEesmI7sbQhMpttW9IZQ=
Received: from DUZPR01CA0008.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c3::17) by GVAP278MB0135.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:21::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Wed, 10 Dec
 2025 16:48:39 +0000
Received: from DB1PEPF000509E6.eurprd03.prod.outlook.com
 (2603:10a6:10:3c3:cafe::c9) by DUZPR01CA0008.outlook.office365.com
 (2603:10a6:10:3c3::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.8 via Frontend Transport; Wed,
 10 Dec 2025 16:48:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 40.93.85.30)
 smtp.mailfrom=duagon.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=duagon.com;
Received-SPF: Pass (protection.outlook.com: domain of duagon.com designates
 40.93.85.30 as permitted sender) receiver=protection.outlook.com;
 client-ip=40.93.85.30; helo=ZRZP278CU001.outbound.protection.outlook.com;
 pr=C
Received: from hz-deliver01.de.seppmail.cloud (162.55.72.219) by
 DB1PEPF000509E6.mail.protection.outlook.com (10.167.242.56) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.8
 via Frontend Transport; Wed, 10 Dec 2025 16:48:38 +0000
Received: from hz-glue03.de.seppmail.cloud (unknown [10.11.0.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by hz-deliver01.de.seppmail.cloud (Postfix) with ESMTPS id 4dRM9f2zDvz4www;
	Wed, 10 Dec 2025 17:48:38 +0100 (CET)
Received: from hz-glue03.de.seppmail.cloud (unknown [172.18.0.6])
	by hz-glue03.de.seppmail.cloud (Postfix) with SMTP id 4dRM9f2djKz1xZZ;
	Wed, 10 Dec 2025 17:48:38 +0100 (CET)
X-SEPP-Suspect: ddc60bbfdeb9457daaba3d4ca9bfb9c6
Received: from hz-scan07.de.seppmail.cloud (unknown [10.11.0.49])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by hz-glue05.de.seppmail.cloud (Postfix) with ESMTPS id 4dRM9f25lWz1wLh;
	Wed, 10 Dec 2025 17:48:38 +0100 (CET)
Received: from hz-scan07 (localhost [127.0.0.1])
	by hz-scan07.de.seppmail.cloud (Postfix) with SMTP id 4dRM9f1VbjzmJd;
	Wed, 10 Dec 2025 17:48:38 +0100 (CET)
Received: from hz-m365gate01.de.seppmail.cloud (unknown [10.11.0.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by hz-scan07.de.seppmail.cloud (Postfix) with ESMTPS;
	Wed, 10 Dec 2025 17:48:37 +0100 (CET)
Received: from ZRZP278CU001.outbound.protection.outlook.com (mail-switzerlandnorthazlp17011030.outbound.protection.outlook.com [40.93.85.30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (not verified))
	by hz-m365gate01.de.seppmail.cloud (Postfix) with ESMTPS id 4dRM9c4Fhcz2wgh;
	Wed, 10 Dec 2025 17:48:36 +0100 (CET)
Received: from DUZP191CA0071.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:4fa::11)
 by ZR0P278MB1043.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:54::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Wed, 10 Dec
 2025 16:48:34 +0000
Received: from DU2PEPF0001E9C2.eurprd03.prod.outlook.com
 (2603:10a6:10:4fa:cafe::7e) by DUZP191CA0071.outlook.office365.com
 (2603:10a6:10:4fa::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.7 via Frontend Transport; Wed,
 10 Dec 2025 16:48:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.79.220.33)
 smtp.mailfrom=duagon.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=duagon.com;
Received-SPF: Pass (protection.outlook.com: domain of duagon.com designates
 20.79.220.33 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.79.220.33; helo=de1-emailsignatures-cloud.codetwo.com; pr=C
Received: from de1-emailsignatures-cloud.codetwo.com (20.79.220.33) by
 DU2PEPF0001E9C2.mail.protection.outlook.com (10.167.8.71) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Wed, 10 Dec 2025 16:48:32 +0000
Received: from GVAP278CU002.outbound.protection.outlook.com (40.93.86.2) by de1-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Wed, 10 Dec 2025 16:48:31 +0000
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=duagon.com;
Received: from ZR0P278MB1218.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:80::5) by
 ZR0P278MB1556.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:a3::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.15; Wed, 10 Dec 2025 16:48:29 +0000
Received: from ZR0P278MB1218.CHEP278.PROD.OUTLOOK.COM
 ([fe80::a0e2:7867:dcd3:b9c3]) by ZR0P278MB1218.CHEP278.PROD.OUTLOOK.COM
 ([fe80::a0e2:7867:dcd3:b9c3%5]) with mapi id 15.20.9388.013; Wed, 10 Dec 2025
 16:48:29 +0000
From: Filip Jensen <dev-Felipe.Jensen@duagon.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org
CC: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Filip Jensen <dev-Felipe.Jensen@duagon.com>,
	Jose Javier Rodriguez Barbarin <dev-josejavier.rodriguez@duagon.com>
Subject: [PATCH 1/2] serial: 8250_men_mcb: Clean defines
Date: Wed, 10 Dec 2025 17:48:03 +0100
Message-ID: <20251210164804.94801-2-dev-Felipe.Jensen@duagon.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251210164804.94801-1-dev-Felipe.Jensen@duagon.com>
References: <20251210164804.94801-1-dev-Felipe.Jensen@duagon.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: MA2P292CA0028.ESPP292.PROD.OUTLOOK.COM (2603:10a6:250::15)
 To ZR0P278MB1218.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:80::5)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	ZR0P278MB1218:EE_|ZR0P278MB1556:EE_|DU2PEPF0001E9C2:EE_|ZR0P278MB1043:EE_|DB1PEPF000509E6:EE_|GVAP278MB0135:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a99781b-b387-47a2-0e34-08de380bf809
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?/olqwybJM7CbVPNTQARymfphxhYBdewKacnXkvGUkDpJotgk+EZsnA5aGTCE?=
 =?us-ascii?Q?7NZ/Ah7MLEQZQkyLn4aXHpfyl1l7eoFLVszavwJaQB/6aCz9OWI7mXtpPl+J?=
 =?us-ascii?Q?8hgjDgRZv5Cg3n2grrfRv8DZpBvSJVT3jrvz0OBXOGFzUhsRLfRuWbwKA0p1?=
 =?us-ascii?Q?eDeGMTq9R8oKuyMf7G6dmH4Bp4KeAwkkXnnr35ayDNsuFYi8VQI54GdFoZwb?=
 =?us-ascii?Q?bdNCXjkbor/QL7UYu/Kd91tiOejixUIVQhFEGFOLZE7UOo0w1SXFLF9TnKcW?=
 =?us-ascii?Q?qtkeHFYp40oPSLE3iVPPXiUm6Awyv7eCr2L6KAqKoBSuMZJ/N7tu2jwy3Ezx?=
 =?us-ascii?Q?BlgYVD+j/xGV5xUzo31ntoqL3E9cUGoQTMh7sbXrGk5J4IbRGyKtYMvbS5qM?=
 =?us-ascii?Q?By+kWYaOKfOyLE95ebbemTpNUwk6isIww6s3FCaGiNpTvvBYaeYaLKR+M6Rv?=
 =?us-ascii?Q?6/nLLi/LDXF9wymOH2GTJBcobu3fEYEkvHjQH8aRW1zoOcGo7KoWM+muzscd?=
 =?us-ascii?Q?tIVyhk5DP2J/FcoZumc1mVajZ3JZQ2r0veqy9pvRMg0D+8cajzO9hbVBqOT4?=
 =?us-ascii?Q?um9gvwp80fZ12wil9NB/IuCkXXkJoTgCKgH2OTm+hPK/+mpKSLjlR4A5byGg?=
 =?us-ascii?Q?eqaAyQYgoN+wDDNWOSALz7d5N6/41FIMdyGb+a3Db691A3VvZ2k+igMjoqnz?=
 =?us-ascii?Q?yEHFHZcSM++8cQU1OgqfCUwttneM9EmIP1zurcPe91g2PBd5MtxQhvH/0zJa?=
 =?us-ascii?Q?ZpG3l9UNerCYCMtoFGNhH95oSpt4neNqr2iT4sgLziDhZQSMmSBL/BlCgIYc?=
 =?us-ascii?Q?8x+ZnMPC3wxMVLHtMuH4RSds0Uyw74s8y66Emzxxz0/CKhY0XdZcNtPDjFZB?=
 =?us-ascii?Q?cBHaBW5XFQe6eooFeW56iO9tqLvkx7nRZL+MrU5166CDWBVgmWvQeRVe4cb9?=
 =?us-ascii?Q?Dz9olPxLfQV+H5yTejG3UFD7CR4u7fpl+E6zm4F08JPNQj9uw1NEEM3H828M?=
 =?us-ascii?Q?G65BNbphnLP+y9RokNYvENaKB0qf3vyfJ/6NM/pTm66MNe8EfIffhImp/33n?=
 =?us-ascii?Q?Zbj42moC8yhTMjLyRbZKoZv8HBMRkv7gYsLe2qLU8YKUjgaqPuJ9AGYNjMV5?=
 =?us-ascii?Q?c8qLToEXJft1lo/i26QpscIDa0U/zMtU3xp/XW86RdWa1etx5Wb5jW6h3rNI?=
 =?us-ascii?Q?WU2UbUg18dhWq3R6+rmdW5C8XqX2J3oOf5zLfLuDkoFH47+LM59ot5sPrcvi?=
 =?us-ascii?Q?e5/YxtDeTMTBFO7V020TXSJFm9XF7D8dnSvYMJMqdOx7IaNPssIT7pLNG8uo?=
 =?us-ascii?Q?a6ulpsMVksZK7OYKIK+SMDPaKs1YPAkGAygGipdeYhJem4s5YBrA2YP0dP70?=
 =?us-ascii?Q?25hF0dw7k3WYSueVVXufuQ8zSH/FxJPcOR6mWVEg6ty8r7aHJEhxvxuomHY8?=
 =?us-ascii?Q?Owt1069X5Gh2o7GbNAfEOzx4EfcxQbLxvV2s+g79nGF71WhLKNmhqwFJ6SSH?=
 =?us-ascii?Q?OEYEOCPfdJvejb5TdATOB8qQEgB5caE9zB8a?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZR0P278MB1218.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR0P278MB1556
X-CodeTwo-MessageID: 81af4796-8af9-45cf-bd38-bf006adc48bd.20251210164831@de1-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 1
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU2PEPF0001E9C2.eurprd03.prod.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs:
 df95e887-e74a-43da-a652-08de380bf25a
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|36860700013|376014|1800799024|14060799003|82310400026|35042699022;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?kz4ky4NHaiGedq1iS2gxd0q9vM2ZcgdAyz8oMGYY7ZRDI5HUrlXLuS2pvfgt?=
 =?us-ascii?Q?w7rfda3b3Fu79C6hchhpKybN63lpnJ40a7awAdWnEVyt38ZIL/XdPY89qeEa?=
 =?us-ascii?Q?KzLj5vcq9lPJCwGTleFIqleDUKGav0S9hzONMFj975q3UrD/BiO5EwbKSFe5?=
 =?us-ascii?Q?4588G1L2V2Ht0K9xOt3HT32c+Ym2DURGXgIXTlTjybbMTQZUarwh605hpXfQ?=
 =?us-ascii?Q?FRdwBS8fG6OtOdyt8syErwltkWMiCKXyA+nEUrrlRNa8Um+zRgqVsiU6eZB6?=
 =?us-ascii?Q?XKAbezEfHYyFlWvRjxsG9MdFi3Jl37vjC97BRF5dtjW00gSrbhC3VzAiK3sm?=
 =?us-ascii?Q?wsztVy1Bmw+lEpZcucc0xdygW/ynDgN6PfpTvRsr179HXzaPrDNxFTjm0HP2?=
 =?us-ascii?Q?uf6CpbROFMIizoCzKiUsSeOxYzi1EVfIC0ijI5bCZtzDsGgYxYsv9ZH35diA?=
 =?us-ascii?Q?RjEJ3vJUg/WHwCrNxVcHC6HDRSllNeupmB5E1f6OH55gCcDFoE5yMhGOeSoA?=
 =?us-ascii?Q?UYqSl52fJwJr2ut3KxqUlAkk8J372ANndWNK83fOJTtSqDej9KTXcvZSjdeb?=
 =?us-ascii?Q?3xuvrNFGJ3uL6xx3vyEKW1w+pIvzOB4+kGeZLflt3BPd2BYqhLmgi5Px7iwu?=
 =?us-ascii?Q?j4UUXZJ1rdoAMRF81CtQd9u+UH+sgDvoRcD1WbFpy37wCZDFM4cWQT8wgIor?=
 =?us-ascii?Q?UQeSSEMzGWBsr2u3aR0Kb18zEbZMEmVQxDfNWFcOsu6eqYL2Cp8QPyfQPmvN?=
 =?us-ascii?Q?qkNev95sfOxfSaiWYHcpS37/EPDkaXyx0hRrT5TWc0TJM2ZtDhtoMmzpNxSN?=
 =?us-ascii?Q?zU8hcaAFSayuSERPKGOUXcQsRCnFy+mMqi9cmD9w6nt+UCYm4V22O3MT1OTK?=
 =?us-ascii?Q?s3aIuJG/XUdpIlg7axyr9HkTOFfhh3haDWIrztYRIRrWYnYHIdxkZVkZzi2A?=
 =?us-ascii?Q?IBGDqNysPvYC7+wozshsFLoMuqnv58fOT1BClk8X/lB/a5cCDkNQ/kJWtAxs?=
 =?us-ascii?Q?+lTb+XBUG/2i4u/D4GH/zXjYbvS7OK3KfjCwis4lJeTpN1BguKyw8DAFEu1K?=
 =?us-ascii?Q?vL2NhNChFi8WKZwzVMX5lIfYgsPeF05bIHr3TRl5pHZuDbIp0xUlVWs8Q/uP?=
 =?us-ascii?Q?cNaamcHFujlnbplc+knnUQNCeKBc4cfeiFUnXWarKTfGaQJ+L5wbEQvMQLhJ?=
 =?us-ascii?Q?PeGLqlNzaTtr/k/P8CgGOCwsnwM8kbG308ZfO09UqwKWi8fVvUt/LvzgoBIj?=
 =?us-ascii?Q?464xqaYrbQPbzFfosolJH7CukReFFhfBLbBMIUyEmujosTecFikg9xomf+vg?=
 =?us-ascii?Q?nZB6x/GENjug8owxEFyvW+asp0rVYJ6IRmYJb9qjUCad8fCjCn8yC8NrmDHb?=
 =?us-ascii?Q?a6FTOwABk1u9KqLG3uCKjAhM5uEwVNUlYg9QXR10VEhH2ZSmsXX+h4+uIpZP?=
 =?us-ascii?Q?y9pNABXZrMZnwnpRxJCrCSNjqhzaQpos4EuQP4zKvZnLYCwmQ9R8ca9frUSd?=
 =?us-ascii?Q?6TGXrKcuUroP2auy5fD0J0jAW0IZlAfuUIh2Mt4K0pTTmzXGVPQJaanRP3AI?=
 =?us-ascii?Q?GhZAcoLAhE7OLVBubxo=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:20.79.220.33;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:de1-emailsignatures-cloud.codetwo.com;PTR:de1-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(14060799003)(82310400026)(35042699022);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR0P278MB1043
X-SEPP-CCCVersion: 2025-11-05T14:36:24+01:00 6c313bee
X-MS-Exchange-SkipListedInternetSender:
 ip=[40.93.85.30];domain=ZRZP278CU001.outbound.protection.outlook.com
X-MS-Exchange-ExternalOriginalInternetSender:
 ip=[40.93.85.30];domain=ZRZP278CU001.outbound.protection.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF000509E6.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	1eae977f-8261-40fe-9805-08de380bf41e
X-SM-ruleversion: 2.1.0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|35042699022|156008|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0sbelOcZSaH7+V7ihVkanu5vUJiOVJiPkfQfKFh7E0qv2GxiluWNfkrup8RH?=
 =?us-ascii?Q?1ST/A3EXT51v+JGiNgw0ALdv7XCSmWvSWkoi3C7+/+3/yV++6ORET9BiFG/e?=
 =?us-ascii?Q?Vjd9RqF/jqU/0EYxxQV23fn11h2v9R1T5dOiayZiYWnp0wny0Ez3ZWVVtumV?=
 =?us-ascii?Q?DHjDj+sDq7r4Wr3o3ZaDOwkUmMMlrabuvICUmJ6BNdLmHUIYlx+QG+h4wcDk?=
 =?us-ascii?Q?9IZ6KagO15mUlRlJepiF8wvmWdpIaN1HUT2KWDgPwDu2SWENftUjVN1LOkM0?=
 =?us-ascii?Q?eYApC7vJul/G+y19zX5Tz8vnfKejIpLRkRWPWu67vujjnMBmKM0RRxQamvXI?=
 =?us-ascii?Q?NeCiarpxJEi0w5gMw/ZRMYJeU6IhR6Y+ORpTvFqdYnsOcTElSouigdrxZwny?=
 =?us-ascii?Q?cBY4X4BGoLnlQbCDXr7TPgRwBZuRgFT4exvTSbX6UzhGatKR1mrDb+SLTy1H?=
 =?us-ascii?Q?mgrSWnCF8CPsi7c57dy4Mi5xjbnleR+6stMNOh81Dj38ffO06T7tpyVcjtjc?=
 =?us-ascii?Q?D30g4c91kCaXcsz2NboV3hU731R/pPn3MjD0RBLQVQQ2A4Q1CN2Yr6mbuM96?=
 =?us-ascii?Q?8sT30PIxkKFrH4q90HFGaRLRG861UHIBGBRB22dNKr0RkIG+28DdZX52oUi2?=
 =?us-ascii?Q?32Ku1xMocEF+kiBZvByzQCbqO5+DDxs1u6UpsTS6LMK29G3eWvMQ552tXvws?=
 =?us-ascii?Q?axILXCUPoG5datNZy5VkMhGHCNX05v94P5NxNiOHDXl6zDBtomUT95UlZ2Cq?=
 =?us-ascii?Q?lvr5RZgpXV6GKzphjNyCidPTmXKFHQAXtsHC320qX+nVyxoo6jEbWEEvfvk7?=
 =?us-ascii?Q?EkSEbHGLLUMK+Lnya8yXtIkmIpTS7h++9JvhDZ0XarzuRteJeOl3f7FDSnbj?=
 =?us-ascii?Q?S2fmr5iQf549RU4PoA1WHzvaTN/WHQkxlyl5v5oiaoQAcKDpaEKCxDNmSbMq?=
 =?us-ascii?Q?7z6IpYoU77K3gIGiHYqtJx+2OZ4v6dK0VvXjHByL1VKIMFhqg2vucuWHrURW?=
 =?us-ascii?Q?ZFDQHIhdL+9fMnX4G2dyG6LCRd+8BIUEJVs8eSdm0zOrL7mp5STwoVQj3HaU?=
 =?us-ascii?Q?ivvzW04igx6QCe9DYscCvXI1vhGVZkQJJCfo47SYf3dD64rjhcxts5aUQ2dz?=
 =?us-ascii?Q?qHfxgMwP+DS2?=
X-Forefront-Antispam-Report:
	CIP:162.55.72.219;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZRZP278CU001.outbound.protection.outlook.com;PTR:mail-switzerlandnorthazlp17011030.outbound.protection.outlook.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(35042699022)(156008)(82310400026)(36860700013);DIR:OUT;SFP:1102;
X-OriginatorOrg: duagon.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2025 16:48:38.9165
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a99781b-b387-47a2-0e34-08de380bf809
X-MS-Exchange-CrossTenant-Id: e5e7e96e-8a28-45d6-9093-a40dd5b51a57
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5e7e96e-8a28-45d6-9093-a40dd5b51a57;Ip=[162.55.72.219];Helo=[hz-deliver01.de.seppmail.cloud]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509E6.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVAP278MB0135

The Z125 define is not used anywhere, thus removed. Also used a
more specific name for the maximum number of ports per unit and
removed the duplicated define MAX_PORTS

Reviewed-by: Jose Javier Rodriguez Barbarin <dev-josejavier.rodriguez@duago=
n.com>
Signed-off-by: Filip Jensen <dev-Felipe.Jensen@duagon.com>
---
 drivers/tty/serial/8250/8250_men_mcb.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_men_mcb.c b/drivers/tty/serial/82=
50/8250_men_mcb.c
index a78ef35c8187..6ba7464bb2dd 100644
--- a/drivers/tty/serial/8250/8250_men_mcb.c
+++ b/drivers/tty/serial/8250/8250_men_mcb.c
@@ -28,8 +28,6 @@
 #define MEN_UART3_MASK	0x04
 #define MEN_UART4_MASK	0x08
=20
-#define MEN_Z125_UARTS_AVAILABLE	0x01
-
 #define MEN_Z025_MAX_UARTS		4
 #define MEN_UART_MEM_SIZE		0x10
 #define MEM_UART_REGISTER_SIZE		0x01
@@ -42,12 +40,10 @@
=20
 #define MEN_READ_REGISTER(addr)	readb(addr)
=20
-#define MAX_PORTS	4
-
 struct serial_8250_men_mcb_data {
 	int num_ports;
-	int line[MAX_PORTS];
-	unsigned int offset[MAX_PORTS];
+	int line[MEN_Z025_MAX_UARTS];
+	unsigned int offset[MEN_Z025_MAX_UARTS];
 };
=20
 /*
@@ -126,7 +122,7 @@ static int read_serial_data(struct mcb_device *mdev,
 	if (res < 0)
 		return res;
=20
-	for (i =3D 0; i < MAX_PORTS; i++) {
+	for (i =3D 0; i < MEN_Z025_MAX_UARTS; i++) {
 		mask =3D 0x1 << i;
 		switch (uarts_available & mask) {
 		case MEN_UART1_MASK:
@@ -150,7 +146,7 @@ static int read_serial_data(struct mcb_device *mdev,
 		}
 	}
=20
-	if (count <=3D 0 || count > MAX_PORTS) {
+	if (count <=3D 0 || count > MEN_Z025_MAX_UARTS) {
 		dev_err(&mdev->dev, "unexpected number of ports: %u\n",
 			count);
 		return -ENODEV;
--=20
2.34.1
