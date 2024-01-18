Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2100.outbound.protection.outlook.com [40.107.220.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459962E3F1
	for <linux-serial@vger.kernel.org>; Thu, 18 Jan 2024 19:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705604529; cv=fail; b=V4LbaAcoWr1tevKAglMbQOYp+u9TMLhhObsSIEkAHygp3gdJ6DEjVsdiW8TVLV45JdjvE8xKxn02mGUAbB/UTd2J/cqwDQLvrUBLhySFpj3W8/mATweeQP/Kr1M2X74Tz7tnhBqV8eZxNVuCQb0iRAZLg7O6fkDEbOokzEQOEzo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705604529; c=relaxed/simple;
	bh=ZikNoJQ+8p72NhU1XqossGP6tondDIPBHhtUhoniHfM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ajG2H2PJqpudbDSnGJSuh7yUyqMYaaSkHDsICIDlzGp+TNQ5dKXl2glv93tn4FA0nR6mbvyXgCF2JvrgpoU8tGLwD2djwJf4TUIMJsvKPqcqZ9mU9I7FPH8XVHevFTayHZzvP/IeBwCsDYh56iwvPdNYxWjBeOG2pnDYfpgwAew=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cornelisnetworks.com; spf=pass smtp.mailfrom=cornelisnetworks.com; dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b=UaJv1Whu; arc=fail smtp.client-ip=40.107.220.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cornelisnetworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cornelisnetworks.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b="UaJv1Whu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DvGFETpr8rmThzMl89fy+v2654Cr8nXjinSUG1bozpPrC/Izt0u7Ik3fGsVPBuoxZHN/oYXHf0EwubJE7aZvC0Wi2ThykTk8o5ZcaGmoEJNUH4baeSJPJuowsrnyKknSCpYAeC6sCSyVubGeqNYkfwRY8sd2VJJn86+juUyQdeblYoLy8/GjhpeJG6KQ0UB1DcRCQ0oumd5ZtEo/bo13WP7uUV3QZztXQBVxIkh89nxy78vHTLWHtuJiFmuQD4bN56IUhzdb41bxMcer10tINkhYfrltwStJVzv16BbYFviAQTppjzjlCi6lUqiyLpMrEMyOQTfhUTyqO/3q8j4mvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UndGFzX0DdzhluBGW24+UGXFxLTkMWx2ga2Xjmg/T4Q=;
 b=XEboNs9QpJTk3oovRM5m7NCprONtfoMASLkR4GvVYM/ZIolYNjNvC/BHW3iVZD3Tia0p3ZPoeLDpfBUsWtkRf1JnBjswNl0JAR0RFyFnSNk7XOCmwhbMdNsfNQbI+lsXCgDKauw8+TlqvkkxFehYAV7v5+W4rPv4rrOmryy+w4IFTuQK02CUrpab0HpIlLo7LI6v69NceYW/FLlMes3dElRphlaHojUdxF5nD+WRDedjuy/1vIYjxxyrvmRVH+0tKd/rBA6MQN8rIWd+xcu1fjZ7J3NCyk1lBvTRaKmG8odRf6zcM6ZM9MdfmFw2IfADwQfZuNVOEMTcKnJXTOAtjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UndGFzX0DdzhluBGW24+UGXFxLTkMWx2ga2Xjmg/T4Q=;
 b=UaJv1WhugbFBQaGq7EfxcmzmW7Sky4d6MRGdr7Rw3gk9aw1R8Xf0cOiTzAEYk/RaJRwgYbi1+XBBM4W6VPmgVyqAHx7cdmYg0A9K/WUpL9R39fyzLVnWJkDPFjbZcMx1cKkLlfnCGo9rYTAx+zXbxR5bd7cbMxmEKS14ipACnsoRM5DH6wx2mzram5qw6ZlAwussgimVXnvrUA9a6+t6sja0CugMzY+oCuJ7+3ky+8E/RukKLo4SQhbLS9HiVaA1Y5pIYAyocS6IZspl8xLNz5WzIA1n4msTYCSw2Bzkapq/bkPJAHAzZlZyzF6pN/4ehiquZKCmikLIrTaSPnDq/w==
Received: from BY5PR01MB5635.prod.exchangelabs.com (2603:10b6:a03:1a9::29) by
 IA0PR01MB8307.prod.exchangelabs.com (2603:10b6:208:489::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7181.26; Thu, 18 Jan 2024 19:02:04 +0000
Received: from BY5PR01MB5635.prod.exchangelabs.com
 ([fe80::46d2:6053:23de:c858]) by BY5PR01MB5635.prod.exchangelabs.com
 ([fe80::46d2:6053:23de:c858%3]) with mapi id 15.20.7181.019; Thu, 18 Jan 2024
 19:02:03 +0000
From: "Srinivasan, Usha" <usha.srinivasan@cornelisnetworks.com>
To: Hugo Villeneuve <hugo@hugovil.com>
CC: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
Subject: RE: max14830 irq
Thread-Topic: max14830 irq
Thread-Index:
 AdpCZgM5EpVKR9TvQJaVhp41Fise0gAHCR4AACRxtcAAQIMEgAAEhkhwACGgiYAAAgv4oAACsxKAAVkxryA=
Date: Thu, 18 Jan 2024 19:02:03 +0000
Message-ID:
 <BY5PR01MB56356BE85E0B8E52C07478C09E712@BY5PR01MB5635.prod.exchangelabs.com>
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
x-ms-traffictypediagnostic: BY5PR01MB5635:EE_|IA0PR01MB8307:EE_
x-ms-office365-filtering-correlation-id: 3dd111d4-7026-479a-1497-08dc1857f53d
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 cd2x7qf2u8TZeGlTAlkvRSw5GFzRWgUIbL8gpWa0QGdmlvrkKr8mY5XGBITHY2MmSY5uD9lL78augLIzqjdwkKAxB4JFoRItEYkiuLAKe4K8ve4DzG8WCFw2P1SwLPlwt4lWrtEHlY6Ydi9mTTxrcPsU1o53ASR/IXAeH3w+WOeTRXML7j9seoRIiT2VRxzaeh0gpVzpRA8pEiSOfBNJryA0BMvPmN9rXkuhX6rTUCLfSw+RqMT43nORd75QpdaAwEgwLvbkzUS1akz9lRdReifQE/5leOoD3gF91Sr0HyN+u/7DcpzwNj5/5iEU3fICPrBvVbzKESVDYRmCTcvF94sQt4YuAq2cpD4rcQqikB0gfWHOQL4qmiSnt4Swg34FlhLuw8CzTXkKddPp7AFGGqFujzM5kZuaPb8cXxl5cc4oDveWKXsCm4y8C4WVLqBUXS8QAb8hW3AY0rU9hw75uyaLk4n8dDk09uJFUw5y6KODtyx5AUjzVc283SQJefz+cOGPa4v2yJX6fvHKhd0KPiajUtyNzcshRBZ6KMMYEuondA1uIHKn4Or8xGon7qBclgskfXXFPW1K8M2aeH7LpWP1oh++HbJJDkxphab6bvAhB07b/MK4UunC56ZESamMB++Uvsavvue7o0yLvbL+3w==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR01MB5635.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(39840400004)(346002)(376002)(136003)(230173577357003)(230273577357003)(64100799003)(186009)(451199024)(1800799012)(83380400001)(53546011)(71200400001)(38100700002)(9686003)(66946007)(8936002)(64756008)(122000001)(966005)(41300700001)(76116006)(7696005)(8676002)(4326008)(5660300002)(66556008)(6506007)(478600001)(7116003)(66476007)(66446008)(6916009)(2906002)(316002)(52536014)(86362001)(33656002)(38070700009)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?4IjMjp+7MDCHZsyC7aiZLVRbLk0ICHu4CjjZ9+uihZojN/GfjnHFlsL2v21u?=
 =?us-ascii?Q?XVJ2+cZS1/GwzI8lbvvP2f+Qi/waDjLtNNm1c1pFTy5c13mo3g54itnBDvZL?=
 =?us-ascii?Q?atb/EDulIi5j75o4ShfjZ40827zZbsIPEyDXy+4Tty8wVrMzZRNLWf5MaDC1?=
 =?us-ascii?Q?TZW9Lkr3j5KQD0QcwuNYxvroyfBhoaUrMZqjqrrFlHL7+qEauRAdJtcRukQ6?=
 =?us-ascii?Q?8NPQCRs7TgyoGOaYszMXMm+HjshBTbq5jpGIdy9xeyPTKQLa7+EcKZwxUXKn?=
 =?us-ascii?Q?1EUjQ3YSFOeAnaL7a9HX72J1xfrxKvzJ6ri8kgHX238jdXvL6TwpnQdrhVUP?=
 =?us-ascii?Q?grde5+RzJ4MfnpJNkQmEtw5GmOyh9mI+f+xaiy9SWRNiuB9yqqA/mvZbunCa?=
 =?us-ascii?Q?ms9n4ltUaHR2XrL3yzAWxIqhRt8C49v6HrkhXkj4Njph7eAhOVJ1Nn1qBF4n?=
 =?us-ascii?Q?XbB+rIb3nS6T4lXUR8owmHCmPqLT1mTLITpN4npcI4UkWE5bTWODazISWIt1?=
 =?us-ascii?Q?jXRosCgV8oBgeQ8g45Q9Cm5uRgwGnZVMqthc6De4tTYAvu2YxirpC9CsFAwM?=
 =?us-ascii?Q?+KUCaHlqG06JuHmpfoURVZiZPGzDyHRWM0N0Z7+IZ8OTvd0U7xN+IxnDDNkY?=
 =?us-ascii?Q?ab9/mMMVh8Z0dDkxpDpKXMWOykounyZ1h3ApFbTxzdbRgVqBJjtLLDiE3sK6?=
 =?us-ascii?Q?KyK2wdrZKxrZHLLzSzND3oavwBPyCLC1dkTPfFcZEkYUqt1G1JFUCkS3Axlr?=
 =?us-ascii?Q?pQSz3X9OfE9Jmt1VrF9Bv5YJ5wi0koYH2lQbUf/zxqMA2axV7sFXDHbRk964?=
 =?us-ascii?Q?B6W0uVjGQCRTri7JYaYDHYXuicWxJUhOd6/nVuVgoh5eX1A48rVADqDU47uc?=
 =?us-ascii?Q?n36WNXSgt+Z2hFUhdayg5+6+nYQIkxazvWnVOlcHUKOFII79mLJKsJxz2Ms6?=
 =?us-ascii?Q?zAr16VrwXtYRdiqUFjw/KbuRE0tClnpMY+h5P1GEvkwMot8cooODBon9w8Kd?=
 =?us-ascii?Q?zIFmxv8ZHMsiW0p6qyX1RNsees0+ezF3NAOThl5oqSabAHvF2MAuB0vd5Ru5?=
 =?us-ascii?Q?9WbiZRcS1bCKPd3gAUK9jetSVxhUtWgrSNnOcmeXMyOAQJcUjkOGF1giu8kC?=
 =?us-ascii?Q?7oP7iLojTwKWoiVK/uaxi2vqztj2vQWo0pEerT9aiesxBj+6fKGigVv0+A7p?=
 =?us-ascii?Q?m7fpFSA5FdM06KCUaBBtF1dTJwqtGdLy/nO1MFL+s1XX5S8QNwSjFtEfKfhH?=
 =?us-ascii?Q?RwtBqxRHzk4cDG4Y7p6slFEQUGT/amKovSKMel7M5bk1FEQIH0P1Qbr4y3en?=
 =?us-ascii?Q?u51zPnqVAd2J5JLae7/MFwOx0+hsUip7MJ/LzKIWj5g9cz4pXAB3JvhhlZ2J?=
 =?us-ascii?Q?Pa/5kBO6RvF1OAlajuwbEzaSvRjjdU8tLR7ZG6UWk1GSD+bya2xJSWXD1HpO?=
 =?us-ascii?Q?jgziT69wstlidhyvAzDhcS1iBZFUO/2D4F6FSNvuEHR2jdLSl3RGk7aRSykj?=
 =?us-ascii?Q?962YxqW0CmUtVITzhd81f3uQaukZ4umV4Pehet3dTdp0/+w19T5KUlbj85c/?=
 =?us-ascii?Q?tYJeqaxoc/f/H9QzTJzwldUhf+yMnxHbmTt7LbJuUZmAXfce+KsHfymLpyI+?=
 =?us-ascii?Q?k2iJ+skie2N8/kl03vsTpj03AWK3NtV+qACR6EFBmhcilkkjhPLhkhMQ/r6b?=
 =?us-ascii?Q?03wrng=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dd111d4-7026-479a-1497-08dc1857f53d
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2024 19:02:03.4952
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Zi7RpJ6QHFogilQ0BuxaXAaBWGyX9PmsvhPt0DTikv6jxMwF4eSZM9W8eGjcJorbjqCuFrrYz7ds7EhpMW1hzFQ9zE+anfhdSNPTa2p/CqVPzwkTCnYkUMlsnNKncn8v
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR01MB8307

Hi, Hugo.
We are still investigating what is going with MAX14830 i2c based tty device=
s on our platform.  The linux version I am running is:
6.1.15-580639a #1 SMP
https://github.com/openbmc/linux.git
commit id: "580639a973406691fa93b8fa377c4c5a43f66094"

Should driver code in the above version suffice?  Or, is there a new versio=
n of the driver that I should be using?
Thanks in advance for your help,
Usha

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
