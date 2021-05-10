Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81A39C433B4
	for <linux-serial@archiver.kernel.org>; Mon, 10 May 2021 11:50:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62E6261278
	for <linux-serial@archiver.kernel.org>; Mon, 10 May 2021 11:50:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231769AbhEJLva (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 10 May 2021 07:51:30 -0400
Received: from mail-eopbgr00062.outbound.protection.outlook.com ([40.107.0.62]:61958
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232403AbhEJL3L (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 10 May 2021 07:29:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nesMmrMFhdqilGVkBK2zAks+srmjYCNW8P0EmM56mT/xmq5umJ4pTJXIzxkXq9s2e1UoZGsA6X1HJPGXf121IvFYXBMBZn4yUKezzklgFHzoVGrSb41FZVHFMS0r5Z48e3xYCjTL2NsEL1A7MtTICsNBneNSb3LCETWm+RKIaBjGIlxad7kojoONUY6mp+vsnVmeMaQPFiN7xkEFg0GWuvajruOo1KeLX6GQPf8cqdcNLn3mnKqCwzqknS7a/t/znJOdvNksUEMJh7FF/rz7DHXdeEi+oGu1TGW6sADdYtyRb/rasiqsplPa3g9RYkj/9ZVL24DmlnuLko/pUoJ5aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sF/mfBbXW4pSaQ/gutHZd36n9mgbYZkcq1nLtUEV0eQ=;
 b=coGZfuREV85rH51aMYQgKoPwD0YGeGpJFUY1t/pgKA935zmoBvpLvRrEt7Peu2H0LPKudQGyuwtdVvU36HOvQlMWZm3qCNlP53UgpIjY64xmJuvuDs0naGhbbkqkvYkrEzwN8etjoFoDwAZPNquWnJojPaaruC3o4ewHwqx8wOMYHpFIjsRchswAa5cl+Z4YUe/ezqVU6IuvN8LF4QtkK9FAgIhVRjxMfUrK3PQnSSzN6rBNLAUJg8OqHDa9y3bKCRhVmru1v0Q6s3CekCpCf5UUtgpsgVF3Qte1djxGG3XgRAdkX7roM59KitIIDUaOeUt7X1gZCGtPqAVjFsnXgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sF/mfBbXW4pSaQ/gutHZd36n9mgbYZkcq1nLtUEV0eQ=;
 b=XYjscPtv76cN00ymQYcwYVMRtn+j1nt2qdaVY7ZwVl7PoWZK0LQ9kYXsFacf5kTY3jfnvTEPVJonBwTXlA/EWQzBtqUUCw2toKHsLpcwg6gzf2ULqgTuvyZ5e4C89fkgzrtmW7viAmwHH51vXF43dpYBljvcy+4DFNbrdlhXDwc=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nxp.com;
Received: from VI1PR0402MB3405.eurprd04.prod.outlook.com (2603:10a6:803:3::26)
 by VI1PR04MB4895.eurprd04.prod.outlook.com (2603:10a6:803:56::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.29; Mon, 10 May
 2021 11:28:04 +0000
Received: from VI1PR0402MB3405.eurprd04.prod.outlook.com
 ([fe80::f1a9:a104:7d02:2efa]) by VI1PR0402MB3405.eurprd04.prod.outlook.com
 ([fe80::f1a9:a104:7d02:2efa%3]) with mapi id 15.20.4108.031; Mon, 10 May 2021
 11:28:04 +0000
Subject: Re: [PATCH 22/35] tty: make tty_operations::write_room return uint
To:     Jiri Slaby <jslaby@suse.cz>, gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>, Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Samuel Iglesias Gonsalvez <siglesias@igalia.com>,
        Jens Taprogge <jens.taprogge@taprogge.org>,
        Karsten Keil <isdn@linux-pingi.de>,
        Scott Branden <scott.branden@broadcom.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        David Lin <dtwlin@gmail.com>, Johan Hovold <johan@kernel.org>,
        Alex Elder <elder@kernel.org>, Jiri Kosina <jikos@kernel.org>,
        David Sterba <dsterba@suse.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Oliver Neukum <oneukum@suse.com>,
        Felipe Balbi <balbi@kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
References: <20210505091928.22010-1-jslaby@suse.cz>
 <20210505091928.22010-23-jslaby@suse.cz>
From:   Laurentiu Tudor <laurentiu.tudor@nxp.com>
Message-ID: <bb07b435-ff8c-1d9d-bc2d-6d8981902be8@nxp.com>
Date:   Mon, 10 May 2021 14:27:59 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
In-Reply-To: <20210505091928.22010-23-jslaby@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [79.115.169.144]
X-ClientProxiedBy: AM3PR05CA0127.eurprd05.prod.outlook.com
 (2603:10a6:207:2::29) To VI1PR0402MB3405.eurprd04.prod.outlook.com
 (2603:10a6:803:3::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.107] (79.115.169.144) by AM3PR05CA0127.eurprd05.prod.outlook.com (2603:10a6:207:2::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.24 via Frontend Transport; Mon, 10 May 2021 11:28:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0783ae4a-8172-40fe-30b1-08d913a6acff
X-MS-TrafficTypeDiagnostic: VI1PR04MB4895:
X-Microsoft-Antispam-PRVS: <VI1PR04MB489545704BE3CACF5642A808EC549@VI1PR04MB4895.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:497;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RR3tp5CK8z7JTqtZQ54dKT2/Qi510kuwZTlaFxujOxaS3dMvZEpg5BCN+WO+kFqHDyn6AXMXyi8ft5ekBCWxfSNlyjv+q1yCwaC2VIvB2IHwfOckuTf16xsoCfCfN5GI1qxae6sDIKwbp1Wr4D/YiBim4bQhIoY8dB2MYecHhQ+99Ybb1nMEtNvX4f9cGAeLEHh6LnitL3Y+MDR8fe8aEkQ8CAU1wll+nTDmFnzNeHpZITAi9Rjxq0CQXN77TkUZtkFLta9Wv02kMV5t9FVCJXU8K48Zi12hvb7YhR90pEg9chqFlwLIVm6k5EP4HJ99du4mJ63OWjhmF4sIVpR7AWD/65TQmvQgRxVeXICI41Z45s5pQ1JXJTLCuHLn8zcmr3qJS3esIiJqHxgY0yEnNM4e5U+hAhvesFIeYU00L2D5iYST9PJQj7TPcxMOkyYWuwwUsdFOuXpifQrBQxQQGY+l5DBHvOJ/MQY9To9FERilCz56hi2mZGx60FK8Y5KgvDbcr24BAe1LNK9YqEkfl3pFPQX2MkNZXGsED9dicDhSWuhJ64dHTB6iYXRAOpt9aGSV+IOGfvM9VBydHQuHpFaPQEHMZUQHTz11gXThi8/ZNBpd8MKAniSi6JCKb7AKBBIZRFO4DdAynWq28UVaXdoS3eqsdmzqmRNtyc6Jrikb0iP0W8M4U+uarWnOmUDwgQrbebZn7V9hc7t+5M4K7Q6d0ceWHl830BkXHeYW7jM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3405.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(376002)(346002)(39860400002)(366004)(86362001)(16526019)(186003)(31696002)(6486002)(38350700002)(38100700002)(44832011)(53546011)(2906002)(36756003)(4326008)(66476007)(7416002)(7406005)(5660300002)(2616005)(956004)(66946007)(316002)(52116002)(26005)(16576012)(54906003)(8676002)(478600001)(31686004)(4744005)(8936002)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?NlhHT0tRQllJNGdkTWthemM4SDE2OWxRbERBRlRGK0FKTnhta3lLZUdLbVRY?=
 =?utf-8?B?ZDJNZVZVd2JTMFV0Q3lmby83Wm1pSVF5djRIMGZUWk5Jc3B6Ti9hMGtrNWpL?=
 =?utf-8?B?clErczBFMWlITXova2lRRkt2Z05ubmZwbHJyVkdmMnp2cDdyVkhMOWJ2RVRl?=
 =?utf-8?B?dGdhMmFIaTJFZWpYaEJQYWsrL0xWN0pwVUVNUFJQUG5LMnQySEdFR2dFa2JX?=
 =?utf-8?B?RXJEenBkQVV2MnJETkpXeFBDV1owT01tOUVhbTBoKytWWVVuYnRsRDJrNGF1?=
 =?utf-8?B?VFhwd3E0UVNBWnZHY3FoazYwRnY0TTFIb1ozcmUxSmhaZHd1cTNtTGNhN2Vr?=
 =?utf-8?B?TmtoMERXaVVjZUd6aHVvQ204eGlJUGE1SGlFRDFOcWd0MmQrdVhDbG9YWVFG?=
 =?utf-8?B?bTRKbHRnbGNucG5oUHo1ZGMya0ZFc1htUEdkeXIrMnFFVzgvdkM0YTFtdlBo?=
 =?utf-8?B?N0tqZ09XcjBxWmJXdDJyQi9ORm1UTlpOUHlHbmgvTXNkMVJaYUhKK3lSOEhZ?=
 =?utf-8?B?OHNuWDFCenNUZGh5VlNmclJ4d2VQZGdIdTZ3RHlJY2NFSDJZaGVQcnhDMHR2?=
 =?utf-8?B?bGhIUUZsQVdxM2JZRmdHQmRIcDZ5Ukx3TWJxYjNoeTJyTURGeWRMUVQ4bS9u?=
 =?utf-8?B?Q0ZMUmIzcndHMjFjdG5LMlBkaEpJdzVBQmw3c1Fmcktwd2NaclN3UVVvcG1v?=
 =?utf-8?B?Y0cyRkdHclJzRGx5czg5Q2llVU9lREloSUp1OHV5ZWhYbm10SHBoSFhubGI2?=
 =?utf-8?B?TGd1NDJuUnpPZjVFYnhZNTdFOTFsaXBDdWo3NldnZjEvalFOd2tpRVNyKzNp?=
 =?utf-8?B?cWdVZnpNQlpjQnBwa1d1K2NxaDRZby9KZ2lSUlppN1VlbWhJQ3Z6bEVDcVd1?=
 =?utf-8?B?d3BWMTAyUmhXNXlVRWlQR2JSZGJqR3NWSmM2ZE5DdWd3b1FNZTFkRHlEYzJl?=
 =?utf-8?B?Rmlmb1l3bm5YUTFHMTI3aGxINU1hYWcvUEl5TnRrb3VURFpMdEtYVzRHcUZB?=
 =?utf-8?B?R2txd21TalMzNTdWVE1rNEIzdHZOcVRjLzJmampsaUl1VTZ2S2dYdHRqUVlY?=
 =?utf-8?B?b1E1TUE3Z0FUU0w1V3dMWk13djh2RmY4VG9ZUFVrOEEzS3lGTkFtUEVtTVh3?=
 =?utf-8?B?NGlrL0hCNEt4OUZMbitnMzZ1MWV1Z0hjNmVpZ3VvcGNXK2FmSXNCanExaXYy?=
 =?utf-8?B?Q3IzZFJBWnEzaVpId1pBaEdqRWszZ0NqTFRCdTdzanU2allqamdnbEY0U1Uw?=
 =?utf-8?B?YnZCRkZNQUZwcWZUS2dBeXpzY09jaVJnQ05kNThIUjF4UjJFdVJHT2VVVjcx?=
 =?utf-8?B?ejV6b2ZYenB1SnhtNkR6T2tqMXhFR0t6VzFRT1FlQ2YzQWNGNXZhbkdWdEVD?=
 =?utf-8?B?eEt6Q1lzWkhSQTBpeDA5VWdIa01Ga0VkUm1qNUtHejl1L1MvUUNBUWhiS0E3?=
 =?utf-8?B?YmlFUHhtaW5qS1lOMXNraVFlZG4yRmo3S3BkcGdzWHhrZ1hVYkhMVzMzV2xM?=
 =?utf-8?B?MFhDeU41OTM4bkVhWlk1TzhNV0Rlb1kxYSt0cXUwdGxiVmVTZzB4ZjZBYzgr?=
 =?utf-8?B?S1FUa2hpVHdqM25EMHFVM1VUT0MzT0FUTms0TW1maDhrTEd1dmZWTlBVTy9Y?=
 =?utf-8?B?eDRUNzlJb3Z3V1lxNnNnSkZLYk9vRk8wTU1taW52M2l6SlpvNldhTXNzQmR5?=
 =?utf-8?B?Znh6Q0dDZWEwemJFcW1XSWxaMHYyaGRmSGtKcmZFMGU3VUpYUVo1SWcxNTlF?=
 =?utf-8?Q?GcZFzGXVn5gIw3qSmj5dpyj+gKrxhiEKqnpowfv?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0783ae4a-8172-40fe-30b1-08d913a6acff
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3405.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2021 11:28:04.0678
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XobJaVTkUFN4R6r40VqBfJ/zdaNp4Pcxi3kfICluw5KTp0mX5BJ2rHZX3xfmuE0y4T6loPPuVE0UMqiNQ7YBUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4895
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org



On 5/5/2021 12:19 PM, Jiri Slaby wrote:
> Line disciplines expect a positive value or zero returned from
> tty->ops->write_room (invoked by tty_write_room). So make this
> assumption explicit by using unsigned int as a return value. Both of
> tty->ops->write_room and tty_write_room.
> 
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>

>  drivers/tty/ehv_bytechan.c             | 4 ++--

Acked-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>

---
Best Regards, Laurentiu
