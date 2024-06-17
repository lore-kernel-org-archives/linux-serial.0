Received: from eu-smtp-delivery-197.mimecast.com (eu-smtp-delivery-197.mimecast.com [185.58.86.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A32718F2EB
	for <linux-serial@vger.kernel.org>; Mon, 17 Jun 2024 21:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718658235; cv=none; b=HfevmpPYMKXw5SsS62Oqo/Fm+AYajQvw6TPa/vphm2mQ4sH6XiAVouu1MBiBxfL4JQ0eAIeY7l+ullrL8iVBK+ouZLTL2QH96aWPqfnro+lOTbCPUV3ioECMkc6QqJDVWVLzyeJv8N8G5eznCW7bc8bzO6Vll83clR6Ex65Uus0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718658235; c=relaxed/simple;
	bh=aRHB8NtBF72L4Qb7uUC1SU9fosE0jGvRxhF3MofbvvA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 MIME-Version:Content-Type; b=qbBQ1w4hN6EssEZ/6QnrElQzBlYqqZKBGcBIeDyCPF5Fo6D/T22qRmpSqxKPiSzDYd1uIbl5OUEuluFldvmjVtY7KhTw4uNXLsJx30fexIPQ0o8kxNz/NMKAjqfonidw26jQShgKi2MbCocwv4jVv3vZH4AIoKOQYFKgMY7ei+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=camlingroup.com; spf=pass smtp.mailfrom=camlingroup.com; dkim=pass (1024-bit key) header.d=camlingroup.com header.i=@camlingroup.com header.b=CnkHxsER; arc=none smtp.client-ip=185.58.86.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=camlingroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=camlingroup.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=camlingroup.com header.i=@camlingroup.com header.b="CnkHxsER"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=camlingroup.com;
	s=mimecast20210310; t=1718658226;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2IysvgqfTRsJX3RuvFEF6O0Ww2WiNpC6x8K6aELXNGI=;
	b=CnkHxsERbB7XPRsgv8BD3q3nMThjAl5fBV7oCz6ZHyLeG0bR4+vsXH2bndI31979n3i4wN
	z8aXH0Rt6AYjyF9q0DhRJyep643q2GIf2dRvdFJbL9p0orI9Uj0AG4vK/M+FyiLN2ZXR7w
	ryN0OqYqyDHIf5QahyQw2ApwIU8tWrY=
Received: from GBR01-LO4-obe.outbound.protection.outlook.com
 (mail-lo4gbr01lp2105.outbound.protection.outlook.com [104.47.85.105]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 uk-mta-241-aPfV7xrkNw2I8NafGMfzvg-2; Mon, 17 Jun 2024 22:03:38 +0100
X-MC-Unique: aPfV7xrkNw2I8NafGMfzvg-2
Received: from CWXP123MB5267.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:142::9)
 by CWLP123MB3843.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:a4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Mon, 17 Jun
 2024 21:03:35 +0000
Received: from CWXP123MB5267.GBRP123.PROD.OUTLOOK.COM
 ([fe80::f866:62f9:716e:ca4f]) by CWXP123MB5267.GBRP123.PROD.OUTLOOK.COM
 ([fe80::f866:62f9:716e:ca4f%4]) with mapi id 15.20.7677.030; Mon, 17 Jun 2024
 21:03:35 +0000
Message-ID: <960da827-0be2-4891-b1fc-9be9cc6bbefb@camlingroup.com>
Date: Mon, 17 Jun 2024 23:03:31 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/2] serial: sc16is7xx: hardware reset chip if
 reset-gpios is defined in DT
To: Andy Shevchenko <andy.shevchenko@gmail.com>
CC: Hugo Villeneuve <hugo@hugovil.com>, Hui Wang <hui.wang@canonical.com>,
 linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
 gregkh@linuxfoundation.org, jirislaby@kernel.org, hvilleneuve@dimonoff.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, andy@kernel.org,
 Maarten.Brock@sttls.nl
References: <20240614102952.679806-1-hui.wang@canonical.com>
 <20240614102952.679806-2-hui.wang@canonical.com>
 <20240617120347.907e8e1e8eae5824930dcc48@hugovil.com>
 <274b7ed0-28fd-4348-adfe-c4302fea0c09@camlingroup.com>
 <CAHp75VeGnpqKNKaK_nUm+HXuqqTX3SzbkjgH4ki6-m=j2O-YbQ@mail.gmail.com>
From: Lech Perczak <lech.perczak@camlingroup.com>
In-Reply-To: <CAHp75VeGnpqKNKaK_nUm+HXuqqTX3SzbkjgH4ki6-m=j2O-YbQ@mail.gmail.com>
X-ClientProxiedBy: WA0P291CA0003.POLP291.PROD.OUTLOOK.COM (2603:10a6:1d0:1::6)
 To CWLP123MB5273.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:148::6)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWXP123MB5267:EE_|CWLP123MB3843:EE_
