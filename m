Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2123.outbound.protection.partner.outlook.cn [139.219.17.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86CB7A937;
	Mon, 20 May 2024 02:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716171699; cv=fail; b=tc4pXuW0VMjOjN+HK+9B/YgFlR5NhnJJe5EbLQVmUAqmjR/CcXIL2MDBCMuajkbtsFOxL4BQkhNUvdUz/TEmdLKnqFjkI2QpRJwuSZ8PPoE5MfcahIE7ixxPbfJ3sPZe7IC1Jm0YfhlZiE+8FF+WI8eifndefS+c5ekXptN5SSg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716171699; c=relaxed/simple;
	bh=J0O+1ofwQMSIDgG+AX34v2/U75QKsXvVUr5eqvQBS0g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pqAlT6k+JnwxiB2drp54lAOI8B9G+E+JgpaFGNSbHOWWByPsNLM4k6Eteb0/P+ShxgqSvNjSpaWGeOH5Z1FTaS1W+WyEAlzoBxw2IO1uttbjIbLpOPrxs/Gpr1dzjXGkCj8984bF7/rZAUgwdARZE12BDc+oyxAbB28Yd7yN0Kw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dzV7LYo/c12ZolieE7ro9G/VZ/RKZdLFzOXnH6aOwa7dERoFY+xDn/FDmx4aM5O3wA1tKn4zx9MoCOjOHuhJs9ZtZ7KDnb7ZUjlfKv068lNrIri6AjEL7HJ3UcBTTBeIWrYwK8fT7On9/QH12TJ28YGk4tfTsgCnCF6GyAV/WJ0DrDHiPwTO/Kt03+vNmpdGHtf7khAsEcR4NsWcrDj5/H+ZQF1bQS9w5zFrwmfkCjZhF1Ut/+TAsMoluINQmLLn4S9tN+nAjkOT5d2FHlYeSgrhgMUEij+Nzqu/BGTFUcTkcI+xDMTnj2ObuKuuENTD32MGKl2J2Q0c7Wnh+ZE1sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vVBS9DS0R+fOFyJNUnKA8QOp5fHBabIVD3/mWUEwA0Q=;
 b=goJlgZVNRTjDucQxeci+RmtgKgBkDh/zukkYU0DNVtj6FCkgmdtFJ7M2W9N5ehYZO3DwfYw4HCfgiSW5GxkyyBwVfySL1SLVVfLbAp+8rsE01OeCU3I+yJEXnNGPnd8QIdskCJDBrIi9cTLaB4mp97BXtnfjE4F2xi3PyBiwkKpx7K6Mt/iniHA6Sy9t4XqdB2emX0YCRJKK+jLuSvKFxsViLgKy20F9mDjNr6a6tBtXuaI+qvAGD0ZTsxJoCLriuQjcdpinoD5D5vob4HaAcaSlaDm8SCyByAVOM4b2QqM9xQNtYoGgMuniq/JEKWtne08voR3tSXEctib3xWRR5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1163.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 20 May
 2024 02:06:45 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::5de:15b9:3114:4f45]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::5de:15b9:3114:4f45%5]) with mapi id 15.20.7472.044; Mon, 20 May 2024
 02:06:45 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Conor Dooley <conor@kernel.org>
CC: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
	<jirislaby@kernel.org>, =?iso-8859-1?Q?Ilpo_J=E4rvinen?=
	<ilpo.jarvinen@linux.intel.com>, Philipp Zabel <p.zabel@pengutronix.de>,
	Conor Dooley <conor+dt@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Paul
 Walmsley <paul.walmsley@sifive.com>, Albert Ou <aou@eecs.berkeley.edu>, Emil
 Renner Berthing <emil.renner.berthing@canonical.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1 1/3] dt-bindings: serial: snps-dw-apb-uart: Add one
 more reset signal for StarFive JH7110 SoC
Thread-Topic: [PATCH v1 1/3] dt-bindings: serial: snps-dw-apb-uart: Add one
 more reset signal for StarFive JH7110 SoC
Thread-Index: AQHaqCHgtz79W1ezuki878Bx/wUczbGbmvWAgAPIpRA=
Date: Mon, 20 May 2024 02:06:45 +0000
Message-ID:
 <ZQ2PR01MB13078FDA1D4A37D85F97B4C2E6E92@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>
