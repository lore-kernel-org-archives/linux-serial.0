Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2116.outbound.protection.outlook.com [40.107.215.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A255187336;
	Fri,  7 Jun 2024 11:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717760635; cv=fail; b=gBk4qPjK7LfY3KmPg4/6wjbbuIc9SmNXxcBj5AUSSPnXlAh7z4hzYav4HuL8K4/ickyS+MHtOzXUyZXvwoyhuDgZ/mo3XA069QP+RV5HH0HN1AvYZUuOQtaf3g70d+HJfZrHr2caXunp6rt06EECZUPZ4sPH1sDkHGAR9pSyxBM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717760635; c=relaxed/simple;
	bh=AomXrG9TdvRvi9FYFoQ5Qdff26AXigP3E5ONNe75qB0=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=tabqFFr0I/Ul48jp5VFjZ6uJ39IURJLGQJCrY/1bIHMkBNdX5fY+M7z4C48zH11wWQk1Gu/iD5Ea9S6EXr+QJB84AKhqaxF3vXNSzjcqpMqOvT2af2ndqJzzRpU2WmkQHBJEshMiyErOHpV5/Tdgks/Ir4pMteRHFwofgXXaJno=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com; spf=pass smtp.mailfrom=moxa.com; dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b=b4ULLkKc; arc=fail smtp.client-ip=40.107.215.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moxa.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b="b4ULLkKc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H+d4RvmllGMNXps5nlj70zHnNJXQIrDA61gQsLhUR+PizUtz5FLOORZ+hHIJ8PC5Cz2ua4KHGaRBMwklbNjM9n4acqNUcgX/KmxlP4WO4ebltBuKRN/31l48JRSFrae/wjv6HkurxFA7tD3Whefth85uWQUkGIpkh0cOkUknqclUFkWyYoBogBvz0rGa0jiVie0MjhX/9NfauEHSXnFOBuolEaGGoKHe0PK4NAPmST6dwCTNiR3bXg4AYWEgIl70PPCZh4RwreneDmVYZkJwPUykMvJT8wzgk57JFu1rzNmJO1BYrU5y2WhfQ3NRfqjU1CRrJAabve3/XeFxtByqsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KYw3sJu+k8WzxJfraNNDUApRpv74Slo0lQjEK3yGwe4=;
 b=OYK8xj9LOzJvm8RMbSrmyze2J2R9njx3owSCQvfUaRtuwj23TH37CEW4KIf+bQvo4kDtTBwmkIUVPUZrnFGjT7xVtYfVn7AKtzFFbTuwVnYFWnJ0A+HoGuUc4hmH2LF1sauSnMeK+o+q9bQ8mB5ZrDh5cl7DML0zQ2iLty3RFFcdKmJ6XA80FH8Hd3X9tMyBwM3KBXkg74a/o+qZ/WrqVuI3Ribkx9BczpyTCMxybcxP93/74zdj7DFUJGarjWVv14AGHtdo/xJpfzCSMJ3gauOmr7X1OCPa52OvpwxtNCEfKW0cNxueFvrZVUUEUxo6hr74rogcgUYTufeZ/eMoiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KYw3sJu+k8WzxJfraNNDUApRpv74Slo0lQjEK3yGwe4=;
 b=b4ULLkKchHdaUEBczWXJVkjmXORuXPuaTxBkuhS37QBDSdkAk68zOBtGpnRfZw1xkWPW+7FblfbWPbiPSi4J/cAf6Nqcwfs/xr62Q1nhE3YC1iNL20yStQ5EnJxKAD14JEqFSZmEh4RrVxQh48YPOomKN+ayVYx+EJTgpQwoGys=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14) by SEZPR01MB5588.apcprd01.prod.exchangelabs.com
 (2603:1096:101:12f::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.34; Fri, 7 Jun
 2024 11:43:46 +0000
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::60ab:8615:ab67:8817]) by PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::60ab:8615:ab67:8817%5]) with mapi id 15.20.7633.033; Fri, 7 Jun 2024
 11:43:46 +0000
