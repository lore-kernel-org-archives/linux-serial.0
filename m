Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39916C77B78
	for <linux-serial@archiver.kernel.org>; Thu,  4 May 2023 14:46:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbjEDOqU (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 4 May 2023 10:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230416AbjEDOqT (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 4 May 2023 10:46:19 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2066.outbound.protection.outlook.com [40.107.21.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 123FC2690
        for <linux-serial@vger.kernel.org>; Thu,  4 May 2023 07:46:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ml7BLbTycptU5OLK7THoXN3HFVy3infsfpFtV5N1Za3ouzsWpGlPBtYIRDakfoNuu2IRm50t5dZiBjzFWt1aW6IO6pbmumuDWHvHtnXP8hY84HuEkgOj8b6u7JStoe0UoiZ79jlRQNlM5lFW7mkShi9XumK4gqa1tVvp87yBQOlJ4g5OdeYceQy3A+KaW+G92zU1bFA55fP1923LTvpSIY2fKBt0DtyzBaBfdjtsk/bN1a2iYKz+HxL2HsCPpqxNerawQunds5k0601i+W9cihiSI+3yP9WOoNUc4PMeRW1yuNRYnvYwjVhqWJjbCpshnA2SXm0DIacMzQc7aRVd8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XOfXiQTV7OtREaWCoLm8/kK3cFkp96B2ZJU8kM0MyWU=;
 b=e6YRKeid1cR5QHeN0aDddoTl4fwqmUW0VN7BrnpI1uwBndtz364cvEh4QgCwg6CDUGjVRLAZrCyhP4XAaXGjFYK3bp3lHVBvJyhoOfLBwV/jiywkCW5rnG3RqyY8To3ZZY5+6NOnrUNxCUjmjHMIeL4A8Jv4bWwxZjUKCcykSXixJmyGmg/o/oTBLZRVKpiN2ZTTzHEwz/sUpa+fKFCq8rFuY/LiOGhBrz0StAmYRnERb3V3Si20RfYtrEYAvec8/OEY0kQobgg3aqQxjedtFQw7ee+GI+Me2g0tDNTfyIEhjeKKVp2DCs9cnp9jiwTR97cEdYSCHYY5NgSJ9zM9Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XOfXiQTV7OtREaWCoLm8/kK3cFkp96B2ZJU8kM0MyWU=;
 b=BJS+3vMAD6+dmxwJq7eN2KgNuPaR1yPwJN8Gtq8hGzOeenVDyy8y/hJpVhcypPz9hJGvi/GtNFJBuqv9JA0iM+PxDbilhyPDf4LUdWdGeO/sH71/7GcEWLlN8aYMMTIrBlnVxVAxGVP3EJD3ba9fbUm2XDvP9VrKOpEl7Am0csw=
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11)
 by AS8PR04MB7640.eurprd04.prod.outlook.com (2603:10a6:20b:297::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.26; Thu, 4 May
 2023 14:46:12 +0000
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::28fb:82ec:7a6:62f3]) by PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::28fb:82ec:7a6:62f3%5]) with mapi id 15.20.6363.022; Thu, 4 May 2023
 14:46:12 +0000
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
Thread-Index: AQHZfSlNM2e41/dBg02uWPwIr2d5EK9IQdAAgAB9nPCAAVeSgIAAE5pw
Date:   Thu, 4 May 2023 14:46:12 +0000
Message-ID: <PAXPR04MB9185349D6F32233A30083CB5896D9@PAXPR04MB9185.eurprd04.prod.outlook.com>
References: <20230502190641.657483-1-shenwei.wang@nxp.com>
 <2a4bec70-4285-c48c-1bb9-c2e713ce3e0@linux.intel.com>
 <PAXPR04MB9185C216231729D3EF8091E3896C9@PAXPR04MB9185.eurprd04.prod.outlook.com>
 <6bb5ddbf-580-83a3-766e-108ecfe7d48f@linux.intel.com>
