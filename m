Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2133.outbound.protection.outlook.com [40.107.243.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E09CEA3
	for <linux-serial@vger.kernel.org>; Thu, 11 Jan 2024 00:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cornelisnetworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cornelisnetworks.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b="moWZnHn3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ipvu1t++Q0ALIpzRUDJyo4GoaGYSXS6p3odu5JG6hY1K1f62usdw5gLa6pni+x14nKgDSdlF+/bkuWUxpoKZDQapEtUL3ocdVXDW6X+L0ih0HfQyEFveiIiB+UxUyFt8DRfofImx52LffP9LCccBr/TcAa4uPeXUuL6IiTPOwsoesF+6JEMoBnrd7XDEgsXaJDq1fxI1lqEpG2E9SPmK32cszP9ych6OhQn9PsuqKzSLI/fsqvIV/1pDHHoScmHjPY7ic7aFSyIcL3pa/64IO+/aOItdslDU80GhfGFAfX3lRsxTaerm2X6/VT8ahm43UnRDqgXbd2gK/jdNIsXbqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fLZqTakFuX0Wp9ezgYw5ivKoEFZEO9PaVxopXquK7Vk=;
 b=eMuDCGBiYNrbzNZGbWpT/zfAvTzlYvNBj1b2m8zrwuL4uiOn6WDJu1dhvKzfoVNQa0W+AwPpzPCFyJjbmYZdCOSeUoPqjcA0GJHMqLQVtBBydYKAgHJnD+pHuwlF9UXldH1xsNVI0qTxozYMyNz9wLzggCUe6cMb5VnL8Ri0/afNNyRzl4rc8NXQkVcy3/y8vk675Cm5VW7xbnkeI/w3/v8N51Tbvvtwzxj6QZ3paogEtq5CZ+N9g31ZisXL2fU63Kw9/0vwtc16vXxP/a+MJ8H8ASvMeKefffhrliy/Cr7XQU8Hb/Uqg3l6heKWkUL5EIDExKHi/xVNYKJaCmrMNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fLZqTakFuX0Wp9ezgYw5ivKoEFZEO9PaVxopXquK7Vk=;
 b=moWZnHn3XUYCqFgxPdEZOa+w79Wk35LXHN0TNpdne0gscbryahVN1nbrv//9rnyor1WTRMJY6p+ji04NiXVW91DvAhLe2QMBxNKb4p/pV0CCDfTyQrAnqWv9Boh4/AxAX2e4dklcxTLvSPP8Qq+sk4kz6ukV606YdKInGAvpRDwftRQ1Vp81q8mhvMWhZmz5Z+gvuVjEL4CGK6v+PYk4FTf6vTrp4XZJ8wfmva4Al9z8JSBWKh+ydB3JZDjeaOliOo+d3KvkAyjPFEk5hScRb8/sp7RKPqE5+WeAUvyxbTOEKXdW5pJOvbRghBoeDrhYHb1xZTQfRQDJoMUln21HdA==
Received: from BY5PR01MB5635.prod.exchangelabs.com (2603:10b6:a03:1a9::29) by
 CH3PR01MB8629.prod.exchangelabs.com (2603:10b6:610:168::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7159.24; Thu, 11 Jan 2024 00:55:58 +0000
Received: from BY5PR01MB5635.prod.exchangelabs.com
 ([fe80::46d2:6053:23de:c858]) by BY5PR01MB5635.prod.exchangelabs.com
 ([fe80::46d2:6053:23de:c858%3]) with mapi id 15.20.7181.019; Thu, 11 Jan 2024
 00:55:57 +0000
From: "Srinivasan, Usha" <usha.srinivasan@cornelisnetworks.com>
To: Hugo Villeneuve <hugo@hugovil.com>
CC: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
Subject: RE: max14830 irq
Thread-Topic: max14830 irq
Thread-Index: AdpCZgM5EpVKR9TvQJaVhp41Fise0gAHCR4AACRxtcAAQIMEgAAEhkhw
Date: Thu, 11 Jan 2024 00:55:57 +0000
Message-ID:
 <BY5PR01MB5635A9264220404AA6EA5C089E682@BY5PR01MB5635.prod.exchangelabs.com>
References:
 <DM4PR01MB75952BAB0B535CF832C89AD99E6B2@DM4PR01MB7595.prod.exchangelabs.com>
	<20240108172934.c457ca06b6543f868d32de46@hugovil.com>
	<DM4PR01MB75959DD41CC90B1B704A05D29E6A2@DM4PR01MB7595.prod.exchangelabs.com>
 <20240110174015.6f20195fde08e5c9e64e5675@hugovil.com>
In-Reply-To: <20240110174015.6f20195fde08e5c9e64e5675@hugovil.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornelisnetworks.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR01MB5635:EE_|CH3PR01MB8629:EE_
x-ms-office365-filtering-correlation-id: ea4d0eb7-ef49-47cd-1d78-08dc1240124d
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 yvhdA8efU4kuc74jUeOfSRtVXIw5YKvSlXlta4PvUrRADqMXz+VEk6wjGD21wqQfGWfeKNTbXtI7mZSRJ8WaYqS865qnN8Mc6ew1mPkr3NEVXEI991jC9wdvq+mBzAc8NCcsNwgbcekkz0CIi7vSdsacH3jrfKrPfUSCRzd3DGVUnESWTxg4PzbYOKzYmWfz0QynoPkgqqcVb3bSF5kAUDw+vjA88qOTsWjpabtBwHXY/Dmqk37v76a8JXocyKqyZplocqvmHu0Dpf28JACNPUFGFCfegn5af66wZIgjEaZc2XNOZI5wmscmIuerFtVQJhG/sUrfx87kM2tgzNfJa9tvbkbOAtHM3kPxlMcyubM0DIUTy6PTwz382dg/4xajSC+kXQQsn+nEmVzB/+a/zNajv+IGkhQJTXZ1OJ0Jx3LhWGdUP3WWfwI4I9ie4CCp6sqguLAdvRvzdhq9SQgDxBEPvzKWzc6+qY1nPefzgH2fE90o7qbCBDbx31y0h3E+c3THnsxag/EH27WLYyHmTLaqcFxsoXSnBNw5WszIhuY5JapKz+tHTM+XIhUnsS60l0HvCU4mVjnukjzlHifX6albrWr/b3QZMOHdjvjn+QgJNomVA+Mv+AVkwkK1YKz7WXLGLs0mGTF8O5UKic8DAcoXdcJB3GU65Zs/nML1zGY=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR01MB5635.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(396003)(136003)(39840400004)(376002)(230173577357003)(230273577357003)(64100799003)(186009)(451199024)(1800799012)(55016003)(2906002)(5660300002)(478600001)(7116003)(52536014)(4326008)(38070700009)(38100700002)(66946007)(66476007)(66556008)(316002)(41300700001)(6916009)(76116006)(64756008)(66446008)(33656002)(71200400001)(8676002)(7696005)(9686003)(6506007)(53546011)(86362001)(8936002)(26005)(83380400001)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?bRnTCPOMVenTt2KBaN4+9iu7TF2/PeDZA2W48YRzvtwYwGZTEOoqGfYizW/C?=
 =?us-ascii?Q?2ghpKaInLrSFl+PX8iZv4lv6FkaLU77dV/CV5CTtjXFkhq1Sf0DS49CJeXBu?=
 =?us-ascii?Q?4iRjbcpGg/vx7OLWgTm1ZN8rwKQJA3NS0qyCebNqeqwzGkiiYpTTymQ0hmyB?=
 =?us-ascii?Q?I/YC/W7+8C1+1wytskQ1ei91Kw2W2Dp5GuQt9TiFucEBbJv6vp8rJXL6CIbl?=
 =?us-ascii?Q?BFS8De5WkiyWKZ3z6KchaM//TAi4TqvNF00RZocxsZQp/+5pzA3y4J3A0tjt?=
 =?us-ascii?Q?qap5h26mdpIRvFDYivdMGh8rPj+OEa82a0x3zqp+YCWas2hoWt6Ec6k2259a?=
 =?us-ascii?Q?/0A+kPawBnWHbOscN7+fDZjpSeuDVc1b5nS0e7gOmByLjIHk7nwZcmcQre77?=
 =?us-ascii?Q?zdyNbQU5Wo7VRwkYgBqDQJLYXIp6mqkfYU1JE74VRx+s3QFsrITVcDPx1BXu?=
 =?us-ascii?Q?S3uB+A4q/MD1rieEo9IumiueePwLV5PMmIuGSERHuoSx5tqalpXcanax4gdy?=
 =?us-ascii?Q?C3FbLz0Uayowavbd/ocEcz0zP0bk2uqf+gbIvIDnyTCldpMHCzI9RS3tfvjj?=
 =?us-ascii?Q?XekHQwn7g0tc+MSnCFNCygH+jf94dBx3KYqgquHyd6o03Y6MJEKZQ0mBidIq?=
 =?us-ascii?Q?2QGcVfhx2py1OrWWunmZ2FAk7ElJ8jNOu+Ktlav6QINyj7haYHReYtY8Sy7r?=
 =?us-ascii?Q?7cLQdEsQIGud6yeZy+vTt0FTGBqaDlJETCEVs+3v76mcIYWcWnlSwn41uj67?=
 =?us-ascii?Q?4OoYtIpxXLX502h3JTcmgqFe4pFwU/oPqXGRoCcfXwikzWNppCwtNRRBvFCG?=
 =?us-ascii?Q?hmxOvhCp8nF9ML1odGaYSxVhbaG7au5OSOdPLdty1sq7dWFDp1N54lZElUe/?=
 =?us-ascii?Q?K6T15ERNXBtRMg6LoP+aHSaioXq0MXCxMCWlmwQOAyNk7estLlFqUseGFJ6L?=
 =?us-ascii?Q?BZhqI1iI0C8Rgj24y3d9vc9Mm9rOIVHWfjjKgXFdntVApIQThoMpx3RTQ6qI?=
 =?us-ascii?Q?OgMarv4mLoWPR+3TDIWhuq9E9SIQeQiTBi45dEcjK9O7SeXrI/woAwKU0LiB?=
 =?us-ascii?Q?XvJyWaX9ljcHzgrCdvZSOFMLXtQKJqL3Np4jNBbvt/FQLaPVhhgAaZUNznvJ?=
 =?us-ascii?Q?BaA5YJylT8gC3cAv9cjVM3s3uyGL39u5LFREfRMlQG+Lf9fxO/ZPVChifHlg?=
 =?us-ascii?Q?PsJaWy9E4Gc3YsOOUQRWXRiZwdTb4eswawq9bLhGPG2e9YBcIsyyaEdEdnwk?=
 =?us-ascii?Q?SU3JZ4VUZnLV/9yotg1HxaE81tXNxRw66ilkyY0cbj57WEKzyl7rKnlRlHzF?=
 =?us-ascii?Q?OUoNO8Cm8NhTxNDIxO2Sh7aIBWGTvIlUOUoKGmhHZZJOl/eIGsr/bsZ+dVWq?=
 =?us-ascii?Q?+BV4Rn5vUxXFNDhjlu2IzncIa9/St8mF//t6Ob4Tqu7Hf+YeuXAtv4xjpWxP?=
 =?us-ascii?Q?TxpXJkmFc7vE2lMovpeSwlpVTOTIpDxkEEazdfQnbXckUBjtSM6NDJMJC33/?=
 =?us-ascii?Q?qZ4zFr3AaPEtG/wotlkSz135oU4gEpady97+FVIQeMfTV0vG9xcnQ/fLV0m9?=
 =?us-ascii?Q?UMEWIdxQyOLTqowNWQfNxg4gj6jo7kn0v1wZo/0ihdZLR+DmIDktSGfYl1p3?=
 =?us-ascii?Q?6g=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ea4d0eb7-ef49-47cd-1d78-08dc1240124d
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2024 00:55:57.3655
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NjW4j1qMEb48fiR5mWWTUcLkCQEWnedjPkI7SM+wRwyP9onXNJAGQO19s9yzUT5gkR2NVmWuK5aXELQFzNsun6L6FyXSIKh7zpEdWo4DbDcYB9aGSRvphHQEwOjtZYba
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR01MB8629

Hi, Hugo.
Thank you. Yes, I have clock source set to xtal and thanks for the tip on t=
he delay you shared. I think my issue may be due to how I defined my interr=
upts in the dts file for the arm.  Thanks again for your feedback!
Usha

> -----Original Message-----
> From: Hugo Villeneuve <hugo@hugovil.com>
> Sent: Wednesday, January 10, 2024 5:40 PM
> To: Srinivasan, Usha <usha.srinivasan@cornelisnetworks.com>
> Cc: linux-serial@vger.kernel.org
> Subject: Re: max14830 irq
>
> On Tue, 9 Jan 2024 21:25:03 +0000
> "Srinivasan, Usha" <usha.srinivasan@cornelisnetworks.com> wrote:
>
> > Hi Hugo.
> > Thanks so much for your response.
> >
> > I was building with 6.1 had one patch but not the other.  I brought ove=
r the
> 2nd patch as well but made no difference.
> >
> > I switched from 6.1 to 6.6 which has both patches and still the same is=
sue.
> >
> > What do you suggest next?
> > Usha
>
> Hi,
> let's hope that someone with more experience with this IC can help you.
>
> In the meantime, see my comments below...
>
>
> > > -----Original Message-----
> > > From: Hugo Villeneuve <hugo@hugovil.com>
> > > Sent: Monday, January 8, 2024 5:30 PM
> > > To: Srinivasan, Usha <usha.srinivasan@cornelisnetworks.com>
> > > Cc: linux-serial@vger.kernel.org
> > > Subject: Re: max14830 irq
> > >
> > > On Mon, 8 Jan 2024 19:08:08 +0000
> > > "Srinivasan, Usha" <usha.srinivasan@cornelisnetworks.com> wrote:
> > >
> > > > Hello,
> > > > I am trying to get max14830 working on our platform and I'm seeing
> > > > a stack
> > > trace for each of the UARTs in my device tree.  I'm not sure what
> > > the fix is.  I'm running 6.1.15-580639a (OpenBMC 2.14.0) on ASPEED
> > > ast2600.  Any help appreciated.
> > > > [    2.608620] max310x 11-006c: clock is not stable yet
>
> I assume that your clock source is defined as a crystal (xtal) in your de=
vice
> tree. Is it really the case (xtal vs oscillator)?
>
> If yes, do you see this warning message every time? I noticed that Bounda=
ry
> devices have a patch in their private repo where they increased the delay=
 to
> detect a stable crystal from 10ms to 100ms (but they do not explain why).
>
> Can you try that:
>
> @@ -610,7 +610,7 @@ static u32 max310x_set_ref_clk(struct device *dev,
> struct max310x_port *s, if (xtal) {
>                 unsigned int val;
>
> -               msleep(10);
> +               msleep(100);
>                 regmap_read(s->regmap, MAX310X_STS_IRQSTS_REG, &val);
>
> Hugo Villeneuve
>
>
> > > > [    2.614933] 11-006c: ttyMAX0 at I/O 0x0 (irq =3D 57, base_baud =
=3D
> 3750000) is a
> > > MAX14830
> > > > [    2.625532] 11-006c: ttyMAX1 at I/O 0x1 (irq =3D 57, base_baud =
=3D
> 3750000) is a
> > > MAX14830
> > > > [    2.636061] 11-006c: ttyMAX2 at I/O 0x2 (irq =3D 57, base_baud =
=3D
> 3750000) is a
> > > MAX14830
> > > > [    2.646513] 11-006c: ttyMAX3 at I/O 0x3 (irq =3D 57, base_baud =
=3D
> 3750000) is a
> > > MAX14830
> > >
> > > Hi,
> > > it seems you have I2C communication with your device and the ID
> > > register was read correctly in the probe() function. If it was not
> > > the case, you would have an error message about that.
> > >
> > > > And,
> > > > [   88.430219] irq 57: nobody cared (try booting with the "irqpoll"
> option)
> > >
> > > This is probalbly happening because max310x_ist() was called, but
> > > when it exited the interrupt line was still active, so that it was no=
t
> handled properly.
> > >
> > > Can you make sure you have the following two patches in your kernel
> > > version:
> > >
> > > 984a4afdc87a ("regmap: prevent noinc writes from clobbering cache")
> > > c94e5baa989f ("serial: max310x: fix IO data corruption in batched
> > > operations")
> > >
> > > I do not have hardware to test it, and this is a wild guess, but
> > > they may be relevant to your problem because they enable the FIFOs
> > > to be read/written properly. If Rx FIFO for example cannot be read,
> > > the source of the interrupt cannot be cleared, and could potentially
> explain your problem.
> > >
> > > Hugo Villeneuve
> > >
> > >
> > > > [   88.437720] CPU: 0 PID: 65 Comm: irq/57-11-006c Not tainted 6.1.=
15-
> > > 580639a #1
> > > > [   88.445687] Hardware name: Generic DT based system
> > > > [   88.451046]  unwind_backtrace from show_stack+0x18/0x1c
> > > > [   88.456906]  show_stack from dump_stack_lvl+0x40/0x4c
> > > > [   88.462556]  dump_stack_lvl from __report_bad_irq+0x44/0xc8
> > > > [   88.468784]  __report_bad_irq from note_interrupt+0x2c8/0x314
> > > > [   88.475208]  note_interrupt from handle_irq_event+0x90/0x94
> > > > [   88.481436]  handle_irq_event from handle_level_irq+0xbc/0x1b4
> > > > [   88.487952]  handle_level_irq from
> generic_handle_domain_irq+0x30/0x40
> > > > [   88.495253]  generic_handle_domain_irq from
> > > aspeed_gpio_irq_handler+0xac/0x158
> > > > [   88.503326]  aspeed_gpio_irq_handler from
> > > generic_handle_domain_irq+0x30/0x40
> > > > [   88.511305]  generic_handle_domain_irq from
> gic_handle_irq+0x6c/0x80
> > > > [   88.518411]  gic_handle_irq from generic_handle_arch_irq+0x34/0x=
44
> > > > [   88.525316]  generic_handle_arch_irq from call_with_stack+0x18/0=
x20
> > > > [   88.532328]  call_with_stack from __irq_svc+0x98/0xb0
> > > > [   88.537973] Exception stack(0xbf925eb0 to 0xbf925ef8)
> > > > [   88.543614] 5ea0:                                     45854088 0=
0000003 00000001
> > > 00000000
> > > > [   88.552742] 5ec0: 00000000 4184ee80 45854088 00000000 45854000
> > > 41a64140 00000000 00000000
> > > > [   88.561870] 5ee0: 00000000 bf925f00 4016bb7c 4016bac0 600f0013
> ffffffff
> > > > [   88.569252]  __irq_svc from __wake_up_common_lock+0x1c/0xb8
> > > > [   88.575483]  __wake_up_common_lock from __wake_up+0x20/0x28
> > > > [   88.581714]  __wake_up from irq_thread+0x118/0x1ec
> > > > [   88.587070]  irq_thread from kthread+0xd8/0xf4
> > > > [   88.592040]  kthread from ret_from_fork+0x14/0x2c
> > > > [   88.597288] Exception stack(0xbf925fb0 to 0xbf925ff8)
> > > > [   88.602923] 5fa0:                                     00000000 0=
0000000 00000000
> > > 00000000
> > > > [   88.612053] 5fc0: 00000000 00000000 00000000 00000000 00000000
> > > 00000000 00000000 00000000
> > > > [   88.621179] 5fe0: 00000000 00000000 00000000 00000000 00000013
> > > 00000000
> > > > [   88.628559] handlers:
> > > > [   88.631088] [<4f379e2c>] irq_default_primary_handler threaded
> > > [<26199d83>] max310x_ist
> > > > [   88.639952] Disabling IRQ #57
> > > >
> > > > __________________________
> > > > Usha Srinivasan
> > External recipient
> >
>
>
> --
External recipient
