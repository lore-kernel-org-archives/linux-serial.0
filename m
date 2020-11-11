Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2679C388F7
	for <linux-serial@archiver.kernel.org>; Wed, 11 Nov 2020 02:46:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A2E52168B
	for <linux-serial@archiver.kernel.org>; Wed, 11 Nov 2020 02:46:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="S3UrBX5n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725870AbgKKCqd (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 10 Nov 2020 21:46:33 -0500
Received: from mail-db8eur05on2047.outbound.protection.outlook.com ([40.107.20.47]:23393
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725884AbgKKCqd (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 10 Nov 2020 21:46:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=byPBZX/GZicSLKzIpx78qbZLumCacUhOOyFl0Hl7IXMvF24XqGnEiWx6XT2/3hMpCsQo4h0ub8X7Y8zfjkGYN2luAiPOCqpM7FIxRnbTQImWLrsDxdFyNh8tDcbKa57Y86e8SLfzQA5DKMCdoXnvQAsW4MoAWRQf2JVlRWVM1OvQRwKmJpIZvNWa/4uG4bRsEQg0S6V9vYnVZckmgoI+VunrcoGUWghTsWuXzB3yr4F2xfkzjvkfXonM43R0X9xbCKp02IedTi3z3EbJN9ORT2LllGZ3pBjXhjBGBCvv4ubR8fzH9gi/PwieSFqa3hME0ANpSLtuemibiWNhDXZOQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hdgeirUalarwihEH2LTm2rScZW07hLOzxNyQHRXL/6w=;
 b=nPoClmvBvB7PgjbDxmEL3XRP180++u0z4I6joVuYYcxj4kjC/g58Dxuml41e93T88Mis8anZXoibMgbKVN9s2L+yb+E9whEzCj0kLk3Ofy+dGDHrQJffMMyqBuqyZ2ZfrPMeD4hK6yQhC73dwHc1QhekDSPAnpNU60uKJGzxmq/1qmig5uG/nobt39Yk02QB/EjLpxeHW+N8s6VKx9GlUvKj1uZdvjTdZLMYpW37IHm113b6pmY2m/Fm+6QKBGqq1Wmm1/gsW2P1ZGkDNV+1uPO8Va82PLafk7GWEOojYGYcMST7ahoCMCYbFxRNn45jpveeSmEjp3jA0xuUKUGEMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hdgeirUalarwihEH2LTm2rScZW07hLOzxNyQHRXL/6w=;
 b=S3UrBX5nmsXEtLrLmjSyqkpZsTm6xVQDxuUAaVECLkZ0E9knRQG3VzyFqZWRRJQ6JtIZATNkLSnLGtwrs7tivGOwxQ6XPwgmUHLOQVVWE1yxukgkBmwpf5tCNJ/+Ib2amZHcOiUe+XPdc8v8yxSjHUV+crVSwT9uGs0/l8bj/sU=
Received: from AM8PR04MB7315.eurprd04.prod.outlook.com (2603:10a6:20b:1d4::7)
 by AM8PR04MB7330.eurprd04.prod.outlook.com (2603:10a6:20b:1c4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Wed, 11 Nov
 2020 02:46:30 +0000
Received: from AM8PR04MB7315.eurprd04.prod.outlook.com
 ([fe80::11e6:d413:2d3d:d271]) by AM8PR04MB7315.eurprd04.prod.outlook.com
 ([fe80::11e6:d413:2d3d:d271%6]) with mapi id 15.20.3541.025; Wed, 11 Nov 2020
 02:46:30 +0000
From:   Andy Duan <fugang.duan@nxp.com>
To:     =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "lukas@wunner.de" <lukas@wunner.de>
Subject: RE: [EXT] Re: [PATCH tty/serial 1/1] tty: serial: imx: keep console
 clocks always on
Thread-Topic: [EXT] Re: [PATCH tty/serial 1/1] tty: serial: imx: keep console
 clocks always on
Thread-Index: AQHWtnoNblCPBiNtFEq8ypIVxTqcE6nB09+AgABn55A=
Date:   Wed, 11 Nov 2020 02:46:30 +0000
Message-ID: <AM8PR04MB7315453E4A9CC5FA2BC68A85FFE80@AM8PR04MB7315.eurprd04.prod.outlook.com>
References: <20201109091403.12515-1-fugang.duan@nxp.com>
 <20201110203105.psro267now4cgctg@pengutronix.de>
In-Reply-To: <20201110203105.psro267now4cgctg@pengutronix.de>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9f05623d-0283-4888-0b99-08d885ebfe63
x-ms-traffictypediagnostic: AM8PR04MB7330:
x-microsoft-antispam-prvs: <AM8PR04MB7330E0DA97071D42A9C5558CFFE80@AM8PR04MB7330.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ton8ZJHd9gUXa0FrpzLbCm/rwERwVaDcyhJ5bXUNyLSnFQuG46nVfN/Tg07rPb+o3Bk2WdWPymdHBo/iez92YzqqkwsOpENGF/O7s8a7VWWarKZ6/dom8qZZXHEfYxbnWeMFQMjmrEh0gbovDXNAfq9P1dlp1jVH5oRBwUgkZOc2XM5HJpfejaNg83Ekf5rveRPR5XQQeANwONe9pVs5wai6wELd+7auFqWI6M7Xlo2T1R1+4YXKuTVjFJuBYhYjgbBGJLjdasax/QYGTKHK9kNJZcZh/Y1JghF2oG9v5cxuq5qZsoz+IQbjn5J33sPyK0KY4Who2zvV1QYCw+fLqnjXMlXKPquY4XD9MOhDmOHCv7rHm6CMPXDN+iGgf3WwPNmD8ZN74i7lz3IrI9/Gaaau8CG0mqS7s+rSRY6fkyCnDgwhtnNiYmbU2IDNKsIMqHrOF2ImtqV21UrDEp5/9w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7315.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(39860400002)(136003)(396003)(376002)(66574015)(86362001)(316002)(4326008)(55016002)(5660300002)(83380400001)(71200400001)(54906003)(6916009)(9686003)(83080400002)(186003)(6506007)(8676002)(33656002)(76116006)(2906002)(66946007)(66446008)(966005)(52536014)(64756008)(478600001)(7696005)(66476007)(66556008)(26005)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: w/M/U8vtP8NTCiJRXKkLqruPLf+ufbWpoxe/0ceKfvCfR0b/SROEjo822lL3J3IK1WQNsm42fKSEVVoblVP6pReZmG1ThINRDtX87AUxfykevMLwnQFD/eZmNzJ35MZIaZ1MrEEa1TpW8Z7zoB4Yo3buzM8ddcmh7cYaLLH8HEEiXQEgr7TtLE8HLxzrrV8X/uUBy96rE2VNu/iRRPJ5AOaTtC3mGVXN3QHHm8QsJDjLUYbJqYKfqhhEQtHvTdmwda2ea7Ls4aXJDmErmPuIp3g6bkPtDYRdG8C6xcdc9m5eFpdegFfzejXEfEg5awP18saeUB8epQSCnYa8TZZyooC2Ur1VczzNrvDNKef40K2f8skiwIUNT0FKaz3egLaz2fAaEmvYP6JqTXbEALtSxipLN8J8w6UvVThuwiV43UfM3MpfHOsyiRX+7ReBZc6qB5lZfoMCFk8Ene5AF9mS3xAkwvPoi9/JNgFmCa+uS3fMmkNRKnMIGL0n6z3P+wQVaoM8ASrD95+v8jxYWT5nYhqjVQnNgkYNvQvHldDokaAcbdx21XSA4c4Ps+v6CFUww9ZXpGSFPGStEbG3604J00600V2BaApEsZ0xiTBeM5F4qRpAX7Ala71qZk4+5ILDvdhJuCD4oSfkS6HER6zLjA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7315.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f05623d-0283-4888-0b99-08d885ebfe63
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2020 02:46:30.3552
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9hqEArCn3sYHX6qOgiOV0kRfGEtS9nUIn9exJNaukTwweoD3JGYm4Pbx9j/dIvYLtaET8jdQwFrBdZVwAlwKMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7330
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de> Sent: Wednesday, =
November 11, 2020 4:31 AM
> On Mon, Nov 09, 2020 at 05:14:03PM +0800, Fugang Duan wrote:
> > For below code, there has chance to cause deadlock in SMP system:
> > Thread 1:
> > clk_enable_lock();
> > pr_info("debug message");
> > clk_enable_unlock(flags);
>=20
> flags?

Will remove it, thanks.
>=20
> >
> > Thread 2:
> > imx_uart_console_write()
> > 	clk_enable()
> > 		clk_enable_lock();
> >
> > Thread 1:
> > Acuired clk enable_lock -> printk -> console_trylock_spinning Thread
> > 2:
> > console_unlock() -> imx_uart_console_write -> clk_disable -> Acquite
> > clk enable_lock
> >
> > So the patch is to keep console port clocks always on like other
> > console drivers.
> >
> > Signed-off-by: Fugang Duan <fugang.duan@nxp.com>
>=20
> Depending on how old this problem is, identifying the commit that introdu=
ces
> the problem (and noting it in a Fixes: line) would be good.
>=20
In normal boot, there has no problem since there have no printk
between clk_enable_lock() and clk_enable_unlock(). If you add debug
message between them or enable track in clk driver, the issue should be
triggered.

Will add the Fixes tag in v2, thanks.

> Best regards
> Uwe
>=20
> --
> Pengutronix e.K.                           | Uwe Kleine-K=F6nig
> |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ =
|