In-Reply-To: <6bb5ddbf-580-83a3-766e-108ecfe7d48f@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9185:EE_|AS8PR04MB7640:EE_
x-ms-office365-filtering-correlation-id: dd5835c0-7642-41d5-280a-08db4cae4e2d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sxtIveEp0s+pWh1Nw0pxit2PtJGpHONsSRePuCzeeuZG7lnQUAeGXsVO0a+bb4NIywll211mMIUMyrC0sucz9bvXv3i482OZVCUFUx+xv7PTm9W+cYaeNjAoXuoM+MjDI3Itt/Kan3d8J8Xvp/DeWUN4/FvihqsEc6QGrFAaHRSeWFKEX6imz6K1rtasYtjjbKg2yStMZNdfamQHjlmASbjyqCWwZ7YX871aaFsxIThgecR4mUx8SNtJP4MPE77DH/JfprROAWVrhJOvghuul9Yetbkr3ywDMOuNY90AHU4W6Wsj706MWes8eDoonNVkOlv00zQ9PCQ+kymaAUk267DeTUUdzrWZgeypJCUB4sj/exLaIo0vFBvxbT5Fa4rMVyrq6cXIbsnbGRF27T5rlwRNKTMFCH7A4ofqCRPVoCdpWZOuL5P8paUUmSVvmrBkpf5+c8OOtZxXCFjUXdLl9CGo6jITip66in/5PtI7qrVMa5Aj0+riVz1JxfyY28Lm6JYdmHKvuLWU0ArzNT2zL0JT1pqjhLqFlgn6Mb5p7/n2M/VbKVeRKpWEMZypmuOpCHA2yGUt3yeq951yydbLeS7SsFUUgGdnjYGtQll5Zg4+IbnMonAs64ttWivjty2S
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9185.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(376002)(366004)(346002)(39860400002)(451199021)(44832011)(478600001)(38100700002)(122000001)(55016003)(8676002)(52536014)(8936002)(5660300002)(54906003)(86362001)(26005)(66946007)(76116006)(66574015)(66446008)(7696005)(6916009)(4326008)(64756008)(83380400001)(66556008)(6506007)(66476007)(33656002)(316002)(9686003)(186003)(41300700001)(53546011)(55236004)(2906002)(71200400001)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?MSpSYhtVyCjq56W5e9xLJOM7xx/rmbQB1IBNcGOyI38HZ6zvTDH5O95KoF?=
 =?iso-8859-1?Q?9kIEuuEl9pQbMBHHRc07kOZWzchgutHsYuKGGNoQzC2MZAsgoNmdvZu6fu?=
 =?iso-8859-1?Q?THqsmXYaUDlGNfb3xWH+buM/qXiF/BTHBmMvPMfP3EVhyzwsNcKlEWhSgt?=
 =?iso-8859-1?Q?9dmvtF6LHN08mjPcG9avN69Qf7HEWef2BS70OFDtOPFPZrGVIS5lgbuX+Z?=
 =?iso-8859-1?Q?oYMy6kpcSavNrGP6VsJt0U7XH6xs4z34Vgz1EccJXNvS0WR3WY6YVRNtUH?=
 =?iso-8859-1?Q?e/MFsg6KeXAGU1Z53yv9jD0p5QhuoV3T4unviHhXpvDZ7JbD88dMFIp9zn?=
 =?iso-8859-1?Q?DysDd2pP0m2A/xT55ksZ13P93chzsmEWTRhsUlsT+p/6VLbQ390mrG15z3?=
 =?iso-8859-1?Q?hADDQGWxZ3MxF0MLkoSRfT3i/ZJSwYpXD7uvPepFtykDfL/MdVrGf1R2EQ?=
 =?iso-8859-1?Q?sbtjyFE0+6hkeT+HHooOQYR1s7ArGd82RNW++ZWRTgMVaJ3eQXqcriwZnn?=
 =?iso-8859-1?Q?tt/c4MHe6OgFWmOXOgEh5r8NokHo+WpwxwnsMF1k/vap3qb3GE/RthRD0P?=
 =?iso-8859-1?Q?U434xlnMzj0R0s7BkF96ZjQ9SM/SfWdncNPPVTIOKIXMGfcd4B/PFE6Imd?=
 =?iso-8859-1?Q?59Z0KWyqe5SVke2Ls7wkIFiFq4oe/dhyOOGOXYh2tkPrldjbPpqGx9mAkP?=
 =?iso-8859-1?Q?5opvFjGQMzIyBy2U4wDKVEXskAhBb/reZGB9cgoNXCj9f45ybdiqS4xsJq?=
 =?iso-8859-1?Q?4unnVwHKQY9vqXK/VwnAIXpC7eUIOcaNttkkqlIIOd5K+J+FCw0U4ffZWE?=
 =?iso-8859-1?Q?5AhbkdDhRj0dAYlolbhrh0va3kg0glVaFc1AmSKvBDsh97B1ALOtTbruGM?=
 =?iso-8859-1?Q?qgqzhT7LfJwNPmxXwyDTIibX3+g1/yg4P1Ii7ELgYsVwQGBVRLVdAvZ5Ai?=
 =?iso-8859-1?Q?3V9WY94DZqO6l4xN8hPLo+sz2/8j1WE5Zxnw7Z5juHXvWL/SPaRGbZGavW?=
 =?iso-8859-1?Q?rt67mHp9K0gDXv96JVIHVVyCdsmQwF0o40Ldg1uoSCGiFYHgPM+r/wDhjj?=
 =?iso-8859-1?Q?j85xts1bsGVQ08Ks3rHrttxqVin15MHQbV7sTaQr9eqT9cjRqhyTFpLDev?=
 =?iso-8859-1?Q?vDw0w0p3taIbG9CDIgtg3B0OTARLdZxZZ2j1UvL1yDIYXHj5rp1GVHWKYu?=
 =?iso-8859-1?Q?Wa/S3AGAjnS5dtLzRjQe6rEDKrjcuNrI+5sEIVtaJAafESYUK6QUBHcjik?=
 =?iso-8859-1?Q?gwVLAgRqMQCKTu+NtIpKFT02cFupVZ00lJcjyU2PxzFbcEQAUIBQmcsdv3?=
 =?iso-8859-1?Q?YIZqJUThF5p93iKf2nFpd7Sa8GVKlb1e6nV+9htdjJhzteDLPmI7eyyb9T?=
 =?iso-8859-1?Q?HZoTYyApzuwS365g2TD6KgM+1UTvFC9NKYj6RzuAIWzm5wefXHbksaQ8zu?=
 =?iso-8859-1?Q?qhRMBm5KZFV+zGPGH3AtzM1ZFH0CUhTM0IDjlNccRtc1UC1l1oOS8jCMp7?=
 =?iso-8859-1?Q?Xbbm8ix1tbCsMCxbd7SDCARzP2dc3SdTkcI5PAMWzhi/agWTJRdyLJszjs?=
 =?iso-8859-1?Q?/beuFd6+b8lTGb/N3IWcHBxHutf28djH9+YlobuJcwO670SHYBMXD6aI0Z?=
 =?iso-8859-1?Q?BnLVRtVM3mdBaEaB2k8xEZMGLv8qF2G/m2?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9185.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd5835c0-7642-41d5-280a-08db4cae4e2d
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2023 14:46:12.2633
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +xiIH4fHUVLleiiBMn9pIujNk0gXx2PUpcv7TP3eXvEi/qtfRCgQvrZD3ooFAT1ZY0kQTPuSI/KpKBnq4ybfIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7640
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org



