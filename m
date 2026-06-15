Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011051.outbound.protection.outlook.com [52.101.70.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A8438422E;
	Mon, 15 Jun 2026 05:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781502579; cv=fail; b=NDMNlRuK+8KYaGnWIyKHQt40nacndOH+GkjnC7EkLOX+noxZBbDdoBPJA5yx4lDb3B2crma49UZc1Fngs8x6QHu+pAd26b6bUosXzjAAlc6UQCCPmVk9I3aCYznZrk+xKy+sSLrRuB7GkE4mZb954mQrrcMDaRw6uUV80Kox11w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781502579; c=relaxed/simple;
	bh=9zGe1Yfpm8AgfwGiLBHaWwETkCdVeTqwD/XAUUWF5QI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fqi5zF5La9+IWQzex9PVeWihpBHXMYlqS8uwDK4f3PsQNh3LzSAUg8qHKctSnaDvvXC6Sj4tQXb3O0M8VyimctUPsG2zMibJQ/xuvrPJhXoPRr6mWOPqF2bB4vo8jQaWZ/aOLcBx+GyOR2PpoVAIzpHdp6FZOKjmWPMdqsvf5BY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=fVoGP6af; arc=fail smtp.client-ip=52.101.70.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="fVoGP6af"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k7Ul9jfKTSsXxWeum12dCV7cnrgbFTVeMSumzSaQSLth1SFROdEFL7OcUiV2X5gzmr3w6MtBnk9dfLYVvN8AFZMEXL798Ql+bjvAihMrcS8LQqcPYwmCsh2BVszfRxZ3ndxcYMJhjBkWQYCSwBjo4Wl6tE4rud/MBHm/TL7M67/20zJfuGPQnd3BifFK0ZeiyI5Osh0J+BPgD36D8o1F8oKIsQPGOOqwMA1x9b+HlNzY19pZl7QCQRjOHY7cUpn7ew3555Jqa/ZjGoEC9i8XJFtVcUg2JK5oAaB7cG6vB2cUqZJOsimP1YSfXF2HfbfDU+y69ML267k34hIjhkxmMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r/jx6+yglVVyHgdcesSq4zkvbI4pIVvsNfeaT4YQJ4U=;
 b=yW0KwgR7SYZZ+ov+CkNAEaT6r8/uxK9pnYHe7HERftojEh8k3aPLaA+WbAUBmWNIciszv8YbJzmJmoRwZ/Zshe/sqqRrftaHkznjyZppm4F4RT9vyU79V0eHDCHPL2x5Hpbm01UQ2J+y/1G/WPunrhz6aLY/14eY0QXebz/jdOH+c5hbdB2kh54aax9ILjrQn554N19MumJF7SHhQ8sHWgOYl8jaP1Ph5R4HERfKNbcmZfyqsz2TfRCPXLBywcUjBZCXGc94+zwpmLTKIoPz4f/ZhaF3AExyneau+FVv52cfTdUt2bt8SMl1ddnXuFagJJ4psXGXjnnV2P0/f4jAKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r/jx6+yglVVyHgdcesSq4zkvbI4pIVvsNfeaT4YQJ4U=;
 b=fVoGP6afAtTN0bHhwn2iTTfMcTmQ/xg/MlZLYANb017diZMdeVF5KiRHHhTiKJpJBnkvqcHOm2Ag86XGQWIA+lSsLZa866O10P1Cls8bPfkKpmZTeoscns+mvyQApQiehP5RdNYwrWIimPucSm3SbHCNRTStxhT0vMfTNjXcFREtfidhdic8RBghCPJ4xSiegf6xA0C8g86sILNfQnz9ZIZ9Hw1Vs6c7GlJr2RF+SZcraw8J6DcMmrMMmXeo+w0flypIsn9o3StydxX8a7VT9cSq26xiOteSbQXUQADQKa8bL4xuroxn6ukd30dxRCbdbUpgqxpx5RpImKD7TU+55g==
Received: from DU0PR10MB5387.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:329::14)
 by AM0PR10MB3571.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:155::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 05:49:35 +0000
Received: from DU0PR10MB5387.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::de46:63f0:fed4:cdef]) by DU0PR10MB5387.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::de46:63f0:fed4:cdef%6]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 05:49:35 +0000
From: "Starke, Daniel" <daniel.starke@siemens.com>
To: Weiming Shi <bestswngs@gmail.com>
CC: Jiri Slaby <jirislaby@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org"
	<linux-serial@vger.kernel.org>, Xiang Mei <xmei5@asu.edu>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>
Subject: RE: [PATCH] tty: n_gsm: fix NULL deref of gsm->dlci[0] in control
 message handlers
Thread-Topic: [PATCH] tty: n_gsm: fix NULL deref of gsm->dlci[0] in control
 message handlers
Thread-Index: Adz8iBq8O/I2zobuR/2fEq6NEFMaeA==
Date: Mon, 15 Jun 2026 05:49:34 +0000
Message-ID:
 <DU0PR10MB5387DBED6B4DDFF66F1A57B2E0E62@DU0PR10MB5387.EURPRD10.PROD.OUTLOOK.COM>
