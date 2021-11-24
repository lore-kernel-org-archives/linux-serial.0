Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63DB5C433FE
	for <linux-serial@archiver.kernel.org>; Wed, 24 Nov 2021 12:39:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344841AbhKXMmg (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 24 Nov 2021 07:42:36 -0500
Received: from mail-bn8nam11on2056.outbound.protection.outlook.com ([40.107.236.56]:56193
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1344467AbhKXMkh (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 24 Nov 2021 07:40:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S824+Jnex4S+C9cqu8mQ7EnA3orSbUp7O6Z9o4Uim3cympYzp+Ghasz5M1kj0dZ5r3PMNVMmXwdbeGMQBB1JfvZ6PHWM8TqLR5b6/xLhl0VqW3q511TQcVYkwZ+t18hi2ETA4NPI7Vl5fro2aMxH9sF+FcRDxPKlIe7mgcoTLISkh5F5+FiiifxJ5q/XNtXzvdP0+sbI5mCrhgxkUQE2hkRt6YCsorsusy7rk5vsgstc1NSEtHCCMii91NbFoem8MkHPeMqbLa0m5s2uMNASsXyzrUPapRXzEM7IUn1cNNU8qgfQ+WQFBiTjA2aJDEUtdQZ9ko9Fi1lQRpCSokJ9Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=et/kDctVNqTZzvWWfC19B2+hYd8lfqgqe+hYeHQK7yI=;
 b=HKX4xE+uyMbDVKa/AGLWbSekM3WlWHJGFtXLBjt36fqSk9KODTT76mVhg2ojIIYwjHfINP024HHxluuDIdSWjt0L88Be9YkRef1ev570rQCRPxakc0IhacHN3DEIUge56B+amwmWds8ZNDojHnQBic+YESnirYLMOYirZLg9aoButMuM9LViZ9yjsMUBmrNRPHWxkrCYzWZOCWxJI9ghIBjQ1lP9Il7b9DgJoaRMdyXV1dtcpj+4I+T18BM152xVjQvtu8lgTTTVzjAZ2EWDdLBdEEx/X5MdD1KI46W23YgRFmDOJIselpHIMx4cZCYrJ+a5qAQwj1HziChkRAsYRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=et/kDctVNqTZzvWWfC19B2+hYd8lfqgqe+hYeHQK7yI=;
 b=n02GGUCPmmwKq6BtQDCfv5rSsRjiB70hssoaPDan+nQTWiynCkEInOAQbSzScbvs0GkD8osgN5x2FZ+MMFD1NkID76JECSUqQEY/cwm4tc9IkJjLERhee68p419TElvcd0w98x+1BLFDJNv5Ejzi/RYPftBY3iAVGhbtrS+pK9U=
Received: from MN2PR02MB6640.namprd02.prod.outlook.com (2603:10b6:208:1d0::19)
 by MN2PR02MB5934.namprd02.prod.outlook.com (2603:10b6:208:10f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22; Wed, 24 Nov
 2021 12:37:01 +0000
Received: from MN2PR02MB6640.namprd02.prod.outlook.com
 ([fe80::9882:74b:43a4:55]) by MN2PR02MB6640.namprd02.prod.outlook.com
 ([fe80::9882:74b:43a4:55%8]) with mapi id 15.20.4690.027; Wed, 24 Nov 2021
 12:37:01 +0000
From:   Shubhrajyoti Datta <shubhraj@xilinx.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "jacmet@sunsite.dk" <jacmet@sunsite.dk>, git <git@xilinx.com>
Subject: RE: [PATCH v2] serial-uartlite: Remove an un-necessary read of
 control register
Thread-Topic: [PATCH v2] serial-uartlite: Remove an un-necessary read of
 control register
Thread-Index: AQHX4Gv7EWkg+gaFuUifZzwqi/nMYawSdXMAgAAoTkA=
Date:   Wed, 24 Nov 2021 12:37:00 +0000
Message-ID: <MN2PR02MB664063C64EA9C8BC59C3E566AA619@MN2PR02MB6640.namprd02.prod.outlook.com>
References: <20211123131348.26295-1-shubhrajyoti.datta@xilinx.com>
 <YZ4O+qnkVyhGzuDy@kroah.com>
In-Reply-To: <YZ4O+qnkVyhGzuDy@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=xilinx.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: df36f2a4-0d29-47cf-ff0a-08d9af471cc8
x-ms-traffictypediagnostic: MN2PR02MB5934:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-microsoft-antispam-prvs: <MN2PR02MB5934AEBDE8FDCF902CB463DDAA619@MN2PR02MB5934.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RL9n9ICtM3p0h3D+d6m51KlXD1h+Bed5W3TqnL/1V7iuB11Dfx7JfT4uHdxRxS5fmYaZf10U6TXUnlLAL9vtr+tyHF/yfpZPMf08voFOEpN7KtAfQuYPRBjBbclZglmH9NApdkrbby4+0nAZVih8IyB8l/9BNwv56UmHBqBIUCjldjWptx04KbxbhH48xPo7yyahaO5eUkCoenGgs+6xu3vJGXdcmzIwBI7+bDBXQRpRvVjBDMohcGmXBZr/emoVK0BMUhn94fYTaYcWvE4wqSnfwH7Yewj1k3+iqwI254w8byED4Dk4FW7HZgyymZT33MYGMdgrEO4p11MMQLVS3FpTFmzoAMquUQM2/3lWLi43gkXsWPucbpAWT9q/SZXTRxgvMGoGitE1RH5bGb08+EycKSrcJgC/DXlJCw3BtS1gwHYp595nPTAIOhRflpnUsmJ0KERmqMI8pURziHwgzdINxzDlYJ0rCkfGhAhbV3VNnB7fD50We7QLyfbXS/jr0zl8riJetintiVf7b5k0RiKUO0EnMiI1ZIFvUBu8OTkR1cOXbuJschQFjUPYX+4mge2dMlokTKknZZB8eE00/XTbm6B76X8KtOiUbUHs/jhUWofK1uKyKDfdKR7+Oib/72r1Dw0a+NJtsooVM8mYGTTu2Ror4HNkKw1JC3VEdSyzTqnPR7gl2hZJyCCcKC5vzbgrjn4kbBrE+eHktOwb6w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR02MB6640.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66946007)(9686003)(76116006)(8676002)(4326008)(55016003)(54906003)(66476007)(6916009)(6506007)(52536014)(26005)(53546011)(83380400001)(71200400001)(2906002)(107886003)(38070700005)(186003)(7696005)(8936002)(86362001)(38100700002)(316002)(122000001)(508600001)(66446008)(66556008)(64756008)(5660300002)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uXqQ0Sn4FQ+dv21Jd+u2ouZlQM15Gn/cXZbIQDkZ1pqnbWtqM6XFaiRyromT?=
 =?us-ascii?Q?eoDR57qr3xIW5cSBXZKd9DJwNGt+bJEtRdzv47squWivs3nFzxzirOvsKmXG?=
 =?us-ascii?Q?a/PEZFEXZHPkzm//Pfkv5AKgGc+1hmzlSQLUzStsiGhyweZeyJMQDLmr6L1/?=
 =?us-ascii?Q?kfTq/cYc1OTjX8GOxzljaJit03UquWga5feMJ4236f+I+5L46x8IQAaKyWnw?=
 =?us-ascii?Q?mgTcTP8W+xEV9OsG+FRqX4hUoiD6/WqB9MP27GWhnFI/vhnhoQAtJojn3fEt?=
 =?us-ascii?Q?W13Vobi4dkqqSYWPSYv1jn71PW2j3Arj7iGAd0B8BskodHpM+psSIB4mw6Sw?=
 =?us-ascii?Q?97SVTATDS+83wenvqKirq3/XbM8PMQJWx8mjh6lFvQPfmccQtns/TDJxzxyr?=
 =?us-ascii?Q?KctAwzyCKanD89zIARm4UEdFXN5phyk2lwcPho225K6AN07aaobYS1r5+YZK?=
 =?us-ascii?Q?ETUBtta8BYRxbKJrmSjonNW2Y+1ocQE0Hw4Q65SGjgS/cV4RxH6A4bgFB5T2?=
 =?us-ascii?Q?y9zZzUK3sbIBPN0vOImqDjkDVXrsjW4O1DYH517mO4pG25KWDjyrvt1+MCO4?=
 =?us-ascii?Q?6EPVwLI4fW4BdGhVsCisM2r663id/LJ5yJOcVELigxxXp/txDeEqPnORRDBL?=
 =?us-ascii?Q?uOvbkZArCppuyi/x7z/Xx1RSjH+K+3Eo/NDXfGpDMfCiL7Pz47GkCjrGn4vV?=
 =?us-ascii?Q?MD2/89mCVlQv6PyZHUZatYorYJVhCgzdh5PRJx/4bCD+Kw5VZL2q9+WDFmJV?=
 =?us-ascii?Q?VE9vP6w09VMDxqVT6n5cA3XE0jNflDQi9Y0K9yOZRf74swSKcUL2vnr6h3cl?=
 =?us-ascii?Q?dEssGzO2xtdcQbFBhLFnVENeVDuV165LLH999bOqRWZk8TjojNYr0GFmgssy?=
 =?us-ascii?Q?90ityz/xk15Ij/LxuBeyNKbTG7AqRbtBaOfeZFnfWJHSIuQfZrD/gJoopPv8?=
 =?us-ascii?Q?cxOJpaEpN1iXhgYSZFKGKI74nZpincVYjS6MIisJcG85qDSUMFudgF0S05sQ?=
 =?us-ascii?Q?FlsNnrIEd/s7mx1g0WdZS0lFPtwAF0TmYKtLnqDHhhwqe4BudXRAEvT6Q1Kw?=
 =?us-ascii?Q?6PfTxzsj2HxW4OAN2DZDYS+tWa7HQvFHqp45b39MLJrdWbAhtnsY3rc5T6EB?=
 =?us-ascii?Q?Gl5tKYCBZvT6Dsn391mK6PafZizQuaaC9e+sEqjXiPfpbHw9/aVIBcBQGqQW?=
 =?us-ascii?Q?q8NF7KL7UzWeShkYoqIa5M6uuAZVWRtF2NSIdBkTp/BVK1CNGnem2K2NmXbr?=
 =?us-ascii?Q?CJVc9nYYBa8av+ZFcUbVMi85lsgkVydKrbbc+fbRIb1ig0KjVNtWpSi9HoFM?=
 =?us-ascii?Q?YIW9u+L/ivjKkwPsRq/GyQMNKZII4eKf2/avLE23nay5QqqvzhlQAvODcTbs?=
 =?us-ascii?Q?fc7lRL1eP6ObInrV2M//828J1gt4/8fyB2xoKHYZYBdXfUIMv8omtV+wugXq?=
 =?us-ascii?Q?bhk6I+TubqbGOW9dhza/3bOxXs75+6Yr1qdWzuMuldhN0x5l+JU77uboSKud?=
 =?us-ascii?Q?/QQzGlfY4YTd2zTyfaVRyeXO5AKbkIW8TB7/RBXjdztrUWEeUb12pgmC0Gbn?=
 =?us-ascii?Q?vhy7AU1pZXMby6If0O5bCGLI+oEBa87Ogat7BwUoNBasfRJn/zD2nOt9GYur?=
 =?us-ascii?Q?EwO001YCoM/98PggGpuqeGc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR02MB6640.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df36f2a4-0d29-47cf-ff0a-08d9af471cc8
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2021 12:37:00.8844
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +ywf39RYcoYnONCDrP/elR9Z/SkIahKjw5xYxdYEVSkTmJy3zsaeiUzUYX8HpF9dBTVkm2XoxcS7YnIcnzi7Sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB5934
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org



> -----Original Message-----
> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: Wednesday, November 24, 2021 3:38 PM
> To: Shubhrajyoti Datta <shubhraj@xilinx.com>
> Cc: linux-serial@vger.kernel.org; jirislaby@kernel.org; jacmet@sunsite.dk=
; git
> <git@xilinx.com>
> Subject: Re: [PATCH v2] serial-uartlite: Remove an un-necessary read of c=
ontrol
> register
>=20
> On Tue, Nov 23, 2021 at 06:43:48PM +0530, Shubhrajyoti Datta wrote:
> > The control register is a writeonly register that's why reading it
> > doesn't make any sense.
> > The manual states "This is a write-only register. Issuing a read
> > request to the control register generates the read acknowledgment with =
zero
> data."
>=20
> Are you sure this is ok to remove?  Usually you have to do a read after a=
 write to
> ensure that the write succeeded.
>=20
> What ensures that the write succeeded now if you remove this read?

I do not find the mention of a read requirement in the manual.=20
Also in the current code in ulite_console_write and in ulite_startup we are=
 writing without a=20
read.=20

Thanks and Regards,
Shubhrajyoti

>=20
> thanks,
>=20
> greg k-h
