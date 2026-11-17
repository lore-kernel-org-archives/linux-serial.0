Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.73
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794896064;
	b=lR0si1AurPSHNMww+xnsdks5svWLgeh9y9vxUVYgmdHhbgd+ay4S9U6zr/u2Uq3WcISa
	 zgt9GsStxv6U+yi4tLpjpVWkouZZTi6dBbc2nDOjT/ZZ5mfWQMN4yeXJFP1w+DWM3Pdxo
	 kUZifrFRkoOhd+cUTV4K5yBI7QrefbPV1/DFZlcMyfGAKTSqTRScpK/KKZ20ZmxJsUqtx
	 KUO56idgExXRMtP5C25aegjGzj7xnXR2Odc6+HDHFeRaUD7qv57lWGAxTd0jcU52Mz8eO
	 vKC2Dhf0HtfbCA4H9gkzgpEvLWAWS66EcEp2B2JXs6dtTrYfvkASoImu5uYsSXy9BUA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794896064;
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
	bh=XMaeVK0+vvSmz0BgfnVmnrm45Y8sxR0FNYjuSe2QVnI=;
	b=wDNQMjAl490Eub1Ik+BQM+B9JZI5C2l1ljIugu4AxsCiPZTZ2nhRs0s2WnmdnUMKpCUv
	 F8f39wkRmy3W0HhgqtIrFuS/urB5y4ZiTQDCXNp5Zx1ksEEfaHJf7PLMENIbB8ZLnAPQ5
	 8z3brC3gAMYUcESkIotOF/Wjs978YksH7UixOETM7Hjy3RUJfHKYyB3NGeXJcm8u3XPVa
	 +Gng8omOnyQ8u7ZQaeubp8yB73fzeEmhgriHfUwqueYt9FcqvioImeoEXT7Ip93r7yz6s
	 11trYb+IWgHBxQcrRrIOJvRtaRRpy6ImFrBpQgyXlGc/3rO2Be8I6IV9lrH1POS4aNw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=vaisala.com;
	spf=pass smtp.mailfrom=vaisala.com;
	dkim=pass header.d=vaisala.com header.i=@vaisala.com header.a=rsa-sha256 header.s=selector1 header.b=LmQAEfBn;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.73
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11023073.outbound.protection.outlook.com [40.107.162.73])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C4A606A336;
	Tue, 17 Nov 2026 06:14:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 75C4A606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vaisala.com header.i=@vaisala.com header.a=rsa-sha256 header.s=selector1 header.b=LmQAEfBn
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pjKSEkW0M5NWmtriQGK1t9fz0hJ2MY773nxaCA602ZC+hR/NszQ73tz9DdIR8oFiL1zN8qfVrUg+nsc/owaa8vJXFZ4u1a/Ffl/+pTLG1ik+z2bauZw2IgBzoFtoOR/lO85sZnpfIUu5riznCSDgopBszptX0n/b4w14LcJf0VD0NeL3Y1Ne+kjpiUHILtSF3CSmLyhLZvmcVpKUXUuUYGLT2lpn4ostqrtQEXkERwu886lT8a8/d5mFI0MYgVlRYZ6gSUeoKAnJN05Uf/a9GDMprJgV/TtRQqoEIurGw5aI7G0yn9Zi+naJdAJx+gVykPpZGE7YtZQfFrrSKrryVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XMaeVK0+vvSmz0BgfnVmnrm45Y8sxR0FNYjuSe2QVnI=;
 b=nX6pH4tmIJeCb+f/47A9baUhn/aC7BGs/TfMwp+oj6GDOD6fJFOxmhpXie9B/GOoll+NbsFkQRo8LM/BpXIKuHKxtAeXBu0v99oG4QMRVCYxPWQvzwh6SndWw3yADx6f1AUmlAkOD79kwhveRKN5fYPCU8vGTm9AZ8ukynklFjZDbi8ydd2S1n0wrXk+eAAvh3kCKoXx7HCOhFI+ySzP9+MCW0PZhJusEqlklnzrpC1GaZDMgkd3VsxNcK56IlKdIqCqrqGFC/eY8MkiHAkuIp5z/BJHlmyYsP42xL0LGdHkBOuA1EglhYX1km7qO/VBqOqShi44juaf3kAJNwE3AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XMaeVK0+vvSmz0BgfnVmnrm45Y8sxR0FNYjuSe2QVnI=;
 b=LmQAEfBnEFVJNqvPls4A1WyRov5xWCWLgWp/UmMflRQzMG0V9r1EiYq9XNDHPgN+BNwltdrh726s5h3fJKID4Hgi7IuCXOPNn4werREbAVDDrh6F3QlEceRNiUNdxHGKvWxom7Z8LfwmSWH+xOa+578DiLtY8XoJIrm+l6Q4jpvR3v4XDzTDYT3o3tRmpS9GiL8Kwzd2+POJbJrl1tiBO9WJDxlpAaopZamlrfcZDPIj2xdlPbldXHeMRPuxpTWKWnHEXsRF+rJHiM0y2HfGl7Oro/B4dmn5bdg7NNGl3NykZfSweR4MA0o0cMLE1AG4f51W15z5/E9OLmFeW+O0ZQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from PA2PR06MB9176.eurprd06.prod.outlook.com (2603:10a6:102:407::17)
 by DUZPR06MB8724.eurprd06.prod.outlook.com (2603:10a6:10:4b1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.13; Tue, 17 Nov
 2026 06:14:14 +0000
Received: from PA2PR06MB9176.eurprd06.prod.outlook.com
 ([fe80::b6d:8160:d324:3bfc]) by PA2PR06MB9176.eurprd06.prod.outlook.com
 ([fe80::b6d:8160:d324:3bfc%7]) with mapi id 15.21.0615.013; Tue, 17 Nov 2026
 06:14:14 +0000
From: Tapio Reijonen <tapio.reijonen@vaisala.com>
Date: Tue, 17 Nov 2026 06:14:06 +0000
Subject: [PATCH v2 3/4] serial: max310x: hold TX data until the software
 RTS send phase
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261117-max310x-tx-fixes-v2-3-b395126fd23d@vaisala.com>
References: <20261117-max310x-tx-fixes-v2-0-b395126fd23d@vaisala.com>
In-Reply-To: <20261117-max310x-tx-fixes-v2-0-b395126fd23d@vaisala.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, 
 Tapio Reijonen <tapio.reijonen@vaisala.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794896051; l=7600;
 i=tapio.reijonen@vaisala.com; s=20250903; h=from:subject:message-id;
 bh=eawYP+amhLcsiszAvBXsQrRq2vOHPblbI7yOPemon40=;
 b=wRX4cBxUUPTw3ujh/F0ovn3x9hbpKhjIVzuuzmLwFCq7cPrgoFWBbsoWXyie60kGN6RXg78BN
 Nd6UDCoCWeyBIf4QQ4LaUSu8D0RvsaC6SpDFdbpsLtcn1trN8v0rkS4
X-Developer-Key: i=tapio.reijonen@vaisala.com; a=ed25519;
 pk=jWBz3VD84WbWgfEgIqB5iFFiyVIHZr52zVBPOm7qiGo=
X-ClientProxiedBy: GV3P280CA0020.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:b::32) To PA2PR06MB9176.eurprd06.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: PA2PR06MB9176:EE_|DUZPR06MB8724:EE_
X-MS-Office365-Filtering-Correlation-Id: acb4558f-304e-469e-6c5e-08df44720102
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|52116014|1800799024|376014|18002099003|22082099003|6133799003|3023799007|5023799004|11063799006|10067099003|261026140227099003|261022075727099003|261026121527099003|261022105027099003|261028144727099003|261021123027099003|261021121427099003|56012099006|261009223027099003|261102123227099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	l1OO7L1PxAnVD8wyYMJ6gIyMcwO2XWWmGCm91dt4Vk87CBObQXz3guR1rbjZDOXcWmMBI5k/q8Xv7/2SkOUiJxjxJcvlbSWplmErRdwzZnCCzdpZxBc1b6exsPKKCGEBbRqeRM1Pc5CHJ8iHE7iDq8B4eFOF4cW/csRD9QjpGsXHFVqc5HLZBwhKq3sapgdLNrJNgy3VrDB2pOmsoDV9WthBZAF62id793Mzrv/J3w0HZt2E53nUGo8n46qqDecdKDZaqxaELhOMY8aL1T59g7pcTsugUklepULA7c6IGP9Pw7Mf5G2209wissvRrxeqV4fxWdBLAMkUKR23WfubGXOVpyVdoXm5TjOhrUy/cpTpe9A6UjyXYV79Abx9rWZ59E/WcSC0DPKT7rzbESFhPLqZSjMnQZnTqi/wYC8CiiuxOBGnRFYRVSZMySMXxULAZskcQOPVsitsvNi2wJQq3jikkHt8ZuzWBKAudO80ZTmglmEkwQg3Dz22lvirwlHyOya1+O1w3LYxVviTO+kNeS2uQM7I0qiqY7Gdg6EPK6bwi5mCJectjD9Yt4/F2VpzWmCKaqJptuUgMgddpDbXOJBHD1YnWD5Ry+muKdXxMxaWey69/z1Uy8w76AXYwdhqpZj2UDHPyJHq9BVwBB3e++r2XDwZuzpQTCx+r78mWxDsa2H7goZxfvOwZ0ONYjsEyyfZ/qCUUytNRJC1FNlWHfw1WkYGVSh/Q2M6MqasNp8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA2PR06MB9176.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(52116014)(1800799024)(376014)(18002099003)(22082099003)(6133799003)(3023799007)(5023799004)(11063799006)(10067099003)(261026140227099003)(261022075727099003)(261026121527099003)(261022105027099003)(261028144727099003)(261021123027099003)(261021121427099003)(56012099006)(261009223027099003)(261102123227099003)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K25hdkJIUW9taDl1N0I5b1gybGJ6UThPV211c0pTWm1PWnRqZkxsVkFFWjRo?=
 =?utf-8?B?cGNiTkRJQ2FGL1BLVmZqR2hvTkt4cHBEYVdmUm9HN3BTT0thZmRQS2tkV2xy?=
 =?utf-8?B?cmdvNHEwMHIvTC9PalozMWpHV0pGRk0wQVJ2bDQ2UERCMVpaSmJPWE1JbGpi?=
 =?utf-8?B?TmZxUVpnMzlxM01aNVUrbUNEM0hEWjg1Q05SYjdBTlJkcWVrMk5jOTR2bjR6?=
 =?utf-8?B?d2RPMjlxTExXTEhsWDlpQ0tBUFlwSUQrcDJvc1A2eFJtNFZ5aExFQWYySXJh?=
 =?utf-8?B?aHdBVVF6TmY2dUNGSnRKZ3ViMWRiZWtNdm1mbi9aYmJnamZRYXNNQldQKytN?=
 =?utf-8?B?a0FHTWliVnhFSDJNRGFNT010UXNaZUhNc3BLOWtRWHg0ZS9rc1dvZGhYQ3ow?=
 =?utf-8?B?ZEVOdGJNT0QyaE1VTC9YeWwxckpxVktvWnFHczlTTVFTemlEdWZiRUE0L2pH?=
 =?utf-8?B?SUNiQ1hqNm90WWllZGNzYUcvNXZweTc1ZzA5WS9NSm1HMmN5ckRYYkowVllC?=
 =?utf-8?B?WGpJc1djclh6c05tYWhlT2p4N0ozWlpvNWxYRW4vZTg2OFB6RE94VXJOdENw?=
 =?utf-8?B?VGxKS0pMaElLMVFEL3dLQTlUOHA1TFZ0bnMwcURJZUUvbXh4N3BwUWU3bzNs?=
 =?utf-8?B?VEpLc2JTN25mNU1IbWtROC9HSTJNak5OYnAzSDBjWFVPcXd0em9FbjJDeGF3?=
 =?utf-8?B?UUx3UGx6aGRsODZSU1Jyc3UrZzdBdWxSczBZdXlXNkw3R2RKZjc3bjVRQU5x?=
 =?utf-8?B?akIycTFCTC82blFPZHlQdHJGM1hLUnc4RU1kTHFra0ZWdnlYcXZ4YmFUbU1l?=
 =?utf-8?B?aVgrY2VDS3hlb205cU1ac1phN09zMmFhbnJEUU9CVXc5R0o4bWtWRTBERU9W?=
 =?utf-8?B?QlNwbDVYU0lmTXc0bDZLbnVWSkNMVnVZMm9pc0VRRlVhdktjU1k4N0JjT2t6?=
 =?utf-8?B?QmJKL3dlUlIwbktGdUdkVlFoMWk0eXBYbC9EM3I1VStWdFUzY0k0T3B2clU2?=
 =?utf-8?B?UnFXc29BSGt1WlljcWM2bkg3WGMyWmsyWXgvVmZOaUliMC9Sd0ZXNVg3N2VB?=
 =?utf-8?B?enFGR0ZWSU1nRHZTSzVvbWhJOFNqa3pzdEhFVHJVdTlYTy9kd0o3OFFkdita?=
 =?utf-8?B?TXZxaUZaL3V1aFFJQklkQUJzeVNDUnRhUXdQWCtoR3lVeTdCWnVaSXhzT3Bi?=
 =?utf-8?B?QWFSY0grVi9FbTJ4U2tFUnBwRmFvdjVYVkxqWXZYNDVUNDd0QWtld2hDQ1g3?=
 =?utf-8?B?SU81Q1hEOW4rZkp3K3J6REZ2Z3NaMWE3T2U0MldSUlpRRWlTRGhjMUFTamdE?=
 =?utf-8?B?ZW1BbXlnSnRTMUltRDduVWFoNU4rV3orcVNxeEZ3TklCaTB6M0tOcWh1bmdl?=
 =?utf-8?B?K2ZjVThrcjQ2RXVWYnloRWZmVzQwVWh2QW5zRDdqY1c0aUxRVFFZU2R5VFFO?=
 =?utf-8?B?dm82dFNoci9GVDltc0hPQXlGb2VYcjErZWg5aHFjV002TkNZTEJpWmpVOUpa?=
 =?utf-8?B?Zi81c1FuZFRBcHVvZlh6Zkg4d2dYUlEzaHlITDM1WnlmR1ZhelBUWnZuRjFG?=
 =?utf-8?B?c3kxM2NjSGE2MENZVEdqbVdDeG93czFCdEZFTEREb0cvSzRmeFY1bE8xcm9j?=
 =?utf-8?B?aEovZ0hDb08yVkVRMll5Y2ZSN2gyRzJaSmFtdDJ4UWJMandiZGx2MUNsR3Zi?=
 =?utf-8?B?aVMzcG1RTWd6NzRJN3R3OHpLalNpVkJtbnJQQWk4ZlVOdE9qZ3d6VHlDOUJa?=
 =?utf-8?B?bTN6UHFkWk9Wa1ZFN0xZWlNhVFFHN3FEU01MNVc2Y01DSWlXaDRnRnJJMkJ5?=
 =?utf-8?B?TXAzaUlKanZpTi9nRFVGOXhLbWtaUWNhUDBuUUE2YTcrMGI3Tm8zWHlkWmNn?=
 =?utf-8?B?L1o0L3ZLbWFVSzE1L1dhdUNFMzJ1VmJVTzJUM2ZKakZXQ09Gb2h1UEhyVFJH?=
 =?utf-8?B?YzdvRTZzNUpLVmhtUTQ3QjMySldacDVuNWlZSXRKc1dZYzZUV1RPRVEzcDR6?=
 =?utf-8?B?THVXVFpoaVB1bXdHS0ZwOW9KSUZxZ3ljYmROZVNVaXk3S2FhWFpVZVF3bnhP?=
 =?utf-8?B?NFhaUmFQbll4WTdXT1BmQU5tMXlNK1VxWTliOElTcERFZGxKeTIxMll6TzJG?=
 =?utf-8?B?N0hiQjl1LzgrUEhDLzlHMU52SHBuY0VXN1lzMGU3aFRSWFdCMjgrOTFhSlp5?=
 =?utf-8?B?L1FNd0FkZWV4Q2g1enhlQWVzVzY1TStDOHZycVZJbGlJbVB3ZzhHbllVTTZy?=
 =?utf-8?B?TTJhcUw3YlQ0Ni83YnNZZHlYVHpTUXRROWM1Y05FRGNHU2p5TkdYb3dLMFBS?=
 =?utf-8?B?aVVwaTBXVjR1NkdWby9YdTVGTU10eFltVHJMblVEL0wyL2hjUmlnVzg4Zldn?=
 =?utf-8?Q?uMkfE0RehmNNa0NM=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acb4558f-304e-469e-6c5e-08df44720102
