Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A64FEC77B7F
	for <linux-serial@archiver.kernel.org>; Wed,  3 May 2023 18:38:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbjECSiq (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 3 May 2023 14:38:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjECSip (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 3 May 2023 14:38:45 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2088.outbound.protection.outlook.com [40.107.105.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E6DF4C24
        for <linux-serial@vger.kernel.org>; Wed,  3 May 2023 11:38:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iXhywOuxrwAhLPBHv9XjIMwEOfmP24QfOUpn/RLBDnDPZPOEJFzqJSKcuOhD14DLt+W8Y2D9rPjGNPGI7Kw931GLcvcMU0+u+ZJHOp6aYsV9AYolmPRHmr2F7TPQRlOB3CUZpXGAoN/jWIOAPSldEgVsax9RcqUZM/c4PkRyB2r8e+C0Y4PyKd3htPwEw6EduBx/fztYHsX5w1E5OUjHrwG+cUkzjmBrO8Ufea1IqOD+U7rgUTQTKyr7RnyjB5+OBZfwAfVAMFaVd8C8XXeDprNO5/JQtS5iqT8/MqNaTofg8umvR+wkL9ZzcfZNjfWvpm4Q1AdkZ3ZzmZOPLRjCVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dqzUnapbSQ9heovHsHJ9LuWp6gHn1ZTp4WxxSafWFx4=;
 b=ED6aty3OcaNaiaCFXfvP0CxTmv5hiH3ssV+1lgas5vSJghJJ9jJHadFiXuoKKZesweFQHnXTokPdCeaZLfkkS9t94u8yJBCYo6tcX6ithApmaXzqoKElGR1Wds9BbwXHD4S23oZtzSs1VWRBX4T0nxCTwX7luuWlXMVlHXR8zZlolumxaI0oBuyzEND8o6ZlC5jzJ8uCDK7Lt3ezitC4/dsxFbAD2ovgJTXVm/VLp8QZsyrZIMAlOrP3iFblq1M3VUKMThneZQBLURHsLyI5z3VJbK2+7oC00EQvaXhoJajc5oXw0G0VcKG2hXuaE6PdIUVwx96DYpclkyUrzlehuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dqzUnapbSQ9heovHsHJ9LuWp6gHn1ZTp4WxxSafWFx4=;
 b=H/QgKebZRxRfEsk5StqxZx5Hmz9b6pfmplkVw80Sfu6+S5Uv00bEG+br28jhJZN1w2zmrBmBDngaSXhEqV6SsvE+hryHi19zAc0mQp7blsD/lckDk9X/cBjBuremhXi1Gmk3T/0qbDJpfAFbuQr/9dGr8YyE54N2K0u5cRjl3Xg=
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11)
 by AS1PR04MB9240.eurprd04.prod.outlook.com (2603:10a6:20b:4c4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.31; Wed, 3 May
 2023 18:38:40 +0000
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::28fb:82ec:7a6:62f3]) by PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::28fb:82ec:7a6:62f3%5]) with mapi id 15.20.6363.022; Wed, 3 May 2023
 18:38:40 +0000
From:   Shenwei Wang <shenwei.wang@nxp.com>
To:     =?iso-8859-1?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        "imx@lists.linux.dev" <imx@lists.linux.dev>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [EXT] Re: [PATCH 1/1] tty: serial: fsl_lpuart: optimize the timer
 based EOP logic
Thread-Topic: [EXT] Re: [PATCH 1/1] tty: serial: fsl_lpuart: optimize the
 timer based EOP logic
Thread-Index: AQHZfSlNM2e41/dBg02uWPwIr2d5EK9IQdAAgAB9nPA=
Date:   Wed, 3 May 2023 18:38:40 +0000
Message-ID: <PAXPR04MB9185C216231729D3EF8091E3896C9@PAXPR04MB9185.eurprd04.prod.outlook.com>
References: <20230502190641.657483-1-shenwei.wang@nxp.com>
 <2a4bec70-4285-c48c-1bb9-c2e713ce3e0@linux.intel.com>
