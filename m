Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 737E3C433EF
	for <linux-serial@archiver.kernel.org>; Fri, 14 Jan 2022 06:19:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239348AbiANGTl (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 14 Jan 2022 01:19:41 -0500
Received: from eu-smtp-delivery-197.mimecast.com ([185.58.85.197]:34535 "EHLO
        eu-smtp-delivery-197.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239347AbiANGTk (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 14 Jan 2022 01:19:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=camlingroup.com;
        s=mimecast20210310; t=1642141178;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rbS95TOfkbtrqNfdDxirlhwYTaw3Z5/xVHQHaMAMgDU=;
        b=QqPy/FHrwyFWjAexPyshFZYQYcA66Q0yP2tCD5hxGY77wbdFH0vThmnHVYR6PvawWYmixA
        1Iswnakk+mOD/mD2KMBEh1G89SJsOZ/VsbTV3R5Qx3qUBd/kKxSdttJ1wxKEMebQuCy9Ak
        tTZ8CFoRpCC5K51RFvRIbDfxobRetNw=
Received: from GBR01-CWL-obe.outbound.protection.outlook.com
 (mail-cwlgbr01lp2051.outbound.protection.outlook.com [104.47.20.51]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 uk-mta-232-eNAemDzMP3yLMlSEzQpIBQ-1; Fri, 14 Jan 2022 06:19:37 +0000
X-MC-Unique: eNAemDzMP3yLMlSEzQpIBQ-1
Received: from CWLP123MB5572.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:16b::6)
 by CWLP123MB5340.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:14f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9; Fri, 14 Jan
 2022 06:19:36 +0000
Received: from CWLP123MB5572.GBRP123.PROD.OUTLOOK.COM
 ([fe80::4c56:90c1:1ed:2ea3]) by CWLP123MB5572.GBRP123.PROD.OUTLOOK.COM
 ([fe80::4c56:90c1:1ed:2ea3%4]) with mapi id 15.20.4888.012; Fri, 14 Jan 2022
 06:19:36 +0000
From:   =?UTF-8?Q?Tomasz_Mo=c5=84?= <tomasz.mon@camlingroup.com>
Subject: Re: Modem control lines for RTSCTS hardware flow control via rts-gpio
 and cts-gpio with IMX
To:     Tim Harvey <tharvey@gateworks.com>, linux-serial@vger.kernel.org
Cc:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Huang Shijie <b32955@freescale.com>,
        Dirk Behme <dirk.behme@googlemail.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Richard Genoud <richard.genoud@gmail.com>
References: <CAJ+vNU0CrD8091W5zH7ve9v3ZVAGXR6=6DGebd5LhHz4mzt4+w@mail.gmail.com>
 <CAJ+vNU1tJ5W5RCUsPehgH7CS=v=7mttHgNOu-UdWGVpzf2LcBQ@mail.gmail.com>
Message-ID: <4bdbd9c0-8ce3-84b1-9f89-be89b686c652@camlingroup.com>
Date:   Fri, 14 Jan 2022 07:19:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <CAJ+vNU1tJ5W5RCUsPehgH7CS=v=7mttHgNOu-UdWGVpzf2LcBQ@mail.gmail.com>
X-ClientProxiedBy: LO4P123CA0114.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:192::11) To CWLP123MB5572.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:16b::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 21e8c890-5e8a-4f17-ee85-08d9d725d684
X-MS-TrafficTypeDiagnostic: CWLP123MB5340:EE_
X-Microsoft-Antispam-PRVS: <CWLP123MB53408192571299837A07043392549@CWLP123MB5340.GBRP123.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0
X-Microsoft-Antispam-Message-Info: HBerDMxkvhu6dCEZM9EEQcpHsHilrBbHSUO1E6AKiVWwXGRTxPYatT4dkfWpFZecqwvFOAMZ3i3aVbH9W7ILwLLzuHz8Hjah2jKqe29F5GgTVgHPcIJ04u/8pX/k1ay0tRNtjG8R0KdogCYVteMkaqNcQZ/NSjFncocfv0LPmN+9H7/aBNJW3NQQrLkIs7pJVO4c/ZaBSAoQBZwjV/EjPkDRZfiCmiVmCJeR/IvC1qFDfw5jYe+2RCw4FV1XWHpmNa3ZBIDnfw6bYl4lFOZdk3gpcXgjxZf+HbV+BOeRBMdpof9+0xXps3eYI81R1FXtmHlLVi2PTVzrRvjpjUms3RLOqfN94967PAsAQVTDytPjVo+KThfCmK7Ek5ZpbWExpVYGOlObcAiZ0nXBB97OP6vFvBxRhat2V2AAWfnJ5tSBFGQFdOhnSlkUueooBQoF/XYUZ1UiwNLxoWPMfcmzGu1z4oa3/jrzRoQbTkMungatuv9lhgZaVBuJnHRgGFcsTNrk0Lq4Iuy1HVV3t0yZ3T0x/NU97k9jo6kOq9Xj0P6nbW370MiZ29mUYNBq/wmI3CtT8iAbHx8p3SW6N49F+n9UdPdZIm9VuQsHUBT6vxuJ7pjh29bCe9Toh48FhuNs31lVx0YeE1nVnYWz7VJgeamfx9R4dGdyUP2G9Wd7kiufpS49mDUJQlZh5u6WSbHmjYcY+Md2W5MgMuyX8PvHsZdqn9ZrXJFYIzct/AoctUjq5sZnPumySo17UmSDhCa4Hu0qf3BloMd9bQCjM7JOJLUj1r1TuIsaH1xsSFG2Po2NGCjdnRsSy6qNd9k+/IA9E/ynSY0HPlUugn8WR8+qB1+8lzJf+smjwPeheRWTVs0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB5572.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(366004)(86362001)(6506007)(26005)(186003)(36756003)(6512007)(5660300002)(966005)(66946007)(38350700002)(38100700002)(2616005)(53546011)(66476007)(52116002)(508600001)(31696002)(316002)(54906003)(2906002)(66556008)(6486002)(8936002)(31686004)(83380400001)(4326008)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1101
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NEJCaHRBa3o4cTk0d3FVaUtzNWJmbGN2aDFqZUtRRFJZbzQ5dzlkQmU5bFJx?=
 =?utf-8?B?dzNEUW9YcmJJa0FjRS9XN1pERXFTMkMxTkIvTjJ5NGdoWWhyMU52aWQwTC9U?=
 =?utf-8?B?cHJJZUF3ektiQzNYanlPcGtVdnBUUzhIeWRsU29pdmRRR1JpNUtjWW1JeEtM?=
 =?utf-8?B?anJXL2x5blZYUWVSTW01YkNjTTZqVkhzS2laZE9DOHNxOFZ5WjhOalVWWlNJ?=
 =?utf-8?B?ekdXWlRiV3l1QUlxVGJtb1FvanU5eEVFUW1NaDlwcHF2a2xsazhWU1hUdk9i?=
 =?utf-8?B?Qk1vREZtc3BwY3BOTXNGaW93UWNSZk9EU1NEdGNZZlljbWIxZ2ZoS2Q2SkQ2?=
 =?utf-8?B?bGZ6NWx2VlkrMTc3WDQ0bFRrQnI1dGoxUVZBSjN0b1FrNzBRa2xRaXBVWDVo?=
 =?utf-8?B?c1UwYk5FTUJXdWJ2U0VIVGg5bFNxaHNneXd6cTRXTHVJVmRmUkxaUmpBcVZL?=
 =?utf-8?B?NnN6c1FTU3N5VXJLREY2czR5em5vbkdEYlZKV0dPLzRVVGhDaWZRa3BocXBR?=
 =?utf-8?B?QUNMUWJwRFlRdGxORnJrL0hQTVJSdmpXb28yZndRbEdUUDVkdUFtaVVNeG1G?=
 =?utf-8?B?akI3eXhMWTV3S3VWR09Kb3drUTlGVytvZUErOEdOSjMxQ0dsV3N2NXBnQ2lN?=
 =?utf-8?B?cHNYOU95OGZQcytzcXl0U0tGempCZEg3YTExakp4K2RROEVRWVR5T0hTSGFJ?=
 =?utf-8?B?NmdYZlNMcmFLWVhLczN1UGt0RjBDUklBOGlvdUE0VUJhNldZdzJZb3VKVDUz?=
 =?utf-8?B?NmxXSGIzSFJvdStNdE1SWHRpQVZYV3lyWHhRM1BFenpsdllueTBDb00wYjhs?=
 =?utf-8?B?aU5wTnJCa0hLMnRPQzM4MDczdHlXalZJSWd3ZGl4OFRpNWthbHA0ZDdaUVFs?=
 =?utf-8?B?V2ZMQW0zeG4yMGd0N2RoS0hLMGEvQUMwV2QzZFZBd1JPd21Gc0dFV0hSWldu?=
 =?utf-8?B?MlNYbEtuTjYyUlExUVk4c1UzMksrWUl2YTJxdWJhckVwVnRwaTc4MlRacXgy?=
 =?utf-8?B?QWJsYjNCRlpkU3JPeUZqd3YyMHo4alpzQnlhWDI0NkhUQ1VIVFZoOHdZY2Vo?=
 =?utf-8?B?MlYxRlpLYSswMForSEJQZ3d5b1pycmp6Rkp6MU5mQmNjVkZRcWZWS0Y3Umxp?=
 =?utf-8?B?UjROSzhDVWxsak1YSkwxa1B6N05wYmk4clhTT2M4eWZHZEllVlJLZVRXUTZL?=
 =?utf-8?B?YUtCRnRKeXd6SlRmUXpYZXFMUU5vNHl2QmhPeThNOWxjZUFKeG5qTFQ3M293?=
 =?utf-8?B?dGpYRThHdmJKa2JLczZWS2dmSFVjY090QyszWHA2dkJEZlIxT3NDT3JLUzdT?=
 =?utf-8?B?VWJjdy9Fekt1VEdtZE4yc0ZZS2RZdkNWQXo2UUZ5TzRkTktHRXl4cHJtYzFk?=
 =?utf-8?B?NDBoK0lkSXhlcldhSmVWdjNZNGdsWFVMRnNvSUJFRDJFWGNNSlpsRDh0ay9V?=
 =?utf-8?B?SVBqY0tSL3EyOXNoQis4NVMyN0dZTXUrOWRoK0FLTTJIbGtWaVRFcDEvSllD?=
 =?utf-8?B?U01HbU9vN3lIZzg3c1lVeERuSjBYM0MvTEJyNC9hVzJvV2tiVjlZTFBXTGlO?=
 =?utf-8?B?K0l5Q3MxVU5wUVJpT0pRdTFFMFJybFcvMkRIcjdWTHJzYmk1cHdwTVZUejNV?=
 =?utf-8?B?UXV6SDNIbmhISkJYKzFWUW9lend4WlkrMERaZVdSeGRjS25vcG45dzhZNlFP?=
 =?utf-8?B?Q3VXMVFIWVluZ0ZPdU5VTW1XQnNPSDFWY2cxaGcrK3l6cWNyS28vclVxSGJw?=
 =?utf-8?B?czdnQlZaOWZ2YXpKaVo3UVBlYlMreDV5ZUl3QlpOZkZBRnNIVGZ4NVJsNmFI?=
 =?utf-8?B?eHc3ZnV0WjVxTytlUEZOZlZNSVVxYXpPZ3piNnErNE1UaXJ4ak03b2wxaVF6?=
 =?utf-8?B?cmRGMUJPeWJHVkNXazNaSldrRExZNHFmNjQ0bDVHcUdPOU9BcG1WU251eGEx?=
 =?utf-8?B?T29IaTdKYWFOWUthTysxWVhkQ2tMMXV5UE94UEtJN05XbkFDVEtyUllDelBt?=
 =?utf-8?B?WElpTHM3OXdpTHdtV25xY1ZMSkhBRDFYY09ocHdDT1puRTVsZmNVZEtHTXNK?=
 =?utf-8?B?UXhtSG5qN2JNSFF3YTRwRkljSFl5SW5IREMrQjZTNWluM013Mlk3MUpYOGl0?=
 =?utf-8?B?Uk5iQ2dxaDk5K3E2WmowRUc4eUVHcStPTVQvSGpIY2FlSktVQldEZzMveC9V?=
 =?utf-8?B?ZXFQRHppRmNHaUc4NStSQTZSV0U4SEg5NUlOY0JJWmt1dG9GZlRlU3VTbVhu?=
 =?utf-8?B?bnNyQ0IvOTZ2UDhOS3FvTTNnVmpRPT0=?=
X-OriginatorOrg: camlingroup.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21e8c890-5e8a-4f17-ee85-08d9d725d684
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB5572.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2022 06:19:36.4152
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fd4b1729-b18d-46d2-9ba0-2717b852b252
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d3Q9/Kjm1vIFW7nks6wPcs99Mg0Dfub4UPLtVkQLi+EXsm2mr8RYrvoZBwFINIkWjs53npVEKiM7lYwv8jy6OS4anwSJfKH0tTiDcvjN71I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP123MB5340
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

On 14.01.2022 04:08, Tim Harvey wrote:
> So I believe in order to support using gpios for rts/cts in the imx
> uart driver I must find the right place to call imx_uart_rts_active
> and imx_uart_rts_inactive when the FIFO is not full and full
> respectively. I'm not that familiar with the Linux uart driver
> framework - am I on the right track and if so any ideas where this is
> best done?

It is not really the driver (and thus FIFO level), but rather the amount
of free space in tty buffer (checked by Line Discipline workqueue) that
determines when to throttle (set RTS inactive). This mostly works fine,
but fails [1] when the RX interrupt frequency is too high [2].

The throttle/unthrottle request, when termios CRTSCTS is set, is seen by
the driver as the call to .set_mctrl (imx_uart_set_mctrl) with TIOCM_RTS
bit cleared/set in mctrl parameter. Currently imx_uart_set_mctrl() only
controls the UCR2_CTS and UCR2_CTSC bits based on mctrl.

To support your case you would most likely have to add the gpio handling
in imx_uart_set_mctrl(). However, I am unaware what other issues you
might encounter (i.e. if it is not done there yet simply because nobody
had that use case or if there is some deeper problem).

[1] https://lore.kernel.org/linux-serial/10e723c0-a28b-de0d-0632-0bd2504783=
13@camlingroup.com/
[2] https://lore.kernel.org/linux-serial/20220104103203.2033673-1-tomasz.mo=
n@camlingroup.com/

Best Regards,
Tomasz Mon

