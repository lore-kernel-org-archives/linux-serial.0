Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAC8EC7EE23
	for <linux-serial@archiver.kernel.org>; Wed,  7 Jun 2023 14:06:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240953AbjFGOGG (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 7 Jun 2023 10:06:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240887AbjFGOFx (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 7 Jun 2023 10:05:53 -0400
Received: from outbound-ip23b.ess.barracuda.com (outbound-ip23b.ess.barracuda.com [209.222.82.220])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D338E1BF1
        for <linux-serial@vger.kernel.org>; Wed,  7 Jun 2023 07:05:46 -0700 (PDT)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172]) by mx-outbound20-2.us-east-2b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Wed, 07 Jun 2023 14:05:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LZ+nJCkDHjw2Op+zr4r5Dm4ZgoMaxNO80VbiXo/x8uVwkw2NVic7/Ceu0bd5fxobcRhALAQBD8hZjGgt3M0iueoXcYuTGPtxqjzAn7uz+udj4LdW4XtK2ex7PgvOY2wqMyUH9V+6mapBnFPAG5aSO7CE0eBejUbHGfrReVTA/4mFohSaBR7KryopuzS2nCm+D9l0Aiax3ZDuT2Fny1z/nrMevedb9nccm130XbJi0zkp8OykAqqctxqf7Mk1hXMQIdH0oEe8H5VBiWqSoqrRx3PbXCz7uBQm9rojRJVDjOfA9dezqJaxy9M4riHvLoCQif0ZajMAVrbT+s0P3z0PKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9uluo436IjM5k/Mu8zruWvUbitmFNnVJ77gk+SZ1lyI=;
 b=mK9ud7OPK+Bfmsw7CNBfWiubW1O3DhDJrjPIzABWpwJiVqKtr0qapDR8HH8kzvVlmxz3yut9fHsxa9e7NB+arUgHYqruqg1hpGN+UIhgNjQYtjAiwo/eozzKP6GYSb9tTKsUXpau5jodWOwm8jo/7ffiVhYxED7kAPHBsPiAwbvdmiMr/kXMlFpWdFAXJFstjk8JfLBB9hX7RNHTriPV9hCJjnNINoEaXm4burEirZ5r80PQxIOtqAK94qjSyIEtAdg9O4+nKHFloOGBJ8U+vk6UBFq4obmrKa259Pp1KR7YxYsKdSP2Ra70G+c49ZPSJqS8Frv4vIxND6Ji2PYQzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=digi.com; dmarc=pass action=none header.from=digi.com;
 dkim=pass header.d=digi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digi.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9uluo436IjM5k/Mu8zruWvUbitmFNnVJ77gk+SZ1lyI=;
 b=lY4pPMauMcUnnBk9UXJxpLuxSMLyZeA7JR+21/M99JfnySYnAB6/ueh/2t9BF7eaIsus8JKNgqcICH1Wt3z6DNj1FGqUKDA3ZT0OpEKJVrkkJx5QZ9vkC15bjo3xscDG/lPT3iQ50LEiuhrUEvVfXUr6+FsiiQw3wM6qmwaB4v8CnZzNPzFuhRRruPoaFvIK7EwSVd7FGCCkIr7xGuiFPJ8KfhYRMU3pfcZaTCwGB/lobV5mmDmVegRFzJ0r6XlkHkZYtk+2k3CvMRLk+LEyGpRq67JbE/rHTwFV6/w8NZty5VhcBBEXXCV+Rr2mhaB+A3ozom0h71O+fj3hMSGjYQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=digi.com;
Received: from CO1PR10MB4561.namprd10.prod.outlook.com (2603:10b6:303:9d::15)
 by MN2PR10MB4366.namprd10.prod.outlook.com (2603:10b6:208:1dd::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Wed, 7 Jun
 2023 14:05:34 +0000
Received: from CO1PR10MB4561.namprd10.prod.outlook.com
 ([fe80::c626:ce53:befb:11a9]) by CO1PR10MB4561.namprd10.prod.outlook.com
 ([fe80::c626:ce53:befb:11a9%5]) with mapi id 15.20.6455.030; Wed, 7 Jun 2023
 14:05:34 +0000
Message-ID: <347fc250-ed9e-b448-2ff8-b604faa14e7b@digi.com>
Date:   Wed, 7 Jun 2023 16:05:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH] Revert "tty: serial: fsl_lpuart: Fix the wrong RXWATER
 setting for rx dma case"
