Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9241DC7EE29
	for <linux-serial@archiver.kernel.org>; Thu,  8 Jun 2023 10:49:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234352AbjFHKtg (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 8 Jun 2023 06:49:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235075AbjFHKtd (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 8 Jun 2023 06:49:33 -0400
Received: from outbound-ip23a.ess.barracuda.com (outbound-ip23a.ess.barracuda.com [209.222.82.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE5A9272A
        for <linux-serial@vger.kernel.org>; Thu,  8 Jun 2023 03:49:24 -0700 (PDT)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174]) by mx-outbound-ea15-94.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Thu, 08 Jun 2023 10:49:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lrlxEG4i5n/R5ssEn0MOcJhkUmG9JijXOG4wCXLW+6VNIPW4lfjixU5gf0V8//cuWPoIZUXA5Zh2fwoRrGcR0VmaCeS+lLMT+yO/g21ZhQABssvh4x2SNAY03koI5/8HTcfSxFOqiE5z8Att2ZA++ClWwu6m2KaXY12mU8f5c97sl+SGPgzwf1N3hNJZkGZi3YR10Kgdo5V0cMkwRLbXwWOZBOu6rENnKD488Aw1w952EY20SpWxWkl8h5Anp1fnObQRGej7aJJeSf/3HLVZsq6AnpdCrk3zzIP8RpTur4StEIHFjD0Q9kKmTLnPVcPUE/mc43cmEgQPXTIKSwzkGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bCboCwaUUs9T7c4dbYcmg88d73QMuicoYHRrR4VbNmU=;
 b=GDDUQ551x4XBsClJJnnw11tatH6dptAPVRbz+/vguOnnY4kg9aPopTFhomqQJRykS7RvxQSazJgNSLOGp+kkN+ImSVb0xHTMgiXRv57/N7YoYK+Lyi7mcm/29iJ8OJWA6KK8WdO5B9/Z0gQXMyorNfGKQ2GFY7NusxGOdiYFomeYXAFxH9PcLRNR8HEVMZffkjt1UJksA1j6q4A/ufN5IahDHqGh32T8aVnhPDko/zOQ/RGFRLdyAcLo1lJJCs12jEPP1mmYZ6IIxtBBJSts/0wgQhFjmhX/4JsmKisGuCE5tbrvRONdIN5VAiJ3NUL0RJ7o/ZZTFgvzfFQ4iNUI1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=digi.com; dmarc=pass action=none header.from=digi.com;
 dkim=pass header.d=digi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digi.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bCboCwaUUs9T7c4dbYcmg88d73QMuicoYHRrR4VbNmU=;
 b=p8V/VQ5NEjYDf1flCN7vo2RBLxDR2lmgh66v+yH4Z5fO+K7bUhb+KDf837CtyGxk9YTOFQowB1mZQvWyNOrwRUbitLk5BIxAVGp7Q8ej52CypD03ETP+ZoqVIp2yk+2CrogdEGvnYcG2I7/+vanf2zJlR4WOfZDmbrETYcT0chIkxjyeWHfB9+Ykj+FUkGasHr/MQte0M2UlbotZeig+hrmH/qyMcRlu4OchKN40gPvknYFCVI7LZOKBeL95TvpRx+VX5/q86NOccfYjO/gtbOQ/vw+fzwh66h2gvJKnbiHfI8RzZUyEbt70H/LSTaL8JU/1oe2MUwXdOTDXoVDlDg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=digi.com;
Received: from CO1PR10MB4561.namprd10.prod.outlook.com (2603:10b6:303:9d::15)
 by DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.38; Thu, 8 Jun
 2023 10:49:15 +0000
Received: from CO1PR10MB4561.namprd10.prod.outlook.com
 ([fe80::c626:ce53:befb:11a9]) by CO1PR10MB4561.namprd10.prod.outlook.com
 ([fe80::c626:ce53:befb:11a9%5]) with mapi id 15.20.6455.030; Thu, 8 Jun 2023
 10:49:15 +0000
Message-ID: <01694f3f-6898-6ff6-dcd9-54cb105cd5f0@digi.com>
Date:   Thu, 8 Jun 2023 12:49:08 +0200
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
 <2e57e76d-c47c-8109-722f-224f9f9a1a42@digi.com>
 <AS8PR04MB840494F96C9FC354827FB5579250A@AS8PR04MB8404.eurprd04.prod.outlook.com>
From:   Robert Hodaszi <robert.hodaszi@digi.com>
In-Reply-To: <AS8PR04MB840494F96C9FC354827FB5579250A@AS8PR04MB8404.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0200.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ad::11) To CO1PR10MB4561.namprd10.prod.outlook.com
 (2603:10b6:303:9d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4561:EE_|DS0PR10MB6271:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cd7e1d4-730f-4080-9a4c-08db680e0060
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v33dp0mEpeDePweFaKCt6hI6utV+L0JQzSfDJQDbDt2I0oe56v67/ztMHegxFfAZL2OwAX4Winf1hmCdlxi5TzH3xMxgb2zhGTB//g0TJEGOtzjRHT06fYEGURP5r8/of92HWo0V/Ud0CCUyuNvE6WXMEtDGOpmetlLlhzw4hpJsHSvK+YN2yaL3pmcwqb+qU02bt+BatTxEuAgi5ZfmKex9x7vpJiEep53ufsNMsqL6cQqqantI8T57zW1dvw9hcoc7yJt6L8arB9lhJ/JFI9ArpUeVKiQ82L3Y6yAA5Qdti80BQvZCr/vVCuGKF4eJ9gEpPBTi9OHzKqXqNXo2bO6MfyEV/RWaUp4bdqs1ys82YosWUHIo6oI+5aGI16JCnz9i4IcvIv58kf6ChFsglxFMK89STOO1tP//H8kFvb55qHGQIs84wGNJ02vB5s8e7hSQ7oRyLqM4DVBuFaGIt4cMrH82O89Zwjeb9cuXxMcfoFGXvMInfV/59e68zxnKrghtzd/cMEtWUZIWwjomJjtf6tei5hzrtsDFcjS7CKr0r2keAU3tFNcvmLzuhZMRl1C/hTN/EEiT5l6vXexqlZdQj5rmIMe/KcWSmaRVJfpLndcbk9W0+axlnHvRIcRHmBY7UwZRka7eMV9BtXeMnA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4561.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(39850400004)(346002)(366004)(136003)(451199021)(26005)(186003)(6506007)(6512007)(31686004)(2616005)(36756003)(6486002)(6666004)(2906002)(4744005)(8676002)(8936002)(44832011)(110136005)(478600001)(5660300002)(38100700002)(31696002)(86362001)(316002)(41300700001)(66476007)(66556008)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NjlKQ20xK2NZcklQVmQxcUVtbFNjZy96Q1RKT1BTTzViQ3NNVy9hRVJ1N1ha?=
 =?utf-8?B?d2VwREdCajRFS3laejQ3ZUlScXBiYzBkR2NyNERJMDdFblpVb1UweUFNZGpi?=
 =?utf-8?B?Q0p1VE9KblJzSnJWTks2WmgyN0xNNm9GWU9jSGY5VitaQTg3QjNSdFljdTVT?=
 =?utf-8?B?VjJKeFZ0L0RUd1lzVnBEdWZNYmswM3BOQ09JMmVoQVVuWEE4cUlZVlZZMHpa?=
 =?utf-8?B?MkdqYVg0bnBmRGw1eDlHRGg3ai9jNEl4R05mQVZvckZ2U0NJRm9qeExPT1NX?=
 =?utf-8?B?aXpQd0dKcHpCNVhCaUMycllteDg0NTErdC9nMWZTNDFhVXhpYUZLV3d0NStv?=
 =?utf-8?B?MkZuUGJJYysreWdKZThsTVNta3RvOVJvV3hXOUtZdHNUOHNMWGNJakUyekhD?=
 =?utf-8?B?b1lZTXpRbzFndDZiTDAzbXVkVlhacWVhWFRzUGQrcFYxQVIxYzViNlFyWnpp?=
 =?utf-8?B?ZjF4dUpoajFMU3E5RlBxM3JQUGhJTlhhOSsyTVNMd1RwUFZHc2ozTGpidVow?=
 =?utf-8?B?L2UrS3M5ZWw2UjV2NmtaMUUwWGtlektoT3grTGdvYnVNWXBZUUI3MWN5OCtv?=
 =?utf-8?B?TVRMcy9wTk43T2Y3MkN4dk01eHZ3bzBkQ1ppQzdMTTg0WG1BRHFwbmNsanY4?=
 =?utf-8?B?WkVhZXJpZmlRT1B5dkdGWkx4SkI2V0FRcnduZnJzaTNGa3ZwUmVIRjd1L3A0?=
 =?utf-8?B?OEg4endVSkwxTjJGNlN1K0FreWk3VGRCNVJwNm1HdFM0cFdjbUgzWHNvUVF0?=
 =?utf-8?B?czd2ZzhDaUNYczVzN2JCck9XVUdyK0ppczdvcFZsSmwyWldGZmM0Zm1NaDBS?=
 =?utf-8?B?b21jeFFBZEExa1hBR21vaWkwUTVTK0dnSVh1bm9pejMvRlN6dXhtSEwyMWpS?=
 =?utf-8?B?MlA4S2VVS3RTeFRVVzMyRU9XMEZSOFVYWVlSZXNwcllDTnRxcUJJSmZhb2hz?=
 =?utf-8?B?TFlldGxaVjBCTDBpa0dOWFRTT2ZYODhyamtMZmxEd1lTc21VYTY2Zm1SRnA0?=
 =?utf-8?B?bXhGZHJLWTBLc3NEVy9vQXBPb1lCNytRSGxVSDdzeDdkdms4bnhwMVY2M05k?=
 =?utf-8?B?VWtRejI4TUhpeVhscjVVblVjSGQwcDBhZ3cweXZUSFNidElwbzVrNHlDWFZ5?=
 =?utf-8?B?dEpKV2o1TFFjSTVQNjZYaktENmhHZk84bHhvL05DNjFQVm5LK0dYS21mOGJD?=
 =?utf-8?B?OG1Yd2hlZ0pGRWNhbDZ5cGJDMTA4YytQMVNTaUpGamtabWM1clhtZHpHVlFX?=
 =?utf-8?B?aDFXVzQxRjFYQnRTZWFXWmRreUF3L3BsQ2dJUkk3MUN5MCtVL2ZTczlOcFlZ?=
 =?utf-8?B?TDg1VXp0Q014Z2tLQ0V6em5WODBrRFA1Tkhma2F6NnIzbUh6bFcyM1llRGtD?=
 =?utf-8?B?ODludVJSV050UXYxWkxFSUx3Q2h3NkQvVlI0WUVvb01GSFJWV1FHS2N5ZjZD?=
 =?utf-8?B?MG5iUlZJdGxZbnlrc0hXbDJDTVYvSE9vSWhMRm1BdzFGRi9na1poMjRyS25V?=
 =?utf-8?B?STZNQlc5Vlkxd3lFWTY1dldVNUJGSEdRM0dveitOSTNHNlhyVXQzdnBpVUpq?=
 =?utf-8?B?d2ZBUm1qWThsNHB2cWtxQmJGRno3MDJPbmppRlE0V3BMQVdOM0xuN2IxMFNk?=
 =?utf-8?B?TDgzcFpaaWZlNXpjcXQ3QWs0RmdTMVRvYzBxb1E2WmZsM2pUa3JWTGk0bnlo?=
 =?utf-8?B?eW1Gbk9zUmRaclZyTUtoczNmNjNTcW9SK0ZuSjBPWXBsTXovalIxcVNNUko5?=
 =?utf-8?B?WXFCenlNRTNKOTJZUmRGOFk4WlRpcDNKajZXdEF2QUR6OWZaRm9rL0tpTWJt?=
 =?utf-8?B?NCtoVUxEV0paM0hBTmlkWXpWTnB1d1ZkZDZCWEpydVVGc01iRW5TdENVWk9P?=
 =?utf-8?B?UGZkN2llVWJPZ1BRNWxRaEZBTXc5M1V1SjhwSVBsTHFtMmlabG5SMjd0SDVI?=
 =?utf-8?B?ZzlwQkdNYXNoQXVETTBpbkpockhBRVRUVkRoUW5mNDRueUJYVHFBSFNKRWsx?=
 =?utf-8?B?VjFKU1ppYWdrVUU2TGkwN3FiZngwYzF3eWYvNDNFR1hFSkJwRGdUUEJwRE1j?=
 =?utf-8?B?NTRacUp4dndWRmcxRFNnRk9nZWlKUE05eDhRb2pqR3NQR0pCNHJjN3RiV3Fm?=
 =?utf-8?Q?gSVB8XxpQkUXICBVVhbadiRBA?=
X-OriginatorOrg: digi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cd7e1d4-730f-4080-9a4c-08db680e0060
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4561.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2023 10:49:15.1022
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: abb4cdb7-1b7e-483e-a143-7ebfd1184b9e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /1bRBy/4e3o/vfumdWjHEytT1lIo8IzZJfQxpTYws06eFKvXoTvLhdKNC/cUqWj/foFlca4BHnShzhTXlqNBww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6271
X-BESS-ID: 1686221357-103934-22308-15458-1
X-BESS-VER: 2019.3_20230605.2208
X-BESS-Apparent-Source-IP: 104.47.55.174
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVsbGhkBGBlDM3Ngw0TglOdE0yd
        jExCApzdjE0iIt0cTM2NjYwtLU0FCpNhYA1ndTJ0AAAAA=
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.248673 [from 
        cloudscan23-155.us-east-2b.ess.aws.cudaops.com]
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS112744 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 2023. 06. 08. 12:45, Sherry Sun wrote:
> Yes, the RXIDEN patch has already been upstreamed, you can check the latest kernel.
>
> Best Regards
> Sherry

Ahh, sorry, you're right! I'm using 6.3, and it's there. I forgot to check. OK, then I'll push up another patch with setting the rx_watermark = 0 for LS1028A.

Thanks,
Robert

