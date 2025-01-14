Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D693F157A55;
	Tue, 14 Jan 2025 21:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736889511; cv=fail; b=NkMLcCCDB/0wCq7ejZzMk0yahXZUW6g2gOVHZdWiNA6U4fAQI8yx6IttDhXuPyv6fcR7jhcH9sFsOPVxzw0S725Lgmnr5R57zNBubl3iLB83JHbE6Hrz0fFvIb9anOfJS88tZca0CU3ArAExhdCFqcbRfF+aGAiCXlgV03BHVcA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736889511; c=relaxed/simple;
	bh=qmRNAlVFZuRtlj1qrl2Pn45v/XYmVETDCVYTXSe1YyE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=eylbLuPAX+TiNoUog3gTonvliBHjaVlkwCT+O62eDL+2q10N4JOl/lmdto7eDr5YvVfK53qiWEtIIopkMVvzMX1xX+N8PKh7+veYgWPXoOdmh0hM7EqG1oBYI8GW4ESTB54+1B6si8/eylJzQCM094gpNDDaifFSbKKhiic0cts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=eMZ9aztb; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=pzMISyqk; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eMZ9aztb";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="pzMISyqk"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50EIXsqT026933;
	Tue, 14 Jan 2025 21:18:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=vqOuU5QJBpV4cmn6uZ
	i7cdelX/4EaCeqMHuLV+V6SNc=; b=eMZ9aztbLb8Z5VrPrGCgVAb6S/PPR3UHyG
	lVUxczoFh3jKM3kYl4AYfEGyE+mxKiAfCJpXbvW4wVZ+09SwPIW0h6HsbuhW7hdi
	EtIhZCJISkeeixxU7f0zQ5dsr3hSKYseThlacvVtA/VxMLX3AnLHSU4k9VfFtdN1
	RASnxVIzMuVamlp7qgYJsVrMxr+iHwsYgXXRHoXVfCDRFnlguoTadA5cNqQpugO7
	I/sGlcRVuaALKgXU2HXxMFTrfE7NiqVPk018ubbDdHaA0Izf1GfH/uq2QFyu2VQt
	4Q7dccTcjMeeGOkY04U9RN+Wys6mujHZZgmQOxZYNyEWyNrE28LQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 443gpcpt7s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Jan 2025 21:18:12 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50EK8dKl037308;
	Tue, 14 Jan 2025 21:18:12 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2047.outbound.protection.outlook.com [104.47.58.47])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 443f39642c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Jan 2025 21:18:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ofPB7MNDRxYErSbHO9R2nn23fXD7oTcOWj+L9HQp6fsoFRJyKloVVdwfzSNK3iO3/ZrXlsIgo8L4E7c66/KNCnccaXHAdR8cl4ECPaNNEr4JSZd9wXXacgyiqrOwCxOaHVqE0phBDV83Z2sJrh5uvOu+UeblvnFCJ101D+bczVuwtYHiTJE7z4msYgrDKPNtkUWs/p4V/4pllrhbGQjHF4RRv8yjDHZp3PSSifWTavuu7MAc7/lRrd7om98NvU21Q5M+BdqJKPE8dhUX/U0LbftVZKc4vUU00PSwdrwMkIBvrU9RZhjsDwrRjgv5sAk/rIzHl3wXPYCuRXDKz65CtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vqOuU5QJBpV4cmn6uZi7cdelX/4EaCeqMHuLV+V6SNc=;
 b=xkeHt9CVaJy/kgwcbGlInZtAyp57aX4g7oI5oAVE+X8YWkJtyJzeSjD/okI5qUAqpG8GBSEfj0Z3z9aNN5qXw5mBhU8/DctG1M24RKc9dqWGBxFiNZdgSkIsP+0GuPy9pectzxVwb0NcMNi0+ZTSHqiURjTTB+3p80eiHVIBCPgw5hp3yXhMD74jYT6Pzi+4+vhGQlp+qZ40l0uv/OgLGnrWCa7cY0lU4MT5g57K3blSVXB4yLpFF5yZWaMRfK04ZEW+VVEAej1zmZWyZUmGaCZU5FymqbF9eSL3yujp9wJATZIc/4yp2/KUyTNJnfjRicPKnFing7Vxjt35ILlk/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vqOuU5QJBpV4cmn6uZi7cdelX/4EaCeqMHuLV+V6SNc=;
 b=pzMISyqkpbq/HMmh/bbnl+Fr72LdYkgTRJhm4RrjtPLoxV52L+onK9Bjo7MyyjoaMrqWh2h5lnJUaOxmtjGRLI0h9SZ1Qpqn8z2bzYEYBEZsG2KPGE2scNrvgRZitkv9s0I3+AEZUCxTyZI8qCUuToDpqHu7iruZZbt4nTteW8c=
