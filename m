Received: from SY5PR01CU010.outbound.protection.outlook.com (mail-australiaeastazolkn19012064.outbound.protection.outlook.com [52.103.72.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1B01DF74F;
	Thu, 25 Dec 2025 04:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.72.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766636591; cv=fail; b=Hn+eJ2AMfgS6NmsQTRqwG62LVzDIPJCHLHwIgjxcEi7HmDGR0k9J8D8zdTrxBxSe63IPZiRb2g7wMNEnJn2csdKMl9wYmpnqxdXhLaiw8N0XOHsbNco+tYoriVm9BEmXw0+8jD66Xm6w56wMXi2gDS4niSZaZKDqOeHnyEjH58c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766636591; c=relaxed/simple;
	bh=Jci1Qy1Cx+HPwQ8AF47AGCkvzgMia/TRfJhpsYfsWYU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cjXeEJWAwJkT06V8A0vBLZRDnRb/3FyORsaCxEyBYErBjg2WdZcBirYsLp782SEAhs2QNCQJjk9a7qhhooZxJLHM57qFeI6oGoxDnl+eDzHuLaPM9jBLyz57wdHH7eVYHqg3BG9e8lGK1b2naDO7NFl3lt4UiJFOcKJwYXQYwUA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=WXO5Zmwv; arc=fail smtp.client-ip=52.103.72.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="WXO5Zmwv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bGcbT0hDP5wxo6y6I8dnDDlgOhK52rWBeBbk/LOCrtbpOOJP3AEU39EokSbUwBajV6cMSYfNGnRa0KqIIz9LKczswbMzCosPlhCmiQF7lOcnoqsO3TVNJw8rf6XVtDLEBN6eq0ivTjyUwNyERcjUq6UoEhUuxwkadk3/GPhOiuLtEBe2rQ/Iuqo9MIykFe8ajTpSeVUAkwfP9eSZEVGyxnn7WxCiWtVMVeOUKkJ+8CUv61DJKCGqQH5FPGop3hkcPm/b/kSFVPgZ06cvSifWtwdQraz50a5QTCxvHuEf/u2eI7QrDaPmfEb0aTZHgAs05/ZEX9I4ua61pThnCkDwGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cGJQCBpfCdcOEohJTRJXMn9mKFUJ6mJBs2muXjSCQHI=;
 b=A02llcxrLsw/3fe5SfXT3TFOvqRzo4VQmF7GmPpBRNBWsGgcwbNQX6URG/SievPNBMbTTR/HDuVKpW8XrhpXVrBHE7xnkkvS5tLjVuIEDqyn9+ceu+UCgLQFMe49qdPWj40El0NHIiPjcN6sv7YMERMLSOt1chPMcRZb+Rcpnu5cqqAxhLfF6RnJ5E5ZmQgCykE3GE3+f2SJFlEr8VfJkII15VK2hJKVx2THsHBXCAUThAnq59TotdqcnvdRr/zFSWEdC/exKRxKtErdK0xzuJ0CWeJjCrVF7aQLHoTwNaDPkZUYiCZS7alKZUjAkPO5uyAvbauWbA1zwbgkV1ZDLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cGJQCBpfCdcOEohJTRJXMn9mKFUJ6mJBs2muXjSCQHI=;
 b=WXO5ZmwvQ04Pqff3BUVSU2s5dEqmsAo2cHjwUNzn2WPYETfAvnWMNyxcpNbEFzRV+FQimsZF3EYF5r3euSx+5faY6bQhyPprdV+Q7xCbkK6LX6FMf4AAjwP51G01OuD89YBLB66+3sH5vB46IiiPo9WTg82NnizXlh9JJ8ScKVbU/eMQRiwUQ+NDbcvlEE7CZqOZLJTqtDTGMuej/i0mhRco/gl4xjz/LwoOBBXs0Mswo0FIASEu1sPpqJJwFVGLrrI+nh52/rFxz4L3iSfkKWLmLQtb8vP1J/HaoLHO6BYwJ8uB/zEoZOqCrn9BMXNEQ1gn3VHUhzReC+UCm4EggQ==
Received: from SYBPR01MB7881.ausprd01.prod.outlook.com (2603:10c6:10:1b0::5)
 by MEWPR01MB9289.ausprd01.prod.outlook.com (2603:10c6:220:1f6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.11; Thu, 25 Dec
 2025 04:23:01 +0000
Received: from SYBPR01MB7881.ausprd01.prod.outlook.com
 ([fe80::7cd2:d6e8:3fa0:5f0c]) by SYBPR01MB7881.ausprd01.prod.outlook.com
 ([fe80::7cd2:d6e8:3fa0:5f0c%3]) with mapi id 15.20.9456.008; Thu, 25 Dec 2025
 04:23:01 +0000
From: Junrui Luo <moonafterrain@outlook.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Baruch Siach
	<baruch@tkos.co.il>
CC: Jiri Slaby <jirislaby@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org"
	<linux-serial@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, Yuhao Jiang <danisjiang@gmail.com>
Subject: Re: [PATCH] serial: digicolor: fix use-after-free on driver unbind
Thread-Topic: [PATCH] serial: digicolor: fix use-after-free on driver unbind
Thread-Index: AQHccv8qvC1Z9aqY9UyWKzQaaUhT6bUtMKEAgAMcJyU=
Date: Thu, 25 Dec 2025 04:23:01 +0000
Message-ID:
 <SYBPR01MB7881835C63D3E6F5F4BA81FFAFB2A@SYBPR01MB7881.ausprd01.prod.outlook.com>
References:
 <SYBPR01MB7881327BF7F679E76A7315DEAFB4A@SYBPR01MB7881.ausprd01.prod.outlook.com>
 <2025122232-grass-stoppage-6645@gregkh>
In-Reply-To: <2025122232-grass-stoppage-6645@gregkh>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SYBPR01MB7881:EE_|MEWPR01MB9289:EE_
x-ms-office365-filtering-correlation-id: 2e0339bf-6cf2-48c7-25c9-08de436d4ab8
x-microsoft-antispam:
 BCL:0;ARA:14566002|31061999003|461199028|51005399006|8060799015|8062599012|19110799012|15080799012|15030799006|41001999006|12121999013|3412199025|440099028|40105399003|11031999003|12091999003|102099032;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?w4PnUlcjjBHRdvoc8N3Kkfre5tZtfLor0PnzqG8JnVDzCPYvkxGUlQFyU5?=
 =?iso-8859-1?Q?cVH9K5onf6qDtXadGJL3p7WORidvGLZXWKzWogA0QbToxgpN00zdqkstv/?=
 =?iso-8859-1?Q?qieIgLlU9LPxrGaTNeFOAdy0hwR2cUeiQAdFRAZ+Mf61BMC9CIaFtoc0Ln?=
 =?iso-8859-1?Q?C3/xqd8IN7dWyVLuWzDv5u0aWGXMMA8Xf5GnG/N6FFer3mLC8HcUtn7g5r?=
 =?iso-8859-1?Q?hlnzNzqwA8BZegALPMjT02Km6kvgtbSRPVRGLV+bSq+Nm8TE2WYuQGQfRa?=
 =?iso-8859-1?Q?dbsSDMlU/sZp4xaqRGyo0QbMpXXaccxzqZqDnGhzaNmXQlpRMPxD/goQDZ?=
 =?iso-8859-1?Q?I9pMA3+suXg03745NXPyJTnXDhGno5Dnqw+yMd+TtetKpV0WWrHW6f0iYX?=
 =?iso-8859-1?Q?HxLP7xQq29yRgIVuIcLY8A6/KRIJoh/Uf03kUUD69UXbTRTyxdeZE+2EpY?=
 =?iso-8859-1?Q?0LUz1ZG11Q11DIapphmr4wJsy9DfHm4V1uSrSvRIZOeioTa2qFi787pJ8O?=
 =?iso-8859-1?Q?WFW2Lv7EZMb/R++7OOaP2xvGeHdEOarw4zOBOUkrnd+UvheNlhvQjiHfek?=
 =?iso-8859-1?Q?RbiGArl5tIVe/fnrcMSHFn+rXHUfe5KTPDGzh/+uLmH8/gjyt3UFBdE4+G?=
 =?iso-8859-1?Q?lNWaplEQtCmhBKv7YHSHFYzMrYoQmOEBTLH8LQ/MwpEr4shkeG7Er2FWLk?=
 =?iso-8859-1?Q?9EfDsG+wetH9QX/yu/r7jZgaHR6DP0nll1ONzWIBoJbMmv8hAV+7BsO3Pu?=
 =?iso-8859-1?Q?1JKoGJA8tUDlPizVnoDCyt1+ieNXePvqPIcupKlLO3yI5vQX3l5VB5bxTG?=
 =?iso-8859-1?Q?yE/KgLFmBfE3EvzXo1UzH1bo5XRR0LYkqgYUAfK8q/KvJvnpBsNNgP3Nz3?=
 =?iso-8859-1?Q?QnGql4uv6ILyCUqrgjV64bV3IXckJF0dFGtdXOOXOybT6UfGk1TN6Juwbm?=
 =?iso-8859-1?Q?CP1i+KNbthChp+vO6M7GOzlzpzjvA1SXfmJYf4SFVHud5EZc2CUN7PBnd5?=
 =?iso-8859-1?Q?n2gqtnypUuY7VPyDbLNA6mcpZ85Pz37jFgNym2HKqIQzA81iMweD2fIwOi?=
 =?iso-8859-1?Q?FkBiLLCfgLdgWt4QJQpC4Jkn2/uJplHwfwNjqqWEyIoB87Xg+mCPDECojw?=
 =?iso-8859-1?Q?/sIl3yewe9fLqM+6x2mOjVQig0pnwSdfTEuj3fiPoi/M5ZVMWlHA4187Ol?=
 =?iso-8859-1?Q?BXUiDqBvIIQotOJUFH1ckNJTrvkloSadZKvQASseuDGFQpxZ4/yqDk3BSl?=
 =?iso-8859-1?Q?Vt1DFN7tvvCY7pUP047GrxL5xuZW1gWhmAgsBcilh4J0uSEDgPaepTqqMB?=
 =?iso-8859-1?Q?4Vla0uHR9R9YeY9Bm5F1zvpoZE5kIHY7v96Vvp716KNICwhM/JAvehIU7Z?=
 =?iso-8859-1?Q?gyqVjDT/0YOyHYHqUBE362x9Ji8I4WEA=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?haXbBOTPGBHoFZgCcO8nTymlilkVsO6BDU6VQZnr3LErw2Qb8bMOaOuJjb?=
 =?iso-8859-1?Q?oJIiQq28eQWvJuJcyPqLe3gaUOFhKHLYzY+qzICX4cLqcrtXqLrr7DCPKQ?=
 =?iso-8859-1?Q?aEbdxSmSGLb9IdqEnEteo2Hd4uVegMQPs2PnV7BK1Fizx+mFtLOLePwyg7?=
 =?iso-8859-1?Q?A8N/cQq/YrVh+7673EOrWTnZcUF52qN0OZ2lt135ejnuA1jg87Hn46FVUu?=
 =?iso-8859-1?Q?eAVVjKJpPwbzOy3xyPITBwMn+vP6B2dsUKoKv+Czhpy0FnqVt5Hp5qDVJw?=
 =?iso-8859-1?Q?CLlMmX0ytCULw+2hbvwqPHd6R85iMwRO55nhGKOHeiL/Nm7aab471LK9Em?=
 =?iso-8859-1?Q?fDCczRnJ3wqsE+cbxlXVaZS7EDGBfY7hPzFiWpsXdJcsRic1+GewPIPN0e?=
 =?iso-8859-1?Q?TyYA9uUSb77FaohZKPcvAIebiUKyJccYPkAhGk9LgM0i+LyjMaGNEHIPNE?=
 =?iso-8859-1?Q?oyPZdpOkN8HNwir9KNJ+SGZzQ9LwMShg033REdf7TqBIaNNJ9+3S8Q3/ya?=
 =?iso-8859-1?Q?RXM33isprPC0LNT79v0a/VTEdl6qm7KeVMderOs6nRqQ3rkBB7+8KggX1o?=
 =?iso-8859-1?Q?IJKQntc8466cruQOJq7WNnDrCQGMc3p71PDvGkuEnHSejZGBgeBKiz22sw?=
 =?iso-8859-1?Q?5MxP1leSlV7B0WkcvQLyh76q6EHOHdH3WUUWR9fBwKzlrThzfXgkiCEzH6?=
 =?iso-8859-1?Q?7eheFY1xEa7ger/Gk7wFbF2BqGT1F8A34dYDmjaZEvZMZSTaZp4cLd/ogS?=
 =?iso-8859-1?Q?CeRAW1HCS7/bmx/UEMqjtIAYn3D4FsdufADfQPGxXF4nxocOsVb1jwABsH?=
 =?iso-8859-1?Q?iqDwraYpxeUYcCqip3ZMoZSj/o+nH80RSNsEWubhSJyewNWOO9zvVtSzu3?=
 =?iso-8859-1?Q?DX+5/+sHLRT2QEeUYpzArwS0KFoJu6ToUv4EFGwT6m9jvDH4gOJ32f+Tom?=
 =?iso-8859-1?Q?CZROZ68U3nAYVkc0E8n+3CsRQjPsTNM06PtE2BeM7xdW/gi8KBbLWLfPk1?=
 =?iso-8859-1?Q?/oVxIhGTkBQbAbBuTd57ChX3gK6p0AHvXRmovGHr/CLAUjHHE2C+1NmUcb?=
 =?iso-8859-1?Q?J2BvuJ1eUlDNmEiBIeBh36gamvRLbmPiXmnTTJq/X/Y0NzsABcxHC3HCgi?=
 =?iso-8859-1?Q?qnAhHjNvC1RUkHhYmD/klMzvu+bPumsWpvG7nkWekXFFhy3FccnJArzdBi?=
 =?iso-8859-1?Q?hM6ZzMPvp5DhyKr6qnLRUNsP959jBZLA7yIWOzltvUMN+FWuKNGOLqHEM0?=
 =?iso-8859-1?Q?oAws00mT/BI85Uj89jYWzh8Qme3N8FCalSsmCTZV6w/tWIV7QTu3GIHqwM?=
 =?iso-8859-1?Q?k57SwIbTWY14Nrq3v4y7QqeR9doscb/J8CfnmW4R7ApQEG9NbGaWQ0G5em?=
 =?iso-8859-1?Q?ZR5mSos2ise88jm+kQxyz18P7K8DXqeHNnan2Fknv8SS1Fm2IPiMqfD5ht?=
 =?iso-8859-1?Q?LjY0d9137zJJLpX/?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SYBPR01MB7881.ausprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e0339bf-6cf2-48c7-25c9-08de436d4ab8
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Dec 2025 04:23:01.6395
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MEWPR01MB9289

On Mon, Dec 22, 2025 at 07:22:14AM +0100, Greg Kroah-Hartman wrote:=0A=
> On Mon, Dec 22, 2025 at 12:55:02PM +0800, Junrui Luo wrote:=0A=
> > The digicolor_uart_console_write() function accesses the global=0A=
> > digicolor_ports[] array to retrieve the uart port pointer, which=0A=
> > can lead to a use-after-free if the console write occurs after=0A=
> > the port has been removed via unbind.=0A=
> > =0A=
> > digicolor_uart_remove() leaves a dangling pointer in the array.=0A=
> > =0A=
> > Fix by clearing the array entry in digicolor_uart_remove() and=0A=
> > adding a NULL check in digicolor_uart_console_write().=0A=
> > =0A=
> > Reported-by: Yuhao Jiang <danisjiang@gmail.com>=0A=
> > Reported-by: Junrui Luo <moonafterrain@outlook.com>=0A=
> > Fixes: 5930cb3511df ("serial: driver for Conexant Digicolor USART")=0A=
> > Signed-off-by: Junrui Luo <moonafterrain@outlook.com>=0A=
> > ---=0A=
> >  drivers/tty/serial/digicolor-usart.c | 4 ++++=0A=
> >  1 file changed, 4 insertions(+)=0A=
> > =0A=
> > diff --git a/drivers/tty/serial/digicolor-usart.c b/drivers/tty/serial/=
digicolor-usart.c=0A=
> > index d2482df5cb9b..5861be2072c4 100644=0A=
> > --- a/drivers/tty/serial/digicolor-usart.c=0A=
> > +++ b/drivers/tty/serial/digicolor-usart.c=0A=
> > @@ -397,6 +397,9 @@ static void digicolor_uart_console_write(struct con=
sole *co, const char *c,=0A=
> >  	unsigned long flags;=0A=
> >  	int locked =3D 1;=0A=
> >  =0A=
> > +	if (!port)=0A=
> > +		return;=0A=
> > +=0A=
> =0A=
> What prevents port from changing right after you tested this?=0A=
=0A=
Thanks for the review. You're right that there's a potentially race window=
=0A=
between the NULL check and port usage. I found that several drivers handle=
=0A=
this the same way:=0A=
=0A=
- meson_uart: has NULL check in console_write, clears array in remove=0A=
- sprd_serial: Fixed similar issue in commit 99038fe75afa=0A=
=0A=
This check does not fully eliminate the race window, and adding stronger=0A=
synchronization in the console_write() path may have non-trivial cost. I=0A=
am willing to adopt an alternative if one is preferred.=0A=
=0A=
> =0A=
> And who is calling unbind on a port?  Why?  That's a debuggging thing=0A=
> that a developer could do, it should not be part of any normal system=0A=
> operation.=0A=
=0A=
Although this may most commonly occur in development or testing=0A=
environments, it is still a legitimate bug that should be fixed.=0A=
=0A=
In addition, unbind may also occur in:=0A=
=0A=
- Some embedded systems using runtime device tree overlays=0A=
- Certain virtualization scenarios with device passthrough=0A=
=0A=
Though these are uncommon.=0A=
=0A=
thanks,=0A=
Junrui Luo=
