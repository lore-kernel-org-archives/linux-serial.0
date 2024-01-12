Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2107.outbound.protection.outlook.com [40.107.94.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C496BB41
	for <linux-serial@vger.kernel.org>; Fri, 12 Jan 2024 14:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cornelisnetworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cornelisnetworks.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b="mKMl+VFk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F2+Cx2uv/uUkBrykq+PXDDl6yoMwRcJdWyEs5ZxxHWL5qSX0Bt0Y8/OLRwNBEpgavl/z+/Rv3tqNiaGUYLbL9MqThb3OqL+ig7XpNYl9iQObphZ6T2cxeJsb5RLqJPqTAayMrPWO9j/TQBWpmNu8a01ksgOD0PVV95GZ0ehSfMBkHXx11YobDzc9ewVxnMV60Vs1lxqVj819lVJGZaaRclrCkUzTosn6jzHdF/CdncVDXCIrY//AJaJLWE8fgwLCN9v/G6VhPi4wR7rhFo3g+QjUsMt5be8moiMbGxv6uHAJW7b5sHQU8Y3AGjk2Y/Q2eJK89mkBQIulbF+TNIsJRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xpiKL/Dqil5FaCdQOZGfuqkKhP+MsNLQSKJ3NxNQp3E=;
 b=RQUbg68TvGWCVZWwvLE5dhm2/JUvBh1K40PM/6+oXl+09bA/Mosvlivddba5ZTBvH4cdTDkAqaH+Btp8iRuKnMNSJG/NfP3HfJpy2icJbGen91s9cGcpO/0PWYDRe8SY8fJUbZzqG3Ksw/7x86XNXnaQkUUwt1yAiXkxgwdaJlSsc3vA/uGn1e8jxvYrYdxx+gfms1qKBwoB07jzbvblalNOIwSjpol43nlMdoNmxtUb+STx+MUf3ZoJCzpmhePOz70NymdA37EQ11xqbSDqJvCVKhV7PoSVJaiPtbUAlLig94QitnGpQYDGPj4oYlQXF6lI5rwh2slEEYTVIziPmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xpiKL/Dqil5FaCdQOZGfuqkKhP+MsNLQSKJ3NxNQp3E=;
 b=mKMl+VFkwLRJhxI8dadzLFkEGAjBEPAetRvyCmSVZ2/IM0ehtrUdhBAiTErPA7bufoc9+xPl0a4Mll69Hpf7UNYJaymTHq1dZ4pMGH0p4Tcr+gdZfizHBCAk4d44GasnYWcujDQdbPULKXDknf+HiEwvUYqO+hynOKGlwHjJwMkXbran4EMjfKoR0Y+15wsNS9BsLmffMMl50wErs75bIDbJIEe0+Xaw010MgHKkSmQGRFnkJuEq6J5vq1L3HxMuAPZpgKw4Dr7l0q8Ook2onncDoPhZth23MCNa70qAQDMSLyBW0lJp7ZAoJWhYBElat9c3IZUtKYOYLMVIrJHXYA==
Received: from BY5PR01MB5635.prod.exchangelabs.com (2603:10b6:a03:1a9::29) by
 SJ0PR01MB7300.prod.exchangelabs.com (2603:10b6:a03:3f4::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7181.21; Fri, 12 Jan 2024 14:10:46 +0000
Received: from BY5PR01MB5635.prod.exchangelabs.com
 ([fe80::46d2:6053:23de:c858]) by BY5PR01MB5635.prod.exchangelabs.com
 ([fe80::46d2:6053:23de:c858%3]) with mapi id 15.20.7181.019; Fri, 12 Jan 2024
 14:10:46 +0000
From: "Srinivasan, Usha" <usha.srinivasan@cornelisnetworks.com>
To: Hugo Villeneuve <hugo@hugovil.com>
CC: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
Subject: RE: max14830 irq
Thread-Topic: max14830 irq
Thread-Index:
 AdpCZgM5EpVKR9TvQJaVhp41Fise0gAHCR4AACRxtcAAQIMEgAAEhkhwACGgiYAAAgv4oAACsxKAACfcb2A=
Date: Fri, 12 Jan 2024 14:10:45 +0000
Message-ID:
 <BY5PR01MB5635993B9E1088CF7B71903B9E6F2@BY5PR01MB5635.prod.exchangelabs.com>
References:
 <DM4PR01MB75952BAB0B535CF832C89AD99E6B2@DM4PR01MB7595.prod.exchangelabs.com>
	<20240108172934.c457ca06b6543f868d32de46@hugovil.com>
	<DM4PR01MB75959DD41CC90B1B704A05D29E6A2@DM4PR01MB7595.prod.exchangelabs.com>
	<20240110174015.6f20195fde08e5c9e64e5675@hugovil.com>
	<BY5PR01MB5635A9264220404AA6EA5C089E682@BY5PR01MB5635.prod.exchangelabs.com>
	<20240111115239.63d408a688b1b8783de3064f@hugovil.com>
	<BY5PR01MB56351BA462070C585273B3909E682@BY5PR01MB5635.prod.exchangelabs.com>
 <20240111140833.4d312e7e4ae11f1770df8968@hugovil.com>
In-Reply-To: <20240111140833.4d312e7e4ae11f1770df8968@hugovil.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornelisnetworks.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR01MB5635:EE_|SJ0PR01MB7300:EE_
x-ms-office365-filtering-correlation-id: f1ddeaa5-4496-4d15-a6ad-08dc13784553
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 kRdjUp2/Abx6AUJVql84KDKwZWEZzJrdLxJ1+JiBebA2nsN4yDZmD/eKFf22EWICRMCF46CpmrfzaqrM9JIg3KVN/TRFEgLBOC3QwHF9RBlBVyrN/bVlSjQVLuSBj8G0LThFZgFydUgfweUdfVaqNo0L0r4fJY8Q1+vfzq4yG2hy8liXKRkYA2O5B6oTh1fmi0PcZMVGuYQQG7dAiYffefGQiL+cHvndQvaFrojvhV/KX2eyRb3AW4LjfNPfzD4Wt1+66t3uq02fJemRS2onO5EuPnkd0TDHe/SMVYNjU7UZZ6bkELyatsnJf3T4baUfu1hFL+UAA3jD3eEo6QMY5VOooHw6CD6UBKvkEJazmj7O1pW2jSrRmqLnr4fzK7A3p075x3ZKb32wpc0J26gJTSw5myCSl00k9iaS5Ie1awi3J9uoaQIc0lHjGjx0xwjHTLKup+bKM4LHAq3GyxonLSmmrDwGtOqt68SD3b+O7fqx8kH31jer93Is1WrP6me+fbgD2sGefS0tzPLkzfd6o+x1FgAaZimJLh7NVAu9tTB2uO9J7izm5zoZDOvrkfr/Ld0JlkT+SkduPpOvek9m55YedUDomsGUnr3UkVLmPbz+6wBtJgYNKqFb64VaUg10DZoutB687Qje3xkLFBjnAEdtCgeV4SoxVOwO3glJx6Q=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR01MB5635.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39840400004)(346002)(366004)(136003)(376002)(230173577357003)(230273577357003)(451199024)(64100799003)(186009)(1800799012)(53546011)(7696005)(6506007)(478600001)(71200400001)(38070700009)(41300700001)(83380400001)(9686003)(5660300002)(76116006)(33656002)(2906002)(38100700002)(8936002)(52536014)(55016003)(6916009)(7116003)(66446008)(64756008)(66556008)(66946007)(66476007)(4326008)(316002)(8676002)(122000001)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?5eYynLUy1kwnheml10r/eYjWQZp/EY3xPiIFM7+ThmyOL0pqgs7guKIvwp32?=
 =?us-ascii?Q?2+lA+jA2yJyJkmpqlQNMT7ObA705uu8aTgbo1pk9wmZsf4r9qm+hlKLkJTcT?=
 =?us-ascii?Q?pv2ma0AMD6vHx5DiHutc+Kgp6RQ+ghLHaAN8z9TuKpty+SqQ1/m8tmZo+BIN?=
 =?us-ascii?Q?Ap3uoEO7dxzzezxRN/D2fd01urJNm29SI3g3JVxvpdIL/2K410qHzg32+V+o?=
 =?us-ascii?Q?BvLumD1A+4g5AqrSYIPwbc4IabhwVJQKgSTMyPI7gqDDlOCd68bPZIqeSAWE?=
 =?us-ascii?Q?yDllpRVeqRU+gyapejrH9wEZwvb0vvkOXW7SoZzwpWqo7QsJtsCXBp3Q+FHp?=
 =?us-ascii?Q?QRfMise7GyP3a0lEVgCa7imBkWHw9VyjhKhd0FsDlGv0KNeyuhQdnqi2Woqf?=
 =?us-ascii?Q?cl8kLj6K6UcxBT+Nu5AfPfEnxb14bJtlB1ftSDbCqxHUY3ILrtdWyUuuP63s?=
 =?us-ascii?Q?Mn/ahTveVx1tLDx4R2ePvRmZZpnvjI0hBtqYcAgTWSA6WYay7zYLul0dQ0uy?=
 =?us-ascii?Q?HGOSKRoQ0HMHYW5FXudVZ9C3NDO+EDAkwmlgNck7nwI4LpLtRJJNesTRZ2o4?=
 =?us-ascii?Q?WjiDMLL2ViAMhjzJAKH45bLGRzoPTHECbqaFQkHoSOV8w/Xj5rnG2OQm8UfN?=
 =?us-ascii?Q?+rNkR9vmEuDI8KnnmKb/FeKJLzVZUcgeeTVLUX9qiflvaSdT7eHY04x0eYVt?=
 =?us-ascii?Q?Ne2+UAmDNQETAhyq/rBN+uaHlAmMiacTLcbuJnuP+hgrB3DSIU2rgkHNFz/I?=
 =?us-ascii?Q?46+9B2z0G6AFXoApyVJqOXESKy9iYX8x0dG9Rl6UtzoQPyPqOrFI/8THWlDf?=
 =?us-ascii?Q?6Brzy1G6BsKuer+tvf4blGisMtEwlAGALtWVAvZYrTOr4cjQjRCEX+2NSGTn?=
 =?us-ascii?Q?L6mQuGF3GM4aUGey10b76DMIu398bTEmNewSLVupnN4AjE8UJu4r8AncESXL?=
 =?us-ascii?Q?E5gDQ55L4IrFA8CmrfS7CLJX4OlwSezXuLg+PBX0A8ouSuAGIog+f43U1ufG?=
 =?us-ascii?Q?XJuUirdjwL23/t+SYvJrczRTiECWw5bBH9uXpIDYdceK/lCnYKtNeI82u/36?=
 =?us-ascii?Q?UZIWxPQDa42zRGT5VqJRxA22edAtmZ7kpZs89x4gmhZKN+TuopDvS/FHCW32?=
 =?us-ascii?Q?h8ssOH506KMzuQA4qiNIzs+/M74NPwSAUTc4PWidSymWA0cB/KIEoT45PjB+?=
 =?us-ascii?Q?HFz8peRKpoiJNJh/qeZ2YuuTTOWvhw3mDyWO3bPo/+kc4dSWBOryQig80925?=
 =?us-ascii?Q?DgkH59AOpJ3+qD27JYPtO7HKp5r9Sw1Uw9z34QShY7j92PQ0UDC+rYIsFSnb?=
 =?us-ascii?Q?TGZXqFRfhw8jn69kqRrYM/Kk3jnAWHs8bKJ0c+ZT+qltAPUkwixgsORG1FAQ?=
 =?us-ascii?Q?nDMMo7GnzGf8zItfCW1cCYoHGDsPfLY5qmNI4QQ8N8+8+qEC5yy15EpHJUed?=
 =?us-ascii?Q?QN5Sbx+zONRdKSgfWAH9elDxX0ryp/CKkMycgje0Qfz0vavk1eZMhJbEHyBn?=
 =?us-ascii?Q?bsoDRAH/iAiTvLn89H6f1OnNf6Qz+Lq3LyzJ4Z8NaXZbQt4Cy/fm0iCRhn+7?=
 =?us-ascii?Q?g8AUd8riwlrHo3LDoOB4hl5iWfWqadNagK4O84nfj03MO+pmXZMnwOEAvEF8?=
 =?us-ascii?Q?wCChI1Jk8hXAVSQzclIeKZ1In7wjqpg2knm41pSdfz+DxwUGxGJpgX799fRP?=
 =?us-ascii?Q?cFoWoA=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f1ddeaa5-4496-4d15-a6ad-08dc13784553
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2024 14:10:45.9852
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2Z0j3Pm8ELbWvf6E/hrxAkXWgf6UPGQFhjxw/oBK5xvfyYzx/5/t8LJZJTpJ06HqwCWQ7Wenp4zaQ1Pyudf0UEANublcJLKnqaxLi3yXojXIaJkHRiFTO2ZQBB4YUdFa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR01MB7300

Thanks, Hugo. I think we found a crystal issue.  Thanks for your help; appr=
eciate your feedback.

> -----Original Message-----
> From: Hugo Villeneuve <hugo@hugovil.com>
> Sent: Thursday, January 11, 2024 2:09 PM
> To: Srinivasan, Usha <usha.srinivasan@cornelisnetworks.com>
> Cc: linux-serial@vger.kernel.org
> Subject: Re: max14830 irq
>
> On Thu, 11 Jan 2024 17:52:18 +0000
> "Srinivasan, Usha" <usha.srinivasan@cornelisnetworks.com> wrote:
>
> > Hi, Hugo.
> > Sadly, yes, I even tried a ridiculous msleep(1000) but I still get
> > [    3.671189] max310x 11-006c: clock is not stable yet
> > [    4.791122] max310x 11-0061: clock is not stable yet
> > [    5.911719] max310x 11-0062: clock is not stable yet
> > [   90.951252] max310x 11-0064: clock is not stable yet
> > [  178.631326] max310x 11-0065: clock is not stable yet
>
> Hi Usha,
> strange...
>
> But thanks for the feedback.
>
> Hugo Villeneuve
>
>
> > Thanks,
> > Usha
> > > -----Original Message-----
> > > From: Hugo Villeneuve <hugo@hugovil.com>
> > > Sent: Thursday, January 11, 2024 11:53 AM
> > > To: Srinivasan, Usha <usha.srinivasan@cornelisnetworks.com>
> > > Cc: linux-serial@vger.kernel.org
> > > Subject: Re: max14830 irq
> > >
> > > On Thu, 11 Jan 2024 00:55:57 +0000
> > > "Srinivasan, Usha" <usha.srinivasan@cornelisnetworks.com> wrote:
> > >
> > > > Hi, Hugo.
> > > > Thank you. Yes, I have clock source set to xtal and thanks for the
> > > > tip on the
> > > delay you shared. I think my issue may be due to how I defined my
> > > interrupts in the dts file for the arm.  Thanks again for your feedba=
ck!
> > > > Usha
> > >
> > > Hi Usha,
> > > if you have time, I would appreciate if you could confirm if the "sta=
ble
> clock"
> > > warning disapears when increasing the delay to 100ms?
> > >
> > > Thank you,
> > > Hugo.
> > >
> > >
> > > >
> > > > > -----Original Message-----
> > > > > From: Hugo Villeneuve <hugo@hugovil.com>
> > > > > Sent: Wednesday, January 10, 2024 5:40 PM
> > > > > To: Srinivasan, Usha <usha.srinivasan@cornelisnetworks.com>
> > > > > Cc: linux-serial@vger.kernel.org
> > > > > Subject: Re: max14830 irq
> > > > >
> > > > > On Tue, 9 Jan 2024 21:25:03 +0000 "Srinivasan, Usha"
> > > > > <usha.srinivasan@cornelisnetworks.com> wrote:
> > > > >
> > > > > > Hi Hugo.
> > > > > > Thanks so much for your response.
> > > > > >
> > > > > > I was building with 6.1 had one patch but not the other.  I
> > > > > > brought over the
> > > > > 2nd patch as well but made no difference.
> > > > > >
> > > > > > I switched from 6.1 to 6.6 which has both patches and still the=
 same
> issue.
> > > > > >
> > > > > > What do you suggest next?
> > > > > > Usha
> > > > >
> > > > > Hi,
> > > > > let's hope that someone with more experience with this IC can hel=
p you.
> > > > >
> > > > > In the meantime, see my comments below...
> > > > >
> > > > >
> > > > > > > -----Original Message-----
> > > > > > > From: Hugo Villeneuve <hugo@hugovil.com>
> > > > > > > Sent: Monday, January 8, 2024 5:30 PM
> > > > > > > To: Srinivasan, Usha <usha.srinivasan@cornelisnetworks.com>
> > > > > > > Cc: linux-serial@vger.kernel.org
> > > > > > > Subject: Re: max14830 irq
> > > > > > >
> > > > > > > On Mon, 8 Jan 2024 19:08:08 +0000 "Srinivasan, Usha"
> > > > > > > <usha.srinivasan@cornelisnetworks.com> wrote:
> > > > > > >
> > > > > > > > Hello,
> > > > > > > > I am trying to get max14830 working on our platform and
> > > > > > > > I'm seeing a stack
> > > > > > > trace for each of the UARTs in my device tree.  I'm not sure
> > > > > > > what the fix is.  I'm running 6.1.15-580639a (OpenBMC
> > > > > > > 2.14.0) on ASPEED ast2600.  Any help appreciated.
> > > > > > > > [    2.608620] max310x 11-006c: clock is not stable yet
> > > > >
> > > > > I assume that your clock source is defined as a crystal (xtal)
> > > > > in your device tree. Is it really the case (xtal vs oscillator)?
> > > > >
> > > > > If yes, do you see this warning message every time? I noticed
> > > > > that Boundary devices have a patch in their private repo where
> > > > > they increased the delay to detect a stable crystal from 10ms to
> > > > > 100ms (but they
> > > do not explain why).
> > > > >
> > > > > Can you try that:
> > > > >
> > > > > @@ -610,7 +610,7 @@ static u32 max310x_set_ref_clk(struct device
> > > > > *dev, struct max310x_port *s, if (xtal) {
> > > > >                 unsigned int val;
> > > > >
> > > > > -               msleep(10);
> > > > > +               msleep(100);
> > > > >                 regmap_read(s->regmap, MAX310X_STS_IRQSTS_REG,
> > > > > &val);
> > > > >
> > > > > Hugo Villeneuve
> > > > >
> > > > >
> > > > > > > > [    2.614933] 11-006c: ttyMAX0 at I/O 0x0 (irq =3D 57, bas=
e_baud =3D
> > > > > 3750000) is a
> > > > > > > MAX14830
> > > > > > > > [    2.625532] 11-006c: ttyMAX1 at I/O 0x1 (irq =3D 57, bas=
e_baud =3D
> > > > > 3750000) is a
> > > > > > > MAX14830
> > > > > > > > [    2.636061] 11-006c: ttyMAX2 at I/O 0x2 (irq =3D 57, bas=
e_baud =3D
> > > > > 3750000) is a
> > > > > > > MAX14830
> > > > > > > > [    2.646513] 11-006c: ttyMAX3 at I/O 0x3 (irq =3D 57, bas=
e_baud =3D
> > > > > 3750000) is a
> > > > > > > MAX14830
> > > > > > >
> > > > > > > Hi,
> > > > > > > it seems you have I2C communication with your device and the
> > > > > > > ID register was read correctly in the probe() function. If
> > > > > > > it was not the case, you would have an error message about th=
at.
> > > > > > >
> > > > > > > > And,
> > > > > > > > [   88.430219] irq 57: nobody cared (try booting with the "=
irqpoll"
> > > > > option)
> > > > > > >
> > > > > > > This is probalbly happening because max310x_ist() was
> > > > > > > called, but when it exited the interrupt line was still
> > > > > > > active, so that it was not
> > > > > handled properly.
> > > > > > >
> > > > > > > Can you make sure you have the following two patches in your
> > > > > > > kernel
> > > > > > > version:
> > > > > > >
> > > > > > > 984a4afdc87a ("regmap: prevent noinc writes from clobbering
> > > > > > > cache") c94e5baa989f ("serial: max310x: fix IO data
> > > > > > > corruption in batched
> > > > > > > operations")
> > > > > > >
> > > > > > > I do not have hardware to test it, and this is a wild guess,
> > > > > > > but they may be relevant to your problem because they enable
> > > > > > > the FIFOs to be read/written properly. If Rx FIFO for
> > > > > > > example cannot be read, the source of the interrupt cannot
> > > > > > > be cleared, and could potentially
> > > > > explain your problem.
> > > > > > >
> > > > > > > Hugo Villeneuve
> > > > > > >
> > > > > > >
> > > > > > > > [   88.437720] CPU: 0 PID: 65 Comm: irq/57-11-006c Not tain=
ted
> 6.1.15-
> > > > > > > 580639a #1
> > > > > > > > [   88.445687] Hardware name: Generic DT based system
> > > > > > > > [   88.451046]  unwind_backtrace from show_stack+0x18/0x1c
> > > > > > > > [   88.456906]  show_stack from dump_stack_lvl+0x40/0x4c
> > > > > > > > [   88.462556]  dump_stack_lvl from __report_bad_irq+0x44/0=
xc8
> > > > > > > > [   88.468784]  __report_bad_irq from note_interrupt+0x2c8/=
0x314
> > > > > > > > [   88.475208]  note_interrupt from handle_irq_event+0x90/0=
x94
> > > > > > > > [   88.481436]  handle_irq_event from
> handle_level_irq+0xbc/0x1b4
> > > > > > > > [   88.487952]  handle_level_irq from
> > > > > generic_handle_domain_irq+0x30/0x40
> > > > > > > > [   88.495253]  generic_handle_domain_irq from
> > > > > > > aspeed_gpio_irq_handler+0xac/0x158
> > > > > > > > [   88.503326]  aspeed_gpio_irq_handler from
> > > > > > > generic_handle_domain_irq+0x30/0x40
> > > > > > > > [   88.511305]  generic_handle_domain_irq from
> > > > > gic_handle_irq+0x6c/0x80
> > > > > > > > [   88.518411]  gic_handle_irq from
> > > generic_handle_arch_irq+0x34/0x44
> > > > > > > > [   88.525316]  generic_handle_arch_irq from
> > > call_with_stack+0x18/0x20
> > > > > > > > [   88.532328]  call_with_stack from __irq_svc+0x98/0xb0
> > > > > > > > [   88.537973] Exception stack(0xbf925eb0 to 0xbf925ef8)
> > > > > > > > [   88.543614] 5ea0:                                     45=
854088 00000003
> 00000001
> > > > > > > 00000000
> > > > > > > > [   88.552742] 5ec0: 00000000 4184ee80 45854088 00000000
> > > 45854000
> > > > > > > 41a64140 00000000 00000000
> > > > > > > > [   88.561870] 5ee0: 00000000 bf925f00 4016bb7c 4016bac0
> 600f0013
> > > > > ffffffff
> > > > > > > > [   88.569252]  __irq_svc from
> __wake_up_common_lock+0x1c/0xb8
> > > > > > > > [   88.575483]  __wake_up_common_lock from
> __wake_up+0x20/0x28
> > > > > > > > [   88.581714]  __wake_up from irq_thread+0x118/0x1ec
> > > > > > > > [   88.587070]  irq_thread from kthread+0xd8/0xf4
> > > > > > > > [   88.592040]  kthread from ret_from_fork+0x14/0x2c
> > > > > > > > [   88.597288] Exception stack(0xbf925fb0 to 0xbf925ff8)
> > > > > > > > [   88.602923] 5fa0:                                     00=
000000 00000000
> 00000000
> > > > > > > 00000000
> > > > > > > > [   88.612053] 5fc0: 00000000 00000000 00000000 00000000
> 00000000
> > > > > > > 00000000 00000000 00000000
> > > > > > > > [   88.621179] 5fe0: 00000000 00000000 00000000 00000000
> > > 00000013
> > > > > > > 00000000
> > > > > > > > [   88.628559] handlers:
> > > > > > > > [   88.631088] [<4f379e2c>] irq_default_primary_handler thr=
eaded
> > > > > > > [<26199d83>] max310x_ist
> > > > > > > > [   88.639952] Disabling IRQ #57
> > > > > > > >
> > > > > > > > __________________________ Usha Srinivasan
> > > > > > External recipient
> > > > > >
> > > > >
> > > > >
> > > > > --
> > > > External recipient
> > > >
> > >
> > >
> > > --
> > > Hugo Villeneuve
> > External recipient
> >
External recipient