References: <20240517061713.95803-1-hal.feng@starfivetech.com>
 <20240517061713.95803-2-hal.feng@starfivetech.com>
 <20240517-lion-supplier-f4d15b0edcff@spud>
In-Reply-To: <20240517-lion-supplier-f4d15b0edcff@spud>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1163:EE_
x-ms-office365-filtering-correlation-id: 952465af-f1cc-4095-a440-08dc78717fe5
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 9k5lPWH+vPTvFsARkz8OGSNhI1ys9+qh2xZMbritMzAblBDGG1H/1/iqbIvwnusKvR+ldCjqHbwe5IBQ0TWEAe2tPLI/+j7pYnAuIYm2NWLwmZBhiwkNVu3cBGroYLp2yOGUtzckA1Kz1xAkebcL7N+VlvIzwwKRhn6enrF+CA0UPoTP8TX9/fI1MSFTD19rY0xkBhsxSIjLrmTTKQJTWQcl9yDTtChRv1NQANqUesDeZ0iZWDRS/YrvLbH91QMcmMSBoGZf6TUL2/ye78xMrGNIEjHjyXMSpmrjo65SOTZrbQOzMsmJJafE765ViTh65u9Qg8cOeSvNdQN9XyKtNbmJxiTxsYazT2WLYCfG7u1sMGGdgrEji8mfiRyaoJ39SezSNbbMZfHa1NbBrFvHnET0fmXt6ABdpOvHqbztv1Ti8rqjou50dnwSBzKeSnkCCbjbPokvlqzoFX0HoIn6tk3Mh8N5383TuXEYwIpJicIG2E7SKLx/YLvXH6neVlEI2XuhTxLy+X0hoTyVtToNt/wk/tRwMNmXN2A223MKW4R6oo3Y/eKItBCLSJiIMCT8NOGxixVZHUe4C35Bud2tBJKIq7dUSQq8pxe4CLH0nP/3wcnlwpRroEGf4siC/Ai/
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(41320700004)(7416005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?qKa9waZlakTBGpNhwyn+2noJEn1KcKeYKM+y2MVriYfkakhD1cxcsq6vvC?=
 =?iso-8859-1?Q?0Q7CE2lO/qgtVPuecX3q5dfJxOyEojucGkUEMXWAfZdssF5Cud8EcVPMWf?=
 =?iso-8859-1?Q?ahiF+yKXFKr5lirpGdbBkptO6rb8GnRLudUzZVAxKlX88v5x7/JZg1mo07?=
 =?iso-8859-1?Q?rDjqbDfFgk7c0p6GRDkWHWAdF02lQYU7kI5tCuHFTQvGMq89Fjsvg+GahO?=
 =?iso-8859-1?Q?ipO6S4q3pAEs8KViqkn0x1BBt4nxseUErWkDBiNEJhdU19SGU2AT7AKoER?=
 =?iso-8859-1?Q?yLaGLJWkFPG8qVveMTwVVux2wWBDu+eAZsKbYcJIa60EcH/1k5Iuq+emnR?=
 =?iso-8859-1?Q?POIMVYvDTsaTl/SAW2Q/ziN5utJoc7m2zNNXZ96s4tsSbtGbON4QXcrEUM?=
 =?iso-8859-1?Q?q9/uqbF0W1adGWS+ArtAZIRKuiUaRtVNfgXArxMW/Bvb4MPZEQXEPvrRkZ?=
 =?iso-8859-1?Q?r6vKUNv7d4qfIP3s3W6wRSDAw1vr3nbLBXth0h0DXhEEeZKZx4hg/vymiN?=
 =?iso-8859-1?Q?pDKV1bpVw4L1+Pckm//rLOk2gzqh3jUgf5Bj+U/srouBl6pTOuxd+FQEkI?=
 =?iso-8859-1?Q?8X91ZqrJ9w53IiRKe36Kv+1Y29MXsGcT93441LznAUWRIFPloxSe9VOxFx?=
 =?iso-8859-1?Q?+cDZ/VxBR9r7p0YY4uSXdOuhdSYfibK31Jq3QnWJVyvL1vUG7bX1Uqt9/w?=
 =?iso-8859-1?Q?6aa8smCMtNz7X1VHUW/n5RSWwZ8/CuM4H5cnlJpsWwS4uYxvfEggojqaSP?=
 =?iso-8859-1?Q?NZ0NkrIuWwhVo7zoyCnqRHb8M0ndMOntAWXQX1N3v237Nhwn0uoJ+kPR4e?=
 =?iso-8859-1?Q?/NGvTIAZ8h54PSKVKXANVL1Iu3D+hj8URavkNRr218Pzh8Acfouls2XZnj?=
 =?iso-8859-1?Q?5P7iwOmHWDi9OuYtX8WYoEsU9jWdIdeGGbViGvyW6K7pwR0Kad9z/qcmzx?=
 =?iso-8859-1?Q?uMzoOOfy0JF4fB8/1XAhgaILHwFvKe+0nfVn+U8Kn1F8tTS1PZWp97VN0p?=
 =?iso-8859-1?Q?ulcqyC1ojjIT5kQQc9yhyeJZbk4aXi3AwBk2Llqe7X5rVrwb00tINps6RI?=
 =?iso-8859-1?Q?N6DEfUW/TzC6BQ2nLB0sxDm0IslUeEbSppuxdxc4AIMm5JXFOfHyOSeDZU?=
 =?iso-8859-1?Q?rkob0wYRPttWGtnUV7u7Uy1Jnd3yv3ukxfMuzYomQ+h8HOkMdBl/pcWpuc?=
 =?iso-8859-1?Q?oQVqcAFvRzN8GwFyGgAYoXWAZUTHlsJ3nyebdQE8nMYWxIUZgsw1hosOZ4?=
 =?iso-8859-1?Q?mAXlnH/e/ANJtDTBh8yipkI2xl1iDqrZgb2CXzh/FJUFc+ROJSYq6jFuKw?=
 =?iso-8859-1?Q?y9zL1EO3BPV6zKbT7tOnBUEk+6I6iZnHNyizPEUA3HupHLOAcmszbEPfgo?=
 =?iso-8859-1?Q?Fh/mXVX09mIo8jOznctQxEWV3O7oXz1/K5soRn+ramZIa9TI2QsnLyEWYA?=
 =?iso-8859-1?Q?2BkPiisyY8wkiWQ64UsWyuUy6OO/GpfPtnaRmMJBm1ubs75NsUOsx1G53t?=
 =?iso-8859-1?Q?5p50ptcds9lmBr8HtfvrbLbpucmJ/6YUCKGc2UXTnMozeTeJ4sadEME8Ox?=
 =?iso-8859-1?Q?VrG8of3lqCvC1twmVE7szBEh8qDPjh6tb22EKM17wv0ngxCnXjokv/WDj1?=
 =?iso-8859-1?Q?4cAaFjrFJgl1Mix/3UGrog9OD6yrobQ4tp?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 952465af-f1cc-4095-a440-08dc78717fe5
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2024 02:06:45.1813
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Peb/C4SSXRRbhlnso1gkx95RYSiP3v3nj3jB2IW+rlo3jzXwDI+UpRCIInr0TdqlDQz0SpqWiWps2WepPoGKZnLlGDX1IUGJVOHUg/+bK9A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1163

> On 18.05.24 00:17, Conor Dooley wrote:=20
> On Fri, May 17, 2024 at 02:17:11PM +0800, Hal Feng wrote:
> > The UART of StarFive JH7110 has two reset signals.
> > Both of them are necessary for JH7110 to initialize UART.
> >
> > Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> > ---
> >  .../bindings/serial/snps-dw-apb-uart.yaml          | 14 +++++++++++++-
> >  1 file changed, 13 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.=
yaml
> b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
> > index 1001d2a6ace8..a6396c5cbfb1 100644
> > --- a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
> > +++ b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
> > @@ -13,6 +13,16 @@ allOf:
> >    - $ref: serial.yaml#
> >    - $ref: rs485.yaml#
> >
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            const: starfive,jh7110-uart
> > +    then:
> > +      properties:
> > +        resets:
> > +          minItems: 2
>=20
> else:
>   properties:
>     resets:
>       maxItems: 1

Will fix it later. Thanks for your review.

Best regards,
Hal
