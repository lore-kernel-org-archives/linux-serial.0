Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2124.outbound.protection.outlook.com [40.107.93.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B5551C27
	for <linux-serial@vger.kernel.org>; Thu, 11 Jan 2024 17:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cornelisnetworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cornelisnetworks.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b="WvXbB35n"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NuZI2e3R7UBnZXEEnLTCXedqh0bEtauV+sO8pMVJXrTxPk6ItSFg6wQXRM0Kmx34kHC77b18bNX+Oph4ljn+aPkj3KDnDxCJUMXtFsPW/f/L+BAtzb60x7+6+pE7SxXt1MqB4Ewxi7Kclbuh0JU9h+7qfs3Le0eOl7s1ZeNUWctvY2rHtQLV29XLIYznQgtYmdZbqXtV6hYlzvnIKFj540Ubs71QTqiQa+VhevWzgWnNY/9EEZvqEcdkdbfy+TqqYUU42ujRiSHXhVSe+HyXZFJ69oXg9docPQIF9IQEVz8eWhy/AhYEcIc/Q+NZkA5Z0es7rI7MNLrrtfytl3LJ5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=61/t0qMAXlAxM8R+X99LmC+ur0MJW43uRwHcSoc9Agk=;
 b=SSUp47U04+QunnPqd9O/WUJ5lSnbW5yedNKbIZDUFchgV4NJn8h5EGIwh4Tn4BdhFxvztwvGh/cxIqiof/X07B68E/70q3K+uB8LHKsteo/1vhNfg9Pwf6QD3CaBfj8FcNQVwhgPHgb7YBx6rdWBNWtqEBngySp+Y03GM1jhi14FutfXKeblfYIKIL4LO3SsdNRNv0brA3wZgX3AmpJ35es7PDr33OMVcMgaKVShz8vepm3Z7zb3LqlfKIEeh7CJ45g7+Ogzko7evDMMIIB+2ETDqZmyhMobga0sJYzpr97dXsX2PKQ+IZDInytmf4X8DDLFz+chOR1rwau28+p3IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=61/t0qMAXlAxM8R+X99LmC+ur0MJW43uRwHcSoc9Agk=;
 b=WvXbB35n39ajHqkZkHNvkDlG8wvQYGbqZa1tnFgVpRblPdIHJHEQDZghXAtKIbxNkv1ioAh9V9mTXIDZCFL1gxyc99GoPX6k0OULU0OdfBA9cT/F57Fe6Su2HpnVqqizcOIVo3Woaq7MUSy6p5ZBmKdhRakt6KrN9FNgMFkZQb1U3dEjbeUHkWyJ/Jht8r//J2xBhTbIJwaxFU5R/NAld90w4ZvLGY7Ha8WyNuna94DH3lgwhfRKswLNmDcH1TROFER5umML2R6PygsDKa9Q3KW9XgJ0cb6a9BNY43X2E7/719dAVfaBtT92m+uoX1dWRd+Pj4RU9ALGyvmn65hJyQ==
Received: from BY5PR01MB5635.prod.exchangelabs.com (2603:10b6:a03:1a9::29) by
 SN7PR01MB7921.prod.exchangelabs.com (2603:10b6:806:342::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7181.19; Thu, 11 Jan 2024 17:52:18 +0000
Received: from BY5PR01MB5635.prod.exchangelabs.com
 ([fe80::46d2:6053:23de:c858]) by BY5PR01MB5635.prod.exchangelabs.com
 ([fe80::46d2:6053:23de:c858%3]) with mapi id 15.20.7181.019; Thu, 11 Jan 2024
 17:52:18 +0000
From: "Srinivasan, Usha" <usha.srinivasan@cornelisnetworks.com>
To: Hugo Villeneuve <hugo@hugovil.com>
CC: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
Subject: RE: max14830 irq
Thread-Topic: max14830 irq
Thread-Index:
 AdpCZgM5EpVKR9TvQJaVhp41Fise0gAHCR4AACRxtcAAQIMEgAAEhkhwACGgiYAAAgv4oA==
Date: Thu, 11 Jan 2024 17:52:18 +0000
Message-ID:
 <BY5PR01MB56351BA462070C585273B3909E682@BY5PR01MB5635.prod.exchangelabs.com>
References:
 <DM4PR01MB75952BAB0B535CF832C89AD99E6B2@DM4PR01MB7595.prod.exchangelabs.com>
	<20240108172934.c457ca06b6543f868d32de46@hugovil.com>
	<DM4PR01MB75959DD41CC90B1B704A05D29E6A2@DM4PR01MB7595.prod.exchangelabs.com>
	<20240110174015.6f20195fde08e5c9e64e5675@hugovil.com>
	<BY5PR01MB5635A9264220404AA6EA5C089E682@BY5PR01MB5635.prod.exchangelabs.com>
 <20240111115239.63d408a688b1b8783de3064f@hugovil.com>
In-Reply-To: <20240111115239.63d408a688b1b8783de3064f@hugovil.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornelisnetworks.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR01MB5635:EE_|SN7PR01MB7921:EE_
x-ms-office365-filtering-correlation-id: 4ba8f03c-964a-425d-d10c-08dc12ce0dc3
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Jbmwy+fJWgIqAHaJe/chQHV+bMSeve8ueHXndC2hB1Sg7R2c7PfDu7jZ5cKvs0ewFb8I7lRMMlSqznzEBCANPoWTghMetAak7XAUh7lGJfo27e6SP3L6NR9zCLyWOLJBIIzKa0UecFBDlr/0Q4ELR54TGJ8h3hJMWD4jayBAtgw10Al/lbeYImWTEQCQ+OjwPBUVj5M5dJxIqC8hC70XD+xFYTzkEMhfP6Z6yoRTwUYzEH81TRv7gz5dWiG9vqY3Vg6tBxUJw5RhX4zX1U8fAaLBoif3QEaVzSV6GychUMuO6cTWTNvZ3KQoVb9YY57JJuMx+oU8SYxTQJaWfXWwsWO6UHr+TFcQHSM0S0ECYLb2vdMPwyU0sNy0TwV7Lv/fQZ/IVUwv63/s0lQaeWNe/KARruf/AP3zfqd3IYIajFdTjJAs4qFe+FcCimvoNXm3+lcvp0kUqEAfjQg7RiYLd4r8CDEsmXHE5hQd+r+ub6hDiUSZG/D3OaxPdzG+LzsOrDuDsO8wEXMez7+l4yoSfGHXld0B/wzULmKUPMtDyZ0tjGHgNlQ1PfocePAumzU240/bUrbH4e6ry46HuRB/yqpI5J2rjQDY1YEut+MGYeUQRM2yjHl4BGnGJ5Voi/k1YWe6zJCIelVSHmJKp3bcf/Qj9vCR+jPqFYoN4yur4yE=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR01MB5635.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(396003)(136003)(376002)(39840400004)(230173577357003)(230273577357003)(186009)(64100799003)(451199024)(1800799012)(55016003)(38070700009)(6506007)(7696005)(2906002)(71200400001)(5660300002)(9686003)(53546011)(4326008)(316002)(66556008)(66476007)(64756008)(8936002)(66446008)(8676002)(7116003)(66946007)(6916009)(76116006)(122000001)(83380400001)(38100700002)(478600001)(52536014)(86362001)(41300700001)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?AJD4viqz0VA06UsNQ1n7vllpVwFIpW5FSvwphkbj7vwCiXBQZEIwnx60AP5A?=
 =?us-ascii?Q?tWqzP+gp1uk/NxAlQ8GUPdXqLzmt1NQx7BpBcLt9sBZk71Ml1Xpoh5+AiOkR?=
 =?us-ascii?Q?NOk+YvtirGDtjynI2cJUqDab9YAlQrG62L2FRaQFANyGz6qNd5Wk30GJd/Ej?=
 =?us-ascii?Q?lZRyfdJGrBtxVxBSXGv4Z8jEfVJhSoYysQPHDUyn9qHuuVz91m3EFbJQfdNM?=
 =?us-ascii?Q?mN6r2llC6TyrQ+lE+0H7tL4xzlGm8f2t8lpP5M6vDv6WxkQ70FThLPRbU00j?=
 =?us-ascii?Q?buEfmD8T0K1dvyvA7I78xi6z13w4lr81/HgT4A+Ne6uTBlbxOHDBT4b60QL9?=
 =?us-ascii?Q?0IpK2z9jYAFzch110iG3wt2zCW5F8BAoZ7WW5vYYL2DcoXdFzMqajDfkvhEl?=
 =?us-ascii?Q?rJLLMkzxVt3K0BpfptDjhCl+tGa5KnPgdgsC6onZbsxidHk3f3NLkR/9rYnX?=
 =?us-ascii?Q?aEIydJhX0syOGM/OdxG5eGdjhWACX/agepzJhpCAtd40Ln8yr5owH/DB6DXA?=
 =?us-ascii?Q?S1aBlw1GuwEQDO3nVm94yJ0U+V+I+CURoccrmLw7FWxgiEZ7z/1sQC3AyMsF?=
 =?us-ascii?Q?pE91cMtDtA4+KhmSCJlYWvLGfxmzl9ct+8CFHU0aY3o0ugbSRNnw57nKX6ff?=
 =?us-ascii?Q?CfiAZ5c/eQzzpwSz93IgCjvqNtcxTXnCA44bqoTQNWKko5wrsMcVLoKzcr6l?=
 =?us-ascii?Q?L4JEBZzVlNX+CziEz70Ing5vJtb49hzto4YBt5Q4TrgRjKBxs5boqPctXFLd?=
 =?us-ascii?Q?TcN3gOnRmM8y7RkHeaUeKQ5m4vjnotOsxYrXVYBLIgKrlK5MPwfv0xzQIauN?=
 =?us-ascii?Q?tkEJQTBxWjhZ+loLEEAFnABTr20keRGEgxjhUxQqaFs/i2r5s5pIc1RE5wyT?=
 =?us-ascii?Q?T8QDwyer5M369PxAMQ4/9wWeUTAnS0EPBLXkz/pvwniyiHj1ZKhjLIFvrQAO?=
 =?us-ascii?Q?dyj4HUfxGPPZBDJ4FO2+mDOe4rDt5sWwh037YZQVhTydLEpUsVDCuoUyKaiS?=
 =?us-ascii?Q?OreaxR5fEL4eDSMtcoGDnGOskE1FxwN1X1LUNPFMpRGzs+oCw6PqXisVp9AO?=
 =?us-ascii?Q?+zdldHwqvZHMqPyz9yrZwAjB93zvRzqEMbxA4sjVTn7Zn0ZIF6b4Lb0FtJ7t?=
 =?us-ascii?Q?HE6VFBjrOcDLO06SwAOG6agDJKjdTrYtSGGthj2eSSAcA5WfAwADfI9g//a5?=
 =?us-ascii?Q?Ii+VO19J1LgyyVB1www2ZwA6GdZwdKQq6lVNpwCq+ezPeSsLpdZt32sn2UHT?=
 =?us-ascii?Q?GSY+ZUMI0xpv8fMXSw7i66G2YmFDp6v7f+lWL8+R1+oLmNHS7DahF9kTAaH9?=
 =?us-ascii?Q?jqFtlwYEfk0xhl3qUsr7VFn168/kRx3Zt8Lhelo05xuuAWZFL+/e1Hx+e01v?=
 =?us-ascii?Q?Mu2QPmxxDvCymjCdIwzFhYApAl9ZeCd9zmOjsuAdm2UNuqGPWAEKTo7UuFxf?=
 =?us-ascii?Q?aHKcMdwaJRp+GxarkFwsyXkKB2nssyYzZHw1N5qvxEnE2qBCZlWYs9gk+Zn3?=
 =?us-ascii?Q?qWhFeiMOC0vCJPSDziOIgDUFlvIkCPpX1fSrrfosHLmQXMF/nI50IgOwZ5p4?=
 =?us-ascii?Q?LRz7oG8G5fDmYomZznSs3C1RqJlsy39UphvcC1J85iW1k7n2jLAJDZkCpJB3?=
 =?us-ascii?Q?nb/kO/UbzXhHv2YfQcBuQzDV3A+PXrWeZrpRJtJUtU4fTI+5Qdv1e7RHT627?=
 =?us-ascii?Q?fvwlLw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR01MB5635.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ba8f03c-964a-425d-d10c-08dc12ce0dc3
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2024 17:52:18.2776
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uigOHXQgEej7E3Vyk6BJp3PGwGSAmLCIlTDr1GTIgd9wyi8hvv6jof7oID4OW6mVtkFiq4vB99g1YoIPBVwIrE/3FjM3tTvUsgvdCPui47g913cBckhtQT+ZBu7vkiln
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR01MB7921

Hi, Hugo.
Sadly, yes, I even tried a ridiculous msleep(1000) but I still get
[    3.671189] max310x 11-006c: clock is not stable yet
[    4.791122] max310x 11-0061: clock is not stable yet
[    5.911719] max310x 11-0062: clock is not stable yet
[   90.951252] max310x 11-0064: clock is not stable yet
[  178.631326] max310x 11-0065: clock is not stable yet

Thanks,
Usha
> -----Original Message-----
> From: Hugo Villeneuve <hugo@hugovil.com>
> Sent: Thursday, January 11, 2024 11:53 AM
> To: Srinivasan, Usha <usha.srinivasan@cornelisnetworks.com>
> Cc: linux-serial@vger.kernel.org
> Subject: Re: max14830 irq
>
> On Thu, 11 Jan 2024 00:55:57 +0000
> "Srinivasan, Usha" <usha.srinivasan@cornelisnetworks.com> wrote:
>
> > Hi, Hugo.
> > Thank you. Yes, I have clock source set to xtal and thanks for the tip =
on the
> delay you shared. I think my issue may be due to how I defined my interru=
pts in
> the dts file for the arm.  Thanks again for your feedback!
> > Usha
>
> Hi Usha,
> if you have time, I would appreciate if you could confirm if the "stable =
clock"
> warning disapears when increasing the delay to 100ms?
>
> Thank you,
> Hugo.
>
>
> >
> > > -----Original Message-----
> > > From: Hugo Villeneuve <hugo@hugovil.com>
> > > Sent: Wednesday, January 10, 2024 5:40 PM
> > > To: Srinivasan, Usha <usha.srinivasan@cornelisnetworks.com>
> > > Cc: linux-serial@vger.kernel.org
> > > Subject: Re: max14830 irq
> > >
> > > On Tue, 9 Jan 2024 21:25:03 +0000
> > > "Srinivasan, Usha" <usha.srinivasan@cornelisnetworks.com> wrote:
> > >
> > > > Hi Hugo.
> > > > Thanks so much for your response.
> > > >
> > > > I was building with 6.1 had one patch but not the other.  I
> > > > brought over the
> > > 2nd patch as well but made no difference.
> > > >
> > > > I switched from 6.1 to 6.6 which has both patches and still the sam=
e issue.
> > > >
> > > > What do you suggest next?
> > > > Usha
> > >
> > > Hi,
> > > let's hope that someone with more experience with this IC can help yo=
u.
> > >
> > > In the meantime, see my comments below...
> > >
> > >
> > > > > -----Original Message-----
> > > > > From: Hugo Villeneuve <hugo@hugovil.com>
> > > > > Sent: Monday, January 8, 2024 5:30 PM
> > > > > To: Srinivasan, Usha <usha.srinivasan@cornelisnetworks.com>
> > > > > Cc: linux-serial@vger.kernel.org
> > > > > Subject: Re: max14830 irq
> > > > >
> > > > > On Mon, 8 Jan 2024 19:08:08 +0000 "Srinivasan, Usha"
> > > > > <usha.srinivasan@cornelisnetworks.com> wrote:
> > > > >
> > > > > > Hello,
> > > > > > I am trying to get max14830 working on our platform and I'm
> > > > > > seeing a stack
> > > > > trace for each of the UARTs in my device tree.  I'm not sure
> > > > > what the fix is.  I'm running 6.1.15-580639a (OpenBMC 2.14.0) on
> > > > > ASPEED ast2600.  Any help appreciated.
> > > > > > [    2.608620] max310x 11-006c: clock is not stable yet
> > >
> > > I assume that your clock source is defined as a crystal (xtal) in
> > > your device tree. Is it really the case (xtal vs oscillator)?
> > >
> > > If yes, do you see this warning message every time? I noticed that
> > > Boundary devices have a patch in their private repo where they
> > > increased the delay to detect a stable crystal from 10ms to 100ms (bu=
t they
> do not explain why).
> > >
> > > Can you try that:
> > >
> > > @@ -610,7 +610,7 @@ static u32 max310x_set_ref_clk(struct device
> > > *dev, struct max310x_port *s, if (xtal) {
> > >                 unsigned int val;
> > >
> > > -               msleep(10);
> > > +               msleep(100);
> > >                 regmap_read(s->regmap, MAX310X_STS_IRQSTS_REG,
> > > &val);
> > >
> > > Hugo Villeneuve
> > >
> > >
> > > > > > [    2.614933] 11-006c: ttyMAX0 at I/O 0x0 (irq =3D 57, base_ba=
ud =3D
> > > 3750000) is a
> > > > > MAX14830
> > > > > > [    2.625532] 11-006c: ttyMAX1 at I/O 0x1 (irq =3D 57, base_ba=
ud =3D
> > > 3750000) is a
> > > > > MAX14830
> > > > > > [    2.636061] 11-006c: ttyMAX2 at I/O 0x2 (irq =3D 57, base_ba=
ud =3D
> > > 3750000) is a
> > > > > MAX14830
> > > > > > [    2.646513] 11-006c: ttyMAX3 at I/O 0x3 (irq =3D 57, base_ba=
ud =3D
> > > 3750000) is a
> > > > > MAX14830
> > > > >
> > > > > Hi,
> > > > > it seems you have I2C communication with your device and the ID
> > > > > register was read correctly in the probe() function. If it was
> > > > > not the case, you would have an error message about that.
> > > > >
> > > > > > And,
> > > > > > [   88.430219] irq 57: nobody cared (try booting with the "irqp=
oll"
> > > option)
> > > > >
> > > > > This is probalbly happening because max310x_ist() was called,
> > > > > but when it exited the interrupt line was still active, so that
> > > > > it was not
> > > handled properly.
> > > > >
> > > > > Can you make sure you have the following two patches in your
> > > > > kernel
> > > > > version:
> > > > >
> > > > > 984a4afdc87a ("regmap: prevent noinc writes from clobbering
> > > > > cache") c94e5baa989f ("serial: max310x: fix IO data corruption
> > > > > in batched
> > > > > operations")
> > > > >
> > > > > I do not have hardware to test it, and this is a wild guess, but
> > > > > they may be relevant to your problem because they enable the
> > > > > FIFOs to be read/written properly. If Rx FIFO for example cannot
> > > > > be read, the source of the interrupt cannot be cleared, and
> > > > > could potentially
> > > explain your problem.
> > > > >
> > > > > Hugo Villeneuve
> > > > >
> > > > >
> > > > > > [   88.437720] CPU: 0 PID: 65 Comm: irq/57-11-006c Not tainted =
6.1.15-
> > > > > 580639a #1
> > > > > > [   88.445687] Hardware name: Generic DT based system
> > > > > > [   88.451046]  unwind_backtrace from show_stack+0x18/0x1c
> > > > > > [   88.456906]  show_stack from dump_stack_lvl+0x40/0x4c
> > > > > > [   88.462556]  dump_stack_lvl from __report_bad_irq+0x44/0xc8
> > > > > > [   88.468784]  __report_bad_irq from note_interrupt+0x2c8/0x31=
4
> > > > > > [   88.475208]  note_interrupt from handle_irq_event+0x90/0x94
> > > > > > [   88.481436]  handle_irq_event from handle_level_irq+0xbc/0x1=
b4
> > > > > > [   88.487952]  handle_level_irq from
> > > generic_handle_domain_irq+0x30/0x40
> > > > > > [   88.495253]  generic_handle_domain_irq from
> > > > > aspeed_gpio_irq_handler+0xac/0x158
> > > > > > [   88.503326]  aspeed_gpio_irq_handler from
> > > > > generic_handle_domain_irq+0x30/0x40
> > > > > > [   88.511305]  generic_handle_domain_irq from
> > > gic_handle_irq+0x6c/0x80
> > > > > > [   88.518411]  gic_handle_irq from
> generic_handle_arch_irq+0x34/0x44
> > > > > > [   88.525316]  generic_handle_arch_irq from
> call_with_stack+0x18/0x20
> > > > > > [   88.532328]  call_with_stack from __irq_svc+0x98/0xb0
> > > > > > [   88.537973] Exception stack(0xbf925eb0 to 0xbf925ef8)
> > > > > > [   88.543614] 5ea0:                                     458540=
88 00000003 00000001
> > > > > 00000000
> > > > > > [   88.552742] 5ec0: 00000000 4184ee80 45854088 00000000
> 45854000
> > > > > 41a64140 00000000 00000000
> > > > > > [   88.561870] 5ee0: 00000000 bf925f00 4016bb7c 4016bac0 600f00=
13
> > > ffffffff
> > > > > > [   88.569252]  __irq_svc from __wake_up_common_lock+0x1c/0xb8
> > > > > > [   88.575483]  __wake_up_common_lock from __wake_up+0x20/0x28
> > > > > > [   88.581714]  __wake_up from irq_thread+0x118/0x1ec
> > > > > > [   88.587070]  irq_thread from kthread+0xd8/0xf4
> > > > > > [   88.592040]  kthread from ret_from_fork+0x14/0x2c
> > > > > > [   88.597288] Exception stack(0xbf925fb0 to 0xbf925ff8)
> > > > > > [   88.602923] 5fa0:                                     000000=
00 00000000 00000000
> > > > > 00000000
> > > > > > [   88.612053] 5fc0: 00000000 00000000 00000000 00000000 000000=
00
> > > > > 00000000 00000000 00000000
> > > > > > [   88.621179] 5fe0: 00000000 00000000 00000000 00000000
> 00000013
> > > > > 00000000
> > > > > > [   88.628559] handlers:
> > > > > > [   88.631088] [<4f379e2c>] irq_default_primary_handler threade=
d
> > > > > [<26199d83>] max310x_ist
> > > > > > [   88.639952] Disabling IRQ #57
> > > > > >
> > > > > > __________________________
> > > > > > Usha Srinivasan
> > > > External recipient
> > > >
> > >
> > >
> > > --
> > External recipient
> >
>
>
> --
> Hugo Villeneuve
External recipient