> -----Original Message-----
> From: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
> Sent: Thursday, May 4, 2023 8:02 AM
> To: Shenwei Wang <shenwei.wang@nxp.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>; Jiri Slaby
> <jirislaby@kernel.org>; linux-serial <linux-serial@vger.kernel.org>;
> imx@lists.linux.dev; dl-linux-imx <linux-imx@nxp.com>
> Subject: RE: [EXT] Re: [PATCH 1/1] tty: serial: fsl_lpuart: optimize the =
timer
> based EOP logic
>=20
> Caution: This is an external email. Please take care when clicking links =
or
> opening attachments. When in doubt, report the message using the 'Report =
this
> email' button
>=20
>=20
> On Wed, 3 May 2023, Shenwei Wang wrote:
> > From: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
> > > On Tue, 2 May 2023, Shenwei Wang wrote:
> > >
> > > > At low baud rates, the DMA transfer may end prematurely due to the
> > > > timer, even during an active transfer. This does not accurately
> > > > simulate an EOP event as intended. We expect the timer to only
> > > > complete a DMA transfer once the idle period satisfies a specified =
interval.
> > > >
> > > > The patch checks the DMA residue count before copying data to the
> > > > TTY buffer. If the residue count remains unchanged since the last
> > > > interrupt, that indicates no new data was received. In this case,
> > > > the DMA should complete as an EOP event. Instead, the timer restart=
s.
> > >
> > > This description is lacking something. It does not explain why the
> > > stuff in second paragraph is necessary at all as setting a longer
> > > timer based on the (lower) baud rate would avoid the need to do the t=
imer
> restart.
> > >
> >
> > Agree. Would add the following to the last sentence: "if no new
> > characters are received, the timer just restarts".
>=20
> That, however, is unfortunately not the case I was interested in here. Th=
e code
> does restart the timer if new characters _were received_ (residue changed=
), no?
> So my request for clarification to the changelong still stands, why is re=
arming
> the timer necessary instead of simply setting a longer timeout right from=
 the
