Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0511C54E76
	for <linux-serial@archiver.kernel.org>; Mon, 20 Nov 2023 11:06:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232711AbjKTLGe (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 20 Nov 2023 06:06:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232475AbjKTLGd (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 20 Nov 2023 06:06:33 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2076.outbound.protection.outlook.com [40.107.243.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83D68C5
        for <linux-serial@vger.kernel.org>; Mon, 20 Nov 2023 03:06:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IBYYl9WcmD7NWCjUkbFUBd86rZWqQnGxuntZwLkugICLsuIvEYTA0aQOv/dRz+5FkVNIjqOiUqn+YFr5NqfM36pe41QEyzIBsTFiysP7dfpg/SewPap7IUNqLw/B9LiNFqwzhso+IfEPKnFNhm7EQ56a+OqhuUCmspYbJOWxs6gGZEOjTRk8imifn0OS4PKOm3mbLBsLAfunokY9SrGCOZ5AKQP2wxnvAJTaCpe3TFEHgMc6xqVM7N0L4HrinXAu2avb0W0ZV1QX7LfSIptWyu+8rnVPM1/QL+usmNHsLAHruf1tSEwIF7sFmZIgPYdSvZSs2tgzZWt52XawUY/6Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OEPX0+i3hIgT+vG51bQnu0N4R9SFrzgVlCmmyZYk944=;
 b=GR8+i/OsGabmRZjZn1lY7HIE28j06tTVqkENYFzk83ia6hlhd+1voZQr4LyB80vzteFKyGLZYF1tkkNUH6bpsCsoLs5c5Wbv8pGGWIo2hL3ge73Yju7TsOXgdcYHS5sd+1JzUueseoNDBeiiYZlBEvYs+s64D4XshIASeAnvzsWpa/BDoUl2K8D+0seORKg8neEFuuFMB02RI6bll/o1K1cNjomVCfq9nfdmMLjJvf0/vP+Ra6YZnmb+ncbxdW4mt8Ai59UXfXTHsUV1tH4y9aC/yVaycwTwOUYVImqpd116cIq8uBdxqfod2BUsbQwy2T161hGVG+uLES8aPFuc5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OEPX0+i3hIgT+vG51bQnu0N4R9SFrzgVlCmmyZYk944=;
 b=vjz37hIGp4ssOneEwDCNweUJeyellPvbdqu15Q8WDZbvNCYQF4ls5C1J/P+r0HDCHfPgfec8RucdHWu4bdlBmVu3Yewx1qWwM/Ond+FmEzYHaJAgV0G21EpcA2G9tnJHKSIwApWhYIcysnd+SKD9pGRCFiU0Ma3e9zetDmzhlJE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by BL0PR12MB4914.namprd12.prod.outlook.com (2603:10b6:208:1c4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27; Mon, 20 Nov
 2023 11:06:27 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::39a2:42da:ea20:3349]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::39a2:42da:ea20:3349%5]) with mapi id 15.20.7002.021; Mon, 20 Nov 2023
 11:06:27 +0000
Message-ID: <317e9341-4341-45df-976f-81468e821f74@amd.com>
Date:   Mon, 20 Nov 2023 12:06:18 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] serial: xilinx_uartps: Fix kernel doc about .remove()'s
 return code
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     kernel@pengutronix.de, linux-serial@vger.kernel.org
References: <20231117101236.878008-1-u.kleine-koenig@pengutronix.de>
From:   Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20231117101236.878008-1-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR07CA0276.eurprd07.prod.outlook.com
 (2603:10a6:803:b4::43) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|BL0PR12MB4914:EE_
