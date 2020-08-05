Return-Path: <SRS0=nzNS=BP=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 369B0C433DF
	for <linux-serial@archiver.kernel.org>; Wed,  5 Aug 2020 20:16:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0313E22B42
	for <linux-serial@archiver.kernel.org>; Wed,  5 Aug 2020 20:16:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Q/9XHEwd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbgHEUP5 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 5 Aug 2020 16:15:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726439AbgHEQUG (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 5 Aug 2020 12:20:06 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2060f.outbound.protection.outlook.com [IPv6:2a01:111:f400:7d00::60f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D20CC0086A2;
        Wed,  5 Aug 2020 07:41:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K2abX8N/VHXCER0Sv8tTvCZ9c5O557MKSfbKelORtgHNBeR4GPnq7cZ9lgYDZS04b5vTAKJlBYVpDukYY3VrdKr3/5UV2LXZnCHSAGx2nMc6iC1dbpwJ5VEG8fsZ09LK3EK4by2wCGfSFd/xcVpkeDIkGZUsmbrPRvRgW/cX3O2Zzc3NISC4oUNydGFkCN23VkpkRwqxmWgY+OBO2srWOGWO3zG5ulhLZ98rzg9oWdoahLCYlWWyVRVV9ZL7i9DuQecrs/gfeFTtyffVAM+TNSAMQ8EdOGzs4W1hNwN4Ac6DpLntR/yEQz71G0v8QLq++0ifQbNOrBvqmDYyDTJz7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cMDOOVDbAPfNfq0gLypCFMaYRncjz22Ayr4Xky+CzvE=;
 b=LKlRKbDmVslc13/3kS8lEi2L+qdLIrWJR6GxqIdHVQzdfWLuO7N0uhghw4fT+Ik+Om2J1dTe1dCa0xdO8pR/k6lv6110dJNrcp0KumODmwdedDPJj6mpdO+o3DOEAtVbXc11y+UJjC4Q7zrrF95VIa39slt89U1+jSoTxj2KJth3hFI569RiGGODesbBD15jpQ49FGGWfFlVAcWHBJofdSYrPdMQlzzyzZ8/yceSdTk8UAlniy+YXgCADmUyEC0tMcQbJdcisWmtb0USl3+zlk3OZTx6qlTpGQ6K7ZUPUdkOWLLI1LtdwVCAg4N+Pje3wHsIGmPK+9MP78odnjeaPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cMDOOVDbAPfNfq0gLypCFMaYRncjz22Ayr4Xky+CzvE=;
 b=Q/9XHEwdKM12is7GDnTzN76Sx0dG7Y/gBZQQV2xdd57oNUyLo9lGd2MA/FiHCobkOFKqeybz6NPcyQlNEUx+kghvBRPyRYSFBvnO/1tuEPansnMzu80ThxAwjdnJGzxgQZEcuJJvVNfy8QFMXi7r1e32hK1lB/NMtyRoNLj1/gI=
Received: from VI1PR04MB4800.eurprd04.prod.outlook.com (2603:10a6:803:5a::12)
 by VI1PR04MB6974.eurprd04.prod.outlook.com (2603:10a6:803:133::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.17; Wed, 5 Aug
 2020 12:09:34 +0000
Received: from VI1PR04MB4800.eurprd04.prod.outlook.com
 ([fe80::1c58:aed8:bd10:6c9e]) by VI1PR04MB4800.eurprd04.prod.outlook.com
 ([fe80::1c58:aed8:bd10:6c9e%3]) with mapi id 15.20.3239.022; Wed, 5 Aug 2020
 12:09:34 +0000
From:   "Vabhav Sharma (OSS)" <vabhav.sharma@oss.nxp.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        B K Karthik <bkkarthik@pesu.pes.edu>
CC:     Jiri Slaby <jirislaby@kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Vabhav Sharma (OSS)" <vabhav.sharma@oss.nxp.com>,
        "bhuvanchandra.dv@toradex.com" <bhuvanchandra.dv@toradex.com>
Subject: RE: [PATCH v2] tty: serial: fsl_lpuart.c: prevent a bad shift
 operation
Thread-Topic: [PATCH v2] tty: serial: fsl_lpuart.c: prevent a bad shift
 operation
Thread-Index: AQHWayFI3yg/bZUvNkSlmfbzKR6GJg==
Date:   Wed, 5 Aug 2020 12:09:34 +0000
Message-ID: <VI1PR04MB480018F32A080BC5CC76E3C7F34B0@VI1PR04MB4800.eurprd04.prod.outlook.com>
References: <20200721174228.misj2mgqzcfz2lsj@pesu.pes.edu>
 <20200729160333.GA3652767@kroah.com>
In-Reply-To: <20200729160333.GA3652767@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [103.49.154.17]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: af13b12b-cd4a-4ec6-6689-08d839386aa6
x-ms-traffictypediagnostic: VI1PR04MB6974:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB697425F7F17CD9D7307A483FB24B0@VI1PR04MB6974.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2733;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8ZdgxBaeL1YeYwicLRZFZhkDSHv/Sx33eEeKn+f157t4sstfCXKuLuZhg3ajaaLtF3PvmaPPFzaOFMyz5uCU2nIkh8RHdi8048ovws6P6e+KRc4f5P0kP7usyTcEXVXPZS/FJq2k8r7rdtcjn6jzms5dWhWzIbj4UKobtXaYIZQbYsVjHgp6W3DXbdB+Rr1v/C9VBZoZKxQDWJtIjwXghmmIg1C/YglHgvzHtKYeurbQhGQZJqMElSORnrsTW3xgO//ueq8DEa0UK5HsrNb7Kbeni5sk6+O23iU4Q34e+l/FUe2l+fd7Eb1p7WwdZgQ0fyjKkIQ0mzTmJIYSlO6B7g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4800.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(366004)(39860400002)(136003)(376002)(346002)(64756008)(478600001)(55016002)(110136005)(86362001)(76116006)(83380400001)(54906003)(66446008)(186003)(2906002)(26005)(7696005)(4326008)(8676002)(52536014)(66556008)(8936002)(9686003)(66946007)(66476007)(6506007)(316002)(53546011)(71200400001)(5660300002)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: JB+Lky7jGao1sIZExD/axQ3vb5v91aLLBp0DYI56xQUuWIdgdRtaa53BmM72ums3l4g8wcGg4VYvXMFEl2uGRfKHkpHDadfp2N5XP9UfaTZx14Y5eIVAhNhrSi9iYtiKf0DTnOlQX0CisqgJIwPBNwyYaeV+MPJYHBXy8MMlsu8CzT7/XCVh5rpRvBWXXt7TaCvhMmFSvuSByLesmgClAHgG+wYIllI0uCbLbb1jUFlWG5T24xhXn56JsENER2fo2NgaeFSqGrNH0bPTnIF7NW5WvJyeHnGslrmr19uF7tYbtGDm77Bauuhdi1dJPVHekw2INUZxhzvFD4HfhUK1KP3ejqjWc+184DRsAgaYzgjnKgzDC9ICUR5t16IXmJSaIpQqXyVipxXjqNEF79aWI1iPlPV+pNy3BHHf6IQF+fviT5V8kWJqeE2w1s6tAjZb3kNqt8NFFO4aZQl3HrWwWsS0UdvnWMBXF6jMyS7OGd4V5vchAGu9B2w270zv4rbaQ/EXER6bEsmtlejPWRFzmCxKRmsE9ph+a5i2C2O1gfKEi7uP2oSsEgiQoV4lvOBLOR4nHvVoqazcHQz2QXJ+TouUbk0dIx8aNcaMGvvjv5j8sbJUq/yAAAqcWC+S7aI5IjgLMWzvZc6cYgrmP/WdUA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4800.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af13b12b-cd4a-4ec6-6689-08d839386aa6
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2020 12:09:34.2017
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7C9GCJNILBD0WEXhjHwVjyFRyoY9XoUnVgnEFpBUJ0O7jF9v+tLDo+u05imw2AX+6s0zxjwWPneWBuvTHMpZaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6974
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org



> -----Original Message-----
> From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Sent: Wednesday, July 29, 2020 9:34 PM
> To: B K Karthik <bkkarthik@pesu.pes.edu>
> Cc: Jiri Slaby <jirislaby@kernel.org>; linux-serial@vger.kernel.org; linu=
x-
> kernel@vger.kernel.org; Vabhav Sharma (OSS)
> <vabhav.sharma@oss.nxp.com>; bhuvanchandra.dv@toradex.com
> Subject: Re: [PATCH v2] tty: serial: fsl_lpuart.c: prevent a bad shift op=
eration
>=20
> On Tue, Jul 21, 2020 at 11:12:29PM +0530, B K Karthik wrote:
> > prevent a bad shift operation by verifying that the argument to fls is
> > non zero.
> >
> > Reported-by: "Vabhav Sharma (OSS)" <vabhav.sharma@oss.nxp.com>
> > Signed-off-by: B K Karthik <bkkarthik@pesu.pes.edu>
> > ---
> > v1 -> v2:
> > 	added Reported-by tag
> >
> >  drivers/tty/serial/fsl_lpuart.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/tty/serial/fsl_lpuart.c
> > b/drivers/tty/serial/fsl_lpuart.c index 7ca642249224..0cc64279cd2d
> > 100644
> > --- a/drivers/tty/serial/fsl_lpuart.c
> > +++ b/drivers/tty/serial/fsl_lpuart.c
> > @@ -1168,7 +1168,8 @@ static inline int lpuart_start_rx_dma(struct
> lpuart_port *sport)
> >  	 * 10ms at any baud rate.
> >  	 */
> >  	sport->rx_dma_rng_buf_len =3D (DMA_RX_TIMEOUT * baud /  bits /
> 1000) * 2;
> > -	sport->rx_dma_rng_buf_len =3D (1 << (fls(sport->rx_dma_rng_buf_len)
> - 1));
> > +	if (sport->rx_dma_rng_buf_len !=3D 0)
>=20
> How can this variable become 0?
Condition x, taking false branch
Explicitly returning zero=20

static __always_inline int fls(unsigned int x)
{
	return x ? sizeof(x) * 8 - __builtin_clz(x) : 0;
}
>=20
> thanks,
>=20
> greg k-h
