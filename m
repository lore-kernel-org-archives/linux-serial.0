Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F230AC433EF
	for <linux-serial@archiver.kernel.org>; Wed,  5 Jan 2022 10:56:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239551AbiAEK4e (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 5 Jan 2022 05:56:34 -0500
Received: from eu-smtp-delivery-197.mimecast.com ([185.58.86.197]:34619 "EHLO
        eu-smtp-delivery-197.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232847AbiAEK4d (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 5 Jan 2022 05:56:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=camlingroup.com;
        s=mimecast20210310; t=1641380189;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jsezfD7PzpMq0YZiIv2oiREpOn7hvkyyZgkVGyOIPJc=;
        b=b6usdn3n2y3gUyKZeo6mXOPVz3LhBWR8fuCWG0q+M+2pCntzvryOr8gw4g7jrQKMML0TL7
        qqkIWvoqQzCLiRW83XUY18ydzBGA1I1Z+sU2XI0FcQYasXultDD/5AMbDzoCJpyNgqye5X
        sn8pLamRgakDZjX7Xz19flZtzz47f+0=
Received: from GBR01-CWL-obe.outbound.protection.outlook.com
 (mail-cwlgbr01lp2058.outbound.protection.outlook.com [104.47.20.58]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 uk-mta-249-e91XAPfdNZOeMvGg-_8mDA-1; Wed, 05 Jan 2022 10:56:28 +0000
X-MC-Unique: e91XAPfdNZOeMvGg-_8mDA-1
Received: from CWLP123MB5572.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:16b::6)
 by CWXP123MB5834.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:195::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.14; Wed, 5 Jan
 2022 10:56:27 +0000
Received: from CWLP123MB5572.GBRP123.PROD.OUTLOOK.COM
 ([fe80::4c56:90c1:1ed:2ea3]) by CWLP123MB5572.GBRP123.PROD.OUTLOOK.COM
 ([fe80::4c56:90c1:1ed:2ea3%5]) with mapi id 15.20.4867.009; Wed, 5 Jan 2022
 10:56:27 +0000
Subject: Re: [PATCH] serial: imx: reduce RX interrupt frequency
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        linux-serial@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        k.drobinski@camlintechnologies.com
References: <20220104103203.2033673-1-tomasz.mon@camlingroup.com>
 <YdQndwYc9xaauvpS@kroah.com>
 <7e509806-77ae-8f94-2563-7dbae1ebca17@camlingroup.com>
 <YdQxmQ+OMCrabg2u@kroah.com> <20220104224900.u3omfbilejx2jawr@pengutronix.de>
 <4c48200b-cc2e-0766-a002-831a789d4879@camlingroup.com>
 <YdV00WYGGd49WYt9@kroah.com>
From:   =?UTF-8?Q?Tomasz_Mo=c5=84?= <tomasz.mon@camlingroup.com>
Message-ID: <2a898a30-0d01-603e-f1b3-435f69b71722@camlingroup.com>
Date:   Wed, 5 Jan 2022 11:56:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <YdV00WYGGd49WYt9@kroah.com>
X-ClientProxiedBy: LO2P265CA0494.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13a::19) To CWLP123MB5572.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:16b::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 33a28cd3-dc14-4122-4c12-08d9d03a059e
X-MS-TrafficTypeDiagnostic: CWXP123MB5834:EE_
X-Microsoft-Antispam-PRVS: <CWXP123MB583497EAB075343F92985249924B9@CWXP123MB5834.GBRP123.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0
X-Microsoft-Antispam-Message-Info: g+erFKNLVL9ROYL8dGUSUAx6hTa2k+zjE5JZUV7sv1ZYh9ll74DEc1pL4SKP9x4ud650jbiLlWRaxOIz+C2d14QEkZAvTVFqON4Tg0P8mkM7ycvD1mGBYrwI1mZCRsewG20S9Ook6LtGelHTLUFJ+f5cgHE/GgQ9tcODE8/WyF8OHuF5wHMLNvvixy5v17B466Snb+AVXsEeRmN5CjPY5cYE3oaoKxsDoFfY3QZKupm3y578sAK8NY6tWU0U2Is2eMBBUONq1vNiM5/KPaAPit2Dqgbwit3xWG9tCeJZOhVvPmGToTUTjbVnMq85QLkfoxGTidnTqNAWev3/9f/D3amOo+Y4faHrS6jdC747EesfprQx1iGibhaSCGEL5TuN6KPPTgCtMgqqU3Uou8RbNSX0oGEk16H1+Eipv8pwTjndMcYW3P+s7qBFeid655FS6alGzSLMeyMcwVrysk5kovSRwJWd56DzIUYS67rzwp8O88Ecvl8cXq97Tq/QICU1/YwFlwcDuGa+MsxuAPCnPGjgJZgNfFEszTUlps6thfQrz1esGu3DjPT157axtXUXlXODIRLpToo8QBh1hPMuK6PWbz8ESKa1IiZPN01gNi9XQUuECIDqaHXsEqGyw2CIcuTJg8mc1RMFCHUyaI4ocReWNWUt75YWBx9Bd/mGgKcXgFxPypJITjI+htetZcf5wlBhHeMPsKTuWm+VB6bAdtitjV/rZU5PUQUcLjgeNg/fS3m67P2xKOrMb1fqddKRjKs7ANHgbPaTZFgXSwxi7Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB5572.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(366004)(31696002)(5660300002)(54906003)(508600001)(6916009)(2616005)(4326008)(38100700002)(107886003)(2906002)(53546011)(83380400001)(66476007)(52116002)(6486002)(8676002)(8936002)(86362001)(36756003)(31686004)(66556008)(6506007)(38350700002)(6512007)(316002)(186003)(26005)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1101
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jleS+dii2o50e4nXI6Lr51NQ3pisKwlgUiOWpl+RHFPiUShMwGub/E77N2Yd?=
 =?us-ascii?Q?dgrsR8c4zGw6ovKwJbxXS03V/KfV4GLa/5/jSUpGRPo9Nsca3yFvE2vYUC9L?=
 =?us-ascii?Q?soo+CDkexGAR97zOvXBv0lTDrB0mWWkBa2rhklLGDifW0ePbrfXUED2vtsTd?=
 =?us-ascii?Q?HZZJCq7FNwUE97S3/swj/NhjshcQPI7iwrCz2dNw8JcLszENVr+b+Y56A8x/?=
 =?us-ascii?Q?1Wzzdli1/fG/J5tbf5n20SB72QwbAX5QWajHLHSnzuaesz3WXiXDgWsrQ1oT?=
 =?us-ascii?Q?uKtzHY4NbITQS45KdkxZ7WQoTW5F8k8kkPo0TzU9J9vo3xljpXNvgFCvZYfS?=
 =?us-ascii?Q?CQqm768q1fcHwYEO4ttz1wPsXptqiaX2WJEyBfRxF4iqz2Xq7lQgOmUiJKFj?=
 =?us-ascii?Q?FEDRD3zYDx+nFjOFKhE5CuPBrnXKqLdbVTd4gElo1fK4Lbv7rjc4vO3iozuE?=
 =?us-ascii?Q?TwqrY18TiEje+Bc9Kx1CEodP4bm3cewsbAV8A3fv20RxIpYVQs5rJpER8IEa?=
 =?us-ascii?Q?SJNWcmsTtlG75yqk1xC9sc+aPjskqQUO9Ob9+E2Fw0ds9Iy2FVsNnMH3ELrD?=
 =?us-ascii?Q?ISob42QP8Q6YaQGRWMi/DTRjWOQazt4YTu2EpJLGcLrISawKa+SvR50agCvg?=
 =?us-ascii?Q?hvfq3mFVK1i61I2oZhgcgFaOE/hH7C+WMeiKd8GzGI3CQdhzuqN9GDcFykFp?=
 =?us-ascii?Q?pVTpivaWtgdwXwtg0in6mGGS0zV5pwD8qwOVe1E42lWUAo36YfGoQkyBkSM3?=
 =?us-ascii?Q?xA47SKUxpZkfAFiZNkZFtyQ8osaQ3e7RcFTmpzDObvtA+5zdrskvbI9Q31p0?=
 =?us-ascii?Q?Xv2+hsHQh5K+Ta57wfqM8qmI660VEdUkovMKqVgl7CYnioNY+0vFi7VIzaB4?=
 =?us-ascii?Q?Q39ukzEX+hAGtnf6QPmpk3t7rZQxqJCoEjGdcVpN9+8gGpvLe3hnDKr+hMpM?=
 =?us-ascii?Q?thMJSTL6krjBuKCRUxHA1NigjwFkegf3VwNs0ZcL2BMlJREzMmBAfUJchrPL?=
 =?us-ascii?Q?U8Btfj/g2w8Otu3D5scbmWSPlDtzCymdkjfzdpI1pRG9FWTgsw2YvYeBZKgJ?=
 =?us-ascii?Q?68fw/OZau8/Rvs0Dk0nhkHvjN3iwK9oT0iPhcdb7/s5dCckcTqMdl/0fgNXf?=
 =?us-ascii?Q?4wshtcTblw+RmXdnuiDFpji3Go4jMPIuIRlGAT7Dhr8DGA9iwk4Gqea8z5z3?=
 =?us-ascii?Q?FzKs1aLOO0v4fIzPvQ7Y1yi9ExdAwFJ2MSAvmf/1owrWzEKB6jmyL+9QBSoY?=
 =?us-ascii?Q?vdWaos8wBofkLtq+WHFpR35vmIV9ZKMOmtVr7ef/dxaaxROWJM8h3MdWU0um?=
 =?us-ascii?Q?7clhEUi9l5FlnNY7bC839LZdROH/IBVJg19yzEzJT9AQtRmiTUK6sxxNp0ot?=
 =?us-ascii?Q?IVZNNfu8awygLhEKVpm65fGbifPUzdawOLOTYyLct1PooOZ9Z1q8ag9KUbn/?=
 =?us-ascii?Q?Wt7kO6oY8XlrlF19uoIO2QNX9PVFTZ1eP4bKEkRxW/3gLUgj+mLLxh+ElR9V?=
 =?us-ascii?Q?ptAisZea8JCkaYsY7EW/NXlVbv5s1IUznrbwV98e4IOUc/yUlODN1wRZQCLP?=
 =?us-ascii?Q?dBjVjcFrbA9MNcYP5xOWivZQtzaRaLM6nNCbbf/mJMGhaefH2jpTG+w0bk3b?=
 =?us-ascii?Q?xXPkJSEV1IWSUwO4Vw+ItY3nyoVt3i3u/GVdZX334O2bceW89cca4Oohy1po?=
 =?us-ascii?Q?9Y6olA=3D=3D?=
X-OriginatorOrg: camlingroup.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33a28cd3-dc14-4122-4c12-08d9d03a059e
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB5572.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2022 10:56:27.1670
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fd4b1729-b18d-46d2-9ba0-2717b852b252
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dFuVhVdDVNtspnMM+c3KLzgY/2gbvUz0leFP7ptJX0hcvCra3R2N4hY0ViBwwSx2Mj1ZmpysKA11Bh4xQ9lvSRhx0dijQmpf+Y/dx7O2CKw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP123MB5834
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUK97A341 smtp.mailfrom=tomasz.mon@camlingroup.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: camlingroup.com
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 05.01.2022 11:37, Greg Kroah-Hartman wrote:
> On Wed, Jan 05, 2022 at 08:59:09AM +0100, Tomasz Mo=C5=84 wrote:
>> While the increased latency due to this change is undeniable, it is
>> important to note that latency is not everything. There are applications
>> where the latency is crucial, however using Linux for such applications
>> is questionable. Linux is not a Real Time Operating System after all.
>=20
> Yes, Linux can be used in real time situtations just fine, look at the
> RT patchset for proof of that.
>=20
> So let's not make things any worse for no good reason if at all
> possible.

Avoiding interrupt storm is a good reason for me.

>> Latency is simple to measure and argue based on the reception of single
>> character. That is only a corner case, not fully describing real world.
>> In the real world, it is important to consider the overall performance
>> improvement. It is hard to determine how much does the performance of
>> the system improve thanks to less time spent in interrupt handling.
>=20
> If this can't be measured at all, why make this change in the first
> place?

It can be measured, just in general case, it is hard to tell exactly how
much does it help due to the complexity. All the time saved by not
wasting it in interrupt handler can have impact on many parts of the system=
.

However, there is a use case where it is easy to tell how much does this
change improve performance. In the situation where the interrupt storm
occurs with current mainline kernel (RXTL is set to 1) essentially
freezing everything until the sender stops transmitting, the patched
kernel (with RXTL is set to 8) handles the situation just fine. Change
from completely unresponsive to just fine is easy to notice.

Best Regards,
Tomasz Mon

