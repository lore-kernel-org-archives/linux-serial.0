Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2089.outbound.protection.outlook.com [40.107.20.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01FC779DC7;
	Mon, 18 Nov 2024 15:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731944699; cv=fail; b=ggzQGveYw6ZJwTsRQT+0qR11QnORxnO93XyCyQNPvchNsFK2Qowurmo9EFV+RXQtJjlcvdWNp8uO+OmLaWHOXox8v64Qi/EunTpOUNTambN6MgBWRuobsk8K+WZty18moeNQy7qZVeUT8nGBpaeXBrzeRDa5IYhyZK0ILvx+sFs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731944699; c=relaxed/simple;
	bh=+vvmXdxzsWvVeeZihpyhZlT7ZthlGKMM2LLVWMAH28k=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=sLoZArgXjDK/yK9OF67Ut9PW7CzvzQvV2kt1q2og6LTFaWyJ6752O9Vmo5awzZ+xyrEryAo0wYO6rHJnIohV7YKkJvfDA5dvM3QUhvSMhT4OJIDbLQg+7Y6ljiy3+8yozwogC7yEuVL9cl70jV94n/yS63WrMTV9xJmRQ5p3mZE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=bjKxG5c7; arc=fail smtp.client-ip=40.107.20.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="bjKxG5c7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vB/D8Hy75aZoIVI9AwAaZ6eCfDnJpx+ogk2oOo7pjLNLNDtXI6VEs8fA9wWbKqvO0h5l9HUs1ERwcg668p7m0jUFAd0hdOxGJNGpvW4q/eNJVJlwM7MdQWNpoUCFaV55bQfCnPUOm0y8q/kjphUpcYZSvFUQcNMn13Vggy64plw+Q21f2hDjPEse/6HhT/bBDSF+ruOJpj73viv055WxG836JdGSi4ZZRPLGat21iFAOVFgFSLZtoGgCrhgLUhRWvbrcjXBXoBqFDRrrlaHGLSDbhrayN5mlOhzB49W6gSOwusHU60Vj3wWxPm/qZ3/JvL5XCOOJVf47ZOJO57GiIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GxYZ9Wrpf7IkQ6GkQMZBtVZ/QiPrv2+TUTbuukG+XN4=;
 b=Pd6zSg5oPoEwjtUAH4e81+J1ybQPgu9g37YJVOtBtI4OpbrX+pxidDs4NBrXnmAGdL5IB6eqAw4DbnIZRrTlsWerBMVI66/C6/e0mZ0CL+3IdXwTGfymE4Qm1azbVeF26AxkGrbs6n58GucjdfPahJRduPMhSkKrs3d64IIGT2ClY4+P4NMY1CQwX8pJUGbCwGoQEpx694UZgOkexh4eBavpHinutXMHY6KowkD2KsAAYjXo1EJnum9ZtTVy0BzGASajnS9pZ4MO+vLCaXgOWU1fnS3XpEsfM0GWGNySDA5c5Bl9b6s19Z7eGNhfaRz4xjdTTglfzF6UVSZgHvMrsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GxYZ9Wrpf7IkQ6GkQMZBtVZ/QiPrv2+TUTbuukG+XN4=;
 b=bjKxG5c7PaKMvPkHwD2jbuFzUvxewDRFZI5h4fDo2AzrpeLE0fSc6ooVgfrS8yYmPbH7+C181ShylQVXoS0msFvsDCLFzQONSGmhwvQOF7jj7Eow9Hers4NSyOWDjtOABNAs87dP4zSqH5arY7eRsgl3y6837wAVa5OAH3a1e19B324IWP/2qoqZGNhNE8T02As2YAwsQwnDx5Jvl886VWfNvQwCqRh4Sebe3EH/AEFLqRHqO4q1iCQfd0N9c9MYvaZvrvWrERes1yU3vkaUrbGO3iSM9SQ0qsIfKqKq/JMFltjT1st79Ij1Yl3MLXqu9gBweb8buNzehOk1sSY50g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by AM7PR04MB7175.eurprd04.prod.outlook.com (2603:10a6:20b:111::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Mon, 18 Nov
 2024 15:44:52 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd%6]) with mapi id 15.20.8158.021; Mon, 18 Nov 2024
 15:44:52 +0000
From: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chester Lin <chester62515@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	NXP S32 Linux <s32@nxp.com>,
	Christophe Lizzi <clizzi@redhat.com>,
	Alberto Ruiz <aruizrui@redhat.com>,
	Enric Balletbo <eballetb@redhat.com>,
	Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