From: Crescent Hsieh <crescentcy.hsieh@moxa.com>
To: Jiri Slaby <jirislaby@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Crescent Hsieh <crescentcy.hsieh@moxa.com>
Subject: [PATCH 0/6] Adjustments and Enhancements for MOXA PCI Serial Boards
Date: Fri,  7 Jun 2024 19:43:30 +0800
Message-Id: <20240607114336.4496-1-crescentcy.hsieh@moxa.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-Office365-Filtering-Correlation-Id: bb980c86-d018-4338-3dfe-08dc86e716e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|52116005|1800799015|376005|366007|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ty4/gi3jMv2B2VBwHRDdbID6dfw+q4YatjDpCGtHpucWom41P9udX+tUwPrN?=
 =?us-ascii?Q?A+ZfMTuYRZ2dfXYSBXw5D8ZEY7tkoufeWIX69A9QdmDixB8XhjiW9RZBljhb?=
 =?us-ascii?Q?zfZqgqUr3ORq+QgbvNHQ1xHj7tIcR8QozQutqmtWo6mYsyJ+zAkyDy8TsbIN?=
 =?us-ascii?Q?6bVI59cSNzqAFnoYXYcDrC/WY2cIl1rsPpfTBPOvNIDQM8NSpNFnsG4Ndb9E?=
 =?us-ascii?Q?afM3LKgNgnZfG+3EoJsrvDerTFRkqdAxV5FnyuPwEsXUaw0VSlj9MzdZmgB7?=
 =?us-ascii?Q?WnEt169oAQmWsHxdp4iOFla246qzYR9wpMa+EjODadzU+RlFOEinsNZlNtYV?=
 =?us-ascii?Q?54dr6t0byWzHXo2q8pHiDB6nQviqw/tfkOdydVkWhhDxj2DK3gfBFHZdH7ft?=
 =?us-ascii?Q?ZFveM8yVV+B+Ft7rDLY5KUcVWT8IUfM1aYIsBdPUb0Q4007MTcUITZQGp/nF?=
 =?us-ascii?Q?Gm3237xOJSYLKgD01Ka/qj83xN3qZ1C03TABflGZ8+2j6WWji8+HmrG5PiZc?=
 =?us-ascii?Q?1mOTOTzpBKhJPoyvBqiLOs51E9R0BFV6pKSgE7eGWfMTCg5t4Mr+EYhM47NJ?=
 =?us-ascii?Q?CvWPSx6WVHVUd5W5W890aOSYpK36l2ED7hT2rEa1SQeuWm1HEFuEm7cQChiX?=
 =?us-ascii?Q?OZsJ80pIudEgO7Cskj/IY4LIT2fzNWRLhPCRp1vwU5/Thcn9+3woE14BJQTY?=
 =?us-ascii?Q?X5Tv0VfwIL+JeySbbqT3eIzD/OolzK+Ud8JnnTMLRib5IA1fQHOqCZsWDuKX?=
 =?us-ascii?Q?FMSmvkbjOrXs2Lht17dwbH+ss0deJ0q7It2MFvAU9S1scw0krB1Zi2di6H51?=
 =?us-ascii?Q?gVgma/rW07Mqm+y3Hs8HAiZXB+f6o0ND4PrX/FtOc+9X+HqvBONsYCIhwtMs?=
 =?us-ascii?Q?ZueI8K9zsWCX3UrODrwl51q1fmOQgU3QuKxTKyHID27mKKjjmJRwWVH89Mrt?=
 =?us-ascii?Q?7J/q596BkFJsepx1VO/cY8fluA73hjOfdVPiN4OJGPUFJtgEKq4lpFjN9ImC?=
 =?us-ascii?Q?ztJmyMrcCBZD0znZdW4h21he/vb/NFKUPwERBMOIQDqxieqMvugN/Ez16l+e?=
 =?us-ascii?Q?3VKujUHmjoQu7XGdYPHvzuC0ASN12wq7GR1rR3CE18KsnCSS4hpykf2t9r4B?=
 =?us-ascii?Q?j+TobHbuRhWLR17gUCDRCs+Gswv3+U710G2GogJKn5ZYblU4eDh7jjeZoYXt?=
 =?us-ascii?Q?GRBNqGPKSjCYOo8lEnxNbhTfSFGySIPCUKwNn7Fcqm/m7JXxUSz3oucfgeXx?=
 =?us-ascii?Q?9SYyiiR5PYw0krB5z6pCpV1O8IqIxpgcI3L5LflujTsTL2NX72HL5JcANTQQ?=
 =?us-ascii?Q?Spgiqf1gmtwY0d9rJJvUx03GOhLDSFlaQ92mnZ+KD3nVUm95L+yha1avW1Ka?=
 =?us-ascii?Q?Uud/F70=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR01MB5405.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(1800799015)(376005)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ko5yT1P5qBqWr4fMGkR/VaCmbYwKYKl5pHWMWUi6a/enBXMGE8aLTz5BIb8x?=
 =?us-ascii?Q?pHJmvEuUTtdUIpHKsVPWWVZsNdQ0ROHzO6b8m16r7+ypl3QfMP33PMZ47FcI?=
 =?us-ascii?Q?WDkUioBuhp4Jhnw36xjiele/2077sikGPst+UXeIbioNDlYYTRc8sSiVMlCX?=
 =?us-ascii?Q?1sSMQNXa4bs19mGfZpCjckJej6zjZuqhHHWGK+BC+bk3X2jtalI3k/TePh2c?=
 =?us-ascii?Q?ekUsWBgYu2anF30NGKXFSbO9AIcH0l+2xh3W2pICs6nftRUbpdCUjSHyUBpS?=
 =?us-ascii?Q?B0ExJuJyzF20ZKxt07j75scTkePkOD3w9rAYFuD4EYbHLAAIxWYiOkpK72EH?=
 =?us-ascii?Q?lJ7jwRLPvTfJOP3uUMRzXCrsUW3fIjW/OQBK/WpzV17j4Y5PvQpSBBRc3uwL?=
 =?us-ascii?Q?peZMer0xRqK52R/kFeAOwziJctt4dYQhOfAx/+7g/TS1PDFCmoufJY4sGwJU?=
 =?us-ascii?Q?VfIsFHiMPDHkE3K8N1OGZJ3e0TLwjuIHkU4KHulSjDs5j4UbST+1zG3RJ8Zj?=
 =?us-ascii?Q?JyzkvhisUjXX0nUJSFE719ISZ3RVrKcCmb2n11VgCVBuSKd3ye6ym2sJ3rOd?=
 =?us-ascii?Q?2Mf/CQkGb5AoFsY0mgvWNM3bZq33mEwn3LyamMwsGLPLlqBcRVEXRg25McyW?=
 =?us-ascii?Q?48040nmLUv4zLTjCaq9mfTbNWrBOBbRsndatUhUyGkBjwFCONlfhw8JR55uJ?=
 =?us-ascii?Q?gCcoxUUg2wZF2yDQrTmKo2mAHqAZ8e+5Aj2pVDl6E7AlpnDXL24PyWAJ3GXb?=
 =?us-ascii?Q?czFaIW5MwB4+Lw2fa/ObB5eLbeN0dzcqpoXX0C1cdVAtZMM10zXAcAB/NFe6?=
 =?us-ascii?Q?HQMJXifVjoWYypntglbIivDpTUC2vnyAJ/wp+7LIYb6D+OV+PgV1Kaj3im1+?=
 =?us-ascii?Q?FyRnggLb6bgOUZxk8tgAmFfomtWfeDCmUU23kxOmpE+6vqu+TGXH2kew6IE5?=
 =?us-ascii?Q?bj930+Z6LM/OA7lK5B4HS50jdZ65M5RwPrWv/k8vxc34rdrDSOUeEiVYzxtk?=
 =?us-ascii?Q?ev7lejoYTeMvxFXfZmw9qf5WwdsjWr0UALW7HXnAx8bg5VVEQOrLlbDXmVZQ?=
 =?us-ascii?Q?9MsePEmTgQPppsyYkbgTaXy1EmOmkH3f4jwRKaWgPXHHMg798ysM88iLk0NR?=
 =?us-ascii?Q?ljI9Uazp0RWM4DPrlB1o7N8DO1F5qY/0eMImRCb7u4Z0XFQ1il6vnZxh8Tpk?=
 =?us-ascii?Q?wqWvl8ipK9ymN+GEx/wAhbTBe9/jQNGcpqaUJyeNBQpPAlqm/6vlNlH1Di+5?=
 =?us-ascii?Q?5cva/sbU/IscVodNttSlhd6d5ER5It/6JecXkzUGNnQ8GMLXr/na/CsrBmwu?=
 =?us-ascii?Q?kBgXF2iqlfE/dSeh9cv8nUM6qNVVNT8FGo6WJEnBk6Cn3Z2+rNd3a9ssmZaa?=
 =?us-ascii?Q?xxiztH/N7Qio0jg3fP3Tq6sGortcmjXqMLabTpDFskvEmfqc4dfpuqgGjrtM?=
 =?us-ascii?Q?SotsW6ltaICI3iezYN7v+QVxbC+UBcK3vLXjxeKWg1/8JyAh1R+KQsujoLzH?=
 =?us-ascii?Q?IvPlR+9YBg/I3PNztmbCK5pCIC8cCcXo0f9OAcda8VcMY2zEqNXAbZaReWfy?=
 =?us-ascii?Q?qQ92ESsfl3XfhKduQNbKXgwmoXWaVlzgKkAFbiziRv3j3eL6rwYA1pez6in8?=
 =?us-ascii?Q?dw=3D=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb980c86-d018-4338-3dfe-08dc86e716e7
