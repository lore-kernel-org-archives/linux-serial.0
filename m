Return-Path: <SRS0=hg1Z=A4=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B01BFC433E1
	for <linux-serial@archiver.kernel.org>; Fri, 17 Jul 2020 09:41:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 856C52070E
	for <linux-serial@archiver.kernel.org>; Fri, 17 Jul 2020 09:41:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ce7Kedae"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725950AbgGQJlJ (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 17 Jul 2020 05:41:09 -0400
Received: from mail-eopbgr40070.outbound.protection.outlook.com ([40.107.4.70]:44800
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725912AbgGQJlI (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 17 Jul 2020 05:41:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ikv/Y9dki6M9Ui7d2yacd3SWLzBwxmZqsiyb3YaKNNY+t88NDmKbdwTRiEG5M0XpnytzD3qBA+XCqTU5+a9Sf7yyd/8YrEHE4EwUbMU28D+u422jWzSFkNILFOCGhfduHGA7bq9btkyEHm/Dj+Ql488tJ3IdK1NeKFXFSG/OT0GYJc7q+QLf15Pdw72eSkEFmD0BYWLkm8qx8R/E23SedG86CD220pOG6ZdsAnP0kadi7my/Ryl7SLD7Q1k/qusRtvxcdj2SaKjHmFS0M3yE5YVTLRD9UJJvnHOf3SBH6td7GqOBrcASDXUIlpTDE1OG7GSjJPixwWlWj2OoXv89DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UCxfgxaCsbIRpbE0kStZWZeoDkzMaCq51MT6tnVRRaI=;
 b=Z6KdQuXPGcA/eAwUWl4lhhMg8qu4np/sR9B+HiKT7xX3v7YC90DiuqF9SfqtQ6bd1mXpIB/XEZCB2ybxuR4jEOKbFO8TgjjS+s/5fCoRfvYRHTR8pU98ce0PDJ3mqAnC3d/Z5xRQSF/ixChMRXYK3IBOoJpNibnlZ7P3uuD4xC4XboIqYDVud5HPaF/EeyWzclAC1aZgaG3GH96V2XkwXLduifr2b3gUJ77U/HYI3DiaW0JXFgBIwmseOQjfOWbRa/gPpD8YZ5bQBImcCyUnk46GRhUKMQ+JFPq7001Z3f2K7JWxFAd8vktriLny/jToc9kBUxG1PLcfTcAw7zGD8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UCxfgxaCsbIRpbE0kStZWZeoDkzMaCq51MT6tnVRRaI=;
 b=ce7KedaeEPLo00Cpfr6SaRP9YZg3udNnZAIKNebzDUXCgaeGJYFDkyO/uFofjgcY8rUjMcMyoA3tmtgDFECqRrqTZQ6fWve4Kc+cIlOT33k8FQnihOEuAKPEvKq5fAZ37libMxNaX8jqWaf9qlE3YMXuZJt7fdlMq6et8uoAZR8=
Received: from AM6PR0402MB3607.eurprd04.prod.outlook.com
 (2603:10a6:209:12::18) by AM6PR04MB5063.eurprd04.prod.outlook.com
 (2603:10a6:20b:a::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.18; Fri, 17 Jul
 2020 09:41:05 +0000
Received: from AM6PR0402MB3607.eurprd04.prod.outlook.com
 ([fe80::75d9:c8cb:c564:d17f]) by AM6PR0402MB3607.eurprd04.prod.outlook.com
 ([fe80::75d9:c8cb:c564:d17f%5]) with mapi id 15.20.3174.028; Fri, 17 Jul 2020
 09:41:05 +0000
From:   Andy Duan <fugang.duan@nxp.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "lukas@wunner.de" <lukas@wunner.de>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "jslaby@suse.com" <jslaby@suse.com>
Subject: RE: [EXT] Re: [PATCH tty/serial v2 1/1] tty: serial: imx: enable imx
 serial console port as module
Thread-Topic: [EXT] Re: [PATCH tty/serial v2 1/1] tty: serial: imx: enable imx
 serial console port as module
Thread-Index: AQHWXBP98HXcYKETtUuSdT5h82zRRKkLeN0AgAAJtFA=
Date:   Fri, 17 Jul 2020 09:41:05 +0000
Message-ID: <AM6PR0402MB36074D3821E7B188F3E987D1FF7C0@AM6PR0402MB3607.eurprd04.prod.outlook.com>
References: <20200717081827.3417-1-fugang.duan@nxp.com>
 <20200717085900.GB1457960@kroah.com>
In-Reply-To: <20200717085900.GB1457960@kroah.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1ea9cf87-e86d-4ec4-38e9-08d82a3586f1
x-ms-traffictypediagnostic: AM6PR04MB5063:
x-microsoft-antispam-prvs: <AM6PR04MB5063592A0B6161094F3D3F9BFF7C0@AM6PR04MB5063.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RHX4wg5kc+F88S5tQZ+vULZDNtDBpiSSzV6NUmTwAib1riv9WcYQZHwu9UVbCaLx6UIfRo1WpIh7DOow3bc3isNll6Ti7aHln1r08QuOo6gmNzQtxWrg4t6eXQnyOo9+qc5quJPerzJOeSCmBGxi41STMS3VdbP4XJNZfausYeuUZtyL7x3zb7m58WPm3Xl4GUb1LNs2dhnrZA/uY+i5+hoXraIgNLcq5YfYns+LEgtUMIPxi4jxrggIBIQRtnslhiv8vRhN1mhtXmsFFau0JW2snOaOU5LZqfsRkOtUqLpYQ2SdPX1/hPZJtcYIbt68
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR0402MB3607.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(396003)(376002)(366004)(39860400002)(136003)(55016002)(9686003)(66556008)(64756008)(66446008)(66476007)(66946007)(8676002)(26005)(7696005)(6506007)(186003)(4326008)(54906003)(52536014)(316002)(86362001)(5660300002)(2906002)(33656002)(76116006)(478600001)(8936002)(71200400001)(83380400001)(6916009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: bUdOALwddib9+gJJnXSp+9LC2eSf2ozsNKXUa3CIChVUzmoeuZ9F1OPqxy7edPKFG8fvNDAXxZFCjTr7RXanwCSCviW0yB3JjHseNiAEN7nsMDAQ4QwmnaIqewMlsSPynN7AAPW2IIBsAkFTHisyGcn0Ka7ELvVlBMNFzVV4SZE0jkCkSW0B+OzEioWLbbvlOqZCkRA7fyFr3sNlXToDPWxYUOQisk8NcuyABZvZ5JKBhMn/wrChDlLaHsmTTUjB2SbmTPQkDACkjpNsrOcLLoDSfvL35i/TnnqQXK/x8tRYkcc4cq5PG20LdUs61VObetRrK+vcTfdQ4Xo0tPRUFdKVRNDFpsKAxC071gOGQr813KyZc2613zk/5VAVeB++kMxIjayVaw6hK9USYCZrssQGestZSk1ZbdPW8uOPoFOTUnq6HL6PoMIcg0UwLYvL1NdDR2AMHpl6TQ6uhBfcRts8oWv4n3xcc3wT7BXnM0nnr9Bi/pbQByQZe1rWuwI5
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR0402MB3607.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ea9cf87-e86d-4ec4-38e9-08d82a3586f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2020 09:41:05.7794
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QHIromXzQTqpwcZpCFRa8iEFon/QQZiQgXBfhGt0FKvg2iOjeO+ML/81qeWZ3dHmaxrE9vmnsQPac6Rt0SFpeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5063
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Greg KH <gregkh@linuxfoundation.org> Sent: Friday, July 17, 2020 4:59=
 PM
> On Fri, Jul 17, 2020 at 04:18:27PM +0800, Fugang Duan wrote:
> > GKI kernel requires drivers built as modules including console driver,
> > so add the support that imx serial console driver can be built as
> > module.
>=20
> No one knows what "GKI" is, and it isn't relevant here.
The Next Generation Android Device kernel will consist of generic
Kernel Image (GKI) and several GKI modules, and drivers for specific
hardware (possibly closed-source drivers) will be loaded as kernel modules.=
=20
In short, in this scenario, everything soc vendor driver is modularized.=20

Anyway, it isn't relevant here. Will delete the information in v3.
>=20
> >
> > The changes of the patch:
> > - imx console driver can be built as module.
> > - move out earlycon code to separated driver like imx_earlycon.c,
> >   and imx earlycon driver only support build-in.
>=20
> Why is this not 2 separate patches?
It can be split into 2 separated patches, will update it in v3.

>=20
> > v2:
> >  - fix kbuild error
>=20
> These v2: stuff should go below the --- line.

Got it, thanks for your comments.
>=20
> thanks,
>=20
> greg k-h
