Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12A54C433DB
	for <linux-serial@archiver.kernel.org>; Thu,  4 Feb 2021 22:23:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C773764FAC
	for <linux-serial@archiver.kernel.org>; Thu,  4 Feb 2021 22:23:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbhBDWXq (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 4 Feb 2021 17:23:46 -0500
Received: from mail-eopbgr1300043.outbound.protection.outlook.com ([40.107.130.43]:61312
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229511AbhBDWXp (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 4 Feb 2021 17:23:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QK0wT120jPisxI+RbR2Erd4qDBPlvbhhbEu3HdFHsOJicg/oS7GQuNV0C/+PUe1LXsW0o/dIcwiQpIR2pH0Tf+S2lVRYqU+4z5Z+Ag8Gr7h/1dxBz8sd4HMh24F2VR0gkbU4eoW7fZTS+2JY8P6fETlwE7QGLQncbeZS56Ix0b4erpZLTm4HM1ocPmsB02quGPtOZn5foBweO8n4oaBmSLSxMLAumI9SB1tRpu+x2efTWWMVBJpGoL4B4Ro3206ojEqJx9Tj8GAjdpJHsCU45JRa1QcQwLKQV/p3xih5IVoIkSBVkTss0GPwLfmhzLCY/nDhLeneVODMwbkEkXSiWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FMq4CoXfVre4tDLm4yYnN4pcX1j9IT3EfbEZn0W873w=;
 b=YuoQ4+VMoLmwIjnN9o9kurut7rOZD+TrlQ2ZA4dLkK/gS1ZLvubsbif4Z4N7/W8aNSVbsu9Dic66obhnPPDL+IQxBGKFmZP6IX+haFRtLfn17A927rvHHWj8vEkLdyoB16SoXjMmm9VF+QhMxN0TmxZiAqQuQ15Kt4NFO6ErHXO4nrPWOO3/1DJ8vxq+9eYvFe5l7E1SM4fXnVig32C6EOnBHR3Bnrs1P7P/hxYYApeSyR3gcETlvqhEOSRdzJEdsNG35QPXE2wvdgFpYs3ap6iaeo5xXCzsqCyxpHaZGb7jmxvv81ypMJ1M5/AS66Ahc92a/Q9kkcLLt49gXDrFCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cortina-access.com; dmarc=pass action=none
 header.from=cortina-access.com; dkim=pass header.d=cortina-access.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CortinaAccess.onmicrosoft.com; s=selector2-CortinaAccess-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FMq4CoXfVre4tDLm4yYnN4pcX1j9IT3EfbEZn0W873w=;
 b=uLKdekuLtwdrv8icQfCXAsbPCmxyBRSAdqmUa5TpFU0UiwAeG1iT99dmJR4K5mBDX6wbWyUKi/0cwtfiJUjzAaCmf1JB6rhR7y4sbY5QfLf5KCbnZDk3d+tNZybYd5GNfT/6QVJNIo3mPd8qIPBE/vJwe1IOYaUsDBL42P8x/gk=
Received: from PS2PR01MB2504.apcprd01.prod.exchangelabs.com
 (2603:1096:300:3e::11) by PS1PR01MB3530.apcprd01.prod.exchangelabs.com
 (2603:1096:300:7c::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.24; Thu, 4 Feb
 2021 22:22:09 +0000
Received: from PS2PR01MB2504.apcprd01.prod.exchangelabs.com
 ([fe80::a5a3:f135:b16e:7329]) by PS2PR01MB2504.apcprd01.prod.exchangelabs.com
 ([fe80::a5a3:f135:b16e:7329%7]) with mapi id 15.20.3825.021; Thu, 4 Feb 2021
 22:22:08 +0000
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
Thread-Index: AQHW+w1gIDlYU0uPg0iNd3+S47j5m6pIkj2A
Date:   Thu, 4 Feb 2021 22:22:08 +0000
Message-ID: <B05184D2-DEB3-4ACB-ADB1-AE21AB323689@cortina-access.com>
References: <1612425530-20483-1-git-send-email-alex.nemirovsky@cortina-access.com>
 <YBwXoCwKwkcMPYvy@kroah.com>
In-Reply-To: <YBwXoCwKwkcMPYvy@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=cortina-access.com;
x-originating-ip: [70.58.207.205]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 88a3d86c-5c2a-4ab1-b1dc-08d8c95b4fa6
x-ms-traffictypediagnostic: PS1PR01MB3530:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PS1PR01MB353022B3330E8B460FC01236CBB39@PS1PR01MB3530.apcprd01.prod.exchangelabs.com>
x-ld-processed: 0694623c-6669-497c-89c3-3a32a9934313,ExtAddr
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DKA2FFqMToZKFFzN5yqKEQqdm9WKAat9ORgX7zZEmhmOjuz5Om5U2l1UWQuVtOHvPMycknp9FPdi0aM82B74g8VE7qCUNGmIqutsIKkSsIdvdOPVvKZwGr5ilx4nOQf6jRCoA3U7IRdnnJrLdhKkJfISta9im5iHcaMNEs2Z/trTFjn6TQkmLbBnJZqJtWbThNuiQ1sTIaUJ3TSViIg/hMt4fy6ODZAlCJEhYw24ZYROR8idMoLsKoft33x9NmpABXTCvdlfjRLdVIq/hBGnrjYbrRDxWw+Ktq3oD1qZ0SAMWLR02nxtQ/2W+RENbIX87+EzJc1qIHHrtJPBoS3Vcl79QPyx6maxiNqNLFrlGtZfJiu4XwAqK/M9t9WekRkO9/0xgcPkT1o5dgo+6a7tDnofUf619sUxTsdRCrIIoQxuAT+eTOojNl6TX9Zqi2nKkEV5kawh7e/oziyvzozDSuT3yZE6UaS5quhL8uf6Vqb+8+caJ0WooyG9wDrliNW+zWLy5+Mv3x4HTjTPD7Xitw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PS2PR01MB2504.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39840400004)(396003)(346002)(136003)(376002)(478600001)(8936002)(186003)(4744005)(316002)(2906002)(2616005)(71200400001)(4326008)(6486002)(6512007)(54906003)(36756003)(66556008)(26005)(66946007)(76116006)(64756008)(66446008)(6916009)(66476007)(91956017)(33656002)(8676002)(86362001)(5660300002)(6506007)(53546011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?hT3eAe8YVY9rauuGeDgFAl/OIEfKXFyponoW0q37KYtIUxrDrY0P3NA4Yj3i?=
 =?us-ascii?Q?/AGvuwtsZTcD3O/UDvPXIThS97fPW6A/DDgvwZX9MSMQxU1JOMmHdFRKjkib?=
 =?us-ascii?Q?d00BwpstKvKPMP02ogbFBScbT3SYwT6x6pcqumZkJ8/5R1Xe7qlM3jcXVKjC?=
 =?us-ascii?Q?PiNgM1l+yXqV4rrS3iHDuK5oO9Ta+QGDybD4/3v5UbkpaK0pbqS+XWqPcfyn?=
 =?us-ascii?Q?YV2QtphUM2CbOmxxbF+jA5bmGjWiN4IaNcgQxspJ5GYuhaDtlUgHOM/S/CWW?=
 =?us-ascii?Q?GjJwe3wAG9OBtaTJZKRV9XTe9cXlcV/HznZIInEFlLYwusplzWPXT8eGGGsS?=
 =?us-ascii?Q?XxfIoqm+D5LOWd6AENlLqWPlmpSBgv9Os79fY4QmukLpUjnWfRoLkpH7HB9H?=
 =?us-ascii?Q?Wvm9+xrrf3ZXfa0xzXIqRQNsUpQYYvykCuzadz8llaymtYAwjpqhWjSUp5rI?=
 =?us-ascii?Q?Y2/3BLm08u8aRDpC0b0WST2uhjF9y0pbk7qMK62lZTkVMGQ1WIyWNq+CBU1B?=
 =?us-ascii?Q?UqLav47RYfsYnUtTW+1+IDQO6vUVGV0SoUEvJbTsQ33gwNhD7eRRBcj/8XqZ?=
 =?us-ascii?Q?TiMrAqHLWNLkflJjb/kNs/57ccMFALNIzzkFZpWg6TYtdzY4eC5CY0ixZhuj?=
 =?us-ascii?Q?5cx4DWDeGMmxFluvVFR8rq/mVt3YiC+y5wgihXhfBIGuMyGOph5wQtm8n7NK?=
 =?us-ascii?Q?ydMenjpHpaTZ4IsS/O6I2LcAIAOEJ/zY/K2EvY9ps0gygYCNOKrCrfNQC/Ya?=
 =?us-ascii?Q?UIKGgRohy4hPFfcPVLy4+hTk4wXOBqNjBeMHWsAqR8OFzpCDPL8wcrK6uu9f?=
 =?us-ascii?Q?MmeKitTGoZRmjNj7cooH1zNAxJ060wi+3zxm6F6EO2rVCp6tIxIxZkhjg9RZ?=
 =?us-ascii?Q?Oldllf362ihCi9Bw36IZqkUZFp7+8wyMgRYmZcdi8ivbt0Hk88rWIZOr7PTx?=
 =?us-ascii?Q?g1seaKfScu3aCNmx0qss7UwYwFnLvqWKIvYX6CCIotTPLYdhvork1GlRMPNV?=
 =?us-ascii?Q?sPpw+Jam6eYxRZrDof9ObBPNwzQ/vsCOJa5X1DO/4lRP8oYQq08dmy+qtf7c?=
 =?us-ascii?Q?7/aGvx1faTt80EFEgjygQG6YR9gEpoT159QDvSMgu8WewSXMNJjiRJzQtBko?=
 =?us-ascii?Q?ieqVpeitE2PMSuv+pgd0F9zAd4t7lWua0L7/Cwnxb/dKUN/RcX7Z7ceAs+wU?=
 =?us-ascii?Q?vqGERVEax5C6VxUf7oHMevXv8awFp8fj/oNdvgKY/kSWzFh4w6hPr1TNt8Vo?=
 =?us-ascii?Q?hiV5cdGl1ckVea+A3OnryEF1ke214Yq0Y/hx4HentiyypnxCyJbs35yCGcTI?=
 =?us-ascii?Q?ze2KsEaHInD89FKF7UC3xn9Y?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A8E2AEC9B5AA1C48ACA35F95FEB6F7F2@apcprd01.prod.exchangelabs.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: CORTINA-ACCESS.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PS2PR01MB2504.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88a3d86c-5c2a-4ab1-b1dc-08d8c95b4fa6
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2021 22:22:08.7557
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0694623c-6669-497c-89c3-3a32a9934313
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VfWXAKwFNL98nHlhPCxCxYZzgdestl946QL41se7Xl06y39WrddkcXs8Tb+dKco7v0Bhvub/3SHvHFlD9otKCn6wXN63eSOUtJM2gQL7I7Gom6IdCvULKSbDKvpEj9bM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PS1PR01MB3530
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Thanks Greg. Will fix this and add a change history.

> On Feb 4, 2021, at 7:49 AM, Greg Kroah-Hartman <gregkh@linuxfoundation.or=
g> wrote:
>=20
> On Wed, Feb 03, 2021 at 11:58:47PM -0800, Alex Nemirovsky wrote:
>> +static uintptr_t *cortina_uart_ports;
>=20
> Note, "uintptr_t" is not a valid kernel type.
>=20
> Please use a pointer to a real thing, no void pointers please.
>=20
> thanks,
>=20
> greg k-h

