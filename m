Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0FA1CBEAC;
	Mon, 13 Jan 2025 20:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736800743; cv=fail; b=gwmZDR3p0GgJ3dsYCGec9aYhatnBDpKnqfftxs/oleuPI/rSsONSb5wN2qnYWnxtFh8e04i2UVcT3OfZpr41CyQRloMpRzV9CLlJm0xiMPRlBL6hJkgNqyjPd2OOaYBoUuuzsAN5QJcjqA6mtrIpshYPrbpTERpkI28GymUWFwc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736800743; c=relaxed/simple;
	bh=Fob9GHe5JvFuqPIJ30XMquvqPP+Vztv//kOALkkKaus=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=T8hSW0zXtdXy3O2kGqH+02mIykMM0XuQhE18GCtvzRwaNMHGmkqm4zMhsE34ybVZ24lyOVsPhfD6C/tuczP3QUzaEh7bl6q+Tl4Z0ybz9E4rKYYfcrw+qu72oA25qdZ5IVhms7F4F+pCx0GeyPaDfZ2blYBunldRAS0TWMI+GPI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KJE6Ofwd; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=I67hrnDE; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KJE6Ofwd";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="I67hrnDE"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50DHN1ZW021301;
	Mon, 13 Jan 2025 20:38:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=qW0uF4B3jsNjY/bcra
	1Mxr1GjdF14OoqiodgTXkOOxo=; b=KJE6OfwdMF2UkxxI6zOA5wFX4d6xQWDc4t
	L1LqlGoKDsChRtYFZnyrTxvOBDvt5qqkqNPXhpKzMDTEOFp0oYlWeLRjsGhqbcW3
	bYBznMdHgCbn+Jz6Zikv6AMOCdVImk+rJYjWF5C+4IWeCKmld7L+DhkVMO0q0m5t
	3pknrh92odDW0156HeyITmJpZSDez7HC7A27kaC7nEc4R97q4jHbny8ljFLnon81
	mBkiXWrDkLc8J0D4Ae/0FV5l9tMExygFKpa2BOmjE4qwtnahCqxsZOGm/nVH3cMC
	l5Q5VCDQGqDVqK0JO7u2yHQK9kICHYT3Pc4v04ug8L/cxPFnDZMA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 443fjamg39-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Jan 2025 20:38:42 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50DJcDeL040424;
	Mon, 13 Jan 2025 20:38:41 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2044.outbound.protection.outlook.com [104.47.56.44])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 443f37epk7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Jan 2025 20:38:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k05BSZzO7cSMXnJqQ5yj21tfgRLEWhANA0liCKxD6SHpwAcKaqPPdRs3Lq1Qj+1P5AVVseEaO7XRN4mw4vN/NZHm3D4sUPMWz3A2X4b1lZLWJuLGPmJwVn5TrcqEYy8U+xIlhDTsiV/A6zVB/HY/pNsPupR4uzcvIXLPmN8V2YAh64JLCMwqrhrLLrWeNor5C0njUd4lh8S0UC5/+WXZ4r1pBq7hNmZRBgb+6OcBZf4Wdb+vvzGSFgkpg1JCbDProxRuEgjDdUsPju5rl8woEdXXV1WAkvuwr+IsmeGKGShwQ5rEAEJYNzQT45RNUupiRSaAqeXfL0Z4U2y+D/luQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qW0uF4B3jsNjY/bcra1Mxr1GjdF14OoqiodgTXkOOxo=;
 b=ttHnCrVFZOdW70EcuRx2nHKaSxtzqyARQOKajiXy7NWDtcXH5eTzD1WvHFBSg/52K3G7JG/cI+kS+VtZhC0KdA4Hvw/sVutbXD+6Iz7L2vpvBUs5eDlJN0Nrbo5nWryzIptQyqQ9slymx7w8UGfwHmzcOW3ITIWWQ6u6OBeOABIr3Ou36DQdJY2RGH/5Ev1D8KyDnPUw+iN84ECC7hDCalDXikDyvf+w91KABSCcDLL48BCHwJ3dZW4csJMw0nIYw3vY3CwO9YG1z2UAt7eZN5yu5A0/5YHl4uoGFQOgVm/Cw5JRG2GXvjEzRzAE0fwiC+sK/EtjtH3pTBBX5zlHRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qW0uF4B3jsNjY/bcra1Mxr1GjdF14OoqiodgTXkOOxo=;
 b=I67hrnDEZIEiLUIaxnsAxrBhJhG30fXQRoq6TNiP8RvF42qR/NG97KyF9tVxGaPDPhpxsrDk1vNhgh4WfaLQNKHyJAHEegEAr0R0qKlcz7kgBGdyiBfNdaGi6Jyi2088I13Zo6p/uDCkP7NLyDIEzKLSTZL1DC0GWCXB0aSqZMc=
