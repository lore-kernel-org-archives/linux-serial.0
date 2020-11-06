Return-Path: <SRS0=r4Ma=EM=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15333C388F7
	for <linux-serial@archiver.kernel.org>; Fri,  6 Nov 2020 01:28:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1CC820782
	for <linux-serial@archiver.kernel.org>; Fri,  6 Nov 2020 01:28:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="bIHfS/zt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730246AbgKFB2j (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 5 Nov 2020 20:28:39 -0500
Received: from mail-eopbgr60056.outbound.protection.outlook.com ([40.107.6.56]:52332
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732775AbgKFB2i (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 5 Nov 2020 20:28:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SAv38y+tTmz5RDC/1jycPYOlCsvia1Cn4HEfuTjTZARBYqKfdkQqt+blj5p588u/AOJt0oycUHdb0EERjc7xRhMu8OJvyLPtXh9N4Cdr9HxnzbOVcnQX5Km11lhQlj8V1+6iroviOvtL0A/dqi9pvgIYaQcjAP9Bh722FioBFfqUt49iBXCqyFLFkX4r6OTjvy21YvFk2hckM5pcmB/fwzRPrRu9nuBKanHjVeXtbFm/ORelp33pxM2XRYCEU8RR/ZtTsgcHhK9qY7vlD75ohFXW1Hhz/TEYODaDMjn2iVCSh8vCGqirq8P5yWugZ3uiDeH+cvEWPwEVgNlv52vLsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gxSeqCtPziraiZ+1idnJKbsy2oe8oxHrec/4YGAdea4=;
 b=S3okAv0svdP9RbQEN3VLWCA6Og5jV9BeGVkGgA5AObihp4zGSTiNW4n/h1k9DcZy6PXiYiEcrEBr6CMEQDPUe23fcFMAGuM1dXOGkKAbl7A44zDst4+MhWIsUWpn4Zw6GxZrFpQa7atSsC4HChg35QyKeF2JJt4cbXuQG19rPWvmYnZ2u0HPA/pT6JcjXX8zGNxZJDqxTipOJ2MswkYJ8DTZY1eLaFImLZz1rjN3Tfw8WE/o/RwaLxLUl8lRRZkAvPi3KXZUEjpvZrJcZbxmX4FYHKOtuU7SDCItggqyDQW5cX5CrNDxXQXMlcS4sqPEHKuvg/SjJwEz3C8ZO3926A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gxSeqCtPziraiZ+1idnJKbsy2oe8oxHrec/4YGAdea4=;
 b=bIHfS/ztejmNlHlDvb/PBJw2etVS2gpEZSykbCrgcvdg4toAVnaV4uabDb16UVajqaKbSFPRAuFvEQCi4C1Bda4YNvEU/5pYNcnOqMNdXLyOS3xRAUi1nvRbONOcSYF60TtRDB50JUydKO1Z+GTWC5YjdRylaVvSynsAnzu8zio=
Received: from AM8PR04MB7315.eurprd04.prod.outlook.com (2603:10a6:20b:1d4::7)
 by AM8PR04MB7955.eurprd04.prod.outlook.com (2603:10a6:20b:249::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Fri, 6 Nov
 2020 01:28:35 +0000
Received: from AM8PR04MB7315.eurprd04.prod.outlook.com
 ([fe80::11e6:d413:2d3d:d271]) by AM8PR04MB7315.eurprd04.prod.outlook.com
 ([fe80::11e6:d413:2d3d:d271%6]) with mapi id 15.20.3541.021; Fri, 6 Nov 2020
 01:28:35 +0000
From:   Andy Duan <fugang.duan@nxp.com>
To:     Lucas Stach <l.stach@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
CC:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "patchwork-lst@pengutronix.de" <patchwork-lst@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: RE: [EXT] [PATCH v3] tty: serial: imx: enable earlycon by default if
 IMX_SERIAL_CONSOLE is enabled
Thread-Topic: [EXT] [PATCH v3] tty: serial: imx: enable earlycon by default if
 IMX_SERIAL_CONSOLE is enabled
Thread-Index: AQHWs7Pn7kpXWQcr9UWisr/1T4Yk9qm6ULsg
Date:   Fri, 6 Nov 2020 01:28:35 +0000
Message-ID: <AM8PR04MB7315ADBF697FF08B9BCF202AFFED0@AM8PR04MB7315.eurprd04.prod.outlook.com>
References: <20201105204026.1818219-1-l.stach@pengutronix.de>
In-Reply-To: <20201105204026.1818219-1-l.stach@pengutronix.de>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: abcc0a4e-138e-4ce9-5714-08d881f347e9
x-ms-traffictypediagnostic: AM8PR04MB7955:
x-microsoft-antispam-prvs: <AM8PR04MB795544C94FE2A6150F9F9095FFED0@AM8PR04MB7955.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1751;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1Z0RG41/mcMmwxR8Y4FjZj4bBGlNS6YfVQT/3TCDH/0/vV4C+fYkPgjN31N9kJum6xFDOz8Nxjow1nx2P7u6xQLW20wMdf25/Dy32EYu4RAtg+UfLmrWdBO3mzbvS/TfXZvRU4XWHf7umNxoBIxUuwfxXhlMrzGBNaroHLz0Y3El8o6m/w9PsYb499Hjg8lVa4ux2mKJGC5DKV7F4Li7Fdnk2AbyzHS/V1ncVnzjCsTXmV5JN4ben0GSch83iJvq8tgTtJtR/le2FK40PPv8oNi6flyDVZP8U7pM32xlJl5cHtz3erpUc2nZVI1rPKoxU8lqUuhDKudVXr159qI3EQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7315.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39850400004)(136003)(346002)(376002)(366004)(2906002)(110136005)(8936002)(66556008)(54906003)(478600001)(71200400001)(66946007)(52536014)(9686003)(66476007)(66446008)(55016002)(5660300002)(64756008)(186003)(26005)(7696005)(83380400001)(33656002)(86362001)(8676002)(316002)(4326008)(6506007)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: Z99TvryZr2yWHK50wx9YMm1OnV1bQRWZu0V+gSvi90I5C0Iq5Te0kuRHK2rsi+GYv+n4jtLPICHRCRgYgheut7WO8QvD+GRv/2SIHcxAKP376fkBgkmWAdrnudZXPcFeN9MKPkKKX8ja52DV8/LdtKqxuULJHTESJ84CzWkZ8UZzGP0CFf0fGacg7FPKZOtij8Lo5Q7+EFyTyH2ui80U19cs/LXGFXsLH5+sSoizcVzDWbSpYBai6ayENPXKOfkQLiThssogvhIg7JREi72PqhDQiDeGonpbo3NEbmdK0jUmuJpZibJHw5CsgrLhwWjQ7L2yBpDSSbxDGH9PXNTk2MTkNjf0JkXGXankqfnlZ+iggy8mzjq/Ntwq3n1TRqcuxpdtgDfiFzYeNOJ1f6173lsSXsXhIohyl+bmbciIG4lg6DGIHJsiQT8mCA1UJo1jC2TJbzoXHK7ye3Oe+zVvKz/QjpAnec/k0/lePJmO37H7YlaocI9/ej9tdvVFz/RMTv0MCdSGj/QHzwpsoqNNifSWeRI0EJnLnzUcLz/8VjJr0bYIEqp7hVQ8PIXIreLA+dC1MKRpcT0vDLOSJiBkkvZT44B3HiNaiU9BgMz4omUC9elbdOb1IS+Hv5Giq8UxpssbcvZg1mhiC/c1I2xVIg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7315.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abcc0a4e-138e-4ce9-5714-08d881f347e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2020 01:28:35.5330
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Kh+FjDvz6Dz0RwUEUJ+iD1HB1MgQC/tlQimGc9vyGNjUkjf50zjr7HTuY6lQOquJcZj0ph366FwJ8TFsZq4bug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7955
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Lucas Stach <l.stach@pengutronix.de> Sent: Friday, November 6, 2020 4=
:40 AM
> Since 699cc4dfd140 (tty: serial: imx: add imx earlycon driver), the early=
con part
> of imx serial is a separate driver and isn't necessarily enabled anymore =
when the
> console is enabled. This causes users to loose the earlycon functionality=
 when
> upgrading their kenrel configuration via oldconfig.
>=20
> Enable earlycon by default when IMX_SERIAL_CONSOLE is enabled.
>=20
> Fixes: 699cc4dfd140 (tty: serial: imx: add imx earlycon driver)
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> Reviewed-by: Fabio Estevam <festevam@gmail.com>
> ---
> v2: add R-b from Fabio, fix typo in subject
> v3: no changes, adding this note

Reviewed-by: Fugang Duan <fugang.duan@nxp.com>
> ---
>  drivers/tty/serial/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig inde=
x
> 1044fc387691..28f22e58639c 100644
> --- a/drivers/tty/serial/Kconfig
> +++ b/drivers/tty/serial/Kconfig
> @@ -522,6 +522,7 @@ config SERIAL_IMX_EARLYCON
>         depends on OF
>         select SERIAL_EARLYCON
>         select SERIAL_CORE_CONSOLE
> +       default y if SERIAL_IMX_CONSOLE
>         help
>           If you have enabled the earlycon on the Freescale IMX
>           CPU you can make it the earlycon by answering Y to this option.
> --
> 2.20.1