Received: from PH8PR10MB6597.namprd10.prod.outlook.com (2603:10b6:510:226::20)
 by PH7PR10MB6335.namprd10.prod.outlook.com (2603:10b6:510:1b2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Tue, 14 Jan
 2025 21:18:09 +0000
Received: from PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca]) by PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca%4]) with mapi id 15.20.8335.017; Tue, 14 Jan 2025
 21:18:09 +0000
From: Stephen Brennan <stephen.s.brennan@oracle.com>
To: Amal Raj T <tjarlama@gmail.com>, danielt@kernel.org, dianders@chromium.org,
        jason.wessel@windriver.com
Cc: tjarlama@gmail.com, amalrajt@meta.com, osandov@osandov.com,
        linux-debuggers@vger.kernel.org, linux-serial@vger.kernel.org,
        kgdb-bugreport@lists.sourceforge.net
Subject: Re: [PATCH v3 3/3] kgdb: Add command linux.vmcoreinfo to kgdb
In-Reply-To: <87bjwati2e.fsf@oracle.com>
References: <20250113172936.1434532-1-tjarlama@gmail.com>
 <20250113172936.1434532-5-tjarlama@gmail.com> <87bjwati2e.fsf@oracle.com>
Date: Tue, 14 Jan 2025 13:18:07 -0800
Message-ID: <87v7uhrt68.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MN0PR02CA0027.namprd02.prod.outlook.com
 (2603:10b6:208:530::30) To PH8PR10MB6597.namprd10.prod.outlook.com
 (2603:10b6:510:226::20)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6597:EE_|PH7PR10MB6335:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f9c1c0b-75c0-439e-b0f6-08dd34e0f1ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?v5uRtav39H37U9dplaatwPA0U94H8RynnZwjjaZ7lS7+0dSdsKlOS5po62QM?=
 =?us-ascii?Q?tnP3jo4boKEr1IsLoOhGkngY6Ky1TcTPiDfxKAgRvcCgjfQPKLZhFhWiOUOW?=
 =?us-ascii?Q?G57OUHeN/Ei1nsnsjfP6XW6ubC0vImTxjwlCngHeuMTJXc7P6OoicswOHWal?=
 =?us-ascii?Q?CdTJIwCTNykoDkFON6+9t0Vrbt5TXAm6Gmmq5tuguPmhZuhbsKGTtNZ0VMyO?=
 =?us-ascii?Q?DxMecWS9fiUzmDwBjTY8Xm4No2psr8sEG9WSVR4LbaFc3SQTBArNtClTkwDH?=
 =?us-ascii?Q?15Ip3IldobapZrcabZ+BMOvBohMkJ3hGGVfIrdehX8TL91rHJt1Xt4dAU1gH?=
 =?us-ascii?Q?FpCPZSdcHdRATl8GsVn0FPnAuA8LODszG7Ga9vNupeACQDpDU6JeZKKolS9s?=
 =?us-ascii?Q?DPY1Y4tx5x6GyXtXPs5g3wRzP7/iIU5pwLc5K4w/QOmBcsH5t5Q7UHj9NotT?=
 =?us-ascii?Q?m+/KM9IC27KWEggUL1CJikxeY9uZcF4vCSoVx8xDnsoKsXbMWI6hTg3hv4BC?=
 =?us-ascii?Q?fyK50YWJAl5uvZeuH3+pLklYGDugzjovtds8Iza5dm9njT084zcde2+qVpO2?=
 =?us-ascii?Q?h0c6PIlfZv/P1iKTKl6EJuuqIIqZltjXBSreCxvI+X/Fae9j48Xt7ryqZBst?=
 =?us-ascii?Q?vZFY1KbF2RAnI5tDYq0TrmJUvMWE3CFFSOQDE96O1g9cyFqWzLjfQDXnxTI8?=
 =?us-ascii?Q?Ok80yDMG+Hnfpbu4VpVmI9RBRqP+V0/X7tPKKlZ0iJaLNL1dSLYhw1iB0lSr?=
 =?us-ascii?Q?KJ3s8TpvM7bu1oDSMyeLTv+rwU2Af11gOnGpnGYfAWfVVx+qwAHW30/WNEzf?=
 =?us-ascii?Q?hUIWYJ4NH/bNU4gQFxrCFbnyrhUDR0QELQFjNp1GRKD7j/70ZzhNkG0XCAgp?=
 =?us-ascii?Q?DGn3QB2kUYrNDdzdDGGaHu6dEZ/ZdAP2xXd0GHN1csp49a5Z1s2oC1WhU3HC?=
 =?us-ascii?Q?ZBixBGGS3GZYcoWvEfLKkPnOvuTbp0M/S+qVx9FV2jxSw83PciFnxL//7/f9?=
 =?us-ascii?Q?Z9ijhpRH96h+GNOkyhDoRut9zhkCgr55UAkSbhp5IUuy3vMXap0ek3qzv+Je?=
 =?us-ascii?Q?O68PGl7oQZLVe3EO28CB1QPMlmIKNissOSJZHuwwtsTt8AaeotegWIL19lZY?=
 =?us-ascii?Q?MhcZNpYI1luY+A/a2cniq8YBtFbPevVhKtUZYt4ki/mXyTm4zDw/p6X/l+WN?=
 =?us-ascii?Q?FKCOC7hPE+a93XPUPdvtsHzLJ0u1u23XwIsWpOA55gFct8g/QI+kMltjj/Kx?=
 =?us-ascii?Q?8GtK4Rbtc9qyhuwJc4IfNW7f5YMPqJyUIulwLa3uCDkzmdrsn8SYhbqPFgMn?=
 =?us-ascii?Q?tASvIOqowFjPWzSDwo78ixa5kBxcgrKiORjsSpLRpm/Zgg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6597.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?caOOReZUVNe32HTeo3NFb9X834Q0/p/JDfRFDg9UJt3durj5vezf0y4/nW07?=
 =?us-ascii?Q?2B6J6b6taLBN1mRrjr2Pp3qgYiraDA29UNOxMABWG/uQ/2CCGxhZM2kW75iv?=
 =?us-ascii?Q?XcfC+2Pdu4cHsJ3N4TSkb9G9hcHumVQZHvlqzZzKSLLK/18LBt3M0XoiafLj?=
 =?us-ascii?Q?rYEUS56m+5CFsouyeTBgHr10sOfsmxHMzX+BxSJgabkKfh3uXWs7u24Ktu97?=
 =?us-ascii?Q?B7LaHhJUWK/rtRcIPhkeICMFU1hMsmvQtn4l3vEtQIhpe3XEAAnMz9x6O/F6?=
 =?us-ascii?Q?glOmCrquWBI2b3Q7ddOZfQT+HFNQ2uinAVm/aWJdePMQatnnazw6otlzBMpN?=
 =?us-ascii?Q?REnNUfjpXnpMMKItgnIntc/HhO1WLsfD5HNjF5jLnLMo7YUCqw2slIJ3eS6F?=
 =?us-ascii?Q?A2qBAKXPLH6z8KDjP3buIzu57WPsKkfwF6PCSqSMpWhrYg9D+uZ6quuZCAK3?=
 =?us-ascii?Q?3jI5RcRi7q9z36fQWRWqIql4sH+0R+S+tNGYl5zlo6dqE15LxZ91okws/Tzp?=
 =?us-ascii?Q?XNx05ocncrJ7ruqnjppNXMOWHeUdVbdji4ecf31m4bzat9yMKEnqjN12Hk1B?=
 =?us-ascii?Q?0k26IWRIF7+pDah1jjNaLlQYtPw9SqTmowhIFG7OLbwa+iTY0uYUM6q2fd9I?=
 =?us-ascii?Q?GBRuDc/05rlio7+1X/DntjtgmtlryVJRsnUh+jzRAUYxwmWW5t2hsRmhTmzx?=
 =?us-ascii?Q?CorqtgO4IeO748IK/MEDsr4z/9N/5kWvSZrCV0UAj8m6y5AYziKPP6cKx1wj?=
 =?us-ascii?Q?wPZ9Gyt/E0YT6OrSn+IjwOt+rjHCNc1fa+y+xQ63WJyg4tHEF4SVqDsW1Cuf?=
 =?us-ascii?Q?9qQmj6Hdjhxrg+NljSTuUC3R7GkUeGGBw7G1BkgO0ibv3Pmn4SntlTZ0aWEB?=
 =?us-ascii?Q?V/Fiox1ia1w0nVbDlW7XlLqFLFSJP4H/yK0DmniK3nQyCYFIK90tWnzDmRpt?=
 =?us-ascii?Q?YFJN5hpRuNsRocWUoEnRE9eHG1reEitlpka1Sa0CZfggRnADLnNP/3jToJNu?=
 =?us-ascii?Q?3FccjRAEpd6SorFjJdJnyqeJLEPs4ukG83EKeCEEWUEOeBx65t39VHBoqfZg?=
 =?us-ascii?Q?vWLNbwtgaYRighhJfPKYWcbLwvJT7Q1EP+uoGnT5GF93lJ+eHMrvbZraw6TR?=
 =?us-ascii?Q?uXIUgUXxZNcvdIdpg4BnO2fbjF11DQmpd+17jJbpW4tRa8zgTUjWw3fLJhwf?=
 =?us-ascii?Q?EsSGckzeyqH2pJtk3mLiS6t5M7nQqL68bWzwq1KEifODIPZXpOm7PT0RBCUk?=
 =?us-ascii?Q?hUW1ErvGnw46Vjo+PSGZ3TTDD7J3f8jtTl0GhmsWlyuSj4kcpFoE6EARbdlB?=
 =?us-ascii?Q?fA1hPwByO+e/jjWkTzEs1XZKV+/0vdQK0ZPAHqLzvt5hEq2cSrtzHbObmFXL?=
 =?us-ascii?Q?+Tv43xH6VYMJT9ftdjct7uAq7UdQ6a61Pi9Ey2KumBaOwgYnq1iixoa8o3P2?=
 =?us-ascii?Q?SVmmYTJE55+pohat6DfwcLzr2F6uXChH+0qT61/EZIPF6YGPVDu4gBAjMbGx?=
 =?us-ascii?Q?Z05bUNtGLR3g9/zu2lMMLUw5vY0G+QLBPiTVmPZJ9YlY6gKddJK16WxRw4xd?=
 =?us-ascii?Q?CJ8rUOGRSD6NRBJM7X3mWHn4caarMCElV3s2nf6xwzRUkBzMrNbWPpzUYmn/?=
 =?us-ascii?Q?dw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	aetViD5QxdXqIJMhmQZEdwzBVJTPOLf4Ufh2eypYf560of/PTF3reK80XAVLegC3XRbnBLhhXKYWtG068my5yQUDDVntiSFr6by7C5RGcmUJ6iDe83oX+ltZW3qkKio4WTZVm0v6BXR5q1A5QBJiof7u2UNqcD3D260bE4M2LPJAfH12TR4SU9829oZiU0iJZqmsbR2NTMfSpm419Twk8U/gtS8GfAAY9lGHWTE6yvILIhFWI/R2svfjKspBi2GeXnaQxxmE0XB3svQe5Vxt3eVrHsIPO5tXMKuJluYcfQXCUbNkgd+pK2c3bg2Ri0rqkQn/uhPxnnyrDAz9Sa+uia3j1thg16WCxb0w4tJIPPw+wC90A+EMb0eUogCoE6KD0YLvQK6HqQoi69ZiMAQSCgrcXfGa82AT1vRNw14R0hqyKKGY31xHGk6ABRr7E/FY9IUh+Lhecg5bm4l6Irnu/y5CAoSYCtAZhPozQtsdhzCOQ+8CW4ha9wHLH/vYOprScyUprR5ZHcZ4odY0uHPHY+46P6bG1N1uQXXpacZxQZgCvYVoDfonC1pW6nFDMwvPBp7VnUuGjTMV61825ly33PV0HKLXYSig38yt8ZeVYPw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f9c1c0b-75c0-439e-b0f6-08dd34e0f1ee
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6597.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2025 21:18:09.5219
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bb5SUTNbeS79pkbXuir0JBQjxceJweaOxR87APjn+yqI4yV7cxf6hetENYdAnuDNYqBYACYCHG5mxm3U4oNFLq+3ryMyi3M3hlP9niu18yE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6335
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-14_07,2025-01-13_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 spamscore=0 mlxscore=0 adultscore=0 bulkscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2501140160
X-Proofpoint-GUID: ZP2jM7mKaC0H6fTzXvvU2gKXESrCaoiQ
X-Proofpoint-ORIG-GUID: ZP2jM7mKaC0H6fTzXvvU2gKXESrCaoiQ

