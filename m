Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11023141.outbound.protection.outlook.com [52.101.83.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD253A2549;
	Thu, 24 Sep 2026 08:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790238767; cv=fail; b=QnGFZcP3stg/VHSJBx2UKX7drIScHJsG11hVIZ3mONhOrFJz9Dr/nhUKIJze0jT+8DkZ7qJHrcMvid233q/ce3froSRcDxdcG0OEBOClgzGp2m5M6FTwIAdLPtkw13pO5zb6fiLAzR1raqOVu0dm1pO/XC5ksh2iubP6mbdDUMc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790238767; c=relaxed/simple;
	bh=EjT9pGxLuxwaFZ0y/Tiadh7lglCrxg7GhQXxv2+LKcM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=naSnSjQzUFDbh0Reo9QI3y4w+/5ww3aXUdCR6fJKA97k5mSGLaMwXjxjm5AUgQVIT7ieTWC92lmsHqlOFXbriBe2fOoyr/HrkFXh5qq5zCZ+E6VXl2Lrldz4WjmGWk1gcT4qtqSUaNqCDSkBCyBKxww7ZqwVNKUztUfrz+11+/M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sttls.nl; spf=pass smtp.mailfrom=sttls.nl; dkim=pass (2048-bit key) header.d=sttls.nl header.i=@sttls.nl header.b=oDMh6ii4; arc=fail smtp.client-ip=52.101.83.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sttls.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sttls.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sttls.nl header.i=@sttls.nl header.b="oDMh6ii4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GF7Rid2zYL7QkMvIniODJwBCa4mK2dcDYYmmZcisA73cvou1/ljrRV1Ha/79V8xDeGA6mH4qZ97kTwF3tuoIXmug3IjP0eFx+b+dlv7eUZv0faZDtQejSDly+kPDNyyxOKLaNtP8Vct3ZpAXRjGYfcya1SnTIff9lRSnwnjTmc3Plcb0qBa5lFPwh+2dgwy8RY3t64wWrBapIcCCJ9YE3ts8cLoXKfoe6+VuXDDM0zzrHyNpen7TEK+gq7N2d+XV7ztgzB0yk9MJ79dulpUS6T/MsiW20yzgElIYBRLxjyoSwyKAoNJGyvwP9Avvqvy2Mz4bgOnYE0P+WVwKjisSIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EjT9pGxLuxwaFZ0y/Tiadh7lglCrxg7GhQXxv2+LKcM=;
 b=RZovg/3QK8+IVju7Flzz078YVwIjtZRnwkdydIEgX5KkhDiSk7wcHxXUzo2/WtYjooMts+YYI/Ry7HP/DxqkV/gDPlnP4NR5cPgvE3I1e5moy+ZSMNfNaGwdoUfVE3RyZLHC6929HQFY1v8zas0AXmqkEi/YqlmJtJ6AMAZtu6wmpOOHsdRVqUVF3PLyPvkJXFLUabHq5TH9pHZ52AMh6ATqIJNaUEeFAKMS7MYtqXR77SHzWVQFOUK8s4rHe/n/6AJl63+a4ttX7KQRZn+vHLk854e3Y0rjpvjF45vcAkLV7yXH3MX780w5mbUKK5VJVV3zfcSUfhgaDC65s7XT7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 20.93.157.195) smtp.rcpttodomain=gmail.com smtp.mailfrom=sttls.nl; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=sttls.nl; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sttls.nl; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EjT9pGxLuxwaFZ0y/Tiadh7lglCrxg7GhQXxv2+LKcM=;
 b=oDMh6ii4IpInA4myfPbcG1W3klGpEq1lWufYFs2oYSsusHpARIBtvINEiImXwDnVc88pelJFypIB2e+0vP37Drxa7PXej8MtDV2trMIxT0vio957WDdlOr9fSiB2ZJAQD6eLG1MLjGxG5qClU2XNWjyMeYo8aW2QWVC+4bINEdmu9eGO3ZeG99FgNzikGloDv/jVuLFwB1bSJqYRb9Afaa/BNJwwZNAOOQQeJ85OJKDEhpYVTa1XRnXHQmUve58h1Wr233aA+schHmNpl3BOYTgi7ifh6CRqfBPewVzNch3FFMouX92UvcY3GAVMZ1Wrj45m72t8VkKqjlcjTQ0fFA==
