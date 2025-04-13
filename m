Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2060.outbound.protection.outlook.com [40.107.22.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7725686344;
	Sun, 13 Apr 2025 11:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744545372; cv=fail; b=qJkvwnKO8onyWTb3jOJowzCCTnefswZfHOGXzMtagV/pJqyVGM4T2UkSESImciOnL4a1zp4fJ4UK6I1vMshAXIQEiezwwD2cvt8YzTbC6vkIYvmAMXaSF2ug3I3H4tNzT7SVqzBhwu2IHJjMwV11ILN2AJz1k2/Ybsj64tl/TKc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744545372; c=relaxed/simple;
	bh=0WWkFwINIrcTAD78ItYFsBGVh6r9q5LfuEk526xWCq8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nUTgX+m1u5JjyoNJBXFB38L3RaBFH6e/DC3cEwgCZtmENPA15gvPGRbJYSnEvYh02y4ibQ/N6qLO7Uyho/FaThqnV5X1bKBXQoAYks7rDuf+RKQyN0BwQi6DXCsQkxWz/AsXo3a/MoQoQI2Ysyt9MptKD2EOJ/p+IKBR752IW2E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=A5hu0Df0; arc=fail smtp.client-ip=40.107.22.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="A5hu0Df0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EK/eN1kcm1Y9nFiZ0RajG0QCtkaBQ13583/qCmjdm23twYjWM5GFCRUtj9nJQtKmBcgdijXTE/JzXSq+r2slgSgB18LYjOu023XrNcgeYSQ8zp9lq1FvQrK42yGvvSgamoiUkGHj7WUx5N/7slGgHntwHnFOvoUoblyKb1Y7cc+37QsxVxMIMWMGubOnwb3ZFOwVeLOBWy9Pa2pG6o/woAvnB01lVOLrT7Tw/MOhce4BBV4AyAkvwa4xT+iEwhDovRQXowg61yw5oWvC9FCozCChKBDBIxQN+NlytWgQjWRJmKFIXNEFvGdWIUsMJul0sQlQcKxoQxnHejanXww27w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fsYx5wq4DJm58Mw/DBosKY4nffW8634QjOkSkdFAi6U=;
 b=aQdWlyFQ79ALQo+GAzWN1J+9DSiGfk8QOpxAd5cHWdsjmvjdqbmY9Dv9X0SaatoaROF2DLRf+/JD6pdzcfNAT+K2am3P2YAB62y/tPMovVIUHi3V6euD+pGbKPZ4d+L+NrYCP9cQCUwlx0zGHaXs1trMH+7S77Bg19IkP7kfaB0rdPNGCJz3TOGk9iOcE6OnppPdSZ0jaToRKNZSkP+Smz00Lbnk/BBWzCGVjhUAo03uhLTl8AaWiT8ntv0vsuL2p0ubcCVUu+JJLFqxnIhepsBti7QeGmS5yU5jhMXmWhI2INNAMLFD7NcxLhQdjGRkf4y3kDnQZLSS4hTmIWUjBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fsYx5wq4DJm58Mw/DBosKY4nffW8634QjOkSkdFAi6U=;
 b=A5hu0Df0nJ5k2we3Y0UXs6/ea0cq5r/2X5/ysa74kY6BTsM1vId4XDfLAU1PipRh+3N1A0ftNskm43DXpkl4cvkNW6hzOIMjK0CensDXhypTUeuNSGr9TrBG+cwHIKb1IX72KTyVk4y/ELlui3V37cGndj9B0rj/cS7DBNOScYuFGSJbn3vw8ZACzsnQ3D2deiIj5AVbQ424ON3FY56nv4KRS4xFXa8WHXTJcO7VwWzw+6iKB2SiuamMsNb+jB0QBVmA0zKh9JqPiDc2eUKmenk1BTTjAE1VnjEyONdypHfF6u//deOTnSDGMZ0ChJkgpDeIKQFVnTBFX/yTgbNuQA==
Received: from DB9PR04MB8429.eurprd04.prod.outlook.com (2603:10a6:10:242::19)
 by PA4PR04MB9416.eurprd04.prod.outlook.com (2603:10a6:102:2ab::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.32; Sun, 13 Apr
 2025 11:56:06 +0000
Received: from DB9PR04MB8429.eurprd04.prod.outlook.com
 ([fe80::2edf:edc4:794f:4e37]) by DB9PR04MB8429.eurprd04.prod.outlook.com
 ([fe80::2edf:edc4:794f:4e37%5]) with mapi id 15.20.8632.030; Sun, 13 Apr 2025
 11:56:05 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: "jirislaby@kernel.org" <jirislaby@kernel.org>,
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, Shenwei Wang
	<shenwei.wang@nxp.com>
Subject: RE: [PATCH V4 0/3] tty: serial: fsl_lpuart: cleanup lpuart driver
Thread-Topic: [PATCH V4 0/3] tty: serial: fsl_lpuart: cleanup lpuart driver
Thread-Index: AQHbmjRkZs+nJ/8WhUeFh6Qe8IVy47OereaAgALy9SA=
Date: Sun, 13 Apr 2025 11:56:05 +0000
Message-ID:
 <DB9PR04MB84291F2E69D0380A74EFF31A92B02@DB9PR04MB8429.eurprd04.prod.outlook.com>
References: <20250321073950.108820-1-sherry.sun@nxp.com>
 <2025041157-supply-joyfully-8b9c@gregkh>
In-Reply-To: <2025041157-supply-joyfully-8b9c@gregkh>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR04MB8429:EE_|PA4PR04MB9416:EE_
x-ms-office365-filtering-correlation-id: 59dbb09c-4d10-4ffe-a445-08dd7a822bd4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?QA61zUGxfhkneiG7lZidRd9d3WEhtty4OCNtKeEXVUAjZCKsfK4Fgh68mtnQ?=
 =?us-ascii?Q?krUMMIoR/v74vTmq+T3ZhswSMJ+CpIRVGLkJMN0oBugdHQFYzkI7ypFhdjlD?=
 =?us-ascii?Q?X0DIptL7P1TnLYmPdXks5Y0NPAP0s/xovYZFuv4B7N5088bXSqmEw59GWCVN?=
 =?us-ascii?Q?SNcXKfn633ZOhQxBv3vw9gYJycrqDbiIcpXK4ZtvGdJ/+4sR7h1JnBQEH42u?=
 =?us-ascii?Q?wWK//+FdOpvH6JtVAjJFXFZKn0RNNJeIe95jSsu90vA4kILIf6nwzShSpJdr?=
 =?us-ascii?Q?1ROkuNKsxVVH5g9S5KOtn+wM82Dhcq2H0pZ9krZKsO+txH7w6fyiIN1sZccw?=
 =?us-ascii?Q?n/a0SDWNmQX+j+9kjhEWw6HfSirHR5q9jrwY+fRvTXztdz9jBmEVT9SCKebz?=
 =?us-ascii?Q?8eWy+KqYkbqKViu5KMPtuFlXZtKkv9Msnv8iPfktTniimvwpYWEpuW4QEeoj?=
 =?us-ascii?Q?qZ3GyzGwkVDew73CC0RNmsZYo4/7vBhAGkTs6TreYSql7UhYE0zZH/2MRxIh?=
 =?us-ascii?Q?BndgsbtaDKM6ZkJCbbsGrpxTRXfGUFpcz+VM3HVQxUJTo9D+Na/9thy4tj2G?=
 =?us-ascii?Q?YIIVazRpuEbHLqk0R6Wr1QnGuhsfrS1DmM/23EyIvH+3giBgFQAAQxnF9LgQ?=
 =?us-ascii?Q?rUbXYGRFzfgpYBKEt1a9FGxL86FH/LleRc5hGsBsnwV5xZwex9cF7s+og56O?=
 =?us-ascii?Q?P+VjjDHpFbVChpuWEoVqn4MXoKVH21OOs4nsL7fZrZ+164darMWiaoMJlbVl?=
 =?us-ascii?Q?7pPj9yRR7acjr5dhAyoN1UxJ5FEk+aO1HvRa1wUL9vphzDWR97YDUMFEfbJc?=
 =?us-ascii?Q?nk5QWv//duMrJqL1RvQ5SaztPK9FxOiLbC/+8yuqjmzgDOSGjvkDIfo2Ryi3?=
 =?us-ascii?Q?M/sA4X2O2olid9QEzijrFbjj7+OYTNA6y4BWoSE4XB1Y3AipYxjpJHQFpqrH?=
 =?us-ascii?Q?u4BkZYlTdrNXWVhGX7Zy/sRLzEMLvmhbLmRsuNKNKB+EB3c1fq6SvF6ou0qD?=
 =?us-ascii?Q?iDixH0quuF4xCX60I5j1VIZpHPx0Dj3HLa/NlXORqemF88FyX/jXFAh4ah1e?=
 =?us-ascii?Q?VHret3VZC8ehPvkwutXulXtMXB3BVZuzdTEG+GQv4wVUCMw7LU8+8O9PrTNd?=
 =?us-ascii?Q?NdND1uT5AHsfH0CrD3iLDpg6RXq/f3W4QmQ5hbIAll8ea/RZ1SOj0R2MoOXx?=
 =?us-ascii?Q?IstbcqeZf5pXdLGDElnQF2UGhM041BkDrj0ja2bCPO/1b7MEkuVjN5tpQ4dU?=
 =?us-ascii?Q?ZpXnylV2gTpO6zDlcFi4RLX+QA43sQTofuXHXfUtgLDrM1yu+hY+CDAjqrKH?=
 =?us-ascii?Q?b/alzQU27BEYm2EZwB5/gsD7O0D4VjOtBoYbyPN5JySQLbJ9AhwpWE8m4r8R?=
 =?us-ascii?Q?/6rg8wsOonnf+2Xs4x+hXUneQj9asONbo9H7gfWL/HfKI/s5EWUxSFFMgURp?=
 =?us-ascii?Q?ZvmbyeJszlReNN90BoF17CHWytNz0V2hZyHHFMoYfoMNrrLBBLVh0doiVzON?=
 =?us-ascii?Q?mi/5pTDTYo7eGkc=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8429.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Gdnk+6MMQhlcoqQU0uqo4HpDQRNWziq197PFOAEn6hv93kVgzaGSKIWV2OU1?=
 =?us-ascii?Q?T25o34K8cZ9oz/w0NVkaqKzqW0pLBmUmk5R14d6ouBUFWe9sBHmMXCLX72KZ?=
 =?us-ascii?Q?zrSEAgsk4BnpJvqTCcOOzzIN54qPmC71i86tiOZ4F0U2t+75g9y9hh9sFE/v?=
 =?us-ascii?Q?kiuME341Hm5euf7Mti484bLObtQcn76HcLdDmaa+FAuSZjjosLrOdK/6rwGe?=
 =?us-ascii?Q?Fz7r6SItTRzuHw6Rp+yr6mBjrMVaW5l9oq2ZUmv4kcMsaaCA4Hj6518YH4zT?=
 =?us-ascii?Q?m5eMlUcLT0nnKFegHBdz8zCYbHUum2DcQ0vlI2xKU4iWJUweDgaUaDRV7AL2?=
 =?us-ascii?Q?knIYChRQemqrT1mdPGDmSRq7k6kwKmWHJT9g08IbKpOTJqFOaOWVtGfiENUg?=
 =?us-ascii?Q?FuKYkFi1wvVlYhRzbvPBRVS72z0FCe+ZJfZDR9zEA31lKsYizsUg1tq4xtW7?=
 =?us-ascii?Q?5Sv5fAXY+x9SJY4i56lu+s1+GXB1HReNvraPM46syfjJFnnka9ogojhlO4HH?=
 =?us-ascii?Q?V8B+4SOAEFx8o0HHeRLZodjb8tEagRdDrWztjF2dYMTb60RDFYqe+saTCs9y?=
 =?us-ascii?Q?1aVqE7n2IZD7D9EmYEH/dXIxLYv3uFUXWEZYqxO3raDNlZqh4pJI7q9oFroF?=
 =?us-ascii?Q?q/ak4BQKZBWUDTRJh4ue0PdBWN8UQouN9LRHpxoBRzYvpNKL98zq0qcSTKSx?=
 =?us-ascii?Q?nIha/NtfRet4+6/4OUOLDnMHcBEqvGIeLzGELFHiroD5WuYD5GZiR5olVkAl?=
 =?us-ascii?Q?oK3S2kDHNmbzfXToi0vo7K4aV1grILaGxlYvv7wKmZXM8dypLKBrzpgb09/p?=
 =?us-ascii?Q?oyprLWVITxUyeZyz/1nDs7tss/jx9k4Eazd0nRlDVyvvA9F7cv6Jc6+KW0Y5?=
 =?us-ascii?Q?B/vyLfZ1tSioAHhNU6y1HlutcIDJPuFD6yAXVVQYcThKFYYAYXSqR7LCrArL?=
 =?us-ascii?Q?QR2I3uDIOVIIg+0WWXnD147r9yYiErsKQ5hWfngrOoo87hOmS1qJCvOUjf3E?=
 =?us-ascii?Q?HJPtVllZzuD+e6xv451j5qdMP6giyYWz6X+3xuyFvKyJNz/47pW9X+wauI08?=
 =?us-ascii?Q?j1aNQgXvwvBri6mEO0X9ge0bV1b3UTSF2w++GQ8MxP43jVuySjbkT1/8sDY6?=
 =?us-ascii?Q?mf7/FAHG49Wg+DqXJGufMUb+da0d/HDyyaeLVA4U8QO2KBqHlI2tbFaNNffC?=
 =?us-ascii?Q?Mj8OSCRkQZPUZ5+4uOUNHSCr7ZW6BEWILiKJGNQk5wpkUVv1YNxEH6u+xxQR?=
 =?us-ascii?Q?hP1Yjm929txnoTeMTgblWO9/yPu35GC82TmMWFLpmg09ct2Lj4ehMlLcViMF?=
 =?us-ascii?Q?ZMQVvF+zLzouvdawB+1wQszABiX4SgMEuoircUyo3im+BfcFJN5IOer0Msso?=
 =?us-ascii?Q?M67U+mTrRXO2lyTgt3t+s/2bdY+H3HhPdxZPinFZFR+ggZ5nwZ6Q+h15WAri?=
 =?us-ascii?Q?0cMb0grKXXdPOw0hSqzjWrn3YDYnduka5dY7WVkfkntJvoBnVY1oeUF0Q81V?=
 =?us-ascii?Q?bwjBLCRMQkSkvpe8i4ReMQ0ghpBSB2XlUsbNvXnZPxZSeRsw7ZXDYR8ytnYX?=
 =?us-ascii?Q?Hz97zCDrxCFbAk3QdWCwo16+mRK982kzKNP1LoKp?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 59dbb09c-4d10-4ffe-a445-08dd7a822bd4
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2025 11:56:05.5919
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: erJpd1GdCe1ELFQjMQrLABRjOA4QkeKvbBh9CmEakPyL8Vdl7IWak1/VauHx4/zNMZKl5IH+v00smonnB+2YMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9416



> -----Original Message-----
> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: Friday, April 11, 2025 10:51 PM
> To: Sherry Sun <sherry.sun@nxp.com>
> Cc: jirislaby@kernel.org; linux-serial@vger.kernel.org; linux-
> kernel@vger.kernel.org; imx@lists.linux.dev; Shenwei Wang
> <shenwei.wang@nxp.com>
> Subject: Re: [PATCH V4 0/3] tty: serial: fsl_lpuart: cleanup lpuart drive=
r
>=20
> On Fri, Mar 21, 2025 at 03:39:47PM +0800, Sherry Sun wrote:
> > Do some cleanup for lpuart driver, no functionality change.
> >
> > Changes in V4:
> > 1. Fix unused variable 'sport' warning in patch#2 reported by kernel te=
st
> robot.
> >
> > Changes in V3:
> > 1. Add the change to covert unsigned char to u8 in the first patch as J=
iri
> suggested.
> >
> > Changes in V2:
> > 1. Add the third patch to rename the register variables as Jiri suggest=
ed.
> >
> > Sherry Sun (3):
> >   tty: serial: fsl_lpuart: Use u32 and u8 for register variables
> >   tty: serial: fsl_lpuart: use port struct directly to simply code
> >   tty: serial: fsl_lpuart: rename register variables more specifically
> >
> >  drivers/tty/serial/fsl_lpuart.c | 472 ++++++++++++++++----------------
> >  1 file changed, 231 insertions(+), 241 deletions(-)
> >
> > --
> > 2.34.1
> >
>=20
> None of this applies to 6.15-rc1, what went wrong?


Hi Greg,
I can see above patches are applied to L6.15-rc1 tree, please check
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/log/driv=
ers/tty/serial/fsl_lpuart.c?h=3Dv6.15-rc1

Best Regards
Sherry
