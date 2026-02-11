Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011043.outbound.protection.outlook.com [52.101.70.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541DD33F8C8;
	Wed, 11 Feb 2026 09:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770803977; cv=fail; b=jvyWOY6JP+MIDBvAQe14OBdpuLdbTuqQmefNs1h/lITAFY1eMiOa5YUrtGURaPTYq5vPBiHiK8ap/EXBdpmuRrSTsohtObVQdWr3g+60RhaXViTN42/PkVAA0fHA5avlLDXPbL9JIkLNv0Gms4tsah8gkhk/QC9zZ6XP8iDahTg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770803977; c=relaxed/simple;
	bh=/SK1m9daTQVxqkBf2JPwQoPortuhgGVKPty36sdgCEM=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BE3s8ljBHHPtX9pSet4oES7QRz9thMt2ILEAzKnAtYxLTRw2/ggbfWLmvYXNnurZSe2Tl9EAtx32oNAOCGp/+St+h9p6dA/y/gOQb/fXivVFmonFdFMFnr3i8OUG8GXiulSH2bRxCcowiO+Q2mT8Hl2yt5tE2/yx39EDX1Ep7tI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=NZYcd72a; arc=fail smtp.client-ip=52.101.70.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="NZYcd72a"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vda0D/cJq7YcS6U4n9W77lWmFgvoFoUllpAbG/jYsiEi6JJLYJoBngdEyWSUVE+9uHt401N03lAwrYMY/bw9paT7WioLLd40R7rlbsAIptwWhPNivkvHqjaf0de9UCWCl/5bLDCStfhustN8EcjhpV1BzNx9PXrgC7Dqhb2vA5EFJp0YGDj4zg7NobLm3QJ12MwEAm7ChtRDZIglZpIXyyW38LCz09NlhO/3bzzWRB7TERU4LQkisGaDNXy6znYKFQoPpL9GJckgCDrP+s9AkqdgozUYrnWihKGWEJ03i4Npih/cscJTvHIYmcOb1Vpbw/zGqSP0Y9xqMp3FxPzHjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VvvTol36JSNp0xbTw3qtERckypTujUY+gUbAJnWgoYk=;
 b=gTgnmugQvM7yruKO4iZ4avlQJF9Ad+eCr+rLi+yTQv1qnjw24dHX9Ws+26SMAf0ChURlr0lxpBKOnQ677+aOkN1luNMP5spJNC6YgR7nwNFqTIPE3cUTnJEC89lcL+xVTuTKDEzGhJDbLOnZ1In/LU4duRFWm9qHOWBMgUJ1yutpyu4g869B29W95V9FViTRZ55RCGICZ1qvRs+3jYKNnPqAbMDiVY+2EYke2tcyvU5W8ZMTEd2ZZ3YivcbI8UqJO7e3gVAWYUoLuiHp+3mGHutpzhYAaNmD1DhNl6bNBhWFjgrANBYFbZNo6VOHnrhwUN/ydy2SAsoNBebXMd8Cxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VvvTol36JSNp0xbTw3qtERckypTujUY+gUbAJnWgoYk=;
 b=NZYcd72asUYIl+jvhb+NNbOeLo0oYQO+tBeuLnn04YjWUZIL4M/5H1jmuXrcglxTb3WZWXUHFib4gdj6QcX6WypUnwhLldz1dJNEpDWzv7Wf6nfnsBLTmNCYmuAXJv97vGQxd+4jqlKjKCjhfZdWIFzmNSerMGId7HAf8jK0jhXBVOe7ezYF9Oep2ymCDqHfwdopqSupoFSZwbOLB49ceAV+sKd3B3lTXn5QugiDp/SGqnI6vkjQ4lkTR9sUz6ancHyJBG/i8cm3lG+8oAYb8rNxQp/LmL5ti6h9VltNjVVczJ/Zouq5Nynizi+ccP9kKRZwsubayB56FVlQbU/8tw==
Received: from GV2PR04MB12102.eurprd04.prod.outlook.com (2603:10a6:150:30c::7)
 by AS8PR04MB8514.eurprd04.prod.outlook.com (2603:10a6:20b:341::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Wed, 11 Feb
 2026 09:59:33 +0000
Received: from GV2PR04MB12102.eurprd04.prod.outlook.com
 ([fe80::ba38:9cef:8457:c944]) by GV2PR04MB12102.eurprd04.prod.outlook.com
 ([fe80::ba38:9cef:8457:c944%4]) with mapi id 15.20.9587.016; Wed, 11 Feb 2026
 09:59:33 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: Frank Li <frank.li@nxp.com>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, Roelf-Erik Carsjens
	<rca@thorsis.com>, Josua Mayer <josua@solid-run.com>
Subject: RE: rts-gpios support in fsl_lpuart driver?
Thread-Topic: rts-gpios support in fsl_lpuart driver?
Thread-Index: AQHcmoMt1Ew+Xwu59E6Z/smUgQK5grV8FqiAgAEtXrA=
Date: Wed, 11 Feb 2026 09:59:33 +0000
Message-ID:
 <GV2PR04MB121025846D52A63EAD9A9A44C9263A@GV2PR04MB12102.eurprd04.prod.outlook.com>
References: <20260210-rearview-hungrily-536a95fc3385@thorsis.com>
 <aYtVNxZU4tqtj2fo@lizhi-Precision-Tower-5810>
In-Reply-To: <aYtVNxZU4tqtj2fo@lizhi-Precision-Tower-5810>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR04MB12102:EE_|AS8PR04MB8514:EE_
x-ms-office365-filtering-correlation-id: 275d29a9-1927-43fe-273a-08de695441b7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?3t1yjju8K7qWiX7xPPOAk290ai2csHmjEKregCWhhO5DyiXuOq8GDRp03JW7?=
 =?us-ascii?Q?XzdZdm5ocUyxoWZynQjLEfwshU7Xi/ZsGNXzRiCVMsMd7HwPhfk1+APqFfbG?=
 =?us-ascii?Q?HiHgl7c7+F9ifUZ3tv0h9BLpmUxz8seMjfDVK1fOMUazMeRUZ+6o4uNKnKGl?=
 =?us-ascii?Q?dsSSEuN9zLDN1Q5xsdfUlFf6H/LJDu7MPJjWmJQSQpnmZQcEMO/4LuUWS1WL?=
 =?us-ascii?Q?fFe31B+jdScVv6W0QbaY9XXuLEuD1zUA3YHmXyLhxUIhm7qwapgWD/Ye/6y1?=
 =?us-ascii?Q?aQzEQrCIgF4RxZOxRLJyBlaWcJcG1oCAjV0PuBCPb5d9rfhEWzPiL9jZzmNw?=
 =?us-ascii?Q?dPFnTdz0NdVTIaNoOYUzlEFXFrpW7dinvt5+EO08XXD4gUtzLbVp7Dsj7zsT?=
 =?us-ascii?Q?QlwNgRmyTkenF7M1KDEY2Kmw0OUMz0OGUDn49IfTfj7IL59wJvOoghz1qjme?=
 =?us-ascii?Q?BwmiKfQ7hxb0IjNDkOMwQBIQXr5e6E1c4wm9YgDN0hmtzZ0fRmL3WAVxZTXN?=
 =?us-ascii?Q?0CtxdVfCY3FtdWYuG64o3K0cmBFBk42nYdNsOp3AmmAj+s+7s1MSewNyLGXu?=
 =?us-ascii?Q?d8xOnR11SeTETfq45wJ1d2037liSp262dF7egrLW4apat3qv6qD4UnPZ06aY?=
 =?us-ascii?Q?h3zRNqXxNyyIwifGck5FA8zyryU+YPnZ70PubJhT3Tc5/VvrSLbrXTB+udfb?=
 =?us-ascii?Q?vXuLFpCeCQ4siq0fPsnsN8IKLq7lHWE6m7PoOCHDv1vKfa+tg92BYbq3cMaL?=
 =?us-ascii?Q?I+BgwnrxA1I2SmdprGqNT4sVa+80QcCIlv2/6iBzCLtgRDUOSYyNTfp+WPiI?=
 =?us-ascii?Q?yzI+x8HU6MsmK/DII41qC4BzeLM5UyrHwfDb5XozHLvkHC6T2Mon7SvXBHCe?=
 =?us-ascii?Q?9qYw8ZwZJbRltmBNcQvO81DL6H9t3F0LteURzEON2L+PAvO2cydf5yWiXSS1?=
 =?us-ascii?Q?MhNg7nrBo096qNLCNxkLqixL+LCwEGaA+sg5U5QiYD2VIw84toelJYlnvSFE?=
 =?us-ascii?Q?QOX7opsHVfVizmXQSlEDhN84K12qBrpD6EQ/JNJ+T5yXV7IsDSGP5tLCzh9e?=
 =?us-ascii?Q?gqIav+gDOB/FJJhvfT66IJ3MYQfktm+bQMjt53CW+MNbSKqpOGFTNV9WaG/5?=
 =?us-ascii?Q?zxMTpQ6y+SG8Ck+nJDSjomzEgwvvt6uW8raH0MHVoVLDAEJcIkIUGp9MxAEY?=
 =?us-ascii?Q?YsotpbLpI3lGCUYKrOCoAsTrAOJkp/ondBss35NbhKScCGGlgxiao4K9aWFl?=
 =?us-ascii?Q?5R+7ZvzKv+qKTIHYD6nnBfqHvDJclskgcdLBldpstLIO8cptz1igZGAdXr/W?=
 =?us-ascii?Q?wExcgPFnElpr0UxJTKgsfl6Nne1n5ALacbc0pUy4fPGm4SreR18Q/mwIPX5J?=
 =?us-ascii?Q?mp7H2z1n/PV4RjXdvb0ylN6Bs8SU1Bkcskupb/4s95bMv0rYcOH5+xzQGgCT?=
 =?us-ascii?Q?Wsa4G9oR0Sp71o52OtzIYuZoY+XjVuPRx2fLaBH6Vby0gnLmBpHx9HnPVnyl?=
 =?us-ascii?Q?zqzZqG/Y6ypZelkujnNRn5FWlrP6ZDiSvserNJonLn84kecvxJYBhO1ABIWA?=
 =?us-ascii?Q?lbCqmkNej3JKuKEKxMihvuWbe8aAO2sCArohcOUcMpWCXwT8gvESAX14yJWn?=
 =?us-ascii?Q?Gc11LgYu4H2r+w+Vl+p17n8=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB12102.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Q4NMlsYpKrWN796o8zquTNiMcYoVJ7N/7Ti96PVkdK6s4naiumv+Cz11fMwf?=
 =?us-ascii?Q?wmPQyPZR3Pzuyvk+w4Zi+c3YiltKLirDEOxBfGZzToScQVm9WP3ymLHdx/J5?=
 =?us-ascii?Q?vyrCSFBxQABzanSKw4uUCLxuPKU/QWUtuNE2oA5LUJp0+MAYtbD8qnTZBS7Y?=
 =?us-ascii?Q?Y5ssLavJDc25BgyUrNKGcFmlxY8UxnsPFxXgQHr3fM7U7OHZF70NNnnMtR1B?=
 =?us-ascii?Q?HYJjfkqvt+CqPJXSpvqYLsAlzgsQ4KuT1fCnBVQSYfLDZuLmk0ut2qxAZUN6?=
 =?us-ascii?Q?6mnA8BKx6GkUUOiMob/puiO0iTAKLniRaoIyR3QGZG8R04yjnOnK/MA0SF8y?=
 =?us-ascii?Q?A14/kTtkkxU3vGR03BAaGqA8tucvK+LqAgZv2ouI7p+IhADDOmhKk9oDjYJJ?=
 =?us-ascii?Q?g8Te9aTZrQDbYPwu4YhvpfRSo5ANbxD/zrVR35ZrgHHJapozHrXkuIn//Opj?=
 =?us-ascii?Q?t7aKNdBEg0rEjFCNZ7mBuOUoBIiwbwtv9n6f+m4FLPax2O8jQE/HbU3lIwdC?=
 =?us-ascii?Q?3NhSG7HlkZYu+dzhSk+6HstcdCD8s1wOmN/UHCEB3aqbipYn9mdygQeqNTV8?=
 =?us-ascii?Q?FK5Ovw3mzkwszaw4gx0sNbxiNcCmAqURIRu8bQIcK+UnQhtEFXJjsRjwAH8a?=
 =?us-ascii?Q?GvJI+F6Ib+0DNRPXMhUN8G04Ga7TGtAXwavJ0QBdh5CvJ4tOqCMtFeqDdMHN?=
 =?us-ascii?Q?pcTsx9JaXZlpvutdnchEqX/bsaf/dYEMq1qDZElD+6LI8bBaL/creZOH3u4L?=
 =?us-ascii?Q?SHPn7kp3/InKzil/AkMR6AXhlslTb67bPbu048Luj1BaECF+5ggIsx8SyK3k?=
 =?us-ascii?Q?eaj+P2yvDg+S/tWvX/qI6CXSa3Cx5sk0ZMf27MPP02T1R8cjV6t5KZ8vzNdS?=
 =?us-ascii?Q?k+Ax+qOij0zjjLpJ0fJ1kzNN2D3ggXXQFA1q/FlFZUdSyPMW/FE5lKPhNM4v?=
 =?us-ascii?Q?6AzVvn/dkdLxG3t4jzcWsdnXvOi9g+L8BwfRkhzVWMneJkrqiiF1lKEN5Osl?=
 =?us-ascii?Q?EAIokA/jtYORWVG2xcu/wP9XmtqTQPxZfAhqtbeHirp56B+9BWYcvH5N7yGn?=
 =?us-ascii?Q?ozk8hsejjU34sSYixZuR/kWztbj81ekutvJhsp8jIJJTtnXmP915iPf2SRgY?=
 =?us-ascii?Q?UDUSbDHtzY1ycKXWDoW6Z4Lc2nieP4gC3QolqzAcNVlCXHCk6Rs0786PYWFA?=
 =?us-ascii?Q?O6igxt/WR99me8679o2GYotusTuag2ZGlN0XEbcwKT0honTR8XWbffmanMdi?=
 =?us-ascii?Q?gfQLeyvLEOrLIf3drOHsh/Cjpg9fKZ/ALgSGA+nkEYx/u5ZAjSaMWImvLGMj?=
 =?us-ascii?Q?yp0/PHVuGcDQxkw4/A+r/wrQekGltUaPpp1TiaqkA6GoQcZ4nvKgHxyTN6dU?=
 =?us-ascii?Q?5lfkseCJAzhYCyjj2GDyrA/JAFv2fC1gl78/02qBI1Kh4+QwJ0AlrVLYzHEj?=
 =?us-ascii?Q?Qtzi6kFImE7wKdXvYjYNP8s9lcYqxyMtpY6a9n08UaL4T7gepuTqqi8P6jtB?=
 =?us-ascii?Q?X8rzLBbGjAlY/LFRFyi2EQEM1CRb/K9n7rJ9ZU6NrnyY7xm/K+9Uao7ykzkk?=
 =?us-ascii?Q?/SUKVQWGSk6L11TGprDDtD733oWHhPJ+6KXCHIlfksvWR5bzykHpXcXgVJMY?=
 =?us-ascii?Q?518/0qwC8/4/weplOERsD9qdB+8EL4gspRP5UV18LZvsHKXiR5pUB/spP8G4?=
 =?us-ascii?Q?fXL6ycBXcPhk9o2piFzsAPTyHHQbmkhl8LPrlP8ZL+sQT+oU?=
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
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB12102.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 275d29a9-1927-43fe-273a-08de695441b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2026 09:59:33.3397
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mXWG6OV6hNQs7yxIWPV+QvoTPRadO/UMSh5ZWy1xmVS6ZoQdto45cA9cKdAA5myRisOsUGpLnSPiWLK/geL3aQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8514

> Subject: Re: rts-gpios support in fsl_lpuart driver?
>=20
> On Tue, Feb 10, 2026 at 12:48:05PM +0100, Alexander Dahl wrote:
> > Hello everyone,
>=20
> Add sherry. look like we have not implemented it at lpuart.

Yes, currently the lpuart driver only supports auto RS-485 RTS mode.
We haven't received any requests for sw-controlled RTS mode (rts-gpio).
We can consider adding this feature in the future if such requests arise.

Best Regards
Sherry
>=20
> Frank
> >
> > we are currently experimenting with the SolidRun 8XLite SoM featuring
> > an i.MX 8XLite SoC on a custom base board.  Due to how our peripheral
> > hardware is connected we need to use rs485 with uart3, which has no
> > native soc controlled rts line.  On different SoCs you just use
> > 'rts-gpios' in devicetree then, letting the kernel switch this line
> > through gpio.  Alas it does not work on this SoC, the RTS line is not
> > switched at all. :-/
> >
> > According to my analysis the i.MX8 family has different variants using
> > different uarts with different drivers.  For the variants using the
> > imx.c driver, you find dts files using rts-gpios, but for variants
> > using the fsl_lpuart.c driver you find none.
> >
> > The rts-gpios property is evaluated by the serial core in
> > `mctrl_gpio_init()` right?  And the actual switching is also done
> > through that mctrl_gpio interface, right?  As far as I understand the
> > source code, the serial core calls the .set_mctrl function pointer,
> > and then it is up to the driver what to do?  Some (like atmel_serial.c
> > and imx.c) call mctrl_gpio_set() in the function mapped to that
> > pointer, some (like fsl_lpuart.c) don't.  Correct so far?
> >
> > Up to this point I'm somewhat confused this is no generic feature in
> > the core which works for any uart, but there's probably a reason for
> > that?  Maybe interaction with the actual uart registers in some way?
> >
> > If it is like described, I'd say the fsl_lpuart driver currently just
> > does not support this usecase?  Is it possible to implement the
> > necessary things?  Is anybody already working on that?  I looked in my
> > mailing list archive and in the imx downstream kernel, but could not
> > find any hints.
> >
> > Any advice welcome. :-)
> >
> > Greets
> > Alex
> >
