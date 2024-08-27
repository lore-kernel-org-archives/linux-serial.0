Received: from eu-smtp-delivery-197.mimecast.com (eu-smtp-delivery-197.mimecast.com [185.58.85.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF481C3F17
	for <linux-serial@vger.kernel.org>; Tue, 27 Aug 2024 15:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724773146; cv=none; b=DdNIja4bEoFDbqk/bDxnvXSFCY0UdIc6ooZNFPxya64rZNB/2xAFaNF34DBUWmgIkiG+Lsh5ZEKaU4kj4oW6tAbveAJ20bF5E3p2ZtoiOSDplL+BVbNap6cDMS4ZVRHAu3UWvZzk8oPTVICAI6+ls89dR35FUdWcMPeojQLAGsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724773146; c=relaxed/simple;
	bh=rgXJxJ7i1FhFhXiK+OJhtwpkxqweOGYiAGllI4aNxb8=;
	h=Message-ID:Date:Subject:To:References:CC:From:In-Reply-To:
	 MIME-Version:Content-Type; b=Il7Mu3T+N4SOLnixa7GuWNubX1b1W0tu/Ea5xzZb6RPj+qrsB0dUAltyFdImDcU/U7MmvBbNKZov9WHt7ObxlnriEkI+FRrsDOYHJDmkMUXUUjYMA9IhaCF5omyr7VWJ7nioWMl8xMy3lnbtjlZsGBtXL3xfdxVPZ08nBKoUb24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=camlingroup.com; spf=pass smtp.mailfrom=camlingroup.com; dkim=pass (1024-bit key) header.d=camlingroup.com header.i=@camlingroup.com header.b=JB87qIep; arc=none smtp.client-ip=185.58.85.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=camlingroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=camlingroup.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=camlingroup.com header.i=@camlingroup.com header.b="JB87qIep"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=camlingroup.com;
	s=mimecast20210310; t=1724773136;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SUj6lykUWzpmGvjPz4hFjdAHAOf97Mghp+WWebCKnL8=;
	b=JB87qIepfePts+zjkuyWHJMueqcAKkXtK8+7Fv9bb6/lDB5VVHFuwNAJlekcPs6fOi6eYU
	wUxHCv99wASae3pKUQsGF8w2pg/NQP4o4xhX1YLBU5UvmgTXxr9s1Q73aVaeC0F3X+bXLL
	F0S4Xk5CenwelrTx1oBg7wbr/sTkyp0=
Received: from GBR01-CWX-obe.outbound.protection.outlook.com
 (mail-cwxgbr01lp2040.outbound.protection.outlook.com [104.47.85.40]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 uk-mta-260-a8YD14-AP26OMCMGMeokRA-1; Tue, 27 Aug 2024 16:38:54 +0100
X-MC-Unique: a8YD14-AP26OMCMGMeokRA-1
Received: from CWXP123MB5267.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:142::9)
 by CWXP123MB3509.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:79::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.26; Tue, 27 Aug
 2024 15:38:52 +0000
Received: from CWXP123MB5267.GBRP123.PROD.OUTLOOK.COM
 ([fe80::f866:62f9:716e:ca4f]) by CWXP123MB5267.GBRP123.PROD.OUTLOOK.COM
 ([fe80::f866:62f9:716e:ca4f%4]) with mapi id 15.20.7897.021; Tue, 27 Aug 2024
 15:38:52 +0000
Message-ID: <8e4874bc-893f-44b5-9775-4581d628ba1e@camlingroup.com>
Date: Tue, 27 Aug 2024 17:38:50 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/3] serial: sc16is7xx: cosmetic cleanup
To: Andy Shevchenko <andy@kernel.org>, linux-serial@vger.kernel.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <Zsy998mgOAyJa2xn () smile ! fi ! intel ! com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Hugo Villeneuve
 <hvilleneuve@dimonoff.com>,
 =?UTF-8?Q?Krzysztof_Drobi=C5=84ski?= <k.drobinski@camlintechnologies.com>,
 Pawel Lenkow <p.lenkow@camlintechnologies.com>,
 Kirill Yatsenko <kirill.yatsenko@camlingroup.com>
From: Lech Perczak <lech.perczak@camlingroup.com>
In-Reply-To: <Zsy998mgOAyJa2xn () smile ! fi ! intel ! com>
X-ClientProxiedBy: BE0P281CA0010.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:a::20) To CWXP123MB5267.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:142::9)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWXP123MB5267:EE_|CWXP123MB3509:EE_
X-MS-Office365-Filtering-Correlation-Id: e92461b0-3db7-4599-c89c-08dcc6ae5a76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3hpv4Fy9Q5WFQL/mi2g+UlmUVcVPrAqhJ1xVPmH76sYh8WvxRuSjxm+Tw3TP?=
 =?us-ascii?Q?c3duXYWOxlKEl8s4SvgDs6Qg1FqesUD0AAUh4YpCl0YmsGAocYtd0kDzPu7Z?=
 =?us-ascii?Q?jITHGgR47BBzC8dzviLVwlFzykZ8laRoEE0XptiVfQOjzrOHJwdXyqliy9f+?=
 =?us-ascii?Q?jlr83ydeHA6nkOwtTFD+RU0QwXyRiBh62ClUayekLO/9dPieGyHXuVMaHW1/?=
 =?us-ascii?Q?6i4NvVPsT+QTOr3kH+oOXFQ4/3zibwJozxywb6sieVhFPlWW/59DYNQkrMkq?=
 =?us-ascii?Q?UOSKR7Zxh3XsHSm1bVeX4P/TZiIngnLdg5opsPfRsjCdn8bc5AffWEBG/uKY?=
 =?us-ascii?Q?Arvs6VyJ7oeAaOaFKZxPhxLndIEvtTsz3vvIQQLtZkwxmNYucGaGkTcnmCLc?=
 =?us-ascii?Q?jntBZatycvGfybZGjwZjT1+nCelqf4/BOSQ/oX1gaRBzv1vP/Oe4dKQXkhi6?=
 =?us-ascii?Q?80886wZHwIc+AGJuNc1qY0hh85TS+hXlUM3ySU/Oq++E3ACv4AiSFyZcbxDb?=
 =?us-ascii?Q?F4YJyiW0W+Qr+hQso2Qv7RSN+As40ZqvmQX109U8t0XZnJ07Q9H+Dldn3u6o?=
 =?us-ascii?Q?d5Gf9lsu+50lz5Hw/k7aOsZWu4Cc+4w2401k1Nt8/JBOI8L/JhaJ7u3pej+S?=
 =?us-ascii?Q?r+Af+Ixa6SAsvhsd9zAjWZPjhmKwl//cY5dsjC6kcK54ZpKq46KlG0PoQwGM?=
 =?us-ascii?Q?A3bKNj8i2O+bGlBYld1UOZ1n4+lCYB2eg6Yawo5zGIl0uQ97ESYN06oWm2ml?=
 =?us-ascii?Q?n/MI9cIudTD75BEPjOhdDjHbXCuZMgEN26qyQ2RU19XyWHpdQwTUcoVvx7KC?=
 =?us-ascii?Q?r7hY7uAhSkmJgIGoBUgwVY/lnHQpVHA87hTwI51e3uy2qlJ0VDDGDu1Y/sqN?=
 =?us-ascii?Q?NqUllg4w2lX32+nGHbR59A9qWQgtxnW0E0iJxJUWKBPnUi8tRyywMmufN4Zg?=
 =?us-ascii?Q?tA4V9tgzlgrw/hRFNS8AItbfyF0FlysrTKDqwsrFSFhJ2rNUYsC98YWxYmz5?=
 =?us-ascii?Q?ZU6IJYV377XsWkL3ALG2e13AeJv8SukNcyno9vKFvRnn2YRe3SqKwJPE4qBQ?=
 =?us-ascii?Q?abTOVM7RvKcf7olmD0dfczJB4xhUerL+c4gicBYMVdEt2qG1+qjE95ZbzZu1?=
 =?us-ascii?Q?U/oqxvmSPBnkiqAYQK4NfNetLjTRkrs1zURXh0nBS+RQivVkjFQhY4HAHSOT?=
 =?us-ascii?Q?h8yFeBbLIu8GlBLPrDA1k5Ki5PlVnQ+krTP+nLsV98WGyM0Q07uhl4us1WAU?=
 =?us-ascii?Q?pnWITu1fMy8j3zhF9XmAvXi/eBGJhAr040TM4Fmu4UfCjq8PVoXpJeuB3CQ6?=
 =?us-ascii?Q?DVOKyhllmeiBgUpnfa82d8b1niaw7Ey3xv+cuHVsYdK6PQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWXP123MB5267.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1102
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+H13vQhUBWKxTTZjjwj1UcFb1EgpWCHuNZ5IuPE1GoL/3DrwD39B/XgewpCL?=
 =?us-ascii?Q?kyMlgKjGd2he5/Fux7G/66cOy4t8f4coC7OmqnB8/d7ZybrAzsInod4pUwtH?=
 =?us-ascii?Q?LQNDXgTx3FhEopsh9h34eegcXg5u10Wv6ugCei4ACDm9T1rqccJQHo0i7UL/?=
 =?us-ascii?Q?wHqTMppe13usTnNgnkvK4B5AewEkpcWgZyMCMh3T9nNBMjXV//3Z7f2Y3zdH?=
 =?us-ascii?Q?hsseDqULSfSezKg0z+uRQ/vO+ugqV+OqUuDPCKtQkyciWchSnGcjSwg4ukMm?=
 =?us-ascii?Q?3aVDMl2wUMLj2tQraGo+zom5IdTHb0x0kmTnQw3lvms2sAQviTqZZ+/b/nqk?=
 =?us-ascii?Q?ATTfEVvfUUQD6n5OdkTBJMF2PXcILUKOYeVAqCVtaGR7Uyf/Ss2sNevbJQTn?=
 =?us-ascii?Q?Ilh4CApbmz4ZXPss5ljvyaQ3PIIBRuCet4CbBkH5ayUIf+/TkBjQAEpBbcXi?=
 =?us-ascii?Q?i5wkaidHp5tFbGMfQSxxq/sZSh9cUuqSgLy0FWuURnn7P1eHvEkh3ucpAh/i?=
 =?us-ascii?Q?vcwKlOo2nxrMjUdzzObun986sroFbt2TTt9xW68CfobS2Eh7b03xT/54Q1aB?=
 =?us-ascii?Q?L5rD2Z3gxfBeMScvJ5rS9oHFL063wA4VqeujdMVp1tvBBZImX0D2ua3uNKbH?=
 =?us-ascii?Q?EOWn8YJm+NJkDksqE+024kvGaSOT/b+Yox4GuCt/RFyTRkh2O0jlWOkFTLOX?=
 =?us-ascii?Q?Yv4I7FL6EsVMBog66trXJ5vYbYQtPlsD9NebM4BfozkIQA8WOrUpDiJihqsg?=
 =?us-ascii?Q?Y3RiZj6N2J0C25hmNK76tEhTGnZwwlI98YFX06GsCl8Gnb0TpSDttAsf9YWg?=
 =?us-ascii?Q?2unUL767QV3eQTQNXtZNATbMeVnsNjTvySDEY3KA2N43hNQGMf+uznHgLRDY?=
 =?us-ascii?Q?vVuHXgl50M8v98SuLKapop/S7DuNAztS9v8fkHU8YbYJY8nw7X1MPphYcY9Q?=
 =?us-ascii?Q?SrHaHLpgq3noc1EeDQOTJafYitdGICq5QQ9cOGgqSokDVp+qIHxdfrVhJiBF?=
 =?us-ascii?Q?fhsSavT38Uihgl7ngBTe+BGjacxgzt1HK5UDL6z/SPyMg7bys9r8WQLNf5Kh?=
 =?us-ascii?Q?3xuNkfShidnDBK1+o9XP4dYuzbhMKqr+GQB/HB4y1F1YtTkJc3PiiwWAH10r?=
 =?us-ascii?Q?1vJxvivZSIH76qCTGUe2NJBGT+Ve9LN4KdaUnCpGiHCQkKtzoWitboUqXfG9?=
 =?us-ascii?Q?HjGQy62Af67nqz04LiWASY7QrTzF8s3ZNK40sct30Ebd06ZBYYRrd0oSo1rT?=
 =?us-ascii?Q?rmwAGxfU48+30yYmrUjbpEVasRAJbkT27ZSEH1Om7HNnex+EqjVJvYFOJt0V?=
 =?us-ascii?Q?V+cSkTERnG4eZMNPkbMedulsqXWql/sJG1c+j0klfdR+V5FNmHWBf39jbT6C?=
 =?us-ascii?Q?qoa/N8K2wITQbtFf98iGkh8UxuH/eSa2aTZOeO6xwHc2wh4U8leie+Nltjzp?=
 =?us-ascii?Q?hqNH2OfxqCHEo3bmE7vkUmVSq5K2MNNq/5FAO883XEu4IaPGNdJshtwK5yWt?=
 =?us-ascii?Q?oGsUU/GN7BddDIofcVJe0C5INuT+n09NyqcR8UGIb2AeL5D/0vr1QE96j/lb?=
 =?us-ascii?Q?S4v77uwKqCkzZ9HDY1Qh6JN0i3vTWVwdpIXIN7QeyNsICX6dQ7QWFvtS9jwd?=
 =?us-ascii?Q?MMwSKPNHjqppBOfPigFMVf/29VeBf3PIn1Yv937sL6dNWguqzNwE43eMe8rD?=
 =?us-ascii?Q?en+xHw=3D=3D?=
