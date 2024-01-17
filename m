Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2107.outbound.protection.outlook.com [40.107.237.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE66219E2
	for <linux-serial@vger.kernel.org>; Wed, 17 Jan 2024 15:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705503794; cv=fail; b=HLDkntWEaBTtjatecKNGyzU53fABDUSFwg/3Cx4o14S68f8YfXDVDL5qIdBI3mC/hxdayam1CgLTQQAJuA67pDLLGVkAvG4dx62b8EM4Gxblm8QOXwYFxpBNW+mdiniFNba0maDOF+uLf9qw6W07V/t8qK6Qg/Z9mE5uGExVN6o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705503794; c=relaxed/simple;
	bh=rl6VcwU5zleViCNEs82p7a+uc3tXcpU2hcjr8hlrCj8=;
	h=ARC-Message-Signature:ARC-Authentication-Results:DKIM-Signature:
	 Received:Received:From:To:CC:Subject:Thread-Topic:Thread-Index:
	 Date:Message-ID:References:In-Reply-To:Accept-Language:
	 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:
	 x-ms-exchange-atpmessageproperties:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=mraCjk6uOGiop+XSMwwVYLOXNlz8x9KribKOGHmqqQJCCkmfs3eUy98QRsiV3VcN0BDOV4CIS68Tu1by8PrfqAZo/xU5kwqvGrRZdqNEDwshJQYLTwxq4H2JZZDuuAmLvNE8JEUAAp1IKTk2gItqm1/sGBPmnroV9n8388tcKXk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cornelisnetworks.com; spf=pass smtp.mailfrom=cornelisnetworks.com; dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b=Tj5DKjym; arc=fail smtp.client-ip=40.107.237.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cornelisnetworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cornelisnetworks.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b="Tj5DKjym"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T163deo1BIZ8KlbJbsBlKnmzIYIBa7GUejM2SJ5hB1wmN8AEyIYqWuMH9VNVX1u3FckgpxtdROZ9wyEGttZ+eQsFv6RlIzqn9nUARNx8jg6g+hzaem+dydFLHyNirw2fn26cTGSMomnPL7cG7UrKA8NH2xWzdiFRpHj7sJ+4lmrr2mmOnk9sw79AcuAIKZnImLoFVA0Mtt4/G/8pwzx6bFcvgDqU83uxThP1qvzuAUmqZT16xZYHia2ImWm6hVU3VJlc+GP5moGoPebmCIgFHQ6DU5icnnBgvvlOEjjWjlQNwzeC1DUjpwb5s2yv+2g63hltEcvXYybaV3iD6uXKLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q1Wv1R+umIth4jU0qfsMFSmCGIdez2ANobfQmiKeH4w=;
 b=m3VDnEY5ILs5gd5YJmoOTKBXtziC9LZ2RgoqOcpj1h3O3r2+4wBgfqGt1N4AokDW9uy2mRZ7aq24/NzoXqWa2lIkQDhFKK0zgunBILKl7M4Hxx5L2F6EatT0E9QhnDNS27wxMXedCliMUlKmiKtuWKgztRhle4tw29L5PsnAopfqEzKsgPdenymiln2gjXIoKTd1ajkIALtXNm9f7nMEdqBPt/Eb8lfiGev+DWusc7MfpmmbtsLKIu2w5tlQTZChlZcdAjhoUgY+lA33gTRTV/u2yl80dTZ/XwJkS6fBqB3eh948vZ9/hV6C0b3nB7kP24q8ron6shCAq4lTODktGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q1Wv1R+umIth4jU0qfsMFSmCGIdez2ANobfQmiKeH4w=;
 b=Tj5DKjymWOR57UiTTEBVKQKak7No/aMzrdvHvJPw6hYEMIMHramHnh5doLOiZMkiow2b+e98MX742o7Uz0M0nqk/CiugJ7YuHTUJx7GfyJgzQcCbEfb0Eo9a8vDdroJTijLEK5b/ApUnwcajWFQ614MgHGQ7pMeEGoPbk1wRCBxZRJ3UHGKhvxem8EN58fHp3A35qtn6sFUcUF2K8EDS1NCgbSZf/otnCfaMU6onS56ucnHXjZ9Ff+Mhv6IXVuxip1Pe0eHC8Vj9CUqL8N7vUzbnbcRW9YMGfuc8MvhCpTtAd2qE9JdQzKCAlA4xR/QlSGi/Am+6z1LI7mLws8ctzA==
Received: from BY5PR01MB5635.prod.exchangelabs.com (2603:10b6:a03:1a9::29) by
 MW4PR01MB6323.prod.exchangelabs.com (2603:10b6:303:78::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7202.23; Wed, 17 Jan 2024 15:03:09 +0000
Received: from BY5PR01MB5635.prod.exchangelabs.com
 ([fe80::46d2:6053:23de:c858]) by BY5PR01MB5635.prod.exchangelabs.com
 ([fe80::46d2:6053:23de:c858%3]) with mapi id 15.20.7181.019; Wed, 17 Jan 2024
 15:03:08 +0000
From: "Srinivasan, Usha" <usha.srinivasan@cornelisnetworks.com>
To: Hugo Villeneuve <hugo@hugovil.com>
CC: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
Subject: RE: max14830 nobody cared Disbling IRQ issue
Thread-Topic: max14830 nobody cared Disbling IRQ issue
Thread-Index: AQHaR+YWx8arCI/v3UGtuO9AmL25TbDchOYAgAGXmyA=
Date: Wed, 17 Jan 2024 15:03:08 +0000
Message-ID:
 <BY5PR01MB5635AEE9FABD3E327DAC15E09E722@BY5PR01MB5635.prod.exchangelabs.com>
References:
 <DM4PR01MB75952BAB0B535CF832C89AD99E6B2@DM4PR01MB7595.prod.exchangelabs.com>
	<20240108172934.c457ca06b6543f868d32de46@hugovil.com>
	<DM4PR01MB75959DD41CC90B1B704A05D29E6A2@DM4PR01MB7595.prod.exchangelabs.com>
	<20240110174015.6f20195fde08e5c9e64e5675@hugovil.com>
	<BY5PR01MB5635A9264220404AA6EA5C089E682@BY5PR01MB5635.prod.exchangelabs.com>
	<20240111115239.63d408a688b1b8783de3064f@hugovil.com>
	<BY5PR01MB56351BA462070C585273B3909E682@BY5PR01MB5635.prod.exchangelabs.com>
	<20240111140833.4d312e7e4ae11f1770df8968@hugovil.com>
	<BY5PR01MB5635C11E9BE2B105FB7B87A09E6C2@BY5PR01MB5635.prod.exchangelabs.com>
 <20240116094320.f09f35e36adc9d27902e9694@hugovil.com>
In-Reply-To: <20240116094320.f09f35e36adc9d27902e9694@hugovil.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornelisnetworks.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR01MB5635:EE_|MW4PR01MB6323:EE_
x-ms-office365-filtering-correlation-id: f5bc090e-5fe4-4e2b-0f20-08dc176d6a71
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 4s2Z4X6c/mj1yi/xefFdqGfFQs/KMoUDHXGYW+g0YrXGfl0e93EDUCleEYptfwLeabT95QHKzWWtf7JNqk9xUSBDBo9Q+LKte4ZnpS8pSyYp58TS5W0zSJy7yNnRQCSfk1bERsANX+tIJxUxQflHVUdYSzFrh9XuN12vq1dqMlYYJHSdf8M+0RCIiaobivcHzv/uJc6ZHbP3IFqdymOPa/+VNRrctxs15LKsQ0/d/einWznG1kM2XQFS3RqG1Nj3GjcEXgtE40oERC3kkXmOS5Wm+BPiFrhPDIH4UPV/KmzyyTf+SkvbGZvlNo4ReQjWQXrEhj2Lri9bMl5gkIVmdbeAvkf9E5kFeBPMJbJnxyFkTAQNaHugx7PSEjdK9oPn+X+H7lSlHu+G3pbJZBMMN4TTVGBF2Zz779zOnMMweROHAbCNIuZItD0sJVD9nUJgKOd05/UM2/p0dPLFdAJdl1WDoEA8zcoM6jyymqgbnt3Jnjy7eDpeF2wsDQRSJn0SEM5RWC7W4ZqY9YaQBoFbnvmToM5kDU681cHybx3llB0wEKBjxfO+VpgFO5PZQcqSMcg3fqbO3LkP7WfPYQDr2uxum1qaW15iXfqFDWAJsX1VigSuE2vO3N6/Ga5UcLpxFYTUP5dDucDI14cxDi7fVNaq5Zkue3u6OT0A+Ezw5NQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR01MB5635.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(39840400004)(376002)(136003)(366004)(396003)(346002)(230273577357003)(230173577357003)(186009)(64100799003)(451199024)(1800799012)(41300700001)(122000001)(38100700002)(83380400001)(38070700009)(33656002)(86362001)(52536014)(76116006)(64756008)(66946007)(316002)(8936002)(66446008)(66476007)(66556008)(6916009)(2906002)(4326008)(8676002)(5660300002)(71200400001)(9686003)(6506007)(478600001)(53546011)(7696005)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?XdNkTNh/VoDlkbWjf98hsi5rYhkQ+8aMFSurkmJK2nn1O9Nl8vECniuDdJSV?=
 =?us-ascii?Q?g/wpW/m8vJi1rmJtMjID1Lr9nFT/CUNfvraJqBJ9Hwan2bE0sIsWGOnz0gcr?=
 =?us-ascii?Q?OEKI0nWcmiAOl2PAZcTFKO3XEWInrKiI4wqlWPMGL9eq7ZYwhebBWdMzaYtC?=
 =?us-ascii?Q?TrpyjcgYqdANH+vJ292EfysjNEIOQbPoNjbj63FlhB6OOJjHOinObcs1hzNE?=
 =?us-ascii?Q?g367PGcH2hPSwsRwSCRO9O5O0GpB9xPbMcvDGjlWEqk87pCRY8gZybJAl2J4?=
 =?us-ascii?Q?CShZWTgi8753+C7aq7Y9mkR2rbmD6U8L6Ves/nJZrMXyDT1bd7Ve3Q7OUqBp?=
 =?us-ascii?Q?Cvw/a5V3qH2DPr22l0XgMnnJ/8QbYHkj61yViHP+zBIyG6e/fgmUKoNhCjyM?=
 =?us-ascii?Q?xolsKU5ienheY9Mh2omvVKlHZ8oAdOrFpikyJCkkal+skfs65bUdqxPt/n4C?=
 =?us-ascii?Q?za4RwjKOczSYMD/mOeRckmEbmygZ8+NWx/OPSiIceUVc8t53hnkNRMv+qFvQ?=
 =?us-ascii?Q?Hdx/td9LaltGeVukh3Yy+V/h0OQQoI9wPlSOiUu3/T13EhYv+0F0c4hIpgZt?=
 =?us-ascii?Q?ZHeyq2TCLp9IPXIs4GUEmiPU/Rj9YS71W7RZJdAQ357zUpDxVX968gvznORT?=
 =?us-ascii?Q?H7t235nhfPl/CXHS3dxH/E1W/m2F2JMfwbthpM4ttrGgKSrQ2pmVptRivAUk?=
 =?us-ascii?Q?RB5nnkWy5QMCGBQLPcZkcknnUBZaWiEIAOyY+wlK3eJRxNyS2+1OH0uvpbyE?=
 =?us-ascii?Q?S1Kw7Zh1GFZDl7hKABP+8t8xY2v2mUmd6B9TqZ9r9YiWGVS9zMjyGvxBKYWC?=
 =?us-ascii?Q?Y5ey4MfPmXqNvIOg235RWBi5b8MLB67uoaPuCWbBZuP8aCGq0aHcTSVfm02q?=
 =?us-ascii?Q?SjV8GRRUZqxFZFWn7o+vjdCNN79HUdNzdTNnbTjri7IX2EAmdLrRwPjlzu8N?=
 =?us-ascii?Q?ejPAN3r6hq0n6DuxGfHHdcQbsSrza2nhv/YtT3ulRpmbRQxeGj8fOMuWBrf8?=
 =?us-ascii?Q?SKPbSLiz2DazkizqCrR80REdgx6SQPEXvT63UOT3/NtLdYKNU41Z0d6/Qtre?=
 =?us-ascii?Q?k9lnh7LFf+NkSMHOqGf+qPsayRqi/dRvRiqsgBeOrLOx0i8D9QG4Ni6aCxfy?=
 =?us-ascii?Q?P2ApqN09AdZGhTjReeqTAOX3iyynLgpdYlQgJluqoXt69tV0fOh3VuonWsu8?=
 =?us-ascii?Q?KZbqdYPn1LJI078gxnYFRuiq1SYlht41o9Xg3GC4jOJ6sifRXsLMkAigIKsz?=
 =?us-ascii?Q?BCZ/U89FAiMB4fW2hk1IB7OlKfPbrVhkeOdRsmVVmJW4Zo6liQN1la72aa9H?=
 =?us-ascii?Q?L04pI+oF3qwKkLn4i3G8gWwhFOVeA5t9kOuVzmy3uPNLPsgnZXjg+/n/rzYe?=
 =?us-ascii?Q?TKsz9vs5mwL6rkYqNoo29DdOMxgbVsc22dietg71gbA0JQUj0JyD5Bd6VRam?=
 =?us-ascii?Q?iB5EjS0ANt8VskSwwiZHPprSG6znax9gKMvHsQXOaafQ1wuuHcAD8uaDhEca?=
 =?us-ascii?Q?JPx6TrhLWX5VkN19ocYMlx5M9KryyvYkkSy4kYLHfLWCynCr+0cAmoBcCjHh?=
 =?us-ascii?Q?LrqJynU1F5dZmWPetSHBVKUpDv1R5EmC5zLO14w4jnIJcTE8EjR+jOjdyH9N?=
 =?us-ascii?Q?pDJm1BcwvXeklJYuGEuu6ErcpIurqQHx82D54dtUxq8gJ8uo0CMU9SaSVRp6?=
 =?us-ascii?Q?nmGQAQ=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f5bc090e-5fe4-4e2b-0f20-08dc176d6a71
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2024 15:03:08.4048
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mhVLlkp/+Ux3bPUBSrMnYeRJc8JjHNBwX4yzZ03R20o/2rjBdOH84RpnEJlOLycrQmAyPhCh4MzIHQgnzBF7qcZMI2O6gYQPkKcJoxsOqP/I5ulagOc3YsJSC6l5cKzq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR01MB6323

Hello,
We are investigating another hardware issue. I will resume the old thread a=
fter that, if I need to.
Thanks.
Usha

> -----Original Message-----
> From: Hugo Villeneuve <hugo@hugovil.com>
> Sent: Tuesday, January 16, 2024 9:43 AM
> To: Srinivasan, Usha <usha.srinivasan@cornelisnetworks.com>
> Cc: linux-serial@vger.kernel.org
> Subject: Re: max14830 nobody cared Disbling IRQ issue
>
> On Mon, 15 Jan 2024 19:07:30 +0000
> "Srinivasan, Usha" <usha.srinivasan@cornelisnetworks.com> wrote:
>
> > Hi, Hugo.
> > We fixed our clock issue in the platform; and you were right, I need to=
 bump
> the delay to 100 in addition. I pulled in the latest version of max310x.c=
 from
> torvals linux and I still get the "nobody cared" stack traces & the inter=
rupts get
> disabled.  I'm hoping you can help me get beyond this.
> >
> > 57:     100001          0 1e780000.gpio 152 Level     11-006c
> >  58:     500001          0 1e780000.gpio 153 Level     11-0061
> >  59:     100001          0 1e780000.gpio 154 Level     11-0062
> >  60:     100001          0 1e780000.gpio 155 Level     11-0064
> > [   88.832861] [<da8c4f2b>] irq_default_primary_handler threaded
> [<ac7ce979>] max310x_ist
> > [   88.841725] Disabling IRQ #57
> > [  175.370303] [<da8c4f2b>] irq_default_primary_handler threaded
> > [<ac7ce979>] max310x_ist [  175.379166] Disabling IRQ #59 [
> > 262.242889] [<da8c4f2b>] irq_default_primary_handler threaded
> > [<ac7ce979>] max310x_ist [  262.251752] Disabling IRQ #60 [
> > 369.903466] [<da8c4f2b>] irq_default_primary_handler threaded
> > [<ac7ce979>] max310x_ist [  369.912332] Disabling IRQ #58
> >
> > Thank you.
> > Usha
> > External recipient
>
> Hi Usha,
> please respond to the original email thread, so that people can see what =
has
> been done so far and better help you.
>
> With your crystal issues solved, do you see the exact same problem as bef=
ore?
>
> Can you confirm with a voltmeter or an oscilloscope that your IRQ pin is
> behaving properly before and after you insert the max310x kernel module?
> Maybe it could help if you shared your DTS configuration.
>
> Also, just to be sure, you should not just pull the max310x source code i=
tself,
> but use the whole tree to compile your kernel.
>
> Hugo Villeneuve
External recipient
