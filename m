Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.19
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793648296;
	b=xO1VRmTw2ESHTamEXAq9HhlWRktJXcjdJUmmP7Hg+338t/HkmIpaLUlzW+9k7nKDnbNt
	 6XI47cfZ1xswCumplR+DN+tnDb3tPOtq7C2Gmor8ODVUDkVgZT25xW5bBbp1KWoUluaOR
	 iLtDSceguR69vVjaZ4zcUYL8TLpu0aGxO647HtI17wgR9pdwIGRhdeauC0D6lIOxQTTkR
	 +ZCpqQ1puW/WO4YsSA5ZlhVIKlk7hXlMqLIumH16NAMPYEo9XldaKj6e1EjabbOmY9uvt
	 WyuhAHzIYssPyZ6zTzFFRbb24kgP9YWb3FcgvAVpqqXo5osTZWURf3+DXMtSeDPirTw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793648296;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:From:To:CC:Subject:Thread-Topic:
	 Thread-Index:Date:Message-ID:References:In-Reply-To:Accept-Language:
	 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:user-agent:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:Content-ID:
	 Content-Transfer-Encoding:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=WtMt/AN2kisXrnO11a8t5rCWY7XQJs/LPScZmcJIjWM=;
	b=D3danToXms9fg0Pap/DDZoNKl8jAWE2YCNm7aCzIRKEIYn484Y41hZUNd4yYvah3mbnp
	 qf9OUIr1Xr49PBOzL7Axc/ptqNGuAvzOUkW3tYnfa34FJDok03L3lTEp/jEy4CYtRuh0O
	 WTa2/DOdmlMILXJevb177nD0B0LzkVvV7R/4f57GRnurtp383nrViFpOkaWsMA/ta4mwr
	 SvW1j3UeTISxwe/UK0DTpJ3nkc8P4275aP44cNsdAl8hVzRJSQTu5CwmPqsrOxN5APUGI
	 O+DyNz7AVUFl8HGNsUUZrPrHeusrcBEmS4zJVIdFOPDhtTQCSyemYZWdTN6TcKG8lsg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mUfguGRn;
	arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.19
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B923B606A327;
	Mon,  2 Nov 2026 19:38:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B923B606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mUfguGRn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793648295; x=1825184295;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=WtMt/AN2kisXrnO11a8t5rCWY7XQJs/LPScZmcJIjWM=;
  b=mUfguGRnj1R+QdNs2RN/dT/uInkzVkJ7+vYD4RAW8x3i1hgES4JCu3N3
   lzdhLHpmYCEtiiqbixf3oeszVlBzG9hXGTiQruE5pj/w57wGgr50sKf6m
   uDe/K78lcSIqGVqNc7LC7tS1A4aIeLgKvTucCOS//xotvxuATA1R4Kamz
   GFsGBdudraz+Fs7gheAEkYOhP0FL+YqgJqHiUOaWcsp5EwEGHRVoqqPJF
   10goJqUtgTX6w0uR07+awO37sszP8W2wXN7RImAt8Bxac1iwc7Wf0+Nzm
   1fZYHPaEDW5nfY1Et5IzaeBF6dHDPznYrNQVh/Vc1yGjq99CFlOaZJdNF
   A==;
