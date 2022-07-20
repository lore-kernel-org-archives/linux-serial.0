Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 529A3C43334
	for <linux-serial@archiver.kernel.org>; Wed, 20 Jul 2022 13:42:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234788AbiGTNmH (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 20 Jul 2022 09:42:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231668AbiGTNmG (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 20 Jul 2022 09:42:06 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2048.outbound.protection.outlook.com [40.107.102.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57CF950044;
        Wed, 20 Jul 2022 06:42:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DmoONUD1IFw2amh7l3uUK/tg0z6mKdZyN0k918bopTD/1MyI0wa+aPBG9vuJxughNYa5oH1ca4RDG3ciWIOgyHfu8B0NeaJ6IBxADnWejfDrSset9KFKUWNgzDGG3DoN5vkENV+6IXiLYmKoZCdjU9PoWXfTq2uGUdNozDFbQi8MH7R1ka9b+5dOXfdmyIP/2g47V9zcfn/lol5mC4LQKrVZHoG5v4/p7+5Kh2F/KRT12nROO/M7c6BMGTi/v9v9id7hIDEM2eqT53TxuD4RayDOlyh7zXKBnvrCmb8RKepY+aj2vISxJNOVP4+xAa4NMk03qPlokuXwmB2erdMMxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/SQkklVtruLcEMsVPjCIaLhqMObTzhTmBZ9rY6z1HEk=;
 b=OeG0BhxNIS3jbRfjQsvYCi//jXTCF4Vi4OpjYHNXNbGqaD1u+T6tfyHyF1CuWAwJxmcvL1sYMpZWGPl3CTbt9Ia/1j2oPWkbm7UtIxav6CF4130s7S5BY81iIqEXUVFMowJCkv75Saw5g9x6GqKlTGgbiVnI7DlaiBaS7o2wwAooj8anyCPCXlAIhGA6UboFP01eOeof4EIbYelWVy+yVFTMafaR34WDF6bCqlXZF6sL6Bei54pF2zTQoCWUeVBZUTzrmCO6l7umKonBN+USlHq8PXaE7/FO2d3DOAe3NFgmmzeoQMjQ6fKkmzzJkLA3yhlAoj78NqLLbvaT4YEL7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/SQkklVtruLcEMsVPjCIaLhqMObTzhTmBZ9rY6z1HEk=;
 b=BHz2KTuBbtrhxUxwaAEkNoD3Gn5BrbGYAYQ6UmcQkk/TR9pzcba7lYm5txYJ7Nt4ipyVYrsZcE5/9AYRLLGEgeKo1KOoprXT4j7MmlOYYG10j+S4Hcka3QCc4m6IOUOYQhh2PHyJphwdYgOSccU3TmjkmmAk3lRH34fyV2hIDwM=
Received: from DS7PR03CA0331.namprd03.prod.outlook.com (2603:10b6:8:55::26) by
 BL1PR12MB5112.namprd12.prod.outlook.com (2603:10b6:208:316::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.15; Wed, 20 Jul
 2022 13:42:01 +0000
Received: from DM6NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:55:cafe::98) by DS7PR03CA0331.outlook.office365.com
 (2603:10b6:8:55::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26 via Frontend
 Transport; Wed, 20 Jul 2022 13:42:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT015.mail.protection.outlook.com (10.13.172.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5458.17 via Frontend Transport; Wed, 20 Jul 2022 13:42:01 +0000
Received: from [10.254.241.52] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 20 Jul
 2022 08:41:56 -0500
Message-ID: <0168318c-02b0-c591-190e-770035879b4b@amd.com>
Date:   Wed, 20 Jul 2022 15:41:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/2] dt-bindings: serial: pl011: Add 'arm,xlnx-uart'
Content-Language: en-US
To:     "Datta, Shubhrajyoti" <shubhrajyoti.datta@amd.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Shubhrajyoti Datta <shubhrajyoti.datta@gmail.com>,
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
 <50bfd52b-6fe0-546f-9121-0145aac91289@xilinx.com>
 <9d9067f3-5b2d-6434-ec2f-93b4a97a6588@linaro.org>
 <BY5PR12MB49022C7A09F42E8B5A1F868881889@BY5PR12MB4902.namprd12.prod.outlook.com>
From:   Michal Simek <michal.simek@amd.com>
In-Reply-To: <BY5PR12MB49022C7A09F42E8B5A1F868881889@BY5PR12MB4902.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eebc1913-f51e-42e2-230d-08da6a559fdc
X-MS-TrafficTypeDiagnostic: BL1PR12MB5112:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qCiWcXjYPA88BdrwXmAFBggEobnynYsapeN1ZtV6/UI463yqzKw2Qh0wCBez4fQuEUT0pgZxOZBS2c3rg2Ew/pjlDbXmYHlbs44uRYD+TKQrTgWqaaXP72MPhp0wFGNtVW+sLvfM3/Q209Sxkj03NsVtMi9+Jrg8tbb2QQMVKPQOPacveqbPrhR5Hwiep92hPv2i0NwNh+czFYvhVA4/yKbY/me44eRXwl4s6O+2qyHWQoK2gBWWJDG5YqMYMi5Y6c/BxfJtQu+/yAVptpdIhKhqp1SGawWfX44DXPdJGJK7pZ4FEKm3pj339lNhMq7qjRE2Ide8yw4Me6tWEFWQ1R+S1J/pafRIyO6wrMGjhRsDHAIUGjB7kOfTIQ5lPKBLVaWFe+DxBZaWbaxHijmt6IdvN5QnH1CmOOd7+MyZtrs9sBdgDX/CV2YTLLAb6oupS9yASKL7CIh/mTDK5vVHA2ThZRaqznuCVFgyej6YOjglFXvTBDfM/Wwf6Y0u/vzGYSyKjgfDw7QPRQOQK05XSofPVCRBztFS33XTUoSooK1vPjQI8SEDSK7DtoSsO10kmuSd304vEEkQkJyA0uqPwFp+oqUPs3x0Y7ryT/+54vggxnmrNxQj64VKRg4KClc1L420qlN7lKp9x+cFHaIjo+6+XX40FMOMnfGbjBIzAOXPQy8Y6f/x2yhWuirBdU42kxkiPS5y74y8UVgMDNOf7N2jQiz+EzehCh0AxNxBoxUnDhrYx26J8NyXWwnuUzCirxCcverxSLFmLfkAQWZZmwc4KTCg3tZyolDDpUI0eWv0uRGYbpbfyo9MRIr6q3/vd0eHieWV4liLanncZqAm/bWhDUTU13aHV6g/XQbQcA6n/eRB0O5lxPRTrZZP24jL
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(376002)(346002)(39860400002)(396003)(136003)(36840700001)(40470700004)(46966006)(356005)(2906002)(16526019)(82740400003)(41300700001)(40480700001)(107886003)(426003)(110136005)(83380400001)(47076005)(336012)(82310400005)(53546011)(81166007)(316002)(54906003)(186003)(31696002)(26005)(86362001)(8676002)(8936002)(478600001)(2616005)(40460700003)(70586007)(5660300002)(70206006)(4326008)(36860700001)(16576012)(31686004)(36756003)(44832011)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2022 13:42:01.2021
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eebc1913-f51e-42e2-230d-08da6a559fdc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5112
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org



On 7/14/22 14:14, Datta, Shubhrajyoti wrote:
> [AMD Official Use Only - General]
> 
> 
> 
>> -----Original Message-----
>> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Sent: Thursday, July 14, 2022 5:29 PM
>> To: Michal Simek <michal.simek@xilinx.com>; Shubhrajyoti Datta
>> <shubhrajyoti.datta@gmail.com>; Rob Herring <robh@kernel.org>; Krzysztof
>> Kozlowski <krzysztof.kozlowski+dt@linaro.org>
>> Cc: Shubhrajyoti Datta <shubhraj@xilinx.com>; linux-serial@vger.kernel.org;
>> devicetree@vger.kernel.org; gregkh@linuxfoundation.org; Srinivas Goud
>> <sgoud@xilinx.com>
>> Subject: Re: [PATCH 1/2] dt-bindings: serial: pl011: Add 'arm,xlnx-uart'
>>
>> CAUTION: This message has originated from an External Source. Please use
>> proper judgment and caution when opening attachments, clicking links, or
>> responding to this email.
>>
>>
>> On 14/07/2022 12:55, Michal Simek wrote:
>>> Hi Rob and Krzysztof,
>>>
>>> On 6/14/22 14:21, Shubhrajyoti Datta wrote:
>>>>>>
>>>>    <snip>
>>>>
>>>>>
>>>>> No, I don't know what the differences are in your h/w. You have ID
>>>>> registers, but changed the IP and didn't change the ID registers?
>>>>> How has the IP changed?
>>>>>
>>>>
>>>> The IP is not changed and the ID registers are not updated.
>>>> The limitation is coming from the AXI  port that the IP is connected to.
>>>> The axi port is allowing only the 32 bit access.
>>>> The same information will be updated in the Versal TRM.
>>>
>>> Can you please give us your recommendation how to process with this?
>>
>> Unfortunately I don't think that anyone remembers context from last year,
>> especially me who was not Cced. Rob responded at end of March and it took
>> two months to get back any answer. Such slow response time from submitter
>> does not help to stay in the context. :(
> 
> I had to contact the hardware team and get the details on the issue it took me sometime to get a response.
> 
> I will summarize
> 
> We are using the ip from ARM but the AXI port that we hooked has a limitation that it allows only 32 bit accesses.
> 
> So to tide over the and differentiate  I am adding a new compatible arm,xlnx-uart.

ok.

Shubhrajyoti: Please send this series again with updated commit message in 1/2 
which contains information you provided here. That means it will be v2 version.

Thanks,
Michal