Stephen Brennan <stephen.s.brennan@oracle.com> writes:

> Amal Raj T <tjarlama@gmail.com> writes:
>
>> From: Amal Raj T <amalrajt@meta.com>
>>
>> Add a new query `linux.vmcoreinfo` to kgdb that returns
>> vmcoreinfo to the client using the mem2ebin encoding.
>> Maximum size of output buffer is set to 2x the maximum
>> size of VMCOREINFO_BYTES (kgdb_mem2ebin() requires 1x
>> for the temporary copy plus another 1x (max) for the
>> escaped data).
>>
>> Link: https://github.com/osandov/drgn/wiki/GDB-Remote-Protocol-proposal:-linux.vmcoreinfo-query-packet
>> ---
>>  kernel/debug/gdbstub.c | 18 ++++++++++++++----
>>  lib/Kconfig.kgdb       |  1 +
>>  2 files changed, 15 insertions(+), 4 deletions(-)
>>
>> diff --git a/kernel/debug/gdbstub.c b/kernel/debug/gdbstub.c
>> index f88e21d5502a..f2c80bd368e2 100644
>> --- a/kernel/debug/gdbstub.c
>> +++ b/kernel/debug/gdbstub.c
>> @@ -30,20 +30,21 @@
>>  #include <linux/kgdb.h>
>>  #include <linux/kdb.h>
>>  #include <linux/serial_core.h>
>> +#include <linux/string.h>
>>  #include <linux/reboot.h>
>>  #include <linux/uaccess.h>
>>  #include <asm/cacheflush.h>
>>  #include <linux/unaligned.h>
>> +#include <linux/vmcore_info.h>
>>  #include "debug_core.h"
>>
>>  #define KGDB_MAX_THREAD_QUERY 17
>>
>>  /* Our I/O buffers. */
>>  static char remcom_in_buffer[BUFMAX];
>> -static char remcom_out_buffer[BUFMAX];
>> +static char remcom_out_buffer[MAX(VMCOREINFO_BYTES * 2, BUFMAX)];
>
> Looking at the code added to gdb_cmd_query(), the actual maximum size of
> the response is VMCOREINFO_BYTES * 2 + 1, to account for the 'Q'
> character. This is a large buffer, for most architectures it would be
> 8193 bytes, compared to the current 2048 or 4096.
>
> The more I look at this, the more concerned I am that we're going about
> this wrong. GDB has packet types which allow reading uninterpreted bytes
> of OS-related data, and they allow specifying a requested offset and
> length:
>
> https://sourceware.org/gdb/current/onlinedocs/gdb.html/General-Query-Packets.html#qXfer-read
>
> This would ensure that we could break up the data into multiple smaller
> packets, which may go with the protocol design better. I can't find any
> documented maximum packet size, but in the GDB remote.c code, I see it
> being initialized as small as 400.
>
> I'm aware that I come up with the "qlinux.vmcoreinfo" idea so I'm the
> one who should be chastised for missing this potential limitation if it
> does exist. I think I'll need to go into the GDB code and play around
> with this more, and also share this idea with the binutils people who I
> probably should have consulted in the first place.

