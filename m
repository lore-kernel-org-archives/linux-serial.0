Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8356C7EE29
	for <linux-serial@archiver.kernel.org>; Fri,  9 Jun 2023 12:15:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231183AbjFIMPI (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 9 Jun 2023 08:15:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240381AbjFIMPA (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 9 Jun 2023 08:15:00 -0400
Received: from outbound-ip23a.ess.barracuda.com (outbound-ip23a.ess.barracuda.com [209.222.82.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7963A1A2
        for <linux-serial@vger.kernel.org>; Fri,  9 Jun 2023 05:14:56 -0700 (PDT)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101]) by mx-outbound-ea15-94.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Fri, 09 Jun 2023 12:14:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yn8L/XTH0Kw3AHda2PEsoO3fkN2JbCe/SLmlH1j/QFTO4P/ghnu9p5TDZSFEmGqbpszhwa3WzTAJrEcd4w7d4/A6qtrKdjeeyz7QS/XuRMCxr45FyNpWmAJMdvWUPJVBEoODSzee6hzM+xVjbpbCMXt1HXdNFQrYp6qk8tJQQoyNZknaVPt52kH7HrRqI99cI0CSXZK2USBZW87MgF6h2ZPlUKFwyrs5vXPjAT30PixihZPTtoYM4j11F5VT3PkuVaFHPpWhrqlV9ZWCgP3rdtKJ4ND8LlN7YoYIG0DhVNcLyudYhU8JeQ8qpCcN8G2NsnM82qQfX1+A2XSU/vOLqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=42XAOsWn7l4DaiD7QBmjyo9/bB9+8pKJEHBGcO9zCG8=;
 b=CApPlEBlT7q3C1wPkMzR3a28Q1kopz+RnB/HiHAhGaRX3QXsMcoKt2gSqc3fs8GW4DtBxynOV2rsB4ATF3ftnKQ5bBiMUFkB4TTHZX0iZFKcTvep0dDkyufmvzMF6psERppLL5yRmPwRLhYKyJ1smapdhv1zmXkrIDLea9ICUJLXbNSSP0qa7gcL7ZJDKMTaPFjK64ZcaUE+6SRLYwWJLjHPINVWmBU74NkPWLdQG0ShWZeXzQN1x+AzCkAWtYne9+Ic0KJXLNTBW46mILZ0tWwB/BngfXGbQTIwqckr5JpQqa1uOG25H4qhTM338njKOtV8ngECTayTMK/tcE3dWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=digi.com; dmarc=pass action=none header.from=digi.com;
 dkim=pass header.d=digi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digi.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=42XAOsWn7l4DaiD7QBmjyo9/bB9+8pKJEHBGcO9zCG8=;
 b=OM6coERJX+MBeoQvxR0LCgQQ0af4kk+XX9DPSuR1oMoWz2OdGi4KxRX9+QsL5FUnOl0q3TztFyJTXUbY2lwcZXl3sZfEllu0SxWH/LhQY1pNeuwlTQozC3385zQqUVehIktX5dPG2qfdwvBHEuCMv8jx9GiZktNUuEbiuK5eLDjeVBcBx4u3YmldlBKZ/B4wKn+lRrTV0SnYm8UmfipY8sV5kSsXSc9cIjlGEm4umZR7RNFgRZM2eitF9I+nYe8UKVz+U8tmHessdImjXHh+jhRVPLauI1+W//VkVWjesYLPCqg4k1henPSMBrcnP807/wq6gFFVsLw9gTf0Xuo5PQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=digi.com;
Received: from CO1PR10MB4561.namprd10.prod.outlook.com (2603:10b6:303:9d::15)
 by SN7PR10MB6641.namprd10.prod.outlook.com (2603:10b6:806:2ac::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Fri, 9 Jun
 2023 12:14:43 +0000
Received: from CO1PR10MB4561.namprd10.prod.outlook.com
 ([fe80::c626:ce53:befb:11a9]) by CO1PR10MB4561.namprd10.prod.outlook.com
 ([fe80::c626:ce53:befb:11a9%5]) with mapi id 15.20.6455.039; Fri, 9 Jun 2023
 12:14:43 +0000
Message-ID: <bece99c6-2982-c067-f9d8-8d1ebd8428e8@digi.com>
Date:   Fri, 9 Jun 2023 14:14:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH] tty: serial: fsl_lpuart: reduce RX watermark to 0 on
 LS1028A
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>, sherry.sun@nxp.com
References: <20230608111927.1808525-1-robert.hodaszi@digi.com>
 <2023060858-groove-riddance-0c09@gregkh>
 <94cae2c3-13c3-7c72-04d9-640a8ff1e7f7@digi.com>
 <a050e754-e15e-5cde-e838-f4a79885f7a3@linux.intel.com>
From:   Robert Hodaszi <robert.hodaszi@digi.com>
In-Reply-To: <a050e754-e15e-5cde-e838-f4a79885f7a3@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0264.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b5::19) To CO1PR10MB4561.namprd10.prod.outlook.com
 (2603:10b6:303:9d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4561:EE_|SN7PR10MB6641:EE_
X-MS-Office365-Filtering-Correlation-Id: ac4781b3-b96a-4a00-0e1d-08db68e31b9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b2vtw+G8R5t8G91iUiRt9fSisENdCPZVGgN/gLjkCD4dQNDhSl4/AcEVw7bZEF11M2JYTXYXO2wbWlhbxugYFVEb2+In+W4Z+5y07zRBwvuXgHqjVe4VPUdNCVkZ/3z3uUral5073k1d6qe/aApzrRqojWNkFj54zZXq6zkB3C+QxjzgWckL2GEw65kMLDD6PrfBvS/Z9MJpeog6jhJ5tw+JfwOwyglvP4FVL923G0I9/6dGzFAhAm0diccMLYKcdqVvT0JzQ4lnuK75sXMLoj1TenA/fKrZD/dhRexeaLVFRj/GADHYt1jGGni1jfb2/ueDanaANyytJMSkwxTSpGfDN34fTN7P1Kbf5mJ4YyH+2GoWuDHIfdPf33aZsajNwFSZLBfPrItX7NtIb+Rjgn4s5IvoWlniceA9xa/dMDt4XbzncNNgzjjGTCFmOe8CCpm2Oi2GLNu8itLaV2lEMku37ZshY7hA9Zei2PRo+c3hMxtBhK92gdlmSwjOV4olooPYRqLIClGJu+JEOlZbWds7yfzT0GJ3nMvCXvJFBIBA5pfzYP9YjaTeYKz3ZERa33nNBi9VvS/otUgw0dpmJALea6OjT+2rRJGaxZ6m8TqpHfpItw+fFp+TH2FzZfDDfMJDFgpAcx8PxGLp3uoTLQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4561.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39850400004)(396003)(346002)(136003)(376002)(366004)(451199021)(86362001)(31686004)(38100700002)(54906003)(66556008)(66946007)(2616005)(66476007)(31696002)(4326008)(6916009)(4744005)(6666004)(6506007)(316002)(26005)(478600001)(6512007)(6486002)(44832011)(41300700001)(8676002)(186003)(5660300002)(2906002)(8936002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cFJMWnErSVJRQm5QZWhiRktQcHk1bzV0aFZwYU5FbVNabXBLTk1tYWY0dENn?=
 =?utf-8?B?dlphQ002UnZkS0FRSGpsMjE0K2JOdDNYVUJiWWJlVkJJS2IvUTNzaURtTXR1?=
 =?utf-8?B?L0tMMmtSTG5ESWsveG9BcFBCTld4TnJwRWl2M2tlS0MvRmFlcmxZdXF4UFNx?=
 =?utf-8?B?ZWk3dkxVb2lYSVp2UFJvc0xPZkhheWlwK2U2bGMzaEZIYXdyd0xqSFVBVnZo?=
 =?utf-8?B?TWdWelVNNnIzemlDNkcrRFZSTk1YTnFsU2pnYUJFRFFLWXhBc0o5eGoxSnNu?=
 =?utf-8?B?cjhKMmg3U1o5VVNRMUxHL0kzdHhPYnNmTUlQODNUeW9nY2RsNzNlUkh4cUZ0?=
 =?utf-8?B?UUpJMWlVK1UrNXRPSTBKNEM0SnpUWXJWZlI3Z1lwWTNkQ0VGcks2UTYxVzZi?=
 =?utf-8?B?aFZjeTNaTW5wRUROTDVoNzBhSkxQbTRRMnFCOXlOVXBidGt0dURTSHczdkVL?=
 =?utf-8?B?dTJ6cXlnSGlnNEpRN3lVNWFBZWw4RGU5L3BhLzgyTmtjT0VpcVB0R2ZFZ1ZC?=
 =?utf-8?B?TExtLzIwalpYaGN1VzJwSDNxN1AxVmpJL2RGOTYwL21NSTVOS0FmNUJGZkc3?=
 =?utf-8?B?azFiSE9JdHVnOWhKeEorY2VvdjgwRkNVQzFycEE5SlBTUXlBMml2OWFTMnc5?=
 =?utf-8?B?VWZSVnJpSk9IZzFJYVNFNWZZOUVVQjloak5rU3YyZlF3WE5aczgxM0NPMmhL?=
 =?utf-8?B?UHpNVTZabUxCSzdaWVBieVdLUE9PbUd2NWc1YjRBRVB1TEtodVFhREJDUndT?=
 =?utf-8?B?NG5Pb3JYZUtYYnExRytIQUVFaEJFb084VC9EMFluNTkrTTVZNUh5QVQvYXlV?=
 =?utf-8?B?NzF5UGVkSS95QzZWMGhzVXZnMXdaY1R3d0dZWXpkZXdFMnlLWVRac1VqbVcv?=
 =?utf-8?B?aXhiUjVOWjEwV3lVNitRRkRJSnB5L1ViWDdxeVU1NWhaL1J1SmJUQ1lyWXN1?=
 =?utf-8?B?RTRROC93QWUxLzdpYWx1cEJxMWZabUlXMzhyclRwSmE5YUg0UGU2MWdBcEU2?=
 =?utf-8?B?OFVPWnBzL3JsRHJzSktPMVI1Q3lkMFA0a28xeXZuU2FkS3VucWdoNlVJK2lz?=
 =?utf-8?B?c2hRMjVhaFBzTE1Sa1pZVUNwYmR1TENUdlVkT1pKelRzWnFza21UMWJHVkNh?=
 =?utf-8?B?eGpSZHlRaEJMRE5kZmdQa2RadU9HUjd2QkdBNHdhdllnejhDWU4xTGJjNTJI?=
 =?utf-8?B?NjdhMzE4ZkRRV293dlhmSTVmQjFWQWljWittSGR2WnprblNyMUVIa2dwSTdX?=
 =?utf-8?B?TFhKNzVMVWdpUVA2aGRMMWhTRTZENjJaQ2g1M01xZnNoSjR6RE9LVG0yalRp?=
 =?utf-8?B?TTFkcDdHaGNwV3E5ZUREai9GYUUrSEdpbVJKaHR5VTdNRWhwMkpBUmxPUnAw?=
 =?utf-8?B?T2NGNlZTaXBjTk0rR1JtZllUbXRCOXliZjFxTnNrTkkxS004czZBOExTd3ZD?=
 =?utf-8?B?Tit6UDR4R1ptbktrdUlPeEFJRldGVmtpSGxUdGdhQ0JIRlVhajdJRWt2UFlR?=
 =?utf-8?B?aThqMktJMHo2SjJaRG5peHdKemxTbUV1UEpvcFBkM3BuUnl6dGE3cEkyU2hq?=
 =?utf-8?B?ejhQclVDUFpMaEQxRTRiaWl1aG1CRTBvYTJqcFZ0SlZRRmxOSnNmQi9lL0Q4?=
 =?utf-8?B?NXlHeS9lcGhwTnhaVUlrb0p4Rk1jTXZzUGl4Z1RxRkJqSnZLTkI0WUkwNVhC?=
 =?utf-8?B?NGFVaEFwK0grQkFLYnBuWnBtWDFhNnFrOENQSEJMcE1lQU0yMjZkYmtmejV3?=
 =?utf-8?B?dDFKOFZPdzE0NWVsemxpakFVMVhYS3JJWUhYZFF3SDdpZ0RYekg4dEN4enBH?=
 =?utf-8?B?R09rQzVENFdsUFp6aVYvdG92bkFtSlhmN3g0ejc3TWQyOGtDckhJM0FxaDZq?=
 =?utf-8?B?Vm1zMHlPWlFpZzZxRVdEYi9JVjJmRUhlaFdnSStOQVRJcDdBSDVrYUZEVC9i?=
 =?utf-8?B?eTJ2ZkpETTQzNUI3UVBFbU1pWm9IMjNtUElWWitIQVFveURVdHdqZDNHTERU?=
 =?utf-8?B?bHR0OEFZdHNFTjB3U2IvbkhSclZMTkc5M0NQN2FtL2cycDdMbkJsT2VuaWZx?=
 =?utf-8?B?eVhPRmMvWUd1dWdwRzJCM1NOWXlZK010eEQ3eEJ3alpwTzJyUGtjZFdoNWNL?=
 =?utf-8?Q?bizYA3lTQuyJpgf3qcoh91BMh?=
X-OriginatorOrg: digi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac4781b3-b96a-4a00-0e1d-08db68e31b9a
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4561.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2023 12:14:43.5746
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: abb4cdb7-1b7e-483e-a143-7ebfd1184b9e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NxR0tjlZenAkXu4R+4/wjarZV/5NS7y+fDHQ6fPtQAN0zBnLiLn2aURP+DAD1NI+I9/uc/GXKIKWi3B30ee9ZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6641
X-BESS-ID: 1686312884-103934-17757-4670-1
X-BESS-VER: 2019.3_20230605.2208
X-BESS-Apparent-Source-IP: 104.47.70.101
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVsYmJkBGBlDM0MzY0sgg2czIND
        HRLM3C2MIozcwELGJqaGGebKlUGwsA8JZLOUAAAAA=
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.248699 [from 
        cloudscan15-243.us-east-2a.ess.aws.cudaops.com]
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS112744 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 2023. 06. 08. 17:56, Ilpo Järvinen wrote:
> Please provide a new version of the patch with Fixes + Link tags then
> (for Link tag, prefer to use lore archive links).
>
> You can find out the correct format of those tags from the information
> under Documentation/process/.
>
> --
>  i.
>
Hi,

Thanks, done! Hope I added correctly.

Robert

