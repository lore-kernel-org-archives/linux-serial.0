Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2116.outbound.protection.outlook.com [40.107.215.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ABFB18FDD9;
	Fri,  7 Jun 2024 11:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717760638; cv=fail; b=dq6GATE+Iup8xiFwTmtTZHXhjxC69eYprc0saYyA8Ixx3GX7Y0B341f1ey9WxWFMo0LW4Izguz+mJ85GDpk72EX45K/51LB4qvkiBUsBSyxxOeiG7HdngK35ZnbrPDQab64qBq0Iz6fU5+tz82x5gsenGc8m+0mPIZ6NXhX3Vrw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717760638; c=relaxed/simple;
	bh=n9UWOos5KpeToKB6HEjEiIT/TAL3eM9lq6+qHv/Zrvs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QBMyKGB5R8tJ8Y5tjlTmcYpwHExyzKXDPjnmjLFDvLGmGPJolZPlaEtDfBuLTK0h/L3A4keAx7U7bEGmyf7OL0fa1AvqL28AykZ6Z/ix3fTNrNGkMpbgZjfKG9tCEVWrdi2GAiHF+z4aExq4oZk92i96yX2WTHMhGz/vQjlAK4w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com; spf=pass smtp.mailfrom=moxa.com; dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b=Skni0FXl; arc=fail smtp.client-ip=40.107.215.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moxa.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b="Skni0FXl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eXv3CtGak2j7YP21DXG3j1vC/t0CVp5HCaIHIgKUnavg4jRVnXTBu5cbmlpa4C5s7NoNGG/vsqVK7+6Yb5Wp1f6doycaAadqG2hKZyBe8Pfc8Xv7zQs+RhELqhIbHLY2KER7XOT01w2g1YyZ0ndUXFw15BI09eY3OPwq8ky5fSnpkl3LNwiE74dE3ck/hAzPPmfusJYnOiXW7t/TsuhHAIefq6lgYNppuI8aoKwmc3YaQ7jmkqD5JWd7Jqb5YDgbgO6o+IAksh39E9ofHsGbM4joB8nHds2KjbEj1wioh1tljpQUlSW/VluabKGDVyIiQKXJk5pkclG81Zff17SrFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0yMinIKP3YALVZ5qXKO/GvnKk3wxs0RGpuwCoi0Y2pU=;
 b=X/oDXZa0iaqWZRWeNH+o3kk+4Rh9wGrIm704n7Q9M73LZVwH/J/ChgiFEd+ZnGKSm4k7PqCy8cVIQOwEu3kIQAxAup7E+aNafkzZdHQjcSYBraevQkBn6K/GB8zjpqtF6snlpFon+P6Xh3Fh71qau8H4ztZwm01xYaucMoZGcBV4Eyc7x6NeWfPCiSolFPawXfph2VO35BtCf8q28ERXswaBGsaQ2DGmrM6/vKIusTBYYqXgDCm5C3JblpEvN+RkmlcGt/9pdSN8e8iSTQBBg744Ret47yU9pstBY90/WFCmYYnCl+4oR6A41pzx9jwRunTVzBiPIx4K5YKThCchuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0yMinIKP3YALVZ5qXKO/GvnKk3wxs0RGpuwCoi0Y2pU=;
 b=Skni0FXlGQiKeQo1edVhGayCHv0UUF8jrh71bnlsUIFmEQX5PQmOO2E0mhI9guFHFnkDPawkaMqY5tO9BYowVm3gTxYxmfidAC+C2htAF/MaA7T2X/EQ8QL7X2x2wBpSCxvQDjgnVoDEk4aDetP2/w1In1RrUBAL0Ffv6Z+FGoY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14) by SEZPR01MB5588.apcprd01.prod.exchangelabs.com
 (2603:1096:101:12f::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.34; Fri, 7 Jun
 2024 11:43:48 +0000
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::60ab:8615:ab67:8817]) by PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::60ab:8615:ab67:8817%5]) with mapi id 15.20.7633.033; Fri, 7 Jun 2024
 11:43:48 +0000
