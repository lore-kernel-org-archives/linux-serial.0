Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB2F16EC19;
	Mon, 13 Jan 2025 23:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736810595; cv=fail; b=kXctWSgptWRlNDNMXk8A6Hh52tpLlk638SeGFyJzNoeRw/+QZv4gMx8EhqF1Ki61/MsTA24EZOozLK7E5T/3FwGBughsWGesVp7+TZkykX8RGLITfdchdKsLUmQAtr0Nb2wK41CFYP9ONnq6m7f3KEOn7Ie3WhKb0QNEOYD7id8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736810595; c=relaxed/simple;
	bh=ocmKou5Gv5Pk5lKfjEBfbXG0HPUc+w2vOPN/ZKTih6o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=BGEJuaLkO0sHOd73Qw/lSXAYa4iTh8mHq1mQHmtPlJzDfX66VpQ55xkk6gYScox72VQ1V7leVKdXYdpbrutmm6sCbQXI5BmTZAul64KzMsFupCf/PfLGdn/KRjXzy2wX9gOj2dHzWh1WB/On4aIjCl4cqVmOXdraGqcGLIVssMI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CAMba87I; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=UxYSaeO+; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CAMba87I";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="UxYSaeO+"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50DMBB2H000308;
	Mon, 13 Jan 2025 23:22:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=4TCihAJ8ktXOlFmAFj
	8BynVhETZlNB3Ttz1uiBKqKWs=; b=CAMba87ILTyrRIelOKjIxdjjyYxW8ptNC/
	sWOpDG8fhTGdkLmdAjA9YOoGWNaVYvelD0h6IX1pBUIb5PHi9l0xNPPeT4H4Mt2k
	1PmST+Vpe2Xf7G7VD23C9zyemOdZ1EqS+uirrgTXED3F4osPRwrcz+pCXIBpaAcn
	8HQk+UJYHsBG2YEdOiHUyuptnlGebYL1Jt79MsXuxiEyopXbJUd58vzH7FKu5yVP
	iyKVCh2qb1tV8e5MfDcgIuYo+KKcmyXCjnu0tcwEj7eWQbw6fvKlSCyiROxzugdw
	C+HsSMopnjrXSayNBk3dZ46jPT6QLw4pYDsnLlkZAKL3ObPFcLHQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 443f7y4rra-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Jan 2025 23:22:55 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50DMA1P1036440;
	Mon, 13 Jan 2025 23:22:54 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2043.outbound.protection.outlook.com [104.47.70.43])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 443f383je8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Jan 2025 23:22:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uAzQg4uRNVlbDyAo3R9T5XarNnVmM30AHrWUlKbyemxn5+HBEpXvgHUVTkGgkGLmP0BDaUcnOHP9l6XyHpPq48Hsn4qcIbFrg/2d1Rf1Agtt5fQkGsc/TpjubB+cAPZieS0AkOrbXw8sU1GvHFieNzbJKRhSb8WmeULEaduH1geXdVvMO8duUPUgmfDpoNGf31V6CVIkADY2GHfdC1IPyIYAQfi3TsodekLmoerZtvTpo8wWvMi/UGD/UurZA7KpmYP/ze6Y3GPWgx7BvDosyKzZ0y/k20j+heCQrAsSHtvOCPcblbSBwoLE+IzqoPXY8cIZeuZkxn5Le2Qdyjyanw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4TCihAJ8ktXOlFmAFj8BynVhETZlNB3Ttz1uiBKqKWs=;
 b=Y9IG9ecgmQu1s/y6Ssl2LV0IcDA9ED5odGaYtcq8yQ/3Kver8mNjdbnTlqqjZ3YLCAoclsJHzNrSRQS+eayjdJgqlP7ij3Tq4WhBTZ+fBn9se6XIKHNONdyKjd1VxbroGkgvTxHUUtBM210PbfJI9d4AeYqQvcEguVSRFGkm4wT5knTKK9GXRpE1T22D1v5kyVRNw3mBwrnMNgMZIn9Nq9N3BiMu63X1qBB9a7VbejUGZjAb6LF02pBMWMATTpQ9nq/AyzCnEhtgVQEJZUCQ0h5zLnEse19G9Xw1f8ugrMmrbonXDpDIwZC0HkjVqDSERHhzambn1blo0+8CYyGw7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4TCihAJ8ktXOlFmAFj8BynVhETZlNB3Ttz1uiBKqKWs=;
 b=UxYSaeO+gPMKbj61NEajHnGZH0jvU0AteELTeYLxTj0QdXQHXsWwn0YipmtYmrtyX69otfRMcK+oYRno+JBn7M8gXZb5NCBk6J9Gh5p576W3spevr8QkMECZZkxOWUlzKmmTZnHtyxPox8/1fDfzV2vnipcwlp+O816G5LpIFsc=
