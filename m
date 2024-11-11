Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2065.outbound.protection.outlook.com [40.107.20.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5B5189BBB;
	Mon, 11 Nov 2024 11:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731324573; cv=fail; b=u7sEM+BPoz0F47boZouwiHVj2gkpHi9jlThvoaltGBrACm96T7GehannCGGLqRHofIdsEQScyG7Ge8wlWNR3PugBcIVTuWLouW5uMcRRSpI7IjDwpCc9KQ2AfWsKFmP/y4W0ujZlrcvgQH5llJGoKAS2SCOFySYCon24L5BNSq0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731324573; c=relaxed/simple;
	bh=bh+cvJVgVfmlDFP8ZHq4gdBT4rSgzlIn3Mj4ZyrBxKI=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=kdZEyL1bqbrJ2sfBIusc6xSxkoYK5mDtnNyuzUfjoCT1m35EdC8F3OLteUUHRElVBzYobWe63kf81Ds3WaPwsMW8guro75f8DgsuYoeVd0VxDjups1vgwdUmy0xwSCHv7T6n0QulkWoODOKRSIn0ej9UciydNpC18E6vQ6uS+V4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=RkMXZzRY; arc=fail smtp.client-ip=40.107.20.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="RkMXZzRY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CQxYJWl/J+FNz3fBTd238XUfJiZjBQeBkSL7rRKGnXFvZNe8KPWU934i+WLuEIAAkvYxIz1x8nzTVX3O96rWkuV2h3DiqpQb2SkFAFfSpjc5TZT8+FJiWZySgYow4Vjncu9ecJe+Q9g54Bz1lIxLJknot4w4VtJcU6SZiNotxCKwrQ0kX2KSI0FfKCpHayEygMfYBdPbsrTRVPWPmElczdJY92nrI4rfKiXwEYoQS+HW/cJVJOPwNUyhLVrXNkwgeUNAaG/AHJ8Im3eFEWsvm/vRkf2/s432RCU55JRfrlfcNMUQqpLKEOLHU48FVlT4YIbrHqDDPWbVjYNG1gwR/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WdRC2spHFIotK7CFpVqjiSfl3jzqoTYsGjePdE4Ao+U=;
 b=C4IZFHphc08Iki+yVU23rqQRz+MxHZN9Y+eD5KC/bdfMST23pdzXBQQ1YIEPbObI6wzNaM/XM7kdNkKKfk67QT/lvwFX4tcSJuDLjQ6IED/iATZXG7WEB+N1opH6OkZcCwuV5R3blmsyFFPN44ZduwG5iqP2ulM/5zCCFe147LP5F1nC9R/Mc2jqArBJ6p2Fl8M9cRvZ1lh/66AGaR/WyWEiSxf52p8V+CmDKg3SCuSJStbNsycOzXrD+qLn/OMhUPs4G3Pex7wrDt/TSaR5KaCT1YYiCXLndHu43TCiYNWp9R4t0YKgXHoJZet+kSLEZX+b4K1o5g2Ylm7lHbyegA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WdRC2spHFIotK7CFpVqjiSfl3jzqoTYsGjePdE4Ao+U=;
 b=RkMXZzRYAhiLwAhXOJA8dFTwL9gI7CWLck9Z+z/0Wj3xM6xK2M4gSmNLjknyehno05uM1p71ov7ijClaQ3yXZwDFpYmMkPdzl2NZw+f3T2ptRW6q1fwv+P0e6ZYZ1TgSwjlP7wcF4PFn8apXPcNmyiUAnMivgUt2VDRQ9RF9Bs3wpPohuhnSHzN3uWivNlRho5q+LO5SrJtDnrwOWG0VKrWGfHQd3ARCuhCMmpp6QGM4z55tmDxIBkm1K2E3iePJTqueMIOZu5d+BKgofgCWKR9Pa2SKeC5/JSI4B4bEgSFjgUIrLKdsIW9ORS5xYGuDKxs0ycxpBtwBjgwuVXQk5g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by DB9PR04MB9428.eurprd04.prod.outlook.com (2603:10a6:10:368::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.27; Mon, 11 Nov
 2024 11:29:26 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd%6]) with mapi id 15.20.8137.018; Mon, 11 Nov 2024
 11:29:26 +0000
From: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chester Lin <chester62515@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	NXP S32 Linux <s32@nxp.com>,
	Christophe Lizzi <clizzi@redhat.com>,
	Alberto Ruiz <aruizrui@redhat.com>,
	Enric Balletbo <eballetb@redhat.com>,
	Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
