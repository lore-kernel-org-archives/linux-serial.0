Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A194C433E0
	for <linux-serial@archiver.kernel.org>; Tue,  2 Feb 2021 00:17:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD90464E8D
	for <linux-serial@archiver.kernel.org>; Tue,  2 Feb 2021 00:17:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbhBBARC (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 1 Feb 2021 19:17:02 -0500
Received: from mx0b-002ab301.pphosted.com ([148.163.154.99]:11670 "EHLO
        mx0b-002ab301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231301AbhBBARA (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 1 Feb 2021 19:17:00 -0500
Received: from pps.filterd (m0118793.ppops.net [127.0.0.1])
        by mx0b-002ab301.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1120AJhF027888;
        Mon, 1 Feb 2021 19:15:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=distech-controls.com; h=subject :
 to : cc : references : from : message-id : date : in-reply-to :
 content-type : content-transfer-encoding : mime-version; s=pps-02182019;
 bh=3J6vCWDd/r3M6RY3za3BAsRviWR5KRKiiflNMZqIkuA=;
 b=Xiynh82HxvZ0SBRZZqTCgBnNoAsxvkpqRtw/ArfknhFOhDVGbQj3pYRh5KhL9a1VvXHY
 w4mhUsvJUc5Aa9JfSF/V+K+vF/N0qa6h83Gs+GooR+aylZuyy9rDIY0Zz/dSqd9GONeS
 xvHyGEzPbrrNrmbTNPWRnVp5lWi/nGSW+I9AtEdm9kv/Pmsmj0cA9NXJxDkk2Hxm1//o
 NTYru8PsBB0TY2VRvy62GRxASM8Mcxde/wmjTUivoKMicwNVFZG+lWjNlPOiQi76Qihi
 tBvVH8L5WM0Rzf624K1H2RDgvIXxa0cervbPpSwkVRYyykaG+tm+9PoVn/Pj5JYD1U9t Uw== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2176.outbound.protection.outlook.com [104.47.58.176])
        by mx0b-002ab301.pphosted.com with ESMTP id 36dnpnh9xj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 01 Feb 2021 19:15:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oGHgxhDuUddvnChtp+9Tm5qBVAA3b8Fsvc1PipQ1Wpt61sw1EVVSY0ByxkqVG2qGkcU3XXK8tBkzEBCosh1tq3xFIwq5ToL8OUnZIOk0vAB5neutmnxX/rqt/eT6TfHZHmXIRQkYqx3zTAWbcnDKGZTPBcQNMaH23ceBhT4NKGIn9I9NH6wjc6nbbPzC74/l2tBmqXeRF/dIbnNXs13WQiDoKx6bKQZ+mHXpDi1hhl90+N57G+UFgLOJIyzJSQtzNvTuiVfSdSB1+xsSLJqXNTCYanBL6w3DpnSebMhxkH/LTs+z0cFal65Z7jT8YoNt4Xx1jy8j9sFRLOZD04t+Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UkoIAV6kGqCKkSnPdnRXaOfwPUowHjoL718QbmZLzdU=;
 b=MTvAYjqFgVsiJgddaSjnqj4TOSX0rHNtlfnbvHcwoXk907bnqIVTw9t8JX3xylyuKtJF2EphK9SKEfmkDuHLzv+6mPcloY8dnwJ6S3eX214yTwfIHgZzBcb9ruC/A9+mNsmGkbgrDBArK68f72kyihvaUp7KsKT1CGMQ6ZSnt7ZOPXSn3ketxmicL70qHq44+X0ySTmsUGscMOqJPxsmUZSDuVEsyu7aHL1NZkfUrQQMcxElky+ivElTOOIldGGdeDr2ufMV9zSg1u4ZvzYus6sbI8Z18BCLE0bbBnhSDEtucpiMKOZxA8EgTaRBzFicOIxA+FcEVwvn8BdcHj3m4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=distech-controls.com; dmarc=pass action=none
 header.from=distech-controls.com; dkim=pass header.d=distech-controls.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=distech-controls.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UkoIAV6kGqCKkSnPdnRXaOfwPUowHjoL718QbmZLzdU=;
 b=nvcyN8flIGz2AWZRNaR5DNmruu8zxGlT4pjJ6SjHALnSqVM0k6+STTIvwiFNnFbf6jsNN5FFHnZvrqzqR9tuazv5bhIGV1sXM2WQHw94id/yz2lGSI3PVdPGPYPeRUb1tH+7OirhSh22zKofniTLTC35hlQ3/86JijJcNq21p7Q=
Authentication-Results: theobroma-systems.com; dkim=none (message not signed)
 header.d=none;theobroma-systems.com; dmarc=none action=none
 header.from=distech-controls.com;
Received: from DM5PR01MB2457.prod.exchangelabs.com (2603:10b6:3:41::21) by
 DM6PR01MB4780.prod.exchangelabs.com (2603:10b6:5:6b::16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3784.17; Tue, 2 Feb 2021 00:15:51 +0000
Received: from DM5PR01MB2457.prod.exchangelabs.com
 ([fe80::9de6:ce8a:e281:8e63]) by DM5PR01MB2457.prod.exchangelabs.com
 ([fe80::9de6:ce8a:e281:8e63%11]) with mapi id 15.20.3805.024; Tue, 2 Feb 2021
 00:15:51 +0000
Subject: Re: [PATCH 1/3] serial: 8250: Handle UART without interrupt on TEMT
 using em485
To:     Jiri Slaby <jirislaby@kernel.org>, gregkh@linuxfoundation.org
Cc:     andriy.shevchenko@linux.intel.com, matwey.kornilov@gmail.com,
        giulio.benetti@micronovasrl.com, lukas@wunner.de,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        christoph.muellner@theobroma-systems.com, heiko@sntech.de,
        heiko.stuebner@theobroma-systems.com
References: <20210128233629.4164-1-etremblay@distech-controls.com>
 <20210128233629.4164-2-etremblay@distech-controls.com>
 <1c4f5095-e350-8cc6-daee-4a841b1373d2@kernel.org>
From:   Eric Tremblay <etremblay@distech-controls.com>
Message-ID: <f1519982-9ecd-3e7c-86a8-fc4df5170941@distech-controls.com>
Date:   Mon, 1 Feb 2021 19:15:48 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <1c4f5095-e350-8cc6-daee-4a841b1373d2@kernel.org>
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [2607:fa49:6d60:7d00:81ec:ecb2:e06b:bcd1]
X-ClientProxiedBy: QB1PR01CA0024.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:2d::37) To DM5PR01MB2457.prod.exchangelabs.com
 (2603:10b6:3:41::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2607:fa49:6d60:7d00:81ec:ecb2:e06b:bcd1] (2607:fa49:6d60:7d00:81ec:ecb2:e06b:bcd1) by QB1PR01CA0024.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:2d::37) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16 via Frontend Transport; Tue, 2 Feb 2021 00:15:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d855acb5-0b70-4297-377d-08d8c70fb2b4
X-MS-TrafficTypeDiagnostic: DM6PR01MB4780:
X-Microsoft-Antispam-PRVS: <DM6PR01MB4780250D69644446F437326B95B59@DM6PR01MB4780.prod.exchangelabs.com>
x-pp-identifier: acuityo365
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZyduHPBK10LWflPnY2QgOYVdi7kq9pEXXlKQs/2Is7c+rux2sOOUTqMEWNpDhU7BJTwO51iSpLpBInWMMeMK1GiEb3tcwvBlRzk8FB64BwGi/rwLidg//9lcS6qfbDYHV6MBlY8fn9t4M3w8C6NZqMriY/qTfTpOKBrkgT9tHS2iAv1DON6anBBNDgareWUGDcsi6tufZwGlwWVkosVJPKSUjo0Yojr06i+ojDfm6npahSuTtEznqCCVVnDEMyx8NeZM7NyfXmfzg4Vn0myq0SbTZ8B5WWFwmQkFzsZJxoUrJLDsQ81mX/aUM2xkN9oD+i7T20Xsgj+5Xam/kHdoX4AUmfgUKYUK5QNwFMHzdWd6tG99IFHh18Ew/kq9+yA7CTIuLWmuQxZWl/uskgDNnClL8lf9yuvyffH2ow9jOnQXH21HqHfyW1DSaaPg0s09iv8QOFe9kd2JNbVu1y4XYKd2WvIm/C2IOjcU/e+OKWe+GOYjD96yykfj6ipbXMGsaCW/6DY5gT7iiu26XV2oxAPUlZrJEdeqXCYu6mxPfCqYy8KnBSOdaID1EasyW66R3C0eKiv9wFx4DZqS/M48JPvjkrxVLRrr1tZ8B27i1/s=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR01MB2457.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(396003)(376002)(39860400002)(366004)(2616005)(5660300002)(6486002)(31686004)(478600001)(52116002)(83380400001)(316002)(36756003)(8676002)(31696002)(4326008)(16526019)(66946007)(186003)(86362001)(7416002)(2906002)(8936002)(53546011)(66476007)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?iso-8859-2?Q?uJD8Lz19JVZJ3KZcdfguV7T6PjVL95TpzFZYtDsJcGlfsI80+VKiMmXZVx?=
 =?iso-8859-2?Q?B06QI544soIAHWN4KJxX07m2RxYHsC5P3geFhPCrVW+1C/llKZF4/Yb0bB?=
 =?iso-8859-2?Q?RtViQrJILPnFiS3P/UJnmv2VuZ4TsqxQwrsvmV9sR3Pr51uA/C2wMkctWf?=
 =?iso-8859-2?Q?UT5hK4z598hhoL5AXeGba9XXohdDWIq816KMvu14nqqZJrpNUOJSLBeOVG?=
 =?iso-8859-2?Q?BTpe5ltReEApkrmzwpvPXcoXBuHphQvs936OXDOCssUg/Mv823jv35JtAt?=
 =?iso-8859-2?Q?7m8DM+sJlUvAR/hlJerm/RCptwwUdbTG8dDjyPJcIzdDga68+s+E3cFd3Q?=
 =?iso-8859-2?Q?V9fPW2KHGc5CYel/gzIEyVx7fYAEyno6WOjVRhccRYNBujjTH/65ROeXJh?=
 =?iso-8859-2?Q?7TnIGWMkEDj1l39o64GCj9MxXicrhiX14TFNGxLghUNyw1liYhI5MPnpny?=
 =?iso-8859-2?Q?ChBn9vMQC+L/WK/m1ZCDNH6vqBqz9hGyuHd6DPH3MJGA433ddRR3x7TWT8?=
 =?iso-8859-2?Q?RAVyJYKHuADRj7Ec33PrjtdkAkR3Io77/sl1fmHUanCB4lb++cFV2exM72?=
 =?iso-8859-2?Q?SKOaIkoqsorEbLFx6K5reuHZyyAMJD68XuXyakoSH+BDc0Zr8lXsp3de9c?=
 =?iso-8859-2?Q?vbNvOA9J02mxd6TsG6gcjE170Hq/h5lbdVWpHkWpkfsXhppW6DMFMTzp8w?=
 =?iso-8859-2?Q?bTrn2xZnAsgf4PCPUVbb0LVQEZvttoAGx83Hmp6t1z1p2q3EN1uZ3vUhVM?=
 =?iso-8859-2?Q?TWyrDqVIu2xyG1uR+X2W9IHUEH9eyXJ+D0Iq61nthhZqExghVY+DWNc6y7?=
 =?iso-8859-2?Q?b1Ag2WQyid7VMuD16voDQlYzCgtl6Vz5InK2ORnnrfUUFjknolczF3/sAB?=
 =?iso-8859-2?Q?ViPZGuFvOG0hZ2ITQRGnVjTuh9VcBi4oYb11+dlLR+0cC/vrGxH1AP69va?=
 =?iso-8859-2?Q?guju0HLtmkqpMrgme9QsPLTLQ94JG3EQPLBuiL5h4E7ZkSvpBBDRHoF7jX?=
 =?iso-8859-2?Q?O8opLRV0I4Xz7T3onrnz27lry9v1HqEP6uyh9NLgxVhocMz8QQWJuJEp8+?=
 =?iso-8859-2?Q?D9b42A8CUkCuO737b264S05jlJISpy/N2FQiSNiWFWgHQXerAe1N0BN1uY?=
 =?iso-8859-2?Q?KQB3Ec/Id3/HBqmqjZAI3HQdMNlxBaHYNM6vLm/TdH0mhs04E0uc6HFQwL?=
 =?iso-8859-2?Q?aMHhr7v3UV+VzA=3D=3D?=
X-OriginatorOrg: distech-controls.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d855acb5-0b70-4297-377d-08d8c70fb2b4
X-MS-Exchange-CrossTenant-AuthSource: DM5PR01MB2457.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2021 00:15:51.2026
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: caadbe96-024e-4f67-82ec-fb28ff53d16d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: evFn+s0oV2xxA6vyWEpVVgoRETXK0Pz/6OguqCZYkY3WesNpSRMUWnTYaZbOrHGXtirY1Eq+ni6kUdAovPGnTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR01MB4780
X-Proofpoint-Processed: True
X-Proofpoint-Spam-Details: rule=outbound_spam_notspam policy=outbound_spam score=0 lowpriorityscore=0
 phishscore=0 priorityscore=1501 suspectscore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 malwarescore=0 clxscore=1015 bulkscore=0
 spamscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2102010137
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 2021-01-29 2:23 a.m., Jiri Slaby wrote:
> On 29. 01. 21, 0:36, Eric Tremblay wrote:
>> The patch introduce the UART_CAP_TEMT capability which is by default
>> assigned to all 8250 UART since the code assume that device has the
>> interrupt on TEMT
>>
>> In the case where the device does not support it, we calculate the
>> maximum of time it could take for the transmitter to empty the
>> shift register. When we get in the situation where we get the
>> THRE interrupt but the TEMT bit is not set we start the timer
>> and recall __stop_tx after the delay
>>
>> Signed-off-by: Eric Tremblay <etremblay@distech-controls.com>
>> ---
>>   drivers/tty/serial/8250/8250.h            |  1 +
>>   drivers/tty/serial/8250/8250_bcm2835aux.c |  2 +-
>>   drivers/tty/serial/8250/8250_omap.c       |  2 +-
>>   drivers/tty/serial/8250/8250_port.c       | 89 ++++++++++++++++++++++-
>>   include/linux/serial_8250.h               |  2 +
>>   5 files changed, 93 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
>> index 52bb21205bb6..5361b761eed7 100644
>> --- a/drivers/tty/serial/8250/8250.h
>> +++ b/drivers/tty/serial/8250/8250.h
>> @@ -82,6 +82,7 @@ struct serial8250_config {
>>   #define UART_CAP_MINI    (1 << 17)    /* Mini UART on BCM283X family lacks:
>>                        * STOP PARITY EPAR SPAR WLEN5 WLEN6
>>                        */
>> +#define UART_CAP_TEMT    (1 << 18)    /* UART have interrupt on TEMT */
>
> What about the inversion _NOTEMT? You then set it only on uarts without TEMT and don't need to update every single driver.
That's a good Idea, I will use that in the next version.
>
>> diff --git a/drivers/tty/serial/8250/8250_bcm2835aux.c b/drivers/tty/serial/8250/8250_bcm2835aux.c
>> index fd95860cd661..354faebce885 100644
>> --- a/drivers/tty/serial/8250/8250_bcm2835aux.c
>> +++ b/drivers/tty/serial/8250/8250_bcm2835aux.c
>> @@ -91,7 +91,7 @@ static int bcm2835aux_serial_probe(struct platform_device *pdev)
>>           return -ENOMEM;
>>         /* initialize data */
>> -    up.capabilities = UART_CAP_FIFO | UART_CAP_MINI;
>> +    data->uart.capabilities = UART_CAP_FIFO | UART_CAP_MINI | UART_CAP_TEMT;
>
> This change looks weird and undocumented. Why do you set data->uart suddenly?
>
> Actually, does this build?

This is a silly merge mistake, sorry about that. However, it will not be there

in the next version with the _NOTEMT capability.

>
>>       up.port.dev = &pdev->dev;
>>       up.port.regshift = 2;
>>       up.port.type = PORT_16550;
>> diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
>> index 23e0decde33e..1c21ac68ff37 100644
>> --- a/drivers/tty/serial/8250/8250_omap.c
>> +++ b/drivers/tty/serial/8250/8250_omap.c
>> @@ -1294,7 +1294,7 @@ static int omap8250_probe(struct platform_device *pdev)
>>       up.port.regshift = 2;
>>       up.port.fifosize = 64;
>>       up.tx_loadsz = 64;
>> -    up.capabilities = UART_CAP_FIFO;
>> +    up.capabilities = UART_CAP_FIFO | UART_CAP_TEMT;
>>   #ifdef CONFIG_PM
>>       /*
>>        * Runtime PM is mostly transparent. However to do it right we need to a
>> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
>> index b0af13074cd3..44a54406e4b4 100644
>> --- a/drivers/tty/serial/8250/8250_port.c
>> +++ b/drivers/tty/serial/8250/8250_port.c
>> @@ -558,8 +558,41 @@ static void serial8250_clear_fifos(struct uart_8250_port *p)
>>       }
>>   }
>>   +static inline void serial8250_em485_update_temt_delay(struct uart_8250_port *p,
>> +            unsigned int cflag, unsigned int baud)
>> +{
>> +    unsigned int bits;
>> +
>> +    if (!p->em485)
>> +        return;
>> +
>> +    /* byte size and parity */
>> +    switch (cflag & CSIZE) {
>> +    case CS5:
>> +        bits = 7;
>> +        break;
>> +    case CS6:
>> +        bits = 8;
>> +        break;
>> +    case CS7:
>> +        bits = 9;
>> +        break;
>> +    default:
>> +        bits = 10;
>> +        break; /* CS8 */
>> +    }
>> +
>> +    if (cflag & CSTOPB)
>> +        bits++;
>> +    if (cflag & PARENB)
>> +        bits++;
>> +
>> +    p->em485->no_temt_delay = bits*1000000/baud;
>> +}
>> +
>>   static enum hrtimer_restart serial8250_em485_handle_start_tx(struct hrtimer *t);
>>   static enum hrtimer_restart serial8250_em485_handle_stop_tx(struct hrtimer *t);
>> +static enum hrtimer_restart serial8250_em485_handle_no_temt(struct hrtimer *t);
>>     void serial8250_clear_and_reinit_fifos(struct uart_8250_port *p)
>>   {
>> @@ -618,6 +651,18 @@ static int serial8250_em485_init(struct uart_8250_port *p)
>>                HRTIMER_MODE_REL);
>>       hrtimer_init(&p->em485->start_tx_timer, CLOCK_MONOTONIC,
>>                HRTIMER_MODE_REL);
>> +
>> +    if (!(p->capabilities & UART_CAP_TEMT)) {
>> +        struct tty_struct *tty = p->port.state->port.tty;
>
> Is this safe? Don't you need a tty reference? Or maybe you need to pass the tty from the TIOCSRS485 ioctl to here.
I saw that there was some place in the code where the tty_struct or the termios struct
was accessed that way, I may have done a wrong assumption. To get the TTY struct from the IOCTL,
we will need to modify the rs485_config() callback, I'm not sure I want to go there.

Is using tty_port_initialized() before and returning an error on failure would be a sufficient
safety check ?
>
>> +        serial8250_em485_update_temt_delay(p, tty->termios.c_cflag,
>> +                           tty_get_baud_rate(tty));
>> +        hrtimer_init(&p->em485->no_temt_timer, CLOCK_MONOTONIC,
>> +                 HRTIMER_MODE_REL);
>> +        p->em485->no_temt_timer.function =
>> +            &serial8250_em485_handle_no_temt;
>> +    }
>> +
>>       p->em485->stop_tx_timer.function = &serial8250_em485_handle_stop_tx;
>>       p->em485->start_tx_timer.function = &serial8250_em485_handle_start_tx;
>>       p->em485->port = p;
>> @@ -649,6 +694,7 @@ void serial8250_em485_destroy(struct uart_8250_port *p)
>>         hrtimer_cancel(&p->em485->start_tx_timer);
>>       hrtimer_cancel(&p->em485->stop_tx_timer);
>> +    hrtimer_cancel(&p->em485->no_temt_timer);
>>         kfree(p->em485);
>>       p->em485 = NULL;
>> @@ -1494,6 +1540,15 @@ static void start_hrtimer_ms(struct hrtimer *hrt, unsigned long msec)
>>       hrtimer_start(hrt, t, HRTIMER_MODE_REL);
>>   }
>>   +static void start_hrtimer_us(struct hrtimer *hrt, unsigned long usec)
>> +{
>> +    long sec = usec / 1000000;
>> +    long nsec = (usec % 1000000) * 1000;
>> +    ktime_t t = ktime_set(sec, nsec);
>
> Why not ns_to_ktime without all those divisions?

I will change the timer to _ns and use that function, thanks.

>
>> +
>> +    hrtimer_start(hrt, t, HRTIMER_MODE_REL);
>> +}
>> +
>>   static void __stop_tx_rs485(struct uart_8250_port *p)
>>   {
>>       struct uart_8250_em485 *em485 = p->em485;
>> @@ -1531,8 +1586,18 @@ static inline void __stop_tx(struct uart_8250_port *p)
>>            * shift register are empty. It is for device driver to enable
>>            * interrupt on TEMT.
>>            */
>> -        if ((lsr & BOTH_EMPTY) != BOTH_EMPTY)
>> +        if ((lsr & BOTH_EMPTY) != BOTH_EMPTY) {
>> +            /*
>> +             * On devices with no interrupt on TEMT available
>> +             * start a timer for a byte time, the timer will recall
>> +             * __stop_tx
>> +             */
>> +            if (!(p->capabilities & UART_CAP_TEMT) && (lsr & UART_LSR_THRE)) {
>> +                em485->active_timer = &em485->no_temt_timer;
>
> How does this interfere with the current handling of active_timer? You should explain the changed functionality in the commit log. And you don't reset it to NULL in the timer.
I will add that information in the commit message thanks.
>
>> +                start_hrtimer_us(&em485->no_temt_timer, em485->no_temt_delay);
>> +            }
>>               return;
>> +        }
>>             __stop_tx_rs485(p);
>>       }
>> @@ -1631,6 +1696,25 @@ static inline void start_tx_rs485(struct uart_port *port)
>>       __start_tx(port);
>>   }
>>   +static enum hrtimer_restart serial8250_em485_handle_no_temt(struct hrtimer *t)
>> +{
>> +    struct uart_8250_em485 *em485;
>> +    struct uart_8250_port *p;
>> +    unsigned long flags;
>> +
>> +    em485 = container_of(t, struct uart_8250_em485, no_temt_timer);
>> +    p = em485->port;
>> +
>> +    serial8250_rpm_get(p);
>> +    spin_lock_irqsave(&p->port.lock, flags);
>> +    if (em485->active_timer == &em485->no_temt_timer)
>> +        __stop_tx(p);
>> +
>> +    spin_unlock_irqrestore(&p->port.lock, flags);
>> +    serial8250_rpm_put(p);
>> +    return HRTIMER_NORESTART;
>> +}
>> +
>>   static enum hrtimer_restart serial8250_em485_handle_start_tx(struct hrtimer *t)
>>   {
>>       struct uart_8250_em485 *em485;
>> @@ -2792,6 +2876,9 @@ serial8250_do_set_termios(struct uart_port *port, struct ktermios *termios,
>>         serial8250_set_divisor(port, baud, quot, frac);
>>   +    if (!(up->capabilities & UART_CAP_TEMT))
>> +        serial8250_em485_update_temt_delay(up, termios->c_cflag, baud);
>> +
>>       /*
>>        * LCR DLAB must be set to enable 64-byte FIFO mode. If the FCR
>>        * is written without DLAB set, this mode will be disabled.
>> diff --git a/include/linux/serial_8250.h b/include/linux/serial_8250.h
>> index 9e655055112d..d2c66faff0dd 100644
>> --- a/include/linux/serial_8250.h
>> +++ b/include/linux/serial_8250.h
>> @@ -79,7 +79,9 @@ struct uart_8250_ops {
>>   struct uart_8250_em485 {
>>       struct hrtimer        start_tx_timer; /* "rs485 start tx" timer */
>>       struct hrtimer        stop_tx_timer;  /* "rs485 stop tx" timer */
>> +    struct hrtimer        no_temt_timer;  /* "rs485 no tempt interrupt" timer */
>>       struct hrtimer        *active_timer;  /* pointer to active timer */
>> +    unsigned int        no_temt_delay;  /* Value of delay for no TEMT UART */
>>       struct uart_8250_port    *port;          /* for hrtimer callbacks */
>>       unsigned int        tx_stopped:1;    /* tx is currently stopped */
>>   };
>>
>
>

