Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FB8EC7EE23
	for <linux-serial@archiver.kernel.org>; Thu,  8 Jun 2023 09:35:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235465AbjFHJfv (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 8 Jun 2023 05:35:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232847AbjFHJfu (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 8 Jun 2023 05:35:50 -0400
Received: from outbound-ip23b.ess.barracuda.com (outbound-ip23b.ess.barracuda.com [209.222.82.220])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F10861730
        for <linux-serial@vger.kernel.org>; Thu,  8 Jun 2023 02:35:45 -0700 (PDT)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100]) by mx-outbound17-16.us-east-2b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Thu, 08 Jun 2023 09:35:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hkYlueaKlYDDkISHjXbBrkvjXHJf5rzhH+KKWZ7PoXucWLV9Z6BniZPdS3/B9xfJsWSXrmVYCJ8u4c5FwuBjzIHEo6a4w7rRCuWWh5VbRUbiaYTG3xfOm8MK1D6dnKsP4oLzzaaUQY+cpoL+AJZivfXauSS7AB/enGWc4/sPLMCSjur2MnoBKVGI+Wnkt6V4xQkdjUAO7CphG+Xd+aosglAYB3nplFnJR4xVv3ySDyZqd2KY7V+trCLtXVgcl3ZRbHdz8nTZWkq4VpwI2vxUBHNbio4eFaWGcrHu9drOUgRroxhVyj7/9p+QduS3xRMCIsezulkVTFkANnmF2bhd8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HvfLyqp/UdeJL/hYtGfEVEihlYPqPwIvTjvLh71AI+0=;
 b=fGut9GcLSrQvUEgxOk96vJnsPppH1+aZ01SGwr4xTReWyeOESMMDlNFMVrXxilwA2MVonDKlssUwMUApGy/gAW4LVQA6MFSkIEVs2fa29dYYMIfh7k8t3zfeeMz2eITb/SzT09pKWJOGdhcRM8KVkf3qXwC4dsL+7k985azkEcg3l3I+vBSnyoDOIT1Js5PQg1MWh7XyjThLIksYnZKVSu0m9aahP6P8EMlpU5OYemzVLn6WEquMUTpH72nrL/xk1nfGA2QW6ggGyZqW40JDrtWhIGxxfqy7goyl7RCmgWJCCveEW6nem/Hr0anJjFKVyc3aSeXxX8yCR7ZgoawQQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=digi.com; dmarc=pass action=none header.from=digi.com;
 dkim=pass header.d=digi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digi.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HvfLyqp/UdeJL/hYtGfEVEihlYPqPwIvTjvLh71AI+0=;
 b=RoqlWsipbSM9BolBD3g1RSK51sqDjGwY6LnW8zQLN+CPnuqFH3tuQrzS6zLfNZcZe/1Z/pYdZOZjH6O0tj8VRLQqqsqr2wLJcApt7dSbqtDpWq9LSOSFVgT6kNqUMoN8QF0mqbLPx82NPK/lG+VmsBnevbDqm5K0vl2ffmyXwZt1skjQ4qDw/JPhH2aisdB/cTJ584T9ozIPffK1L6FCNYhUTWn1WL/H2/5WYzJyv1ZpMzMU/1FZehEN/dUHqkfTdiQaON5A/VRcJALPyAC6BQRtBon7AheWVnd5BdqIxAcyBtkbNHPNA/IKmZ8b8mOeuNlPEXtOlCREj0RbvTMshg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=digi.com;
