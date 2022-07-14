Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37A87C43334
	for <linux-serial@archiver.kernel.org>; Thu, 14 Jul 2022 14:53:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231996AbiGNOx5 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 14 Jul 2022 10:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbiGNOx4 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 14 Jul 2022 10:53:56 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2046.outbound.protection.outlook.com [40.107.20.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B9D412628
        for <linux-serial@vger.kernel.org>; Thu, 14 Jul 2022 07:53:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kXdKbhv18rfcN9+btSNVhdPr3APK3uJKxSmIzntPWIyoQWogqwyYB31Rl45O4RuHYig5YZg0SVkLgXuux9YwfIvchY+qntkzxJ/G9eYdruhQcxHPGj6cA3K2QR8yL5IlJm+hzYR/YWrLmGSFI7EA3PubCnvgvcakBT61WolEiTjuILVo0Vte2PRinuOgD4863I+YLiDEYmM3VGWtTDr/GTJxMdaUu1A3PSLE1J+efEKC7OoLpE4whiwlMznbE1vyu1foTLa+K8AjElYjKiBjT47XNB82nOFDMysv02xGNZtykmSIQNhEkVWmVlZR+IMFUOdGv63kioSQp3TAAWYcnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dFaveaWIOQ03+h9GVA+laJ9/aMCFdJH7xkk9/FomWC4=;
 b=FJVzwJDFwBlQbfzTucMLYTtd/UntLKHlgt1WEQphyOQbKorl1cZxE5TzTT+RCTYhAc0AVJC6LtJhCJMPzdX0CyFmrRzbxwClVzoN/aW95c1bpLOM+Hicj+xLK562EZIg2qv0jWCCEiApAydVeaiq9oID95GzfASC6dNsIgDnlLchtP+YBnCCL3lqV4HQ4Y4CNfcTLYVx9Jk7s3925yjBiYQ33wox+JiGxs5kuONqRYrlrnyB1O4KQFsq4S1bFdrVS6hbs471+YiLAhW2iu3okQ71EPId3aL+coV70TfbfLbDkNHT4klTviyLuBr7ibI+dtj9qOTj/xJJL/3BO7QYLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dFaveaWIOQ03+h9GVA+laJ9/aMCFdJH7xkk9/FomWC4=;
 b=ArrN7IEcZyl2Q8fow5wjfCf83DIM4bFOgbEGBxXBX9F61tEOJ3VNS5kSU4yLB7pQWRpN0yBpRwRjhBOczF/5Kn+2emtQkQMV05hSGYaQ9CsKjBQ3v7JfFJTeulH9WSP/NLAiQOGTHsanjtwE7A1DbTBQN8xuv1QfpX3TV7P61a4=
Received: from AM9PR04MB8274.eurprd04.prod.outlook.com (2603:10a6:20b:3e8::23)
 by VI1PR0402MB3695.eurprd04.prod.outlook.com (2603:10a6:803:1d::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26; Thu, 14 Jul
 2022 14:53:50 +0000
Received: from AM9PR04MB8274.eurprd04.prod.outlook.com
 ([fe80::34eb:6533:85f0:5ed6]) by AM9PR04MB8274.eurprd04.prod.outlook.com
 ([fe80::34eb:6533:85f0:5ed6%9]) with mapi id 15.20.5438.014; Thu, 14 Jul 2022
 14:53:50 +0000
From:   Shenwei Wang <shenwei.wang@nxp.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
Subject: RE: [EXT] Re: [PATCH V1 1/1] serial: fsl_lpuart: zero out parity bit
 in CS7 mode
Thread-Topic: [EXT] Re: [PATCH V1 1/1] serial: fsl_lpuart: zero out parity bit
 in CS7 mode
Thread-Index: AQHYkwULr58SUgPXOUmslT7pwfzuYK199q4AgAADjrA=
Date:   Thu, 14 Jul 2022 14:53:50 +0000
Message-ID: <AM9PR04MB82744713B231B4E1A9B39A2C89889@AM9PR04MB8274.eurprd04.prod.outlook.com>
References: <20220708195800.325933-1-shenwei.wang@nxp.com>
 <YtAorn/GVtoTRkdO@kroah.com>
In-Reply-To: <YtAorn/GVtoTRkdO@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3c2fd609-dd21-4a27-6e64-08da65a8aa04
x-ms-traffictypediagnostic: VI1PR0402MB3695:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jrN4ogPB9NyK/Y+xw/eisZs0UtdLjXZshyrHAYL16IU5+BD0TlCybtnfd8hACszm+ePaQvGcxl5goe33gmVoOxIrZtJWxCK4TFmZovDgs/b8EyVKSheCwy/EdFvgRPgVPLFKkaCVp4OZ9a2EE/iWNjTK7oRTguIDeItphmaJci0jVZbZMcLMShKG94pwYmP4fNYv17KUl4Np8pOdqkCU0AOKn8Kqwgs3Nbe15sBLmeMp3mzu1igFJ45RvDd9kYU+zWdZYhOyyVJu1CzK9QNM6AHr2gai70Z+YGoEGw/6Mx965o9SBe2NuOJUG+obKaXHzeutVvOXxQDooV0bU1qrRGss/WR5wEJ1qB+9KqSd9vz+OvWFcWW5AndbLm3ZtR9EdEWdflMThmSyp1Rqr5z/B900p0mxB+ZGCWdY87t9VMr9k2saS5mJoTm6v5uprHLF0dnDEqQV10CcblqPB+hrTYsKuBkqZZ1XbqeL8y1MYHkTN8OQyofTG2MmwOa5km23qd1A9JpoGkActnf/gqGSOPNDuHZgmuO27AlLWVXat8uG2BzacEVrZ79vW7NkriPfYX0fP5RGuBMAk64CphQBmxrfc0AisO0AXy5wLKNIe7T+9pYIXXsdF+QTu1Y59NZmJpDzaq2Z4VOrf5cIOU69S41MPmqTirQDSIq3VjtyotMVqD87obLE16XHM7v8N15FUE6WIRbLpYbCW1FGO7Xs3klZdQJNWaxeY1cCXt99CctnO2J1cQm5Obu1M61hS5L0VA8S68GXSm0fGStCrsfwjopgmPH2vEnjvjPuwZc35DM+eWrHmCcf2FruyB6nU0Sl
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8274.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(366004)(396003)(136003)(346002)(39860400002)(66446008)(66556008)(5660300002)(8936002)(86362001)(6916009)(38100700002)(52536014)(8676002)(66476007)(76116006)(66946007)(316002)(6506007)(9686003)(186003)(26005)(71200400001)(64756008)(53546011)(83380400001)(41300700001)(38070700005)(44832011)(122000001)(4326008)(33656002)(478600001)(55016003)(7696005)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?elY1x8eiBVJRW+jUME0XEhAYBQk+pnOAbuwnU/poH0fYvL56VHVHN871iGdQ?=
 =?us-ascii?Q?iUUJQx5L7CZKPrbwZm4REU0bAOXI7B4E87pZeT+zktIPzPGybGuFD5DEfUnc?=
 =?us-ascii?Q?LPztGrqb7IrjomtHg1G8jzauGPcuUjVfsQwGLS1Xgp3XUuvmFp9hFHpS1jDt?=
 =?us-ascii?Q?2LdTX4rAe1X3SJNnyeZPIZtpRTQD34+jAVWh8TVMwMUx+tBiqCPRxnqZF+Ls?=
 =?us-ascii?Q?vgbwMca0Rouk5Q71HK8lAijVHK2O6c+pMAPhs7ax66AKLv9+C+GLp3RmgyuF?=
 =?us-ascii?Q?8f0eFmNDZ6oRvUaz1yiAEST43pWd7+2OMfFzNe8AUBYDHOs0/irgpvI+rbMk?=
 =?us-ascii?Q?s9Fn1UbTGq4fWLuw/zMU7WQx0aPZZQN15IefRXnKGjc7XxC2UpZEHykTUkxW?=
 =?us-ascii?Q?twJhdezQCPaaDo1a6YzCpWAfQyWZULpdGnMxA1ukFYl1PGBjGFilOnhx4QEJ?=
 =?us-ascii?Q?pN0l10pHdppVZNftY3pyUb/MjV9mTsytyev/DyrIG6vTEd7D0GxB8q9hoyGq?=
 =?us-ascii?Q?Q3W5/JZwOtmgc4O++lQaSTy9japznv7P0SiFatv/hvgoYXkwjMkF/qtHVWIS?=
 =?us-ascii?Q?GbZdgdR2q/cRnLoSIMQJzgPqHeyx6Vy1xCnwI6bN6XeRDfh9EGxoG2TZ3vXO?=
 =?us-ascii?Q?KgZVN8SyXWgfLg1sacAXVWGg618YfK+sN7tLghsRmbTAcsq5xC65vSGqjRnt?=
 =?us-ascii?Q?VuyRMr03jvnXiIEaeTWxXqkeIh6U6tQSTRzwTrI5OEoSCcTgb3CkWnWF9AVV?=
 =?us-ascii?Q?k73aqaXI1RhoVg1u8Lh282n59NQ+wBI3umyJe38cATB9l+d8SdJrmxCwwtU4?=
 =?us-ascii?Q?m4TiNlpyjSqiPMxv8MRNMI4hFEPQteczfZUmEenRZBQny9Zhn/6bZuYonU5R?=
 =?us-ascii?Q?Npy17qOnD+pz6R6HXmfAlhPWbPX4znJQM0pB6RJtH0o6KbGmrc5dKC7EUWqc?=
 =?us-ascii?Q?Ri8mZ8DZ0rjkZFQyYbaPm4IJoWL01x4phDnr8lhfrl+fErOC1Yv8gN9LaIpa?=
 =?us-ascii?Q?Ya/dOa0gZ+CxcJoFvIVqCFbtYl/xPiWGNNB4p/p7EG9YT9zNrU9Nx+r7tdOZ?=
 =?us-ascii?Q?5UsVMmDGHbNvgBVzvh56IvnQZxyJb0D0AX2k6dJ/sYXPA0128pY+kQiLLSY6?=
 =?us-ascii?Q?+CLYCDDxS1DOu2elVl/TYG2BWoXn8VrUzU9eke8qc9tk8nfa7Rt7sgnAGyYw?=
 =?us-ascii?Q?X1N8In5Xy2NkxtuKv2dGPd6eBJBbINLpfZ8INP6c9SvKTluVnQdpydf75+cU?=
 =?us-ascii?Q?4ltQCW4zlmgn0o8iQefpo3NsA92U4FiXsSqeTAFiKj786mgjdt/m/p7RyaC4?=
 =?us-ascii?Q?FaBHz37YpjlfQDnQx4vJZ1YBH/Nv203RdgQFBNruqSQTHF5vLPEbOB53lGVp?=
 =?us-ascii?Q?q+vxBQNVqDdYRk1y1WQAnWSACAH0nfDjLeuWYANfUTq5hiHSdC+koLC7q0SV?=
 =?us-ascii?Q?abFtc03yPetQ4yKdipDXiZX5XwkgVNeXoF5oqud1RU+C3fHQW/XZcYFKoUux?=
 =?us-ascii?Q?JUxXU+n6PbfAya/1XFlsjg7w0FmwT3gfR/dkpYenCZEh+lL1mzRmKvZbwLXM?=
 =?us-ascii?Q?yZvCUQtpdtFc3wgpkQQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8274.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c2fd609-dd21-4a27-6e64-08da65a8aa04
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2022 14:53:50.7049
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +lnJmOYchPDAlV0HcnjZIID3AV/wEuzRG3QodB+5gx160zXGrfvLMbp/hlD88CnqUU84ziKQK5zHuTd/hRyGUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3695
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org



> -----Original Message-----
> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: Thursday, July 14, 2022 9:31 AM
> To: Shenwei Wang <shenwei.wang@nxp.com>
> Cc: linux-serial@vger.kernel.org
> Subject: [EXT] Re: [PATCH V1 1/1] serial: fsl_lpuart: zero out parity bit=
 in CS7
> mode
>=20
> Caution: EXT Email
>=20
> On Fri, Jul 08, 2022 at 02:58:00PM -0500, shenwei.wang@nxp.com wrote:
> > The LPUART hardware doesn't zero out the parity bit on the received
> > characters. This behavior won't impact the use cases of CS8 because
> > the parity bit is the 9th bit which is not currently used by software.
> > But the parity bit for CS7 must be zeroed out by software in order to
> > get the correct raw data.
> >
> > Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
> > ---
> > changes in v1
> > - fix the code indent and whitespace issue;
>=20
> Normal patches start numbering at v1 :)
>=20
> >  drivers/tty/serial/fsl_lpuart.c | 26 ++++++++++++++++++++++++--
> >  1 file changed, 24 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/tty/serial/fsl_lpuart.c
> > b/drivers/tty/serial/fsl_lpuart.c index 8fe0494d4057b..a8f59fb27c825
> > 100644
> > --- a/drivers/tty/serial/fsl_lpuart.c
> > +++ b/drivers/tty/serial/fsl_lpuart.c
> > @@ -274,6 +274,8 @@ struct lpuart_port {
> >       int                     rx_dma_rng_buf_len;
> >       unsigned int            dma_tx_nents;
> >       wait_queue_head_t       dma_wait;
> > +     bool                    is_cs7; /* Set to true when character siz=
e is 7 */
> > +                                     /* and the parity is enabled     =
       */
> >  };
> >
> >  struct lpuart_soc_data {
> > @@ -1022,6 +1024,9 @@ static void lpuart32_rxint(struct lpuart_port *sp=
ort)
> >                               flg =3D TTY_OVERRUN;
> >               }
> >
> > +             if (sport->is_cs7)
> > +                     rx &=3D 0x7F;
> > +
> >               if (tty_insert_flip_char(port, rx, flg) =3D=3D 0)
> >                       sport->port.icount.buf_overrun++;
> >       }
> > @@ -1107,6 +1112,17 @@ static void lpuart_handle_sysrq(struct lpuart_po=
rt
> *sport)
> >       }
> >  }
> >
> > +static inline int lpuart_tty_insert_flip_string(struct tty_port *port,
> > +     unsigned char *chars, size_t size, bool is_cs7)
>=20
> Why inline?  Don't do that unless it is measurable with and without it, g=
ood
> compilers will guess this correctly.

Agree. The inline is not necessary here. Will fix it in next version.

Thanks,
Shenwei

> thanks,
>=20
> greg k-h
