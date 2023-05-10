Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB227C77B7D
	for <linux-serial@archiver.kernel.org>; Wed, 10 May 2023 13:52:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236778AbjEJNwa (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 10 May 2023 09:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236955AbjEJNwS (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 10 May 2023 09:52:18 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on20629.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e1a::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BEEED059
        for <linux-serial@vger.kernel.org>; Wed, 10 May 2023 06:51:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iYzL02cXb9q8f0huo54CjeyR3JeaoOMmWdXuTVvQ2jydsttMYOBOAjv8eLpPl8lv8iDQHj1MRVpGjArpPX2jJpiF87hVoFm/sDxKk66yBgiSTfsNNrZ2DSVxCYZDfUtFPQm9XVkrpQDsvr+8C9EPc1nEmTOlvYqoO+rYy6hzCY1YaKiwx0+9Wq2BCisE7Wf1i0RoyW/EquZ88P/bN4iuEepVhSg+xbZOTr4G5VSvJomc1TQjmoR6LaAR7oNnIYGqw9K0ZYOdz9n4rsMpI1q8eux6j9Eqf9pia05ym0pan8VWpki0twJscZcYqJ3MXvNI4BUgvuf3wxjWBiBNgseTVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+S7dLV99/2kA/KdO6rzyjVkQOlzZ2yoWuXGMZiMRrEk=;
 b=ewhoSzT/ju9DjYOzHEPUz2gG7e+gfDvNf4judQ+hRhqKTI96oJSYaUx4GKh2rez40ovqYwLaU+bZzi60tYFkzYNL7N0ANBlZRkaGjBm8g0YQjf8DAHdAWwi72luajU6y5Bq23+0BObcCTcT2qDGGb9ak+CdWGe7OxKvENfCYB8Ud1lph4Y/vq5845d2XUXor0h9jrlmamwWzQaBb0g+t8qJQWTUfuD3TytkaH55i0rxbWFGPNsHW8/SHXP/wl7E1c7ujwUunmtKBdayFGzhZQTccMlqMadIMeQTMmOpbjaGvYaW6AaKpxiyEXEDuVlyvxkDP2WGoZtTa9Sin2agIqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+S7dLV99/2kA/KdO6rzyjVkQOlzZ2yoWuXGMZiMRrEk=;
 b=BPwAmZQ9NSzTl71uDPS2Pg7hVdd0cy8SY6HuElD34Q4TmaQ+o1eZWeV/PD66tgVK+rx25k//JqaIZARCYD3MOtxn3E/AuqDMYJV8csPxw8xYoCyX69Wnf3vbLvxWxYaZLB2kM8daTDUYyPdzfX0FnkyKr6hMlb/QrHrZRDz3rBQ=
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11)
 by DB9PR04MB9235.eurprd04.prod.outlook.com (2603:10a6:10:371::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Wed, 10 May
 2023 13:51:03 +0000
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::28fb:82ec:7a6:62f3]) by PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::28fb:82ec:7a6:62f3%5]) with mapi id 15.20.6387.020; Wed, 10 May 2023
 13:51:03 +0000
From:   Shenwei Wang <shenwei.wang@nxp.com>
To:     =?iso-8859-1?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        "imx@lists.linux.dev" <imx@lists.linux.dev>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [EXT] Re: [PATCH v4 1/1] tty: serial: fsl_lpuart: optimize the
 timer based EOP logic
Thread-Topic: [EXT] Re: [PATCH v4 1/1] tty: serial: fsl_lpuart: optimize the
 timer based EOP logic
Thread-Index: AQHZgowavdVFPBi2O0O+wcMt0x2mnq9TUK0AgAAwJiA=
Date:   Wed, 10 May 2023 13:51:03 +0000
Message-ID: <PAXPR04MB918575EBB951432D2ACBB17089779@PAXPR04MB9185.eurprd04.prod.outlook.com>
References: <20230509153624.1073946-1-shenwei.wang@nxp.com>
 <f374a1e8-bf8c-c2b6-9350-2f34bcbe7227@linux.intel.com>
