Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2091.outbound.protection.outlook.com [40.107.241.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469388F4A;
	Sun, 19 Jan 2025 13:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737291708; cv=fail; b=Ise2iEfW9VwAI5UE7yjCKCC45tGT9G8y6FUG5mgsHnYUdTezLzNjsX47f/2+M8h6NvwPwF7sohn7BhQUTh59sv7agdaL1qo26Qo46Z+VupxmvbybdHa7rO9iczYrCnevECc4aI8W2+qe3HSu42IhlOYXw01x6PJjm7QXPSej7lI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737291708; c=relaxed/simple;
	bh=a55h0ljah0FKMy6gZH2dS1zFfUEKOL8kYr+6D9x1ldU=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=OWsUZ5ooPNCb/3HETTiPMQRdW8VlM7pKH76gCgxJQujedB79ulm9O7cjudbRq40zlgMK/2VPWcQuUhjxcZeK5idJAO67U8Phqotd4FSP5sssBxV/tu5fm/TltDXKVwkrhcMRoUoR9x715JeLkKg3u28GD5jrCjAhAHr9HpufAAk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=genexis.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (1024-bit key) header.d=genexis.eu header.i=@genexis.eu header.b=HnbnHhqF; arc=fail smtp.client-ip=40.107.241.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=genexis.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=genexis.eu header.i=@genexis.eu header.b="HnbnHhqF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qPA1bnFZuVE0Z642fAJ9u09aIqEwCVAGu5eOirc9pBZ41lMbCKIhGqK0eKrseEDGxnHI0Y512luEY72EoiydGH/82YWGApAPmua7iyf2eCoyR1jFCWfNm66hvDI2dE4LZZb1ICXtBkJ20U8hRX04ifGrtaor/sdJyv79XP0Ii7A3C4iXVaYrHw3+7Nndg6v84Kh1SDElNrtOTBrwJdr+IY1zeaosVsEeF3dEGip5Hp2LfFLRXfvwva6A9182U/EhJhL0m9ZdrQQHOXAXqLTnPTW1lIPNwEgSHAC2kNGIgGmTu+xc+uvaAsxv+c5lKpalgyjPl4dvUJzCr7tWGav6Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sPtzCr7dbwMRwhlKBpDwokdTXEOm8EJmxvdwWAngxGA=;
 b=wS0i4esVGhPgVRRzeLvusAu8XMFXNDQQ0y9NNbkM3PKg11drqDjuyAQ4L9Vm27Au6rDOtUZHDkLCWoihQHYS8E76HVtdq9Yy7TNDqqyyyVLn+btzfOv1rlO0QCrjtViiD31Vg1oEmnO0/UWkWTK1u3ZwpPcGdymkasDodE+HM55L1R6VWSELrdivLu4TkTI2xlZiRp1p4X84abjPMq9rJB24S+KEloGzFis4ieZpZS203cuXxQKjHeV6COhcpQdGvA8W010GJMfbtrHmMV5VpIP+mOT6IE+HSdFj3o7UQ9ZIYeoFQsdqnxzkV5s1f//UVlyqKbmxa22SbEdFeKpO0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=genexis.eu;
 dkim=pass header.d=genexis.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=genexis.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sPtzCr7dbwMRwhlKBpDwokdTXEOm8EJmxvdwWAngxGA=;
 b=HnbnHhqF77g+F3wYovM0BVJWRSUEZwiZFMCT/EEKkyChat0utQyUchNNYtm7+3PFt4ns0njXDWvC33JM59IxEPTOj+SXKP6okWjKgsogc1HBCK7jGPt43PmQvzua1SmIb993uePdMnXYhg9kVba1iE8Fh8FZvuvtcSWfoHza0yk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=genexis.eu;
Received: from AM6PR08MB4215.eurprd08.prod.outlook.com (2603:10a6:20b:90::16)
 by AS8PR08MB8326.eurprd08.prod.outlook.com (2603:10a6:20b:56f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.20; Sun, 19 Jan
 2025 13:01:40 +0000
Received: from AM6PR08MB4215.eurprd08.prod.outlook.com
 ([fe80::f8bd:a866:322f:7b42]) by AM6PR08MB4215.eurprd08.prod.outlook.com
 ([fe80::f8bd:a866:322f:7b42%5]) with mapi id 15.20.8356.014; Sun, 19 Jan 2025
 13:01:40 +0000
From: Benjamin Larsson <benjamin.larsson@genexis.eu>
To: linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: ansuelsmth@gmail.com,
	lorenzo@kernel.org,
	krzk+dt@kernel.org,
	gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	Benjamin Larsson <benjamin.larsson@genexis.eu>
Subject: [PATCH v3 0/2] Airoha UART support
Date: Sun, 19 Jan 2025 14:01:03 +0100
Message-Id: <20250119130105.2833517-1-benjamin.larsson@genexis.eu>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVX0EPF00014AE9.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::30a) To AM6PR08MB4215.eurprd08.prod.outlook.com
 (2603:10a6:20b:90::16)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR08MB4215:EE_|AS8PR08MB8326:EE_
X-MS-Office365-Filtering-Correlation-Id: 164fb187-6d09-471a-7ebf-08dd38896a0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|10070799003|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZnenWp4H570iMNWMS5CnQgcuJxUxrCyXNO1Eh5Yvd6vZeSXk60/H1sBcSChh?=
 =?us-ascii?Q?hGYwZQAfmnNHE387UipM1/YK4KX+k0Ig6VIVakA8Tjl1tLRQDw+yocz6N7BK?=
 =?us-ascii?Q?KM9gkH2Y39vCEKes3q6d0a05kZttdxjF6CB2gGwOyIypKQgwfVmqQStAmQv/?=
 =?us-ascii?Q?ayH421BnYGZMHEyo/5vDoFWN78Iyk6m20FO5nSySBP+OUgGmkimp39QcZYUK?=
 =?us-ascii?Q?AavbZ37yftvH8Ki4l4cbs3UgQgKLxPOx6oZUV4B8ZZve1xx+o8hkqxst67/b?=
 =?us-ascii?Q?bdDI/3ve0iNQ74c4KoW28X9iXgsBBs2v7qDvhizYgRIZkH7K8bzNdDfNUvYu?=
 =?us-ascii?Q?nx9fEv6wFSaGcY29L580+FBYxEsnC78MLKDpV70fkptxzzY2t1I2mpRCxCRS?=
 =?us-ascii?Q?3Hd11slZC1xFPyPPXuX5LXB/BgGa01aGgETnt0boPCLnJyo1TehAzngixqjW?=
 =?us-ascii?Q?fGOEhpkPNFch0zCs4Bfn0Tu58wCmnoEwREdVD6sCbtpLbknTtyQQNohTUBYk?=
 =?us-ascii?Q?bF/MfcTiWV4B4Ifnx7ReSA0qz0+CA5rcCGotB2iNeu7Bwqk4qa/iilVqtHU8?=
 =?us-ascii?Q?q/HM8DRM+j2ZjZXJUCz/8M6rTPHwkiXcgubnhrhgkb3dKu79ETjo0hEut3bh?=
 =?us-ascii?Q?g9+pNGOma30C1EAtYdSGixSAkB5tWYyq4Q3DRZQUH/EBG03X8jkjmOydcXKm?=
 =?us-ascii?Q?UOjhCV21+3A97kS20zg+Cyqm4xYHD5pMDjY5/MOJImmC39mZHA6gPefSo1XH?=
 =?us-ascii?Q?/a0UMixVB0mBSx7vfZvDd/c3LYaCM7hvtaEAXABain6UyK8qkVZ131kx0bzK?=
 =?us-ascii?Q?u17Mu0UiKEIHcyLjIMXwPEP/3E4mcxpy8LP7M5gcXh758ec7M5LIDs4z4EaH?=
 =?us-ascii?Q?JBnZ/sUrl6ux9HPQ9bSo+6PNcCjPhUlu5OdC3UULmfHcAI4z8IYrvtA/iCLU?=
 =?us-ascii?Q?G6CV6Vs6p8H6Ev0DfpsbQYAmOsrU+z155G5jJiRBX4rephnwjDmJkB2z6BiC?=
 =?us-ascii?Q?YrjdzOxpv7/KB8nakxZqg5cZUzmwh0XZYngFi7LLzoPI/SUPRmwhcA3Vp2ko?=
 =?us-ascii?Q?WLHdkHkfKOINo1vKWByYFVugKt87AGt3f6WX3dT45LV1HG0EVegDx30n0lN3?=
 =?us-ascii?Q?TTNWE500RHL66z1GQH9h5P6omEB5KHxvjTgEpzHkvveGrFZjmDBkQi8sEq7E?=
 =?us-ascii?Q?yy0FdcUc2hsaP9OB8KAnnbfvkW87/PmFowhtp6zo2Ui7rAENb4B8atCZS0LM?=
 =?us-ascii?Q?MnwNUPIChpkgMzj0/BdzX3P4GcbwJL1HVA9hWMIAb9HqC92UzwmVdW3WYUY/?=
 =?us-ascii?Q?ol2uXozMQpqyADwHN8mySWNdfSLrAxvjY43DjBKc+7klEkh986CsnN3DH317?=
 =?us-ascii?Q?WxpVXYA5F2jeEC0hvY7A+2MLeVtl?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB4215.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xGKFLE5b64llcseIj+3z/8+wxY4/0vLrytVzPMnXTnFBEPXAPCVpRpuj4wLw?=
 =?us-ascii?Q?AD1OUfllIJ03vS8iVO3e37S4M0c3djr/3ZuCzdNP/grxl9cM7/XSGz//4wTy?=
 =?us-ascii?Q?1++qClnYiqk9YaKF2h3hLqW6TOAALJnVIkfQNVrd6JgTR17Jwnyksr2mBNyG?=
 =?us-ascii?Q?YU+S6uUCZujUQjBYqaBg7nGCxovzhxztjMRZXT8jXAZopk6oJKtfSL9jQ1VM?=
 =?us-ascii?Q?pgv01p8r8u+n2bR+dh5ia4FyXto6UXT82w6f2B219iZQ4LJsamabPzhQVNU2?=
 =?us-ascii?Q?9FZkkzid09EBxZgHfrbWhc/+v4MEqOa9PuiH5daOUZvMW4sNBahHlGZvKCOG?=
 =?us-ascii?Q?DG0zjvpAj1r8tLYAu1JryRRIJBgaVhw2HpVDRlNEurfX5p46H80/E95qM50M?=
 =?us-ascii?Q?GyECfdYMIs2aGlefqVcBCWXkjh72SeC/VHM9FjNG3XkRmB3SQnT8Di2GtRWZ?=
 =?us-ascii?Q?+RDTxq6/IWZ0PdYr/ZcqT87zUNHXXl44OQm4Q40uuYLJIQbBjSubB+dSZ5gD?=
 =?us-ascii?Q?PJb8heFfDnDLErD8kXV2FvmvvI2OuiFtsD3pCguwdXmGu5pzcs3m3ROdAUvv?=
 =?us-ascii?Q?YwAy99exXHoXp0dUwcRXyseSxamueIV41ufENfEI4xFKYIN9A91gH9MGgzNf?=
 =?us-ascii?Q?Ha6svgAhzho+HwB+n/BvuuPov/WjPMgX2XyubYNs4fjjfB3OiPrF3e5IUUOV?=
 =?us-ascii?Q?V3goNvw3Im7XEBGb3lzJMO3dgNZ26rQmYdAEnJNEMgON40Wol/C+0heANVmn?=
 =?us-ascii?Q?BejcbtZB5GfR+GMAMk0V9QEy3Iy+R6x2f8A1waNsa43zs4JL4C1d6p/Inqk8?=
 =?us-ascii?Q?WdWO9H8YMxZav9q0FovsK6V76+jH3zSvtcz6DpvxstUml7WFXNOzrZZI62UF?=
 =?us-ascii?Q?QXlfmyDQaDyB2/ZW6PAxfj2HfYGCa8Ku8OTlF7BVSfcj8xo3JACvTSRDqopL?=
 =?us-ascii?Q?8cnc5db2bho31B/NcI05kX7jBM08wKFhkbH8b0fhpsUz8PB8VEsgM4VwZ7Ao?=
 =?us-ascii?Q?n/FEDkTcKC5s5sNmpGuzjkSMUZGMxKIScYZvaBSIvsxCUZET6i0EH5f1oo+M?=
 =?us-ascii?Q?s/2s5F6Uykv0SGwTj4PjnLsfjN7qdqBPPAU7UyIWgRyy3ALOUvg7rianCQSJ?=
 =?us-ascii?Q?kowkrDS1/TpjIpob1k3Mw4qndRtAI+eb4aohl+icDqTrQHjhAs+Q7a7dPVtb?=
 =?us-ascii?Q?Hee+AoAjec8aPaIjk3pPw0m6eVHAKTeRJzwgC5wgTSTbGt1waP7k++1CNt17?=
 =?us-ascii?Q?SzoTC3xNQzxRE8WXVWgeMf0HyeLJl1MeX+k71hUfqs4lkHUs4t2TWyYUUkDX?=
 =?us-ascii?Q?SqACv9vHgpc79g/wmfYULyqTgtTwPeSNwZr4zhMZJw+NwAQzU2k7eBEpwxNA?=
 =?us-ascii?Q?H3yg9rVmmkqsZ2TgIaG4O7XswCPN6ddT+4Foad/eltK9wq3MWEKGfsMQop+X?=
 =?us-ascii?Q?Z32KQ+Ol0a4Puj7HFT4PZ85ENs8yeP8BmPr9Leqh+q2ZbNy9yNhyNyyVjTy7?=
 =?us-ascii?Q?nUGjf67TJ5jKNljbaVxJ4laAK3I1BfbZeQ1KJg4JyUnUv0XkTZsJuzHtqM5z?=
 =?us-ascii?Q?iAumPn4aJvFnfcLQ74nL11NQORpDqAZPGUdncbNfInkC+05wdpUYGZr89AwN?=
 =?us-ascii?Q?hQE6EUdzzzbrXg2vsJb0wI49dizT70B+Mnu6CJiCwc87xvPMeiJMe+Whmowz?=
 =?us-ascii?Q?/R5INQ=3D=3D?=
X-OriginatorOrg: genexis.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 164fb187-6d09-471a-7ebf-08dd38896a0d
X-MS-Exchange-CrossTenant-AuthSource: AM6PR08MB4215.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2025 13:01:40.3244
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vr5gjCkR/omnPkka9WIDjy3Be0iMNtUYNSN4l0REwTkg8HMNlVtSGzEM6WW5wvu33BDSh8fS0odB7gkEByMRNHPNPWHgRGbd5Ga+TunZ5HM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8326

The Airoha familty of SoCs have a UART hardware that is 16550-compatible
with the exception of the baud rate settings.

This patch implements code for calculating the baud rate for the Airoha
UART and HSUART.

Signed-off-by: Benjamin Larsson <benjamin.larsson@genexis.eu>
---
Changes in v3:
- Reworded commit message
- Restructured comment text
- Fixed kernel-doc warning
- Fixed kernel test robot build error and build warning

Changes in v2:
- Removed ifdef use in .c files
- Removed uart port defines from user-space headers
- Reworded commit message
- Added code documentation

Benjamin Larsson (2):
  dt-bindings: serial: 8250: Add Airoha compatibles
  serial: Airoha SoC UART and HSUART support

 .../devicetree/bindings/serial/8250.yaml      |  2 +
 drivers/tty/serial/8250/8250.h                | 15 ++++
 drivers/tty/serial/8250/8250_airoha.c         | 83 +++++++++++++++++++
 drivers/tty/serial/8250/8250_of.c             |  2 +
 drivers/tty/serial/8250/8250_port.c           | 27 ++++++
 drivers/tty/serial/8250/Kconfig               | 10 +++
 drivers/tty/serial/8250/Makefile              |  1 +
 7 files changed, 140 insertions(+)
 create mode 100644 drivers/tty/serial/8250/8250_airoha.c

-- 
2.34.1

