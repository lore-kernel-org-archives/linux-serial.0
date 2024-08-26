Received: from eu-smtp-delivery-197.mimecast.com (eu-smtp-delivery-197.mimecast.com [185.58.85.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27EED13DDD9
	for <linux-serial@vger.kernel.org>; Mon, 26 Aug 2024 12:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724675751; cv=none; b=CeLMZ25fboxY/fpRcHAIUj88UdmQsKZBadqPCgXRNkMCYnzf1Nm4dS7UT5uoegbhMM16cZ5RqMDHcq6HA1alPhzgUCEox2QduZzD/KmwpSWuM/pVfzEFsqsmY2tXpedGlsDCwkd/pzkJjVVld9Mu2r23sLdd3zyq3hxYOu/FeMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724675751; c=relaxed/simple;
	bh=EQVwB9N+w6vdH0vDgDXf4WFksXc+20mnlpn2jrGswa0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 MIME-Version:Content-Type; b=uMC9XyyCG6Nkuc0h3ctNbr72xGG89FTo34iZT8ndGPbeR9sDXVmM2O3F7RdIjUkHAq0/RkFKJJles9zDgE4XUJkoSsg7nDam7Clul7A5PSRU+w0YxnrNOwMOA+6xiJyKK/tjRL0ujmCMJj0+I0v5+q3K7IxrHMPlJtOuBzF2HBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=camlingroup.com; spf=pass smtp.mailfrom=camlingroup.com; dkim=pass (1024-bit key) header.d=camlingroup.com header.i=@camlingroup.com header.b=iya35wF5; arc=none smtp.client-ip=185.58.85.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=camlingroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=camlingroup.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=camlingroup.com header.i=@camlingroup.com header.b="iya35wF5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=camlingroup.com;
	s=mimecast20210310; t=1724675742;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OgqRTSzt3bTWzQid5H2iYIiMOjzliWxrosTp2hKNVlY=;
	b=iya35wF5cKDgBfAQjDnVIhcb83aB3z0cnMspHeliumfNHmk+BjhPDQAWfGkBAUHAwFM9+Q
	I7Zn6UfpFoSUnfDFoduSU3K0AA5hu7BNfFibLyrLGP+r7kXIGctrfOhZ7mYZ+8vaXW3yQ+
	mqnFAGFTQfcNv+RWNvSeZWpYekaRXqY=
Received: from GBR01-CWX-obe.outbound.protection.outlook.com
 (mail-cwxgbr01lp2048.outbound.protection.outlook.com [104.47.85.48]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 uk-mta-60-Em8GJ90vPXmuUH7oIlvTwg-1; Mon, 26 Aug 2024 13:35:41 +0100
X-MC-Unique: Em8GJ90vPXmuUH7oIlvTwg-1
Received: from CWXP123MB5267.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:142::9)
 by LO0P123MB5968.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:242::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Mon, 26 Aug
 2024 12:35:39 +0000
Received: from CWXP123MB5267.GBRP123.PROD.OUTLOOK.COM
 ([fe80::f866:62f9:716e:ca4f]) by CWXP123MB5267.GBRP123.PROD.OUTLOOK.COM
 ([fe80::f866:62f9:716e:ca4f%4]) with mapi id 15.20.7897.021; Mon, 26 Aug 2024
 12:35:39 +0000
Message-ID: <5d1f5d01-c7ab-49f9-b754-1c32043668c5@camlingroup.com>
Date: Mon, 26 Aug 2024 14:35:37 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] serial: sc16is7xx: convert bitmask definitions to
 use BIT() macro
To: Andy Shevchenko <andy.shevchenko@gmail.com>
CC: linux-serial@vger.kernel.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Hugo Villeneuve
 <hvilleneuve@dimonoff.com>, Andy Shevchenko <andy@kernel.org>,
 =?UTF-8?Q?Krzysztof_Drobi=C5=84ski?= <k.drobinski@camlintechnologies.com>,
 =?UTF-8?Q?Pawe=C5=82_Lenkow?= <pawel.lenkow@camlingroup.com>,
 Kirill Yatsenko <kirill.yatsenko@camlingroup.com>
References: <7deb753f-bf86-47ce-89bf-8277aca4293e@camlingroup.com>
 <fbd8debf-46ab-407a-beda-43e083bffee7@camlingroup.com>
 <CAHp75VeqOV7GEqMs6fMi2Fax-97zt+ykEXaptng=pi_BDKU5Bg@mail.gmail.com>
From: Lech Perczak <lech.perczak@camlingroup.com>
In-Reply-To: <CAHp75VeqOV7GEqMs6fMi2Fax-97zt+ykEXaptng=pi_BDKU5Bg@mail.gmail.com>
X-ClientProxiedBy: BE0P281CA0006.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:a::16) To CWXP123MB5267.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:142::9)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWXP123MB5267:EE_|LO0P123MB5968:EE_
X-MS-Office365-Filtering-Correlation-Id: b7ee0871-fa4b-4a10-233c-08dcc5cb97c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8HQbo+yzXUPnL+YBk0xuEU8uDYZazr/95eKenNun1vEqlu+s/GyynhMkEN5O?=
 =?us-ascii?Q?JWPAI7OgviI/vb9aSdJYz8j/XjnascJR1TOuf04BZLNn9DDcNnR4XVdcVXET?=
 =?us-ascii?Q?Iv1EG7guB+2Aq0VqjJKh/ExlwuNlnJfL3I1DHM+LwqS1XhJgu5uYjdizLy6H?=
 =?us-ascii?Q?NNLFRnlcrsxjIwkWO/xgKNKTSxJ9xayS02iukhczHAcw3KPDlUOsHYYgSKhI?=
 =?us-ascii?Q?+GwgrB8TcSmHGSUWsy1ge4bIm89ygMa14o4gN/Ru0EdBopMrpEiFP8ZEZbTR?=
 =?us-ascii?Q?EccIFyfVlVyd08EK87ITbcBh6haYrxFv0IJXpzpicnn+PJ4xItNUUKj+gWfE?=
 =?us-ascii?Q?d4/vTpz2Kjbo52apv5kNwGNzzCXplW0iAq1XoFMC9XT8oANJQQivyyT8+XaG?=
 =?us-ascii?Q?Nyt1OaRXbh7Vk4vS7ilfbB76EqXSXdaPWIrXVpr9+MvKTi8JQ3xBUuVTD02Z?=
 =?us-ascii?Q?x2xnRI8uH5gtQk3nJ0D5h9XJHLil8oEv1Mw3lximW0gHgLVpuC2YAu5nG0FJ?=
 =?us-ascii?Q?v55IJnUcP56SKnZs1ShMV6CqNunmLtYFitcUkfoKbJlaJgy4jqhQ47YJHkSL?=
 =?us-ascii?Q?ewfI2WzneQ+8BCf9XRXk3yeehFGfeRLSzWbSs6SnTX4Pcp0PTAiFFlsKJAMG?=
 =?us-ascii?Q?tlKb8FHvTUzppUnLer0s0J1X1PiWyOHk9BJ67DOYvhKCfi6T1X8y52Aw4dkF?=
 =?us-ascii?Q?Y4l2ZujHJkS4cNPkBcdxsNHYGVXKIilKVUNiuIa7fdGYERWrJ5Vb990HDSpY?=
 =?us-ascii?Q?wTPh5TzTHPEj5ZMoWB348eeqpieqs+GQQGGhgVNvrgRSpFvLamdtTHF/7ch0?=
 =?us-ascii?Q?9QOomc6ny75H0wTYQVENurcCbIbtnM/RCO9sMt7AVerItmip5UKDPSHZBO1x?=
 =?us-ascii?Q?K7VXOU5lnOpJ/igfFT/Z7yqOj7JnTe80gLReQtLCMyQDXKACileZzFAiZqZh?=
 =?us-ascii?Q?bAFhCYh6D3LhvLStWM2VP01JCjVHjs1FT4vr+ooOY0gvipPLzC2+FtwljRaE?=
 =?us-ascii?Q?mQS8gGw39kG84Rcpz3YmRNUOoKk4JpFrf6aLiHdF3H6k+pK1SxZJjIestGE8?=
 =?us-ascii?Q?aC7NFXFvWG4I2hge1vj6wy8QYdXTouOnLIzJ7F1aATXkevb6khm5HEWp9wIg?=
 =?us-ascii?Q?QvhmhQ80qxvbV31faN2yw0Z1R14ioOyHTyLf92GtL9LNkFcQFklN7/npTSHl?=
 =?us-ascii?Q?GywjNn7UHLj6PQgsPMlNn6xPQn207FK0IAxIvAyj4Bb82FVOyvxfgFjQ/bKG?=
 =?us-ascii?Q?1gkF4wwWqYhVWok0s7WBWsYd+3OrDl1Api7ZdM127qAVGhj9+VcHz/MlEVxJ?=
 =?us-ascii?Q?9EaZPKRw7U7ctly5/U+itND3yknwvHtOfNZFvdrcGznHNQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWXP123MB5267.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1102
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/8NuOxm4KDZO+YimLN/Mg8X4u81Q36KXLS3uv6mk5y3a0vWFZU2AGrBVUtX2?=
 =?us-ascii?Q?vA+YOn+QyT4bV5rzKBmd+tecYDKOVJVn4yZoXtoMaQNT/PlxGovnB9vU9vX7?=
 =?us-ascii?Q?+oX38O1rQnHOpzF2L1poCzxHODyqDEe/m9URUtl+qmvdPjZKvaipQ0V3tpNQ?=
 =?us-ascii?Q?UI1VXT9dubHL2k2RX/+19eIYn7DHnzCCSdpgsVdSyL6EWuyPzIjjhj8W4C2F?=
 =?us-ascii?Q?g6SksBtx+zg2BiDA4cczk9o418NMZQFUHacO5Vq2Ac2kNJSlXHJ0f3S8r7iP?=
 =?us-ascii?Q?GXpU/tDSnswwkZ5/YloQgEFyLxT7YN/LUYCYV1ZocUWinv2A2LjIriiRQo0L?=
 =?us-ascii?Q?LUKaGFhJZM5RO8SGmwsn/uRg3awFS+lA5u3RVvPzXN1aNCTDoDO4SHDKe7Ox?=
 =?us-ascii?Q?JCQIg5BKDpVb2YxNITXspZ8merb/sgLj9gPVcuVnEiJxNLKMCgk6cqAD6ja0?=
 =?us-ascii?Q?NLHGt3jVOWo94E/HDThA/I4AMoenKgNU4s+rOTsK6IYNV13FM/DINW5qUncQ?=
 =?us-ascii?Q?l0etJoNiIoJNk0XbVDkDCF39lmJh0Sv/eY6Xc0rbhCKhTvvYjRQbr69golOt?=
 =?us-ascii?Q?QWEPK8pMa2wUzQdxU2ImEuDNH625pgqCW17E+4wVfJJctXEBhXowXw+FWa45?=
 =?us-ascii?Q?RWQ8ZzuAs7aw020VUwTMZf64JPimFK9lhiEVkfMCU9ebGZ0WAzTObl9gdsLx?=
 =?us-ascii?Q?P0VQBI82Y23rLjEejei7wo/dI3ZJ8vJIR2uvK7ULs+SnJeK/QsDwjPG1+2eJ?=
 =?us-ascii?Q?dV9KQkhU78XfUHCRymQ4c0xrjiWVKkyFNyV/gk+PI6Xx6faPS9nFxpcSGsAI?=
 =?us-ascii?Q?QnNXChgPC+SteURntXeE+e8mECB8821m6ORJM5gMnGmT8klBmt/jxz1P+FpO?=
 =?us-ascii?Q?kxWM8I8vK8fU7jc9UR8jQ4eI2FjEhbZ2th0X/6KacaGANM8/zkOSxFPPhODg?=
 =?us-ascii?Q?7Tf+fb0tYNIdxL+GpyX/7MjM8DKano0V5J3CwRcW6oEQ9VafqyK+X7hqYkH5?=
 =?us-ascii?Q?XBPG+RbeqavqVcOLglR1jbPTlwCj8xahhOl1fCnqO9iGPJ1qD1FO9ISMgLI2?=
 =?us-ascii?Q?sm2Qv2xT8OakSN+gW0oeJDYE+UmzPv9ZKS02haUeJsWyppzMMPmLb1l/b1HI?=
 =?us-ascii?Q?5nwbWibZPHDoiALsLwb0Jz5qS2iAb9NcpnUEy1ml9xxxqZpOSc9xnQ5D4mSp?=
 =?us-ascii?Q?SsmHX4REwel7lsU4lC8K6AJhD0pZfWNQLpc5O/OL9HL1KR+jyQ0u3/2361W9?=
 =?us-ascii?Q?pH+BSZziQrAYJVoN3LK3E/UvfeBa5T1+COV7Lz8FP0zvsQgruVg075loB5FV?=
 =?us-ascii?Q?MsZtM4qvvsiE6yjOgoi9JR7bKyfxtC9oPn/C/ErYlytxlNjVrQNqN/bG4072?=
 =?us-ascii?Q?5t+OL+WLjzV0FqsqD29X0Pvrdb/Z/k1IBQQkjNDzZxI85Ay3hUbNLLeTn39C?=
 =?us-ascii?Q?9dZQi1zR2FCkgaDbWOGlPxCJfI9p+Yhhn7aMnUhG2ahoik1Ed0u7oSmtwg6j?=
 =?us-ascii?Q?zLOpe6/SY3Do30xSN87k6Sr5ov/9TAZ2bzn8/4qD/lUES1nUavFme1xNO2zH?=
 =?us-ascii?Q?Det7fzFbddK4INFSKUvVs1dkcDXWPT+EBmrHaNVj21WMnTLDCAXX4sq1JFih?=
 =?us-ascii?Q?7w=3D=3D?=
