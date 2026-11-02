Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.15
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793649390;
	b=hRcHDY9nHQpJ1xrClIp4R8Xoq0A1rnhbyYg4SgZ17pESaUOZ2T7At15x1YbOoK2LydJo
	 Yohc6YAu0eFqG3aUbxfLOfzMm3GZ82m/71IhfnqU/LgVCPvFphspzc6cfd9X+eXuiZcWg
	 TzJprCBhakWXD5bZ0Tgb8IMnTcrSV+QG8/SeYdqZu8jQTQ8u72P3AjDPzjHoUrhWdNxOe
	 vMwP06VdZXkYzFGzD3K0Wb9wL3UBVBQ469wqFZsEvuDchO2RGYj1K7u6sVcXVt4FIUbKt
	 G/939cCHjcri+yfVjS+vZG7grNNsYl4CbUztHZghVBO+t2L6RHzQ5lfNk6mBlMucX5g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793649390;
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
	bh=mX05JYYBjt4nEibcwftHQSMRzSSiiJ14zPT7twqkNt4=;
	b=CzVVFtevJsL7rMItHDUdJ+KPOT3YAHKZJrdlVxUwI5jF5ys5suSUvrL9zwivW5HmCT/O
	 J/FJw+MOdoiOyDDdtSTc3V1txRW/RMu+HA3hODF7giiTFz7voXNAYK1HeSWzOT/wXtrRj
	 SEpKbeD7dpSQG3KnVk4wYT+T+b9zWnADxg1JeoQhJWXMx9nrXYvgooR6t6ffCr0228ROm
	 JxRUnEHY51ZhKtm/KZ7k8sgy66RZkxNn7IXW+bsqdPKOD9iF0Yw3HpXtj6ky3oDhVvInr
	 nkcVVb++/3bF06hMyKurZS9jobrj9E1jaTYcsB1yQ4e+vz/cMwF2JLjkncBw+m3kBvg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=PpceTI2J;
	arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.15
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151C0606D825;
	Mon,  2 Nov 2026 19:56:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 151C0606D825
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=PpceTI2J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793649388; x=1825185388;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=mX05JYYBjt4nEibcwftHQSMRzSSiiJ14zPT7twqkNt4=;
  b=PpceTI2JE9lq1UPuVvbi5Z7M1BcpKr97IiQI66aQF/oEYsiRnmHryJiT
   SWhIp8YmjMTnjYHXA9LU6Rcqwj2Gqg5nzgTFhGphA30GbWn0QssRa9Too
   THrj1dbMG6fpl3yh/Bc56irqC+bGQdqyyt15vDk7RodOCMQNRSiWMJdgZ
   si6tIkM45XPTJOxx9MwY9LzZ04f574dEE10JV8+qfqyzJxlaevsjrJUJR
   J1RTigbAjloXxw5oZLjgsmfEyGUU38Va2eqCjyqnoDd87zOlz2/gGjWEV
   U2C4hwFvFOCIS0LBAzlvLR75iB+lMEnaQloZWLKU+9pRQt8IGgcRwVrYw
   Q==;