In-Reply-To: <f374a1e8-bf8c-c2b6-9350-2f34bcbe7227@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9185:EE_|DB9PR04MB9235:EE_
x-ms-office365-filtering-correlation-id: b3bb87b0-162d-4f42-6e8e-08db515d986b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 05rceghtxLAezoKHRbA3Cpz4S8xpehWw83G06tAZ9ZoZjpx/dloWQ/tskQTqv/+ug2kz+/mZ77uBOMwbvgQPOT4/ovgJW63bd+6QXS2eLEhZ6oKVwh1iIt0imHbf5XfJCbr2oWO3qRFBQvne15Z2IPtJ9iw6MNC+MwbUs1QW5kPQg+nMkMAZADHEBUzJG3XvCZsVFAE2ILm87eOtNvapAo0zI5rAqjvgZ/UnW5+/6cQxvLolpjcVXPJqKSiZshysj2x/aXLvGy90kC/6gqjNSch5I//d2/vOA1Gk6Vdj2yuoAYQmPbycf4miz6DYZsHhsMq11YaeRHas8ie/WqixwE0iYkE/XHxgGt0P00/bskJmpx6IAs67o/cCyhMQgPxhWLi+PXWUUPgEn9fPflb1rSBDaAfnwY345vTVo4QvcCtkugTTxY3Au46ZRetccAbpxEMIS0O1Gw0nXHyCHhJDbSiALyUMlHgGS0YKrNJRSNIvl76H4V/R+P/46+7x8TNkeOTPha9TIpZn66wIfIH9Bma/zI6feZQnRGGtIvONlm0mhjI2I3bbMrErDotHgU/gf2jBT9HhXS3NxUmnUDW5R5rexFzIHnbmAfPKzZBu/+nwlZ6ZwIxfFgQ/r8km4HPG
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9185.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(346002)(396003)(366004)(136003)(451199021)(9686003)(2906002)(186003)(6506007)(53546011)(38100700002)(55236004)(26005)(33656002)(83380400001)(55016003)(66574015)(122000001)(71200400001)(316002)(38070700005)(76116006)(66476007)(41300700001)(66946007)(4326008)(66446008)(66556008)(7696005)(6916009)(54906003)(64756008)(86362001)(478600001)(52536014)(5660300002)(66899021)(8676002)(44832011)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Rky0EBz1A1fPOrQiaqCe/7o6Ziage1byzVhSdEJL3kXxAcLFs5lq+rUI6+?=
 =?iso-8859-1?Q?i6CmLXQPj7LkaH+BfPTE/Je5ZR1rlJWZdia1OTwotZl5lAWzYbeiMda4c2?=
 =?iso-8859-1?Q?BnCsnkccS9yU4NjglUsDw2sWJh+VMOPiS3j9liKJp89Dv89aF5LZuYtTql?=
 =?iso-8859-1?Q?T0SVemoqS3TOdY6QIM4aGoZsWo0AauwQE0/+/+E9MVeUrv6CnM4Fvu4LwJ?=
 =?iso-8859-1?Q?Nm5wt+9J0dav/aPEGx3ijMySmd+PTvvmQYRm4G4NKs2P9oYW+7As6vJE3n?=
 =?iso-8859-1?Q?l9SYYSRGSetPzgov/v0UBUtb4EdY6NV3fD5l67Jer43fiOo1ZIdpIon/i3?=
 =?iso-8859-1?Q?tZMq/V6DikROUoJnrzNJDcWhEhG2yj6NUtKxwa0q9/3fkTyXq8z1TtCJ01?=
 =?iso-8859-1?Q?LaiqZ6ymUx6EVUIWF0swmqihVpkVCGMXzNObVYliNF4G/hkavynUBVXbiM?=
 =?iso-8859-1?Q?z9el22V7xBqZ1vK2v1yYyIKNw/e6C/qCu7FqCjUn0cz1ig7/e72aN0g0D4?=
 =?iso-8859-1?Q?fq6+d9YJ8WJ8sLE7Qwto5TmQaAKMsp029/qLxzhrUQ4lFbYAanKjtq2sgr?=
 =?iso-8859-1?Q?fR19qEaUer8Z249h5z3dImwAsLUal/Ba22lykYTnmrKgDe7nu7FSP+5yEz?=
 =?iso-8859-1?Q?uRaa30GAnj8+Dz4nvfOd5k/pCb2/PlzdA/s28laXb1g3TsR2Ig9+g/fIP6?=
 =?iso-8859-1?Q?QvJ1x4d7UzGwS6xWOTBdaZQ1Aecdy9xRF2FQ3FVE931iT52DWKFCdZsOfZ?=
 =?iso-8859-1?Q?J5+bbi+sqO0uBtTR9HFvxYTcKDRoQSyc/UIKvBKpsVJR3dU3KMFTaJt1bc?=
 =?iso-8859-1?Q?h4quvndxAGVlarK78g/GKBsfkaz+4C5dLmK9BOOQbqJqTptoSrRU0gqRbm?=
 =?iso-8859-1?Q?4uG7ENGobWpBsGYr34Z0zlqkhXXEoQ5zKdjp3afWUNH51Awpt3MY3fBYKd?=
 =?iso-8859-1?Q?OXeNCBDlO44/lOm83xKK4eNVAJSqTuZvxAbZB1Ab88aytAgwqph+eoNWuK?=
 =?iso-8859-1?Q?I+C6Z/9oflyBksYcV7H0lkGR5r+OG57diwvGaDvq19znXx0918/6PCA1jz?=
 =?iso-8859-1?Q?/pvRM86Grngo6Mz/SQSoXBsBZQ9M/vWRNS9innQqgwMxZB9XFQiwx5CwQv?=
 =?iso-8859-1?Q?HG5XHTiW2PO/RMlIZn27MhZSkiVY/DoWeOq4oc4ezWPnY6tOyyaMYTKcyK?=
 =?iso-8859-1?Q?uUW31bVP2nN4vmIJdk4UzF0ElY/M1uqvlOlQJpH3oIxaKl7tFXRgC5zRVt?=
 =?iso-8859-1?Q?T5qpCP7hiyeZqENK/JDc4K/TcEoPhU5zAoP0HNM39tWlbgeBzIH5NrO1V4?=
 =?iso-8859-1?Q?7RUtB/i4l9bfamUaiMs7z/IHvrqwBVv/c9HvCRFjJHd0lUjjqtuoIWBqH4?=
 =?iso-8859-1?Q?U1sIy/lQIbNCdnXPKZ3LeJwjvwGy/VA8MiKzypwktTBvAW5iOzAJ4NqGb3?=
 =?iso-8859-1?Q?04Y7TzKxbKqfXhR8N20pQQSrVGKqf0wq/lilvpp9usJHj40Kf/+FBD2hY5?=
 =?iso-8859-1?Q?g/8aoucyNsGNEewYChMphMQ9Q7WlZ213MOs3HCXS4BPue+N124uGJnH6kl?=
 =?iso-8859-1?Q?6VjpVp6yHHpv7uNFY9H/4gLbdt25zuYHjYolt5RgFbU5t2vfwPFGkNWEIs?=
 =?iso-8859-1?Q?MQt8DSiAdYuAY8YGV3wrISxOgj2l8PlSHO?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9185.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3bb87b0-162d-4f42-6e8e-08db515d986b
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2023 13:51:03.3650
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: guhhc0gj9cPBXLlKyPXCnkHaUs16drpGn8qW+Hwe9Y4dXiAJ2UpRH1PDbOft/mYpc/hOM6ufEIOTb6dcEETZxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9235
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org



