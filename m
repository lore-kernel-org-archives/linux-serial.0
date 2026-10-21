Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.108
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792560000;
	b=dB84adzXgJ3WMzxU+GBdomwtoLLSfIIHGLO5Vqd5AHWZNiH2+5J12odhYXynw2kPxrJ2
	 3285s26wO5IL/WOIxJ2364tQu0ydDbSqLbNo1v14Etj1T3AEg5alp8rJEfnvHgwpjBj2r
	 n7EKbt182T3gp79rqiCSIsBXIwWU6msukCt0TTOOq/lm+qCB/b/b2n6AruYZ4+JWRMst1
	 fvf25KfxbsqToncbtqhCQUHBW/ZX45P/Y1POJN5+uq4+OJjs7Mk1BOXBuM42/FvOM35qG
	 LOMi8Rjr2LGaJzB89EuD3a0TE90JAeGTvaOLtsVkJHY5/ogYQ6yFyB6C0SeJhREy5MQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792560000;
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
	bh=InfC9Ee+c3PNK0o2A5FEDoo+AHnk9Zkf9oHBfKhZLxg=;
	b=02WJNnqhCAhKEtnmjeHSW2OEFf3UuhqvfRn22nz+mNIj0YDeVoxkZF4zlsH4w/Qmatgq
	 QOopK8FOvXrrYnqbWW8tCoTjT6Z1duCzA4FCav7aMQbOSrS4Fh5DN1vxECDRINP/SpITx
	 6cFF+gCSjdG2wB3GtDL0x2TxVa4omG850Kl/xPfWrPx4Rrkw/FbV0iB5/0TRr1OCDFMH6
	 Yde8IatbtyoB9rYJpBP+QRhculh9H99A25xW32ypaLqRuwFVseVIVFZz4DiW3yKXhO+ms
	 amcil2UyIOfuyepgH5lMWqlc1Ft63jYuEbLX+KRdgJjr8U7LL/tE8n7b9/npIGmTatA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=vaisala.com;
	spf=pass smtp.mailfrom=vaisala.com;
	dkim=pass header.d=vaisala.com header.i=@vaisala.com header.a=rsa-sha256 header.s=selector1 header.b=3Jb3FDD0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.108
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11023108.outbound.protection.outlook.com [52.101.83.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3AE606A320;
	Wed, 21 Oct 2026 05:19:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF3AE606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vaisala.com header.i=@vaisala.com header.a=rsa-sha256 header.s=selector1 header.b=3Jb3FDD0
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vc1DsEbR4iVGPy985D6Xtz4ezX5Q5b4X7TTtA6gZffCql4vZQRam99XkbZfBucoVSb3jlb+TQSxtIoZpGYNU6VCwVf3FLZeEF+JSWHqB0AxeGVAU7OpD+p8ZClF1ZiiMiKa+qDU94wAprfjyFTb3B/YuLkhQYEOAnIYspNw1Fh/Gd8AZkw8hc0nbbxnHgeMsvLpVEOg+4FJpIPD6+/DjnDI8gifyceme9iQZqsi8RGJesPuqGb9RVJF69cXYUQL6Jf4+jSIWtsLtBB9q/pB+Af1J+wGapnLr3INm+VQtcMgaAL9btFFEE33lYuG6b59Ahm9KhhD31iVhYSmG4rV6sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=InfC9Ee+c3PNK0o2A5FEDoo+AHnk9Zkf9oHBfKhZLxg=;
 b=bs76YuBX7tm5sc3nkZWSef4cB1TiQ1/lJKgPvDtDreho8QOe3fxTXzJnYo36umdMIvhGNt4bUDoodmN/Yo+ojRzHDrRayUsr7UJr4ORzjcjeCbblhpJPMPObk2ExenvhmukUgOjb+pcE6+rnAEjzJ085a7KAZGUvp+8W172Wfkqwg9czmamcdDa1ySnc2cbPdBq6rKyoeiGBqn6yfSroU3b/hxN+nnXyh2VMz1pmkEbio0YRxHXJVsGFWVIc0milY5xiKxJWbLI0Fnjx8Nm9CiczkhveuwVn2liPOI2oMptXsBZ1/ydRob0V6xAQaQgy8h7oxUn/A5f6H2WFnmkkcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=InfC9Ee+c3PNK0o2A5FEDoo+AHnk9Zkf9oHBfKhZLxg=;
 b=3Jb3FDD0td2mItaotONeE3z4L+Ew8X/1bcIqdRJ6EWVluy4kyEr0W18cmUyZEqOIWYseynSvsRMWwZxhVGA42xYkzSKfLsNcCXdSXNsVQbS4q1r6x1ajXZx4RPV6ukEDVZgFSyYw33P8emfbkCii6ZPeI3SOSq41k0cx/SDMGSzTF+IvuM5SLywNy67CNkFHVoCLkfuVv8qU9mSvR8IWDfo55hxj4SjE4EDE3gKovU26xkdNqlhd1XRnPrTpV1mh+ZqJ1HuB6P4AVK/UmrpUENDN6AbIC/wFwyCU2jn1/yB3ojK5I419KxFhQjv6GbWQbu17z7tSK/CCJ0yx8LOktg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from DB8PR06MB6441.eurprd06.prod.outlook.com (2603:10a6:10:12f::13)
 by GV2PR06MB10300.eurprd06.prod.outlook.com (2603:10a6:150:2fc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Wed, 21 Oct
 2026 05:19:49 +0000
Received: from DB8PR06MB6441.eurprd06.prod.outlook.com
 ([fe80::2e1c:62a3:98a9:35f1]) by DB8PR06MB6441.eurprd06.prod.outlook.com
 ([fe80::2e1c:62a3:98a9:35f1%3]) with mapi id 15.21.0522.017; Wed, 21 Oct 2026
 05:19:49 +0000
From: Tapio Reijonen <tapio.reijonen@vaisala.com>
Date: Wed, 21 Oct 2026 05:19:38 +0000
Subject: [PATCH 1/2] dt-bindings: serial: rs485: Add transceiver interface
 select GPIO
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261021-serial-rs485-mode-gpio-v1-1-80d7b0903d93@vaisala.com>
References: <20261021-serial-rs485-mode-gpio-v1-0-80d7b0903d93@vaisala.com>
In-Reply-To: <20261021-serial-rs485-mode-gpio-v1-0-80d7b0903d93@vaisala.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-serial@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Lukas Wunner <lukas@wunner.de>, 
 Christoph Niedermaier <cniedermaier@dh-electronics.com>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Lino Sanfilippo <l.sanfilippo@kunbus.com>, 
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, 
 Tapio Reijonen <tapio.reijonen@vaisala.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792559987; l=1589;
 i=tapio.reijonen@vaisala.com; s=20250903; h=from:subject:message-id;
 bh=r6NLeX9TXjrO5CNbM9fj6rDO5yK6ofSt86tOnF2O15A=;
 b=G3FGehPvJaopbGea+sFzO0DadPchhL/XRI5LTcU1ofUgbo2Hy9WufgrZf8WSraKN9MW9KZYjJ
 Upfgusd8wmWBUMC2vt9B/fLIzKZYPCTrNMI6Qdwtu3phIXC1pAj1heX
X-Developer-Key: i=tapio.reijonen@vaisala.com; a=ed25519;
 pk=jWBz3VD84WbWgfEgIqB5iFFiyVIHZr52zVBPOm7qiGo=
X-ClientProxiedBy: GV3PEPF0001DC1C.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:400::105) To DB8PR06MB6441.eurprd06.prod.outlook.com
 (2603:10a6:10:12f::13)
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
X-MS-TrafficTypeDiagnostic: DB8PR06MB6441:EE_|GV2PR06MB10300:EE_
X-MS-Office365-Filtering-Correlation-Id: 73ee2a4b-3239-472a-6da9-08df2f32ed83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|7416014|376014|23010399003|366016|56012099006|38350700014|11063799006|261009223027099003|10067099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	2NpRP0yhFTzt8xIifWpVdWlkeJE6Rvpml0GiRD43k6vc3hW0rnaHgWwfS9mvqC5G2PuUkGIkVLdqh46r8bOVcUIMLZMfao/Y2oDN++D7eboxmu1s+JAhqMHecXHNEjDqSPpr5JGUr8i5IGQvu9iDF23B309Rg5T7djLpGoZ7QBh23Paoz9/1kNxo7SSEKPdgyTskzWq3zDiu1vghNum8SMY3fdKLv6iwJrtDtLZt77m+9KC2MjbChuzSLEz780e2FH5IuxNLQTJab7OSIu3CNiG8xYU0lgxj1I2sp0INVb9/em118jvalfy+o1a7AWRvfB5GPLd7XqJDNpejcd7aN9+MxO40y4sMVw5ioL0MLeaTZ5rzKqpulG4KecM3wv/U/TKUIQZCl3Twx2gKyzdVT2VWotA8vBkriEtrDlseQs9dBPQK2/rVsPXcYZztlYpeLLH4sV/tG8C+THjufaFkW9u/J6GgJDE7PUwHd8n9yHYILPr4I98pVmEg9DYcBIQll6wPFnBXqTCMA1oJPzS0PTLu0cr8l+6rLs89O/IJK3AW+EBnm/BIlKBDmk+vavPqljgqpNcGeV5Ia1ok6hFNm995cvX6+pxa4pL3aELxy1T4CMueFJRt1lwUqtITZ7A3kzHxmxMBT9xnE9EBb+uTEPuywDpLXZ3853bkM8iM7QxQ3DtCZobhjxJ2dlSd4uAHYJPULgNh95R3CUtccDKgoQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR06MB6441.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(7416014)(376014)(23010399003)(366016)(56012099006)(38350700014)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eDRGcVJ5WlhXNEtTUjRNN0Vqa1o2MHM0QkJJWlMxeDRwb2xucVgrVVM4R2VP?=
 =?utf-8?B?L0thcnZQSG0wSnp5TWlIcHF4REhFa2pocmdhK1l4Vzh3aXcrZlgwV2NsaTVQ?=
 =?utf-8?B?UlJFcHVycitJTHdGdzEvUDdvZHkrWW1jdUsxbGtEZDFYTEMwSWNhTUpmTWFP?=
 =?utf-8?B?WmdVdDNhbkE0WVlKdFBlNWQyZG5HZlRONjlTS3kxYWRyNjBsQzdVd0llb1Zr?=
 =?utf-8?B?TllZekdCclEzTmkwTnN4ZkY0dkRDeXhPTEY5dzExUnFsRUhvcGMzSmR6L3FV?=
 =?utf-8?B?N21DbVpHNGNyVnFUU1N0emlVUFBRZGlsUjJGNldKZUg0YWZsZnFZbWNyQWpU?=
 =?utf-8?B?aFBJYWxkV0poS2h3MzBjU001RDJPTGpVREdPZzVTVzdmRy95Z1NwdEVJaVJ5?=
 =?utf-8?B?NWYyeE42bjNWRFN6YzlxUzBRY2xXVFdaTzlmYzZNMHpER1d4cjdoM2FNRlRW?=
 =?utf-8?B?WE1JaElzR0ZDSVJYNEhkZ1NRMUtaNzVkbnM3ck1PNTltcnZ3UXJKeDd3WVpN?=
 =?utf-8?B?eDBPNWFveGo3OFd4cUYzZ3ZlWmlxU2wyZDJ3VS9POGRxdWdQU2dycnlSanpO?=
 =?utf-8?B?dHBHWmVwZzg3Y3NhTUFtODVhVE9iMGg5a1E1VUN0cVVqb0FFZXFLdDJLTnIv?=
 =?utf-8?B?cnNwZXE3VURTcTFWc0hxTzc1cmNGK2VGQjJJZ0huSWsrZ3ZwS0hNdmQzVHVY?=
 =?utf-8?B?OHplN3JFU0E4dWJ0TlZCd2RUeXlCRytEUTI0ODVTcFVVYklLUkV1UzZwZitq?=
 =?utf-8?B?ZG8yMXFsdWpZclp5TGxyamVXZ1BxNnRSOVMremRlOC9KTVFPVEJHUHVDbGR0?=
 =?utf-8?B?cG5ZcmJLc29ZL2J2eTRyVy93TFIzYXhKa1lVNkhuRVZnT0ZYcmF1SzVhTWtJ?=
 =?utf-8?B?M20yRkEreERGVXpZYlRobnlPZEFhVXpacmtBY1J1bFVkLzRDY1A0TjdJNTdP?=
 =?utf-8?B?RHBUdmJueWZmSlpFTmYrKzMxcTN1SWpmc3hGTllJeTJDRjM1YzNBaTkvdGNO?=
 =?utf-8?B?c0hELzlJeWFpTVFmZm0zaDVrdCszeGhUd1NEQTRIdm1pdEU1TFk4Q0d3Rm9o?=
 =?utf-8?B?V2drRGFpZlRsMG5wbUJFUE4xajlhYk9QUldNVWpqRzIxRnFESlJiZlVBUVQy?=
 =?utf-8?B?eTdaSm41TnRwOXk5YWxUZkw4NEFCRGo1ditDRXVoZXRhU1VJa2hJOWVpcWM1?=
 =?utf-8?B?dFFKSVU4TjVYYkRjNmpQWEJjZlhtd1NMTzdrMUEvT0lSMWhaODVSNjQ1dmZC?=
 =?utf-8?B?QitpL1p2SEcvSkZVd3llUkZCbmtBZjhsTEwvdHhpUG0weDVBT3ZtY3h6TUI3?=
 =?utf-8?B?REhCVTVTaENMdUQrS29sTHptQmNNRG13MUZoSTIxaVJHQmNTSWhOSGpvc1hj?=
 =?utf-8?B?NGpjTUo3dEtHMUloUjVmTkhxUUNjRWRGK0VmSkJIenVMK3dJdDJrUE9CZWxC?=
 =?utf-8?B?Z2JpUFRYU1BVcFVnRk1TZ054Y0cyUVFTU1Y4OFMvaGpvSElnbm5wcXpTWDVL?=
 =?utf-8?B?MGt2WG4xaE9DUWhKVTZ4QjFES1BKczBwUllibkZ1NFQ0dUtzZmNnM0R3Y3dx?=
 =?utf-8?B?Q3N5VFpkd0hraWo4RjZ5NjFYbEE2Z1IvU2hrQncvMDFQSE01OSsxYk5rT0hY?=
 =?utf-8?B?bUxyU2dDN1laTXJzMm9IZHordEEyNm1tZ1dhVVFHcGt6T2tjdXFwTDd6TFVx?=
 =?utf-8?B?KzVzN3cxQmtMSGRBVGxLZE80bCs1WWpSNGNNUzRJdGFhL3pJUTQva3JaM2NS?=
 =?utf-8?B?OVVEejVyVVAvTjZMdUdrVTFZRlNFTndpTlN5MVZmL0tXcnk3cmorMWZ0V25s?=
 =?utf-8?B?Y2NPU0luNW82dWM3emxxbXlPZFFrYjBNZEsxZURVWVY3NkpNZWpWZTU3QjVj?=
 =?utf-8?B?ekVJMzZlL1lIam9RN1RaVXRMU0RsVXptcm9NbEd4Qzhzc0ZsNlJJUTNJdE9o?=
 =?utf-8?B?ZkkwU3VuYlhHOE4vblVkb2NReFVBME9ha3RWUlI4cUtBUlBHSDZ3REQyM2lE?=
 =?utf-8?B?R2IxK3I4ZFRkZllpaTF6STFkWWZLS1pSZ0l6bDAwcjZieDdtVzVJWkplME81?=
 =?utf-8?B?WHRCMWMvcG0rVk10d0ZIa2tva25ERC95S3pOVG5MK0JEVGNLcFRDcjRvL1Vt?=
 =?utf-8?B?eDRPVk5MMEhYODErWHhqYWVnSjZlMnZWTzVSWG84YWJ6S0NzMWR3VDcwOUtE?=
 =?utf-8?B?ZHFIMFArODZEd0s1SGYzV2tORkQ1L2p5WG1jb3ZCRU1zYnlQMjlXVFBLLzgw?=
 =?utf-8?B?VlFJNUw2MlljdHR1cEpmNjlTTjBVZmJ5OXdxVENEbXE0dk5OLzhPVlhuSEJ6?=
 =?utf-8?B?NnpJU0FTOXFIc25lV0lYdXdELzdpUEJSUnJ6eUtPdlZIVHdkbVFBcDFkSTB1?=
 =?utf-8?Q?2ozSjZf9emjTqCL4=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73ee2a4b-3239-472a-6da9-08df2f32ed83
X-MS-Exchange-CrossTenant-AuthSource: DB8PR06MB6441.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 05:19:49.0538
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zZxUnWXH1pZgj9EZN+22i6LT+onxXYqDCeBRhP0Hg1RY/6WsZBJhkM1zVsE41T9cnJj85Wrujn48OOJRt8wMgf8etoxSzHXhlhy1hFnfxwM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR06MB10300

Multiprotocol transceivers such as the LTC2873 provide both an RS232
and an RS485 interface on the same bus pins and choose between them
with an interface select input: on the LTC2873 a logic low on the
485/232 pin enables RS232 mode and a high enables RS485 mode.

Add an optional rs485-select-gpios property for that input, next to
the existing rs485-term-gpios and rs485-rx-during-tx-gpios. The active
state selects the RS485 interface, the inactive state selects the
transceiver's alternative interface, RS232 on the LTC2873.

Assisted-by: LLM
Signed-off-by: Tapio Reijonen <tapio.reijonen@vaisala.com>
---
 Documentation/devicetree/bindings/serial/rs485.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/rs485.yaml b/Documentation/devicetree/bindings/serial/rs485.yaml
index b93254ad2a287ad496f791e3ee90eb9defa0609d..2b5fd405e164f308b6036331edce7eb61da2f3ff 100644
--- a/Documentation/devicetree/bindings/serial/rs485.yaml
+++ b/Documentation/devicetree/bindings/serial/rs485.yaml
@@ -60,6 +60,14 @@ properties:
       the active state enables RX during TX.
     maxItems: 1
 
+  rs485-select-gpios:
+    description: GPIO connected to the interface select input of a
+      multiprotocol transceiver that provides an RS485 interface and an
+      alternative interface, typically RS232, on the same bus pins. The
+      active state selects the RS485 interface, the inactive state selects
+      the alternative interface.
+    maxItems: 1
+
 additionalProperties: true
 
 ...

-- 
2.47.3