To:     Sherry Sun <sherry.sun@nxp.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
References: <20230607103459.1222426-1-robert.hodaszi@digi.com>
 <AS8PR04MB84040A92A1FBFE8177CF08D59253A@AS8PR04MB8404.eurprd04.prod.outlook.com>
Content-Language: en-US
From:   Robert Hodaszi <robert.hodaszi@digi.com>
In-Reply-To: <AS8PR04MB84040A92A1FBFE8177CF08D59253A@AS8PR04MB8404.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0264.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b5::19) To CO1PR10MB4561.namprd10.prod.outlook.com
 (2603:10b6:303:9d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4561:EE_|MN2PR10MB4366:EE_
X-MS-Office365-Filtering-Correlation-Id: 502176d7-2849-46ea-01f5-08db676042c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o3GXYLjAiYBLjDk2ib/MAl0twsf6UF+Z67zGyMLL9EF0JlrRzdFgTYl46ds/4ChwmBOv3k5HYlQxpEzcuSUKZQ2+UTj6eTk4Qr6ODAoOpAZHnqWak5HVfbIH4yM8pbNpZATCivTyGC1JIBSbKKN9Rs1ku40LDF0QFuZSdPCkU+VnajAQIgYnzcvNrEVdvliwKFpou/Ff7Li8SFpCqwNoampXKOxrxDGGqzDSKGJkBqHh2q81ZCwvimfpBxYQvrYfmrH1Hqh4t2Kcmb/9WnWDGzDtMuagxUtHN/xJUmil1fdY6FykrqYnlfXIL7SMLDmzsOxh021PNsyf1YxR3SFvc0FuUsiLt7rFMBgqTkUqUkg2oGCFK5JGH+G6k+EnD4QzDsM8hzbQX6/U12gdFptRFgTIzPLyNZA/abhEFNd3F6qcKYdTtaXgpVeICNAD9ePO8A0BAsutRgLAMbd5oBMArIbaJXMDEAbVffazH7LCbYj0OjjgsLuCtaMD9HqSc5EOjzegTLd5fzbBeMPU7OV3jgUDHOHfpS0sfM3jdX+vzrlYu4b7M/UsVmy7IPF65tFoO8S1AlsLYqmyHKG9zsQeSTBNFteM4PB+FNiNGiNazzLM1/13WajxxYHrH+A28nbgZD8MO2sBNYxDUnN11X0RbA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4561.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39850400004)(366004)(376002)(346002)(136003)(396003)(451199021)(36756003)(26005)(41300700001)(6512007)(186003)(6506007)(5660300002)(83380400001)(2616005)(8676002)(8936002)(110136005)(478600001)(66946007)(66556008)(66476007)(316002)(6666004)(6486002)(38100700002)(2906002)(86362001)(31696002)(44832011)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WW1Hcmg4QW5TNkIyMFU3T2p3U295NWdnd0l6V1RZSTRHQ05CSENHK3RDYWJK?=
 =?utf-8?B?MXVBTkdzOGU5VHQ0RW5hVytGRzF3K2lRbzdrem1rOGlLa3d5NWxPbXdIUU9z?=
 =?utf-8?B?UDM5cE1HeUFRL0FDb2RyMGRjdUtPNk1lenlMYkZ6TGh3N3ozbUJVUjUxM2ZM?=
 =?utf-8?B?dEtWWXZhMUtJb3RxS05RSUFlcjYzWms2c3loR2szTllNc2ZRcWRBdG0vVjRt?=
 =?utf-8?B?RUVBRmVBZHVMV29rdGYzMi9udW9lTlo5MjZYRnJ4SU9XeUxZc1MzeVpZamdj?=
 =?utf-8?B?SHA1VHlXR214RzdhM3RGSTBic1dhUGFtM1NLbVpyMUNJcE83bStLdFVjNW1i?=
 =?utf-8?B?OEllL0tPNCt6VXJFVlZUbnB4L1ZoVldFelVOR0ZBTTRuM01LeWRpSG82UzRt?=
 =?utf-8?B?YVkyVEZoY1BwYUZxNHBLM3FyWHNZdDMzd2dLeXpDOFUvcFZycUZYSmRNSEw4?=
 =?utf-8?B?dUZ2aDZLb2F1TXNLdnVFYWpnMnh0RlN6S01Ub3JOQUJYUFlFam8rRkoydENm?=
 =?utf-8?B?WUNzaUhUMEp4bTNKUDVMZ1o0cmJCdE1MZkNPcS9uMFgvaXFNZmFCSHdrQ2pk?=
 =?utf-8?B?RXJIS3lEVC9QMHBHdmV1NGZ2U3J0N2R3dzRRb09LTERTNTkyY3FrcnAwd1Yr?=
 =?utf-8?B?eTFBTCs5Y3lFTjNycXV6ckdiT2MzVndFWUgwSnExaFg5WWdQUGt0OUFTaEds?=
 =?utf-8?B?eHExK25nYUlIYjBqYURVaU1hQW44Y25FMXRPemorZXVXTHZIRGZ2YTd4d1Nz?=
 =?utf-8?B?YjlFTjVjVzFsa0xpNENick9TdVdzSkplRUFjeTRzSUlRU3QyNlM4N2hmMCtH?=
 =?utf-8?B?cVdCZ0FzS3V0UGI1bXY2eHdSbWNBdDRha3ZUYmpteUF4R21nb0k2TGVsUVpV?=
 =?utf-8?B?eUFnL0t0bysyaVhnMmIwdTdiRUI1R0dyZDExL2pndVEvNzkyZTFiQnltSHVm?=
 =?utf-8?B?RHRSVjRDQndLeWsvVDlyLzVFZVdFYTZUZ01wTTZ4SHJpc25QUVhIaE8wdUpB?=
 =?utf-8?B?R0E0ZWJISzEzV2pUbTkycUgwa1JaT2hFYXdCNFZkZjNNa0k4L1NTSk1FRmQx?=
 =?utf-8?B?VWo0ME50UWk0MFVyUmFudTVYWDFLODdQYkUxVmxLYjVJcHhZMjBJN01TRm4v?=
 =?utf-8?B?ajFzMC9CRzhJY0o5L0dMVTk2OHVIM29TOHNsNkovTUovUXdUczBUVkFsNzhv?=
 =?utf-8?B?ZjJBRTlMdVVicGpoVTRxbjVFSG1sbGE1NlNkU05vV29GZWE3NUtranR3WDdP?=
 =?utf-8?B?VnkzM2c0MTEvK3BNTThOVnJjZnB2YjNONExnK0xMa2xqQUQ2d0RsbXJ6OUtN?=
 =?utf-8?B?b1M2Z3IxR3AyV0lyVmJzLzFqSmdCSnkyR1M5UXcydkVaaDdjSmI2TktkN3RB?=
 =?utf-8?B?NEVGcFFDeGV3R1NtNklVQm1GQ3p4aG1RWkNhTFZ3K0dpaTNObVFxa1JxcGxD?=
 =?utf-8?B?akt0YnE5NVIwd0NaMWNRbHdRSzdYTVpWYnp4V2dvQ1VjdTU0QURhOEZ4U3pi?=
 =?utf-8?B?aUVzNzVYelF5L0ZsUWpMY1J1RDluTlNNZW91OC9tZENuQTBydklEWndOV2FO?=
 =?utf-8?B?eTd1MElaTllHdDFqL20xUVM1NFNsYjhUelVDdG5Ub2xxMVBiS3dkeTJRUEFx?=
 =?utf-8?B?ejRDTzBQSG9OUlhlaVlSMUFpQ1pYeUtFanlWaEV0ZCtoVXJQVjVUQ2c0QU5T?=
 =?utf-8?B?eXEvSEZaQW5NeEVHZzYvWVVUWUxhVENReEovSktHalhka2FMclJQWkJHNHFI?=
 =?utf-8?B?MkdoTmJSUHlDdklxYy9sQzBQaHp5ekR1VHF1b2lKR0NDUlh6SEdWR0poRTRj?=
 =?utf-8?B?cnpWRDF3TC96SVZzUENlN255TGgrNGszUW0wZ2ZVQ0pYdHJ3YjJSVjdESTJz?=
 =?utf-8?B?anpwY25HdCs2cW1GK1k1N29nSlNGbkx3MmJtcnk0ZmgzR2Q4Q2h1dVZVN2c3?=
 =?utf-8?B?VnBYdWFSdS9Dbm8yaXF6TU9hSjA1TGcrTXZ5NHo0bzZnOHRKYkdXQ3hUcy9N?=
 =?utf-8?B?Sm5hWHFXSmk3TlI5enNtb3RteE5GQVhWa1Y5dW1qWjhXN1RLZVFoNDVXenBC?=
 =?utf-8?B?bGZqaWR4VGpDUFhPTjIxMlFvM1JuUVY5cElYZ2drN05nNUpjQ2drS01YY1Ur?=
 =?utf-8?Q?VdZ7hW5YTDLhXgOplBlU5yH4o?=
