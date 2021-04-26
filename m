Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD911C433ED
	for <linux-serial@archiver.kernel.org>; Mon, 26 Apr 2021 12:50:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C9596023E
	for <linux-serial@archiver.kernel.org>; Mon, 26 Apr 2021 12:50:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233294AbhDZMve (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 26 Apr 2021 08:51:34 -0400
Received: from mail-eopbgr80074.outbound.protection.outlook.com ([40.107.8.74]:7720
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232107AbhDZMvd (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 26 Apr 2021 08:51:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yn1hy4HuoypJMRSXA/wdlBkABqoGc3O/XUDfEawoSkWDHTm0Pk/OhUKQeu25Q/e1cOOxj92AzK5sWf43ZfRP4ZR3hYwGAa3nWNPVDJpnUPuwKow3nWnYsNymNorGe/OJ7jqVztcxdPtNAM2+mvyBpgVprjIdwC0hiWn4tRhnZVmicipc+7N9XpaFNM9cKWjaOuHry5IKlk6u8D/2v/9LuoxPbkaJQd8erfr5tzgmSOe9Mp2Y0z39zxhOkVXtiqEI6X50I3czYucCZguic1toriLMjV4IU5MLg+SkvEvQLf0LPxpBDAJpHZbLyYpyHTDMSlyRVX5jLCJQ2V3iTWdhVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JPTpNPSU1UX0aN43G+D6oq97mT7I2z7aw2ZUBxVycSQ=;
 b=Xr6wTGLDuVKEaNrKwBJg6XSIRvx/Wr3vluUR75UikwOAm0Rk/knIciYGLZo2PWVqL+fNoyrgv/1tNZ1OuUojQj3oxM5yRoA1GeaPmuKtgYwXQab3n0+20AO/8k5BnzJoIs2V2EEB12ZkCQsERZ3+VDAdqy6EzOcP+uhaa85NEpySJblFUFwkGG/LQ3EKKB+2n58ZAaEIrKsCd3RWV5gLEE72PIaeIjGm/wolnAasYeAD91Yq1XszB19F3C7nznQ6CiaB6ECJqjZEEuEkTQf35UrcEb2Vk7s609J5iuq3S7wiWGV/r/6F8+quG837HO/tmoXRSBuHrBiienp5ct/ggw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JPTpNPSU1UX0aN43G+D6oq97mT7I2z7aw2ZUBxVycSQ=;
 b=CyAWv6ALrMdT1b2tNv4gKdO4rAM1ekrhkqTgVtk4Rfc44ycZ9A69QRGWi6ZeKIcRAQnDgmwOabgLcAohGyVjzmt9oJC6CBd8huprj4wbsrDJ8I1jTQhNlNrk0Z7DwDgLXMhuai3LbEnx/QONCNebzqqiT7d9SMJnlchh2tpFNmU=
Received: from AM0PR04MB4947.eurprd04.prod.outlook.com (2603:10a6:208:c8::16)
 by AM0PR0402MB3922.eurprd04.prod.outlook.com (2603:10a6:208:f::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.23; Mon, 26 Apr
 2021 12:50:47 +0000
Received: from AM0PR04MB4947.eurprd04.prod.outlook.com
 ([fe80::c9b0:c412:80f0:4645]) by AM0PR04MB4947.eurprd04.prod.outlook.com
 ([fe80::c9b0:c412:80f0:4645%6]) with mapi id 15.20.4065.027; Mon, 26 Apr 2021
 12:50:47 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH 1/2] tty: serial: fsl_lpuart: fix the potential bug of
 division or modulo by zero
Thread-Topic: [PATCH 1/2] tty: serial: fsl_lpuart: fix the potential bug of
 division or modulo by zero
Thread-Index: AQHXOnDozEAqr+Jd7U+V+2HHvk8drarGcc0AgAAwVTCAAAkhgIAAAtswgAAK2ICAAAcqYA==
Date:   Mon, 26 Apr 2021 12:50:47 +0000
Message-ID: <AM0PR04MB4947C2088A8C4540AAB17E1392429@AM0PR04MB4947.eurprd04.prod.outlook.com>
References: <20210426074935.11131-1-sherry.sun@nxp.com>
 <20210426074935.11131-2-sherry.sun@nxp.com> <YIZ0/vRLASlUph6x@kroah.com>
 <AM0PR04MB4947A9253CE547BEBE95BE8092429@AM0PR04MB4947.eurprd04.prod.outlook.com>
 <YIalMRdbAKZpIJWP@kroah.com>
 <AM0PR04MB49470E50CFAB8C36EABB241192429@AM0PR04MB4947.eurprd04.prod.outlook.com>
 <YIawr8i62pHfSacm@kroah.com>
In-Reply-To: <YIawr8i62pHfSacm@kroah.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=nxp.com;
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cd110d06-df04-49b4-8a0e-08d908b1e9d3
x-ms-traffictypediagnostic: AM0PR0402MB3922:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR0402MB392270931C749BE60084717192429@AM0PR0402MB3922.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: d6GiEZfrfiIMjtZn+I2FvitTzP6f60xsnRwH2X3Dlknx2D/8bI8FUeRMGnyuOl67228CEGuIthIwH5eNClrxVSnilVMj09gawKnTq3qoHkpl7SM77IHggU+twymfoNYQ04UwF5aB3mBaxajDUq0AHzytMTFMxa9lv//cGOzc4sCKcPsD5Kazfd06Nx/SF5eG/PbmjTI+RaZfclSyOv8HCLF+nVqEnd1SSunP+iK0p/DJUJJjJ5/zNKk70kGw6+RiPAIXcalNx2qRo7psxddAa+1NDiM/KD2Cp1v4AJjy/+rOnzeeDSIpr4j/T0t4wsh7Qe4GmD1szUvBJIyREwqyhjJz3auUdg/WNvygQ4fRruECsmIQH0m24srcIWehTMsq8+9ptyioQd1ilwhgD2IkkdV+80kXh5OaE7X7j6gYdXTB9TRpCRWC+Hwp8/lS5Xodnd15heieX5Q2Tm40LosCicmU0G/MscI+CRrUx34aAL9hjGx8LL5ayvJEYEaZ1iMzqF1oubjEOuDc0wVvgRHjdwaih1V0IU0C/urHLNEcktuGzrmRcFfGLAMo+e09Yj1FLHTbitenoww9KSTN05DY8F6Mi3LFHZZGd+HSHAY23hA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB4947.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(86362001)(44832011)(8936002)(8676002)(55016002)(498600001)(64756008)(186003)(2906002)(33656002)(9686003)(6916009)(4326008)(83380400001)(71200400001)(7696005)(26005)(5660300002)(6506007)(38100700002)(122000001)(66476007)(66446008)(54906003)(52536014)(66946007)(66556008)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?XxbnEkN6dpYuhyPoKN3klChtTPqXadegQY5hDU3hx1sCAXaY7hyIUJvkXM?=
 =?iso-8859-1?Q?zaZsRvXXIZETtvW75D02khf6S0n0Br0sYRobm3Q9WKt5uyTSgTftg4QWw2?=
 =?iso-8859-1?Q?yiU02rwJMZa/qp3DJrDBiHOO0ez8me1rkAxH1pWV5RtApQk3FUEOHEAgpF?=
 =?iso-8859-1?Q?oPzFIUZOS6I3lacmc1LxNzTAlG0Is/JhZbhOXwTes4VC8d1O1zU1IaDa4V?=
 =?iso-8859-1?Q?kUyCSfCeIVVeVO93JbtwzW6sz/6nmR18tXOlkzT8SrfEVLrLZYp3HzlS/D?=
 =?iso-8859-1?Q?lfGkLhMzJyiNxoxZqXJwsEHMwxLsBSzXCa2v/JtvihgDxGI4GqrcklI8De?=
 =?iso-8859-1?Q?z0ItyzBGL09u4vuUa4GSTgDsdkK0QHr6j9A5i4RKTWzR6y20Ygtln9WHgl?=
 =?iso-8859-1?Q?hpm4Qq7ZcVyOnfjK8in3tIpAE5QgluJlM4rHecR9vjudv0U59Yr03fNBxi?=
 =?iso-8859-1?Q?IJsUwuJm5bivoplkngUIPLwi4uryKGyfPCECYhqY6AuIj63LSRwGF2Pnd7?=
 =?iso-8859-1?Q?x/UUFSX0ybV3Pkz3vlQmUymL7RysIIohWcTUuj/t4yK2FkqPmPW4zDfc4p?=
 =?iso-8859-1?Q?rMmm5VF3842laV+5hNZ/6LNS9GArCGiLS4NyS/NayrV/ufh9ziaVtN3QPH?=
 =?iso-8859-1?Q?2lfO082et3FnutFt4uXQwzzZSagVl5hNR+JU+++ZAZ7lcF93Skn3P3gqjm?=
 =?iso-8859-1?Q?bxW+h3L3/qn6fyxlBpZMN7WHNP3wWU2CGYNLxT1DyPhfJN/IviA8oeCK0+?=
 =?iso-8859-1?Q?ruiVgQCops/SBqfPY9GZwdAZ0m69pHLMGJvEZ2IjqcQOQDKmAFj5zohROA?=
 =?iso-8859-1?Q?1roaQffLf62cj/OP4qZbuCAbvUz4bdP92G2XPX3Uv358JmV0i0YNCllCUJ?=
 =?iso-8859-1?Q?t38O9FRXG0m8zM6vtqO4aiPzbUBmPiF0Cs6d7KL/uPg/DldaGf1/JAFNLM?=
 =?iso-8859-1?Q?G/uxvJgjNOmSQSgyPijpUbctR+G5B7+vS5H2HQ2mZMSceNkwSFu/U176ju?=
 =?iso-8859-1?Q?urSqBL1xvjJEUAqtxO9YHSk3YjvSyHYr0t5sYh0bjRVQaqbBiAhLjkZedD?=
 =?iso-8859-1?Q?z/fWzZoZCQgyPpbRRf28QlecLv7lQS1vA51WYVLGPZOFGSEIHSQCitnVJn?=
 =?iso-8859-1?Q?NQpCo2eyoDSBkZwOs4jJAxJUfN2RKXCqytR+nUIFPrAcl80BWZkrVROoCT?=
 =?iso-8859-1?Q?TBrIK4/uHAiFpnOrREtJJaqbCt1Sj3nZD80S1IrSKES2+wbFrPhY+r9Zgz?=
 =?iso-8859-1?Q?rxh3gYe0UnXzkpbMi7i2mNLGZQWiRuTr6oPYsrsT71ooSB3UED4+k6RFzS?=
 =?iso-8859-1?Q?6hW2EPojv7JCifq0vA2wv6mVxRmpvSKE88oVjEhV/NCJeptx7P5xnsaJWz?=
 =?iso-8859-1?Q?8jdiqPhRdu?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB4947.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd110d06-df04-49b4-8a0e-08d908b1e9d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2021 12:50:47.3844
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 18kOVc9fWwJNejdQdXOJpx7uhIlwL7z8tPrgIem9IGg2HrIoagV3QrKYxxTFaycWLyA6RauXD7s+XYXBuIryKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0402MB3922
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Greg,

> > > > >
> > > >
> > > > Thanks for the reviewing, yes, I have tested the patchset on the
> > > > real
> > > hardware.
> > > >
> > > > Seems the coverity check is static scan, so cannot judge if
> > > > UARTBAUD
> > > Register will be zero.
> > > > I just found below statement in the uart reference manual: "When
> > > > SBR is 1
> > > - 8191, the baud rate equals "baud clock / ((OSR+1) =D7 SBR)"."
> > > > Since I am not familiar with uart, do you mean that the value of
> > > > UARTBAUD
> > > Register will never be zero, so this case will not happen in real wor=
d?
> > >
> > > Given that this never has happened with hardware for such an old
> > > device, perhaps it is impossible.  But it would be good to check.
> > >
> > > > If yes, I will drop this patch.
> > >
> > > Handling "bad data" from hardware is never a bad idea, so I don't
> > > necessarily want to drop this patch, I just want to try to figure
> > > out if this is a "incase the hardware is broken/malicious" type of ch=
ange,
> vs.
> > > a "this bug we are seeing in real hardware" type of change.
> > >
> >
> > Yes, you are right, the probability of hardware happen in this case is =
really
> low. But we cannot guarantee that it will never happen.
> > So will this check here be accepted? Thanks!
>=20
> Please resubmit it with a better changelog description summarizing the
> discussion here to make it more obvious why this change is needed.
>=20

Sure, will send a V2 patch with a better commit description. Thanks!

Best regards
Sherry

> thanks,
>=20
> greg k-h
