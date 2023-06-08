Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A04DC7EE29
	for <linux-serial@archiver.kernel.org>; Thu,  8 Jun 2023 12:22:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbjFHMWv (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 8 Jun 2023 08:22:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235563AbjFHMWv (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 8 Jun 2023 08:22:51 -0400
Received: from outbound-ip23b.ess.barracuda.com (outbound-ip23b.ess.barracuda.com [209.222.82.220])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 433FCE43
        for <linux-serial@vger.kernel.org>; Thu,  8 Jun 2023 05:22:46 -0700 (PDT)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2047.outbound.protection.outlook.com [104.47.73.47]) by mx-outbound22-120.us-east-2b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Thu, 08 Jun 2023 12:22:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hEa0iWmgy2CsNcaqbxGqroMsr2sPUVIVywf4lQCQCsVRIKMfzMt4WWpk5bvNjqAwkcFteQIrayp+IDB0RjRbgWOOBSgiO7LQve6ZJLcqCys07ldZ7LsFz2c8j5OAGC5f4B1LkBWtCBbjLlkQ0IL/qy2Ty0lKFux21+2PRHqI3rUp9BYs511kDBZe3L8LvjjRvKLYIDPA3c/Mz/uZb3O3cHzGesaRIGAIjc93Znk+y65BfXzjPCh6Nqy+1FKNYoRdFTevdHtzwp3yLQQ21fzZYKQ4+0h+zpacyY741m2d8K5WiyB1nyBP1J+gj1rNYsAWJsRPjvFPmAyWZ+43vZl3yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cdrw3pvEK7l/RcvGp+UzhtGExen+JJx/kMgIhXGZSxA=;
 b=nZRIBnch/S8jaBZBOAwW7dQl+aUm6vBMx6WyajWBQtwSX5+SnC7GYkUZb9px8x13hRrYJQWN8+6wCsJdCS1mKC5vjgL6yNCKMD1Yv+AmGtVCX16MPOAYpWPYZSpuULEdipjygu5WXdZ16BZOWT0i9OOQsITG2Z1Wfn6J6jTZY/f8iNYeTxUEh0vr4VbIOiwH6VjQ2AWl4+i7gBORoKRUfqyT6wJlINHmy9KL1DMniMcjS1Z/oAn6OioYhiasyuvdvY88wknjxDdQ/OAW/oWCZ4gZxtA7Fl8jAkJ4jzvwcDN8BGlJkm6aMAzhvjpqk7jjUtTV8Y1Z2UXLnJ7Jd4owCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=digi.com; dmarc=pass action=none header.from=digi.com;
 dkim=pass header.d=digi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digi.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cdrw3pvEK7l/RcvGp+UzhtGExen+JJx/kMgIhXGZSxA=;
 b=jMKjAioV8R/1J1O2+xAJF0x7IYF8AFniLAfpx1ZsmW2VLa9WMCIwMKyLQB3mTV2/fOV+hdpioHGFCv26gMK9Hz0rHe5owyu3ooGQ/sZnDSg7i9I0OhPFuCC5doG7KmrrT/S96/CWuSya1C6ny+UaUOeTKslD/zsXV3vmGAyXgLjA0hKtxbwABQXdOVtmfLHWbhNJfnJvY6T7xATGPjOGH16U5PiMhBbA1JmWlFB1grK/fExh2D7R3G/ApR/lexAAQFPhJOb03Q1nh++Lz9baTT1/NXgPRRHAqtNUXwH3Un1Wb9Wm9NRwJB5wwZt6APMih+NrtcmmuZq9u+Sx4Rfbkg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=digi.com;
Received: from CO1PR10MB4561.namprd10.prod.outlook.com (2603:10b6:303:9d::15)
 by CH3PR10MB7355.namprd10.prod.outlook.com (2603:10b6:610:131::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.39; Thu, 8 Jun
 2023 12:22:38 +0000
Received: from CO1PR10MB4561.namprd10.prod.outlook.com
 ([fe80::c626:ce53:befb:11a9]) by CO1PR10MB4561.namprd10.prod.outlook.com
 ([fe80::c626:ce53:befb:11a9%5]) with mapi id 15.20.6455.030; Thu, 8 Jun 2023
 12:22:38 +0000
Message-ID: <94cae2c3-13c3-7c72-04d9-640a8ff1e7f7@digi.com>
Date:   Thu, 8 Jun 2023 14:22:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH] tty: serial: fsl_lpuart: reduce RX watermark to 0 on
 LS1028A
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     jirislaby@kernel.org, linux-serial@vger.kernel.org,
        sherry.sun@nxp.com
References: <20230608111927.1808525-1-robert.hodaszi@digi.com>
 <2023060858-groove-riddance-0c09@gregkh>
From:   Robert Hodaszi <robert.hodaszi@digi.com>
In-Reply-To: <2023060858-groove-riddance-0c09@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0142.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::8) To CO1PR10MB4561.namprd10.prod.outlook.com
 (2603:10b6:303:9d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4561:EE_|CH3PR10MB7355:EE_
X-MS-Office365-Filtering-Correlation-Id: e89c9ec4-c49f-41f4-7dbd-08db681b0bfd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gqUFBbuT375kXbZe2Xiuc2v8f+yp35kVax/B+qOAUf69sQlzX9iFKZDZwCHNZtXbEhT3jG2q7oR5BxNfpfI031yfXNZgzYVvEJiKgYJiQoS8iSt7SxQMXmg1kSpKJOzUq7oDZSS8IYg+K3KCqf5wPMcmza4h7k4tq0bRWRH6H2mOw74N20l1/Oc3g9ZVzmC6mKS9hm1YKU8lLi0APr8D0f2nXOYTk9k9VaPaw63HHCKiKdIpKyr/pZRYl95Gh3tHTy+3NVqyxZRgnjkFdzk2gXOhT5x3o9SEOpGqv07LRu09Nnd7ujkmU9F0jqXI7RPt3QNOxeg2YaO6Ju0/DG/eyph6R9NSUvNRDNtI+exIa4qru3AifbbhI8ozbFy45eOFTJhCPxkGMk1hYuSKonDWXO0lE7HmYzMAV845kIrgSITO79jCCMEfkfu0AGljaKn3jxHu+wIzuSLwVFCn+D3jyrMYstf+RNf/iHhX1+BtXmgCd65Ec+MRwVuDFq0IoX62/LYHynXEvfN8gRI3qpgZACKlwRecKGOsgLXM5ZbO/23Ye2YLTsBMVOqeQVsQXgs+av//vB7LT1aXcYmPOH/xR9GkFyFGB0hlKd580W7b6iuZBc6DCq7Dp5DM4S8nJj4VakHzCyPi5+Jgtytj/qXKAw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4561.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39850400004)(376002)(136003)(396003)(366004)(451199021)(2906002)(31686004)(4744005)(44832011)(5660300002)(6916009)(41300700001)(316002)(8936002)(8676002)(4326008)(66556008)(66476007)(66946007)(478600001)(6666004)(36756003)(966005)(6486002)(186003)(86362001)(31696002)(2616005)(6512007)(6506007)(26005)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZG45Rk9xWWprOUhtVXR3blM0VGpuL3M1UEFDMmZ4cEN5cTVWSGN3WlpmTmxW?=
 =?utf-8?B?NzhQMmdqN3BCNzFWV1FTaUtFL202d3c0YWcrLzVFQlpxWXY5QlRveXIzM1pF?=
 =?utf-8?B?MFpRMmc2SUoyRU1PNHFXWUJKcC9qWlVOWUI4ZVU0Y3oxYVNxayt6M2RyaUhq?=
 =?utf-8?B?UmpST3kvSU5La092Q2NkelNQUzhwSSt1eGh5OUtEam5yY0hPTHhic0kzOHB5?=
 =?utf-8?B?ZkxxMkVkVGVVeHFBV29ObENYd3dhTDJnUHU2UzRPU1U4L003bGRwcHAyRGh0?=
 =?utf-8?B?SmQyUVBPSitnSE0xSFUyeGs1c1cxOVNMUTNXZDZvck1xdkppT3pDZDR4Q0xR?=
 =?utf-8?B?N0VVWlBOQ2JsMHNpbXJ3WGRidVlQWm8vWU9kalc5SzRVV2gxTlhsMWJyMkVL?=
 =?utf-8?B?cUNNd2g4ZHE2RTVETXQwVG4yS3V6cHBtZXZzTWpuNzNQUk1HUExjSmNhNUho?=
 =?utf-8?B?SjZBZUI1TEJPR2xkdEdjR0VuTW9qRjNhZDhGblhoRHp6c0lQRW45bTlUbThC?=
 =?utf-8?B?SGM1d2U5cjFGYkVZNmxDQlZNTGRWb3ZXWExhOFNmelprRm5DOGNaakFUOWtT?=
 =?utf-8?B?M3pDRmlBV0p0RzdyeDVyQU82a2Jjay81dFB3QmxFZVlSdlRTN1VhZmhMeXJR?=
 =?utf-8?B?czFQQ0x5YU9BdFpDbnI3bThYeFN4cUkzaktieDRMV0hOdlBZSnFyQmhqRjBu?=
 =?utf-8?B?QjRoTWJhZVhyRUZQbDBFMitRVFc5OVhKNFVCemg0alA5d3JoTFVuQklrRlFY?=
 =?utf-8?B?eFkzamZJUDc1dkVNTHRMTXB6b084TFB3djRtTlVCNDZwYWh3MXV1RGlEV094?=
 =?utf-8?B?Zk1iZmdjbmFJRTQ1a2YzVmlHUS9RWHg5S1UvTlB6Uyt6VWR4bGp1Z1VFQnJD?=
 =?utf-8?B?eDloWm1rdjZraXVMaUNhalBsVmNJbWlMYi9sWklkbWF3L3FhWnNwdXp0VTU1?=
 =?utf-8?B?Vk54MGM0UlQwQlpxQTVHRFJXUzJxc2RWeHFiRjRvZ3h6bnM0VjFOUUVSZEdz?=
 =?utf-8?B?OHdLdkhCd3NqTy85UFVmNXUxYUNWNXg5UGJSbHd5dnpnbFROcjhoTG1XRVg1?=
 =?utf-8?B?UTVQNGY2OTNtTDVFNkNKMTQzQnFyc05ReXBkN3B2M09tV1FYbFc5TmViRm56?=
 =?utf-8?B?dFYwQXZ5QVFSMVNoZDdjQzB4eXUwbk9GWE55YjF2aXhycWVJQzRzV3lyZXo4?=
 =?utf-8?B?NWs2dWtNRXZYTWxSREdRbWRRMG40aytMRWRCTzYyRHEvbWlQbnhSeGJIaVI0?=
 =?utf-8?B?MHlTc0NVYUo2Y0hLOHVGUmFuM1NPVXNUbzRMVndZNmtrMEM3TUtXV1U2UDBR?=
 =?utf-8?B?RTkyeUM0OCtyZ2E5UXJWTHB0aks0S1Z2dVJ3V1RCcUpwQm4wUnVOd001ZVBG?=
 =?utf-8?B?UzF5VUpuRkZsRWJIc3Z2dTFCeUd0a3lXYVNKbmxKYUo0TUtKSVdGS3QwQzNB?=
 =?utf-8?B?a1h5djA0SjMyOUlHclRHNzFRVHFuRXBVZDUrUmVJQVVLR3RGeDhYWFlIZFc4?=
 =?utf-8?B?aDlMVFFoMHMycGVKZ1VIajB1VlhUQ0dCNlhjdFdBdzJNM1J3Vms3WHM4Rmsx?=
 =?utf-8?B?Q1VlcWtxK3BIM3pzd214Ri9YbXh5WVZnUCtnMHU2YmZzZHBWSEN0RWVwN2dT?=
 =?utf-8?B?bjFaRWx5YmhGbVZPNFJ6bG1pY0ZBOE1hakJxTCt5ZDQxemF6dUNwRW9EZ1Fw?=
 =?utf-8?B?Z2FkRE1lc1JxeXQ5VmZub3FiYnExT3pkeVdYakt4YitlVm9Gb0lXdzZweElH?=
 =?utf-8?B?cUpKcnIwY0RISnM1R2Rxa0RNYmd4d0FGa09XU0MwK3ZETXlzbnZnRlpReGJ1?=
 =?utf-8?B?YXoxL1RDT3dLZjh2ckVaNDhUSXNCWXlmdVJURmZjK1lhNU5GbjgrV3I4R3F0?=
 =?utf-8?B?MkNBdzRycnVpS1doQTZoMmxpZUd6N2ZscGFsbWR4MnRrbEZyR3BPUG1uZkdi?=
 =?utf-8?B?WFRGMWZBZ1B5SGdFb3FXY0ZIRjFuK3VBbE0rQ21ITkszMzZwQlhPbkxMVmhp?=
 =?utf-8?B?ck4zVE0vRjBQcFMyeWt6anVjd2VTcEZSM0pKZ0paZEZuWFYvZUx3KzdJc2Ru?=
 =?utf-8?B?NUIyUEVGVHN4SDRkUXNLaHIzbDBCRUlvanRKL0NmQ1psNWVJZVdpODk5bnlo?=
 =?utf-8?Q?pdkJdyU8iIG+k+FZHa4N1iVT5?=
X-OriginatorOrg: digi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e89c9ec4-c49f-41f4-7dbd-08db681b0bfd
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4561.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2023 12:22:38.1362
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: abb4cdb7-1b7e-483e-a143-7ebfd1184b9e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: muB571BiqFaIybZZBS4+08HSbVj3T0W41xwOznxaYDksDOQM1Imm0BKpWmKmLS140e+PI/nJpVd84UBh3jY6EQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7355
X-BESS-ID: 1686226961-105752-5418-169214-1
X-BESS-VER: 2019.1_20230525.1947
X-BESS-Apparent-Source-IP: 104.47.73.47
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVsbmlkBGBlDM0sjc1CDVPDkxNd
        EwJcXQwDAlycQiMdE4Odky2TDN2EipNhYATEpPdkAAAAA=
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.248675 [from 
        cloudscan13-220.us-east-2a.ess.aws.cudaops.com]
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS112744 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 2023. 06. 08. 13:52, Greg KH wrote:
> What commit id does this fix?  Should it go to stable releases?
>
> thanks,
>
> greg k-h
Basically this one caused the issue on my unit:

    9ad9df8447547febe9dd09b040f4528a09e495f0

Check this discussion for more info:

    https://www.spinics.net/lists/linux-serial/msg54555.html

Yes, I think, it should go to stable.

Thank,
Robert

