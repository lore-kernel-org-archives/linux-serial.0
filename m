Return-Path: <SRS0=BL42=AG=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34B80C433E0
	for <linux-serial@archiver.kernel.org>; Thu, 25 Jun 2020 10:12:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09D722076E
	for <linux-serial@archiver.kernel.org>; Thu, 25 Jun 2020 10:12:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Sby9t5rj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389777AbgFYKM6 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 25 Jun 2020 06:12:58 -0400
Received: from mail-eopbgr80082.outbound.protection.outlook.com ([40.107.8.82]:34166
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389773AbgFYKM5 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 25 Jun 2020 06:12:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OxyjOHwvh0fnLT62F3M3DF6kIslzMPyYELwikCLI3PUjZel4NqD1QRRwsTFiW3LcJPnWEezq+AOmh25hSd63iAB8wBdHgrpm/TNLUB6Bl2q69EJ3EpyjyN7w+QsYof3uTpMLC9plHVb70hZo65hJrRNa5s7oQNgDT5kqTYBJvU/XaPloaq1aL6oohaWpKIW6sIDW6FFB2yAO1by989cwfztciGSh9TGXVpeHGCfkaNDqlpw3f7oM9O05ObIt9Hu+lfKrwdB9yGro2OqAV5xx4fL6M8xCfBFHfU6q8yO+yceaWxeD1w5cHweAkOxM1gpvdqFEOYKIs4UepTY7D71FaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WM8BxBjnJEglo55ZCaAgQ96CYpDBqGjuiGNl8/wnhhA=;
 b=JoWpJiQU4SWcLw1NEjs5tJfGEZvJNpWYo/7m968AXQiJHPA6l4RVBmJ8LXYSXkgCp9KA2pGSkaMFE3PB01AiejE6jWMDSudxFCR9M4YWz85FuBGIdi8KmKCAJzgAxJi0sD80intBIooG/RSxe2m68mrqmZpbf2mug6A4xfoKENmYi7ZAj4ZW7fiU0a5MgD9bSECGmCrF6AbrgqXnMmiMbXm2dXWOGm5Jpergh8LVvUg+/JkODVNQJDBfCon3reFSXeRNAk9DZk2xuhJ+qztGc17xZ6Gbg11+Nh7Eg66ok8/Lw8CiRxTSgGUeU3xenkFJCgl35hs77Toeyhgpq+wiwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WM8BxBjnJEglo55ZCaAgQ96CYpDBqGjuiGNl8/wnhhA=;
 b=Sby9t5rjRV8m1aFXJvYbYgLG4qpp6cPF23R1LAtCYmBVZYZdgOkuVu1C7Y86LslBMCC4d2x3DpOeKvmSESanX7Jz9U3hrpqkFXstum0bcK9qhkzeYadSoHZR14qr+Cp4X/jIwc95fN+CxBJppkffnIJDYH6lWvEzD//E99WZJT4=
Received: from VI1PR04MB4800.eurprd04.prod.outlook.com (2603:10a6:803:5a::12)
 by VI1PR0402MB3696.eurprd04.prod.outlook.com (2603:10a6:803:1e::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.20; Thu, 25 Jun
 2020 10:12:54 +0000
Received: from VI1PR04MB4800.eurprd04.prod.outlook.com
 ([fe80::1c58:aed8:bd10:6c9e]) by VI1PR04MB4800.eurprd04.prod.outlook.com
 ([fe80::1c58:aed8:bd10:6c9e%3]) with mapi id 15.20.3131.021; Thu, 25 Jun 2020
 10:12:54 +0000
From:   "Vabhav Sharma (OSS)" <vabhav.sharma@oss.nxp.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        "Vabhav Sharma (OSS)" <vabhav.sharma@oss.nxp.com>
CC:     "jslaby@suse.com" <jslaby@suse.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Varun Sethi <V.Sethi@nxp.com>
Subject: RE: [PATCH] tty: serial: fsl_lpuart: minimum baud rate support
Thread-Topic: [PATCH] tty: serial: fsl_lpuart: minimum baud rate support
Thread-Index: AQHWStkwXdsTbHthxU26kv5p1F4BKA==
Date:   Thu, 25 Jun 2020 10:12:54 +0000
Message-ID: <VI1PR04MB4800F6C28186CE70F3E1D197F3920@VI1PR04MB4800.eurprd04.prod.outlook.com>
References: <1593078545-11272-1-git-send-email-vabhav.sharma@oss.nxp.com>
 <20200625100410.GA3327034@kroah.com>
In-Reply-To: <20200625100410.GA3327034@kroah.com>
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
x-ms-office365-filtering-correlation-id: ecdfde6f-e8ad-4e0a-dcb4-08d818f0538a
x-ms-traffictypediagnostic: VI1PR0402MB3696:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0402MB36969B24F5B37C3A67864C7DB2920@VI1PR0402MB3696.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0445A82F82
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: T/vVwkd8C2WLltNqXokvVd5Z3+NdjU2W/GlWKKYCXdFPYgl3boc0gH4eX456+s/8Efi5gtdKIuMbo3IcKng+5rlCu25YliRiiW4VTTGofLIyyvgqdt7LNUC0MVDwjPzbzfN0qHp8YoCAWNRHp1F9Lt1uIDsR9geFXv6pYKBv4aL64U/RsQbytiG5CFA7rqnT1a1iRXdBcMXgqJKkyuhS7D0xQQm9gIGFeFARhnns+GQ2B2n+A76IllDsP5eh0fVOSgjV/I73Ar9XJ7NOP3lggZzE/0qXGebHuivFBaVX3dBwaekgdYvt2q0bV43zdPle3mBN+HK/anKloYM2f3HDyQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4800.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(376002)(346002)(366004)(39860400002)(136003)(6506007)(8676002)(86362001)(52536014)(186003)(2906002)(8936002)(26005)(9686003)(54906003)(55016002)(7696005)(316002)(110136005)(4326008)(478600001)(66446008)(5660300002)(33656002)(53546011)(76116006)(66946007)(71200400001)(66556008)(66476007)(83380400001)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: KTFFpK0mEp1YWaIi4kJxgFz0cVXyQYZX15t2BKp1zjgbZej9AnbGmIbrWKB60D68MhbDsLHN/QTsLoTzbD0OURLgtJZ7kNX9tEwUSR+tKy3eMGw9q/75i3YOCTtGR5O8A2m403kMbZM8r+5kM/yrcMDa5qDDi3blv/jZypbMyaGGv7uDVgd5FCP6d4IKanx5859TWYCSlj5TftVeub3HrCriQSCgql5Vl27CTTYKZD9f5GMqp9gYXOnlzwycpa5NrQfrZ1zjZOzRcdlnkdBS5TXwQQ2HR6iSAecga9DNsz/bWHZjijRrdf6RiEj9R+I7EWiA9QjO2qKlJFOVtsEUYHc9OdhbqXlZfkl0FsOocaXQYOtYSplmfiwFAYU3qXP+WEQP42BG1FEHpxQ4T1TqukxrXd4aUKH/9lzrTGGctfeLGz1Ds9I3ydq42dZsbqRsZFXlA70nj43jgAyWrZ2iJMI0XscVx5h9HeEOG69a3+x0ZicsLRc0pgUuEOQVgTb2
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4800.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecdfde6f-e8ad-4e0a-dcb4-08d818f0538a
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2020 10:12:54.4133
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nSUVaxN6pmoKg2aawEanKwyjH2sS6WHBNrIhdjUpF73wUVWygCFHv8mm00IQh8lr/iRRo4Y6dUzxHw3bksWuOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3696
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org



> -----Original Message-----
> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: Thursday, June 25, 2020 3:34 PM
> To: Vabhav Sharma (OSS) <vabhav.sharma@oss.nxp.com>
> Cc: jslaby@suse.com; linux-serial@vger.kernel.org; linux-
> kernel@vger.kernel.org; Varun Sethi <V.Sethi@nxp.com>; Vabhav Sharma
> <vabhav.sharma@nxp.com>
> Subject: Re: [PATCH] tty: serial: fsl_lpuart: minimum baud rate support
>=20
> On Thu, Jun 25, 2020 at 03:19:05PM +0530, Vabhav Sharma wrote:
> > From: Vabhav Sharma <vabhav.sharma@nxp.com>
> >
> > The formula for the baud rate is
> > baud rate =3D "baud clock / ((OSR+1) =D7 SBR)
> >
> > Algorithm used in function lpuart32_serial_setbrg() only changes the
> > SBR. Even with maxmum value put in, OSR stays at 0x7 and the lowest
> > baud rate would be ~ 2600 bps
> >
> > Update the algorithm to allow driver operation at 1200,2400 or
> > 600 bps
> >
> > Signed-off-by: Vabhav Sharma <vabhav.sharma@nxp.com>
> > ---
> >  drivers/tty/serial/fsl_lpuart.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/drivers/tty/serial/fsl_lpuart.c
> > b/drivers/tty/serial/fsl_lpuart.c index 90298c4..0fd0fa5f 100644
> > --- a/drivers/tty/serial/fsl_lpuart.c
> > +++ b/drivers/tty/serial/fsl_lpuart.c
> > @@ -1925,6 +1925,10 @@ static void __lpuart32_serial_setbrg(struct
> uart_port *port,
> >  			tmp_sbr++;
> >  		}
> >
> > +		if (tmp_sbr > UARTBAUD_SBR_MASK) {
> > +			continue;
> > +		}
>=20
> Always use scripts/checkpatch.pl on your patches so you do not get grumpy
> emails from maintainers telling you to use scripts/checkpatch.pl on your
> patches...
Indeed, I run the script before sending patch
./scripts/checkpatch.pl 0001-tty-serial-fsl_lpuart-minimum-baud-rate-suppor=
t.patch
total: 0 errors, 0 warnings, 10 lines checked

0001-tty-serial-fsl_lpuart-minimum-baud-rate-support.patch has no obvious s=
tyle problems and is ready for submission.
