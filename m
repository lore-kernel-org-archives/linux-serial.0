Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2051.outbound.protection.outlook.com [40.107.93.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB338193418;
	Mon, 21 Oct 2024 07:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729494995; cv=fail; b=F05HyJVc6rivHsJfbrNnY5BOrRTi9IGFX9PIGXGl9RCyECEOtKop4bfSyjDYhPdJwIJD0OT9StaLETuQHxAXXfC3Doeij4uAIej9jjwick4JMCMlehYUlnMavPGSvZOX4T+5QGYrEYsLhj55fU0obaQ+F3UWTJ0xZsPBf0WSb4U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729494995; c=relaxed/simple;
	bh=4tv/EozEvn8FA4kpBZG2jC3ai4TKUnWRx/CLtMtH3fo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZMeaVRAHPOplyzNoOaIZgvZ8m5xyZ9GaaSQZHzA+ZROUAbpvgJuBsw4jN0k2WNdD4T37rlMwq500TIisRcIi7WXg7bwsBxjerMAvpi+5CfdjW3wDsd/ngGKn58IADdSKuKqCCm0QfQom3k0HkmMjvFUXaKfqcqpBAN/b+jbSfeM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=nwsjnYlt; arc=fail smtp.client-ip=40.107.93.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="nwsjnYlt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IVwP4fvcu9ThhXkVOWtCcAlIEAvYSu7FF6UuiLei2fVKOWeuTjGyJny/Yic/zS/JQFrQkwOz3q4wv1u7TBL7DIAb/VP6BXc4pKOlDwDwO/kC8BSMWl7FR/CCHICWVEW8IL6xjoucE5phoSpNyBIBuwjMLbkBYAdMGnZfhtc5q3cB8fw9YQgXhn0H4QavVik2WWc7zE03oF8/UJHswAQFqAdTpmmcetVUldJcPeHP5sZ4glTp7lp98d5A41po53PI+OEbm0+z/OwEb2eOpzcxejmdtYM7LjDv26DO+0jnzQnpRffO5S07q++CbOmfByXsSraV0RXjUPFQQJ+aao/GJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4tv/EozEvn8FA4kpBZG2jC3ai4TKUnWRx/CLtMtH3fo=;
 b=QKHxPhizqW+qqPtwY5jhPXQbtZ6zKt/WP6sX4d5/cmEMXFslGfs6bm9BgvFdZXZgaCW+Vd9slWMrKCGxJBZ9xIgn4RaiAhEQHzdsSn9l6o/Gyxpl3jJc+JhVolbJt5fts2VKmOmywTcM5VWs/JPQ9mnwYkgnoSjGY6r86FjWLbRFeMU1Yu3zrtXEtCOBL9N7PCM/5Yadm29rKX+9yF0p+tbIrDhcUawzXox32a1Yxgm4JAzjVnNdQ6KHicsNSgACkg5Ow+2QM0VSPrj1oATnRGnJSdMqMymQta/RUYgnpRZmzFIGHIvBPAHg27P0eMCI1lxWZdvqLk6qF684VetGTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4tv/EozEvn8FA4kpBZG2jC3ai4TKUnWRx/CLtMtH3fo=;
 b=nwsjnYltBW3RtiZHZqum3lHi3dZP41daaunwxqrR+dJaz/ldBQQklyEDFq026xAOXY7BUVb5v+ys6iJ8cVCMGWiFbD9NHmyDgCUKO2X/bkS+QPpCATzeyET7RYhMrJR6qMv/jtt2XA46hUhfh1uWW7JVgHfH6U6JGtPsToya5Y+IivQt43nepCmzCWX33m5iyLYHO7MmHXc/muH0fof6ckTHa1ukI3E0E5CzDHGe1Ob2eg/xfGTzEthr6l8/CdmZ3ReRXYyymCwl5ymkhHhzHpcNdlTPkIUmoY9znKzRsryLkCKdZuyasICMGdX4XzYyqSC73PWlmnYziHGJEhqf0g==
Received: from PH8PR11MB6804.namprd11.prod.outlook.com (2603:10b6:510:1bc::6)
 by SJ0PR11MB6672.namprd11.prod.outlook.com (2603:10b6:a03:44c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Mon, 21 Oct
 2024 07:16:31 +0000
Received: from PH8PR11MB6804.namprd11.prod.outlook.com
 ([fe80::6f39:a4f:9001:ea75]) by PH8PR11MB6804.namprd11.prod.outlook.com
 ([fe80::6f39:a4f:9001:ea75%5]) with mapi id 15.20.8069.027; Mon, 21 Oct 2024
 07:16:31 +0000
From: <Mihai.Sain@microchip.com>
To: <gregkh@linuxfoundation.org>
CC: <richard.genoud@bootlin.com>, <jirislaby@kernel.org>,
	<Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <linux-kernel@vger.kernel.org>,
	<linux-serial@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: RE: [RFC PATCH] tty: atmel_serial: Use
 devm_platform_ioremap_resource()
Thread-Topic: [RFC PATCH] tty: atmel_serial: Use
 devm_platform_ioremap_resource()
Thread-Index: AQHbI4ScFIhWhRua3UaZpOD1hdxMurKQxoyAgAADFnA=
Date: Mon, 21 Oct 2024 07:16:31 +0000
Message-ID:
 <PH8PR11MB6804FADFEFEA51A8B35F894482432@PH8PR11MB6804.namprd11.prod.outlook.com>
References: <20241021064321.3440-1-mihai.sain@microchip.com>
 <2024102151-showy-partake-a2aa@gregkh>
In-Reply-To: <2024102151-showy-partake-a2aa@gregkh>
Accept-Language: en-GB, en-US, ro-RO
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR11MB6804:EE_|SJ0PR11MB6672:EE_
x-ms-office365-filtering-correlation-id: 5de4368e-58a9-40cf-6188-08dcf1a04985
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6804.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?cGZkUVZhMDBsOGNxYU16OUwrM3BKSExidGFLSGZIMDJ0bnN6NWc3Z0RlbzR4?=
 =?utf-8?B?WjRCT0ZJbS9WL3BCVWlxYm9NSzJPUHFrcGVQWkVkaDB6ZXpQdGhTMllDSGxs?=
 =?utf-8?B?TmoxU1JQZGVMTndDZ0oxVEt4Rks3RlA3ZllLbi82SERoTWI1ZTBlMWdJQ01B?=
 =?utf-8?B?NVBYRGJRK0pHZ0NYWGJuQjM1L1JqZjhpMVNuMXdpYzlsUldYU3g4NE5jZHNu?=
 =?utf-8?B?VHZLYVV0Wm5GeWNUY0c3L0lTQWwxUlZXK2EzYzNtbGNWaVRtWjF1TC9aQThm?=
 =?utf-8?B?K1ZsKzhmV1pPOWZOc24yZk9sQWhIMWFJRkR0MEFLSXhDOGk2cUhERWNtRk9C?=
 =?utf-8?B?dWxUbklhMm5WU1Y0cnRjWkwrN2VjRzFTaGhpMHVVUWxJYkI2N1ZrOTRYUjN2?=
 =?utf-8?B?MllwbjBHa1RyYW51ZGJUK1A3SldmaWJmNzg5MTNLM1lYUTN5TVlkK25hY2dB?=
 =?utf-8?B?TTJGN1B5UmFhTDcyYTNBTkxySmhJZmVQcThYbmRacThYNURZZmdWd0JwWjhv?=
 =?utf-8?B?OFhjYkdDMURsUWppellTb29kbGQrQkpxZ2FURThXQUl3UTdYYlNBQ1BHQTN0?=
 =?utf-8?B?VkRQTTIwRGZ5YnNzRVo3OUhld2NOdmNQZEZHbStzZkk4bERLaklpQ2NrcDFO?=
 =?utf-8?B?VTU2a1NQbTBFWTJmZlFvNGozck1MMlVGNU5sb2JUd1VHbzk4SW5VMnJqRE9v?=
 =?utf-8?B?TDI0U3JKejZaR2xQZ3BvM21vM1VSNWh3VHJ0Rm1naC9MRm5sdHJYSkRzMjFs?=
 =?utf-8?B?Mnd0dGFuUVZSWWp1K3FvV29SNHh5U2NnS3VzMG9VYUFpUmhDNk1Nb2tPNE9M?=
 =?utf-8?B?ZFd3TEZ4aHNPYldWYjVKT0lRZjdRbTI4ZGV4NE1GUUI3L2NUNW5xcThTSlY2?=
 =?utf-8?B?YVB5M29VRStwTStOaTFaNG9MaHR6c3NQM2c4bnhpWDMzZ1IweDlsN3E4WGJ5?=
 =?utf-8?B?V1gvc2tWSzFUOG9mbWZMempuOVhESDhYM25EN3BucVd3VURnZnNtNHpNUlJv?=
 =?utf-8?B?TmpaSUdPY2NKL1RMT1AzVUlEYXg1ZEVMZVhKTjVxMmxwTnltc3dYMDdmNmRE?=
 =?utf-8?B?Y0VKT0ZiNWlmQmJ6SUxBbnZhNVRWbTkzTWxNWjZGMFlOM3FqMXJ5SStsTURC?=
 =?utf-8?B?cnRHMnFrd2JiMkJXS0k2R2pkMmQvRHhwMXdWNXVWNE5PY2VHYTZ6L1ppenBW?=
 =?utf-8?B?Q251MXRFTHZCc0FKNXg2SU9qTDYzRGZQL2Vmd0F2QkREYmFtYWk0ZXE0UmlT?=
 =?utf-8?B?MTJNYWtjR0tRcGVCM1V6b29iYmRheDAxN2YwaFBUQUdjVmtsN21WeDBtZE9H?=
 =?utf-8?B?cVQzaEM5bkU4NGpsa0pDa0l5T2FKeG5pYUo3ZDh6UVZlNGFzc0g1V2lyMHp4?=
 =?utf-8?B?b0ZwcjJpZy82VHZkMjd2VFJrKzdOM0dsdVh4a1JJQnhKK0dXdC9CQUtucDFp?=
 =?utf-8?B?Vko2TnEzWkFneWdsb0ZHUmd4akpvZTkrb3paN0lZeUxUS3N0YWE3d1R2aWRZ?=
 =?utf-8?B?UzVuQnp5NWdPS3VCUDJwWGpOOXE5MllCTEFDcXNtZXh0cUdGSmtrYmwxN2o4?=
 =?utf-8?B?cFMvNWpVMmo0Q2t0bVRuQVFBVlQvaFZTYlJERWtheW5TbmtMM2ZHRGJLYmV5?=
 =?utf-8?B?b3FWdVF0ZERBTHlsb1NmRVltT2R2Y3NWZEV1WEc2VGVJZU9qZzVRTWF6bktx?=
 =?utf-8?B?NXNaeHFOa0k2MlA5dGJxYTlhTzgvSjdoUWtycHlEMGhlZnppeGdvdHRWaU45?=
 =?utf-8?B?NGRhRFVxMG9GYlg0eVhTTXppc0F0ZkNWYTRwaDJaOXlJTWN4QllLUi9LdkdV?=
 =?utf-8?Q?zuyKccogamejHU67SVKRAHpTda+fcUIlJSYu4=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UUJmYnZ6dE5lZ1lXV0szWXJxdnNRbnFLOFJFUHNPdHF4cEY1aGZnc0ppWVM0?=
 =?utf-8?B?aEhCY05RY1lITS9jcngzM2phazR1Vi9nQ0hkcXRMVmh2akZkdDRzYlJjeGh3?=
 =?utf-8?B?dUVTR2taZ05CT1JCQUZlNTJlWVBZLzkyUzZRdTg2YkFSV0NCbGpoVDlvUEpE?=
 =?utf-8?B?ZWZ6cktyTmpVUXZWYUdKSFpiNmFtRXQ4aUp4WHZKanNVSTZtZWV5M3BGV1Y5?=
 =?utf-8?B?TnNtVHdBU1hFZUNLT2s1WGY3R3hMeU5qR1JFTnc4SHFac2JORlV4M0VoYThH?=
 =?utf-8?B?cjRUMVJrNzFuMkkwWXN4L1dxTTNXdW16WE9HMGpvS0h5UDJxb1hzMERrSVNn?=
 =?utf-8?B?NGp0UExZRUttTEQ5cWpKVnB3WEhRVTFVZmJIaVJMcGtkMGNJSzFIMDhwV3Zw?=
 =?utf-8?B?M3BiNW5oTkcwWHJuTm9yRU5iZ0xuajM2VG5oeXZQU01DZGhCdkQ4TmM2Q1Vh?=
 =?utf-8?B?UTk0dWVHZVRyUy83eEJKY1JkY0NNZkRXR1BlRUZldEY3REZZTytwK3U2bjEy?=
 =?utf-8?B?ZHpjVUtCV21UMTloUjcxamljZnJBdVpMbDFQV3B4cGV5NVN1dWJCZHY2MnpR?=
 =?utf-8?B?RjlSVFA0VzFmWURvcGFRLzJDSmNMQ0N5eFl3OWYvcEF6TGlFaUxKVlpjQXNm?=
 =?utf-8?B?WHZqQzYxd3VIdDhKVkswQTVVbG5KNFp6WDBzUlVjTDdxZVVSSFA4M2YxT2RL?=
 =?utf-8?B?UnlFVlNjNWRtWmRqRTJyVWJVVW1IZC9IYkVHRHJHY1RsN1ZTRTk3c3RZd1Zy?=
 =?utf-8?B?dno1YUE2azRvaEgzb2ZUQzBkUUhRYnV0dE5NTU0wOGR4MXFPUlVnMXVURjg1?=
 =?utf-8?B?Sjh6alduS1IxRDNQajRJQ05NTXRucWZtRXFNMWxuRGdDOXIrQUNSWVpXQ1NO?=
 =?utf-8?B?bDIxaFYrQkhZTjM0R0JWRExQckt5V2NiY2oybHJjZjdvZUZoZ09MQVY2R0VQ?=
 =?utf-8?B?bUNFbWFrVlY3OFE0c1c0R2xYa1hlN1N2QlE5cVJNSjBHVjN1dy9rd041U3pH?=
 =?utf-8?B?TjRnRTV6am5Vd2dGU25GaUhjcVlKVGt2b00zNEZiUlZpUjlHYnBUNDI0emxB?=
 =?utf-8?B?VWdjZnI4ZG9RMkxRYUlvQXRkR1hyR0Nlb0s2VEQ2Wm1WYXBvTGlZL1daWVcx?=
 =?utf-8?B?aFROOEhobElNYWZCaldRVjZuMlU5em13b2lPU21OK1B0V0RrYUg0QStRTDMr?=
 =?utf-8?B?bUhtMkgybmJOaFpNWnBWYmpZbjhJOUVPN1lMT21hOEdpUG1paVJFRWN4ZFhs?=
 =?utf-8?B?Y01UWVZWMFhTWUMzcmxzN2NtVjZEN2RBaFlhaWovdDFZaHB0MUYvM3FGT3Iy?=
 =?utf-8?B?eUNPWndEQm5YRkJvYklqSGMzMmdjcnlCUFJZUDZvcUJ1ZTlaUUN3RThzNWVI?=
 =?utf-8?B?Q0kyK2JOemNHbG1qTG1SMzBDdlFGa0xiK1hXTG5iVGt1S2cxUXZ1UHhPVkVP?=
 =?utf-8?B?VHo2ZVZ3OUszbC8rNkpRSUo3TjRGb0wxVmE0UmJjYVhFcURmNnFERFBxazZr?=
 =?utf-8?B?K1JRSkRGc0VhMmhyNnJ0aE9DcEV2NXQrRXNxTytOSzUxUmVuOGUwQ251UC9s?=
 =?utf-8?B?SXM3bWpyMHBWdnhxamZZLzF6dzRDd1JOWWlyYWdDMDJQTSsxUFVIV1FZUTZZ?=
 =?utf-8?B?Vm9BSktxM0hHUGczVisvdWQ1WG1aN0xWelRISFFFOHNlOFo2S3hFR2NwcE5n?=
 =?utf-8?B?dWRlVExnb3NXaU1ObTNPRWkycTFpVnN6b1phNmdzRUtUUEJDajlpWU9nckJr?=
 =?utf-8?B?YVFvc3ZQOUZ4MzZLYkNOOEpWQnFreC9VSTZhTFY5di8xNWxpNkVVajdJYUZM?=
 =?utf-8?B?UkNSMiswV2dkcnY0d3U1akMweXl4MWdPYVRENWFqMTBiRzdSL09Sa1MwT3Bp?=
 =?utf-8?B?VW9UbVpyYndza3Ivb0g5SC9oekhRR25nU3lnbFdTMG1EVHdnNE9lM0xRZ0Ja?=
 =?utf-8?B?cU5Zamh3M1FyNG9wSEJsNU13emt3REdMNVR0UE1EOTBOVmxQSXhsVEtoZWNl?=
 =?utf-8?B?OXdNU3BFVi9qSi9IZVowR3p2QUtwRmQrKy9aWmEyVDFmRzhGK0ZxQTN4UGpn?=
 =?utf-8?B?SURITUZUbExWWGg1bTh2NGcrR3pIeDlwdFl1T0Nvd0hTUXlFT2g4V3k3aFBl?=
 =?utf-8?Q?jGRcSRHXBja0qFnxIeDMzuxSN?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6804.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5de4368e-58a9-40cf-6188-08dcf1a04985
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2024 07:16:31.0270
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OwqYD8yVHNhlzmOMgvRGHUsootIR5APS7Nm4rcTDTdvsn4nbv1qKI5t6NC8CxnTsIMxlJ4A0AfL3mNl/+AmObw702jRSXc90dICewUO3aKY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6672

PiBGcm9tOiBHcmVnIEtIIDxncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZz4NCj4gU2VudDogTW9u
ZGF5LCBPY3RvYmVyIDIxLCAyMDI0IDEwOjAwIEFNDQo+IFRvOiBNaWhhaSBTYWluIC0gTTE5OTI2
IDxNaWhhaS5TYWluQG1pY3JvY2hpcC5jb20+DQo+IENjOiByaWNoYXJkLmdlbm91ZEBib290bGlu
LmNvbTsgamlyaXNsYWJ5QGtlcm5lbC5vcmc7IE5pY29sYXMgRmVycmUgLSBNNDMyMzgNCj4gPE5p
Y29sYXMuRmVycmVAbWljcm9jaGlwLmNvbT47IGFsZXhhbmRyZS5iZWxsb25pQGJvb3RsaW4uY29t
Ow0KPiBjbGF1ZGl1LmJlem5lYUB0dXhvbi5kZXY7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5v
cmc7IGxpbnV4LQ0KPiBzZXJpYWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0ta2VybmVsQGxp
c3RzLmluZnJhZGVhZC5vcmcNCj4gU3ViamVjdDogUmU6IFtSRkMgUEFUQ0hdIHR0eTogYXRtZWxf
c2VyaWFsOiBVc2UNCj4gZGV2bV9wbGF0Zm9ybV9pb3JlbWFwX3Jlc291cmNlKCkNCj4gDQo+IE9u
IE1vbiwgT2N0IDIxLCAyMDI0IGF0IDA5OjQzOjIxQU0gKzAzMDAsIE1paGFpIFNhaW4gd3JvdGU6
DQo+ID4gU2ltcGxpZnkgdGhlIHJlcXVlc3QgcG9ydCBmdW5jdGlvbiBieSB1c2luZyBhIHNpbmds
ZSBjYWxsIHRvDQo+ID4gZGV2bV9wbGF0Zm9ybV9pb3JlbWFwX3Jlc291cmNlKCkuDQo+ID4NCj4g
PiBUaGlzIHdpbGwgYWxzbyBlbmhhbmNlIHRoZSBwcmludGluZyBmcm9tIC9wcm9jL2lvbWVtOg0K
PiA+DQo+ID4gY2F0IC9wcm9jL2lvbWVtIHwgZ3JlcCBmbGV4Y29tIDsgY2F0IC9wcm9jL2lvbWVt
IHwgZ3JlcCBzZXJpYWwNCj4gPg0KPiA+IGYwMDA0MDAwLWYwMDA0MWZmIDogZjAwMDQwMDAuZmxl
eGNvbSBmbGV4Y29tQGYwMDA0MDAwDQo+ID4gZjgwMjAwMDAtZjgwMjAxZmYgOiBmODAyMDAwMC5m
bGV4Y29tIGZsZXhjb21AZjgwMjAwMDANCj4gPiBmMDAwNDIwMC1mMDAwNDNmZiA6IGYwMDA0MjAw
LnNlcmlhbCBzZXJpYWxAMjAwIGY4MDIwMjAwLWY4MDIwM2ZmIDoNCj4gPiBmODAyMDIwMC5zZXJp
YWwgc2VyaWFsQDIwMCBmZmZmZjIwMC1mZmZmZjNmZiA6IGZmZmZmMjAwLnNlcmlhbA0KPiA+IHNl
cmlhbEBmZmZmZjIwMA0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogTWloYWkgU2FpbiA8bWloYWku
c2FpbkBtaWNyb2NoaXAuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL3R0eS9zZXJpYWwvYXRt
ZWxfc2VyaWFsLmMgfCAxMiArKystLS0tLS0tLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDMgaW5z
ZXJ0aW9ucygrKSwgOSBkZWxldGlvbnMoLSkNCj4gDQo+IFdoeSBpcyB0aGlzIGEgcmZjPyAgV2hh
dCBuZWVkcyB0byBiZSBkb25lIGJlZm9yZSB5b3Ugd2FudCBpdCBtZXJnZWQ/DQoNCkkgdXNlZCB0
aGUgcmZjIHRhZyBpbiBvcmRlciB0byBnZXQgdGhlIGZlZWRiYWNrIGZyb20geW91IGFuZCBhbGwg
c3Rha2Vob2xkZXJzLg0KSWYgdGhlIG1vZGlmaWNhdGlvbnMgYXJlIE9LIGZvciB5b3UgSSB3aWxs
IHNlbmQgYSBuZXcgcGF0Y2ggd2l0aG91dCByZmMgdGFnLg0KDQpUaGFua3MsDQpNaWhhaQ0KDQo+
IA0KPiB0aGFua3MsDQo+IA0KPiBncmVnIGstaA0K