Received: from PH8PR10MB6597.namprd10.prod.outlook.com (2603:10b6:510:226::20)
 by BLAPR10MB4834.namprd10.prod.outlook.com (2603:10b6:208:307::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Mon, 13 Jan
 2025 20:38:38 +0000
Received: from PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca]) by PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca%4]) with mapi id 15.20.8335.017; Mon, 13 Jan 2025
 20:38:38 +0000
From: Stephen Brennan <stephen.s.brennan@oracle.com>
To: Amal Raj T <tjarlama@gmail.com>, danielt@kernel.org, dianders@chromium.org,
        jason.wessel@windriver.com
Cc: tjarlama@gmail.com, amalrajt@meta.com, osandov@osandov.com,
        linux-debuggers@vger.kernel.org, linux-serial@vger.kernel.org,
        kgdb-bugreport@lists.sourceforge.net
Subject: Re: [PATCH v3 1/3] kgdb: Add kgdb_mem2ebin function for converting
 memory to binary format
In-Reply-To: <20250113172936.1434532-2-tjarlama@gmail.com>
References: <20250113172936.1434532-1-tjarlama@gmail.com>
 <20250113172936.1434532-2-tjarlama@gmail.com>
Date: Mon, 13 Jan 2025 12:38:36 -0800
Message-ID: <87jzaytpo3.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MN2PR17CA0021.namprd17.prod.outlook.com
 (2603:10b6:208:15e::34) To PH8PR10MB6597.namprd10.prod.outlook.com
 (2603:10b6:510:226::20)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6597:EE_|BLAPR10MB4834:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b7d78d2-cca5-4b1e-6bce-08dd34124251
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?55AGMSWKmW7KpzL6GyBKF5rcAiPL9QIIXJI5lL7rtwR+EQKWS++ZhNpCL3Fy?=
 =?us-ascii?Q?q7N20riNuOcWtLw/bessIx+7f6wzNqNKadHAnngiNg/wtTJUwMZ/Dq8SzVXu?=
 =?us-ascii?Q?OwAeGwW6yr5MvFWpQ3NC1czMgYFkPmUH4cDOURZiUM/Mz0YVuFfsVOvb4My7?=
 =?us-ascii?Q?ERdW0z1xh9EgoDuj7zA0DoGTQRF8S/ObLWQkh63yK60hFWR5Lc+gNkQow7HU?=
 =?us-ascii?Q?OJZ+CJCMWuKFgxQknEfGmEKBi+zhNWxkI4gqRmBUXcJDmZR78Gl76mSWXJtN?=
 =?us-ascii?Q?H+CferYgllT9bjRsedTHkmra3kcOnmE3WME/0rI47MtJCny1Z9xfR5EC7jEw?=
 =?us-ascii?Q?ym71ggQRgo+m1UBFjgT55VR8EhNBhWFebPyTl09gNZLoqt75espFcxx3pcMb?=
 =?us-ascii?Q?vgiv2L/Nz3Y2Pl8BzThpF3J8b/Z7OUyG40TO6GkSRqR0dtiXFkGksaihlB4H?=
 =?us-ascii?Q?6hB0VoyX2pQ6DeybECpCrBElNv2vsPm3xOLLZxBXb2qRH/mDYAokj2Wdt2Mb?=
 =?us-ascii?Q?uAmHgAnDn4om86tveaZZBLbUoIhGmmwnp9qjxOV7BGMw77Cv5N/MvZLhgVpl?=
 =?us-ascii?Q?r7pvlDh5NXrPG20qIyxOjdgNXZQ5H3/U1sZ9lVh8/fMtCfWc/PWgImahMnoQ?=
 =?us-ascii?Q?bFmTzSxNTVSbI6hQzF6V6O2ODnjLgD0Mp33WnYH0HaCPqEyPmWFE0LU8DAX6?=
 =?us-ascii?Q?7EzVgUWQd578yCBAfahR7vNCqhUNrZ4Xw/2ZVyJiz5/0gNWOUemgQHlGQPAs?=
 =?us-ascii?Q?ehJ78D6UJwSoX8+v68gvCJbutWmjNypv0eKr/6gWuyBlnWeUaDE1w84w+9wE?=
 =?us-ascii?Q?p7GhDuYxYwt3iDCzHlvTD1CWMNE4Mo6uqhcoIvnTFB63W+jig2MzthRXSynK?=
 =?us-ascii?Q?J8Vy9DHqRevhRBTt/a0L55McJSEO6K9NN4Uh6QYxoVPM5a3g2ADnLjR/PKJ5?=
 =?us-ascii?Q?fxCFfd+X3Ch+7QZJptNArNWQNTPj5/cBcNJ+QAH1cfy0ZKMfxviyeXYQp2PE?=
 =?us-ascii?Q?U+5jjw4ZSnTqI60g/gL/I23xpMN8EiCLrzJQDTaOUmYV8SHG84fS23UUmfrT?=
 =?us-ascii?Q?6VDCGDJH8atjVzBRUxfDK0c3vOfLYOhiNIuxbQFR0YnxZNjLxNmWd5mUqofQ?=
 =?us-ascii?Q?/M+AqQCV3QBgF/F/ePojbl0a0Xko3mmfpBmCrQSlKXVNFwmE5PSBXcMIEL/h?=
 =?us-ascii?Q?v8cW++wrmHXM8jPd9dZjohvrZBiV6fn4TlsiOEM5jzLBGhypLEVxjKBvv0wC?=
 =?us-ascii?Q?zFk2uGHUKYqQ9zo6QE0WZJzzGM9adQQwG1sE9eyZjFsmsNOUEgYvvEHJZZlM?=
 =?us-ascii?Q?bdTAfkB0ZbkApleRB3goY7+ZZXbbnhaeHGl54pQ4m8FVIg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6597.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mi+r2JJpZz+XsPVb9Fj2yvRFF3Bn4GQpKuLtiLk/9WOv8X2BBp/Dk8No+oBW?=
 =?us-ascii?Q?b3kI96FZOXHZAxvQHmazNI/9Sc28xzDQvMG5IJeD26fj5EhN/cL70s2uqFYc?=
 =?us-ascii?Q?8AECWwaDDzP7SmJSAJ2p8cONTjdIjv01kmZTQ1bc4dr836eXaMGm06XyFsdk?=
 =?us-ascii?Q?6ODdu74qEkRqwID12KuBrGDp0MrHts225j2SBjtee3SKoMAenyANzKlLSt2v?=
 =?us-ascii?Q?ZuBg+FZXOgD8NA9NmpeVua1T0fa8eThRcDgBSO7ONja7tAgcCYWWVwPVYJKj?=
 =?us-ascii?Q?OZQ/ZFxqv36HAvU4EmcSAvNSsOAAAhDzzGHSBNA8j+oR5CDM/phBKqEnWaAH?=
 =?us-ascii?Q?Cme5noPnUpHoebjdbmK3jtHol0q91hlW06K8iZyvqrSRfGJUnzYYvgbB5tJ8?=
 =?us-ascii?Q?yFiKi8xVFwEj/g21KcQv5XHXIGEr3SYvM0FOoTXQWizfzuWETqjNiwXBM69U?=
 =?us-ascii?Q?mOfvMiQaQJ2rHbHPDjHw2Qrl58uBiHTLf8zIaAuVqyxySEWBmDa77hufFQWq?=
 =?us-ascii?Q?mpPI2hUNHANhZ8zExBknww0Ci3HGn9UkDyzzQkinleKc/RCvLUS0pBJOIIZa?=
 =?us-ascii?Q?1vcZIaTEIvkSPMj1vxNsA0RuvpMbPiL7iWVrO+DlkztXxsN0NkETSi3i4fM5?=
 =?us-ascii?Q?W6oO9vHnQn83S6iLsoNjOzSWqo+viClNNSJAg+jItfZspoX32be4s1V2L0KY?=
 =?us-ascii?Q?j8Joz6depXuG8raB6E+LtpAOmPApMyUsxjS9IuwoR4mnaMN+6+JmdPDscvEc?=
 =?us-ascii?Q?NpinqDga7GDIpIy0Y6CqKs/7XA43jpgT88OeYXc5qzHK1iKks8LXWFgtzoek?=
 =?us-ascii?Q?sI6SEsBwwbIRQzNNBTZUFKHY8PZ8lUbYgdRZA99my8gYz6sR4I431BpB8bsF?=
 =?us-ascii?Q?uDFpnRTlmoQwY+9Ht/5b2ytZN+TPydfvgYU2pgDQAc2/ZmNXKmQrEyK6MFwq?=
 =?us-ascii?Q?VC/3F+NrZSPMx5ygkDfz1DXGCpSSBRsYjipHv50lgqCD5bWhx7R9M1BoHnIi?=
 =?us-ascii?Q?pNYXfYik6wrK7/5YhHWM6mMYem85f1Xx+07f7F+yuLSlwkNbw8IBq319KaNA?=
 =?us-ascii?Q?WS67CvmtdR+vuP7gef3bnGJkawRnWJbYB0PjEEYGTf5dzpg81D1t67ZC+FnB?=
 =?us-ascii?Q?WMcCNBO7oJFhqWHFRpaVq3Ply2/o2hrueejNRU7S3lb1tm54LUq6FORU3PYQ?=
 =?us-ascii?Q?eJKtB3Vj0J2QNXP8ffts5AIjqj3e4XY7s8tqTuEWwwR6qUhcSOlwMAI8dqnT?=
 =?us-ascii?Q?UYwqNW6iMMHNkquK9iKSKS+Mf7upJEcsbcDN3bE0EVgQ5nL2M1CeCZmpmwoz?=
 =?us-ascii?Q?xd++fSkdGNacFIrMlrf/7Q+/045B+Tt+lF7mwrLQyNE+nb+HtjXmVpncV+hY?=
 =?us-ascii?Q?CKe7VPEK8g5PusYyCxneCcX4tC71+LtWYkDVh1TlULNOFCSi2ADkQDTaa95j?=
 =?us-ascii?Q?2JNJsTO+YR9Kd8VVg7AbVeK/O/RPE99sraWJ7VhPasqAEWo6XcT8uYDMu/5J?=
 =?us-ascii?Q?aHrI2NqlqdW+0kr7nZOLPMa9fvwWdp2fGVl+LZOxaNDwEqhrE0sPghH6uf5D?=
 =?us-ascii?Q?6JYiCzXVMXNAYNpz1vQZ4cwIv3KUsI7CffP1GyAVzsynTWIro7hm73pCUqqC?=
 =?us-ascii?Q?Pw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	/fUm9le7HXEbEAW+zNi9fjM2XVdyuZ2ByeHeRvFLdWdmUkg2iX0PIO9WX5eJ2XRhG7O/anJ8J896M9qq4eY/+QgC4eleXxGVWFticeNrrbwJdBzrnVgMR8E7wF4BT2iPVXARY3GRB4NJ1pw/NwsVUnr0aZAuF/yp0hhk108Tu5paowcXr/KGqlS+VjWXTMQVNQts9cEHNwqORI1CUTdH4crxm4SniGVeILPMdmqvHiD1MrDhRNVPd0C6sDUSLuNtezRMM3J7tEI7IFriDBehWdbnFzQDnZAQzqtFOQ7dxXpAe/32XcJuhj3DU1/qpiDsA1zcjVbT2PmsUYvEhAnLlitNgTYlUskIZ6RGRSNe16T/oJYUJ/7w45Yh7YLbVo1M2PiELn4qX0LT2Fcwckx5xJgiraEyvZufq2erq6SkIqO32Qvc4PgsDcGcxv+K6e3lRZP9dc0h6vWDvpMU/bJk5s43dg/bsULRnTpB7fWIEV5//TD9ScojwKAa3DC/Ub5Fo6kOJ9rAndbudCFBJdMLWaUKSMLIwzOGee49w2KketVSDr2uixLr1053QK82iX56rO8DEjNiiNOI14Gn1U2et7mNhpwfrup7ER+L7oKAJTk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b7d78d2-cca5-4b1e-6bce-08dd34124251
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6597.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2025 20:38:38.5146
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4+gEHyXhD08F5ogG8Wt6u7nsIlCGlhFG/atFFYA1O5kVCboOM6UJMH1aniHfG78pXMkHBTT69kk8vI/g8ll+s5E0OMsZLRse8yFBn6IUcUU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4834
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-13_08,2025-01-13_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 phishscore=0 bulkscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2501130164
X-Proofpoint-GUID: nQpgVaQNM9i-rQT48TTvxScXi52Tb9_A
X-Proofpoint-ORIG-GUID: nQpgVaQNM9i-rQT48TTvxScXi52Tb9_A