X-OriginatorOrg: camlingroup.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7ee0871-fa4b-4a10-233c-08dcc5cb97c2
X-MS-Exchange-CrossTenant-AuthSource: CWXP123MB5267.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 12:35:39.7035
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fd4b1729-b18d-46d2-9ba0-2717b852b252
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LLE7EqKX7gKCFvvFjGBr/U3hvVb4YDlTWjrjVY8eCCaSFA08vtrrCQy54QP/a1AXGUEOFJNUtLpGfwR0m1eTGkXPRdyk50RtqntR8SaSQpQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P123MB5968
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: camlingroup.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Andy,

Thanks for thorough review.

W dniu 23.08.2024 o=C2=A019:58, Andy Shevchenko pisze:
> On Fri, Aug 23, 2024 at 7:55=E2=80=AFPM Lech Perczak
> <lech.perczak@camlingroup.com> wrote:
>>
>> Now that bit definition comments were cleaned up, convert bitmask
>> definitions to use BIT() macro for clarity.
>> Convert SC16IS7XX_IIR_* bitmask constants, to use GENMASK() macro, where
>> applicable - while at that, realign comments.
>> Compose SC16IS7XX_LSR_BRK_ERROR_MASK using aforementioned constants,
>> instead of open-coding it, and remove now unneeded comment.
>=20
> comments

