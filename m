Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 387A1C7EE23
	for <linux-serial@archiver.kernel.org>; Thu,  8 Jun 2023 10:15:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232125AbjFHKPd (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 8 Jun 2023 06:15:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231359AbjFHKPb (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 8 Jun 2023 06:15:31 -0400
Received: from outbound-ip23a.ess.barracuda.com (outbound-ip23a.ess.barracuda.com [209.222.82.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B53401FE6
        for <linux-serial@vger.kernel.org>; Thu,  8 Jun 2023 03:15:24 -0700 (PDT)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168]) by mx-outbound-ea15-94.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Thu, 08 Jun 2023 10:15:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M6Uo2MlsnpFm1myuuDPyWE03jA4KReZsTyOh0Z0EProIqk9atxI9+pSC4z2nwq6cCFiWGjaFZKu43rEKiAHlgPWXSwKC8I4tYktZh58jDFH9dN+qgfzhhkJRFR6sFk00nS+x6cVrEPa7VbdpTin/vMYM/wnu1p9MigcR4ZcJCD5AOPlhDnIUpRzSv6GCOVHmel+7ek3FpVwsSeindeJYpOpKnmT/aOrFGbwBfYfojxyWU2CoZlk9mCK5299Fv3A+SeclSAqhTJM7QUeAxx86+67eANB05a+bTsUXCY4v9Pbm8/109uTxIyE7CPm6UlCDF8HzrF5Xy9F9wZGd3c5KZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rGS48EVQ0LUql5SDBGZLIeh75c3XM+Vyaxk0s8dqV00=;
 b=GxTSI7jBRekxWg+2efNfJniuBQXau7fkqPUeWcs3vwOyazUjbL69bcPLwqqWfwnBj4NrEEz9hHGgF/U3uTiUjqFOEr5ETfJkcsS5YIjFjnPcfRr4wG0yc5A4LuZ7/Bo9zcq4RdmSId19q2KRroC6SLQmokYKRqiOmKIuDzITwT+9OdvMsfajPaQssOV3yUrkVokJVKYBT75wAHNJgZFevs4KSYEDnxDaIATJe62b3zHRb7uvcUAaLLPtoY7htq8KyPopLfJmyfXm9HMDrdSzDvoSgQMPhB1w2n4jRCMM9UTxW3H1ieULaEZBCOe6hhBL9HQDuLVloqVm1dQG/c3bQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=digi.com; dmarc=pass action=none header.from=digi.com;
 dkim=pass header.d=digi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digi.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rGS48EVQ0LUql5SDBGZLIeh75c3XM+Vyaxk0s8dqV00=;
 b=bwrWw1+EjkOeGJFpiyZzo/s/EHQZNOVmQC3WxBg04geTo9XWpdUMDMqgdDdG2Lc2x0v3MsEHgdEuynSpElvqDwYmCaohjLSUxQ0vsRbKlntQ/wAr/lPg8oXtv95p7g0z4bFueAGiRzgmdNgnjm9ocVcjw4ZPy33zBKhG3bB2Ut7ZC10eFYr/Q/DvxkvvN2UllGNPYuBPA/csM1aV1t+rtPKXY44j4g75QMI0sY0ZAi8YC4S8PbPXoNGgQeEam4z9ychdrH0NG13OjPJV9d8aWmeA4YHymocZ+0MuKryn3z3eGXbw0wq5yLuADq74yIKLWV2UIzaWqAwsVRaHEwq11g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=digi.com;
Received: from CO1PR10MB4561.namprd10.prod.outlook.com (2603:10b6:303:9d::15)
 by SJ1PR10MB5908.namprd10.prod.outlook.com (2603:10b6:a03:489::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Thu, 8 Jun
 2023 10:15:15 +0000
Received: from CO1PR10MB4561.namprd10.prod.outlook.com
 ([fe80::c626:ce53:befb:11a9]) by CO1PR10MB4561.namprd10.prod.outlook.com
 ([fe80::c626:ce53:befb:11a9%5]) with mapi id 15.20.6455.030; Thu, 8 Jun 2023
 10:15:15 +0000
Message-ID: <2e57e76d-c47c-8109-722f-224f9f9a1a42@digi.com>
Date:   Thu, 8 Jun 2023 12:15:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH] Revert "tty: serial: fsl_lpuart: Fix the wrong RXWATER
 setting for rx dma case"
Content-Language: en-US
To:     Sherry Sun <sherry.sun@nxp.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
References: <20230607103459.1222426-1-robert.hodaszi@digi.com>
 <AS8PR04MB84040A92A1FBFE8177CF08D59253A@AS8PR04MB8404.eurprd04.prod.outlook.com>
 <347fc250-ed9e-b448-2ff8-b604faa14e7b@digi.com>
 <AS8PR04MB84042413F6C9ECD80A1E87639250A@AS8PR04MB8404.eurprd04.prod.outlook.com>
 <76357719-c5df-6c15-add7-a955c7d106ed@digi.com>
 <AS8PR04MB840416EB91176287C91C88BE9250A@AS8PR04MB8404.eurprd04.prod.outlook.com>
From:   Robert Hodaszi <robert.hodaszi@digi.com>
In-Reply-To: <AS8PR04MB840416EB91176287C91C88BE9250A@AS8PR04MB8404.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0158.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::11) To CO1PR10MB4561.namprd10.prod.outlook.com
 (2603:10b6:303:9d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4561:EE_|SJ1PR10MB5908:EE_
X-MS-Office365-Filtering-Correlation-Id: 07e67c02-3a83-4e5f-383f-08db680940cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CCZQydw7XJ6LKCx3D4U4c728G186nCWSKTvzlnyD5pKK6ydO3tbPhG+rCWbYYIaetDjhYyWaajIYfPEOcK72OTvenWU4GFyaZOETeJSiwjtH6kQqfL/TfBbSEkvUEktPUFYOEvBOd26Tb2se8hBnsZxPVkFPMTmUjzQpiWkgI71ZsWbMVy7zHOkaJDa3o4eyvJkt1MVdlwPm0gK969GpAK0AmqSRSEqvz82Sg0aJ2WoDC1nKo52OcWVQt3AdstrjlKocc3tNftWB4tOFYGp28bhrK8mkKa+YUNXFXXeAHi4itolqvcelSUJ1csiBvW0heP2IxSsybhuQxT6H5Mr22SKoZKmuwFLsQZzW5By/BzTGgScnV+jcYRWsgEs2xXDfJ4608F///1uVVAWthzqCbYGhJyumgdi6vZR1RnECuvgobwne2KiayUcBKOMJKRFBO9hP6JyLYonjeMelbipTgY0LckNA1ewIXyaOwvVBztc8GjjTRSDrYCmZsl8pXqsMuNg92/NnXskO3viRYmjFp11+WWIxRXv54ucZdvNq9nbPq/Iz4U9eBXNkwILab+CPYUMSVSNW/gW5tUFjkGhXLC2JlZDu7cjW/9CTdr+goPCmAG+qFADU1/MfKOZJYjupU/JrkBcMfcuzyAEJcXnGMQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4561.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(346002)(396003)(376002)(39850400004)(451199021)(2616005)(26005)(6512007)(6506007)(38100700002)(41300700001)(31686004)(6486002)(6666004)(186003)(478600001)(110136005)(66476007)(66556008)(66946007)(316002)(8936002)(44832011)(8676002)(4744005)(86362001)(2906002)(31696002)(5660300002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dTQrSG9RSTBiekFkOWZBTlZKK1lWYjFHbVRmT1gvU2JSQ2x0cm1ubkJsLzBB?=
 =?utf-8?B?SVpSV0JTeGhMUGxtdUExaEpWa2svbjg3TXgwZjhIYmFtM21pQXpsWkx3M0ZK?=
 =?utf-8?B?dnBuQWhvU01ZT3k5S3grejJvaTBwMC8wMjZzM2J1MU9lL0RtRk9tdVErYU5h?=
 =?utf-8?B?aS9zbk9NSmZYemEweWdKQmx3Z0h1Rlp6eDFMa0pKQUNGQWJrMWtHVzJveXlH?=
 =?utf-8?B?d05UdGlveUFZQTZ2Qjc3MHRPWkdyWmQvVTZLM2s0d25wMVV0Y3NyNUxzaCt1?=
 =?utf-8?B?czB0ZmNMcHpaQUpKWEI5TjdTZVRrdk91aTdPZ25McUhaaVBpWXRFWk5HOHJM?=
 =?utf-8?B?a2lqNHZsTS9keng0QnV3ZFU3V21XMVVSbTdyQk9DenMxUklYcDlJUXlwQ2pK?=
 =?utf-8?B?Nk9keDFLeU8rdFNsTjlGaEtaa1o2MWhOM0ludUxDUWZXb0NseGs1cE5STUtW?=
 =?utf-8?B?Zkc1ZGZMWXc2bmkvQmJoU3o4M1hybWRRbGpBcXpFU3lEQXlocGZUMExNSlA3?=
 =?utf-8?B?VkIzVnlnY0tjbXRZK2xmcGhiRkxiMXFmMkZwTDQwSEFzV2FPdHE4ODZJSzlG?=
 =?utf-8?B?SHd4Z0J5UzgvMzVLUlgxV04za1Mvek9mQ2NJUk8xWjBGS1VGK0NSdXNYUUtC?=
 =?utf-8?B?TW5ONVJnSXhiWHV4bC9SejNoa0szckVjdzllYXdSRlJEMEdjRE5jWUZ3YjQw?=
 =?utf-8?B?d1VZMU1VM0ZDUDNLU3lCczJyZ1ZBSWlTTmxMSFQvWG13ZjZoZHZHWGxUU3g0?=
 =?utf-8?B?Y0w1UnNsbS82bllOak1pWXhPNFh2b0V0UmQ1Z2RwMG1XMHl4NS9uY1VSWDhR?=
 =?utf-8?B?akZNcllrQnl4MEVBTDJqWTBSMFJwU1VjVUljVEhza3lZNlhtb29Yc1JuVmcz?=
 =?utf-8?B?UHlycGFPeFloUldwbU1kRlYrZjdBNnJPNTlzMFplS3ZXU1grd2RSbjN5aC90?=
 =?utf-8?B?K05DK0wwZndMMUNMSHpNMnpIY1ZWU0UxcGN2YW5NNHhhMVdMREtGdUFoM0pL?=
 =?utf-8?B?eUl0K2ZEMHpYeVVQK2kvUWhNai9zWGJISjBPcWxCUE45aUJpakxZQ2NPTzVI?=
 =?utf-8?B?cE9PMnZLSkNKNmxtNTgrZWJYODVGdXlkVTdLQVZyMWlDQVl2dFBYN2gzM0Fv?=
 =?utf-8?B?MXc1c2FvTnNMU1QvLzdrWjJROStHeERXQkNuZFdNUzdoOHppdE5ZMjRuWUo0?=
 =?utf-8?B?Q25EdzRmUTNjVDNTVW5iWjMyM1YycEpYdEk1WDBoT3U3QU0yMmtEeFNCWWgv?=
 =?utf-8?B?UXI2K0QzY2dZY2ViT2lNc2ZXTFU2bFpGWUNMVE5LaWRzZUJlTW1pdks2U09M?=
 =?utf-8?B?YVhKb3hBRGFOWkpreVFjQ1JVZFpKTSs1NnJ3d3BxUUdZYzlaTzdSU2RuUTdD?=
 =?utf-8?B?UVNGNGVxa0VOemNiSFVBdGFxck94NGo5cDRIWGNXS3ZKMHhXODRNWjVjMWRU?=
 =?utf-8?B?Zk96a1kwazF6WHN3WmhrV1o0bm9zMnJkM1lOM2NTOHRHV3l5L295VTVNR1NW?=
 =?utf-8?B?N05SbExvSjNXVzA4ODZpVW1nYTM0YkRMdDBJbjQzVUpjc2dpOGVLL0tqVlVs?=
 =?utf-8?B?V2hJdXFjQ0dXM0lIVlQ3UGtZVVFYVFAyMndkTzl0STJ4dHhOZHNTSjZFSEZF?=
 =?utf-8?B?VUlESXVMTmZJTWJWQzUwVXVWOERZUU12ellMeXRGV3oveEhDaThGU2JWdUQ1?=
 =?utf-8?B?eU1uQnc1YnlrOFR2Z1dDdiswalkzd09aejBZU0FQUjJQWkpCVDNuL2hsdlNu?=
 =?utf-8?B?SjZ6TWtwcTNURldrSm8rVW14K29zbUl5cTFvcnYwSnlnUXN6aFdFNUROUTY2?=
 =?utf-8?B?YktYM0RhbVNJY3FUTlpRTFQ0UlNtL3VkY0lZeWFNclJ0S2RFVy9Zc0ZKZklY?=
 =?utf-8?B?ek9tamVVRGMyRk8wcW45dnZQTFc4T2JzaE1GcnFhcWgrMFdQV1dwcjJFdE5F?=
 =?utf-8?B?Wm5UeHhEOC9aVjZsT08yMnExbTFPdDh1ZkZ3NlpRV3U5cHNwUU1vVnQ5aEFq?=
 =?utf-8?B?SmRVNGJDbnJ6K3VOVzc4ZFJyTnY0K0MreGs0Y1ZSVDBtZU1NeWFTRTBLTURT?=
 =?utf-8?B?NjcxV21CWFpNek5hdnNXRU44Sm5xUG1WUjJiRFl5K0djbTlkUGNOWXpCdndy?=
 =?utf-8?Q?Hg/j8oMvyY06NlK6d12uNMczj?=
X-OriginatorOrg: digi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07e67c02-3a83-4e5f-383f-08db680940cb
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4561.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2023 10:15:15.8456
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: abb4cdb7-1b7e-483e-a143-7ebfd1184b9e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D3Dt0sK82zy48qJkLdjHpSQ1xDrGZ7tpeO86zL5bhqod22yB6apfyrkeEZMEfuOoaDt0fH6eeNHQbWt3uWncIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR10MB5908
X-BESS-ID: 1686219319-103934-7985-79529-1
X-BESS-VER: 2019.3_20230605.2208
X-BESS-Apparent-Source-IP: 104.47.58.168
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVuZGhkBGBlDM0tzC2DTJyCDR1C
        TF1NQs1dQyzTIp2TLRPNEwzTQ1zVCpNhYAzaCBX0AAAAA=
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.248673 [from 
        cloudscan23-43.us-east-2b.ess.aws.cudaops.com]
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS112744 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 2023. 06. 08. 11:58, Sherry Sun wrote:
> Oh, maybe LS1028 use the old IP version LPUART.
> If this is the case, I suggest that you can set the rx_watermark of ls1028 to 0.
>
> static const struct lpuart_soc_data ls1028a_data = {
>     .devtype = LS1028A_LPUART,
>     .iotype = UPIO_MEM32,
>     .rx_watermark = 0,
> };
>
> Best Regards
> Sherry

Ok, that should work in my case, as that's basically the same as reverting the patch. And I'm not losing anything on non-DMA case, as DMA is always used.

But the other platforms should be fixed as well, as it is a global issue across platforms using DMA with LPUART. So please push up then your previous patch with RXIDEN for platforms supporting that.

Thanks,
Robert