Hi Amal,

Amal Raj T <tjarlama@gmail.com> writes:
> From: Amal Raj T <amalrajt@meta.com>
>
> Add a new function kgdb_mem2ebin that converts memory to binary
> format, escaping special characters ('$', '#', '*', and '}').
> These ASCII characters have the following meaning in GDB binary encoding
> - `$`: Seven repeats in run-length encoding
> - `#`: Six repeats
> - `*`: Three repeats

These aren't the justification for escaping. From the GDB doc linked
below:

- '$' is used to introduce a packet
- '#' is used to end a packet

These cannot appear in any of the packet contents, otherwise they would
confuse the code which determines the packet framing. So they must be
escaped.

In fact, in run-length encoding, these characters are banned -- so they
don't represent seven or six repeats, they simply cannot be used, for
the same reason.

- '*' is used to introduce a run-length encoding

Note that the language of the document indicates that only the "stub"
must escape the '*', because only the stub can use run-length encoding.
Presumably the debugger side of the connection need not escape it,
because the protocol is designed to allow the stub to be implemented
more simply, without needing how to interpret run-length encodings.

I don't think you need to include that level of detail, but the short
description of each character and the reasoning would be good. And put
the same corrected description in the comment below.

> - `}`: Used as escape character
> kgdb_mem2ebin function ensures that memory data
> is properly formatted and escaped before being
> sent over the wire. Additionally, this function
> reduces the amount of data exchanged between
> debugger compared to hex.
>
> Link: https://sourceware.org/gdb/current/onlinedocs/gdb.html/Overview.html#Binary-Data
>
> Signed-off-by: Amal Raj T <amalrajt@meta.com>
> ---
>  include/linux/kgdb.h   |   1 +
>  kernel/debug/gdbstub.c | 119 ++++++++++++++++++++++++++---------------
>  2 files changed, 77 insertions(+), 43 deletions(-)
>
> diff --git a/include/linux/kgdb.h b/include/linux/kgdb.h
> index 76e891ee9e37..fa3cf38a14de 100644
> --- a/include/linux/kgdb.h
> +++ b/include/linux/kgdb.h
> @@ -322,6 +322,7 @@ extern struct kgdb_io *dbg_io_ops;
>  
>  extern int kgdb_hex2long(char **ptr, unsigned long *long_val);
>  extern char *kgdb_mem2hex(char *mem, char *buf, int count);
> +extern char *kgdb_mem2ebin(char *mem, char *buf, int count);
>  extern int kgdb_hex2mem(char *buf, char *mem, int count);
>  
>  extern int kgdb_isremovedbreak(unsigned long addr);
> diff --git a/kernel/debug/gdbstub.c b/kernel/debug/gdbstub.c
> index f625172d4b67..f88e21d5502a 100644
> --- a/kernel/debug/gdbstub.c
> +++ b/kernel/debug/gdbstub.c
> @@ -39,15 +39,14 @@
>  #define KGDB_MAX_THREAD_QUERY 17
>  
>  /* Our I/O buffers. */
> -static char			remcom_in_buffer[BUFMAX];
> -static char			remcom_out_buffer[BUFMAX];
> -static int			gdbstub_use_prev_in_buf;
> -static int			gdbstub_prev_in_buf_pos;
> +static char remcom_in_buffer[BUFMAX];
> +static char remcom_out_buffer[BUFMAX];
> +static int gdbstub_use_prev_in_buf;
> +static int gdbstub_prev_in_buf_pos;
>  
>  /* Storage for the registers, in GDB format. */
> -static unsigned long		gdb_regs[(NUMREGBYTES +
> -					sizeof(unsigned long) - 1) /
> -					sizeof(unsigned long)];
> +static unsigned long gdb_regs[(NUMREGBYTES + sizeof(unsigned long) - 1) /
> +			      sizeof(unsigned long)];

