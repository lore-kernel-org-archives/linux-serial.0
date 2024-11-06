Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2045.outbound.protection.outlook.com [40.107.100.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C9E1D278C;
	Wed,  6 Nov 2024 08:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730880815; cv=fail; b=seieEFZqDBFAzScPxJBRY2a1jhDD95WKwKBYsIAk/4da02XQKNxrSr85OoGXfLRgXfIjbp69/cBTWhoJecXGURArvjgrxmd+LEiQgtw8PmBxWI9EV7J7m+HhvRcjb3iGqFRICyBzUDGGNb9d+NBZHxfPU49a/ZbMK0fXc4TgdRs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730880815; c=relaxed/simple;
	bh=fTFpmB+JXyTSzBUJ/gUuPSsygDXPoO6GbPTOm4QaCuc=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CBi90gchnb8mK/ezczJaOhlUKR+qtG4dl+yvUIinxkfXqllpbTJ+/utAyn+dNdn7muHz045D/UmZkEm8L+RvFRgc8q7TD2FMVAUqTfMfFc444ymk8z+VMPDI2W6nzrOciHbZKyjPrczaMfCjHHKH3sPsfvDzMty6P5J4CeGII18=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Mod4WPQO; arc=fail smtp.client-ip=40.107.100.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Mod4WPQO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gK+u5N1a0+Xn2/qwc7dkta/ciq43Tyd+yIS9dtnzwstWQKXR6Q/4v8TrwVfPLHKNTnXxXBfG8Exj4A1Bu61Lujz5unRtPIob3siIpZWa2qByMmTYqY89MFcWbI4iSNmWTKmZl6kH1PwqOdIHnnEArHZGlyi4gieEC6wkN03J7EXZtwIJBQ/ajqugsdACs2B3ufXR1rG7Kri2IB13Hkpmneou04ynVsx2Myfk4DXrZcsAjgWzDkmeyYGI4UGEcHO422UOgwpAOKsB+gVRXJqFo13Hqs9jJpjbmulyRbnf/fjsJrIWdWORcR7jacCRgg4Ryk4JZHNUfburIcaaNtNUbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fTFpmB+JXyTSzBUJ/gUuPSsygDXPoO6GbPTOm4QaCuc=;
 b=FJ1YGyEAQqEoC42tDfT03LMFW1vSQZbUtCg13nJBqplCqMbbEz7/plBh8pb+hX04SyLr8YSUHt/0JwomsMTB8MzMpDn4WnG2uK/qqagziKIhtklWivWjAozhtaXJvAL0NRYLfR0rzTPwIzIMeiw+cotpuUVtrst9AA09u6uWGOmDU/6F+npDJvt2Tghln1PHSzGeO/bZvLUiPjNQVkuGv7iiSfCbdcSbWkYmJTlJQcL4cpMctg017ukX2h/fKlnMQsBD6t8i3qAvPY83R4W/AF+OYR9NUxt8rmmcNfzkB6I5yvvOmivwl5sdsTi0Ipmqzkn9On/NJTkw0pfBawhKvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fTFpmB+JXyTSzBUJ/gUuPSsygDXPoO6GbPTOm4QaCuc=;
 b=Mod4WPQOPtiCNLZqpcCUklcHC03jsc4s4Df0Db33kkXuqmdeZUggA5Ur+QqP80tEsb5SX52MtB34imSkKxZFOngJfbkYMCM1itrpfDX4NIiniZkm0KQ5dz7h6uc6Z5QeS1gmezNbSz9xy6XGYb/cL01Vqn2tNQTdiwvXNwJbO+gJiUspc4S5rOXxmKmFh8uHJtp0znARrTuW0QOF2Auv3WGB11xDS3+iZ8Nnbt2i+2KfgZzIdHdAMYFAELhYXbUW8ZsPr1bZpDxFwJCBI1BHuZH2fcxB2kZ9uLWuIMqxJEd2iNcXdP5cD1H8Hr313DypJbvtXXti+mdh5PJ40bRB5Q==
Received: from DM6PR11MB4185.namprd11.prod.outlook.com (2603:10b6:5:195::29)
 by SA1PR11MB6808.namprd11.prod.outlook.com (2603:10b6:806:24f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Wed, 6 Nov
 2024 08:13:29 +0000
Received: from DM6PR11MB4185.namprd11.prod.outlook.com
 ([fe80::1692:c829:d50b:8c30]) by DM6PR11MB4185.namprd11.prod.outlook.com
 ([fe80::1692:c829:d50b:8c30%5]) with mapi id 15.20.8137.018; Wed, 6 Nov 2024
 08:13:28 +0000
From: <Hari.PrasathGE@microchip.com>
To: <Mihai.Sain@microchip.com>, <richard.genoud@bootlin.com>,
	<gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
	<Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <linux-kernel@vger.kernel.org>,
	<linux-serial@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] tty: atmel_serial: Use devm_platform_ioremap_resource()
Thread-Topic: [PATCH] tty: atmel_serial: Use devm_platform_ioremap_resource()
Thread-Index: AQHbL4VrNPM00PhkA0SWGWqF0pQw5LKp6HiA
Date: Wed, 6 Nov 2024 08:13:28 +0000
Message-ID: <3a1bfe36-ea7e-4296-9cea-d5265baa298d@microchip.com>
References: <20241105131946.22449-1-mihai.sain@microchip.com>
In-Reply-To: <20241105131946.22449-1-mihai.sain@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB4185:EE_|SA1PR11MB6808:EE_
x-ms-office365-filtering-correlation-id: 60df2197-cc74-4853-d141-08dcfe3ae4ef
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4185.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|38070700018|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?T0JJeFMya2dGWDA3L2I4eWRNTWdPRVg1SHRYRE9xZi9Nd1dWbVQ5aVlkbVhm?=
 =?utf-8?B?UTloc1FFa0RuajlWL2JJR2IvLyswajJDc0FyZ290NGNmUmtEOFRRczdWVjZi?=
 =?utf-8?B?TlFUaHM2aFpBSzI1WjJ5aUFCbkMzWjFmaXRJOHZkc3YwN3lQK0M5NWhRczJO?=
 =?utf-8?B?R2FmM1JtWkJIVWl6UFFWTnlNd1RSNzcvRWdlcHV0UWo2ZUttMnl5Q2lXMlJ0?=
 =?utf-8?B?cHhKSk1IK2psNFQvQjZwa2VqaWF2SUFmZlkvZlp4SmlXcGMzWktNZXBXRWNM?=
 =?utf-8?B?QUN2bWpFbHdsUGszanpKY04rZkxjL0tuZzhJTnovMTNZWmRpKzJvR0VWdWdq?=
 =?utf-8?B?TitRdzVEY1dYSWtFUVZ0NkdBcWhqM3BDbGNLZURRdXYybG1kQ2FQcDk1RjRW?=
 =?utf-8?B?Wk5nSG53QTFJQUxqMFlrR3BWVEFFd2dhM0hJUFM1YUE3elJwbGllbGEyUlh2?=
 =?utf-8?B?R1ZYK05OdUN3UkpzN1diRUI4L1NRWmRuTWRLTzM0cXVlcUpVZHhwTFNmcHVC?=
 =?utf-8?B?RmlwR3NNWTFXZTZmUUVDVS9RYjNpMWVhMERjY1FQSUs4Q0FpM09ZMWh0a3Qy?=
 =?utf-8?B?MEhkcXhOd2lFc1lkbmlQU2NaMWNKN3pXR3FGVCtrQlFMYVBjY29KU2ladEdU?=
 =?utf-8?B?NWtySHJka1B6L0xWNndXektEaHdKZmJOd0RUV2tINGhFMGpOL1gzeXVwc0xr?=
 =?utf-8?B?N1RsSUJiSnRpMUhJUHV3ZG5MVHdHT0hiREhZVDFwbkc2OWpmUW51b0pBUXEr?=
 =?utf-8?B?V1RFMnprNmlGclQ0TXlvbkdoME1IYk9tOHNhV1UvT2VyOGpsemFJSGROR3dO?=
 =?utf-8?B?WXFBd3ptYko1RTBSNUFnYTJNN01BRkNoR2toUkNneHJ0bng4T3BVdld0WkVh?=
 =?utf-8?B?aENBZEFRaklSY21KaCtMQnUweVVianB1eGxia093M2hKbWhxTjhMQ0MwV0xZ?=
 =?utf-8?B?aFNobGhYUmczNUFxQ0kwY1dacWhLekZDYlFGM3VXTnhIOXZWbXdOSHQwVHl4?=
 =?utf-8?B?YmlFWXh4MDBaajBoSXFUcmZBVUdiZTBQSW5td21ZK0xxVC9SRGFNcW9QN29G?=
 =?utf-8?B?Q2pGSThMTkZKcTNlY3ZpTHZ1N25iTHhUSVBpKzFyMHVva0plYWRzdGo1cG1u?=
 =?utf-8?B?Ny9tYklILzJDNytMVVB1TDB2VHlOMEI0R1p5NnFSTlBzZ1E5aVYzS3Z6L3VU?=
 =?utf-8?B?VUhZMzd0NEF0OFc1T09RT1V0Q29TNm5qTnVhS0sxeTVBdVBRV0F3WFAyWUFW?=
 =?utf-8?B?d0F5SFIyUVd2ZTl6Skx6ektBV2p4b2RkcE1UZCtjeFBSa2pCRGRBVFZuTk1Q?=
 =?utf-8?B?cG5GdThxMzZaYVBaVmZjakxsSFBWd2FMQkt3UlRZWnlXeG90QTFEWHpmTGwv?=
 =?utf-8?B?L3RQZjg5elhoZGtIUFlPckRMR2Nlc1kvS2Vkb2cvVlhHYjJhTXNwUC94K2cv?=
 =?utf-8?B?RW1kdTRiMXJNbVZvancyQ1RBby9VOUo3VHp6Z1NhNWEzb0t4Vnd3M3NMNUVX?=
 =?utf-8?B?NG5JcGoxckFwZ0F1cUJOUUxkck9tbXN6V044OFl6UEhBWXRibjgzZ2ZjTmFz?=
 =?utf-8?B?dWFZRHdzVlpOQ3NKTzZRT0dEQmcxcW1YTHJyRW5BajE0VGR2T3c1c0R2cS85?=
 =?utf-8?B?Tm10NHR4VW5raW5OOHBURHExNUxaZys5bGxkd1pMRXMvTEdMNDc2K3Z3d25P?=
 =?utf-8?B?L1JwVkkrQ1N5RE50b2Q5bUs1WGxnbTlqSG1temk5ei9qQll4dkdMZTlTWDRX?=
 =?utf-8?B?L1ovYmpxYVQ3RVdPdmJKUDZZZzBLUk5GSld5emdUbkFSRVRtVkkyNDl4SEwy?=
 =?utf-8?B?YjRYRXEzbVlrZXF5czh2aVZJdERETnY2TE5waW5RY0hyaHFyYW9qRkVGaGIr?=
 =?utf-8?Q?qKEWNOduTciDK?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MEZreUZ4aVErNXFWVEcyenVUK0wwT1Vod1dkTmZuNk9IUzRiS1Q2bGZpR2Y2?=
 =?utf-8?B?QzN5N3JxOHkzMzIwb2hkMDk3d3ZqZExmWHI3Wm9wZ3VEQlVEb1JQd3hkdzBq?=
 =?utf-8?B?V2U4QmRMQmNBcFhJeHROTWVYUnpNZE9yNnFZOVBzWDBiT0RmY29jUzNybVpO?=
 =?utf-8?B?bENnWnlDQ2t3U3dWcTJhWTVPWWNGbWxIdGVWUGNtUUhSdWFoUGJyV2gvVisr?=
 =?utf-8?B?Rm8xRDVLekZZZlBKV1VHY3BqRitXTDNKWVBlREd2c3FRd09mTEZuK2Q5YjBK?=
 =?utf-8?B?cjBPRVRSQkZEL05kZWZ5RWNUOXJjeXdOenAvaHlENWZDRHExdzNqditRVWpn?=
 =?utf-8?B?SlZJbHN0cUl0UStBdGk2L2cvWXJSQU9RVDlZQXFjWmVpZkt4WjBQR0R3cm0v?=
 =?utf-8?B?emFmMWJReXhhcjJqTUs3OVVDUHBnQ2o3aHpmd2VwQ0VXV3lvOERMUTFZc0Vp?=
 =?utf-8?B?RkJDY2xFME4xQmJVekQwaTZsWlJUWmFubVNUZ1BJeVZFaEoyU2hiVkZTTEZt?=
 =?utf-8?B?MkpQYjU4MmFac1RwZW1zMDlnVlQvMjkyNnlZM1ZNK1RwWVErcmhaL01NeVdy?=
 =?utf-8?B?emF5NG9SMGsxSjdNcmtMTXNqWXkrWCs3OXBOZ0h3cGxQRitMSGY5TmtkMStQ?=
 =?utf-8?B?a3l2b1pncWFmSG5OSkowYWs4b2MzSHYvd01MelJjRGFKRElZS3JzRngyQ0w4?=
 =?utf-8?B?U0d0YkJFNXdYZGlXcHEvR2R5bDQzblNoRzJTckdPTXFnQnEzc293WkhMK2di?=
 =?utf-8?B?SStVRHU4WFRUVWZlY1czd1RmcFFTVVRnempyY1NFcy9XRjJwV1BQTmd0QmVO?=
 =?utf-8?B?TlB4Q081QW9XTXlGbjZ2bTg3TXVFYzJwTk1GWEVGSFJ3eC9pQzNLM2ZVT1ZM?=
 =?utf-8?B?Q2g3cnROZ09FNzVBOGoyREVPRFJsZDRmQUNnNFdyckFtRjk5OXpNRnBBUWZl?=
 =?utf-8?B?bmkzcjAyeWUvUUpuZllGbUo4YzlySVVCQktZeGtCL0I4ZzlyTXF2Tlc2anZ6?=
 =?utf-8?B?OEgyblhRYVQzZTJVRXZJQmt5cG5UWm1iRTRoSVMrT0NYWm9BcDl4ZHBwbVRD?=
 =?utf-8?B?NTZ4TjNoZXNkcnU3bmE1MldzQWYwSVpubTZVaTkyVEs5SUtXQlZKblhVNGZZ?=
 =?utf-8?B?TXZWU1E1TUxERnJucElsaGorM3l3NDdxTmdkYjJJdVUzRXBZTlJnY2FWWTdM?=
 =?utf-8?B?bG05akFmU09HcGV2SndZcmZxcmFEZXRaclBmR2NOSVJDS0ZHTEhCYlRIM0pX?=
 =?utf-8?B?OU5pcWVFZVZKNkVQYjdMT0RCSEdNSkdQd2hvMFlnZEd4L0Zwc1lOMnVVbUdo?=
 =?utf-8?B?VDMveHRqQWJkdW0rU1hnUkx4bENzdU5POVNqWGhSbUZicnR0RHYrSlRGN0hv?=
 =?utf-8?B?SGlTeU9lQUplU285SzRXVzBGM0U2UWUxVzhZczIycVhsUmJja0w5d2t0ZnFL?=
 =?utf-8?B?d0RveVNzM1YzSlQxTGQ1KzUxcEM5amhUU2t6S2FybkF1cXNmWDlrSTJTTEQ3?=
 =?utf-8?B?eHZkZjRiZ0k4YW1BbWU1NWoweHN3N0FsVlVTTk5KT0dEaVlwMDJyQ1IwcXBh?=
 =?utf-8?B?M2RUTHdGNGl6SkxQVFMyVGx4NUhjL1Z4bmZEMWN6cGtBdXRybFZRdWFoZHBU?=
 =?utf-8?B?aFlyZE1kQi9pNTBhT2NKWDZLOW4rYUhiOEFUTi9LVEpDUFFYa21aaU92dnFt?=
 =?utf-8?B?V2J4WlFRRGVBY0RENVUvNkJCUDNwTTlGYktmSURCRGhOSE9tMXZKMVV5YnYx?=
 =?utf-8?B?cjU4TE52bkhmYWZUZGV1UVMrdU9xRzh0VHcySW1Va1dyL01KaXl6WGFYYXc5?=
 =?utf-8?B?eXlocHNBZW5BTEgvRlNYWXh0L0FMRi9FSi9GWE1sWlJGOG82SDdMajBsMlFV?=
 =?utf-8?B?R2tZdU1FZDZmTklpdFNBQzBqY3V1ckcyVDVCeHFMYkdJT2tqTXFNZ0lxZkVa?=
 =?utf-8?B?bUE1SDg2c1d6bDJobGJNdVZVZjhBZTh5RVlqNDdIWk1yZmhEQlNqNHFtbmRX?=
 =?utf-8?B?M0l5ZFVJN0NBYk4vTitMN1FZdmhQWWRhNjdkc2QxM0FMT0dad1l6Yi82bmhv?=
 =?utf-8?B?WG5HaFk4YUhxc1ozTmpDd3NTTnVXakRMSDVVTStac0ltdGtGMkZIQmdHRVNH?=
 =?utf-8?B?S2dBRkFXdUFwMU5CTGRZNjJMdG1vZTJ3SEdSdlBEYjJKV3FvVm55OGNaQ1Mx?=
 =?utf-8?B?THc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <887BB6CD34689C49AE08C6762910ADBC@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4185.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60df2197-cc74-4853-d141-08dcfe3ae4ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2024 08:13:28.1610
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NdijEciAQY7Lb1er7zAH7Yd+VAc7VgRInOsGvxhoFZgPdkdcbqmawAW75OtKv/C0eDXV1xHFpcALIk0mlYcmDaIiCrccJ4R/g/2zWwtzPIU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6808

DQoNCk9uIDExLzUvMjQgNjo0OSBQTSwgTWloYWkgU2FpbiB3cm90ZToNCj4gU2ltcGxpZnkgdGhl
IHJlcXVlc3QgcG9ydCBmdW5jdGlvbiBieSB1c2luZyBhIHNpbmdsZSBjYWxsDQo+IHRvIGRldm1f
cGxhdGZvcm1faW9yZW1hcF9yZXNvdXJjZSgpLg0KPiANCj4gVGhpcyB3aWxsIGFsc28gZW5oYW5j
ZSB0aGUgcHJpbnRpbmcgZnJvbSAvcHJvYy9pb21lbToNCj4gDQoNClRoYW5rcyBNaWhhaS4NCg0K
UmV2aWV3ZWQtYnk6IEhhcmkgUHJhc2F0aCBHdWp1bGFuIEVsYW5nbyA8aGFyaS5wcmFzYXRoZ2VA
bWljcm9jaGlwLmNvbT4NCg0KDQo+IGNhdCAvcHJvYy9pb21lbSB8IGdyZXAgZmxleGNvbSA7IGNh
dCAvcHJvYy9pb21lbSB8IGdyZXAgc2VyaWFsDQo+IA0KPiBmMDAwNDAwMC1mMDAwNDFmZiA6IGYw
MDA0MDAwLmZsZXhjb20gZmxleGNvbUBmMDAwNDAwMA0KPiBmODAyMDAwMC1mODAyMDFmZiA6IGY4
MDIwMDAwLmZsZXhjb20gZmxleGNvbUBmODAyMDAwMA0KPiBmMDAwNDIwMC1mMDAwNDNmZiA6IGYw
MDA0MjAwLnNlcmlhbCBzZXJpYWxAMjAwDQo+IGY4MDIwMjAwLWY4MDIwM2ZmIDogZjgwMjAyMDAu
c2VyaWFsIHNlcmlhbEAyMDANCj4gZmZmZmYyMDAtZmZmZmYzZmYgOiBmZmZmZjIwMC5zZXJpYWwg
c2VyaWFsQGZmZmZmMjAwDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBNaWhhaSBTYWluIDxtaWhhaS5z
YWluQG1pY3JvY2hpcC5jb20+DQo+IC0tLQ0KPiAgIGRyaXZlcnMvdHR5L3NlcmlhbC9hdG1lbF9z
ZXJpYWwuYyB8IDEyICsrKy0tLS0tLS0tLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlv
bnMoKyksIDkgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy90dHkvc2Vy
aWFsL2F0bWVsX3NlcmlhbC5jIGIvZHJpdmVycy90dHkvc2VyaWFsL2F0bWVsX3NlcmlhbC5jDQo+
IGluZGV4IDA5YjI0NmM5ZTM4OS4uZTExMDdmMTRlYzk4IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJz
L3R0eS9zZXJpYWwvYXRtZWxfc2VyaWFsLmMNCj4gKysrIGIvZHJpdmVycy90dHkvc2VyaWFsL2F0
bWVsX3NlcmlhbC5jDQo+IEBAIC0yNDE5LDE3ICsyNDE5LDExIEBAIHN0YXRpYyB2b2lkIGF0bWVs
X3JlbGVhc2VfcG9ydChzdHJ1Y3QgdWFydF9wb3J0ICpwb3J0KQ0KPiAgIHN0YXRpYyBpbnQgYXRt
ZWxfcmVxdWVzdF9wb3J0KHN0cnVjdCB1YXJ0X3BvcnQgKnBvcnQpDQo+ICAgew0KPiAgIAlzdHJ1
Y3QgcGxhdGZvcm1fZGV2aWNlICptcGRldiA9IHRvX3BsYXRmb3JtX2RldmljZShwb3J0LT5kZXYt
PnBhcmVudCk7DQo+IC0JaW50IHNpemUgPSByZXNvdXJjZV9zaXplKG1wZGV2LT5yZXNvdXJjZSk7
DQo+IC0NCj4gLQlpZiAoIXJlcXVlc3RfbWVtX3JlZ2lvbihwb3J0LT5tYXBiYXNlLCBzaXplLCAi
YXRtZWxfc2VyaWFsIikpDQo+IC0JCXJldHVybiAtRUJVU1k7DQo+ICAgDQo+ICAgCWlmIChwb3J0
LT5mbGFncyAmIFVQRl9JT1JFTUFQKSB7DQo+IC0JCXBvcnQtPm1lbWJhc2UgPSBpb3JlbWFwKHBv
cnQtPm1hcGJhc2UsIHNpemUpOw0KPiAtCQlpZiAocG9ydC0+bWVtYmFzZSA9PSBOVUxMKSB7DQo+
IC0JCQlyZWxlYXNlX21lbV9yZWdpb24ocG9ydC0+bWFwYmFzZSwgc2l6ZSk7DQo+IC0JCQlyZXR1
cm4gLUVOT01FTTsNCj4gLQkJfQ0KPiArCQlwb3J0LT5tZW1iYXNlID0gZGV2bV9wbGF0Zm9ybV9p
b3JlbWFwX3Jlc291cmNlKG1wZGV2LCAwKTsNCj4gKwkJaWYgKElTX0VSUihwb3J0LT5tZW1iYXNl
KSkNCj4gKwkJCXJldHVybiBQVFJfRVJSKHBvcnQtPm1lbWJhc2UpOw0KPiAgIAl9DQo+ICAgDQo+
ICAgCXJldHVybiAwOw0KPiANCj4gYmFzZS1jb21taXQ6IDJlMWIzY2M5ZDdmNzkwMTQ1YTgwY2I3
MDViMTY4ZjA1ZGFiNjVkZjINCg==