Received: from PH8PR10MB6597.namprd10.prod.outlook.com (2603:10b6:510:226::20)
 by CH3PR10MB7117.namprd10.prod.outlook.com (2603:10b6:610:126::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Mon, 13 Jan
 2025 23:22:52 +0000
Received: from PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca]) by PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca%4]) with mapi id 15.20.8335.017; Mon, 13 Jan 2025
 23:22:52 +0000
From: Stephen Brennan <stephen.s.brennan@oracle.com>
To: Amal Raj T <tjarlama@gmail.com>, danielt@kernel.org, dianders@chromium.org,
        jason.wessel@windriver.com
Cc: tjarlama@gmail.com, amalrajt@meta.com, osandov@osandov.com,
        linux-debuggers@vger.kernel.org, linux-serial@vger.kernel.org,
        kgdb-bugreport@lists.sourceforge.net
Subject: Re: [PATCH v3 3/3] kgdb: Add command linux.vmcoreinfo to kgdb
In-Reply-To: <20250113172936.1434532-5-tjarlama@gmail.com>
References: <20250113172936.1434532-1-tjarlama@gmail.com>
 <20250113172936.1434532-5-tjarlama@gmail.com>
Date: Mon, 13 Jan 2025 15:22:49 -0800
Message-ID: <87bjwati2e.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0446.namprd03.prod.outlook.com
 (2603:10b6:408:113::31) To PH8PR10MB6597.namprd10.prod.outlook.com
 (2603:10b6:510:226::20)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6597:EE_|CH3PR10MB7117:EE_
