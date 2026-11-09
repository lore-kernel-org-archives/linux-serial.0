Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.104.109.113
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794242646;
	b=Fy7S2/IzNp++z7Xz2Mc3qhStN0tox650yjFjU6G+gZsNt/ZJ9KTt54PiXYLQmmtSaTnO
	 cCcADe8Km0ARqJGMlVD0NkQnJB2EzhixXp4YbFArj9psDg/BV7S1t1VThHSR56AKRuu43
	 XWg/Wzjd4cztpWf/AqEtz3Dkk2x23VMlUy79gJuMQ5IAiLlNYYz4ftlr4I62aBsgYBQPz
	 C8EpG1J363nQDgwK6oaUbSzNHX2sZ0V6hXrhKKQh7MEulvUYuJxM6h/Jh1Eu6WcsApPs/
	 3LMBsK4zgcpNlznaiTtHfkToGrJqRtk6FQJvpUhc8U8gQMjr/YUzTlenSesqUAYXfSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794242646;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:In-Reply-To:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-OriginatorOrg:X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding;
	bh=lKdeNI2C1JIdHaqLbneHv1qoNsRo1CMptwMq1YCRXUc=;
	b=GEPKea7f+jtdCBp+e2nsrcqY9nxzkNvM3aEcniMZTlBJ3iXQ8L42E9VMBJrcz9uEwJXE
	 fw1e5/3DN2yrpl16MIOhWPwKPHKgzu2ElnKK7eNAqYTVq20GNqZtW8Y21KHozAUac7kQq
	 R76wudfTn7kMdYON8T51Bx1mFgovPzdRptP7a07S7wHwGwHN1G3hE29ZjzDLMtxdOLxsU
	 IFhMfNO3VhjMwVH5p86wyjJbdLSYL1GnPbib1XzkqY1ylXqkohjpIMe0OXXjTqccfOzDh
	 03j3b6bDOQXJy10w65ur1NE1XSrs2mxSXWjswBN83XpY3On62rY2TnK1rMwcjs07GWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=toradex.com;
	spf=pass smtp.mailfrom=toradex.com;
	dkim=pass header.d=toradex.com header.i=@toradex.com header.a=rsa-sha256 header.s=toradex-com header.b=lcH6mcvo;
	arc=none smtp.remote-ip=194.104.109.113
Received: from de-smtp-delivery-113.mimecast.com (de-smtp-delivery-113.mimecast.com [194.104.109.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4D2606A326
	for <linux-serial@vger.kernel.org>; Mon,  9 Nov 2026 16:44:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7D4D2606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=toradex.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toradex.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.a=rsa-sha256 header.s=toradex-com header.b=lcH6mcvo
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com; s=toradex-com;
	t=1794242638;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lKdeNI2C1JIdHaqLbneHv1qoNsRo1CMptwMq1YCRXUc=;
	b=lcH6mcvoxIIjXb6i9biWj95wit3tZ0+J2Yi424qoEDd2f3+3yJ8L1jut/UrsNE6e0c4UHh
	8WUTEVsGiWJHvg2SNRtrMdlcmedsFlaBijAJxHmBtEy/vb0gV8fiJkxaBC5GpI9GsI7cvo
	txCgnBcceychlxLfL6RCXJrEM+IHmqs=
Received: from ZRZP278CU001.outbound.protection.outlook.com
 (mail-switzerlandnorthazon11021072.outbound.protection.outlook.com
 [40.107.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 de-mta-55-xo4ETarDPvKSOxY18QZSIA-1; Mon, 09 Nov 2026 17:43:52 +0100
X-MC-Unique: xo4ETarDPvKSOxY18QZSIA-1
X-Mimecast-MFC-AGG-ID: xo4ETarDPvKSOxY18QZSIA_1794242631
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:2e::8) by
 ZR3P278MB2228.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:c1::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.13; Mon, 9 Nov 2026 16:43:50 +0000
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::88:6821:13f5:a5b2]) by ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::88:6821:13f5:a5b2%3]) with mapi id 15.21.0592.010; Mon, 9 Nov 2026
 16:43:50 +0000
