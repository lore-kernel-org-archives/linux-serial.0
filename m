Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FAE9C4338F
	for <linux-serial@archiver.kernel.org>; Thu, 29 Jul 2021 15:31:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE08360F42
	for <linux-serial@archiver.kernel.org>; Thu, 29 Jul 2021 15:31:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237869AbhG2Pbc (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 29 Jul 2021 11:31:32 -0400
Received: from mail-vi1eur05on2080.outbound.protection.outlook.com ([40.107.21.80]:13768
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237794AbhG2Pbb (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 29 Jul 2021 11:31:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R2bFk0eNF7dgG2iWeXDbAdI7iRQ6x5MZGmHRd9u9g51Fw2yZmxQBrixjjd/N+birp8TwqFvNG1qwjm6JSuwbCl0pNRYRHlY4l4V0320aCBWYoOTNYhnhSBe8C76TFSa0HRNW9mAmJjiNsNiIxn/eEBJZP0Ld4qKGJXjinwgkSfz1NC2Dku1Vjr5W3ZHZL1WbHWGuwOYIOEATX6UZag6RQ0TgOOzvuJvyt1N+ziBr/dYgMgAJpD0vLkgEwVJvolE/a3EOPjFVr5XzX6P8hMeHf2BUlWYjd2/1oc6g2tMPA/2lQE9QNrwVytUFz3UIQNCi4O8KRHf3OYK7MuPnEwZh+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q71i+5pTi/kydRMjmpm2sFp7Fa9zGpJen7zoEQ02Lfc=;
 b=frhf+i+WzxHOsgSxExzc9SVS0Pb26Y5/OkDb/oYmzte2MPCXly0Wj2aF5xNdPT26zMHa8Pyx/y7fSqrUS6LpN0aqv47tT4KXi+H48myRKULXfgBiXV8bfpHAlecdS7ZFJN0TeUyp/LkVSHImEIrWPDmHyR/U8/OEJE/rhGu6U62TEpk9yRjfwvcHiUMq76GqlhZuvjJbALNf0R7ctNwRFnYi3MXwD7yvbgj1uKqKrjEGtUK/QsZWUF3zAoI5H8fN9OXBVQewVsLHWVdQccYGuuUrro4Kd5juBeGuIG8mViticwc4I4jKiLsIQQAkjqHJ444zaUPS0r+P46hgwhRDkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=secospa.onmicrosoft.com; s=selector2-secospa-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q71i+5pTi/kydRMjmpm2sFp7Fa9zGpJen7zoEQ02Lfc=;
 b=FiUdAXl5ywjOcoISEQTgFp3VpbtJ9Hwfv6foFC79t+H6WfnOur0gP/TMIk+RrZXc3SxWOoHfBzKDdIV1ayAeT3Z5qOUcXv0B4YHvfqu+p1XBqRnGCVDdSHRCmSdAgst0coxIRAb1zjaWWBHVgsWKmah+c064j7KXg5vOINVRwOs=
Authentication-Results: xilinx.com; dkim=none (message not signed)
 header.d=none;xilinx.com; dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by DB7PR03MB3801.eurprd03.prod.outlook.com (2603:10a6:5:33::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18; Thu, 29 Jul
 2021 15:31:26 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::dc6c:815b:2062:d1f1]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::dc6c:815b:2062:d1f1%7]) with mapi id 15.20.4373.018; Thu, 29 Jul 2021
 15:31:26 +0000
From:   Sean Anderson <sean.anderson@seco.com>
Subject: Re: [PATCH] tty: serial: uartlite: Use read_poll_timeout for a
 polling loop
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org, Peter Korsgaard <jacmet@sunsite.dk>,
        Michal Simek <michal.simek@xilinx.com>
References: <20210723215220.624204-1-sean.anderson@seco.com>
 <YQLCX5pTkVC1Url9@kroah.com>
Message-ID: <be426a00-d60b-a645-8f5f-f2beb104461f@seco.com>
Date:   Thu, 29 Jul 2021 11:31:21 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <YQLCX5pTkVC1Url9@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR07CA0023.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::33) To DB7PR03MB4523.eurprd03.prod.outlook.com
 (2603:10a6:10:19::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.1.65] (50.195.82.171) by MN2PR07CA0023.namprd07.prod.outlook.com (2603:10b6:208:1a0::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.20 via Frontend Transport; Thu, 29 Jul 2021 15:31:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 61a0b510-5e22-44fa-dc52-08d952a5ed90
X-MS-TrafficTypeDiagnostic: DB7PR03MB3801:
X-Microsoft-Antispam-PRVS: <DB7PR03MB38018286F191EDFFD850D2E296EB9@DB7PR03MB3801.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vLUszvOcJ7+t6z8paPEHJjyiXPpQ+CYmutS3jjVN2IY5nGYPuZynlYIR1rRcWrvcBL/17M40SZtKMDvkM1/0twidLs0FRUTH9mWSWH4GjTdGkVfss3BjIoGWGgNII1kJnkdwPXVArB3IHEWR/FVB8I74bnK6uLYaYKqD127FabQZXC7w6SnnyvJj7byETr6CnABwGN7fvZ3aZKQG3dsUGf5swiXUoF804KTMDStvoBsexQ3clKA4zKvLjlbTks6rBkqwo9IxOiDH/qG3DC/ef0ALFYoTl9uJqKiuCTWEIu+P2zj6G5fQ6zRIwKmzkzPoFpQSOJwu1e5oYN229vjuLgC3NYjL2CmsDXpZbpjQW/IAOKa5Z7jZEd0dW0YX6J120Fhvdh2nOdwPYSsM7mO024mu1AKJmRT+eL64iBppvu2IpeK/Mip+LdC8RdrfAe4F7LbF1vgGhC/hDd+9NMNu8v9hO20nTR/ZfxOG3qTn1OD3KLt32yl84xsxPw8K4zV/BXlwWdNYXT7YHaghrABLOAFm1VmQD/kUdcAifLVo8GQL0io/lAUK0f0E4n2MmZ376NuE7HkNnXGCRTVaPntoHPBciLst0Z33jzffrosfpslFzUjbWxuA9gEQ3NLu/kk6Jq4wc53mzSwWF1wPqUNX4aoU/40fQzWC/CniKrRr7ijL5JM5oQ/7nbJdXKva1rVvrK/ik0DERWd+W+ble8Yjsdsa9d13BRcJcE0sxTrImPxMGPlU4PWN07LJysRLdzdEQjNweAHabjWT2OLEuntOAA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(39840400004)(376002)(136003)(346002)(66556008)(66476007)(6916009)(36756003)(6666004)(2616005)(66946007)(31696002)(956004)(4326008)(44832011)(86362001)(54906003)(316002)(6486002)(478600001)(52116002)(2906002)(16576012)(53546011)(5660300002)(31686004)(83380400001)(186003)(8936002)(26005)(8676002)(38350700002)(4744005)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TjQ0Q0wyT1dqRjcwVUVyVDVvOXNtNnZ5d3JUUkpGRlFJYndIempsaGVyaDdN?=
 =?utf-8?B?YWJWTXBvUG1uTDAwTzFLZmc1aFdCSU1CMHhKQVBkRVAzSzM3U2NVZG5YMFNh?=
 =?utf-8?B?T3J2c3RkVkx1Njh2bTNNR1M5eEgxK2lzeGNGcjFkZGtySWRXVXVFTk9KajR1?=
 =?utf-8?B?UEJLNnlIQ1VybTJUbC9VbE5UVUFRYll2dEx1dVE2ME4vVWNiRUVMTFphN2pF?=
 =?utf-8?B?dG0ycDVIU0MvZk9wSkl4eUdCZGZMMXFCY0FBaloyb25LYlFYejMvTUVxeGpk?=
 =?utf-8?B?SStYM2UreTlLZzc0RXhFOFdiNVhtZlJlNXhHTXd6OXZWZCtpRUR3Q2VLdlU1?=
 =?utf-8?B?b2JjWDdIRVVDQkFOZWdydDFhRjV4VStROEd4TVdxTXVTYm1BV1RFa1E1UzFh?=
 =?utf-8?B?QWNNNm5kdUFwSXZObWphWGFBLzVYQW95K1BMMVBpSUJDYmtCS0lFMXJFUXQz?=
 =?utf-8?B?SGw2RWFBa1FqZU5rMWtvQkZLZ09keG9zOEwvemxrVmNOdTdyWC9ZMW5vaGc1?=
 =?utf-8?B?c1dFWWFMZEQycng0VndVOThYQ3hmR2I5WFRzbnJpd2haZTBJV1hvbTZJbHBL?=
 =?utf-8?B?WndzbHpNeThCdEZZNm80YmNvbXUweFNCUXhrQUdDTnFZbUNlMStkODdVM2cz?=
 =?utf-8?B?bEtueTR5Q0pTOWRWa0pRM1VFZWo0TkR2Uk1GQUh3cmVJdk9jblJuWk56VUVz?=
 =?utf-8?B?eGM3VWdlNDZPaS95MFZtTEp4RThrYXF2MVZzM0NMcTlQcGxFRFVKU2p0RHlD?=
 =?utf-8?B?dTNNYUNvQ3Q5VjEyclJGcS9YalRVOXZXWGhUdDhjRUowRDgwOXhTREV5d3o5?=
 =?utf-8?B?SzkxU0owdDBIdW9BSEpSd0NTcmx5Vk5aNzBMV1gyb29Qb0QxS1E5SitjeTM0?=
 =?utf-8?B?QXAzdU84cEZScnBIY2czVW9pdVNJZmJJaGE1bFpQYUNrTm1CRHpDcXFkV24v?=
 =?utf-8?B?d2R3blJDOTNyY0NwK1RiMFlkT3BuQ2I5NmZkMUJyNmd0YzdrMGlxaTRyTnBl?=
 =?utf-8?B?YndaRm9zc0xScmxxd2tHUWRZMGwrMXBzNDc2OVFSczByRTIyTkV1UEo4NjJB?=
 =?utf-8?B?OFpoaEY4Z0xhZHdQU0E5YlQzUDdiMFZ5a2FHS0N3V2JFSWRQNTJ0YVV3cnZ4?=
 =?utf-8?B?M0FNMkJNaVFSV2p6YUcwNnBFWUZHMWorQzcySGhWeTg2YUx0VzN4MDdUTEg5?=
 =?utf-8?B?STh6bWNmVFZCTzgrRnQxOGE1eThVNW9tNllnYzEvWjJpWnNqa3NONGlyRDRN?=
 =?utf-8?B?RVBrNTN6S0ZLLzh0OG80d3hzYlFHMXhOeHdqaUFyN1pPaTlOd0tnUDQxS25R?=
 =?utf-8?B?ZjR4M2x6dkhJTllPeWlTMFRhVXZ5Q0JlTGRpN2ZKSStQK0NYL2N2cGo0ZjY2?=
 =?utf-8?B?SEtia2hCZm1sNFZzMnUydkJOSXMza2ZYLzhTa3ovSkFpM1NVNnB6UjFOZUlz?=
 =?utf-8?B?V3lDbFV2dmllYnk2bUlRTk5tRzNhT2svZmtaMElseGFzSWlLU1BoVGxlcS81?=
 =?utf-8?B?a0U2Q0ZRYjdWcTVNN2NaOTdUWVhRcitaTUdzQzBHK2NOQ3dPeENlOHpOWGtp?=
 =?utf-8?B?SFlHb1ZUTzB2THFBRFY4dmJ3SU9RQ2NzY3hWb1hnVnlNVXlRUTd2YlB5K1k2?=
 =?utf-8?B?MGJvbWRNUi9uam13dlVtdG8wRnM5RWxiak1KYXNvMW94S2U0QXBPYS96dEE2?=
 =?utf-8?B?a0QxQWpFa04xTjNyeVM2eVpSZWNNVjNNZWZveEJPVDdzWnJwV3JvT1cvTzRa?=
 =?utf-8?Q?EVmo0Jrb/wrkc0lUrYPz1qIMkQ0Bt1U30dKWp6m?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61a0b510-5e22-44fa-dc52-08d952a5ed90
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2021 15:31:25.9610
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QbcAAeH1p311aKk0rAbvYr4hw6UnVXGr1Ti7rXUFzUNSM+GIbO2/ARwkIP/+Mr6jpvv5EudyxEcDKh1t5PQocg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR03MB3801
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org



On 7/29/21 10:59 AM, Greg Kroah-Hartman wrote:
> On Fri, Jul 23, 2021 at 05:52:20PM -0400, Sean Anderson wrote:
>> This uses read_poll_timeout_atomic to spin while waiting on uart_in32.
>
> That says what you are doing, but nothing about _why_ you are making
> this change.  Please fix up.

Ok, how about

read_poll_timeout was recently introduced, and can be used to simplify
our console polling loop. This results in a slight reduction in code.
early_uartlite_putc can't get the same treatment, because it can be
called before udelay is set up.