Received: from CO1PR10MB4561.namprd10.prod.outlook.com (2603:10b6:303:9d::15)
 by SA1PR10MB5844.namprd10.prod.outlook.com (2603:10b6:806:22b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Thu, 8 Jun
 2023 09:35:39 +0000
Received: from CO1PR10MB4561.namprd10.prod.outlook.com
 ([fe80::c626:ce53:befb:11a9]) by CO1PR10MB4561.namprd10.prod.outlook.com
 ([fe80::c626:ce53:befb:11a9%5]) with mapi id 15.20.6455.030; Thu, 8 Jun 2023
 09:35:39 +0000
Message-ID: <76357719-c5df-6c15-add7-a955c7d106ed@digi.com>
Date:   Thu, 8 Jun 2023 11:35:32 +0200
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
From:   Robert Hodaszi <robert.hodaszi@digi.com>
In-Reply-To: <AS8PR04MB84042413F6C9ECD80A1E87639250A@AS8PR04MB8404.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0183.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::19) To CO1PR10MB4561.namprd10.prod.outlook.com
 (2603:10b6:303:9d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4561:EE_|SA1PR10MB5844:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fd44d98-5883-4c71-2213-08db6803b83b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z1Wg3Dd8cRCQ/Coh1kcFSpxWk17btnn/uolwuAwyT5CvWz15eLlXnKT7jLuBIYpJg1XV8yC4aZXVBdhplbeQfP2YDTmchigq6i0hzdznVxFa14ooFJ/nBdpE1Pc2pU8bApwlvKWGxaQccsSlDnpRc6vQTfdRF4Xhs7foyKwl6gZJ3thD2XQw5CWIdK3s3INo3vxwStS1R2lek9uH4V6VilNW//VDHEMuGzVlhaIJA6eK5rnzVmow2stYGx7CaWXMHaRVowRso+3CTmRMUOZwm/QLlfV0K7fLzjXNbmfJxiuqehfhMWUr57l9g8EZWOtPTOzkH2E3TyQ0yMY5il4YuQmI7DrRv4BdIOcj/H0s36f/0uiQcJiJwqFHUjOxcCh+ZTtGY6OzDCbirn8vcbqHO8Q6vSbehsmq9/fAFDMgeW65mTpC+lwjgvHpBxgLzwdD9uyMB5HFzl7A949bvugbHRlu663yiShh37gL5sfgduyl3XpymwHUrv24CS8NiWajhrxmwCMi6x2J47gGhuTlQ+u4nlt5SoBSO1sHuD9Yzu6gvnWO7c6lZBCsQInrQgjk19LTeu0NpygdjbKWe8PaqYa8FGM6EkR90TNta5IYRfnZ35dXczIAzXF+fmeg/ff5+3DmboNDz+mdVv/Qv5LvsA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4561.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(136003)(39850400004)(376002)(396003)(451199021)(8676002)(8936002)(478600001)(41300700001)(316002)(5660300002)(6666004)(6486002)(110136005)(26005)(44832011)(186003)(31686004)(66476007)(66556008)(66946007)(6512007)(6506007)(2616005)(31696002)(2906002)(4744005)(38100700002)(36756003)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?STFUTFR0SzNnWTlBUmRHVGhEYzUwb3QyUU92bnhla1IwcEhaMmtvNnd5TWZp?=
 =?utf-8?B?SU54MjRJN1M5UlNJaGRsakp4UXpDazU2SkpxWU1rZmNrTnR4NmZ1eCtyVUFW?=
 =?utf-8?B?eUxuT3FxN3pvcUNSb3NPT1ozMTFaTjROdlhPb0tWYWkraWpvaWxxQWE0Uk82?=
 =?utf-8?B?bTdGSHExVElHYWNlZE5wMjF5RS9rVi9IcXFsZndMeXBPZ2ExRDExakhSRWo1?=
 =?utf-8?B?bStBekczMDlVR24wRVh4OTNEUW1mMjhiWjZpSzI1dzRSS3pDbTVic0RNV0pM?=
 =?utf-8?B?cXNKUUpyVmdablZibHRwK1oyQVRJdWxVcEdUVmJwbUF0dW8yTjZLUTM5ZG5V?=
 =?utf-8?B?NDNHcERjeVpsT2RRTDdmSHk4N1FSSHBNVGhJbGc2T0diSks5SW1tcW1DYmc5?=
 =?utf-8?B?d1IxWHVsTG81SXhYekRuRGlPeVB2b3p1Ny9wU3lkL3lKd1psa2lwWW5UTDN6?=
 =?utf-8?B?K3d0NTE3MTVQWW5JamtFUlVJR3hFMGI2bURrUFNKZSs0Wk8wQ1RtaDcxeUNn?=
 =?utf-8?B?L2NsYkROcTVybkdlZi9Va05WUkVkOWVqdFBrem1EbEdOR3pqek1mamlBZWJH?=
 =?utf-8?B?bnR4VFJpLy9KUFJTVlFFaTFuSmErWkNUVnV1ZUFZK21ydE42R1JLd2xCM3Fz?=
 =?utf-8?B?clFKVW1LOHhYZnNJdHRiR2RlOGtHYTVuNWNsZ3pCWTR2bzU2eEhVNlRPaEh4?=
 =?utf-8?B?OXVML1lqTWUzbXZyUGpvRlYvVXdBQWFOSjR1RzNQd0EvRno5dVQvdmswdHY4?=
 =?utf-8?B?RVlZaUkrQjgxakVVOU5yL01ubW5ZaXVXWHpDenk0N2NpRDFwOThOdDFSSHp5?=
 =?utf-8?B?cnluK0VjTWsyZ25SeW1EN0dNT3g5VkszZTFBSTBERm1xNW9PM09TZXZOQXc1?=
 =?utf-8?B?Z1ZXNldQQjQ3ZXZ4NkIwNTFEZ2I5NEYwdisxU0xxN09FSGxTdjl4eERoaVVo?=
 =?utf-8?B?dUh2TmtKVFp4Rk5BZGN5WjFBQ2hBdGZJQ1VYcHJ2dElSU1VZNDFHTlloUUgv?=
 =?utf-8?B?ZUdtM0IwZ2hwdWVEOFhTU3BDemdoTWh4QXZmWXJtcmc5OEw3QmR6TFgxaGgy?=
 =?utf-8?B?b1Qvd21wM2tWMGlKeWp3dXc4WXFLTm41akRNTmh6YmlrSUhid2VMMk53S1dp?=
 =?utf-8?B?cTJqSldWeG9ET0pGQnh2cUgwelJIald5a1JoNVliK0RTNXI2dGdpTFcxTnJG?=
 =?utf-8?B?QWxybStTZ2F0ZkQyYk9ZaWQydjczN3hXK3A0NFY5Z0pLZ1B0RVhldTFQelds?=
 =?utf-8?B?OElEUnZJdWY5MHEzbExIK2hDcHB3bCtBd3VLVkxKdnpkc0lNelNEUGd1eDJa?=
 =?utf-8?B?Y3BaOTlDWFRVWEhtem13WUN0aUhoRWIwbHdFYURybXBBbmdxaFh3ZHJlalVM?=
 =?utf-8?B?bXRnaks5dUhYUmtnaklqbWpWbWhvVFJJNHc1U3FiNEU1RHcrVm1oOGpybDdW?=
 =?utf-8?B?ZEMvT0JXUG1hTlB1WXRPSkptWll6Q1hUU0kxU0tzNnVucVhUZW1aRTVaemZ5?=
 =?utf-8?B?ZFNEWVlMTjRGWDVsNCtVVWpEQThzc242aHJnWThQTytwSkhiUGo1N0dGNzJS?=
 =?utf-8?B?UzM2dURSSldiVDRKQXpKUlVIeTVLOXpPTmc3L1BocHR5TldwYmUybHIvbWJz?=
 =?utf-8?B?M1gwaUgvUlF6L2pLLzFIaEd6VkQyS1VxSTJFQUhBMThnaHY4dzRMUmV1cGE0?=
 =?utf-8?B?ZnhZeEt6NjlSTzN6b1d2bWlSUlM4bFRpSGloeGZvWENiYk5TbHNrYUVRU2wv?=
 =?utf-8?B?dldFMTQzNytFUUhTNytWclBRVnBkdzNVcGVxTldrdTVqc21ENXo4ay8yYTc0?=
 =?utf-8?B?MUxlSFBYS0swb1dvSmhGT0tDVFJZM2p2b0VIcTZWOWhMd1NsYXovc1ZNdEdX?=
 =?utf-8?B?ZUljYlZyZ0l3bG84eng5MGZjajZSd3h6L0RhRi8xbTBia2V4UG1zdFB4WHEx?=
 =?utf-8?B?Mi9NTHFvWFFGZklaMW5PNWRtYVNCdlQ5Mlp3R3FjWkxrU2V4VUNvYSthelY1?=
 =?utf-8?B?Q09ZYjRZeU9wOFhwckl2bzFqZ0tzdHZ0YzNUQ2ZlYVBDSEN1dDdwanI4bWxY?=
 =?utf-8?B?MW1ibVd0b21TSkZhNVZWY3A2eDZMQ3dMT2JBcFgvT1pQbGZ6TDdldnNyUlhv?=
 =?utf-8?Q?QFtxIFKm0/KairxZZ5WYlFx5A?=
X-OriginatorOrg: digi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fd44d98-5883-4c71-2213-08db6803b83b
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4561.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2023 09:35:39.1579
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: abb4cdb7-1b7e-483e-a143-7ebfd1184b9e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pf6XwMuJnDuE/R42QtJiBX/Mz2Nbd4bQ9y0JnRI/hJHUAyoUGQIJw604e6dd8WhpJCxiBhDpoRK3EfWUd8zX1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5844
X-BESS-ID: 1686216941-104368-5469-140578-1
X-BESS-VER: 2019.1_20230525.1947
X-BESS-Apparent-Source-IP: 104.47.58.100
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKViaGRkBGBlDM0sjCxMw8MTkxNd
        nI0iTN2MTIzMzAJDXJwsw4McnCIk2pNhYAa3nrGEAAAAA=
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.248673 [from 
        cloudscan13-164.us-east-2a.ess.aws.cudaops.com]
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS112744 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 2023. 06. 08. 4:20, Sherry Sun wrote:
> Hi Robert,
> I understand your concern, fortunately, LPUART IP provides the Receiver Idle Empty function, which can avoid the receive data being trapped in the RX FIFO. For more details you can check my patch below.
>
Hi,

Although I can see RXIDEN in the i.MX8 RM, it's not in LS1028A's LPUART FIFO register. Seems not all LPUART IPs have this.

Best regards,
Robert