X-MS-Office365-Filtering-Correlation-Id: f258837b-b419-4b30-bd08-08dd34293378
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nPEQINmr9jTO/9kXnfDw7Yq24NoCVknTg7R7b7SzNSbM+0pSsgoRbYuldxT6?=
 =?us-ascii?Q?z5pOXpYNiHlo8DPx5sY+gDgFJajfZNRddh0TGV5jzHgXCNGUh6WgUswByptn?=
 =?us-ascii?Q?Qyj/c6ELHIPv5YWYOJ8llwZJWvt3vwTR+wN41FS1SkuKYCiMJrKNAr6Oo0ME?=
 =?us-ascii?Q?Yx93qNo3ncBbvWVImldeRad6NCVzi7E+6D46Q3sIQuFx9rkJ9aq2CiHauKH/?=
 =?us-ascii?Q?G+iAfryBr3IhkQQeok4o5Z1rtLZR8UoVAQTNgEbqMCLiHMzk2ONl+z9/pU56?=
 =?us-ascii?Q?Vem/3kUT7vcVyUZQNcRAOxyxX4+a2Lep8BP2dYHHNqOKYf3oc1neAdkcxLd7?=
 =?us-ascii?Q?v7Q1z95kQh9v43H7un0vZpHPwhp6bz63InGzpI2WOaJdQ9XhfqA3VTVzmFOR?=
 =?us-ascii?Q?3AzWGz60WHcR8fluElQG0Lfej5TOXnupOt+HKHWp0O2Fg9pzZm1b78fBaRZK?=
 =?us-ascii?Q?lM2PkZR6wfuVkcqEtbzCwMjcPWx3EGq9QSMG8q6ckUZ4yyvJ3bvyB29jwn4H?=
 =?us-ascii?Q?rkMlVl28u/lp55SATJe2NRPBtdJsSRv/cB3EGqiEmPxAM2xc5VivLl7yTNTX?=
 =?us-ascii?Q?YtYKkhTDWN1tmAG5hqFKjrCxko+NGIF6dMuJUirMu5dpIz2p9/UzkM/jOw9R?=
 =?us-ascii?Q?yoFaYeGDum3h0gbPEuaZItVz4q+lrBF52XAwroPq0q8LokwdRj1SYjdblX4B?=
 =?us-ascii?Q?ntCEyaZA0GPG+vNtBLsZRM3NykMzve4QU2w+amu3fh/L5d1FD51jZVtBjIug?=
 =?us-ascii?Q?88B1OKGPa6Bcz+jY9olJf8d+V72BeQlktIwae6MZlsampahcUPMG0W719kZz?=
 =?us-ascii?Q?ICt1A+SIGvpzUTSu2N4gYO54JJuQtlhzoxpRW3iwQLl3ErINGnWE9CHzL74Z?=
 =?us-ascii?Q?myWR3yYC/Vjf6e3GRUQb08taCWCqttJ+/D5rhl/Zcp6B3KFcY5ot4jO0SzMG?=
 =?us-ascii?Q?OVL9qLh9UMENnkIJcWYY5ZFkgzQNeajOnsMk11Rdru722T0zK71D6Mvw23ZG?=
 =?us-ascii?Q?liruBQjFQWNLvzpAGdnRfltWDQarIG3wZ7yAIB/BAEYJCjJSIhpsojgbU5Gf?=
 =?us-ascii?Q?VXZe0XkiN9C5PxpAcMeySRYX8Xi9f2E+xNkhhZihrQaKHy0D5cBnX3NTNF5y?=
 =?us-ascii?Q?o4MOvJHC9V+Y0C+/IRG3lcflO5zu4H/EpbuRdRpREpGsTz+ECIZbIjL8yJEC?=
 =?us-ascii?Q?+IklUDj0y9yLh9qVzPN6R9uG5AqqEp+nuLg4LqXI+suk0yTLPH9K1MuT9ZaA?=
 =?us-ascii?Q?L4nVQPUKRGK0A7emLmoSFWx6ireCmm+W8roLIN7yyRw6UWbo9iVc6X1lktE3?=
 =?us-ascii?Q?C1aT8I1it8ohHqEycy6fMmT0Odt6C1XeEfTrfrLeqRR4ww=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6597.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Pmqyv5kzIH4Tm1sKoGH8ymeNdYGXP0P9LNoBEFynacGLrFhj78hwnMP+Ek7b?=
 =?us-ascii?Q?ikAK6S3dJ7FVx6YzToT2gx3/sCOEZJbSBkalD5MQ6vV/5pbU/rhDadEB0EXU?=
 =?us-ascii?Q?YIuSA78yRQnHCc0KOBl+Z7z61dIzfjoLCfESCODLiWEMRdcY58eJg9a9zy7x?=
 =?us-ascii?Q?HJs9He9pbXJgTypIqGiesSiSTRcaDw78GIRkQI1VpjZcxTzvblp+rPjUdK6B?=
 =?us-ascii?Q?o9Zmh/s0iFaAzOZND5I/vu8daVIhxmOUnRTqGNjXMPk/T3c1JgHwAO5JCprY?=
 =?us-ascii?Q?Wetbr97BedA0gQJ0IetUv7l04eEePW7WoHhKzreu4Ilo/ZkUBtcC3R6thL+C?=
 =?us-ascii?Q?CylZN9EW6jhtfqDy6myTUXyyEWtCvSuMrnh+y2mVIsVGfWp/xhXFoKXmyuue?=
 =?us-ascii?Q?s6Ab7nFk3wP+diKTe2rSa3e5Hsm5zSD9an16kcBq2wbNYxYtuBKaZVDKrXDk?=
 =?us-ascii?Q?bN7zWPo7irrosRt9UZ3/FdTrQAg0zD0LmgakZvbEtwXBC1OugfL1Q0H+JVYs?=
 =?us-ascii?Q?E2960dlY9EaOS9Kt+yrbddRmAMvMTw/vRycm98Z3VIcSZLztBXj6S/w6dxRT?=
 =?us-ascii?Q?zCKW0t3RgXfFaEILGy1muLru4x8eu0IFX7CsMxumGrNTep0SpISQRn+RGZt7?=
 =?us-ascii?Q?0ymdd/o6uTyWO7uzjwPazipvhFTAVr8WOwChrXgNiTjdcGUCXCzV7ExOzpg8?=
 =?us-ascii?Q?ZUyO/b4vpvmPc2qOD5cQomRmzU+m/Dwpb/H1ykmJ6vrdjV5eig0Uncay88DK?=
 =?us-ascii?Q?frKu2qptzy9bxp8zOQp3VDkOqVuU09TCMVsn3UHYOu2nzI8q7MdsOMEvhJjY?=
 =?us-ascii?Q?Ux71eMsxcfbY5X0Erxosz44/hTYcDPzdnqfSZ7IynNmiiJznUa51t/4h4ui7?=
 =?us-ascii?Q?cCsaQUVEFl7Ngo3TA5aEsT2pDaMJZcN6kblPPB4GtoAn/+uCr8t5+whCeROt?=
 =?us-ascii?Q?m+/RkmYT5Yk390fmdLx4wV0UL/RbfZ96rd2IaDbvF0xC2ppImO7v+Q2jovti?=
 =?us-ascii?Q?f0D9xkIyuqsQNaj5Q7hpfyN2h33cjvv6Zchm7z1y3VYIblVvn/GuCvTf/lm3?=
 =?us-ascii?Q?CFtXlI5NRJz2bpL+os/A2oTczxPQpVsFTFEPDPlbE9txT0rY26ziY/3MMxBx?=
 =?us-ascii?Q?ZJG7BDj+s2AteEe8wFy8YnCw7/DOn2WGRSatLt5vTPYAAL1w/rPe4rTZu0j9?=
 =?us-ascii?Q?XkKgHglToPTGOosBqJXWNOgMe+fcS1eB7udeCUlU8m4wj7Mp+H+KrGwQe3TS?=
 =?us-ascii?Q?Xz8i8EmOpRBH0jh7aKPmUFrJu4Ckhq2n1LhyHeNXQ470WvE+qFp2EzIsCr77?=
 =?us-ascii?Q?Mmu23HgZQfr9c0Aew0eUkeMGqY8pJ/VC3Nzfpgna674LB1h+1uCuNd/Hi2jn?=
 =?us-ascii?Q?i2HkN9zUwKwLD9c8Z7uvK+KTAEqxmpuckLYOTUqqJv3dktK/Ad8SBdP/iLZ5?=
 =?us-ascii?Q?cA5OmH7XwE/9UfxvgQ2KCfy9h+YBJJxt9NCYwQFXBrA6P/Yp80DqeLEB1IAt?=
 =?us-ascii?Q?A4GHXkcFLIZHj5p4cjUbCfsgDsCi0zY7JtW6FSgaqLerBfyCGgjdWrBBD9bq?=
 =?us-ascii?Q?VrZesNjatzvERBsHqYPVtT/Lq23kcOVM2E0h2l4RbLQVT070uCJQjzLteVVv?=
 =?us-ascii?Q?Vw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	d+hY5/NROeJa/erO2IPh+02DjNXO0pDehqdHZrN8yGasRN9aqVx7GJqfOfHqOV5HLBou5Y87lfYXZH6HG3RNxpN2bEum8LYs4z1/tKB8apYbBBjiPsHwV6mY5Gt9eNSMmypubL3+VT5JXkGkAjqOvCzLpdzFHOVeDcxAlKxXbNk4Fg00faXy4kLJViBCX/vzwag5PylBEiGmguZBX0i2mflj2PHYAEvjyJMp3uN4CjtRqvtcL4S/u6GpOwKFAorcIO0zsIeYAPFIMemmXCSq/UqUclcONt3nMzK6UswD1gkPx1qXl5Ed1GwT/atgUMKeQuQd27rbim4q08YnhwyyBj1WYSTeoA/scoGoyL6P9MenKOq8lppbQP2DZDRx8gdy6mJ7hi4eBbuv2OFNnI4S5b2F0Ev+srdCWtL8pwpzuZRB1S4owAGCleLWBsKYwLXeXEEdxGOAHnN7BRZv5YsG1kpzNwsdFt0WI1+bhXPUDSltwXl7s8inPVfmTP32KV7Tynog11y1FAdCzjqmHjnY5hLADR1PqZQxDUV4j7Di/WVHlnTQLITujwtkOIQuDRdgYUjeL9vbTis9IDrAXBCQCm/cfWDwUwMYuwdNg60xhbE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f258837b-b419-4b30-bd08-08dd34293378
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6597.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2025 23:22:52.1629
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xa/RUA8+V2Y+BfxdeAaVjXmvDC+L4KoRD2m8Qa7a4jjrIcXf9s6i/lBeANpUCEihEhDWnY1UmPpMfQ9j1KbmJ+XeLz3gCH1sC3rDMUGMk/I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7117
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-13_09,2025-01-13_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 malwarescore=0
 spamscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501130183
