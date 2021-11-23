Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E37A8C433EF
	for <linux-serial@archiver.kernel.org>; Tue, 23 Nov 2021 20:12:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234887AbhKWUPX (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 23 Nov 2021 15:15:23 -0500
Received: from mail-co1nam11on2071.outbound.protection.outlook.com ([40.107.220.71]:44277
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234794AbhKWUPU (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 23 Nov 2021 15:15:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LccqvzadKhQOaiDik7fysoTmtjlaI/ZZXccNUqME/FpAi+Lg0noAIAGhmcYnZSjA6Lm1buv9V+bm3SChouV5iu0+zYSgNJjrEOURaBK+VV7vlFciPAevsz+fFqiLNyTgkABFn735RW63UWIBRMnb83YPXffZ2Q7CMXPeVZK+0gPSIaESW3OPKHeK+oikAPHsmwapd54Jhum2VqJAAMHT9PKD/fxYrovmtAHTnV3w5BJ5RLhmi+oh3GN3XfKBMG/seWUqist9FylmrYu74vzZk+sUxe6pB7r+z7mSGJaOwIoPRsL8cs55tudd2GQAuHW2FTfQ9xK5WaEkhqkADlMqyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eJGzR5iZ94VtQEIAbNpGkU9dmGaLH/xBBvK0fYtwJ04=;
 b=ageEsISbIzZ2q0JKGlPSaYQECOGvW3tFUUqY/pOPyiUR8x+lU6IvFpTsBUvcOah/Q66D0GUMNfnUEoGNUW6wwx/G+Me7Ho8P6XvoDAomYh9ogg8SYxEqh72bkzmiUl4OCLJ4qqaLe6LQYJpGHEFF9bwxnMGsiaCWBgqVeBaL1sOiw09RoZOqWqTW579hCbjW5jb7TGrxW1yBW6JEty4ZxcJL3IjlWKBVVlPjdUibseiBLGFhT4/XTZ1v47lN/P1yloOLGsf/MyiXd+RXRd+YZlJ1AUsB8N5SiJ3UjroZPMYSspZWk84tMgHYvhkPH7fVsMFHnN6uupxAxRc92tPBKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=sunsite.dk smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eJGzR5iZ94VtQEIAbNpGkU9dmGaLH/xBBvK0fYtwJ04=;
 b=D2gN/1D4S7IB0nWXXvfGUZI1Rc/qn3MNSt844bphJQG4IoCXRjdLsWWozsOjAwMW6IxgY+DhDlHQ/QwgNs/tOnxPKw2wRv25DipTowHJCY1Owt9sFfwswVfHUBAIZVZBFyWZFxPHDAkszHMd5u6DfIm4psNTKwCrztTMD6X4n9Q=
Received: from BN9PR03CA0721.namprd03.prod.outlook.com (2603:10b6:408:110::6)
 by BN7PR02MB4018.namprd02.prod.outlook.com (2603:10b6:406:ff::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22; Tue, 23 Nov
 2021 20:12:08 +0000
Received: from BN1NAM02FT011.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:110:cafe::1a) by BN9PR03CA0721.outlook.office365.com
 (2603:10b6:408:110::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend
 Transport; Tue, 23 Nov 2021 20:12:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT011.mail.protection.outlook.com (10.13.2.129) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4713.19 via Frontend Transport; Tue, 23 Nov 2021 20:12:07 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 23 Nov 2021 12:12:06 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 23 Nov 2021 12:12:06 -0800
Envelope-to: jacmet@sunsite.dk,
 linux-serial@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 gregkh@linuxfoundation.org
Received: from [10.17.2.60] (port=60786)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <lizhi.hou@xilinx.com>)
        id 1mpc98-0004H8-8r; Tue, 23 Nov 2021 12:12:06 -0800
Subject: Re: [PATCH 1/1] tty: serial: uartlite: allow 64 bit address
To:     Greg KH <gregkh@linuxfoundation.org>,
        Lizhi Hou <lizhi.hou@xilinx.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        <jacmet@sunsite.dk>
References: <20211123184506.1184561-1-lizhi.hou@xilinx.com>
 <YZ05/73+BhIANNGF@kroah.com>
From:   Lizhi Hou <lizhi.hou@xilinx.com>
Message-ID: <0e212384-396b-f765-be28-f9319c64b5f7@xilinx.com>
Date:   Tue, 23 Nov 2021 12:12:06 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <YZ05/73+BhIANNGF@kroah.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b3d5f064-2cc5-4e3e-f92a-08d9aebd8620
X-MS-TrafficTypeDiagnostic: BN7PR02MB4018:
X-Microsoft-Antispam-PRVS: <BN7PR02MB4018E53881CEA772B2CAE28BA1609@BN7PR02MB4018.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6tURBWkQXnvjpIhvCdWNSGWrbja6xgdjBovPRMe6a5o+kyqKO8kLk3lAljq3AhTIc0jEXPY1iJvIdKr75ZRfMwXcyoyzz/72YR4Vr0Mg+ZmBdrTh6jmk673wOz5eE7sPqWA++8FoxITRamTNxZdN7Nkn3veZih9jrA9tJT3on5RzNDv9dUwjqWe9FmtOVCBDRdyP5FyUN/pjiKFJ3B0h/yM/0k8hoXFJBeTBqGACoejYfKN7HoDXWKDKA1kA6XEEMM03GMZh5rEgnOoM5C6vdCNGuL99uIGjiAsZd5cVxAHGXEG5vVAKpXz1bbtYqfkacRuaXjyUar45guMij27TOV1CZRRVgb2C6IDt+o5CyfyBnqxx2lb6QoXk0Hfba/jyhjcpI5KZb4qMSp2EnCZ27zeZW7C1oHVMaedHCiTi6lpyIEALIf4hQQI5etQ3i6RSp2Ukz4X2H4RAQkqZibW3a3ldjy24A4s9W54e9NM/hmAiYfP4EBiHg15DDuwZ2Xlr31t7Yeeg9jVMDjUnpXNVC0bLPpNaC8Mmnhpq+V9rv5poa8yL1Fx3vSROeFOkwL2I4VlErR5dv9G4CGAWe3TtqtbkkR61EMMse+Sp7cbFpeD0lbOaGifnGTN4rxHOrQ0BEtF+U48kPbLtAfUOi0f5Axe24B9wdnEtWyp+xzKLiJxXqXBpnjtis4XNcr/DO8CKAg94YC+GQpDe9a/878pmCjnuwmQ0lFBKLpCtrPBDuadn8+xgMhTp9400o4Nnwz1bQetU75/6swZrZaL8sZYY590PFaG1JjdJGLYfEfEXRgrnh3qv9vfdqOqUsRiL3US1TvbysLs49vT7wtn9t2hcFOW5ovmxOEa54NhV4CPDvu0=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(36840700001)(46966006)(44832011)(36860700001)(70586007)(26005)(2616005)(70206006)(356005)(83380400001)(47076005)(82310400004)(426003)(54906003)(9786002)(508600001)(8676002)(336012)(2906002)(53546011)(7636003)(5660300002)(4326008)(36756003)(966005)(8936002)(31696002)(31686004)(316002)(186003)(110136005)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2021 20:12:07.0666
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3d5f064-2cc5-4e3e-f92a-08d9aebd8620
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT011.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR02MB4018
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


On 11/23/21 10:59 AM, Greg KH wrote:
>
> On Tue, Nov 23, 2021 at 10:45:06AM -0800, Lizhi Hou wrote:
>> Fix the uartlite probe failure when it is mapped to address above 4G.
> Fix it how?

Does this detail comment look ok to you?

The base address of uartlite registers could be 64 bit address which is 
from device resource. When ulite_probe() calls ulite_assign(), this 64 
bit address is casted to 32-bit. The fix is to replace "u32" type with 
"phys_addr_t" type for the base address in ulite_assign() argument list.

>
>> Signed-off-by: Lizhi Hou <lizhi.hou@xilinx.com>
> What commit caused this problem?  What commit does this fix?  Should it
> go to stable kernels?

I searched the history. This problem was introduced by 
https://github.com/torvalds/linux/commit/8fa7b6100693e0b648ffd34564f6f41226502a19

And yes, I agree this should go to stable kernels. I will add 
stable@vger.kernel.org to cc list.

>
>> ---
>>   drivers/tty/serial/uartlite.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/tty/serial/uartlite.c b/drivers/tty/serial/uartlite.c
>> index d3d9566e5dbd..e1fa52d31474 100644
>> --- a/drivers/tty/serial/uartlite.c
>> +++ b/drivers/tty/serial/uartlite.c
>> @@ -626,7 +626,7 @@ static struct uart_driver ulite_uart_driver = {
>>    *
>>    * Returns: 0 on success, <0 otherwise
>>    */
>> -static int ulite_assign(struct device *dev, int id, u32 base, int irq,
>> +static int ulite_assign(struct device *dev, int id, phys_addr_t base, int irq,
>>                        struct uartlite_data *pdata)
> So you changed the variable type which does what exactly here?

ulite_probe()

    -> ulite_assign(&pdev->dev, id, res->start, irq, pdata)

                                                        ^^^^^^ could be 
64-bit address. Thus "u32 base" may lose the high 32-bit.

Hopefully this makes sense to you. And I can re-submit an updated patch.

Thanks,

Lizhi

>
> thanks,
>
> greg k-h