It looks like the majority of the code changes in this patch are
formatting, maybe due to an automatic formatter?

Generally it's bad practice to include those sorts of changes since
they're unrelated to the subject of this patch.

>  
>  /*
>   * GDB remote protocol parser:
> @@ -257,6 +256,49 @@ char *kgdb_mem2hex(char *mem, char *buf, int count)
>  	return buf;
>  }
>  
> +/**
> + * Convert memory to binary format for GDB remote protocol transmission,
> + * escaping special characters ($, #, *, and }) using the `}` character as an escape.
> + *
> + * The `$` (seven repeats), `#`(six repeats), `*`(three run-length), and `}`
> + * characters are considered special because they have
> + * specific meanings in the GDB remote protocol. To avoid conflicts, these
> + * characters are escaped by prefixing them with the `}` character and then XORing
> + * the original character with 0x20.
> + *
> + * Examples:
> + *   - `0x7d` (ASCII '}') is transmitted as `0x7d 0x5d`
> + *   - `0x23` (ASCII '#') is transmitted as `0x7d 0x43`
> + */
> +char *kgdb_mem2ebin(char *mem, char *buf, int count)
> +{
> +	char *tmp;
> +	int err;
> +
> +	/* We use the upper half of buf as an intermediate buffer
> +	 *	for the raw memory copy.
> +	 */
> +	tmp = buf + count;

It's a fun mental experiment to confirm that, even if every character in
the source buffer required escaping, this function would still work :)