Noted.

>=20
> ...
>=20
>>  /* IIR register bits */
>> -#define SC16IS7XX_IIR_NO_INT_BIT       (1 << 0) /* No interrupts pendin=
g */
>> -#define SC16IS7XX_IIR_ID_MASK          0x3e     /* Mask for the interru=
pt ID */
>> -#define SC16IS7XX_IIR_THRI_SRC         0x02     /* TX holding register =
empty */
>> -#define SC16IS7XX_IIR_RDI_SRC          0x04     /* RX data interrupt */
>> -#define SC16IS7XX_IIR_RLSE_SRC         0x06     /* RX line status error=
 */
>> -#define SC16IS7XX_IIR_RTOI_SRC         0x0c     /* RX time-out interrup=
t */
>> -#define SC16IS7XX_IIR_MSI_SRC          0x00     /* Modem status interru=
pt
>> -                                                 * - only on 75x/76x
>> -                                                 */
>> -#define SC16IS7XX_IIR_INPIN_SRC                0x30     /* Input pin ch=
ange of state
>> -                                                 * - only on 75x/76x
>> -                                                 */
>> -#define SC16IS7XX_IIR_XOFFI_SRC                0x10     /* Received Xof=
f */
>> -#define SC16IS7XX_IIR_CTSRTS_SRC       0x20     /* nCTS,nRTS change of =
state
>> -                                                 * from active (LOW)
>> -                                                 * to inactive (HIGH)
>> -                                                 */
>> +#define SC16IS7XX_IIR_NO_INT_BIT       BIT(0)          /* No interrupts=
 pending */