X-MS-Exchange-CrossTenant-AuthSource: PUZPR01MB5405.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 11:43:46.1768
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ub6iVXMBSfVt+2voBFSdTE9ltLkbT4/4KVAHO67TxNMkijIwMUciOOJJtuyTAlQO6Y5RJaBntPEmj227NNCaFu70YZrlMDAeeco4prRYNug=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR01MB5588

There are 6 patches within this patch series to make some adjustments
and enhancements for MOXA PCI serial boards, a briefly description is
written below:

- The first patch is an independent bug fix patch.
- The second and third patches migrate some MOXA PCI devices from
  `mxser.c` to `8250_pci.c`.
- The fourth and fifth patches address improvements and adjustments in
  handling the serial interface.
- The sixth patch adds a UART configuration that aligns with the
  hardware capabilities of MOXA PCI serial boards.

Crescent Hsieh (6):
  tty: serial: 8250: Fix the amount of ports doesn't match the device
  tty: serial: 8250: Add 2 ports PCI configuration for 921600 BAR 2
  tty: mxser: serial: 8250: Relocate device IDs from mxser to 8250_pci
  tty: serial: 8250: Add check for setting default serial interface
  tty: serial: 8250: Add support for Moxa PCIe boards to switch
    interface
  tty: serial: 8250: Add support for MUEX50 UART

 drivers/tty/mxser.c                 |  50 ----------
 drivers/tty/serial/8250/8250_pci.c  | 139 +++++++++++++++++++++++++++-
 drivers/tty/serial/8250/8250_port.c |   8 ++
 include/uapi/linux/serial_core.h    |   3 +
 4 files changed, 146 insertions(+), 54 deletions(-)

-- 
2.34.1

