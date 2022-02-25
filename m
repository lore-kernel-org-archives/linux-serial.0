Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCF21C433EF
	for <linux-serial@archiver.kernel.org>; Fri, 25 Feb 2022 09:37:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239157AbiBYJhk (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 25 Feb 2022 04:37:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237594AbiBYJhj (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 25 Feb 2022 04:37:39 -0500
Received: from eu-smtp-delivery-197.mimecast.com (eu-smtp-delivery-197.mimecast.com [185.58.85.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EEAAC7305B
        for <linux-serial@vger.kernel.org>; Fri, 25 Feb 2022 01:37:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=camlingroup.com;
        s=mimecast20210310; t=1645781825;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qFdnGdJl6jp5uApaE+8D0+MLW0ap2eSnFgSxwl/RlLY=;
        b=b/MiE1OJ0Qr0dts/8Z6FCyfEFHpGoJGjJdIqnUiL+qoNbbM59hGRGAqQeyKpg3O5A2Z6rn
        uRCh4FRuIaNY4QXB7eNZBnM3xQ4wCjC5g5/mZjQk+F0QkBEsgHXhWw5kJANiNqwj1eq+8u
        yYDJxJEc5DMtx8I1JPuBl3zCu7p8lsU=
Received: from GBR01-CWL-obe.outbound.protection.outlook.com
 (mail-cwlgbr01lp2050.outbound.protection.outlook.com [104.47.20.50]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 uk-mta-238-5phHe5QjNbWsQxjowI-RZA-1; Fri, 25 Feb 2022 09:37:04 +0000
X-MC-Unique: 5phHe5QjNbWsQxjowI-RZA-1
Received: from LO0P123MB5583.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:213::11)
 by LO2P123MB4910.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:1e0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.24; Fri, 25 Feb
 2022 09:37:02 +0000
Received: from LO0P123MB5583.GBRP123.PROD.OUTLOOK.COM
 ([fe80::bd5c:d100:7185:a21f]) by LO0P123MB5583.GBRP123.PROD.OUTLOOK.COM
 ([fe80::bd5c:d100:7185:a21f%7]) with mapi id 15.20.5017.025; Fri, 25 Feb 2022
 09:37:02 +0000
Message-ID: <5c677799-411c-0c4f-fd99-15ac6dcb4844@camlingroup.com>
Date:   Fri, 25 Feb 2022 10:37:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 0/6] sc16is7xx: Hardware flow control fixes
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     linux-serial@vger.kernel.org, Phil Elwell <phil@raspberrypi.com>,
        Daniel Mack <daniel@zonque.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        =?UTF-8?Q?Krzysztof_Drobi=c5=84ski?= 
        <k.drobinski@camlintechnologies.com>,
        Lech Perczak <l.perczak@camlintechnologies.com>
References: <20220221105618.3503470-1-tomasz.mon@camlingroup.com>
 <Yhigd0pu2hmSLirE@kroah.com>
From:   =?UTF-8?Q?Tomasz_Mo=c5=84?= <tomasz.mon@camlingroup.com>
In-Reply-To: <Yhigd0pu2hmSLirE@kroah.com>
X-ClientProxiedBy: LO2P265CA0475.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a2::31) To LO0P123MB5583.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:213::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ce58a64c-cb5f-4349-c40c-08d9f84260dc
X-MS-TrafficTypeDiagnostic: LO2P123MB4910:EE_
X-Microsoft-Antispam-PRVS: <LO2P123MB4910AC29B3625AD0D5C8ACF3923E9@LO2P123MB4910.GBRP123.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0
X-Microsoft-Antispam-Message-Info: dHFY1tuwy89tnmz9wi6DWsJPzfVePswFEDUROrj05epNOf7gvz0XdLex2adIte9V9kP3OsUkg7T+eyfRb821r0bVIQ4Gr1FBPTB6kaUNe4SBD+L3aC1hUQUvgkJywvGVCvWA3M2C4afqrIzBCTdvgA4AbQLqXNeMuNM2j3fFfnfaxnwcV+0er5s/T7JCVCOrvxupeV/t+KkSbE6IEGUllYo1APjRo7tjmmhHyCb+46zOJD0+ZAtSIe8YABLg/oP/kcctfPi1+lr9uIEHoIGKLVE2WNucP0Ry6I9ambDF6T3pDzvW8AdAGT0yyNdH4MCfzHF44STD/MTJyzIyWjs3rgpcBBz5LnCW/eK+MomgddjInMXaIf5l3HaBKaI6ffYDM2B33O3swHJuKn1qscXvXVvxKJQiKzs2h7nd2w1RRWQeBxIGox7vhenNgQipQEWAUBbzOU1RdxuuowYAMOWWxzFo+YZjlbZOVefRroMZWKKcVZiuxHjhzOFgiEx7MrjoMR51PL6BHuXHepWbSbympfLTjWtaSeFcN5Tc4sBeNuFMjfwOaGAnzT8lbIyvZmRRd3rDJ6ZHywsBA7gpdSYWSuSm+vUzxElqCVlNFFBvh58MPNOzbHSgAbyHljiLYzDFrRSndXKegZGwkJqwVGqxAi2fMRpwtbR7eByrXp7cA2ezrRac9cERCuyIzPez4YzNAg1yuWtQ/mfNV7dzxrzlSRE9/usXubvfc3RlNhoPIYC3EAI0E50dRrMvI9ESlPvtirCXojSPh1+bY0J/S0Ac/w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO0P123MB5583.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(366004)(4326008)(8676002)(66556008)(66476007)(31686004)(26005)(83380400001)(86362001)(8936002)(186003)(5660300002)(2906002)(54906003)(66946007)(36756003)(6916009)(316002)(6512007)(52116002)(53546011)(6506007)(2616005)(107886003)(6486002)(38100700002)(38350700002)(31696002)(508600001)(43740500002)(45980500001);DIR:OUT;SFP:1101
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iWtSMhcHrc9Pf77ggksNXeBm9Nb3h9ndf728N5A2Z8XPAszlG8tXh6BV51BX?=
 =?us-ascii?Q?hK5hA2I2yj1iOcoeiyuttThP7W3jjxEue11sUXDwPM7N2DZ3e4lq0F3RARhD?=
 =?us-ascii?Q?p32YJAJKl00TmkjxYMxkkk62qph+40ohCt//6/6PCzBoO0aqJblRybaxZNa/?=
 =?us-ascii?Q?96kHZsZRsVVsw8EozxggLQfkvigJGZfsforU8/PrniXtWEt3Du68yL0nnI4Q?=
 =?us-ascii?Q?TY7Lzk7A+EeRM0bKcqOhL1dmqXq+cLxS19+LZSr63X69qnUiQvX728lxsp1A?=
 =?us-ascii?Q?yxFbUcX5eUpO1V1eSKys9kXvf93Cl+5qV/NMZMUFW12y7j5BoNIMnV1YO6gJ?=
 =?us-ascii?Q?Z8RNp3MOX6Lm7e82KHHxS0opZcLdATuyuUahF71EK1GyEq+BMcGKb9cwLoOB?=
 =?us-ascii?Q?41I/A7Mw64lj5B6tUplpWPZDDrf0CB++18Wemu6FMVAf4o0S53N1T6Ai4J/M?=
 =?us-ascii?Q?dY12te6prENv7rVX6QcqbcWJ1wkSNEzBzMK/7i9wyKjFBiu5oFNHQNjvxJgI?=
 =?us-ascii?Q?8sNDFGn6xdlXfJZyV5qd6f5/Ptr3Qe9u7JLQ6jgGUsN9h+S4JT3/sDzo2egs?=
 =?us-ascii?Q?5aQivvb3DOMyLInKp02dh5weUNHZbHAvyZ70xWux9k3sMeOxejXhBmi/KBp9?=
 =?us-ascii?Q?4fzFHUXokOslemOVIBpkjKELgq5tHxF6GgGRhDmTifc7q2t8qcRZebC3IO97?=
 =?us-ascii?Q?zMB535dMa5G5JYarPmAbIkrJr9k2TX0+nlf/JG+vyifS6udCh2WIfRKPVTOu?=
 =?us-ascii?Q?pDqasn5dqvs42ZzE4S/0isbvgui5umoAFW3c6dvJyJrXm+GQLPohrayzRDqW?=
 =?us-ascii?Q?pjLhzni4OpwYWS0XY9NUiaUDWqEhfsfg4rKDmc0kWKhnDPe+a54FD8NqqjJs?=
 =?us-ascii?Q?wJ0m+a3MYw2RMOAsD2GIwL82HSlXDoEC0JhPJR2h4Lu50c0k43wPKLpZruf1?=
 =?us-ascii?Q?4fGcNuYLDYzVhUyx4mqtuaOjn5MO18qrU995DJ4WNtVuKPXsncTf5ysLLwNB?=
 =?us-ascii?Q?BdwxbyIz1IF6pDqluAu+K8rC3/3744p1sOYK0dhXlJMKYtfNBDfsDHZzxWwr?=
 =?us-ascii?Q?hNs6bL7fV4ZhEli22b7u4Y7UgW3xMxZzCijWVN5ih3A1Y3y8Q9J07utFbw0Z?=
 =?us-ascii?Q?rWo4lqVzqBs6X23J2luuV0/nYriHZp8RBSMxRtEtZo+oILjns6wRF9v5KTCN?=
 =?us-ascii?Q?Laj1XntpwYt+TpF/l2XjAcf1c3RS81405NiroDRs3G7DuHs81OJqCA1DdtcT?=
 =?us-ascii?Q?fic/irIYIE0CfZg9h2tFD8tEsJ/xeYQNeOZyyEF/MjEaHpV7RlD56YJNy9Dw?=
 =?us-ascii?Q?OMxvvdiIkTy92yDIt990ROKWcqNjhbgXbk3ZcmxgX8MhCZmP/0g0ao8jTDCq?=
 =?us-ascii?Q?vC48j/vm43pzbS/MLhyq88pGSnRncn7VwRSMGRfFAPByNufljVs6PSpHbIhi?=
 =?us-ascii?Q?RslpfR+rH5QRW7kR28CCNpYGKJs1KIP2hnv5/T9AYCmOXBNBT89bjdLYli75?=
 =?us-ascii?Q?e2eZgK9MGp/8moQNnlk1lD55p2FX2Hw7/cQNhDpT1IU+JmSzF6LpbvTrkwZZ?=
 =?us-ascii?Q?4E8DbRhVihl5yPvMjbPMkCtGjiMD6X/8a4dGFqyUVEdAwzNazE9R0G3i0c0x?=
 =?us-ascii?Q?isy/twBLWqMHbAc0x5d1ZqFGj4q7O7taK4BKRbtMcJz1uC7x9qNaEbPWpFt6?=
 =?us-ascii?Q?jlN6Ig=3D=3D?=
X-OriginatorOrg: camlingroup.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce58a64c-cb5f-4349-c40c-08d9f84260dc
X-MS-Exchange-CrossTenant-AuthSource: LO0P123MB5583.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2022 09:37:02.7496
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fd4b1729-b18d-46d2-9ba0-2717b852b252
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B3XL4PXan1s0q6PKJwyRmXZttdLytbk9rSA35wr/THIaGgotCnQBU91VAk87BrqHmx4V6fcx6i751as4eTxMEikQezeft+zC810++npAQFU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P123MB4910
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUK97A341 smtp.mailfrom=tomasz.mon@camlingroup.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: camlingroup.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 25.02.2022 10:25, Greg Kroah-Hartman wrote:
> On Mon, Feb 21, 2022 at 11:56:12AM +0100, Tomasz Mo=C5=84 wrote:
>> sc16is7xx driver assumes that the device handles hardware flow control
>> automatically. This is not really true as the driver does inadvertently
>> clear the bits that enable hardware flow control.
>>
>> This patch series solves multiple issues present in the driver. While
>> the patches are fairly independent, there are some dependencies. The
>> "sc16is7xx: Properly resume TX after stop" adds IER bit set function
>> that is later used in "sc16is7xx: Set AUTOCTS and AUTORTS bits". Also
>> the patches that control which interrupts are enabled are dependent on
>> each other.
>>
>> Patches should be applied respecting the order in the series. The whole
>> series applies on top of "sc16is7xx: Fix for incorrect data being
>> transmitted" [1].
>=20
> The first 3 patches of this series applied.  Please rebase and resend
> the remaining.

The remaining patches did not apply because the "sc16is7xx: Fix for
incorrect data being transmitted" by Phil Elwell was not applied.

The Phil Elwell patch was independently developed and made it to the
list before I sent the patch series. For that reason I based the series
on top of that patch and mentioned it in the cover letter.

I am unsure what is the correct method when handling such situations.
Should I include the Phil Elwell patch when resending the patch series?

Best Regards,
Tomasz Mon