From: Crescent Hsieh <crescentcy.hsieh@moxa.com>
To: Jiri Slaby <jirislaby@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Crescent Hsieh <crescentcy.hsieh@moxa.com>
Subject: [PATCH 3/6] tty: mxser: serial: 8250: Relocate device IDs from mxser to 8250_pci
Date: Fri,  7 Jun 2024 19:43:33 +0800
Message-Id: <20240607114336.4496-4-crescentcy.hsieh@moxa.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240607114336.4496-1-crescentcy.hsieh@moxa.com>
References: <20240607114336.4496-1-crescentcy.hsieh@moxa.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0020.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:263::12) To PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR01MB5405:EE_|SEZPR01MB5588:EE_
X-MS-Office365-Filtering-Correlation-Id: 65a7513c-e64c-4b17-199b-08dc86e71844
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|52116005|1800799015|376005|366007|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Y76EGalNJurXQ4CUTW7+Ti+GmUAPY/GTk2vmIpe44m6MKkYOa8PEHbyaxJEs?=
 =?us-ascii?Q?fGNwn01BK4e0H5qsrgBeyvU0auzeT38ca0cLtiaEFT5mL+qCob3muviLIWQ7?=
 =?us-ascii?Q?oxSQy+u8EssRGLJxhGUbQymL9Bi+VYRvwN0ls+i502n4gL9cbV/z9bz82Sya?=
 =?us-ascii?Q?oITZZX28AeKua/cERDyFBl9KSNHJADFdFJOhTbEvclUObuizekQlWJkByDF8?=
 =?us-ascii?Q?TMUpFMABNNvyIitF/x0ohf7PnQ3rM76NEPJGmVXBAEchmj7WV5UTthmNICJE?=
 =?us-ascii?Q?SrMyI3a8yppLnmRz/LUFtPuZbZW62b9H4Hainb8YYtNE5vW6jm2kOCu+x00d?=
 =?us-ascii?Q?y3qJ8J2l3nLC6rOwpJNAuLjlbwkzbke4sUzLlC3UWLPKwaoKPcq9x5DAJ970?=
 =?us-ascii?Q?11d2J1MV7DrAvdzvdzphaNFcKBChKjlitXtg0kbAu5bpHkIp1J5SJb5xozX+?=
 =?us-ascii?Q?FRTZv16oEBk5UOePXZhDWNkh5cHV/aYHCV/PE1QkTJrKaGaomCaVXQ+2DPcl?=
 =?us-ascii?Q?71bi+dn06KZ1VsKMPNGlIb7KfxuGltdoNsYKx+oBj6prGtpEJqAkI7U3jmkC?=
 =?us-ascii?Q?I40IAGRnqtUTTqM8oylPcE+jm1G9aHqSWapcZzBnubrtQZaMZZTqQl3O+tbX?=
 =?us-ascii?Q?aNkwehrV1rSdMorCbJCdTpK01RoADxPgTDL8CyJyQDxzUbexWivPYCmyC8eh?=
 =?us-ascii?Q?IXIymKISj9bRYELH1fUEJCP8pFptGYl8QCrDEEZjRjUnhbch3u4DWVqHe/4d?=
 =?us-ascii?Q?rNxBSjYVU8CdpahyjNvbsLYthjYcTXkDCWBJ0GjRxhuCtp6pzEhYTDbLgiSx?=
 =?us-ascii?Q?MG+NxecOrvERXsH5d86Ko42gVF9hXAF/rHRzNq16DPpfO4U1jYIKzmAUxpv/?=
 =?us-ascii?Q?bEdoIaNKk94VEQOTiyCVql5JqGjY/6QaIcFEipsnkcSKIj3XiLt2B00EuXqQ?=
 =?us-ascii?Q?+YoZI8gw8XbEYFIOxB6OFyAN5lHSDF0kas+P+zYf0RMLqH+A3O9Anz77/gdA?=
 =?us-ascii?Q?PQf8q9p73mhUSVILvXyUo5W4E40rSTAlHJInn3pn/3nALs8CcLoNGucuMX2V?=
 =?us-ascii?Q?3AyfQP9wci01dle4cCLXIfebXBYj3VaygfhPbcumH9GJgrQsKEgdfDQYHwDq?=
 =?us-ascii?Q?s1/ArHeHqd+ZoXRt2aFDXtnddmpTBg10+ZfVB2J36UN/Bk0IIaUYmW3uoBIc?=
 =?us-ascii?Q?tDzTxuXvSRKXEtRbnJxJRNVubtA1iPiGDw7KAYMOnShmqQqsZ1TMSvQljhgF?=
 =?us-ascii?Q?p9FUH68XC4rwQAc6hMTiUvSkVbWD7vbo3FkNxwMVOHKqAhAiWvgUIWDNkcie?=
 =?us-ascii?Q?wXXzrpr4+AqwYjZFHcfcechUJlJDLAH8zgy5qWBHUQNht6ABG4dvzU++ErbY?=
 =?us-ascii?Q?DF5KmXM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR01MB5405.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(1800799015)(376005)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WVZjM9lIZUqqDGQJF5v8In0pRLOF3vBP57I/NgE5jKALs44d9h5arrHh+J36?=
 =?us-ascii?Q?poQKIJkwK+nBHLzNMZyho7MGXhC7GRaXlyanso13MFdVGCZus/wJfhzb4Jta?=
 =?us-ascii?Q?e2RBQ+e8LCJEBAw+1RpWewOVoYzWAXV02vwNBDrUZfwralIBnrkbxQgMtzGs?=
 =?us-ascii?Q?70iudD2YhSF889QlR9ajp1EAAd50wu+fVAnioTVgaq8MgJnKWknosyEei8cB?=
 =?us-ascii?Q?8H0g7CDkeSOoJ4guSsUG0nbO/gEB9XLubp1Jl2TsfTYlArWxTop25prcZkj3?=
 =?us-ascii?Q?R0Fq+9u0LVcA2L4heCzEyxQR1Y2MQ2CBRqItkX8lZlUYDlZ6TGQOexsEB5KN?=
 =?us-ascii?Q?gXb1RDh5CNlH0atBXxtmE90RHmagWoqbKCKJd0bdIvC3epE2X38dwWhdwiwz?=
 =?us-ascii?Q?mVTRiwojzXtmcFyiu9xy5/+pIJy5W1KcCCUsF/oufYBhhiTDOEWWECJUKucR?=
 =?us-ascii?Q?41pUDN2xnhepT/foc3uALluS+Kwn34Lt5zNajCU7vC0ZvxG5V2mw4x8uoR7n?=
 =?us-ascii?Q?cRzXWWvQb67LARmbJIrGdG6pqXch6381ReevTN0BCWjCIs5jHf/EOdzmLVur?=
 =?us-ascii?Q?XsibVV3eaDwWXSvNOhPvWjO/GsZJa11BJz30IanrnReU/Wr/jVsDPXZ82j5G?=
 =?us-ascii?Q?xw7lerJoAu/00e25Q/sxCucyUu1af65/HSGFh4Li82fFn47fis5eBbGojSes?=
 =?us-ascii?Q?VQxzJPEovmvQ2nB175xzebkeIS66zPKevNtfnSKwOfb7qp1WLw4T0IxKywR+?=
 =?us-ascii?Q?GQaz6jpwAuW3KbX1eaEgAEXiKJGfbfIvsNu5HOwEgqyW5Ad6kqL+zwts8Ro0?=
 =?us-ascii?Q?NRfwSvqQ4JTNM3n47MNvf0FESBnk+cOTrojrsAGjT5lGLcwdVU6jZGUOPEEj?=
 =?us-ascii?Q?j+w9jQUrjTSHHh0J4gFEcwnBrJW1XloiC3t3Hf5egsYx9NsyceZPpCSK4WuR?=
 =?us-ascii?Q?hbaQeP2dvTRFyIpDGAHqyZ/6foOGHzRqZuYPa6OUT0q7CsKeHqEFiMRvJpcH?=
 =?us-ascii?Q?JiwOLUwygKUiGEIpCT9zACl54aPcB8C3Pt9+HNK4d9v76+SSx6yFd8zilpp7?=
 =?us-ascii?Q?ErDFtfxPLKLvz0NTiAax3JlhG3tfcAap58/ysCQMPrr8qAUZQELutbrPxvFU?=
 =?us-ascii?Q?RH/df/av/Z/jMd1KRMsx/vPm7a6iwCxnSRXyk22IJ07kAK9DbBwlZgi2cDuu?=
 =?us-ascii?Q?CgFMuXRtwkmIf2JlyNAiGQN0m1hAgd3LsK9eLi9WxIWwQtyED+XR+KM+kLWE?=
 =?us-ascii?Q?OhOw30AheCfqJp/zQWt4dUGk8O45kZOs8Oi/f1Qfcrdp+asGf8iDCVIMPiIh?=
 =?us-ascii?Q?LEyx4f1Ch4dN5y9mxok2xooOJsiAF07+ZsChofHOlQrBxbQXTOUHxJAlHhG7?=
 =?us-ascii?Q?+hv7L4CaaaV8fd0Civg7PnATudGfQFQTwBnZ+TttEyLkVkR5V6KHQiFyp1lC?=
 =?us-ascii?Q?Tz7XYkb79YaX8DFQizf1MyCEoYgH+EiYNEGmmVjOt6tsiY6v/yumuc2tdrUG?=
 =?us-ascii?Q?lDHJXnQW9VX4N29DAZEQm6QCSkNuLQHNfFuo3adL7Bn0ax8uWtxyyUDR8Cfz?=
 =?us-ascii?Q?+GefQ56OvBSgs7dgCe3/VzkajdH47tFwfgK3Ud6zAaqOOKiWb67QOuWG1fpI?=
 =?us-ascii?Q?Ww=3D=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65a7513c-e64c-4b17-199b-08dc86e71844
