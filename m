Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11023129.outbound.protection.outlook.com [52.101.83.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C5E3563F0;
	Thu,  2 Jul 2026 12:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782994635; cv=fail; b=TSXJm9Ry3w+Yzksf5u+a+Zln6RnEkBbEaQAItYDCkiOH+7hraNRmyYYNRacGQ+NeFcAe9/HG47tM1dnRVMzqJ2JK8iiW/jmmdWxhbn7wnD/QjI7AtnYHlw2VSUP5pb6ZILIh091thQI51QsVPcYExNnEcMDOUqJTKAGNtLMtQLU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782994635; c=relaxed/simple;
	bh=ir7OM0DuI/YmRJqcmGYQPmEQskB0lSpqw8mYHxFx/0I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Exrjt2TduwX3uzNzod24ivk/34HcmXXi9i9BGw4bHG4tBxZ5KKWRntmQTfT0TR2UDpIeKtzkx+lMTMlzkPy8AsZQ4uzD0vPhZrNle4ENLWJPy9CvUyKii+q/UXhqJ0polrtgqdcYXEEu7L6b0G4iEggbgKmv/jrxcKjGV0H05Fg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sttls.nl; spf=pass smtp.mailfrom=sttls.nl; dkim=pass (2048-bit key) header.d=sttls.nl header.i=@sttls.nl header.b=jKF8bROR; arc=fail smtp.client-ip=52.101.83.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sttls.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sttls.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sttls.nl header.i=@sttls.nl header.b="jKF8bROR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cnIkgywi3X6qUOakDnLCS8aQA73e+zDjAJz9BYjRiRM5khC/sEwiJ1dJzSbGk6w6DwSrNEU5cNhF0s0EU6iJ2kkSpqFthX//ZjEr0IZ/lqTLQ9r4fEtkGiZvP5+gHlmie57P7pIQN3bO7T2hL0ZKHqoQ7CMOYK2aeFQs7+cLDKhqUuYBfMXsCT90XngnUTN8QsWdxeTKwyPwRM9roYKUm6MgYX25febLonjgVKQK7chT/5fa5gQJYjn/niAOgW2wBYkrwg+0swWx4LAd6yQmoLUevMiPFtJld9n6CtgqKHtvTP8Cwudo37yknqL/kqKwRMGuadhT9FQ/sSJh/kPZfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ir7OM0DuI/YmRJqcmGYQPmEQskB0lSpqw8mYHxFx/0I=;
 b=yAve26G2gKvSdcaYkPqneGzQxenXHqKJe6y1iVsAfNsJB3QHJVIwnV5nKtMD5QYisnjzsU+MmrDDGihsvXtIIn4FrijvtvyAR9FLDv9U2AWl4n8BfAgIxUOBHGLa881TKqxiW8iZDHU9ZG2F5k9567ZJfVKHsTOzyiRNR2PvnSfiNc66+1tzZG4leXn4P7GOigPqDjHnwJ9o7u93dGrVzHSh0ouQ2TWquIhA5mOje46vlOfP3TrG/8AVep9/01SmFmYRbhRl/GQlCn4ZkBAw2MgmxLPrnbLTQ0c6COREydya7dkvXTRcyk/1N8EWRxIsi/0yXs0iliAsDgwOut16pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 13.93.42.39) smtp.rcpttodomain=gmail.com smtp.mailfrom=sttls.nl; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=sttls.nl; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sttls.nl; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ir7OM0DuI/YmRJqcmGYQPmEQskB0lSpqw8mYHxFx/0I=;
 b=jKF8bRORB6mhE0lG6RCJmPWkr6teBERQF6BDGgpPB2p6bR0yXOknwfd8feXhnWOC7nUcV/WIVXH4B1Kti1zw2joYvvJK4ZXWsyZ1S/7ARkkvY1jcbe4OnXXiQy/sjTt7zAoblNedG/r7jWeueJ0CwEBmK6MsBekElEJ79nxQYAm3ApUzhQVqC4b6cjwCO72KP4RiNh0ARRa0lKhluS65QAmr6Dppd5yF9Zte/zuu4S5AukbtiQVvsMTKpOrZ5qJCLtRWvChfk6ruli6fVELpaRbmI1lP69x6nJMqKX1vaeu3BIpBLk4OrOto1hzkiUXA6TDUsNX+SXSpgc8nBk5v9w==