References: <20260611183217.2488508-2-bestswngs@gmail.com>
 <2026061101-hanky-uninstall-da53@gregkh>
 <DJ74X3U3L9DZ.3RMWZCB0O5ZCE@gmail.com>
 <2026061228-scrubber-cosmetics-c77a@gregkh>
In-Reply-To: <2026061228-scrubber-cosmetics-c77a@gregkh>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=8520ff68-fd97-42e9-afa0-6a3bc7eb06ee;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2026-06-15T05:30:29Z;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR10MB5387:EE_|AM0PR10MB3571:EE_
x-ms-office365-filtering-correlation-id: c5285e03-4537-4ea1-e00e-08decaa1e136
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|55112099003|38070700021|3023799007|22082099003|18002099003|4143699003|11063799006|56012099006|6133799003;
x-microsoft-antispam-message-info:
 qVwdEeJVVriAlpLWgYREt27hrG5gnfxQ9umpOoWMH1YsUcYZlJDEMKcpOXeYG4D5bgKKrnOvNO/d/CHuCMSl+bL1RmuL6s9zvz8OLfzYHnIWirIVSh4c9UVVootDzsTMROQeWDpgAViT1McTgxGO7/m9kINm+c2zMhyBtaqjzsnORDHTuC9rUq7fNZKLxxeGOJtdZdyh+AIpSVQW2R9dsfCI6aQ/0WSGKqFUevo8TqMBPwJXAYAwX0AEwVo4a/WrDqHj5KjPPV38pj8SDI8pWZsT9RvdiocWjf1kG2mdth6v/SAkulzW1FFjrJ6vojjDydIt+g/VNY9zWoCMpbrRyKwNrkwzZ5qWdRwvCt+2B4O9UzmBCTSCSJ2EuVGQHJd77QvChmqUqSnuZ1UrEr3ivT9Hpv+AC1JrcZD8KRq4j+0KYpFUrBitfwwBXa8Enlh4uRsZ7kayPHtoJDip2lQt1efZpE/berW/xhmgHQavHVPDVdhHuDpJCGqSrVUcUleY81fDm11QY/9tFws0LSNnHsoBw8Lf1AO52bYBo/1Rl8qIQZBFtCkp5NeWOEIByfAWq/Mq6ssfjPZ0HyS/+G5tRGN13xjyK/yicPKxKwsugns4fhzW6+3v4tZBhS6GcagrtmXI8sRA+bNppdTW03cJviKSzzDv3oaPp8ygZMHoAqKWR4QdKv1ICVE1i4K69kGuPPMxfhDl3VrW7MyuArsrr4kWiSeynrRP2RvlyqeYZcbwRgz+gVeizXvdBB1tXpWc
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR10MB5387.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(55112099003)(38070700021)(3023799007)(22082099003)(18002099003)(4143699003)(11063799006)(56012099006)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?qZqbQkKcon51oNLScl6joGamen3RLmfMtFrD/M1eKZGd1CkYHT7c72Gy1l5i?=
 =?us-ascii?Q?pKeohKYTDk/jo8doiyLgZCfxSHLDUR4GivQXi5pT5usf7B1j/85lIWa3IJyh?=
 =?us-ascii?Q?JGN4q9n3AgNW+zcaQwl4ipAe7oOwkwFbLnVOmPQeZPmidAfm2JLb9fH3hWkb?=
 =?us-ascii?Q?s8ymAL/YH2me/sFavCiH9qnUXjXTlwITv46xd1NkigPqWVA4FF20v/XtCeYK?=
 =?us-ascii?Q?/MG7Ck30bdYbo8xzVql+1tG6ZylDhyuCL5vnVK05iLBZMmhXBQNEsvYizGpP?=
 =?us-ascii?Q?kx+J+z5pwh3HN1m6pURhKgGcEvqx1JHQbwMHH/FYnz1FW+HWWBVfWbXFwwGZ?=
 =?us-ascii?Q?++jLWtWXUthGSBA5hDCfC4H7KwUQYvKElsPgbF+9IeSt8zN1asTY2RkorKEY?=
 =?us-ascii?Q?q5pLLQyNn1jclzYIg//bKd11jgRMRuLhcqKTcweZxEPmbV/w5z8z7to7cAme?=
 =?us-ascii?Q?D+m1zi5/FUW2NwebJ9zTdp9GTBru+TPIyaT3xV1GebcCATLe4zYHj5pdx1Lk?=
 =?us-ascii?Q?iPpZlpUWwtlHDp7/MrkmZMfmq4xXsGi2n6euU6L6Gq6xZTHjjZlZKkiWO+J7?=
 =?us-ascii?Q?3Wv+2/ByPYI/s9wXR9HoIAR7950qpgSUhm2hAIvKKXsdJ5VWeCsPCLCCwWbf?=
 =?us-ascii?Q?xI6vWTZn2qhIs+05zs62n4lkp4y5+UgLB//PCIvB0+Ty3Tjw/oyA3KV+Y8fa?=
 =?us-ascii?Q?DhCs5uucI5lC3EC6/IwSzMYe2S13Ahu0Oll964CLNE7cvmZSO7bjFavM7Yie?=
 =?us-ascii?Q?r7XEO2imUZzAK2o3d3//tU0dxn5sCVBKUv7BnhdoOVmu62mRvxxtamC8HsF1?=
 =?us-ascii?Q?xJlBoov2m9St6oMUUZja3n8DBeYRX0AR4+gbyBm64ReL3bPI+Jdq9QqDWdze?=
 =?us-ascii?Q?8Yf+c+NdhxtXt+Ec06wRSdjE/fwfINpN5Gk3FfhbPdPyjndfv5+q4bN+uQh8?=
 =?us-ascii?Q?bWddaJBj9pUgm5nBobX8Yjlf1cmNebVfhTMJEb2LQYcDnk6vggVGUskX/fK1?=
 =?us-ascii?Q?oqAbDLwPgC0DzOEjK60t6EmSyXTr+jzrh+CE0BsgJxoFdiVOjZpNg+fGauFI?=
 =?us-ascii?Q?FniXF4J7mJz7zvASBNRKY1KfAQ4Dpdpbkg+UDJXrV7gAImPri97UyfIx3ir6?=
 =?us-ascii?Q?XhB4o7RWlc9oeLO9IsfylkvHXt4Y6MCCTDAa/xLG2a/cSF3zUHchgqdPsqS9?=
 =?us-ascii?Q?DROHoUR7rumJTSqAyTyN8JcyGhx6n2q16d1N52wGApjxnj0lNExiBVYz21wU?=
 =?us-ascii?Q?W/FVAaE8itrpE+lMuel9MV2g87uKkjO/8R0w0sZnCIsoYe4vqiIA7vj1Fl2f?=
 =?us-ascii?Q?8Lum+RI/0a/8O9K8qOEG3G+ne78ZyhJruO61ja4yuPv6wS5FSzoKRWA9UB0q?=
 =?us-ascii?Q?84qUlUuKuEM2P1w5uMe9nrnQQ/FGbcGVtWl7vTugXwi8Yn+pY2ksMqFHkPns?=
 =?us-ascii?Q?9SPdQRY1JI++/F0Bj9SUDAnUm6fNdMtMU/SpjSYeL7+x4CZATYV5HNs82BAJ?=
 =?us-ascii?Q?z8yUQGv2xxO/zZLlSIHo7bH8AwKP6je3g0rxxUHuIhR5NtkhTdKfnSHoECcp?=
 =?us-ascii?Q?RD4BNkD9YT1aLu7EXXqxhhjrPyr+yVP2Vk7kRUjY/pLv6Uy1TWbvcAr9IIbh?=
 =?us-ascii?Q?leVe8dZ8fV0C4eQD9bKlbHTZqAqnpzeaefOuIu0pF7hn67iWmrFiu6LJTx3t?=
 =?us-ascii?Q?D1G/4Ut8+5tEFUWuD5bkR+8kF/uC3GLoiRBrAMQGTM8aMQFeLfj5sGwXSmlU?=
 =?us-ascii?Q?sNvSeO82gA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR10MB5387.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: c5285e03-4537-4ea1-e00e-08decaa1e136
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2026 05:49:34.9636
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YarSyStOiy8NsDS5cuHHKWHWNEKFTylmHNzoZx1MNypeqBXMnQUw7olAeuX86ASnuDzsKUNIGs0mmJopfNqfv5uSjF7W5xBjNzk/3rckhig=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3571