Subject: [PATCH v4 0/2] add NXP LINFlexD UART clock support for S32G2/S32G3
Date: Mon, 11 Nov 2024 13:29:19 +0200
Message-ID: <20241111112921.2411242-1-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.45.2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P190CA0007.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5de::6) To DU0PR04MB9251.eurprd04.prod.outlook.com
 (2603:10a6:10:352::15)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9251:EE_|DB9PR04MB9428:EE_
X-MS-Office365-Filtering-Correlation-Id: 910577dd-192c-4cc0-2465-08dd0244198b
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?akNKT2QrOFllRGpqQXIwOGpZU0JxeExBUDRxck8yY3hFQjZ5OGpsR3RKVldq?=
 =?utf-8?B?QjQ1Vmp0NExyWlNlNkdUZUpsUFpqdE9TZWhoR2NZek84SU52dy9uSm1yT2pa?=
 =?utf-8?B?MHRyTkVQMFhmZWtXZHlXMUJ0b3ZVV3RJMGZSNWdCclBteXExTURmaEhnUEpJ?=
 =?utf-8?B?b2huK3NiTlIzVFhIOVdNNG1ZbFJrTmtTY0k1RFpWZm5qaFEwZVRHalVybmMx?=
 =?utf-8?B?ZjVUZGVpS1F0OE5vTHJYSy9mYVN6VkFOYWhXTDM2R3BkU1lEa3Y4bVlXdHEw?=
 =?utf-8?B?Nlc5Ny9Ick1SWElNcXh1aG9mS1UweHAxTWVoRFl1QktteHBJcGlWaVR4ME5s?=
 =?utf-8?B?SkVnVlVpS2dXMzNlUkQrSGhCZmkrNTd6SG1MMXJqUk9qYjhiNTg5VzRRR0tq?=
 =?utf-8?B?cnJEU2w1WmZ6VUwvNFZsbFpTSGEwS0ovZnhEd1o2OHNFbkE2M0NLQ3hnQ09a?=
 =?utf-8?B?VTZTSjRva3RBSXZMa0c3M2lQbVdXTHVwMlZmNmd1d1Boa2hzOUx4emlrTzd1?=
 =?utf-8?B?QlFxVG90TXJIbWpZVGRwdCt5NHFNRkE2V3dOZW93bXprejZmNk9jWDJGQ1po?=
 =?utf-8?B?K2g4VTFLQTFtS05veFBzVkxwNW92T1IwVG5hcnFaSnIycjdBR0o5cFk0L0Y0?=
 =?utf-8?B?YmpEdmpkcmpkWVBoaXZmZmpuWXp2Zm1wVVBhUDhkUldqMjl4T0R2bld4OTFB?=
 =?utf-8?B?cjBJSldtNFR3UkV5b3FDMWVVMFUrZVBoV01OaXNQRXZ1NjBaengzSktBei9s?=
 =?utf-8?B?OXZpMFBGMkYzYzBtaHA5S2IzY1VhdFU0THJHZHYyYlFvVnd5d09IWHZPSGEy?=
 =?utf-8?B?cVJZdGxVRnQxL2xjTlk3NEtrS1M4NStxdmFFWmhFbTJPQlJNdG9USjdpeFFM?=
 =?utf-8?B?a0JnR2xWM2RTZEFiclJ0WE1jYlJJSkZqWDRIeDRHSERuYUg5cTRSR01qaG04?=
 =?utf-8?B?ckRHNzNGWGlyYWxUOUJkRk56ZjVoeG1hUzlaQWdzeVRHN251OWcwTUJNRm9i?=
 =?utf-8?B?eGF5OWRIeVo4R3NDOWx6R2UrMnYrQjFaL3FWbHBUSHF0andkc0pxT2FROHAx?=
 =?utf-8?B?MFVZWWlrTWhLZVAxbG95NGpLWnQrU2VhZVFMdFppT0U3U0ZOczcrZzlMTU1W?=
 =?utf-8?B?V0pTTXZsQ3NoM0l1YlordnFHb0FSc1BzTTduKzJRT05ZWS83L2E5NGV0V1Zz?=
 =?utf-8?B?L3QrU201U25HNUJzanh3a081TlBFdFljVk93TmM5TTlPSTZSeVJkWVlCcGxB?=
 =?utf-8?B?bXV1SWsrN3ZLOXpzeG9uVllqTTlWbHVjdzE3R2pOa0o3M3VNRmV4ZXNXV2RV?=
 =?utf-8?B?Q29yTUJmY2VOSVpxVDB4OUsxUGlHT2pTeEMvN0dMdFY4NXRZTFJla2pDZEw2?=
 =?utf-8?B?SEZXdTcxUHA5RCtWS3JXRklMZno5a1dlcHkxVDV4VU9HcjhRR3RLTitwNjIy?=
 =?utf-8?B?NlVuK2JQNnZTUzY2ZU11am0waVVJRWxKcTdERHppVGFFbjdVS0pOTzRtNnho?=
 =?utf-8?B?aTMvYkFWOWVGejVzZ29KUHh4b2ZkQ2k4dWpnWS9jb3lRK1R5ZmZUVGpNRmc2?=
 =?utf-8?B?Yk0xV0xyTldzcFYxQUNTOU9IUm92dUxCZXI4dXNNelBSVHpWL2NDWEFnSHlk?=
 =?utf-8?B?ay9YSlNDWjlVcjk5RGg5K3hOWDZEejBMTjR4NVlYOWpUUmFYZzZCYXF0YmFn?=
 =?utf-8?B?Y01sNzBCY2VTdGxHZ0Y0RlVERC85cEIrQmRZckI4M3hoZzNnUjJUaEQwSFow?=
 =?utf-8?Q?JnhVAAv8OfmClT9ZPd0tuptgYDDhIlHj04vFSdb?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bzRGYVMwaGRPYk1oclQzckVOL0I5WUdzZDl0Mm90elFuTjZkbmo3L3VId3Zn?=
 =?utf-8?B?dEdpY1FXWjRqRENRRHZaUW5qK0RhTm1UUkdhYlFxczBpVFJJa1ZLTURCamlS?=
 =?utf-8?B?SWZ6S2VxYnlaRFh3VFRNckVDTEl0bkFKOE1ENHhCVUJXRGtzQndpRSs0VExr?=
 =?utf-8?B?WVVkakkzanBHWEttRnNIRjZWMGpjSzdBV3piVFJ5Ums4SXFrM0pwNElXVWE4?=
 =?utf-8?B?cVBrdHVnazlTRytocVQxN09qN1VOZWNSQzNZMFJEQTd3Wkh5TlRZeXNwNmNh?=
 =?utf-8?B?WHIwRkpkRTkrQ2ZwTDdUR3lBakVORW5VNzRENXpseFUxL2RBcW1ZWC9mUEw3?=
 =?utf-8?B?OW1ZNG42RWh2cktacE53N20wYXFwbVp5TEtnQ3A3RExvcG5OY2RJVG9DZTBq?=
 =?utf-8?B?RWJHSmliZXBJVzhwZ1ZOSHQ4cWtSc2EyUEJ3QlZBbzl6ZFVKN1JPZGVxMUZJ?=
 =?utf-8?B?NDFLMWJhaG9qd1BwSGNqM2FSS3ZPS1pvbnhZWFV3cElwTVpZekZjaG5OQk4w?=
 =?utf-8?B?OGNJOElka2tEWndraTFWSC9ac1laVTYxUCtnNDhxQU1LSk40ektocCthNHZ1?=
 =?utf-8?B?RGFlaGY3UGxkM0xtOVdkMXIrNkNIbExlNmJJbnoxRGxrc1llTFR3bldxZHFB?=
 =?utf-8?B?Q2V6SGQvdXhic0QwWTI0TmFTZ0RUb3ZlYWZlLzFCWnowVyttM0krc0l0QmQr?=
 =?utf-8?B?Qzh1VkNnTXpVeVk5SGt1blluYUgvcTZhSFAzNFZaUUgvQ2twODRkZ2ppejB4?=
 =?utf-8?B?cVYvbGZ4c3ZyU2VPOXcxbXpIK0w2TTdRV0VBS3JJcktHNGxmYVo3TXY4Wmsr?=
 =?utf-8?B?SXMzSTJiUGdOaDJWeTBHSWdCYjJLbFcvOGdqbE5mdWVaaE9QNXVEQ1R3TUUx?=
 =?utf-8?B?bW9idWt4NXZrU3dtbnZQcnBhb09Cb0d4SXJUb1Y4bytQU1dFN2JYSzNnUVRp?=
 =?utf-8?B?NkRiYWE1bjVnbWd5WVhiTVVLRmt3UTU2UlVWc1ZLMGprOHpqbjBTd2lFaldQ?=
 =?utf-8?B?NTNueGd5RVVTRTZLVldzKzluRjFHTVJVODYyUmtkSERvU1RmQ1NMUE5Ib1FC?=
 =?utf-8?B?UW1QN1V4ZkhaM1k1Y0RLWmN3cEZIK21hQVdwdThhcHBTWFp2UDliQk42MXhY?=
 =?utf-8?B?U3hmd09lZ25rSUovS2kzZ1k3ZHdtejRZd3Q5NUlKQVIzb0hWWGF2WWdTZWY4?=
 =?utf-8?B?VTQzakovZUZSVTdlR0tHOGRyL1RrYUcxSDBxVGdCd0pyVTdQZEZQRWdKL3oy?=
 =?utf-8?B?cFNMR1hIbzArRDdBR3YxN2xMdlN1UXJkVXNmZW5UdVFRRi8wTm5WRmNUbnVs?=
 =?utf-8?B?OVBSWEMySWVhWmp1b0hNNytNVisxTGoyRFFUcGhrRkJuR3ZUblprSjZKbURM?=
 =?utf-8?B?aVVvYXhwS3Mzazd5N2tkZS9YWHExaUxGa1kwdXNSNXdxSm00UlFaR2VKL3BE?=
 =?utf-8?B?ZE9TUlNKTi9hQmZnb3NSNk5LLzdDOHFFU0FjQkl5bGdZTUxlaXA1WVhIVXp5?=
 =?utf-8?B?cVJZUWJZc1hvbXpBWWVxNy9NU1E4dGxVeXlRQ1JHR1ZEVHNKUmlBSm82cTZr?=
 =?utf-8?B?TkpyZnNIUzE5UFBSKzB4QTA0QVcvWWxVRkZ5SW8rRGhGazBtQVVjak8xV1JN?=
 =?utf-8?B?K1h1NUltOXFTeUFLZnpGS1pMTngwOFlST3kvQWJHNXFPdnNtZnVYU1hlbHZq?=
 =?utf-8?B?cFg4aTVUeXZ0VzFNYW5DV2lmVlFhY1BBZ3A3dTJFSGpQL0c3VStuaUkvZThm?=
 =?utf-8?B?cEtsdUw0VUhaS0JqdmVLR1QzcWljSXpkR3FOQnFnZW1lNE1seXNnNUxUS0Qr?=
 =?utf-8?B?RWEvVnZkS0ErYmZIR1F1NmlLT1dDYTl6NEd5MjN6bEo3RUxFbE1MZGREbXFX?=
 =?utf-8?B?bWUxWkdFRnlBYlc0Y0dUbUVEckxtNFFtdTZTMWtmMW5KOEVnSjZWZ0tuWlQ4?=
 =?utf-8?B?aGdKQS9mS3NTUTlSVGl5bGJNbFZZSW9McU94bnVlRXJ0R0JpWjFLOUo5K3Yz?=
 =?utf-8?B?ZXM0Q3hYTWMxSStjREMvSFE1SVJBODgzUDlhZVp2TDM1UkN4aTd3MTh1MjdT?=
 =?utf-8?B?dFljcnA1bStmYitmYWZIQkhQdVp6SmthRzVqOEVHQTE5MmtXeDhmWGF1Mkd0?=
 =?utf-8?B?YUpuZlJ6WnhZOStrSUxGSGFtVjJKdi95S1pJZ0ZHZTRObWRVaVFWZEh6Q2FU?=
 =?utf-8?B?RGc9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 910577dd-192c-4cc0-2465-08dd0244198b
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2024 11:29:26.7980
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qw3K80pam0ceq8h7oW4kqjTpGc3Sa9t8cdpoc5vu+41gY8UbbibxvpfLlclkF5UcG1mp02LNsb3T6stOop8eKq0aoz3khLfua86nb0W7KbI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9428

From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

LINFlexD driver was working on S32 based boards without clock management
because the downstream bootloaders (TF-A [1] and U-Boot [2]) were
performing the LINFlexD clock management.

LINFlexD driver from Linux Kernel should manage its clocks independently
and not rely on a previous bootloader configuration.

[1] https://github.com/nxp-auto-linux/arm-trusted-firmware
[2] https://github.com/nxp-auto-linux/u-boot

Changes in V4:
- Switched clock management to 'clk bulk' API usage
- Added more context for this patchset

Changes in V3:
- Fixed an error reported by 'dt_bindings_check'

Changes in V2:
- Updated bindings by adding more information related to
required LINFlexD clocks

Ciprian Marian Costea (2):
  dt-bindings: serial: fsl-linflexuart: add clock definitions
  serial: fsl_linflexuart: add clock management

 .../bindings/serial/fsl,s32-linflexuart.yaml  | 16 ++++
 drivers/tty/serial/fsl_linflexuart.c          | 82 +++++++++++++++----
 2 files changed, 84 insertions(+), 14 deletions(-)

-- 
2.45.2

