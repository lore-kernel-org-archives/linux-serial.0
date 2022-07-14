Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B85AC43334
	for <linux-serial@archiver.kernel.org>; Thu, 14 Jul 2022 15:26:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240163AbiGNP0e (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 14 Jul 2022 11:26:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240109AbiGNP0d (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 14 Jul 2022 11:26:33 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2054.outbound.protection.outlook.com [40.107.20.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B34D474C8
        for <linux-serial@vger.kernel.org>; Thu, 14 Jul 2022 08:26:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GdeyH075y5VVCgL1q6KHgruc8EKHRqhnM4t4ZobJ04qcHW5CLOAlCVHHyBrNYthGwfZ9Xd1xT66Li7YejSGWkr9HvVav3fC9dkzBmon8wnGVnyfVz6Iqgm8wioHShRkwlbEtW0+atsbWeFN4dxmyc/SaEzDkKtuAWLcob3ZNbzH+AVTPlrwvdjVGHahHO0F9jtqIZ/Js27RQeLu1LXGkx4o7Ko7fgJ8nY//qM31K9hrFvqw6cRb8Nahq8BIyfbciAe2+PJLu6Mqt7Cj8yiGby8XpDICwDmy5DqNiw3HgP/XgtZQeaCxA0L7b8I78HrbO1bF9OyhZREgjMySqYvEiXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B5NhIdu5WPfFZBGwhqnbZeAT4kpDXlRmXVC2I29UErk=;
 b=cJC7hu8pyHQfFc5VPUgDv9ct2EMAxZ1RrFz7wf1w3GHUXHAmVAOvwzPsKU0W5obbJcdeggDa7nZQSQ/byAA1w8azmxb1h7K+blvRL3XctjoKMsCKPPR9byK9SI874bfAcdY22wrCM81s7mWMToJQur0ciuYa4h9zzyb1niYCu6fv8N3IGLn74J3j4yN2Z7FD+lnZCKDXL4gyG6HOKT6W2rCwaCo8xynaHXrc5ZBS0UFzT+KAUHilgDZH3AWFvQsCmDhKK0zA87s4dYjGEKD7GdYOlYl55he728jjUL9qKpX7L9M0jPxAXnq34AWlCV0qHgMnATRpqkNNrFs6q4dwRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B5NhIdu5WPfFZBGwhqnbZeAT4kpDXlRmXVC2I29UErk=;
 b=IwBWCj+IwHH02XOfJCwwn2PPLsVb/SVAY7eR7EKifu09W95srPrpmEF4sWxaYeMqciamxypOATAv5SfvtJVCzBef4c8WepQHVGMe+3zM7hdpgmuK7z2Rm4fJ7PfUYmDWNHeD+8SG76z9zYR8IE7G4WzthKDazT/2n9AI8Y4lbDY=
Received: from AM9PR04MB8274.eurprd04.prod.outlook.com (2603:10a6:20b:3e8::23)
 by AM6PR04MB5383.eurprd04.prod.outlook.com (2603:10a6:20b:97::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.12; Thu, 14 Jul
 2022 15:26:30 +0000
Received: from AM9PR04MB8274.eurprd04.prod.outlook.com
 ([fe80::34eb:6533:85f0:5ed6]) by AM9PR04MB8274.eurprd04.prod.outlook.com
 ([fe80::34eb:6533:85f0:5ed6%9]) with mapi id 15.20.5438.014; Thu, 14 Jul 2022
 15:26:30 +0000
From:   Shenwei Wang <shenwei.wang@nxp.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
Subject: RE: [EXT] Re: [PATCH V1 1/1] serial: fsl_lpuart: zero out parity bit
 in CS7 mode
Thread-Topic: [EXT] Re: [PATCH V1 1/1] serial: fsl_lpuart: zero out parity bit
 in CS7 mode
Thread-Index: AQHYkwULr58SUgPXOUmslT7pwfzuYK199roAgAAI9QCAAAXFAIAAAFiA
Date:   Thu, 14 Jul 2022 15:26:30 +0000
Message-ID: <AM9PR04MB8274C4D9B66F697E998A416F89889@AM9PR04MB8274.eurprd04.prod.outlook.com>
References: <20220708195800.325933-1-shenwei.wang@nxp.com>
 <YtAouJ0aaZsdCzV/@kroah.com>
 <AM9PR04MB82744674CA0015303AE7B5ED89889@AM9PR04MB8274.eurprd04.prod.outlook.com>
 <YtA1EiZ35t5LOA3O@kroah.com>
In-Reply-To: <YtA1EiZ35t5LOA3O@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 97b6c0de-e335-4ed0-6d0d-08da65ad3a08
x-ms-traffictypediagnostic: AM6PR04MB5383:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: z3cIrP+Mv10O416YbXEPvIn8Tgbemt/H3LHau/upN7SzpTS1LG9i7S6InSg+LwZYCZQ3BpT/Uj9HRWYN+dXQJL796Xo+PqCAZt3b2YccYUaVFHvWBi1rie3Rucq2QR+Kf7uaJBmqno3XpND7/UtOIsYzYIOjajU7uaz3ZASDvn7HJkZH2gteTsgADkhansWeyhdsDXp9o054brF/0lrlLQQIAvEKutoK9vlrnWwOpovYH7thPqd21N0wAW1gpNRqWvPeB0CmiW3rozmswykJpcokdjhk8aXinriSI/Wm8SoXdv+ALVT9PtcAU8Q/KcuqYqFkTI1Yzd50SIIpNtWsDYO53iLf+v+26M+shfguaUivTnIbS963K7ysut9ANG+btKVYZ4UrkQhNwN66NOdNl6zjPcpDDh5wQCuxaDSBMBfBtW1d7cele6hSu+0Xa4u7rCJI7FYBQT1g4EYK0s1BIspIF410WCzTKaM/oxbe5mYMZTttTp0EucdjMOmR6Rb9bkb73nnpeF6SDecKimdlmypGR/HNHCh5kqvf8oUo1ohAzm2NCn7dyt0UB2bOJgfi2gFYuIbsl/eBSPtEt/hTFxxhRsQe/tzZtgB70gEV3MDOZTsQhZ5okeRxaO7246hjfzrsQ9cQMwSLk52kFWMtC+iDRpNvKQIQviZf/KiNNZSYt/ndUErLPAEvGWQsdaKqlIU9RMVAGzrxUty+jsnOs6xPeBNRjaCctDmM2y76SEaci/gvUobKPWevZ7BvSI8cnChDMrTlfbPkgBnG2C/yYgi00YaHEDHqONMhN30rWwnkaieOWSR4RQ5L3m1wi0gH
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8274.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(376002)(346002)(39860400002)(396003)(136003)(86362001)(6506007)(316002)(55016003)(26005)(71200400001)(53546011)(7696005)(186003)(6916009)(9686003)(38100700002)(38070700005)(122000001)(41300700001)(478600001)(2906002)(5660300002)(52536014)(8936002)(4326008)(33656002)(66446008)(66476007)(64756008)(8676002)(76116006)(66946007)(83380400001)(66556008)(44832011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?u1Xsq3jwKqnqM0FTZGs50WB0YQOty5ov8sSWhK1HQwguNirflNe6m66COlOX?=
 =?us-ascii?Q?Yos/HVCqr/W4vf4xVkNU5p4tVXduILeg3fW7do+bwk7IMX+f0pVHn166aWGd?=
 =?us-ascii?Q?WEzzRZtjFMGGFZ51H1P7YOtG02MTP/nzhdGPS0NCC1G0CNgXPOAWzRtCxgp5?=
 =?us-ascii?Q?YGv+18R8cSK8dXolOWWxnU+0oEuBO3oEPPR/BYhMx9t2Z+7n7tP1TH49/5dE?=
 =?us-ascii?Q?aHM9RGs1RzTj/9CweDgyBrLGyo9i1XxTjEhpkPlVQqcxZxFHncEylaa2dE4d?=
 =?us-ascii?Q?bVgnwMfgpbY3NFNZvGG0MFn7IHVzlB5F6E30cI9yERqkVRCffjpk7pYjdZAX?=
 =?us-ascii?Q?mFduXZ/W9d9JunAp3ifqZk2PFhhW/NMc4NNjYrmK+pGLgamP6eutwCP6LtiI?=
 =?us-ascii?Q?+wqfAmEMoB0/TGjnSJX5NQzhycbhFkcCB+4mMpda0DSWPz9zxujHQO77bHMu?=
 =?us-ascii?Q?UyfqQg5bdYmgB82LD8VfEazAlt6lyE91RIAjrncU5or+vZGDwNz7xZXXAvsS?=
 =?us-ascii?Q?ngShc0tHac0c/d4Sf5KG0SFEVJAZecSDhRE2y+kEEH2LYxFmaMoy44YKSI1C?=
 =?us-ascii?Q?R4rt3lk7tmRuMopX1zm3ywRhhnOUZ92gkxbBKDhYDQXGa7SgBNyUIelvo4g/?=
 =?us-ascii?Q?5zOU7tsmFruIBU5NwGNK81fnRt0MwG+r8lnSHrYNJgr13wYhpIJIV+l8/tmM?=
 =?us-ascii?Q?TVqo9l5qZI1AHGU11kdfNDPTyC+88JpG5cD83bVn+iRE4YVgdF6hT+1SrRo4?=
 =?us-ascii?Q?uHI4fzpAjtdfeHkCDlfMobu6vw9m7SZUH/SrE4AcPStUj07YuZ7NkE9GCnzE?=
 =?us-ascii?Q?xDYErgkFXqtolkVnlKSlIJiYAkcGYT7/bMO1Pvq4Iq0dMwCTZEQxOXhCpkGE?=
 =?us-ascii?Q?GcDkmvEWl28zLISXeuvbvZTAXPE/mUlHbmvBaT6IN91pGBd/NEshG3K06Kdm?=
 =?us-ascii?Q?wsBqsD9vdMjLNHLcTwyYAre40MILTXrrM5XMdlMnBrwQM0UZ2QpWxNZarj2j?=
 =?us-ascii?Q?SDBmpQGXG3z5dtHVddZISdXg9sWA2VG3aw4AE2GOiZtra3T2eH9o/ARNVCzf?=
 =?us-ascii?Q?xOP/k1KJONv39vMxP7DahTL65c5DTaD181dBFUperr0OGmKRx39BTPOZZo3h?=
 =?us-ascii?Q?oiFEaZQyTTgVynNS0qBpDSCG5PmmelPLsDKrG1iSuvz3Owud3sZyGFZatkMW?=
 =?us-ascii?Q?4wXsR+unAFOcFuaKGX832UQJ0QhloKtTNNnwuQHUu9/fWPdir94a+wlRcpVK?=
 =?us-ascii?Q?U2kuamDsJM7mgV0nwcGCf7k9wSxYtaeCOZXCiuG9RtG60sLf9CwlNf/WnbfH?=
 =?us-ascii?Q?xq6K3PbXfLXyKw7AvZrQjU5I3MzB8W+s5pHoGaVICSLXo3CtrCO8BQu4bnR1?=
 =?us-ascii?Q?xJ1bOVXuSccW+xw7R0ZZN/4+5aHtXP8U2fOO/PtcxMA7g9YZPyw+V55ftc+w?=
 =?us-ascii?Q?xk4dNnbePIQVhALVVAXzXJxFCh5vf005bYZIgoYlVKiMDddXWRIiD6Aa4uTL?=
 =?us-ascii?Q?+MGjb6y02pf3ChRl5swwGAaK+1YIGtN4UlnD2lSKD4cniCcg9n0hSvvCVfN5?=
 =?us-ascii?Q?CJi/iJCo2PRV7V67T60=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8274.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97b6c0de-e335-4ed0-6d0d-08da65ad3a08
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2022 15:26:30.3569
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I2UzUhdjRBiHv3rMUIQyOzWq3cy3B+hjHNNPr0SKmzRXQUWvbQiyCixaZ/BUPmIgtiUUHA/4bTroEara4c42Dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5383
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org



> -----Original Message-----
> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: Thursday, July 14, 2022 10:24 AM
> To: Shenwei Wang <shenwei.wang@nxp.com>
> Cc: linux-serial@vger.kernel.org
> Subject: Re: [EXT] Re: [PATCH V1 1/1] serial: fsl_lpuart: zero out parity=
 bit in CS7
> mode
>=20
> Caution: EXT Email
>=20
> On Thu, Jul 14, 2022 at 03:11:35PM +0000, Shenwei Wang wrote:
> >
> >
> > > -----Original Message-----
> > > From: Greg KH <gregkh@linuxfoundation.org>
> > > Sent: Thursday, July 14, 2022 9:31 AM
> > > To: Shenwei Wang <shenwei.wang@nxp.com>
> > > Cc: linux-serial@vger.kernel.org
> > > Subject: [EXT] Re: [PATCH V1 1/1] serial: fsl_lpuart: zero out
> > > parity bit in CS7 mode
> > >
> > > Caution: EXT Email
> > >
> > > On Fri, Jul 08, 2022 at 02:58:00PM -0500, shenwei.wang@nxp.com wrote:
> > > > The LPUART hardware doesn't zero out the parity bit on the
> > > > received characters. This behavior won't impact the use cases of
> > > > CS8 because the parity bit is the 9th bit which is not currently us=
ed by
> software.
> > > > But the parity bit for CS7 must be zeroed out by software in order
> > > > to get the correct raw data.
> > > >
> > > > Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
> > >
> > > What commit id does this fix?
> >
> > The issue should have been there since the driver was written. As the C=
S7
> mode was rarely used, we didn't notice the problem in the driver before.
>=20
> So should this be backported to older stable kernels?
>=20

Yes, that would be great.

Thanks,
Shenwei

