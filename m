Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5F77C4338F
	for <linux-serial@archiver.kernel.org>; Fri, 13 Aug 2021 11:11:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8151D60720
	for <linux-serial@archiver.kernel.org>; Fri, 13 Aug 2021 11:11:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240257AbhHMLLv (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 13 Aug 2021 07:11:51 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.111.102]:52341 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229526AbhHMLLu (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 13 Aug 2021 07:11:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1628853083;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YuDqYqlDX52XGH6Xx4ZJdfjw6jJ6d2QZyevYR8uar1I=;
        b=SsekhHd+8/Ti/kMdsF79/VrPnDCBPRjLD0K2UKkDp6XJtAF4IZe18X9db9tLG9xxRF3gN1
        aaCX5dz3Y9YNWbmtRmezkviNfnG+6DdXhxNgMVYlQn+geVr3pFVM6vl17k6fl7hocB7k+6
        iaOkP1l2ZrAN2yysABKQ3yD8decbct0=
Received: from EUR03-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur03lp2058.outbound.protection.outlook.com [104.47.10.58]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-38-FFlhevM_MY294yQW3jbm-w-1; Fri, 13 Aug 2021 13:11:21 +0200
X-MC-Unique: FFlhevM_MY294yQW3jbm-w-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M3916OnuYFdSKIjhB+TGEb2NKJ9jjC85JcDvHnhlKIqvZpoGCkuYmSbhOtYNNNmmnW/DILVMRr+wn1v3U/diYn3OscOnutkRHJ0Ca0IhtaTqx96oaFfNXeUC0cLRHvmrlm/MC7cktCEzWsuvb0Po7zj8jL4WhjqBPU1R6v/uXsA0WLfCy2DPxd+O+XxTQYdVL00oIXwmJKc1QI57XOsWtz0LsKi1FCzJ8jPSUWKYY/OhXxSpZkbE5J3SlcBiD01zleOOMqihwaYC91P5u+s6GF79Pt4gAYKDole9RyP7fqK9AqNJqh+lmRg7g+L5ayAx3q0WP3PzdmAObT+A9Qeimg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GQt0L8BpLHE3aVj85F81lBrza1+PpSu2vTo3ac9c/0I=;
 b=lDThBx2WfLucEzDf7xJhDpv1VaD30jonBPLmiV3zN4dQ71bzwV5+AYxqYIvXZg0r7YTHsFiQcRU/lF/1Ob7mi3z2bhllrUmEomiUJdMM0kh5a0l5ke9aUlrIXB7EVmS4vS+AJJqc1SufI7guX5Iv3RkdAmbVbotvJz73E2VF8jaX7OGcXJ6rJ7cGUyO4lY2PZtXfoEPmZ1L+ZXjvzlBh0/oobXvgdgZWeR1i8j9Ns75mEZdCdMDl+nKRtUem7vQDRj/Md5N4EDocg2tP4KMUdsS4mIJPFWT/A5RHvjIvXTFR8GjIXFK4CI5DcotBJWLyu8F0D//AKGMK1WGDCoKp/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com (2603:10a6:803:4::13)
 by VI1PR04MB6959.eurprd04.prod.outlook.com (2603:10a6:803:139::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.13; Fri, 13 Aug
 2021 11:11:19 +0000
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::504b:de61:1358:c344]) by VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::504b:de61:1358:c344%4]) with mapi id 15.20.4415.019; Fri, 13 Aug 2021
 11:11:19 +0000
Date:   Fri, 13 Aug 2021 19:11:04 +0800
From:   Chester Lin <clin@suse.com>
To:     Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-serial@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Stefan Riedmueller <s.riedmueller@phytec.de>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Li Yang <leoyang.li@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Matteo Lisi <matteo.lisi@engicam.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Tim Harvey <tharvey@gateworks.com>,
        Jagan Teki <jagan@amarulasolutions.com>, s32@nxp.com,
        catalin-dan.udma@nxp.com, bogdan.hamciuc@nxp.com,
        bogdan.folea@nxp.com, ciprianmarian.costea@nxp.com,
        radu-nicolae.pirea@nxp.com, ghennadi.procopciuc@nxp.com,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Ivan T . Ivanov" <iivanov@suse.de>, "Lee, Chun-Yi" <jlee@suse.com>