X-MS-Exchange-CrossTenant-AuthSource: PA2PR06MB9176.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 06:14:14.4608
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PIVxgoc9QpTNh9/n+eU43+r/GByKNAYliashtf79p+mt0eB0uQOORaY4Eos6nZkOioIqAD6rGthHgbrwbMd8JSLUcJgAi0h4dRGDDULeeG0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR06MB8724

On the software-timed RS-485 path, start_tx() begins an envelope by
setting MAX310X_TX_WAIT_BEFORE_SEND and queuing the RTS worker; the
data may only go to the chip once the before-send timer has moved the
envelope to MAX310X_TX_SEND and scheduled tx_work. Nothing enforced
that: max310x_handle_tx() pushed whatever was queued whenever it ran.

The chip latches its TX-empty interrupt when the last byte of the
previous envelope leaves the FIFO. Under load the IRQ thread reads that
bit late, after the next write has started a new envelope, and
schedules tx_work for it. That run found the new data and pushed it
into the FIFO while RTS was still down or the setup delay still
running; the chip transmitted at once, the head of the write left
through a disabled transceiver and the receiver saw the rest misframed.

Seen on a MAX14830 with a 20 ms before-send delay: with 25-byte writes
every 20 ms, 33 to 88 such losses per port in five minutes remained
after the after-send race was fixed, several of them as misframed
bytes.