X-OriginatorOrg: camlingroup.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e92461b0-3db7-4599-c89c-08dcc6ae5a76
X-MS-Exchange-CrossTenant-AuthSource: CWXP123MB5267.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 15:38:52.6112
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fd4b1729-b18d-46d2-9ba0-2717b852b252
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3eiv7E4jpHGQIly+003HpOp/QXmKexGRAoL4oDwxq618OYPnDfhy44CEot1rdvYomEvbehGb5IxlvJLjLAuThze3NZGazyxmHuThPSveKok=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP123MB3509
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: camlingroup.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Andy,

W dniu 26.08.2024 o=C2=A019:40, Andy Shevchenko pisze:
> On Mon, Aug 26, 2024 at 05:40:28PM +0200, Lech Perczak wrote:
>> When submitting previous, functional fixes, Tomasz Mo=C5=84 omitted thos=
e
>> two cosmetic patches, that kept lurking in our company tree - likely
>> by oversight. Let's submit them.
>=20
> Reviewed-by: Andy Shevchenko <andy@kernel.org>
>=20
> I haven't looked into the details of the changes, but feels good.
> What you can do to confirm is to run this via C preprocessor and
> show the diff here or assure that it's empty.
>=20

Great tip for checking such changes the correctness.
Up to patch v2 there were no significant changes, as expected, but for patc=
h 3,
diff is quite substantial, due to BIT() being more explicit,
than open-coded constants.