X-Proofpoint-ORIG-GUID: X-FKSgiN-m5_lnIQ51JwVjg25JcW2vxn
X-Proofpoint-GUID: X-FKSgiN-m5_lnIQ51JwVjg25JcW2vxn

Amal Raj T <tjarlama@gmail.com> writes:

> From: Amal Raj T <amalrajt@meta.com>
>
> Add a new query `linux.vmcoreinfo` to kgdb that returns
> vmcoreinfo to the client using the mem2ebin encoding.
> Maximum size of output buffer is set to 2x the maximum
> size of VMCOREINFO_BYTES (kgdb_mem2ebin() requires 1x
> for the temporary copy plus another 1x (max) for the
> escaped data).
>
> Link: https://github.com/osandov/drgn/wiki/GDB-Remote-Protocol-proposal:-linux.vmcoreinfo-query-packet
> ---
>  kernel/debug/gdbstub.c | 18 ++++++++++++++----
>  lib/Kconfig.kgdb       |  1 +
>  2 files changed, 15 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/debug/gdbstub.c b/kernel/debug/gdbstub.c
> index f88e21d5502a..f2c80bd368e2 100644
> --- a/kernel/debug/gdbstub.c
> +++ b/kernel/debug/gdbstub.c
> @@ -30,20 +30,21 @@
>  #include <linux/kgdb.h>
>  #include <linux/kdb.h>
>  #include <linux/serial_core.h>
> +#include <linux/string.h>
>  #include <linux/reboot.h>
>  #include <linux/uaccess.h>
>  #include <asm/cacheflush.h>
>  #include <linux/unaligned.h>
> +#include <linux/vmcore_info.h>
>  #include "debug_core.h"
>  
>  #define KGDB_MAX_THREAD_QUERY 17
>  
>  /* Our I/O buffers. */
>  static char remcom_in_buffer[BUFMAX];
> -static char remcom_out_buffer[BUFMAX];
> +static char remcom_out_buffer[MAX(VMCOREINFO_BYTES * 2, BUFMAX)];

