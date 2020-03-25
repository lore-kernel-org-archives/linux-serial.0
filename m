Return-Path: <SRS0=EpC2=5K=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69DD6C43331
	for <linux-serial@archiver.kernel.org>; Wed, 25 Mar 2020 10:07:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 419792077D
	for <linux-serial@archiver.kernel.org>; Wed, 25 Mar 2020 10:07:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="VgjoDNom"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726103AbgCYKHV (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 25 Mar 2020 06:07:21 -0400
Received: from mail-eopbgr00048.outbound.protection.outlook.com ([40.107.0.48]:22325
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726043AbgCYKHV (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 25 Mar 2020 06:07:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JtGi3OnLf4q72d/KAa0BUbCMZ0PVSGRfx2JDYPhf1WAu8zJ2jSZYg+J5BGV8aIF0CtQrixtRhOobMGF5nod0mKWHicdQaVHIeZqX0QXpU5iUkNL2gX/DUNyO5JWvqbSL8P3wSmhlY8lgtSupdRj4nPds7H+NT1JNOfgNq+cDoMxBpX/5kvWgiKmsQJgPLzQT9mCES9Roto84EvNE/3dCj+SKOefaOkWmzLfk0NcXtHbitV4tmsOavcvvxfNAkRaLeUk2c9L9Xr8wnqhsQ6e7UBAHRsYguOcTt3WN4AnxiL7PegrO7bUc4IK981sbKxLtzuEJlwxDm69mnAiWW7KMYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GdEa+1x3J3T8iWOIq/8zkxFxvKI+43zFcBI9ADD3gP4=;
 b=nJy7+PFJlHsH46DXYK6iZFMOJU8YWQRz40cmldPxx9DgiI/EwCUsUIYoQ81qUyKE2FmG0HHt3mQhfBgXo51uo77r0MwzyyNtYN8/N0hPwQ9IJvoyVAPLwuZMZOxgiEBdkgBvxxqakHmyvSkyBNQSZ3Uesjk26SYmOHGrCh+mPbKCktQWJjyfI5xOpI/jqfOUrj7fp5IZTuR/rYPfz4TnbHZQPKBPnU9w6k3oGaR0hVZo2epTNlL7GKuosYiI/88LqZbsjI8zben3sii3ykJX7eezOs6d3cpCCf5hk+gMGZwTGhcCsxt39+lg2ZKLmyFCD0tF21ljZUxVuT3x4IeKtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GdEa+1x3J3T8iWOIq/8zkxFxvKI+43zFcBI9ADD3gP4=;
 b=VgjoDNomo9CEm2wtTblN3yu2zRPyOKyE2uF525hHbtVO7Y+z8uzdh7ypne9y6PpQF3VY7FnKoyp+nvct4KbuXXXWHngFrCAWDq5qgsnxfIt15CPDZ3BHrxIatzQDX/5kVLUdKVX/yM9ocLbvMHxGwt8VypH6PpvBoaHGezWUSLo=
Received: from VI1PR0402MB3600.eurprd04.prod.outlook.com (52.134.3.146) by
 VI1PR0402MB3678.eurprd04.prod.outlook.com (52.134.12.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.20; Wed, 25 Mar 2020 10:07:15 +0000
Received: from VI1PR0402MB3600.eurprd04.prod.outlook.com
 ([fe80::c991:848b:cc80:2768]) by VI1PR0402MB3600.eurprd04.prod.outlook.com
 ([fe80::c991:848b:cc80:2768%7]) with mapi id 15.20.2835.023; Wed, 25 Mar 2020
 10:07:14 +0000
From:   Andy Duan <fugang.duan@nxp.com>
To:     Michael Walle <michael@walle.cc>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Jiri Slaby <jslaby@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Leonard Crestez <leonard.crestez@nxp.com>
Subject: RE: [EXT] [PATCH v2 2/2] tty: serial: fsl_lpuart: fix return value
 checking
Thread-Topic: [EXT] [PATCH v2 2/2] tty: serial: fsl_lpuart: fix return value
 checking
Thread-Index: AQHWAoTG1OM2WzNTEUGCC1E+7uhgbKhZFR3w
Date:   Wed, 25 Mar 2020 10:07:14 +0000
Message-ID: <VI1PR0402MB3600E689FB51FD5D6E2A2911FFCE0@VI1PR0402MB3600.eurprd04.prod.outlook.com>
References: <20200325090658.25967-1-michael@walle.cc>
 <20200325090658.25967-2-michael@walle.cc>
In-Reply-To: <20200325090658.25967-2-michael@walle.cc>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=fugang.duan@nxp.com; 
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 75f919ad-cdf4-4b6a-bf68-08d7d0a44b1c
x-ms-traffictypediagnostic: VI1PR0402MB3678:|VI1PR0402MB3678:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0402MB36787D07DC8779349CA7EEA3FFCE0@VI1PR0402MB3678.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:289;
x-forefront-prvs: 0353563E2B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(346002)(366004)(136003)(376002)(39860400002)(55016002)(186003)(26005)(4326008)(9686003)(2906002)(6506007)(33656002)(86362001)(5660300002)(316002)(4744005)(7696005)(66946007)(478600001)(66446008)(71200400001)(66476007)(66556008)(64756008)(76116006)(8936002)(52536014)(54906003)(110136005)(81166006)(81156014)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3678;H:VI1PR0402MB3600.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nod81UQ7UIuLDwJjv6DzIulIZIyKb7ULAw2cVU+0PqhGYYkCJVsr/xE6FFxkywYkd5i1oTtjkDU2uvBN5oeD0kmyDKNLtGfvqDsPKvZXNc+yz3FP4+aNo1QMqP9YnpwIkFsp5SQf9GZagdYHj1O47sfKRh8e3Po5uDpUhYQMLNIBbQPvxkuvSGJ09v9r7eWwFk778z2cTi0O1hkDi7vGCAGQ84sUFR51QZUX6cdMDcplI0T5MIju3zl193Fyk1F/iRZ0QzbhGniZ3pN5hzPqj7eEE1g6Zvyqzi5RmxtmFkOEcvu0yHJoPTNK+gNLabPuRauOeTcdeMtuS2GagTSHNriSetE7OJ4G3d6ChLcB1BBkcCuHozXlMp4O2Q6V00emWKeCZMzQSYsSHnftudQSeC3uHWeE60ujpW8Iwl/ENIwOHhQ8pV5OBnuX0x0xV3Jz
x-ms-exchange-antispam-messagedata: NQHAtykGgL31s5jkDN8CQSTmwgWZUFCxp5qWlZ8mXDzonfdb1oyEuBu6xgvSApb97s2qOinFuhr3Nafqe8FTF6kad3tm+SDEuo75JWw3UNl18L1ltegwWzxAv/zLIuS1PKcLcZ8amJFbNLf5FIPGow==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75f919ad-cdf4-4b6a-bf68-08d7d0a44b1c
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2020 10:07:14.8434
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3rRPtjeUYaQPewbDOcy9EWbSh/jF4SLCWcq3x8+7/zrQZibNFsIkag6IWrpWtP6TlukMApSveDVcwK7VJiMt+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3678
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Michael Walle <michael@walle.cc> Sent: Wednesday, March 25, 2020 5:07=
 PM
> The return value of lpuart_dma_tx_request() is an negative errno on failu=
re
> and zero on success.
>=20
> Fixes: 159381df1442f ("tty: serial: fsl_lpuart: fix DMA operation when us=
ing
> IOMMU")
> Reported-by: Leonard Crestez <leonard.crestez@nxp.com>
> Signed-off-by: Michael Walle <michael@walle.cc>

Reviewed-by: Fugang Duan <fugang.duan@nxp.com>
> ---
> changes since v1:
>  - none
>=20
>  drivers/tty/serial/fsl_lpuart.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpu=
art.c index
> 131018979b77..5d41075964f2 100644
> --- a/drivers/tty/serial/fsl_lpuart.c
> +++ b/drivers/tty/serial/fsl_lpuart.c
> @@ -1538,7 +1538,7 @@ static void lpuart_tx_dma_startup(struct
> lpuart_port *sport)
>                 goto err;
>=20
>         ret =3D lpuart_dma_tx_request(&sport->port);
> -       if (!ret)
> +       if (ret)
>                 goto err;
>=20
>         init_waitqueue_head(&sport->dma_wait);
> --
> 2.20.1

