Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4F86C433F5
	for <linux-serial@archiver.kernel.org>; Wed,  5 Jan 2022 07:59:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238264AbiAEH7R (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 5 Jan 2022 02:59:17 -0500
Received: from eu-smtp-delivery-197.mimecast.com ([185.58.86.197]:34287 "EHLO
        eu-smtp-delivery-197.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229880AbiAEH7R (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 5 Jan 2022 02:59:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=camlingroup.com;
        s=mimecast20210310; t=1641369555;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uIxtCd/oMaV6nmKv9f2TP5drykD4D6wu3jUWg6V9zfY=;
        b=at3nCXeA05mukiB2BEfdok9udcL5dGu2I7Oz4A8cqEXmXYgBNcB30X7nvpcLTJM2lLLdcE
        JkugC4Aft5TKdt+gDFsYig0iNKlLHY+6umAF1gj2WOQaPzaxgd5ip4KcS/L2uQCeuTKN88
        6wEcaNfvoJJicUsGaDL983ho/Oh3tec=
Received: from GBR01-LO2-obe.outbound.protection.outlook.com
 (mail-lo2gbr01lp2053.outbound.protection.outlook.com [104.47.21.53]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 uk-mta-15-uuuIv_hzM52VTazoFE5edQ-1; Wed, 05 Jan 2022 07:59:13 +0000
X-MC-Unique: uuuIv_hzM52VTazoFE5edQ-1
Received: from CWLP123MB5572.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:16b::6)
 by CWLP123MB5369.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:14c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Wed, 5 Jan
 2022 07:59:11 +0000
Received: from CWLP123MB5572.GBRP123.PROD.OUTLOOK.COM
 ([fe80::4c56:90c1:1ed:2ea3]) by CWLP123MB5572.GBRP123.PROD.OUTLOOK.COM
 ([fe80::4c56:90c1:1ed:2ea3%5]) with mapi id 15.20.4867.009; Wed, 5 Jan 2022
 07:59:11 +0000
Subject: Re: [PATCH] serial: imx: reduce RX interrupt frequency
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     linux-serial@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
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
From:   =?UTF-8?Q?Tomasz_Mo=c5=84?= <tomasz.mon@camlingroup.com>
Message-ID: <4c48200b-cc2e-0766-a002-831a789d4879@camlingroup.com>
Date:   Wed, 5 Jan 2022 08:59:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20220104224900.u3omfbilejx2jawr@pengutronix.de>
X-ClientProxiedBy: LO2P265CA0186.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a::30) To CWLP123MB5572.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:16b::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 93bc3503-fd41-413d-1dcb-08d9d0214212
X-MS-TrafficTypeDiagnostic: CWLP123MB5369:EE_
X-Microsoft-Antispam-PRVS: <CWLP123MB536923F2C024F0880C826110924B9@CWLP123MB5369.GBRP123.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0
X-Microsoft-Antispam-Message-Info: flM5oZkIJu7Ea4bVJObacRH6Oh82tiW5XgPhDI+qtNB6dWd4vzVp0mLTeaFt5Lsi9aB7SpMLyTYMXQYJqFEpNQZAskSf0fZXuxA7Z33IMpths7tdPd0eqRyqijRP1MH5VD3mgZ7K29n5grlGTB5o/o/KIzoaakH4bsWab9ycJPr5A6AuSqk8G4E9sRkaLo4+WP5/HDQ2izLQXIxOFzWl4ZNeAljwWUJs4qB/E6rwC+H5LbWfPAwkbpHF7zs1yKNiNdcSb3Ip/2Mt5rcbIB47wyvga66DzHudLZ3dxsVYhDVanTEtozaiGYvmhzxuMQ01dQgp665i56j/JqdWmvJB2AK4IZstTP68ctAC1JDN+/S1CMOVz1AFHODsCt6HVVoFLCvZO9foU4Keu6W8CaWHtQJQdnS3QWQOhH68sqfIND4QvNbybyOJGfjmScDHiVGfj7Mod2rId55sEoruEtY5fZjCM6gTHe76L4mjvwX+RYs1HZngVgSN3Znc4EPeF82Dz80CEaWwHkbJf30+B2buOjYvRmDk+S/+gHoPyoPI//otFspEIZplnDD2FAm0whK+HRD4Yr+o5HLTeB4SDMD/nDlVAgxhXARK/V8ZI1RnNWUlT4aXH7gxf//sUKDV76zeMMpq2snvTHP70As+EG9nsc8wrvx+uAozNA5nTYPmvn2q2XokPIqOT+lKE+WQYPFsvGABavMhLleDUxqwo5FnIQCWkPmxm0EM/nilIacb5iNUc+Kkhj3XYzXLYLncmiW/bUdQc8okMQMJZ2Aah0K7Dw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB5572.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(366004)(5660300002)(186003)(26005)(107886003)(2616005)(316002)(66574015)(83380400001)(8936002)(54906003)(110136005)(2906002)(31696002)(36756003)(86362001)(6486002)(8676002)(66946007)(53546011)(6506007)(66556008)(66476007)(4326008)(38350700002)(38100700002)(6512007)(508600001)(31686004)(52116002)(43740500002)(45980500001);DIR:OUT;SFP:1101
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yYl8rHcibB5eJyHhZBNuoUG0m294f7Qz3p5tzIKLk3AwwBYtxecDZ+NVZ0aX?=
 =?us-ascii?Q?DI5QZlYgwAjSYCZ54t9VFqHuUHgkJcCa39QuULaj6m7FQbaFr0yyZuV+bwPb?=
 =?us-ascii?Q?8XJzTHLLBzXA546G5U6VPfrneGY3cfssVyI387A6ENUMZNXcbRXV1zMrzmns?=
 =?us-ascii?Q?6R9pwsRs+kTh719i8yBnSIEaWjggce2sR9qInn1rQaL4ANdZ/cU64b0GiFxn?=
 =?us-ascii?Q?Y0dItNum2tBXttG49F9PAAeq0mtcVPSJ9/vwkFtwqolR6bQHs0g/X08/dRTW?=
 =?us-ascii?Q?UERaKkV1HpfLsfj/qZgiLrDWrP9G+lyxDMBkzHYDUANo3trDovbpmRvyK4Dx?=
 =?us-ascii?Q?WyAPGNkXLveYfapZ8bd3h21fpyZXKJbfmYoCGr3RNtt1fZJZYFAH0GHnPRmh?=
 =?us-ascii?Q?ohJvufUZPvpf6d+DSS1mx2e6UdE8MWjO/LF/8IVrr7gkyljxxKKlKO1Kxmo7?=
 =?us-ascii?Q?IjYfk47REeNbl5MBiNhBuc6MDPdujhIUhkhQHEXuv8TfbYQVty5vuadQaAqS?=
 =?us-ascii?Q?scK5EifQ3IATd3eGM8g4UAorLJ/W1LE709UNip0ylU5vR9lYUtcxSHfl6Gq8?=
 =?us-ascii?Q?2y5ZuobIuR0vqwRre0NmeOfhNCOLR2RPv1sqsHJaoFFTdU5q8/DW+RhcFE96?=
 =?us-ascii?Q?EjKr9epxSu1xVJ/7f4Jlpis4COCB1SlnL81RC+bY4KEeZqh2lqpOOrJFx1CQ?=
 =?us-ascii?Q?y5HNw1tpYZN4ExcC/Inx2VARPWtd9uBitYkHP2NaTiDJY4oBPes1PB5wDaU1?=
 =?us-ascii?Q?DizVMi5iNS97spctw7HxuoBAhXw926CXuLpvgcDI0sKvUCaKiF/Ij5fAUaok?=
 =?us-ascii?Q?tTcQD1eHjyybLspLL4imhOe+n2dhIv7hG2OJomD3jlbO1lhKvVQjrb0JiO8m?=
 =?us-ascii?Q?rqPJBwKBl1KFvXQ3hxw2G8zZnudITvjfvlUBh49bhP88SurIoPxhNDF7bNT/?=
 =?us-ascii?Q?wsey1Byf4U+pmS2w1ipKM3o31erE7l4HBuRI3+jih+Ugboa1ZfYPx98ax+4Y?=
 =?us-ascii?Q?d5t6ZmX13/CtqXGhL3vFUMaBpAsrasVXW+FdCGGojO7ihcR0XvFHprLR8bz8?=
 =?us-ascii?Q?sFsQa1f0QNXm6ma63ZbkVYtWvuQWwD3KeFPS/BlqMStDsBLQgGtSQDfqylcQ?=
 =?us-ascii?Q?CU4HWRAobcCplO/w2fhGrCi46Hc+vymBU7/H9U1QmOWmc5RzqsB0qaNUazfk?=
 =?us-ascii?Q?2Okbaqirxn+ZgSahpkE86HkcrmpuO5ySMX8y36i6QRDW0bpeUS7L0RJKuYV+?=
 =?us-ascii?Q?80RpuuUmcg4+HhNP535PaNgN66GPavzoEdOfX0qoSsOH567LzGmj8wDSRDFt?=
 =?us-ascii?Q?EtDPt1Qnk2dh6VInLWP92FJuLJqe9eYCi1rkNAF1148+VHT2SL60Q4OXbcNo?=
 =?us-ascii?Q?1B+PkFQZZrv5Dl01+TQIaKaJ1DeSnQRxbOQEXSL573/eV7FiL7VOC4vP8itk?=
 =?us-ascii?Q?lGTiPe+LIJ0vcQLQ52NXIZbUfXEr+nCB6umPtX6dBnsjOoYTPC4MV2ff7AJ4?=
 =?us-ascii?Q?436OUf7a6pHxwRmoASsCAsXO1BMRmV9fljo/Koe0Cf1NrNIWM+8QHzrD5XUN?=
 =?us-ascii?Q?yrw98ot/9OJJo5gLTHhQ13M8xSBvak0fjxidx1rVojaBb6zsF/nBYwG5lQ9v?=
 =?us-ascii?Q?I+HOsYOpQstooXyTeonqkJpx4NMmtcij3OGcSHTG++94iCVK39MHBvDNio50?=
 =?us-ascii?Q?mtfMRg=3D=3D?=
X-OriginatorOrg: camlingroup.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93bc3503-fd41-413d-1dcb-08d9d0214212
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB5572.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2022 07:59:11.1711
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fd4b1729-b18d-46d2-9ba0-2717b852b252
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7XdRTqkjsF13bRf3Hf5XDW9nRf55oxzymIreMayUjiwobRSuIWjBF+3dWpkcAntWQZPE6Ar92MBRogvUpIprVE57oHU87DWL34z30JcKBMo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP123MB5369
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

On 04.01.2022 23:49, Uwe Kleine-K=C3=B6nig wrote:
> On Tue, Jan 04, 2022 at 12:38:01PM +0100, Greg Kroah-Hartman wrote:
>> On Tue, Jan 04, 2022 at 12:13:06PM +0100, Tomasz Mo=C5=84 wrote:
>>> On 04.01.2022 11:54, Greg Kroah-Hartman wrote:
>>>> Why can't you do this dynamically based on the baud rate so as to alwa=
ys
>>>> work properly for all speeds without increased delays for slower ones?
>>>
>>> Could you please advise on which baud rates to consider as slow? Does i=
t
>>> sound good to have the old trigger level for rates up to and including
>>> 115200 and the new one for faster ones?
>>
>> You tell me, you are the one seeing this issue and are seeing delays on
>> slower values with your change.  Do some testing to see where the curve
>> is.

While the increased latency due to this change is undeniable, it is
important to note that latency is not everything. There are applications
where the latency is crucial, however using Linux for such applications
is questionable. Linux is not a Real Time Operating System after all.

Latency is simple to measure and argue based on the reception of single
character. That is only a corner case, not fully describing real world.
In the real world, it is important to consider the overall performance
improvement. It is hard to determine how much does the performance of
the system improve thanks to less time spent in interrupt handling.

> Maybe it's more sensible to make this even more dynamic: e.g. keep it at
> 1 as default and increase the water level when a certain irq frequency
> is reached?

The more I think about this, the dynamic part feels less reasonable,
i.e. all the extra complexity needed seems enormous compared to the
potential advantage.

I have hacked in a GPIO toggle at the end of interrupt handling. This
allows me to measure the latency increase with the oscilloscope in the
simple one character reception case. Latency here is defined as "time
between the stop bit and GPIO toggle". Note that this test completely
ignores the user space impact (process scheduling).

With RXTL being set to 1 (aging timer effectively disabled), latency is
within 10 to 20 us range. This time does not depend on the baud rate,
but on the system, i.e. cpu frequency, memory layout, caching, compiler
optimization level, other interrupts and so on.

With RXTL being set to 8, baud rate set to 1M and 10 bits per character
(8N1), latency is within 90 to 100 us range. The shift by approximately
80 us matches the expectations as it is directly induced by aging timer
(interrupt was raised only after aging timer expired).

When DMA is enabled, baud rate set to 1M and 10 bits per character
(8N1), latency is within 100 to 110 us range. This is somewhat expected
as the main latency contributing factor is the aging timer. The extra
few us is likely due to the DMA overhead (not really important in real
world where more than one byte is being transferred).

Usually serial transmission happens in various length bursts (frames).
For such transmissions the latency induced by the aging timer is
generally equal to 8 characters time (when the frame length is exact
multiple of RXTL there is no latency induced by the aging timer).

Worst case scenario is when the intercharacter interval is slighly less
than the aging timer timeout. While this is possible, in my opinion it
is highly unlikely. Aging timer latency upper bound, mentioned in commit
message, is equal to:
  (RXTL - 1) * (8 character time timeout + received 1 character time)

The real advantage of higher RXTL is avoiding interrupt storm. With RXTL
being set to 1, I am able to trigger interrupt storm at 1M and higher
baud rates when intercharacter interval is virtually zero. This is
expected because, as noted earlier, interrupt handling time is within 10
to 20 us range. As the interrupt handling time is more than the time it
takes to transmit single character (10 us), this inevitably leads to
line discipline workqueue starvation, and in turn to dropping the
characters, because eventually:
  * tty flip buffer cannot take any more characters,
  * tty throttle does not happen due to interrupt storm,
  * RX interrupt is fast enough to keep RxFIFO below autoRTS level.

With RXTL being set to 8, minimum RX interrupt period is 8 characters
time. This happens when there is continuous data being received (no
delay due to the aging timer).

If changing the default RXTL value does not sound right, then maybe RXTL
could be configured via a device tree property? That way it would be up
to the user to tune it for the application.

Best Regards,
Tomasz Mon

