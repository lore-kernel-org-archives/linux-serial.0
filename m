Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4E73B3BEC;
	Fri, 17 Jul 2026 07:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784271737; cv=fail; b=MwFJknqzN65m9eFU3CNeeDoWY1jpcBjebO3rZWhMTJQ5zqfeg6oxqIya2pg9hZn6zS5B8CQZ4xU5haYObOBVQILlzY9dpMgbQinW6SqY+xz35ppXNiENodSY9jjwN/7vkg0LIUsC8yXNLSNFnAHpQq4ulIkl60rEZTvfTCRDcFQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784271737; c=relaxed/simple;
	bh=/dUt1iBOzGlVZExzUIKIBpfvVVu5IzSACFMbO96A7GI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eOPTClGHV+CKMZTqaMOuvqZTa1NKs5y8M6rTD6OU7qKYJIKqMhbxheZYdQv5Xu1S7li1d2VxmRRFV+abk5YJro1pLVYl4hKmwsigSTAzC1f6oyuzbOMZjJkRh9jQcc6O1MN6Rk7PXBT3cMx0+qZS9pSEcjHHBB45RjkxdKHN2Kw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gxosxa1V; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gxosxa1V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784271736; x=1815807736;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/dUt1iBOzGlVZExzUIKIBpfvVVu5IzSACFMbO96A7GI=;
  b=gxosxa1V/hwJwXrRavYZl/bB88eeibCm8LfsraPtjVPhQ+C/i2GK1c0q
   DBnKe8MZhJ3dVPEm2hYeq52hdmuXZXvQKQ8HpJIYvDb087AXKLtjhoM+a
   2HA6ElQ1DiVeJJPH8hivyVXmkixP7jQ/c9LFsW2hYVv+1phPSgIZ0fDoY
   vJUDHPmibRi9F8Rp7NAi26YwhIN8oxrxWHm89By6p2sw0RTGcgzxsilaw
   AlxqIH7Rc/WOT60ykJSTUFEUUafO+i0q+4WXZN2SXrOE/XlvanjlmK4K8
   FWV1Gi4vvppOtuV4AMtWYhVlqnViWS0gPm9kOcQ01GUv7e7orWK06oZUt
   Q==;
X-CSE-ConnectionGUID: 5jXJPA+3ToCgMeBaxEL9TA==
X-CSE-MsgGUID: XeieLKzAS9Ot6exa7df1YQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11848"; a="84717176"
X-IronPort-AV: E=Sophos;i="6.25,168,1779174000"; 
   d="scan'208";a="84717176"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2026 00:02:15 -0700
X-CSE-ConnectionGUID: GwcrwLRATdKnlJnXF4Scwg==
X-CSE-MsgGUID: YXYeN//IRJqnKs+tYAxRfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,168,1779174000"; 
   d="scan'208";a="257343686"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2026 00:02:15 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 17 Jul 2026 00:02:14 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Fri, 17 Jul 2026 00:02:14 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.7) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 17 Jul 2026 00:02:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qrO+J1RmqltbnGWEYDAkgxoT7towrF7+blmduuSeN0/XtiAMQwFDJ0w8YRMqbWYow1/LZb2VkhK7HTwugM6ebHSz4Yg4Ie6RsdD05e+yDI36OCvirKzRyO60yb/shVDsjSA5CSNdz31CNDzRWbXBu/3CCz7pTXfHcdrr4oCsSZDNnoyndq7adX0tefWGTwdbKzRGHcuhHWFk4zNJfy0NRzPacNdxOaj+ughdKemGj7ZiK4iHKYSbl/OImnTMbv6ZvsmuAs9brwr4QLaGHWCeDTKve8ifcIWZdSzdmfTz4gcdS59Zer/o0gdLdwAYn4mlNXSOh3iVqpD+WK9C7W/mDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/dUt1iBOzGlVZExzUIKIBpfvVVu5IzSACFMbO96A7GI=;
 b=PV2St9GAM1wRijffQO4iEffhtAogl1hD8wHCOunu+CjnEfTS8DD4EXfO3iZVC9SjRK+RV+UfiVMj/3tUsfOAeNjwa9mX0TSYf7H0LNylUO9XPYbT8O8uikLJ+ZNLxPGHlfKShv8VbrShcEdzMkKwBPJM8wFlheT78EGfHGK7tBcwsISOFQzPTysEhaAOsojnWUAyT6bSGlvMqqs7kxx/DEbiafzojVsq20O2/kMg87aHI7+IhQ5DNxvaAm2ywwpCVaW7rrjjy0fL0wbNTABkZAQ5+XFP+myO2mULuvYy5oaMBb7xMKRUgViJkoXZ0edpk4yPD+CvSdNUgAN9kMtnGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5902.namprd11.prod.outlook.com (2603:10b6:510:14d::19)
 by CH3PR11MB8590.namprd11.prod.outlook.com (2603:10b6:610:1b8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.11; Fri, 17 Jul
 2026 07:02:05 +0000
Received: from PH0PR11MB5902.namprd11.prod.outlook.com
 ([fe80::f95a:602a:34d3:5d37]) by PH0PR11MB5902.namprd11.prod.outlook.com
 ([fe80::f95a:602a:34d3:5d37%4]) with mapi id 15.21.0223.011; Fri, 17 Jul 2026
 07:02:05 +0000
From: "Jagielski, Jedrzej" <jedrzej.jagielski@intel.com>
To: "Zhou, Yun" <yun.zhou@windriver.com>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "jirislaby@kernel.org" <jirislaby@kernel.org>,
	"socketcan@hartkopp.net" <socketcan@hartkopp.net>, "sdf.kernel@gmail.com"
	<sdf.kernel@gmail.com>
CC: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
	"mkl@pengutronix.de" <mkl@pengutronix.de>, "linux-can@vger.kernel.org"
	<linux-can@vger.kernel.org>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] tty: ldisc: fix deadlock between ldisc_sem and rtnl_mutex