Date: Mon, 9 Nov 2026 17:43:48 +0100
From: Francesco Dolcini <francesco.dolcini@toradex.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Kiryl Shutsemau <kas@kernel.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	"biju.das.au" <biju.das.au@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	Au Dang <au.dang.jx@renesas.com>
Subject: Re: [PATCH -v2] MAINTAINERS: Fix Intel TDX kernel file patterns
Message-ID: <avH4RI_0OyePjWJp@francesco-nb>
References: <20261027055750.GBauA9XlPykc1c1Xhv@fat_crate.local>
 <TY3PR01MB113468FBD8E5EFA65C4B4E5EB86602@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <072dd88c-4ca1-4c8a-98b1-7783bc43c1c5@kernel.org>
 <TY3PR01MB11346BAE55FF22F66E86A6F8B86602@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <afdf1864-4721-4177-bc18-2a5821d97559@kernel.org>
 <20261027205411.GAauEPc4AtLwvrDfFr@fat_crate.local>
 <7b0a2e98-c614-4cdd-8604-3b5b21e8474f@kernel.org>
 <20261028154743.GCauIZH3pZm24jCX9b@fat_crate.local>
 <20261030023338.GGauQCAuYyXGwIhlqX@fat_crate.local>
 <20261031030112.GHauVZ-OI2KjdkjrcY@fat_crate.local>
