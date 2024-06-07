Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2091.outbound.protection.outlook.com [40.107.215.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86938190687;
	Fri,  7 Jun 2024 11:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717760639; cv=fail; b=DLpZQTmexbZxUTSgvikLUO/IWX2q2kEluqGjwVwdw2l0bUKaCjGinNLmz5tob3Rlz0f21MAznQ4Yzx0gKnicZg74vn+7U6svKFHrD+vmv8WDlp6/VM+FoMKJB+6a4qqYwUJ+B8xaK+fsn4xX0WRDI/1qiF1iIK4+jKYRE5txhoA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717760639; c=relaxed/simple;
	bh=zt6VFeofYwI9X7zNEPgVrz5MNFRyNq6++b0+udehY7w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TsPhwrL/U7DGMz8z5cF+CFTv8tWzZSoqJX5EgvzbUuEVTHIhU/uMTVEUhT7eyIdEOE+N+vG3y3bs6IBzfMeUpn7MK59tQy+r9qqcZN703BLyycaozDyC+G22pD7hK1tZhr1/3v2/34PJaX9fvYjqJDUce4+Sdo7bHxjG6WhCyjk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com; spf=pass smtp.mailfrom=moxa.com; dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b=ARZZPQaa; arc=fail smtp.client-ip=40.107.215.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moxa.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b="ARZZPQaa"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bf+s5+UmLs0cf2j8eRHol3SPnl+xq21QkMCfL+AFiZuc5AbHEETbAYtfr8QURvz9ZHhZeSGdKIRH1Sq3+7JWkF44kRPgy39pR8IObGN6u/l1I58FNq5pAE5K2yhpz1uD+qxAwS7PTdhrbuC7oEGdZNLJfRKEckzm6aSGOIkiWzZRwsQ9xqTsnyyJFfFtqE2x+7cOJu8w49r3CLfBoC6ZnUuXv8NBA2DF5ghPskw/UXmCTIxiVt/XA2qZJl669YV5T6u/3V8gNV+GyvwqAKtBWJL4XlarXfr6JB4AkHpSkKDBzrsRG7SWWqSpuwz8xBJRYf4Y/giNmeWVGFlv0iGjwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8rbk7jRCv8AH7e6eF70Ii9GBtYLdwRykrZXAppaVsyQ=;
 b=VxM5qQ+ZsWOLPJp6XFO9PJkxuFI95F+RbvpB6zTzUiaWp/95STjf3536RCa22DeyazT8RYYqlSNIS9c8mIUSdKxmtGpjr/tdSHgz3huMwIYU3FRxeGRhRUhBoOQwKWjhmSrSH8OFN0kdFXxPJlLUFUI8wtEKfMgJkvVVau5aWMw3kFY4Vv3chv5QE635Z5kzkEgeyLr6PL3R67Heflo3h+GfGdaYoebOk6Rfa8Vhq/1sOHPL36IbTUsR53IbUJvc35juIOquLLD6DxXyxMw5ES1Q+1rmYI2vJA6eb9j6VsHQpO8m2aaipjmzs9Fdn5AUgqwe5JQrpC7y1MPXDnJ8+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8rbk7jRCv8AH7e6eF70Ii9GBtYLdwRykrZXAppaVsyQ=;
 b=ARZZPQaaBqtsu9pWlk/Unbd+Ovfiix+JcxXc672x+X7vV8BrFVEJ141Zlliuz6UUzLw3+b/1xA18IQJhvbXRgwPHOFuVwsbz18NJqjKcIfonDBVI+1tbPYLEU8FCLhVb5yGh1TVWBFcjJsFcXqZ86eiWTPzOm2iy/LPQxszGNNA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14) by SEZPR01MB5588.apcprd01.prod.exchangelabs.com
 (2603:1096:101:12f::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.34; Fri, 7 Jun
 2024 11:43:49 +0000
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::60ab:8615:ab67:8817]) by PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::60ab:8615:ab67:8817%5]) with mapi id 15.20.7633.033; Fri, 7 Jun 2024
 11:43:49 +0000
