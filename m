Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2117.outbound.protection.outlook.com [40.107.21.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8142913;
	Sat, 18 Jan 2025 12:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737202465; cv=fail; b=XUMwsCN85vNIbZ5Yx+vaMHa8FuQe4NAGwlpK66rMyxXEuemFjELSTfx7js1JzyxVzrqYu0kWxbWKLBU3rHuh2lsGL49TJ6IiznUNclnYvGeuMkuB5xwCbUWTLm7OFeoDFEIf9C0M6q3VGnlGv04WKkDp8D+xmW6mJfSpOjqdjuc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737202465; c=relaxed/simple;
	bh=AcOW7rMer7sB5b+SAQ+xDGgVHmMO9IFvlkGWUNqrVuw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OZEXyPQq8XIelBCEK/b+K+8RF6n1J/MxBl0ue50ujPJ9rMVIb3os2VFaVIdKfr6N/tGYDtyu8nawnlRivNn0laDNdVwUZNF8uBD4J3hjqhpSAjrilIynGOvC+GP0HR4CF6qYr1vxbdiBtdwsjPdNjazmu/oKhcSfKNwP1sO/tq0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sttls.nl; spf=pass smtp.mailfrom=sttls.nl; dkim=pass (2048-bit key) header.d=sttls.nl header.i=@sttls.nl header.b=nqh7qEFt; arc=fail smtp.client-ip=40.107.21.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sttls.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sttls.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sttls.nl header.i=@sttls.nl header.b="nqh7qEFt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ne5G+5HQ5BTyt5c6bwButQoCemtaLsVuU8rJlR7cioaMkmjW9rHulb0/C51yPcjAokeiCxPEB0pgnBinr1SItTiA15ha5e90wunirdjsY2P1fuRSpKSWkmQNNdqb/JFy4hBFsAuESQAOy8s8k1vfo7AcqT+AabzmgJHYRSfC1UM7Dd1pvR5+wDA5Qxt9QAeWm4Sa6zXmEeDfR6Wz6q2Uw1h64MFzEU8KXZysfAhIj1vE0eVQ0P0eL9rcZO1L47QkDGwsJSqt8VR+Nd6JeiUue4YS6EjQ8KHE+4zvwKxKHvS0Jqje0yEyB1f9DNS20aI6bpZY4Z1Fy91RJjW55nWT9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AcOW7rMer7sB5b+SAQ+xDGgVHmMO9IFvlkGWUNqrVuw=;
 b=OoFJ6PZbTgcEcMq/0gYQhCbB+81yx9t3b0AHZNvSvqW3tIif6bPPpaeUO/EFuyRWG33Nzj3eZVd0P8nq/9qbKmdVcE3max90BZ6X6zpYIQZUa5CAIzqyojg/MSwXkGWXb29Psy4OHqqfq1xzgq2Hci42XeNVO6B/byREcC84HQJ2ns28IDTEwGRoOdIPT8zmuN3rK5yfrRPkwEDIw2AEH6XHUNvUVLib4qj3hAh4V0ihag1YgCHzg1nbc6gCW3gHEgf82S1beXpHMGQNjthnyHIuajp8Egrpi2QMa/P7jTZNEd95fUqi5WbIuw4h3f5Fx82jXijul8pMp2XDllyJLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 20.93.157.195) smtp.rcpttodomain=systec-electronic.com
 smtp.mailfrom=sttls.nl; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=sttls.nl; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sttls.nl; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AcOW7rMer7sB5b+SAQ+xDGgVHmMO9IFvlkGWUNqrVuw=;
 b=nqh7qEFtGcDz9lhM3l3L4XnxMdTCf2CMWS9eZmopStdkM+o7gOps+SNBkqaNRsSSEHUMCkZ1zqGPfiWHq8tpjZgSQMkLCGceizQEm4yCYnl+9Y9OAq7lUF7G3AgdihnntqNiq80X7VerAuemcu9jFyzsJWfJt3H5r86vmYWBQS9xUEI+ktPywemG3uDzjDfBXl9+gJ07twJDBEuS3/92YXbh1M0X2yDE8bVHh8g79glDqflR2w6TtvTC9PrS4AUtlSmVkLyA/qfQZ+gscMq6zWEbyx1dU0RKSizYS2bg3EVtSusu23Vn8thPLAPzf4DQLvfQhko36sJIDBeeBe14DQ==
