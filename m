Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F07B3C433E0
	for <linux-serial@archiver.kernel.org>; Tue,  2 Feb 2021 00:04:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B396B64ED0
	for <linux-serial@archiver.kernel.org>; Tue,  2 Feb 2021 00:04:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbhBBAEG (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 1 Feb 2021 19:04:06 -0500
Received: from mx0a-002ab301.pphosted.com ([148.163.150.161]:49952 "EHLO
        mx0a-002ab301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229527AbhBBAEF (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 1 Feb 2021 19:04:05 -0500
Received: from pps.filterd (m0118788.ppops.net [127.0.0.1])
        by mx0a-002ab301.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 111NwTp2010149;
        Mon, 1 Feb 2021 19:02:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=distech-controls.com; h=subject :
 to : cc : references : from : message-id : date : in-reply-to :
 content-type : content-transfer-encoding : mime-version; s=pps-02182019;
 bh=WubTx1cGcd8Srgo241Lg4MfvGA++ln8DzqSjhSPgOJI=;
 b=ky8L09kJrunyMuSaiJjku1VNVgoEHVrMqTAQJL2BPTtL7zz20jISmb7x3iOpaNwMxVkH
 nPdhrg/66LtQlLLT3qNHW0yTfmCaXFC767N6CckG2GQsr3kl4W9hszm/RfIgIyxr146z
 ckzUdb0udWquXSYYlkahENDfFUdyJlQxTBjvMKKj3HlVII6YuWHXKcvHMlwN5Ot/s3CZ
 buxztxnp/nd6xGpm9Aooi9q3i6cCsi5uNCdErRniPnFLpGg/gfc5u0K9C2OtOxTUUB6K
 JQ93NjgHp+JH8gyeda6zqd+kHeOoQuTMTrTiQGh8NXp73vKaNsL/8SqfnggSs9sMYwV8 Pw== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
        by mx0a-002ab301.pphosted.com with ESMTP id 36dnmss9nu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 01 Feb 2021 19:02:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fykF2NbPCprhdV9B76NMibeCeRyUb0+dROkFHXL9auEUCEJVsRDW63PsQ3yKcFiSAx3bGXehZLaTPXjwTwnkf04zTPBdv7jTDCPV8IoZS6CRitpYk3jUlj06xmCXn49skupgrqEkdkHjukja7WdPB0yWQxDYDKb4CYSGJMYiJltJa2s+tXq0ibFPkLu6+AzUtJZgG5CCv1K7l4vkcP7Fe6KsAuVrlvOH6eJu4LEY6Jt0FA7T7S1PeFMAFULVmWg3aRsdGOwszURfUKpiPSbdCbMcsQAlnCZZ47jf9Zf3u7XzuX4qLulRmYSejuwh36KC6qM0cGQhOGrQqpNTz3BbjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WubTx1cGcd8Srgo241Lg4MfvGA++ln8DzqSjhSPgOJI=;
 b=Qda5bM5VcIUb50Zcbx15vDSpHSwbblnDSLHNo7PdOGJea71D9rMWaHyR0IuhubmhKYftGcsuG+nMfhWHZ7Acf49pzK4FUSE5+95mIh7+sVceiGCmqT6vdJ4FHULSsBmxqNeYurvr2meBkzzQ4HFgSvAdT5h7zG9rUSPwrtx78sHB0Ql8NNEHkmlvb1symdky8wHqduH/Hvp/vk6L+EBKaqqXAUJQvIhwT2ekClqnGkqBwAx/4zRjU/QRjcA8UjTnmRJ90qkCAIvr6mVNNiHruXy1rGv9LHc04yPEz+90dVmo2vgZTrguZHWG9q7K59Ax1qppXlcV4cLRiPexcepjjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=distech-controls.com; dmarc=pass action=none
 header.from=distech-controls.com; dkim=pass header.d=distech-controls.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=distech-controls.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WubTx1cGcd8Srgo241Lg4MfvGA++ln8DzqSjhSPgOJI=;
 b=He+WB8bv+yelhl/UUAwupkfifiAJUXr5ewXv4clPAT1W5auKITxCwwSDY21aD0/BEv79TBw6dF3jzdYgDMWcUEx34EZ+5/J1Vk8rGfkMj+HSqzISHEWtxX+h4YiVjdrnxD2JtKdSOqCkl559RIO4+GXLTl+0BWs9asI0GabC65s=
Authentication-Results: theobroma-systems.com; dkim=none (message not signed)
 header.d=none;theobroma-systems.com; dmarc=none action=none
 header.from=distech-controls.com;
Received: from DM5PR01MB2457.prod.exchangelabs.com (2603:10b6:3:41::21) by
 DM6PR01MB5705.prod.exchangelabs.com (2603:10b6:5:158::29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3805.16; Tue, 2 Feb 2021 00:02:54 +0000
Received: from DM5PR01MB2457.prod.exchangelabs.com
 ([fe80::9de6:ce8a:e281:8e63]) by DM5PR01MB2457.prod.exchangelabs.com
 ([fe80::9de6:ce8a:e281:8e63%11]) with mapi id 15.20.3805.024; Tue, 2 Feb 2021
 00:02:54 +0000
Subject: Re: [PATCH 0/3] Handle UART without interrupt on TEMT using em485
To:     Giulio Benetti <giulio.benetti@micronovasrl.com>
Cc:     gregkh@linuxfoundation.org, jslaby@suse.com,
        andriy.shevchenko@linux.intel.com, matwey.kornilov@gmail.com,
        lukas@wunner.de, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        christoph.muellner@theobroma-systems.com, heiko@sntech.de,
        heiko.stuebner@theobroma-systems.com
References: <5FC36FF8-8F09-4B82-92C0-BE5E0AA2C117@micronovasrl.com>
From:   Eric Tremblay <etremblay@distech-controls.com>
Message-ID: <f480b022-0dbb-7dba-e426-2882683ec54b@distech-controls.com>
Date:   Mon, 1 Feb 2021 19:02:51 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <5FC36FF8-8F09-4B82-92C0-BE5E0AA2C117@micronovasrl.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [2607:fa49:6d60:7d00:81ec:ecb2:e06b:bcd1]
X-ClientProxiedBy: YQXPR0101CA0007.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:15::20) To DM5PR01MB2457.prod.exchangelabs.com
 (2603:10b6:3:41::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2607:fa49:6d60:7d00:81ec:ecb2:e06b:bcd1] (2607:fa49:6d60:7d00:81ec:ecb2:e06b:bcd1) by YQXPR0101CA0007.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:15::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16 via Frontend Transport; Tue, 2 Feb 2021 00:02:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: cc9e1498-1b53-464b-0322-08d8c70de3a0
X-MS-TrafficTypeDiagnostic: DM6PR01MB5705:
X-Microsoft-Antispam-PRVS: <DM6PR01MB5705EB38F01DA51A34099DE395B59@DM6PR01MB5705.prod.exchangelabs.com>
x-pp-identifier: acuityo365
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 44fAAtdhWfUA0TIOGj7Sp4apj8p2rPJIZWyioPOszo5Uqrvb6x4ubE6J2c2WVo2YFhijbTXIPTqJ22dvFNFgVurNKq0WNcq98fb2kHpsViYVIrCE3Mam1PS8ELoRZRe+SPGq4q/+D5LqHjFK/MBGzFT4fpXINFaPNCRYXYHB5L+xOJwIY8n2STWYiZScVemR9sMmi6HInQr8/CCi8+QJ5BOXBT0PHcrRh7thuNeZju1esziIUn+0iefw7nOINSKrVFMejNBnGPtm/N3mkKv1qzfKUB6/yjv/tAMQVXpcV8OkvzTgaaTzhhvj62hmJMMQj1z9sjAsCJjU7YlckePfPvOOTAE8VjvtkL1hpTwjBa9kyarh5QH3kxvEBEVrIPHpEVzZxw3EiDon8kRlPM9iX0QGwgxvxkASplyAWSqA6AwAab3pgHwtUDcPCasFod7E1ZMODpux92NaxAhiRSHShRDb2fHyY4IG1Xu5cywjMSyn+TaMaekira5B1sx7QlvgD6iY6GuFY07cazs59x11yXjHFEPUdyxjc1i1b3N+fbindzf5T6YB2dNev2l8KsVFwBwPc+Zm19fwf70FqMpYIW/6CX2qihmTJeKpOcC0NBU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR01MB2457.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(366004)(396003)(39860400002)(376002)(7416002)(8936002)(2906002)(2616005)(4326008)(5660300002)(186003)(66476007)(53546011)(66946007)(16526019)(66556008)(478600001)(6486002)(316002)(36756003)(52116002)(83380400001)(86362001)(6916009)(31686004)(31696002)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?U3VIdXhkMEZYZTl3ZmhLaFhJMUQzbXk2TTArakIyY3RUNmhvMGJjaldGYnJa?=
 =?utf-8?B?azQ5TzFLN2hmNWt6ZXZUZ0pvWDZvRlBEMzBZR0w3YkhySlVGK1MrRDNzUGNP?=
 =?utf-8?B?MnJuVUR2SXVDVkpwU3NSNFB1NzFBa1lBUUFPNG8zTmVUUzN4M2h1eWUySHdK?=
 =?utf-8?B?V0pyWUJxb3pmdXFYL0FRZ0xqbUIvTXEyMzBJYU0wTlZTaEdoME9MODBUeWZk?=
 =?utf-8?B?bEZFeEhpZnRxNXpQVER6ckNKazR0NVk4V3plWm1ZanZKVWJLbGF1aVRVOXFU?=
 =?utf-8?B?bDBldFMvc1M2OHV6OTl6RmdKZnNSLzlYMm1OVk14dW5kcnV2UFZ6V2c5Rlg0?=
 =?utf-8?B?TE5STWJhTkF3UjdkdkU3R21adll5ajdWVmNVeEhZczRCcFdXZkFTODZrQjg4?=
 =?utf-8?B?QkNpaEFjVEdxVkUxU1UrQ09wN3VXeE52QnVBWFBNRjlwdXV6M25WcnM5Yk9V?=
 =?utf-8?B?VytWOXRjdlBKZHZUQ29UZGVHUVQ4eTdwbHpXeWN2UUhFQ2g1NEh0VmlDcXJt?=
 =?utf-8?B?OTA1YXUwTytmTzZmUStkaWNaYkpVblZta093UFYzQm5nL2R6bmxhd2VEcDBY?=
 =?utf-8?B?cHVjWnJOSUxlSHgrRmlmajVnM3p5UnB4dndZMzEwWGxva3p0elU0KzBjOStw?=
 =?utf-8?B?UjVpK2dTdVdXclRGc1AvSFNRZHpQYjdNL0thUEJGLzV0dkJyVTRFekJBMHBH?=
 =?utf-8?B?dzJJc3JTcWxVNzd5WXBFYlM0Qi9DL29tRUcrOGRsWkR1anFTVFVjcXhQOHAv?=
 =?utf-8?B?ZkNsZWJvYks4TWxFcWkxbnprNkpCWTdXa2swSzJhUk5jQjFGdGoxSmZEZkxv?=
 =?utf-8?B?QVpFWjBtS0w1eXlRUFNJVjJCbGkyVC9qbUVCYk9lT0Z3RWhySUhzQ0NsYWJr?=
 =?utf-8?B?NHN0NDVzSldodDJWR3FwVExSTStyMllVczRCdFRYeER6TllrMDF0SWE4ZHV2?=
 =?utf-8?B?UjdNMjByMTRJVWVXLzJoYzJibXVVdFovNE5lUFR5MWpiOG1iT0xRWEJXYTBL?=
 =?utf-8?B?MHhlSnIvZE5SNWlKL01Qa1hjRHlLa2hndE42VXMxTnFRR1c5SGY1TDd6U3dM?=
 =?utf-8?B?QkJrR2ZrVFRCYUVEa3BITDJlcFdPejhuTUZHanFZOE1jV3JnU0ZJWGRYUk1I?=
 =?utf-8?B?NkllMkp5ZERjU1RwVFNYV2tnemVGRHVzRnN4c1RHcVRNT3U5djV4di9BMHAx?=
 =?utf-8?B?MDRGUWVnZVRpMERJSEoxdmtldVd5WU56VElBa21tamhwNG5Pc0xaV2ZQbVlI?=
 =?utf-8?B?SFFNaFZ2UEtMU3F3MzNRNnZlV2NIR3dwNkszbk8yWmpleTk0STNKaHZlak1C?=
 =?utf-8?B?NlhFcDBYM0tERDlZckZpNHZBSzgrOEZhT1pJeTFqdGs0MVlVekVYSTRqY1J2?=
 =?utf-8?B?R09iUE8yL3dFQWJPb2MwVG1vTGlMQ0hsRUN3L2V0eUpUN1BTbjdSTmMrZ2Jq?=
 =?utf-8?B?RjJ5T1ZPYy90eVU3UWd6ZHN2VDNMUEp6dlR2c214OVNLa2oxSUZnZ2s1VFRh?=
 =?utf-8?Q?cNgq06CWeuT07m+QtxGiVZb2Ur7?=
X-OriginatorOrg: distech-controls.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc9e1498-1b53-464b-0322-08d8c70de3a0
X-MS-Exchange-CrossTenant-AuthSource: DM5PR01MB2457.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2021 00:02:54.3630
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: caadbe96-024e-4f67-82ec-fb28ff53d16d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hCY9NnlVaQAzu93LAwjk7bioUs1GG0ttMWeUvYTHmwMwFx7UDoouQ8YgW8ZGWk6DOI/a4yijMnQYxWc7Spfsgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR01MB5705
X-Proofpoint-Processed: True
X-Proofpoint-Spam-Details: rule=outbound_spam_notspam policy=outbound_spam score=0 phishscore=0
 clxscore=1015 malwarescore=0 mlxscore=0 mlxlogscore=999 impostorscore=0
 bulkscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102010135
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 2021-01-28 7:12 p.m., Giulio Benetti wrote:
> Hi Eric,
>
>> Il giorno 29 gen 2021, alle ore 00:37, Eric Tremblay <etremblay@distech-controls.com> ha scritto:
>>
>> ﻿The series is mainly about the support of 8250 UART without TEMT
>> interrupt. I saw that there was some development in the past but
>> it was never merged. Since the last discussion were quite some
>> time ago, I was not sure if I should post a v4 over the
>> last v3 or start from scratch so I decided to post a new patch. Please
>> advice if I should have done the reverse.
> Please keep my and Heiko’s SoB and add your SoB too describing between [ ] what Heiko has done and what you’ve done. 
> For example:
> SoB: Giulio
> SoB: Heiko
> [Heiko: ...]
> SoB Eric
> [Eric: improved timeout etc.]

I will add them in the next version, thanks for mentioning it.

>
>> The approach is a little different from the last proposed patch which was
>> doing using a polling at 100us. I tought that it could be really long on 
>> some fast baudrate and really not that long on slow baudrate. The current
>> approach is to calculate the time of a bytes when the settings are changed.
>> When we get the interrupt for the empty FIFO, it's the longer it can take
>> to empty the shift register.
> Good idea.
>
>> The other two patches are to use that features with the PORT_16550A_FSL64
>> found on some chip like the LS1043A.
> Do you mind to add my 8250_dw patch that was originally part of this patchset? I had to send it
> soon, you’ve preceded me :-)

I think there was still a comment pending on that patch. I think you should resubmit
since I think it's a bit out-of-scope for me.

>
> Thank you
> Best regards
> Giulio
>
>> Thanks
>>
>> Eric Tremblay (3):
>> serial: 8250: Handle UART without interrupt on TEMT using em485
>> serial: 8250: add compatible for fsl,16550-FIFO64
>> serial: 8250: remove UART_CAP_TEMT on PORT_16550A_FSL64
>>
>> drivers/tty/serial/8250/8250.h            |  1 +
>> drivers/tty/serial/8250/8250_bcm2835aux.c |  2 +-
>> drivers/tty/serial/8250/8250_of.c         |  5 ++
>> drivers/tty/serial/8250/8250_omap.c       |  2 +-
>> drivers/tty/serial/8250/8250_port.c       | 89 ++++++++++++++++++++++-
>> include/linux/serial_8250.h               |  2 +
>> 6 files changed, 98 insertions(+), 3 deletions(-)
>>
>> -- 
>> 2.17.1


