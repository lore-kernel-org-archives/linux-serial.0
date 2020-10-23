Return-Path: <SRS0=K8LB=D6=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CFE1C4363A
	for <linux-serial@archiver.kernel.org>; Fri, 23 Oct 2020 01:44:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B786C2177B
	for <linux-serial@archiver.kernel.org>; Fri, 23 Oct 2020 01:44:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="T+3uqI3Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S374382AbgJWBou (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 22 Oct 2020 21:44:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S374380AbgJWBot (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 22 Oct 2020 21:44:49 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on0604.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe0d::604])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E814C0613CE;
        Thu, 22 Oct 2020 18:44:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U487VNoESm/lZk/YsL5QyIj/SlGowDPxNLAxKWkxxpRBVWAkdiJWGKO6Fd2W0EjSG6ifteeN5xKJ/Mf1WL5zYig43MMILkQfKoWGs96jum/RcU+LVKE0npE5wfKFOdLQdW5QSHe/L846Sg0s62qoUPzEt2XU1hIWW3JzSUtXN2LnUtaG4QFGBuw2WGp1V8k/oFs0BRGVroqIDeVU8Qubzza7EC0WlGDQHA53CVILB795Wp4D8zHPLsG16cIxoHxMjd0sYlRec2F18yME9dh7jNfYyy+6DirR9GPrFUgtvFz4a/C2eNDV08yRyuH3BKuSa7Ekl+Slk7+tixklQ6a+RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U7UUu8UR7hxg2oGYOg1Rd/WtzxITZ2I00o8GoSI+Iic=;
 b=YsSj17onmwFH2AZ85AJciwI5fevL6F6DawlhGGOSoIhAQo/njdUvHSbfTfY2si6t5yRJmxKryLTLNOOk8+iTKFzwFouLWbfBqCfzwDeL3FmjTQdBT3C1OZw/VkIfAOK6tQRLQE+6aYNxjdiQZ4DyF57glpFPEP8dzx9DrMyVGt7RgrwSzIf+PljJCzPMLrui1enDDvEIPc+xE+m+2FTP8Sf7mMUjwEA+yNfKIoZfWsg9I5wIny4seiAI77XaNkDQaDkZ5FBZFAbjmPFw8BRdIKXfKePhMiok0P9tKQgNfpNVaBW08jY1sBuoSqApr4VivbkrAhCq09iKNxDvSMzfqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U7UUu8UR7hxg2oGYOg1Rd/WtzxITZ2I00o8GoSI+Iic=;
 b=T+3uqI3YSH2ohIbYWs4v2xw7ZmPZJ1XlJdHNX1GsArBxfkCbLziyO7H3hfYnhzNIl94dsBuLaTSp4uwK+uLHLOoCFfKC4jqvBZM5raAdGYFtJrFlGt6Bv6JyeGu0cJerWZrrJqhnJmdwgWrbJD8RCH1iMh+qppyJIU62lT8Z8mk=
