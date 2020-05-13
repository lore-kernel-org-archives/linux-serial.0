Return-Path: <SRS0=7vif=63=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75C96CA90AF
	for <linux-serial@archiver.kernel.org>; Wed, 13 May 2020 08:14:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 452ED20673
	for <linux-serial@archiver.kernel.org>; Wed, 13 May 2020 08:14:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=sifive.com header.i=@sifive.com header.b="czYOe0fH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729414AbgEMIOw (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 13 May 2020 04:14:52 -0400
Received: from mail-dm6nam12on2076.outbound.protection.outlook.com ([40.107.243.76]:6123
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729106AbgEMIOv (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 13 May 2020 04:14:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KjllQCkzPNV2aQ2/odEvUh5qC41WgnfkRHAIOWZNes5UQrybFuOO84rrNWnKqi3koQnNlWOt9PhKvhuJ1bnyU0Y0H2oupPCLQSUW5yAS2HI+qnHAsDU9M64lwyPS0YfuJ0YoiuNdG/YYtSIikpTMZgZt8X00yR1IOT0xOgo5Y/Gs6hMzcNeos2QjjiUB5cAYuREHBgshiHtOX6cPCl9a8apbWcSly/Y+VAZIt0D+B8CdzZ/Y4oEcuR36loeO7LOf+F+6xQJOfGRqYAktrRtye3D/pPBK9iVHEDihlVV6CeRW0N2DT9tVYoxGPiGZufgiHuwojVEIvPPbyNIrhfam0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WOzs+h1e7R6ni1UU0+56qupOGZmo5U07dQKKWa1XxJ8=;
 b=c86jelvbjFrJD/diY5XEIjc6d7mcqvRrgI23empdLEcJVaiwV+G2pujNwsukfpnrq44L7d4IjxI4klWbmJha6SmQxtiG5jfcZgNLroSgOErkM8dOclATENKK+DUTOnGkeBCBUQifPC/6jFHEutfDWUd3+iQG+x4iHa/+G6MuTkJ4cn8iswLF9oZiGPBg+woT4SBnnC6he0iFsogbw4SiEg/XIUoxti4GPnod+8JjxacICRAHuGVEOh6Kuv3JfJuUZxV0JGQHvFcB6m9d/J6w2KeZ3Xgm4jBUdDeVsFYedAXneHGanJ30GXrN05kNcS8il4VQf+8MxAvhSbZEpw1g2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sifive.com; dmarc=pass action=none header.from=sifive.com;
 dkim=pass header.d=sifive.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WOzs+h1e7R6ni1UU0+56qupOGZmo5U07dQKKWa1XxJ8=;
 b=czYOe0fHDwjLFQuZ1qxJqsfPtBCmt3wqOm7II9nrq5h2nTkERpLguIt/csYiooWPaicWLYDrY+g57ypMfZDqJCQIlh+JdVU24TOibDUSmDV94IMGPiGeZohp77LQBhUqQvTx0Dahy5Lbv7icg9hc2ClnM7QExGQuOD7QA9XaBdE=
Received: from BYAPR13MB2614.namprd13.prod.outlook.com (2603:10b6:a03:b4::12)
 by BYAPR13MB2582.namprd13.prod.outlook.com (2603:10b6:a03:b2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.13; Wed, 13 May
 2020 08:14:47 +0000
Received: from BYAPR13MB2614.namprd13.prod.outlook.com
 ([fe80::c0fc:30a3:5e5f:c2b6]) by BYAPR13MB2614.namprd13.prod.outlook.com
 ([fe80::c0fc:30a3:5e5f:c2b6%7]) with mapi id 15.20.3000.013; Wed, 13 May 2020
 08:14:47 +0000
From:   Sagar Kadam <sagar.kadam@sifive.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        Palmer Dabbelt <palmer@dabbelt.com>
CC:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        Atish Patra <Atish.Patra@wdc.com>,
        Anup Patel <Anup.Patel@wdc.com>
Subject: RE: [PATCH v1 1/1] tty: serial: add missing spin_lock_init for SiFive
 serial console
Thread-Topic: [PATCH v1 1/1] tty: serial: add missing spin_lock_init for
 SiFive serial console
Thread-Index: AQHWJewOGC/Eei+2vk+umicyZNhzfailFmOAgACF5wCAABQpMA==
Date:   Wed, 13 May 2020 08:14:47 +0000
Message-ID: <BYAPR13MB261414A78707F1020FC529B599BF0@BYAPR13MB2614.namprd13.prod.outlook.com>
References: <1589019852-21505-2-git-send-email-sagar.kadam@sifive.com>
 <mhng-b2e9c16c-ee06-4c78-800d-a7725d6c74a3@palmerdabbelt-glaptop1>
 <20200513065938.GA764901@kroah.com>
In-Reply-To: <20200513065938.GA764901@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=sifive.com;
x-originating-ip: [116.74.146.90]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 68c5cccf-2acb-4d23-3057-08d7f715b39c
x-ms-traffictypediagnostic: BYAPR13MB2582:
x-ld-processed: 22f88e9d-ae0d-4ed9-b984-cdc9be1529f1,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR13MB25822069D0290E9221B9224E99BF0@BYAPR13MB2582.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0402872DA1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /J9dm8lKwM64k4m9ZGTMbKYStLJv0UYn3V/u2RbnZA7MtrPqQkCTp5SJpH2vmabOxFibKfDw92GwQEdn77Ir2N39bqYbPGUXyKf2/9d5PR/JIwBUpOmH95IR7R9oV1vAAzAJAXkGTgTjRExA+DxCRXg+bzWnShwRIDEHad7HELJcDzfUFWZz/HTnpg8iBow4JUKBaRwsyEgVTxeZOP5twi0+VNQLlcpQ9qNw9Y+bIX6BZsTQRv+AfN4xhoJka3XoZt2P5MrTqE4Hm+cBBYr5t2xv5rVf53kRpuXqqNKdpACBhIM7Ot1d5AuTPUFIj5rGgzMXw3a3YP/KIG5xFqajVDYjDbyedjUTaaaXZVW12D1YFuJSrrWJu/Ss6MzDANMdhRoaJ2wnxh1/feOL2zC/0h7dYK8i0m+8fZPTWb45OM3DY2zk9msFfYvlDGGcF1SoAMHfGGgFUoIcxBDFbzPpmDeYq+GrPqgKS2Rn5QicOfdLS/eNQWz53vK/5TqV62vccmurGOzyRj37P0TBobqsZ+JMEmp6uParK6HFlo2tOsryhHHwz8PBDoASIDM2ZeE+tgBUPzrb3zc1z2uBov+dYucJflyBlgrU2kE6tjnHieI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR13MB2614.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(6029001)(396003)(376002)(136003)(346002)(39850400004)(366004)(33430700001)(4326008)(66946007)(66446008)(76116006)(66476007)(26005)(8676002)(64756008)(9686003)(54906003)(186003)(110136005)(66556008)(316002)(8936002)(71200400001)(55016002)(33656002)(2906002)(5660300002)(86362001)(55236004)(6506007)(7696005)(478600001)(53546011)(44832011)(966005)(33440700001)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: FvYIdnZUvMhh+M7YFv3I8x0Fhe9agQYQP6yFGq/vvCI4BhL24rVJF3Cbkm+ev30Q3NYmzrk1H3D8Ilsc8b44WqH4QCJ+WxxrH7nCiGgvuezzrfeW/3pN/6osIyuzVI0HlXLa05MhIsFKQYyefb6sEaOJwgyRfnLuBh9TqI7hgGnt3Fuzd1plA9qdOJiEJ028LOQTu9ynXU1hdKh+dY0oV9rH2TWx4Cvc6XfOG6qx/F9yR+KbLasY47/BJHKY3UNntSvEZo9Inq1PV0o4AseX6+rfy4UrpG8stRwxTlRWUe1nCX/IwuRCowsMHyecwzTnLXqoP+0SIjAvFgtpyJzHLRpNEyrLWO0l4SjSqrYTuZaiszcwyG4ogJsUKC+0EDB5zaxYZtPZHfI++rcC5QEj9Y1/khJ515lwn6bU6njQg7AATfCsoHAkFkX4U+1TshkAyVPbL+7Fo0JYj8UkpZ2YGeiS/chhe8weNuD2paXnREk=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sifive.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68c5cccf-2acb-4d23-3057-08d7f715b39c
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2020 08:14:47.4986
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 22f88e9d-ae0d-4ed9-b984-cdc9be1529f1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DPK4THBJdpYxHbCOHD5ho1OqWHevqymxkhRFV5HZllqQFxXfnsn7mVMOFOe0E9Tp2qHyh0PkC3e6M6jL6TQ09Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR13MB2582
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hello Greg and Palmer,

> -----Original Message-----
> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: Wednesday, May 13, 2020 12:30 PM
> To: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Sagar Kadam <sagar.kadam@sifive.com>; linux-serial@vger.kernel.org;
> linux-riscv@lists.infradead.org; linux-kernel@vger.kernel.org; Paul Walms=
ley
> <paul.walmsley@sifive.com>; aou@eecs.berkeley.edu; Atish Patra
> <Atish.Patra@wdc.com>; Anup Patel <Anup.Patel@wdc.com>
> Subject: Re: [PATCH v1 1/1] tty: serial: add missing spin_lock_init for S=
iFive
> serial console
>=20
> [External Email] Do not click links or attachments unless you recognize t=
he
> sender and know the content is safe
>=20
> On Tue, May 12, 2020 at 04:00:23PM -0700, Palmer Dabbelt wrote:
> > On Sat, 09 May 2020 03:24:12 PDT (-0700), sagar.kadam@sifive.com wrote:
> > > An uninitialised spin lock for sifive serial console raises a bad
> > > magic spin_lock error as reported and discussed here [1].
> > > Initialising the spin lock resolves the issue.
> > >
> > > The fix is tested on HiFive Unleashed A00 board with Linux 5.7-rc4
> > > and OpenSBI v0.7
> > >
> > > [1]
> > > https://lore.kernel.org/linux-riscv/b9fe49483a903f404e7acc15a6efbef7
> > > 56db28ae.camel@wdc.com
> > >
> > > Fixes: 45c054d0815b ("tty: serial: add driver for the SiFive UART")
> > > Reported-by: Atish Patra <Atish.Patra@wdc.com>
> > > Signed-off-by: Sagar Shrikant Kadam <sagar.kadam@sifive.com>
> > > ---
> > >  drivers/tty/serial/sifive.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/drivers/tty/serial/sifive.c
> > > b/drivers/tty/serial/sifive.c index 13eadcb..0b5110d 100644
> > > --- a/drivers/tty/serial/sifive.c
> > > +++ b/drivers/tty/serial/sifive.c
> > > @@ -883,6 +883,7 @@ console_initcall(sifive_console_init);
> > >
> > >  static void __ssp_add_console_port(struct sifive_serial_port *ssp)
> > > {
> > > +   spin_lock_init(&ssp->port.lock);
> > >     sifive_serial_console_ports[ssp->port.line] =3D ssp;  }
> >
> > Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
> > Acked-by: Palmer Dabbelt <palmerdabbelt@google.com>
> >

Thanks for the review.

> > I'm assuming it's going in through Greg's tree.
>=20
> Sure, I'll be glad to take it.
>=20

Thanks for accepting it within your tree.

BR,
Sagar Kadam

> greg k-h
