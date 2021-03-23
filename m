Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07C0BC433E0
	for <linux-serial@archiver.kernel.org>; Tue, 23 Mar 2021 19:29:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C806A619C8
	for <linux-serial@archiver.kernel.org>; Tue, 23 Mar 2021 19:29:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbhCWT3A (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 23 Mar 2021 15:29:00 -0400
Received: from mail-eopbgr1290057.outbound.protection.outlook.com ([40.107.129.57]:10752
        "EHLO KOR01-SL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230142AbhCWT2y (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 23 Mar 2021 15:28:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NVecg14KC7QBOUm6rwPBHWA57PE93D6NpI0j0eCUqlCGYaH0SHQhVpcZglLLTjIi4L2YqiptsFMXupyhGLeqSJ3CzEjhzJhL2eTff5xevpmjVVemKydRP0yG+HC5EspKi1Ie40AolLLAPblY08JYez7myE4ohA5fnO7IO+P0VP+tNP0u+mO7c0uZ8M3ChxJvegHa1UbjoKMvC1g79lWkmcrl22hTAn2nNJIVvGcx4565u5ynnHoeCjW65v2XL+TaOwSCpcBBS0fqSiUml8qx3Y8o9JodTykmSqA5jz9fVUxlkiqaG23vn2yA7wnK5Ei/Z1wNM6cv2Pbc7LGAic9+1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2pi13U3MuwyUJYVuuUZoPF8SV22CMoayE8jHUOdx9/o=;
 b=RtDh1A/YvVZsdz8HhDEzbkUbYVcV6pV8q1poPbUnh7ZR+9FgA4EcoG5nYYQZ/CliJiOzI0vSZmQ3r8Hlw+GqQD/1LQIB6hxNbT0IswGiVWeuYb6K0Vpodb7uv4nSQB0r5gfRSFLFKvS4TMNxjbVkyL0mqnrtWBhSm+IVzVfjOSyEBTt7iB42SH593eFi5meE4WAZY101wm3GnidaN766GHDguw10oJ5fi0UI2UWISW0jRdQvMV0fJV+L8ns9sGVd5pQHAtHG5qRyWvGhGUMvAs/qzqH4PsyY6YXEHR9iiIQ12MKpUyWMZfOPb9j93a7Tyb5P0VGTns4pVzoIEbQfjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cortina-access.com; dmarc=pass action=none
 header.from=cortina-access.com; dkim=pass header.d=cortina-access.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CortinaAccess.onmicrosoft.com; s=selector2-CortinaAccess-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2pi13U3MuwyUJYVuuUZoPF8SV22CMoayE8jHUOdx9/o=;
 b=DXszqm8813hGc09Wpyoo9mTw9oLobtGvOoWLwn3ODKpdacv/fD6k2n2tD4vwN3jheopDhV/DweHnnAZWJT31DVxku6/CNnR4Sv+6Sc2s9lvE6KInfBQv1JchCkHXdvgmHuvrpD8D0Q4uIt4+kQuY7x6ej2xANYvvKMktTLtdI9w=
Received: from PS2PR01MB2504.apcprd01.prod.exchangelabs.com
 (2603:1096:300:3e::11) by PS2PR01MB2311.apcprd01.prod.exchangelabs.com
 (2603:1096:300:3c::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Tue, 23 Mar
 2021 19:28:51 +0000
Received: from PS2PR01MB2504.apcprd01.prod.exchangelabs.com
 ([fe80::7937:3bdb:b574:e31e]) by PS2PR01MB2504.apcprd01.prod.exchangelabs.com
 ([fe80::7937:3bdb:b574:e31e%6]) with mapi id 15.20.3955.027; Tue, 23 Mar 2021
 19:28:51 +0000
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
Thread-Index: AQHXH8YY8JGd0lZ2t0+mKnLpM4QhKKqR9fQA
Date:   Tue, 23 Mar 2021 19:28:51 +0000
Message-ID: <04208957-55F9-47E8-A20A-4DEB2A35040E@cortina-access.com>
References: <1613702532-5096-1-git-send-email-alex.nemirovsky@cortina-access.com>
 <YFmzax3pWFNtFbn9@kroah.com>
In-Reply-To: <YFmzax3pWFNtFbn9@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=cortina-access.com;
x-originating-ip: [70.58.207.205]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 706d783d-b75e-4daa-e327-08d8ee31e3b3
x-ms-traffictypediagnostic: PS2PR01MB2311:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PS2PR01MB2311ECA363E3812648CF86A2CB649@PS2PR01MB2311.apcprd01.prod.exchangelabs.com>
x-ld-processed: 0694623c-6669-497c-89c3-3a32a9934313,ExtAddr
x-ms-oob-tlc-oobclassifiers: OLM:962;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JLaYFz8aWic/NdDfTYzyUY0pEBC3ufMp2+L4cTiRuADZXkDz49pxGmAj/gDW1ADWIxLMG5My8QJJpjALD46sp19hXQqxv31w48ZnFY5Kehb9Z3kgjssTyKbmQZ4IkM+EasWJI6WTnABCfSvMbfpiKU1W2o60Ly3ne4J/tjIf20lfgIOo9S1M/YhySV/1GYKexjMvhDfj/ci018qD8DXB9Jr8sbjDJnRHNTAMz1rkEFYCCegAZCwqV8RAmANpnDFbUShPcBFrWDeMJx4KXQLH+ENQHNxK0ltK8RmR70veDRT1MinVUDOOs7WzwWizVroAq6wqLkZ3NTq1UwJuKznVoZv+DljFDpU+u2DObFwG7bsG89LTwAEfd/RO63WOAYElZNPjRyu7XVLwIdzOWwoTBiNb5KACz6fi7DbElxBSiu9HpKmkfFSrvSnPDL2ycOiLwnCp3ig03iIxj8subF3r7xscoap6DwcowgHp/D/JXn4Awh75Rf2xj0fLOD366ZdXNCiYBdZl1r1IuWNWEtD1W3x5zMDXpZwnm8n/pJTOX07KLTBeTAZf/CGkzw4bklXP+4O3131QAP/w2x6qjuuiPklcg/45L9qD805GFvvUAsKewZoivMW2bxpBqEWY/DJ3V0TvQQena8/52LrdrtJPSyujvpXjCT000tmC963RdQw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PS2PR01MB2504.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(396003)(136003)(346002)(39840400004)(53546011)(6506007)(36756003)(6916009)(86362001)(2906002)(71200400001)(54906003)(478600001)(316002)(5660300002)(83380400001)(6512007)(186003)(33656002)(6486002)(8676002)(4326008)(38100700001)(2616005)(66446008)(66476007)(64756008)(66556008)(76116006)(26005)(66946007)(91956017)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?lyOwRVDwy+q4QRyIE7tZSiM5XVqhxPELz2HTcMUQd1qJbu9aUG1XCXgB1W+c?=
 =?us-ascii?Q?ohbM93+E2CjJBQHPKGtj/Ay3tNstL9y2mSOZ4jW7w7WXEHkgq+V/+I2FSaUf?=
 =?us-ascii?Q?zlGCunyCjMvXcWbj6dDVYBrD3WdryvwIWo4Axp/kSYuQhWEloKkKWdUEP+BI?=
 =?us-ascii?Q?G/18sbQULGbnhExbBjQSlGTAe3SXzj7WV1o69I84Y+miTyb8EONr+f0xwD0s?=
 =?us-ascii?Q?pnCGovxugjU84CrVpfD48xniOUsNOfXWpXOzicVagilbYXG05olr55Bj3M8t?=
 =?us-ascii?Q?AfcNNz0jl3utQBbd7H6kftMtfMUHcVXdRE3O+k21spGSpAC2oMJMktYOZkA4?=
 =?us-ascii?Q?0a2MNudptQo5o8pzqxhSh/QzZeTsXDmbUMwG/QJbPTMfD2dHq1xuKOSQ4Ooi?=
 =?us-ascii?Q?hmiWNvryeh9xKWHvg0FLhm4jot4HXBIfvVFALUm42gDT29fHf59ZxfKn+Ssh?=
 =?us-ascii?Q?VFlHd9JKiA4a/NDzbaqZoh5whOfIEBtEBRQqdYhflCHARyxI/4WfQvBF3BHJ?=
 =?us-ascii?Q?41EF64t1V8INjsamKjm5lWfKojZI9QIjEVzN74N0OVgClLhOxYzCAXEp1p57?=
 =?us-ascii?Q?0mVMauajy0m55YtyYVFuEmcRVTGG4jA//MkoVXmzhrBB164A/2MPlWQbQQa2?=
 =?us-ascii?Q?kN/ZXvkLXEXOV22qmirGnrDjsiGx4Zf3qpQQHt8OJkFW59TY6ySu/xRgVXmW?=
 =?us-ascii?Q?9Heztq3OU7p2EPFEll3owlm93TI08TBMkJ2xEXRFIhv6abFr4XGhdtiN/FB2?=
 =?us-ascii?Q?YEcOxs9mD4n79ijo9GzqmMltPtMlLFDE7nGFaY0CdrsfFKqageBuRprQJzOF?=
 =?us-ascii?Q?fh+DksPiaPS9R/c64sNaDQzpKneq5/g6lhodL8E/9Uye/4YBelWb5h4SD5sd?=
 =?us-ascii?Q?4GUKNkzZTucjBT2v1FfoHvkCv8b9vO6C7r+zbze7RMieWyhnLrAGQQs9NbPB?=
 =?us-ascii?Q?60ZM/CkJXLMezvoITgKDD+HK6U8dm9yc9z+253hBHwOtu4ccPEYLF4SAdZw8?=
 =?us-ascii?Q?K+iSejgl0p/gBKJ82SYTtfwIoNInVPvXN5P3DcNuj7ADKxlcLivwRmEt/gVH?=
 =?us-ascii?Q?WaZPJwAh7b+lwREnlXm3qnVR7jkiDLAPtsyWz2QlzxonVrxKwdlrxrCD2gmq?=
 =?us-ascii?Q?LKlAtT0OMqFVSwui5fAOPPRjwRNUH2x83y7mTDoXMg8GDWHVPn76IkCGPRA/?=
 =?us-ascii?Q?LL0StgOW1Lu54Kfw4X6DSiCZrH14Tb0/Y4LT2Z2PPx6OT/E0CsxBRTQ89KCd?=
 =?us-ascii?Q?jcHsmN7JxkOEByqSg+bPssMS+3xjCv1ion8X+XgM7pfisRoRuvkwBT/Jog5g?=
 =?us-ascii?Q?whqGE1relHB5uDqBHU/im0Df?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <AEA84E4F1E7D2C43834F2666BD90C22D@apcprd01.prod.exchangelabs.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: CORTINA-ACCESS.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PS2PR01MB2504.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 706d783d-b75e-4daa-e327-08d8ee31e3b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2021 19:28:51.1789
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0694623c-6669-497c-89c3-3a32a9934313
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rflL0fZu7IL7+bb2LdzbAJjdaSe+TfitPM7dXRM9UxFlKfkVS0w5uwm8IylkL91UgzLnPJCcV6wpIAHX1ze/NgY1e558ct5/vA5bFvsSTdrGZVgtC8oLhT4DUsMruM4X
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PS2PR01MB2311
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org



> On Mar 23, 2021, at 2:22 AM, Greg Kroah-Hartman <gregkh@linuxfoundation.o=
rg> wrote:
>=20
> On Thu, Feb 18, 2021 at 06:42:09PM -0800, Alex Nemirovsky wrote:
>> From: Jason Li <jason.li@cortina-access.com>
>>=20
>> This driver supports Cortina Access UART IP integrated
>> in most all CAXXXX line of SoCs. Earlycom is also supported
>>=20
>> Signed-off-by: Jason Li <jason.li@cortina-access.com>
>> Reviewed-by: Alex Nemirovsky <alex.nemirovsky@cortina-access.com>
>> ---
>> MAINTAINERS                                |   5 +
>> drivers/tty/serial/Kconfig                 |  19 +
>> drivers/tty/serial/Makefile                |   1 +
>> drivers/tty/serial/serial_cortina-access.c | 798 +++++++++++++++++++++++=
++++++
>> include/uapi/linux/serial_core.h           |   3 +
>> 5 files changed, 826 insertions(+)
>> create mode 100644 drivers/tty/serial/serial_cortina-access.c
>>=20
>> Change log
>>  drivers/tty/serial/serial_cortina-access.c
>>   v3:
>>    - Remove usage of uintptr_t. Change to pointer to driver's private
>>      structure instead.
>=20
> Is this really a "v3"?  The subject lines do not show that, so I'm
> totally confused as to what to review and what has been reviewed here.
>=20
> Please fix this up and submit a "v4" so we know what is going on :)

Could you recommend a method or a tool to update the commit subject id with=
 a version prefix?
Currently we are doing a git format-patch and the subject line is automatic=
ally created without a=20
version number. Do you just go in manual and edit the resulting patch conte=
nts file or do you use a=20
tool to assist in this?
>=20
> thanks,
>=20
> greg k-h