Looking at the code added to gdb_cmd_query(), the actual maximum size of
the response is VMCOREINFO_BYTES * 2 + 1, to account for the 'Q'
character. This is a large buffer, for most architectures it would be
8193 bytes, compared to the current 2048 or 4096.

The more I look at this, the more concerned I am that we're going about
this wrong. GDB has packet types which allow reading uninterpreted bytes
of OS-related data, and they allow specifying a requested offset and
length:

https://sourceware.org/gdb/current/onlinedocs/gdb.html/General-Query-Packets.html#qXfer-read

This would ensure that we could break up the data into multiple smaller
packets, which may go with the protocol design better. I can't find any
documented maximum packet size, but in the GDB remote.c code, I see it
being initialized as small as 400.

I'm aware that I come up with the "qlinux.vmcoreinfo" idea so I'm the
one who should be chastised for missing this potential limitation if it
does exist. I think I'll need to go into the GDB code and play around
with this more, and also share this idea with the binutils people who I
probably should have consulted in the first place.

>  static int gdbstub_use_prev_in_buf;
>  static int gdbstub_prev_in_buf_pos;
> -
>  /* Storage for the registers, in GDB format. */
>  static unsigned long gdb_regs[(NUMREGBYTES + sizeof(unsigned long) - 1) /
>  			      sizeof(unsigned long)];
> @@ -292,8 +293,8 @@ char *kgdb_mem2ebin(char *mem, char *buf, int count)
>  		} else {
>  			*buf++ = c;
>  		}
> -		count -= 1;
> -		tmp += 1;
> +		count--;
> +		tmp++;

