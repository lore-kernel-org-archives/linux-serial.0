Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013068.outbound.protection.outlook.com [40.107.162.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51271991CA;
	Tue, 11 Mar 2025 03:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741664209; cv=fail; b=gbnJOvetU6l11Kw3eQIVk4wtk1YrV+jAOPiYcJvvzDRuqUJtHXdMYjRRoLBojlgA28l4OTrdu9VsURu+EwdDOf2v1sHdLB50D23z9E792vg9dp2dr2AYK52UhZ9Bu/m8U3EigsrEMhok736/NZ3tnF2VTjm1PygFgP9Y7IKBCxM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741664209; c=relaxed/simple;
	bh=lvt1D6czqwTbc7gALC4AvGBAw+JmnlGug934ufBlmBU=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=ks5aFaSDX6G0r8i3iGUHs7Obq6WhtgtGHpaVgF1/dYrlHRdwOdEk9NlaHJp77nP62o/GTGWSnml0GWHXy9BGKVOF+IxQIt3PGkA8H0Z3ulDV67cm/dHWD9orCyyuLDGgNh5x5GXBmeuTvRys/yhdRIcn0kr0NlculHjD8+NQoaU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=jDcuYOzG; arc=fail smtp.client-ip=40.107.162.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="jDcuYOzG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cgqbHXSBJw4uakecDrJz3s+hJL+dFk+RFYxboflbqT257yhTe8Vt6xez6zeKWc+Cm4+Bhts4n5PQys0UEjht2xUQfkhIItkNFeSdJ8Bo2VevxSkVo0C9pqvq14Zu8LUU+kuQ1u7bTAK/b+ng0klQj4H9J0btecj+jreZAHbaHKaORMEE1vFfULprQRVt2VB60NeFlFj0T/58jmhmure5Pz56Ahsvnisks3xYSBqyjx3RdQ7IdaIfhRU6htkbwrbbxBbxAkg6lauwte9K6gH4wlTXpA8xyLJAxn/oB8TZitNYZbcSe9JHgEfh9PQHS1tryEoC670PYeDDI4F0i7cDlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T4iI2DGU3oaO6quEmx7+w7+teTDKWTjOXM6RDbssWns=;
 b=yrkENrrPlZt6tTGejCeNagj5pQvsAx+vLZHLp/LJ9g+u5GQn2SVDj15hKqqZwECIMo+AdUnHDj+76ArwvuMSy1raYedJqG6TctF463W9DqsfREin1PBO+rkm1TvXwn2EPlUw9q9Tqb9LQMjmgnoOUa0E8WXu36kLOq4jJqInGUWoiRztqunsAgnOm4j0Vp9vSy/lzJJaRy3jU22ZnZ/m03gAGPgHfuRtlCUuwechyrM0/qOzsXX6hlNk0H4xMVocsk5kLsgySuvhhgL4HkXWgCOp7sxCuWJH7CSu75Xt+ZzD4mXym3PQlqUoY17ONlol/S7M9bH7KCeG1mLjaYdABw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T4iI2DGU3oaO6quEmx7+w7+teTDKWTjOXM6RDbssWns=;
 b=jDcuYOzGsQSePc1MsAIHuWiV6csxNr5fGC7ehdqBWVsg131h5qtK09O+5EguySpPBByGheW4hqQrJh5Nek2WaLRGEwSM/ij17ZFJSCLP4xCY8DBb/GZIyS8T/0Ep+eXTa4YDIyAEpha5GNinvoSBCbFtuCLb2cucO8z1jNg212kxQ3MqKS0SQh/5tyIaseBkmqresr0Z1nUXx1rnrZcnOfjpXSMXypnNkJQLRgT6rLj/OOSdtL3uvC/hTiR57bojsUBECWOMpNroryyEF/QsORqA2xrnMqlU2hSPxFz+ZRQUQ6FjeUwqj5ZUi/c6tHXkL2LUtZDLfEpUiHY8DhT+VQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB8429.eurprd04.prod.outlook.com (2603:10a6:10:242::19)
 by AS1PR04MB9480.eurprd04.prod.outlook.com (2603:10a6:20b:4d6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 03:36:45 +0000
Received: from DB9PR04MB8429.eurprd04.prod.outlook.com
 ([fe80::2edf:edc4:794f:4e37]) by DB9PR04MB8429.eurprd04.prod.outlook.com
 ([fe80::2edf:edc4:794f:4e37%6]) with mapi id 15.20.8511.026; Tue, 11 Mar 2025
 03:36:45 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	shenwei.wang@nxp.com
Subject: [PATCH V2 0/3] tty: serial: fsl_lpuart: cleanup lpuart driver
Date: Tue, 11 Mar 2025 11:33:33 +0800
Message-Id: <20250311033336.1254842-1-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0019.apcprd02.prod.outlook.com
 (2603:1096:4:195::13) To DB9PR04MB8429.eurprd04.prod.outlook.com
 (2603:10a6:10:242::19)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB8429:EE_|AS1PR04MB9480:EE_
X-MS-Office365-Filtering-Correlation-Id: c765d30b-40b0-45a7-1928-08dd604df21d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pQIbNQ+SZ4pi2K2xxYVwyYeC6NzwzTS2yXB7xKvrb30E9e2p122MOVl76fzO?=
 =?us-ascii?Q?6RDwm+YniPj4MKbZuDfsgaXBlJ0B6PeAGvYXL+Cs3geaS1JagleTsCIQfpkh?=
 =?us-ascii?Q?rwYCJZG8eQkKmSak3VGUaBJHTHho/77meFU5pU5PHM32Gy8TqiZwObFzjsnz?=
 =?us-ascii?Q?/s4PkQuYaO7QINGCquFSndQS2wAMIBjuJ+Au5KdVMwy2TZYrDbDkigMzqhER?=
 =?us-ascii?Q?UbBFdSv36Oz/MBB6ywLZTqZCM+mHngJUke3HhPCwFnFLhTAAZUqh4BPHLu7t?=
 =?us-ascii?Q?kH3Fp4KgzB0lGogynDDjQp426ciXAOl9uwGmac89pQ/xd9+9UUX2M77oA04X?=
 =?us-ascii?Q?HxYx5/Q9CaJceqCHeIY1Oc/Bv1TkHXXuLW/4aHB4YT+itRfzC80J/hVYpU11?=
 =?us-ascii?Q?NO6EnvjYKXjfNB+mDeGH2gpORZZpWV0C2mV679R/tRDJAK68G1oRFvLYieB7?=
 =?us-ascii?Q?+dtOS6ILC+aIe/heyOregSy1J/NbDXlg4NsXrjj7U9chdEHgy1Vcw6d/ZReD?=
 =?us-ascii?Q?g6+PpkdVwpJZYtVIBmZbub3JYuKkOgSqpzSuhOZdtl4RnwpEwG+Y5pS/mGia?=
 =?us-ascii?Q?VvUr0PgJH4XDEs3aJXFIS2Lj69Rydls64lEig6FFOcf8HE5HACzw/olNBwGd?=
 =?us-ascii?Q?yux+VXLjPiwUZQejP5aPXbonjLl/SLaIpEWZ2WRSZFE3Z66amHgaRg9iQw5k?=
 =?us-ascii?Q?CUpmEE4CBsOyZxoJZslZPlnuY0ifA6aaojk+odUlwv+pvmmNv/Xc8462X3UK?=
 =?us-ascii?Q?HOyP2wlsl0OfOa44Pca30DS/j4xR+KBMR7S6LMlqh4szpT+IQQcOsq1czuPh?=
 =?us-ascii?Q?dr4o7Dk61zYKUmiJKZr3vUH9vtn/W5PPTJYieoXxpqBPQGVpS2fJw9l4ZF2Q?=
 =?us-ascii?Q?lGdlKHba6I0hMnLv9y4ICEwoMcA2KMleqtpHgBX0zEESc4jVH9+CJcrRlixD?=
 =?us-ascii?Q?p8hzZBHIcsxxmacA2fSz0X+iheci0z0h7gOzw+yY080Luqmc0bMnO/SEnRC3?=
 =?us-ascii?Q?pO+pdM120edOjUKsAY/mltBUNZm20L3xerZZ3axe94KGs8Gsf+iN7QrikBB/?=
 =?us-ascii?Q?tzl1GqeEo1OT8BwB1tCQjMp8NBu7L0ukuEeJ9fu/ZuT87WbbAYpRCbCXYG4N?=
 =?us-ascii?Q?RYx0DHtcV0c0m6dL/usPw+nPVRwPj+9YwgccQOQxjjOAtvYUhL1mE35FY7Xb?=
 =?us-ascii?Q?DZNw/cBePy0CgIJEi0+t0j7F4uGygi5bhq0k8D1BiKHuhdo/dRyyLJvU/lAa?=
 =?us-ascii?Q?6Phm7rwIPc3ixPb8qgEy71IRoR8pIQ6vHcIxSUX+zguv2+dqXco9qYceWHMb?=
 =?us-ascii?Q?+gQvK/WBbrHGWy44K72iumOBmGE/kIR1pOQ8C5kIBl845yFrGu1FupYGgg9o?=
 =?us-ascii?Q?NlXKTpv6uK3ojXtTNIlKjB3/4zbBmfY+glKA0eiVwwXgNKwkF0gsKubvJ7SE?=
 =?us-ascii?Q?mEVO5n1ks0N1f6QomADX7XNq28eUUblk?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8429.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?efuivUUeW59uV4IY0uTOup5twKPzcDLuHQNuRpTWJjFgu5CwYoP6scpZ+lmT?=
 =?us-ascii?Q?OCj0Mcv1osWAp+MK2G9Xt482otWizyNVoHBN8tSLEsvEMXSszMohjQ2UIaFB?=
 =?us-ascii?Q?trj09u+nNV60oZba4TC83YHKyrcEySHLF2gGHS/IQvGOz9R48Lt/xefhZ5vf?=
 =?us-ascii?Q?knJScwi5qkjHrW0Rn3IRcSgkn5BYiuvh1vitHT1+qV6RVOmRLYlbgovYGxuH?=
 =?us-ascii?Q?bVKMgAiqI+26aAWOlRqPX1xnVkfzseKR6SONWe6AvKhN6362lOhkcWYctOA0?=
 =?us-ascii?Q?Cn+IEOIGCRJQNqLoxqh8NElkiqBWGmtwKDc/blUZAknq80Q34cIwzeZESnPB?=
 =?us-ascii?Q?IKdz1Ix961TUuhQOgz7S/yLdAipVwEqM856gvTQhz5fSCWYn28Cb5oHDRAeK?=
 =?us-ascii?Q?Kk4abBsRSBInLznpLS01OMY7OQRhoF3ml5zPz8oDIvPPRi70AKsXYAi6GJL9?=
 =?us-ascii?Q?zbWZLhuqSzujfsDNouox9Ee7cXKYINSS6Mj1KRrqSxx2s49gPNCqIHABu9cQ?=
 =?us-ascii?Q?87h4Zth6E3f6UuRCAXZ/1XanCobcFd3e9vYt2KtpgBOXWVqr5YrCqSH7wA6L?=
 =?us-ascii?Q?UNY0RU+x7ScYQRCakGdqqKYycV2otuMtv6MupP2VkMg6cvLMyVeuyyofoaKM?=
 =?us-ascii?Q?zXm6jXFiETeHAAEqy7SsoSnfiNnL/UWfxzqrMyDfAiJ+zY6UeRRQLtgLY9e8?=
 =?us-ascii?Q?k2QVF9WB+NsWRlM8zzinGlachMMSfNLTIiFvSSfBIQxUOiywPdPB/BoOdzfY?=
 =?us-ascii?Q?uK0yvrYJHbYgHMRQV6oex8U5trk3w3vMRMKoAXmuMfJsot0r0sIstPVlKpaA?=
 =?us-ascii?Q?Fu8BBVKHEUgMdDDAZrC1Z3zum2TtDiMIrbanCskDBG30kYqs3voss2AZQjRU?=
 =?us-ascii?Q?qmCrHHnI51kATwshTRF8wez7f6KT3cAGM2oYfBiqTqtQI4bBu82CdfHDBmjB?=
 =?us-ascii?Q?b6QE2AcX1ZhUvlFz7v+QA44iCpgp0mRbzOUgPSy85/Xr/PWi/fGMnKjCf5a7?=
 =?us-ascii?Q?rgh5lloUPxNf1UcsjiTzQl3sJacBXmQf65vtl56ix6iJlfaxE4Ot+fScEb+p?=
 =?us-ascii?Q?rtY3+kT2JyuMZwpkpEH74OD4uiezWCh8vg6Xfi5M731vCcdyXzBcEq5P3E6U?=
 =?us-ascii?Q?PKkgRqbGgf69ddZvDWlRXSpqCyUTpILVJvTRC6ERhHC0VCkUbgoAUnKIRwUC?=
 =?us-ascii?Q?7GrIoV6U7OLhqCZ5enfa/dbqp+tLuscAHAV6xxat2oK1xpHVwhZG+u7HbKRD?=
 =?us-ascii?Q?P/B+YtXF5cP2yDYCzMMKi6yeaNj7oPTZ/aVxNPHAcZ2SmLaXxRgHhCCJjRR3?=
 =?us-ascii?Q?1lqbL0V9+uB9wT/+gTUy64PEa63LFZED7JV9b6A7uH81itMPuHfIyivUW/TK?=
 =?us-ascii?Q?SW9siDIib7xwZquf68nS/SKxqVruHz6lbK5bcVNAi8dgQ0YXip/TPlFH1Yh6?=
 =?us-ascii?Q?EbQ52Fu9K+lYkxWdJmcKglOSSFKb13Ac1IHHLy3YeWTIHjM/w6JJma+R0JZq?=
 =?us-ascii?Q?bMAdQm4NXgEGlEyExcrL49b5UVIMkvJfrLQojspiP9bKl2uWvxQKjmaIzkLR?=
 =?us-ascii?Q?WAHHirdtCCalDkAWOu5kP2fuRODSAqj1to45qgF9?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c765d30b-40b0-45a7-1928-08dd604df21d
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8429.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 03:36:45.0360
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G8Ji9E2F/6ySYntYSO69WEI1qdCMJuPAGoitE3hOecwoyCzS2oC/GEigm18Fe2vUs0DV1h92k1HlNfPNLY9CvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9480

Do some cleanup for lpuart driver, no functionality change.

Changes in V2:
1. Add the third patch to rename the register variables as Jiri suggested.

Sherry Sun (3):
  tty: serial: fsl_lpuart: Use u32 for register variables
  tty: serial: fsl_lpuart: use port struct directly to simply code
  tty: serial: lpuart: rename register variables more specifically

 drivers/tty/serial/fsl_lpuart.c | 446 ++++++++++++++++----------------
 1 file changed, 220 insertions(+), 226 deletions(-)

-- 
2.34.1