> -----Original Message-----
> From: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
> Sent: Wednesday, May 10, 2023 5:34 AM
> To: Shenwei Wang <shenwei.wang@nxp.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>; Jiri Slaby
> <jirislaby@kernel.org>; linux-serial <linux-serial@vger.kernel.org>;
> imx@lists.linux.dev; dl-linux-imx <linux-imx@nxp.com>
> Subject: [EXT] Re: [PATCH v4 1/1] tty: serial: fsl_lpuart: optimize the t=
imer based
> EOP logic
>=20
> Caution: This is an external email. Please take care when clicking links =
or
> opening attachments. When in doubt, report the message using the 'Report =
this
> email' button
>=20
>=20
> On Tue, 9 May 2023, Shenwei Wang wrote:
>=20
> > DMA transfer may end prematurely due to the DMA Rx timeout even during
> > an active transfer because a constant timeout does not accurately
> > simulate an EOP event. The timer should only complete a DMA transfer
> > once the idle period satisfies a specified interval which is baud rate =
dependant.
> > The problem has been observed with low baud rates but could occur also
> > with high baud rates.
> >
> > This patch uses a timer to simulate the hardware EOP (End Of Package) e=
vent.
>=20
> You could open EOP at the previous paragraph where it appears first.
>=20

That sounds more suitable.=20

> > The idea is to make the DMA Rx timeout baud rate dependent and check
> > the DMA
>=20
> Just remove this "the idea is to" and just state what was done by startin=
g with
> "Make" like I initially said.
>=20

Agree.

> > residue count before copying data to the TTY buffer. If the residue
> > count remains unchanged since the last interrupt, that indicates no
> > new data was received. In this case, the DMA should complete as an EOP
> > event. Otherwise, new data was received during the interval and the
> > EOP condition is not met so restart the DMA Rx timeout
> >
> > Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
>=20
> Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
>=20
> However, please check a few additional comments below.
>=20
> > ---
> > V4:
> >   - improve the patch comments per Ilpo's suggestion.
> > -     .rx_watermark =3D 31,
> > +     .rx_watermark =3D 7, /* A lower watermark is ideal for low baud
> > + rates. */
>=20
> It would be better to have this change in own patch. It might be somethin=
g that
> causes discussion/problems later on so it would be better to have it as a
> separate patch. But I'm not sure how tightly it's related to
> DMA_RX_IDLE_CHARS which may make taking it out harder.
>=20

You are right. The rx_watermark here should no more than the DMA_RX_IDLE_CH=
ARS.

Thanks,
Shenwei

> >  };
> >  static struct lpuart_soc_data imxrt1050_data =3D {
> >       .devtype =3D IMXRT1050_LPUART,
> > @@ -1255,6 +1257,8 @@ static void lpuart_copy_rx_to_tty(struct lpuart_p=
ort
> *sport)
> >               sport->port.icount.rx +=3D copied;
> >       }
> >
> > +     sport->last_residue =3D state.residue;