In-Reply-To: <2a4bec70-4285-c48c-1bb9-c2e713ce3e0@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9185:EE_|AS1PR04MB9240:EE_
x-ms-office365-filtering-correlation-id: c5cffcd0-8019-40c2-743d-08db4c059d66
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tdvq2BhvfSGM+LY62f3We5rPcmrTqQcMMasGU9XfeJRPsMjHkDDE9FWRT3Q3YaDREDX+/8FNtxpSHwXLC6mQ4vBrJHXw647Msh64pPRAJCZWIquiqLSh9GDtH6SfrPMMmE0x6QE3Qdh1Qmc393G6yxc9h2P7dxIJEE+ymD2AeWvLhLPOqhinvHbcaa7WO9hSx6jgvlseGQn4g4vOSnnAgnI/dGV+pEFHoXEwVYXrvl1DVo7Nidrx1MGTc8srfzpS7UE7xboEQbuYox8JwUNhm/CLfrDwEITuIw7xgQWC5sLJNuizhEFBkqHGV50Pdr3HVPcKgCYp3m3sZoY6CFFCnVqcj9gCTZv9tEQMb779+zv9wRqX/liUUeiuhbCgGiL4Nd7F4upKiIxuAY4KDcx/VBcukXiWyyhOS6Sh2rmuMLGw49UdFYa+pv5XXL+CT+FtPQoyZ7kAZqjG6G17tVIPp/4YN2jW4mRl7WA3lXPhvapOAFV17be+SoWDA5OL3tjU00WD7lIO3A8gVnk02TCu1bc+LOQYUCxvutpKEKo7rONr2CDk2P948fFg3pmX0VKTqNM+crSA/I9BXtj9Cj36JVRAlXIMD4VNUSPUzMxpu9OuPx8nPWARW7cmGjM+Fpum
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9185.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(376002)(136003)(396003)(366004)(451199021)(55236004)(122000001)(186003)(26005)(9686003)(38100700002)(53546011)(66574015)(83380400001)(6506007)(8936002)(38070700005)(8676002)(5660300002)(52536014)(2906002)(41300700001)(478600001)(55016003)(54906003)(33656002)(44832011)(316002)(71200400001)(7696005)(4326008)(86362001)(76116006)(66476007)(66446008)(64756008)(66946007)(66556008)(6916009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?hvO/u9n4BbAb9tsaCEBy/xpTy/ZtasrygLl04IbyEOzhNQO04FPqXCO6VC?=
 =?iso-8859-1?Q?b2JSjrhHVFnZqgvc1BWfRAwFGbPw+aqYR5Riu9tyWemS3iiOFOJyU2XL9v?=
 =?iso-8859-1?Q?+JA/PJ6lxNXIYr+6tzP7c9CEjku9Znq2VNHvNp9WT7ASJEVEuU+ugkYco4?=
 =?iso-8859-1?Q?KphPIs86lFX681HC9eDFSAadi+xnuHkysFXjTRC5Ma9OI6la2U4CZBadjK?=
 =?iso-8859-1?Q?/ehANZ8tmMg/sI/F6wcL/Oj1P3VSP2y/huK9smlwIrvSJSDN38o/qUFJg6?=
 =?iso-8859-1?Q?rY3/yEtBoh8GoefTQWI0rH1lfuoHLiFm7A01EgMCWAaUtoBi0WuwnO8vCn?=
 =?iso-8859-1?Q?Y+X3JMhmGEAjSghBRTMVKe8UeeFh/68Wb/9GzyvuQcriNgJBO+UWSPFUof?=
 =?iso-8859-1?Q?f631SzOQXTvGTS7roUYw08mdBWin6IXMJGODsCs+HFim/MG/lIG15tmZwQ?=
 =?iso-8859-1?Q?93VNUKcd6YEB26kYf6G0QQzSGSxzmSsIfQCHBN4DI7/4d2iOnXePXNyJO3?=
 =?iso-8859-1?Q?BSAeJCgkp1dackatSp6CgQltPb+2Yg+ezD+BPVjDInUp4ikPsFCB2yB7/H?=
 =?iso-8859-1?Q?9hSoNvOyTbl4+76wM0e6AtRQNs+yA6N8gv4XyYcZ/GERqnf63N03m4gQur?=
 =?iso-8859-1?Q?OHXOOgX2/mXSMhBLZk/LYrle5Ew3IJnK0G593L+MSBLNkZKbZ+2vLWccvS?=
 =?iso-8859-1?Q?uChUqCS2XDJWEYF4MrK7rU+7K9IrMYBhiBExkmVj+/WQXNWqBbHu3bxyeU?=
 =?iso-8859-1?Q?WtSR5Cm9aqjIG+hhmjEwDzcZYHawCS5DXC4Ph6+MJMOHC2wkITn+0gjj32?=
 =?iso-8859-1?Q?QpkkMAEm+cdlVUWzDPf0uvp5z+ueiScUzZ3IGzzDZ84s6K8UvAgJ+lZX+N?=
 =?iso-8859-1?Q?kYJZ2WdKwudvxvgdiODAFMl9QVuuwDDMNDrKKhwAdnKs5Lbsy8BPRhfJB8?=
 =?iso-8859-1?Q?NQUkmBRmZ/NIJvNVODJrCY0z6WjSDgpcaWkAQyNPm3WI432wB5bxyVLmml?=
 =?iso-8859-1?Q?u1VQiTi4OInZR/Pkrm1ouoAVMXdwbizcq/rg0YLHGKxv/t3D1bcFtu+FrK?=
 =?iso-8859-1?Q?1pJ+zjWc+67UEYL75wFTC1Dn8djaWkGxIIAKcwV/TLV58qI0ZavP+Br3yC?=
 =?iso-8859-1?Q?sLv4JN1OOQhGyzsNTpfFzIfoUC4qe/XypbF+V+Dqz4CI6tRVhBupHNKbZi?=
 =?iso-8859-1?Q?obFalu23DNlXashwvFO3VZA1nYN41FUAuTKaqV/RbewQ8TcXvurlXIyso6?=
 =?iso-8859-1?Q?bwYSIdVFbXq6v1uCC5iemQy+LmY8ETkvQVTEk6j077eoyfy2ZtDa68pxQt?=
 =?iso-8859-1?Q?Sk1OowHrLFvE/8gjtsBxbA1bEuoRCr25Jj5jQ++OA9CbHsF856YhInNhWM?=
 =?iso-8859-1?Q?JKI+l8jFNascBqnfL772DXYsjoM9Doja0evdjLXDkzitsKlsbit+1WqfmH?=
 =?iso-8859-1?Q?nfHjQqGzQvn+r3OZHmFGsXy/r+Y5lxOXxzBxgnOL+jk8ZaZYq9ELLDzVV7?=
 =?iso-8859-1?Q?L1MdLEvEUtN4uc49HMUcyEMSY5Ni6pZWFawzIBSEKgmmGVOABRzllozleo?=
 =?iso-8859-1?Q?E899hx4Vpz5nWkeHAJlAOyVplrDHEn4vPT65UMYAfFStdnL454YTgg+k0o?=
 =?iso-8859-1?Q?GQNYDZa5zS0v8+p7OWl3SCBvIDbPIwNxnE?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9185.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5cffcd0-8019-40c2-743d-08db4c059d66
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2023 18:38:40.1828
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 19XnCXDU5/5vzJ6VraKv66bTHKpH5lzRrh0bcZ9l/Cgegz8VJPgXP2viaiuvmTJJ+SDCuTmEGnfNI9hbGTcLxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9240
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org



> -----Original Message-----
> From: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
> Sent: Wednesday, May 3, 2023 4:03 AM
> To: Shenwei Wang <shenwei.wang@nxp.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>; Jiri Slaby
> <jirislaby@kernel.org>; linux-serial <linux-serial@vger.kernel.org>;
> imx@lists.linux.dev; dl-linux-imx <linux-imx@nxp.com>
> Subject: [EXT] Re: [PATCH 1/1] tty: serial: fsl_lpuart: optimize the time=
r based
> EOP logic
>=20
> Caution: This is an external email. Please take care when clicking links =
or
> opening attachments. When in doubt, report the message using the 'Report =
this
> email' button
>=20
>=20
> On Tue, 2 May 2023, Shenwei Wang wrote:
>=20
> > At low baud rates, the DMA transfer may end prematurely due to the
> > timer, even during an active transfer. This does not accurately
> > simulate an EOP event as intended. We expect the timer to only
> > complete a DMA transfer once the idle period satisfies a specified inte=
rval.
> >
> > The patch checks the DMA residue count before copying data to the TTY
> > buffer. If the residue count remains unchanged since the last
> > interrupt, that indicates no new data was received. In this case, the
> > DMA should complete as an EOP event. Instead, the timer restarts.
>=20
> This description is lacking something. It does not explain why the stuff =
in second
> paragraph is necessary at all as setting a longer timer based on the (low=
er) baud
> rate would avoid the need to do the timer restart.
>=20

Agree. Would add the following to the last sentence: "if no new characters =
are received, the timer just restarts".=20

> > Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
> > ---
> >  drivers/tty/serial/fsl_lpuart.c | 52
> > ++++++++++++++++++++++++++++++---
> >  1 file changed, 48 insertions(+), 4 deletions(-)
> >  }
> >
> > +/*
> > + * Timer function to simulate the hardware EOP(End Of Package) event.
>=20
> Missing space
>=20

Will fix it in next version.

> > + * The timer callback is to check for new RX data and copy to TTY buff=
er.
> > + * If no new data since last interrupt, restart timer. Otherwise,
> > + copy data
> > + * and continue normal logic.
> > + */
> >  static void lpuart_timer_func(struct timer_list *t)  {
> >       struct lpuart_port *sport =3D from_timer(sport, t, lpuart_timer);
> > +     struct dma_chan *chan =3D sport->dma_rx_chan;
> > +     struct circ_buf *ring =3D &sport->rx_ring;
> > +     struct dma_tx_state state;
> > +     unsigned long flags;
> > +     int count =3D 0;
> >
> > -     lpuart_copy_rx_to_tty(sport);
> > +     dmaengine_tx_status(chan, sport->dma_rx_cookie, &state);
>=20
> > +     ring->head =3D sport->rx_sgl.length - state.residue;
> > +
> > +     if (ring->head < ring->tail)
> > +             count =3D sport->rx_sgl.length - ring->tail;
> > +     else if (ring->tail < ring->head)
> > +             count =3D ring->head - ring->tail;
>=20
> linux/circ_buf.h has functions which likely handle what you want to do he=
re.
> They will get you true count across wrap too which this above does not do=
.
>=20
> Given this is essentially duplicates count calculation some refactor woul=
d seem
> more useful here rather than recalculating the count again in
> lpuart_copy_rx_to_tty().
>=20
> Also lpuart_handle_sysrq() duplicates the same calculations.
>=20

Just had a check with the circ_buf.h, and this piece of codes can be simpli=
fied
with the CIRC_CNT() function.

The other part you mentioned should be optimized as well. I will submit a s=
eparate
patch to do that after finishing this one.

> > +
> > +     /* Check if new data received before copying */
> > +     if ((count !=3D 0) && (sport->last_residue =3D=3D state.residue))
>=20
> I'm unsure about this condition being right.
>=20
> What will happen when rx_sgl.length (or -1 of that, I'm not sure which wa=
y "full
> size" is here) worth of data has been DMA'ed. Does this condition end up
> delaying copy such that it's done only on every other call here?
>=20

The timer function will only complete a DMA transfer when there is new data=
 in the buffer=20
and the data has been idle for the specified interval.=20

The "full buffer" situation should be handled by the DMA completion callbac=
k itself.  A "full" buffer=20
means the DMA transaction has received sufficient data and invoked the comp=
letion callback.

> Also, should you reset last_residue in lpuart_start_rx_dma() ? I think th=
at would
> solve the "full size" problem.
>=20
> > +             lpuart_copy_rx_to_tty(sport);
> > +     else
> > +             mod_timer(&sport->lpuart_timer,
> > +                             jiffies + sport->dma_rx_timeout);
> > +
> > +     if (spin_trylock_irqsave(&sport->port.lock, flags)) {
> > +             sport->last_residue =3D state.residue;
> > +             spin_unlock_irqrestore(&sport->port.lock, flags);
> > +     }
> >  }
> >
> >  static inline int lpuart_start_rx_dma(struct lpuart_port *sport) @@
> > -1297,9 +1330,19 @@ static inline int lpuart_start_rx_dma(struct lpuart=
_port
> *sport)
> >        */
> >       sport->rx_dma_rng_buf_len =3D (DMA_RX_TIMEOUT * baud /  bits / 10=
00) * 2;
> >       sport->rx_dma_rng_buf_len =3D (1 <<
> > fls(sport->rx_dma_rng_buf_len));
> > +     if (sport->rx_dma_rng_buf_len < sport->rxfifo_size * 2)
> > +             sport->rx_dma_rng_buf_len =3D sport->rxfifo_size * 2;
>=20
> max_t()
>=20
> > +
> > +     /*
> > +      * Keep this condition check in case rxfifo_size is unavailable
> > +      * for some SoCs.
> > +      */
> >       if (sport->rx_dma_rng_buf_len < 16)
> >               sport->rx_dma_rng_buf_len =3D 16;
> >
> > +     sport->dma_rx_timeout =3D
> > +             msecs_to_jiffies((1000 * 10 * DMA_RX_IDLE_CHARS) / baud
> > + + 1);
>=20
> There's ->frame_time these days in uart_port which you should base frame
> timing related calculations. I wouldn't mind if that existing ->frame_tim=
e math
> that is visible in your patch's context is also converted (in a separate =
patch).
>=20
> I'm assuming that magic 10 is assumed number of bits and 1000 MSEC_PER_SE=
C.
> That +1 seems odd, did you mean DIV_ROUND_UP() ?

Yes, it is 10 bits and 1000 ms. +1 here is similar to the result of round u=
p.=20
And also the ->frame_time could be used for simplicity.

>=20
> > +
> >       ring->buf =3D kzalloc(sport->rx_dma_rng_buf_len, GFP_ATOMIC);
> >       if (!ring->buf)
> >               return -ENOMEM;
> > @@ -1687,12 +1730,13 @@ static void lpuart_rx_dma_startup(struct
> lpuart_port *sport)
> >       if (!sport->dma_rx_chan)
> >               goto err;
> >
> > +     /* set default Rx DMA timeout */
> > +     sport->dma_rx_timeout =3D msecs_to_jiffies(DMA_RX_TIMEOUT);
> > +
> >       ret =3D lpuart_start_rx_dma(sport);
> >       if (ret)
> >               goto err;
> >
> > -     /* set Rx DMA timeout */
> > -     sport->dma_rx_timeout =3D msecs_to_jiffies(DMA_RX_TIMEOUT);
> >       if (!sport->dma_rx_timeout)
> >               sport->dma_rx_timeout =3D 1;
> >
> >
>=20
> --
>  i.

