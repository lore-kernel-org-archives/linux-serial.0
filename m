Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=52.101.65.125
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1794400109;
	b=LPvyHMJ+biGyjxqE0kLotUfdyU5f/pzpXN7X3haaXNTqz5oic52cnymoMXAXwqRghLio
	 AMQUIRs5W+RXm8PEg5jtlMo4ikj1tHnarbSx4pd0vd8qBpwgtc4lEP8myCM5YTzSdpX8Y
	 ggWkkf/Vc3GVLZsinIVHvQQAeJwKZFPy1b26jhPRzBKAu5io4mMD0DtZkDM6HsjYEduz1
	 m3IANvrGEhOjv0gwKe8nO/Kt4VoaqsOMrQj3xyKscadUgNq9a0nHrKk7/rHoNVLXhqtSr
	 uUCw7OfVaeAyzvOuUBkCgtvgjz1QR+6KEhBheL/wMosrr63sCTK35XGrcitx8B6rVxg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794400109;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:Date:Subject:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=Q7atUrn8EPArUNQ1s51SuXzHDHgyJnFOMKXr8YeA7ic=;
	b=ISA9vwBLGogGDqk3TiqeL/0D0kjXnqcgt1EPobDpWSh3qHsTKHfK2APwmybNruZF7wdD
	 40IY1cXYblA5K9EP4WCWVH0Du1DuSM7Yq6zxij5PjogognILVRc3Ow68YUd2EFP2SWhqr
	 66BKEX7lRTDvTMnfx19XApAY/+EcnYhszDu7eRcB9mTL0qq0m15QC6SKplhWz5S827Cjj
	 de6LxVxs3ygVqYrBTXjO530rRjNeW4K9JGMVQgUaS4aaja74eSQEG9kxi0q0qxy04N929
	 KnqNhiaINIaCoyJc+TJVWAiLISbcQzoBvuidmZCowX4L9UlQdPoM063AD7YjhjPH9Rw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=vaisala.com;
	spf=pass smtp.mailfrom=vaisala.com;
	dkim=pass header.d=vaisala.com header.i=@vaisala.com header.a=rsa-sha256 header.s=selector1 header.b=imGAldk6;
	arc=fail smtp.remote-ip=52.101.65.125
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11021125.outbound.protection.outlook.com [52.101.65.125])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF58606A335;
	Wed, 11 Nov 2026 12:28:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6BF58606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vaisala.com header.i=@vaisala.com header.a=rsa-sha256 header.s=selector1 header.b=imGAldk6
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S1uGEYgrFk9kEc80O7CKqmH+vo6zrTy8L2VA3Wgn2dz0K7VJY7O04LiKIEpPGUSGYaONlupo3ebNKZtyvf1bDqgKsdRTmtU2+e8y7u2WXzmSeto2xy/CvwCyeBjIy0S9/ZUHFiAqUsgbicmkkcXO46oeQzDP1EJFsS/m5hE+ehAVHKnDQiMiktIDDFuIzTvcTatVK/Yu8kQ3VuINDggpecfLCW2Q+gJh7u7wPjaBCcdMd3xf2nqdFSp/0tsphYOblpeg8NFONUMWkT0M4q3ET2r1VR5lHDrFzK/oIgLkj87PtuDQ0MdYAPiwGTDGgAYtqZTO8FoJeIOu79h/M3FnaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q7atUrn8EPArUNQ1s51SuXzHDHgyJnFOMKXr8YeA7ic=;
 b=OA4Psz0hEP+eNvYiog9U6+mxQuHoRJ6GVuXChptYRrm714YOjjRW+b8JSTZx6rCUyXKFLbRj5nZjMO4iN8SDkQZM/8+ZV+vYy7zX8K2pHbWs9qMfNgRvuyrvl//H1kJX1cIMjBtguj6EWbt5ALNR/GXYfw7tE6V+UoJNzBliombDmlGH3hDyo539enMphmvfeLqzQHbSJ3YHNWbAqpIbWNAI6ncTao7K0aFDgfGOC6fPNNpQJuzVUgBevRawSZnham7Hh/7RtdasVbYB3DrBwzbUDYQkq1bWbcSGPcygNsRL2qMlGsuB3W8fE10+O/Sm+2Pja0A2v5duPYtS0ugeEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q7atUrn8EPArUNQ1s51SuXzHDHgyJnFOMKXr8YeA7ic=;
 b=imGAldk6poijJKDidR8M7yTJwnnW62bm9GOdENA2Y5x83pReRywt9DPoLBaBG0FOB27gX5Mcj8tP0l999e/TIxooUJCqy3YK/Ez2xKkPhmyd76iARV1l+vOjagJ5QBn6bDkTANzWd+2GUk5XKAPSa4uwEGsHYwrT5wNZdqWtJs/VihiO7joacAqcp4lyIijGPu7d4yWXB5sUEYhtmOjnLR3EfQwysKb8Cyu4PGWur8FiNlX5dI9vEkRoqJwrS4tsPHK9P0oTGEd6wRrp23KvMapZAO5cIrzo+/k5XSnPAHfQW9LYiTS85zrAf03PkE3H1O50/cRGBCtNdcYyzjgSDA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from PA2PR06MB9176.eurprd06.prod.outlook.com (2603:10a6:102:407::17)
 by AM7PR06MB6737.eurprd06.prod.outlook.com (2603:10a6:20b:1a6::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Wed, 11 Nov
 2026 12:28:22 +0000
Received: from PA2PR06MB9176.eurprd06.prod.outlook.com
 ([fe80::b6d:8160:d324:3bfc]) by PA2PR06MB9176.eurprd06.prod.outlook.com
 ([fe80::b6d:8160:d324:3bfc%7]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 12:28:22 +0000
From: Tapio Reijonen <tapio.reijonen@vaisala.com>
Date: Wed, 11 Nov 2026 12:28:04 +0000
Subject: [PATCH 5/7] serial: max310x: Request the line transceiver per port
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261111-serial-transceiver-supply-v1-5-40bad0f912f2@vaisala.com>
References: <20261111-serial-transceiver-supply-v1-0-40bad0f912f2@vaisala.com>
In-Reply-To: <20261111-serial-transceiver-supply-v1-0-40bad0f912f2@vaisala.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Markus Probst <markus.probst@posteo.de>
Cc: linux-serial@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Lukas Wunner <lukas@wunner.de>, 
 Christoph Niedermaier <cniedermaier@dh-electronics.com>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Lino Sanfilippo <l.sanfilippo@kunbus.com>, 
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, 
 Tapio Reijonen <tapio.reijonen@vaisala.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794400093; l=2123;
 i=tapio.reijonen@vaisala.com; s=20250903; h=from:subject:message-id;
 bh=KVHio2exVjmsX+X/s3olJnfqux0rLfa9hBvZ8DPplEE=;
 b=1RHXXA5FoTfvN/6QoL4a9SLp6shaPGmYjLqkh26Lhrbx9kTrkO0lIAIO3FiYBpDFU1bHwlJok
 5rTlBkPpiJDBwURCGcllFKmcpB4rkECoVK25wFo+Pk7YpIgji4bqOPY
X-Developer-Key: i=tapio.reijonen@vaisala.com; a=ed25519;
 pk=jWBz3VD84WbWgfEgIqB5iFFiyVIHZr52zVBPOm7qiGo=
X-ClientProxiedBy: BE1P281CA0076.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:78::13) To PA2PR06MB9176.eurprd06.prod.outlook.com
 (2603:10a6:102:407::17)
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
X-MS-TrafficTypeDiagnostic: PA2PR06MB9176:EE_|AM7PR06MB6737:EE_
X-MS-Office365-Filtering-Correlation-Id: 90702d87-5813-4e23-98dd-08df3fef44ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|23010399003|376014|366016|1800799024|38350700014|261102123227099003|11063799006|261021121427099003|261022105027099003|261026140227099003|261009223027099003|261021123027099003|56012099006|261028144727099003|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	8/9bbsycpw6EmH/kapZZVyP14g0fDdH5Aetxtf5WZQhBICNuLnnCsmJFkgGMiabb4ditxV5MjPEAmtD5P6YzhEYAi61fVl31QFOyXV9wglYmq8PJ9DVX4doBXR027HXwsOW8LLxv4qnncdN+XlGQY/wB6RHl34TXK/k1JqzTkQjjOzkKPVaYFwprAtLhnUw9bdcqlBHSdieF9d0bGzE/HdHuweFdlX8cwH5nk13N011ohE5elEE5XMnx3IxmNPwkYTYXqhmOBVwCeq+e9RkmG8itZEBpI4m1467jXtk1IaO4WySK4AGhfw5sv2COrad9s0cM+fI6HRl1i/IISuc/1MN57g5l6JyT98Q3vYf/1lniUCla8Df/OnizQKDC9LBJoRD7fwHTxKsx6QD57gFSrKkU4n7dYFLNI3hMVkfGpTEKxSMU3CTsV0SoCLJbRVN2wDj3YzyPW9GhUDSR/7YP0NpldtVEZXpbnD+/2qt90zGEkAaCKpYWXRcGV9WTrI6pfbCkLtZqsHoWm6fzG36PgeSs3ijKR+mYpJI4zXIimJt7W/qEAR2VYYcYwtpU6Ni/5HGMyLEjnnZAV+jWHa3ByARxm6htlXtHG9bmjnXJ60psPRFYBBqV3XpA0LkpsAgeUlpCjgZ5i5GI0ReC60X4F5xHhSKSxYaN6sf4015IpEEyl5PefFpNIZpIOIRxrBmt1W3elIApoohWGIslNEm5t1kdZn3tW1rh1GEjUrV9k+Y=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA2PR06MB9176.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(23010399003)(376014)(366016)(1800799024)(38350700014)(261102123227099003)(11063799006)(261021121427099003)(261022105027099003)(261026140227099003)(261009223027099003)(261021123027099003)(56012099006)(261028144727099003)(18002099003)(22082099003)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bGlkaWRwck5DSlhrNEs5aVJBdUh1aFY0NWxFQWd4b3ZGWHpmak1wTmhlU2NE?=
 =?utf-8?B?dlRuZURlSjIreXo1RlJmWVU2NnZGL0VWa0R2NFViUHVxMVNlL0ZlS1ZISE5F?=
 =?utf-8?B?NXRWWXJBdXBCRTZSa0ZqUjFSamlHL1JjdW53UnYvUlg3MXIxTGY5akFwS3la?=
 =?utf-8?B?VENvL0NCN0V3NlRHRXluUXI4dzhyaVZXanB1ZzlKM3YzQm5YcmVGRmorQXBQ?=
 =?utf-8?B?VHpGVkZjclJ4MHRMMTRiMURCcjBiaVpId0p6OVlRSTgvT1BUeFZKQlZLajZm?=
 =?utf-8?B?Q1VlMnVueDNpUlFXSXJWckpJSk5DWTRMK3grckxjZVlyQ2lVUnc1V3JVMmxh?=
 =?utf-8?B?dmRjTFBxMGhhMmM1OC96R0QxckFYMjhNdVoxTnp0SnNJeVh0M3B5Mk5SRW9l?=
 =?utf-8?B?aFBCTUdqSDJFL3d2RnZYQ2F1cGNDbHl1cDNTQ01sSVBpaGZqVXh6Y3NKZTd3?=
 =?utf-8?B?dTE5WXlLZGp3Y1NTYmRwbjAxdHR1d3V3Y0p1Y1hrQVBxVnYvL0JJRTJSc0d3?=
 =?utf-8?B?bytvN0p0cDJjZVZyaDZEdnBlSW13dDdKc1FOOVRMWEU2UnI2SnVWcTZqME1h?=
 =?utf-8?B?Uk45NDJBK2g2aXJYTk4zZnl3TmJBSlBIZUdGZGdtR0pXQVFhT3dEYXErNFVW?=
 =?utf-8?B?Ukw5eVZDY3FpVnNFWnBtNWdmQmRJUU9TbTRKY09ucHNCNjhkQ2l6WGVJRFlq?=
 =?utf-8?B?Z0N1aXRRQ1hlTHdpb1ZkdmdmSHVvSk1nWit3S3MvUnVKakNkMzMyd1JHVFl5?=
 =?utf-8?B?a3lVb29kbWN0WlZIOVV4VkttUXZhRXVRRVgyck9wcW93dVpRajVraTMvRHZE?=
 =?utf-8?B?NTZkTmhYV2FQenV1TjVsVXdTQVdUbng3dmVWY2pvS2lZVmlvOHpsU2daVnJy?=
 =?utf-8?B?aUF1dG4vaU9vYW9zays2ZzdhdDVicG1YK2pHUGNiYXBaSU1mN3ZPUkdja0xp?=
 =?utf-8?B?Yk5aVm5Xa3k0ZVpyckNYc2RiUkU3L3I1RHpNRW9aR0FPWWIzVUljUld4Nlp6?=
 =?utf-8?B?L1ZwYUtabEQySE5TOGwxKy9jTnlhZFU1ZFlxRTBiSStUdXE0NTdTclhheGp4?=
 =?utf-8?B?ekJGL0NlL1k2U2lPb21oRWhHWGFiYUhXUkkwUmQ4VVFXL1NkZmdvY0VsVkdI?=
 =?utf-8?B?RHNNeFFXKyszSXNYdHRleXloRjlTNi81MHFNTEo5djBTVXltbkJZTDI5cWNZ?=
 =?utf-8?B?ck5GYWVwK21NUUxkbTROTVFLb0RDa0cxNjhYL1BpZUZaRktSMHJ3azdtK2lt?=
 =?utf-8?B?N1d4NExNZlBzaUIwREJRbGoySEFXU0J5K2c2eHUrcFdCWExoU1N1bThFS3JY?=
 =?utf-8?B?aUpsOXhvWnZQQ3RjeTdJTHZOeHVXc1RpclF6MnJVZmRIWTkxWjcxTVZyRVN5?=
 =?utf-8?B?Y3E4U0Zjd3l3VW40VFJKbStPVW9QMHZ6Ym5vcXBrZVQzSEJTV3hnZ2REcTZz?=
 =?utf-8?B?OFJ4eC9LVmQ3VUdGLzFSMk52Wk1YQmdQWGVSc0tXSG5zWmF0KzVWTkNsUU9P?=
 =?utf-8?B?b2J1R2F3V0FVZmcyVGR1c29pY0xCeks1NVpRK0FDUnI1emtodzcrK0pwWG1S?=
 =?utf-8?B?cWRrY2VRTGw0Y21IaFphVzI2SXJtNmdhUG91VVhrL2ltc1ByQTdYQm1NMThO?=
 =?utf-8?B?aUN4ZDVFb29KMmh2S1RUR2IwUmw5WkY1NGJ3bkY2MnRMOS9UeEJGQzdqUXor?=
 =?utf-8?B?MUs2VkgzQlVoci9Pcm5qMVQrNVJjSk01bU9LN29WZSs2ekVOV1k3M3VEQjZq?=
 =?utf-8?B?aUN3RnlLWmNkOHNtR1hXZG9QYzBvbitGVm0vVm42S2hCU3Biem90UUxmT3pz?=
 =?utf-8?B?SWFlS01xcEpyNEpCRStvNEFXUzBOL3FaNzRVZmQ4VDllVUowVzFHVC90UjBx?=
 =?utf-8?B?dGtiOUlvdTZlaktxN01lZ1lKd0U1MVlnWHFUUVpROWtwSnZNZjNmMURoY2Iz?=
 =?utf-8?B?dlp4YWRyazIwOGpWYWU3M3FKcFVoRytPc2FRa0lHT2RqbGpOSVlUOVVrYi95?=
 =?utf-8?B?UVNvUEttNVowaDk1K3d0Z0dzQys5TVhNT0xtQU10WW9sS2ZwSG82VkJlL3RB?=
 =?utf-8?B?K041VkRkb2RPYzJJSStkVmUxcFNNbzNQdngrVHN1dUEvSmJ4cmxiM3V3R3lv?=
 =?utf-8?B?cGV1L2hnM2pMTk16cHdod0VMVGNHWjBlUGlNNE4xei9NKzdYT1YwWUJJUG9J?=
 =?utf-8?B?YWtyckd5alA3c094WW9OTjgvdnRWNzhsbHJ4ZllsdlFxNGhuNTFBUnJDN0F1?=
 =?utf-8?B?YlVFeURoRklSU3BlN2F5bVQ0bUhodVp3UmhOM05ydlRKUGlXUDAxblZMbGRY?=
 =?utf-8?B?TUlzZzBlL2FWS3UvWDllNzM4VmFlUDhUTFVCaTlQTUJycnNrem53VDc5eC9J?=
 =?utf-8?Q?5Oe/LAGBCMeOSdq0=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90702d87-5813-4e23-98dd-08df3fef44ec
X-MS-Exchange-CrossTenant-AuthSource: PA2PR06MB9176.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 12:28:19.7365
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0AKjtzyX+nG6o893cKvlEFdzwSqRQVLXgxZN6mpkIBORMMt1kk4qErIzLz6B9VPGTzBX/meJ88UnPHmP66AjuD66xo+ogax0BzscRdnGMl4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR06MB6737

Serial core requests the transceiver GPIO through the port's device
when the port is added, which for this driver is the chip: the
per-port "serial@N" subnodes, where the transceiver of a multi-channel
part is described, are out of its reach. Request it the way the RS485
properties are requested, while the device's firmware node is
temporarily retargeted at the subnode, so each channel gets its own.
Single-channel variants have no subnode; request it from the chip node
there, so the transceiver is known before uart_add_one_port() for
every variant.

Signed-off-by: Tapio Reijonen <tapio.reijonen@vaisala.com>
---
 drivers/tty/serial/max310x.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index bdfdf4a9000bbd18509746bbfd8ed0ade8164598..876bdd1f5496dcf46fdc790a89892342fd85a9e4 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -2032,20 +2032,24 @@ static int max310x_probe(struct device *dev, const struct max310x_devtype *devty
 
 		/*
 		 * Temporarily retarget dev's fwnode to the per-port subnode
-		 * so uart_get_rs485_mode() picks up the per-port properties.
-		 * For single-port variants, fall back to the chip's own
-		 * fwnode so legacy DTs that declare rs485 properties at the
-		 * top level keep working.
+		 * so uart_get_rs485_mode() and uart_get_transceiver() pick up
+		 * the per-port properties. For single-port variants, fall
+		 * back to the chip's own fwnode so legacy DTs that declare
+		 * rs485 properties at the top level keep working.
 		 */
 		if (port_np) {
 			device_set_node(dev, of_fwnode_handle(port_np));
 			ret = uart_get_rs485_mode(&s->p[i].port);
+			if (!ret)
+				ret = uart_get_transceiver(&s->p[i].port);
 			device_set_node(dev, saved_fwnode);
 			of_node_put(port_np);
 			if (ret)
 				goto out_clk;
 		} else if (devtype->nr == 1) {
 			ret = uart_get_rs485_mode(&s->p[i].port);
+			if (!ret)
+				ret = uart_get_transceiver(&s->p[i].port);
 			if (ret)
 				goto out_clk;
 		}

-- 
2.47.3

