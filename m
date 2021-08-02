Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1021EC43216
	for <linux-serial@archiver.kernel.org>; Mon,  2 Aug 2021 21:50:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED5DF60FA0
	for <linux-serial@archiver.kernel.org>; Mon,  2 Aug 2021 21:50:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232147AbhHBVun (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 2 Aug 2021 17:50:43 -0400
Received: from mail-eopbgr80085.outbound.protection.outlook.com ([40.107.8.85]:30187
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229567AbhHBVum (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 2 Aug 2021 17:50:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gse6LL/IMGUEd/78J5eZsi8joIArzLg5N2FAcsUlosUKF/SpPitBh1HvMGV21MA/lmo9OwMDdEKoBncnWcpH5LoP+wlGE6tyXnXF0HWhEM1GFBQAhzilQe1qbO1/f21gRwZ3bX0XqRfr9lhaCzfFhoQ3hMlwtpnHyJhiECh5dSjuRSzD2WEdiEn8VIMZc5aRjPkLbNmtvmYVhWuYg3DgSJWcGnxLTgeLSDuFG9zsp4Kwt9eRY9CiTro5FhKQCKAXfrQ+YWwCdk3m8HL6wQcmUb6hfkUWr8tsfVkiqJ43HPliUKdraOnOAAHNu7xT5pOZ3V3jXK5s65sPtsi/6/3n5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dBrb9JOY2W+319ZIPN0UoaZ3VnEQNXIN68nvoKF3mUc=;
 b=maz57hbjZIs/EgpTlwNBqlKPUK4gxP8frKbB3ynswkqyG9IZTU9rc8Xjws/9z+wxBgA/HJytEedZcdmbt7to8780ZgDHTRatPhysKFg66c/FAY97NXCUzGkYRCDtTh1ViUZOEIHKOEHwc/LFGHXkV7yK3UBvsEuado1OmNvY3aaEx1krgZWt7CJPzTMDuEe/CRQJqGNvZMCCfrTfZK8OwDOFmfGm+o/go1Hcxas8/+WsVVthx+FZ3QllQRtIduyuOt7YGR36ubttRnFMX9Xo4caPPkGaPGhoAm4PEZS74AoRLF5bEUBcONs0mmq65IooPaf7I1vm0Oiy7gmm15viwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=secospa.onmicrosoft.com; s=selector2-secospa-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dBrb9JOY2W+319ZIPN0UoaZ3VnEQNXIN68nvoKF3mUc=;
 b=XMJztdQJSic6yzKEUZKZNdLUV9dP2MumWOfnfZdii9OcuLeWsLzRL9kZVRqQ/Y1ivK/x5KTRcbaDDtpC6v/ieYJqZYuAdHKCael2oFL8W4+a62RC6ApTehJORsp+G0gfq7mXJWIOfarMWnbmR7hDBLw4gp0zpvWo325FLe4GztU=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by DB7PR03MB3513.eurprd03.prod.outlook.com (2603:10a6:5:6::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4373.19; Mon, 2 Aug 2021 21:50:29 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::dc6c:815b:2062:d1f1]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::dc6c:815b:2062:d1f1%7]) with mapi id 15.20.4373.026; Mon, 2 Aug 2021
 21:50:29 +0000
Subject: Re: [PATCH v2 2/4] dt-bindings: serial: uartlite: Add properties for
 synthesis-time parameters
To:     Rob Herring <robh@kernel.org>
Cc:     Peter Korsgaard <peter.korsgaard@barco.com>,
        Peter Korsgaard <peter@korsgaard.com>,
        linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        devicetree@vger.kernel.org
References: <20210727221740.1997731-1-sean.anderson@seco.com>
 <20210727221740.1997731-3-sean.anderson@seco.com>
 <YQhigKhqp0VvrBr0@robh.at.kernel.org>
From:   Sean Anderson <sean.anderson@seco.com>
Message-ID: <ee8d7472-e80e-f3bc-91eb-d68bd57fd95d@seco.com>
Date:   Mon, 2 Aug 2021 17:50:25 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <YQhigKhqp0VvrBr0@robh.at.kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR02CA0102.namprd02.prod.outlook.com
 (2603:10b6:208:51::43) To DB7PR03MB4523.eurprd03.prod.outlook.com
 (2603:10a6:10:19::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.1.65] (50.195.82.171) by BL0PR02CA0102.namprd02.prod.outlook.com (2603:10b6:208:51::43) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18 via Frontend Transport; Mon, 2 Aug 2021 21:50:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4b60bcec-a7fa-4ff2-7f14-08d955ff8b3d
X-MS-TrafficTypeDiagnostic: DB7PR03MB3513:
X-Microsoft-Antispam-PRVS: <DB7PR03MB3513CB2B321BAE2268F8F0AF96EF9@DB7PR03MB3513.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +U7qq0bJLihVfkH1IBAMg8LS1RpmQrGu4ivUBw7/nO8xS4He8JsrFOiVVANlIbHWd1RKNJIv6hMyRTT0njIaqkJzNMIgtQscju5/EltlSYPsX/wh2oernJReAiZewKgY8X6S4it8nJdM2zZjRVIWq9b8x7nvuIpEUWIFgBC5I4L/bHzHMQHDWTSw9nmDMP+fm8An85rdf7bGBrXyySDBzWFcfCJPglOqHfchghMFcBK5dEHjcrna5OMSMXeTLTf5unx06ru/rDiUXqaUQGvYV95KHFIsd9m8S+JnqK1zaEQL+MTVCMBFQt3ovFoTYLOsJzVRVoi17BNPFcFzKkYUu1faxGv5B8C20YUqcVt0iMSXJ2bOUn+cXtBIJ5dAq+M8oW8NyjJyXMjIHdlQOhHhl6UGyoGkrcsiIZzvO7eE8yGIYR/Jv/e+GTyoDoS6zO5BI6uF/McZXnEaUkP4+0+ScdG6ZsqHZqEKFvVvvHMVV2akYy+rACIQaMJcnmgVmJDAioNZzGPy1ZeQtWyXbtbYoE4CUA88ZwoDs1VgMH+9v47htIXKQHnB1NDY5zCcmv0ic7CNoc+Vxn0pJL/nsU5Az3WGcrDlF9l0jgpqGp7Gmxwn/XUD4t/z5yClyr/kCD3giy74GmCNahnm/+QlVzCkQ1wRBarZ9oUN9io+KGKEk8Kwvh6u17xXAjYhx+Ohnuytos6ZlkPN8jtcz0ZrMoL+ogRvphUJnPWw4BvwXOgb+PMV9IGXT9Jwp8/TbmxNN1kdHNogKJQ/kW+01Dmph0GUeQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(396003)(39840400004)(366004)(346002)(136003)(2906002)(478600001)(8676002)(186003)(26005)(31696002)(86362001)(6486002)(38350700002)(38100700002)(53546011)(8936002)(52116002)(956004)(31686004)(6916009)(54906003)(6666004)(66556008)(44832011)(66946007)(5660300002)(66476007)(83380400001)(316002)(16576012)(4326008)(2616005)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZVpKMDR2a3lyWk1LY2lZZjZ3Rmh6ZFpLV2dla2w4b3A4U1dRMmhOcHJaenZY?=
 =?utf-8?B?ZEEvQ1BpVjBGbU9ROGxCclVuV05XNnd3cHNQTWd5ZVZibDhrY1ZSdGJPbWlk?=
 =?utf-8?B?M3A2bjQ4T25PQmNDWkRsLzVmRm9NbVlIdGtTd0t3bWFOVm51bjJydTNmOEU4?=
 =?utf-8?B?UHYyR0xhRDJrc1d3anlwTlU3RDR0S1lJWFNQMlhyMVgyYXpKY1BCVnh6cEk2?=
 =?utf-8?B?U2N5SWJqNHAvS0k4K0RKM1RhYWdaTjNGMjRjb1BKSkFWWks1V25Qd3FMQUEr?=
 =?utf-8?B?by83akJkcFdvZ3ZFYnNycXl5TUU2c0JpenFBcFhzaVo1SWNZMkQ0K2JRTGhW?=
 =?utf-8?B?UGdDWDk4RGFNdTJSdTY5Q0p1YmgxdVo3QmhiaG94ekl3LzViSEZTYXpSNVEz?=
 =?utf-8?B?Y1lrRXMrRmtEcVI0NWVSdUN5bG4vamRIVjN1dForL2l1WWhsVmRlSVJmS0Y2?=
 =?utf-8?B?bEtTMURzczluamZLc0VPNTN5cWdYa0VOcllTbkNoaThYa2toMGgvNnBsUHN4?=
 =?utf-8?B?UHJIeEZ4TFFjQ3FGV0VFNEdXY2U5eHREODhRRy9TWDZPU1FHRHFIeEJPZkN2?=
 =?utf-8?B?N2R2RTBDUWtKbllhZ1Bvdm9wNDhJZnNKTGhGOUI2OFdQSm9Qb1Fma3VkL210?=
 =?utf-8?B?L3B5eS9HNExlN25tM0ZOd2V5TytUY2NBZi9JeHRnQ2p3TGVqanhWTGYwNjY3?=
 =?utf-8?B?Z1JzNm5LV2wyRldxazlMTTZjRDIzMzdiRmo3OWNxaHNCYXlyNDFHMms1OGoy?=
 =?utf-8?B?bGhSbnNSSVM2VXVEOUZKekxXV1NvRGhMOGFpZVlacTU5alVORHFydlNVTFE5?=
 =?utf-8?B?NS82T1UrMXFiZjVJc2N2RDUycEc3ZXZ5ZVlsc0FPbGtHdkV2cTNFU2hTT2cz?=
 =?utf-8?B?QmQ1ZWlmU01kT2dkdktsTWgvbTFoZU11aUJ3T0tTTUlkZVdXTnlnYy8zMzd3?=
 =?utf-8?B?R2NOeGNBcjV0aXBmRHlTNFJtemhScDFYd3E1Q24zKy95MVkyaUlhT1huTmhY?=
 =?utf-8?B?bmNRaElLeFhXazV3SldsN0lESmVtdHJGd0xLN3FHcU9xWEpTZ1FwcHhFU2Q4?=
 =?utf-8?B?V21acWdhaDF3UmRLT2NuTFVYNVFDYVYvTlowKzF2aEsvTTQxRlpsc2N3V3BJ?=
 =?utf-8?B?dUlJVkg2Z3FCOTFIRTc4dVo0SUZqZzRSNk44c2tlck1ZR1RpbWFRYUNhRnhN?=
 =?utf-8?B?TlZHUlRGK2dPODd2N2JRTUs0VTlkL0xBcXcxNWRXaWFQeSs5bmIrRVV6NXpJ?=
 =?utf-8?B?M1pURlJxTkZHdlluMWQ2ZXJvQnkvUUs0UXZiY2lvd2dSRVRUR2laSVNmd0Yv?=
 =?utf-8?B?cnRoVG5NUk5PR3dhQldyakJxbHZQa29GalBreVoyWC84eXkxOUxWQlZuY1d3?=
 =?utf-8?B?ZFcxRnU4OUZkY0daMmh4eHc2TWJ4S1BLcG5CazluTGdEMVJDVDN6bXkwdi9I?=
 =?utf-8?B?WjhsVVpVQXFBVEdkNHlOeEhFcDVXeUlTckZDVHo5VnR2eUdRUGFJbUVxUWpn?=
 =?utf-8?B?OTlFQ2krSFR4UGo4QWYzZHRlLzVuVG9nT0N0MzdLdzlrbGdOQjB3V1lXU29l?=
 =?utf-8?B?NEROOE53TVFsbi9zM1BKcVNVSURmcjdRYlFSc2huWkxaRmQ3VUlUemM4MDRr?=
 =?utf-8?B?Y0FRR1BrM3VuOXNLZ2pXbHF5dzZmM3hPL2hmc1pCa0UvUTdkWWU0RUQzUmtY?=
 =?utf-8?B?aXl2Q01EU2lqYVFYRFdsT2l0RFNGZmQwSGs4VnFHSlZRS0t1U3hOeDV6bnF1?=
 =?utf-8?Q?ZOPYPCP5OiKcxz3z6HoY+HeyKqDfnfQNXMZ74Kb?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b60bcec-a7fa-4ff2-7f14-08d955ff8b3d
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2021 21:50:29.2379
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KUtuIMcNb/Mngs93hij/Coq7H/fEE1GtrOLAKijqte9V/JobtF80hgp3Y70unFkVLy3+DxauzktqD86mt+0PgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR03MB3513
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org



On 8/2/21 5:24 PM, Rob Herring wrote:
> On Tue, Jul 27, 2021 at 06:17:38PM -0400, Sean Anderson wrote:
>> The uartlite device is a "soft" device. Many parameters, such as baud
>> rate, data bits, and the presence of a parity bit are configured before
>> synthesis and may not be changed (or discovered) at runtime. However, we
>> must know what these settings are in order to properly calculate the
>> uart timeout (and to inform the user about the actual baud of the uart).
>> 
>> These properties are present for out-of-tree bindings generated by
>> Xilinx's tools. However, they are also (mostly) present in in-tree
>> bindings. I chose current-speed over xlnx,baudrate primarily because it
>> seemed to be used by more existing bindings. Although these properties
>> are marked as "required", note that only current-speed is required by
>> the driver itself. Hopefully, this will allow for an easier transition.
>> 
>> Signed-off-by: Sean Anderson <sean.anderson@seco.com>
>> ---
>> 
>> (no changes since v1)
>> 
>>  .../bindings/serial/xlnx,opb-uartlite.yaml    | 39 +++++++++++++++++++
>>  1 file changed, 39 insertions(+)
>> 
>> diff --git a/Documentation/devicetree/bindings/serial/xlnx,opb-uartlite.yaml b/Documentation/devicetree/bindings/serial/xlnx,opb-uartlite.yaml
>> index 4ef29784ae97..28859e70e60f 100644
>> --- a/Documentation/devicetree/bindings/serial/xlnx,opb-uartlite.yaml
>> +++ b/Documentation/devicetree/bindings/serial/xlnx,opb-uartlite.yaml
>> @@ -32,13 +32,49 @@ properties:
>>    clock-names:
>>      const: s_axi_aclk
>>  
>> +  current-speed:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    description:
>> +      The fixed baud rate that the device was configured for.
>> +
>> +  xlnx,data-bits:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    enum: [5, 6, 7, 8]
>> +    default: 8
> 
> default with required doesn't make sense as 'default' what value is
> assumed in the property isn't present.

Ok, will remove.

>> +    description:
>> +      The fixed number of data bits that the device was configured for.
>> +
>> +  xlnx,use-parity:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    enum: [0, 1]
>> +    default: 0
>> +    description:
>> +      Whether parity checking was enabled when the device was configured.
>> +
>> +  xlnx,odd-parity:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    enum: [0, 1]
>> +    description:
>> +      Whether odd parity was configured.
>> +
>>  required:
>>    - compatible
>>    - reg
>>    - interrupts
>> +  - current-speed
>> +  - xlnx,data-bits
>> +  - xlnx,use-parity
>>  
>>  allOf:
>>    - $ref: /schemas/serial.yaml#
>> +  - if:
>> +      properties:
>> +        xlnx,use-parity:
>> +          contains:
>> +            const: 1
>> +    then:
>> +      required:
>> +        - xlnx,odd-parity
>>  
>>  additionalProperties: true
>>  
>> @@ -49,5 +85,8 @@ examples:
>>          reg = <0x800c0000 0x10000>;
>>          interrupts = <0x0 0x6e 0x1>;
>>          port-number = <0>;
>> +        current-speed = <115200>;
>> +        xlnx,data-bits = <8>;
>> +        xlnx,use-parity = <0>;
>>        };
>>  ...
>> -- 
>> 2.25.1
>> 
>> 
> 
