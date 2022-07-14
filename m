Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1573C43334
	for <linux-serial@archiver.kernel.org>; Thu, 14 Jul 2022 15:50:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232438AbiGNPu3 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 14 Jul 2022 11:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiGNPu2 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 14 Jul 2022 11:50:28 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60089.outbound.protection.outlook.com [40.107.6.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 671DD32BBA
        for <linux-serial@vger.kernel.org>; Thu, 14 Jul 2022 08:50:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I8sF7cfFICxqdMiEQPaEOEeRyrhmK4D3JeB26deoBbJ9p7io6SiGfGie90Ngp7OWMXn5E+jmHWj4bZeiwDy7wuffRj7zBBU4pomDWb/8cgBYnU1HFgrvmG1KG4lHUZKZ/6cqImBOVHH6WgzNSEj7aRWCnlH2PGSpS9Hgae+K0E08HEZxxCD2ur+Opt38nGYKE1ol72g5dQpCN9vmu5UFlGhpBXBikD4E1e3lLl2p7q2QVDRgoeYwps4ST24G1OAtSGhrJNGXCMgERJLqMSLKh5WA1tF/KC8rrxej08ra/Y0dFgDsJuvQr21nPbw+NDqVQIyMhFH/PNuswGcUgmbnvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o6EzrYWhU4hV4+bwQzIC/yi8Alo9LyLTZ95mUzYh69M=;
 b=jX6l5wi8CpHtEus1YTy2IOO/qWkUc7veVdhAdgyAFCo75laM+fwd4pUzynnG9iLIeLr82QiY+6Y04ChNwP5xjApyEWfO71P62nihlOC/2qhIvorxNbl4/NFEqBngqtRNA2VhilqZn3mWmOyWqLPYNsTBt7Tp4+yJLTo4QDKSrzVEKyuPa0qMTn6BT7xtXYSwBdtICSMd2ZP48aRXlHRZalXflFsWHrVkfXkomfEfCQP8OvqGMVSloWDi94Tl55RSw4e8gow8gf5xxnvvfqqD3fDRxx8AL5AHLccyv7oewE4IOyVTMpzMEa1xxCz03XQxquyFPDoPKXBkXS/mU6kPzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o6EzrYWhU4hV4+bwQzIC/yi8Alo9LyLTZ95mUzYh69M=;
 b=HtFVxxOR7+zgyqFlX3ecpO7xXYJhnAT5vEpG+oy+Wjrog/yH1+9AsFBDMxU38yYUJlHN5EiZ7AZ1MjSwIyoG31++Csjain3FFYZN3J5CsWSTX5HsZoliHCouDu4s2Sh5FHzKNi/hkR3RYBOAr7nY0M+rbmt/bpggPnILBpskb6k=
Received: from AM9PR04MB8274.eurprd04.prod.outlook.com (2603:10a6:20b:3e8::23)
 by VI1PR04MB5790.eurprd04.prod.outlook.com (2603:10a6:803:e7::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26; Thu, 14 Jul
 2022 15:50:25 +0000
Received: from AM9PR04MB8274.eurprd04.prod.outlook.com
 ([fe80::34eb:6533:85f0:5ed6]) by AM9PR04MB8274.eurprd04.prod.outlook.com
 ([fe80::34eb:6533:85f0:5ed6%9]) with mapi id 15.20.5438.014; Thu, 14 Jul 2022
 15:50:25 +0000
From:   Shenwei Wang <shenwei.wang@nxp.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
Subject: RE: [EXT] Re: [PATCH V1 1/1] serial: fsl_lpuart: zero out parity bit
 in CS7 mode
Thread-Topic: [EXT] Re: [PATCH V1 1/1] serial: fsl_lpuart: zero out parity bit
 in CS7 mode
Thread-Index: AQHYkwULr58SUgPXOUmslT7pwfzuYK199roAgAAI9QCAAAXFAIAAAFiAgAABioCAAAUSoA==
Date:   Thu, 14 Jul 2022 15:50:24 +0000
Message-ID: <AM9PR04MB827436A558C5B9D920DD5A1589889@AM9PR04MB8274.eurprd04.prod.outlook.com>
References: <20220708195800.325933-1-shenwei.wang@nxp.com>
 <YtAouJ0aaZsdCzV/@kroah.com>
 <AM9PR04MB82744674CA0015303AE7B5ED89889@AM9PR04MB8274.eurprd04.prod.outlook.com>
 <YtA1EiZ35t5LOA3O@kroah.com>
 <AM9PR04MB8274C4D9B66F697E998A416F89889@AM9PR04MB8274.eurprd04.prod.outlook.com>
 <YtA2pxR7GXxv1/0p@kroah.com>
In-Reply-To: <YtA2pxR7GXxv1/0p@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 044595ac-74c4-4142-ce25-08da65b0912b
x-ms-traffictypediagnostic: VI1PR04MB5790:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TJLdM76UGAnVb5qoAQr+OCaEI4lofM692lfF9pF7Yx6ssUFjgQblLGsG3CSE1EQbgvMxixMjKF4B+thg3/zQk+j7HjcFt1VCjdzQVX4EOxmKiqGj/413OFog2Il92nzY4srdizxqAC1CiDcZ5DVTprYZo0pPbWUNFSeIX+TuCuFgi3MHI5AmrahlRxzBRb6bvh8qf9fCxVQOzJ1OnXsLjqgyN+rHJVC+wTWYcUAiO3TER/j52wx9RSDevN/Op2igFLn3TDGssm7U1xG3PbykznGOIujrSid/wl3IzVPBEEJ8SBnamAHooXmXPt7+ZMH5+060NtI7LqzVbOn2+qdOkhIftAmCmHY5HgZKQGrjF/zbsArY3fyWR/tCwYwzH7shzxPVf2OuHh5e/RgZLL/Q5cC3ebjagwFTRd1VqccSrnVPr31dZYBAYOgKmuPGLfKrJ/IP9UWdu+ZKbhdUN/IWtl/gTKWBN2MV9aGjxhjC+IbplCfwe5JJaMZ2DO9hqJFeiHhxcqaYnT8E2wBQgN4H+KhRxAFvF1fkSAGadwdIPGxcH71zZaCwr+8iZjFN1wp5O5qP31sPIEuyU6k8zp066lKowD7RTxDqsrtodJX30ZIOafhwjRbqncN1BlTxKmxGhI6/0cCULaoXy85gSuEcgfnp/xHstMx71o40MDGQOltsmt4hJDWf/u/WtEesMcY2C3Pt+xSD3BgmT0wMPwJuceBtcmFEEdtGRMuJN2TkD0dmUsD9eZwWuzI9YDYG+11E+JqN/mm0vAb8e8aNjWcaQrHCSpOdl185pbxqvddU1llyIIu4NdEdkxpJXt5ExhDH
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8274.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(346002)(136003)(396003)(376002)(39860400002)(9686003)(2906002)(478600001)(41300700001)(26005)(53546011)(86362001)(55016003)(33656002)(7696005)(316002)(71200400001)(6506007)(6916009)(44832011)(66556008)(38070700005)(83380400001)(38100700002)(52536014)(76116006)(8936002)(66476007)(66446008)(5660300002)(66946007)(4326008)(122000001)(8676002)(64756008)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?M2QvI0NgYXYw+3A894Ws+z0ro4cXZ70JE7uE5n6+xg0Cz1B3X5V4iHyzbQWM?=
 =?us-ascii?Q?PA7k+Qc9BlY8p9cOFDDItrYMYrnE1VluE927KCCvdTbnucQqemhf7Csmr98E?=
 =?us-ascii?Q?ONOtwZ2hooFVwMIPHAIW699ACeDw8gwAKPDdnuCVo9Wer64/wdWBU+QtFa9U?=
 =?us-ascii?Q?R/s+dflb0wWdNRzd2cTc1UWiQ4iG1styFtHWXN/S3t/VgIHTbJCTc6+zZVyf?=
 =?us-ascii?Q?0qas6biaFNGny0FvdTiPo45zzF+XQO2CKlin4ZmGLj0g5an29F+Q3bu30/KB?=
 =?us-ascii?Q?wMLllCGNBi3HE0M3qd1r+Gul+bSFaKZix95WkrTewZz6nnlATH+zbZvHlzv1?=
 =?us-ascii?Q?hF1TjkYgqyPbskKDUk1wPm5S51q6qVZvvtDK/xykkyZSaJNCTSaFvYCT4PJM?=
 =?us-ascii?Q?EHy7I7bFYPkFORg4HMyHI1yKFScPp5yfvvOzZ+BeNMC7GOfMRTnrSoN8T1VE?=
 =?us-ascii?Q?rHirdY026MUVDBVXvS5L0n+CqRSoMvvd2rwPN9XiY030l3CbYPjHV/F7H+hL?=
 =?us-ascii?Q?oa9m8ykdNpWC17w2BEvnkmVZsCajBzrd/USYdg+HFfSEF1X1t46z0C59pHbY?=
 =?us-ascii?Q?xfPTDifETzKBYhxKW/wie1OOPZVVg0/1gauIpL2UADydgo6r/5ObYWLc4mn8?=
 =?us-ascii?Q?+NfUkNSlGzmZaBHLLvt0GObcf5wzc2BL+eBq4YokTVWltEq/jIl+lTfkEAIC?=
 =?us-ascii?Q?W4lsjm2naFU991BYPdOqS66pYKvHSWLLwSTq8L5DivUDwKsYWRFa9E3BgLDv?=
 =?us-ascii?Q?TigvX4UiTXwesePq1hQJ8m4tBrR2rWnPAq4JAV6gT6bx/Ktr+5hQNbP9qajl?=
 =?us-ascii?Q?h5Rw6sjGPgYv5h80fXwwVuwayOQQSK5Oqwp6IxPdR0lFQ9t9CZPs2SJkyXD3?=
 =?us-ascii?Q?Q1/12Yt8u3Ysk6w1Cl6v8ykSX7xKGobBk5wtqK/kQoz8kSBSGhP3ZYdEfVfX?=
 =?us-ascii?Q?dLBmmI9vUZ8uIprQBFg3cFUkD9DLiJyc2GbVQ3DdoQMwGT31VfpEvdMBrcks?=
 =?us-ascii?Q?b2rJIZCInzvZTRm+sotz0ujw87c7fvg3MN216d/6YbUpCehirbysKv/b0nTh?=
 =?us-ascii?Q?rE9icRjfInxxsfL2PRm65Rz+iAZTGvfgsbM6vyFaHxysT7UllhHhs0kAvX1h?=
 =?us-ascii?Q?6rguip8wfSCk+XdFD7boVm7lObGYzG8oDDjHBsuPrcCyV+QRjy14oTIzUdjU?=
 =?us-ascii?Q?agyeIF2TbV44o2afJxEmMjyD7ER1Iog4YxKx4fzxnnqwtDhFBADdEwgFhRol?=
 =?us-ascii?Q?7e4dwkizt59fiBnH2KJTZ7MtBUsX6uaQurkmaCZGvLlM/iFI8eB6vxs6PZ8z?=
 =?us-ascii?Q?L0F9aF7+HxPiYWNKZ/xvqvfVxj1J+P+0epWgLB36U/JGHAy7ULq7BE+mKtHv?=
 =?us-ascii?Q?m/v5eHpf8xfIlVgCa1QQmULt+/Hvq2bh4AMNTF8I8dgsE94Jn9H5/55MIMsP?=
 =?us-ascii?Q?z+bfywgu1Xy1/uWh+RhAD1sdrvao+jsdJjLu2LSiIix/S6seiHeYrm7xEift?=
 =?us-ascii?Q?W4kENpouOG2j/xmQFfuGXoh13LCu/QUDiaxLFmgzxY77Ul3R0+SyQherdtIf?=
 =?us-ascii?Q?dnkbmrrCH2jtELQsLc0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8274.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 044595ac-74c4-4142-ce25-08da65b0912b
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2022 15:50:25.0250
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OEP+9JZZBu2+bEODCmJ+qUelTz37oizAPpnKfUqz7Wg57Ryz1fPdGIOF4fiq+Zp6QRBnn3kXF6h3HznuoL++kA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5790
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org



> -----Original Message-----
> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: Thursday, July 14, 2022 10:31 AM
> To: Shenwei Wang <shenwei.wang@nxp.com>
> Cc: linux-serial@vger.kernel.org
> Subject: Re: [EXT] Re: [PATCH V1 1/1] serial: fsl_lpuart: zero out parity=
 bit in CS7
> mode
>=20
> Caution: EXT Email
>=20
> On Thu, Jul 14, 2022 at 03:26:30PM +0000, Shenwei Wang wrote:
> >
> >
> > > -----Original Message-----
> > > From: Greg KH <gregkh@linuxfoundation.org>
> > > Sent: Thursday, July 14, 2022 10:24 AM
> > > To: Shenwei Wang <shenwei.wang@nxp.com>
> > > Cc: linux-serial@vger.kernel.org
> > > Subject: Re: [EXT] Re: [PATCH V1 1/1] serial: fsl_lpuart: zero out
> > > parity bit in CS7 mode
> > >
> > > Caution: EXT Email
> > >
> > > On Thu, Jul 14, 2022 at 03:11:35PM +0000, Shenwei Wang wrote:
> > > >
> > > >
> > > > > -----Original Message-----
> > > > > From: Greg KH <gregkh@linuxfoundation.org>
> > > > > Sent: Thursday, July 14, 2022 9:31 AM
> > > > > To: Shenwei Wang <shenwei.wang@nxp.com>
> > > > > Cc: linux-serial@vger.kernel.org
> > > > > Subject: [EXT] Re: [PATCH V1 1/1] serial: fsl_lpuart: zero out
> > > > > parity bit in CS7 mode
> > > > >
> > > > > Caution: EXT Email
> > > > >
> > > > > On Fri, Jul 08, 2022 at 02:58:00PM -0500, shenwei.wang@nxp.com wr=
ote:
> > > > > > The LPUART hardware doesn't zero out the parity bit on the
> > > > > > received characters. This behavior won't impact the use cases
> > > > > > of
> > > > > > CS8 because the parity bit is the 9th bit which is not
> > > > > > currently used by
> > > software.
> > > > > > But the parity bit for CS7 must be zeroed out by software in
> > > > > > order to get the correct raw data.
> > > > > >
> > > > > > Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
> > > > >
> > > > > What commit id does this fix?
> > > >
> > > > The issue should have been there since the driver was written. As
> > > > the CS7
> > > mode was rarely used, we didn't notice the problem in the driver befo=
re.
> > >
> > > So should this be backported to older stable kernels?
> > >
> >
> > Yes, that would be great.
>=20
> Great, properly label it as such when you resend this.

This is my first time to handle this kind of label. Can you let me know how=
 to label it for older stable kernels?

Thanks,
Shenwei

>=20
> thanks,
>=20
> greg k-h