X-MS-Office365-Filtering-Correlation-Id: a4be78af-3b20-47cc-ab48-08dbe9b8bd7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pmOc0lOGBGtG9s/Hq0bYcJLytqWOP+VtAwIiwjgF1bUsqw7OAVl9GuMsVyILM0G5Qw87DiQaTXZ/bh/ANWoyuw99zArh7gLxqQR1/YP9yfrcBU5G33bQTJ2NYiU8RLbmiv7xC1tjSnF/sv053JydCI3aO9LCvJ/XAo8OgRXqRg0QSkG0ZCDahp2JpPzWzZIlBZR4RRZawoObdxUCnAJIMC5CHpjK+rZy9XXl8ktmffcv5aF/3w+ZIYexzIzUdXef/nUQ9rFjbymLVS6fU6qD9BVvrTO2dWzk+6HOCvHVYWBMoEqi9UuXg/nIdEDCB94Nf91R6IWUabM9stLqj9NpJPYa2Uzs3oh2qADGZfBXWs2j7klgv2GnW6U0me73GLGSRFJRnmTs1S5eOiMkLgTA2GVCemVf+DhB6I+JREZ37aBBl9OcOpE6wntpLhe3NadPllDixQb7KZsVbSLYMRv1p7fD5ANsAKcSNU7ct07Ft1mILO7kFqeE4hhqtIDU8XNFoldlsCrOhlKmpJQCoYXegWjUQGTKy5/8jbiFQkFd+BzUNzwzFz+7x9QMed+qQXr8CV/kPEV9S83cUoC5v3BVhLVVbj9vcOdn867JlzW93TWXuqr2jMiSHyPYd/cEv57I4ahpzYRuENCAqhg4MXRAZ53qmQPGVK99CvYui9TkG6s=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4758.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(366004)(396003)(136003)(39850400004)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(83380400001)(6506007)(53546011)(110136005)(38100700002)(31686004)(316002)(8676002)(4326008)(66946007)(66556008)(8936002)(66476007)(478600001)(6512007)(2616005)(966005)(6486002)(26005)(6666004)(44832011)(36756003)(86362001)(31696002)(41300700001)(5660300002)(2906002)(142923001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?alZjTXV2WmQwL0l3N01xNTBQNEVJSWFveEpSWUZDbXAyRHF0dlJXSHAyVzd2?=
 =?utf-8?B?NXBIMHhtVlA3dG9ZcXhXL2M5Y3lyTElBa2xCUFM1TDR3TjJHR3JxOHE0Uk1E?=
 =?utf-8?B?RHl3TGhrRlBoZ0RCNEErL1VnSXc1b1phVWtLYk1CRVJURDJtKzA3T2c2U3M4?=
 =?utf-8?B?enNkL0lWL013UVI5ZzRZQ05QTzRzd09aRW5HV0FkcFdDRXE3V1F2N0d0M01u?=
 =?utf-8?B?OXpRSFEyWWxXR0pOaEVpL1FBU3pRaWtDQjZjM3pVVWMwWTFRUkdLb2d5cGFP?=
 =?utf-8?B?dGw3aGxVM2RlbDkyeVQ3UThmUjdiVERobFVIRjlpZnNhbTNpTndWR21NWnox?=
 =?utf-8?B?ekREalovL3gwWUwrMjAzMitTRXpYUHhuc0xzTHJnUmJXMmhNOWkyZklLSkl6?=
 =?utf-8?B?bFhhVnQydlZ2R0kxSVYxaXZERG1ydWJrcUdPUnFlakJQc1ZlMmNyMmlRa1Vm?=
 =?utf-8?B?MEpJb2tUS0liVHYvYVJtR2dEbXRDRnJVYTVmTWQ5Y0d4eUs3b0p6SmNLbVdo?=
 =?utf-8?B?aHUva2VHVGlYYXVFeXpHdDEwSDFkQndKcWFVKzduWHdoMzZvMEp3cjVRVVcw?=
 =?utf-8?B?YTA3MTc5U0YzSkc3WDRJM3NMR0FQOXZLeW94NzYwTnE3TUgvR3l6T1U3ZlhZ?=
 =?utf-8?B?dC8waUQzcGRnc002UW1heDhxWmgwYWFIQzYybHJ2UTBmekNXWUR5ajZJdElE?=
 =?utf-8?B?eGJyUVVDbTZPaEhzZG4vZ2xWZEhkY3VVK0lrbElna3dCdXhxb2tBMmJqUjFs?=
 =?utf-8?B?U1hpWXJyTWxINHlET0krUi9QMHc3UmVDVXhYQ2U4aEFhNTVvMVpGMHZrTGtF?=
 =?utf-8?B?OFNIRmlGR1Y4cklhejN6UWtEOHFob1dId2FFYnBEa0IwcFVzN2o2YUcrMHVn?=
 =?utf-8?B?WmZKekJlcVJQbmFzMVcxUFRWTUVEMXlMVi9nYm1EU2hZNEtqTmRwSjJPZk1B?=
 =?utf-8?B?dzNZWWxiY1pxWUhiSGRGa0daQVc2djFEdTBHbDdLRnNPZUNTcFc1WHliNlhU?=
 =?utf-8?B?Rk41SHMyUXBlWEhKbDNqeVpaY2RtK1NUc2tZc3h0aXljL1dSeGV2UEh1NTg1?=
 =?utf-8?B?amVucnBuWGZkZjlNbzJKMTdsTndUcmhYUm51Q0piYzhzUlFucG9FWmplZ2Fl?=
 =?utf-8?B?akwrbzRJSGp5K290cHo1YVhvRlJLUXN0V0Vsc2RUWTd3TGtHdFlVNDJWTVFR?=
 =?utf-8?B?R0xiZjZvb1ZrT2RiN0hIVnExQVlPclRYQmFidm00NW5xTHpSNkZoTGZNNUNI?=
 =?utf-8?B?V0VhbXVQN1hkbERmaHAvc2srTXQ4T3pOQmtDQnRSMmV3SjRqdVlTNUlSbDdX?=
 =?utf-8?B?c1ZxTFRZZG5FZFozeU5nZ0JrcWlFU1hYWC9MMGk3VjBZNTZ5aDIwaHdjOWxr?=
 =?utf-8?B?WlMyeEk0dm0xYWF6NlJHZGdTSkVUMUZMK3BXZ3JpRWVCL0w0WVhURGhLTnJx?=
 =?utf-8?B?OWdtQkJmN0d6Wk5QeG9Dc1R0UzgvY0pzMTMwek1HT01wd1BhSThzeldFYWs3?=
 =?utf-8?B?SDZQZnRaM2RwZHk1aWRvQytMcmZ2QWZwbFVmK3Y5blVnK1hjQ01yTXNqcTIx?=
 =?utf-8?B?eDdpbzBXVTd0c1VNcnZyQ1VhL0YxanhZZEp0d1hFUFl4Tk9mMDNyc25KR2Ri?=
 =?utf-8?B?dGZPdnY5Z1k1RHRKV3lNSE85YURSWWZUY3MyWEFVaEMrTVZNbTNyQlgrUGQx?=
 =?utf-8?B?bEpFRHkrTXB4cEFLbXVqN1RDQTI5dmp0NVl2cFh5cXY1NndwRktqbk1KZUZD?=
 =?utf-8?B?QjVyVUhJaDlPZ3k4UGdvTTQ4R0xINVVtcERncnd6NS9GZFlnazZSckUrZmRi?=
 =?utf-8?B?Qnc3Q2RWWWxOVEdUY2NSTUU4aTczeTFZblhzR082RCtJOUJoSTJiekxURCs3?=
 =?utf-8?B?S1I0U1QwWDVjOWI5Ym5pY3hzV0xsSlZkZ2dQN0FFRnY4RjZtYXVwV0NOMlpE?=
 =?utf-8?B?dlBCYXMwNVZKNk5yRTFJYURQWWt0bW1WMGFrUCtMTEtHWk9MWk1EdnBTV2FL?=
 =?utf-8?B?MmlFVkhpMXUvY2NJcnlNdDE0TUVySjFHTDdpUVhNaUtmajE4WjNSSWZEeFUy?=
 =?utf-8?B?N1IzMlpZOVpPYkthaXc1ZG5uR2ZVVVpUL0haRHdRT3F0QnlZdGV6SCtOZGdp?=
 =?utf-8?Q?vKU9MjZrJFpIR3lYNPs3Isocy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4be78af-3b20-47cc-ab48-08dbe9b8bd7f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2023 11:06:26.8153
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ATyy6nZXMVmV7IyoN6JAUFrgjv5rQKJ+6RWv5q85aMawZPThY8Ku2AeAyGpbHppx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4914
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org



On 11/17/23 11:12, Uwe Kleine-König wrote:
> Since the driver was converted to use .remove_new() the return function
> doesn't return a value any more. So remove the obsolete documentation
> about the return value.
> 
> Reported-by: Michal Simek <michal.simek@amd.com>
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
> Hello,
> 
> the patch converting to .remove_new is not yet applied, so I didn't
> reference its commit id. It's available at
> 
> 	https://lore.kernel.org/linux-serial/20231110152927.70601-53-u.kleine-koenig@pengutronix.de
> 
> and obviously this patch dropping the comment should get applied after
> the conversion to void.
> 
> Best regards
> Uwe
> 
>   drivers/tty/serial/xilinx_uartps.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
> index 6decf2b13340..920762d7b4a4 100644
> --- a/drivers/tty/serial/xilinx_uartps.c
> +++ b/drivers/tty/serial/xilinx_uartps.c
> @@ -1663,8 +1663,6 @@ static int cdns_uart_probe(struct platform_device *pdev)
>   /**
>    * cdns_uart_remove - called when the platform driver is unregistered
>    * @pdev: Pointer to the platform device structure
> - *
> - * Return: 0 on success, negative errno otherwise
>    */
>   static void cdns_uart_remove(struct platform_device *pdev)
>   {
> 
> base-commit: eff99d8edbed7918317331ebd1e365d8e955d65e
> prerequisite-patch-id: 78ddb8b8246b06d5805c7dc8ad6481c7e4bc22c8


Acked-by: Michal Simek <michal.simek@amd.com>

Thanks,
Michal
