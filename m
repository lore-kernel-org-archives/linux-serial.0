Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6113C4338F
	for <linux-serial@archiver.kernel.org>; Mon, 26 Jul 2021 12:30:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 995BB60F44
	for <linux-serial@archiver.kernel.org>; Mon, 26 Jul 2021 12:30:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233993AbhGZLuJ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 26 Jul 2021 07:50:09 -0400
Received: from mail-bn8nam11on2067.outbound.protection.outlook.com ([40.107.236.67]:10720
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233742AbhGZLuI (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 26 Jul 2021 07:50:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k7BrZuG6XbwA1+nFkaONudI8QOnwZALT83bcqtzHnlLTfeMd4hGlbas/i5rzZQnMcjLahrrUX8D3fcmJFukoDNcUt+3FfnOJI/f0ypuN+N1hDoEbdMiMNVreQ96+FrYjCMcVtBFLzE60bO/UOP+vjP22ezurTX+eJ9N8LuPIHaPIIpd5kfUgDLG/RehCN1kZLtl3Ef9rs68ivB6qLjtFldHAV0tLG4zSeQ4a3J3IKNi3aaQrgOtZaizLil5DO1bdYSjRyJWElTOX/7X83PvlDBAbRYFGF8diRgZzQ4XuameHuLoO/A6J5Qw2IO8a9382PKhNHmo06P9I1JUSaUJz9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ltPvmJHhWpYte+Z9nTEDl4XuWdW1Lr0URZM+cK51l8k=;
 b=Filg50Nj/F+AwOnCtN9YgWWZgggHjAL/xjxHuotVYQzpdQAg5z6rDJ7QnYuZQIb/wwNr7yiBxmMOcSzisZ07IWvTkfh0qhjFRG9c7EliJOg66rsiWq62Z5DfstU6s/5yv0dHugGCxc1iGZG+i1wMdhPhJ83O55SwrbE7nY4cNU5TtPZ7KGnxuhWvTLvsgcJMtlrjX2lWYDLrDqROuGoAAZkc0yoNLEwqQo7+ztlzxNtKdzsVD1Kd6wN30xXVHJQ2FLsIH19FOjIpMGx0196ypj6faL79ICD/cgtnA1MiGb1iSkdfXx5mMbG9n8BzJIpsr3Mj9HeQgBAmWekx4ZNGnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ltPvmJHhWpYte+Z9nTEDl4XuWdW1Lr0URZM+cK51l8k=;
 b=jnBfGxBBu4FoqW2ZtgRO5QqWqk+eqd/Qf0BOS2hRzS6R3aREKqNKmKeUngeC/V5EDpMt4PKAPaDg2nsZb8A/XsUvifwji8HuSp4aWWvKoadkISn9pa1LbTnCM9qkIaoG5ona/3FvdIVF6KcxUwdYD01s5AbzMfkfhZuyD5Gg0R4=
Received: from SN4PR0201CA0063.namprd02.prod.outlook.com
 (2603:10b6:803:20::25) by BY5PR02MB6033.namprd02.prod.outlook.com
 (2603:10b6:a03:1ff::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.28; Mon, 26 Jul
 2021 12:30:31 +0000
Received: from SN1NAM02FT0010.eop-nam02.prod.protection.outlook.com
 (2603:10b6:803:20:cafe::89) by SN4PR0201CA0063.outlook.office365.com
 (2603:10b6:803:20::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.26 via Frontend
 Transport; Mon, 26 Jul 2021 12:30:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0010.mail.protection.outlook.com (10.97.4.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4352.24 via Frontend Transport; Mon, 26 Jul 2021 12:30:30 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 26 Jul 2021 05:30:29 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Mon, 26 Jul 2021 05:30:29 -0700
Envelope-to: devicetree@vger.kernel.org,
 robh@kernel.org,
 alexander.sverdlin@nokia.com,
 gregkh@linuxfoundation.org,
 linux-serial@vger.kernel.org,
 peter@korsgaard.com,
 peter.korsgaard@barco.com,
 sean.anderson@seco.com
Received: from [172.30.17.109] (port=48730)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1m7zkW-000GQg-Cz; Mon, 26 Jul 2021 05:30:24 -0700
Subject: Re: [PATCH 2/5] dt-bindings: serial: uartlite: Add properties for
 synthesis-time parameters
To:     Sean Anderson <sean.anderson@seco.com>,
        Peter Korsgaard <peter.korsgaard@barco.com>,
        Peter Korsgaard <peter@korsgaard.com>,
        <linux-serial@vger.kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Rob Herring <robh@kernel.org>, <devicetree@vger.kernel.org>
References: <20210723223152.648326-1-sean.anderson@seco.com>
 <20210723223152.648326-3-sean.anderson@seco.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <a4ec376c-7208-aaf8-344f-fc3b6a31aedc@xilinx.com>
Date:   Mon, 26 Jul 2021 14:30:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210723223152.648326-3-sean.anderson@seco.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d6bc344d-b1d1-42e1-59f8-08d950312804
X-MS-TrafficTypeDiagnostic: BY5PR02MB6033:
X-Microsoft-Antispam-PRVS: <BY5PR02MB6033240E0E6179BB08B4C6FFC6E89@BY5PR02MB6033.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JqnC6QjDta7gL9pf6ZDSmvPnG+sMe3lcjk32P25B64sk3CViyIqici0H3x5akXQDPndc2VEo3zpDrBM/W4ma1PmHTm27P/HxIRbgCNOrpO9lm9aGdWGID2xby/ohI8MnXiYH0+w2F2fNhDvu0jzCHp7eTMsiufXcQKum9hrEq/TR4PScrbUukhDO5Mq89PD5j26o+mJTelhT8tVoyDISWniEDQXpjIqHgZoSOQ5jA9L3QcoihMlT9748FZqFhmR+9rBtL7ahsqWns1M0lV8fQz6j72XdbRFKuvhI1nCqLO9P9EcI7HUBkRZGNlQiifK+kQLchRSl3mnLNMK/DO4Qx3ndqaX49U4krYb5P9iTt66C/K90lWTkffKLrC8uCGNNM2FF+B9wSShlcRih124oXIa8w3i4w30RBPlVMDTGUH+wY6ES3BvROV/N8cSRT+Xz2HeW0kAmFiOj/lcJhgxVKuH3Zt+362TA0sgBnxHoZ0bXfJjvFiMIBnEtU7idYQ86OF/UYraJMyyHwIPLYMtLxV6z9s/1ZH4zYDhRcv8Yu35/59vBkO3dOeSLVuKJh+JNZtZpRIGR5LlXLxcBlW3tDL1YpwDuNebUd7KmeurGGsszNGGoA03x0XO+O89WlZLWkI1rjq7kdHXajyLCTLUw/WwGlHVkrIR3T+5mTjDRBm/KFZvCt6xo8lJBBZdUNQJmQfUXWmdGEbtt4t8qkaMnL0R5Sf8fHzU2lhXYZadaY0w4E1e67kZuWUBQBh2+V+sA8OgS6bwkr89IXCc5bmkFiQ==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(346002)(39860400002)(136003)(376002)(396003)(46966006)(36840700001)(31686004)(82310400003)(110136005)(5660300002)(186003)(8936002)(36860700001)(316002)(336012)(53546011)(9786002)(8676002)(26005)(36906005)(54906003)(6666004)(36756003)(82740400003)(2906002)(7636003)(47076005)(83380400001)(4326008)(31696002)(70586007)(478600001)(2616005)(44832011)(70206006)(426003)(356005)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2021 12:30:30.3829
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6bc344d-b1d1-42e1-59f8-08d950312804
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0010.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6033
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org



On 7/24/21 12:31 AM, Sean Anderson wrote:
> The uartlite device is a "soft" device. Many parameters, such as baud
> rate, data bits, and the presence of a parity bit are configured before
> synthesis and may not be changed (or discovered) at runtime. However, we
> must know what these settings are in order to properly calculate the
> uart timeout (and to inform the user about the actual baud of the uart).
> 
> These properties are present for out-of-tree bindings generated by
> Xilinx's tools. However, they are also (mostly) present in in-tree
> bindings. I chose current-speed over xlnx,baudrate primarily because it
> seemed to be used by more existing bindings.
> 
> Signed-off-by: Sean Anderson <sean.anderson@seco.com>
> ---
> 
>  .../bindings/serial/xlnx,opb-uartlite.yaml    | 39 +++++++++++++++++++
>  1 file changed, 39 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/serial/xlnx,opb-uartlite.yaml b/Documentation/devicetree/bindings/serial/xlnx,opb-uartlite.yaml
> index 4ef29784ae97..28859e70e60f 100644
> --- a/Documentation/devicetree/bindings/serial/xlnx,opb-uartlite.yaml
> +++ b/Documentation/devicetree/bindings/serial/xlnx,opb-uartlite.yaml
> @@ -32,13 +32,49 @@ properties:
>    clock-names:
>      const: s_axi_aclk
>  
> +  current-speed:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      The fixed baud rate that the device was configured for.
> +
> +  xlnx,data-bits:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [5, 6, 7, 8]
> +    default: 8
> +    description:
> +      The fixed number of data bits that the device was configured for.
> +
> +  xlnx,use-parity:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [0, 1]
> +    default: 0
> +    description:
> +      Whether parity checking was enabled when the device was configured.
> +
> +  xlnx,odd-parity:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [0, 1]
> +    description:
> +      Whether odd parity was configured.
> +
>  required:
>    - compatible
>    - reg
>    - interrupts
> +  - current-speed
> +  - xlnx,data-bits
> +  - xlnx,use-parity

I think all of these should be optional properties because were required
in past. Likely a lot of xilinx dt binding files have them but as it is
visible sh also has it without it.

M

>  
>  allOf:
>    - $ref: /schemas/serial.yaml#
> +  - if:
> +      properties:
> +        xlnx,use-parity:
> +          contains:
> +            const: 1
> +    then:
> +      required:
> +        - xlnx,odd-parity
>  
>  additionalProperties: true
>  
> @@ -49,5 +85,8 @@ examples:
>          reg = <0x800c0000 0x10000>;
>          interrupts = <0x0 0x6e 0x1>;
>          port-number = <0>;
> +        current-speed = <115200>;
> +        xlnx,data-bits = <8>;
> +        xlnx,use-parity = <0>;
>        };
>  ...
> 
