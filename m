Return-Path: <SRS0=iRHZ=AJ=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63096C433DF
	for <linux-serial@archiver.kernel.org>; Sun, 28 Jun 2020 06:26:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3043020775
	for <linux-serial@archiver.kernel.org>; Sun, 28 Jun 2020 06:26:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Y5iTDnGt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725999AbgF1G07 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 28 Jun 2020 02:26:59 -0400
Received: from mail-eopbgr140077.outbound.protection.outlook.com ([40.107.14.77]:12165
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725958AbgF1G06 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Sun, 28 Jun 2020 02:26:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z+uxEyohqeSEjEFjsoXW2pYib7+KAMbu8llkPtz5zVAjx1oD11BZlPWneM+gH3dkCxShY6futfNG4cPgDSduRQbP7u9IpVkpPn5lDhqkowQhO/PCyjCRfBoRL9ma19z7it9vlRH3S/mS12EecVCukeQ9kQdlbv2u3C4vHsKYG8CMhEcmYVllCrQCX7maW4/uOn84koRMORDc9S0ETOoPtC0xyJIm/FlDgi41ESDQ38X+DM1aLXCE6QeYZh0yhbGSGywS1KN97I8xGQJwbUhkFIoGlx6RldxMchBW1hyjFl4wEGGSqQUuSvJFk9mdqWxP2VZRFqvBtuHN/JcPflMf9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0LQWiRoB7lFVH9OirjADp9o+q57Y++7V3A+bz+o9fsA=;
 b=SyP9qEbBIgBghjxFF/4gaaXm1z2rUwPmMIT9cg1BuJvn3fn67iLSiCLgZYbNcqS30lfYpPmJ90GYeVACR+af9MJl+PLpy5lePDvnahNcWwx2lUGViOmiV8JMb/tMCTdD4rgerMSuAEz1WY0+v2KFIAj8nkQ1NdiS1ZP4YiOfq7cyBmZ6ompAGu8Q3bZm0PD3vHbSeV4QakVF8DldmMWMdqoaeafgmTS8NnhxBqn/9HKdZa6YQhiTA8whdhzPI+9pJpEWQMKhFkqZjf4Dy8qh6YhhYMtXO1skUNWnSGoNeDWMZZttXfWSFR491+mgH3jzjsPAecDSsebCyRnq90bdOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0LQWiRoB7lFVH9OirjADp9o+q57Y++7V3A+bz+o9fsA=;
 b=Y5iTDnGtQwYqflRnArbhksaDEBfURUWZJYoqC31tFmNGLPRzIjqZnvAVpXjfWprYNB8glykwNPI2gi5p/1DalG/HafM53BB2s3EokvJLh4PTSKJwiFtBw4miCXv4yMEYtcfa79RHzQ4EkJXh0l5FdMDVpE0K8hRu0g9vV32r7w4=
Received: from AM6PR0402MB3607.eurprd04.prod.outlook.com
 (2603:10a6:209:12::18) by AM6PR04MB5269.eurprd04.prod.outlook.com
 (2603:10a6:20b:12::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.25; Sun, 28 Jun
 2020 06:26:54 +0000
Received: from AM6PR0402MB3607.eurprd04.prod.outlook.com
 ([fe80::35f8:f020:9b47:9aa1]) by AM6PR0402MB3607.eurprd04.prod.outlook.com
 ([fe80::35f8:f020:9b47:9aa1%7]) with mapi id 15.20.3131.026; Sun, 28 Jun 2020
 06:26:54 +0000
From:   Andy Duan <fugang.duan@nxp.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "lukas@wunner.de" <lukas@wunner.de>,
        "jslaby@suse.com" <jslaby@suse.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: RE: [EXT] Re: [PATCH tty/serial 1/1] tty: serial: imx: enable imx
 serial console port as module
Thread-Topic: [EXT] Re: [PATCH tty/serial 1/1] tty: serial: imx: enable imx
 serial console port as module
Thread-Index: AQHWOxZaCOXDxJNXRUq3E/+YIfJBnKjsptCAgAEMX0A=
Date:   Sun, 28 Jun 2020 06:26:54 +0000
Message-ID: <AM6PR0402MB36079128A22FBAB4EE94079EFF910@AM6PR0402MB3607.eurprd04.prod.outlook.com>
References: <20200605084321.26255-1-fugang.duan@nxp.com>
 <20200627142315.GA1959761@kroah.com>
In-Reply-To: <20200627142315.GA1959761@kroah.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=nxp.com;
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bd0d6a9b-4c67-4491-1fb2-08d81b2c404c
x-ms-traffictypediagnostic: AM6PR04MB5269:
x-microsoft-antispam-prvs: <AM6PR04MB526956BFAC805175DE601B61FF910@AM6PR04MB5269.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0448A97BF2
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XUz3RgMC/yIJfbr4FoPMJ5mS3S/JbJcrMsqBfuVpUHAT0t+qO0R5b7q2oYbvs52XBlrAIXwut5uGLdGg23n8ZcusfKFsQpLti+AZOCJzkV2mJm0je1hO4V90c3Fa5tWl5PRLoD9d0G3YZI9yaXcwO+46zn5CY2SSGdr5e/bv0CaLe5sZkwU6HPiaug/VYOFF3JxXCOqvhr7qC44HsMGuEUYr32ty0AG+uUwqeoKaD0HEERLglpEqtct90iFoikLNE/gnwhfivR6FFsi6ebKF3erLHd4FyCNbmGfI3PxswfgEEd8WnkkrfUbZg0m7IYmGA//Hsebq655pXRAHg0tA+g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR0402MB3607.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(396003)(346002)(376002)(39850400004)(366004)(186003)(9686003)(55016002)(66946007)(66476007)(6916009)(64756008)(66446008)(26005)(54906003)(66556008)(7696005)(6506007)(86362001)(76116006)(478600001)(8936002)(83380400001)(5660300002)(2906002)(4326008)(8676002)(33656002)(52536014)(71200400001)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: UPs0hcQ3rtS1Eamy5UUxYqBnPa0IQrD8M0qd6AfAbxBqYFjSRZj6VnqW2TuVTJ90HUmTslk+uLY/JKS7G67D4F3YmNRg66tyypT8mIkiGaUDEYM9gHHmrRSzVtD/nZxLCTX08E2mYMiwZGplVCXnNonpZimyyxpuFDT0vRMcGIBtvqvgcA37WTYPUJYJRM/EUldjOjaHVlVgqW9VoCcUFzh9j/eOjvcXxMPecz7XuaNJ8czP48WI3P8sAiQz0eHGtxULLstJsSwG1NBBelumHrebQSLIviMk3nv1u8SeCzuzFCG6va4nyKCrMZOHTL0XVfhsPkaU5JkqmVWl6v8wDiwT/xrAVnxxodtte4fsGtCneIm7lXkxJGLEf77U8FTu3gJlJb3wad9gmqVHgLc1nCN6HT1p/XYPP26BnUfNMIux8k8tW7N1TXl61sg9NqVn+AA8bDbFXf70NRS3Kq5lpXBNQLioGZAcF1Ly4sv0IFo=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR0402MB3607.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd0d6a9b-4c67-4491-1fb2-08d81b2c404c
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2020 06:26:54.3133
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yVLSvZaHaKwzTolOMmOZX68YKG3SBBhts4kcX/6qqsz/TIc8PkGUrubcjNF252kFvb+5mLF4jBsJOogfsxgVww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5269
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Greg KH <gregkh@linuxfoundation.org> Sent: Saturday, June 27, 2020 10=
:23 PM
> On Fri, Jun 05, 2020 at 04:43:21PM +0800, Fugang Duan wrote:
> > GKI kernel requires drivers built as modules including console driver,
> > so add the support that imx serial console driver can be built as
> > module.
> >
> > The changes of the patch:
> > - imx console driver can be built as module.
> > - move out earlycon code to separated driver like imx_earlycon.c,
> >   and imx earlycon driver only support build-in.
> >
> > Signed-off-by: Fugang Duan <fugang.duan@nxp.com>
> > ---
> >  drivers/tty/serial/Kconfig        | 17 +++++++----
> >  drivers/tty/serial/Makefile       |  1 +
> >  drivers/tty/serial/imx.c          | 37 ++---------------------
> >  drivers/tty/serial/imx_earlycon.c | 50
> > +++++++++++++++++++++++++++++++
> >  4 files changed, 65 insertions(+), 40 deletions(-)
> >
> > diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> > index adf9e80e7dc9..890cbf214561 100644
> > --- a/drivers/tty/serial/Kconfig
> > +++ b/drivers/tty/serial/Kconfig
> > @@ -502,20 +502,27 @@ config SERIAL_IMX
> >         can enable its onboard serial port by enabling this option.
> >
> >  config SERIAL_IMX_CONSOLE
> > -     bool "Console on IMX serial port"
> > -     depends on SERIAL_IMX=3Dy
> > +     tristate "Console on IMX serial port"
> > +     depends on SERIAL_IMX
> >       select SERIAL_CORE_CONSOLE
> > -     select SERIAL_EARLYCON if OF
> >       help
> >         If you have enabled the serial port on the Freescale IMX
> > -       CPU you can make it the console by answering Y to this option.
> > +       CPU you can make it the console by answering Y/M to this option=
.
> >
> > -       Even if you say Y here, the currently visible virtual console
> > +       Even if you say Y/M here, the currently visible virtual
> > + console
> >         (/dev/tty0) will still be used as the system console by default=
, but
> >         you can alter that using a kernel command line option such as
> >         "console=3Dttymxc0". (Try "man bootparam" or see the
> documentation of
> >         your bootloader about how to pass options to the kernel at
> > boot time.)
> >
> > +config SERIAL_IMX_EARLYCON
> > +     bool "Earlycon on IMX serial port"
> > +     depends OF
> > +     select SERIAL_EARLYCON if OF
> > +     help
> > +       If you have enabled the earlycon on the Freescale IMX
> > +       CPU you can make it the earlycon by answering Y to this option.
> > +
>=20
> Did you test this?
>=20
> I get the folllowing errors with this patch:
>         scripts/kconfig/conf  --oldconfig Kconfig
>         drivers/tty/serial/Kconfig:521: syntax error
>         drivers/tty/serial/Kconfig:520: invalid statement
>         drivers/tty/serial/Kconfig:521: invalid statement
>         drivers/tty/serial/Kconfig:522: invalid statement
>         drivers/tty/serial/Kconfig:523: unknown statement "If"
>         drivers/tty/serial/Kconfig:524:warning: ignoring unsupported
> character '.'
>         drivers/tty/serial/Kconfig:524: unknown statement "CPU"
>         make[1]: *** [scripts/kconfig/Makefile:71: oldconfig] Error 1
>         make: *** [Makefile:606: oldconfig] Error 2
>=20
> I'll let you make the obvious fix and actually test it this time before
> resending :)
>=20
> thanks,
>=20
> greg k-h

Sorry for inconvenient things, I will double check and tested it before res=
ending.
Thanks.=20
