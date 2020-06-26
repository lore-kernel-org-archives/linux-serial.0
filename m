Return-Path: <SRS0=sLvH=AH=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0737DC433E0
	for <linux-serial@archiver.kernel.org>; Fri, 26 Jun 2020 11:18:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C91D920C09
	for <linux-serial@archiver.kernel.org>; Fri, 26 Jun 2020 11:18:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ORdPIyaC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728403AbgFZLSq (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 26 Jun 2020 07:18:46 -0400
Received: from mail-eopbgr80059.outbound.protection.outlook.com ([40.107.8.59]:10062
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728380AbgFZLSp (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 26 Jun 2020 07:18:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z+4wRQI3E8Jvia5xa6KlYOtQnfnAipEJKA0ZQhamJF3Rb0gkEQei6xzrZ8w0gOblVD/cW8gFrx7/DkalUZF90lvBI/2zcc+64C/aPPshQfLOqb1sjYVtPIv5G9X+FH1qEyMvhv6J39w79eLIRB/296TQEJs+VqEbkX4ljIXwYTeI0ZNhPIjpTtzhldZHoCOajtEXZRBgz4yLM97cYVJbZwVYG8llVCzqSNfqa3OI3678VFFaaXN5SzutsYZquJ4oI7gC5sminMxb6pcumwfhTQNi11QH/R7HYt4K+mYsG9eZERqDm2WEFp6rl1LxZw815BaAbdhev/fEmqu0vfUjuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iBrJXOmFsrVsXY6D5uSuDhc+JYskV+BgBgoXOkXvLns=;
 b=P5DT/CVTecTNtr0xeFziW6w14GY+FAKECVGmG+jgW2Jht/tAzUW4bYAJJFYZ4pkq+1BpqElKIVpNCh+E3xJG0/US7CWCgPbja8eE205ahZMZdkeOOvCIK/GVr1FYmnk+7PIZD5Gsyp5e9UeAC5BEP4y0COB7w9WFVydqyyXskMddeP8ZA1jApux68WGrN5qBJaKfyaSBwP7KNGaHj+caPTYElzSLxFhIkGjtPOGj22EkUsITg0zbu4zh3E8mz55sMihPbapVfAcSpHPKxD/xc54+umv1If1q9YuJjHXDvBJIwlXHMSTcKIMZJId0kbYCiiUaeGEb88blJdtvgOSuzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iBrJXOmFsrVsXY6D5uSuDhc+JYskV+BgBgoXOkXvLns=;
 b=ORdPIyaC7BB2SGUP8pHNB6ggmQOfXS/e1kgcBCybQeOE/Xh2gWUgeZdrL0/7FCqTaiEqihgTT351+OXc+4J3dQuFgDw9tCGaArEFhe8l39X0qtuiK50nuPTjlpqjQVulrDtINuaD9cWfvr5s7VyoG2gzS2ta3g4tNP3BquCWlmo=
Received: from VI1PR04MB4800.eurprd04.prod.outlook.com (2603:10a6:803:5a::12)
 by VI1PR04MB4335.eurprd04.prod.outlook.com (2603:10a6:803:4e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.23; Fri, 26 Jun
 2020 11:18:42 +0000
Received: from VI1PR04MB4800.eurprd04.prod.outlook.com
 ([fe80::1c58:aed8:bd10:6c9e]) by VI1PR04MB4800.eurprd04.prod.outlook.com
 ([fe80::1c58:aed8:bd10:6c9e%3]) with mapi id 15.20.3131.021; Fri, 26 Jun 2020
 11:18:42 +0000
From:   "Vabhav Sharma (OSS)" <vabhav.sharma@oss.nxp.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        "Vabhav Sharma (OSS)" <vabhav.sharma@oss.nxp.com>
CC:     "jslaby@suse.com" <jslaby@suse.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Varun Sethi <V.Sethi@nxp.com>
Subject: RE: [PATCH] tty: serial: fsl_lpuart: minimum baud rate support
Thread-Topic: [PATCH] tty: serial: fsl_lpuart: minimum baud rate support
Thread-Index: AQHWS6uMK90atu7fKkiLW+wqBK+01g==
Date:   Fri, 26 Jun 2020 11:18:42 +0000
Message-ID: <VI1PR04MB48009D6DE5C96EFB7FF559F7F3930@VI1PR04MB4800.eurprd04.prod.outlook.com>
References: <1593078545-11272-1-git-send-email-vabhav.sharma@oss.nxp.com>
 <20200625100410.GA3327034@kroah.com>
 <VI1PR04MB4800F6C28186CE70F3E1D197F3920@VI1PR04MB4800.eurprd04.prod.outlook.com>
 <20200625105256.GA3335222@kroah.com>
In-Reply-To: <20200625105256.GA3335222@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [103.49.154.18]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b73f394d-f30f-4d5d-bd18-08d819c2aef4
x-ms-traffictypediagnostic: VI1PR04MB4335:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB43357E2CEDE2F6C5366F5B87B2930@VI1PR04MB4335.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0446F0FCE1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gjcIpodNWLqOrfjGnBGC0OvKw5trJdej3MQlt3XlcOW8dWAaEFEGBA9gA7u2j7uR1l8UIcUrXX/BsN26DfGKI/3kadW4V5geQoz03mKsz+0QC9EFhKbf640GWtCaZnu1jXdaZXL2V4qd9vxfxDTgi9HVFJbZApRadyjrqhgNvFtaqRkv9UBsKqgypH/aTPOUysta/iQa0yA4lEa+0i95T+/krJ06WRJINqMMQqsDTAMMaV7QHVgA1mANYjK8zu14wz1OAtnVGBUR0UfgOCqYQmgIsMuztvAaqkJrK3sLc4mI5fjS0W5ljh/Eo5gHq6RXohsHGEcIS+cFPnSb7pl7CQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4800.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(136003)(396003)(366004)(376002)(39860400002)(66946007)(8676002)(53546011)(66556008)(71200400001)(66446008)(66476007)(316002)(86362001)(64756008)(54906003)(4326008)(83380400001)(2906002)(26005)(8936002)(7696005)(33656002)(186003)(9686003)(110136005)(6506007)(478600001)(5660300002)(55016002)(52536014)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 2CIHuDmVjW5YjEaB5vCLsY+0fcgO40QgLYC2UcH8QP8SgnDo92/hlhhiT8ptB2/A2emJo//JPqky93yxp/VKm30ZtTXD40x515tZiwE6+vfxS4Cziapv6YxvxT5BDZENCFzcmd6esxTYYbbAQbaro+ChCZmhSFC9asf1HYvCD09a51UE+LJOcbHQXx3geC1TONLQcKfK8Y84OMcEfZgay2/xz4aoWDN0geGFMup4nQBAkOUBi/GXLLtXxb4nqUvrsFHLtwySIaZgP6Ng7ZmWWRDFIFgvZZwnzccYqSZxcaMiakI0roZnhfKkGg+b9TxR0ZW7wUqRVb21BFQU56EROYOuZOaCve0GPzQG9mpQLQL0CJmXpScKktQU7kGM2W0L0wCnL84gk3shPqKMULW5DKlNrBACH97hOOA/hTIVqw3BWQRiipedf6KgHKELK2vD45TSnW2RPCKDSpka29+RGxNj3rBMZnWXHNLpCLmc23E=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4800.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b73f394d-f30f-4d5d-bd18-08d819c2aef4
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2020 11:18:42.1740
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O66TgWHhVTpYxkp69xKpQfa3+cRktqVL9f9MpnEbBIFvOAn1onXIPa/+saqEYkxIJzJA52Y0oNr2mKaD9C5rtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4335
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org



> -----Original Message-----
> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: Thursday, June 25, 2020 4:23 PM
> To: Vabhav Sharma (OSS) <vabhav.sharma@oss.nxp.com>
> Cc: jslaby@suse.com; linux-serial@vger.kernel.org; linux-
> kernel@vger.kernel.org; Varun Sethi <V.Sethi@nxp.com>
> Subject: Re: [PATCH] tty: serial: fsl_lpuart: minimum baud rate support
>=20
> On Thu, Jun 25, 2020 at 10:12:54AM +0000, Vabhav Sharma (OSS) wrote:
> >
> >
> > > -----Original Message-----
> > > From: Greg KH <gregkh@linuxfoundation.org>
> > > Sent: Thursday, June 25, 2020 3:34 PM
> > > To: Vabhav Sharma (OSS) <vabhav.sharma@oss.nxp.com>
> > > Cc: jslaby@suse.com; linux-serial@vger.kernel.org; linux-
> > > kernel@vger.kernel.org; Varun Sethi <V.Sethi@nxp.com>; Vabhav
> Sharma
> > > <vabhav.sharma@nxp.com>
> > > Subject: Re: [PATCH] tty: serial: fsl_lpuart: minimum baud rate
> > > support
> > >
> > > On Thu, Jun 25, 2020 at 03:19:05PM +0530, Vabhav Sharma wrote:
> > > > From: Vabhav Sharma <vabhav.sharma@nxp.com>
> > > >
> > > > The formula for the baud rate is
> > > > baud rate =3D "baud clock / ((OSR+1) =D7 SBR)
> > > >
> > > > Algorithm used in function lpuart32_serial_setbrg() only changes
> > > > the SBR. Even with maxmum value put in, OSR stays at 0x7 and the
> > > > lowest baud rate would be ~ 2600 bps
> > > >
> > > > Update the algorithm to allow driver operation at 1200,2400 or
> > > > 600 bps
> > > >
> > > > Signed-off-by: Vabhav Sharma <vabhav.sharma@nxp.com>
> > > > ---
> > > >  drivers/tty/serial/fsl_lpuart.c | 4 ++++
> > > >  1 file changed, 4 insertions(+)
> > > >
> > > > diff --git a/drivers/tty/serial/fsl_lpuart.c
> > > > b/drivers/tty/serial/fsl_lpuart.c index 90298c4..0fd0fa5f 100644
> > > > --- a/drivers/tty/serial/fsl_lpuart.c
> > > > +++ b/drivers/tty/serial/fsl_lpuart.c
> > > > @@ -1925,6 +1925,10 @@ static void __lpuart32_serial_setbrg(struct
> > > uart_port *port,
> > > >  			tmp_sbr++;
> > > >  		}
> > > >
> > > > +		if (tmp_sbr > UARTBAUD_SBR_MASK) {
> > > > +			continue;
> > > > +		}
> > >
> > > Always use scripts/checkpatch.pl on your patches so you do not get
> > > grumpy emails from maintainers telling you to use
> > > scripts/checkpatch.pl on your patches...
> > Indeed, I run the script before sending patch ./scripts/checkpatch.pl
> > 0001-tty-serial-fsl_lpuart-minimum-baud-rate-support.patch
> > total: 0 errors, 0 warnings, 10 lines checked
> >
> > 0001-tty-serial-fsl_lpuart-minimum-baud-rate-support.patch has no
> obvious style problems and is ready for submission.
>=20
> Ok, then something is wrong as there is obviously a coding style issue wi=
th
> your submission, as you can see with a manual review of it, right?
>=20
> greg k-h
I see, Unnecessary usage of brace for single statement.
Thank you