Only the single expansion of GENMASK proves very hard to analyze in the
diff - so I double-checked with a calculator,
though all BIT() expansions do match, as does the updated definition.
of SC16IS7XX_LSR_BRK_ERROR_MASK.

Anyway, for completeness here is the diff in full for completeness. It's hu=
ge=20
and has lines way over 80 characters, but that's how it is.
I obtained inputs for the diff by 'make drivers/tty/serial/sc16is7xx.i'.

46,48c46,80
< # 1 "./include/linux/clk.h" 1
< # 12 "./include/linux/clk.h"
< # 1 "./include/linux/err.h" 1
---
> # 1 "./include/linux/bits.h" 1
>=20
>=20
>=20
>=20
> # 1 "./include/linux/const.h" 1
>=20
>=20
>=20
> # 1 "./include/vdso/const.h" 1
>=20
>=20
>=20
>=20
> # 1 "./include/uapi/linux/const.h" 1
> # 6 "./include/vdso/const.h" 2
> # 5 "./include/linux/const.h" 2
> # 6 "./include/linux/bits.h" 2
> # 1 "./include/vdso/bits.h" 1
> # 7 "./include/linux/bits.h" 2
> # 1 "./include/uapi/linux/bits.h" 1
> # 8 "./include/linux/bits.h" 2
> # 1 "./arch/x86/include/uapi/asm/bitsperlong.h" 1
> # 11 "./arch/x86/include/uapi/asm/bitsperlong.h"
> # 1 "./include/asm-generic/bitsperlong.h" 1
>=20
>=20
>=20
>=20
> # 1 "./include/uapi/asm-generic/bitsperlong.h" 1
> # 6 "./include/asm-generic/bitsperlong.h" 2
> # 12 "./arch/x86/include/uapi/asm/bitsperlong.h" 2
> # 9 "./include/linux/bits.h" 2
> # 22 "./include/linux/bits.h"
> # 1 "./include/linux/build_bug.h" 1
99,117c131
< # 12 "./include/uapi/asm-generic/int-ll64.h"
< # 1 "./arch/x86/include/uapi/asm/bitsperlong.h" 1
< # 11 "./arch/x86/include/uapi/asm/bitsperlong.h"
< # 1 "./include/asm-generic/bitsperlong.h" 1
<=20
<=20
<=20
<=20
< # 1 "./include/uapi/asm-generic/bitsperlong.h" 1
< # 6 "./include/asm-generic/bitsperlong.h" 2
< # 12 "./arch/x86/include/uapi/asm/bitsperlong.h" 2
< # 13 "./include/uapi/asm-generic/int-ll64.h" 2
<=20
<=20
<=20
<=20
<=20
<=20
<=20
---
> # 20 "./include/uapi/asm-generic/int-ll64.h"
534c548,558
< # 6 "./include/linux/err.h" 2
---
> # 6 "./include/linux/build_bug.h" 2
> # 23 "./include/linux/bits.h" 2
> # 14 "drivers/tty/serial/sc16is7xx.c" 2
> # 1 "./include/linux/clk.h" 1
> # 12 "./include/linux/clk.h"
> # 1 "./include/linux/err.h" 1
>=20
>=20
>=20
>=20
>=20
608,624d631
<=20
<=20
<=20
<=20
< # 1 "./include/linux/const.h" 1
<=20
<=20
<=20
< # 1 "./include/vdso/const.h" 1
<=20
<=20
<=20
<=20
< # 1 "./include/uapi/linux/const.h" 1
< # 6 "./include/vdso/const.h" 2
< # 5 "./include/linux/const.h" 2
< # 6 "./include/linux/align.h" 2
706,711d712
<=20
<=20
<=20
<=20
< # 1 "./include/linux/build_bug.h" 1
< # 6 "./include/linux/container_of.h" 2
720,721d720
< # 1 "./include/linux/bits.h" 1
<=20
723,730d721
<=20
<=20
<=20
< # 1 "./include/vdso/bits.h" 1
< # 7 "./include/linux/bits.h" 2
< # 1 "./include/uapi/linux/bits.h" 1
< # 8 "./include/linux/bits.h" 2
< # 7 "./include/linux/bitops.h" 2
21426c21417
< # 14 "drivers/tty/serial/sc16is7xx.c" 2
---
> # 15 "drivers/tty/serial/sc16is7xx.c" 2
21491c21482
< # 15 "drivers/tty/serial/sc16is7xx.c" 2
---
> # 16 "drivers/tty/serial/sc16is7xx.c" 2
48375c48366
< # 16 "drivers/tty/serial/sc16is7xx.c" 2
---
> # 17 "drivers/tty/serial/sc16is7xx.c" 2
53866c53857
< # 18 "drivers/tty/serial/sc16is7xx.c" 2
---
> # 19 "drivers/tty/serial/sc16is7xx.c" 2
54000c53991
< # 20 "drivers/tty/serial/sc16is7xx.c" 2
---
> # 21 "drivers/tty/serial/sc16is7xx.c" 2
54680c54671
< # 24 "drivers/tty/serial/sc16is7xx.c" 2
---
> # 25 "drivers/tty/serial/sc16is7xx.c" 2
62770c62761
< # 26 "drivers/tty/serial/sc16is7xx.c" 2
---
> # 27 "drivers/tty/serial/sc16is7xx.c" 2
62833c62824
< # 30 "drivers/tty/serial/sc16is7xx.c" 2
---
> # 31 "drivers/tty/serial/sc16is7xx.c" 2
62904c62895
< # 32 "drivers/tty/serial/sc16is7xx.c" 2
---
> # 33 "drivers/tty/serial/sc16is7xx.c" 2
62934,62935c62925,62926
< # 34 "drivers/tty/serial/sc16is7xx.c" 2
< # 315 "drivers/tty/serial/sc16is7xx.c"
---
> # 35 "drivers/tty/serial/sc16is7xx.c" 2
> # 320 "drivers/tty/serial/sc16is7xx.c"
63029,63030c63020,63021
<          (1 << 4),
<          on ? 0 : (1 << 4));
---
>          ((((1UL))) << (4)),
>          on ? 0 : ((((1UL))) << (4)));
63032c63023
< # 426 "drivers/tty/serial/sc16is7xx.c"
---
> # 431 "drivers/tty/serial/sc16is7xx.c"
63069c63060
<  one->config.flags |=3D (1 << 1);
---
>  one->config.flags |=3D ((((1UL))) << (1));
63082c63073
<  one->config.flags |=3D (1 << 1);
---
>  one->config.flags |=3D ((((1UL))) << (1));
63090c63081
<  sc16is7xx_ier_clear(port, (1 << 1));
---
>  sc16is7xx_ier_clear(port, ((((1UL))) << (1)));
63095c63086
<  sc16is7xx_ier_clear(port, (1 << 0));
---
>  sc16is7xx_ier_clear(port, ((((1UL))) << (0)));
63164c63155
< # 570 "drivers/tty/serial/sc16is7xx.c"
---
> # 575 "drivers/tty/serial/sc16is7xx.c"
63180,63181c63171,63172
<          (1 << 4),
<          (1 << 4));
---
>          ((((1UL))) << (4)),
>          ((((1UL))) << (4)));
63186,63187c63177,63178
<          (1 << 7),
<          prescaler =3D=3D 1 ? 0 : (1 << 7));
---
>          ((((1UL))) << (7)),
>          prescaler =3D=3D 1 ? 0 : ((((1UL))) << (7)));
63192c63183
<         (1 << 7));
---
>         ((((1UL))) << (7)));
63227c63218
<    if (!(lsr & (1 << 7)))
---
>    if (!(lsr & ((((1UL))) << (7))))
63240c63231
<   lsr &=3D 0x1E;
---
>   lsr &=3D (((((1UL))) << (1)) | ((((1UL))) << (2)) | ((((1UL))) << (3)) =
| ((((1UL))) << (4)));
63246c63237
<    if (lsr & (1 << 4)) {
---
>    if (lsr & ((((1UL))) << (4))) {
63250c63241
<    } else if (lsr & (1 << 2))
---
>    } else if (lsr & ((((1UL))) << (2)))
63252c63243
<    else if (lsr & (1 << 3))
---
>    else if (lsr & ((((1UL))) << (3)))
63254c63245
<    else if (lsr & (1 << 1))
---
>    else if (lsr & ((((1UL))) << (1)))
63258c63249
<    if (lsr & (1 << 4))
---
>    if (lsr & ((((1UL))) << (4)))
63260c63251
<    else if (lsr & (1 << 2))
---
>    else if (lsr & ((((1UL))) << (2)))
63262c63253
<    else if (lsr & (1 << 3))
---
>    else if (lsr & ((((1UL))) << (3)))
63264c63255
<    else if (lsr & (1 << 1))
---
>    else if (lsr & ((((1UL))) << (1)))
63276c63267
<    uart_insert_char(port, lsr, (1 << 1), ch,
---
>    uart_insert_char(port, lsr, ((((1UL))) << (1)), ch,
63325c63316
<   sc16is7xx_ier_set(port, (1 << 1));
---
>   sc16is7xx_ier_set(port, ((((1UL))) << (1)));
63334,63337c63325,63328
<  mctrl |=3D (msr & (1 << 4)) ? 0x020 : 0;
<  mctrl |=3D (msr & (1 << 5)) ? 0x100 : 0;
<  mctrl |=3D (msr & (1 << 7)) ? 0x040 : 0;
<  mctrl |=3D (msr & (1 << 6)) ? 0x080 : 0;
---
>  mctrl |=3D (msr & ((((1UL))) << (4))) ? 0x020 : 0;
>  mctrl |=3D (msr & ((((1UL))) << (5))) ? 0x100 : 0;
>  mctrl |=3D (msr & ((((1UL))) << (7))) ? 0x040 : 0;
>  mctrl |=3D (msr & ((((1UL))) << (6))) ? 0x080 : 0;
63381c63372
<  if (iir & (1 << 0)) {
---
>  if (iir & 0x01) {
63386c63377
<  iir &=3D 0x3e;
---
>  iir &=3D ((((int)(sizeof(struct { int:(-!!(__builtin_choose_expr( (sizeo=
f(int) =3D=3D sizeof(*(8 ? ((void *)((long)((1) > (5)) * 0l)) : (int *)8)))=
, (1) > (5), 0))); })))) + (((~((0UL))) - (((1UL)) << (1)) + 1) & (~((0UL))=
 >> (64 - 1 - (5)))));
63394c63385
< # 808 "drivers/tty/serial/sc16is7xx.c"
---
> # 813 "drivers/tty/serial/sc16is7xx.c"
63456,63457c63447,63448
<  const u32 mask =3D (1 << 4) |
<     (1 << 5);
---
>  const u32 mask =3D ((((1UL))) << (4)) |
>     ((((1UL))) << (5));
63464c63455
<   efcr |=3D (1 << 4);
---
>   efcr |=3D ((((1UL))) << (4));
63467c63458
<    efcr |=3D (1 << 5);
---
>    efcr |=3D ((((1UL))) << (5));
63485c63476
<  if (config.flags & (1 << 0)) {
---
>  if (config.flags & ((((1UL))) << (0))) {
63490c63481
<    mcr |=3D (1 << 1);
---
>    mcr |=3D ((((1UL))) << (1));
63493c63484
<    mcr |=3D (1 << 0);
---
>    mcr |=3D ((((1UL))) << (0));
63496c63487
<    mcr |=3D (1 << 4);
---
>    mcr |=3D ((((1UL))) << (4));
63498,63500c63489,63491
<           (1 << 1) |
<           (1 << 0) |
<           (1 << 4),
---
>           ((((1UL))) << (1)) |
>           ((((1UL))) << (0)) |
>           ((((1UL))) << (4)),
63504c63495
<  if (config.flags & (1 << 1))
---
>  if (config.flags & ((((1UL))) << (1)))
63508c63499
<  if (config.flags & (1 << 2))
---
>  if (config.flags & ((((1UL))) << (2)))
63554c63545
<  sc16is7xx_ier_clear(port, (1 << 0));
---
>  sc16is7xx_ier_clear(port, ((((1UL))) << (0)));
63563c63554
<  sc16is7xx_ier_set(port, (1 << 0));
---
>  sc16is7xx_ier_set(port, ((((1UL))) << (0)));
63573c63564
<  return (lsr & (1 << 6)) ? 0x01 : 0;
---
>  return (lsr & ((((1UL))) << (6))) ? 0x01 : 0;
63589c63580
<  one->config.flags |=3D (1 << 0);
---
>  one->config.flags |=3D ((((1UL))) << (0));
63596,63597c63587,63588
<          (1 << 6),
<          break_state ? (1 << 6) : 0);
---
>          ((((1UL))) << (6)),
>          break_state ? ((((1UL))) << (6)) : 0);
63637c63628
<   lcr |=3D (1 << 3);
---
>   lcr |=3D ((((1UL))) << (3));
63639c63630
<    lcr |=3D (1 << 4);
---
>    lcr |=3D ((((1UL))) << (4));
63644c63635
<   lcr |=3D (1 << 2);
---
>   lcr |=3D ((((1UL))) << (2));
63647c63638
<  port->read_status_mask =3D (1 << 1);
---
>  port->read_status_mask =3D ((((1UL))) << (1));
63649,63650c63640,63641
<   port->read_status_mask |=3D (1 << 2) |
<        (1 << 3);
---
>   port->read_status_mask |=3D ((((1UL))) << (2)) |
>        ((((1UL))) << (3));
63652c63643
<   port->read_status_mask |=3D (1 << 4);
---
>   port->read_status_mask |=3D ((((1UL))) << (4));
63657c63648
<   port->ignore_status_mask |=3D (1 << 4);
---
>   port->ignore_status_mask |=3D ((((1UL))) << (4));
63659c63650
<   port->ignore_status_mask |=3D 0x1E;
---
>   port->ignore_status_mask |=3D (((((1UL))) << (1)) | ((((1UL))) << (2)) =
| ((((1UL))) << (3)) | ((((1UL))) << (4)));
63664,63665c63655,63656
<   flow |=3D (1 << 7) |
<    (1 << 6);
---
>   flow |=3D ((((1UL))) << (7)) |
>    ((((1UL))) << (6));
63669c63660
<   flow |=3D (1 << 3);
---
>   flow |=3D ((((1UL))) << (3));
63671c63662
<   flow |=3D (1 << 1);
---
>   flow |=3D ((((1UL))) << (1));
63681c63672
<          ((1 << 6) | (1 << 7) | (1 << 5) | (1 << 3) | (1 << 2) | (1 << 1)=
 | (1 << 0)), flow);
---
>          (((((1UL))) << (6)) | ((((1UL))) << (7)) | ((((1UL))) << (5)) | =
((((1UL))) << (3)) | ((((1UL))) << (2)) | ((((1UL))) << (1)) | ((((1UL))) <=
< (0))), flow);
63719c63710
<  one->config.flags |=3D (1 << 2);
---
>  one->config.flags |=3D ((((1UL))) << (2));
63734c63725
<  val =3D (1 << 1) | (1 << 2);
---
>  val =3D ((((1UL))) << (1)) | ((((1UL))) << (2));
63738c63729
<         (1 << 0));
---
>         ((((1UL))) << (0)));
63748,63749c63739,63740
<          (1 << 4),
<          (1 << 4));
---
>          ((((1UL))) << (4)),
>          ((((1UL))) << (4)));
63753,63754c63744,63745
<          (1 << 2),
<          (1 << 2));
---
>          ((((1UL))) << (2)),
>          ((((1UL))) << (2)));
63770c63761
<          (1 << 6),
---
>          ((((1UL))) << (6)),
63772c63763
<     (1 << 6) : 0);
---
>     ((((1UL))) << (6)) : 0);
63776,63777c63767,63768
<          (1 << 1) |
<          (1 << 2),
---
>          ((((1UL))) << (1)) |
>          ((((1UL))) << (2)),
63781,63782c63772,63773
<  val =3D (1 << 0) | (1 << 7) |
<        (1 << 3);
---
>  val =3D ((((1UL))) << (0)) | ((((1UL))) << (7)) |
>        ((((1UL))) << (3));
63804,63807c63795,63798
<          (1 << 1) |
<          (1 << 2),
<          (1 << 1) |
<          (1 << 2));
---
>          ((((1UL))) << (1)) |
>          ((((1UL))) << (2)),
>          ((((1UL))) << (1)) |
>          ((((1UL))) << (2)));
63876c63867
< # 1400 "drivers/tty/serial/sc16is7xx.c"
---
> # 1405 "drivers/tty/serial/sc16is7xx.c"
63926c63917
<    s->mctrl_mask |=3D (1 << 1);
---
>    s->mctrl_mask |=3D ((((1UL))) << (1));
63928c63919
<    s->mctrl_mask |=3D (1 << 2);
---
>    s->mctrl_mask |=3D ((((1UL))) << (2));
63935,63936c63926,63927
<    (1 << 1) |
<    (1 << 2), s->mctrl_mask);
---
>    ((((1UL))) << (1)) |
>    ((((1UL))) << (2)), s->mctrl_mask);
63960c63951
< # 1493 "drivers/tty/serial/sc16is7xx.c"
---
> # 1498 "drivers/tty/serial/sc16is7xx.c"
64009c64000
<        (1 << 3));
---
>        ((((1UL))) << (3)));
64056,64057c64047,64048
<          (1 << 1) |
<          (1 << 2));
---
>          ((((1UL))) << (1)) |
>          ((((1UL))) << (2)));
64079c64070
<          (1 << 4));
---
>          ((((1UL))) << (4)));
64095c64086
< # 1640 "drivers/tty/serial/sc16is7xx.c"
---
> # 1645 "drivers/tty/serial/sc16is7xx.c"
64188c64179
<   ({ int __ret_warn_on =3D !!(true); if (__builtin_expect(!!(__ret_warn_o=
n), 0)) do { __auto_type __flags =3D (1 << 0)|(((9) << 8)); ({ asm volatile=
("406" ": nop\n\t" ".pushsection .discard.instr_begin\n\t" ".long " "406" "=
b - .\n\t" ".popsection\n\t" : : "i" (406)); }); do { asm __inline volatile=
("1:\t" ".byte 0x0f, 0x0b" "\n" ".pushsection __bug_table,\"aw\"\n" "2:\t" =
".long " "1b" " - ." "\t# bug_entry::bug_addr\n" "\t" ".long " "%c0" " - ."=
 "\t# bug_entry::file\n" "\t.word %c1" "\t# bug_entry::line\n" "\t.word %c2=
" "\t# bug_entry::flags\n" "\t.org 2b+%c3\n" ".popsection\n" "998:\n\t" ".p=
ushsection .discard.reachable\n\t" ".long 998b\n\t" ".popsection\n\t" : : "=
i" ("drivers/tty/serial/sc16is7xx.c"), "i" (1732), "i" (__flags), "i" (size=
of(struct bug_entry))); } while (0); ({ asm volatile("407" ": nop\n\t" ".pu=
shsection .discard.instr_end\n\t" ".long " "407" "b - .\n\t" ".popsection\n=
\t" : : "i" (407)); }); } while (0); __builtin_expect(!!(__ret_warn_on), 0)=
; });
---
>   ({ int __ret_warn_on =3D !!(true); if (__builtin_expect(!!(__ret_warn_o=
n), 0)) do { __auto_type __flags =3D (1 << 0)|(((9) << 8)); ({ asm volatile=
("406" ": nop\n\t" ".pushsection .discard.instr_begin\n\t" ".long " "406" "=
b - .\n\t" ".popsection\n\t" : : "i" (406)); }); do { asm __inline volatile=
("1:\t" ".byte 0x0f, 0x0b" "\n" ".pushsection __bug_table,\"aw\"\n" "2:\t" =
".long " "1b" " - ." "\t# bug_entry::bug_addr\n" "\t" ".long " "%c0" " - ."=
 "\t# bug_entry::file\n" "\t.word %c1" "\t# bug_entry::line\n" "\t.word %c2=
" "\t# bug_entry::flags\n" "\t.org 2b+%c3\n" ".popsection\n" "998:\n\t" ".p=
ushsection .discard.reachable\n\t" ".long 998b\n\t" ".popsection\n\t" : : "=
i" ("drivers/tty/serial/sc16is7xx.c"), "i" (1737), "i" (__flags), "i" (size=
of(struct bug_entry))); } while (0); ({ asm volatile("407" ": nop\n\t" ".pu=
shsection .discard.instr_end\n\t" ".long " "407" "b - .\n\t" ".popsection\n=
\t" : : "i" (407)); }); } while (0); __builtin_expect(!!(__ret_warn_on), 0)=
; });
64205c64196
< static void * __attribute__((__used__)) __attribute__((__section__(".disc=
ard.addressable"))) __UNIQUE_ID___addressable_sc16is7xx_init411 =3D (void *=
)(uintptr_t)&sc16is7xx_init; asm(".section=09\"" ".initcall6" ".init" "\", =
\"a\"=09=09\n" "__initcall__kmod_sc16is7xx__410_1749_sc16is7xx_init6" ":=09=
=09=09\n" ".long=09" "sc16is7xx_init" " - .=09\n" ".previous=09=09=09=09=09=
\n"); _Static_assert(__builtin_types_compatible_p(typeof(initcall_t), typeo=
f(&sc16is7xx_init)), "__same_type(initcall_t, &sc16is7xx_init)");;;
---
> static void * __attribute__((__used__)) __attribute__((__section__(".disc=
ard.addressable"))) __UNIQUE_ID___addressable_sc16is7xx_init411 =3D (void *=
)(uintptr_t)&sc16is7xx_init; asm(".section=09\"" ".initcall6" ".init" "\", =
\"a\"=09=09\n" "__initcall__kmod_sc16is7xx__410_1754_sc16is7xx_init6" ":=09=
=09=09\n" ".long=09" "sc16is7xx_init" " - .=09\n" ".previous=09=09=09=09=09=
\n"); _Static_assert(__builtin_types_compatible_p(typeof(initcall_t), typeo=
f(&sc16is7xx_init)), "__same_type(initcall_t, &sc16is7xx_init)");;;


--=20
Pozdrawiam/With kind regards,
Lech Perczak

Sr. Software Engineer
Camlin Technologies Poland Limited Sp. z o.o.

