Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.11
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794805911;
	b=H+hHmbcVafI8k2I+2lKlzVvCjv7tMi08t+4UFzYG9URN+zlUieitjQ7SmR4DLL7N5PnR
	 pZtRZeprGq57wXJj+uI2kuSWEHmalFbuk1usk2MDr90WSAhmg8ZNZK/ZQCTcg9L1r0CeS
	 OFclKg7ZBDJu6zzkQjNoAmFY/GVR5C5ZGS2H7t0DPqyctQ6nQLRQD1NeCoNSwtVhYWiqF
	 aGDxnEJWBP+HOiPww3neSrmP9WEpLxkgwjcrAk2oyUMRCldzCdFKKJtzcN1g5LXNq9w2j
	 6dsQcY4qDBZYxZZsiBjKQEbnLvAPyQ4wdko9kj6MDv8gwV3VSbhm1VbyABeCdZJMAVQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794805911;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:DKIM-Signature:Received:Received:Date:From:To:CC:Subject:
	 Message-ID:References:Content-Type:Content-Disposition:In-Reply-To:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=tt0jZxObkVTaSOOT+YSeXYj8fYalOKsEmEXK1T+o3xM=;
	b=VHf5xIxCUjXCnllUP36VU5qKj4MXFP9ctnWs/irTwPav6XS0EECuFZlku+JPl18efmwg
	 Td7YFgikLgJXP5BFEID6Lxj12DS9Tun+91ia0ystseheTi1S/rYth8kGDWsGYHthYmVD8
	 7abO/WLe7lamxp9UM40CQt38+eof5omSGGdxI02a1bnS+k1kWLFUkr39tCBoUleDKmG2e
	 XiCoCmOnmFATo7hzVQ359q0urK+3W1OT7vKW1VCChSctdY+2VecoJJeoGi3GEwET2mghL
	 9xE83OC05uM/C6UDGugTup9S3Prnohx7lNe4PulHSH7ckvIroSoYQPFdIz0dKyab/EA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="BaHA/WQk";
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b="VbbY/2lY";
	arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.11
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B7D606A31C;
	Mon, 16 Nov 2026 05:11:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 53B7D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=BaHA/WQk;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=VbbY/2lY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794805910; x=1826341910;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=skFplQm/cKgo49nW+L8RkP6noEvNuWA9PKaCJgVVoP0=;
  b=BaHA/WQkNUZBUK5YPhsZ4MRIfztxoW6ZoPk8hdwvqTcEu84rTTbZUscd
   3pH9QhICGv2qVL/zg5KBgqMCyv+0eDm7C59kcCriAXji7UrsK1omqeBdM
   CK5Y87OzTTZQYFRPP3cnyLIoxKdifp9aUIeBeV/7fgWA2DFlOWgsWgWRX
   A2IJEj4meIUnfg7F8UZBlujiBuJKYHNCpacqbg+1DtYCzUzkMxYSVx09p
   MmhTl6/CtI9eHp72gkWgvmmvMhYPs4fi/cHVSiBiFi20IoflrCfcrnST3
   3RsFjRAP5qC1IN5K88nkLQvDqhPUiqGnjZtIyl3wZkXTc0v1aAuGxVSp3
   g==;
X-CSE-ConnectionGUID: hmvkrSeDQFu7w8XH6IhbAw==
X-CSE-MsgGUID: Xis64O8qSdKh+ZwuNXH1/w==
X-IronPort-AV: E=McAfee;i="6800,10657,11967"; a="3449962"
X-IronPort-AV: E=Sophos;i="6.27,216,1787036400"; 
   d="scan'208";a="3449962"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2026 21:11:49 -0800
