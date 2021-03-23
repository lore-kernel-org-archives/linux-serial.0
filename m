Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4A3DC433C1
	for <linux-serial@archiver.kernel.org>; Tue, 23 Mar 2021 19:26:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56395619C9
	for <linux-serial@archiver.kernel.org>; Tue, 23 Mar 2021 19:26:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231985AbhCWT0P (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 23 Mar 2021 15:26:15 -0400
Received: from mail-eopbgr1320042.outbound.protection.outlook.com ([40.107.132.42]:20192
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233018AbhCWT0C (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 23 Mar 2021 15:26:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c4gV9Pb1pJX8uHtliV4poFGqtkz62RcwJhU599e9k2mKuPtQGiD+Srj88i7H3P/UI/YUYToUPoZO3pkfQpr5gsPGli2RVZrIokARmYmI+InJhOIBV9cgQ70y07m5OuMtTrhxuL6jyFCZr/cxtucmgWtw44ynRX6rqBxULuIuNp6MuFYgYu4MDBf6X9MgSL+n+bWUiRdY+ccV9nrwThXy6dmajBOs6fdePdjz3/EtxhS7v8/oa3iXyOpROIODoEep3QT0dUeyiVV/frr02fSH9GQyWDBDgyQB0/ADYLMqmanjr3X/vVfQFGfWCbHK48zl6VYEN5N6I7EZUgBEM4O+0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iGvvmYF0XkcKzR32aEIbOdz2QTUOC8Vrpg6UvFAtYuw=;
 b=PoTn6nCjQM7gTB+Lj0SQYWXHLABNxNaIExFBprHyK0b1PCNnjGueYMI6vxVyC1rhz2CvEPRTkuWbjUneAaSmP8c27VJ6EM1Q00TwCBQcNkWVDd4znPSW86T3ZYs4XP9IhHazKirz0cyNrmf6GWp/KX/IeVFE90Bmg+jRRiNpS2oYRjy6vaRcqLfirff9p7rQKRs7scWtOF8IuEC7ttk+qj2RTI8iYnJxCoXfFpUxW6RoOdPNt+EQ3NOLXSHNSU2VUkGX12KQ/OYGlQTDvTCW7AG2/E4TrE4QMbf+HfJH3AL3hsi4NPoHeuSc9P2ue9pnoVMJdoCGVOc+oONp+S07Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cortina-access.com; dmarc=pass action=none
 header.from=cortina-access.com; dkim=pass header.d=cortina-access.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CortinaAccess.onmicrosoft.com; s=selector2-CortinaAccess-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iGvvmYF0XkcKzR32aEIbOdz2QTUOC8Vrpg6UvFAtYuw=;
 b=fhmmUxl7z12g3/CgA6tapsbMwylwrmd97AEs2WzUCBIlh4pU2DyDmtcdxTgLQIbsqJMsOK/CHb68GDPiobpBj0CF2WIXb9+j5EN5be8q/vWr2A2b6Kw9y1vybav7mHEk+Uou35pITk9PNDPDqfgfzQVV4mLIGMHLonU99MtcgpI=
Received: from PS2PR01MB2504.apcprd01.prod.exchangelabs.com
 (2603:1096:300:3e::11) by PSAPR01MB4007.apcprd01.prod.exchangelabs.com
 (2603:1096:301:21::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Tue, 23 Mar
 2021 19:25:58 +0000
Received: from PS2PR01MB2504.apcprd01.prod.exchangelabs.com
 ([fe80::7937:3bdb:b574:e31e]) by PS2PR01MB2504.apcprd01.prod.exchangelabs.com
 ([fe80::7937:3bdb:b574:e31e%6]) with mapi id 15.20.3955.027; Tue, 23 Mar 2021
 19:25:58 +0000
From:   Alex Nemirovsky <Alex.Nemirovsky@cortina-access.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Jiri Slaby <jirislaby@kernel.org>,
        Jason Li <jason.li@cortina-access.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
Subject: Re: [PATCH 1/3] tty: serial: Add UART driver for Cortina-Access
 platform
Thread-Topic: [PATCH 1/3] tty: serial: Add UART driver for Cortina-Access
 platform
Thread-Index: AQHXH8ZG8JGd0lZ2t0+mKnLpM4QhKKqR9SaA
Date:   Tue, 23 Mar 2021 19:25:58 +0000
Message-ID: <E0630C1D-AC64-4DB5-9467-EA2F4590EB26@cortina-access.com>
References: <1613702532-5096-1-git-send-email-alex.nemirovsky@cortina-access.com>
 <YFmzuEfpN7zzKel3@kroah.com>
In-Reply-To: <YFmzuEfpN7zzKel3@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=cortina-access.com;
x-originating-ip: [70.58.207.205]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 79ad1983-4964-4a14-bea3-08d8ee317cc8
x-ms-traffictypediagnostic: PSAPR01MB4007:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PSAPR01MB4007ABAB84445D80AA0E0BA2CB649@PSAPR01MB4007.apcprd01.prod.exchangelabs.com>
x-ld-processed: 0694623c-6669-497c-89c3-3a32a9934313,ExtAddr
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iLYXwdzlNTgh2imKUnYbVyi5Eqp2NMtikLq1FT5zGbMOB98ywTWEMr0v7N5upC5hOjZ97JjLJ2tdz0n26Wy0YXy36O+Etiec0HvmAG3YZs1VPrkNfPq25o1a5gdeE39aP100kFW68K0ws57MWmQnPdEER0bIZpFbKbtNyywifVdqEJ3wTZ/zudaV00ySJBLerurxovPDHVGwoBGX3mVUnP/XC0ZlvzhIU3OVXG7opTjtYdkh2cH2Lf/z0GC9VR+OctuopK7IB1zOn4bLdvXu5E5N8gL6tOZp9Akcsu2zMGwSUvUA4yPh01iuGIGD8G/iRdPGdrO1ywXTYTzd7/acYbkxcz3aFF3l3YvflmG3xKOCNMfpk8mYr3JsBhjlKB0bKw7Z8WS+vRZEFsPepwquLGFRR8RgqijYpAxK5XF+gy3O+FXv3w4swuEU3ZrBSQCEihTXr47Dtnu01c+re8V6gcDSUWCNsisZcsphkhv0vv5N6lBbPBCxDLGkMDobaNU1uT9Dsx7h2xzLXsx6XEwG1OEAj6HzMIXTTm4zSSUoY1kb8E/x5oGnwE/9RALxNuDIps7clOlC62DM2quSMKHKtIt5xhPvrtY8gTb1tc5YIqKKaPpvY6gnlYTGZhcs0bI7+FKDUGAdr8xIGaL+tkqo6Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PS2PR01MB2504.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(39840400004)(376002)(366004)(396003)(2906002)(6486002)(53546011)(83380400001)(86362001)(6512007)(36756003)(6506007)(64756008)(66446008)(66556008)(76116006)(91956017)(66476007)(66946007)(8676002)(186003)(316002)(71200400001)(26005)(478600001)(54906003)(4326008)(8936002)(38100700001)(33656002)(2616005)(5660300002)(6916009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?kRLx0hyZl/p8xM+3BaMR9kKvsoLIAKZL9TCQ1ipOz2GeTolYtH8HTfapbP0j?=
 =?us-ascii?Q?nnw35+kDhevaRXNCo8cWH3RGIDtA5Pc+YohaAvdNjLsB3i0MNbD9jKmDRsHC?=
 =?us-ascii?Q?aFphJwoiL92LL90TBfDp2UfD5fLIizkDTGnB/PFRzj5MhjJUMsmtJ1q67RAa?=
 =?us-ascii?Q?b24uAkIkeBbhxHvWQTQuoUlbONHcZ4/VQIq6CwLpxrps39LEw7jh8E4E7iZC?=
 =?us-ascii?Q?VSeRudOQjm4x+m2UZ9hsFLrYvHQpahx22zDXpCT3UnJTdwbMMslEAIv8bb7f?=
 =?us-ascii?Q?9ONHRxEL2fAEZBZuo6Eqo5EZB27BPj09lpkJIKwStUPutkTGUpEryL2Cdoeo?=
 =?us-ascii?Q?crUb/leLkSlVvMkQORJmWookxADl4Cs1txqC4pxWZpdWmTb+WF/inufuurnH?=
 =?us-ascii?Q?Y7eXi1ud8nZS/SuKoUFSASYl0WN/RUHsr3MGd1XXNSYCJaElf4CALdqGI35V?=
 =?us-ascii?Q?m74X90dv9xWRz3yVltRZ/osC3SWIWgRvFdaIxOXJaiAYeBiYHHYw2lTXn/Ce?=
 =?us-ascii?Q?X5HxW3rVunt8Hh7WrssJfMj+Zu5F5gbTknv8vrK9wf29+CiXOih4XBTXykDP?=
 =?us-ascii?Q?cm1b1+eEUgXUMWIYrWeaOw46Y5WCH4V6BideNDlfUPmJvT/u5zXCDMv36N/V?=
 =?us-ascii?Q?/NA9NN/vj/xix+rrZ3VJ23pOkonURGhAlx2EqB92mBs7YlHxVcM7eed0+nhs?=
 =?us-ascii?Q?XGcwPuB0sHm37Stl/vahpELDtSDhLm4pEXZr031vLsIE/KirtbQcHKQm9DeM?=
 =?us-ascii?Q?bkvqp3XqcQ6qN3baJX7u2ZDHzYWBohbHadSHEKoNtRAGl0ugRv25TLx/fR9p?=
 =?us-ascii?Q?epYxpMOVzx9K5gbM5uo0FOfo99nvIpYJmxBhZ6At/tF1vY2JjxKwmuMl9shB?=
 =?us-ascii?Q?rRd97b3f/lqvtE4SMjdwcWiPaZFoB87kGaBoPYSd3b04FJkEVa2L+kUc2IMg?=
 =?us-ascii?Q?tgkUbNaXAhWNxH0Ckq2qH2+UsXNqQo3WhWvYHRlBn0aJyUFMzSA4t4a8g9lS?=
 =?us-ascii?Q?BVyXhMr8Sjf0DL+kKQ580/Mn0HCr9/o78srvgFjRfbYZJvojtksjNSTJYk7w?=
 =?us-ascii?Q?q1tfsUroFN1JxtIuz2mN2d7Niv4wfEH81baPU5KdaofUM43CP/zNCEGk+53c?=
 =?us-ascii?Q?+8wWR+nvnKKSoY/aIvVYWg7E3R7yG+BV6Nq8B3UnCe9EQmVY9M32TFFvwxvB?=
 =?us-ascii?Q?3FStv7HjGGrEppOEQ3VY/SpdCKuOMYT44V+NbqAzsOMmKWB+ANyeFCuUHoe6?=
 =?us-ascii?Q?UsERG12cksofwgUcU630I5Us9MEWjj1kvBeWJqQ+hwwh+dEGiOzW9lEkU2EC?=
 =?us-ascii?Q?vpW211eXvm+FQYBsE8bUqiVE?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8FE99533F4580D4E97D727BEF26C709E@apcprd01.prod.exchangelabs.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: CORTINA-ACCESS.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PS2PR01MB2504.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79ad1983-4964-4a14-bea3-08d8ee317cc8
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2021 19:25:58.5153
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0694623c-6669-497c-89c3-3a32a9934313
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BFG9RHbvPEKaRIJN2FVsGF0lSlD4wygx9b0c2auXrTF7VcUCaRChtuE3TFE2USJXH4UDw0TI1jroZ1VJUshNu34Rf0Gw2lOhoxxbbgIAG9ygvGks3EhC54o20vMXOR2S
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR01MB4007
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Greg,

> On Mar 23, 2021, at 2:24 AM, Greg Kroah-Hartman <gregkh@linuxfoundation.o=
rg> wrote:
>=20
> On Thu, Feb 18, 2021 at 06:42:09PM -0800, Alex Nemirovsky wrote:
>> +static struct cortina_uart_port *cortina_uart_ports;
>=20
> Why is this not a per-device pointer?
>=20
>> +static void __exit cortina_uart_exit(void)
>> +{
>> +	platform_driver_unregister(&serial_cortina_driver);
>> +	uart_unregister_driver(&cortina_uart_driver);
>> +	kfree(cortina_uart_ports);
>=20
> Should not need to free this here, it should be tied to the device, not
> the driver.

Would it be possible to provide a reference to an example=20
of a good way to do it.
>=20
>=20
>> +}
>> +
>> +module_init(cortina_uart_init);
>> +module_exit(cortina_uart_exit);
>> +
>> +MODULE_AUTHOR("Cortina-Access Inc.");
>> +MODULE_DESCRIPTION(" Cortina-Access UART driver");
>> +MODULE_LICENSE("GPL");
>> diff --git a/include/uapi/linux/serial_core.h b/include/uapi/linux/seria=
l_core.h
>> index 62c2204..1931892 100644
>> --- a/include/uapi/linux/serial_core.h
>> +++ b/include/uapi/linux/serial_core.h
>> @@ -277,4 +277,7 @@
>> /* Freescale LINFlexD UART */
>> #define PORT_LINFLEXUART	122
>>=20
>> +/* Cortina-Access UART */
>> +#define PORT_CORTINA_ACCESS	123
>=20
> Also, no need for this, right?  I would prefer to not add new ids if at
> all possible.

Could you explain why these are no longer required and what has=20
been done in the tty design to make this obsolete?
>=20
> thanks,
>=20
> greg k-h