X-MS-Exchange-CrossTenant-AuthSource: PUZPR01MB5405.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 11:43:48.3987
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eHagN9uf/2GySRSE/DYInrLkI4LRwKN74TyKN80QRSP9PrYFQsIhR4ty3wXG9th48QFEodswmo3ZNb0rlfQ++hvPevDpbJCwZnThyS6P+Aw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR01MB5588

The devices in mxser could be supported by 8250_pci, so this patch
relocates these device IDs from mxser into 8250_pci.

Signed-off-by: Crescent Hsieh <crescentcy.hsieh@moxa.com>
---
 drivers/tty/mxser.c                | 50 ------------------------------
 drivers/tty/serial/8250/8250_pci.c | 50 ++++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+), 50 deletions(-)

diff --git a/drivers/tty/mxser.c b/drivers/tty/mxser.c
index 458bb1280ebf..b0e7ea6611bf 100644
--- a/drivers/tty/mxser.c
+++ b/drivers/tty/mxser.c
@@ -160,31 +160,6 @@
 #define MXSER_CUSTOM_DIVISOR	(MXSER_BAUD_BASE * 16)
 
 #define PCI_DEVICE_ID_MOXA_RC7000	0x0001
-#define PCI_DEVICE_ID_MOXA_CP102	0x1020
-#define PCI_DEVICE_ID_MOXA_CP102UL	0x1021
-#define PCI_DEVICE_ID_MOXA_CP102U	0x1022
-#define PCI_DEVICE_ID_MOXA_CP102UF	0x1023
-#define PCI_DEVICE_ID_MOXA_C104		0x1040
-#define PCI_DEVICE_ID_MOXA_CP104U	0x1041
-#define PCI_DEVICE_ID_MOXA_CP104JU	0x1042
-#define PCI_DEVICE_ID_MOXA_CP104EL	0x1043
-#define PCI_DEVICE_ID_MOXA_POS104UL	0x1044
-#define PCI_DEVICE_ID_MOXA_CB108	0x1080
-#define PCI_DEVICE_ID_MOXA_CP112UL	0x1120
-#define PCI_DEVICE_ID_MOXA_CT114	0x1140
-#define PCI_DEVICE_ID_MOXA_CP114	0x1141
-#define PCI_DEVICE_ID_MOXA_CB114	0x1142
-#define PCI_DEVICE_ID_MOXA_CP114UL	0x1143
-#define PCI_DEVICE_ID_MOXA_CP118U	0x1180
-#define PCI_DEVICE_ID_MOXA_CP118EL	0x1181
-#define PCI_DEVICE_ID_MOXA_CP132	0x1320
-#define PCI_DEVICE_ID_MOXA_CP132U	0x1321
-#define PCI_DEVICE_ID_MOXA_CP134U	0x1340
-#define PCI_DEVICE_ID_MOXA_CB134I	0x1341
-#define PCI_DEVICE_ID_MOXA_CP138U	0x1380
-#define PCI_DEVICE_ID_MOXA_C168		0x1680
-#define PCI_DEVICE_ID_MOXA_CP168U	0x1681
-#define PCI_DEVICE_ID_MOXA_CP168EL	0x1682
 
 #define MXSER_NPORTS(ddata)		((ddata) & 0xffU)
 #define MXSER_HIGHBAUD			0x0100