From: Crescent Hsieh <crescentcy.hsieh@moxa.com>
To: Jiri Slaby <jirislaby@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Crescent Hsieh <crescentcy.hsieh@moxa.com>
Subject: [PATCH 4/6] tty: serial: 8250: Add check for setting default serial interface
Date: Fri,  7 Jun 2024 19:43:34 +0800
Message-Id: <20240607114336.4496-5-crescentcy.hsieh@moxa.com>
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
X-MS-Office365-Filtering-Correlation-Id: 864cbfe8-b50f-43b2-fb11-08dc86e718cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|52116005|1800799015|376005|366007|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eGjUlfvaoUqnaObKygYQdsDpqwecSEeLHkc9ojQhQuiUZEB1vnbAOuRxUVWm?=
 =?us-ascii?Q?TLMtiQ+YesNp8mHUyjin8U4Pt9WQlDFFB4GaRHXHGbnZVPpc7b1iK+HL8oF2?=
 =?us-ascii?Q?4LP8L3QgkjVloH1xYoctTF/2zXfKccDMBnLPitJGKU9/okInwXUwZHyjOkxA?=
 =?us-ascii?Q?NnIfIVf0euXB902fpT8C+qtI4ZWG/G1RAJq4D75Ly1ErFyjFJ/FheE43u0Cz?=
 =?us-ascii?Q?daj39+apD0rqmHb6LJ9rDlI7XRbh+C4bsi3+rSzDMU1nfde9AeElpA8E9n5L?=
 =?us-ascii?Q?s/BHklPW/1TiKCBlPqIMDQG/Qt3jPeqb+IWhjK2oegCz3bZ9zTELyV4+kASG?=
 =?us-ascii?Q?ZNqonkls5nbgQdQMYHRueZzMmonb9tPPz1YAEMcOiwM3BHYbeRIeEdgveJ23?=
 =?us-ascii?Q?BZpuyKGUQnTpJXYBJ5pGnwNZQ0yopVXGhCj8+N6sm/oC8stQAbbF4Nwp3861?=
 =?us-ascii?Q?k8hE33Zolr7vxEgqyyoyBPsHHGziyFGhMmzLaZ3gXUyHFXVnfFkTeh+x30MC?=
 =?us-ascii?Q?5ibqEezcZ7r6o5lvfB3adSmY/iaVjVFijSA62Tm43R3GD74o15VqgWzmVs0N?=
 =?us-ascii?Q?Gw1QJv+woPUgttwTYTQ4LwPMZH7bfBBBpKMMGYoW8vVoQPtUPe/TE+p5ahEz?=
 =?us-ascii?Q?u1pufXqofnQVexmK7FJqA+OFvkY2UpLigYu1zFyYrVZIcOPY9flSqiF6ppoY?=
 =?us-ascii?Q?AP6Us0qwNIqWwWE455P0cU2jKAibGYky10NniGoMJey8xBKbqpJKbusvGrUs?=
 =?us-ascii?Q?0G+n8K+gA1OGjtlHrdLYtDvDCtSKFLGXI8eQbN/VDfo6tB94U7nB3nlaFhLw?=
 =?us-ascii?Q?xNj7CNunBSA/BQkpQjc947WS65qA9DfoQ4NKSTF/JjNwinjXBamRsL7RyYwc?=
 =?us-ascii?Q?R4vOCjen5wp6i5ufiwZBYAPGRUMrt8FYclgtWIju+CLywkJH/EYJR5AXd7KF?=
 =?us-ascii?Q?5DggmW8AwGZhMxm4Wqh51mX1EfjejBhBo1+1PEWcadQTASGfBZAjRUxJf8yv?=
 =?us-ascii?Q?bOKUW6HUduNG+S6vTABfSdOOIPf8wC8HABmM854GoCzPz1A9GJ3phvE1eUIM?=
 =?us-ascii?Q?CKrBhzIRMWGkwaAO2occG2EaOLPiJxZzxIA2vsl3SCRFeCtuWPIMlidlzS81?=
 =?us-ascii?Q?KqS6/tQFIXWgHxYqeKyPAbIgYdHemCVbDypyWLJZHQaxp+k4crwF5Xmkipk/?=
 =?us-ascii?Q?X20OeWZhF62sZ9lHZk8Lg98oY3abBfZEtE7joSbd1pE/GYukFzNEC7InimXd?=
 =?us-ascii?Q?z7AJQK7E4QDaBHkHEDP4QSUYgwWxW2aH7P6g16ylT/xhQBIVxp/Cy8Yx+Tnw?=
 =?us-ascii?Q?CF1o7a/gC0pbti36gGEWvPtfEdQi8enA9JPvh7BPm1a2eoND8TwhXMTmZYW0?=
 =?us-ascii?Q?0Jcuta4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR01MB5405.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(1800799015)(376005)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?trMLAPY7W+wi9J84fINDMLiN8HgZaZv9Z3knYsfmlIXw7ZV7JdjkPUF1m9IA?=
 =?us-ascii?Q?6m+DFepUdmskJ0C/VIwrt1zqjAJfUXVtVkVSAbBzXHMwgFjwmKp3WAGN9w3I?=
 =?us-ascii?Q?q4h9JnAZjNM+NOs9Xln55LmO6TdjHAR9pHIobeX3xzJLDv45xxhBoEwLfXvW?=
 =?us-ascii?Q?z6FGgoDiWHE0xJpAUQgz5VIcz7qt++BpvXIselt9xQHHZwSLtaw8vl7pwY8U?=
 =?us-ascii?Q?28fjXZzXJGYuLLw+rqgnnaupnCzKuaabHir6DH9uiwhIS2AVkhhWzIsT+4tR?=
 =?us-ascii?Q?ji6kL0xf9ydBWO06iQhgPKkpCRmvLTilx8pxepVYjdaLQSCuwPJ8Rb1CY96D?=
 =?us-ascii?Q?oA4qh9t2QT+IdKFwB52tuoInnp8HJxMpYTlPsq5aSDW6CeoGJOeFZDyRLHfW?=
 =?us-ascii?Q?OM40I7iJSsQ30AFozrQIoEWd8fCXJ4jSKrpiaIL4c41jKkWq0ciO2/v+xT1X?=
 =?us-ascii?Q?NUX5cQG1ll8golsrzEPkRQrEZjeIYy9XAN+aX6YMALjS27MBUo9YDred0CeD?=
 =?us-ascii?Q?6ujMA5BcFsLMHambmh7xVaCzbel0zY0hgqFBoEDvPliJS9p2TTKhe7TnJkmi?=
 =?us-ascii?Q?xtZyqhVgeVsYTDw+6q50LvguGMvIoFSWWYpoh2Ow6oK9TQeKAA0nnDly9VIp?=
 =?us-ascii?Q?h7JpAj+QTals0VpLGzv0ok5f16U4U0iEE+9RmG0jORZKGV5LF7CBfBegIHc0?=
 =?us-ascii?Q?nCxMEwcvPWtIPkYewpLdHFy1Lt6m9oRI25FIZzkBUiQTPmS92LoeAkFFKJxR?=
 =?us-ascii?Q?dqxC86v18JLdOiv89D0apiyncaciooCFZZtmW9acKppNQ19pa97lN1r6UKOI?=
 =?us-ascii?Q?1cDF4Vik/cs23FV/WRONKsS8mmjtxx0XrjPn3XX7JcwskEcN1N6VqPFFvxOp?=
 =?us-ascii?Q?I9qPugP+mr3sfujvOgl5uplv8t099g6yStIvy9E2UarJSdK71s9KhvjOMQgo?=
 =?us-ascii?Q?sUv7NgDOVOBteNFyiVTWcaiuMEOOS3kl+Erj/HLCqIB4QhQlh9Mtxoq0dCfb?=
 =?us-ascii?Q?c0ufAO8Y8W6b94N+MDZsbbBAZzG3hfMuJidq2ydis26TLP/pTXPLdmMbfJsd?=
 =?us-ascii?Q?1ndrJXdGDGAT2IyWo5T9CiHKOK1XVPFMBrgItS8A7AXxT/sOM1xISpmNQSFR?=
 =?us-ascii?Q?eRupqIJcZ42n5BTnjkKwZPEhKfh7XjzbfErsF2Bqida97b8mwKM74zhnoRzX?=
 =?us-ascii?Q?t4GChJQ6NkYmG8IY9MNZoOce6E7kemXrXhsA4Ko7FBiA01P+huMCOA8GlOtz?=
 =?us-ascii?Q?cG8tjsNL38IPJX9Cv8tOUeSHYFj1d7aMJylJ2zCEi42FLjsjzvDiH6fg1iYH?=
 =?us-ascii?Q?gcTyloDJe9KXAIg91bqpJgkhqD2Z1ZIBz3d9If4MZZN0EqvHUa48yrd3X+xi?=
 =?us-ascii?Q?cQEUswvMTli8j9XE8k9vf6K/hlv5lkB8XKolm7TaPdY0F7Vd1rKMM2Ez8oQx?=
 =?us-ascii?Q?XCpiDtfqT4vwTQhZR6t+nojAlQJ100u+UnG5nfNpyOMTyet3oFpbMUpn8apc?=
 =?us-ascii?Q?+nSlNjSubkX43Hj2qPjxkN0J0QJiCbfITIOfxDiLo35NYFKfS6/N0NBWwqLe?=
 =?us-ascii?Q?mk+tcmL0AlMnVORKikuyjFy+elHedEJXX1ngQbplMi26UsDgPyIo21g9AyYQ?=
 =?us-ascii?Q?ZA=3D=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 864cbfe8-b50f-43b2-fb11-08dc86e718cf
