Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2058.outbound.protection.outlook.com [40.107.104.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298C71591EA;
	Mon,  6 Jan 2025 10:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736159102; cv=fail; b=grmnWZLnbwORFj2DuoU/RyDtqdRD6Wd6pBi1FxTewC8857cbpWCjJSUOAha9WETxZ0GKVApJMJD+1vQlhP+OT1b6HuKLe4M5pMaZbHgOJL2vo5insb7JQUb0sIh8FuYtccRXgTDQKIYXKofr981eWzSzFsKf+qLmCJ8CgDCR5bc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736159102; c=relaxed/simple;
	bh=SxfnXzacwQeHW1OA+70R+XgpLqs68tiM/2Q+nq6vwTk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uK3eJJrs0wqXR32NVh0Ggolz4X5Aqfny8rfO02xJHGqMLNS/EjJFplx5WmjnHR7d4LSI/1AHhJF9Wql7vKWJTamsUFY0W58TDnc23+nJTrEaKwSc10542231JP/dcJ+lwdH0xSFdJxS/TyMBnWuqzysbSIHn0r17+cfi16iseic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=eO+SyKqw; arc=fail smtp.client-ip=40.107.104.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="eO+SyKqw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cPbWnjXOmysG+WS/rHGBZiq305hCgERBEJE4tMsbi0aMXIU4leA8j6mDNMHVKZ9n3OFWpnXbADc1E2QET/IHG5idc57OO/+aYqj7jfvwzdhtr6i4qRYKhdZV5PHm+epX3ne4NoEn0DoQ5WMHQgk44TSMwre18mBY4QsbnSBCJ5tQoFG/3ro35i9TjrJRt1niF4A8SBDADnLjwQ6yFa0quqN6IdCBFNnui5jDvkI4LvIGNbRJM9xuM1+0sKXuIS7ti36iwX4CjK+wWLx/w4NU/pKbq5gHmAGwNaswQui9J+EiHnBqK8y/pqxMcdMk508Gtc+zuXSTK5yb3Ss3BDd0dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZiNKqFg237bIKV5PZ4e9qFYSKjcj0Gn5KbNlk44MGLs=;
 b=lCpAmwE+0B83Yu231/RmH4aRjBkfohrLhNRyU/jKzvBr3x+EFxZ5r9lqc2gfceS0kwXLNROqARWrzzszSRMfvy6QO9F+Qq4ZTv9FB/CJ1qcSwxk/8ti0RGn9JDY3Bma0pEIEo2uiwwhKJfE6rRrDskuPyWM0Kl1859vfeFgq9ICT/v1JACRuNvviAf6A0Sw9VRNgVkUx0hT7A+liWj/SllbTxt5Fw8KqN2RavQ+yQPgyBqB+O506wwW1+4v9h+zg+QSMqIYcVus62Jduj9SgqFJxUbIYu7ayHpVpPnAj/0qco4ITbPl+I5NqjfwDZI7hMn46H0AxfTVKieWKAtRHPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZiNKqFg237bIKV5PZ4e9qFYSKjcj0Gn5KbNlk44MGLs=;
 b=eO+SyKqw71LTHU9H3i3omEsnq0sVCaxCxtn8HTKnqCVA7DjkAZ1bhZ1lx7FNYGH/gJYAL1LEa3ozU15uvgrHlInfnz+eTJ40EakTiyxyWO/l6RQjgMTM7aIndzugFwP7Me0smquIKDqtdTzkfBjNG0OdHLj9sAwxI38TN0qJgipITVbrf4zqDW6whbwrxr6HSvB2HtWrdyA+FtobcsoYe/lFyTtFSlvgDAa+ZwDkgQT0RMHWiNKOpyOnHiJfpSMns9mZDl+Q5ZmQRkFCnUT2FVU/3f5/Qy9yR8qLYUhNPlNtq1MCK/cS6+gB6tpz5DmGm1eLlvVe6Y/UHL9edRSbAg==
Received: from DB9PR04MB8429.eurprd04.prod.outlook.com (2603:10a6:10:242::19)
 by VI1PR04MB10052.eurprd04.prod.outlook.com (2603:10a6:800:1db::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.16; Mon, 6 Jan
 2025 10:24:52 +0000
Received: from DB9PR04MB8429.eurprd04.prod.outlook.com
 ([fe80::2edf:edc4:794f:4e37]) by DB9PR04MB8429.eurprd04.prod.outlook.com
 ([fe80::2edf:edc4:794f:4e37%5]) with mapi id 15.20.8314.015; Mon, 6 Jan 2025
 10:24:52 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: "jirislaby@kernel.org" <jirislaby@kernel.org>,
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH] tty: serial: fsl_lpuart: increase maximum uart_nr to 12
Thread-Topic: [PATCH] tty: serial: fsl_lpuart: increase maximum uart_nr to 12
Thread-Index: AQHbXa8xeDDJ4lnkCkiOGzKD/DUd4LMEwrkAgASWmwA=
Date: Mon, 6 Jan 2025 10:24:52 +0000
Message-ID:
 <DB9PR04MB842950C5700AEE30968FA1CC92102@DB9PR04MB8429.eurprd04.prod.outlook.com>
References: <20250103071154.3070924-1-sherry.sun@nxp.com>
 <2025010351-overlap-matchless-5c00@gregkh>
In-Reply-To: <2025010351-overlap-matchless-5c00@gregkh>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR04MB8429:EE_|VI1PR04MB10052:EE_
x-ms-office365-filtering-correlation-id: cff02b5c-acca-40d1-3d66-08dd2e3c5b6e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?qqWIvKXy37GVXIRDY49KWWW8apKfVCeGpJskHxfQZz+dXf6NMaK2Z1WzbVsf?=
 =?us-ascii?Q?iD5ER90Dow4C2HMkTXaQQhtLLkmKjXaxNhkvCuCReynmkE3cn3cE9NQWsgao?=
 =?us-ascii?Q?5S7HBWBLNtT2BabOl+0L8LerCFBEILJJlD+oYjdKRwWr3qH8j7RjHtoth6m6?=
 =?us-ascii?Q?AsxEcfkUMl3cZOWea7+hMCUCNjKPulfqtUNqEbLpmxmTyBCmWu1RT6qrfawF?=
 =?us-ascii?Q?i4XwqWJot/6/jWGXLiz9vd47aTbNPNCR8YWHHEcmEIomCRExoEMyNs9tHtcS?=
 =?us-ascii?Q?VqBfNBwT/wyqAEPt378v5glIf31YRKZmov4vuegSIdcuuQdGiGTQmWOYEf5c?=
 =?us-ascii?Q?4L1fpTbsnoz1qdmGkLEPl3Rg50khw+jL0qjOUpHdwrj5LI5av1bCxt1gzpH/?=
 =?us-ascii?Q?KCmdNylI6oNkVKJAxnoUdDAofQ3m7WWb5s8jmRyMLcNFxwwp5GzLjkMsjGB/?=
 =?us-ascii?Q?Ru9X6yYPttaVE8DY16uLkIamEXqE3qTAg/3p9w3hd06eXnBUwjeYApzgPF3P?=
 =?us-ascii?Q?tzOB9O13xlSmeyY5+Pocf7gsiJTUaNtr19rn0GA/8fGC7VV5503TfYYHZd1u?=
 =?us-ascii?Q?ZzTGtJ+POMwa0pSiRQWnkOVO/ZDNntK2uIEjsxvMcyU4OexOa8Ysj6JBGvTa?=
 =?us-ascii?Q?a6iuTkgxc1ipXPIHnSUEYt6SIqoRNgivPJq1FlWHEzNFSUXgd426YKZukExo?=
 =?us-ascii?Q?rZYfqVeGA5Bzaot00H9LCn/GX3NwtvVczdNQNA7DXP+aG4b1Ai7gQjkwn/F7?=
 =?us-ascii?Q?MUYJoUA/bpzKM1Ch6xMo/aD1/0nTGT5J504VCqRgyebyelUGtcYd/qHAJ/a7?=
 =?us-ascii?Q?8W3symuPZ9TKZTE/8D1mNpxC4CsNhSraKN6TqRaSieweut1toL0NHqC7vJEf?=
 =?us-ascii?Q?gn+xU3qG6nQyPX13zEMd3CgL/ZhkblhWbpy1j5KyCUN22nEY1vQmug7IlGLG?=
 =?us-ascii?Q?hhfSsxkhmOFx6Ixi4ZIrKkqLUHTBrbmG5heePDVq+wLKHFtXa0/tUdnB0gsb?=
 =?us-ascii?Q?JwwoHjnuICIjwL+eRV3mlngYqiKERwU7B5PwWdfRYkkUm6BdR1jpaPVdI23F?=
 =?us-ascii?Q?9ijg+0KUIVhjQ+i6oX4vSu8LAuR4yPGBq9D+VGGh1GwWByLK7CKz8daZxKVj?=
 =?us-ascii?Q?FT6DF7oCcI7zRI53PHO6s/J9JEX2zpvulQzY+D4xtXhFEwCSbM3hed+zNyev?=
 =?us-ascii?Q?Dzvu6RX4jgit3jAE1+vhvv62as+83PmyANOa7L2p5jWgUXfjCE7/4Q7m+oF9?=
 =?us-ascii?Q?+PLgDK4D/PrnCdh7y8LuNxY3VK11DvQZfr8WLyXlQm8FRjngYrpUBHiiMLrk?=
 =?us-ascii?Q?javHyahqp0mKVbgu+bKrkbZSWCv+OxtGLosIfZwEnDnvf04zxPmAI6yHw6Ch?=
 =?us-ascii?Q?xvvvBmabe9XjsuuQHdLOmuWFqe8LMBVbOk5I8YWXnXQfNNuld4SpIJA6qjaJ?=
 =?us-ascii?Q?ntE/q/I8abCu9kCupkx3qEQmw2BI05hD?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8429.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?32dn5BZ6HMINJAn3hsvFD9NzUZdRPWg7XzWXz7FV5mePrw+S3vAqBUs+MnEB?=
 =?us-ascii?Q?LeuuVhtEQdqR+VJInHJGB1OUyCH8xfnTlbtKcgeOYJIE96hI3EQw6sz0avNF?=
 =?us-ascii?Q?uE0tIABVNU0p/UJVa3xXCgDLq+klyIsNc1qasySHoQu64vyFaJgumNpL87rb?=
 =?us-ascii?Q?c/FF/1qmCfAO3Kfc5LuYgczm+0jCUpJ4Uv+SL+MdPiAToW8xLgcP4NP/4VWr?=
 =?us-ascii?Q?b2KZZBY0kUnSdIGzpz4EAikZ5HZfjZkxt010xq9peD9rv8AK52a2ETMzhxhz?=
 =?us-ascii?Q?dqdNtQgsU9RuYK0nGuu0fD5MsGR3UhBnnR7KAd779XrsxsB7mOSR1zW94JCL?=
 =?us-ascii?Q?gKBGs5S81t7d3cxBpKncQOB4Qqk9IVySCK7kcZtx9qRdrn6jYiiTa9plKdP1?=
 =?us-ascii?Q?qqvezESJzLvrpzrOZ1pP3JTa9QtH80TlheAMepYZ1K4kx1ss0XO9cOspJIII?=
 =?us-ascii?Q?xDMA5oCP2VJAsDJP2wB30Xb+6VP+b8EQaokveREoBC2qjwMCf8CKVQ8+eWjB?=
 =?us-ascii?Q?GvlBnWEVx+ib/yQUpgT0UNuqP25zUc2fFfuhDZzIogPuQqFxjPX8ngy9tyMg?=
 =?us-ascii?Q?pi2txgTpP5BneU2juHCpxpDNkQGWZXlRWvj1RUoxaZpjSdY+H60A5U1dLQk7?=
 =?us-ascii?Q?d2EOy+7kG/6X0RGWBHX7b+5JE87R7AvXqKBB1qNgeVFV1a4c5c9ptx63OcJU?=
 =?us-ascii?Q?nPQdnocsU3KFJ3TJciJ1aCMwmbql1ZAtzpI01x0pNFJlHIyK1fW7046LxZX/?=
 =?us-ascii?Q?MnAVeUDkD2J6crMX9ZLpAKliZdGqzJgp5awGqxEgcciXJSSjWtggDXG7J9Av?=
 =?us-ascii?Q?7NWe1/gsCNaUtdlGFXv5RNHdQxxdE+GGryIC7Guj+Ydtt0d55VQy8KJKudtP?=
 =?us-ascii?Q?+qsVJkgcPV5NE+jZ+LpgLCiGRitwvAzm8HJk54Xj1sg9q7qJ86eXlMfx3G1A?=
 =?us-ascii?Q?oNSx7aywuhXhKoob8NvD/Nh2SP8OFFw7Js2AevI2Mt8NghWFX0peBzEKu1MH?=
 =?us-ascii?Q?rfIonEdsHfiFnovFhT0I3e6OyR6QG0A2Ow0Ux0t9jrNy6Vw+OLmDxa/3Brel?=
 =?us-ascii?Q?zfNqkb2IvAnTuDxOQx6LPZ5xwgHDxAVfxAHBI4XqdfQVlXYnuDWVLFTHlr9j?=
 =?us-ascii?Q?8CA8Q5Vz6t30/E3KeO/24SdxiPaya6wMNI2v19Mh8EfOCGoXCgVuIS6dhN2V?=
 =?us-ascii?Q?hmh5nD6YYSmMkFTwtJaEBi4wT90+K4plxxLDF3Ff3yqRoDrZr3biezrdX0+1?=
 =?us-ascii?Q?BQJZy9U/ekUxS8zWigBq1eAdMM7eLAU443P5ptNtSveyDxJKqHER8crGS/ga?=
 =?us-ascii?Q?mFSoeqdUFo5+zFZRYmg1MBGZUlHDt7dGZa/K+WnfUJDOtMA649n9rNUl6z5A?=
 =?us-ascii?Q?q5LCCkrfumWtdaxClVG5JLXAQG2R1Q7zea5/9uR7JC8r2tfpfneB8jk6s/27?=
 =?us-ascii?Q?aaY/zj5bzWdPD9KPetbOsvJkfZwC7Z2oAIatwT0BLDl9BJzRFj/RqdGlyjo+?=
 =?us-ascii?Q?m2feSzgde9gOacypwl8uiC63Frva6Uos1OJI1ItmcQi1tS/w1xKQkvzs7m8z?=
 =?us-ascii?Q?KRkf0ajWzf2uwElBo1U=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: cff02b5c-acca-40d1-3d66-08dd2e3c5b6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2025 10:24:52.3028
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ihanOPS9IcVca2VVWOTL7++lucumPalxQyBnyHdqAVKhrXAF1TJyfrZcVz5SmZe8rcuaboTJahDfG07nDSW6zQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB10052



> -----Original Message-----
> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: Friday, January 3, 2025 5:08 PM
> To: Sherry Sun <sherry.sun@nxp.com>
> Cc: jirislaby@kernel.org; linux-serial@vger.kernel.org; linux-
> kernel@vger.kernel.org; imx@lists.linux.dev
> Subject: Re: [PATCH] tty: serial: fsl_lpuart: increase maximum uart_nr to=
 12
>=20
> On Fri, Jan 03, 2025 at 03:11:54PM +0800, Sherry Sun wrote:
> > Some SoCs like the i.MX943 have aliases for up to 12 UARTs, need to
> > increase UART_NR from 8 to 12 to support lpuart9-12 to avoid
> > initialization failures.
> >
> > Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> > ---
> >  drivers/tty/serial/fsl_lpuart.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/tty/serial/fsl_lpuart.c
> > b/drivers/tty/serial/fsl_lpuart.c index 57b0632a3db6..7cb1e36fdaab
> > 100644
> > --- a/drivers/tty/serial/fsl_lpuart.c
> > +++ b/drivers/tty/serial/fsl_lpuart.c
> > @@ -245,7 +245,7 @@
> >
> >  #define DRIVER_NAME	"fsl-lpuart"
> >  #define DEV_NAME	"ttyLP"
> > -#define UART_NR		8
> > +#define UART_NR		12
>=20
> Why not fix this properly and make this dynamic and get rid of the static=
 array
> causing all of this problem?  That way when you get a system with 13 uart=
s,
> you will be ok :)
>=20

Hi Greg,

Thanks for your comment.
But I checked all the uart drivers under drivers/tty/serial/, UART_NR is wi=
dely used, currently almost every uart driver that supports multiple uart p=
orts defines this macro, this value is needed for the nr parameter of struc=
t uart_driver, also for console index checking and setup.
This patch just refers to many other uart driver patches to extend maximum =
uart number, such as https://lore.kernel.org/all/20240112095300.2004878-3-v=
alentin.caron@foss.st.com/.
Agree that it will be nice to dynamically allocate everything, but for now =
I prefer to simply change this value as there doesn't seem to be a good uar=
t implementation at the moment, not sure what you prefer?  :)

Best Regards
Sherry
