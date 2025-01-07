Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2064.outbound.protection.outlook.com [40.107.21.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197CD2594B5;
	Tue,  7 Jan 2025 08:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736238566; cv=fail; b=VZSjcxsZWcvaTgKkFf+OTRKINaNEQtaDhhw8nmt8cdPn5/jomBGQVMy5Kr4rUS+DNEYBkRTDlJoUtYAKlGamyV2lEnn7Ywdyy2ci0hvXMi0caLivV+ufdR7TaxmMOt2/1jz9bH4Sdz973bV6N7g4D7rbnPD+urnQk0CNhr5yt10=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736238566; c=relaxed/simple;
	bh=iCbbkQheVDDy6vrVBNWucj1EXogHvEuy11aN9MNPHvg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YqQ/3o01jOFSLwlSTiIawsBySNUB7xsg0O5Da0yL3s8h099OkwWOU+lxVUTi1NzL5QzaciHN4i84qUVxmCGnm9YktAF07CxEIpN7OeV4/uAo5C50p245Wgsfr+HcOt7YgCdHIGGfTtz03E132e71NcsbEXoCQDYikddcOoBBrbE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=d9F4CpB0; arc=fail smtp.client-ip=40.107.21.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="d9F4CpB0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E/zKJR2KBpOu0lBfrG5LrfYcDRdbZT6/02/BrNKakt53r+iwxVF7rk3SgQMVn0Ye1OiOAqD/Km9yetBIfgX/gYkF/ZGBfu3Vf662sltFdpxOkSOkdn1PReUS2u/3xSmIefXaTmSDM2kgZRIQPKg+YJMKVydumPrd/FSHdvKVPv3WNKKvkSCSfnEkZ6BVrlvSTTA0Erb1WAd5dsyJCN21Ij6Ky0Uj8QxR1mYrlWHJO4Lm1swS7M8pkphZMh3Lak9KrzchjyuJVp+Chm0NICRcqWibowjLIKgdWCtt7vhjW54LX2C/q4oHbbBrXs6bC7H2VXC7BsOemvasR7dr3LJFew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n009g5wLtYlwjz5WDXrV7icF9d+cDdy5ckSARaJglXI=;
 b=nQ/sHhbFeyzUaqG3t/NT2GyXXqiBt9b8ZXjmxULkbHfRQj4SkivXLTEkLtpFAVgs6Kp0xPOXXGFKm/1k/QRl7JM4/tgPuL6aRYkwa2beghlztsYx608QNra5hsuvZSJOHHx+HrxYR+VY1AgGtZDrzJa/EwV6GXK0L4sHFjU+k+20X6QB9ygd5yGeNvR7WhVaueWNoD4bCDIcX2MDwWCCm8e3eu8e2yAAKAAoOHdP1c/ehufxVLj4EnIQfEwMgGoTGrxVu6gyuKMW/aXzO2ra+eJsubsQRgz7CwTTJnEaIHrUodzHZPq0m/c1BsGJeJidHssyM7o1OTTgleN17p6E/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n009g5wLtYlwjz5WDXrV7icF9d+cDdy5ckSARaJglXI=;
 b=d9F4CpB0K5fGdOjpsVCm4XoooPvr4thS1luKBMEiTQklCVTJkSjGwC/LO6MtLJmQ5VZHcjwuUBIJ77qtBgfN4tmvywqkrBDAMe82EqQm3VoVAOpiPhtbTI8/A2Xy/c4yjdUbWLlQIm76XySW8D+h4NFXqT4l5rz9jyt4L143RBfSXckDfF02rMJQsLRBZK1QAhSh1YiVu7XfZlE1gcJYnZO+rEyhbVTAJVwrfV66x6eyIgepVGeFahMHKjDDbzLJVZuyFc7xbLIjgFx0fi94UkXyjtd4fpOjfj9Frb9h2V3SrJc/B6mLJf543vJ/bitRQMK6plpR03SHuwBI1EYVgQ==
Received: from DB9PR04MB8429.eurprd04.prod.outlook.com (2603:10a6:10:242::19)
 by GVXPR04MB10564.eurprd04.prod.outlook.com (2603:10a6:150:215::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Tue, 7 Jan
 2025 08:29:12 +0000
Received: from DB9PR04MB8429.eurprd04.prod.outlook.com
 ([fe80::2edf:edc4:794f:4e37]) by DB9PR04MB8429.eurprd04.prod.outlook.com
 ([fe80::2edf:edc4:794f:4e37%5]) with mapi id 15.20.8314.015; Tue, 7 Jan 2025
 08:29:12 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: "jirislaby@kernel.org" <jirislaby@kernel.org>,
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH] tty: serial: fsl_lpuart: increase maximum uart_nr to 12
Thread-Topic: [PATCH] tty: serial: fsl_lpuart: increase maximum uart_nr to 12
Thread-Index: AQHbXa8xeDDJ4lnkCkiOGzKD/DUd4LMEwrkAgASWmwCAAG2hgIABOQ7Q
Date: Tue, 7 Jan 2025 08:29:12 +0000
Message-ID:
 <DB9PR04MB84290597CC2BA6CFA096849B92112@DB9PR04MB8429.eurprd04.prod.outlook.com>
References: <20250103071154.3070924-1-sherry.sun@nxp.com>
 <2025010351-overlap-matchless-5c00@gregkh>
 <DB9PR04MB842950C5700AEE30968FA1CC92102@DB9PR04MB8429.eurprd04.prod.outlook.com>
 <2025010602-cozily-rind-c2c6@gregkh>
In-Reply-To: <2025010602-cozily-rind-c2c6@gregkh>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR04MB8429:EE_|GVXPR04MB10564:EE_
x-ms-office365-filtering-correlation-id: 2815ffc0-aedd-4569-617a-08dd2ef55d62
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?uaP4XlqAS0/pOQ6koAheYvNjaWFOyh+GGqULM+3F5+8dDV0mv7urDfTrcZz7?=
 =?us-ascii?Q?lmYkAogTQ4tAiqPVJyXft67R8Pqx9K/3jfaFrmsj6lqhat109JqOR5FDkqvD?=
 =?us-ascii?Q?510gjGOQg1UFE9NPd1bFamfuf8FCPPP5dEu/voJ4BZtMBDWgX7anjs6b1m06?=
 =?us-ascii?Q?p6iJfRS9QARDT+pa3WK6jLUkqTFRaoPLlkVoM4dJthd2BwRWnLWB3fIR/pEo?=
 =?us-ascii?Q?mjirx5ZAUiYlNHa0tMcufaSH+dLPanCv/zPM0AOQk1eogIczvBIdypyVJnhv?=
 =?us-ascii?Q?gFj2rMbEOkS9ZLdbJX7f/oiL/U4VCiFNNYnIzNRK+XQ28H1N53xnF28ATeZl?=
 =?us-ascii?Q?xO5wmU8jijBfdkDhLwdTr39B4KdFl7Flzl3NNatvbUFhypPsvhW+NXYLX347?=
 =?us-ascii?Q?M2AHgQuGjEelrNuOH/kMxogyQfr5m3/VgB2LFYZY16TJHOqJZ0lJ6IVHmmwv?=
 =?us-ascii?Q?/QXIETJJ9rjx9pNdMxodwGIUhIXZ/if6wgiB4k9hda6diJtkbVi63m9sFk+U?=
 =?us-ascii?Q?q4BGAxSTyw7r8NN623DdmxzYDDPIf2qv7TStyLEXs/LdxMimxiAe26V1AZOc?=
 =?us-ascii?Q?Eif0xf8EtJFo+wnz+QZGA8qauAkUFwBAYAOZsN+Ac3G54HutTrkVMGtu+zI9?=
 =?us-ascii?Q?Ans8hGLAdVSGRbl6cD+TgqDOwGoi0S5pJTGYOOpM9rErO/iy5iNbhleHHndy?=
 =?us-ascii?Q?HVLqpmRWI/DthDUdEfR19LhfxLMGbV558d0su7otlFSdSTyx150DzEN24gHy?=
 =?us-ascii?Q?o8BvlbxXn5uyAmk/D5tva9qVBAJyHVPcr5fPIFgUXRdQMADnr5qmyBWZGfRL?=
 =?us-ascii?Q?djeTsX3wlzaeOPpoCQSLQM3mzGG/+nWqGYoVCEnmi0hIGJq+w2VM+/I0HOzq?=
 =?us-ascii?Q?5icze5ziRs+iFYOhWKDc1KUSjzJqOJgUvYV7Ff7K+7iqOn/8stWWiunQq+yW?=
 =?us-ascii?Q?aGZqjEkW+6KfI3m9hcQaXglONtUc65S7RuSG7DCNc8j24bXvMV7Y6ulNMUHM?=
 =?us-ascii?Q?z4oxEsnvYKXY/5+uth0d9L9IM9+Y4NZEoAUuzGMohUncOAagOofnKNsP0hNB?=
 =?us-ascii?Q?VauVxYXWDTPOORDwLm/EFTQnwqSEDrUXjO8jimKEbet1mg7ZloXaAiAwfLWR?=
 =?us-ascii?Q?XtvA0qp2xZj+T13QhT1Z8H62HBvWMO8QH0nsrQRyKSh3x0pP5wPRE2MuEx4A?=
 =?us-ascii?Q?I/br8h+zMP/FvBiYD63SQrc2Y5zX7tvPlrQ9K4CE+fyTRtiNxgABSUNTd7Wv?=
 =?us-ascii?Q?qnBVitSder0EwqQhXAOuzJkoZLRgTmu7sfbwDBkzvnAYX5MHxD2LByQCDWsu?=
 =?us-ascii?Q?aeQC4fUpncngSq5ENCeGqebHdV8os6xUZVC+V7GqYl/FXUHo5JpV/ssLTZKP?=
 =?us-ascii?Q?/+8Fui6TxrTL3narIPI0+BM4/jG1tSXbtNOQajuYKawcdVvuvMiR3iVP8TiM?=
 =?us-ascii?Q?tzm9AGAk9PA88k8m9ILTwfozxZV3c+Gn?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8429.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?sa4igUjETDooLRIYM7lLVJVgRlTCgc2/4Caoj+XWMQQ+kdsxrKkmDjdcMnHm?=
 =?us-ascii?Q?9vP4tsa5EIndEiY32kf+VOZXbzCrFMp27Bzpx5apUXn96Zhr5kE8C0BdRk0P?=
 =?us-ascii?Q?nZ9A07qyCkc9PUi3VdVjJtbo3ofldhTrroMwasqQyO521HLFnvA8dKKpyx0W?=
 =?us-ascii?Q?wDE8zSKpVJnvunFtL1bwbt5oxUDn7X0fapdULRKDpmLSH32p6egFPv2ANRDw?=
 =?us-ascii?Q?ahoPBLsNKgGJhzD5iF5Bos+G2w9G6JZJvMlzDF3rqAaLS5tDnPKXCqk9fKmZ?=
 =?us-ascii?Q?H2wMqVhzwSbLgJuLlC1MUEqdon2dt1CH8JD70buzreG8q+L4K6a7Uai+QRTe?=
 =?us-ascii?Q?cS8x9rdwbucq2XDB1oKzJTj9Gw61Tif96/RFkMdIc0aIkTIL1JXKJNq87Yku?=
 =?us-ascii?Q?3ItpdpLloBuDa0GjRcojH3TZmtYtMufM5jVwwjjVNevtv29TU3o6Tyi1Ppfu?=
 =?us-ascii?Q?KmL2tgFQ232PS6VemvIYJt5w+MjhoHgz/8NoJGOEJDQKCnoABcbuooiNcOmn?=
 =?us-ascii?Q?wU36TglU5UeAU7Hed4LuMlYQB2Zpw9cX4bWBBfTUt6T8i5v/i8fMWiYDoBYG?=
 =?us-ascii?Q?8FWY8yc2b4dcbRRjEid9yAqOUkclYcGDrHRCZqsGc184PcBTgMIwlKErgNxQ?=
 =?us-ascii?Q?Qh03qZ+lrBcmR2Pz46iTUoKQse6ZE3jrm8qo4L6EGlKf6fG+sv9EH1qn73ul?=
 =?us-ascii?Q?Poh/W7EikYrdUY/aZFUgcSeqhxXrhiwK67RjYWXqFISLDBpwdFlS2u7PRjiv?=
 =?us-ascii?Q?laklV/GREb7olpEd//yotCEuT3scBOy7LRdvdjt/oAMS8vbrV5OClluQMshV?=
 =?us-ascii?Q?dywcYvKh4eDTqz0StiV6Mgequ/2jV6gj1mD/LyJFI+HUlYJVm7HGO301lav9?=
 =?us-ascii?Q?CuRZDLHu2CCbvWDGYCxfXlGgHEPMPNotaFnet5YzVkbrjV9UTooMfh6RfvOz?=
 =?us-ascii?Q?lFJRqi4DCRJ98SUAy5kY7K2jqQYT+Y1mtwagvMW2MPycDFQa62mUZANNlDIf?=
 =?us-ascii?Q?wu8kbDWrw6ZtPYE9EUwKzNaz28Dl3vXyzEidfuStUa8WBJYnpjRCg8sOs5T8?=
 =?us-ascii?Q?MBz3OPRMwAHISFsaFfHjRN5MkYY2fNGdKRP7jexkMjgWVtnDVDH53CSTR2kG?=
 =?us-ascii?Q?6HHgfVOiP0rMtXwA2vVFhoNUH4kIvxJRWqZ2GNXaeetGdtLySKJXN159hwM1?=
 =?us-ascii?Q?umnSFyLSpSZZitjn6dOPKZAsfLYcVKTccOOEmw9/F8GWblc35oi0pyGqfHza?=
 =?us-ascii?Q?ruh9BhKew0ibI1iKHTZ2kowgnGHzHw4YBI4OQ8tFi71ITy18mMuviJzdFzD5?=
 =?us-ascii?Q?paXGvezy05oASHVbGEMQZM8SF0JOSM1yGI+y+t6d8pdHZ2+kWgGNNQNEVyI4?=
 =?us-ascii?Q?DmLS+2qF3m+U1ry1MxIDcZWJu3legYSdMEcgcxlhFmFP8yj1OU54N+cht6xY?=
 =?us-ascii?Q?cNc+WpJBN6wSxali1R2ze0JQGp1zN8poGsztf9Sxi7wr6PS81yLRCZNKDuj0?=
 =?us-ascii?Q?r39rcJpDIhspjkz+j3FJyrXtnjwbiAAXCd3765wPEyoMQcg+nGCC718rUnO/?=
 =?us-ascii?Q?mkQ3h30HmLN4yfbBNdE=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8429.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2815ffc0-aedd-4569-617a-08dd2ef55d62
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2025 08:29:12.4962
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QD6oBoVHMlSUFIaGwyi69Z4JYpT6AE17wKjMg5aYOYd4fH42yn1fO+uZsXnYfUCJWZgdRs9yCbjyGEIKE3Ei3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10564



> -----Original Message-----
> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: Monday, January 6, 2025 9:45 PM
> To: Sherry Sun <sherry.sun@nxp.com>
> Cc: jirislaby@kernel.org; linux-serial@vger.kernel.org; linux-
> kernel@vger.kernel.org; imx@lists.linux.dev
> Subject: Re: [PATCH] tty: serial: fsl_lpuart: increase maximum uart_nr to=
 12
>=20
> On Mon, Jan 06, 2025 at 10:24:52AM +0000, Sherry Sun wrote:
> >
> >
> > > -----Original Message-----
> > > From: Greg KH <gregkh@linuxfoundation.org>
> > > Sent: Friday, January 3, 2025 5:08 PM
> > > To: Sherry Sun <sherry.sun@nxp.com>
> > > Cc: jirislaby@kernel.org; linux-serial@vger.kernel.org; linux-
> > > kernel@vger.kernel.org; imx@lists.linux.dev
> > > Subject: Re: [PATCH] tty: serial: fsl_lpuart: increase maximum
> > > uart_nr to 12
> > >
> > > On Fri, Jan 03, 2025 at 03:11:54PM +0800, Sherry Sun wrote:
> > > > Some SoCs like the i.MX943 have aliases for up to 12 UARTs, need
> > > > to increase UART_NR from 8 to 12 to support lpuart9-12 to avoid
> > > > initialization failures.
> > > >
> > > > Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> > > > ---
> > > >  drivers/tty/serial/fsl_lpuart.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/tty/serial/fsl_lpuart.c
> > > > b/drivers/tty/serial/fsl_lpuart.c index 57b0632a3db6..7cb1e36fdaab
> > > > 100644
> > > > --- a/drivers/tty/serial/fsl_lpuart.c
> > > > +++ b/drivers/tty/serial/fsl_lpuart.c
> > > > @@ -245,7 +245,7 @@
> > > >
> > > >  #define DRIVER_NAME	"fsl-lpuart"
> > > >  #define DEV_NAME	"ttyLP"
> > > > -#define UART_NR		8
> > > > +#define UART_NR		12
> > >
> > > Why not fix this properly and make this dynamic and get rid of the
> > > static array causing all of this problem?  That way when you get a
> > > system with 13 uarts, you will be ok :)
> > >
> >
> > Hi Greg,
> >
> > Thanks for your comment.
> > But I checked all the uart drivers under drivers/tty/serial/, UART_NR
> > is widely used, currently almost every uart driver that supports
> > multiple uart ports defines this macro, this value is needed for the
> > nr parameter of struct uart_driver, also for console index checking
> > and setup.
>=20
> Yeah, it's messy, but it can be done (for example see all of the usb-seri=
al
> devices, we don't limit the number of those ports in the system except to=
 256
> I think.)

BTW, it seems that usb-serial devices also have the max ports limit, you ca=
n
check the MAX_NUM_PORTS macro in include/linux/usb/serial.h, it was extende=
d from 8 to 16 now.

/* The maximum number of ports one device can grab at once */
#define MAX_NUM_PORTS       16

Best Regards
Sherry
