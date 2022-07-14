Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63999C43334
	for <linux-serial@archiver.kernel.org>; Thu, 14 Jul 2022 15:11:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235095AbiGNPLl (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 14 Jul 2022 11:11:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbiGNPLk (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 14 Jul 2022 11:11:40 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70050.outbound.protection.outlook.com [40.107.7.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BC7154C87
        for <linux-serial@vger.kernel.org>; Thu, 14 Jul 2022 08:11:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dcoYVxyIabWW9Sqqux83DN9rohkEHhOcR6MfOd9dq7TxZztpv2SRmPdyBkE+0rn9owsvOrkx5rLrwv1dsG9m7xukFcd/xms3Lckp/hK8TamW0XqEbYV92KkZmg/8+vVeB+xeIZGCugb14Ec2eFsJu9m92hIP6wRqxuQAQTCsHXBfNdt7d9thjJbsGc5FMFKNc8FsSQJgZJGvPDhGMWTrpGrxPrvLLCgkruPJxmqjJHnE4JTdfpDfJKm+t/+IHb7Qe4rhq1PcvmWNp5xW8AdYeNftvchb6VKPTfMZ4mqsJm19DaP8vir9OjR44fU7ZIprAVGJwdwjs3DUzSSxYg06Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fyG8aGQ77RNkSzpWARDxGBz7oM/xcMXXQWzadDL5Ozg=;
 b=YInRh7+Poo0bjZrMvFr7SoGKzt7AB/vzaSMYoTFpU9PElCkYIzZPhNjEHXA68xPj56LrlxVlfYRlbz5lzZ/FyfFqji6fLwKUofJvOH+WHwXExlnQ1gi8RudAmrctkUWqvPN4zFWRGBpT4x9YgCgotDMhBTtC4l2cMYWTeyjP3eB7e6+ofXq3kvjH0jvJ7ZFLBwydcXqq9ZTFCdjnX1zXRkAuOg+spiSYjG5t2kHgmbmSdAtHSpPdUy8KwJ8JQ3zMCiWS4jN/Q/tb/3kBIMo0Mntd34YF2u6Ok2MCF3bQGTw59Cyrwb7XE35kRbh0GzIgVZvYkEeAl7d9ppu8H21hJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fyG8aGQ77RNkSzpWARDxGBz7oM/xcMXXQWzadDL5Ozg=;
 b=nTPfQiRVqHKyHMayu493mpSajTeSZoHFDm1J93lDiQAMGp1mlLeHks0S9w0p92MXczcy4BI3OC3kEsgoTxBNovlPUE8/Ty+BXnYfHp5lzd+cra4r5QlHkgcOjx4k7bkU2FYj2dY9Vl3zq6eP0IRaCqRWC2IJfCV1+kw9yykB3bg=
Received: from AM9PR04MB8274.eurprd04.prod.outlook.com (2603:10a6:20b:3e8::23)
 by PAXPR04MB9301.eurprd04.prod.outlook.com (2603:10a6:102:2b9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Thu, 14 Jul
 2022 15:11:35 +0000
Received: from AM9PR04MB8274.eurprd04.prod.outlook.com
 ([fe80::34eb:6533:85f0:5ed6]) by AM9PR04MB8274.eurprd04.prod.outlook.com
 ([fe80::34eb:6533:85f0:5ed6%9]) with mapi id 15.20.5438.014; Thu, 14 Jul 2022
 15:11:35 +0000
From:   Shenwei Wang <shenwei.wang@nxp.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
Subject: RE: [EXT] Re: [PATCH V1 1/1] serial: fsl_lpuart: zero out parity bit
 in CS7 mode
Thread-Topic: [EXT] Re: [PATCH V1 1/1] serial: fsl_lpuart: zero out parity bit
 in CS7 mode
Thread-Index: AQHYkwULr58SUgPXOUmslT7pwfzuYK199roAgAAI9QA=
Date:   Thu, 14 Jul 2022 15:11:35 +0000
Message-ID: <AM9PR04MB82744674CA0015303AE7B5ED89889@AM9PR04MB8274.eurprd04.prod.outlook.com>
References: <20220708195800.325933-1-shenwei.wang@nxp.com>
 <YtAouJ0aaZsdCzV/@kroah.com>
In-Reply-To: <YtAouJ0aaZsdCzV/@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 12da217d-b8a9-490b-dbe8-08da65ab24cf
x-ms-traffictypediagnostic: PAXPR04MB9301:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HpbfaNTyxkswM4IyUY2XzeeY/hmseeMGoDxmPeucGedF1lOCi2dy/tH+4s2FWBHnvZBmi863kuOTZyv+TnjLUDtK6W424fEYMfx7sSoaKJ8wLD3EOLiPAlOunIFQTrv9lHDcz0sUlQG09xGgq50YJUasIi8PCb5M2J4XBYfrXpnuDgGmb1BPmqLMhugH0LsoCxVekj4jDSIyi5/F6nqt04Ls+/L4S5dcL/NS+XZmcndcyBYKbIzmNfdVHK1hFT/5IWD2bqV5btHAzD1CedZS4MIXrWmaYDPMiRxdgXb2qpjfCMmekHSm0SSPOH9jrqn6WjEV5dw57lS0hSruHqkOBETaFrDC+QiDnc1B2D9OeE57TuY3Q8NogPV5Gn9binXakYqRJUDoOMG5BKLNubRz5aw11dYlZxJlR2N8fWhfXUNAzSKdNbn2eHSWP+BHYAcPqBTH6RwerFL2uR2n5rNViE4rKV7kN+SxOYvbvHOEdj4l5LkuYiuVmqilSbecPtUQ9Zvjl0NE61EAeKuQ5FkzS/UVAk4/vpAg/4GHJVB+hWysY9viEqKV9IvXugo7HRn0TxlG2mjyYz7+290OQgMKWqhrbvYMU4EqiZLMz2R9M+LSlZL3mqoIJON7MvS88LDlYZUzDsgjRTe9+xJ/6+x+UrZ8fkKTH+u9bh2SCp8/2ab1RHiUOlr/pTEk0P49ILb6tl4fM6hUWpDCP2S+PeJiHxHS8fQE0C43tcm9hhl+vdW6QaN+nq+bk9QnYoso/ZV2/IEmt2Z31AUM1WhyOuVsC5CuLRn6Dji5+o17RVQTHSXIja+mGoKxMv1kyRejm33V
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8274.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(136003)(366004)(346002)(376002)(186003)(83380400001)(38100700002)(76116006)(71200400001)(55016003)(6916009)(316002)(66556008)(4326008)(66476007)(66446008)(66946007)(8676002)(64756008)(478600001)(86362001)(52536014)(44832011)(26005)(7696005)(9686003)(6506007)(53546011)(8936002)(4744005)(122000001)(41300700001)(5660300002)(2906002)(38070700005)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?A9Gb6Tp6aWKRG1MBM1i+KuRHSuLr7bxi0VANDBuT5V9WRwJ2nrD/tmdNrHQo?=
 =?us-ascii?Q?z2IqVDghffEbYigsBtc/ftIgfcd5pRtYFoQz2dIwBf/UmTMppZAoulN1ECE3?=
 =?us-ascii?Q?U7KuQVZCaXFAYmq/+DIXu2biXf4LcBQeJy5L9TcqByjs9BXePvWHAAlIxfFp?=
 =?us-ascii?Q?QAYMTY+Dw2IXR0lh1Wx/uEAgEk4xWOqfmMeGnPloEN6dsOhEYsOYzffFuY0k?=
 =?us-ascii?Q?vEHWwLfLh4WkhkVoijNq+wt1vh3spxHnxOf7d/4/ZOd29xffb5/zVH804Nmu?=
 =?us-ascii?Q?InWYTCNwIeh0fpE/+hVh+LN+rkBnmjOvyYS/FkvvHydCZedXCGOoA/g/FFzM?=
 =?us-ascii?Q?+E7eAWbIgQaT+TwjwXWEYz1GsQNkIGXgCuCKA94YxbSq3gAqHIiNXcW+HtEp?=
 =?us-ascii?Q?hYcmuj6vbTGx2w4OhtNGskhtq+60r4BVbRxwi/6adD3lfNVAwO0idgUpl7pm?=
 =?us-ascii?Q?g3GHBfQvstOTbv4xbj6p1MyOZhQ6ssvwVqyeUDHcFpGTgIIStYdJ38nG8Tq0?=
 =?us-ascii?Q?NmLOWBxq7ezqSXjzz6Mhy1bnoNGm7lhfzeZbU9d74ClbIPSByWNFR52E14Xq?=
 =?us-ascii?Q?pF7LkXLJ37/nmp3bX5bCgVRbifT5erwlg6Iu7P+m6RzwdgaVMIRdynHT9707?=
 =?us-ascii?Q?5G0TAXvutEoNjDcgrjN1wJ/ykXqCarym9celihffUbs34tYTRzWg5QJH568k?=
 =?us-ascii?Q?O7wkMU0oQOrja8g3x7gGh1+6/5iI9+XiIzVZfiOBKzzPCG8uEC6OvDmWwbye?=
 =?us-ascii?Q?16bi2F+Wn3eYsxe/dpUR5s9mt8BrYghlKh2X6rF2wQtrAnXHv8U9+ZNpUc15?=
 =?us-ascii?Q?1lSvJ/CiMEeDGShw5EYnZAf0yiBI3DJ/IMHk1oMm9mMoCNfr1r2x2+Ds7MUh?=
 =?us-ascii?Q?4iu37hnJncE2nlccJzI27WKGg7MvUxzISG22BZO5tKUNmJrQL7OmqcfWomob?=
 =?us-ascii?Q?gYtHNlNRC4dSzhDTHElg9nIjNiRqhqao0dASjzKddQ5b4E2kNXb2w1PVHEcN?=
 =?us-ascii?Q?AvbCmTjsYy57/bWp8Ip0Yd8hfeMi/GaOP/cCHkmKgaorXYZEEdy9HzxR+2Dd?=
 =?us-ascii?Q?fB9hunb48Y7m+n8sWJHF5LfeHy+KuQlYOjofghP/U5PMRnrnzdphxyBgFExt?=
 =?us-ascii?Q?2Dx05HWyAsvysQ6KFSR+IXCKpjy1S04X66NKI8/DgOxkpRS2F0q3bX9K9ady?=
 =?us-ascii?Q?Ho+bzv3A7PJxroIR/bYl23rKnroh9UvOhmMYeoxWQXYy5gxpLcRn8aalYqaV?=
 =?us-ascii?Q?q4NjtIyXZzYqyxm9Yz3IqnUClaXwEolAKlP3vZHaNLAQMpoBgg144OEkvIgx?=
 =?us-ascii?Q?Dph5YUkrSV4q1Xp4qGXMQKWeiTmPG14vlsWWLIJS3fN19uC8Ihnm2pGOsTVC?=
 =?us-ascii?Q?/Sz7gA1mGyxnysxdC6qfRMFJxyiw19N781TSsafatdEX5uyZGvZZOLPA+KLx?=
 =?us-ascii?Q?utQror3PdBRNbDKAo6jrsnndQapITUp3eZee3QgjcEYMXBVzywyV6JNTOq/F?=
 =?us-ascii?Q?HAsbmXYLKkgHUFp19vNSehQIHv2vutPc0BFnwGMvQ6/VtZy0RsQs8Xkd3NYg?=
 =?us-ascii?Q?3/YxRFylIlaSyHmtqYE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8274.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12da217d-b8a9-490b-dbe8-08da65ab24cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2022 15:11:35.7136
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: md8OsWwGj2PqAWOUYzmngW7//xvkxlA22i+AKf6pI31G+4Vn9lODeD8cUtsNcUKo0HqBbpncS3gTpHw7Qs04sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9301
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
>=20
> What commit id does this fix?

The issue should have been there since the driver was written. As the CS7 m=
ode was rarely used, we didn't notice the problem in the driver before.

Thanks,
Shenwei