Received: from DUZPR01CA0055.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:469::19) by GVUPR05MB12702.eurprd05.prod.outlook.com
 (2603:10a6:150:330::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 08:32:40 +0000
Received: from DU6PEPF0000A7E1.eurprd02.prod.outlook.com
 (2603:10a6:10:469:cafe::41) by DUZPR01CA0055.outlook.office365.com
 (2603:10a6:10:469::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.18 via Frontend Transport; Thu,
 24 Sep 2026 08:32:40 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 20.93.157.195) smtp.mailfrom=sttls.nl; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=sttls.nl;
Received-SPF: Pass (protection.outlook.com: domain of sttls.nl designates
 20.93.157.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.93.157.195; helo=westeu11-emailsignatures-cloud.codetwo.com;
 pr=C
Received: from westeu11-emailsignatures-cloud.codetwo.com (20.93.157.195) by
 DU6PEPF0000A7E1.mail.protection.outlook.com (10.167.8.40) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 24 Sep 2026 08:32:39 +0000
Received: from DB6PR07CU003.outbound.protection.outlook.com (40.93.64.95) by westeu11-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Thu, 24 Sep 2026 08:32:39 +0000
Received: from GV2PR05MB11941.eurprd05.prod.outlook.com
 (2603:10a6:150:2cf::21) by DB9PR05MB10424.eurprd05.prod.outlook.com
 (2603:10a6:10:450::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 08:32:35 +0000
Received: from GV2PR05MB11941.eurprd05.prod.outlook.com
 ([fe80::86e3:136c:737e:e29a]) by GV2PR05MB11941.eurprd05.prod.outlook.com
 ([fe80::86e3:136c:737e:e29a%3]) with mapi id 15.21.0451.014; Thu, 24 Sep 2026
 08:32:35 +0000
From: Maarten Brock <Maarten.Brock@sttls.nl>
To: Ginger Li <ginger.jzllee@gmail.com>, "jirislaby@kernel.org"
	<jirislaby@kernel.org>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>
CC: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] serial: max3100: Fix a data race on s->rts in
 max3100_work()
Thread-Topic: [PATCH v2] serial: max3100: Fix a data race on s->rts in
 max3100_work()
Thread-Index: AQHdSrQ0OfrVpZejHUSsRylLfJiPN7bdaG7g
Date: Thu, 24 Sep 2026 08:32:34 +0000
Message-ID: <GV2PR05MB11941D5360C9A4D678E9A6E1E83812@GV2PR05MB11941.eurprd05.prod.outlook.com>
References: <20260922053151.11260-1-ginger.jzllee@gmail.com>
 <20260922170239.33485-1-ginger.jzllee@gmail.com>
In-Reply-To: <20260922170239.33485-1-ginger.jzllee@gmail.com>
Accept-Language: en-US, nl-NL
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sttls.nl;
x-ms-traffictypediagnostic:
	GV2PR05MB11941:EE_|DB9PR05MB10424:EE_|DU6PEPF0000A7E1:EE_|GVUPR05MB12702:EE_
X-MS-Office365-Filtering-Correlation-Id: f66c0086-5a16-4bfe-216f-08df1a16653a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|10067099003|56012099006|22082099003|18002099003|4143699003|38070700021;
X-Microsoft-Antispam-Message-Info-Original:
 W3XiBcIs81Gl72tEGslm+kgkWDytJuQ/4fdOh4HuRPy+woLx7mJtgqEEpHBflMkVtSz9nxWIc5KPBR0C+AEHhVpmoyBNgK0LWuAD4rXXCkJoitCB0JwsFBP1JmbSQfDZZjbsEP78coZW7scUkrTgjPt69lS79H80ZbzX1C+R8MUd7G5aLaS6buFBrGhCF48HcG6NX/bdMUdpVcovAQlTcuQ4IlDz6f9N1f3BwFDS6qJHI7URkUsVRuQzF6C5BfsqIOuUITPp8lnKRqB50tDQzonyFV9fnISn2tYlBRVx7J8HzeuoBvYZwnTUuV65Xmw+oFeUMLeikP2BBg53fWiTLao9mh+9OWhDs1qwpIBnYhAW1MmAESeUBV2wSt55hjCsF7AXwIQ9jaOdyfP1O6i57LeT0vqtViFwwFDkEpYtHMH4WDgyIzwdfeAagYkrHRLU6emP0FDPaCAG8HvrhuV238Rjjme1mndxKUsYJUqE+kwAuMNnCRiPgEdA05pPRpjaOqN8E3tEWnCLcKBh1U9uC+lfD00c8+NMNC14+265LQgO4OtfzRXaeqyz1lWOZWR+JCk8AQ3/xGxTly4Pvyqd59T89h0r3TAAvow6OIPXa2nE2zMOGAcRn1ek9Ktkf62Jfu9V0eUc9/c3rYnGpmWTKuM1T9cUV8P8sx0gdMJkACeu8Mbxcf22bjQDFIXfMuYuDLjLruz6Zyo8WZl/kmRQ/9bRc3FlW+4mpKxW9KxZK3g=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR05MB11941.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(10067099003)(56012099006)(22082099003)(18002099003)(4143699003)(38070700021);DIR:OUT;SFP:1102;
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: NamXqKAEZmoS9OG/Sqy7oq0GxOc4H73NJ/P5ssODF9tlRD1t0v0xVaw1KO05dISzWKmsGm8G6GOVc8BKPGla7mxYdOuNHSAb0snk2TX3EJqN0l+EORoGeK8BTxTuw8pa8YtyU+acH5gGQdsJFjnkrWpuSITow0fQSd1yWXaZ8vo+bvQBu5BVIKsTwjUZeFpZxpUwYJtqSoxDHzXrrF+Czp5YOVWGGY9TWcme9uhODdY/xdujVjtSb8t2y9v9g6r0eONo1LuAC2rb/1B8TvzoeUmFOFRZDGOo7/Whx3rYw1q77Me+LljyOgG0RG5kwS6JRu2cnkUwI2kTSmQdL3UFxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR05MB10424
X-CodeTwo-MessageID: 6201b278-a4cc-4b81-9c41-cc63aa9289c4.20260924083239@westeu11-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU6PEPF0000A7E1.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	44195ba6-cd09-4da6-2b86-08df1a166253
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|35042699022|14060799003|82310400026|1800799024|36860700016|23010399003|10067099003|56012099006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	aEkeS7JyEZihIJJmlyIobvcWloKExY5Fgba/+XiAXmu5PBqhvz5eWaFp9HsVLPahTFqGcJBF7tbl1E9SJm38k9F4a9g4Bha4Nh2fyJ9rXdIsDJvzA5MmYD4XtG4GyvdxP4WFgRVAPu0TZTFI2AkmTGSUinM9C5ZFLjSJcF4ZdiouWvpSTg388pLCaS6ZgvGe8GcSO1evyOvvJ2RShcyniQerLXpQ/FXV47RYWtPepkCqmDDXk6pbcRIHIbVE0sdAuBVGh6R8YaBWRW/YkhQbpitfPL/RdWv2PmbfmrtyyqS/Ki+z9yTgN1wT4Npin+gBzFh9xfAKKJZPwtBkY5GMlH4tScbeU6ZsfyU3lAbrIq2+KQAxL+gSkYd0qtvh2rTVD29pkqbZ0qDhwnlXzev5dPgQogruBpxcylJmTlWuO63340qZs7It6CfJh7+kJFt8nVvGsGHBsxoHXTSG3nL3BkiI3hM0fU9t5KCDsz32MVbmAzDxPmgOY8BgwkfQYisOMero5NJe1P4AE0csElEjZBOntnHI5UyqUolZYLz3iWFwE5xt0SfNcSAA+Sn0vR8sQPE5sO/S0W7EvkWH5bBlN3tBoL2LwhdcUZ0dflM8eAIExe7lZVl8cr6HzX21zxWXZkeBUjGA4w8DqJtfRcMku+cifzrnALKBKrNIuHmZ+SfCI3vMuJUXwitA/z8xV9QrpIbh5i9hWWrPY2osaqp8cA==
X-Forefront-Antispam-Report:
	CIP:20.93.157.195;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu11-emailsignatures-cloud.codetwo.com;PTR:westeu11-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230040)(376014)(35042699022)(14060799003)(82310400026)(1800799024)(36860700016)(23010399003)(10067099003)(56012099006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	FbQcg++R/dqkB98CLrxjEL0nVopUXCJIErNUhYV3UvvIuOBPO6BCyl27cusesbY1BA1U14H46bKdM1V5G2cC7dQqwBhgKgdwgNVMtPcFE3ae6gFXu7Vsjbu9rJsMNsxd7yU695A3HuqsZ0siajfUMuOlzfHcrEXEqI5BDtOQegquW3q6mnj5YIhUFTSIMkzbOeVgE7HnLlFyP3JvKUiOWj7ZgoqoX2hYcgRdCuE4LzvpK9xIp/IJo/W5TpTA4yleljMGFLfAwcUv6yOX+eYN5ai0o24NdPLXln4fe6py8pikk5cMvZ2IydQ13ovvQPx/fd7OYaEngpvWMXII+1hB9ZCrF6ho9XBgcZp0R49Kt/JcnZs1AyP1OyPxQL/ugsdigp7PF2gLrAc7IXIxd5DcUfZvw2qSSHDKKdB3vQHSQM6OGEyb3R6XKp4vZhtdV3KA
X-OriginatorOrg: sttls.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 08:32:39.8785
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f66c0086-5a16-4bfe-216f-08df1a16653a
X-MS-Exchange-CrossTenant-Id: 86583a9a-af49-4f90-b51f-a573c9641d6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=86583a9a-af49-4f90-b51f-a573c9641d6a;Ip=[20.93.157.195];Helo=[westeu11-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000A7E1.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVUPR05MB12702

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBHaW5nZXIgTGkgPGdpbmdlci5q
emxsZWVAZ21haWwuY29tPg0KPiBTZW50OiBUdWVzZGF5IDIyIFNlcHRlbWJlciAyMDI2IDE5OjAz
DQo+IFRvOiBqaXJpc2xhYnlAa2VybmVsLm9yZzsgZ3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmcN
Cj4gQ2M6IGxpbnV4LXNlcmlhbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmc7IE1hYXJ0ZW4gQnJvY2sgPE1hYXJ0ZW4uQnJvY2tAc3R0bHMubmw+DQo+IFN1Ympl
Y3Q6IFtQQVRDSCB2Ml0gc2VyaWFsOiBtYXgzMTAwOiBGaXggYSBkYXRhIHJhY2Ugb24gcy0+cnRz
IGluIG1heDMxMDBfd29yaygpDQo+IA0KPiBtYXgzMTAwX3NldF9tY3RybCgpIHN0b3JlcyB0aGUg
bmV3IFJUUyBzdGF0ZSBhbmQgcmFpc2VzIHMtPnJ0c19jb21taXQgdG8gdGVsbA0KPiBtYXgzMTAw
X3dvcmsoKSB0aGF0IGl0IGhhcyB0byBwcm9ncmFtIGl0Og0KPiANCj4gCXNwaW5fbG9jaygmcy0+
Y29uZl9sb2NrKTsNCj4gCWlmIChzLT5ydHMgIT0gcnRzKSB7DQo+IAkJcy0+cnRzID0gcnRzOw0K
PiAJCXMtPnJ0c19jb21taXQgPSAxOw0KPiAJfQ0KPiAJaWYgKHMtPmxvb3BiYWNrX2NvbW1pdCB8
fCBzLT5ydHNfY29tbWl0KQ0KPiAJCW1heDMxMDBfZG93b3JrKHMpOw0KPiAJc3Bpbl91bmxvY2so
JnMtPmNvbmZfbG9jayk7DQo+IA0KPiBtYXgzMTAwX3dvcmsoKSBjb25zdW1lcyBzLT5ydHNfY29t
bWl0IHVuZGVyIHMtPmNvbmZfbG9jaywgYnV0IHJlYWRzIHMtPnJ0cw0KPiBpdHNlbGYgb3V0c2lk
ZSBvZiB0aGUgbG9jaywgYm90aCB3aGVuIGl0IHNlcnZpY2VzIHRoYXQgcGVuZGluZyB1cGRhdGUg
YW5kIHdoZW4NCj4gaXQgbGF0ZXIgdHJhbnNtaXRzIGEgY2hhcmFjdGVyLCBzbyB0aGUgc3RhdGUg
aXQgcHJvZ3JhbXMgaW50byB0aGUgaGFyZHdhcmUgY2FuDQo+IGJlIHN0YWxlLg0KPiANCj4gUmVh
ZCBzLT5ydHMgaW50byBhIGxvY2FsIHZhcmlhYmxlIGluIHRoZSBzLT5jb25mX2xvY2sgcHJvdGVj
dGVkIHNuYXBzaG90IGF0DQo+IHRoZSB0b3Agb2YgdGhlIGxvb3AsIGJlZm9yZSBzLT5ydHNfY29t
bWl0IGlzIGNvbnN1bWVkLCBpbiB0aGUgc2FtZSB3YXkgYXMNCj4gcy0+Y29uZiBpcyByZWFkIGJl
Zm9yZSBzLT5jb25mX2NvbW1pdC4NCj4gDQo+IEZpeGVzOiA3ODMxZDU2YjBhMzUgKCJ0dHk6IE1B
WDMxMDAiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBHaW5nZXIgTGkgPGdpbmdlci5qemxsZWVAZ21haWwu
Y29tPg0KDQpSZXZpZXdlZC1ieTogTWFhcnRlbiBCcm9jayA8bWFhcnRlbi5icm9ja0BzdHRscy5u
bD4NCg0KPiAtLS0NCj4gdjI6DQo+ICAtIHJlYWQgcy0+cnRzIGludG8gInJ0cyIgYmVmb3JlIHMt
PnJ0c19jb21taXQgaXMgY29uc3VtZWQsIGFzIHN1Z2dlc3RlZCBieQ0KPiAgICBNYWFydGVuDQo+
ICAtIG1lbnRpb24gcy0+cnRzX2NvbW1pdCBpbiB0aGUgY29tbWl0IG1lc3NhZ2UNCj4gIC0gbGVm
dCB0aGUgcy0+cnRzIC8gcy0+cnRzX2NvbW1pdCBzcGxpdCBhbG9uZTsgZm9sZGluZyBib3RoIGlu
dG8gb25lIGJ5dGUNCj4gICAgd291bGQgYmUgYSBzZXBhcmF0ZSBjbGVhbnVwDQo+IC0tLQ0KPiAg
ZHJpdmVycy90dHkvc2VyaWFsL21heDMxMDAuYyB8IDYgKysrKy0tDQo+ICAxIGZpbGUgY2hhbmdl
ZCwgNCBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvdHR5L3NlcmlhbC9tYXgzMTAwLmMgYi9kcml2ZXJzL3R0eS9zZXJpYWwvbWF4MzEwMC5j
DQo+IC0tLSBhL2RyaXZlcnMvdHR5L3NlcmlhbC9tYXgzMTAwLmMNCj4gKysrIGIvZHJpdmVycy90
dHkvc2VyaWFsL21heDMxMDAuYw0KPiBAQCAtMjM2LDYgKzIzNiw3IEBAIHN0YXRpYyB2b2lkIG1h
eDMxMDBfd29yayhzdHJ1Y3Qgd29ya19zdHJ1Y3QgKncpDQo+ICAJc3RydWN0IHR0eV9wb3J0ICp0
cG9ydCA9ICZzLT5wb3J0LnN0YXRlLT5wb3J0Ow0KPiAgCXVuc2lnbmVkIGNoYXIgY2g7DQo+ICAJ
aW50IGNvbmYsIGNjb25mLCBjbG9vcGJhY2ssIGNydHM7DQo+ICsJYm9vbCBydHM7DQo+ICAJaW50
IHJ4Y2hhcnM7DQo+ICAJdTE2IHR4LCByeDsNCj4gDQo+IEBAIC0yNDksNiArMjUwLDcgQEAgc3Rh
dGljIHZvaWQgbWF4MzEwMF93b3JrKHN0cnVjdCB3b3JrX3N0cnVjdCAqdykNCj4gIAkJcy0+Y29u
Zl9jb21taXQgPSAwOw0KPiAgCQljbG9vcGJhY2sgPSBzLT5sb29wYmFja19jb21taXQ7DQo+ICAJ
CXMtPmxvb3BiYWNrX2NvbW1pdCA9IDA7DQo+ICsJCXJ0cyA9IHMtPnJ0czsNCj4gIAkJY3J0cyA9
IHMtPnJ0c19jb21taXQ7DQo+ICAJCXMtPnJ0c19jb21taXQgPSAwOw0KPiAgCQlzcGluX3VubG9j
aygmcy0+Y29uZl9sb2NrKTsNCj4gQEAgLTI1OCw3ICsyNjAsNyBAQCBzdGF0aWMgdm9pZCBtYXgz
MTAwX3dvcmsoc3RydWN0IHdvcmtfc3RydWN0ICp3KQ0KPiAgCQkJbWF4MzEwMF9zcihzLCAweDQw
MDEsICZyeCk7DQo+ICAJCWlmIChjcnRzKSB7DQo+ICAJCQltYXgzMTAwX3NyKHMsIE1BWDMxMDBf
V0QgfCBNQVgzMTAwX1RFIHwNCj4gLQkJCQkgICAocy0+cnRzID8gTUFYMzEwMF9SVFMgOiAwKSwg
JnJ4KTsNCj4gKwkJCQkgICAocnRzID8gTUFYMzEwMF9SVFMgOiAwKSwgJnJ4KTsNCj4gIAkJCXJ4
Y2hhcnMgKz0gbWF4MzEwMF9oYW5kbGVyeChzLCByeCk7DQo+ICAJCX0NCj4gDQo+IEBAIC0yNzcs
NyArMjc5LDcgQEAgc3RhdGljIHZvaWQgbWF4MzEwMF93b3JrKHN0cnVjdCB3b3JrX3N0cnVjdCAq
dykNCj4gIAkJCX0NCj4gIAkJCWlmICh0eCAhPSAweGZmZmYpIHsNCj4gIAkJCQltYXgzMTAwX2Nh
bGNfcGFyaXR5KHMsICZ0eCk7DQo+IC0JCQkJdHggfD0gTUFYMzEwMF9XRCB8IChzLT5ydHMgPyBN
QVgzMTAwX1JUUyA6IDApOw0KPiArCQkJCXR4IHw9IE1BWDMxMDBfV0QgfCAocnRzID8gTUFYMzEw
MF9SVFMgOiAwKTsNCj4gIAkJCQltYXgzMTAwX3NyKHMsIHR4LCAmcngpOw0KPiAgCQkJCXJ4Y2hh
cnMgKz0gbWF4MzEwMF9oYW5kbGVyeChzLCByeCk7DQo+ICAJCQl9DQo+IC0tDQo+IDIuNDMuMA0K
