Return-Path: <SRS0=1VgQ=6Z=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AD93C47255
	for <linux-serial@archiver.kernel.org>; Mon, 11 May 2020 07:34:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 592402080C
	for <linux-serial@archiver.kernel.org>; Mon, 11 May 2020 07:34:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ds85XVIj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728017AbgEKHeH (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 11 May 2020 03:34:07 -0400
Received: from mail-eopbgr10088.outbound.protection.outlook.com ([40.107.1.88]:12608
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728014AbgEKHeG (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 11 May 2020 03:34:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iL09OQjJs2tKQtNU/G2W4ujalEJRud4BwXDV31itoIXPorTz5l+skCYNl5YTCPYQQSr3S4/bsaN0psxJZdunEVdVnDYFCEVWHU3R+eQmHZ9Ub1swCLhbIN8baHVoxA60yGonRIvuwUqauR6v5Y3fhwrobpJJSxcU36oQFoUinptpQpbeUsj67/rIrg2FBF5vzzzqrUlCmhY/dLl/3wKst5i6Op0KBnjPjzDJMBD6HLqLKQmd3vbdsw9J90TLdSdGTINatsMmD/a9/K3Ly0vcd+gml7BiviPvJFSnhASo5G8EiSRXSvsitKLqPA86n8gh0RmZotmoGi97v4LFPXSKvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nZW13/KE5S3TLo8vrVXoLCx6ZRgrFZARpawdso5YUzg=;
 b=RPzUQkpvcVmZGImUb34WVumrLqauvPCXpdTcD87+6KlxCZg6exDyP69IyInCM99+qYAt4kIbpMUoFFq7tOCdonF/xoQyFCxaWHZgZTzlYZydjdg1uPo+FitlVLaaI6iYTp13K/dlqYMuZKKFEd+244BxANVSGP4rHzCW7J2PWHdjrO+rtQCy8RCW/o3IaZ9AYni9GQaXCmd0nd4KcSCVS1Tg55pfYMIzKU1X3bC+/60zkQKNhG0aCHGN2E8mJPz1JKObaSjPJ6sGWJchAgPRlIaHfN/sg8sP2JKXjvR5i8Bfxq4xTae/wVUj1txi4GI5vvVePge6gazjW4jcceR+lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nZW13/KE5S3TLo8vrVXoLCx6ZRgrFZARpawdso5YUzg=;
 b=ds85XVIjRUnv6X6pQhpcjJySzAfLza7TCJMMEAQyfczGIRE8/D+uSIZFEbEiiqRNUZ+sQWXaB+8CFGSb4RGxZ6t6ugZxvOMFJSakXELPOp45La5uCUfZ49PVlkiCGHvK9KIA4mrI4W7vYBGez5aNmfyGSzt59Ch3tPa7mOYENgA=
Received: from AM6PR0402MB3911.eurprd04.prod.outlook.com
 (2603:10a6:209:1c::10) by AM6PR0402MB3398.eurprd04.prod.outlook.com
 (2603:10a6:209:6::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.34; Mon, 11 May
 2020 07:34:03 +0000
Received: from AM6PR0402MB3911.eurprd04.prod.outlook.com
 ([fe80::a5f9:57c:97d3:491f]) by AM6PR0402MB3911.eurprd04.prod.outlook.com
 ([fe80::a5f9:57c:97d3:491f%6]) with mapi id 15.20.2979.033; Mon, 11 May 2020
 07:34:02 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "jslaby@suse.com" <jslaby@suse.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH] tty: serial: imx: Add return value check for
 platform_get_irq()
Thread-Topic: [PATCH] tty: serial: imx: Add return value check for
 platform_get_irq()
Thread-Index: AQHWJ2R9HRDfI6PXFU6oSAD1fVH3jKiifI2AgAAAUcA=
Date:   Mon, 11 May 2020 07:34:02 +0000
Message-ID: <AM6PR0402MB39112DC95B39E980E830BE34F5A10@AM6PR0402MB3911.eurprd04.prod.outlook.com>
References: <1589180996-618-1-git-send-email-Anson.Huang@nxp.com>
 <20200511072747.2vyavydpfa47kbuy@pengutronix.de>
In-Reply-To: <20200511072747.2vyavydpfa47kbuy@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 75986d84-dc84-4676-8571-08d7f57dada2
x-ms-traffictypediagnostic: AM6PR0402MB3398:|AM6PR0402MB3398:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR0402MB3398DF2E5A8C70C7BDB2D393F5A10@AM6PR0402MB3398.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 04004D94E2
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WVZCbXhYmZ1ajcppip+tQySq1nuRQqmWziAVAkhs5SOd6/MPD2ITWkU4Hd+/9GAVZMnrPRvQztXRUVzMot8jbYz2Df1lJ23DeC1IreTo1wLo8BsY2+EH5KgxywMOoc+WZlJbvQX9wy+WtDWivg4AOc9GjgNTZA3GpwxFWa6gskfMwXZQaufvAhEI3D0OQSStLVfAlx6Xk9WqK+nMhb0iyU4og9iBCNJ7F4mKvBV0cFnchT4lhbU38xOEFWAU00xsrW5yXDx1e0FDFnqySBdtP4fBtteOKBf8EK+vTK3TsLXxST95NjZF9SQ5FI3wjULtputMXuGcfP5Wo+B7kNpwHHhgl0+CY+GIzExYakM9yW4ip2FQ3vtdrW/+P1ZqfLLTah+sFHkPIaQK6RNd/x+gjWEJC/0sUq/pkaV2D20PCvenR9LS8LFuTCQdOO/9s6dzVMrW92b6o8FCwzxuBY4ZMRoicpMoELD75ZA4qcfHgKgldm5PiFjBOrE3TVjjmeyxBdD9hJxnqJ4ZD0pcrPQJYw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR0402MB3911.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(366004)(39860400002)(376002)(136003)(396003)(33430700001)(26005)(4326008)(64756008)(66446008)(66476007)(66556008)(66946007)(76116006)(6506007)(9686003)(6916009)(8936002)(7696005)(44832011)(55016002)(33656002)(5660300002)(52536014)(186003)(316002)(8676002)(478600001)(2906002)(7416002)(54906003)(86362001)(33440700001)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: sccy8CXDNSmgHz0PZfiVegB2qJdHHcCTzwdWYXzwpcTYGEGrOVw4XQPCVHY3MUOzFEhEf5w6b236B8Efp+HgaCxxFZAJ5IubMunXGXyQJb0KWcOKcmu/e7VHCPtr2Fss8dUsrKQ9oMj181Vf0CvKjZ1wrbgWcZUYJAhScDPXfsV4U3ll60aO65OQmyaxu4gzWkwcGXb3gxFvShETEp9P45PS2H1TkuibZ4wbTPlIs03IOsQJEl4bCGrxm59Cv0oieuk3vZhKWMEHi9pjMz6TTktYrRGZoOcXzTi/kSZDzvAT9AXJVir/fBCxPXzSbgCVHLioYOvLKaBvk8lCk5sq4FqbUcrqVuMXYBWCxJbqrqYugOZdSXc+t6dBAfgWUdHrOgsp7RsH5AjoRgjhZ0aspLAxw52RbjkrlPrt8GHTcpfrnANaQlsvT5GZ5kIOTaVXoIqgqzD80ly+l8sJKxVhk4SoYYlb1iSftcVe7zhAMkg=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75986d84-dc84-4676-8571-08d7f57dada2
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2020 07:34:02.7431
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8XBZ7qO2eMLWG030d4BuqI1pZT1t4yVw/nDxW0FpPJZYnIeh8HvxQGq8zVxcNH7O7fb/mAWeqasbphvIIMHPgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3398
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi, Uwe


> Subject: Re: [PATCH] tty: serial: imx: Add return value check for
> platform_get_irq()
>=20
> Hello Anson,
>=20
> On Mon, May 11, 2020 at 03:09:56PM +0800, Anson Huang wrote:
> > RX irq is required, so add return value check for platform_get_irq().
> >
> > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> > ---
> >  drivers/tty/serial/imx.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c index
> > f4d6810..f4023d9 100644
> > --- a/drivers/tty/serial/imx.c
> > +++ b/drivers/tty/serial/imx.c
> > @@ -2252,6 +2252,8 @@ static int imx_uart_probe(struct platform_device
> *pdev)
> >  		return PTR_ERR(base);
> >
> >  	rxirq =3D platform_get_irq(pdev, 0);
> > +	if (rxirq < 0)
> > +		return rxirq;
> >  	txirq =3D platform_get_irq_optional(pdev, 1);
> >  	rtsirq =3D platform_get_irq_optional(pdev, 2);
>=20
> I'm not sure we need such a check as devm_request_irq fails if the return=
 value
> of platform_get_irq() is bogus.
>=20
> But if we decide this construct is good enough, the error reporting needs=
 some
> love as currently it emits two error messages which is confusing.

From the driver, the RX IRQ is always required, if it failed in platform_ge=
t_irq(), then the
rest of the code is NOT necessary to be executed, and also I am NOT sure if=
 platform_get_irq()
failed, the devm_request_irq will always failed?

Not very understand about your last question, the platform_get_irq() alread=
y has error message printed
out, so no additional error message is needed in the check. If looking thro=
ugh all other drivers, most
of the platform_get_irq() are having the return value check, if it failed i=
n platform_get_irq(), driver can
just return error from .probe().

Anson