Thread-Topic: [PATCH] tty: ldisc: fix deadlock between ldisc_sem and
 rtnl_mutex
Thread-Index: AQHdFO8eoCMizjyZPkygekKVlBK1rLZvx+9ggAFKxgCAADZuEA==
Date: Fri, 17 Jul 2026 07:02:04 +0000
Message-ID: <PH0PR11MB59028DA3D84E76C5AD285A35F0C62@PH0PR11MB5902.namprd11.prod.outlook.com>
References: <20260716064719.1401892-1-yun.zhou@windriver.com>
 <PH0PR11MB5902C0DC3D8407F2701948C1F0C72@PH0PR11MB5902.namprd11.prod.outlook.com>
 <70f854e7-b066-4f30-8ebf-71abdece45c2@windriver.com>
In-Reply-To: <70f854e7-b066-4f30-8ebf-71abdece45c2@windriver.com>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5902:EE_|CH3PR11MB8590:EE_
x-ms-office365-filtering-correlation-id: 88097cce-ca9a-4fbf-d8a3-08dee3d14f39
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|23010399003|1800799024|7416014|366016|38070700021|4143699003|6133799003|10067099003|56012099006|18002099003|22082099003|11063799006|5023799004;
x-microsoft-antispam-message-info: B7T97dQnjbw+8dFyvb5DkIehZnmgspjK7Mvk2v+nWKeP1UUv93CDu8lez4sGjpwSJ7swYeR/b3j8zFCq6fynPZzp/1cYVAA6jJB0oBVtRI5tnT+0jmXJF+zUmY7bURhgMAj8hDelTNhHLnvwIgAG7FMVYjvveAA4bCxOupeTtqv18kLHe1l+TyRI1iqKZ0aqrqQobi+h0dWjM8ufU1WbLAnkw/6xfj8AdkrnCxr1HzVE9D3Hok1K9eLFae4k4D8Z2ClZBUNNoEX7eGI6X/GhoB7VNoYW4xm4LnN8l0M1etL4w6u3E7KDGt0iBM8bcspdXAFgDpvkEa84RqQnOAV71AzaHT93UxuHiXRrK3ffAsoY9SvGhWw3phSVjNFr3JlSOA8I379/KozPDLzhKcbTjPsLx71SPsZNDfmGAkHeeEsiGffCz+m4e4+1M6ZGwYw3ch8hDezeKqWNBmxt0Z15XKnyGPbaQxGoSNHlFL04IyxLQqCJXgAFwE2nVht8mHYRKrT3Kbt2BvEpogIwB3nEB3kjKZXiVCiwJxEQ0Zr7rjFRCXSAzWoQ4Q8wCHx0hXWdLb7xZRu9F+Q94bwHutbhudUJuUy5Jm3ZO5+DW6XNr/6nolokAJbZrSCONHXFoUsv41ccjJhtrepDffiXNE/PrZVI44ZNzWpjQLfocFHIXC/Kiq0AH4tmwd+A/kHa2a15YQH0gtYsawGEcmtP2s8wAMrABamA2oBoxm2G0z8F+rE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5902.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(7416014)(366016)(38070700021)(4143699003)(6133799003)(10067099003)(56012099006)(18002099003)(22082099003)(11063799006)(5023799004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cnd2OEkyVS8xekFrc0JjcSt2T2d2b1dMUjQ0a04zeUlybVBoRzVuN3NRZHQv?=
 =?utf-8?B?eFVUU1drQkgyUEIrMlRrdlUvZDc2RXFIaDMwUEQrUkM5TXlCa1F3ckNYSC91?=
 =?utf-8?B?Mks4d1VDODZweTJxT2x5alhQbEJqdkhFQkxNeVo4dCtMbU83QUtIOVErZjhO?=
 =?utf-8?B?TnVVNk5WMWIrU0FMSENwdFp6K1c3MnBCT2hLV0dDNGN6TThWQUJaNVFaaU1Q?=
 =?utf-8?B?NDB5WGpBOUlqVjJUcjZQNEZhSExtaVpvL05xK1dwZnR0bkl4L2h4NFFqM05H?=
 =?utf-8?B?WGozQ0R2ZjZiY1dEMFoyVk1VcThTL0VmbXpCMHl2bEtodGdlOEtad1BXaERQ?=
 =?utf-8?B?c0Fmb3pIUzFLczZJWlpwNW9saytEODJYZVNQbWt0SlI0UUpNanQ4czZqK0dx?=
 =?utf-8?B?N1RXOUg1NmFHeVI3aXBUZ0J5M3gvUFVBSmtFTEltRDZOOFVUbytPZlcrcjJ0?=
 =?utf-8?B?Q3E1ZlJjZnBTK3lyOFl3QlFRUUcxUGMxV3VhcXNtdkF6RUNqcXBESE9qbDlk?=
 =?utf-8?B?Ykxja0NuWjVreUFyNjAyMHk1T3BFSmxZNmlJczdPWjNTNGN1ckRtSjRTeWZu?=
 =?utf-8?B?K1V1RXdYMlZ4MTVVaTlWWGFSUnpCN240akJQOHlScmJ4WVpMbGhCQzU1b3BG?=
 =?utf-8?B?dXJpa2FDRkFWV2VCdWJCZkE0eHRWUFZ6bVBxbnlOYmRlaXJuTEVUN2J5VWtV?=
 =?utf-8?B?V21kK1psUG5VRWJuRVFwRWVzQmQwYThVNk5sKzRvVk1XY3c0c2xxMWtuVDVB?=
 =?utf-8?B?NUtxbi9DUWdlZUk3SUVqbU9GUk9ZUEpFb1hOckdzMVpnZTFMWkNlaUoxZTZs?=
 =?utf-8?B?YkM0ZUg5cUwrZFl4L3c1djFGV2pzdFFBT053K1F5aFRQb2dYZ3ZBbmFqZzFa?=
 =?utf-8?B?bEliUm92aDcrNnBNSjVmaG9lZWlpRmt3UlRyckJqRlFRb2NuYTlxRlNwV2d2?=
 =?utf-8?B?TVR6WXh4dDFZQkRBK0JJYVJSc0RtenVkRDBXOVJrbmw3T0srSTkzQXBFTmk2?=
 =?utf-8?B?NlpKYTB0MDFmRUNnRWZEekp3cmIySGNBZDVEdXA4YU1sZ1RSVUpEMm9remVK?=
 =?utf-8?B?RWs1REg5cit5dk5FUjRLMElqbURHTFU3SXU1Q29WYlplTDVXWlRiKzQ0eHh1?=
 =?utf-8?B?RlhPT2hicE5WU2N5cVZTblh4bjJNVlg1Sms2OXRLSGM3ei9rQ3pVSUtiVUdy?=
 =?utf-8?B?VXBpUitFa0hGWHl5UTNMOE41Q0hmczRONDhVbW1BQ3NnZTg4WTgyVTZjNW9w?=
 =?utf-8?B?b0piV2hYdTFkaktjdm54WGo0VTNQUFBHdHNIb0dYSEl3UjM3aitFbldxd0ZI?=
 =?utf-8?B?UldMeHd0Mk9UV0ZTUnVGYUNGRGlDRDdRQlhLaDRWcEV3VXpYTVkvWGpxcSsw?=
 =?utf-8?B?V0krNkl0Rk9ORC84cU04R3hyZGViaDh0WERIQ05oSTdiSkpSdVQyWFFqMUFL?=
 =?utf-8?B?bXpHNjBKS3RKYWlyOS9SODlRcm5VL21hc2R5MUtza1dxMGZJcHpsV1RDRGl0?=
 =?utf-8?B?Q3BRVElVU0dTVEh3NEROMEVtOUw3VG1GOEZxR2pRMGRYam1XV3hsSlRtN2FK?=
 =?utf-8?B?TDk4bGpNOEYxVHo1cWNqTjFwRnJOOXZGNnFWdjlXclR0cWpMakZWZzFCMHov?=
 =?utf-8?B?enQzQWZWNTN1MEdpSDFzdmYzOWRNZnNPcGxUcWY0ejM3K00zajVMaEgwdEo4?=
 =?utf-8?B?ZHhHOWtjYnIrQjZwTWN5Lzd6dVNNZktiQjJER0RWamVEMmtKcmhOT0RZd2NM?=
 =?utf-8?B?TnJqZW5jWXdoV21PTkFxSnlnVWxqUzFDRWRwaFFqMUFUYXgvZWNoR1ZpUmJq?=
 =?utf-8?B?M3I5bWdZNElTV3k2NnI5dThyWlA0MTZZNHlHekZ1Q2FiS2Q4bzltVi9KTDBn?=
 =?utf-8?B?ZE9oUkhiSzlTUisyNXNkL1B2R1doeEhYSktiYnlXY3pBZEk0ZTA5bUpxczZm?=
 =?utf-8?B?WENKeGc3NmNKb2k1UmlZblBCM1luRUhFY09HcDRIanJ0RHFnS3JaQkM0UGda?=
 =?utf-8?B?R0VnZGEycXMvWUxEbnovRWdRT0hoV3FyUlVvcDlyYU5Mb08zZmllZ1Y1d2NY?=
 =?utf-8?B?N29OUFRDaTZHY2hXKzl4ZU5MejFwZWQrWWJKNHhFUTZDVUFDZEFCeUpvWjl0?=
 =?utf-8?B?K0tUcnFhRWc2SUxxSlNOaEJRbno1NmlZVjh3YUs0bzlndU5aVWxQOGkxQ2ti?=
 =?utf-8?B?QnRJQjNpcXUrRU9nVUNnSng5Vjd2ajFJUHF2bTJPRk54VjhSdUI3cEcxLzlD?=
 =?utf-8?B?UWR2MW1NZWVGd0REa2o3K2JMaXU4TGVXbi94QUFVbmdCYXlORzBvaklWQWtD?=
 =?utf-8?B?dlhNc2o2NE01c0ZGQ05TVmNHKzBoUyt3Q2hoT0toREh3TzFSdnpxUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: WFuF3Meyadc5Ag41mQZ4QEzEl33Tc+YYYSOnXB/eh/80hZvI4bPB7IeX5SFyuyhA7h7wFaX7d1dDhFP0hpdcrfSDaTzcNpG0JBXCtEaDerygjZW5dF1wKvRCWX9mehVhCn2kvuLobkue2PXeC9kLAzbK09pAmiwL/YY0GSVGfLhJ24TNzoC4n4oxEG04llNejk4oniFS3ei0rSAIZAuzPr54DRX5cOSmacpD1b4r+lhrQs5rqnXJ9BujWqxXVxqbMCOb1ljmcDY8a2TUsKSfxORgBejaS7MWN3ic4EM2E8YAe35HwDT7mzSXaLB0bGiKt3rnyp/SvMgWtF9ToE4big==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5902.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88097cce-ca9a-4fbf-d8a3-08dee3d14f39
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2026 07:02:04.9926
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OhuNjyjw0kF2QG2jqxlEtXQxZZq/pJW4Rn5+TSx94uJ/z6iQMJABqlWCXdd2E+WLn5JQXHByTjk2GrnYAb1dgErsy3zKocHyvQccbKfILVs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8590
X-OriginatorOrg: intel.com

RnJvbTogWmhvdSwgWXVuIDx5dW4uemhvdUB3aW5kcml2ZXIuY29tPiANClNlbnQ6IEZyaWRheSwg
SnVseSAxNywgMjAyNiA1OjQyIEFNDQoNCj4+PiArICAgICAgdHR5X2xkaXNjX3VubG9jayh0dHkp
Ow0KPj4+DQo+Pj4gKyAgICAgIC8qDQo+PiANCj4+IHRoaXMgYmxhbmsgbGluZSBpcyByZWR1bmRh
bnQgaSBiZWxpZXZlDQo+PiANCj4NCj5Jc24ndCBpdCBjb21tb24gcHJhY3RpY2UgdG8gbGVhdmUg
dGhlIGZpcnN0IGxpbmUgb2YgYSBtdWx0aS1saW5lIGNvbW1lbnQgDQo+Ymxhbms/IERvZXMgaXQg
dmlvbGF0ZSB0aGUgY29kaW5nIHN0eWxlIGd1aWRlbGluZXM/DQo+DQo+QlIsDQo+WXVuDQoNCkZp
cnN0IGxpbmUgb2YgdGhlIGNvbW1lbnQgdW5saWtlIHRoZSBsYXN0IGRvbid0IGhhdmUgdG8gYmUg
bmVjZXNzYXJpbHkNCmJsYW5rIGFuZCBpbmRlZWQgdXN1YWxseSBpdCBpcyBub3QgZm9yIG5ldyBj
b2RlLCBpdOKAmXMgcmF0aGVyIG9ic29sZXRlIHByYWN0aWNlLg0KQnV0IHRoYXQncyBvbmx5IHN1
Z2dlc3Rpb24uDQo=