@@ -212,32 +187,7 @@ static const struct {
 /* driver_data correspond to the lines in the structure above
    see also ISA probe function before you change something */
 static const struct pci_device_id mxser_pcibrds[] = {
-	{ PCI_DEVICE_DATA(MOXA, C168,		8) },
-	{ PCI_DEVICE_DATA(MOXA, C104,		4) },
-	{ PCI_DEVICE_DATA(MOXA, CP132,		2) },
-	{ PCI_DEVICE_DATA(MOXA, CP114,		4) },
-	{ PCI_DEVICE_DATA(MOXA, CT114,		4) },
-	{ PCI_DEVICE_DATA(MOXA, CP102,		2 | MXSER_HIGHBAUD) },
-	{ PCI_DEVICE_DATA(MOXA, CP104U,		4) },
-	{ PCI_DEVICE_DATA(MOXA, CP168U,		8) },
-	{ PCI_DEVICE_DATA(MOXA, CP132U,		2) },
-	{ PCI_DEVICE_DATA(MOXA, CP134U,		4) },
-	{ PCI_DEVICE_DATA(MOXA, CP104JU,	4) },
 	{ PCI_DEVICE_DATA(MOXA, RC7000,		8) }, /* RC7000 */
-	{ PCI_DEVICE_DATA(MOXA, CP118U,		8) },
-	{ PCI_DEVICE_DATA(MOXA, CP102UL,	2) },
-	{ PCI_DEVICE_DATA(MOXA, CP102U,		2) },
-	{ PCI_DEVICE_DATA(MOXA, CP118EL,	8) },
-	{ PCI_DEVICE_DATA(MOXA, CP168EL,	8) },
-	{ PCI_DEVICE_DATA(MOXA, CP104EL,	4) },
-	{ PCI_DEVICE_DATA(MOXA, CB108,		8) },
-	{ PCI_DEVICE_DATA(MOXA, CB114,		4) },
-	{ PCI_DEVICE_DATA(MOXA, CB134I,		4) },
-	{ PCI_DEVICE_DATA(MOXA, CP138U,		8) },
-	{ PCI_DEVICE_DATA(MOXA, POS104UL,	4) },
-	{ PCI_DEVICE_DATA(MOXA, CP114UL,	4) },
-	{ PCI_DEVICE_DATA(MOXA, CP102UF,	2) },
-	{ PCI_DEVICE_DATA(MOXA, CP112UL,	2) },
 	{ }
 };
 MODULE_DEVICE_TABLE(pci, mxser_pcibrds);
diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index 4964cb9ccaa0..e5bdabcce720 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -82,23 +82,48 @@
 #define PCIE_DEVICE_ID_WCH_CH384_8S	0x3853
 #define PCIE_DEVICE_ID_WCH_CH382_2S	0x3253
 
+#define PCI_DEVICE_ID_MOXA_CP102	0x1020
+#define PCI_DEVICE_ID_MOXA_CP102UL	0x1021
+#define PCI_DEVICE_ID_MOXA_CP102U	0x1022
+#define PCI_DEVICE_ID_MOXA_CP102UF	0x1023
 #define PCI_DEVICE_ID_MOXA_CP102E	0x1024
 #define PCI_DEVICE_ID_MOXA_CP102EL	0x1025
 #define PCI_DEVICE_ID_MOXA_CP102N	0x1027
+#define PCI_DEVICE_ID_MOXA_C104		0x1040
+#define PCI_DEVICE_ID_MOXA_CP104U	0x1041
+#define PCI_DEVICE_ID_MOXA_CP104JU	0x1042
+#define PCI_DEVICE_ID_MOXA_CP104EL	0x1043
+#define PCI_DEVICE_ID_MOXA_POS104UL	0x1044
 #define PCI_DEVICE_ID_MOXA_CP104EL_A	0x1045
 #define PCI_DEVICE_ID_MOXA_CP104N	0x1046
+#define PCI_DEVICE_ID_MOXA_CB108	0x1080
+#define PCI_DEVICE_ID_MOXA_CP112UL	0x1120
 #define PCI_DEVICE_ID_MOXA_CP112N	0x1121
+#define PCI_DEVICE_ID_MOXA_CT114	0x1140
+#define PCI_DEVICE_ID_MOXA_CP114	0x1141
+#define PCI_DEVICE_ID_MOXA_CB114	0x1142
+#define PCI_DEVICE_ID_MOXA_CP114UL	0x1143
 #define PCI_DEVICE_ID_MOXA_CP114EL	0x1144
 #define PCI_DEVICE_ID_MOXA_CP114N	0x1145
 #define PCI_DEVICE_ID_MOXA_CP116E_A_A	0x1160
 #define PCI_DEVICE_ID_MOXA_CP116E_A_B	0x1161
+#define PCI_DEVICE_ID_MOXA_CP118U	0x1180
+#define PCI_DEVICE_ID_MOXA_CP118EL	0x1181
 #define PCI_DEVICE_ID_MOXA_CP118EL_A	0x1182
 #define PCI_DEVICE_ID_MOXA_CP118E_A_I	0x1183
+#define PCI_DEVICE_ID_MOXA_CP132	0x1320
+#define PCI_DEVICE_ID_MOXA_CP132U	0x1321
 #define PCI_DEVICE_ID_MOXA_CP132EL	0x1322
 #define PCI_DEVICE_ID_MOXA_CP132N	0x1323
+#define PCI_DEVICE_ID_MOXA_CP134U	0x1340
+#define PCI_DEVICE_ID_MOXA_CB134I	0x1341
 #define PCI_DEVICE_ID_MOXA_CP134EL_A	0x1342
 #define PCI_DEVICE_ID_MOXA_CP134N	0x1343
+#define PCI_DEVICE_ID_MOXA_CP138U	0x1380
 #define PCI_DEVICE_ID_MOXA_CP138E_A	0x1381
+#define PCI_DEVICE_ID_MOXA_C168		0x1680
+#define PCI_DEVICE_ID_MOXA_CP168U	0x1681
+#define PCI_DEVICE_ID_MOXA_CP168EL	0x1682
 #define PCI_DEVICE_ID_MOXA_CP168EL_A	0x1683
 
 /* Unknown vendors/cards - this should not be in linux/pci_ids.h */
@@ -5774,23 +5799,48 @@ static const struct pci_device_id serial_pci_tbl[] = {
 	/*
 	 * MOXA
 	 */
+	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP102),	    pbn_b2_2_921600 },
+	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP102UL),    pbn_b2_2_921600 },
+	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP102U),	    pbn_b2_2_921600 },
+	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP102UF),    pbn_b2_2_921600 },
 	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP102E),	    pbn_moxa_2 },
 	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP102EL),    pbn_moxa_2 },
 	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP102N),	    pbn_moxa_2 },
