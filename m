Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11021092.outbound.protection.outlook.com [52.101.65.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11535296BB3;
	Fri, 26 Sep 2025 09:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758878329; cv=fail; b=EuXMz/TfwvNOqzi8qoXupi7iNW37AIno1IFuuXvlNZYlbMH70fknTn5NUHPOSJFjh4gHNomh17P53IPIY0aESelXUFpt+uKpeey6LIHQKvSggrhpcZimOLVp9OAGW7D7PsOte08w6DakKGoJJr6FhHT1SDUTrJeNh2J1va7Rnqg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758878329; c=relaxed/simple;
	bh=WvcqpQpErJALsGFNiAP40ND4B4w4Bo/F5zi4ox6RgSA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OAcBPdV5qpMh6+Isl2lTGo1Un5HkJrH3xcbvcD4Jy58ApdCKR7q9w9zP6TknEe9n6D5MC3ICsfkUwedD46S4StXVZyiy1th0QV0IebJnIhpXFGm/Ty0KXauA4SLgfI0R1OMjYkNvErytfzm1/GjbOys+Efp0WatqEeUaB5V5OFg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sttls.nl; spf=pass smtp.mailfrom=sttls.nl; dkim=pass (2048-bit key) header.d=sttls.nl header.i=@sttls.nl header.b=Jd79/8NA; arc=fail smtp.client-ip=52.101.65.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sttls.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sttls.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sttls.nl header.i=@sttls.nl header.b="Jd79/8NA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LZtqz6KeJGLu+FcuqD1TiH28leA7+Giff9n3p2H4FHOsclUVmZdvb+4hmdHIqe3HLnL7QGe9X241OMU+0XF2WpfkMcVuPBN1Hjkm9qmtiUpPfL6X4LqbXyLBlmYFZkLkV/CMxIVkRDYpYwQfXS1fWp2Qp3raK9GXJSew7q8/B4zf1f+ZxovXHwpSbA8UK5dPnaBeqH9NyIgkkBTUTyESCFKoPO9C0hvm+pr/nySeGitn9BfH3qj1Nqi69dxuO6OaoGvoJGGpf0SaOcKq1cCrv3WKlfqDIVFSW1H24vQtaNdzSH0K7RCKY3Z3VMr2eLU+woJhMSTOvKwJRKfeHrCcCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WvcqpQpErJALsGFNiAP40ND4B4w4Bo/F5zi4ox6RgSA=;
 b=r2nWkF/kUXnatZhon7Kl5vzzjfccZVccyBJB9zsZa8hOEv9WkBgb2DGJV2XhjcKoftS1jvhngg06SdCABUAOmD2j94RqZIxcXt+ZfGh/GpQ844QliW36xmRMEihwKz44RuyZRwxQa0bwuJ4WCqTjH6o9f3PS8p8M81wYiOSVb98v4aeEUAL6YfsGaATYNM1MfwQ8ZSFs8PlPyHaC/POjbxBkXFjiW6Cq8R3/D7NllgeRuDSvyWbedut7OKSB092sNkBudSwcXOhsTpaMtvQaXxne0jKU/d/sNxHhOwrV2ygWdRm4gY6Wokcz+Ke+Wqthdc07fS1mb2RAfwHstMIx3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 13.93.42.39) smtp.rcpttodomain=hugovil.com smtp.mailfrom=sttls.nl; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=sttls.nl; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sttls.nl; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WvcqpQpErJALsGFNiAP40ND4B4w4Bo/F5zi4ox6RgSA=;
 b=Jd79/8NAzxC7LnqnV6/62M5yzj6EsMY3qTAtMV6WgKeggfWysdsueSWOde7Csyv5gFpmWzYH8Naa5+ARWu6MAEnaPye2vqTlVaHBVz0LbEM5Bo8rz0dm+LK+MD4EkkocHKADyx9+7M3HNSi90RKiuB4nHdyprnJvCC6pjaETm+5dDL1L+GTvdGArFmN0JNb4c8plF1AQi+BxaiwkpCEUwwrKHAoFBhpFuNZoFc2KpVYks3/En1oKwWkvQ6+5G0M2l4/U8Oq/+X6V/o7eDwsuAyVGmWZG/jVsNWfkcyK2AngXKj2u5UAIHFSOOKTpB9NDUdahS5ZVhA/RMOXKT7Z0uw==