Hold the data while the envelope is not in its send phase. The
before-send timer schedules tx_work when it moves the envelope to
MAX310X_TX_SEND, and so does a write arriving during a send, so the
data leaves as soon as RTS is up.

One more path enters MAX310X_TX_SEND, and it does not schedule
tx_work: a set_termios() that moves a running transfer from chip-timed
to driver-timed RTS adopts it in max310x_adopt_hw_tx(). A tx_work that
runs after the path has changed and before the adoption is now held,
and with the chip FIFO empty nothing sends the queued data until the
serial core's runtime PM calls start_tx() about 0.5 s later. With only
the hold in place, 10 of 338 baud rate changes made near the end of a
chip FIFO load stalled for 370 to 490 ms. Restart the transmission at
the end of set_termios() the way rs_work does after an RS485
reconfigure, through a helper for both. The helper leaves stopped
output alone, as serial core does.

A software envelope between two FIFO loads looks the same as an
adopted transfer, so a set_termios() that lands there restarts it as
well: RTS stays asserted and the rest of the data waits for one more
before-send delay. rs_work has always done that for TIOCSRS485.

The comment in the IRQ handler said that a stale TX-empty interrupt
cannot push data during the setup delay; correct it. The hold does
not apply to the hardware RTS path, which does not use tx_state.