> > I think the fix should serialize the receive side against
> > gsm_cleanup_mux() instead of checking in the handlers. Two ways I can s=
ee:
> >=20
> >   1. take gsm->mutex around the dlci lookup and dispatch in gsm_queue()=
, or
> >   2. pin the dlci across the dispatch using its existing tty_port ref
> >     (dlci_get/dlci_put), so gsm_dlci_free() can't run while it's in use=
.
> >=20
> > Do you have a preference, or is there a pattern in n_gsm you'd rather=20
> > I use? I'll respin v2 once I know which way to go.
>=20
> The bigger issue here is that almost no one has this hardware.  And those=
 that do, don't care about these types of issues as they do not have untrus=
ted data or untrusted users, so be careful when changing things that you ar=
en't able to test.
>=20
> I think that option 2 would probably be best, as that should not affect a=
ny fast code paths, right?

A side note from my side: Using mutex instead of spinlock within the data
transmission path has been tested in the past with a huge performance
regression as a result. This made the protocol unreliable in production due
to its tight timing requirements. Hence, I also vote for option 2. I just
wonder how you plan to implement this. The racing GSMIOC_SETCONF ioctl,
which triggers the gsm_cleanup_mux(), does so in order to re-create the
virtual ttys. It can only do so by a full teardown. If you prevent the
teardown there, the new devices will fail to register in the next step or
the interface will be left with an unpredictable configuration.

See related mail from the past:
https://lore.kernel.org/linux-serial/Zh+iROsYkqoRsJQj@libra05/

Best regards,
Daniel Starke