Received: from CWLP265CA0482.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:18a::7)
 by PR3PR05MB7034.eurprd05.prod.outlook.com (2603:10a6:102:67::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Fri, 26 Sep
 2025 09:18:41 +0000
Received: from AMS1EPF00000049.eurprd04.prod.outlook.com
 (2603:10a6:400:18a:cafe::3a) by CWLP265CA0482.outlook.office365.com
 (2603:10a6:400:18a::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.10 via Frontend Transport; Fri,
 26 Sep 2025 09:18:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 13.93.42.39)
 smtp.mailfrom=sttls.nl; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=sttls.nl;
Received-SPF: Pass (protection.outlook.com: domain of sttls.nl designates
 13.93.42.39 as permitted sender) receiver=protection.outlook.com;
 client-ip=13.93.42.39; helo=westeu12-emailsignatures-cloud.codetwo.com; pr=C
Received: from westeu12-emailsignatures-cloud.codetwo.com (13.93.42.39) by
 AMS1EPF00000049.mail.protection.outlook.com (10.167.16.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Fri, 26 Sep 2025 09:18:40 +0000
Received: from AS8PR07CU003.outbound.protection.outlook.com (40.93.65.51) by westeu12-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Fri, 26 Sep 2025 09:18:39 +0000
Received: from DB6PR05MB4551.eurprd05.prod.outlook.com (2603:10a6:6:4a::24) by
 AM9PR05MB7842.eurprd05.prod.outlook.com (2603:10a6:20b:2c6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.13; Fri, 26 Sep
 2025 09:18:38 +0000
Received: from DB6PR05MB4551.eurprd05.prod.outlook.com
 ([fe80::f854:dcd:a8dc:bc53]) by DB6PR05MB4551.eurprd05.prod.outlook.com
 ([fe80::f854:dcd:a8dc:bc53%5]) with mapi id 15.20.9137.012; Fri, 26 Sep 2025
 09:18:38 +0000
From: Maarten Brock <Maarten.Brock@sttls.nl>
To: Hugo Villeneuve <hugo@hugovil.com>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "jirislaby@kernel.org" <jirislaby@kernel.org>,
	"fvallee@eukrea.fr" <fvallee@eukrea.fr>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Hugo
 Villeneuve <hvilleneuve@dimonoff.com>
Subject: RE: [PATCH 13/15] serial: sc16is7xx: change incorrect indentation
Thread-Topic: [PATCH 13/15] serial: sc16is7xx: change incorrect indentation
Thread-Index: AQHcLWl+ScU6GvLviUebs/CeyhgZ/LSlMh/Q
Date: Fri, 26 Sep 2025 09:18:38 +0000
Message-ID: <DB6PR05MB4551CE3468BE5BC059981F49831EA@DB6PR05MB4551.eurprd05.prod.outlook.com>
References: <20250924153740.806444-1-hugo@hugovil.com>
 <20250924153740.806444-14-hugo@hugovil.com>
In-Reply-To: <20250924153740.806444-14-hugo@hugovil.com>
Accept-Language: en-US, nl-NL
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sttls.nl;
x-ms-traffictypediagnostic:
	DB6PR05MB4551:EE_|AM9PR05MB7842:EE_|AMS1EPF00000049:EE_|PR3PR05MB7034:EE_
X-MS-Office365-Filtering-Correlation-Id: 353b4b51-604a-4e78-bb26-08ddfcddaed1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|1800799024|366016|38070700021;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?cjVnN2wxQ1E3TVZic3hYbWtRT0FCSktHZlF0Z3hPYkthL0M5bThaNDV2MVFo?=
 =?utf-8?B?Y1p0SVFvdXBtMHZ0eWs3NEVyVCsxYzc2L2hjQ00xLytNZDZTUENFSlY2b2hn?=
 =?utf-8?B?SFNkSjhoQnlPM3UzTk5PUWJBYU44a3MrTDBrWTJXN1FUbXE3RE9ZZjBpOXZx?=
 =?utf-8?B?Yy9PRE1rd05pUkZqMlB0ZWw3RkVkZEgrVlRMakRyYlI0T052MU1JYldFUGNy?=
 =?utf-8?B?T3pPR1RhbnJwb0RqNjcyQk9hUTdvTkxPOUNHUHRzRUlTMFU4cTlBTGpFeTZX?=
 =?utf-8?B?OCtrTHYwSXF3bXB2ZHdxaTRTVFhHVXdLME5IWDQ3bmloMStydWdPT29vcHQ1?=
 =?utf-8?B?UlJBbWl1a0JGWnpMVHZ4VUVGUjZzZi9SZmNxOUtIQVlVc2w5S1FUVDh6aXhY?=
 =?utf-8?B?ajVVeWpBZVkvNlV0SjFnUTlNRURNcTRDdW5nazVSTGVsUXVKOUhKQk1ESDFT?=
 =?utf-8?B?VlBSVE5iaTkyNDFzTklVdlJWN28zbkt0WjNya3VJTkFCNG44VVZyVkdhdjhU?=
 =?utf-8?B?ZVV1Vm9DWXREKzNzMzhkTFVxM2kyRTJraHQvM0lhQTkzcGg2YUErS2RXdGJi?=
 =?utf-8?B?VWdMakpRanpPZWFTY0FqekhERTllaC9ValdEeTg2ZDhTZ1QxY05YcjFKSmUx?=
 =?utf-8?B?RU1ZNkNId0dWVHJyMkc1UlFnZlFiUnR1MEwzUVNXUGVmYzZ4eEd6cVhVUkp3?=
 =?utf-8?B?bG85aVQ3YlBIdDBVYjBtYXl1L0pQMjU3azdiMU1FWFM3bEM4VVVIdlZDdUNw?=
 =?utf-8?B?RnlwaXc0U05VcGcwT3hHTnJGM2tLaUpsSGJ6T1RRYXlsYUxQR3QvMzdkZ1k2?=
 =?utf-8?B?TUdNV1RHY29rYmJuNmNja0hyNE83d0hoNXlrMm4wT24yelJGR0hGKzg1TGNv?=
 =?utf-8?B?aEN2MzVFNlRFZGhVNk00dytqQjVvd2JuSEg1S3BRaWgwVGlhT2QwbEExcVBa?=
 =?utf-8?B?UEJJREJnY3lLTW5RbzNGNm1xNS84Nk91a2J1NHRSNTFZNWVTaSt0Uk9ybU1R?=
 =?utf-8?B?ZmRaTVZqOUJXTllCdlFBcUh2dEdsOXB1NktLWEZHSXM2b09YVmc2UngvaitM?=
 =?utf-8?B?YWUxc0l6dG9mbnFTalJURFo5aTYrOHdLcWExR2VkVHB2MFh5NTN6RTNiQUlR?=
 =?utf-8?B?WFFoTE9pQXV2b0hsR2o2ZytreTE0Z3VRRmVRd0FuU1ZqSTFLaXM1QTlaMGR0?=
 =?utf-8?B?ZnRTcU1WM1pXbWNaeEU4ak5JVEgyQ2MrNDRKWUM0dFBUa1hEcW9GRk1Fckc3?=
 =?utf-8?B?V3FoNHlac0FCRWp5QWJYa2JLakFNNndwMGdmK2hSc0VZa3hCSkFZSzZ3NzZO?=
 =?utf-8?B?Zm9EUkQxUGd5UXgyVXJmVU4yYUlxeEc3S0REMUpsdlNOaCt4c3ZtNGFYRFQ1?=
 =?utf-8?B?WlROd0Y2OG81MDIwVmJTM0dPQ2t2ZVovTjFUbTJNTkJqWG9wRUtTWGI3R21h?=
 =?utf-8?B?SDlsdFNKS09lbnJRRmkxK2lKUmpybkFCbGZhcG9FamhRMjc2eWFHMDNJZTIz?=
 =?utf-8?B?TDZnd01FRjRsSmZYeGg2RDUvNHFFVXlkMTlKQ1hnNkFrMElpWGtDY2JJSUN3?=
 =?utf-8?B?YW9sYVBXN0J1YjdoVEFKTGlLcnh0VEpOa1orNVRvQm5ES3NLK0crSUVGd2s5?=
 =?utf-8?B?emNSTi9oNENzOEluYmZjSTRTUDIraGUzWXRIdlFlMmNnV0V3S0ZaSkdVYjlY?=
 =?utf-8?B?WjV6L3NFR0xhZ29TY01USUVFU0gzOFpCa3llMm5PaWViRGN1VEltYndBK0p1?=
 =?utf-8?B?bVRSQXRzVVN0bWxYdnpxNWp1dUE3bkwyNE1ObUx3ait4T084eXJhWUxGMEQ1?=
 =?utf-8?B?MTV4YjlCSmpUVUE4Zmg5d05kR0lCSTVmN0twQlA1eE9nb0llWWxUenhLcHll?=
 =?utf-8?B?R0FkSy9xaFBwSmQ4K0w3M1ZPRmNJOHpla3VuMFhndkNma1RQQWFRb2tEY3dN?=
 =?utf-8?B?SkdJQTY3M0l4alFBRTBBZS9tOHdJNEJQeDhRYVRDTlpkS0RxOTBzVFVpK2pp?=
 =?utf-8?B?em53dDlONGNRPT0=?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR05MB4551.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1102;
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR05MB7842
X-CodeTwo-MessageID: e78bdd4e-c946-4cea-9d53-6068b7714971.20250926091839@westeu12-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS1EPF00000049.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	8d0d443c-20fb-4d5c-cd4f-08ddfcddad70
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026|35042699022|14060799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eW1NWmJEWnR6ekpIa3dPbCsxemVGOXFGcElQdzM3eUNnY0NUMzhLQ1IrdGpj?=
 =?utf-8?B?NzlKamFxSE9YTWNVRW9vcTVjTHpjWWUwTVZXK2ZEa01OV2YxL3p0YktYSFRP?=
 =?utf-8?B?UTlFa1VRaGZIdUN0dFEvOEpHUlArSGx5TGJzbjRlQ2xtbGF1b0I0U1VxaFB5?=
 =?utf-8?B?bHZEbW5kVTllVWxic3RiNmp5RjFFWFFHWTljNFU2d3lXb21iTC9SWXdvMHh1?=
 =?utf-8?B?a0JPZkhDbGpHZlFjVTVRTWh2Z09SZlA3cU44OHEwSldqc2o5elV5WGk1TDVo?=
 =?utf-8?B?Q0lkT3h6TEJqS3pGamhWNS9PazVNamxLUzhSL1VTZXo2YXpWSnVGV2x2UUxq?=
 =?utf-8?B?bTU3d2JTM3R0dnJNa2wrSVRCZGhLaHVOZlF3ZE9UalVpZ1RLUCtLVmpaSEcx?=
 =?utf-8?B?QUR4NkV4cWpwL2I1Q01LcG1EQTdRMDRQUTc0NXU1U2F1QjRmNmF6eWhVbWFx?=
 =?utf-8?B?eUwxMXpuK3JLMmlPQ0NmMzVhNm10WCtZcTFrKzV3cWljOWhJT3RObWtaY240?=
 =?utf-8?B?VldzTmVpbGpTd1hLelBQelRYR0JFbmo1VFNoMDdMcG5leDA3NnpiV3V6VUN6?=
 =?utf-8?B?d0lycXFYdEpZR0ZHenFIdkdFVjQ1Y0Z1N2l4eHpSZ3c1RUFxUkF0WXRCTHZo?=
 =?utf-8?B?elpUTVZlb1pZY3E2blVDcTRPeDBnU0t0WTBqUTdaSWVZWXF2ZU83ZkNDdkk5?=
 =?utf-8?B?UUFocW9iNEFDSGl6bWh4L3ExTE1FWG1rRDdVRkRJeGJZM3ZyMGRTci9aN21v?=
 =?utf-8?B?QkFXbldHU0hxZVhpMjdZMm9wKzFXdFZoQlVRdS9NQXRvSVErTnEvdm4xaHQy?=
 =?utf-8?B?TWlGS2h1TVJnYzFhWXZMY245c1MrekU1Yk5meVlTYmlPR2ZQNGF5clNUNTYv?=
 =?utf-8?B?dVl6bnhFc0VQKzg4bXRFSEFmRDF2OG10dTRzSlpqcEd2MlhuVjZuMFF1ckYw?=
 =?utf-8?B?OFhGV2tIZzZjZmxmYUNvV0QyRm1NcU9TOWdPczVCMlJRU2JZci92bC9GQy9H?=
 =?utf-8?B?OU1lb1k2SlhpZHg3VTAxMlZ5OUhPaGVCdlJjb2xlSW04bDNhR3Q2bDBDRERu?=
 =?utf-8?B?ZzBOOE10SHhmU1FDK3V1S0ZVUHFZM3lzTHRBbEFlWVhLWXpyNktIdlhxWk53?=
 =?utf-8?B?VUpRUWVEalArVFRxN3VSWXB4WTg4Ukh5RjhVTWJibFkzSUNVVVVTc0M5MThX?=
 =?utf-8?B?N2VNbkFyMFl4T21jTk5GNUdkVUNYZHc1MnlWZlBSdzVpRzk2YmxRTHNLbkxB?=
 =?utf-8?B?NW02Yzc0L0pPbnRIeStBOTIzSWVBdWpHQkpaUHlnUkFnQWU1d2ZxWitjbVcy?=
 =?utf-8?B?U3NRajZkZmNVSDAxTkNmbEZCSThHaWxuMmplMi90aDdHTTVlZ3NvUXZBU2pM?=
 =?utf-8?B?SS9xQnZweGIwN1VTdUg2NFVuV1M0QmYwajZyMWtZd2dISU1aTW53ejJmNG5a?=
 =?utf-8?B?ODZwcVF1ZDFyTWFocS9Pbk1MR1QxZ3JMbE5EWlVxUDdXUkVJQkJtbHEvVFJD?=
 =?utf-8?B?UVRyc0JtVG9PSUZKcTNSWTNQNFFhU2N5TXB2VDhRMnJBdCsxdFZTSlVmVGNl?=
 =?utf-8?B?ZlVyazhpNDI5NUUxbkZUbDNSRkNsTGZpUXdScGlQL1llbUxDUzNJU2ltSHg5?=
 =?utf-8?B?bzd2OENWRlJ3cTE0SXMxMytPcGMyQWowa2JQWXJQOEx4STE2Q1V6SGFycDVo?=
 =?utf-8?B?eXlMMDl2YnNFQ3E2TitocGZZRHIxc2o3QjBmMngzcVB5QjQ3SEVuWGVrZEVa?=
 =?utf-8?B?Z1VER05qejBwdWRFNzdXMWpwcmNnL0ZnSys4VEo0T2lMdjMwMHNKS0htV3d0?=
 =?utf-8?B?aGY3cGNuaGYwUzVhYzFXWUYrbWZZeTdaRWl4RUNZTWZuMSsxcDFKdnQyNjk0?=
 =?utf-8?B?QVVxT25tV0c3MzI2cldGYkoydzdhZ0g3SzQyQSsybmc4L0J1TE1xU2k4Y2pT?=
 =?utf-8?B?U2VaRWYwQytMaGVZWHRGamJBNUJwRkNPKy9SbTFhRVR0M0ZvVXVFcmZUeXJX?=
 =?utf-8?B?ZVpLMUdzajNyUkFLNHoyV2lDMEhDblBEVHpEbW1UM3dXaVJkWXhEeWN1R1E4?=
 =?utf-8?B?RHdSblpuTWU0U1lhUjU0RzM0cHNNakgrVmZiWThTY2ltSC91Yjd0K1hnV01C?=
 =?utf-8?Q?Wsto=3D?=
X-Forefront-Antispam-Report:
	CIP:13.93.42.39;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu12-emailsignatures-cloud.codetwo.com;PTR:westeu12-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026)(35042699022)(14060799003);DIR:OUT;SFP:1102;
X-OriginatorOrg: sttls.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 09:18:40.7138
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 353b4b51-604a-4e78-bb26-08ddfcddaed1
X-MS-Exchange-CrossTenant-Id: 86583a9a-af49-4f90-b51f-a573c9641d6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=86583a9a-af49-4f90-b51f-a573c9641d6a;Ip=[13.93.42.39];Helo=[westeu12-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF00000049.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR05MB7034

SGkgSHVnbywNCg0KPiBGcm9tOiBIdWdvIFZpbGxlbmV1dmUgPGh2aWxsZW5ldXZlQGRpbW9ub2Zm
LmNvbT4NCj4gDQo+IENoYW5nZSBpbmNvcnJlY3QgaW5kZW50YXRpb24gbGV2ZWwgaW50cm9kdWNl
ZCBpbiBjb21taXQgOWViOTBkNTdiNTVhDQo+ICgic2MxNmlzN3h4OiBBZGQgZmxhZyB0byBhY3Rp
dmF0ZSBJckRBIG1vZGUiKS4NCg0KPiAtLS0gYS9kcml2ZXJzL3R0eS9zZXJpYWwvc2MxNmlzN3h4
LmMNCj4gKysrIGIvZHJpdmVycy90dHkvc2VyaWFsL3NjMTZpczd4eC5jDQo+IEBAIC0xMTgxLDcg
KzExODEsNyBAQCBzdGF0aWMgaW50IHNjMTZpczd4eF9zdGFydHVwKHN0cnVjdCB1YXJ0X3BvcnQg
KnBvcnQpDQo+ICAJc2MxNmlzN3h4X3BvcnRfdXBkYXRlKHBvcnQsIFNDMTZJUzdYWF9NQ1JfUkVH
LA0KPiAgCQkJICAgICAgU0MxNklTN1hYX01DUl9JUkRBX0JJVCwNCj4gIAkJCSAgICAgIG9uZS0+
aXJkYV9tb2RlID8NCj4gLQkJCQlTQzE2SVM3WFhfTUNSX0lSREFfQklUIDogMCk7DQo+ICsJCQkg
ICAgICBTQzE2SVM3WFhfTUNSX0lSREFfQklUIDogMCk7DQoNCkFyZSB5b3Ugc3VyZSB5b3Ugd2Fu
dCB0byB1bmluZGVudCB0aGlzPw0KVG8gbWUgaXQgbm93IGxvb2tzIGFzIGlmIGJvdGggIm9uZS0+
aXJkYV9tb2RlIiBhbmQgIlNDMTZJUzdYWF9NQ1JfSVJEQV9CSVQgOiAwIiBhcmUgcGFyYW1ldGVy
cy4NCkFuZCB3aHkgbm90IGZpeCB0aGlzIGJ5IHBsYWNpbmcgYm90aCBvbiBvbmUgbGluZT8gSXMg
NzYgY2hhcmFjdGVycyBhbHJlYWR5IG92ZXIgdGhlIGxpbmUgbGVuZ3RoIGxpbWl0Pw0KDQpLaW5k
IHJlZ2FyZHMsDQpNYWFydGVuIEJyb2NrDQoNCg==
