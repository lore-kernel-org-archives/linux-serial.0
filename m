Received: from ZRAP278CU002.outbound.protection.outlook.com (mail-switzerlandnorthazon11020089.outbound.protection.outlook.com [52.101.186.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9501E222566;
	Wed, 10 Dec 2025 16:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.186.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765385324; cv=fail; b=t45GXvjGKnQwsdjPyyP3zB2YYXBwUS5LU6oQdZGc9dvGHpN6Oc0+fFXdwemKUO1TOVrLcGpLYHH7N8Iu8DAk2soDVrSxJJKGqjDcS/yF1bUOt0kYAr0RyPOOxGR4DkFy42hhFrykU+386mf2f8cngbpcKYaZhOh1n67IqXKzK5k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765385324; c=relaxed/simple;
	bh=GmQONKMasGmHkpDG/XdzGcTjSNcNzODAtlbB6vCDrE8=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=aWpR2xUOSYBF+osQ7okG6z2j2XbToWeLQ/cT1KNrPCL0XMa0InJy9q66YINFYipA53riyf7nDX17j4znTy6MsapeBOsw5Qtt3jOrWY8eufxiO+wTydmrk8zjOxoWXKoqud//CB1wgE80PdmJcQDIyZoTTrARGR4EskmxQxPtsO8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=duagon.com; spf=pass smtp.mailfrom=duagon.com; dkim=pass (1024-bit key) header.d=duagon.com header.i=@duagon.com header.b=Gv/NrYm6; arc=fail smtp.client-ip=52.101.186.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=duagon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=duagon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=duagon.com header.i=@duagon.com header.b="Gv/NrYm6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gbh3e4pC4trMnqa7qD5sKSNxVH8X65is4dscBv7HgmgQ12kFZ2T2FhsiCjbU0lRdfgbIhBjDl9NYToedtiBlVm41skkQUX5RrsdmhbwEQyC0lq+NGSr8Xfl8apyRV7ofrVMWIUWJqqfaNume9bbfPWQjj7Ms3IUCGIz85IPaETmL9M2t9KB7eMT9m28cH6hGGAgSO6dS3LJAqIIJ++Jrz77xBfOhIt8pjRrMVT3wZziEhortdHCntiR5dq9DrqJj/ZNP6lpakBbyWRYOnVghgQ9UQBkZ6LqgnRp0XioL7OdAUTHyhQ+yY0uc0mFbRMrcmq/YnzR2e0D2fI3AtrAnSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RvzSAek+De6t3ToeaiqtiGYJx0f/b1u7jDLrCG8Vdl0=;
 b=qbSW75tLRK4y42UJl30COoND5duo7D8+RgfgU56h7SOCGmbWLdjnfEGhP2Lxrkag1PvcfHUagTKRUeWQGOH958m0REfiycK7iElDS6DbWWtKO+9CDIU+d6pNSN9PoLhNp/ANdA1On8YnwrtbmdncBljFKMdU1/0CX8oJ3PGvzLZRkYabRqAmDimG8HNI43qzJ8om18RI+acaTZGZDRT+mfcDA2CbLhLEeXMOLZ8HJ70YrdEszn1dTssVh0gxIGzeYLzRGOt2fbr01xPB6fj33n1ZeuXkJRlSLbeff0v+v9Jw8bI239uLqEaV2W6NNqOITkD02SG3ORm4fu70O0Bq6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 40.93.85.55) smtp.rcpttodomain=kernel.org smtp.mailfrom=duagon.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=duagon.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duagon.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RvzSAek+De6t3ToeaiqtiGYJx0f/b1u7jDLrCG8Vdl0=;
 b=Gv/NrYm6CVbX7H4eaWA2q03wGdBKDk73kYSXyoXl25lSUMISXpo6KOl5FRu6oP5JUYRWiTMrVZfvNodLTy0m1TpLdK3IzTQD7E1zHStFO+0vxjsJbKw+yOnu7JYyRNakGZodYLmZtHzi7BbeoVv+ezXvRHM0iU7Mu4jARn4AEN4=
Received: from DU2PR04CA0336.eurprd04.prod.outlook.com (2603:10a6:10:2b4::15)
 by ZR1P278MB0997.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:5a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Wed, 10 Dec
 2025 16:48:35 +0000
Received: from DB3PEPF0000885D.eurprd02.prod.outlook.com
 (2603:10a6:10:2b4:cafe::d4) by DU2PR04CA0336.outlook.office365.com
 (2603:10a6:10:2b4::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.6 via Frontend Transport; Wed,
 10 Dec 2025 16:48:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 40.93.85.55)
 smtp.mailfrom=duagon.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=duagon.com;
Received-SPF: Pass (protection.outlook.com: domain of duagon.com designates
 40.93.85.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=40.93.85.55; helo=ZR1P278CU001.outbound.protection.outlook.com;
 pr=C
Received: from hz-deliver02.de.seppmail.cloud (2a01:4f8:272:5fe6::218) by
 DB3PEPF0000885D.mail.protection.outlook.com (2603:10a6:18:3::608) with
 Microsoft SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Wed, 10 Dec 2025 16:48:35 +0000
Received: from hz-glue06.de.seppmail.cloud (unknown [10.11.0.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by hz-deliver02.de.seppmail.cloud (Postfix) with ESMTPS id 4dRM9Z4MvFz1144;
	Wed, 10 Dec 2025 17:48:34 +0100 (CET)
Received: from hz-glue06.de.seppmail.cloud (unknown [172.18.0.4])
	by hz-glue06.de.seppmail.cloud (Postfix) with SMTP id 4dRM9Z4B6Kz1yNP;
	Wed, 10 Dec 2025 17:48:34 +0100 (CET)
X-SEPP-Suspect: f64eff4aec394f08bbb1bd6f1f1288ca
Received: from hz-scan08.de.seppmail.cloud (unknown [10.11.0.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by hz-glue06.de.seppmail.cloud (Postfix) with ESMTPS id 4dRM9Z3nnYz1y33;
	Wed, 10 Dec 2025 17:48:34 +0100 (CET)
Received: from hz-scan08 (localhost [127.0.0.1])
	by hz-scan08.de.seppmail.cloud (Postfix) with SMTP id 4dRM9Z3FK6z2k9M;
	Wed, 10 Dec 2025 17:48:34 +0100 (CET)
Received: from hz-m365gate04.de.seppmail.cloud (unknown [10.11.0.37])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by hz-scan08.de.seppmail.cloud (Postfix) with ESMTPS;
	Wed, 10 Dec 2025 17:48:33 +0100 (CET)
Received: from ZR1P278CU001.outbound.protection.outlook.com (mail-switzerlandnorthazlp17012055.outbound.protection.outlook.com [40.93.85.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (not verified))
	by hz-m365gate04.de.seppmail.cloud (Postfix) with ESMTPS id 4dRM9X5fKWz1w9B;
	Wed, 10 Dec 2025 17:48:32 +0100 (CET)
Received: from AS9PR06CA0171.eurprd06.prod.outlook.com (2603:10a6:20b:45c::29)
 by GVAP278MB0762.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:55::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.15; Wed, 10 Dec
 2025 16:48:29 +0000
Received: from AM3PEPF00009BA2.eurprd04.prod.outlook.com
 (2603:10a6:20b:45c:cafe::83) by AS9PR06CA0171.outlook.office365.com
 (2603:10a6:20b:45c::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.8 via Frontend Transport; Wed,
 10 Dec 2025 16:48:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.79.220.33)
 smtp.mailfrom=duagon.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=duagon.com;
Received-SPF: Pass (protection.outlook.com: domain of duagon.com designates
 20.79.220.33 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.79.220.33; helo=de1-emailsignatures-cloud.codetwo.com; pr=C
Received: from de1-emailsignatures-cloud.codetwo.com (20.79.220.33) by
 AM3PEPF00009BA2.mail.protection.outlook.com (10.167.16.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Wed, 10 Dec 2025 16:48:29 +0000
Received: from ZR1P278CU001.outbound.protection.outlook.com (40.93.85.48) by de1-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Wed, 10 Dec 2025 16:48:28 +0000
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=duagon.com;
Received: from ZR0P278MB1218.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:80::5) by
 ZR0P278MB1556.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:a3::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.15; Wed, 10 Dec 2025 16:48:26 +0000
Received: from ZR0P278MB1218.CHEP278.PROD.OUTLOOK.COM
 ([fe80::a0e2:7867:dcd3:b9c3]) by ZR0P278MB1218.CHEP278.PROD.OUTLOOK.COM
 ([fe80::a0e2:7867:dcd3:b9c3%5]) with mapi id 15.20.9388.013; Wed, 10 Dec 2025
 16:48:26 +0000
From: Filip Jensen <dev-Felipe.Jensen@duagon.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org
CC: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Filip Jensen <dev-Felipe.Jensen@duagon.com>
Subject: [PATCH 0/2] serial: 8250_men_mcb: Parameter for base clock rate
Date: Wed, 10 Dec 2025 17:48:02 +0100
Message-ID: <20251210164804.94801-1-dev-Felipe.Jensen@duagon.com>
X-Mailer: git-send-email 2.34.1
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
	ZR0P278MB1218:EE_|ZR0P278MB1556:EE_|AM3PEPF00009BA2:EE_|GVAP278MB0762:EE_|DB3PEPF0000885D:EE_|ZR1P278MB0997:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f21f580-9d59-490e-9e57-08de380bf5c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?N3obajMUUtmMsXMgeYxPVrpxuSjKx0WzQRiCuzZndv79nU1treW3i3lqHwAo?=
 =?us-ascii?Q?i2xc6ZpPiZnAHQqWEwuBTuhDiIcADvvyoc5Smj2blmS9mBaXJLa38bX5JMF/?=
 =?us-ascii?Q?PGzZbcRJyUDZYfA3YwF7EssXMTMcI1Rb8mRN01EhGu2R+917RqQZAlMJH/IQ?=
 =?us-ascii?Q?N7nCTmGUWSVF6X5q1ibQlvrQ38cSZE8r7nMWmNTu5WfTiTXFvri4eboyYlpI?=
 =?us-ascii?Q?BuuIBglGbtyLetLeHyKCtasa4IXuLFEPyUX5uaxUhMfmttITrvKdWg05lrzJ?=
 =?us-ascii?Q?58ubCP2lfofUK3nNoXbg4GndPspqfcovJkhNIqDLvPV2/nfgUd4FhdD5/g0R?=
 =?us-ascii?Q?gXwZZbVp/oAGZAf1Ohg7gWGRLcx7x57nOXLg39cMA3lCdi4FU7OGUIT62Diq?=
 =?us-ascii?Q?rXKLfIiorKxfNcEfIEwtajhyjNP/yT+VbpIZ680WVtgTKkqZD2nD/72LV8ob?=
 =?us-ascii?Q?ExorAYTBkitjRm+46TiO8EKzTRBYuCtBPfijg5kXHEKGb+imhitK/PP86Anr?=
 =?us-ascii?Q?QQpS3Xb5gYZ/KPxAf7bJAMp0m5gcj3e/UsR81KYzbgyWGkFYtbzywGyuL3iA?=
 =?us-ascii?Q?Njl05XHqyPyRxb0XdQar7uITeOGE2g8PpZVzn70v2uzaJ/gRBkR56fGWdzmj?=
 =?us-ascii?Q?ChroKPI2Kg6ofEeHdTFQx3vxQaNt7Ty4ii6h1+NXRcprY+2AaKrecIJsB7Aw?=
 =?us-ascii?Q?3akTi99HpdPy1HiLDVafJFbm5x46tyXD+L3XsYRIcrgLPOO23wXvRxnd1EjC?=
 =?us-ascii?Q?SaywGUD4HjvrkoZJw1QzH8IAPAnPiRNK9fo2EmoYZi7mFRTKFbOg7taXyB2h?=
 =?us-ascii?Q?D3DkR9/hEDyOIHhHPakXlUvuOma7Mta/hlE6lsSd0dKvkzwvpB8yps2kz3P/?=
 =?us-ascii?Q?HZ7a2QgArDDgvVHqGwWZEoEOb/I/GwxP+UVp7K3JXBNo1goM52yvx03gvy/+?=
 =?us-ascii?Q?F1ELOxgnwihpwc82QT5lpIYrpm3MFenJ4epyfi1iHLq3xwjJXYnWB47ncLwF?=
 =?us-ascii?Q?C0m129ircSOo6aL56lh+Du7cjBgituVv9kCc9Ogb6I9CWJhtrCNJYeKIVRDA?=
 =?us-ascii?Q?x/1IJVQdTFhjQoArnD2VDGg4d1ppBiFVEqFi8Hj1PxgGE0/PsSy4i6PU2JO5?=
 =?us-ascii?Q?vq7xSf+ehD5qxVZ1xj3hTNHB4GgcpDvx+eS7avDKlHBD35ocwXw/WEmp2Ha0?=
 =?us-ascii?Q?rpgFmYsupD7Czz3H+wnwkX0UuP0eW3qdvGr3aPhIl6i/k8vVmGIoZVuobjfC?=
 =?us-ascii?Q?AAYmSQuHQzPCaKOGxPjOfIwdtgfXoYHDDZli0S1OjhKb0fAThztVW2k+ZYvs?=
 =?us-ascii?Q?e1tFqqjUhmApeNXr6kh+uSHhDn7ILEhYQzwCdE5cJ0+Y1xftxD6rVHJ++y/u?=
 =?us-ascii?Q?eHjyfbSj3kYajFL1hckGN0GkB0aGbCJIT6fJtMK4zQunJfMvx9bIVypvVyVU?=
 =?us-ascii?Q?Dr3ogkuZRNkmK/My7zCfaYhPCHcDq0VLBHdN55bebID1mk9ESvit2pmPGhAz?=
 =?us-ascii?Q?z2zkZAJcDZNoKTLtq8yW7qorD9VIiU93hfQ2?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZR0P278MB1218.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR0P278MB1556
X-CodeTwo-MessageID: 303a6b25-2075-47fa-b908-c1f4b8cbc6e1.20251210164828@de1-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 1
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM3PEPF00009BA2.eurprd04.prod.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs:
 e68108ed-a17b-481e-254b-08de380bf045
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|36860700013|14060799003|82310400026|35042699022|376014|1800799024;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?QNTLo0GUtoLTgZKtClog7RXmf0OS87at0xL9qNfH2p17XQNKDeK1asfFR5be?=
 =?us-ascii?Q?Xo/w0ST5+keUcSOTwqLa2nZPo/Qn1vm8OXQ1t65Ft2FpvPgGjOHEmhqnULgn?=
 =?us-ascii?Q?WmhO6kdliCdNO0eiu58PQmxUK6uvTxwa03EP0q3ifdkS56koJm6F9J3qWawi?=
 =?us-ascii?Q?ekDof9NIPkMTIG59Nf195ey2EY41u/wHvUGdtlhsREV0D2EtLNUsyT3ghVyw?=
 =?us-ascii?Q?hEXU6Tz6SeQgfEkVofIQPu99RSwJFkjLVL+eh6msclRJehE4oOBvr9tqhJy9?=
 =?us-ascii?Q?Yu/RGM8AK5Z6gkM2iOn27MlA9JxWqh00Iae0s+lO3ELaEGThZuq3nd/gPX6t?=
 =?us-ascii?Q?kNAxRCiJTTcsVr7fxQJLFRUHnkUtNSDepNkByAL2PMgtm+fECEHlM2Z4rpUe?=
 =?us-ascii?Q?N17c954bj+PZdnvDExao/NHCV6wARW+69dQHQv7k8eUVCpfUQt0Wjjr2itPQ?=
 =?us-ascii?Q?n8fGAYMP7fsssfyJ12auwM555KNJOcH+vAFknqj4r0qSFAamyq3vprh5TbhB?=
 =?us-ascii?Q?AR7cc97Bs2CuFZfaYOcoM9I97VFR303B6W3qvtr3rEnIq+MYWRPLhq311/1Z?=
 =?us-ascii?Q?x7zSAsjfZ3vHiblvfe+tM1BiKelwL/ySXMWENOxZKCK1oj1aTYcbf66f74yf?=
 =?us-ascii?Q?OS8qoJjGZ/BttIPNB4qp+HGxuK15ZwURQyZG9VL3xyp/QOQS9nelb6hARKIl?=
 =?us-ascii?Q?LgF5uiO/z6wHhe6FA6L71NLli97o+ou+Shj7ULuELZznh9C82VULzynDq7pC?=
 =?us-ascii?Q?1zJ6ZNwJC2F8b9bUlZDYXu/iqlf8pyABsvi+XQFBkAwq+k3x+FiMPYJZPMFV?=
 =?us-ascii?Q?+9MIwXr7uNP5mWq71prMILo0dj+HVFIlBLR/MIdrdzAN7ICHSwLi6Tj+gQPP?=
 =?us-ascii?Q?yVrwDuEqM5ba4ZWZwvWUI3UvtRI6ZfpuBG0vDX6kgKyWXnGHLB9TrJYOcGPt?=
 =?us-ascii?Q?v8c+w7LkFE8rkJc+QP4KmLlbhgENC/ySWA/IlGoQ5yj3CMaT86Nxaq4WROql?=
 =?us-ascii?Q?K0TmQpwRXdh5/hiZulgaMz0DCTPvsercZw58m/OIQDPq0PzIKxOMzu5KlNIm?=
 =?us-ascii?Q?XMyhCtdtyrzycS7nWGgU2pxsI/hM1SVscm6aI3fB4j7ms+90TpE8hFWP4Yq0?=
 =?us-ascii?Q?uxMPHV421A+nHFeRTNwHbnWJM8JiohibbXymPk0ZbHKlvKoukqTkkQ3kzuFB?=
 =?us-ascii?Q?m3rQoebjq6Lg5SzuEf7dxJJxtLhryBishyQ7/5gRtOq2aoLOP89lSgmdPTQl?=
 =?us-ascii?Q?KrdYnsvqKlP0j8uQsPimA5KZmgZx504OkshoWALtgHMbbMI5Sfkk0mBh66Aw?=
 =?us-ascii?Q?c+X6iOY6KAlj8nQZ3muS0nORltVSTN/g0EkyfvELikPHi1PFYzUvsdFoekKF?=
 =?us-ascii?Q?kooVl2whpg6gKA1UzqqQEJ8G0ja3HN1o6mNyMagPW9aIwsFoEpwZcuSuf9Ds?=
 =?us-ascii?Q?4nU5OrH0GUgWx1O8v4a4w8gf+hP+n/RP3ZwM67/kdnz+SBRfebBLWwpzQclk?=
 =?us-ascii?Q?9Vf0JOHRiy1Wl35WC2CWjG28cpsTdsNaljxKrnG89+Yz/7KHjFV7x08HhtQD?=
 =?us-ascii?Q?/Wl2PtnfAUx1VUr3ctc=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:20.79.220.33;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:de1-emailsignatures-cloud.codetwo.com;PTR:de1-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230040)(36860700013)(14060799003)(82310400026)(35042699022)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVAP278MB0762
X-SEPP-CCCVersion: 2025-11-05T14:36:24+01:00 6c313bee
X-MS-Exchange-SkipListedInternetSender:
 ip=[40.93.85.55];domain=ZR1P278CU001.outbound.protection.outlook.com
X-MS-Exchange-ExternalOriginalInternetSender:
 ip=[40.93.85.55];domain=ZR1P278CU001.outbound.protection.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB3PEPF0000885D.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	6dcbe861-34d9-4659-c4cb-08de380bf226
X-SM-ruleversion: 2.1.0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35042699022|36860700013|82310400026|10070799003|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dwQDLh+p7S9YtImr+OvS7fqykn8dZaGhPC++kJ3SGvQR3U5fzHeZt7f4KOyW?=
 =?us-ascii?Q?5yPXNfuUEjMzYeT4aTrKLp3n2k/GV50kQdGvE+blxtLQU0d9DEWJSj/E+5fA?=
 =?us-ascii?Q?G//XnyC3gWs+3SxcVP8hE+5nukDUWEVy8hcAEewqQwIdTK4lNip3DLRu1BXi?=
 =?us-ascii?Q?wc/Bcv6cAPfxk+/lC39nx1Us7O4mpgVnjpACATikULeRJZqB0a3c4Ba3cxP+?=
 =?us-ascii?Q?WvxookLuOejfCE5zHcbi3Bh0Qz5RvpCl8dX7h3gxp0yzoRbZd0ALWDTKIFKB?=
 =?us-ascii?Q?HgKyfVoCFg76Dn3QsyjwwfkEyWGHyAQznhy6O7CEAMhOmWU1Ua0Q4cvEBKKH?=
 =?us-ascii?Q?Hl77aRJEfIwIr/+aFbrclDV4PvGvsGJ29s85yxgZwK2LcClGwL1qIe1nR+GO?=
 =?us-ascii?Q?11UUcz2xipaTxQpAWF+L+SX2Qinr/nDWA83+lxkRFawrXX4A2BDTLschBK8s?=
 =?us-ascii?Q?Cj2suVATVX5LefiimHSR8uwgd0LraQCC4QOaifIKp5jqmWJ9t6z4BLHwPssL?=
 =?us-ascii?Q?X60E3YRMNd50G737QU1kCSdbX6VNFEkm4PgOwjqqafGQO5z3ptR4Y/mVhXp3?=
 =?us-ascii?Q?jeQr411tKHWXvVNqRoS6jFonQ3uvAyH31Sj+pLzmxwY4Q/5jhjgva+G/+K1n?=
 =?us-ascii?Q?DK3nA6j/Qu1bQKTZk0p0J2QuAlX+jWe6NDW916Yj0yfb2LaWVZpFIlTSf85C?=
 =?us-ascii?Q?9qvQ1KGeWppxY9aDebYej6aAW53hMkmKKdlXDL/mZqMXATUkmkE5Zo0Z1+4A?=
 =?us-ascii?Q?+K5YO/wym9mjipcCF4/ZS7R72l2gTpUDXYFmzcX1P6MpM2KaYO25B+Wh+33G?=
 =?us-ascii?Q?aEhgA84G84RT7CBsmQ9TMem21lI6018Hi20GS5ffxEpdvPYNHT2I0yKkmrKO?=
 =?us-ascii?Q?4Ij3F/dTaCZZahy3ORD1IWLx3elpmDfTDKPAf7WlxFA4yXjrw5HK0HLUKOmP?=
 =?us-ascii?Q?LtC+IDtcCz68XqqldXifUiGsHpa75IAH6tynUZQTHOKZ19qh9rRY4h2Qh6Yr?=
 =?us-ascii?Q?a8ex64MlbYoIVYZgbacVE6r4fbXLmk61d+IpymGFz8g0dOHORCqm3M0Z3WKT?=
 =?us-ascii?Q?FkB2hKjIqx/m0Jn0e+AYFdfcxzjracwer+yfTrdkVwZhHaKx8jY5I6+KpGuN?=
 =?us-ascii?Q?R+BxxDHRcJq/?=
X-Forefront-Antispam-Report:
	CIP:2a01:4f8:272:5fe6::218;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZR1P278CU001.outbound.protection.outlook.com;PTR:mail-switzerlandnorthazlp17012055.outbound.protection.outlook.com;CAT:NONE;SFS:(13230040)(35042699022)(36860700013)(82310400026)(10070799003)(376014)(1800799024);DIR:OUT;SFP:1102;
X-OriginatorOrg: duagon.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2025 16:48:35.1012
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f21f580-9d59-490e-9e57-08de380bf5c5
X-MS-Exchange-CrossTenant-Id: e5e7e96e-8a28-45d6-9093-a40dd5b51a57
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5e7e96e-8a28-45d6-9093-a40dd5b51a57;Ip=[2a01:4f8:272:5fe6::218];Helo=[hz-deliver02.de.seppmail.cloud]
X-MS-Exchange-CrossTenant-AuthSource:
	DB3PEPF0000885D.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR1P278MB0997

Until now, the base clock rate was fixed for all the UARTS depending on the
card they were attached to. However this base clock rate of men devices is
variable and can be set by user. For this end, a parameter is here added to
allow changing this rate for up to 64 UARTs. Also cleaning unused defines i=
n
another commit.

Filip Jensen (2):
  serial: 8250_men_mcb: Clean defines
  serial: 8250_men_mcb: Parameter for base clockrate

 drivers/tty/serial/8250/8250_men_mcb.c | 28 ++++++++++++++++----------
 1 file changed, 17 insertions(+), 11 deletions(-)

--=20
2.34.1
