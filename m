Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF210C7EE23
	for <linux-serial@archiver.kernel.org>; Wed,  7 Jun 2023 12:16:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240561AbjFGMQs (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 7 Jun 2023 08:16:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240556AbjFGMQj (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 7 Jun 2023 08:16:39 -0400
Received: from outbound-ip23a.ess.barracuda.com (outbound-ip23a.ess.barracuda.com [209.222.82.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 732411BDA
        for <linux-serial@vger.kernel.org>; Wed,  7 Jun 2023 05:16:23 -0700 (PDT)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2049.outbound.protection.outlook.com [104.47.57.49]) by mx-outbound11-197.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Wed, 07 Jun 2023 12:16:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H59AO+cZUypR9fi25WfIxLgOFuXCPvGdZXuFB0XhzA/AcJHthxGd4WIXLYOLbrq6+RlEAGKvpGQL/e2XCZ3cyH6ohCYWOZlwgqQu3dpkVRnMC9WA4ZQBW6+OCIcNcWmzopXG/GS836fzxQ9ulErGNY365USLnD9lTJdh+ZhSXc7MWvzj1X4p+cE7aBys94BhIfYYVYu1AlnmYrRnFYbpSc2RKsZ4dhX4/zDv8iGXyd4OqkkftIml+HZFLyZ3rVFwnoc3jKcYDlBJbiqrl71K75brIMQ9FEym/K7JlhziSl3epmBTIIjIm7gAlZV1dBVUWxbSzp5qxv9ZLjYITOmufw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=15dye0CeP6129g0/B2qqJNTuOgU0pQA09Nl0I+dN4xc=;
 b=oRXyysb/FM51upE37jyt4E/qGGPm1QgzyQgrum5YIIkoRwuAC+o/KIzEZHGCt9oCevB+m8Z1pDBBK++xeB5jCakV15Q9zeI0EyxMYQnoSPuma8wCUDev0H2UsOZL/VzWVu17ytXARN47JMkxQApMTZufb9tgqtlejCBffAUHTGaJ5CDEXgVpZgHs+cXDIVarOp5TlLm1kGdH/zlvSnWqdyLXSlDDdP4r8jEEKeoFcd3xg/J5sEjiY+LdovjxlTdiq2/4ayrQDasJ8/WqRaWsXa2Ur28ylekPjId+rgGeA4w2Pc2zPeaU37ofgzw+9aN3CuifA0sOeLwJs9q7wp+m1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=digi.com; dmarc=pass action=none header.from=digi.com;
 dkim=pass header.d=digi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digi.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=15dye0CeP6129g0/B2qqJNTuOgU0pQA09Nl0I+dN4xc=;
 b=cpv4aGBqQWcYslOn8VvoFFtCKu9gZd6gOSqNfBfHCTAFfp5tsYCAOnBnXT3nE257+1qwXQi0xd4quYjta8P3S8UCl5Zao7cj18l2+2LuBr6u1TGUiXoy7PGxQascaY5NS05bDyZawRdt36aXZar0Paa2TItnIrfMBfOeZS2RP8kVFUl9+I5Ww/5zzIJXmjYTDDOB8Xs6BRneA7qiWr5lwXHJ5p1z/j+jO0HGCUbH2m78Q/7nOHw2EAnXsDpDgnYtSXY844tsCmrHz/iRzDq6fHzhX1BMm8dUBV+ijFf+3Sc07a1cQiO8Q/5y3bjkYAiy2dhG/h8pbuRvAFEICluyEQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=digi.com;
Received: from CO1PR10MB4561.namprd10.prod.outlook.com (2603:10b6:303:9d::15)
 by PH7PR10MB7695.namprd10.prod.outlook.com (2603:10b6:510:2e5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.35; Wed, 7 Jun
 2023 10:41:06 +0000
Received: from CO1PR10MB4561.namprd10.prod.outlook.com
 ([fe80::c626:ce53:befb:11a9]) by CO1PR10MB4561.namprd10.prod.outlook.com
 ([fe80::c626:ce53:befb:11a9%5]) with mapi id 15.20.6455.030; Wed, 7 Jun 2023
 10:41:06 +0000
Message-ID: <944e8287-0f48-9324-295f-d250fbbec4a6@digi.com>
Date:   Wed, 7 Jun 2023 12:40:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH] Revert "tty: serial: fsl_lpuart: Fix the wrong RXWATER
 setting for rx dma case"
Content-Language: en-US
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        linux-serial@vger.kernel.org, sherry.sun@nxp.com
References: <20230607103459.1222426-1-robert.hodaszi@digi.com>
From:   Robert Hodaszi <robert.hodaszi@digi.com>
In-Reply-To: <20230607103459.1222426-1-robert.hodaszi@digi.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0142.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::8) To CO1PR10MB4561.namprd10.prod.outlook.com
 (2603:10b6:303:9d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4561:EE_|PH7PR10MB7695:EE_
X-MS-Office365-Filtering-Correlation-Id: ca6bb89b-e837-4f7e-bcc6-08db6743b280
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8JZNWysUBCqpTHp9oBLoMTvuLjy97QHt6Lf5EoMnqa9xJQJHqy9cs3pE6qOby69x4FXals7Wt7O7bVpG32aTMOHG015zzNmXxeWY8q9Q7MI/fawtUOJVcVVn/5eHE9wb2VMlYbpOPRU7KAHdTuq832x8rdbEkDqaKwdpEuxr/uqGFylATiENI3DDSK3nImR6b1xs+7cREaSzMPTt52sdxYGkKb9gj2WjEXLTM7GpnHTUi2iGdUoeujkRLjgMlrUXQeD3odZvg1HjCSrH5M1DiciFhWxgSLuamxA+4dHj3KwHPfziI3Z1LGglj0FqrB1dPhaNJcfs+exHQDMURtrU3XsT1gjz8d23BOMOZFir1JzgsTiueZc7TblwCUnYTlrH4WeHk1YgMYbLMY4c8kq07bF93Wh0afcFL7HRDKg+ki4gNhDcqnG7rXKvqjCLYTzmMVNPRHKlOOSNOELsStDl+hcTUNcXL8GUWjrjyzsPQephtfxgO/gqyEhAxjIAGpRoY4cC/5sP4SgBbEtboax2trs3nywmFcM3oQAG53JPG9FVPD80bF8YyFFpLzKFvwlbJhkvjXmCIYfNr7PIi5fNfqmhF2ss9sghD1l+ZIJyFAWP4LMKNhNm8rNKtUD5wf7YsPfvqBAPDVqkfIRKrAOKnQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4561.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39850400004)(396003)(376002)(366004)(136003)(346002)(451199021)(186003)(6666004)(31686004)(478600001)(6512007)(26005)(6506007)(83380400001)(2616005)(966005)(6486002)(316002)(8936002)(8676002)(31696002)(41300700001)(38100700002)(86362001)(66556008)(66476007)(66946007)(36756003)(2906002)(5660300002)(44832011)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZnFsdXJncUFxSTNLWU5KbS8vM0JpWlpkUXJhMGtDZnlPZlU3WTRXSnQ0RWFC?=
 =?utf-8?B?YmVONEN0ajJWRTBvb2xYVkREU3pQUzdkS0RvMDBPTXpDc1pTSHdRZUM4Z01V?=
 =?utf-8?B?VTNXNHVLUGk0SVBTNjROYVVldENoaXR2TG10Z3VGRXVoZFE3RS9zbmhONzdR?=
 =?utf-8?B?anRtb1Q0NWhiTXlZVEQyNWYxVEU1T1g2MHRzcUxySjdwRU1haUZnUUg0ZThz?=
 =?utf-8?B?ekRZMnhsbUZlN0pRL1E4TEpVUnRTREFrbndqN0oyYlVqc0VaZmZGUHl0ck1o?=
 =?utf-8?B?bk5aTWVIYWVGU1E4MmRuRUNmT2RRY00wR3p3Sk1VbGd2Sml4VUZYdjRyeG5t?=
 =?utf-8?B?ZHU2R01GanB3Yi9QUkNZa0I5aUc5a2RxQjJFLzN0S3Y3WUFDc1NBOXk4M2l0?=
 =?utf-8?B?aFkzdllsS0RpUWpZTkRTeUk2aVpCMnh4cmZaZ1NKM2hKNFpnZForUGUvNjBa?=
 =?utf-8?B?d3l3N3J0ZjhaNDNGVXZOcCthNUtDcnBYRDUva2FoNjlBYnNuOWN2NHZLcVph?=
 =?utf-8?B?aFp5MFJlanVnYjdQRjVEM1BSOStxbFdjR3ZBRlpsTTJqcDc1eEl1NERqL0Z2?=
 =?utf-8?B?TlNSZ3l6Vll4bmJYTlpyTWdDVGt0a2tyWStmSFJvRklqcWQzaFpSNXpzaEE4?=
 =?utf-8?B?UTcwL0VhZG05Ni96b2pYT1kyMVlRU2JLeDNnT3ZxdEw2Yk9nbFJlUDB0dWRH?=
 =?utf-8?B?NDg0SGs0K0dXL1hacDR1THhyVThSdHFVcGlEOStyeDhQVzRSUlFObjhqajd4?=
 =?utf-8?B?aEEzZ3NDV1RCYW54bHZmNElGRVlycUZYYUEvTUVyMThqYm9hN2lTekN1N1Z3?=
 =?utf-8?B?bTFsc1A3SjFaakdYaVBqS1NOYkl4WC82NE1oVktJblIrNXpDSlovRENmcEh3?=
 =?utf-8?B?d0tZdWpqejdDZzNNTHIwQmNyckxBNDFkNE9uRVFxS2ZMdHBlQVN6bmU0eW9M?=
 =?utf-8?B?YzVEM2I4SmdLbWlhMXUrbW5MN1BySmxBSGZOVDg5UUVRdkRESmhLSVdFZ3B3?=
 =?utf-8?B?MUZ6cGdZRWV4ajVaa0pFUXI3L3REWnJKb0E2dTQ4NnRjRkRZd01JZFI4V2l3?=
 =?utf-8?B?QkJyR2l2bjRrQjBzckEvVXFrdHlmMlgvQTFyQ2hGR2dvMHFHUnJjeEU2cXB1?=
 =?utf-8?B?UGpwQWZqZHkrak8ybVRqYS96eHQwNXg5VGtuajZ2MXVCYWZ1d2g3Y216OU45?=
 =?utf-8?B?ZFdPS3RpNnpDanI5SjR6MUdHQktzdGRSbXhEL1JRY092WjFTUWNBWFMvU1U4?=
 =?utf-8?B?MHRBcml1ZnZSN2tTOUFBWlY3TERSMzRoR24wbzFLakNrZE5KTVRackthdW5Q?=
 =?utf-8?B?SDlOdE1iMVAzaldqbGRnYi9tZ0ljZUJxYXhJZy9KaXJRQ0xTcnhjSHBMMTBw?=
 =?utf-8?B?NUlZTlZ1RUttSStXWlg4SkphZ1dLY3JqSGpBamFPVDBtZ1Roc3NOZ3VjNEZa?=
 =?utf-8?B?dlBXRUUxYXJoS3ZTKzlMY2tyR3F5K2VxUExsOEJnd25xYVFLWFN1WTFZQUFv?=
 =?utf-8?B?WllnWTdXM3pmc0Y1U2hGVW5yUDRMdy82aTdBSHpFbk9TWElET1JIYjdRMHlR?=
 =?utf-8?B?NlpwZm9mWFZzRWRNcGthR013Q01VYnRQUnIwREJ5MWpKeW44Ky85dFA5Yllx?=
 =?utf-8?B?cDZ5VlFrb1lJRTFyMWJtckZ3S1BNVXdseUdISEUzRndaMXlTWVVRU2F0OXM5?=
 =?utf-8?B?aHZ6TmJyNjBJVjVER3hnY2RubmdzNnc4OUhlNGRkb2R2ZG0reml3WDU4Mmdv?=
 =?utf-8?B?bTNlVWhBbWJ2ZlEzSUMxQllCY0NHOGRRUTYzbElXL2wyWTNYNWdWU0JFU1Bu?=
 =?utf-8?B?TlZGOWxDOGdxSFJMZTFjZ2F5WjZBOUdoclhlNDVwK2lrbVBkVEt4LzZEbCtB?=
 =?utf-8?B?QythM2NDeW9pWk10alN4VzJaYkd6WERONkJEQ0U0cS9LelRiNHdwMnp4M2Zw?=
 =?utf-8?B?SUl0UEIyWXZwL09yU0NGUFpTWGtGNU81TGhJU091cUhTUHJ6SVZmNUI0dk1U?=
 =?utf-8?B?Y044Y21HY0FjYWJhN1MyYjR6Z2hVQUUza2J3TnNJb0FxRkh4L3hoQXBPL3V1?=
 =?utf-8?B?K1R3dlBvU2wxTkliQTNXa2RwNkZhdEorOW9xa2JaYUkxN0J5NlgrM0FPTTly?=
 =?utf-8?Q?f/F7UdYH+xQLFl3Ut9b8InfFo?=
X-OriginatorOrg: digi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca6bb89b-e837-4f7e-bcc6-08db6743b280
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4561.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 10:41:06.1416
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: abb4cdb7-1b7e-483e-a143-7ebfd1184b9e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IwyGnt5bkhuiJ/F3whKLzap1QbtzskjG87BNSKaRvzvGQS2aKJHt74jq4GgWpkE3jDVASxWR1qhmTTlQu4XZ2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7695
X-BESS-ID: 1686140168-103013-5504-10563-1
X-BESS-VER: 2019.1_20230525.1947
X-BESS-Apparent-Source-IP: 104.47.57.49
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoZGJgZAVgZQ0CLFKDXRJCUt1S
        It0cgyOdk8xczYwNLEMDkpxTI12chAqTYWAAV5vMdBAAAA
X-BESS-Outbound-Spam-Score: 0.01
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.248652 [from 
        cloudscan10-90.us-east-2a.ess.aws.cudaops.com]
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
        0.01 BSF_SC7_SG0146_1       META: Custom rule SG0146_1 
X-BESS-Outbound-Spam-Status: SCORE=0.01 using account:ESS112744 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND, BSF_SC7_SG0146_1
X-BESS-BRTS-Status: 1
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 2023. 06. 07. 12:34, Robert Hodaszi wrote:
> This reverts commit 9ad9df8447547febe9dd09b040f4528a09e495f0.
>
> LSUART's datasheet incorrectly states that RXWATER must be greater than
> 0. Having that set to 1 is causing a one character delay on the receive
> path.
>
> Signed-off-by: Robert Hodaszi <robert.hodaszi@digi.com>
> ---
>  drivers/tty/serial/fsl_lpuart.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
> index 7486a2b8556c..8f1bb0a378d4 100644
> --- a/drivers/tty/serial/fsl_lpuart.c
> +++ b/drivers/tty/serial/fsl_lpuart.c
> @@ -1762,6 +1762,12 @@ static void lpuart32_configure(struct lpuart_port *sport)
>  {
>  	unsigned long temp;
>  
> +	if (sport->lpuart_dma_rx_use) {
> +		/* RXWATER must be 0 */
> +		temp = lpuart32_read(&sport->port, UARTWATER);
> +		temp &= ~(UARTWATER_WATER_MASK << UARTWATER_RXWATER_OFF);
> +		lpuart32_write(&sport->port, temp, UARTWATER);
> +	}
>  	temp = lpuart32_read(&sport->port, UARTCTRL);
>  	if (!sport->lpuart_dma_rx_use)
>  		temp |= UARTCTRL_RIE | UARTCTRL_ILIE;
Here's a thread, which seems confirm it:

    https://community.nxp.com/t5/i-MX-RT/RT1050-LPUART-RXWATER-documentation-error/td-p/892379

