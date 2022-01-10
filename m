Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0781C433EF
	for <linux-serial@archiver.kernel.org>; Mon, 10 Jan 2022 06:15:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbiAJGPL (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 10 Jan 2022 01:15:11 -0500
Received: from eu-smtp-delivery-197.mimecast.com ([185.58.86.197]:38488 "EHLO
        eu-smtp-delivery-197.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234844AbiAJGPH (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 10 Jan 2022 01:15:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=camlingroup.com;
        s=mimecast20210310; t=1641795302;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aea6Hzk+jRgvcybw7FIPAlRIXsNyNXSoXdEJwp7h6OM=;
        b=HrVNah6W5sPSc2NYcQP2oCxyvqptNds2erYlc927stRsMZ7DLsBaZsb1lISO6fq+Xt3R4Z
        bRUT+Pn23IIW7RouqxBspN0L+3+vT6wWZpTgtQ26iIUikxQtlTS2O+xijdu+dUZ5kDpTOV
        xw1NFT1x3J9xQc9ZYUrhhk8VcMb2JCM=
Received: from GBR01-CWL-obe.outbound.protection.outlook.com
 (mail-cwlgbr01lp2054.outbound.protection.outlook.com [104.47.20.54]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 uk-mta-287-NO1ITspNN9eubI9pzr1d9g-1; Mon, 10 Jan 2022 06:15:01 +0000
X-MC-Unique: NO1ITspNN9eubI9pzr1d9g-1
Received: from CWLP123MB5572.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:16b::6)
 by CWLP123MB6147.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:1a3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Mon, 10 Jan
 2022 06:15:00 +0000
Received: from CWLP123MB5572.GBRP123.PROD.OUTLOOK.COM
 ([fe80::4c56:90c1:1ed:2ea3]) by CWLP123MB5572.GBRP123.PROD.OUTLOOK.COM
 ([fe80::4c56:90c1:1ed:2ea3%5]) with mapi id 15.20.4867.012; Mon, 10 Jan 2022
 06:15:00 +0000
Subject: Re: [PATCH] serial: imx: reduce RX interrupt frequency
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Sergey Organov <sorganov@gmail.com>
CC:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        Jiri Slaby <jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        k.drobinski@camlintechnologies.com,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-serial@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>
References: <20220104103203.2033673-1-tomasz.mon@camlingroup.com>
 <YdQndwYc9xaauvpS@kroah.com>
 <7e509806-77ae-8f94-2563-7dbae1ebca17@camlingroup.com>
 <YdQxmQ+OMCrabg2u@kroah.com> <20220104224900.u3omfbilejx2jawr@pengutronix.de>
 <87tuei4882.fsf@osv.gnss.ru> <20220106150552.vdt5qabe2xj4kasg@pengutronix.de>
From:   =?UTF-8?Q?Tomasz_Mo=c5=84?= <tomasz.mon@camlingroup.com>
Message-ID: <a6f0b0dc-da67-2488-16b2-40f5ad049fde@camlingroup.com>
Date:   Mon, 10 Jan 2022 07:14:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20220106150552.vdt5qabe2xj4kasg@pengutronix.de>
X-ClientProxiedBy: LO2P265CA0150.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9::18) To CWLP123MB5572.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:16b::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6152df28-7345-4a14-b949-08d9d4008829
X-MS-TrafficTypeDiagnostic: CWLP123MB6147:EE_
X-Microsoft-Antispam-PRVS: <CWLP123MB614770E167ABA7222EEC6BEA92509@CWLP123MB6147.GBRP123.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0
X-Microsoft-Antispam-Message-Info: Kksp6+VkW1VlpnS7MR1E3AjniU5TS6sG8ZYo0NquY8keqZT21glZaPKzLIJPTScTKIS5pqJye8O8n1dhB+iDYulZjjuzBb1K8jRRCe3NhjVsf8gWEEieHWvPga3OKi3jbtsY6kqrmna+p3X7n5xIYz2kV7OHhu9Ngs474m46e2QkOzQMtQzI5EdnUpGhK8cVL48Rv6paCWBwwARa+xJSZcdJIhmHbqHDGIJKlkR9KZc+f99PNFyFe5RgxnesYezAO2bGIcormw0feseZj6Ks0pRz98XU+UZeXLx6NJYXm3qoWA3SWnxh03mhbb3x8erAe7pzXlKe9Rs9p65A9oFKn9mm92KvSyNYiaN3MXDB7Ug5HT45XbPsWtics1/LnZ82iLdhqslNtGWKC5uWhzuDKHWVuCWAdv/lQjtBM3j/+BxLQ4WuARFXwzAn9EZ8Qiqxxax0KUFJb9fgq5Ct2IIgnrY0HYVQZ5XYULU3GpRtzV8Tm63Hwf9ablqcUStNyPdPqqeNyihakTA3nzJXmBKpTLkvFrf47FoDWMrzZmZ32wZFkw497IWYuR/5tGaxFb5xG690z/4BSmr7kMLwA2sBC5+jnJVMfkwpWBRG5Pvwf3UMNriGzVoDMv1kICHRD+YSu5EIlap1pqw3pLtIDDu442C2g/JUaX6haElEboRhLGOLCWZTGSNmeJ0gc+mM0ul4dA5/Z8XVZBwm/h6XbSxq/a959pofzxpqJvUmQU2J1LdCiyG53XeLzepsAVapWM7k9eaA3ybcp1V8mAz16NtBtA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB5572.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(366004)(53546011)(6506007)(86362001)(2906002)(7416002)(508600001)(316002)(8676002)(5660300002)(110136005)(8936002)(54906003)(66556008)(38350700002)(6486002)(38100700002)(66946007)(66476007)(31696002)(36756003)(4326008)(31686004)(52116002)(186003)(66574015)(26005)(6512007)(2616005)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GvN3jBKBnsnEzxXVXHLJMkFp9TJkfX7xjY0HHsHrEgG408AW1WokvXHm7+mI?=
 =?us-ascii?Q?T1M84ZIKgNElH2As1Axg8FoEuyjMwep23dmHjULgv2RD1V0AIWhSwejOijJL?=
 =?us-ascii?Q?SNGrw/UeGMKX1KnCyVT0lb9JQ8yGVNA6luMGZJgNAdcZMtPv1t3c4zsBCRUi?=
 =?us-ascii?Q?E62d6bvUq+Gd7e9tfmWJ6qSosMMXUzqwqmSWf3cQe/RnWwC0KMxZKF4D62qk?=
 =?us-ascii?Q?O/mK3DuiD8XFJfTp0V8OKwU/btN2EuNiPibTjKj40ATq//d/wvDUX4DwWSpy?=
 =?us-ascii?Q?O6Z3VquqZY/rWJusArdxB27U8mlBmOOLuXPZP62nnT55ygSOe+xat6vSdN5+?=
 =?us-ascii?Q?emdgBz9n+4Lnd5/ey98jCxIFpR9XmcwDaJB+XH9T9w5MJgUrHMzzeH4uYNvq?=
 =?us-ascii?Q?SrYdV+XxXPdfz35zZn8j08MsYLVj37/Pj13spW2lPrnGWyHmukggX6UbD2QI?=
 =?us-ascii?Q?fQTJ421+Uv0NB3hrwXS4D4rYIDdrToKFzpHtZWjhKtINH++if41nrdetK99J?=
 =?us-ascii?Q?hnha3LQv0AbVQzQiXaaP4fpbHN4xFtridhZWXMQ+ngoXJIrHkmj2AMlv6eFk?=
 =?us-ascii?Q?npljOsaYjzZpv/I1EgDMzmgSD9dcuEyZeTVU7D2gu9aAgllJzBwCuw5GYfu7?=
 =?us-ascii?Q?KbzLP6JPrxASvH6VQgE0seGzKHVoDwk5T+9c0Cbhvt/zwJu6LahNd6Z4HJ2h?=
 =?us-ascii?Q?24n565uH9EINndgWeQKkeFujn8/6/Kh8TSWrUwqWXZondWU+YtU2ivFE6I1x?=
 =?us-ascii?Q?iMwk5Rt3WYsgfWrEJwmtYD1ENPnwJM79EVm73taSb4MPBgGzF0AQLNyKqh6J?=
 =?us-ascii?Q?wi54BiRQXzvHN6TERxXvlAlnlT6tGEfX/E9Sx0PImGsif3t59QudxBt5oEqL?=
 =?us-ascii?Q?FaC1G43F/3IWKP5xNHD9bVSYAXOKwqUpYHVXE+ni0IBWfV5Oqf2DLjtD64Ac?=
 =?us-ascii?Q?Of7qKoWjjGiStTo8AaNGG8H1Gu5YAkGCejqA61UmRiUIz/kUYdU2MUs+TNNZ?=
 =?us-ascii?Q?2w58pWud0LmRX0TpgYgzP6jSQBux1taVoZFPHWnpPcpjjbt7rEMfBwCIZ1kg?=
 =?us-ascii?Q?OzKMsV55/7XoqvBOnXv1UAIhVkV9OMFDTACqdUrp3Hg5ydgR6169TlL6bTOw?=
 =?us-ascii?Q?pwa0RRp1CJ4j+b8szTl8SuBvKR+Bw5KPHT+aZ1ixATND+vBInqyVVP7TCv1C?=
 =?us-ascii?Q?YGwdrVCT9bRBwWy6PqYQI+X2ffxiN+HJGtl9U56B8haTZ1cq9v+vH+pAemO0?=
 =?us-ascii?Q?YfQm6fddoq6hlmFJc6895ZNRzHa/cmj9EJ2RAKLJyF7cL4JTdy1HgxRe2s9g?=
 =?us-ascii?Q?n6H97yKOsiTkjuPTzvT5R4hKSYIAgp9cmhYv/FygunLVo8GRGyZYaUtOIWYB?=
 =?us-ascii?Q?r2aArecVIifJb0P1l/fBqPpTRClAno0CltvD6GgrwHa3X0YcmCagNoAprw8u?=
 =?us-ascii?Q?EI3Pmm7JiMgK1mGsdiaLCMCwsYqt6JNyyy02rmyqPbGZf8oSxRJB3emTCgL0?=
 =?us-ascii?Q?38m5K8gZcOvLwH47WlazlWq+GPxf9/c09Z87BqvHRbGcEqPnKrtkBzCAaBfR?=
 =?us-ascii?Q?M8NJziTu6Q7z2kU8S6ptkrknF95eIyYaC5rcL0rXAfhYAly+lXqioYDThKcu?=
 =?us-ascii?Q?YQkx6BBWYL+d7ssTYQONNSYYz1X3+XJlPeVPZtFSCbzHtfAcf0NXbO1p95yH?=
 =?us-ascii?Q?TDSXXQ=3D=3D?=
X-OriginatorOrg: camlingroup.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6152df28-7345-4a14-b949-08d9d4008829
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB5572.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2022 06:15:00.0878
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fd4b1729-b18d-46d2-9ba0-2717b852b252
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EpKaIrKbo3PCoLL2om3jzC944M7qmvp+RC5vJP5kx4oUSy7Bd2iLTtskjdOiUu+vwd9aCP3M6nSmAIHZF1hz4XYYovbrCXYLKBW9QHH7oBg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP123MB6147
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

On 06.01.2022 16:05, Uwe Kleine-K=C3=B6nig wrote:
> On Wed, Jan 05, 2022 at 04:34:21PM +0300, Sergey Organov wrote:
>> Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> writes:
>>> Maybe it's more sensible to make this even more dynamic: e.g. keep it a=
t
>>> 1 as default and increase the water level when a certain irq frequency
>>> is reached?
>>
>> Too complex, and too many questions, I'm afraid. What is "irq
>> frequency", exactly? For this particular driver, or overall system?
>> Measured on what time interval? What is the threshold? Do we drop the
>> water level back to 1 when "irq frequency" is down again? Will we just
>> create re-configure storm at some conditions? Etc.....
>=20
> It could be as easy as increasing the waterlevel by one if an RX irq
> happens with USR1.AGTIM =3D 0 and reset to 1 if USR1.AGTIM =3D 1.

This is indeed simple, but I fail to see the actual benefit of doing so.

> This makes sure that receiving at a low frequency makes the hardware
> interrupt the CPU early, and a burst doesn't starve the CPU.

If the communication involves multiple characters sent in burst (frame),
and includes some sort of CRC check (so only complete frames are useful,
as no partial processing can be done because checksum has to be checked
first), then it is the latency after the last character (not the first)
that matters.

RXTL upper value has to be capped. If RXTL goes above CTSTL then it
would limit throughput if hardware flow control is enabled. If hardware
flow control is not enabled, then the higher RXTL gets, the higher is
the risk of not reading RxFIFO in time. Setting RXTL to quarter of the
RxFIFO (8) seems to leave enough time for RX interrupt and at the same
time noticeably lowers the interrupt rate.

Best Regards,
Tomasz Mon

