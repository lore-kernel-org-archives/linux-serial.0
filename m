Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013008.outbound.protection.outlook.com [40.107.162.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993818633A;
	Wed, 12 Mar 2025 02:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741747159; cv=fail; b=cJZlaft6SLX184P9uizfXHzn8lXGQT+14FGQ3wokqYQKOToVXdLCVy/Gku126Jt3aZ3OTwp6KN4Wf+ufTPge8r3fZ9O3rZDXRDkZijvtWema/FlnGJ2U3BLKiC2FftZ/A8CqHWG0bLG5DrEo4uhYTr+l89bDI2dWqSFMfugM1Ds=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741747159; c=relaxed/simple;
	bh=pRbOF0A0uyxxkHib5SP9N7xRvDDwsU7tZWCrbla6PsE=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Bd1VyGAjof8TF2q/rM0AhSivCloZAgZAdYjJjRw8GZl4m4BGODM93HZy1tMAqq8Oc/8UI1lCpIZq3wplrhHk44vtwLysZMuPpiSf6dDu+msWir/o4+qOqTh7yFWul8gNuLVt2ZLwMMpnUzDEqV/u+dhk6jzCvlkI0D8HzDI2edk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=fMa1bZ3L; arc=fail smtp.client-ip=40.107.162.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="fMa1bZ3L"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cmdMad9IUruPelV9VHb0YOTvPgVhNhg+17CgISCc1tRncLYO6C65UsBER7rouWyEbukTYuBesBBjx5YhXDiJe/1/MT7RafbcsobzJrBFX2b2oejq9alOhXdqVeqe2OO/rbJFDSJzB6vCuVtAfayQrJdwG3UFoaTWvb5Fp+thzcmNsGpNw8o5oh9p9u+bfg7ifDIUREIuEnU163GxplP/TtVPoxkAWY9CJehxRfJv8f7oBAnxlEtSRASJQfhiX0cEKEfxgvksLyl1N6RlCXyqcaFXgulvzDmneVu6FaTMsn87TijGle7J/fM3igZvS8thfer2BinHMB8ARNaSRR6i3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S2gUBNHVndqk+oRvVeeuVkfKp0+7epifJo6vUzEG5Io=;
 b=oXxqvjXiuLaCm1wk0V3pyQGyTNAxiW5ttYglMDWqYVkFdAHTPNoiT83obQhpIrHoVNcve/7YTp5ZyFblQXLcaXD70bPtC4zWSxIuY8V4HSe755a+ankINUyK6YsDdqjjg4P16TDOB+byMpxX1uh8un+0vtGuOBZEtaSkx4kBSi5/Za6+MWVzJc6OkZ2KDEayuYycncG19DGm6ADSMkKv50eIjDY9uYb5JJs6+aaCFJRiwSnEO6KF6YF5DrDD/p0xKuHvHod6Cw87hgvBL2JNmEneV0qo28gIz6Fuo2KDTKQA+SW6oylBUeKRPc/udCiF6FDf/YvkBfuA1HmYdW6WHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S2gUBNHVndqk+oRvVeeuVkfKp0+7epifJo6vUzEG5Io=;
 b=fMa1bZ3LBI/b5sk9Luu7aX02nnSlzhDzwXURbRRvSt8M6KwXHPr2xl5tdyhtLmM2hE1JUCJ3Y4nGGlau6KQJq26Y9GSeLBWlsfTrDaO7QDglMJhp9kL7YSg9o6gLhm3PiHdznG8weAms3tPYZpuc8Nv/lmUAta6RoIqbRhyH++PIpv4Y2Jf8O1tn6UxkQMOlGeOV9tHiyEdLGdZuKGVC1kaM7sKH3zg65VwaRbs7J18QDkvozMps1Up7y2av2wfUH5ap4fk8WV4Uo7HLtPQV1GGqe3mcqhEbsiVNhcOWZ/E6mIIEgemplXhP1oBLfZR7Cj/G598L3rmgwE7/7Z9gog==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB8429.eurprd04.prod.outlook.com (2603:10a6:10:242::19)
 by DUZPR04MB9794.eurprd04.prod.outlook.com (2603:10a6:10:4e0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 02:39:14 +0000
Received: from DB9PR04MB8429.eurprd04.prod.outlook.com
 ([fe80::2edf:edc4:794f:4e37]) by DB9PR04MB8429.eurprd04.prod.outlook.com
 ([fe80::2edf:edc4:794f:4e37%6]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 02:39:14 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	shenwei.wang@nxp.com
Subject: [PATCH V3 0/3] tty: serial: fsl_lpuart: cleanup lpuart driver
Date: Wed, 12 Mar 2025 10:39:01 +0800
Message-Id: <20250312023904.1343351-1-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0037.apcprd02.prod.outlook.com
 (2603:1096:4:196::8) To DB9PR04MB8429.eurprd04.prod.outlook.com
 (2603:10a6:10:242::19)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB8429:EE_|DUZPR04MB9794:EE_
X-MS-Office365-Filtering-Correlation-Id: 407ba67b-85ce-4755-01df-08dd610f13fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KcZenZsmdPwaIAj8hHXMTaRMxLA7mmK3hvFSPS5kiJ39cp44vaP4Y2+v62eP?=
 =?us-ascii?Q?jsuBDsEovktD4leUr2jwzVVt2v4yvpAfOz1FaJ8zSCXfe1vOJT0xGdcoJmyS?=
 =?us-ascii?Q?KANKUIcsvRblyrF2f2HKBfGzfrl48xeSsnpdH2JbYUzXMKrKPgh0XFdnLZbd?=
 =?us-ascii?Q?fB3loy8WMwP++Jgja4ZgenjjzPISyCcshFwKZo1Tjx7R9PLOqxa3Q9KKzTwE?=
 =?us-ascii?Q?51Q/qZE1Yha2fkN1e4q+ELYro2plcq77m1CkA6fA8F+OZy+93Co/u+r+sObY?=
 =?us-ascii?Q?lQvXLnenPYNGbu9tBR7ej75yQmMeIj1y3v5FV+q/1f+BBhd88ecO40fla6Xq?=
 =?us-ascii?Q?pQa4Xu4ogEO4l5iqs/lgomXaDO4A8rr3VFF0hpYTNJm9k0kkOckilV4AXm5T?=
 =?us-ascii?Q?DDBTiqYEBZ6jOybKAHwu6g5OEcwPpEwD4K6o7BxFeM/J/MNjZhidWiTXZWbc?=
 =?us-ascii?Q?yMDjiqouQCdnNSDslGHbl8xqZPCukf9hCrKYfDhnqpTH4L3MQ4IxL76wM5uS?=
 =?us-ascii?Q?hSN5S2whNCLlfsl7Hikt4YT53PvSP5nmoV0+0OLMNqER8r1LqK35shGhjsB0?=
 =?us-ascii?Q?OJsYEVb25soY9XRlQvb5FcyYE6EcSbbyrj194CVOMagqnW+/9V+KczHZblTA?=
 =?us-ascii?Q?jAAPko6fSfXaBs8zk5331mh+apFY0OHY3Sw+OO+fxAKSnE8Xs9MatHW2ZbjN?=
 =?us-ascii?Q?owdKQMTjjZJJ+vixMwdiEIwjJuzX80djxk53SDhAwm0+AQShroMONdrPRKDK?=
 =?us-ascii?Q?ZKWq6Qj/oWjSP83Z+cke6gMVINSZ3jKRY9/yt1yYoGJVdehXyyzPisffP+mu?=
 =?us-ascii?Q?oFkHe3lX51GQRnyrayMtOqLGw59xROLZvvQyZk55AixHGHqWzvZbWD/4HMKU?=
 =?us-ascii?Q?Q16ZrTdDSJTaZB69x1VXsejn0JT86MJPHTI4PbxhWX4Z0GChDZqbGP/mUiWC?=
 =?us-ascii?Q?y4hHeWJFV8zk5KqbCNwvw9DS97n+OTFWmaFfAtmfIx8WfO/5rMTAXVa8C8mJ?=
 =?us-ascii?Q?s4Zh804ZQ2NF34+rqN/HujP3GD9kshx6KPO+5Bd+Cv4ayG2E2mVymjzqH3IG?=
 =?us-ascii?Q?aqPAmhtFItWzpCoSpnzr110t7JP11IkdVjqlvqLJ2qsBrhfV7GbpJBw/zY5L?=
 =?us-ascii?Q?8wkgwEQ4AghEB0au5c1dmy2uOQPFvsWyUR0Cahtd4Cru/6dCyh4bLu0t/+jP?=
 =?us-ascii?Q?aqPyAN82haaUSwG14t/hLe68tmq79IJOenxjO5qSywXEhw85kAji4byYkK1j?=
 =?us-ascii?Q?VC3QFRcut7sXC8JD9hXajGZE3rLTtfeb/IvkNsBMzwENxobL7Zjvt8kxeutd?=
 =?us-ascii?Q?fT66s4Zw5GE1iP5R9HwuK6MTk2DwhaGtbRm7FiI+2LhWJf3Enoys2oYK1Nux?=
 =?us-ascii?Q?8XDcz5aKIpwUV5lmfMXix7rQAHWA/EGaG+on5/If8UrWxWh7+CE5bRDS9rP1?=
 =?us-ascii?Q?OWqQzWdvsyeG6gK6Mr2EuZ6A6BNJzqqi?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8429.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ymqIeUvSutepulejPzhuWTh3DQ7wVBh8upMvVkhT4wU6GLDuTLSlr3cIo9DH?=
 =?us-ascii?Q?krp7wd0HvpV0EKVP+rTYZN0Q8vajqqBBs/YC1H7By3Hu4mXeiVWXXyRSvq8o?=
 =?us-ascii?Q?EOzEjmb7EB3rgy0lq7B9f63VqNLp29crkxkNwjXdStsQXGH2sH28ZScbaT/E?=
 =?us-ascii?Q?mXKtm/zvpZfCBZRd2Tb9oVx9Hbm+pxZeJ/pTG+3hP7eNAF4jVHiIwdrIsrEw?=
 =?us-ascii?Q?2yQ+6ldKNWohpUFEMErah9tiM6esCC5c9OfiOLWBunddvZyGQ6Wp1LwKOiD1?=
 =?us-ascii?Q?sIdtclAE4QbM4YfHTWnfQ8Si3JhJshik685JxpRZut0oBJ2bxX0opC6YOl69?=
 =?us-ascii?Q?4G0IxWQLnU6RNI7jUvYOq0FN7McrRSGyHju2QdXFH1hzkWGiN/0nF9mOr+zq?=
 =?us-ascii?Q?Qni3Lne9Jq5qMjAtIqa9283Hb5FpozhOCcefsjjKvf+20tAnv9Y96+VUv3lu?=
 =?us-ascii?Q?nnxe2vjKbn5F2N6b2snyTseowDM3dRjKnGIr3PrV5maaS33HRsXByankF1h6?=
 =?us-ascii?Q?Tjai/53yvhanR5vgrhKMlq7moo+11QmI9GHde9ZE7RaDCA8mJh93EGpAj13O?=
 =?us-ascii?Q?c25Xj6LVS7SJm6ErTQqpQNZy95ued3UW1ltOTOC9iOF2I1BFH+FDJHTZ+K7r?=
 =?us-ascii?Q?OZ5ZymVIpxHrlacQT1eMxVFWf9Gg1BbjjbjPXH+gTTTemjpKzcsNmyxLxCsD?=
 =?us-ascii?Q?3LV0i6dQKZKSyzYgUWAf7suPhW/T5nvr0MfrzQG3rrrLi9P8Ydn0M3LTF9rB?=
 =?us-ascii?Q?ktLmrndKoVKxItvbHThD245NvmauT5qn2WiAMGwV7g2gALxAKei1rFsAfa/N?=
 =?us-ascii?Q?+fVIjOOEs8gMaNCwBCVNpoAeuaSFqvrnPVCVrXBYs2Ykms+0p9yAshoYeJ+v?=
 =?us-ascii?Q?jHBDjc7P1FfuEEACjotOmlgjXM5GucYOFDzoDa8JD0P8vinZD3LP5ddnBAFt?=
 =?us-ascii?Q?I1e788f0F53MQuume2a7CEpNxDvp0ErLBdkoNG3bIyyqDENFGktijSGCP7D+?=
 =?us-ascii?Q?64V2RmFLsZjubFJMDgaWPqPrqHUpiNS7LBkLIdcJob99SBDVB3x0oERV8kw3?=
 =?us-ascii?Q?Pwynwnv/GJGGybbv3lbMKMewHLW1BczDj2nr/mInQ4jlQM77PgaMB0NXD63e?=
 =?us-ascii?Q?cJv8SwmSPmwnYeWh2M0iAtrR4Fvg/HxWtrzd9h5I0M5An52pwqcjL6eCff69?=
 =?us-ascii?Q?MSjbaUBYTRN++Z68iH3Kuyv18WX97Aj+kuj3IypOvdBxdoGPFWl1wUv3OIOb?=
 =?us-ascii?Q?DvGxMJnSTChfcP1Ez2wzfNklQ7jZ7uEDxs3bU3VpND76CpLSDdc1HhGQ4WSX?=
 =?us-ascii?Q?+wLA4IiTVgxJarjZ9cek9uPmIc1jFVg+zXnI52GuVF4L2s4OH7SEPBHY+zf+?=
 =?us-ascii?Q?TVih/7PnM+fBaeSsUrgVbAqSzV5Y7LOQ5Yzh1RJVpZsi7ablSj0asTQMARpK?=
 =?us-ascii?Q?gkktK1be1592sWhRPxuYh7LWHLDv64ub/8HDEUW1VacbgByOgyOywX4jjJwc?=
 =?us-ascii?Q?7C+pcXln5jDtrbGYkbrvVZPtP3chLIIJx/agAjcVpltPde5a/SUxX+3B6AqX?=
 =?us-ascii?Q?D7iWOVET2/4HuhqDoetai/euAbW/gvqJ8HHG8SSj?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 407ba67b-85ce-4755-01df-08dd610f13fb
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8429.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 02:39:14.7281
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r6256743gMOSlpr2j42Qw5jCABWLBSNNyZAdIGe/jgVeoV5LG1zCDu9hV48oXJC6LOs2u/3U0BEkHtOI3l1Khg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9794

Do some cleanup for lpuart driver, no functionality change.

Changes in V3:
1. Add the change to covert unsigned char to u8 in the first patch as Jiri suggested.

Changes in V2:
1. Add the third patch to rename the register variables as Jiri suggested.

Sherry Sun (3):
  tty: serial: fsl_lpuart: Use u32 and u8 for register variables
  tty: serial: fsl_lpuart: use port struct directly to simply code
  tty: serial: fsl_lpuart: rename register variables more specifically

 drivers/tty/serial/fsl_lpuart.c | 469 ++++++++++++++++----------------
 1 file changed, 231 insertions(+), 238 deletions(-)

-- 
2.34.1

