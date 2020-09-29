Return-Path: <SRS0=bP+p=DG=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42C62C4346E
	for <linux-serial@archiver.kernel.org>; Tue, 29 Sep 2020 09:36:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8CED20897
	for <linux-serial@archiver.kernel.org>; Tue, 29 Sep 2020 09:36:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="dktv5y++"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727700AbgI2Jg2 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 29 Sep 2020 05:36:28 -0400
Received: from mail-eopbgr80049.outbound.protection.outlook.com ([40.107.8.49]:64580
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725826AbgI2Jg2 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 29 Sep 2020 05:36:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j5OwBooAd6R7gbcuVdf9eMIsIgv5X/98LLWTT3uVXJLXu+WeCoX9KkXoWagtfT8ImkyANg+cHK5tQ7sFBFNY2aNw43WQkXzHmxE1wJ/egdXDKkTIj7USBNSoFXZWNfT/vYYKCZAF40z1wGprCdTuCBlHxiGZ7ym2bVaZlPEWI4uZ5nC5vJ8hgE8sN4lA0dgl9w6scGAjMEZEajV/aXxyCiggRbU27wYBdqLEH2zjwT2E6LSpBSrdF1vaFwxQN/A3oWuvynDp3pudQpZzRdMk28NSJU0sMiDz0M5sRVEhsaKrVMB7507TVqVC1kNsC7/Z+0ehTib0RKuXcsBKZmJV8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p8UMfDfevwaC/e2M8AI4UVbCI0VvP6ctqZtxGZ8LVhk=;
 b=KlqKArI81sMVQ0XjOZLqqD2izQbru/OCDqBkNbvtXbma3ZtRqAdSZvwET5CMyjH+2yvYCYzN6gr22nn2t5/OcuwZtzm6S3Ad9yZlJwUyuZYoO2ARQt0F2MoQl7fxZKoCW7m8PqsDPEUfJ/2sWc4idbJSZeSd6ZeajLTpbKb73P2w3Db4wYa5+xehhTVLqq2cxmhAFiPG65+LSZLxwlsq+0Km2TFMsA+5rHZ48dgPDtPUFiNjptooZ7yIlGN+UMwji24NuvF9xzw790jX4IL37OLAOl4Mf5LXuiWLChsrSE43Vn1tMyOoHWqoD1zYOU8F5zpIQkihnd24DJ6WG9BT3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p8UMfDfevwaC/e2M8AI4UVbCI0VvP6ctqZtxGZ8LVhk=;
 b=dktv5y++H3JEJRImlz7X+y5LGSzQesi+Nh6irRR9epflCOO6RKpPvsfYQGWvXg+yn5X1nAQ2VhdiJ5w+fAOIh7CU6dze8ChQEIPgDggqZSR7VEiz2pdcfGwKIuw9CNgEd4RNzkw4ItfaNj7doSUi1L5C/GIZZF479fXKdrlnabQ=
Received: from AM8PR04MB7315.eurprd04.prod.outlook.com (2603:10a6:20b:1d4::7)
 by AM0PR04MB6274.eurprd04.prod.outlook.com (2603:10a6:208:13d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.24; Tue, 29 Sep
 2020 09:36:24 +0000
Received: from AM8PR04MB7315.eurprd04.prod.outlook.com
 ([fe80::11e6:d413:2d3d:d271]) by AM8PR04MB7315.eurprd04.prod.outlook.com
 ([fe80::11e6:d413:2d3d:d271%6]) with mapi id 15.20.3433.032; Tue, 29 Sep 2020
 09:36:24 +0000
From:   Andy Duan <fugang.duan@nxp.com>
To:     Peng Fan <peng.fan@nxp.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>
CC:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH] tty: serial: fsl_lpuart: fix lpuart32_poll_get_char
Thread-Topic: [PATCH] tty: serial: fsl_lpuart: fix lpuart32_poll_get_char
Thread-Index: AQHWlkLyXL3SRNaDbkiNzzmUP3/mFql/WwmQ
Date:   Tue, 29 Sep 2020 09:36:23 +0000
Message-ID: <AM8PR04MB73157339D0AC240C3DAAD64BFF320@AM8PR04MB7315.eurprd04.prod.outlook.com>
References: <20200929095509.21680-1-peng.fan@nxp.com>
In-Reply-To: <20200929095509.21680-1-peng.fan@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: dbb4659c-d9c2-405d-c0ea-08d8645b2185
x-ms-traffictypediagnostic: AM0PR04MB6274:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB6274A2E728D40F0872EEC797FF320@AM0PR04MB6274.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vKdlhwHiajie1QHAe6t03zFRoHHf/S0MJcd+z9LnttieH+O2f1De5NP/R321UO1xvrjVSAQmPn8iUfelwPzBTReGUblr3YwdgL+pxqSVOPTDD8k8YmOl0HHIIZk6wynWENJfL7fMWepG7xuZrBdHSPOS7/hxdmJuOA0AJS85HuuH3qDdiHVh+PGdmO67pNlYtjXimdlQncNnAPr2AZrvf4wBwsgyJLmUItZ/+IUI8vfZmXuCEWpqQHaYk+zJmviBZRfr/bws/+hre/cJEFE49cw1bvAetOv//6YNT2/zGZ0tmASlwnKjaaDuF+Ds2SPWYsPKQZsorp9CjVy2mLxJzx9gh8xwdT/ZHIrblI55C0dl+vNMcNVIyuDRdXwubgVF
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7315.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(39860400002)(136003)(396003)(346002)(6506007)(83380400001)(9686003)(186003)(7696005)(2906002)(4326008)(316002)(66446008)(66476007)(64756008)(66556008)(86362001)(71200400001)(54906003)(5660300002)(478600001)(55016002)(52536014)(26005)(76116006)(110136005)(8676002)(4744005)(33656002)(8936002)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: iCtQdpKSduHv0flvMW0CwzD/Y8/N8RVDVqvEeg+ehOKSLOSigr5JhoCezlwbOWzD0HHzUt2nXOxuhgmD7BelvsJHtMJ9ooqOmFricqzo8XaWCApofuCnesa2xK1jyYjlrQLQiK6tIyWsLHNJQzh4zp7BFCxc2HqRqMWPFI/O3xCvQvYY3sz3r8hbNyLHvlSKYHZkFm/kyvIqTBwyWTny2acNZzqdVrlTM2t+Qmhdikmzn0EB9v4XrytGPgEgoGZVVodgD6YjWr7V3OrjD3v0a2unp0ttFhHPihDeXokJVWnvHYg/ZmfnfHig/7Fyi1mQiJoHFlUlF0F3uPbDyNToZO4BRCheGOEDaa2coGRxYyFCKRyn3KyjajYDNGr3cP67q6k79k8xEHg1kpEBO1I/l8xtZsOirdNP37q3ntYkZHb+t0Bc6jX5/QoOhlOQ9dYFJ2TliGox5EYC2z28488xzwDjwWSMhKctn45W1xr6noqTz0vnZh3Ivf1DW4KhZr68HlnS4ziman9AuzyD9VvMJoIrAldcGspgokp+dH0AvGanUItd+pRI3AhuKAaeJWrn5aiolkNsOUDxBwbPKp0OpZAhgyNax3jW6pNTG0BM6JAzIUPbPgCtttS3SDiQM1zSKvGYfiV9K9bCZYFNTutW4Q==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7315.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbb4659c-d9c2-405d-c0ea-08d8645b2185
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2020 09:36:23.9314
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4FQp0JZVoKlKmzkyMP0As6ViYAzWR10rXI5Rv88Lqkm8SizK6oqZlrWgSbYIYJ9s4e0o8dCm1a+W5Xj79Dlucw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6274
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com> Sent: Tuesday, September 29, 2020 5:55 PM
> The watermark is set to 1, so we need to input two chars to trigger RDRF =
using
> the original logic. With the new logic, we could always get the char when=
 there
> is data in FIFO.
>=20
> Suggested-by: Fugang Duan <fugang.duan@nxp.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/tty/serial/fsl_lpuart.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpu=
art.c index
> 645bbb24b433..1c37280b6c0c 100644
> --- a/drivers/tty/serial/fsl_lpuart.c
> +++ b/drivers/tty/serial/fsl_lpuart.c
> @@ -680,7 +680,7 @@ static void lpuart32_poll_put_char(struct uart_port
> *port, unsigned char c)
>=20
>  static int lpuart32_poll_get_char(struct uart_port *port)  {
> -	if (!(lpuart32_read(port, UARTSTAT) & UARTSTAT_RDRF))
> +	if (!(lpuart32_read(port, UARTWATER) >>  UARTWATER_RXCNT_OFF))

Please remove redundant blank space.

>  		return NO_POLL_CHAR;
>=20
>  	return lpuart32_read(port, UARTDATA);
> --
> 2.28.0