Fixes: 33632215e1bb ("serial: max310x: drive RTS in software when hardware delays are too short")
Signed-off-by: Tapio Reijonen <tapio.reijonen@vaisala.com>
---
 drivers/tty/serial/max310x.c | 72 ++++++++++++++++++++++++++++++++------------
 1 file changed, 52 insertions(+), 20 deletions(-)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index 7ddfe8773faf9bc51621c49fa5d8e7d6b1e4bc34..d92bf241558862cd83073c1d12ec9f0aaf88f090 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -942,6 +942,16 @@ static void max310x_handle_tx(struct uart_port *port)
 		return;
 	}
 
+	/*
+	 * Outside the send phase of a software envelope RTS is down, still
+	 * in its setup delay, or about to drop: a late TX-empty interrupt
+	 * must not push the data out now. start_tx() opens an envelope and
+	 * tmr_tx() reschedules us at MAX310X_TX_SEND.
+	 */
+	if (READ_ONCE(one->sw_rts_during_tx) &&
+	    READ_ONCE(one->tx_state) != MAX310X_TX_SEND)
+		return;
+
 	while (!kfifo_is_empty(&tport->xmit_fifo)) {
 		unsigned int txlen, to_send;
 		unsigned long flags;
@@ -1077,8 +1087,8 @@ static irqreturn_t max310x_port_irq(struct max310x_port *s, int portno)
 		if (rxlen)
 			max310x_handle_rx(port, rxlen);
 		/*
-		 * TXEMPTY latches on the FIFO becoming empty, so a stale
-		 * interrupt cannot pump data during an RTS setup delay.
+		 * A TX-empty read late can belong to the previous envelope;
+		 * max310x_handle_tx() holds the data until the send phase.
 		 */
 		if (ists & MAX310X_IRQ_TXEMPTY_BIT)
 			schedule_work(&s->p[portno].tx_work);
@@ -1314,6 +1324,28 @@ static void max310x_set_rts_ctl_params(struct max310x_one *one)
 			    MAX310X_IRDA_RTSINVERT_BIT, irda);
 }
 
