Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010050.outbound.protection.outlook.com [52.101.69.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F6F32063D8
	for <linux-serial@vger.kernel.org>; Wed,  5 Feb 2025 10:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738751088; cv=fail; b=rumkUyZx/nJ/zFzoIQ0VAAm3OkFJptyYowySI7YhTsOLkfz41QFRYypl2Gv8BVN/aTp/2rUYey0FP4xZwJLr324TFuHOg7KpK1GgVlVvO8WIPGF1AFvfuNIGKrJSObjBx9Aj2eBw3Zyn6NS7A61xMbZgHOPC/MWZAcgMJoDdD0E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738751088; c=relaxed/simple;
	bh=ydv253HfBFzKBdJNbBovDSBMN8E0Jm6aPBfGHgKNgDg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AKm17eYVql300Bji7yFH4HYutOTHH8UDxXt9KzL3EhxCIwEWSXu+MicHGIviWeP6Fu0qDhGmFJOExcNbRBVNhMbyZPBwBCsVzPq7eerpFWWwR/xrE9tqlMPcz7sjX+OUx1UGFsRci8ImVVuLz/o68gn9SChiqjHIMGBkIfnkntM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=XS/kxVVz; arc=fail smtp.client-ip=52.101.69.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="XS/kxVVz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TCgQ0EvWcQvhra3H0QVxu/vSv1xYzJZdXhCSaxYaetW/l42VucMfsqTR5YQbV2N0y9ss7cg9vDzyHPQePBTlPeguAwdW2q8zPme89iH7rhSkaDOqB5gxKVKvo6rCmBgBEgskkz4lZVIq5GKufCVptHm2OVrozwHpiXvdyMmUaICQNf6FT3pqTgWE0F3FxRk+KkgEMDRiqfaxxzKazxvr8zmISeYpwAxF8G4gvoxA1umQ++iosMT3Qd2zMQ5FE87hUwApgfFMV5mkE5l3M/kUZGVCh7j+kKt3krYoYwi11jJHWGw1EPI1AlhsN67C7Fds8PtxCe4Cj4L6WJ3UFRoIcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ydv253HfBFzKBdJNbBovDSBMN8E0Jm6aPBfGHgKNgDg=;
 b=HQ/lXdOjll65KAR6BoytEGBD4cvwx0c3KKJVN94FWE4QAkMjlB8X6VyUkwB3635rjoy+2CPC90ZCYPr30VDv33uMnRtvggRcK9eXznTmSOlamEK+NH1Mv0T0opyI6Xn5r60IZVcGeerVADaxCceAzKAvvxcJNGIH3+7puyxjUClvY8Z9T3aaNrrsyd9ddQ+Zi6uyykCQYD3DiGrrWYL5CGsm6UD/WvUXXUBN5ml17RTiwYtou1MilMCDi3DY/FXAyZGvwmYIQKyybv4KBCsKToJG7tmRrTbtZk5Rr4sJJbOEm7KmPi8l3QfJwbyrSQ80l9tLSFZ4mf34Y43yHh2xEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ydv253HfBFzKBdJNbBovDSBMN8E0Jm6aPBfGHgKNgDg=;
 b=XS/kxVVztwW2ZsRQ0uUZ7bxdtSpe5/qIyqrJ7LKep0IMZ2nMoVwLrFZict1g0Dga+/ISCaG7vjcKeFr0xzQL0MMtNPgQ/oiXDLU0LJuSnWuDEAqjwZHYFScc5OcYfPJEC5i9BNHkr2B34/OgyWXpxfugqahVWB0lNED8wUNPvVqJ5i9Pgj3r9hkGI7C6hE65Kcl2Kf7zkpFB2Gh4SSlnbq9miN1XgppGI75af87zmH4jvZYLXO8M9RNcoUkG83dDWclfur0dIyYyF+SK6NS2VHNP0mr94/suLRYxf6Z3WeTjIoj/ScFkb3YBoM+3ObuMoJ0oxR42hxxXOypHs7oq6A==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAWPR04MB9720.eurprd04.prod.outlook.com (2603:10a6:102:38d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.20; Wed, 5 Feb
 2025 10:24:42 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%3]) with mapi id 15.20.8398.025; Wed, 5 Feb 2025
 10:24:42 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Stefan Wahren <wahrenst@gmx.net>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, Sherry Sun
	<sherry.sun@nxp.com>
CC: Luke Wang <ziniu.wang_1@nxp.com>, "linux-serial@vger.kernel.org"
	<linux-serial@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH] tty: serial: fsl_lpuart: Make interrupt name distinct
Thread-Topic: [PATCH] tty: serial: fsl_lpuart: Make interrupt name distinct
Thread-Index: AQHbd63Hgkl+K/Q8dUKjYBxmzYysTbM4gM1g
Date: Wed, 5 Feb 2025 10:24:42 +0000
Message-ID:
 <PAXPR04MB8459391B8BBA618090EF82BC88F72@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20250205091007.4528-1-wahrenst@gmx.net>
