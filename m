Return-Path: <SRS0=FCDA=AK=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21B80C433DF
	for <linux-serial@archiver.kernel.org>; Mon, 29 Jun 2020 01:46:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED6752072D
	for <linux-serial@archiver.kernel.org>; Mon, 29 Jun 2020 01:46:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="rF5tsF8R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbgF2Bql (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 28 Jun 2020 21:46:41 -0400
Received: from mail-eopbgr60049.outbound.protection.outlook.com ([40.107.6.49]:49622
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726395AbgF2Bql (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Sun, 28 Jun 2020 21:46:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g3oj/VHU5wHMOin15Zin24E8y9zFWCBVBc1dn3o1OtKyW2lJuRvzJ5QkD4VBmkKoLCQJmnZ+LmGF4jN9I1Rbjs8nA5O77RUFNO8YsEHp565U2QJGen8GH6buSQcaUtOuXIwV6lkOa2fKDF36zmz6FWR3XIVxMrq6VfX3DjPSXfynRNmVc3Eh4YNIFU5Ru7iGm269A71QyqxxPITJn26VCWhIQ5SkUrhbrOuJCRINDnNryed1m9nCEQMZtrs6Rt4k0EI6911O5XWWnidevc90rQGuRC5ZQmib7uRBQ9AdnxUPO7gKGhyHNJt7Fn7tlFUN1HfxRya93A6erte2PYRHvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MPTkjCSQfDmWP4av3tEARmf/TzyXcMJc+oUALu+hGnI=;
 b=khP5lU+Ttxf26ebusAXODe1YmQrmbYXSxpU4AEDMgHg31THZI3i+ohGiW8hp+wwqsF5PgbMDgmO3nQPfNQQxf/2KZwWBJkVijxvq/SJd3vrs8f+nMedQQI7RShsUbWz8egS+G5YWU/sH/p1MB8+/hxE6C5No6sgD0aDUzsEmQv/kU7xN2+jyXE67fE0wuCwetxuGfmAB75lD902qEUSI9LIICyUNwIEdmKNOAsX9YvD8WzTsYbhL6t6kvysE8Xyr1OZd36Zib8KDmACQcS1m+TD+wf3i8+m48QCgJACCZFooHBdTQ59kS0HsnsGPMhsoWkSWlqJrm/0yOwwrFQHETA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MPTkjCSQfDmWP4av3tEARmf/TzyXcMJc+oUALu+hGnI=;
 b=rF5tsF8RDSill4y2XieIampAduw+SlqbTLvtX8Maca/h7gX9wfbwn+y3JUl/2UgswElxg++szQOuPIoi40hj5klrCF2D54xFZDXRC6LGisEcoNHC9dSoBDJ0xWnMc9qa23vBAsub1Wif/GQf5CP1DJgKricwQ220t22BXvxwhwc=
Received: from AM6PR0402MB3607.eurprd04.prod.outlook.com
 (2603:10a6:209:12::18) by AM7PR04MB6886.eurprd04.prod.outlook.com
 (2603:10a6:20b:106::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.23; Mon, 29 Jun
 2020 01:46:37 +0000
Received: from AM6PR0402MB3607.eurprd04.prod.outlook.com
 ([fe80::35f8:f020:9b47:9aa1]) by AM6PR0402MB3607.eurprd04.prod.outlook.com
 ([fe80::35f8:f020:9b47:9aa1%7]) with mapi id 15.20.3131.026; Mon, 29 Jun 2020
 01:46:37 +0000
From:   Andy Duan <fugang.duan@nxp.com>
To:     =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Greg KH <gregkh@linuxfoundation.org>
CC:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "lukas@wunner.de" <lukas@wunner.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "jslaby@suse.com" <jslaby@suse.com>
Subject: RE: [EXT] Re: [PATCH tty/serial 1/1] tty: serial: imx: enable imx
 serial console port as module
Thread-Topic: [EXT] Re: [PATCH tty/serial 1/1] tty: serial: imx: enable imx
 serial console port as module
Thread-Index: AQHWOxZaCOXDxJNXRUq3E/+YIfJBnKjsptCAgAGtXoCAAKGEcA==
Date:   Mon, 29 Jun 2020 01:46:37 +0000
Message-ID: <AM6PR0402MB360755114CB6C506014CE308FF6E0@AM6PR0402MB3607.eurprd04.prod.outlook.com>
References: <20200605084321.26255-1-fugang.duan@nxp.com>
 <20200627142315.GA1959761@kroah.com>
 <20200628160001.nmogndgajqbalzfo@pengutronix.de>
In-Reply-To: <20200628160001.nmogndgajqbalzfo@pengutronix.de>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [223.104.212.114]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5f31214e-059c-4709-f197-08d81bce4321
x-ms-traffictypediagnostic: AM7PR04MB6886:
x-microsoft-antispam-prvs: <AM7PR04MB6886008F4FEB7080BBE5DE0CFF6E0@AM7PR04MB6886.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-forefront-prvs: 044968D9E1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OiuTzW9RCqRzWHSpFN+ihXrQNhNvYUsAYRW8TVfes5jgvHYvH6qBmUyriJwYC7L7l6csOQi8gaP/rJTkHa6axHyd30gsGT+k4psEI/G3Nf+zpPuhAD1nDbS3M1qRT7zCM8BMEcx9atZQstVYCL12TZECy6RGv6P8PALK6b3ubzgCY/R6+0q/Uv5qykeiB5mjIuofsU0PR8RGa6/kn+nsZogNlKVtSUFbVb8e1IKzyA/BDw3SjG5O+v9xg7ygVKM55dQbnc8eyBiGdfz0UIZCPQn2qDkDk4nVrP+BRzQmHxEiGhPN/+3j4eoUtGJ+FS+24aLWmbIynwXopEID5Vkxxg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR0402MB3607.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(346002)(376002)(39860400002)(136003)(396003)(33656002)(54906003)(186003)(55016002)(4326008)(86362001)(110136005)(83380400001)(2906002)(7696005)(66574015)(9686003)(71200400001)(52536014)(5660300002)(64756008)(66446008)(478600001)(8676002)(316002)(6506007)(26005)(8936002)(66946007)(66556008)(66476007)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: g8BP57tNHDoRlCIuQEC9bpgU8KbDB5+ap0BM7TPBxMp5u10ufK7KbmfzPZdnJ55yzvTba1b4RS78txLnkHfHCQUldqGkL1SJOTE9A92O3OT7v1O5dgRRr16Yezj22b5p2RlQAnnNwm6Jjvt3cWA4oclf5Z/tRSmpRol74LS0aDMq3vkAxSzcBzGseuwftdKRkfx75Ak4S/iCbxP9rj6wX4Y/+40th55neOpSVZ7+9tN/MWcrVWJ4/fY9uBlg9XaXOOoTY1CCJRLadhkJTanmLwabR6BrZFjdCHukx96+wP/MehfXTX3CcS8/37cSRQZnvsQGIq10+4Ycw5d/DkSXWB/wM6jPxliQPTD7nHIGiWlvEbRy4cObCRBjWFGUrLoHMflYje8iqU5z9dbRB1Qfucs/yG8O073+WIpvzHqVNWV7OvECal1nS3ht3+b8Hbf0mqSu/KBEUid/j1sz52CYMpzAQ1Pb1Wy6W9gfS1ORYGu+bAceEDPnua3KQ5RbsLqt
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR0402MB3607.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f31214e-059c-4709-f197-08d81bce4321
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2020 01:46:37.4998
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cEJIpij7HgdOAmOXgR2fxD9lKhwlxi8WNBT9JIpfRMDXplNwo0cdqzY0ADBiIoHsQeFtf/xP+ySDA7fpqI36Qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6886
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de> Sent: Monday, Jun=
e 29, 2020 12:00 AM
> On Sat, Jun 27, 2020 at 04:23:15PM +0200, Greg KH wrote:
> > On Fri, Jun 05, 2020 at 04:43:21PM +0800, Fugang Duan wrote:
> > > GKI kernel requires drivers built as modules including console
> > > driver, so add the support that imx serial console driver can be
> > > built as module.
> > >
> > > The changes of the patch:
> > > - imx console driver can be built as module.
> > > - move out earlycon code to separated driver like imx_earlycon.c,
> > >   and imx earlycon driver only support build-in.
> > >
> > > Signed-off-by: Fugang Duan <fugang.duan@nxp.com>
> > > ---
> > >  drivers/tty/serial/Kconfig        | 17 +++++++----
> > >  drivers/tty/serial/Makefile       |  1 +
> > >  drivers/tty/serial/imx.c          | 37 ++---------------------
> > >  drivers/tty/serial/imx_earlycon.c | 50
> > > +++++++++++++++++++++++++++++++
> > >  4 files changed, 65 insertions(+), 40 deletions(-)
> > >
> > > diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> > > index adf9e80e7dc9..890cbf214561 100644
> > > --- a/drivers/tty/serial/Kconfig
> > > +++ b/drivers/tty/serial/Kconfig
> > > @@ -502,20 +502,27 @@ config SERIAL_IMX
> > >  	  can enable its onboard serial port by enabling this option.
> > >
> > >  config SERIAL_IMX_CONSOLE
> > > -	bool "Console on IMX serial port"
> > > -	depends on SERIAL_IMX=3Dy
> > > +	tristate "Console on IMX serial port"
> > > +	depends on SERIAL_IMX
> > >  	select SERIAL_CORE_CONSOLE
> > > -	select SERIAL_EARLYCON if OF
> > >  	help
> > >  	  If you have enabled the serial port on the Freescale IMX
> > > -	  CPU you can make it the console by answering Y to this option.
> > > +	  CPU you can make it the console by answering Y/M to this option.
> > >
> > > -	  Even if you say Y here, the currently visible virtual console
> > > +	  Even if you say Y/M here, the currently visible virtual console
> > >  	  (/dev/tty0) will still be used as the system console by default, =
but
> > >  	  you can alter that using a kernel command line option such as
> > >  	  "console=3Dttymxc0". (Try "man bootparam" or see the
> documentation of
> > >  	  your bootloader about how to pass options to the kernel at boot
> > > time.)
> > >
> > > +config SERIAL_IMX_EARLYCON
> > > +	bool "Earlycon on IMX serial port"
> > > +	depends OF
> > > +	select SERIAL_EARLYCON if OF
>=20
> Given that SERIAL_IMX_EARLYCON depends on OF, the select can be
> unconditional.

Got it, select SERIAL_EARLYCON is unconditional, will update it in v2.
Thanks.
