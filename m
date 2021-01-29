Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C4C2C433E0
	for <linux-serial@archiver.kernel.org>; Fri, 29 Jan 2021 16:46:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 438F164E05
	for <linux-serial@archiver.kernel.org>; Fri, 29 Jan 2021 16:46:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbhA2Qqd (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 29 Jan 2021 11:46:33 -0500
Received: from mx0a-002ab301.pphosted.com ([148.163.150.161]:21232 "EHLO
        mx0a-002ab301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230249AbhA2Qpm (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 29 Jan 2021 11:45:42 -0500
Received: from pps.filterd (m0118791.ppops.net [127.0.0.1])
        by mx0a-002ab301.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10TGLT7R005152;
        Fri, 29 Jan 2021 11:22:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=distech-controls.com; h=subject :
 to : cc : references : from : message-id : date : in-reply-to :
 content-type : content-transfer-encoding : mime-version; s=pps-02182019;
 bh=L/d35nB6fySuN54/oOrZvszbEeMI2+QG6o0yITzfIXQ=;
 b=Rpx9MfE6BXKUEw6POczpNDV8MBDNFNcQRnVvgfxATrxn1Rrh65NP1y1hp7dXNvitCPc4
 56SbMNQVhTqotzwVlr/lXAMxdi1u4iHGRhZ44HJqdVvd0BctGliNviq087ualyDp3x+I
 CMgUcK3vn0GTElYm4S5RQdLKvab5WoM+kNHYNYuIwxfsT7MqKOclS31534KbnHvuTKQi
 xL9tzqHQpWA6mutRNrLdunuiOS+wQRVBdaFkPhEqPcUZ1lY7X0EM8hIgGscb90H+TqX4
 LDCB2OPq0f9hehz2Z1XuJ9d7Y2P/NkHx1uQWi4nAfTdI+Z50G5ok0mCttka6vKo/w7Uh UA== 
Received: from nam02-cy1-obe.outbound.protection.outlook.com (mail-cys01nam02lp2057.outbound.protection.outlook.com [104.47.37.57])
        by mx0a-002ab301.pphosted.com with ESMTP id 36byx9900u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Jan 2021 11:22:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hFxlTRFc4o4x9/63RHIStwFhZ23EIGY8aJqSIs9LqH52B+XP9BfBvPO5x7tAA+/noc74M1N++KmLUZKA4gXprP8Z2y/u7WDYVvfLGfm512NGfqFYNG1EZZGbOZUxpBuOOMrTXd47Ui25tQT5uIsJgnjrZ2brNpSucama32fGCjXnSgsrmQtPGUqSRvkVT0FonxYrwCK+ogOZB3Gxle/lxvRe3igEmnLqDg5biw4bQvPdHIOJE/In2H0/gvzDfhX3KMnTuwT88TaPHDWbzCyEqLbFMJZP8QiD9r+iGEhvnfToIrF2W6Ysw7scgTh5TUBfj3TMrDw1dnCNY6iNfploTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L/d35nB6fySuN54/oOrZvszbEeMI2+QG6o0yITzfIXQ=;
 b=cpgBzeYSwYwsehXLq4HjjJa+EEX3myLI/S/GD9vuucO1ivb0BIr+FaWK+yi/Z+UTqYvIkDWBtyT50FEDWKhzy3uLXrxYiKavw4X74EGBL4AwlKxhYt4N283M0VzQj//NkJiN6XzdF6o1+8//ySCDz+xoRWu/wCoEwBGXUd4kGh4PbH07zAVVLbHiELS9ZJwJXrMdky3we4VfHH0wGbdcXrgZ40HkpWPOcfc3ltuu9XY79js6FQTwwgHJhbuwIeMIvAs4Tmy4HGTu0LIeFikBAPd8oMKHMfgFwj8JMd08p94lFvGOutvKyRfPiPKEGBgxJFl/Ysc6HR7MngUxTHFTqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=distech-controls.com; dmarc=pass action=none
 header.from=distech-controls.com; dkim=pass header.d=distech-controls.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=distech-controls.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L/d35nB6fySuN54/oOrZvszbEeMI2+QG6o0yITzfIXQ=;
 b=VVpc6oVWbYrw8TQS0e1huF47Q1o5oUfnyY1iU99YLBgVHG1/lxA82jV0UuGtkM7tPc0HjziS0w6sMniggqs01P2he3DGqZ2EIvQM7G+ns5M2aia+G45hIXj2cdEf9FzOG8PAvxrKMmqJ4FoOCvtrRQKtJo8cL9m4WGX7bcYPLKg=
Authentication-Results: theobroma-systems.com; dkim=none (message not signed)
 header.d=none;theobroma-systems.com; dmarc=none action=none
 header.from=distech-controls.com;
Received: from DM5PR01MB2457.prod.exchangelabs.com (2603:10b6:3:41::21) by
 DM6PR01MB4458.prod.exchangelabs.com (2603:10b6:5:7d::16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3784.17; Fri, 29 Jan 2021 16:22:06 +0000
Received: from DM5PR01MB2457.prod.exchangelabs.com
 ([fe80::9de6:ce8a:e281:8e63]) by DM5PR01MB2457.prod.exchangelabs.com
 ([fe80::9de6:ce8a:e281:8e63%11]) with mapi id 15.20.3805.020; Fri, 29 Jan
 2021 16:22:06 +0000
Subject: Re: [PATCH 1/3] serial: 8250: Handle UART without interrupt on TEMT
 using em485
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     gregkh@linuxfoundation.org, jslaby@suse.com,
        matwey.kornilov@gmail.com, giulio.benetti@micronovasrl.com,
        lukas@wunner.de, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        christoph.muellner@theobroma-systems.com, heiko@sntech.de,
        heiko.stuebner@theobroma-systems.com
References: <20210128233629.4164-1-etremblay@distech-controls.com>
 <20210128233629.4164-2-etremblay@distech-controls.com>
 <YBPv/EA5LwA6jxId@smile.fi.intel.com>
From:   Eric Tremblay <etremblay@distech-controls.com>
Message-ID: <ab4bed42-a3d1-0cb4-ba9b-d37dd807204d@distech-controls.com>
Date:   Fri, 29 Jan 2021 11:22:03 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <YBPv/EA5LwA6jxId@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [2607:fa49:6d60:7d00:d104:219a:c8a0:bca5]
X-ClientProxiedBy: YQBPR01CA0100.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:3::36) To DM5PR01MB2457.prod.exchangelabs.com
 (2603:10b6:3:41::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2607:fa49:6d60:7d00:d104:219a:c8a0:bca5] (2607:fa49:6d60:7d00:d104:219a:c8a0:bca5) by YQBPR01CA0100.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:3::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16 via Frontend Transport; Fri, 29 Jan 2021 16:22:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: cf430490-2cfb-4424-999c-08d8c472051e
X-MS-TrafficTypeDiagnostic: DM6PR01MB4458:
X-Microsoft-Antispam-PRVS: <DM6PR01MB4458AC8C48D415B1C83BC1E095B99@DM6PR01MB4458.prod.exchangelabs.com>
x-pp-identifier: acuityo365
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Jk5Gs32HRWbgijIaT6EJbG6jZopwV/Td4a23iehI+cMXX3r3DcgAM4dQbsN/YO5JWa8r//jv74baubsJID1PeLr/NQJCksl+wgwi9UF/wehO5B06UPRE4SYod9/PcySCekgZ1uagU/Hmmqmmfx0esyG6wXsJ3NxqMZ2eukaHYXbCTJ1aScLn3vis0X+qzwL2qIp3Ur4jb00xslU9WYMToNnGalPvFz8tz1N0oOZvvYEovuveQ/e0s9z63d14IRM29qnABXAQvRCcVw0jlrQ+ytMMJ4yciC5bpKMjcC9nNhgOcAR/fq11O8qQqb8H9oBFGUY6BhFa9FSlA3yEwAuBPNa/WI79ye/V/GZsLEOvWUXbhKluCk19u2nqTpeAWdA6CabyNBcbccAjaLXLhsh9j/MChmyBG59+VNB6JWU0xJ3o4/lKQAewYyW8n0Bv8d/GrIzUnmXHEn/8Lho8WwUUFxuYnGZU4uCp69O9FFl3L0eYu36Hi36hf+eH3Zs1uCKgj0a7PdJDVpcPDSq3/Ev76pJPGVWe/DAoz0S5UslcixfJK8hodbzTlPx5Ee5KbKQnasObaRwl2I6U5bTQ6bg7WgOp/4wTDN+VP6EaoclZFBo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR01MB2457.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(396003)(346002)(376002)(136003)(478600001)(31696002)(6916009)(52116002)(8676002)(31686004)(53546011)(4326008)(316002)(186003)(7416002)(16526019)(36756003)(66946007)(2906002)(6486002)(86362001)(66476007)(5660300002)(2616005)(83380400001)(8936002)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?WS9NMm9kWFRFaGJ5S01qcFpFdmRMWVh4S3ZEVDU0dWMzMmR4L0ZDWU9vY2dD?=
 =?utf-8?B?dnhBbkMyT0g5QnBzR0Q3d0MyaFB4R0RjTDlpOFlHK0tkZkd0Rk9JOFV3WWhM?=
 =?utf-8?B?OVFkOGxYditWMmpvY2l2d3pYTytWLzBlMGgxWERoWC9MMklqckl3dmhodHEx?=
 =?utf-8?B?N0xOb1VleUlnT2dKU3pSSzVLUWpkL1dmei91NnJob3Bjb1FqWDdESXhpakk3?=
 =?utf-8?B?YmZFa2g0OW9pcXZJTmNRdEx3ZnlYckVHY1FkZk5KVkwydVh2TTFFRktrbmUr?=
 =?utf-8?B?cjNpWW5haVZYT0JRNHg4dzg1UUhqRExXR2syNzEwL2Jld3lUQ2ZPeFExcjBF?=
 =?utf-8?B?dm90d1NXOXdSVTdiT1FVWjdJLzhURWQ3MlRYYm9abjlYaEpZM0NOZmRTMjE1?=
 =?utf-8?B?c2VPZ3JiOEhGQjJJTUxXY3Z2WE9EaXdXZ3dBTXRyTzVTZE5tR3BYeFhOOTZT?=
 =?utf-8?B?R3pRNVArRkNLbGxSRGdMQ2tpN2ZxZ0lSZG5sN2d0WVh3MjZGcDhlMUtkbHY4?=
 =?utf-8?B?b3RwcGhYM1g3ZVJIdFUyVWhra1kwSGs3TDJYb1VOTThvVExVTkNtMk5KdlQ3?=
 =?utf-8?B?QU96UDdadnpOL0FaSkxaZ1poRE8rTk5qVHF2UXZqNWZmVW9pRjRCT20wdFlp?=
 =?utf-8?B?TGNOVHovUHppWDI5eENjYWtOVnNZTEtxRTNOYzlna1JZOVNYQzVrdkFTNWYr?=
 =?utf-8?B?K2Nlam8wWC9YdXJ2eC94eTZtZXo5ZW1scjBKMVcrQlNRMkZIUU4walh1eGV2?=
 =?utf-8?B?dXlJVHpjRm5DYk9jWlI1Qlg1T0ExdmRXYmJXQXRHQU40TzYrUFVoTFBId2Q4?=
 =?utf-8?B?U0tFb0dVcVVUZVg3QjM3SFhMUTZxbTRheU5jM0xIeFFhSlJLWWN5SmU0T2JN?=
 =?utf-8?B?ZXdIZ2lSclJRUzZWWE5FdkErYjA4b2gxTlJUTFZ2dW1XZ2FmcE94R3IvdHFn?=
 =?utf-8?B?ZnJ3dTMxVWNCSjI0MjFLcnNGamxVWDBVaVBkTjVkU2lQUktmS3QwR3I4a3FY?=
 =?utf-8?B?OTBJNmU0S1RXTlZFMGxXcTB5bWpQRUY0OG00MVBjaE53SzVIT3dFTFV6Um5k?=
 =?utf-8?B?UmpqcTJOa3FUSURhcGpvNE1sdk1qWmh1RkIrVW8wWGZLQWJ5RWc3aDlkaFNh?=
 =?utf-8?B?R0R3Q1pGQTBsYnJ2YzJpMkNIcjF6VklHc1lzQnh6V3I4bVY2TFBILzc5NDNX?=
 =?utf-8?B?RW4xTnBmWGh3QXJJMkZ6TnVjcU9UaXF4bUw3Z3ZmZDNQQkJWZWh6eWhYUGxN?=
 =?utf-8?B?RkJpU1hjamMzWWpoZWw0NUtwVmNDa3FsZXRpZmFsS3U4RFE3WDZOM2tCcWVu?=
 =?utf-8?B?SFREWTZ6b3JlQ0JLUlllS0E5WTY0YWJvWTRFRnQwSWhzSXFJcDFuUWM0K1g2?=
 =?utf-8?B?SVc5aG9icG9LWVN5aHRwQ2kzRllsYmNiU3hqNGkxNXdlbEtUWnlqREhwOEFj?=
 =?utf-8?B?NHBEVGFhaFdpUmJrUlNtRCtsSy9HZ1B3M1FVVVFhQ0hXVFNLdlpsRjhqUldY?=
 =?utf-8?Q?i/+MU3RDRM8o9c9euEE+WM29I4n?=
X-OriginatorOrg: distech-controls.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf430490-2cfb-4424-999c-08d8c472051e
X-MS-Exchange-CrossTenant-AuthSource: DM5PR01MB2457.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2021 16:22:06.6951
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: caadbe96-024e-4f67-82ec-fb28ff53d16d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tOZqCS7FaF2X00Vz8VdoQVCYDkHCVlHcQ2njSY0rEIzkFeNeXshgc0r/Uf3N2sfFiy6ADx9n8xWyZOFYoBdIUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR01MB4458
X-Proofpoint-Processed: True
X-Proofpoint-Spam-Details: rule=outbound_spam_notspam policy=outbound_spam score=0 bulkscore=0
 suspectscore=0 phishscore=0 priorityscore=1501 malwarescore=0 mlxscore=0
 mlxlogscore=999 spamscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101290081
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 2021-01-29 6:22 a.m., Andy Shevchenko wrote:
> On Thu, Jan 28, 2021 at 06:36:27PM -0500, Eric Tremblay wrote:
>> The patch introduce the UART_CAP_TEMT capability which is by default
>> assigned to all 8250 UART since the code assume that device has the
>> interrupt on TEMT
> You have missed periods in the sentences here and there. Please, check the
> grammar and punctuation everywhere.
>
>> In the case where the device does not support it, we calculate the
>> maximum of time it could take for the transmitter to empty the
> maximum time
>
>> shift register. When we get in the situation where we get the
>> THRE interrupt but the TEMT bit is not set we start the timer
>> and recall __stop_tx after the delay
> __stop_tx()

I will review the grammar and spelling, thanks for mentioning it

>
> ...
>
>>  	/* initialize data */
>> -	up.capabilities = UART_CAP_FIFO | UART_CAP_MINI;
>> +	data->uart.capabilities = UART_CAP_FIFO | UART_CAP_MINI | UART_CAP_TEMT;
> I didn't get, if you state that CAP_TEMT is default on all UARTs, why you have
> this?

It's a merge mistake, sorry for that. The next version will use the 
reverse capability like Jiri Slaby suggested, there will be no needs to
modify other driver.

>
>> -	up.capabilities = UART_CAP_FIFO;
>> +	up.capabilities = UART_CAP_FIFO | UART_CAP_TEMT;
> And so this?
>
> ...
>
>> +static inline void serial8250_em485_update_temt_delay(struct uart_8250_port *p,
>> +			unsigned int cflag, unsigned int baud)
>> +{
>> +	unsigned int bits;
>> +
>> +	if (!p->em485)
>> +		return;
>> +
>> +	/* byte size and parity */
>> +	switch (cflag & CSIZE) {
>> +	case CS5:
>> +		bits = 7;
>> +		break;
>> +	case CS6:
>> +		bits = 8;
>> +		break;
>> +	case CS7:
>> +		bits = 9;
>> +		break;
>> +	default:
>> +		bits = 10;
>> +		break; /* CS8 */
>> +	}
>> +
>> +	if (cflag & CSTOPB)
>> +		bits++;
>> +	if (cflag & PARENB)
>> +		bits++;
> This is repetition of uart_update_timeout(). Find a way to deduplicate.
>
>> +	p->em485->no_temt_delay = bits*1000000/baud;
> Use spaces.
> Is this magic should be defined as HZ_PER_MHZ?
>
>> +}
> ...
>
>> +static void start_hrtimer_us(struct hrtimer *hrt, unsigned long usec)
>> +{
>> +	long sec = usec / 1000000;
>> +	long nsec = (usec % 1000000) * 1000;
>
> USEC_PER_SEC
> NSEC_PER_USEC
>
>> +	ktime_t t = ktime_set(sec, nsec);
>> +
>> +	hrtimer_start(hrt, t, HRTIMER_MODE_REL);
>> +}
> ...
>
>> +		if ((lsr & BOTH_EMPTY) != BOTH_EMPTY) {
>> +			/*
>> +			 * On devices with no interrupt on TEMT available
> "with no TEMT interrupt available"
>
>> +			 * start a timer for a byte time, the timer will recall
>> +			 * __stop_tx
> __stop_tx().
>
>> +			 */
>> +			if (!(p->capabilities & UART_CAP_TEMT) && (lsr & UART_LSR_THRE)) {
>> +				em485->active_timer = &em485->no_temt_timer;
>> +				start_hrtimer_us(&em485->no_temt_timer, em485->no_temt_delay);
>> +			}
> Perhaps
> 			if ((p->capabilities & UART_CAP_TEMT) && (lsr & UART_LSR_THRE))
> 				return;
>
> 			em485->active_timer = &em485->no_temt_timer;
> 			start_hrtimer_us(&em485->no_temt_timer, em485->no_temt_delay);
>
> ?

I also prefer that form, I will apply it in next version

>
>>  			return;
>> +		}


