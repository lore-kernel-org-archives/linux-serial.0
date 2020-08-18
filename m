Return-Path: <SRS0=mq3J=B4=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D80EC433DF
	for <linux-serial@archiver.kernel.org>; Tue, 18 Aug 2020 03:08:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B20B206DA
	for <linux-serial@archiver.kernel.org>; Tue, 18 Aug 2020 03:08:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="fL7rOdk+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbgHRDIq (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 17 Aug 2020 23:08:46 -0400
Received: from mail-eopbgr00088.outbound.protection.outlook.com ([40.107.0.88]:20854
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726302AbgHRDIo (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 17 Aug 2020 23:08:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T8NCa0aIBHBGRW3+VUkfBY86Iirh/5ke3Jcw0W4YgTk9ynlP3oTca1pxv3jK5jy4SCxloNVKZMq0ON5N/s/K622F6YxsAn+kuJrw0RcHiCh7lp+9fWT+YEh7MeHctn5nJiyBmoxspaX5ipUz21XCc0/BgkE8IEEFjn9p9rgHORAJLo96YSMKrFvZvogLgcjKOiXi/Beijqh36VXf2mGtYlSTV2vKd/WP/sPHyQPT26KduBfpa8fJBUNrYposWxYz8F7fcEiC57YVTnkTIkYkgSgjW/ch7j6VeowKLL/YoPa4cSmytSbJhHXrtTySW7jyG4dtQ6BcbxJSqXVyrsJCnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qoXyAv6+CEwoTWj+TpzEmFwbpC/YOEncuexMzv2Lc9w=;
 b=eVe1bYWtAtkZSyFH2uxwc2omtlDyaglfWstkT5T9fexsIDSnWx+3As0hP7GUDVa9ubnxp9rS2+oUJOM0FHjkqkixY5mCqnZL32tCDcc2N7DVm1FFRJPv2huYlBVRunZfwYCeli+4tZUaNmrvCs9HLwVN5I2UdSq6tju7P4swXuZhIN9a0/w995vvFxFAzIePY6PfsJzo9qkQxhLGnnba6Wth83lkqWVnEPbDgWk3vFthAHOuERTgyuqK2yJxf5F1l3UGxSwiRDEv9clypj7AZVNlMr9dWfk0/fFWMoAa2ipmgxpWh7kFRLMSX86WHPTBl9d3HpGNUCspi3tLMA+ejA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qoXyAv6+CEwoTWj+TpzEmFwbpC/YOEncuexMzv2Lc9w=;
 b=fL7rOdk+4d3/4IuHg5atNdnUg7NtvYwzhcSYJPLAjMN31JH1xnLawkaFpBdg4vuIu8rO7G14hD5Sr1Qqbiwk4ZMx7kL9K1UocYl/2c9p2t3p/JpxOJBdnGN+l/cZhOOg942zhrz+sYfyYTqwNEZ0SQ3IUrh+896EiXZujOAiJsk=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (2603:10a6:8:10::18)
 by DB7PR04MB4490.eurprd04.prod.outlook.com (2603:10a6:5:36::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.20; Tue, 18 Aug
 2020 03:08:38 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::8db5:8715:8570:1406]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::8db5:8715:8570:1406%7]) with mapi id 15.20.3283.028; Tue, 18 Aug 2020
 03:08:38 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Rob Herring <robh@kernel.org>
CC:     "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "galak@codeaurora.org" <galak@codeaurora.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V2 4/5] dt-bindings: serial: Convert MXS auart to
 json-schema
Thread-Topic: [PATCH V2 4/5] dt-bindings: serial: Convert MXS auart to
 json-schema
Thread-Index: AQHWcIZ7FvgA9LsKvk2eBl3vzyxOOqk9KoAAgAAKwXA=
Date:   Tue, 18 Aug 2020 03:08:38 +0000
Message-ID: <DB3PR0402MB391683EBE4A7384C3E11ACA7F55C0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1597222284-32609-1-git-send-email-Anson.Huang@nxp.com>
 <1597222284-32609-4-git-send-email-Anson.Huang@nxp.com>
 <20200818021752.GA2147074@bogus>