X-OriginatorOrg: digi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 502176d7-2849-46ea-01f5-08db676042c5
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4561.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 14:05:34.0712
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: abb4cdb7-1b7e-483e-a143-7ebfd1184b9e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gcSWbzjZogkHQYNw5lAKyW8PJB22QXdFE1yH4NxS7aDOW5jUbWWEvGDNeQOyFjDGICfByvTdgEWYg2r/RQT0aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4366
X-BESS-ID: 1686146738-105122-5542-3456-1
X-BESS-VER: 2019.1_20230525.1947
X-BESS-Apparent-Source-IP: 104.47.57.172
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoaWhgZAVgZQ0MAyJcnI0jjVwt
        IoMS3VxDLR1MTQ0MTc2CjF1CDF0sRIqTYWACYX7htBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.248654 [from 
        cloudscan21-61.us-east-2b.ess.aws.cudaops.com]
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS112744 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 2023. 06. 07. 14:39, Sherry Sun wrote:
> Hi Robert,
>
> No, please don’t do that.
> I agree with you that the LPUART RM has a false statement, the Receive Watermark actually can be greater than or equal to 0, but this doesn’t mean that it must be 0.
> And the false statement  has nothing to do with the code here. The code here aims to set the different values for lpuart interrupt case and dma case, and force the rx watermark for dma case to 0, which is unreasonable.
> We have already set the watermark in lpuart32_setup_watermark(), it works for both interrupt and dma case, you can set the rx_watermark value for different platforms according to your requirements, from 0 ~ FIFO[RXFIFOSIZE]-1.
>
> Best Regards
> Sherry
>
I'm working on an LS1028A-based (actually LS1027A) unit. Having the watermark set to 1 is basically making the LPUART unusable. DMA is enabled on this platform. The last character always gets stuck in the receive buffer, and I receive only the previous one. So the WATER register's content after sending one character to the unit (but not receiving it in Linux on the unit) is the following:

    0x0226001c: 01010000

Which means, watermark is set to 1, there's one character waiting in the FIFO, and there was no DMA transaction to move out that character from the FIFO into the DMA RX buffer.

The RM says: "When the number of datawords in the receive FIFO/buffer is greater than the value in this register field, an interrupt or a DMA request is generated." So if I get it right, having the watermark set to 1, will never generate a DMA request when only a single character is sent. The RX timeout function with DMA will help nothing here, as there will be nothing in the RX buffer.

But if DMA is NOT used (interrupt based receive), we can set whatever we want to watermark, as the timeout function will collect the received bytes from the FIFO.

Best regards,
Robert


