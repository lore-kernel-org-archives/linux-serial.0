Return-Path: <SRS0=hg1Z=A4=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93A16C433DF
	for <linux-serial@archiver.kernel.org>; Fri, 17 Jul 2020 09:33:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66D3020717
	for <linux-serial@archiver.kernel.org>; Fri, 17 Jul 2020 09:33:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="FZDx/vA1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725950AbgGQJdX (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 17 Jul 2020 05:33:23 -0400
Received: from mail-eopbgr60077.outbound.protection.outlook.com ([40.107.6.77]:40519
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725912AbgGQJdX (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 17 Jul 2020 05:33:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e3jIafjMZvGZmcPLv+ElOlCM/ZivlBeGp80a6MUEXVuT1eQR7zFjhNrqOJRzBMf4ita38dP0v8YVJXf1fm+tN21YdU9+1/aDp4GlVGkOMJUu2PRuvLBgreUUTlgwrYnTjegh8ytNxkSOABCQrrcaHmNesIxBmN2bETp6OqVQuAFbYDM85RRSzapbsV+oMX0fcEjTMSeR03bKO42Qv31ApFazbgczchJzIg+b40zJ1WGCPecK6/vFyVr74XgluvEzxoyb4+WMUFsoQjWiJrVOtBVuNOpFDCTOU/BWro5TonEazGrNY/ofCvTYSNIo43TgexX+jNvCA4/JGYWStzwa+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wHsf4AhKsd3baJa/tGVipxnPXI3F8SSquVVu1qB6ajE=;
 b=MOfC4HItLzW/s481IutD7IrRrYcQAxykoTdRWkeAhDQMjVO5PBD5lA1TSJEySTF2A77ugTu8Vw0pgCuBTBc52pSFr8RSJnWZUliZMOAfRRsSY3Enk+xVl5SoLrg8+eh9aTFEm2q/pZbIbHp2cQ2B8Nn2uXC3dspsVcq0dnRKJqbWNDqtLwvwdOq1zpI7KuXR+ohIfFvEiL4jKp/AJDHLrHV8Dh+mbWu/z8EqOCpzfGmuY/6K7xnDFl+IWHh7DSVGeNv/VJBEU2OcqrvrsqHeb618DOzI3R5xxeQF8+GoIdgL+3o9ZECO8anaf2HULJ4UVU/5WwjUwGaWsxfqLgc0Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wHsf4AhKsd3baJa/tGVipxnPXI3F8SSquVVu1qB6ajE=;
 b=FZDx/vA1r8E3t5fX4IkdmFLI4M9QZTv5aFXle4DJHkN8Ir3bjBFMgLwHrkcOOZNnNoXFv7B0Z4x3mDr2LMc96yXPNNCGbZEfYEe0f5te6Jm0DjQWnou/Yo5jn0qHB8DxqXkz2LIK0znwURTZRmN9oH3GekUMnXiDas+gLh5Gcw4=
Received: from AM6PR0402MB3607.eurprd04.prod.outlook.com
 (2603:10a6:209:12::18) by AM6PR04MB5061.eurprd04.prod.outlook.com
 (2603:10a6:20b:9::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.18; Fri, 17 Jul
 2020 09:33:20 +0000
Received: from AM6PR0402MB3607.eurprd04.prod.outlook.com
 ([fe80::75d9:c8cb:c564:d17f]) by AM6PR0402MB3607.eurprd04.prod.outlook.com
 ([fe80::75d9:c8cb:c564:d17f%5]) with mapi id 15.20.3174.028; Fri, 17 Jul 2020
 09:33:20 +0000
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
Thread-Index: AQHWXBP98HXcYKETtUuSdT5h82zRRKkLeKQAgAAItVA=
Date:   Fri, 17 Jul 2020 09:33:20 +0000
Message-ID: <AM6PR0402MB3607DFDA5CB9ACD8E9E578F3FF7C0@AM6PR0402MB3607.eurprd04.prod.outlook.com>
References: <20200717081827.3417-1-fugang.duan@nxp.com>
 <20200717085812.GA1457960@kroah.com>
In-Reply-To: <20200717085812.GA1457960@kroah.com>
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
x-ms-office365-filtering-correlation-id: 8458b611-7fc1-450b-92f5-08d82a3471c3
x-ms-traffictypediagnostic: AM6PR04MB5061:
x-microsoft-antispam-prvs: <AM6PR04MB50610C0518CB371D6739391AFF7C0@AM6PR04MB5061.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9R/CuU+2eKoa7efmR/SKt1/v7yu8F60+nJuZ8vm9oYAFqSZTI07mkNfG3Kq3ocDbnbGBN8gUvetCyL6X57mvLsRmm122nKQzvHDqXwZVRtPqhsIRUrkYz3ZXzqzRnlH9D8nZQWMdVLocFnJBcop9C3HlJnczaXPTPbYfMBnyZ53MHWhuHdHhfvmGerJIoNdno/3n5PNQOLb3GPYG5PT5Q9RadNjuj8u6JoKvk7YB8i5UFrfGAPME0sCg6xwvnG3T8KVjl+yIYwlq38VrC4nZ+QdL4MyV3UDX+4E1zEpIADMlJSlD4PY8PMsnKnUwFXDH66ozaD/LqxcbLXf5kLaWmw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR0402MB3607.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(396003)(136003)(366004)(376002)(346002)(71200400001)(6916009)(478600001)(6506007)(26005)(186003)(64756008)(66946007)(66556008)(66476007)(2906002)(76116006)(4326008)(54906003)(7696005)(316002)(66446008)(33656002)(8936002)(9686003)(83380400001)(5660300002)(52536014)(86362001)(8676002)(55016002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: dJGNsi1BdnUW1PXLjuSEp6hwPvhjjDufiXXsjxcqDz61UtZ/2S09hMUFeF9u6Cz4Qf3Qq4TEmgC/nYO9olBB8AJpP6rLzwIPEctBp+FknPaaTFvlZ+0h0KL847ln5LEdo74sLdBnYSzo1szTxYL/0VrZvCpzBC7QPbHGyNXePAgrFkzeC23W8FodUKQ0PT7K3b0zO/laDLTSpg648ucKsVFvn8gKdgM87Z+ZML10wDapPeXvQ+6eIJ8a3LWn5bQB8Wert9JvJjdudo7q0M8Jj5GYu+fAk+LnYBhnBH9y2U23LAakEma/YLF32uG8Uy62GGLpgLxajJkW1C4A6DSF/PR4J96rle/PJlmxV6I27H2qAxnqLL1EpUNcNhCmreq3jmoB3HAoWxoZiBhWzUB9vf/37W8RsM8UNjm+EkduazvLyICAy/BeTdFfrJ5oXRR2ilnFzmq+rEQ1iCNfQEH78dSejXMBJ+O0KcvYNDEZBBq3Bqy7ik4cjxDrpbVokohf
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR0402MB3607.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8458b611-7fc1-450b-92f5-08d82a3471c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2020 09:33:20.7604
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B1Ytg6Ny4cIPZIXZC14dIRXOonpE5rP8oy1PbzIFz+wTZRkNDZpbojWAnMHjyG7Sc3/l8o4viSlYF5bgU4cSPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5061
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Greg KH <gregkh@linuxfoundation.org> Sent: Friday, July 17, 2020 4:58=
 PM
> On Fri, Jul 17, 2020 at 04:18:27PM +0800, Fugang Duan wrote:
> > GKI kernel requires drivers built as modules including console driver,
> > so add the support that imx serial console driver can be built as
> > module.
> >
> > The changes of the patch:
> > - imx console driver can be built as module.
> > - move out earlycon code to separated driver like imx_earlycon.c,
> >   and imx earlycon driver only support build-in.
> >
> > v2:
> >  - fix kbuild error
> >
> > Signed-off-by: Fugang Duan <fugang.duan@nxp.com>
> > ---
> >  drivers/tty/serial/Kconfig        | 18 +++++++----
> >  drivers/tty/serial/Makefile       |  1 +
> >  drivers/tty/serial/imx.c          | 37 ++---------------------
> >  drivers/tty/serial/imx_earlycon.c | 50
> > +++++++++++++++++++++++++++++++
> >  4 files changed, 66 insertions(+), 40 deletions(-)
> >
> > diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> > index 780908d43557..dabd06ca9b66 100644
> > --- a/drivers/tty/serial/Kconfig
> > +++ b/drivers/tty/serial/Kconfig
> > @@ -502,20 +502,28 @@ config SERIAL_IMX
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
> > +     depends on OF
> > +     select SERIAL_EARLYCON
> > +     default y
>=20
> Only put "default y" if you can not boot a machine without this.
> Otherwise leave the default line off, it will be 'n' and can be selected =
if a user
> wants that.
>=20
> That should be the case here, please change this.

I will change it to "default n" in next version, thanks.
>=20
> thanks,
>=20
> greg k-h