Received: from DUZPR01CA0068.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c2::18) by DB9PR05MB9461.eurprd05.prod.outlook.com
 (2603:10a6:10:363::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Thu, 2 Jul 2026
 12:17:06 +0000
Received: from DU6PEPF0000B61D.eurprd02.prod.outlook.com
 (2603:10a6:10:3c2:cafe::45) by DUZPR01CA0068.outlook.office365.com
 (2603:10a6:10:3c2::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.10 via Frontend Transport; Thu, 2
 Jul 2026 12:17:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 13.93.42.39)
 smtp.mailfrom=sttls.nl; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=sttls.nl;
Received-SPF: Pass (protection.outlook.com: domain of sttls.nl designates
 13.93.42.39 as permitted sender) receiver=protection.outlook.com;
 client-ip=13.93.42.39; helo=westeu12-emailsignatures-cloud.codetwo.com; pr=C
Received: from westeu12-emailsignatures-cloud.codetwo.com (13.93.42.39) by
 DU6PEPF0000B61D.mail.protection.outlook.com (10.167.8.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 2 Jul 2026 12:17:06 +0000
Received: from DUZPR08CU001.outbound.protection.outlook.com (40.93.64.65) by westeu12-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Thu, 02 Jul 2026 12:17:05 +0000
Received: from GV2PR05MB11941.eurprd05.prod.outlook.com
 (2603:10a6:150:2cf::21) by AS2PR05MB10272.eurprd05.prod.outlook.com
 (2603:10a6:20b:600::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 2 Jul
 2026 12:17:02 +0000
Received: from GV2PR05MB11941.eurprd05.prod.outlook.com
 ([fe80::86e3:136c:737e:e29a]) by GV2PR05MB11941.eurprd05.prod.outlook.com
 ([fe80::86e3:136c:737e:e29a%6]) with mapi id 15.21.0181.008; Thu, 2 Jul 2026
 12:17:02 +0000
From: Maarten Brock <Maarten.Brock@sttls.nl>
To: David Laight <david.laight.linux@gmail.com>, Paul Mbewe
	<paultyson.mbewe@ziehl-abegg.de>, Crescent Hsieh <crescentcy.hsieh@moxa.com>
CC: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"jirislaby@kernel.org" <jirislaby@kernel.org>, "hvilleneuve@dimonoff.com"
	<hvilleneuve@dimonoff.com>, "tobias.gannert@ziehl-abegg.de"
	<tobias.gannert@ziehl-abegg.de>, "joachim.knorr@ziehl-abegg.de"
	<joachim.knorr@ziehl-abegg.de>
Subject: RE: [PATCH 2/2] serial: sc16is7xx: set TX FIFO trigger level to half
 FIFO to prevent underruns
Thread-Topic: [PATCH 2/2] serial: sc16is7xx: set TX FIFO trigger level to half
 FIFO to prevent underruns
Thread-Index: AQHdAwLMAOuYhCbC9UaQhkHW0WDA6rZMFloAgAAVUoCAABJ2gIAAIw8AgAAY2QCAAqq0YIAJxgMAgAAQ/QCAATFtAA==
Date: Thu, 2 Jul 2026 12:17:01 +0000
Message-ID: <GV2PR05MB11941819970EF65A5770A4AE783F52@GV2PR05MB11941.eurprd05.prod.outlook.com>
References: <GV2PR05MB1194183F888F21065CC596F3D83EC2@GV2PR05MB11941.eurprd05.prod.outlook.com>
	<418f9ae5-8827-475c-b465-1271a784fbf1.bc56e27e-ecd8-43ae-bb87-75bfd472a28d.88efbd1d-67dc-430a-adbe-b90700d161bb@emailsignatures365.codetwo.com>
	<20260701164056.951230-1-paultyson.mbewe@ziehl-abegg.de>
 <20260701184144.62bac61e@pumpkin>
In-Reply-To: <20260701184144.62bac61e@pumpkin>
Accept-Language: en-US, nl-NL
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sttls.nl;
x-ms-traffictypediagnostic:
	GV2PR05MB11941:EE_|AS2PR05MB10272:EE_|DU6PEPF0000B61D:EE_|DB9PR05MB9461:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c0fa400-d29a-45a8-a9d1-08ded833d50a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|7416014|1800799024|376014|23010399003|366016|6133799003|3023799007|18002099003|22082099003|38070700021|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info-Original:
 Ll/SsiBVL17UcJoJ4kYDAZ90HJDVCuhJ2+9I2hBx3PveKn7AUl2mmeAnEK5R8/yx4X8ivJJOjBPzfjSnW3gbhB/DKxklon0rsh9qy1k9r03V983/gSlOxM0NUtgD7QF2buCw70tDCwY7KHZTDR26KD/V9Qu5eFXBG6uWZwEBCEbWCtsAwncfITTglDPZdVSTM5tlg+RovUmKieuvGTlMHDTcDh/iZd89MIFQKptC7QZPqJ8X68NnBvHQdXsUaxv9Fudd60XRDuup1vntjcO3M7S0t5kEH7kaFgvr90cxGkccGTn0ztX8unOIHXNPMQtM6YjhbJo3+INBysVidwpXWvfrl6dUYwUh8QJjbDciqQV54Xq5kLTaYnazQv+XDJoH6LvEr6/LmgZYlsFschQ5Oy2+++LICLWm7ssNGbv4DYLFC4iaH7uN3T6ps0yzCCafsKpoGCVvUBILSUJNa4Vxv18s2HaHT8RHPoozW4PdYo61Rohbh+ftU1aOvf6Av3piD0gfm1fAw8liq/mzDywJ68tErwiT8WXlK1k9ooLUb4xSUlDkdZwiraZw4lNAOZuinan3xMzVNkBzIueDtRpI23NWM+mJifWl6rHOpTiBtXjbUqQjnxDgUfOw9anBXXXUQ1OJh92L/swy7/iVdBPTwHd3mA34KauDCsRCvIgF8/LnyhreO0s2XURCtza15+xcH6yVLFzYCKClqnK9pptfPuBky3/g41zOSuHSf5QXfx4=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR05MB11941.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(23010399003)(366016)(6133799003)(3023799007)(18002099003)(22082099003)(38070700021)(4143699003)(56012099006);DIR:OUT;SFP:1102;
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: gM3zGXCiS+C/IrgIskkEDlyhHUxweledlZRJ8oPVmVVi6bbudlIKcp0XdXFPFcVpYrwazCc79NxTQF3v5xNOyFz17PC5qL1y9D2Og+OrTxlw3XyqM5PDPmBEFZqhJcjI7OXFPzyBc6Zrg9COLq3PoOM4fm8yRusqzZnKxlgkOAf6i8t2PY26IdUZfgobAg8ys3QU68h4igqk21qN5Gpr/Aw3VmV9iwY7FJBgQe154rQ1Q/iIsA1v6w1cW104fN5u/R55gDKCWWHLo/V7l1f7pGl6zPmzQ5ZHnmRVZg52LzBf9c8mwcdhtyBYdmBkftItLTRByRnPfsH9YRicDZDZXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR05MB10272
X-CodeTwo-MessageID: bb0deb08-4f0c-40c9-ba56-e6c14f964378.20260702121705@westeu12-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU6PEPF0000B61D.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	3b06a89a-e18d-46e8-4fb0-08ded833d286
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|35042699022|23010399003|376014|82310400026|7416014|36860700016|14060799003|18002099003|22082099003|3023799007|4143699003|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	ly7lrLk5pDm++9k5iS3hp4bszm4ktblqOlrwkSVbKzfViWRIfwO+eG5ZlUNOEq5wkixzcS8s66rZbhTTYkIAwIBuunc81R3t8loynvy8TRZaiunRK2d1Wqu1MwQTmVJfN8VxbAiLir9Wq2xqI8K6Id+Mzz9kQqYThqVtDbNGxXL5bgPpvg6TikN3KLOJu+8CZfnQKZDbo3RBQpGG46BbHIL4h9iclX91T/YxcCQYWBmvuepaG0L03hcAauZFOcmf4mcpWs08QcRNv6rAH+HVR8q1O6/m5SNaa6TkFjqsuIKKTIDs3pCdJ9vQla+UvG9jeYu+NXaz6Gv7f4P21P9PxddESaLNjmqzLyOcy67oIV1yIf0iVv8svhWnmBkvDIIS+TCsYT/za6EQIcDct2SytnQ2uX3K+Bu8jFWFz/24893fJK6GNTdFCMDfMtsLNmH4NQ2yDa0qY3xBlsT9HPeQMNpj/HQi7ZsbR0addg8zPNrYCwg2v7prm4dZOOXwqtc7c2x1gDUdLMKn2odvHhX5kNHK14sEWRL2+DLfXR0Hxuw9QAjP5d7SY7QX0fy474Cjmhq+6SHBbPtjQRZO80sPfNHH0lLk51cVW+al/RBP/V0BrEHeW/KFNpu6LFWMUIXInlYtL9mTuWpYkYe3HxG2fJGE/joTpY7PVSbM49UDGIv+FWCIRTzc+ROx5amftAgmt4xCBK1BmsoWjSWYc1XxRw==
X-Forefront-Antispam-Report:
	CIP:13.93.42.39;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu12-emailsignatures-cloud.codetwo.com;PTR:westeu12-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230040)(1800799024)(35042699022)(23010399003)(376014)(82310400026)(7416014)(36860700016)(14060799003)(18002099003)(22082099003)(3023799007)(4143699003)(56012099006)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	oBD/66TyUyNdAC2+tBH1nOD6S+4wIMNUwKHxkosTKNWGvKqtFgNntt6qr71crPCOLnKLhhtdSUN58TyLLAKXJa+kti2C85qSNkN3dckeHrjzDq8v3/VV1wdGJrWOcmbvBJpxrbfpNLdX1ULQEHbQSRUeoe72hxIR9Ly66W+yLU2jvLQtkCYTcwUypl2vgJvVRZ6GmU8mGefgYEzBUG17ws6Oz3T4sAO/72np06u3B4vkU4Ujp3kfiRh5Ww5A8maocaueCEdnDvC3hCqGrj/IRiRQrOo6kopHmIylPXwp7lfRLEw3cVXu4yNu85wjnO+DFG/jCRzd1Pf1TMkNIgGBqTtVvZf0SO3JahBKCUST+nPhRDkcDMC1goc7P0/ueYZUp8b6E3GYywrJSqVZBy+PhQwepeXBCkRZAncQkpQ5ZS0QaWYxHHcE8RYEBf96nJiW
X-OriginatorOrg: sttls.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 12:17:06.0418
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c0fa400-d29a-45a8-a9d1-08ded833d50a
X-MS-Exchange-CrossTenant-Id: 86583a9a-af49-4f90-b51f-a573c9641d6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=86583a9a-af49-4f90-b51f-a573c9641d6a;Ip=[13.93.42.39];Helo=[westeu12-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000B61D.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR05MB9461

PiBGcm9tOiBEYXZpZCBMYWlnaHQgPGRhdmlkLmxhaWdodC5saW51eEBnbWFpbC5jb20+DQo+IFNl
bnQ6IFdlZG5lc2RheSAxIEp1bHkgMjAyNiAxOTo0Mg0KPiANCj4gT24gV2VkLCAxIEp1bCAyMDI2
IDE4OjQwOjU2ICswMjAwDQo+IFBhdWwgTWJld2UgPHBhdWx0eXNvbi5tYmV3ZUB6aWVobC1hYmVn
Zy5kZT4gd3JvdGU6DQo+IA0KPiA+IEhpIERhdmlkLCBNYWFydGVuLA0KPiA+DQo+ID4gSSByZWNo
ZWNrZWQgdGhpcyB3aXRoIGZ0cmFjZSwgYW5kIEkgdGhpbmsgdGhlIHJpZ2h0IGV4cGxhbmF0aW9u
IGlzDQo+ID4gbmFycm93ZXIgdGhhbiBteSB2MSBjb21taXQgbWVzc2FnZS4NCj4gPg0KPiA+IFRo
ZSB1bmRlcnJ1biB0cmFjZSBzaG93cyB0aGUgU0MxNklTN3h4IHJlZmlsbCBwYXRoIHJ1bm5pbmcg
d2l0aCB0aGUNCj4gPiBoYXJkd2FyZSBUWCBGSUZPIGFscmVhZHkgZW1wdHkgd2hpbGUgdGhlIHR0
eSB4bWl0IEZJRk8gc3RpbGwgaGFkIGRhdGENCj4gPiBxdWV1ZWQsIGZvciBleGFtcGxlOg0KPiA+
DQo+ID4gwqAgc2MxNmlzN3h4IGRlbGF5ZWQgcmVmaWxsOiBsaW5lPTAgdHhsdmw9NjQgcGVuZGlu
Zz0xNzINCj4gPg0KPiA+IFNvIHRoZSBjb25jbHVzaW9ucyBmb3IgbWUgYXJlOg0KPiA+DQo+ID4g
wqAgLSBUaGUgZHJpdmVyIGNhbiBjYXRjaCB1cCBpZiB0aGUgRklGTyBpcyBvbmx5IHBhcnRpYWxs
eSBkcmFpbmVkIHdoZW4NCj4gPiDCoMKgwqAgdGhlIFRIUkkgcGF0aCBydW5zLiBUWExWTCB3aWxs
IHJlcG9ydCBtb3JlIHRoYW4gdGhlIG5vbWluYWwgdHJpZ2dlcg0KPiA+IMKgwqDCoCBhbW91bnQg
YW5kIHRoZSBkcml2ZXIgY2FuIHdyaXRlIG1vcmUgYnl0ZXMuDQo+ID4NCj4gPiDCoCAtIE9uY2Ug
VFhMVkwgaXMgNjQsIHRoZSBGSUZPIGhhcyBhbHJlYWR5IGVtcHRpZWQgYW5kIHRoZSBUWCBnYXAg
aGFzDQo+ID4gwqDCoMKgIGFscmVhZHkgb2NjdXJyZWQuDQo+IA0KPiBSaWdodCwgYnV0IHRoZXJl
IG11c3QgYmUgc29tZXRoaW5nIGhhcHBlbmluZyBhZnRlciB0aGUgcHJldmlvdXMgdGltZSB0aGUN
Cj4gZmlmbyB3YXMgZmlsbGVkIHRoYXQgbWFrZXMgdGhpcyBvbmUgaGFwcGVuIHRvbyBsYXRlLg0K
PiBFaXRoZXIgdGhlIGhhcmR3YXJlIElTUiB3YXMgdmVyeSBsYXRlIG9yIGl0IGRpZG4ndCBzY2hl
ZHVsZSB0aGUgdGhyZWFkLg0KPiANCj4gVGhpbmtzLi4uLi4NCj4gTWF5YmUgeW91IGFyZSBnZXR0
aW5nIGEgZmlmbyBlbXB0eSBpbnRlcnJ1cHQgKHJhdGhlciB0aGFuIHRoZSBmaWZvIHRocmVzaG9s
ZCkNCj4gaW50ZXJydXB0LCB3aXRoIHRoZSB0aHJlc2hvbGQgb25lIGdldHRpbmcgbG9zdC4NCj4g
U28gd2hhdCBoYXBwZW5zIGlmIHRoZSB0aHJlc2hvbGQgaXMgcmVhY2hlZCB3aGlsZSB0aGUgdGhy
ZWFkZWQgSVNSIGlzIHN0aWxsDQo+IHJ1bm5pbmc/DQo+IFdoZW4gdGhhdCBoYXBwZW5zIHRoZSBJ
U1IgbmVlZHMgdG8gbG9vcCwgZWl0aGVyIGluIHNvZnR3YXJlIG9yIGJ5IHJlLWVuYWJsaW5nDQo+
IGEgbGV2ZWwtc2Vuc2l0aXZlIGludGVycnVwdCBzbyB0aGF0IGFub3RoZXIgaGFyZHdhcmUgaW50
ZXJydXB0IGhhcHBlbnMNCj4gaW1tZWRpYXRlbHkuDQoNClRoZSBsb29wIGlzIGFscmVhZHkgcHJl
c2VudCBpbiBzYzE2aXM3eHhfaXJxKCkgd2l0aCANCmRvIHsgLi4uIH0gd2hpbGUgKGtlZXBfcG9s
bGluZyk7DQoNCj4gSSdtIG5vdCBhdCBhbGwgc3VyZSBob3cgdGhhdCB3b3JrcyB3aXRoIHRocmVh
ZGVkIElTUiBvbiB0aGUgU1BJIGludGVyZmFjZS4NCj4gRXNwZWNpYWxseSBzaW5jZSB5b3UgcmVh
bGx5IGRvbid0IHdhbnQgdG8gcmVhZCBhbnkgbW9yZSBTUEkgcmVnaXN0ZXJzDQo+IHRoYW4gYWJz
b2x1dGVseSBuZWNlc3NhcnkgKHlvdSBuZWVkIHRvIGF2b2lkIFBDSWUgcmVhZHMgYXMgd2VsbCEp
Lg0KPiANCj4gRm9yIGEgJ25vcm1hbCcgZXRoZXJuZXQgZHJpdmVyIHJ4IHBhdGggaXQgaXMgaW1w
b3J0YW50IHRvIGNoZWNrIHRoZSBuZXh0DQo+IHJ4IHJpbmcgZW50cnkgYSBzZWNvbmQgdGltZSBh
ZnRlciBlbmFibGluZyB0aGUgaGFyZHdhcmUgaW50ZXJydXB0Lg0KPiBPdGhlcndpc2UgeW91IG1p
c3MgYSB3YWtldXAuDQo+IEkgdGhpbmsgeW91IGFyZSBnZXR0aW5nIChlZmZlY3RpdmVseSkgdGhl
IHNhbWUgcHJvYmxlbS4NCj4gDQo+IFlvdSBtaWdodCBuZWVkIHRvIHVzZSAoc2F5KSBrdGltZV9n
ZXRfbnMoKSB0byB3b3JrIG91dCBob3cgbWFueSBieXRlcw0KPiB3ZXJlIHRyYW5zbWl0dGVkIGJl
dHdlZW4gdGhlIGZpZm8gc3BhY2UgYmVpbmcgcmVhZCBhbmQgdGhlIGVuZCBvZiB0aGUNCj4gZmlm
byB3cml0ZXMgdG8gc2VlIGlmIHlvdSBuZWVkIHRvIGRvIGEgc2Vjb25kIHJlZmlsbC4NCj4gKE9y
LCByYXRoZXIsIHRvIGRldGVjdCB0aGF0IHlvdSBkZWZpbml0ZWx5IGRvbid0IG5lZWQgdG8gZG8g
b25lLikNCj4gDQo+IFdpdGggdGhlIHRocmVzaG9sZCBzZXQgdG8gMzIgaXQgaXMgbXVjaCBsZXNz
IGxpa2VseSB0aGF0IGl0IHdpbGwgYmUgaGl0DQo+IGR1cmluZyB0aGUgZmlmbyB3cml0ZXMsIHNv
IHlvdSBhcmUgbXVjaCBsZXNzIGxpa2VseSB0byBsb3NlIGFuIGludGVycnVwdC4NCj4gQnV0IHNj
aGVkdWxpbmcgZGVsYXlzIGNvdWxkIHN0aWxsIG1ha2UgaXQgaGFwcGVuLg0KPiANCj4gCURhdmlk
DQo+IA0KPiA+DQo+ID4gwqAgLSBUaGUgdjEgZXhwbGFuYXRpb24gd2FzIHdyb25nIHRvIGRlc2Ny
aWJlIGEgMzItZnJlZS1zcGFjZSB0cmlnZ2VyIGFzDQo+ID4gwqDCoMKgIGluY3JlYXNpbmcgdGhl
IHBlci1pbnRlcnJ1cHQgcmVmaWxsIHdpbmRvdy4gSXQgZG9lcyBub3QuIFdpdGggdGhlDQo+ID4g
wqDCoMKgIGRlZmF1bHQgdHJpZ2dlciwgdGhlIEZJRk8gaGFzIGFib3V0IDU2IGNoYXJhY3RlciB0
aW1lcyBsZWZ0IHdoZW4gVEhSSQ0KPiA+IMKgwqDCoCBmaXJlczsgd2l0aCBhIDMyLWZyZWUtc3Bh
Y2UgdHJpZ2dlciwgaXQgaGFzIGFib3V0IDMyIGNoYXJhY3RlciB0aW1lcw0KPiA+IMKgwqDCoCBs
ZWZ0Lg0KPiA+DQo+ID4gwqAgLSBBcyBNYWFydGVuIHBvaW50ZWQgb3V0LCB0aGUgYmVuZWZpdCBp
cyB0aGUgb3RoZXIgc2lkZSBvZiB0aGUNCj4gPiDCoMKgwqAgdHJhZGUtb2ZmOiB0aGUgcmVmaWxs
IGV2ZW50IHJhdGUgaXMgcmVkdWNlZCBieSA0eCwgZnJvbSByb3VnaGx5DQo+ID4gwqDCoMKgIDEg
cmVmaWxsIHBlciA4IHRyYW5zbWl0dGVkIGJ5dGVzIHRvIDEgcmVmaWxsIHBlciAzMiB0cmFuc21p
dHRlZCBieXRlcy4NCj4gPg0KPiA+IMKgIC0gT24gdGhlIHRlc3RlZCBTUEktYmFja2VkIHN5c3Rl
bSwgdGhhdCBsb3dlciByZWZpbGwgcmF0ZSByZWR1Y2VzIHRoZQ0KPiA+IMKgwqDCoCBJUlEvU1BJ
IGxvYWQgZW5vdWdoIHRvIGF2b2lkIHRoZSBvYnNlcnZlZCB1bmRlcnJ1bnMuDQo+ID4NCj4gPiBU
aGUgY2hhbmdlIGlzIGxpbWl0ZWQgdG8gU1BJLWF0dGFjaGVkIHBhcnRzIHNvIHRoZSBJMkMgY2Fz
ZSBpcw0KPiA+IHVuYWZmZWN0ZWQuDQo+ID4NCj4gPiBGb3IgdjIgSSB3aWxsOg0KPiA+DQo+ID4g
wqAgLSByZXdvcmsgdGhlIGNvbW1pdCBtZXNzYWdlIGFyb3VuZCBNYWFydGVuJ3MgdHJhZGUtb2Zm
IGNhbGN1bGF0aW9uOg0KPiA+IMKgwqDCoCA0eCBmZXdlciBUWCByZWZpbGwgZXZlbnRzLCBhdCB0
aGUgY29zdCBvZiByZWR1Y2luZyB0aGUgdGltZS10by1lbXB0eQ0KPiA+IMKgwqDCoCBtYXJnaW4g
ZnJvbSA1NiB0byAzMiBjaGFyYWN0ZXIgdGltZXM7DQo+ID4gwqAgLSBsaW1pdCB0aGUgVFggdHJp
Z2dlciBjaGFuZ2UgdG8gU1BJLWJhY2tlZCBTQzE2SVM3eHggZGV2aWNlczsNCj4gPiDCoCAtIGxl
YXZlIHRoZSBSWCB0cmlnZ2VyIGxldmVsIHVuY2hhbmdlZC4NCg0KSSBzZWUgbm8gcmVhc29uIHRv
IGxpbWl0IHRoaXMgdG8gU1BJIG9yIHRvIHRoZSB0cmFuc21pdCBjYXNlIG9ubHkuDQoNCj4gPiBJ
ZiBtYWludGFpbmVycyB3b3VsZCBwcmVmZXIgdGhpcyB0byBiZSBib2FyZC1jb25maWd1cmFibGUg
aW5zdGVhZCwgSSBjYW4NCj4gPiBsb29rIGF0IGEgZm9sbG93LXVwIERUIGJpbmRpbmcvcHJvcGVy
dHksIGJ1dCBJIHdvdWxkIHByZWZlciB0byBrZWVwIHYyDQo+ID4gZm9jdXNlZCBvbiB0aGUgVFgv
U1BJIGNhc2UuDQo+ID4NCj4gPiBUaGFua3MsDQo+ID4gUGF1bA0KDQpGdXJ0aGVyLCBJIHRoaW5r
IHRoaXMgc2hvdWxkIGJlIGNvbWJpbmVkIHdpdGggdGhpcyByZWNlbnQgcGF0Y2ggcHJvcG9zYWwg
ZnJvbSBDcmVzY2VudCBIc2llaDoNCltQQVRDSCB2MiAxNC8xNV0gc2VyaWFsOiA4MjUwOiBhbGxv
dyBVQVJUIGRyaXZlcnMgdG8gb3ZlcnJpZGUgcnhfdHJpZ19ieXRlcyBoYW5kbGluZw0KDQp3aGlj
aCBpbnRyb2R1Y2VzIGEgd2F5IHRvIHNldC9nZXQgdGhlIHJ4dHJpZyBjb3VudCBwZXIgcG9ydC4g
QSBzaW1pbGFyIHRoaW5nIGNhbiBiZSBhZGRlZCBmb3IgdHh0cmlnLg0KDQpLaW5kIHJlZ2FyZHMs
DQpNYWFydGVuIEJyb2NrDQoNCg==