Subject: Re: [PATCH 2/8] dt-bindings: serial: fsl-linflexuart: convert to
 json-schema format
Message-ID: <YRZTSJPFLFFIR+gx@linux-8mug>
References: <20210805065429.27485-1-clin@suse.com>
 <20210805065429.27485-3-clin@suse.com>
 <1ff13837-e6ca-c476-376d-b4f80450a259@suse.de>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1ff13837-e6ca-c476-376d-b4f80450a259@suse.de>
X-ClientProxiedBy: HK2PR02CA0137.apcprd02.prod.outlook.com
 (2603:1096:202:16::21) To VI1PR0402MB3439.eurprd04.prod.outlook.com
 (2603:10a6:803:4::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux-8mug (118.166.51.198) by HK2PR02CA0137.apcprd02.prod.outlook.com (2603:1096:202:16::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.15 via Frontend Transport; Fri, 13 Aug 2021 11:11:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b81df706-99d1-4e14-2b82-08d95e4b1337
X-MS-TrafficTypeDiagnostic: VI1PR04MB6959:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB6959E5D203A8807E5C723991ADFA9@VI1PR04MB6959.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h6pdhDBKcUMTJT6hIr7ft7UWvPUS5+a2aIBPe9MD7dmx5tGO76GTOlN1Cf48xW7wxIzDKq/eVg82zH9HDGI1UwQcdTenA/DDbTN2dhw6SQ7RDgmhE9G/qZnoNO70eCjPfF53x/6e16LALLyOTDXkmjR/y/vn6m4EC5AybRpPmCXJMt+mdSLTeSjKdi9DvYFUW5H0nrAh4OJ0su/RUnEOFsunJGvz1KMLRNWt9KnC+Pqo1RjNFUewQp+e7hPIfO7W/Ap7YAf32VuPvkJwnpK+JRGJWROpRjSMYUfohfFpDz0x0hD4Tc3M+O3uUOdECwilrrpZcxqoqhZpu5Sy+AvkBxi3cvmYQpWRyFckvPUT9o1/MbNt6QFoQpEqKIwT9E/5wHLD2B3jpJT6cTMauJN66eZ8qkzcmLWP23IlgjXmIxnMDPAcGVUMN/MYqDg15v/JVbK4qy0IIpBUYGVMedmwUMF8phZ4PwEAXPUDsrhTd1dlhN8KfOwrv/lbV3i5YCoYC36boXINGpKiXDYcJ17kQ23OPI+TsWjYDlvuBHM912hMrimBuW5NHyauQQB/FUf4rbZ+ROVjFmZ5I4z6ezp3Bk+fIIWAtL7+9tuyEWW7RhmV7CbWwoHMZAOerEo9VExWDsyprYtaCUaDABAgIJGUPy+NRDMAtxtSu4KwsctDRlV5Uy7UhoXmPhBtt2LOKej7mTEsTel0oAp2dIcHGInFXmAqbVA98E3CNE4pZSobm/v/Uw8US0BYV5ftDaEE3+PUcTuEr9IjJnveW8jDVTlnrg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3439.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(136003)(376002)(346002)(39860400002)(8676002)(38100700002)(33716001)(186003)(83380400001)(26005)(54906003)(6666004)(66574015)(66476007)(66946007)(53546011)(55016002)(19627235002)(956004)(55236004)(478600001)(66556008)(9686003)(7416002)(316002)(107886003)(86362001)(6916009)(966005)(8936002)(4326008)(5660300002)(2906002)(6496006)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KAFXVH/1vEtkE9utzQ/dqCydxTG3ChRypVSDd2jGogqhK2tN/PQq61Z0JzSy?=
 =?us-ascii?Q?c0HOcto2yD03PD8g5JOfDciUsNTJGD5XPwGrMgONDQPJJ3p8WyXGrgcqu1fP?=
 =?us-ascii?Q?oh6gyB+6wqkCZ/rfYZY4TKvSurrCRydPCx/bCNO5XtePXA7Oglo6n6rB0/Hz?=
 =?us-ascii?Q?jy+bEOgYJZoJpws4oLZWkls+M5+W7dpeKYWEldGagmb/WJYqiRRe8afEPMiF?=
 =?us-ascii?Q?xpBe6tSeTAvkhnD8UwMQCGPlkx/ou5246dSlaBQvLy9WbFz90p26waKzb9W3?=
 =?us-ascii?Q?f0BwveGHhDOmWZFpeUVEnotDZX34dYBx5QtvtJFDsEwC+UsJyM+NzQMY9dco?=
 =?us-ascii?Q?u0FHhBNDaEVaKOWhPE1eMYmyW/vWJ+cvicO+nF2pGgx0epTH8NGTFXaFHfwg?=
 =?us-ascii?Q?Eit1vLs3FlzjEx/hgzmpK98I1GW7dNx2OHkdrIBdNulVTKo2F2PpR/ocHrIH?=
 =?us-ascii?Q?5j3iaHBw9Ft9XSONoHJWSs3cSFr8/uKzzLgwLJ1A9xT35657uqJFrwjA3CXV?=
 =?us-ascii?Q?koEX3I8zCNiSDTNkVsUu+voCIQUnYiSlX6o/pDz8VKRNiD6n2K9Uajf/6+4z?=
 =?us-ascii?Q?h5jrZmR0OIHpaeuC7amET3QAJaBLNLWYhBt6tA1ZX8u5fbzZcOuR9xRELMCt?=
 =?us-ascii?Q?KgsZc95UsBhXinn0v/kZvmlmjlD/IK/IIWrU5oDfCYC6HkOh8V5tLKfBQql+?=
 =?us-ascii?Q?b/Mez5qZfD+mLhuFeSI9+4Ke009diPr+Ar7Oxg15Ex5sS3ukG4l2aWmIQRIc?=
 =?us-ascii?Q?XvJcSbP+ou98w+ZWg8S5cb49DoIksXAYq75OPt6rETADA2opO10ejWPLUWB1?=
 =?us-ascii?Q?4uODZlDEojpRB6ar2orLy6Zho6750cSpbtUt1w+Qe8boOLcMwnthAgf2eTdh?=
 =?us-ascii?Q?w4jMtqqL4d96JR5VLjWTUkDKsgwE98BiUfJqS4DVk5D3lBNFZrzAUibD/vfU?=
 =?us-ascii?Q?Q8BChyzctIH7vSbHwH2DH1PNlCZiaICwZrmqA2L05qerkTSJ9UP21Z0UbGKW?=
 =?us-ascii?Q?Hriy+auER6Pl/VJLp+TLyS7rlkGV7piHVnaKonQ9WsxpobEJYwB12upp1bGy?=
 =?us-ascii?Q?GEiPGsmMy2QVJVE84lZkVlSIsKLTATA09QMAv6835oTrKKWoNQ+pRNr5dNlX?=
 =?us-ascii?Q?ohANCHXfejlu1izglvBvjsCiLCuNfbnmG/4JxkcY4aJmEFEBdqkrqdjXT1cJ?=
 =?us-ascii?Q?ynBhwrSihl7YZ4TTSmW/iwmIP9D2SpuzUa0JRIW4jABi9BGhz+kq6oE7hy3W?=
 =?us-ascii?Q?q80vx3F4v/Jg1dn4P2nwdOYSTQtVtC93xdBhpeuIC36ZP/y9/FRmGvbC4Wil?=
 =?us-ascii?Q?c0LM8JUf5aIfJyOxCDCYGwed?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b81df706-99d1-4e14-2b82-08d95e4b1337
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3439.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2021 11:11:19.1264
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Eg5NQ+jducC32cXARkVAO8R7AAre/KqIQChRT6/PzkQMs3icwR00WcFHMz8hQZ+F
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6959
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Andreas,

On Thu, Aug 12, 2021 at 06:04:44PM +0200, Andreas F=E4rber wrote:
> On 05.08.21 08:54, Chester Lin wrote:
> > Convert the FSL LINFlexD UART binding to json-schema.
> >=20
> > Signed-off-by: Chester Lin <clin@suse.com>
> > ---
> >  .../bindings/serial/fsl,s32-linflexuart.txt   | 22 ---------
> >  .../bindings/serial/fsl,s32-linflexuart.yaml  | 48 +++++++++++++++++++
> >  2 files changed, 48 insertions(+), 22 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/serial/fsl,s32-li=
nflexuart.txt
> >  create mode 100644 Documentation/devicetree/bindings/serial/fsl,s32-li=
nflexuart.yaml
>=20
> Thanks for your effort, Chester.
>=20
> > diff --git a/Documentation/devicetree/bindings/serial/fsl,s32-linflexua=
rt.txt b/Documentation/devicetree/bindings/serial/fsl,s32-linflexuart.txt
> > deleted file mode 100644
> > index f1bbe0826be5..000000000000
> > --- a/Documentation/devicetree/bindings/serial/fsl,s32-linflexuart.txt
> > +++ /dev/null
> > @@ -1,22 +0,0 @@
> > -* Freescale LINFlexD UART
> > -
> > -The LINFlexD controller implements several LIN protocol versions, as w=
ell as
> > -support for full-duplex UART communication through 8-bit and 9-bit fra=
mes.
> > -
> > -See chapter 47 ("LINFlexD") in the reference manual[1].
> > -
> > -Required properties:
> > -- compatible :
> > -  - "fsl,s32v234-linflexuart" for LINFlexD configured in UART mode, wh=
ich
> > -    is compatible with the one integrated on S32V234 SoC
> > -- reg : Address and length of the register set for the device
> > -- interrupts : Should contain uart interrupt
> > -
> > -Example:
> > -uart0: serial@40053000 {
> > -	compatible =3D "fsl,s32v234-linflexuart";
> > -	reg =3D <0x0 0x40053000 0x0 0x1000>;
> > -	interrupts =3D <0 59 4>;
> > -};
> > -
> > -[1] https://www.nxp.com/webapp/Download?colCode=3DS32V234RM
> > diff --git a/Documentation/devicetree/bindings/serial/fsl,s32-linflexua=
rt.yaml b/Documentation/devicetree/bindings/serial/fsl,s32-linflexuart.yaml
> > new file mode 100644
> > index 000000000000..acfe34706ccb
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/serial/fsl,s32-linflexuart.yaml
> > @@ -0,0 +1,48 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>=20
> Since this is dual-licensed and BSD-2-Clause would seem compatible with
> GPLv3, this could probably be s/GPL-2.0-only/GPL-2.0-or-later/ ? Not a
> blocker.

There's no license identifier in the original file so it's not a problem to
choose "GPL-2.0-or-later".

>=20
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/serial/fsl,s32-linflexuart.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Freescale LINFlexD UART
> > +
> > +description: |
> > +  The LINFlexD controller implements several LIN protocol versions, as=
 well
> > +  as support for full-duplex UART communication through 8-bit and 9-bi=
t
> > +  frames. See chapter 47 ("LINFlexD") in the reference manual
> > +  https://www.nxp.com/webapp/Download?colCode=3DS32V234RM.
> > +
> > +maintainers:
> > +  - Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > +  - Rob Herring <robh@kernel.org>
>=20
> @Shawn: I assume we need both of them to ack this (or an S32V maintainer
> to volunteer), since they were not named in the .txt file before?
>=20
> > +
> > +allOf:
> > +  - $ref: "serial.yaml"
> > +
> > +properties:
> > +  compatible:
> > +    description: The LINFlexD controller on S32V234 SoC, which can be
> > +      configured in UART mode.
> > +    items:
> > +      - const: fsl,s32v234-linflexuart
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +
> > +unevaluatedProperties: false
> > +
> > +examples:
> > +  - |
> > +    serial@40053000 {
> > +        compatible =3D "fsl,s32v234-linflexuart";
> > +        reg =3D <0x40053000 0x1000>;
> > +        interrupts =3D <0 59 4>;
> > +    };
>=20
> Otherwise looking sane,
>=20
> Reviewed-by: Andreas F=E4rber <afaerber@suse.de>
>=20
> Thanks,
> Andreas
>=20
> --=20
> SUSE Software Solutions Germany GmbH
> Maxfeldstr. 5, 90409 N=FCrnberg, Germany
> GF: Felix Imend=F6rffer
> HRB 36809 (AG N=FCrnberg)
>=20