X-MS-Exchange-CrossTenant-AuthSource: PUZPR01MB5405.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 11:43:49.2763
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FO9ebqjOLcPFbDsRC8qsWo6tnvAQkpA2exeaGLJp1se2OY0P2zA0f6AionNaXSvtti1FSfvPiXXfFpoG19H6LWEO9ZNtTPMngn2rFwgk8oI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR01MB5588

Moxa PCIe and Mini-PCIe boards are capable of switching the serial
interface through software control, while other PCI boards switch the
serial interface through hardware DIP switches.

This patch adds a check while setting the default serial interface.

Signed-off-by: Crescent Hsieh <crescentcy.hsieh@moxa.com>
---
 drivers/tty/serial/8250/8250_pci.c | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index e5bdabcce720..e4e6493a5497 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -2010,6 +2010,25 @@ enum {
 	MOXA_SUPP_RS485 = BIT(2),
 };
 
+static bool pci_moxa_is_pcie(unsigned short device)
+{
+	if (device == PCI_DEVICE_ID_MOXA_CP102E     ||
+	    device == PCI_DEVICE_ID_MOXA_CP102EL    ||
+	    device == PCI_DEVICE_ID_MOXA_CP104EL_A  ||
+	    device == PCI_DEVICE_ID_MOXA_CP114EL    ||
+	    device == PCI_DEVICE_ID_MOXA_CP116E_A_A ||
+	    device == PCI_DEVICE_ID_MOXA_CP116E_A_B ||
+	    device == PCI_DEVICE_ID_MOXA_CP118EL_A  ||
+	    device == PCI_DEVICE_ID_MOXA_CP118E_A_I ||
+	    device == PCI_DEVICE_ID_MOXA_CP132EL    ||
+	    device == PCI_DEVICE_ID_MOXA_CP134EL_A  ||
+	    device == PCI_DEVICE_ID_MOXA_CP138E_A   ||
+	    device == PCI_DEVICE_ID_MOXA_CP168EL_A)
+		return true;
+
+	return false;
+}
+
 static bool pci_moxa_is_mini_pcie(unsigned short device)
 {
 	if (device == PCI_DEVICE_ID_MOXA_CP102N	||
@@ -2070,11 +2089,13 @@ static int pci_moxa_init(struct pci_dev *dev)
 	    device == PCI_DEVICE_ID_MOXA_CP116E_A_B)
 		num_ports = 8;
 
-	if (!(pci_moxa_supported_rs(dev) & MOXA_SUPP_RS232)) {
-		init_mode = MOXA_RS422;
+	if (pci_moxa_is_pcie(device) || pci_moxa_is_mini_pcie(device)) {
+		if (!(pci_moxa_supported_rs(dev) & MOXA_SUPP_RS232))
+			init_mode = MOXA_RS422;
+
+		for (i = 0; i < num_ports; ++i)
+			pci_moxa_set_interface(dev, i, init_mode);
 	}
-	for (i = 0; i < num_ports; ++i)
-		pci_moxa_set_interface(dev, i, init_mode);
 
 	/*
 	 * Enable hardware buffer to prevent break signal output when system boots up.
-- 
2.34.1