Received: from PR1P264CA0187.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:34d::16)
 by AS8PR05MB10049.eurprd05.prod.outlook.com (2603:10a6:20b:5b4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.18; Sat, 18 Jan
 2025 12:14:17 +0000
Received: from AM4PEPF00027A6A.eurprd04.prod.outlook.com
 (2603:10a6:102:34d:cafe::3a) by PR1P264CA0187.outlook.office365.com
 (2603:10a6:102:34d::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.18 via Frontend Transport; Sat,
 18 Jan 2025 12:14:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.93.157.195)
 smtp.mailfrom=sttls.nl; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=sttls.nl;
Received-SPF: Pass (protection.outlook.com: domain of sttls.nl designates
 20.93.157.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.93.157.195; helo=westeu11-emailsignatures-cloud.codetwo.com;
 pr=C
Received: from westeu11-emailsignatures-cloud.codetwo.com (20.93.157.195) by
 AM4PEPF00027A6A.mail.protection.outlook.com (10.167.16.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8377.8 via Frontend Transport; Sat, 18 Jan 2025 12:14:16 +0000
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (104.47.11.41) by westeu11-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Sat, 18 Jan 2025 12:14:15 +0000
Received: from AS8PR05MB9810.eurprd05.prod.outlook.com (2603:10a6:20b:5c2::16)
 by PR3PR05MB7083.eurprd05.prod.outlook.com (2603:10a6:102:6d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.18; Sat, 18 Jan
 2025 12:14:14 +0000
Received: from AS8PR05MB9810.eurprd05.prod.outlook.com
 ([fe80::841e:3b57:8c60:5734]) by AS8PR05MB9810.eurprd05.prod.outlook.com
 ([fe80::841e:3b57:8c60:5734%6]) with mapi id 15.20.8356.010; Sat, 18 Jan 2025
 12:14:13 +0000
From: Maarten Brock <Maarten.Brock@sttls.nl>
To: Andre Werner <andre.werner@systec-electronic.com>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"jirislaby@kernel.org" <jirislaby@kernel.org>, "hvilleneuve@dimonoff.com"
	<hvilleneuve@dimonoff.com>, "andy@kernel.org" <andy@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
	"lech.perczak@camlingroup.com" <lech.perczak@camlingroup.com>
Subject: RE: [PATCH v2] serial: sc16is7xx: Extend IRQ check for negative
 values
Thread-Topic: [PATCH v2] serial: sc16is7xx: Extend IRQ check for negative
 values
Thread-Index: AQHbaQPgbMkHJBIM7EC9mY5JJhHLIrMccKig
Date: Sat, 18 Jan 2025 12:14:13 +0000
Message-ID: <AS8PR05MB9810FA4CE091AD28EEE9B73683E52@AS8PR05MB9810.eurprd05.prod.outlook.com>
References: <20250117171822.775876-1-andre.werner@systec-electronic.com>
In-Reply-To: <20250117171822.775876-1-andre.werner@systec-electronic.com>
Accept-Language: en-US, nl-NL
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sttls.nl;
x-ms-traffictypediagnostic:
	AS8PR05MB9810:EE_|PR3PR05MB7083:EE_|AM4PEPF00027A6A:EE_|AS8PR05MB10049:EE_
X-MS-Office365-Filtering-Correlation-Id: 82644ae3-27c3-42e5-c4c4-08dd37b9a0f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?YWZEQ3lMMDhMbWZINE5sb3Y5dVFxdkN5UG9wOFRLTFVYa20yTjBERTl2YW03?=
 =?utf-8?B?ZmlRdTlzVU1BWnV3SjExMUlQSE8wMTZQODlZbU43SEJzdmxBWGNuVXl3emxq?=
 =?utf-8?B?d3NKUnQ5MjY4RUx6VlgvTHN4QjRMZnR3aUQ4MWZMUm9pT2wyZ0hSWjFiZGdN?=
 =?utf-8?B?OXR2dkFiWENpZ1V4ZVFJRWtVSlppK1lSUnZIakNRaHVBTkJsbjBock1McWJn?=
 =?utf-8?B?enFiemNCd1YwU01iRnpjZXJIZjQ4bGwrbkJYVUcraEtTaGsrRGN1SGQwenBQ?=
 =?utf-8?B?ZW5OUHdvN3ozRHdScGxWREhTVE9nSjVuOHRTQklQMGVlNUxHR1lKeVBaZGpO?=
 =?utf-8?B?M3A5Qjg2QUhSYjB3WUlicHZ5RW94a1o4aktsRWU3OUNpZUpmSlNhYmdDTENr?=
 =?utf-8?B?UzBFTnF0TXF6OUp3L1NKWERuMDNVRWs1Y3R0d09oM3lRZWEvTkZjVm5jbFIz?=
 =?utf-8?B?U3daSHNrMEFPQ1Y0WmtXT0pzRUxoZGovQXFvektMeExydVdBeGdFemJaOE5D?=
 =?utf-8?B?R3dlazEzYlZRZWJLVmF1RGRhWlBFcUpjdXBQTWc2ZVUxbXJCOGFTTlZkaVlH?=
 =?utf-8?B?Y1I1Y2FVcHVDQzRqS2JFakRENlI1VGh5N0pvUm5wSmZDZnRkdCtwekYzMG1m?=
 =?utf-8?B?QmRJeHQrM3psNFZTUklzeldqdlNEcDhXNTFZNWY5Nm5Fdk9FVzk4UmpGNWVO?=
 =?utf-8?B?NVlHUG9BMi90b21PdVoyZnhYZEtaK1dDR3RxNHEzdHNyTndyOWlXQUdXaWZM?=
 =?utf-8?B?OS8yTHZKTXZZVGFXR2l5ODNIbjZ0WERlTUkrbGc3MFZjSjNiVkl0MlR4UmI3?=
 =?utf-8?B?WitCV1pnUmtUWG9wRDA0Ui8wLzR0VmtKZFQ4d0k0OFl3MTN5QmQ0MEN4UWVS?=
 =?utf-8?B?NjV4ZHlpRDJDQS9aMTROQm5GR2tKcU1xTkVSR1hDTU9OTy9LalBrL2dUREhQ?=
 =?utf-8?B?K25LRnBhS00vejNEUzVvWWR3amNRV2RPa1ZGbll1TE9Lb1ppdldCa0dBaVoy?=
 =?utf-8?B?QmZKZG9mUVdKMjM1bXpRZmI3Nnk5ZHh2SHNsNHVmSTdFS2dDdkZ4S2FaV3VC?=
 =?utf-8?B?bzJVYm1HQVR4K0lFNGVYU0x3ZlFydU1EbTVQVTlNMjZZMzhzQ1NIQ1ppSDZH?=
 =?utf-8?B?M1phMGprOU9JVTV5cThRZEU1bGdrTG9CT1dVWlROYVlnYjhxRCtmcURsZzg1?=
 =?utf-8?B?YlExTXU3U3drcmtvL1pWSm00MGVtMG1TUnFsQTR6dEVqL00xUlRRbzdjZTZJ?=
 =?utf-8?B?aFQ3Yml2K3pGYk5lWS9kWHR6TEQrWEhxL1J3TXhxbTNKMHpwR1NlZG5DOVVE?=
 =?utf-8?B?RWR6c25oZDFxeWNQUlRET1pDOWthbnNCeW1lZ3MwYzVuVFFlNXlERWZMY3Jj?=
 =?utf-8?B?Nms5NExpT2FqblhuLzhDQ29DRTA2ZDVpdFBYekF3eU5RZUs1QXpDeUVaT2RU?=
 =?utf-8?B?NlJaZVVPUWJhbUdlOXcyRVJ3ZE5hd2NVVkZ3dkp1c2t5Mi9QeVRuUTdtZ1c1?=
 =?utf-8?B?R2hJdDI1MGZRVnU4UEg1cnFmbjg4MDRkdGR4YkhMZFlVZUpENTJNMTY4V0lr?=
 =?utf-8?B?ZTBmNXdqd2ZJMmNYVkNpRHd5RHVJK2Vsa1B0YmtCOHRHWVBlbjJsZ3ZuTE5F?=
 =?utf-8?B?ZVVoMnd5WkR4MVF3WlR2NmlHZ29mTkVSWW8rWkxJVUtLaDR3enRKb1VEbXhK?=
 =?utf-8?B?QTZSZ2RYbXVFdkFLcnZvSUpkZit5RmdIVG1hSFcwNXMvZ0Znc0dUYW9LdXg5?=
 =?utf-8?B?RzYzd3poUTdTWkpxTHNqcjFXTFlIeXFRZ3UvN01LQlRWQVVubHVpb0p2aW5w?=
 =?utf-8?B?Uk5uRWw2eVl5dzYwUGNsSDFTOG53MEk1VGdIZXd4WEh0NEFzVGF4R3dsS0Zh?=
 =?utf-8?B?WURRQWVDMFhLVkdNTXFvK3pKeVg3amtPdlJkbG53dkx2ZmhlZW5DVU9YbE1s?=
 =?utf-8?Q?E2x1AOn5dXso3k+3XVS+6z1Hv25c9FDc?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR05MB9810.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1102;
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR05MB7083
X-CodeTwo-MessageID: e234ab0c-f49d-4d32-971f-e62398e12f16.20250118121415@westeu11-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM4PEPF00027A6A.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	7fc59550-1fc6-487e-81e5-08dd37b99f61
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|14060799003|1800799024|376014|36860700013|35042699022|82310400026|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VU9XVnU2eCsyakpuWmt4Y1Zqc1lZOG1JZEpXcmZ6V0ZSM3pEV2QyOHZvRFFZ?=
 =?utf-8?B?QVVKTXNEUjR4dFkxV1JPTUJsUUk1TVkwd0U2YVpuVWt6d3VOYzlHL2Y4YjJ3?=
 =?utf-8?B?TTEzOHhZNXdaQitCMTRzYm9LUjl3c2hSQUNUc2VCdW83QUphN2xwTUxiYlo2?=
 =?utf-8?B?cVFlVDVQbzF4VDhiQjVka3llZ1Z6MTF0UzBXYUIxdmRDRjU2NEZyUWFrOFE4?=
 =?utf-8?B?WjdSMzNuano4c3B3S0NhZ2RSVTVITVU0VVlRV0RVRGkyOGtCMTN6KzdPZjAz?=
 =?utf-8?B?QWJKTXY3VEd5RUwyemFxVHhSV2lPbXZSdkEvYi9kNkpkN3d5alF5U3A5aDlt?=
 =?utf-8?B?YXlNYldnaWNRVmpyU2xLV2NqOHpZTTdJNTdSSXE1RjNsajlERlFDaTFmajF1?=
 =?utf-8?B?MmtTNUxhYUhrTHNFc0ZRR0tpQmV4RytVVjNaZk5IRzRUbDBXUlZWbnhLNjFk?=
 =?utf-8?B?Y2g5TWx0c0xrMjIzL1dPTGYrNUVUREljS1BrMXkyVmhWYXV6cFl3OGZTbU14?=
 =?utf-8?B?YUFwS3Exa1FLYU9rUHNZSHgxaHRsZGVHSWxvWVpIV2VCcHpORHFzSVc2YWJ4?=
 =?utf-8?B?cXBIaGNSRWxxWTgzZW1zUkFUck52Sk5KT3JqVHNJb1ZhajVHM1BZMUUzcCtR?=
 =?utf-8?B?THdpbXI0ZDRENkYvaWhOQmxiQkNRSHJpaFhySzFqVHBKTzRydC9RbERsSXRn?=
 =?utf-8?B?em05WmdtbGZqRU1RTTZmeCtnMzhxd1d0ekZiZ2NSalZCSWVJVDdOei9GUERi?=
 =?utf-8?B?Y0J0MFBPU2Y5RWpYLzlybGtLSnVBTXdkYWVOOHhObGFJRWpxMGhxbFBWenkv?=
 =?utf-8?B?NksvWHU1Zjd1R3JPRHF5eS9mWDY3OHZubUFqSktJYnlaL2JkbXdjQUwwN1ht?=
 =?utf-8?B?Y3p5WUxLNTJIK1BlUW53SEdONWlmeC9QSm14L0J1U2JhcVU4ZUIwUENybkx0?=
 =?utf-8?B?N2d4SWFYVHM5aEE1N01EcGxZSktMRGl1dzJ5TXQzbkQ2U0hEL0Y3dTVtZ1Ra?=
 =?utf-8?B?YkcyUHl5ZmJjZGRlQUUySkxIS2g3eUd6RVM0RkdCa0pjbkt4em9SQUdmSXRI?=
 =?utf-8?B?RUxmU2s5QTBoOEJIeFE4Ny9rNFdQOGwxT1pRY1hhdHlUVHRWcFp4M0M4a0xI?=
 =?utf-8?B?VVVLclZWK3htRnhCZ1NyNjhUb0RKY3BTeEFKUyt1TTJtK2RaUVE0SlZqa0lk?=
 =?utf-8?B?eElDMU9EeWFSZDFDSVk1NUsrKzVBaU5aUEdwOUVvUzNXRlVYS0l2ajZpc1dG?=
 =?utf-8?B?RktSeTB0cFdCRitmVE1LRzRvNklYU0pKWHE3amN0NjFnZ2FSVHBKb2tLMGFz?=
 =?utf-8?B?UjVxSmxSQVBHNW0zWHIxYnJZZ2g1SlhsclRQQ25uMlNQREFHTC8wbkJwV3h2?=
 =?utf-8?B?Y1ZOb0dGQVpZaU5XYVNyVVN4NU9HeU92UmJaL2FSNUo3bU0yM0MxV2wwWEN5?=
 =?utf-8?B?YW5kUWdmYTNsOTRUOXMySHFvZzI2dzNkWkp2N1B2eXpBZEwrVEF0c3FWUUdw?=
 =?utf-8?B?L0hrb3h0S0RCMVpMRUlWR3Q3TlRwVlpXYklWYWZQUkpYUjJIdGVzLzJqS0xk?=
 =?utf-8?B?bERPUjUvOExvc0xtZnBmR3N6K0ZhVDVibFlMOEpDYllmUTBUL0x5TGNzdVVN?=
 =?utf-8?B?d0J3dm1vS050eWJGM0xLMm43YU4vQXFFNG10S3lUUGphWkduMDlUd3NwTnE2?=
 =?utf-8?B?cS9UUXZGa3dqVSt3Nmg0Uzk3UytRSFVITWk4RUtKRllkaHhqaUlhN1NrYlJS?=
 =?utf-8?B?MklKZlZZSERTL2RPeVgzdmVYeHl5N0NoU3BnMEh3ZGJnd1hqRW9FS25aVWcw?=
 =?utf-8?B?UkZ4V1RjZ1RwWThLdTNLQmFJcWJnbGVadHgwSGlPdXdadFdMZDk1c2UzOW83?=
 =?utf-8?B?RVFsNmNPdWNjRms2N3BJeWRTdExtMVFmZ05sWE96TUhlR29SL1kyaXVjTXhX?=
 =?utf-8?B?K1dEelB1TlhGK0gvcm9jb2pxYkZKc2IzaXR0RTgxdmNOYnhNdGo0V212elQw?=
 =?utf-8?Q?4SI3CBQAj1f7d4vlFYj47B1j1w57A8=3D?=
X-Forefront-Antispam-Report:
	CIP:20.93.157.195;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu11-emailsignatures-cloud.codetwo.com;PTR:westeu11-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230040)(14060799003)(1800799024)(376014)(36860700013)(35042699022)(82310400026)(7053199007);DIR:OUT;SFP:1102;
X-OriginatorOrg: sttls.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2025 12:14:16.5054
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 82644ae3-27c3-42e5-c4c4-08dd37b9a0f9
X-MS-Exchange-CrossTenant-Id: 86583a9a-af49-4f90-b51f-a573c9641d6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=86583a9a-af49-4f90-b51f-a573c9641d6a;Ip=[20.93.157.195];Helo=[westeu11-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00027A6A.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR05MB10049

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGaXggdGhlIElSUSBjaGVjayB0byB0cmVh
dCB0aGUgbmVnYXRpdmUgdmFsdWVzIGFzIE5vIElSUS4NCg0KSXQgc2VlbXMgdG8gbWUgdGhhdCB0
aGlzIGlzIGEgcmVhbCBmaXggYW5kIG5lZWRzIGEgRml4ZXMgdGFnLg0KU2VlIGJlbG93Lg0KDQo+
IFNpZ25lZC1vZmYtYnk6IEFuZHJlIFdlcm5lciA8YW5kcmUud2VybmVyQHN5c3RlYy1lbGVjdHJv
bmljLmNvbT4NCj4gLS0tDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3R0eS9zZXJpYWwvc2MxNmlz
N3h4LmMgYi9kcml2ZXJzL3R0eS9zZXJpYWwvc2MxNmlzN3h4LmMNCj4gaW5kZXggN2I1MWNkYzI3
NGZkLi41NjBmNDVlZDE5YWUgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvdHR5L3NlcmlhbC9zYzE2
aXM3eHguYw0KPiArKysgYi9kcml2ZXJzL3R0eS9zZXJpYWwvc2MxNmlzN3h4LmMNCj4gQEAgLTE1
NjEsNyArMTU2MSw3IEBAIGludCBzYzE2aXM3eHhfcHJvYmUoc3RydWN0IGRldmljZSAqZGV2LCBj
b25zdCBzdHJ1Y3QNCj4gc2MxNmlzN3h4X2RldnR5cGUgKmRldnR5cGUsDQo+ICAJLyogQWx3YXlz
IGFzayBmb3IgZml4ZWQgY2xvY2sgcmF0ZSBmcm9tIGEgcHJvcGVydHkuICovDQo+ICAJZGV2aWNl
X3Byb3BlcnR5X3JlYWRfdTMyKGRldiwgImNsb2NrLWZyZXF1ZW5jeSIsICZ1YXJ0Y2xrKTsNCj4g
DQo+IC0Jcy0+cG9sbGluZyA9ICEhaXJxOw0KPiArCXMtPnBvbGxpbmcgPSAoaXJxIDw9IDApOw0K
DQpXaGVuIGlycT49MCB0aGVzZSB0d28gbGluZXMgYWJvdmUgaGF2ZSBhIGRpZmZlcmVudCBvdXRj
b21lIQ0KaXJxPT0wICAgPT4gICAhIWlycT09ZmFsc2UgICA8PT4gICAoaXJxPD0wKT09dHJ1ZQ0K
aXJxPT0xICAgPT4gICAhIWlycT09dHJ1ZSAgIDw9PiAgIChpcnE8PTApPT1mYWxzZQ0KDQo+ICAJ
aWYgKHMtPnBvbGxpbmcpDQo+ICAJCWRldl9kYmcoZGV2LA0KPiAgCQkJIk5vIGludGVycnVwdCBw
aW4gZGVmaW5pdGlvbiwgZmFsbGluZyBiYWNrIHRvIHBvbGxpbmcgbW9kZVxuIik7DQoNCktpbmQg
cmVnYXJkcywNCk1hYXJ0ZW4NCg==
