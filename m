Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2305C433F5
	for <linux-serial@archiver.kernel.org>; Tue,  4 Jan 2022 11:05:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231262AbiADLFz (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 4 Jan 2022 06:05:55 -0500
Received: from eu-smtp-delivery-197.mimecast.com ([185.58.86.197]:27273 "EHLO
        eu-smtp-delivery-197.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229504AbiADLFz (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 4 Jan 2022 06:05:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=camlingroup.com;
        s=mimecast20210310; t=1641294354;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/3yBPLekbwvR3qr47YkE3ycuaci9xGDUd7SNcLQ532k=;
        b=XKI3gWI4BqXUAUzx3zTM525WxKO9Cmkkhs2K7Z4uZ5Qg2gHJ9zTibaZCWUG7tUFMoQ7OD8
        Ux/1Rc6DKPaO21h/lN4HYRXPHBPySCBgGjDYuTo0eKOTMkkB8NFhmnAOw8IprmoMlCJb8s
        G1cNt2rc42bQ2ZUTFGat5pZFuW11Mq8=
Received: from GBR01-CWL-obe.outbound.protection.outlook.com
 (mail-cwlgbr01lp2059.outbound.protection.outlook.com [104.47.20.59]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 uk-mta-9-1I6inF8GPF-S61YjgRxL4w-1; Tue, 04 Jan 2022 11:05:52 +0000
X-MC-Unique: 1I6inF8GPF-S61YjgRxL4w-1
Received: from CWLP123MB5572.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:16b::6)
 by CWLP123MB5771.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:13e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.13; Tue, 4 Jan
 2022 11:05:52 +0000
Received: from CWLP123MB5572.GBRP123.PROD.OUTLOOK.COM
 ([fe80::4c56:90c1:1ed:2ea3]) by CWLP123MB5572.GBRP123.PROD.OUTLOOK.COM
 ([fe80::4c56:90c1:1ed:2ea3%4]) with mapi id 15.20.4844.016; Tue, 4 Jan 2022
 11:05:51 +0000
Subject: Re: [PATCH] serial: imx: reduce RX interrupt frequency
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>,
        linux-serial@vger.kernel.org
CC:     Jiri Slaby <jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        k.drobinski@camlintechnologies.com
References: <20220104103203.2033673-1-tomasz.mon@camlingroup.com>
 <d534d6c2-3f70-3753-62fe-54737ffbe384@pengutronix.de>
From:   =?UTF-8?Q?Tomasz_Mo=c5=84?= <tomasz.mon@camlingroup.com>
Message-ID: <4bf9e1dd-e99d-f6ac-ea8b-3796248d9947@camlingroup.com>
Date:   Tue, 4 Jan 2022 12:05:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <d534d6c2-3f70-3753-62fe-54737ffbe384@pengutronix.de>
X-ClientProxiedBy: LO4P123CA0080.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:190::13) To CWLP123MB5572.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:16b::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 102dc611-7406-43af-8ceb-08d9cf722bd9
X-MS-TrafficTypeDiagnostic: CWLP123MB5771:EE_
X-Microsoft-Antispam-PRVS: <CWLP123MB57718D7E6BD46B2F5B44166C924A9@CWLP123MB5771.GBRP123.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0
X-Microsoft-Antispam-Message-Info: 3dCJIITmLXdVc58BZsWz1K9bIGcDloF+FowusH1ytB1/LmTgiCUZmsj1vshLwEM6H99Dc3iQ1ja+HaLsk0NhAobJ2KtXk8bpiGFrMFkauT2OffABAoEXqbYtuu4wGEYv8qTk7OAkZ3vvdluQkQBFH4felITQcQcQx3hwW7sYTjxBYV5Sg20LpfK+6BBdFygv1ucG8W1+GwvWZ3m6bISe2aXjwZOE5pruSF6q1z3VZiz0I3X2kiYvGLXJK3S8Xad+lhiVO/HBxhHZv6/2hB2xiGu/lDAsyrEFo+IyAwYk42i+DP1PYI+nvcSVOz6gc0ngaYPkzLLxHvyiHTKYwUFpNyO60KOtngPzbG6bu+ZvSxHIne1Tj1IYPSTW2ANh4fucZiwnCAE/C+305C/F0I8K0e1BqTRHzR1iwP2pu33I03n27KONOA49twpFKDOcAq3DdMI97sHplaR+VEtZGOzwIYnSz3Wl3Z/EL8tcH/vstpydFeh9DDIXwTbGMMWGAVoEopYah9Xt2PxWcv4q3yNuaWwlj0z/LSDLLCrjHXOIiGK/mdEqjDJuI5c+ysp51srOp6nZu5HdPgW73MyO9fhNubYEAQRkyZIr70gOlxG5iQYZtgs8Z7fGKCG/IRkHN0it2pG3i4P3hO/DyMKpO4Loj9c2Nzpv+MU2DNGuWTnf8kjJ6wDQGHv1+k118QP5el/CSLKpeJH3yBgtEwdw8X75WmA0eMFXfse20FJ0PrEJ4nSzR/yCk3qtHrfrkCUry7czBJOQHYjxC0j9FUHCLpigbw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB5572.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(366004)(52116002)(31696002)(316002)(2616005)(5660300002)(54906003)(31686004)(38350700002)(26005)(6506007)(8676002)(38100700002)(4744005)(53546011)(107886003)(6512007)(66476007)(186003)(66556008)(508600001)(36756003)(6486002)(2906002)(8936002)(4326008)(66946007)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tzx+ErI9TGys/3pJuN0uNK9TT7jN0nZmukPFeU7+Gf2F4TMKis0R1gkS3Mmp?=
 =?us-ascii?Q?BB8Dx6MEf21QbmuZv0E3XxMKJ9R7SpLTP5RaN8AdJ/TqW1uxKl2Y1M8jbJqE?=
 =?us-ascii?Q?s6gKowP/Ds9SnSYUd0ZhwwSEZTJcABCCV3EWEDaGUmHje+/cTnLzHpc2V1Pg?=
 =?us-ascii?Q?/JfK/vuxUOQTF/ayjLu6BHz1sjgdbC/HxdJF0hLadLRiGg2DsOXIy4sQctfC?=
 =?us-ascii?Q?Yj1IbV2cGgfUjWPiig7ar7Sx8PqRep1ACEjBiseh/T9N3qwaB2YxWebgkZ0E?=
 =?us-ascii?Q?Xg6Dfpsk7jMircS4tfKXcKBl9cVZc8yDW+IJNONikbip661EVr122UyWxupM?=
 =?us-ascii?Q?LjLZj1FVa35FOKwE6BjKFtoNI5YqFKJAJ5jGnyVCOAu87ua2KmMZyZ6bZU1I?=
 =?us-ascii?Q?O8TTr08ZxZCS3vYBqJPumQWtj/RrvoH7sqU039avEV/Opjg1E85EAkltTZy+?=
 =?us-ascii?Q?Jb8AKhTHxK7NWkJvliqPQ49bUkxsdb8XxEXrHp7qd4pjdNx9kN+BfMZbFuXL?=
 =?us-ascii?Q?CulkvMXkWn9XGbdYmMMTN6GGwg46Fb+XDKUKSVByqvsvwSuHFxaIjK3B7+Zw?=
 =?us-ascii?Q?Q+02b49gXwG3eNOLXw9MWfLeJcCB+nDWPBLeD09F0gAcCUBX6a17dvIq5jzI?=
 =?us-ascii?Q?J5f7KtGLBdGdZawYxJ23k/7d5+hCpsMpYPenzZ4qRMUPjqhN9slWC8/QjeE0?=
 =?us-ascii?Q?lZok6AJLAKJGkZ+BTsdwN1d0Y/qYpWB9sCtVDzTEp5RL2TDQTbiw1SNSJqpf?=
 =?us-ascii?Q?wb5gBZ/0688v8A8GTkfE3ppCUdAVcCYJKpdqgJmYs9S/pxguWKysNjuiTjWb?=
 =?us-ascii?Q?/AQNIbdT2barjEv4/+/1jKE4JNnpkhbxtUfW/+Od3W1wuGjWvgMABft/5xKK?=
 =?us-ascii?Q?69OtH2p5ahDO+BBBtulu5Nl875G5sgBtz+I9B8FfrIicJp2lfLJp55bQSMn3?=
 =?us-ascii?Q?1lYBeVp7WwtMDerifGr1b+0w4/PIHZVFrEsujg0wIL2Guos/Qj3Ria/cKcYl?=
 =?us-ascii?Q?BrN3zwe18rqBAHgL/urCqw+OqzJ/o4IQdhyEVS5dClVMY5MANoKAiRHkXDQB?=
 =?us-ascii?Q?xTzrtSPvWmw7cnyYF49/3epEY6/d+dVpvubwORPCCEefkr13W60upzXqJhV4?=
 =?us-ascii?Q?LWEHUS/gzb01og8T/swPtGiTqL5Hm1DiGDNboq42FEQStvvzdMU2yBskJwzw?=
 =?us-ascii?Q?7CDetRWeEAQZUmdLxftU9fdKnuEbPPoNx/w0LJssAinQopnQ0/66c4LLmf73?=
 =?us-ascii?Q?EMpyO5kekAPww9NSZkp6tJfzrfzoESNSPkzWPMy/5Rt+OPZtnqWCyvuPhMLq?=
 =?us-ascii?Q?mZe0GlPoW8UcTANIolfbBUOtu46wUTZhGE1JDpjNf+Gp+0M978zE4K0ymJ+j?=
 =?us-ascii?Q?sDYM0Hjaf9kfxtJ3WIt568L+ctwjOfi3lpgQYhOL/M87ZKgvIEeBgi0SY7jw?=
 =?us-ascii?Q?n2IqzztdL2nUP8wIjnHLCyMXfupqrCNF/o1577d4Z+lwFm6vsijsPAK8vWNO?=
 =?us-ascii?Q?7ZQxjHVlPLEgXkfr8GluM1xG4FKfojsZCHu+ezlnTvzE4zWJeNyhcnA8tJaJ?=
 =?us-ascii?Q?CjaRpi8dsWZeHesWLT6ccP6N8dhFwHoHrAjgQwaUF84FPheK3CKZqp5RTzSI?=
 =?us-ascii?Q?+7obPmqb6phKUySk9bvX0/cOjbCamurRCFiXLXf9f2QQD3ZG1RnWCOpKwjXr?=
 =?us-ascii?Q?9k2GKA=3D=3D?=
X-OriginatorOrg: camlingroup.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 102dc611-7406-43af-8ceb-08d9cf722bd9
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB5572.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2022 11:05:51.9316
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fd4b1729-b18d-46d2-9ba0-2717b852b252
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R3NZBmIP4Bx6s2NwjdObaMpt3uBUeu/0xZcNkq7ekMAo8ezEG2Jl5lMVhpq/EjUg/MPPmHFY1hrkhP68ySMPEyePptrPb2NV+Hp4u5nh8EU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP123MB5771
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

On 04.01.2022 11:43, Ahmad Fatoum wrote:
> On 04.01.22 11:32, Tomasz Mo=C5=84 wrote:
>> Triggering RX interrupt for every byte defeats the purpose of aging
>> timer and leads to interrupt starvation at high baud rates.
>=20
> s/starvation/storm/ ?

Yes, absolutely. While it starves the system, the proper term here is
interrupt storm. Thank you for pointing this out!

Tomasz Mon

