Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB892C433F5
	for <linux-serial@archiver.kernel.org>; Wed, 15 Dec 2021 11:56:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242233AbhLOL4d (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 15 Dec 2021 06:56:33 -0500
Received: from mail-dm3nam07on2088.outbound.protection.outlook.com ([40.107.95.88]:54721
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S242224AbhLOL4c (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 15 Dec 2021 06:56:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lR5KqI4rfNbWMm/GzyXCenklWMcAHGFNByADOhU19lUWMyYz8PlmjDil/vdeRUJKk1VykHCLpk106WW1p6QTenYrtf29013L0JF4K8GWh93nbjEdu2Mj6zAkaF7+HKA/4B2um1I3HA5pOgoj25JRv/PshBuGffBi0TaDJwcGVSR+7tfEYxzAQDsWVt3a0OgTCG6iWR1PNpvpVSlVNEz56YL8k0QfxmnhAcr3iERxIF8iW6HAzfm6uKf5bNndZn81G4M2lb28Aoi/Ysq9nM0BDiTaH/gW2be/kr2SeRrGPfm3Z1e1dJcMcsQK2zcH8rAxq3Y3qjpNvsBlceitbzbksQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=htrGoVOlTFz2Zupl8+c9d8Zh45pkQs8Meu2j5ShlW0k=;
 b=SSQJPufCCzt1xFU4T8Q6I5E/OPDGVyM5I909+X0A2V+s8CB+XMiY6l0FbGcNEgko741zfANkWurnA+MG4r014ULDzaESkA2APCGHcdMZerx/d8Xh+M/c4nhshrPA0bZrdnZTjmY9YxuqoVWQDb4duOlSedByQqkG9UfwJMhKncqRnFNMM9ZcN5Rpq/rwi8h1+Pu41t1C78qq9TnRofg+d3nkN+8wSHQIdOyee8xW4pA648kfFB4+quDs71iLQEDlbSmBdFgMJcrczkUQa7e+3wFOe6Csbrw4Ow7EWw3zyRJNeZCptOpCv/fU+vLWhCDKpC57PCXhpz+3etTZ0sF22g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vanmierlo.com smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=htrGoVOlTFz2Zupl8+c9d8Zh45pkQs8Meu2j5ShlW0k=;
 b=N08OrgTsjns4ty0gzI1NgDdu1Bt0yUXJmf8/LLSH8FAW1qZTbMoHzZ56AxyjPVPCervWzQeyjyUhieisVmKXm6brKe9Hych1jQOGDgFu4M07OFwzuYrqtcHeVt4Uir7KGp0MX/8rEsRcqe9Oq1QuFAvUqWNQFSpsgbEhlglg5AA=
Received: from DS7PR05CA0028.namprd05.prod.outlook.com (2603:10b6:5:3b9::33)
 by BN6PR02MB2578.namprd02.prod.outlook.com (2603:10b6:404:5e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Wed, 15 Dec
 2021 11:56:30 +0000
Received: from DM3NAM02FT003.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:3b9:cafe::33) by DS7PR05CA0028.outlook.office365.com
 (2603:10b6:5:3b9::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14 via Frontend
 Transport; Wed, 15 Dec 2021 11:56:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT003.mail.protection.outlook.com (10.13.4.168) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4778.12 via Frontend Transport; Wed, 15 Dec 2021 11:56:28 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Wed, 15 Dec 2021 03:56:27 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Wed, 15 Dec 2021 03:56:27 -0800
Envelope-to: git@xilinx.com,
 m.brock@vanmierlo.com,
 gregkh@linuxfoundation.org,
 linux-serial@vger.kernel.org,
 jirislaby@kernel.org,
 jacmet@sunsite.dk
Received: from [10.254.241.49] (port=37398)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1mxStX-0005YP-69; Wed, 15 Dec 2021 03:56:27 -0800
Message-ID: <e30af06d-0701-59b8-cb27-b77978feadac@xilinx.com>
Date:   Wed, 15 Dec 2021 12:56:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v2] serial-uartlite: Remove an un-necessary read of
 control register
Content-Language: en-US
To:     Maarten Brock <m.brock@vanmierlo.com>,
        Shubhrajyoti Datta <shubhraj@xilinx.com>
CC:     Greg KH <gregkh@linuxfoundation.org>,
        <linux-serial@vger.kernel.org>, <jirislaby@kernel.org>,
        <jacmet@sunsite.dk>, git <git@xilinx.com>,
        <michal.simek@xilinx.com>
References: <20211123131348.26295-1-shubhrajyoti.datta@xilinx.com>
 <YZ4O+qnkVyhGzuDy@kroah.com>
 <MN2PR02MB664063C64EA9C8BC59C3E566AA619@MN2PR02MB6640.namprd02.prod.outlook.com>
 <cd14525f12ea09fe85d9db18712ae20a@vanmierlo.com>
From:   Michal Simek <michal.simek@xilinx.com>
In-Reply-To: <cd14525f12ea09fe85d9db18712ae20a@vanmierlo.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ad34e236-db95-4605-e4d4-08d9bfc1edd3
X-MS-TrafficTypeDiagnostic: BN6PR02MB2578:EE_
X-Microsoft-Antispam-PRVS: <BN6PR02MB2578F58325FCF6214A5D58E2C6769@BN6PR02MB2578.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CW9af/riMe3yIMPs1qXss/3HwxA2g8eq8B/WWv5BupKGYDoAaYVExFbo0y9vKZmalN+JuZgWeec2gppPtZtl8UFOxItQ4WNuKWo3uiQGmYst/PIB0PK1zacITxLOJZZATBWXvvBpjKot6YXkssGVqzkj0pYEOeDZKF1eT0AzQC3tSSNsAiWNenCfehpjHRU8oXErYpKO4kKj7pexdqf4Ct6wjYJaKozxs1Zus1RmjUC5xqjVed6vIdf9GPxaa7Gz9wm7KEYt3pGv/XZUufVpNqckFsqLwKCqbXXUzWrloFpvCwy/5D//8xsfhyGZEO+DayOs+jr9Hev5BgQ6MjPlGUQ5EyQPknBBBAO0gnWfihHN1QhWJYRg7R6vEjBRR0NT9QlgIuHTWh4LpSrESPTk7kw2FNOs9ijcEDWENl8kzAkl9bb2efMiAGgYpbLuusBKkpxfeI+1AgXnebNwLiaV29CqMTlUNKdUg0Kci8I9CeK0/Fmg5piyXrEwOyroD4d/6unKZGRRHY5jK3r/cc/ETPgM4J5KLmkZCtPVBEdwvE7oSeq1qXc0nY4DKHAseRbawQId8/N17QLP73uSkeo/FtHaKqvWAAyqIdKRpMONaIXhmDFOy5TBHU0U4b8Eg+yknmXoSgv3qbbRe5pnN7T4nkMyHgQ3HMtHr2m3vK42ZXYkh7bMSRznIgm8Xldj+U4K9iJ2f7Zdecznfwy2qniIfqDxhsK1kxUml7ryoDaWlZgXFoIJzrJmuUO9bd2pJEU0Px0dPRG84KS0VkI8XGVVOw==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(46966006)(36840700001)(36860700001)(426003)(47076005)(83380400001)(336012)(7636003)(4001150100001)(9786002)(53546011)(8936002)(508600001)(70586007)(110136005)(54906003)(6666004)(31696002)(2906002)(36756003)(356005)(26005)(2616005)(6636002)(70206006)(82310400004)(4326008)(8676002)(316002)(31686004)(44832011)(107886003)(5660300002)(186003)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2021 11:56:28.8378
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad34e236-db95-4605-e4d4-08d9bfc1edd3
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT003.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR02MB2578
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org



On 11/26/21 15:07, Maarten Brock wrote:
> + Michal
> 
> On 2021-11-24 13:37, Shubhrajyoti Datta wrote:
>>> -----Original Message-----
>>> From: Greg KH <gregkh@linuxfoundation.org>
>>> Sent: Wednesday, November 24, 2021 3:38 PM
>>> To: Shubhrajyoti Datta <shubhraj@xilinx.com>
>>> Cc: linux-serial@vger.kernel.org; jirislaby@kernel.org; jacmet@sunsite.dk; git
>>> <git@xilinx.com>
>>> Subject: Re: [PATCH v2] serial-uartlite: Remove an un-necessary read of control
>>> register
>>>
>>> On Tue, Nov 23, 2021 at 06:43:48PM +0530, Shubhrajyoti Datta wrote:
>>> > The control register is a writeonly register that's why reading it
>>> > doesn't make any sense.
>>> > The manual states "This is a write-only register. Issuing a read
>>> > request to the control register generates the read acknowledgment with zero
>>> data."
>>>
>>> Are you sure this is ok to remove?  Usually you have to do a read after a 
>>> write to
>>> ensure that the write succeeded.
>>>
>>> What ensures that the write succeeded now if you remove this read?
>>
>> I do not find the mention of a read requirement in the manual.
>> Also in the current code in ulite_console_write and in ulite_startup
>> we are writing without a read.
>>
>> Thanks and Regards,
>> Shubhrajyoti
> 
> I suggest to confer with Michal Simek. He introduced the read in 
> ulite_request_port()

 From my perspective that read is not needed and can be removed.

> in the past. The other one in ulite_shutdown() has been there since its 
> inception in
> 2006.

I confirm this. It was originally developed for PPC systems that's why not sure 
if there was any issue on PLB bus. But I expect Grant wanted to make sure that 
disabling port reached IP that's why he read it back that irq can be freed and 
clock disabled.
This is better to keep it there for sure.

Thanks,
Michal