X-CSE-ConnectionGUID: fGA6H42NQo6/UiPfTxdaxQ==
X-CSE-MsgGUID: 6ZlJBstjRYSPeg5vJUclXw==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2364435"
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="2364435"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 11:56:27 -0800
X-CSE-ConnectionGUID: GZXX7cZUTeC2G075DyC/7w==
X-CSE-MsgGUID: eMBDzZ+aS4maY4NHdN5DsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="6208783"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 11:56:27 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 2 Nov 2026 11:56:26 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Mon, 2 Nov 2026 11:56:26 -0800
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.40) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 2 Nov 2026 11:56:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xFT1OaODh0vD/gyDcrF3pMge4FKqLDkZuCCYY5AFufRGyhwojAQ3VdlasKSN5TFCnz5AhGQBupD/KraPbWRWC4mv0aT19bDjA8kbxpr5PcvduuN7R6UlDYy4lYhpy710CmTJeoHJY8LdT+bUGL1Xd9Sv5e3Axl5ig2orOQnmeGzf11A2qKf5Ne1fpdulU8G4uURZoRt0+pyUs/BZVvpfydHyp5HCNmE2Ild1fdpMCf0i7Bow/iUIJRf53NfbRMuPGVv+OMTiiwXumZSZ7qaDUB6mbsCHjq2/vyz4OXt1MUcXxJ/LZEGCBvzGKw7K8TiMhXHA/m1LsaibtNVHP2/TYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mX05JYYBjt4nEibcwftHQSMRzSSiiJ14zPT7twqkNt4=;
 b=ZrNwoD8nmFDWZ2VN7/a6sERbhdwXAqM4c79OOxyTCkU8rYcmWuEgrUqVaeMbXKQN4iQDjk5EMA9Qnw2O58Bin/QUkTY4YwnT+e0ndUq43ge0d0m+/dQG2rsZwaPprLJhvF3HmbBkzE02E2yBJcWldi52m29GE0DKe/siqx3qnrjEsL9PPkzndQbAAkyi6dzeBhIAPDRMR9qsiYd08EmtasGIx9nNJ37a/2yYwqjIaWZZRy6Y0DA2MH3TKJatHKmSzYuL2lFakDZhZirLsQQJWfFNmP2QtaMcFPV+oO5akNx8u1v+hpbQ5raCsngKWiJH3ubn2xoejIVekkKSj+vZKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB634048.namprd11.prod.outlook.com
 (2603:10b6:208:549::23) by CY8PR11MB7010.namprd11.prod.outlook.com
 (2603:10b6:930:56::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 19:56:24 +0000
Received: from IA3PR11MB634048.namprd11.prod.outlook.com
 ([fe80::760f:f0a4:7417:6e57]) by IA3PR11MB634048.namprd11.prod.outlook.com
 ([fe80::760f:f0a4:7417:6e57%5]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 19:56:23 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "bp@alien8.de" <bp@alien8.de>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "biju.das.au@gmail.com"
	<biju.das.au@gmail.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>, "seanjc@google.com" <seanjc@google.com>,
	"au.dang.jx@renesas.com" <au.dang.jx@renesas.com>, "jirislaby@kernel.org"
	<jirislaby@kernel.org>, "biju.das.jz@bp.renesas.com"
	<biju.das.jz@bp.renesas.com>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"kas@kernel.org" <kas@kernel.org>, "krzk@kernel.org" <krzk@kernel.org>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH -v2] MAINTAINERS: Fix Intel TDX kernel file patterns
Thread-Topic: [PATCH -v2] MAINTAINERS: Fix Intel TDX kernel file patterns
Thread-Index: AQHdaOQxn9mA4UGjBkG0GpHfntw09rcbMZQAgAADP4CAAAHcAA==
Date: Mon, 2 Nov 2026 19:56:23 +0000
Message-ID: <efc036144e0506c353fd113d5fdac8aefa4a5008.camel@intel.com>
References: <TY3PR01MB113468FBD8E5EFA65C4B4E5EB86602@TY3PR01MB11346.jpnprd01.prod.outlook.com>
	 <072dd88c-4ca1-4c8a-98b1-7783bc43c1c5@kernel.org>
	 <TY3PR01MB11346BAE55FF22F66E86A6F8B86602@TY3PR01MB11346.jpnprd01.prod.outlook.com>
	 <afdf1864-4721-4177-bc18-2a5821d97559@kernel.org>
	 <20261027205411.GAauEPc4AtLwvrDfFr@fat_crate.local>
	 <7b0a2e98-c614-4cdd-8604-3b5b21e8474f@kernel.org>
	 <20261028154743.GCauIZH3pZm24jCX9b@fat_crate.local>
	 <20261030023338.GGauQCAuYyXGwIhlqX@fat_crate.local>
	 <20261031030112.GHauVZ-OI2KjdkjrcY@fat_crate.local>
	 <953b3d774dc281bf13f5025041d4434f560cf776.camel@intel.com>
	 <20261102194943.GEaujpV134C7Wgx0Nj@fat_crate.local>
In-Reply-To: <20261102194943.GEaujpV134C7Wgx0Nj@fat_crate.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB634048:EE_|CY8PR11MB7010:EE_
x-ms-office365-filtering-correlation-id: b8e3b77d-8231-4b06-81e4-08df391b5f32
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|23010399003|366016|56012099006|261102124527099003|38070700021|4143699003|11063799006|261028144727099003|261022075727099003|261022105027099003|261026121527099003|261026140227099003|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info: /k5lFKLHiYeM4tjlljXVMDhv5Qb9qMvZfJ21qSTpZ4831ijJrhUeicvsR+l6Am5m4Hpeij5mMYaDD44T9jT38Ixvq6LJ2YDAfylz4d3fUpZZ/CZplwtsUdnm1Xl/ne4LgRKsaZi8KkYkUtXB7SgKhV+bLJyRcQC8oueiM4k+QS8d/9InIio7sxKH+vqqqBIln9N8t5/mlUbvc1oqsBkMZxhh3X0Jr6EaaG8tFC3Kb4mGTbbSDa2revwaSkHgD76VbruHvEG6CGvlEzeXpiLtU9eL00ll6/Spi0hI+aMu6e1mG7AJFFH0YQh+GmKkRtWbnw7jcBy8ei8Z8u79BQnbfocV39CVm6kokiyptTFi4b+jAGdIcWP0XQ6tNS/nQY19Wiveb2FwcoFetmuQiUE7Ca9pnWlM0bv7NxKrB38pnclvPd+uchniVT0Zz2IorNRMciwm92GYAh7IMgc5BhiWoLHcihkA4q7qyJoQin6/W+eUyV/rUmoBYhvFFTptmjpGI3D9DKFYbUaXDU2kJy7uGUHXVOvoD3t1yBoElFTxVjaNktb8Wu78MJr94WAGeOMDjCrHVeDXAz7M+reebNzPKxTAfus7JOLRRgCY31XwqgPvQ0w2qIwhEWlS6Z3yNgzCHgr5XQNvsYpK/dZCpCnz2nO+Scw1SQ0FteS4nB9Zj5Lh4kMtbXSABN8iyOvPFApqzJuRIBvgvCqE16no015pXDIwyPY6l4xHK5dxVBdUbRQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB634048.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(366016)(56012099006)(261102124527099003)(38070700021)(4143699003)(11063799006)(261028144727099003)(261022075727099003)(261022105027099003)(261026121527099003)(261026140227099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SmV4emVrNDB5UkpzVlNyV25zWll5VzlaZHYzR25YcnBIMW1MWjl1Q0EybmRl?=
 =?utf-8?B?MW53N2w5NXhqamc5WjU3ZEE4S3EwVWNjZEY4NFFTMlI3bnNMa3F5WS90OVJh?=
 =?utf-8?B?L09heUpDeWcxb3o0bnlDOE1vK3N3cy9pSnFFbk56OXdhaWhFZ3VuczlIRDVn?=
 =?utf-8?B?NGk3SiszQ2VEMlNQS3J6VU5JQ2ZGMW56d3BKR25wMjdBZyttbHJFdERuV3g1?=
 =?utf-8?B?MW9SakRqT1o1Q2dTOU14WTg3bm1sZmVpTm5DRjFUU0cycC9KR2pGUG9zcUlq?=
 =?utf-8?B?V1FDMExuT1RyMmJSaTBFZzNUK1FOY0IxbS9yWmtLTFR0WElWOG9LM1l1VzVD?=
 =?utf-8?B?SGtRT3NXb25MM243QkdJekZ6WmRid2JOdmlkZFpoNGZ5RDZISHd4SlVjVVQ2?=
 =?utf-8?B?NCsrcUhaMmZiRS9XZG1KV0dJWmI3ZW43Q2FoTEZRVWIwRFB6UU9hUU51MVNm?=
 =?utf-8?B?a0Rvai9ESGN2ZWtSeGZyaFJGUGxJbXJVeFlTTG8ycko4RWNEc2ZRV3h6WFBt?=
 =?utf-8?B?M3lFaUZZNWpNcjdDR253QU83dkt1RVMwZnV0aEhtTTJucHZOT1NHMkZ0WlBJ?=
 =?utf-8?B?VWMwdDVmLy9hM1Z4WnJLQ0NoQUx3U1NjTW5xWkt0VVc1bU9KZDUxYVE4YzNa?=
 =?utf-8?B?MyszVDYvMC84d2gxbHBKam9rK2dCVzY4NkttVksranIzRmN3NmhPRTVnK1hX?=
 =?utf-8?B?V3p6MklDN0JXT2hvcUFNWHEyc3NLQ0lBR00rU0lEa3BTc3cwM1MwQVlib1Ru?=
 =?utf-8?B?dGZ2ZElUMzZkMGZndjB1Mzd1RjdVRkptWXhqSDdRcnNtcndBY0pGTHJGeEFD?=
 =?utf-8?B?WTZsNGtqbWFFVHFZMHVKRXhrM1R6K0RJM0dTT0FXWE5CZ2VoZWVydHBpd0I2?=
 =?utf-8?B?ZDBaZ0tEN05taVpZOWhVZ3JaQlh1M1pHRnhsYmc0VDlUU05RMGRad2I3eWRa?=
 =?utf-8?B?WnNZYi9TejdtbUgxaXNXZnU4eTRkaGRNejJjdW5TbHovODR3dUxIUm5IWjZl?=
 =?utf-8?B?NWZCbnZRNGZqMU0xbEp5aEdSMnlqUVVidjZYUEhNUENPWk5iNCtKaVBQY3VD?=
 =?utf-8?B?Wkd1Y2lpYXRtWHVabS92L1hKTHJMR0xsSWo4RWpYMVczWTI0MjlIWWM0VHBH?=
 =?utf-8?B?b2Rkb0dwMTJNQ044UVVyY0NtaFh6MFZDdzFMV1pwRnRKZ2tlYjdoNUtRYmJi?=
 =?utf-8?B?Y2ZEYjdHSEg3bXlBQ0xnbDFaTE9wVDRJUm9qSTdsdXVING1oc0sxSHhHNm51?=
 =?utf-8?B?RS9tYVd3L2NHMVZSYWkvK2ZkaEVzWGJNQTdQN00xa0NLdWpucXVMQjFqM0RH?=
 =?utf-8?B?ZlhLQUo5eHlYRzY4aVdMMCtMbG1KckwwSFNua2NiV3dwUHNKVEk1bmpTNmxm?=
 =?utf-8?B?VmduZmtIN1pRL09uL1NYaTlYdTYyNTFDZU9Bem14OG5sTWRiY0RhSnhOcmRH?=
 =?utf-8?B?djJudDdoWUxiSU5PVTRNcnhLcytGQXNLcE01ZC81bUp2YlM3SlpuM1VQVXpt?=
 =?utf-8?B?ckVVcnU0QlB4c1IvWVF4V2hKMTM0N1hmNE1YWndDYzU4TlF4QXlZcld2b1M0?=
 =?utf-8?B?MWVOMmpKSUZsNUt5M0dwVWFsa3NmblMwT2FTdXZxanhzSWtlaG9wZmg2Q2N3?=
 =?utf-8?B?R1VrcXZDcmlOeGtzZXpmenVrM3hpNjA4MzBHMnhSL3FSVUJDUnE3WVEvYm5H?=
 =?utf-8?B?UmI0TTZXbTROSXRFSDVoMUJIdTUwSGhQelNzcHVsZkZ0OXBuQlozb1FuWXUx?=
 =?utf-8?B?K043M3hXMHd3VVRUVXAvMXdIbnFPUDRNcEFnc3k0Mk9qczl2ZVMwaXEyN211?=
 =?utf-8?B?eFFBbzY3b1lJTXhCMHJodUdlZ3VtUkd1WWVEa094RjlPWUFiN29BL1BWSlg1?=
 =?utf-8?B?THRjaXB3QkpOaUJNSzZ2QUMzeldCZmdTWjdWQ0l6ck9pTTdjb3AzRGlQazJW?=
 =?utf-8?B?Sm5oTTl4NVBDSFZ3TGpMODJZbXBwa0tBWVlCSURRbUZ4d3RYMENWUm1nVjRI?=
 =?utf-8?B?bEg2K3dubGpRdUpKUE5MWWJsRW0xK09WSjAvNSt6dkxldFFzeG5EcHUyUnZ2?=
 =?utf-8?B?SVBhUXZtWmZSVzR4OXorSzBlaVdGLyt6SlgzTUkxK2pVZmNUdGU3R1BUS3dq?=
 =?utf-8?B?OGt3MTRVWm10T1F4Y3hQTXkwaVpMbjUyL3g0Y005Z09sUlowTlU3WnUyQ0FY?=
 =?utf-8?B?N0c0OTh5L3NRQVd0UU5VL2lUa3AweUd1NXFwdkI2V3k5aXdSeUdoSC9uQU9R?=
 =?utf-8?B?YmtlOUZaN1BRYTRTYSttQjNseEl0dU50Si9YbjdNM1F6OGVZd1hHbmt0WE5p?=
 =?utf-8?B?ZXo3Y2FPaktwQkVvbFdnekFtVGZsb05LdFFyaVpYMURRbWNPaHlTMTJKZyt2?=
 =?utf-8?Q?cJ8n6QHq9cxlmfZY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <50982E1811954D48A7EF56950767B2D4@namprd11.prod.outlook.com>
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
X-Exchange-RoutingPolicyChecked: KqfXIaqgEY5HJjc4pIqORGpp3/oHwRRUR4QlQVQgHqOLKkKFUmd58nRgfVrx7zY9pIjCXUlRnoCBDPgYrhcnI5vgs2dc67gnDV0Cw30C8NGYH/mZpNG1MhtaD4dWV/4bxy5r6/H/aE9IvGb05yr4oK/Ok4Jl8YzsjHH96tbkn7C/eOZiFkfkkjqFR6eK2fnpHRvLpSoxowbh89DU0gC4yFcqG8hsQEnOqbCpZLSEXUHfKHgtI9VLwnoGQI4HlFuDIBaJ/76DGwZzOzDKMZF+US+C5Zj/llNGhpL0qKX7sGS7K4J7cXUk57SWQqKazUgz/eTvbWltWybjrB25djYtrw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB634048.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8e3b77d-8231-4b06-81e4-08df391b5f32
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2026 19:56:23.3476
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D0Ef3X+Ff+VjPk3XrJfmr1m5gmbpeOwMGtSVMmX9LDR+YvtJu8HYbHtHFA+bfnix542WmqC6bwTsH+hs2QYjDwHRkbq/DC4kK2hXujX0/vA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7010
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI2LTExLTAyIGF0IDExOjQ5IC0wODAwLCBCb3Jpc2xhdiBQZXRrb3Ygd3JvdGU6
DQo+IC4vc2NyaXB0cy9nZXRfbWFpbnRhaW5lci5wbCAtZiBhcmNoL3g4Ni9rdm0vdm14L3RkeC5j
DQo+IFNlYW4gQ2hyaXN0b3BoZXJzb24gPHNlYW5qY0Bnb29nbGUuY29tPiAobWFpbnRhaW5lcjpL
RVJORUwgVklSVFVBTCBNQUNISU5FIEZPUg0KPiBYODYgKEtWTS94ODYpKQ0KPiBQYW9sbyBCb256
aW5pIDxwYm9uemluaUByZWRoYXQuY29tPiAobWFpbnRhaW5lcjpLRVJORUwgVklSVFVBTCBNQUNI
SU5FIEZPUiBYODYNCj4gKEtWTS94ODYpKQ0KPiBLaXJ5bCBTaHV0c2VtYXUgPGthc0BrZXJuZWwu
b3JnPiAobWFpbnRhaW5lcjpYODYgVFJVU1QgRE9NQUlOIEVYVEVOU0lPTlMNCj4gKFREWCkpDQo+
IFJpY2sgRWRnZWNvbWJlIDxyaWNrLnAuZWRnZWNvbWJlQGludGVsLmNvbT4gKG1haW50YWluZXI6
WDg2IFRSVVNUIERPTUFJTg0KPiBFWFRFTlNJT05TIChURFgpKQ0KPiBEYXZlIEhhbnNlbiA8ZGF2
ZS5oYW5zZW5AbGludXguaW50ZWwuY29tPiAocmV2aWV3ZXI6WDg2IFRSVVNUIERPTUFJTg0KPiBF
WFRFTlNJT05TIChURFgpKQ0KDQpPaCwgZG9oISBPay4NCg==