In-Reply-To: <20250205091007.4528-1-wahrenst@gmx.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|PAWPR04MB9720:EE_
x-ms-office365-filtering-correlation-id: 958738e2-a047-4c79-ed61-08dd45cf4e11
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?cjV0zL8Rma+X4nED3gKA1X1JxSgR1ISUdOxT+kbq+c8whJjCIpA9ZEja6Ek4?=
 =?us-ascii?Q?4UjRus2SpgdQRmxWBTq1ax8N0400mW9ATJLLUZMi398NJx1dnqUEJXm/KOe6?=
 =?us-ascii?Q?SgBymAIWduzAn52kxNNSbL4Uz4lQ2egUUDpzSXUKTTS5VMY14o7fecoou9c7?=
 =?us-ascii?Q?K8/ZzOnC0C7JR+Y3bUE1JD6CH7mUxRoYd01shR0UXJe63n0KKKXKUZeiXjOB?=
 =?us-ascii?Q?IsI+lWZf+R7PHj5ULG+khrstw1U/fcFCKkmZfJnDWGSZx/TaWNdFVSMDZW1/?=
 =?us-ascii?Q?Hcibh6hEkqyMAx921iZxiDBPk9zWIndpmlzvsRsQCCsykYk8M1Wv0WVwf3gM?=
 =?us-ascii?Q?8LTPRnwCPq3tpa9YCESCDPBRIFP1Wmxh4ul6rjXwQ9QTrdSKOg8gj0Jn4AGZ?=
 =?us-ascii?Q?OWYrtsnvzg1n/I1na+6yNu/TtTmxAuQx6r+kW+MNYEgtT30o5SkxTrsRH1Gr?=
 =?us-ascii?Q?aFxTdR7bn1AqYb9MnJwMwa9OSvLbuh2+u6a5pEx1ZyWIgE5flkxnCA5X+ukz?=
 =?us-ascii?Q?m0EIOFEUqgDfNnaER0sIi0Xc6DGsTakuCsO8D+09K/STZDHxt/0JBrkuFiCs?=
 =?us-ascii?Q?MMUO+H21z78eqaDXMB26u0/VpRFyHn/Nz6eBN+v0qzyXT/ADaMx5Z8ldFtqN?=
 =?us-ascii?Q?hBH2YZzFgJC8IkozmFlAj52E41Wah3wYBGssaZ7PuwIruSIhU7+N31xuzAup?=
 =?us-ascii?Q?T90u5MQBw1yNGWUY6Gh30ReBSdYU4j2VX2zfWKQwE0YjSU4OEur6mkWb4NXH?=
 =?us-ascii?Q?I5BRTiXVbHc8kL14iBZ+A1YADO8dkwBiC5FHftiKNJd6q5BVK4EKF8ANl2L5?=
 =?us-ascii?Q?ovjonJWOwV+SNSN4Ktc9j90kZATgVHiWGInnAOa1VNElGgIYMNTdUzxcCz1Z?=
 =?us-ascii?Q?wui5YV+4Ol1AQil2k5/JN+uoieXP9ExvkNmB9meRXwLJ0KMihh5r0FCcIibQ?=
 =?us-ascii?Q?QwrLYNjVceiWYPP+g4zF9RWoIamPUW8Rs8iSqipsZoZm+m2q9HR3E7kMqaQ4?=
 =?us-ascii?Q?2nCfuRICoSP7bd7QH7Fs0nz5tQffp30pScZW+3gzO0Z+R5nrnsI61q30lSe+?=
 =?us-ascii?Q?WoCvib0/RpFfOzoozr+avkBRASaXK7lRoFexJeJ4zbIP4D/ot7A6NarED3Y0?=
 =?us-ascii?Q?qiAFBZRMo6p/nWV3Mf+IEbwzokchlTgqwdBHJg2meq2aV8n27voda0YIofhS?=
 =?us-ascii?Q?/AYr7vo8BUc+InS2s48RueElbQQwCf3onF5bFTjkJKEjcYgJSqXxukpZcPr2?=
 =?us-ascii?Q?6uBEuSMqOn0dt3uHIeIJ4RG17XvLXY+OnCDdpS8UzSl6fsXpBR4TPC9GDlDd?=
 =?us-ascii?Q?LEjqvLi/2pPjtPPXwGUGmOXCY0JCo99eUK5IKJcSxcKLis6QtO5IQE74hfb+?=
 =?us-ascii?Q?KkWBYfhYUmRj5x0xvp67ZqPgx76w7vBdTfHc7hz+//bRCrbse5eBpNJ9JXKs?=
 =?us-ascii?Q?nkvf39aOGkuzznDGFvT+oK6gC2FiXMn7?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?mshEO/1Uugt6eGtIJySOSXmUlhcRSyN7Ij691+rDL40ofdxqWkvBoEwGBxwO?=
 =?us-ascii?Q?2eCmQFl7ZX6qKJdy4jfJEy3ccWKJ/BQodGLjVy+NWJ87nxbty934VNiAcP0d?=
 =?us-ascii?Q?DxXEVLgLJgKNs1rEaydac2Dq0dGDQ2iyLwl7k4YPXBNk2PdEQMxXNUv0hID3?=
 =?us-ascii?Q?yd7ITyqgLGMBHiVJBCelLG7oGoBPUdRHjnmW9Pd/qKMpndPc+Njr/I+1wgVo?=
 =?us-ascii?Q?jqxRIHvyrUAx08W0R1fmSdVkSqI0hKfNR4TAF8hqBhOfIztHctsfeSU0jOFg?=
 =?us-ascii?Q?iIZkhoDSHoQ9dL0Ken5W4ZZj5IJZao/xQQt5445XXyqcidfZUmr6AhhPtSFY?=
 =?us-ascii?Q?SqoGCYZqub4IzOndnDoqVxWLpqZgfz0Pa9BOvRQe1a7/iY3cxwvDL6G2BQNI?=
 =?us-ascii?Q?pzonCeyUDhW7pCnZwdPFe+KbA0L0770OfioasDgDP+jwFbEIBYMLZmwKr/Kj?=
 =?us-ascii?Q?Q0Ym7QDDiWJdat7q0dRTrvkGRyWCI6oP5DZzFuewFvrvFeW7p/jG9PkBQMz4?=
 =?us-ascii?Q?o4j5MOlpX6B0Pgv90U76FL5XCL9x9bQu7AqNadn1KT02Ubc0dV4dfISKc645?=
 =?us-ascii?Q?j6DNPeu3Fxs40qc2xKW3iGHZsWbZIqBne8RPKMu037+kGmiimeWxamsDZgfz?=
 =?us-ascii?Q?tnLqq5KUUjA32ZQmSwPQu463kZf7RLE+EbIqDHaBzgp8MEBtbybR1IoOiCWb?=
 =?us-ascii?Q?h72cPQGTRjmXSxC+wt4EpTG8fGoqQSgbzsEdYg5TfuZx0WbssI/FTo+x+ar1?=
 =?us-ascii?Q?3paOB0TY8XBNYpQJqCOY/KpYlZJIiXgx02cFB3luNP+zEeYh9W2iY5vnn/Mp?=
 =?us-ascii?Q?ADzHwfH1zgQdClf/3m6f3FDItTm9Om2cY1hP/7kzGEH1/SLkWdCIb0SnhVw0?=
 =?us-ascii?Q?jvFfOPfnUSi6YP3FxtWggzKLoSRqSM10J6WiL+ebptEwj3UJ1v5fprkWS9JJ?=
 =?us-ascii?Q?f5joIjlaTRKVObVSQBY7cNPxPSI4E1tC+NoS2bgLLhvJfaVGVWMhCS6hkDCp?=
 =?us-ascii?Q?QV3RbNi2JrO+RFr1JDFUHuJThBZH97QVD2bJbOAwYpQmZ51AiJXR/PJpiqZO?=
 =?us-ascii?Q?GcM9wQ48syn76NxYQU9QjF7q0uAW7PkZtuhZJ/VQbiE0AsHCoEBTQnfb8keB?=
 =?us-ascii?Q?zus+v49u6HHi/feInN/Ozcz9im3Bf1meZC4xowwazOdrjxpMb+vttsSCW6Gc?=
 =?us-ascii?Q?EYx+0H1J/Ou7iVHISvTQDZcY0QfuE77+kR0QkwfbCR+6yJQWzCSWtzp9BkF3?=
 =?us-ascii?Q?570DV0R+EQpKtJ6m6Gk3pZssn1o6OgUzchNCNIWsCh3xbxAxW+FYnqiWEmC5?=
 =?us-ascii?Q?RXd00VoRSUJ0z1/SDbNZYoUAuv0qqtHNUOK19F3kP743yvxzcz1xKXx5iHe7?=
 =?us-ascii?Q?DIQnfUd5SdYo5Qj2d3c8BOhbhcoAuMqXgFQBCThdedQf4R2eElXJUEleRzYB?=
 =?us-ascii?Q?KOwISy388S5U8uprHWNMaFmyvXVcXXdqTHJFBHKlmeatuzf6rCWnH9Rs8Puy?=
 =?us-ascii?Q?s+QmQW5WFdv0HC+pJo4ucw1RGu0CwWtsLuBqLC7XbhSjKp9v1bCGT+AXKeaV?=
 =?us-ascii?Q?jc+ZbcmmIqG+QYqTzjA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 958738e2-a047-4c79-ed61-08dd45cf4e11
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2025 10:24:42.6463
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M3Sd/vlwJ/l/8xSLg1EYULU7QyO0IUQUGAPpOEReqzGAmSpAqeZX3K6DmV1ajm8SSlV4qTyVw7noFhSslZcyqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9720

> Subject: [PATCH] tty: serial: fsl_lpuart: Make interrupt name distinct
>=20
> SoCs like the i.MX93 have several lpuart interfaces, but fsl_lpuart uses
> the driver name to request the IRQ. This makes it hard to identify
> interfaces from outputs like /proc/interrupts .
> So use the dev_name() for requesting instead.
>=20
> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