+/*
+ * A reconfigure is applied: restart a transmission that it left queued, on
+ * the path that is now configured. A send state without chip data has
+ * nothing in flight: restart it as a fresh envelope so the before-send delay
+ * is honoured. start_tx() can drop and retake the lock through the uart_port
+ * API - callers must take it with uart_port_lock*(), not a spinlock guard.
+ */
+static void max310x_restart_tx(struct max310x_one *one, bool chip_tx_empty)
+{
+	struct uart_port *port = &one->port;
+
+	lockdep_assert_held(&port->lock);
+
+	if (!port->x_char && (kfifo_is_empty(&port->state->port.xmit_fifo) ||
+			      uart_tx_stopped(port)))
+		return;
+
+	if (chip_tx_empty && READ_ONCE(one->tx_state) == MAX310X_TX_SEND)
+		WRITE_ONCE(one->tx_state, MAX310X_TX_OFF);
+	max310x_start_tx(port);
+}
+
 static void max310x_break_ctl(struct uart_port *port, int break_state)
 {
 	struct max310x_one *one = to_max310x_port(port);
@@ -1363,7 +1395,10 @@ static void max310x_set_termios(struct uart_port *port,
 				const struct ktermios *old)
 {
 	unsigned int frame_bits = tty_get_frame_size(termios->c_cflag);
+	struct max310x_one *one = to_max310x_port(port);
 	unsigned int lcr = 0, flow = 0;
+	unsigned long flags;
+	bool chip_tx_empty;
 	int baud;
 
 	/* Mask termios capabilities we don't support */
@@ -1482,10 +1517,19 @@ static void max310x_set_termios(struct uart_port *port,
 	 * taking over an in-flight transfer arms the after-send hold from
 	 * the character time.
 	 */
-	to_max310x_port(port)->baud = baud;
-	to_max310x_port(port)->char_time_us =
-		DIV_ROUND_UP(USEC_PER_SEC * frame_bits, baud);
-	max310x_set_rts_ctl_params(to_max310x_port(port));
+	one->baud = baud;
+	one->char_time_us = DIV_ROUND_UP(USEC_PER_SEC * frame_bits, baud);
+	max310x_set_rts_ctl_params(one);
+
+	/*
+	 * A tx_work that ran while the RTS path was switched above has
+	 * returned without sending, and nothing else pushes the data it left.
+	 */
+	chip_tx_empty = !max310x_port_read(port, MAX310X_TXFIFOLVL_REG);
+
+	uart_port_lock_irqsave(port, &flags);
+	max310x_restart_tx(one, chip_tx_empty);
+	uart_port_unlock_irqrestore(port, flags);
 }
 
 static void max310x_rs_proc(struct work_struct *ws)
@@ -1518,26 +1562,14 @@ static void max310x_rs_proc(struct work_struct *ws)
 	/*
 	 * The configuration is applied: release any TX that start_tx()
 	 * deferred while the reconfigure was pending, now on the right
-	 * path. start_tx() can drop and retake the lock through the
-	 * uart_port API - a raw spinlock guard here would unbalance it.
+	 * path.
 	 */
 	chip_tx_empty = !max310x_port_read(&one->port,
 					   MAX310X_TXFIFOLVL_REG);
 
 	uart_port_lock_irqsave(&one->port, &flags);
 	one->rs485_pending = false;
-	if (one->port.x_char ||
-	    !kfifo_is_empty(&one->port.state->port.xmit_fifo)) {
-		/*
-		 * A send state adopted without chip data is the deferred
-		 * write itself: restart it as a fresh envelope so the
-		 * before-send delay is honoured.
-		 */
-		if (chip_tx_empty &&
-		    READ_ONCE(one->tx_state) == MAX310X_TX_SEND)
-			WRITE_ONCE(one->tx_state, MAX310X_TX_OFF);
-		max310x_start_tx(&one->port);
-	}
+	max310x_restart_tx(one, chip_tx_empty);
 	uart_port_unlock_irqrestore(&one->port, flags);
 }
 

-- 
2.47.3