X-MS-Office365-Filtering-Correlation-Id: fd8769fb-056f-4399-03e0-08dc8f10f32e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|1800799021|376011|7416011|366013
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RnVOZBXxkQdaicaO6dPh6+5RS+CQKNq40MPBaAR2/MLsFqZ1WkpWkOnFJsx1?=
 =?us-ascii?Q?457CV8RZVMxKo5xNtW6bF+864AmoLUoUsZ6AzeoWuXZIbFlRK46U/xEEe/sK?=
 =?us-ascii?Q?twwmC2x4mNrVBKvVORk+DHnwZmtb3CkrBAawDoRxbVQomTUuYTn18atsff5U?=
 =?us-ascii?Q?8J+Vx3rpThNKOQ271/SpUb0xH8vAopVslmnqG79lYEPDe5T4tIxmBJoWk8Tf?=
 =?us-ascii?Q?PNc0gI7TM2Ka3sGPQJ3m0H/rqc0aQUFzjyqmYLnpFUkb4wlkJzCD+E196m1b?=
 =?us-ascii?Q?WuBDS1OB/c5TyxyaqTocYUsP1SIJWlWp0fBide/h+jPmIlQ8glHlUZgmJwgq?=
 =?us-ascii?Q?QKKcz3yLDAPYDNdGOtchXyCnxfPSuxbo64lHcWBrnrsUDGrb3bynuVP4F37J?=
 =?us-ascii?Q?3nwpLnXeWs+NkO3cVx823G0ls8LfStD4Ht3v58fTvu+SNVKEqamoQUwFMaXl?=
 =?us-ascii?Q?fKZ1Dhc9UnWfzxozho2LAKSghjid515QJu9KgEXGwdE7zwBLTjt7AH3QvglW?=
 =?us-ascii?Q?sDGTqYhJka/rcXFm03Tr6MyvirlWM0g0/H3IegC8jcbF17Kw9X7M+RXmaVZ6?=
 =?us-ascii?Q?vMtsRMMjdt9SYSc8Pu6sEIKG355xsy0VQmQrz55L8m4ZY0MlgS4sD6st3mLZ?=
 =?us-ascii?Q?l//ZQmH/2Bc0VUxRSKQYbAQ7ArN99to9CUAKXJhRBbfyILVZmTEaxOXEtVR6?=
 =?us-ascii?Q?lsdxZTwKW6W62n0KIvxkLKaFUq8ZR8W/a4mNhDuatc4rx/bI4coTIMUBeReq?=
 =?us-ascii?Q?OAe0xpzTbSUmF4ciy1XtaU/cliUwUb9SQIjTkdhlpYtJYRVxTr+rE2e46H2A?=
 =?us-ascii?Q?wrDxLNiznBjC7G5BHg4X3Xziy/cWic1PML4oacCCNWX+GPh+MTLQ5xcLEiWQ?=
 =?us-ascii?Q?Cjz7QuuoyEqWDIBccs79Y5fEbPi0IP4gSK7l2Ws2/t6eRoNYuB2rXDG4lJaG?=
 =?us-ascii?Q?tPm2W81rJ1w5VUZF6stQkp4VlDhOtzXF1AK6JMAfvwrvSLRrNzw9s5ZIkzTw?=
 =?us-ascii?Q?6aCqR4QQRvH2S1w+dAd/iOkartAqiGsvdZdsIC7cTrOYO0eH9GaaVowjM66J?=
 =?us-ascii?Q?iqeQv7SzsmI3Zplyh12pYQDKQbTzp9ESffZRjrNsnFDelvPsSMFMDFjrEkMm?=
 =?us-ascii?Q?sIES3rWNvPwZe7xsv1lvOPTbiu1RADmfosnRYYnIv+8nZ97OU3CM0UqlxXfG?=
 =?us-ascii?Q?8TriybayoDQdqyVqO/6JP8pJrsr9CsYiD6lrW0RHCZdgd4O2FxxsmhNjPaQ1?=
 =?us-ascii?Q?Dl+X9dBIH3OlPeR7XcFr?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWXP123MB5267.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(376011)(7416011)(366013);DIR:OUT;SFP:1102
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kqjlUcrtXKEl/TLUfz1neaxFRn5ojhFkkddo3xmTaer+B2dVOxbsQ1u/X4cq?=
 =?us-ascii?Q?Sp7sANyZ2GTvf0/smLt5y4RC3yzE19/KBTKdN6g+nGuZslLyRSpGMKwBBGv2?=
 =?us-ascii?Q?5BNp/5W5DHLqAJPKzfFTxRJ/TSidMOWbbshSOdtwsmHESOUC2PYEzdKxrQ0L?=
 =?us-ascii?Q?OUih1dv2/nu5LP8rCAtiqRijtTVz0AiqAABsB3hc4F6k+yxbz3ve7yhNVoR9?=
 =?us-ascii?Q?hD8Q1TRyp+chd351lkjI/0QicGE4LWtlm0xY/wbU7nwpwbiZ1FQInhDS68as?=
 =?us-ascii?Q?gIO236dd5JRmLhdGI58xfX0GGRd4nabIA8NOGA9N57z4+9tstvs43e8sEmZm?=
 =?us-ascii?Q?7U1NpIcbWTeF6tqPM9pyPWZy1b4zn6vHA0y24+bJlZReWOKx28wdDhzAqIzk?=
 =?us-ascii?Q?Rdj+H0adng2gsHt9gk4Z1sRfXAcgS2wMDmz6VqjN5a20012m6XKXblhLKQAR?=
 =?us-ascii?Q?+ks9VLEB9zVJ6yXQmVtmKe2zySLDX3rFzRnqk22Lr2jydfqpcKaPWsDVxaFq?=
 =?us-ascii?Q?9GboeGyzGsp4IMCiLtYSudAzzMUnEYrwUBivckU5Pvp7YhrbyqjIIMHw3UJF?=
 =?us-ascii?Q?l5U96Eq2J1WIzYudSkj/tjyQZrDsmCBRUFPPAmacu3lWVQZPpqtX6TPjqpgg?=
 =?us-ascii?Q?jzp0FNCdjz0s7C+2iJSvU/XSax+9k4yYxWZw5pFduaNoFbPyPjwI4iQzercn?=
 =?us-ascii?Q?De96V1GWXBsoRK6JXucqI6XVXahai7dph/Evjw3mBsIiuAzT1pvmfKVZltlq?=
 =?us-ascii?Q?cDgz9XxpG7Bn6RXAZ8PaJaJNvpNWhqopFpE6K3YL5nrPFzS8NbLDIGE6c2S7?=
 =?us-ascii?Q?iwUfBI6V3ATPeXaWg6vRLYKwW52IjX4/AzUegOmKEVrsH8yaQxu6hJ7Z+lhB?=
 =?us-ascii?Q?J30gGXbaZoAiEQDtZcoDh+VoEWA/f749QVZ5Z1aKxY8zdwf3BxwbDl8F37rg?=
 =?us-ascii?Q?isjRJXl5/GJxZM93KvIdFQJ1xJagpPy+eYc1Oz/rulKVD+ypngGORhH0rA9v?=
 =?us-ascii?Q?nhPWGJYi7ckpyU/obx22NkWLZ86HMTvoGY8/LeCOvqVKesopQc4sQf3hgK7g?=
 =?us-ascii?Q?Xg3ED2xf5EgzT2+DjnPfC2nmSwuwsvoVB3OzMoO7NES/Pi2sCaf0xw5zpgJb?=
 =?us-ascii?Q?9tQOSrwTZ65LPpjWfRZiXNOu/OXgmp3z2j0tg61TMTDck9yEjM/FvN5MfpIG?=
 =?us-ascii?Q?gmu0YNbJVcEQ0onVLi84VyVvcbnHGu2Fe/dSE//gdHW5bKjaPSlwqzSnAYr6?=
 =?us-ascii?Q?v0Cj0m/dQXqoxoJHx9mN1DVjKdfTbOL/cIPfKoYpIOvy1Jlu+c2IJwxb5UTA?=
 =?us-ascii?Q?T8RjgSjxxDnsEc/tgpwj9NCZwe9wEctAok/zTca3w3QrF8Wk/CnB81JZjUHA?=
 =?us-ascii?Q?YP5GwA1x15tUeT1AxZXkn3otWoo/K07lRwsDh/pmQlX5SN1wzGl5Uf8SgJ0D?=
 =?us-ascii?Q?ou5F3QCkqXn8QyeSrRtiyTzt74pYNzdRUxuxlFYp9E+Kv33odUtR8aDXh+kC?=
 =?us-ascii?Q?Siq98X3KaZmhARpIuAF3BAv+7MJKLLnf4aPCbFuzx8d9XVlKL2+nbyUSrB1l?=
 =?us-ascii?Q?BlTdFFM8Qmy9cSSigINxG5SUIWK7eA4/sXtOucts1vMm7Jh3yDDjefMi5Uaz?=
 =?us-ascii?Q?qBVcu2nHZ+vDSv6HkfHMDJiAaJpYPs7cyhXtZq0leoUBwnqA3VTO4B4DSSvr?=
 =?us-ascii?Q?pJtW9Q=3D=3D?=