X-CSE-ConnectionGUID: F+F1f/3PSKO/4kfHAOtoWg==
X-CSE-MsgGUID: F5ogP2hXQXaXgmU7ge3yCw==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2383175"
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="2383175"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 11:38:12 -0800
X-CSE-ConnectionGUID: uCxYrIVGT963/lLxYYwlbA==
X-CSE-MsgGUID: gYRLu0v4Q8S8Y91Atuwh3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="6228037"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 11:38:13 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 2 Nov 2026 11:38:12 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Mon, 2 Nov 2026 11:38:12 -0800
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.25) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 2 Nov 2026 11:38:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wExTpERr7g8d8fb9RVQ9oYD8gj81faWfkfDx3fzz5HGXLk5nvRPmhxa3pARoMJWhEEkts1mzjXcEttVKziek69Il7pMrFDxy0FOlzo/ukCC1nXl259jCSMiXkeHS6mXro6QhorDRTspo0GUDghZqxYlhaDfDh3WCT2ynNhXdXuOm1Us+qp++pKxy+dIRRKfpz1/NgJSuWOGibMixFgypWgD1dlSuiUvm8QdF7QIOM8dJqAv6yhCPneKXzSj0caz520h1dcpwhsFuyUeKcCyerd+Ax9HMmzMCcG3MqCm5xTWZDRbHiLDuc9Fn+L0qcV6Ap6UqjfFbKOnKRXg2oA5pxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WtMt/AN2kisXrnO11a8t5rCWY7XQJs/LPScZmcJIjWM=;
 b=VMUqIK/kcORYhw2GMrr8pCz184Ves2orBsEwhATd4QdOb37QkY4czcC5fIfx5vA8fAmSMBEILb0/vyvSwSNNEeAHSw5Wtn8fuBUCYaHUavKZBvTTnPsZywZDWqE8tECizMJzK5hg3MxiClEJOX5mu/vYDWrC0YUrc2h8DWg4dN37gc1V62xUUzRTOYHnp/X8nlZUXgEealv7vl/4KdiSH3DTCsMhVEZuaH9WV3a0neM/+noAH/oih4zzaq+JoQRg0EaAO1AC946X5Fu84chPws+CHem4hCukwVgt1rABfjyEPDpLEd4f6psReQAiNK/n2F7w5e3LuTDwZKcQusIFAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB634048.namprd11.prod.outlook.com
 (2603:10b6:208:549::23) by SN4PR11MB9966.namprd11.prod.outlook.com
 (2603:10b6:806:4fe::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 19:38:08 +0000
Received: from IA3PR11MB634048.namprd11.prod.outlook.com
 ([fe80::760f:f0a4:7417:6e57]) by IA3PR11MB634048.namprd11.prod.outlook.com
 ([fe80::760f:f0a4:7417:6e57%5]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 19:38:07 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "kas@kernel.org" <kas@kernel.org>, "seanjc@google.com"
	<seanjc@google.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "krzk@kernel.org"
	<krzk@kernel.org>, "au.dang.jx@renesas.com" <au.dang.jx@renesas.com>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "x86@kernel.org"
	<x86@kernel.org>, "biju.das.jz@bp.renesas.com" <biju.das.jz@bp.renesas.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "biju.das.au@gmail.com"
	<biju.das.au@gmail.com>, "jirislaby@kernel.org" <jirislaby@kernel.org>,
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH -v2] MAINTAINERS: Fix Intel TDX kernel file patterns
Thread-Topic: [PATCH -v2] MAINTAINERS: Fix Intel TDX kernel file patterns
Thread-Index: AQHdaOQxn9mA4UGjBkG0GpHfntw09rcbMZQA
Date: Mon, 2 Nov 2026 19:38:07 +0000
Message-ID: <953b3d774dc281bf13f5025041d4434f560cf776.camel@intel.com>
References: <20261026-g2ul_sci-v3-0-b3097163edd5@bp.renesas.com>
	 <20261027055750.GBauA9XlPykc1c1Xhv@fat_crate.local>
	 <TY3PR01MB113468FBD8E5EFA65C4B4E5EB86602@TY3PR01MB11346.jpnprd01.prod.outlook.com>
	 <072dd88c-4ca1-4c8a-98b1-7783bc43c1c5@kernel.org>
	 <TY3PR01MB11346BAE55FF22F66E86A6F8B86602@TY3PR01MB11346.jpnprd01.prod.outlook.com>
	 <afdf1864-4721-4177-bc18-2a5821d97559@kernel.org>
	 <20261027205411.GAauEPc4AtLwvrDfFr@fat_crate.local>
	 <7b0a2e98-c614-4cdd-8604-3b5b21e8474f@kernel.org>
	 <20261028154743.GCauIZH3pZm24jCX9b@fat_crate.local>
	 <20261030023338.GGauQCAuYyXGwIhlqX@fat_crate.local>
	 <20261031030112.GHauVZ-OI2KjdkjrcY@fat_crate.local>
In-Reply-To: <20261031030112.GHauVZ-OI2KjdkjrcY@fat_crate.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB634048:EE_|SN4PR11MB9966:EE_
x-ms-office365-filtering-correlation-id: 21f26e9b-2236-4535-7628-08df3918d1fa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|23010399003|6133799003|22082099003|10067099003|56012099006|18002099003|261009223027099003|261102123227099003|261021123027099003|261022105027099003|261021121427099003|4143699003|11063799006|38070700021|261026121527099003|261026140227099003|261028144727099003;
x-microsoft-antispam-message-info: JMMBP4CqRZzfVAKGwMH7M3Z2qZzyrQrlq6vqt0r3zUpUKZcysAsvrxJFV1DvgLzvra9HbD/4YB1skFLw9gv17sSUqJlX8hjbZdmPKMR3NuRfi9f9YjTtmT3g9jxdlYHQ11FOf+EAjaBSwjbSBke5N9yQgE7FUMTz7m54OfpUHpmoXCX+ZpppAf13eZoI5ol4y4AdkPTCQ6vqm/3L8/7SxeTHjHJJ39D+gK3KABXeAIXo1pBgQDbMh+s+ROUSZ2wQN89Lk/MbiMDCwp8hv7VY/GFSOispAvpvtL79LrjHMjMjvZJYx7qqq4m9PPCcVwiEzVKpmOdQVmJBgwecfyLLEDoGdsZ4nsb3j9/tQ8JM7gnaN91ORAUpgPxNbe9Uvizf9PsNhM3Wty2L1ZADypPwsQ6fFIiaEuKF+noLxk+RDrDYTKkrEeeJ4KFcXNoFiFYlF9qlsbxIxNtBxNVv06ZDJU1nOVqckWaJy0KT0QIs4qQG0HF5Bgie86C/IbRba8ijC8kMjMNUxN7EZKdv1T0vv0F+bWrrc2hYTgrWdgqBXG3E/T7CNQEIsmWaHLpj+scdXXnfZkDNArYC7uxudwSvdiU7NkGJwUKLo1zW2VK2nXfKPnweQP3YKFf38I4BaE3dUkG/AxnoTz7c9UUdkod9nJq4O9PeMwuBc0VYWWFeSuBCI2cctkD5W8a+3wEnTju4
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB634048.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(23010399003)(6133799003)(22082099003)(10067099003)(56012099006)(18002099003)(261009223027099003)(261102123227099003)(261021123027099003)(261022105027099003)(261021121427099003)(4143699003)(11063799006)(38070700021)(261026121527099003)(261026140227099003)(261028144727099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QmFMMVJOeDZIVWJyL29jeVZmbVlVSGhzeDRJbklMWnY5TDhGT2ZrLythdWdU?=
 =?utf-8?B?ZHpMMXpLYTUxZ29VSitJMHBwS3Z0T3AreGRmdHROcER2Q3REWElUMmxIOHh6?=
 =?utf-8?B?d2h3d0tLT3lrb283MFRQZEtWaE1pbVp1UUx1Yk5mbXc2cVJ6U3p1VGl5UFEz?=
 =?utf-8?B?bXFEdi90aDVaYkg1enFnMVp1Qjl3Y3Q3RlJHKytxZmtDNVR5V2pudmUxWHJV?=
 =?utf-8?B?TGkwOE1EK3k5bmFlbGNZbmJ6ek4za1F6c1Z5VkhzZjRkU3c5SkM0OFh0bC9P?=
 =?utf-8?B?cnA4ZjZTRENaenRLYjVjbkFqRysrblBNOGtjUFNhQ2J1d1VqdGFSVzB4Rllz?=
 =?utf-8?B?c3Zwd3RkOXRqRmE2ZnBLclNkOXhTUmJaVlZGL20yUmpIUU93cU5qVCtwRTJw?=
 =?utf-8?B?UkphSlhoMkhnT0poL0NFM0NGdjgrNzhCOHVNbGZ6b2o4RVp2V0NoaFFvWjZT?=
 =?utf-8?B?eXNvcTk4ejh1T0ROMW9tNVR5UG1HK3k0b21mcHFvV1RyRms4bnpiR1R2OTk4?=
 =?utf-8?B?d0pMS0tCcTNQMnBqWHAzSlA2Y203bTliM2VYNzNlRUpVaHZFZDJISllvanc3?=
 =?utf-8?B?bnhCVFNpVkI0WEdVakVZVGxGSE5iNFp2OTI3eFk0U29RR3pzL3o0UklMMk11?=
 =?utf-8?B?MHlNSTcxN2l6Wmc4Y0p5MFhkb0I5TFZpR2p1bjdmVE5vMUNYSjVoSkErRnJa?=
 =?utf-8?B?anRCY1RBUnI0SHRUY3lrb3ozVkVETE5oMGl3R01vbHhvNWVmVDNMaWthbWdz?=
 =?utf-8?B?b1hETzF1cmFKNmJxSGRVQUJKUVlzR2ZTRGw0WEtjTExyUlR2YnhCSS9SeUtP?=
 =?utf-8?B?LzJ2SEk4NGU2QmdPdjFJZTczbFNDTE1ycmh3Q2FKU1FPTUNaSTc5V1J2MG5r?=
 =?utf-8?B?TnJCUElWYTVKWXM5d0lnWFAwNjl3TTM4RU9CSlpiTHBkdlNOcHVLb0hFaWNC?=
 =?utf-8?B?NHFwQU53YWI2Z0p3bmtBMU9sWkpJZUFYdlgydkZXREFFTDNLaDZ0ak9uVlNo?=
 =?utf-8?B?cm1UUGVYcHgzUVhyRVFzOGFaU1pZUVYveW1tUTlxMUxBbzRWMGJLOVNXcE5y?=
 =?utf-8?B?MzVFeGlVTW1MUWgrWlh2a3gydzVXZ0xCQll1N1IrWi9MYU0yQk4xMzVjREhJ?=
 =?utf-8?B?OWpOcGUxbVNiYU4wQXdleTM3Um5zbWZrYkZrSG5rQjZpeWZZQ3lGVzArU2l4?=
 =?utf-8?B?OE9zV3VlM0hXTTNMcVQ2ZFNFa054aUgybjVKWVdiU3k1M2d1bmtUL0VZWVdw?=
 =?utf-8?B?cCtKSSs4NjVaTDJxRkl1c2U5bDR4UnAyTjZrdk5hdXAyaGUzMHc1dWQ1djVl?=
 =?utf-8?B?Z2dNQS9YZTZGWjdNTERROG5NdVZrMCsyUlc1MU1IOVU3ZzNGT3dqdzRMczIr?=
 =?utf-8?B?dDVjY2pCOGpSTEJ2L2pDbFN5VkFTQ3AwVm1VSmMzcXNNMkVRbkVSMXZSaVJT?=
 =?utf-8?B?YVY1anRGVjFiUUVtVUNrUnVRVGVsL055dE1JNk9wZ2RtSkNOSm5vc2NaNXM1?=
 =?utf-8?B?b2ttaUxyMlRjL216SHVSdWFKQjJZVklTVnhOcGxWRmVWV2hhU1pFeHVjemZz?=
 =?utf-8?B?MnV2NThXUE4rY0pBSFNMUDFYcmltWWF5eWpMVnNSTlNtbFFmVTU1T0RGOEtp?=
 =?utf-8?B?YmZpVWl4UlJwTnVFVnMvdmgySThFRDM2UGFiUTFSbFUrNFlhYkdVU2REdmVz?=
 =?utf-8?B?a0R6elZXUloxYklKdHFvV0tGMENWZzRlOFhNRVp5Q0M3ajRLSU1PSFF1YWw5?=
 =?utf-8?B?c0M3RElOV1c4RlBZbENKTEFTcGx6QmRTdCtQdHljTExpclJWSHlMVTE1SXRO?=
 =?utf-8?B?a3ZaVWYxRTRmWFFMTkltMHg2RFJ0b0ZKTnZyR0Y4bFAzeWRXYUJZWGFrWFpk?=
 =?utf-8?B?K2Rvd2J3bUtwVVBwQVFqdEFmMG53Yzlzb1VhL3lLTlpBV05WOEJkNzdjcGxU?=
 =?utf-8?B?UElLOGQrdEcvNEcvbXE5Y3Vqbmd1M3VNMTVsbWhzSStjNW5GOWRwM2laZDkv?=
 =?utf-8?B?c2t0QjZOdmhXM1ZHZlJDOWlWMm8vaE5SZW1aUlRES2NINXVmNUV2SnBMbXhM?=
 =?utf-8?B?cUZGZ0Q1RGdCRUhHV2h5NjN5a0N4cnZmQlJqV01GaDA5NnpaQlNUTGtuNEdG?=
 =?utf-8?B?UTBMY0pHVzBpMnFSb2dmNU82ZEYxek14OWsxT0N0MkR4S0xKb3paN0Y1b2tV?=
 =?utf-8?B?RTFUUGJ5K0paNFJOUy91aC9iU01TaDY1SUhCdm4vMXZSM1BvQlhKN3JWL3Nu?=
 =?utf-8?B?ZG5WOS9JOGtCYjVkMEJrdnRZbktMQVhpY1FXZkFxaUY1YlNCdWFkRkRCb3JQ?=
 =?utf-8?B?dWtTQkVITUhDaXhnNDQ0NG9OVFpad3VFQmFFU3gvZ3d3V0ZFc0ovT3FxRGM3?=
 =?utf-8?Q?dMEM1XXSuAnnqgMQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5EF73C2BDAD5F044918DA15370065E71@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Av1n/Z9QO5pHlTqjP0EtVVDcATMaeyKWqhwFxCI30S3hI39GtYNDTdktnYRj4BxWAxOuwmzB7PfhGn192q60UrlTRpBSQaKiFfmexAx+Y/orrGn2e1ca1hyTtdqsi5dFrAbJVzCueWFxX2KSVxsgUQliFaFhdDLT6GCkpV+yP8b6TiKLJQmyt1nDIpA2X+LKoW9D81mZ9oM1YqfRDASXAF11JCPH8J5P9oexTE6JAtUvFVult2Yy5UMq0lArQ82wKjmI1NfXu/tvE1xlZjfVDRTtyBHaGzv3pJhO/+VGuTm+m+mvnaPYcoFa30fan+gFWMt0YbGoLp9Lad7F6px2Cw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB634048.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21f26e9b-2236-4535-7628-08df3918d1fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2026 19:38:07.4542
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ADVlUwovCUXYK1wRuEqSGQoDAMYho7t3ocyF3tF1aPamR560mLB4586pvV6VMqkGG4esHVBhKSt2PLj2kItjyhbK+RKHcjY0+6cFQtW1/ds=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR11MB9966
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI2LTEwLTMwIGF0IDIwOjAxIC0wNzAwLCBCb3Jpc2xhdiBQZXRrb3Ygd3JvdGU6
DQo+IEZyb206ICJCb3Jpc2xhdiBQZXRrb3YgKEFNRCkiIDxicEBhbGllbjguZGU+DQo+IA0KPiBB
IEs6IGlzIGEgY29udGVudCByZWdleCBmaWxlIHBhdHRlcm4gd2hpY2ggbWF0Y2hlcyBhbnkgdGV4
dCBpbiBhIHBhdGNoDQo+IHNvIGlmIGEgY29tbWl0IG1lc3NhZ2UgY29udGFpbnMgInRkeCIgYXMg
aW4NCj4gDQo+IMKgIGhhc190ZHhlX2F1dG9fY2xlYXINCj4gDQo+IGZvciBleGFtcGxlLCBzZWUN
Cj4gDQo+IMKgIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3IvMjAyNjEwMjYtZzJ1bF9zY2ktdjMt
My1iMzA5NzE2M2VkZDVAYnAucmVuZXNhcy5jb20NCj4gDQo+IGdldF9tYWludGFpbmVyLnBsIGVy
cm9uZW91c2x5IGFkZHMgdGhlIHg4NiBnYW5nIHRvIHRoZSBDYyBsaXN0IGZvciB3aGF0DQo+IG9i
dmlvdXNseSBpcyBhIGNvbXBsZXRlbHkgdW5yZWxhdGVkIHBhdGNoLg0KPiANCj4gVGhlIHNhbWUg
aGFwcGVucyB3aGVuIHNvbWVvbmUgdXNlcyBpdCB0byBjaGVjaw0KPiANCj4gwqAgZHJpdmVycy9w
b3dlci9yZXNldC90ZHgtZWMtcG93ZXJvZmYuYw0KPiANCj4gcGF0Y2hlcy4NCj4gDQo+IFNvIHN3
aXRjaCB0aGUgeDg2IFREWCBwYXR0ZXJucyB0byBmaWxlcyBhbmQgZGlyZWN0b3JpZXMgKEY6KSB3
aWxkY2FyZA0KPiB0eXBlIHBhdHRlcm5zIGFuZCBncm91cCB0aGVtIGJ5IHBhdGgsIGZvciBsZXNz
IGZhbHNlIHBvc2l0aXZlcy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEJvcmlzbGF2IFBldGtvdiAo
QU1EKSA8YnBAYWxpZW44LmRlPg0KPiBMaW5rOg0KPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9y
LzIwMjYxMDI3MDU1NzUwLkdCYXVBOVhsUHlrYzFjMVhodkBmYXRfY3JhdGUubG9jYWwNCj4gLS0t
DQo+IMKgTUFJTlRBSU5FUlMgfCA3ICsrKysrLS0NCj4gwqAxIGZpbGUgY2hhbmdlZCwgNSBpbnNl
cnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL01BSU5UQUlORVJT
IGIvTUFJTlRBSU5FUlMNCj4gaW5kZXggN2ExNjJlOWJjYWIxLi4wMTVjZjY2YWZiOTYgMTAwNjQ0
DQo+IC0tLSBhL01BSU5UQUlORVJTDQo+ICsrKyBiL01BSU5UQUlORVJTDQo+IEBAIC0zMDM0Nyw4
ICszMDM0NywxMSBAQCBMOglsaW51eC1jb2NvQGxpc3RzLmxpbnV4LmRldg0KPiDCoEw6CWt2bUB2
Z2VyLmtlcm5lbC5vcmcNCj4gwqBTOglTdXBwb3J0ZWQNCj4gwqBUOglnaXQgZ2l0Oi8vZ2l0Lmtl
cm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3RpcC90aXAuZ2l0IHg4Ni90ZHgNCj4g
LU46CXRkeA0KPiAtSzoJXGIodGR4KQ0KPiArRjoJYXJjaC94ODYvKiovKnRkeCoNCj4gK0Y6CURv
Y3VtZW50YXRpb24vKiovKnRkeCoNCj4gK0Y6CWRyaXZlcnMvdmlydC9jb2NvL3RkeCovDQo+ICtG
OglpbmNsdWRlL3VhcGkvbGludXgvdGR4DQo+ICtGOgl0b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy90
ZHgvDQoNClRoaXMgZHJvcHMgYXJjaC94ODYva3ZtL3ZteC90ZHguYy4gTm90IHRoYXQgd2UgYXJl
IHNlbmRpbmcgYW55IFBScyBiYXNlZCBvbiB0aGlzDQptYWludGFpbmVyIGVudHJ5LCBidXQgSSdk
IGxpa2UgdG8gY29udGludWUgdG8ga2VlcCB0YWJzIG9uIHRoYXQgY29kZS4NCg0KU2VhbiBkbyB5
b3UgaGF2ZSBhbnkgdGhvdWdodHMgYWJvdXQgaG93IHRoaXMgZW50cnkgYXBwbGllcyB0byB0aGUg
S1ZNIHNpZGUgb2YNClREWD8gSSdtIG5vdCBzdXJlIHdlIGFjdHVhbGx5IGV2ZXIgaGFkIGEgc3Bl
Y2lmaWMgZGlzY3Vzc2lvbi4NCg0KSW4gcHJhY3RpY2UgaXQgaGFzIGJlZW4gYSBjcm9zcyBzdWJz
eXN0ZW0gd3JhbmdsZXIgcm9sZS4gV2l0aCBURFggY29ubmVjdCBpdA0Kd2lsbCBsaWtlbHkgZ3Jv
dyBtb3JlIHRlbnRhY2xlcy4NCg0KPiDCoA0KPiDCoFg4NiBWRFNPDQo+IMKgTToJQW5keSBMdXRv
bWlyc2tpIDxsdXRvQGtlcm5lbC5vcmc+DQo+IC0tDQo+IDIuNTMuMA0KDQo=