X-CSE-ConnectionGUID: vQhO+lmhTdyFIDzdOvjeig==
X-CSE-MsgGUID: MjYz52IjTxiLqxTLli2Ckg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,216,1787036400"; 
   d="scan'208";a="9707255"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2026 21:02:39 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Sun, 15 Nov 2026 21:02:39 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Sun, 15 Nov 2026 21:02:39 -0800
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.33)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Sun, 15 Nov 2026 21:02:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lQcXy4vL1tkO+574j7OzZBRrGfE9wR1VTWNdlraCCNC9N/7LvxGfkf1XCiMF7knaJ6LAMjTPKLLM1b0UxKHHEZxuNuMuGZboJM/EBvK5sQ5q9bxaWzjHgVLvx4RtqAPp6NTZFp+5G/9IDWicWUMNoHjrzeRwcJgBQSIkZqrmeFpvLtehqWsjjJp9h2By1D9arNcjZSS+8UoRem5KfwOL/ZWLe4GAG75zfg0dlWyyQhxQHk2Bu28axovmq62XFiWlvuE99ryeCSG7VRvjjZMnCB5SpQPxERcoTwbzTVSs/+sCYmQyZkiV/ks537CYsYo7x7Gnw6c0n1Qdr796A+nOzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tt0jZxObkVTaSOOT+YSeXYj8fYalOKsEmEXK1T+o3xM=;
 b=Sj+7OZ9ljNyQPuj6YbjuLJimXdwSbrUWQaqCpr2DOJQ8xErgQL35+ZzG1CYJ1iI1o3CTJzGMvDXcyXlyAYBt2EfOuKVgxe0XNDR+YskYObfYxbFYv939rOYKPPx827kNZ8DZygpRcCZ76aywTXSd+8MzhWh96Xrz1l6cQpc9ml4JFu/uqGuZT495RC5Je3w2Hghm30SjEVj6yENzb7d0hmpnx3I/hkJ5+5CpOUl9uJZGHpwXUqQAyLSWn1un4m+MbA/INT16f1Ue4HbjwjQ6ugeyGuOqvm5kq9TqGUqZJ+6MvUHNGJe9yRFpdBITAjlrj+UwN0MOZJb0xxXTwlDG3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tt0jZxObkVTaSOOT+YSeXYj8fYalOKsEmEXK1T+o3xM=;
 b=VbbY/2lYiz4wNrEboyxRYcbXYiPHnMpHJuIOnbqFxBgFPXX7rdX9cpWbbCWB6RBvKpw1KskNGX4aZrR7XxCmi8QiKIK2sEZHHoAPGG+UuIAVFudhxtxi26a3h5FtqibeP/opSykBurvl52pt5vEa8XxYaskMNru3+uX/rEM5Uno=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS6PR11MB362586.namprd11.prod.outlook.com (2603:10b6:8:4c4::14)
 by SA2PR11MB5097.namprd11.prod.outlook.com (2603:10b6:806:11a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 05:01:36 +0000
Received: from DS6PR11MB362586.namprd11.prod.outlook.com
 ([fe80::71a6:38f9:43ed:8f8a]) by DS6PR11MB362586.namprd11.prod.outlook.com
 ([fe80::71a6:38f9:43ed:8f8a%6]) with mapi id 15.21.0615.013; Mon, 16 Nov 2026
 05:01:36 +0000
Date: Mon, 16 Nov 2026 13:01:25 +0800
From: Philip Li <philip.li@intel.com>
To: Xiangwu Lai <laixiangwu@cmss.chinamobile.com>
CC: kernel test robot <lkp@intel.com>, <gregkh@linuxfoundation.org>,
	<jirislaby@kernel.org>, <hugo@hugovil.com>, <linux-serial@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <oe-kbuild-all@lists.linux.dev>,
	<llvm@lists.linux.dev>
Subject: Re: [PATCH v2] serial: sc16is7xx: Fix clock leak on invalid clock
 frequency
Message-ID: <avqOJTuXmpQnRpwK@rli9-mobl>
References: <202611140631.LIs6CWKM-lkp@intel.com>
 <20261116031043.503-1-laixiangwu@cmss.chinamobile.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261116031043.503-1-laixiangwu@cmss.chinamobile.com>
X-ClientProxiedBy: SG2PR01CA0191.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::6) To DS6PR11MB362586.namprd11.prod.outlook.com
 (2603:10b6:8:4c4::14)
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS6PR11MB362586:EE_|SA2PR11MB5097:EE_
X-MS-Office365-Filtering-Correlation-Id: fc8cf973-bf4c-4eb8-ff94-08df439eb0c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|10067099003|4143699003|11063799006|5023799004|56012099006|261026121527099003|261026140227099003|261028144727099003|261022113327099003|261022105027099003|261022075727099003|261021121427099003|261102123227099003|261009223027099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: slcIgwn662gG7cJVP5LDNrNvjZA48gngyqjhcj/LseYMeDaMjx7ToMpulbruc+6X/2bKRlbKWxrN2Rouy6fDI2aBkWrhi7Nx30KejXDooHRdem82OlKf1g6rVU4cNIYrI9dBwU/kLT/QrjFVBPiQ+CtKN9Pp9H8Vn8G+WvtF7efVtyWXTOi4zquDcz5FUg5TCFY2h8XddazspcxIMiE7s80/9mMIOTg3LMindB8TXKQpDkcVfV+rCcjV+mqSS4B89w3OHS5YNYfOD6g8aWvE2cDKt2nriUqXJTjGwWj7+BgN/O9iG/aX0TfcwFfxkVA/BEfKfU6a2/t0gN5vZn24JP4jj9pA/hEqcqCOuiMr1F4SQYEHoI+a8YSVIjxplhibgjUMKLHv17/UFXcFzUyV3fnXLASyt7e/BwEkJ2oT0eEoAePlkvtsIqmDZjNUf1BZ7o+aveMOMHQOZqcBu8VrZXyk+RdtTD6HdHGELEUw0jjOgM53MFFVdC8i/Rb7B2tUKGKFuxZrP3d9oBDp74WiTGFaRcwpIYYWT92/4qks3aMirnhqLJBHTtgrf9JpewkywzpmbvdJWG7zdlPWa2FMPfcuoVp44zjZlEYcFHLUDLiBJW9u+/9QLOE7CblwNhPSV/mM1bhKK+gE8uFfCNI/1VjePAlBVSzZa2/5+VJ2BJo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS6PR11MB362586.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(10067099003)(4143699003)(11063799006)(5023799004)(56012099006)(261026121527099003)(261026140227099003)(261028144727099003)(261022113327099003)(261022105027099003)(261022075727099003)(261021121427099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZRNZoGdo9+o0fpXcsGqxPRCYDJAqBwUrjXUXlvHdsTZypLv7/8CMJTzaAVS6?=
 =?us-ascii?Q?OSaG0JDE7eORRqKgJ6mC28CCbqzV5iibMIO7M+W6nK1CZlB6CtTaHZKmoWl4?=
 =?us-ascii?Q?q3hTaDkvUUmfXTkQD1iorTAJ8YB7Plv+n7l25ouY2q+11pVIuoj+iOEy78hU?=
 =?us-ascii?Q?1soVFa90vcUeEBRsROFzfyLITCYW3ZO6QZ84nxcz3zmpQ3pECC3qcpqDuwX1?=
 =?us-ascii?Q?pUyM4CLgMzp518ZD1jMlAlcMAbzChDx31eJyKI4H+caC8l8h7Iw6mVM5IoIZ?=
 =?us-ascii?Q?9rCWLC+YF7ZDmh3wTuNFLe6/M7gahG/4gfKDykjA262gHOMPRl6rV3ElIvML?=
 =?us-ascii?Q?7j3MRrGgy64ExI2AgM6nnNd2I2pxO7rymc5FEBISDjHEueAdl9579AXFJ3g5?=
 =?us-ascii?Q?sweReUyPBfaECIxqUU9A3XDFFCR9AjhfUv7xYc+kgboovvK8s1r2yqwilyVr?=
 =?us-ascii?Q?j9WzZVtOwGLtj5OxAA1/y/Ejj+ACvC4/Vub1uIabTLwoyU8f8qdg+k0iD50W?=
 =?us-ascii?Q?TNSUYveq0U4MkNX/Iexuos6YJpWNf1ZPLjdR4nSv5CpoXz9kr534z1bu5js/?=
 =?us-ascii?Q?vhG/+drIw4YhN7qI+PXJh5gPRP4EzfHkzTD9hxcP+ZHFSI+94ykkMF9GFeGy?=
 =?us-ascii?Q?il5WX187Igw/DvQ4XnXBiuXDF9q7HfGU06o9iV1qksq41m2WqTJ4wQIiRv1+?=
 =?us-ascii?Q?4yl0nnDM7NQNJnFBuEzSQcv5TCy1UEBeqQRe1nAWQfPR9kq+0Y2Vnqs6YeJJ?=
 =?us-ascii?Q?BEi/14AvaGfikjwMccEuPc+BcwlcFerq2t79DP4ivzHOEzr/zsfb4Amjv3Pg?=
 =?us-ascii?Q?uk2OxhMvCO0+n1pJpfnz3wHJuvn5E0ckOiMkG11TmQ3/rVfJ2AzoM99q3cnz?=
 =?us-ascii?Q?2yPnE/+tAULLn8V5SqRueNkX6/lQL3olqwI2f2JvELtMdg7LoAbVXhQHcHwr?=
 =?us-ascii?Q?xGZA1sDlUifxfKKFpFKDJ3zP2lhZ9HP00c5bpnezaA2sOrE4OnLuLHblcUnV?=
 =?us-ascii?Q?x8zCE7EFbX4kvmh6/a2aPzYgrEBwWK8eSCr2mVboPJ6/UMtRIXVZYxnINpP5?=
 =?us-ascii?Q?UN+A4UxFqklswpoSaQM8N68CasnqyW9J2QM5t5MGOTaCuGUx8zrJ+2uGU8Xq?=
 =?us-ascii?Q?h8c9FAmb9sVF2g6ub+QmhYhjcVnIOR/kNmn4vTve3CF+w6TjlUcs5gSD3iWv?=
 =?us-ascii?Q?ycZL9seOcQfOvhGsHy5cd6hNpY5XF5656AsPoF/FAoV4rhE8jEBN80fy1zbB?=
 =?us-ascii?Q?2tEhxsRzOMTObiyjpBudlB3tkGa+/ssWbCXX+4kYeXNqYX3R6W11BLa2TWT7?=
 =?us-ascii?Q?5fbvjU8emrNzJMg5vmTn6aWbxui8WbDCIowp0BLTOFdvjotX82KXRC4rjeC+?=
 =?us-ascii?Q?XF1VdMzi4zimOvRMQgf4TSyVFLcece5tj3BgotxwSTxN49LPaOj/rRXqcHIO?=
 =?us-ascii?Q?i68S569x2+OG2EnsPG3vFem8QKzQ3sN9X8jyf+v3vXwlut+xcVrXUmLXB2sz?=
 =?us-ascii?Q?0b/QJ3lLaJUuITJyA2CXGGxHGHmfNEscS7pP44sQT1yPiiZ+73cjRDQcpgb4?=
 =?us-ascii?Q?FNnRlDxCLXZv55iat1DT1ft4ULerQyPK25s8QnW4Fzh94UmzOabJoG1YBtmK?=
 =?us-ascii?Q?d9ohRJYJhrLX4YKYlU6MxF/ik9iUbowqHoTgYtM8SuekAujZTJNTXJ1rwa0Z?=
 =?us-ascii?Q?7Pjz1c+lMn4ysTpo6mmCPMxnWUtb9h18eeIeXDRlRofT7+REoI0Z+oYOPw52?=
 =?us-ascii?Q?Ob95pvnkNg=3D=3D?=
X-Exchange-RoutingPolicyChecked: h8bONJOtHQH8blNysoN5vPSFQ7nA7TTrslCyEcYVHiKhxn+ki7PzCe3Yis9h50DeWQRc7+vXPFJcmqqg/BlmN6S1hg7/Km8x2qJukakOokc5erBS/iahtx1Dk5eXgv9cpvcBGECZo/zPhWp6fuyzy2jPgVyCdx5PPK4/nbZQSlBF6R+dh0ScqU/qyeum5wJVnKyAICixldx9H93jZHLvZ1Z0B5JVFxN9zixe8ZINovFWIbgmEMRqwsBnEvvgZVVafbijra7yftt51gPni+R+UdZo9jVXJ1h/oWGRPs3EKYEcxssN351fCyCUUwZYatwLENW93FnCnwHSAvsrWfC+9A==
X-MS-Exchange-CrossTenant-Network-Message-Id: fc8cf973-bf4c-4eb8-ff94-08df439eb0c4
X-MS-Exchange-CrossTenant-AuthSource: DS6PR11MB362586.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 05:01:36.0580
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GAlROjH+NxWG9UIdNkbdZI4joVUZLuIfr0cggp2GAUq6P/kxTwijsTppRjgUfbpm6jcGBrc/83aQJZ6Uc19crA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5097
X-OriginatorOrg: intel.com

On Mon, Nov 16, 2026 at 11:10:42AM +0800, Xiangwu Lai wrote:
> Hi,
> 
> thanks for the reports.  The build error is an artifact of the test
> setup, not a problem in the patch itself.

Thanks for detail info, and sorry about the false reports, i will further
check to fix the bot issue.

Thanks

> 
> Both reports build v2 on top of the linux-review branch created
> for the original 2026-10-30 posting, i.e. on top of the superseded
> v1.  v1 redirected the invalid-frequency -EINVAL path to a "goto
> out_clk", making use of the error label that exists in mainline.
> v2 is a full rework that replaces v1: it switches to
> devm_clk_get_optional_enabled(), so the -EINVAL path keeps its
> original plain return, exactly like mainline, and the mainline
> out_clk label is removed.  Since the -EINVAL path is identical in
> mainline and in v2, v2's diff does not touch that line at all.
> Stacking v2 on top of the v1 baseline therefore leaves v1's
> "goto out_clk" in the invalid-frequency path while the label is
> removed, which produces exactly the reported "use of undeclared
> label 'out_clk'" at sc16is7xx.c:1622.
> 
> I verified this locally: v2 applies cleanly on top of current
> mainline and the result contains no reference to out_clk at all,
> while applying v2 on top of v1 reproduces the dangling goto
> reported here.
> 
> So there is nothing to fix in v2.  It was posted as a standalone
> replacement for v1 (as a new top-level thread), and the build
> error only shows up when it is stacked on top of the v1 baseline.
> 
> Best regards,
> Xiangwu Lai
> 
> 
> 