In-Reply-To: <20261031030112.GHauVZ-OI2KjdkjrcY@fat_crate.local>
X-ClientProxiedBy: ZRAP278CA0003.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:10::13) To ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:2e::8)
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
X-MS-TrafficTypeDiagnostic: ZRAP278MB0495:EE_|ZR3P278MB2228:EE_
X-MS-Office365-Filtering-Correlation-Id: edbe18ad-fb95-4ae8-d02d-08df3e80a1a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|366016|376014|7416014|1800799024|18002099003|22082099003|4143699003|56012099006|10067099003|261028144727099003|261026121527099003|261022105027099003|261026140227099003|261009223027099003
X-Microsoft-Antispam-Message-Info: 56GL8oGC2yEDqmb8N7M1t2kMdMWGUO+gWwesE8UvW5zx3vgUAAHGesqXYM5hAMMlXleQBDItFtdhSQje29SOm8inJHv+dBXDHgW+pUEJT4zCvfJ4894MuBs1AzevnfLXGL4OLR9jGn24ztJzOyJYtIfqKXkUBgct6S3PQVkpclMRYzChKUuHFy61f6sHlrZXBEeMoC7JE/MoZlRL/13fp4tFZOG7Lmau4W96tNkV3LdtWsnoMfLsPth4eH8SH0PWZA7JE6xiegmGezpIbnywne/RV175031JuodVsMb4w6FMtgOpli7ZT3TI+6YRQMx6BSpgUNHWMUAWIdnV+9KKBf0xRoglZ6eR/Yy/mFfguFgyNUyvLTwCrJs6ROJMEQF1upidD/lO2RdhSKQkxWuZK7uy0VfHAco9n6BqF1bVYlZqbcy9YgbrgPXtF8t+ITx3PqYYYwsAPNAH4/aRD6sGUQbu5hNhQbsETrvbQuloZ9hBaiP+be10qocbxUsYNGDpVZ+ZaAxiKvBtXNRDaUCzOr3KZKDqoSKciIUfW6iRZrO2iSl5EItDHR637NHD+K+dtdJvDru7dGAG8oVfWyndOCNPzy2hF6LnBytP+F2ODdH/kUXzzOvm+2H+lcGBolPl
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(7416014)(1800799024)(18002099003)(22082099003)(4143699003)(56012099006)(10067099003)(261028144727099003)(261026121527099003)(261022105027099003)(261026140227099003)(261009223027099003);DIR:OUT;SFP:1102
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LCEAcxvzyEtBtO+G6cawy93DBu5qalvdWsLLNrPFFKr6li0dr5Q+ML5Z1cnz?=
 =?us-ascii?Q?51YgrqSrwLhvGXDyP1fynC9/9hruzKtqZ7BqiqXf5lrFfHzVZjiVcA8mqll0?=
 =?us-ascii?Q?s+ltYCgJiheAWcaDPCPirg7vBg7batNHnWWls/xWk5sk/jkyIasefIXyVbkk?=
 =?us-ascii?Q?zo01cArCzzHTfLTI2WE+qUlfDw5/C1ffqo+2OQF3Ug/yTeO9SRNzVlLFCcQU?=
 =?us-ascii?Q?L9gvj55T98kTCtniGgssfOkgydxW5eiDYd2WfNJOXWeWB7Bjh+Iq7XLkbMrH?=
 =?us-ascii?Q?fECz8ABP9OdflbS2SyySDFrOrTOGsFKxKY+KSLyNOzKCg+LAw39bI3fBToFJ?=
 =?us-ascii?Q?oYBMGKE+N6V5lKjkbuMJT95tKDNHw89d5ZzJr+mdqmHZdGSq5u+7fH4zFxDn?=
 =?us-ascii?Q?wyjViqUJTL8PE7tKbcDEBnueyJb7UQ+KzFout4c+67HMHaUvqkQ9uTYtDQFm?=
 =?us-ascii?Q?KcVfc0hVogYG9G6vMiDhW3w1oJN/1EITK9x5Zox6/wIE7ZAoqqQ7j+QEw1rW?=
 =?us-ascii?Q?+3xTErM00AJ6rJ6qnoTK/m2OQErkJ5BCKF3B5vrA2gp+DJ3Kc50/E+1Cg9Xq?=
 =?us-ascii?Q?9oxcapyI+8gh0E96sfgd9ntFeQ+4FHVl8sXnIivrXUjyi4GDGrId8P1Se36g?=
 =?us-ascii?Q?cg9Bx7BNRCDNYR/t0Q4y9bv/tKQR4dAC4LirUbQBE/LarLPwLhBKEQxjeImB?=
 =?us-ascii?Q?ICqAysEAE9DSfqC6B2x3MieUhj0C6iqa3XMRavASLLxRtFSQA1/kYcNbwLNy?=
 =?us-ascii?Q?XpTgfl6t3MdRFamqULMCGmK8lUbv66YWZ2zIae/GeHY1bCiJtJRxXoQAAbJm?=
 =?us-ascii?Q?+PxR5Owl5W6peSi4/6XK/7PCZrfAlIlNhX8KA/4nukvukipktQOmpYy71s7G?=
 =?us-ascii?Q?VdiGTtk2EEeS9age8hmW87n6IcSyedocgiE5CcB5XZfAi6D1APvmi7GSVxc/?=
 =?us-ascii?Q?UivkdiD705v2xUQBxp+Al5TL8Tc1XaLoYvuIcZ0754TAbY22Fer71gbJyCBX?=
 =?us-ascii?Q?fQrv1jCDuvZ32C/meJPcK8XzOZGOeWMXdlxcgkv+YDzLukTVyvSSyPnlLOK7?=
 =?us-ascii?Q?YqAI3Qzv2D9+OVfU0XZ03Hrvy32pEb/7gTaCsAlYzhbdubY8/dz1k6kjJQS8?=
 =?us-ascii?Q?rFBpIXwAQ6f8Uj4pftLoQBxhaWpVw2X0GsJ/wQn07FKWeKo50PQPl6dk5v8s?=
 =?us-ascii?Q?bOHby3zkiYx2KiePq0Z5uiFleNjdcHZYbByl9VQPJiETLMC5xhmWIEVqY7Vi?=
 =?us-ascii?Q?J4OenlN9Fyh7lILh/C3jiCbIDHYFfv357an/npmptkf3mjaQHhD//b93FYv4?=
 =?us-ascii?Q?th4U0VQtmpmAowurAWeGX+Sf5Y+hXZd3iOMgCi5n8WWXYx4eCPAnzI/1Che8?=
 =?us-ascii?Q?AoLwV8TC8b6YQhCxWXjE8zp3VRNtpsnVrKnMLc+D6xNqL+GepBhVoZldW40H?=
 =?us-ascii?Q?bLtSZFLNuYP46CQYP1EnXoRX8i8/o4GWcpjNXny8x68Xgl/zXCNKPryWkN0P?=
 =?us-ascii?Q?dS/U5SpuePy2lufcg8idPQa847QCIIoHiESluO9oYS067lOyqTxUjYc4zCos?=
 =?us-ascii?Q?BflCTSobJcuRoBwbD98OyCroJY4ojRN4diZTvYOR+nXigBVkiQ0L8IZLgf6Q?=
 =?us-ascii?Q?YeCs8cnPwxDid9zGavmK8n9U8qpmSHvxuqlc47kmfaeT9nCsprUV9rNtJ64k?=
 =?us-ascii?Q?l81aP4o8CpCcQ++WdfreuncW5oS6djZm5ZHnN9TDW5Q0C/yuu1qNHaCuWxt1?=
 =?us-ascii?Q?pJb7Q6qSwpGAJCSjaeIMQkKb/UiVHxk=3D?=