+	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_C104),	    pbn_b2_4_921600 },
+	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP104U),	    pbn_b2_4_921600 },
+	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP104JU),    pbn_b2_4_921600 },
+	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP104EL),    pbn_b2_4_921600 },
+	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_POS104UL),   pbn_b2_4_921600 },
 	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP104EL_A),  pbn_moxa_4 },
 	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP104N),	    pbn_moxa_4 },
+	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CB108),	    pbn_b2_8_921600 },
+	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP112UL),    pbn_b2_2_921600 },
 	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP112N),	    pbn_moxa_2 },
+	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CT114),	    pbn_b2_4_921600 },
+	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP114),	    pbn_b2_4_921600 },
+	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CB114),	    pbn_b2_4_921600 },
+	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP114UL),    pbn_b2_4_921600 },
 	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP114EL),    pbn_moxa_4 },
 	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP114N),	    pbn_moxa_4 },
 	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP116E_A_A), pbn_moxa_8 },
 	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP116E_A_B), pbn_moxa_8 },
+	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP118U),	    pbn_b2_8_921600 },
+	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP118EL),    pbn_b2_8_921600 },
 	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP118EL_A),  pbn_moxa_8 },
 	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP118E_A_I), pbn_moxa_8 },
+	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP132),	    pbn_b2_2_921600 },
+	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP132U),	    pbn_b2_2_921600 },
 	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP132EL),    pbn_moxa_2 },
 	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP132N),     pbn_moxa_2 },
+	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP134U),	    pbn_b2_4_921600 },
+	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CB134I),	    pbn_b2_4_921600 },
 	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP134EL_A),  pbn_moxa_4 },
 	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP134N),	    pbn_moxa_4 },
+	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP138U),	    pbn_b2_8_921600 },
 	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP138E_A),   pbn_moxa_8 },
+	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_C168),	    pbn_b2_8_921600 },
+	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP168U),	    pbn_b2_8_921600 },
+	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP168EL),    pbn_b2_8_921600 },
 	{ PCI_VDEVICE(MOXA, PCI_DEVICE_ID_MOXA_CP168EL_A),  pbn_moxa_8 },
 
 	/*
-- 
2.34.1