> start?
>=20

Once new characters are received within the timer interval, the "residue" w=
ill=20
be updated by the DMA driver, but the DMA transfer will only complete once =
it receives=20
the specified number of characters. The purpose of this patch is to prevent=
 the long delay=20
of the DMA transfer when it cannot receive a sufficient number of character=
s.

> (In the first paragraph, you stated the problem is about timer triggering
> prematurely with low baud rates.)
>=20
> This is not to say that the new approach is wrong but the changelog fails=
 to
> explain all facets of what is wrong with the old approach adequately.
>

The timer is used here to simulate the EOP behavior. This means that when a=
 new character is received =20
within the interval, the timer needs restart. If no new character is receiv=
ed within the specified interval,=20
the timer callback will complete the DMA transfer as if an EOP event occurr=
ed.
The old approach did not exhibit this expected behavior. It would complete =
the DMA transfer at the fixed=20
interval regardless of whether new characters were received or not. This in=
correct behavior can be easily=20
observed at low baud rates, but it also for high baud rates.  =20

> > Just had a check with the circ_buf.h, and this piece of codes can be
> > simplified with the CIRC_CNT() function.
> >
> > The other part you mentioned should be optimized as well. I will
> > submit a separate patch to do that after finishing this one.
>=20
> Okay. You might also find CIRC_CNT_TO_END() useful in those inner functio=
ns
> to calculate the length before the wrap.
>=20
> > > > +
> > > > +     /* Check if new data received before copying */
> > > > +     if ((count !=3D 0) && (sport->last_residue =3D=3D state.resid=
ue))
> > >
> > > I'm unsure about this condition being right.
> > >
> > > What will happen when rx_sgl.length (or -1 of that, I'm not sure
> > > which way "full size" is here) worth of data has been DMA'ed. Does
> > > this condition end up delaying copy such that it's done only on every=
 other
> call here?
> > >
> >
> > The timer function will only complete a DMA transfer when there is new
> > data in the buffer and the data has been idle for the specified interva=
l.
> >
> > The "full buffer" situation should be handled by the DMA completion
> > callback itself.  A "full" buffer means the DMA transaction has receive=
d
> sufficient data and invoked the completion callback.
> >
> > > Also, should you reset last_residue in lpuart_start_rx_dma() ? I
> > > think that would solve the "full size" problem.
>=20
> What about this part? If the transfer always does n chars, the left over =
residue
> can match spuriously for the new transfer and trigger the copy because la=
st and
> current residue happen to match (kinda by chance but could be simply due =
to
> repetitive transfer pattern)?
>=20

Yes, there is a chance. Will reset it when start_rx_dma.

Thanks,
Shenwei

> > > > +     sport->dma_rx_timeout =3D
> > > > +             msecs_to_jiffies((1000 * 10 * DMA_RX_IDLE_CHARS) /
> > > > + baud
> > > > + + 1);
> > >
> > > There's ->frame_time these days in uart_port which you should base
> > > frame timing related calculations. I wouldn't mind if that existing
> > > ->frame_time math that is visible in your patch's context is also con=
verted (in
> a separate patch).
> > >
> > > I'm assuming that magic 10 is assumed number of bits and 1000
> MSEC_PER_SEC.
> > > That +1 seems odd, did you mean DIV_ROUND_UP() ?
> >
> > Yes, it is 10 bits and 1000 ms. +1 here is similar to the result of rou=
nd up.
> > And also the ->frame_time could be used for simplicity.
>=20
> Yes, please use ->frame_time. I added it exactly to allow this kind of ca=
lculations
> to be easily based on actual frame timing (the other questions were just =
to
> gauge if I understood right what is behind your math).
>=20
>=20
> --
>  i.
