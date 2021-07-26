Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25A26C4338F
	for <linux-serial@archiver.kernel.org>; Mon, 26 Jul 2021 15:16:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D0746023F
	for <linux-serial@archiver.kernel.org>; Mon, 26 Jul 2021 15:16:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234962AbhGZOgK (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 26 Jul 2021 10:36:10 -0400
Received: from mail-am6eur05on2080.outbound.protection.outlook.com ([40.107.22.80]:60161
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234922AbhGZOgF (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 26 Jul 2021 10:36:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aqALMWkameXvMl4EE7WZc+PwqaaNkDt/GIfQI6lOBVNXjop+N7st3kP0k8EXAufg3su3yyoADzI/p+lNzy2U88UpyNFo/xYqvIAownJliO4ucdoekU1jvr/ugZTwfIfMasBlhJekQnlqBoftobkQ1NtMpWJsK43gdZMoUwkIszaj3g36zi0/JionvM87CWx3p9r0nmkz+Ulpf8xM/ET2v/ZspCD9S6bqZ1pE/Hg4CLtc2erceEpkG8Lm+uuO/TzrbARXpRroMv13EuQiAXjSaiMXJvQozXqMEKbZdWk+z35/tD1+qiq/wwrojUReZG0Pcd3ruEd7f41Wxk/c+E9ZyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=satHnVb/ysa+7SIfm0m9fNGvHbhy2FLfGJVnReeOcwQ=;
 b=PbfRCcjZ3SSbf0Rd4emwid9A4F4KI4UBsZ/gH4xLdZK+hglRHiczaEGDbUP4AKHyvL0TCqamnjxl4sYNYi9JLpAm8m9Q3CBG+7vTJqY0Ji7+P6Zhi2eCxPg9y/xdlZ4iNw7o7n7OHL8az1IGVAtSeVYmbY9jzQUB9349Whyj7C0GEI1tQZuZrs0gB2veBQ+RFRkX0cUkLMTLOp1sa1rbXUQXY2bUtDg/lGjEY/sKIHrVDuyqh0/Gswa7AAFXm8sUjZpVMFX7Z0dwZY5LVLXBdbGJOxpUL5OY7hjypnXsGvt7RICCIBDsRK/75D0NoS/9X2q7BHbU+pNISvoaSpo+Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=secospa.onmicrosoft.com; s=selector2-secospa-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=satHnVb/ysa+7SIfm0m9fNGvHbhy2FLfGJVnReeOcwQ=;
 b=rWQvL4Pm7Eo6BwWrA6IFh3uxMhuuore69TWza+tAog17RpY+UIaSyOhXPhh30bTZ/VnfWiLV6TrEkHU7Q9t8CEZJiDS5f8moFfiygT4LAKzAcDU0Q6PVYyottLBstc2UgN3aIkW06Nl13Xobbk4NCV6f5EY2l1T8E3j55NW3fv0=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by DB7PR03MB4858.eurprd03.prod.outlook.com (2603:10a6:10:7f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.28; Mon, 26 Jul
 2021 15:16:29 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::dc6c:815b:2062:d1f1]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::dc6c:815b:2062:d1f1%7]) with mapi id 15.20.4352.031; Mon, 26 Jul 2021
 15:16:29 +0000
Subject: Re: [PATCH 2/5] dt-bindings: serial: uartlite: Add properties for
 synthesis-time parameters
To:     Michal Simek <michal.simek@xilinx.com>,
        Peter Korsgaard <peter.korsgaard@barco.com>,
        Peter Korsgaard <peter@korsgaard.com>,
        linux-serial@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org
References: <20210723223152.648326-1-sean.anderson@seco.com>
 <20210723223152.648326-3-sean.anderson@seco.com>
 <a4ec376c-7208-aaf8-344f-fc3b6a31aedc@xilinx.com>
From:   Sean Anderson <sean.anderson@seco.com>
Message-ID: <c81a94b6-7379-456e-e419-507554157c8c@seco.com>
Date:   Mon, 26 Jul 2021 11:16:26 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <a4ec376c-7208-aaf8-344f-fc3b6a31aedc@xilinx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0318.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::23) To DB7PR03MB4523.eurprd03.prod.outlook.com
 (2603:10a6:10:19::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.1.65] (50.195.82.171) by BL1PR13CA0318.namprd13.prod.outlook.com (2603:10b6:208:2c1::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.7 via Frontend Transport; Mon, 26 Jul 2021 15:16:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9efe9256-e010-495f-ac52-08d950485827
X-MS-TrafficTypeDiagnostic: DB7PR03MB4858:
X-Microsoft-Antispam-PRVS: <DB7PR03MB48580D04FCAD6C55D51D8C1B96E89@DB7PR03MB4858.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cIcGr2bYLzVuVDbiWYq3ob/WeH1En+S8F8yMzOVe6ybrG52e02o+0CH5mLHEOnjydNITFA1iBzFzJsSgYtKJOS6UB1rmiWvsDlxd6Fweodkcjw4OrO1+t12jFtb88sLMaqzYuLiERfEtlKoUJaJy+zlTxSK28sD1M66D9YT7OiVSsMQOcde98bjhfVPJzrObcaC7wQeMFvepBujBLVDMobsXQV+DrLMvysZFim+Bs+T+ZIRO8AmDY/tN5Stdk476oHLzEQ9IPv+J+gTGIA2IdfuAg4pog1DXCHClEbAuqFboPevMJ0XS1A6VX1iV94xl7jrLO1xbOWFhbQQd3mR9cYk7SIf/8qFlo5wMJw6JrKkRfYjb77/VTBfoB2lRfNIQNWqiWd3dtPMjocsu/N2mgoRY5Zym1L2kxWMbITgosu9ygg3oXRf0qw11jclt56Z49wZx/ZfNGUUjxWk5hLadOrFOoTQxZPJ6NwQmaPMZV42MWpQvBvGlLh4DtduK+QmeUDa8+HRhiXTWeemdcUW+0OaZuxzgJwfH3yHPvmgkqSq1eJ+5bsAesXIr0pZOUEY7bjd/J/kOIFlUmljZwAvA86Q9Tqj5JfTPGUNP75CyLpc1CRxKC9aCKWwyWgVISjvviS16ghTQZyzUEHQ/4BcReBuGf9kNs0uj8bZxnuRcukSj8iW6jAEfqDypgFU1dfud3JtF/Gv+gfNF8owbDm43r5yIK5U722jFTOUegBlgA0Hm0/mQ2Sijxl3945kmFB8yzRg7bFPjOdbZkKl9SoD1mg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39830400003)(136003)(376002)(346002)(396003)(66476007)(36756003)(478600001)(66946007)(54906003)(8936002)(26005)(66556008)(31696002)(83380400001)(186003)(956004)(86362001)(53546011)(110136005)(38100700002)(2616005)(38350700002)(2906002)(4326008)(31686004)(52116002)(8676002)(5660300002)(6486002)(316002)(16576012)(44832011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Mkl6U3J5QjZ0Z2txYTdBUld0bnRpT0hkQmpuajNYZm1veFhNR1hYclVmVElM?=
 =?utf-8?B?QVZRSU5RdGJxWnZyYm9UWVU4MGt2d1lnTGJ6d2pidWcwZGpTcGlNMDNjalUr?=
 =?utf-8?B?dHN1bVZVMDdWZXVYSi9DdWJHMEplalM4Z25HOThLdFZmL1F1UUlFOWNNUkxh?=
 =?utf-8?B?K2cwWnJWQmtNbWN1eUN4SjRWZE1tTkF0YitLWkZ6SGVrWFlTTmFHZ0Vad2VU?=
 =?utf-8?B?NmlnN3g3UGxYK1dHNzJQanZ3dGlzZW5UNVdGUzdPSHd6Ui9jUlZXK3cvL2N4?=
 =?utf-8?B?V21pWG5uaUZRQitZTmZaUGlSTkpTNVNlblgrc0NRdll0eGt4VUQzQjJWbklB?=
 =?utf-8?B?ZHA2cVRLVzhyVTAwRThRVCttN0g1ZE9kL0g0blFsRm4zZGFSbUlTcmJ0Y1Jo?=
 =?utf-8?B?cEhsbE1BUTRRVCtGUXVZNFlVenlWSmo1OWN4bk1VL1FDOXNIaDlua2NpNHZC?=
 =?utf-8?B?Q3Evd3dpaUJ6Z0NYQ3dSdHlZbldXdXZFWjBCSGI5OVBEUWx2b1I1NEtaM2tH?=
 =?utf-8?B?NU5uL250WGVNd1pEdkFjTDZMUUFScU9PRHJrK3gvL3IxMWllQ3N2MGVUeDdj?=
 =?utf-8?B?cVRIbG1BUElxR0hhNTFkVUF0VEh2NWlURVZ5UktTRnRXa1JFcVJmWnQvNDN4?=
 =?utf-8?B?VGlPZUFZekxrYjNQUkFSY1Z1T2Zzcm9weTJsVEE1aFplV0dVanNqWDdwTjZN?=
 =?utf-8?B?QVpYNUpqcTRBNjhYeFBPSmYvaHZLamRvQUZ2V0NDRWhlSHl3NElHTWJvcjdE?=
 =?utf-8?B?ZUpURXhrYXFHVGNYM0FoeHo4amV2eWFqc2x6bDhuNDBwQzBuU0szYUNSTG9F?=
 =?utf-8?B?TGtVem84dEpyUC8xWEc2L2FyeGlyK2R3VDk5bFY5eS9CYlQ4VzczaFI1bkd6?=
 =?utf-8?B?TTNLR3FnVlRobHROa2Zkc2xwSlhYRmVrc3Q3ZTNzZmdwYThCQXlod3dPcW50?=
 =?utf-8?B?K3hyRk1CQmRrejQ4VVF3U1d1WEEzci9ZMmwxM1lGVkRuM3NBUFU2TEp2OUo5?=
 =?utf-8?B?OHEyMXV6dzhPUXI3K1lsUGRMMHVsRjhJTURLYVRPSVNWc0w1SnRIS1NsMG5J?=
 =?utf-8?B?SUlwVjErUkhyd3d1NUVYWHJuSFJVYnJHNzBJQXIwcFRRMnc2cWFuNG9IbDQw?=
 =?utf-8?B?YzJVOHFqSTZWcGkwRGdnemxvTmVxZDBMZHFMOGR1ZVIwb0NldWJFRnBUQUNV?=
 =?utf-8?B?VUw4bkhTeW5IQm1qRlBOZTBEbXBiK1RhY0FtaWV5SVc5ejdteElXWXFLSG1C?=
 =?utf-8?B?OGJ2eThsMFdWOUxmQVVoaC9EbjhGWm9ldFhZV3hjcEcwWXVjdXVPZTZaN1M1?=
 =?utf-8?B?ajZ6UHpJSTFZMWoxdTJKZnkwNFl5RU9QMXk2N0tRK2dab3FyVlYzNWhWQm1n?=
 =?utf-8?B?bXcyTWJUWlJCNE56eFdLTUNMQWE2c0UwODBSaWZPZ0dvNmszcjVMSWp2Ym9v?=
 =?utf-8?B?c2lLQjdZckdVaWdzYS9Ua1JOeUJ0THlKWTUxd0J4S2psNy9BMGlEZytkWDVr?=
 =?utf-8?B?RS9uamhPaWV2Q0llalZaY1psOFpROHVWTzIrdHNoZ05FaXhMV0o2cGJVYVN2?=
 =?utf-8?B?QlQ5akZ6cVE2RE1ISTl5V0VvZG5FbDZmVFVYSW5hcnQwVno0S1lFZmxNbmdz?=
 =?utf-8?B?Yk5aTHFSN29nOHNrK1dqNi9Yek9wOGZaSld5TXV3cUJKTmlXZFNiNVJVdWhr?=
 =?utf-8?B?R0ZOT3NFRnM1RjhwMHB2QTFacVZVSmNoWExGQWZZMEZFVlptOC9VZUtjYnBE?=
 =?utf-8?Q?EEUSL4AoDaBD6BDmgm6u1VP1rFo4mKc4fU++GkY?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9efe9256-e010-495f-ac52-08d950485827
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2021 15:16:29.7787
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YCkApkVFjWGGZPmX+q0hR24P9/TzREgP1Y6EhlVc4dDDGZkeZWK7RKC8NHeJocyhf4U8c2MSRu1tHrL4P6PbYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR03MB4858
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org



On 7/26/21 8:30 AM, Michal Simek wrote:
 >
 >
 > On 7/24/21 12:31 AM, Sean Anderson wrote:
 >> The uartlite device is a "soft" device. Many parameters, such as baud
 >> rate, data bits, and the presence of a parity bit are configured before
 >> synthesis and may not be changed (or discovered) at runtime. However, we
 >> must know what these settings are in order to properly calculate the
 >> uart timeout (and to inform the user about the actual baud of the uart).
 >>
 >> These properties are present for out-of-tree bindings generated by
 >> Xilinx's tools. However, they are also (mostly) present in in-tree
 >> bindings. I chose current-speed over xlnx,baudrate primarily because it
 >> seemed to be used by more existing bindings.
 >>
 >> Signed-off-by: Sean Anderson <sean.anderson@seco.com>
 >> ---
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
 >
 > I think all of these should be optional properties because were required
 > in past. Likely a lot of xilinx dt binding files have them but as it is
 > visible sh also has it without it.

As I understand it, the "required" here covers both properties which the
driver cannot function without and properties which should be set for all
new bindings. That is, the 'required" here is perscriptive. The worst
that happens is that the bindings author gets a warning when doing
dtbs_check, which is exactly what we want to happen.

In the driver itself, only "current-speed" is required. However, I could
make that optional as well (although perhaps with a warning). I feel
much less comfortable guessing the default baud rate than guessing 8n1.

--Sean

 >
 > M
 >
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
 >>
 >
