Return-Path: <SRS0=ofBx=AS=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B43A1C433E1
	for <linux-serial@archiver.kernel.org>; Tue,  7 Jul 2020 07:51:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E34E20708
	for <linux-serial@archiver.kernel.org>; Tue,  7 Jul 2020 07:51:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="qYzfCUvm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbgGGHvK (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 7 Jul 2020 03:51:10 -0400
Received: from mail-eopbgr1400110.outbound.protection.outlook.com ([40.107.140.110]:6069
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728277AbgGGHvJ (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 7 Jul 2020 03:51:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QOJz1S64dBmR7juwLVGH7LdnHCiTTyA8UNCPMIivD1NHdx/Rf89gPEE878kpBKPwa4LunzhK+qTtJRKSN1gzR+25JDUBi4hzvN/PMj9rOXfAOTRuPecSMtPXqeHg08kxKe/DVjH1ciUydeUuK8+fiFV+vg1RZf32JebDGeYd99qejjCBqEQTZodlDfrd7wyblx9Qq0+ADnE3HB7kmoBrRhQ3mBjM3Aje6wY24Kfv22UVlR9jGR0+TznYKcaApS/FlLZFvefGjcw20m988qHcA+two4eZhcM/HbaEyOADFVjLn5Ayow9bz3QTthmBefyXeHFlHphdZc+MtArD8UipbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T9pGYzLHM19NWcJlmG2L//bv7oNtC1nf4yTqPff/JV4=;
 b=Wp3kAiSLkGudjkimS4Cm4lssnFWflX2hgac9/IToSatn6VrItRzrv/pFi713YytARfcZczLvSPseowJjsJIxZGnpgZOZgUWaS2LT/NuVmzLQxyBrYs2q9gJlveJziTJHpHwdBGfmoH0R+lO8nLRZSc2onKmgcjHj35ZhmJM/wOle5FxORgQTVWKeaCo8xBQdRkUjD/wW7iR49qOv73ObI4QWaTka8UJjfODLstrNXnT+t+0Wt4Iiw5vjkF81B3FkyQbOuD9DDi42JfLceHVWMARFQiF3oPukNbv8wH1i47OjuwD5ooUY6mF7lXbldTyNtPYGNVMlxIp58Q0x8Mz6Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T9pGYzLHM19NWcJlmG2L//bv7oNtC1nf4yTqPff/JV4=;
 b=qYzfCUvm2etd2ihjJoylPCkQMxjWCgkQNayPuE5pUI6im7gza6pPnaV7mSUJ5pok8kJNwWO9Pmc9j3/UPskkUrqPQAPnT5ik4DS8YeiGWU+TWmGoQ9mFjKotd84o1KfPBrWryJnTNZ0zC2BVZ9MHaZEBj3vM8mU65lRJmYhURGI=
Received: from OSAPR01MB2915.jpnprd01.prod.outlook.com (2603:1096:603:38::10)
 by OSBPR01MB1879.jpnprd01.prod.outlook.com (2603:1096:603:6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.20; Tue, 7 Jul
 2020 07:51:05 +0000
Received: from OSAPR01MB2915.jpnprd01.prod.outlook.com
 ([fe80::3d28:786d:6736:7a8]) by OSAPR01MB2915.jpnprd01.prod.outlook.com
 ([fe80::3d28:786d:6736:7a8%7]) with mapi id 15.20.3153.029; Tue, 7 Jul 2020
 07:51:05 +0000
From:   Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
CC:     Marc Zyngier <maz@kernel.org>, Guenter Roeck <linux@roeck-us.net>,
        Anatoly Pugachev <matorola@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: RE: [PATCH v3] serial: core: Initialise spin lock before use in
 uart_configure_port()
Thread-Topic: [PATCH v3] serial: core: Initialise spin lock before use in
 uart_configure_port()
Thread-Index: AQHWU99KR2eghejscEinSaj002W5o6j7vsiA
Date:   Tue, 7 Jul 2020 07:51:05 +0000
Message-ID: <OSAPR01MB2915D815AA2435F3C190FC28AA660@OSAPR01MB2915.jpnprd01.prod.outlook.com>
References: <20200706214903.56148-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20200706214903.56148-1-andriy.shevchenko@linux.intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none
 header.from=bp.renesas.com;
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b080ec2f-7c85-43fc-6ee3-08d8224a8088
x-ms-traffictypediagnostic: OSBPR01MB1879:
x-microsoft-antispam-prvs: <OSBPR01MB1879C98C51430A6077127D59AA660@OSBPR01MB1879.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-forefront-prvs: 0457F11EAF
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uSaHUcLwyP2ox2IXWetzD3RKI39JpCdVqeXXtSfy/vvKXsYLivkTkhUThvUND6LkNWLoAGzX2ZOGfdtuiLvdAfECDtG2geqEoWkqoO6eOnnWHuudBQSK5e8TRxEqisiJk/cbxf9nsOsYYkjn5rfIRJvCoD3uVEMcB5N2TvjKZqysmmz2eT9XHIxTmoOdYH7zF9v0YnK55U/W/NVFRl+DpevqP+AXmUpsFNq/9m7JzD7E8F/HczwSnd8TtZ0VjbiWIp/G45wckO4T86P66XPBsY+xTDGP5Ta3JNyP6Hs5bfOF1e3sje3NGN+8HWr7IkktdSrZ8x7+9bz1TZbeLqe+Tw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSAPR01MB2915.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(136003)(346002)(39860400002)(396003)(376002)(316002)(66446008)(64756008)(66556008)(66476007)(186003)(83380400001)(52536014)(8676002)(5660300002)(8936002)(86362001)(6506007)(53546011)(9686003)(54906003)(110136005)(66946007)(76116006)(7696005)(55016002)(2906002)(478600001)(4326008)(26005)(33656002)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: ZCY5uZqAkObvhhCwFB4ihLQUnbEyIfaTrdCSC27wZF2PbfPQvvPA0sY7jlyFLASoZUoRRiL1foOj9o6ieWxGYRwezeMLuNrDdQC63r6sVN8CH0D0U3uM5yo9pQgMFIuRhCDhqSg2KxmK1XaESNyGrrbf/zkDzc8euVMQ4cZdUTR+9n4EC2xU6vPUUYLLRKL2DtFGxLqShmwfXmiZs7djDHRbXAevOLfpucFU1EGTX8AkrXz1eTKDOr7gyShvcOerZoGS3wmfuobK6uv900uILnsLbi8oxUbjI16HfVcGZHftQzRxxLwa9dcXHceRkaix2zTTjdQhHqND/xhYT+j+HNl/m06o9G/d96NYIuzNIpMMI/WlT03eMSKHiGg+Hoiiv5prIA0JK46JbV+Ng5fne3evjtu0aeb9mL6LY6ecIaMIStA7NH4aTDe2R0l7Bk6YOE6CnnrYJOhLbf+pY0IcuyiFuNVhd1WofJT5+cG8yGr3SR4UaYermE75Nno+I0i3
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB2915.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b080ec2f-7c85-43fc-6ee3-08d8224a8088
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2020 07:51:05.1005
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BU+X+6aTYlBgxrUsz2AzoBR4Ir58dPmkdLvFM3wQPm6x65i13IMUm9Ts2NC+gtRdz3zd7aZphYVYotFQQ+OvgkgAe4GTwgprU4umyHhhOMsoQ0KQTlD6L3nA2jCi/YVL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB1879
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Andy,

Thank you for the patch.

> -----Original Message-----
> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Sent: 06 July 2020 22:49
> To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>; linux-serial@vger.ke=
rnel.org
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>; Marc Zyngier <ma=
z@kernel.org>; Prabhakar Mahadev Lad
> <prabhakar.mahadev-lad.rj@bp.renesas.com>; Guenter Roeck <linux@roeck-us.=
net>; Anatoly Pugachev <matorola@gmail.com>; Tony
> Lindgren <tony@atomide.com>; Geert Uytterhoeven <geert@linux-m68k.org>
> Subject: [PATCH v3] serial: core: Initialise spin lock before use in uart=
_configure_port()
>
> The comment near to uart_port_spin_lock_init() says:
>
>   Ensure that the serial console lock is initialised early.
>   If this port is a console, then the spinlock is already initialised.
>
> and there is nothing about enabled or disabled consoles. The commit
> a3cb39d258ef ("serial: core: Allow detach and attach serial device
> for console") made a change, which follows the comment, and also to
> prevent reinitialisation of the lock in use, when user detaches and
> attaches back the same console device. But this change discovers
> another issue, that uart_add_one_port() tries to access a spin lock
> that now may be uninitialised. This happens when a driver expects
> the serial core to register a console on its behalf. In this case
> we must initialise a spin lock before use.
>
> Fixes: a3cb39d258ef ("serial: core: Allow detach and attach serial device=
 for console")
> Reported-by: Marc Zyngier <maz@kernel.org>
> Reported-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Reported-by: Anatoly Pugachev <matorola@gmail.com>
> Acked-by: Marc Zyngier <maz@kernel.org>
> Tested-by: Tony Lindgren <tony@atomide.com>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> v3: renamed lock init primitive and dropped inline (Marc), added tags (Ma=
rc, Tony)
>  drivers/tty/serial/serial_core.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
>
Tested-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Cheers,
--Prabhakar

> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial=
_core.c
> index 3cc183acf7ba..309fa42b0861 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -1915,6 +1915,12 @@ static inline bool uart_console_enabled(struct uar=
t_port *port)
>  return uart_console(port) && (port->cons->flags & CON_ENABLED);
>  }
>
> +static void __uart_port_spin_lock_init(struct uart_port *port)
> +{
> +spin_lock_init(&port->lock);
> +lockdep_set_class(&port->lock, &port_lock_key);
> +}
> +
>  /*
>   * Ensure that the serial console lock is initialised early.
>   * If this port is a console, then the spinlock is already initialised.
> @@ -1924,8 +1930,7 @@ static inline void uart_port_spin_lock_init(struct =
uart_port *port)
>  if (uart_console(port))
>  return;
>
> -spin_lock_init(&port->lock);
> -lockdep_set_class(&port->lock, &port_lock_key);
> +__uart_port_spin_lock_init(port);
>  }
>
>  #if defined(CONFIG_SERIAL_CORE_CONSOLE) || defined(CONFIG_CONSOLE_POLL)
> @@ -2371,6 +2376,13 @@ uart_configure_port(struct uart_driver *drv, struc=
t uart_state *state,
>  /* Power up port for set_mctrl() */
>  uart_change_pm(state, UART_PM_STATE_ON);
>
> +/*
> + * If this driver supports console, and it hasn't been
> + * successfully registered yet, initialise spin lock for it.
> + */
> +if (port->cons && !(port->cons->flags & CON_ENABLED))
> +__uart_port_spin_lock_init(port);
> +
>  /*
>   * Ensure that the modem control lines are de-activated.
>   * keep the DTR setting that is set in uart_set_options()
> --
> 2.27.0



Renesas Electronics Europe GmbH, Geschaeftsfuehrer/President: Carsten Jauch=
, Sitz der Gesellschaft/Registered office: Duesseldorf, Arcadiastrasse 10, =
40472 Duesseldorf, Germany, Handelsregister/Commercial Register: Duesseldor=
f, HRB 3708 USt-IDNr./Tax identification no.: DE 119353406 WEEE-Reg.-Nr./WE=
EE reg. no.: DE 14978647
