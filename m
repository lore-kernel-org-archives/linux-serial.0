Return-Path: <SRS0=hg1Z=A4=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E96E3C433E2
	for <linux-serial@archiver.kernel.org>; Fri, 17 Jul 2020 09:43:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC2982070E
	for <linux-serial@archiver.kernel.org>; Fri, 17 Jul 2020 09:43:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="N+oeaMBB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725932AbgGQJnc (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 17 Jul 2020 05:43:32 -0400
Received: from mail-eopbgr40084.outbound.protection.outlook.com ([40.107.4.84]:17542
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725912AbgGQJnc (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 17 Jul 2020 05:43:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OhuDfGsDduORQtuQxSIuZm6gz/aEve3MKAYo2CodaHviin37vY2dQuA+VTSg/CKewZRBgNMmdHbiUpjiqDRT3ogPbYp1itHXWfGoDKbhq6nDUQihVboX9Fvh9Z2duvgkMp6Vce0gHyt6I7ih1qw2bQgzjRQt4TBNoq747EtC0hFMwHZM4CAwIq9tkqDWslTetkqJX7Zr/PnLRNu2Lo4xVDL87xmSqqjqbwxJ0YHalh6crpdsYVz0EBnurt7Kw1qEsh82YxCWGnWF7QUJFZXDDMOf73KTNiZDF9K90CoBfYvEnnVPZw+hRmHh15Zko+X5au263tHvzQpsvSj8F/DB7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7eDIHg4HOoTWgLQRxn8jmt4hejF1Jkt+kPUThK0UEe0=;
 b=oadB5W5kQF9BeEdOBTg+ALg7CIDBR2+FmpekvkoltTrMnsO3nkGVQwXD7ApXBbessIBLYlP8nC/p1FyqPMhDIg5Q2h93CwM1CI+csPwoOXKvAD9LGT6/tys/RTB5zEUK7BPWbmG5BjwEukFT5Eodlnot3nbcYmCjxgx5POLAM1maQOqZgASvwI/ulCYYZ/gcTfOJjTb4KeOPyVswoVSTA7vrKvlImd/I19rxKpnaeZKcfSlqJf2xB+R5v0BaHq1Zoa8kh1SAIJhREFiQCQeC4YyZMcvxPYKxJb2xFLDU9woOZSiWcV81bvRYObLwZUAjbfrvIU8IwfjdS9Gptv6P8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7eDIHg4HOoTWgLQRxn8jmt4hejF1Jkt+kPUThK0UEe0=;
 b=N+oeaMBBwJDqVdvMAruXejYoswTnRCY9Geo1ikNqf/VpNIT5snJJ22NP6oyDnWllE4+gBb44tEMVfh0ixfRWsY8E5Q5XW88AOnyV247bErR2NG3ffHg0ifgXabIsw6dPw5wyANgqgE6r6riqEowm//86GuOOEsRrGqFGE+lT90Y=
Received: from AM6PR0402MB3607.eurprd04.prod.outlook.com
 (2603:10a6:209:12::18) by AM6PR04MB5063.eurprd04.prod.outlook.com
 (2603:10a6:20b:a::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.18; Fri, 17 Jul
 2020 09:43:28 +0000
Received: from AM6PR0402MB3607.eurprd04.prod.outlook.com
 ([fe80::75d9:c8cb:c564:d17f]) by AM6PR0402MB3607.eurprd04.prod.outlook.com
 ([fe80::75d9:c8cb:c564:d17f%5]) with mapi id 15.20.3174.028; Fri, 17 Jul 2020
 09:43:28 +0000
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
Thread-Index: AQHWXBP98HXcYKETtUuSdT5h82zRRKkLeKQAgAAItVCAAANxgIAAAETg
Date:   Fri, 17 Jul 2020 09:43:28 +0000
Message-ID: <AM6PR0402MB3607339D9CC6A33B357C7619FF7C0@AM6PR0402MB3607.eurprd04.prod.outlook.com>
References: <20200717081827.3417-1-fugang.duan@nxp.com>
 <20200717085812.GA1457960@kroah.com>
 <AM6PR0402MB3607DFDA5CB9ACD8E9E578F3FF7C0@AM6PR0402MB3607.eurprd04.prod.outlook.com>
 <20200717094141.GA2420692@kroah.com>
In-Reply-To: <20200717094141.GA2420692@kroah.com>
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
x-ms-office365-filtering-correlation-id: c4682ed8-ba19-43ce-c12d-08d82a35dc2c
x-ms-traffictypediagnostic: AM6PR04MB5063:
x-microsoft-antispam-prvs: <AM6PR04MB5063F198A342CF0D6BAD4AA9FF7C0@AM6PR04MB5063.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6PfUTB/cQ2yzhx2MunD3nnjpB5fmo7ujYvlX4BIHIMt6/alN4DXuS8c5iqoH0z3FUfbk9KeLJeN2BrDgKy3aCUhHeb8cQg0RkhZ39TBjO1w7mZ5ByXar+DQrmTibTJxdu5nMyb1ZRkLg3XwwhjPXyjTd6Heb7OSJvtyvHR16gAgCLKmFKOviHDnE1EeM9pj8DSr6c/bEZiNmrYKG+3zTFA+FQd/PZ1aM4pR6M8sMA9VvHXRt8hXkJFjQ+3YkQNVBsXV2YitCCPKXmj3vVuXyDZIIt0MjxVs9yaIaX8+H6Hke1fHX+lqugGMolyCDQQpLqLbsErXwcBWP27ALAKNnwQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR0402MB3607.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(396003)(376002)(366004)(39860400002)(136003)(55016002)(9686003)(66556008)(64756008)(66446008)(66476007)(66946007)(8676002)(26005)(7696005)(6506007)(186003)(4326008)(54906003)(52536014)(316002)(86362001)(5660300002)(2906002)(33656002)(76116006)(478600001)(8936002)(71200400001)(83380400001)(6916009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 3l+Q6KVvdtxYf7BSNUjkihBGzMyJCa2gUZ23jSy0orBzrzVLqwluePeOnnN1Bn9VH/KtbWWcfnmgcLg6lG66ObVcVSx4h7k/6LgBE/Nj4ojW3e+zkXN9pqTmhnsLQ4uCW3ZPF3+D1tTa11bkWGqcAbfjraQvR4BTVHkagOPSDVm57pHeyjFBOZTuTjmYsdfdKyRL7H3eE29aKF61D4pFezrz2xbS/uqjD84Tm3bAv72ksW3D/FinZgcQG6eP0WiFHHNWm9ArlL5u6dRMO1O/vhzr3lSbb64G3zBbS8hDkIGh9JPTVFJEhAp4CFCMalMQ83WYuBSJ19Yuzvg75s08i37hp64A2V3mkjVpFkwlm1KHPiShRYGXkHz54tRkyoRwtf8nT6jsQzh3Td+11AZoHheVzEI+j44hhIi1TRcaAJi0tv5FTyMdOuMoyIxtysYURWpSUM3F+6qrbmwx5NBHhqobVpy4KvyjfE8gdBNHpw2OUVnqSqWN7wppMTnvSxIw
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR0402MB3607.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4682ed8-ba19-43ce-c12d-08d82a35dc2c
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2020 09:43:28.8029
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SwoOuNdQ3RCTLeFL/jeOcip1rG9I2q5Yrtbl4ld9ggrcPN1gXWIWxlnWf9Ht2rVzJvsWlP9v8ePiX+enPiiS6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5063
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Greg KH <gregkh@linuxfoundation.org> Sent: Friday, July 17, 2020 5:42=
 PM
> On Fri, Jul 17, 2020 at 09:33:20AM +0000, Andy Duan wrote:
> > From: Greg KH <gregkh@linuxfoundation.org> Sent: Friday, July 17, 2020
> > 4:58 PM
> > > On Fri, Jul 17, 2020 at 04:18:27PM +0800, Fugang Duan wrote:
> > > > GKI kernel requires drivers built as modules including console
> > > > driver, so add the support that imx serial console driver can be
> > > > built as module.
> > > >
> > > > The changes of the patch:
> > > > - imx console driver can be built as module.
> > > > - move out earlycon code to separated driver like imx_earlycon.c,
> > > >   and imx earlycon driver only support build-in.
> > > >
> > > > v2:
> > > >  - fix kbuild error
> > > >
> > > > Signed-off-by: Fugang Duan <fugang.duan@nxp.com>
> > > > ---
> > > >  drivers/tty/serial/Kconfig        | 18 +++++++----
> > > >  drivers/tty/serial/Makefile       |  1 +
> > > >  drivers/tty/serial/imx.c          | 37 ++---------------------
> > > >  drivers/tty/serial/imx_earlycon.c | 50
> > > > +++++++++++++++++++++++++++++++
> > > >  4 files changed, 66 insertions(+), 40 deletions(-)
> > > >
> > > > diff --git a/drivers/tty/serial/Kconfig
> > > > b/drivers/tty/serial/Kconfig index 780908d43557..dabd06ca9b66
> > > > 100644
> > > > --- a/drivers/tty/serial/Kconfig
> > > > +++ b/drivers/tty/serial/Kconfig
> > > > @@ -502,20 +502,28 @@ config SERIAL_IMX
> > > >         can enable its onboard serial port by enabling this option.
> > > >
> > > >  config SERIAL_IMX_CONSOLE
> > > > -     bool "Console on IMX serial port"
> > > > -     depends on SERIAL_IMX=3Dy
> > > > +     tristate "Console on IMX serial port"
> > > > +     depends on SERIAL_IMX
> > > >       select SERIAL_CORE_CONSOLE
> > > > -     select SERIAL_EARLYCON if OF
> > > >       help
> > > >         If you have enabled the serial port on the Freescale IMX
> > > > -       CPU you can make it the console by answering Y to this opti=
on.
> > > > +       CPU you can make it the console by answering Y/M to this
> option.
> > > >
> > > > -       Even if you say Y here, the currently visible virtual conso=
le
> > > > +       Even if you say Y/M here, the currently visible virtual
> > > > + console
> > > >         (/dev/tty0) will still be used as the system console by def=
ault,
> but
> > > >         you can alter that using a kernel command line option such
> as
> > > >         "console=3Dttymxc0". (Try "man bootparam" or see the
> > > documentation of
> > > >         your bootloader about how to pass options to the kernel at
> > > > boot time.)
> > > >
> > > > +config SERIAL_IMX_EARLYCON
> > > > +     bool "Earlycon on IMX serial port"
> > > > +     depends on OF
> > > > +     select SERIAL_EARLYCON
> > > > +     default y
> > >
> > > Only put "default y" if you can not boot a machine without this.
> > > Otherwise leave the default line off, it will be 'n' and can be
> > > selected if a user wants that.
> > >
> > > That should be the case here, please change this.
> >
> > I will change it to "default n" in next version, thanks.
>=20
> No, just remove the line, the default is 'n' with no default specified.

Got it, it makes sense. Thanks!
>=20
> thanks,
>=20
> greg k-h