I don't think this update goes with the rest of this patch. If you'd
prefer the "++" and "--" syntax, then please incorporate that into patch
1.

>  	}
>  
>  	return buf;
> @@ -777,6 +778,15 @@ static void gdb_cmd_query(struct kgdb_state *ks)
>  		*(--ptr) = '\0';
>  		break;
>  
> +	case 'l':
> +		if (strncmp(remcom_in_buffer + 1, "linux.vmcoreinfo", 17) ==
> +		    0) {
> +			remcom_out_buffer[0] = 'Q';
> +			kgdb_mem2ebin(vmcoreinfo_data, remcom_out_buffer + 1,
> +				      vmcoreinfo_size);

Answering my question on patch 1: vmcoreinfo_size does not include the
NUL byte. So when we get to put_packet(), the loop would continue into
the staged copy of the data. Effectively, some portion of the original
(unescaped) vmcoreinfo would get output after the escaped vmcoreinfo.

Or at least, that's how I read the code. Has this occurred in testing,
or is there something I misunderstood in this analysis?

> +		}
> +		break;
> +
>  	case 'C':
>  		/* Current thread id */
>  		strcpy(remcom_out_buffer, "QC");
> diff --git a/lib/Kconfig.kgdb b/lib/Kconfig.kgdb
> index 537e1b3f5734..012529eee79e 100644
> --- a/lib/Kconfig.kgdb
> +++ b/lib/Kconfig.kgdb
> @@ -12,6 +12,7 @@ menuconfig KGDB
>  	bool "KGDB: kernel debugger"
>  	depends on HAVE_ARCH_KGDB
>  	depends on DEBUG_KERNEL
> +	select VMCORE_INFO

I don't know enough to know whether this would be an issue in practice,
but I'd guess that some people may use kgdb without VMCORE_INFO, and
they may be more likely to be in an embedded application where they
track memory usage carefully, and where the vmcoreinfo may be less
useful to them. It may be wise to avoid selecting VMCORE_INFO, but
instead fall back to a stub implementation that returns an error packet
indicating that there is no data.

Thanks,
Stephen

>  	help
>  	  If you say Y here, it will be possible to remotely debug the
>  	  kernel using gdb.  It is recommended but not required, that
> -- 
> 2.43.5