X-OriginatorOrg: camlingroup.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd8769fb-056f-4399-03e0-08dc8f10f32e
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB5273.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 21:03:34.3920
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fd4b1729-b18d-46d2-9ba0-2717b852b252
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F2NLHUzhklx7r7W9o3n7ztBCMEx5rqAi+DkP6e795z+LjfHhj95blrkhdJySdH6ttHaLoQaRjaFfATitsb3Nk3riyCz4dwHw1RXiZoQ+wh0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP123MB3843
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: camlingroup.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

W dniu 17.06.2024 o=C2=A022:43, Andy Shevchenko pisze:
> On Mon, Jun 17, 2024 at 6:49=E2=80=AFPM Lech Perczak
> <lech.perczak@camlingroup.com> wrote:
>> W dniu 17.06.2024 o 18:03, Hugo Villeneuve pisze:
>> On Fri, 14 Jun 2024 18:29:52 +0800
>> Hui Wang <hui.wang@canonical.com> wrote:
> ...
>
>> My hardware doesn't connect this line to the CPU's GPIOs, so I couldn't =
test this properly - but you can at least have my R-b tag.
> Lech, you need to provide a formal tag as it's described in Submitting Pa=
tches.
I already did for v4, but to make it clear for v5 too:

Reviewed-by: Lech Perczak <lech.perczak@camlingroup.com>

>
>
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
Tel:     (+48) 71 75 000 16
Email:   lech.perczak@camlingroup.com
Website: http://www.camlingroup.com

