Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A8B4C43334
	for <linux-serial@archiver.kernel.org>; Thu, 14 Jul 2022 10:55:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237030AbiGNKzd (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 14 Jul 2022 06:55:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231304AbiGNKzb (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 14 Jul 2022 06:55:31 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2044.outbound.protection.outlook.com [40.107.92.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0579B558E8;
        Thu, 14 Jul 2022 03:55:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oGnQXZO9km5lbJIE+ejz1iFgafcFNv4Tkt7ZMoX4KfbD4fmDCUT2odHhcjnPBJ2zdLGtwpv606kMQE9LElNNfTMQYg8H/F7xxIZ98SE29c1auPoY7EWNGQMCfQacBuPjQ7qfLAZ1Hw0DJcL8E7wtlDLBZh8jEm5ef32XI5BweGNFGsnsEwCsoQ68xjF+ECAi+X4uUXr4EL5cKBJASwdu3UqVWZoOB8KOwPbuPcH7SIytfqyrVjOUERtnxjGRdcOiYsc8ERHf+vbjHsRsHOOpz4CvMUBa9Aymr6RADj7yKXMUZcciqW1ZfiYdZ+txY01M1QcTIXAbY8Yk+rto89nRYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n4xQ5ZtCbOzae+117oJNobSa/X3RVYc+Bp6dqhipya4=;
 b=EZq1eqxPVFQ+Zojx6F3+zRNZYV+W8XduucaZGGQHCo4fTy/eHGzLKbMig0POLUla/6JMFAr+e3IGJnUSe5u3gD1tqAlHMFZlhdXhCaRw+Dh526daNarcXiFji3cXUhqgJx/Ae+RjPp6BnV0rbJ9EDzDZgujQHm4PUxZgA0IA9QSRJm+qb1qWIrYdehVV/z/cq713Zx3DsbkMCO1RXR02OJEfMR6Nw8FEGBMD0ceAIqrnAIlO/W1m/AIn1T4BzgkRDGk0+winydAlzECPSTH813J+Tq6nT6NAnHLzXcNS8aOVGa+Ze4ReuwuzwSEC9+fh7fX7li27OZbJOBNq54zPRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=gmail.com smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n4xQ5ZtCbOzae+117oJNobSa/X3RVYc+Bp6dqhipya4=;
 b=FQtkiykAguQfo6O3sKdYt+r6uWm2T6qEOJBYhpe07j2BwM/nHmCY1VBxrfPEQNgZjDGyBK7402claACzyQ48tZpWYyRHq0arAa4RiQbYChpRFJEY9511NpIfyjNMmdZmd9pPhpWpyekD1Mg4ebFpfuJjjqjdmkytI4L/LNKk5x0=
Received: from BN0PR03CA0043.namprd03.prod.outlook.com (2603:10b6:408:e7::18)
 by MW4PR02MB7426.namprd02.prod.outlook.com (2603:10b6:303:66::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Thu, 14 Jul
 2022 10:55:27 +0000
Received: from BN1NAM02FT022.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:e7:cafe::d5) by BN0PR03CA0043.outlook.office365.com
 (2603:10b6:408:e7::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.17 via Frontend
 Transport; Thu, 14 Jul 2022 10:55:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com; pr=C
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT022.mail.protection.outlook.com (10.13.2.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5438.12 via Frontend Transport; Thu, 14 Jul 2022 10:55:26 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 14 Jul 2022 03:55:23 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Thu, 14 Jul 2022 03:55:23 -0700
Envelope-to: shubhrajyoti.datta@gmail.com,
 robh@kernel.org,
 krzysztof.kozlowski+dt@linaro.org,
 linux-serial@vger.kernel.org,
 devicetree@vger.kernel.org,
 gregkh@linuxfoundation.org
Received: from [10.254.241.52] (port=43806)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1oBwV9-000FAi-Eg; Thu, 14 Jul 2022 03:55:23 -0700
Message-ID: <50bfd52b-6fe0-546f-9121-0145aac91289@xilinx.com>
Date:   Thu, 14 Jul 2022 12:55:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/2] dt-bindings: serial: pl011: Add 'arm,xlnx-uart'
Content-Language: en-US
To:     Shubhrajyoti Datta <shubhrajyoti.datta@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     Shubhrajyoti Datta <shubhraj@xilinx.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Srinivas Goud <sgoud@xilinx.com>
References: <cover.1637061057.git.shubhrajyoti.datta@xilinx.com>
 <e1d6913bfe5ce023d7f6ea106d0359142063e694.1637061057.git.shubhrajyoti.datta@xilinx.com>
 <YaVPYiGmDsqY+1at@robh.at.kernel.org>
 <DM6PR02MB663589B3489C53A34DC25A31AA719@DM6PR02MB6635.namprd02.prod.outlook.com>
 <MN2PR02MB6640017950EFB0FD21D2AD91AA339@MN2PR02MB6640.namprd02.prod.outlook.com>
 <DM6PR02MB66352597DBF172ACC5307274AA179@DM6PR02MB6635.namprd02.prod.outlook.com>
 <CAL_JsqLV3De0O2WDq=w_CQbvAiJVvQ-=V9XuC1tJyZNLyneDZw@mail.gmail.com>
 <CAKfKVtGrdh-iQP7YKUBe37HVeZcU-UV3A3BHKjcnggBFR94eNA@mail.gmail.com>
From:   Michal Simek <michal.simek@xilinx.com>
In-Reply-To: <CAKfKVtGrdh-iQP7YKUBe37HVeZcU-UV3A3BHKjcnggBFR94eNA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 388a5e03-147b-48ee-7392-08da65875c59
X-MS-TrafficTypeDiagnostic: MW4PR02MB7426:EE_
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TDL6KLK9KNm/eijHbP0lvRY1vlg0i/4ZyBTZBRShZJ79AAVCzo8fP4kc7PgaMo5JuFprwkyeYv02tkbyPFlFWmHh0DzSHfPqJ9MmuMzQzjPDDNsSJM5yXXBGPT7zybUC+fH4+sh1XAQsWG4aakkImCYww9y4Nn7dmEo8StjSDUNUovjrcXTaPDdE023na2QKYusiR5pX3zkLPLkMY33AB5HmsgAbdcTmI4ALnIfb25cbCPMEekyCDVLmIJaVmNxSq0wUu6WJupZ3ZOpBUlyuwi0DgBElkrKPDvD7fo84MOpv7ZMRu1b3/7uA++gcsLLWTZmhJWVyL4H6qiBj5P56j1Mt/4vnhqZr6SFhBHuhk8dO1bvxFDOsK55DiRbpDB+ZKVp513rzOI/1eO6WUrU2Om6z5K9f5n5faIq6n+Sutqr1/Woeb0E7q1IAaQKZWav0egwt2oJCl633VyOvicZoXGgQhmBQhbtHaJdbZg+HcsRTRsZEqvDE+hqUalLnXYiw0+dc3ao7w567Zie/ELSyjqAsS39Yd/udV+8s4TWU/pBlBLPp1kx3DPA+U0NP1GB1JS14iSQdIVXJEnGmJhUSyWYP4Es2u1lynvidXJIUSHHeVa1Q0gkFvVFUntMp9I7Flt0U995kJqI6zsys+pQnSHt0bqfM6TTN5tRTlpxyQfIvu5ij6C1q9AuPgp5gmqsVf6QJzAEraFwnCHQqsL42NpqLYL//as68kIo4W/IvEAQ1aQTQHBX/2xXd+5AehQhgKos+VRF5vzdorJt0/1R0uaQ0qY5D8UVxvs3F3oTBHkzP4ekDknLbGebU9L0GCyiM2Z6sY9lTzKn+haGt3PVkf21JTcgQ0Q/mpEI4YZGa5oQNGM7kfZ4dY6QnnFt7g3Lg
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230016)(4636009)(346002)(39860400002)(376002)(136003)(396003)(36840700001)(40470700004)(46966006)(40460700003)(26005)(2616005)(40480700001)(356005)(9786002)(82740400003)(107886003)(31696002)(82310400005)(2906002)(426003)(336012)(47076005)(41300700001)(478600001)(8936002)(4744005)(83380400001)(186003)(44832011)(7636003)(54906003)(316002)(36860700001)(53546011)(31686004)(70206006)(70586007)(5660300002)(8676002)(4326008)(36756003)(110136005)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2022 10:55:26.9296
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 388a5e03-147b-48ee-7392-08da65875c59
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT022.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR02MB7426
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Rob and Krzysztof,

On 6/14/22 14:21, Shubhrajyoti Datta wrote:
>>>
>   <snip>
> 
>>
>> No, I don't know what the differences are in your h/w. You have ID
>> registers, but changed the IP and didn't change the ID registers? How
>> has the IP changed?
>>
> 
> The IP is not changed and the ID registers are not updated.
> The limitation is coming from the AXI  port that the IP is connected to.
> The axi port is allowing only the 32 bit access.
> The same information will be updated in the Versal TRM.

Can you please give us your recommendation how to process with this?

Thanks,
Michal