In-Reply-To: <20200818021752.GA2147074@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 65f8fdb9-682e-40d9-fc18-08d84324011b
x-ms-traffictypediagnostic: DB7PR04MB4490:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB7PR04MB4490ABDDF64A36FFA92B2056F55C0@DB7PR04MB4490.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1417;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7vIPCZx1sZrRik8Gq6cmly6y7F2gvGAk0UwGqg5GNpm9/wXfdxj8P+MZZTBXZGs4jXujJmhz7nQrQ5Lzgb1hOm0Y0J6Mwkq5KQxS+7/rpFWEpdzeov2KSsvLspBaZQh7x8cEGOT4cf/Qt1VtpDwoyayFHDwPmRwJWDFESXys6XUDvoHpSFUU73VIwUh2gddekkbw76HkXFFy9NZG929RGZ4BQUnDKC2k4lZkYJ5dDht6+H/z5I+LJiUt/N00bmyIYze+NLCFHxHYXqFIaDdssWl0f5Yc9XfiPaZ157M7x/4YgrEIpL3To92z0K+6hD8q+Z0yBXz2q16GiIctvtlTKGBTJzAWbp/pi9BGN8CEUSe/nCeTZXHpJzBXrCOr2EV/GDmXHCSEiRISjsk4Sc2OGQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(366004)(376002)(136003)(346002)(83380400001)(8676002)(44832011)(55016002)(71200400001)(45080400002)(6916009)(4326008)(478600001)(9686003)(83080400001)(8936002)(54906003)(66946007)(66556008)(316002)(86362001)(7696005)(66446008)(66476007)(5660300002)(64756008)(33656002)(186003)(52536014)(76116006)(2906002)(26005)(6506007)(7416002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: TpcZtuwwUw+pJUsd//22/t1GCXZimhaW7GaDLXO0fYmkxDxYCFELd3VWX9L5fuXQzD96J5APjbAhOlyhmG9edcydpsvpIzZ/5brds1bGvlh8wEjOtK0KBthRfu1OsqzrrJF/iuhOFSaD1G5jnbbGlJyX0MFQvQEn5XJAHw/6SsdlWhMhQkwEYLMXpK9/Xty0I7YNm3X1gepcj9b0ll1BOqqFStJC8KjMH5DhosDDH3aQdhRqJl9zluqevnqb+LH0UCDF/u36xeq/mqtjYlId1rIi3tsspbAXSG8YTkuQ2MTJpmuP048WGSo9RmAIh7fpcjDnoTIHjy56JhnNQQJ1052KU5BUywx8dklZ94M/fVRuBKvgeg5K9a7nWQ14xayadmeY7VJHsAx/U7SpyTl+ELE8W+Pl7ufVOW2DMZbhaUf95crPiaz/B+hq9Y+2CRc/yLhEXVSiGtvzdpWkqKTYsITeRmZOblfLRkt4ldKy1P/AW/T4bHi6yUu/92gpUd2WVp9ZEW7gU4lkvH37d6rNbXo/6YwKAemG1/5ym3n8JTbbrPBIiFHgw93iRY1ACcPWwNe6NVwatQHVtLCqJrIymSePVRTwS+VO0YGF31k+/A/99c53frPrVCH7Q0TMOEXcwQUK67jfcCBG4cb1O0F8Xg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB3PR0402MB3916.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65f8fdb9-682e-40d9-fc18-08d84324011b
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2020 03:08:38.7890
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rH/iOKtYdu0I+UCIN0teCtdtCxpaJzSNMmN5k1E/8TCc1joIpXu7UxGY42Cb/KW+sQ7GtxWqsrarwCXjkvcDqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4490
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi, Rob


> Subject: Re: [PATCH V2 4/5] dt-bindings: serial: Convert MXS auart to
> json-schema
>=20
> On Wed, Aug 12, 2020 at 04:51:23PM +0800, Anson Huang wrote:
> > Convert the MXS auart binding to DT schema format using json-schema.
> >
> > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> > ---
> > changes since V1:
> > 	- update examples to align with i.MX23/i.MX28 clock bindings;
> > 	- add minItem to clocks/clock-names property as i.MX23/i.MX28 have
> optional clocks
> > 	  property with one item.
> > ---
> >  .../devicetree/bindings/serial/fsl-mxs-auart.txt   | 53 -------------
> >  .../devicetree/bindings/serial/fsl-mxs-auart.yaml  | 91
> > ++++++++++++++++++++++
> >  2 files changed, 91 insertions(+), 53 deletions(-)  delete mode
> > 100644 Documentation/devicetree/bindings/serial/fsl-mxs-auart.txt
> >  create mode 100644
> > Documentation/devicetree/bindings/serial/fsl-mxs-auart.yaml
> >
> > diff --git
> > a/Documentation/devicetree/bindings/serial/fsl-mxs-auart.txt
> > b/Documentation/devicetree/bindings/serial/fsl-mxs-auart.txt
> > deleted file mode 100644
> > index 5c96d41..0000000
> > --- a/Documentation/devicetree/bindings/serial/fsl-mxs-auart.txt
> > +++ /dev/null
> > @@ -1,53 +0,0 @@
> > -* Freescale MXS Application UART (AUART)
> > -
> > -Required properties for all SoCs:
> > -- compatible : Should be one of fallowing variants:
> > -	"fsl,imx23-auart" - Freescale i.MX23
> > -	"fsl,imx28-auart" - Freescale i.MX28
> > -	"alphascale,asm9260-auart" - Alphascale ASM9260
> > -- reg : Address and length of the register set for the device
> > -- interrupts : Should contain the auart interrupt numbers
> > -- dmas: DMA specifier, consisting of a phandle to DMA controller node
> > -  and AUART DMA channel ID.
> > -  Refer to dma.txt and fsl-mxs-dma.txt for details.
> > -- dma-names: "rx" for RX channel, "tx" for TX channel.
> > -
> > -Required properties for "alphascale,asm9260-auart":
> > -- clocks : the clocks feeding the watchdog timer. See
> > clock-bindings.txt
> > -- clock-names : should be set to
> > -	"mod" - source for tick counter.
> > -	"ahb" - ahb gate.
> > -
> > -Optional properties:
> > -- uart-has-rtscts : Indicate the UART has RTS and CTS lines
> > -  for hardware flow control,
> > -	it also means you enable the DMA support for this UART.
> > -- {rts,cts,dtr,dsr,rng,dcd}-gpios: specify a GPIO for
> > RTS/CTS/DTR/DSR/RI/DCD
> > -  line respectively. It will use specified PIO instead of the
> > peripheral
> > -  function pin for the USART feature.
> > -  If unsure, don't specify this property.
> > -
> > -Example:
> > -auart0: serial@8006a000 {
> > -	compatible =3D "fsl,imx28-auart", "fsl,imx23-auart";
> > -	reg =3D <0x8006a000 0x2000>;
> > -	interrupts =3D <112>;
> > -	dmas =3D <&dma_apbx 8>, <&dma_apbx 9>;
> > -	dma-names =3D "rx", "tx";
> > -	cts-gpios =3D <&gpio1 15 GPIO_ACTIVE_LOW>;
> > -	dsr-gpios =3D <&gpio1 16 GPIO_ACTIVE_LOW>;
> > -	dcd-gpios =3D <&gpio1 17 GPIO_ACTIVE_LOW>;
> > -};
> > -
> > -Note: Each auart port should have an alias correctly numbered in "alia=
ses"
> > -node.
> > -
> > -Example:
> > -
> > -aliases {
> > -	serial0 =3D &auart0;
> > -	serial1 =3D &auart1;
> > -	serial2 =3D &auart2;
> > -	serial3 =3D &auart3;
> > -	serial4 =3D &auart4;
> > -};
> > diff --git
> > a/Documentation/devicetree/bindings/serial/fsl-mxs-auart.yaml
> > b/Documentation/devicetree/bindings/serial/fsl-mxs-auart.yaml
> > new file mode 100644
> > index 0000000..5c4fa75
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/serial/fsl-mxs-auart.yaml
> > @@ -0,0 +1,91 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) %YAML 1.2
> > +---
> > +$id:
> > +https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fdev=
i
> >
> +cetree.org%2Fschemas%2Fserial%2Ffsl-mxs-auart.yaml%23&amp;data=3D02%7
> C0
> >
> +1%7CAnson.Huang%40nxp.com%7Cab0ecefb1f8a405a777608d8431ceba7%
> 7C686ea1
> >
> +d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637333138774276608&amp;
> sdata=3D0eW
> > +q1Lnvv2PJcAlS2IThb6DYy9x55jopNRcz%2Fa5YGgc%3D&amp;reserved=3D0
> > +$schema:
> > +https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fdev=
i
> >
> +cetree.org%2Fmeta-schemas%2Fcore.yaml%23&amp;data=3D02%7C01%7CAns
> on.Hua
> >
> +ng%40nxp.com%7Cab0ecefb1f8a405a777608d8431ceba7%7C686ea1d3bc2
> b4c6fa92
> >
> +cd99c5c301635%7C0%7C0%7C637333138774286606&amp;sdata=3D77AsG1n
> Q%2BFl9x0
> > +XStFm6xHXXAO4MNVrkLgezkHni57Y%3D&amp;reserved=3D0
> > +
> > +title: Freescale MXS Application UART (AUART)
> > +
> > +maintainers:
> > +  - Kumar Gala <galak@codeaurora.org>
>=20
> Why is Kumar maintainer and that's a really old email address?

I finally found the fist patch of this binding doc, Kumar ONLY did the movi=
ng of the file to different
folder, I will update the mainatainer to Fabio in V3.

commit 1ea6607d4cdc917987e7e6cfaafc4a630d97a297
Author: Fabio Estevam <fabio.estevam@freescale.com>
Date:   Mon Jun 18 10:06:09 2012 -0300

    serial: mxs-auart: Allow device tree probing

    Allow device tree probing.

    Cc: Grant Likely <grant.likely@secretlab.ca>
    Cc: Rob Herring <rob.herring@calxeda.com>
    Cc: Alan Cox <alan@linux.intel.com>
    Cc: <linux-serial@vger.kernel.org>
    Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
    Signed-off-by: Subodh Nijsure <snijsure@grid-net.com>
    Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Signed-off-by: Shawn Guo <shawn.guo@linaro.org>

Thanks,
Anson