Subject: [PATCH v5 0/2] add NXP LINFlexD UART clock support for S32G2/S32G3
Date: Mon, 18 Nov 2024 17:44:46 +0200
Message-ID: <20241118154449.3895692-1-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.45.2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P190CA0002.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5de::11) To DU0PR04MB9251.eurprd04.prod.outlook.com
 (2603:10a6:10:352::15)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9251:EE_|AM7PR04MB7175:EE_
X-MS-Office365-Filtering-Correlation-Id: b8430b2b-c41f-48ce-3b7d-08dd07e7f12c
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c3Fta2doR3cyNGo0aFpGU1FMMWtTeVB1c1RrRGI0djg0N2tjZzFLZ3lCWVhU?=
 =?utf-8?B?eWFuOWt1dEtGQnRiZmxzdEkvcC9oODZ6eThha0pCVFFIRzNVcXkyMnpROXZJ?=
 =?utf-8?B?OHdnRjZBcDdLVEZnUTdqZnlVVUQxWWVIWGVzaWdUQVAySUdlTS9VK3BJcXNL?=
 =?utf-8?B?Vi9VRnJRd0RkK0hiNEQ3MElOUkFQTmltRWFNSGR0bjRoUWpNTVRrcHB2NEV4?=
 =?utf-8?B?MUNJbFRPektWWG5JQ2dKd0p3dlhab1g1Y1YydkE2cFUrZTBWMmkyZm9PTXk3?=
 =?utf-8?B?aHdVN082Z3NGbmFJUFE2dTNGbit3MHZoaGNHY20xZ21VQjJObWRDUmdrUXlq?=
 =?utf-8?B?cmFhcGtzNG5CZElZRzFoLzFTdXorNkFrcWdsWEs4VFErckhjZzF4SWNuUmY3?=
 =?utf-8?B?aC80YmxtUFVoQnkwWFhRcWEwVENleGdyZWxGNGlkTW1ieFRIL1gxcHYxcFl4?=
 =?utf-8?B?SU5la3hGb2JaRGRoR3V4Wk1nbFlEVkdWcHlwUVZHWkZ0TzJTM1pROEZQWTR2?=
 =?utf-8?B?YjBXR3R2dGJSYmpxVnpXaG5Ja1VtbCs0WDY2S3MvSTFLMzlHRDR0RUlPbGNn?=
 =?utf-8?B?UG5PeGd0dkRpNms1R2JBbS9oZC9ScTd2VUR6S1gwSEY3S2hESnF2a2NnM01I?=
 =?utf-8?B?YXY5b0JidmRza3ViMjlnWHJuTEdsL1QzMG1nT054emY0ekVBcFJ3YjFaZUsz?=
 =?utf-8?B?RmNLSFhlTVhibE45SGR4dHJUODZsaHpMT0xLZHN3V0ZocUJGNGpxNkNMVzdk?=
 =?utf-8?B?Z21DeDJseDB6MDRaTW5GSEtsSlNrMy8xWTlxQUZrbkxrMEdPbVJRVkdqOUxo?=
 =?utf-8?B?VEdieldYcnVGT1ZBcCtEV1NmWUljOGlRaEZkRnZic0NUZEdsNUQyY2pFcFpz?=
 =?utf-8?B?VzU3K0trdUpqS2wrZ2hHVjJYVTNuZFpvN1pZcGJId0J4MnF0SUFhVmc3bGJj?=
 =?utf-8?B?bEZXZ2U1OFJCUFJLblhoUXNmWDcwblFRd0JEbkpnNDE4Vm4wRWFvejFDV0xB?=
 =?utf-8?B?ZkVLYkUxb05FZHBkNGFKejRJcEU3cGNPRHBjVVpIZWpIczhra2VBWDQvSzQ5?=
 =?utf-8?B?Mk93RG9Udlgwb1hyS3dGWmNYaDJkdFowVElKT01CWTVKcEdHK1NycUlRQ3N4?=
 =?utf-8?B?YnJFMzlIWjhmTC9ZQU9DWFRWcVNucDRFTHBRNHB3YytKU2lQaFk2ZUs0cjUx?=
 =?utf-8?B?Z1RJb09LQmhXYzdJczl0RVZXd3JCUzI0WnB2djkrSUg4cXQvVUpvR3BEWUdv?=
 =?utf-8?B?Ym1aRmtDU3VCMTB2cmh5OVI4dHpSeDZOY3JoUHVtQmxsYm5OZEZjdFJDUlBB?=
 =?utf-8?B?aXN6Ulc1L2dBN3pnb3NtYlFQVTdEREZWQkgzendRUzAyMzhFOWV6VUQyV3BP?=
 =?utf-8?B?SVVLMHBCR2VUNWRmMW5Ta2VVdFNYclV6MUk0NGdwVUpkN1VqZHlvQzlWNFh4?=
 =?utf-8?B?ZklVOVRBNUpZdUwvTHBsUDdGWlZLRGt6Z3orczNMYUV5dFNjQlRSQmE4WWNH?=
 =?utf-8?B?MkxianNPckpwZGY3cVM0ZXN2bnZJNVp0VHZueXBwVkF0bDc0ZERPeGk0c01h?=
 =?utf-8?B?bjFFNEVnOCtwYW1wcEw3YzZNT3RvRU1WMXgxK1lzTkIrbE1DalpseFdyaHdz?=
 =?utf-8?B?Zm5mb1VLU3h1ajlheVhTeDVOcnUrb05wa0JJUjRKemk4KzZBYUREeDRFbnQ1?=
 =?utf-8?B?dUJ3Y0o3RlZ4Mm9WQko1QmU5NmcxY1dNWE9IV0lnNmNsd1cvcGlFS0JRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YnlpekplZ2J2TkRQenl2ZWtYTmMzdFVXUTQvUndKazNaZ1NrVUQxOThpL0Iw?=
 =?utf-8?B?OFV6U3JwdFpzK3p3VUIvVjQ0ZHhiSXRxeHVzb2Q2YWRwYVN3cjJleTBVV1p6?=
 =?utf-8?B?ZHN0NVZCQlVJZTRQOSsybWQ2dkV3bVZaUkNwTkhoOWxkYUJ3MmlPVXNIS215?=
 =?utf-8?B?R09teVFTdlZmTm9KOEllMVFMMlQ5UXFFZTRMUlR4K1VLeEtZM2FKV0RBUWp4?=
 =?utf-8?B?V3B3L1BWUmNBeDFTUUFsSFNUTnNvMGhEeHRLR0lNa2lueEJxU1BHSjg4UDc2?=
 =?utf-8?B?eUc1SUo0emxMYjBBQWxNTlZoelFsRlVRREhhNE9yTkQ4SVg4VDNEZTJ2WUtM?=
 =?utf-8?B?T1BOYm4yckw2WkJ0ME5VTE5WU1BHdFJhNWNkTS9xSUlzU00rdHl3bHE1NU1l?=
 =?utf-8?B?dEZzS3A5RVBUWFFVLzIzVXZGM0lIemhrQ09XUlUvWFN3TDdTcEtYQlVMSnZO?=
 =?utf-8?B?ZkNqRHlSSFpqb0pJSkRXQlFQeGRwUTZoUnhrTzc0dWFhaGlUam1VRUtBUVAy?=
 =?utf-8?B?NGlhWS9xMzYvRll3UGI2eGJ4VFJKRzNoQm5jcXdobkR0YlVVTm9lNXNReEFl?=
 =?utf-8?B?MnNOa0NqYllyL2ZXdWpRaXB0cHRpd3RPRE5oN3hKSkl2c052MHZZb1g0OG1n?=
 =?utf-8?B?aUk4V285eDBLZGJybjE4RkdpQXd6MncwYXBuOHJ4SDI1T0JoZG94dWdrZFht?=
 =?utf-8?B?aU16UnhVRS9FRWFnTHNNS01BV3R4VHRKRHN0SFZBb2hXM01tY3BsMGVHK1pE?=
 =?utf-8?B?L1o5dVluVmVOS1YxZUdJWlJzVWZ6eXVpVTlZemFMOFRyZTFqdnFUaktDS0Vq?=
 =?utf-8?B?UVNKbkdvemZqNTl3dnNidGV4NWlzTW0rcGhIem1aanFIck5HWEVZdVc1cHJ6?=
 =?utf-8?B?Vi9VM1RuTmZSWExlaUw4WlJHVFFSQVdoTE9rbVhFMEFPZzVkWDlWaERwRDZx?=
 =?utf-8?B?aUVJLytFUWY3azhuQ0IyNnpUcmNGR28wNng1QURVVW9Obyt2akR1Rkc0ODVz?=
 =?utf-8?B?Q25pVjh0WHZBRms4bHRrWjkwQ3FBNnJqVW8zZVRaaGlTTDQzb2hjb2RuR3dI?=
 =?utf-8?B?cHpFaEkxenZZVk0xNmFNZEFOUjNQRWVMM2tjcnltUWN2RGY5ckgxOFFITVpt?=
 =?utf-8?B?L3VGeDhsUjJ5NXNzeitrL24rRjEwUkloWlYrUGJ6aEpjbjNQQ0xVRzhaZis3?=
 =?utf-8?B?YmVQa3R1SmhtbHBnOW5XVFg2WUdGT0ozeDgreFlyRURObGJUVS9tZnR1aWJv?=
 =?utf-8?B?cXV0T2srSlVUUGY5bm5YcEZlOU9RSUQvZjNzVXhxQUwyOUVsK2xDRTQzWTJp?=
 =?utf-8?B?RnowaHhPQ1dEenRwZTFIS3VsdzV1RG5Yc25BM0lUY3lQeEJmTXhQN3R3aEJK?=
 =?utf-8?B?N0RHaFE0SDFESmFMc3RPODJ6Y21IMjFMaysrOUxRcXM0endCdjNiTUtsdzRi?=
 =?utf-8?B?VFFzbHRDdkdldlF6TkM3eEUxeXArWXl0dGNqRUxRUVBtZFptcVJnUHo4ZXZX?=
 =?utf-8?B?RTNQdURjMFdsWWR5ZHlpOTJTdUV4bEhPN1BHbXhNYkQyVTczQlZxR3d4aUZC?=
 =?utf-8?B?MXREOVRvQ2gvQVFWQ0JqU1J2QTBKN05teFpyU1QxZXhWck1TM3JQZ0tYVkRm?=
 =?utf-8?B?SG0wbzE2TUNYUEJVUE9lMW5JN3RDWnZNK1VYalU0Q0lxcEN0WWJ0K3pONTAw?=
 =?utf-8?B?QS9xRlRGbWRVeGJaSDhLdUNFREMvY3ZtVXZRODVsSmg5cHVkNmRDWWpkMTFU?=
 =?utf-8?B?KzFZVC9sSDAvRUR6U1hLQlJZS0VrL1Fxa1Q1ZHNtK2g4ejRXK2ZlQ0drMWVZ?=
 =?utf-8?B?bjF1REp0aTVlUmI0a1ZtSXZoeVZDVER2VFBoSGlWWllsbGpjM3dTZ05aN1Ar?=
 =?utf-8?B?MHRCN2UrTVNmK0xveHJEY3dlb1liYlVmdkZaSUpxayt4akdMaWJmOStVR3VM?=
 =?utf-8?B?cHlaeTZQMGo2UGR4QnRSVGk5aUlJQk9kazRDUkcyWjRFK0RxSEVBMFh0ZUYv?=
 =?utf-8?B?SytzYnN6YS9VRE1xTFBkZjFxUVNxMndlakM2bjdiNExGRFlQTHNnN0JhTDl5?=
 =?utf-8?B?RjVtK1JvZGtlOHJvajV4Qy9uS1ExSGNZbXNHdTA1ZzNmSnAwN0Q1VzVZSmtl?=
 =?utf-8?B?OEdhdkllN0ZXOGxpTi9ML1RsSjZMajJsTUJwVWRmNHpxNGtYRVVudmhJNFdU?=
 =?utf-8?B?M2c9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8430b2b-c41f-48ce-3b7d-08dd07e7f12c
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 15:44:52.3277
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0q5jK4uBFd2PTly0xleyfezo3yoezhEN3L5oOFD90t75HfxabIqZoJidqBl1psCeiYBjqDw431Duy6n4fh7zq8B4+L25ktYlUXMJzdyey6s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7175

From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

LINFlexD driver was working on S32 based boards without clock management
because the downstream bootloaders (TF-A [1] and U-Boot [2]) were
performing the LINFlexD clock management.

LINFlexD driver from Linux Kernel should manage its clocks independently
and not rely on a previous bootloader configuration.

[1] https://github.com/nxp-auto-linux/arm-trusted-firmware
[2] https://github.com/nxp-auto-linux/u-boot

Changes in V5:
- Use 'devm_add_action_or_reset' to disable LINFlexD clocks if errors
occur on the probe path.

Changes in V4:
- Switched clock management to 'clk bulk' API usage
- Added more context for this patchset

Changes in V3:
- Fixed an error reported by 'dt_bindings_check'

Changes in V2:
- Updated bindings by adding more information related to required
LINFlexD clocks

Ciprian Marian Costea (2):
  dt-bindings: serial: fsl-linflexuart: add clock definitions
  serial: fsl_linflexuart: add clock management

 .../bindings/serial/fsl,s32-linflexuart.yaml  | 16 ++++
 drivers/tty/serial/fsl_linflexuart.c          | 95 ++++++++++++++++---
 2 files changed, 97 insertions(+), 14 deletions(-)

-- 
2.45.2