> +	err = copy_from_kernel_nofault(tmp, mem, count);
> +	if (err)
> +		return NULL;
> +	while (count > 0) {
> +		unsigned char c = *tmp;
> +
> +		if (c == '}' || c == '#' || c == '*' || c == '#') {
> +			*buf++ = '}';
> +			*buf++ = c ^ 0x20;
> +		} else {
> +			*buf++ = c;
> +		}
> +		count -= 1;
> +		tmp += 1;
> +	}

Give that the caller can't know how many bytes the escaped data will
consume, how does this function return that information? Is the idea
that "count" includes the nul byte, and so the final iteration of this
loop will nul-terminate the buffer?

Thanks,
Stephen

> +	return buf;
> +}
> +
>  /*
>   * Convert the hex array pointed to by buf into binary to be placed in
>   * mem.  Return a pointer to the character AFTER the last byte
> @@ -400,7 +442,7 @@ static void error_packet(char *pkt, int error)
>   * remapped to negative TIDs.
>   */
>  
> -#define BUF_THREAD_ID_SIZE	8
> +#define BUF_THREAD_ID_SIZE 8
>  
>  static char *pack_threadid(char *pkt, unsigned char *id)
>  {
> @@ -454,7 +496,6 @@ static struct task_struct *getthread(struct pt_regs *regs, int tid)
>  	return find_task_by_pid_ns(tid, &init_pid_ns);
>  }
>  
> -
>  /*
>   * Remap normal tasks to their real PID,
>   * CPU shadow threads are mapped to -CPU - 2
> @@ -560,7 +601,7 @@ static void gdb_cmd_memread(struct kgdb_state *ks)
>  	char *err;
>  
>  	if (kgdb_hex2long(&ptr, &addr) > 0 && *ptr++ == ',' &&
> -					kgdb_hex2long(&ptr, &length) > 0) {
> +	    kgdb_hex2long(&ptr, &length) > 0) {
>  		err = kgdb_mem2hex((char *)addr, remcom_out_buffer, length);
>  		if (!err)
>  			error_packet(remcom_out_buffer, -EINVAL);
> @@ -615,8 +656,7 @@ static void gdb_cmd_reg_set(struct kgdb_state *ks)
>  	int i = 0;
>  
>  	kgdb_hex2long(&ptr, &regnum);
> -	if (*ptr++ != '=' ||
> -	    !(!kgdb_usethread || kgdb_usethread == current) ||
> +	if (*ptr++ != '=' || !(!kgdb_usethread || kgdb_usethread == current) ||
>  	    !dbg_get_reg(regnum, gdb_regs, ks->linux_regs)) {
>  		error_packet(remcom_out_buffer, -EINVAL);
>  		return;
> @@ -756,14 +796,14 @@ static void gdb_cmd_query(struct kgdb_state *ks)
>  			break;
>  		}
>  		if ((int)ks->threadid > 0) {
> -			kgdb_mem2hex(getthread(ks->linux_regs,
> -					ks->threadid)->comm,
> -					remcom_out_buffer, 16);
> +			kgdb_mem2hex(
> +				getthread(ks->linux_regs, ks->threadid)->comm,
> +				remcom_out_buffer, 16);
>  		} else {
>  			static char tmpstr[23 + BUF_THREAD_ID_SIZE];
>  
>  			sprintf(tmpstr, "shadowCPU%d",
> -					(int)(-ks->threadid - 2));
> +				(int)(-ks->threadid - 2));
>  			kgdb_mem2hex(tmpstr, remcom_out_buffer, strlen(tmpstr));
>  		}
>  		break;
> @@ -776,8 +816,8 @@ static void gdb_cmd_query(struct kgdb_state *ks)
>  				strcpy(remcom_out_buffer, "E01");
>  				break;
>  			}
> -			kgdb_hex2mem(remcom_in_buffer + 6,
> -				     remcom_out_buffer, len);
> +			kgdb_hex2mem(remcom_in_buffer + 6, remcom_out_buffer,
> +				     len);
>  			len = len / 2;
>  			remcom_out_buffer[len++] = 0;
>  
> @@ -895,8 +935,7 @@ static void gdb_cmd_break(struct kgdb_state *ks)
>  		error_packet(remcom_out_buffer, -EINVAL);
>  		return;
>  	}
> -	if (*(ptr++) != ',' ||
> -		!kgdb_hex2long(&ptr, &length)) {
> +	if (*(ptr++) != ',' || !kgdb_hex2long(&ptr, &length)) {
>  		error_packet(remcom_out_buffer, -EINVAL);
>  		return;
>  	}
> @@ -906,11 +945,11 @@ static void gdb_cmd_break(struct kgdb_state *ks)
>  	else if (remcom_in_buffer[0] == 'z' && *bpt_type == '0')
>  		error = dbg_remove_sw_break(addr);
>  	else if (remcom_in_buffer[0] == 'Z')
> -		error = arch_kgdb_ops.set_hw_breakpoint(addr,
> -			(int)length, *bpt_type - '0');
> +		error = arch_kgdb_ops.set_hw_breakpoint(addr, (int)length,
> +							*bpt_type - '0');
>  	else if (remcom_in_buffer[0] == 'z')
> -		error = arch_kgdb_ops.remove_hw_breakpoint(addr,
> -			(int) length, *bpt_type - '0');
> +		error = arch_kgdb_ops.remove_hw_breakpoint(addr, (int)length,
> +							   *bpt_type - '0');
>  
>  	if (error == 0)
>  		strcpy(remcom_out_buffer, "OK");
> @@ -925,12 +964,10 @@ static int gdb_cmd_exception_pass(struct kgdb_state *ks)
>  	 * C15 == detach kgdb, pass exception
>  	 */
>  	if (remcom_in_buffer[1] == '0' && remcom_in_buffer[2] == '9') {
> -
>  		ks->pass_exception = 1;
>  		remcom_in_buffer[0] = 'c';
>  
>  	} else if (remcom_in_buffer[1] == '1' && remcom_in_buffer[2] == '5') {
> -
>  		ks->pass_exception = 1;
>  		remcom_in_buffer[0] = 'D';
>  		dbg_remove_all_break();
> @@ -938,9 +975,11 @@ static int gdb_cmd_exception_pass(struct kgdb_state *ks)
>  		return 1;
>  
>  	} else {
> -		gdbstub_msg_write("KGDB only knows signal 9 (pass)"
> +		gdbstub_msg_write(
> +			"KGDB only knows signal 9 (pass)"
>  			" and 15 (pass and disconnect)\n"
> -			"Executing a continue without signal passing\n", 0);
> +			"Executing a continue without signal passing\n",
> +			0);
>  		remcom_in_buffer[0] = 'c';
>  	}
>  
> @@ -1050,7 +1089,7 @@ int gdb_serial_stub(struct kgdb_state *ks)
>  				goto default_handle;
>  			if (tmp == 0)
>  				break;
> -			fallthrough;	/* on tmp < 0 */
> +			fallthrough; /* on tmp < 0 */
>  		case 'c': /* Continue packet */
>  		case 's': /* Single step packet */
>  			if (kgdb_contthread && kgdb_contthread != current) {
> @@ -1058,15 +1097,13 @@ int gdb_serial_stub(struct kgdb_state *ks)
>  				error_packet(remcom_out_buffer, -EINVAL);
>  				break;
>  			}
> -			fallthrough;	/* to default processing */
> +			fallthrough; /* to default processing */
>  		default:
>  default_handle:
> -			error = kgdb_arch_handle_exception(ks->ex_vector,
> -						ks->signo,
> -						ks->err_code,
> -						remcom_in_buffer,
> -						remcom_out_buffer,
> -						ks->linux_regs);
> +			error = kgdb_arch_handle_exception(
> +				ks->ex_vector, ks->signo, ks->err_code,
> +				remcom_in_buffer, remcom_out_buffer,
> +				ks->linux_regs);
>  			/*
>  			 * Leave cmd processing on error, detach,
>  			 * kill, continue, or single step.
> @@ -1076,7 +1113,6 @@ int gdb_serial_stub(struct kgdb_state *ks)
>  				error = 0;
>  				goto kgdb_exit;
>  			}
> -
>  		}
>  
>  		/* reply to the request */
> @@ -1095,12 +1131,9 @@ int gdbstub_state(struct kgdb_state *ks, char *cmd)
>  
>  	switch (cmd[0]) {
>  	case 'e':
> -		error = kgdb_arch_handle_exception(ks->ex_vector,
> -						   ks->signo,
> -						   ks->err_code,
> -						   remcom_in_buffer,
> -						   remcom_out_buffer,
> -						   ks->linux_regs);
> +		error = kgdb_arch_handle_exception(
> +			ks->ex_vector, ks->signo, ks->err_code,
> +			remcom_in_buffer, remcom_out_buffer, ks->linux_regs);
>  		return error;
>  	case 's':
>  	case 'c':
> -- 
> 2.43.5