>=20
>> +#define SC16IS7XX_IIR_ID_MASK          GENMASK(5,1)    /* Mask for the =
interrupt ID */
>=20
> This is okay, but the rest of the bit combinations are better to have
> to be plain numbers as usually they are listed in this way in the
> datasheets. Note as well that 0x00 is a valid value which you can't
> express using BIT() or GENMASK() (and this is usually the main point
> to *not* convert them to these macros).
>=20
>> +#define SC16IS7XX_IIR_THRI_SRC         BIT(1)          /* TX holding re=
gister empty */
>> +#define SC16IS7XX_IIR_RDI_SRC          BIT(2)          /* RX data inter=
rupt */
>> +#define SC16IS7XX_IIR_RLSE_SRC         GENMASK(2,1)    /* RX line statu=
s error */
>> +#define SC16IS7XX_IIR_RTOI_SRC         GENMASK(3,2)    /* RX time-out i=
nterrupt */
>> +#define SC16IS7XX_IIR_MSI_SRC          0x00            /* Modem status =
interrupt
>> +                                                        * - only on 75x=
/76x
>> +                                                        */
>> +#define SC16IS7XX_IIR_INPIN_SRC                GENMASK(5,4)    /* Input=
 pin change of state
>> +                                                        * - only on 75x=
/76x
>> +                                                        */
>> +#define SC16IS7XX_IIR_XOFFI_SRC                BIT(4)          /* Recei=
ved Xoff */
>> +#define SC16IS7XX_IIR_CTSRTS_SRC       BIT(5)          /* nCTS,nRTS cha=
nge of state
>> +                                                        * from active (=
LOW)
>> +                                                        * to inactive (=
HIGH)
>> +                                                        */
>
Before I send out v4, do I get it right, that I should convert back SC16IS7=
XX_*_SRC
(i.e. interrupt source constants), and leave the rest as in v3?
=20
> ...
>=20
>> +#define SC16IS7XX_LSR_BRK_ERROR_MASK   (SC16IS7XX_LSR_OE_BIT | \
>> +                                       SC16IS7XX_LSR_PE_BIT | \
>> +                                       SC16IS7XX_LSR_FE_BIT | \
>> +                                       SC16IS7XX_LSR_BI_BIT)
>=20
> It's better to start from the next line
>=20
> #define SC16IS7XX_LSR_BRK_ERROR_MASK     \
>         (SC16IS7XX_LSR_OE_BIT | ...

Makes sense, noted.
>=20
>=20
> --
> With Best Regards,
> Andy Shevchenko

--=20
Pozdrawiam/With kind regards,
Lech Perczak

Sr. Software Engineer
Camlin Technologies Poland Limited Sp. z o.o.
Strzegomska 54,
53-611 Wroclaw

