Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11021094.outbound.protection.outlook.com [52.101.62.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091FF2BEC5D;
	Wed, 11 Jun 2025 17:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749662372; cv=fail; b=cELaWxsBhZgS9A+sw03p7zHMcwqIplex6QxiqtUvhgG5ouqhMAGrtYDDPg3A/wyi3t3Vb8RIU7HdwCvAWx0afXmBsjBZENWO20ttTrvnC6/ltU2REwQ0m4BqHqVnGVaPeHdlnSfKs4z4xTUhaxuwP18hkcYQpmLMhvPp+yMZNcM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749662372; c=relaxed/simple;
	bh=hEyjzhq+Qw28bxd31VC2QdQKPfpCny2vRSdOVIDTfPk=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=rZQluO02qLhR3lhYRHCVzsfXRY7Yx9hOa2F6wuYueDgoXHV1AAwwW6teD00tMhsXxrL6edgdPqeD7FH3l40pYxfnV2Q8Qaak6MOyABQMF22Fab00eZJvgk1LkJtfbC7G8Lcp0zoQHqzA4FQKimKguKxBhPDl4UXWxtciarTvyMg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tektelic.com; spf=pass smtp.mailfrom=tektelic.com; dkim=pass (1024-bit key) header.d=Tektelic.onmicrosoft.com header.i=@Tektelic.onmicrosoft.com header.b=OtlvG1vA; arc=fail smtp.client-ip=52.101.62.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tektelic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tektelic.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=Tektelic.onmicrosoft.com header.i=@Tektelic.onmicrosoft.com header.b="OtlvG1vA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lbcoiiubrMw96JljrXavrGR9Py5DncabPj3BxrCe6cPO+iUo8yWAWbc+hNoGDulAQBs+8aLKveS0CPVwjMdHXb1ZzzPWjLK5Kh5g/uxdjh2K1Ldqkqi+I1n2QEGXEnYlC6MBeXHtgCV4+gXJa9dJkVDkN/K0Kr7QVVu4OuHyAf85JVybeP86WiaaSa3dfZBT3VnGki48bgje7VNNLs0T/n51Yd9Z1lT44jPvrieH5Z1s10Qejr1cElS41LVqo5aNgnkqvoxhi+rkDpYULgBVutuXKqzuyn7afSIkeiJ1G9GVJkeDAFhiQubTxRIeiGuZPILfwZ8q3ewj+GzXTisxMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n3WT+HcxFMCD1JPcj3nIEH2ka0g91IPa+y8P3s1krtE=;
 b=kCV0ufor/eZXzcxJQVbBSiViVrAi1kEw/nv1SQGvmWtfsvK6auiShlMr8kwzeKgtXDz7mEQe4lCcGHBVY9nSWJ3l31Y1i4dww3OG/Ps8Z9t0WLZSha2f/PZ/+W7YxZjQsXtjID5cLLW+U8SWM/iAp6aSGYj6i1rrLp4CxmPCIhWU1RmlOplKvQLoxpT92f8jqdoJacGUVi+VLnI6ydKtXSKExMwCRAqZi5WoVTrL2/8wjVAFCGQsBONo2/6C9uuCgqsAI4X7iN+m/B1SR2zdCT2YBZFOG1mWqNLiKm164X0qSjyR6WzK14U/yax6+N/QMKyp+tXmcsf9kTGIyAge9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tektelic.com; dmarc=pass action=none header.from=tektelic.com;
 dkim=pass header.d=tektelic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Tektelic.onmicrosoft.com; s=selector2-Tektelic-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n3WT+HcxFMCD1JPcj3nIEH2ka0g91IPa+y8P3s1krtE=;
 b=OtlvG1vAJpksT70LdMbcEJ55qo423fKdiBz9MJhKTOQRFc5xjcG/v5JzDP7j5bVDDSmXGns64RBzmFS7I98b2Puh35vW5f1S/SOZ+Xy+Z3QkBzjrMSth9jupwty2jPD14Oy0DCaAsO+sAiNqVLpM8WLWqyoSKQyTHNt/p8BztVE=
Received: from DM6PR05MB4923.namprd05.prod.outlook.com (2603:10b6:5:f9::28) by
 PH0PR05MB8366.namprd05.prod.outlook.com (2603:10b6:510:c4::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8769.37; Wed, 11 Jun 2025 17:19:20 +0000
Received: from DM6PR05MB4923.namprd05.prod.outlook.com
 ([fe80::27b8:b7d6:e940:74bc]) by DM6PR05MB4923.namprd05.prod.outlook.com
 ([fe80::27b8:b7d6:e940:74bc%4]) with mapi id 15.20.8769.031; Wed, 11 Jun 2025
 17:19:20 +0000
From: Aidan Stewart <astewart@tektelic.com>
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"jirislaby@kernel.org" <jirislaby@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
	"vadfed@meta.com" <vadfed@meta.com>
Subject: Missing tty device of_node info after 6.8-rc1
Thread-Topic: Missing tty device of_node info after 6.8-rc1
Thread-Index: AQHb2vNWB065kpkaEE6Gap9sTNGo7w==
Date: Wed, 11 Jun 2025 17:19:20 +0000
Message-ID:
 <DM6PR05MB49235690A690EDF4EFEE7CAFAB75A@DM6PR05MB4923.namprd05.prod.outlook.com>
Accept-Language: en-CA, en-US
Content-Language: en-CA
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=tektelic.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR05MB4923:EE_|PH0PR05MB8366:EE_
x-ms-office365-filtering-correlation-id: e06c90b9-5195-4145-21fa-08dda90c1a76
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?bzs8Hv9UHtev1b7TMtdX8rbX8Kb2K6KgMsOt+rLjHlYDPq+VE7hkOD4m1s?=
 =?iso-8859-1?Q?JoOuDzfV/funqGmUxeuckKTJxGRWPi4P18INagtShqR4mX+eHV5ta7FgR7?=
 =?iso-8859-1?Q?k+lk4Te8Piwuy5h3r7ZrBkj0mJ1bwakwqfBSGxl/wr5OGzHWgONS9+ocKH?=
 =?iso-8859-1?Q?harTSYqig5WeHjp8aMAwF5bCC7P8YS4IH+ekk8XpZRGUztVRxpaBOgatua?=
 =?iso-8859-1?Q?oExPuIORaNPr/FmrjSbTOaShwAWhVe9Gg0dEa9P59QJAb+IKVsqJpMT+hk?=
 =?iso-8859-1?Q?RRVgh7prSCeEKS2etwzBLnH4dF7UT/0sfujmE554Sm5z01ThWn1Lx0mQXI?=
 =?iso-8859-1?Q?4xYyWLxjRmQo36VxkHshhNiLO628yFF39eVIkY9taQsOSGHTIjkbmr5vHR?=
 =?iso-8859-1?Q?GBJfKRhxNzSTTo7DPWEz+4pFLoYzphjclOH/GB3h3pegSXeVauyQCHmAE0?=
 =?iso-8859-1?Q?7vq6lMEwecs9Vd+o1mwU50015+SdvIxELCK5ozys+BhKHQ5bm66p9yx4fG?=
 =?iso-8859-1?Q?3y8DFF92sTQ6FJIkdwJbcC7uCH4Cw6gtymyZLOxJ5SeLpROjYZqmWvKtIQ?=
 =?iso-8859-1?Q?4PCWU4spwKbnjJLumqL6jq1Nojt32tSblHBipxe518J1Gk3TB5Dc/cDeCM?=
 =?iso-8859-1?Q?Mqet0Up6Xj7qZVl2z+P7uuy6ety3eVzMsEQNXT5ODRCLHUodyGdBwJRFIq?=
 =?iso-8859-1?Q?78kWh4/0qs3z9Vjb6f/CQXLIrYfsS7lHJuSLYI9NvYD7AwwogGUKCtuU2p?=
 =?iso-8859-1?Q?F4qcCjwhqGP8Kx/U4kAFCh/4OBVlyfR691ZkYGpmKRgqycripI9N/3YZ7a?=
 =?iso-8859-1?Q?u/Sa9oqI6KR6tJ5PeL7ekzx80K7dTn8VjKIOH8UyKZFDZJFJsW3ajZ9ie2?=
 =?iso-8859-1?Q?Wy2ZQ4uETqNLZZt58M0+aMDAQWDAIK3ZWUo61LmBStfLwPXRPBClbtyN/v?=
 =?iso-8859-1?Q?NOF1mPS/UuafhtIitthK/3ruDsub3oFzI95r02LIKdlxyuA6nP9kzHGbHk?=
 =?iso-8859-1?Q?66OFxgxaui8uUhfEBmbDcE3CLKTcn+QziY2zMqDPphGGpKmwQZ+iSLH+2/?=
 =?iso-8859-1?Q?GDTKgomdp6rXTXs0PgSEpUlOf3LW9hydfk6PrV9tyw1SnmX3ioOH52nt9d?=
 =?iso-8859-1?Q?ReExuACG5hRxXSsHwGIurpmXphGUK5mYf/1cpy+qcLZhhweQuMo8i+NDhw?=
 =?iso-8859-1?Q?khq4AG+6k9Ydem1VsLZY8t0gPPy4OTHFy0C/B3FLK1MBCdYXsfvTRqhWup?=
 =?iso-8859-1?Q?Cjn/0JjKWKImJaUebxLmIndw0rISrv0jy8cz/Efn981JA593da3m9BLU74?=
 =?iso-8859-1?Q?uLOOjNXeeAjWp4wedY4AeUDfORkFrV+32CXLmQngA0sP9Gureby/HX2A/x?=
 =?iso-8859-1?Q?DeNBA0M4fhMRji5d3STxqeY65OWkM/nmR/6K+vtSuLrB3qDp3q2daGJ4gT?=
 =?iso-8859-1?Q?ZZfeqzibV8DINvXW2mWqng3edreq64Y02D4NvpURE60G0Ik+ucw0s4XIPp?=
 =?iso-8859-1?Q?hijvf7q4JU6j4pKAtWQdRLFKAt3zYxJmgJ0oybIi6EiNPXkD8XtKfUM590?=
 =?iso-8859-1?Q?k9IraV4=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR05MB4923.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?qfVXZCzCRLhajI9AA+dh7tFU88xym+SsNiUWrvm3Y+pPTCSMRA8ookn+xw?=
 =?iso-8859-1?Q?41mJT1Xk9lsxn7AafsHsEDgBsutgfqqZVn1zQHrhN1u3d/fR6whGKRl4Ka?=
 =?iso-8859-1?Q?xPQHuaEaxiOHB5K0T06+1okSmvHZsw9SV8P5zKswhCh83+yDmvwQuFv6Dp?=
 =?iso-8859-1?Q?Nf6P2JBinl9xTT1ZS6jJPvqppO3wIbeSd7yxsWzWsRw8v4kYNpMxJyxbz/?=
 =?iso-8859-1?Q?2uCOlfwbzs32vzuurZMXj+ZVd6htddnkZiko6t11IsTpCxMuyQKYr68Foz?=
 =?iso-8859-1?Q?Gzy3fBC2FnxcjMMW86vfv40sz2/6VBduJU9PBamdz3VFCrhzsaU1w3fc/K?=
 =?iso-8859-1?Q?OXzoC0kpOGa9+6zCPVP78TswhgCXHGmvoiNgqi4z9WxzV/IyjxhsRBLh03?=
 =?iso-8859-1?Q?3W66vCnKwUEJINhaTWHcWFNxM6IdZLXKiPOx6fc8w+YMiH+gncjS6RBoTZ?=
 =?iso-8859-1?Q?xK1Qe4tD7cST+qS7zWvh/9mAUFXbo/5EVubsLvfLDN6dw8wfZYvCS7aGh+?=
 =?iso-8859-1?Q?C4GRyV4CEvTDb8kiLDoN+48iijIJAwMvSK/BD7ZT9LBsaqkvA+NZxQsDDF?=
 =?iso-8859-1?Q?UWViOdWMS2HTj9df0+buZGFe/ILC87qQJ4HtAIPFQlSSF1g5+YTHECykTV?=
 =?iso-8859-1?Q?1JoXdcv2EqEJDZjlsXNZKxbQwnjLJLKuws89yNRgfkdPXmDcsBUhOLPcFr?=
 =?iso-8859-1?Q?kBjIngwECPCla1a4d0BUQFpvN9GBGssdAnRpn0XcbJXGZEMHdqDmgP4Ek9?=
 =?iso-8859-1?Q?RW4cOXXEvjWCCb27TbB7gAhNT42JbS6qoSpwukqlVHJU1sX7upDUL4T6Nj?=
 =?iso-8859-1?Q?K5FmtQUJhnlLqAWLGL2MWhXMixrvMBZB5js649ey29WK8MZp+MKFLi6FzJ?=
 =?iso-8859-1?Q?FUUx/P8EUtMM25tKhr7H8/+89002c2NA5zogK4+TESBbcDa9NfWaa63Q6d?=
 =?iso-8859-1?Q?2Vi/iZsxbDoRIL3xmExqH9YGjAu9VT9SpfZDdtvROFq6GdIMhFdtYQakm4?=
 =?iso-8859-1?Q?OCWIy5PBBV8kehaJm1ESga4HQgctQu4kNcXSAo5ejL4wXWBUC8MsXIpC0V?=
 =?iso-8859-1?Q?OHldR7HTv5i82l27gjotcumJFVt89sMYZYbrsusZjHcSavWBirazjgf1gY?=
 =?iso-8859-1?Q?7ctzmNmzzVkcYMo7wdY7+7u2G9ZctB/3cimZhyi35Hq6i1Pm0hYmEsD4xB?=
 =?iso-8859-1?Q?VWYQySvkZthNOSC/Eg5otmCpmj6FwNXnZl/ix/6FOE3i3SiTDM9Aue/NGh?=
 =?iso-8859-1?Q?U5gQFKMgsBZfwI1VQSVTTxI293Rgkle6iVM36wulFZ+cl5QNz6VDuEuRwA?=
 =?iso-8859-1?Q?loFBPme9mSzdRr6e6bO2oYkVpMyiJGR30GR6VOCeDZpwbTLZttA+qniAGf?=
 =?iso-8859-1?Q?CLaORZjwClw3u/rzEKZPsiNi+h3hg/D6x5ZzFnJEJjGudNdgwkLOGyJpBE?=
 =?iso-8859-1?Q?F/GuX8wQkPT5ithQSNcW+8kOgtTU1qN9VrCcq1FMRn6klEA43KVBiSTg+V?=
 =?iso-8859-1?Q?OoVCefaPg+yZiYJU7vI6GwrBlibAzA/5xTtKnQMdpmAjIaYiaHSNwF++L8?=
 =?iso-8859-1?Q?OzNWSDxU8AKP0DSwFx621Prgzho9hjy1c1MPpPkiufP3CkQ5N7JdJQFsOF?=
 =?iso-8859-1?Q?mL4lzfDT5voS4=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: tektelic.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR05MB4923.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e06c90b9-5195-4145-21fa-08dda90c1a76
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2025 17:19:20.4656
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 852583a0-3638-4a6d-8abc-0bf61d273218
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2BGtH7ic4eImgW4i991rfGnVvOACUySbaSW1ip6ixuPOCQMRMhJK96ulKZoquHcbLeC+Y3iO2CywKDcRQFXyQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR05MB8366

Hello,=0A=
=0A=
After upgrading from the 6.6 stable kernel series to the 6.12 series, I can=
 no=0A=
longer see any of_node information under /sys/class/tty/ttySn/device/of_nod=
e/.=0A=
This breaks a few of my udev rules for creating symlinks in /dev for these=
=0A=
devices.=0A=
=0A=
This is still present in 6.16-rc1. I have checked on the following hardware=
:=0A=
=0A=
 * Our custom AM335x board=0A=
 * Beagle Black (AM335x)=0A=
 * Texas Instruments TMDS62LEVM=0A=
=0A=
and the of_node information is missing from all of these in 6.12. I bisecte=
d the issue=0A=
to the following commit [1] in 6.8-rc1:=0A=
=0A=
commit b286f4e87e325b76789f30337c98ba72e00532e2=0A=
Author: Tony Lindgren <tony@atomide.com>=0A=
Date:   Mon Nov 13 10:07:52 2023 +0200=0A=
=0A=
    serial: core: Move tty and serdev to be children of serial core port de=
vice=0A=
=0A=
Possibly related, this change also seems to have caused issues with another=
=0A=
driver [2].=0A=
=0A=
Is there any way to view the of_node information (perhaps a KConfig option?=
), or=0A=
is it simply no longer available?=0A=
=0A=
Any assistance would be greatly appreciated.=0A=
=0A=
Thanks,=0A=
=0A=
Aidan Stewart=0A=
=0A=
[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/?h=3Dv6.16-rc1&id=3Db286f4e87e325b76789f30337c98ba72e00532e2=0A=
[2] https://lore.kernel.org/netdev/20240829183603.1156671-1-vadfed@meta.com=
/=0A=