Received: from AM8PR04MB7315.eurprd04.prod.outlook.com (2603:10a6:20b:1d4::7)
 by AM8PR04MB7442.eurprd04.prod.outlook.com (2603:10a6:20b:1d8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Fri, 23 Oct
 2020 01:44:45 +0000
Received: from AM8PR04MB7315.eurprd04.prod.outlook.com
 ([fe80::11e6:d413:2d3d:d271]) by AM8PR04MB7315.eurprd04.prod.outlook.com
 ([fe80::11e6:d413:2d3d:d271%6]) with mapi id 15.20.3477.028; Fri, 23 Oct 2020
 01:44:45 +0000
From:   Andy Duan <fugang.duan@nxp.com>
To:     Vladimir Oltean <olteanv@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Walle <michael@walle.cc>
Subject: RE: [EXT] [PATCH] tty: serial: fsl_lpuart: LS1021A has a FIFO size of
 32 datawords
Thread-Topic: [EXT] [PATCH] tty: serial: fsl_lpuart: LS1021A has a FIFO size
 of 32 datawords
Thread-Index: AQHWqIXVegM7m6vm90Culn+pcbEX/qmkasXw
Date:   Fri, 23 Oct 2020 01:44:45 +0000
Message-ID: <AM8PR04MB731502EE715F1FDD70BDAD7BFF1A0@AM8PR04MB7315.eurprd04.prod.outlook.com>
References: <20201022151250.3236335-1-olteanv@gmail.com>
In-Reply-To: <20201022151250.3236335-1-olteanv@gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 98ca3767-32cb-4945-7b82-08d876f53812
x-ms-traffictypediagnostic: AM8PR04MB7442:
x-microsoft-antispam-prvs: <AM8PR04MB744291A7B1BFCE18864E49A3FF1A0@AM8PR04MB7442.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1417;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hzSWUh5zNjLA3dPKJmtHIaranUgSGUnV/yEFjP7qzvv9tXvHieK3Ud80GyZLvEzm/om42G9UV/0kAeRub8DvSnxrq984EyttYmWicBAM/5zE3EjCmon5mGeRFk/S4IKS+6Kr0VLbqSMssiH58o+uELB+laa+WcViJJgBiXN2qkqMeTpS8ljKDEV22wGqjeKVZrH68UnW67m4Gi9vIVZuhVz21ieoeAWAJKo8x4osh4vRIBGP/uxcF1IqbhZ4cuhiprkhyVPif++gtwIDCP+lglA1RUnRFj4mj3xw2VfNCrl39ZMJ3XfXEXjjXCqB6y8n
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7315.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(39860400002)(396003)(346002)(136003)(76116006)(66446008)(66476007)(66946007)(64756008)(7696005)(6506007)(316002)(33656002)(5660300002)(71200400001)(2906002)(52536014)(8936002)(55016002)(110136005)(8676002)(66556008)(26005)(478600001)(9686003)(86362001)(83380400001)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: l6idvf931rx/sJ31hdsLmrIM4SstOJtKytRkKjuH54W0BnPTQPSCgwLa1Yvn2asvpw/FsaM8RXVO3hbcUgCyAM/xSzybJ6gpj+1h00JZA3DVPx5nuKIrArc4LtSJK8iJ4bznQ0i5xtiM7t9o18GHMykdQhVpfyisWJXIZkraUSaulvOIyi94CDLB4fQSiej/IoCx7e1FxsQZQcvOeKltMW50wsXXgfz9ky2VEscM0ftcK87ioo5OYfjdDdSUgNbSCxM0o9txJxzgOX01fHFVxMW6k/oW50BEt667PAqWWGeKlgHnZ2s63YIzdPd+0dBC8gObB8Z932QjSXNJBjAL2BwiDOyR2tRZNid4HMOVWUFLOW+PCXxbw696NjNUkfJxEnccPTSwhJW9BxHVBPwPqRxIhBosf+UwEGrZsWoI9I22VhZoVqd1Fu4IBYDAMG5W/HOwftCwiAKJ4sU6TL0/kugd1IF8mfbfdIxebndQJM58vYTF+Pid8jPMBCYEVeMNRImI6/1+JD0eLGlBNvfUvfNgI7/RR8B18ogEv7X76wxNE17JyZPDSFGeeujieXXAILv5gpCWpaj7l5scvEbLwf01RGjPsnBbo+Rtl99a+bqCNOiw+zCMNMyhJDBZgYXgT/XyTenFDGrEBQkSg7rRcw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7315.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98ca3767-32cb-4945-7b82-08d876f53812
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2020 01:44:45.1441
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SFP/A5tNoKjL1bfd+PjODSwIeSmMea3sQyaRrK2RH6OXEZ3YjaFQxNguBKMsDxV/WpHI8JsWmO3bhImX4pvwVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7442
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Vladimir Oltean <olteanv@gmail.com> Sent: Thursday, October 22, 2020 =
11:13 PM
> From: Vladimir Oltean <vladimir.oltean@nxp.com>
>=20
> Similar to the workaround applied by Michael Walle in commit c2f448cff22a
> ("tty: serial: fsl_lpuart: add LS1028A support"), it turns out that the
> LPUARTx_FIFO encoding for fields TXFIFOSIZE and RXFIFOSIZE is the same fo=
r
> LS1028A as for LS1021A.
>=20
> The RXFIFOSIZE in the Layerscape SoCs is fixed at this value:
> 101 Receive FIFO/Buffer depth =3D 32 datawords.
>=20
> When Andy Duan wrote the commit in Fixes: below, he assumed that the 101
> encoding means 64 datawords. But this is not true for Layerscape. So that
> commit broke LS1021A, and this patch is extending the workaround for LS10=
28A
> which appeared in the meantime, to fix that breakage.
>=20
> When the driver thinks that it has a deeper FIFO than it really has, gett=
y (user
> space) output gets truncated.
>=20
> Many thanks to Michael for suggesting this!
>=20
> Fixes: f77ebb241ce0 ("tty: serial: fsl_lpuart: correct the FIFO depth siz=
e")
> Suggested-by: Michael Walle <michael@walle.cc>
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Layerscape has different define for the FIFO size.

Reviewed-by: Fugang Duan <fugang.duan@nxp.com>
> ---
>  drivers/tty/serial/fsl_lpuart.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpu=
art.c index
> ff4b88c637d0..bd047e1f9bea 100644
> --- a/drivers/tty/serial/fsl_lpuart.c
> +++ b/drivers/tty/serial/fsl_lpuart.c
> @@ -314,9 +314,10 @@ MODULE_DEVICE_TABLE(of, lpuart_dt_ids);
>  /* Forward declare this for the dma callbacks*/  static void
> lpuart_dma_tx_complete(void *arg);
>=20
> -static inline bool is_ls1028a_lpuart(struct lpuart_port *sport)
> +static inline bool is_layerscape_lpuart(struct lpuart_port *sport)
>  {
> -       return sport->devtype =3D=3D LS1028A_LPUART;
> +       return (sport->devtype =3D=3D LS1021A_LPUART ||
> +               sport->devtype =3D=3D LS1028A_LPUART);
>  }
>=20
>  static inline bool is_imx8qxp_lpuart(struct lpuart_port *sport) @@ -1701=
,11
> +1702,11 @@ static int lpuart32_startup(struct uart_port *port)
>=20
> UARTFIFO_FIFOSIZE_MASK);
>=20
>         /*
> -        * The LS1028A has a fixed length of 16 words. Although it suppor=
ts
> the
> -        * RX/TXSIZE fields their encoding is different. Eg the reference
> manual
> -        * states 0b101 is 16 words.
> +        * The LS1021A and LS1028A have a fixed FIFO depth of 16 words.
> +        * Although they support the RX/TXSIZE fields, their encoding is
> +        * different. Eg the reference manual states 0b101 is 16 words.
>          */
> -       if (is_ls1028a_lpuart(sport)) {
> +       if (is_layerscape_lpuart(sport)) {
>                 sport->rxfifo_size =3D 16;
>                 sport->txfifo_size =3D 16;
>                 sport->port.fifosize =3D sport->txfifo_size;
> --
> 2.25.1