X-Exchange-RoutingPolicyChecked: m5sPu7HIxuavy5SeRnreUmRrHx5zD1+LhHxAkXSiWzNQWm6+k2vDUID1pLdJ7fONq65l+B+k94QRxmhv0zY4Ws+rXJrrXBk7cZbdzxdHwHAN6SKHOTllhqZ78Xq8llWIrUJ8pvhKDyBqnjI+ixyAjKBH79UGBAWbh6PiRolrVrE/ivzYMbDB7Htc678OR2uuc01bVFEtIzoflYUmlmt6bhotmR9JFlrAvVFcbkID9y/UjaG+SfxgwN6RhHXSaqK6GANu9SUe5c1eGfBK4uKnw6ABnFJteMqs54aXqlk7Ross4J2YPA0mMsyw7nfiGx5In4z33rCbK0QDNOAkvQfQxA==
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edbe18ad-fb95-4ae8-d02d-08df3e80a1a2
X-MS-Exchange-CrossTenant-AuthSource: ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 16:43:50.2200
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ecjeyswKGG4MFLOhx4KvTy8J4ENIFLWbwTKvqkD/jiSMhOQ+ksfAJzJDM1f0h5by6GqfSLGwvVO0b9f/Q21crzlMlKyVzomc1RykppHbQe0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR3P278MB2228
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: mb9NSRn9PM-ppj4Hk6mYzfqm0plj5HBtLbPpvzRdQPs_1794242631
X-Mimecast-Originator: toradex.com
Content-Type: text/plain; charset=WINDOWS-1252
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Fri, Oct 30, 2026 at 08:01:12PM -0700, Borislav Petkov wrote:
> From: "Borislav Petkov (AMD)" <bp@alien8.de>
>=20
> A K: is a content regex file pattern which matches any text in a patch
> so if a commit message contains "tdx" as in
>=20
>   has_tdxe_auto_clear
>=20
> for example, see
>=20
>   https://lore.kernel.org/r/20261026-g2ul_sci-v3-3-b3097163edd5@bp.renesa=
s.com
>=20
> get_maintainer.pl erroneously adds the x86 gang to the Cc list for what
> obviously is a completely unrelated patch.
>=20
> The same happens when someone uses it to check
>=20
>   drivers/power/reset/tdx-ec-poweroff.c

And I just send more unrelated patches ... "tdx" is just the short form
for Toradex (since 2003 ;-)

> So switch the x86 TDX patterns to files and directories (F:) wildcard
> type patterns and group them by path, for less false positives.
>=20
> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
> Link: https://lore.kernel.org/r/20261027055750.GBauA9XlPykc1c1Xhv@fat_cra=
te.local

Acked-by: Francesco Dolcini <francesco.dolcini@toradex.com>

Francesco