After checking in with some helpful members of the GDB mailing list[1],
it sounds like the answer here is to use the qXfer command linked above.
Essentially, the format would be like this:

  Request: qXfer:vmcoreinfo:read::OFFSET,LENGTH

  Reply:
    'm [DATA]' - DATA read from the target OFFSET. More data may be
       present. The amount of data may be less than LENGTH.
    'l [DATA]' - DATA read from the target offset. There is no more data
       to be read. The amount of data may be less than LENGTH.
    'l' - There is no data at that offset

The DATA would still be encoded in the same escaped binary format
implemented in patch 1. The useful difference here is that we would not
need to expand remcom_out_buffer. We simply reply with as much data as
requested, or as much as we can fit into the output buffer, whichever is
smaller. The client will use multiple requests until the entire data is
read.

So patch 1 would need to be updated to be aware of remaining space in
the buffer, and it would need to do partial reads. Since the escaping
scheme rarely needs to escape characters (especially for vmcoreinfo), we
can optimistically fill the whole buffer (not just half) and then we
could determine the amount of escapes and do the escaping & shifting all
at once. Something like this:

int kgdb_mem2ebin(char *mem, char *buf, int count, int cap)
{
	int err, i, esc = 0;

	err = copy_from_kernel_nofault(buf, mem, min(count, cap));
	if (err)
		return err;

	/* Some characters need to be escaped, but it's uncommon.
	 * Count the number of escaped characters and then perform
	 * the escaping in reverse. */
	for (i = 0; i < count && i + esc < cap; i++) {
		if (buf[i] == '}' || buf[i] == '#' || buf[i] == '*' || buf[i] == '#') {
			if (i + esc + 1 == cap) {
				/* Skip characters that need escaping when we only have
				 * one byte of capacity remaining. */
				buf[i] = '\0';
				break;
			} else {
				esc += 1;
			}
		}
	}
	count = i;
	i -= 1;
	while (esc > 0) {
		char c = buf[i];
		if (c == '}' || c == '#' || c == '*' || c == '#') {
			buf[i + esc] = c ^ 0x20;
			esc -= 1;
			buf[i + esc] = '}';
		} else {
			buf[i + esc] = c;
		}
		i -= 1;
	}
	return count;
}

[1]: https://inbox.sourceware.org/gdb/87y0zds39y.fsf@oracle.com/T/#t
