Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C0C5C433F5
	for <linux-serial@archiver.kernel.org>; Mon, 18 Oct 2021 09:18:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 303B960FC3
	for <linux-serial@archiver.kernel.org>; Mon, 18 Oct 2021 09:18:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231206AbhJRJVE (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 18 Oct 2021 05:21:04 -0400
Received: from mail-sn1anam02on2057.outbound.protection.outlook.com ([40.107.96.57]:27904
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231149AbhJRJVA (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 18 Oct 2021 05:21:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=htKWejYZdOsZYSk5lA/fkFaeP7qKI5lWSkbqoyYpt8JfzIAKePnMwiKcUT4XK2PSfBN7BJHb/saqCEXhpy7g5I08z2B1AOYA014O6JMGMfC8bZx9b242aVZEDqwlghieWQEUeqWYTw8ZGMlw4ENCHVkrm/QMphEklSQF3LQsMQwg2QYCBnbfNXilzP3eE2+8UA2fl7tzUsSVbhdJd60AEQ/ocCYCqTD26+t69npbvzU8JXuTYWl7E47W9EoXarHlnxuhNd3C0x7W0Yv87WDm2zp4WhpEZ13mWQdTb1yu3//wy5Xn+NAyLgTPzgueO09c+1zrKmneZzy1Q0ONUoSqug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4ngEjK+8WhsgTqaW6LWWN/lME4yWxHu/wui9ocBm9D4=;
 b=f3xv6681p2oAlDBDHC7w+Nm3lmyfUCY1eWw6gZ/YDeL3G8e3twYPS0feXOiPlyhYlNbtDJWC/setYDur/LTWejyt9dD4IXDRpmlJ0Bx67P/pFm9GYdJgxoEI2F0u1RfiR2Zp3X/CV29qweNt1MvABUWPHDNcv9VYdrJv/fLzxak+baVfiotQb+Pfra9IYMgWKriXe/+JM+PDv+lAffoZ7pRV9/cDrBDl6Dsbzm+nURjD0Z+uEPQTXqHqXmtuQ04S02iq+e55/Nju61dzbKyhpsJrM+gvb1+LEPVq3jiGP6OsdB9la72xqQG1AzsR+J84yzO9rXD10kgtcyela+FQlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=xilinx.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ngEjK+8WhsgTqaW6LWWN/lME4yWxHu/wui9ocBm9D4=;
 b=fZQOXlUk0GdC8nd1T88KkI8ea3wGib8Rmnj7qr5gJKzhaq9Eey51SSUOFP71DbNNuGM1kis4eg5AZYF15hIiANua6LF+iW7Avw2+9renwrsrsyAlucoalPvwTuX4j687jvn+zt1j693spuYyShOyqAr+8Hfz8vw6cFOsVsTt8zo=
Received: from SA9PR13CA0142.namprd13.prod.outlook.com (2603:10b6:806:27::27)
 by MWHPR02MB3215.namprd02.prod.outlook.com (2603:10b6:301:63::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.17; Mon, 18 Oct
 2021 09:18:45 +0000
Received: from SN1NAM02FT0010.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:27:cafe::d7) by SA9PR13CA0142.outlook.office365.com
 (2603:10b6:806:27::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.10 via Frontend
 Transport; Mon, 18 Oct 2021 09:18:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=pass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0010.mail.protection.outlook.com (10.97.4.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4608.15 via Frontend Transport; Mon, 18 Oct 2021 09:18:44 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Mon, 18 Oct 2021 02:18:43 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Mon, 18 Oct 2021 02:18:43 -0700
Envelope-to: gregkh@linuxfoundation.org,
 kernel.development@povil.us,
 linux-serial@vger.kernel.org,
 shubhrajyoti.datta@gmail.com
Received: from [10.254.241.49] (port=37488)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1mcOn4-0005cp-9I; Mon, 18 Oct 2021 02:18:42 -0700
Message-ID: <cfe542a5-4a4e-0ceb-d7b0-7d96b03710ef@xilinx.com>
Date:   Mon, 18 Oct 2021 11:18:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] uartlite: Update the default for the parameter
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        <kernel.development@povil.us>
CC:     <linux-serial@vger.kernel.org>, <shubhrajyoti.datta@gmail.com>,
        <git-dev@xilinx.com>
References: <20211018082000.607185-1-shubhrajyoti.datta@xilinx.com>
 <YW0zZVBLImlS4g1R@kroah.com>
From:   Michal Simek <michal.simek@xilinx.com>
In-Reply-To: <YW0zZVBLImlS4g1R@kroah.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4bec998b-ee51-4554-7558-08d9921848d3
X-MS-TrafficTypeDiagnostic: MWHPR02MB3215:
X-Microsoft-Antispam-PRVS: <MWHPR02MB321507B627761C8E65A10670C6BC9@MWHPR02MB3215.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x9B9VbQ3Tkcsz9Um+2ifxR4QRrfH2JVt0n0TKZ2V57jx7aOqOQg8zrxlbzoZdWto4VYErorUYZPFIUm+DblSyarwYUIZX6/jNIn5Rbhtvujski2lFZHbERBUPFMMg5/GR47p1kM7K9aEKMbpN2Dd0102JKWXmW/EJRcHqXSA4/0EhutD5YJ0FhfwUZbxYPgD9yquMEN+yviOiJjNm+4M2QYHSPUCneSkpgtBOKIlKo9W1a4EGDOJbltJHtpeoj+n6TN7bx2fkZDXUDI4FuqSp2jptJnNYU8f/+uMX2xDThxnT+HvWTLZU47ibwz/KMwN3Ip1uUIUFlfclavOZ8Lr1Cx/ZhelsGnm29mUdehDjY8aFhLSVvBSKWyl3VvNHaNoGs1msxeDkWCBDINM+KtRijhoqxEhbnIT9eNMBfbsqnPGKqjoB/X2iUJi2XaWr10SRIL1yEzDlMk/odktLVEFgUXVCUw+E0/TfQGruc2A5T0vXOwYgs2U1KlgyldT2K/l4WzjcK7O9/0inSEte+EDGc3Mhr0jL7zkirWuIaoTnTsy0DAzXQSgVNr2q/nibMIMOF5SjTXOwBYWFXnI9bvYcEP1KJW2IpgJP5/pBrPCP0AcgVJvuWrpNwXJm0NFFtE/v5ADzmFi+iDTpdsixqxjbGjItVgol3tObBe7plDIKcJc8ATQRwEinqGFZIxd7n1iiJ/yzIWV2BTOtCSPNkUTA63e9Lcy5ZzmUgjAMbkVelTNBcHmhy7EFVXFFBnWDy66ATx8SlzdmuUIW0wKRIsrFw==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(46966006)(36840700001)(36860700001)(70586007)(4326008)(2616005)(336012)(44832011)(8676002)(15650500001)(107886003)(2906002)(9786002)(7636003)(70206006)(36756003)(26005)(5660300002)(426003)(8936002)(316002)(47076005)(186003)(31686004)(83380400001)(110136005)(36906005)(82310400003)(54906003)(508600001)(31696002)(356005)(53546011)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2021 09:18:44.7514
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bec998b-ee51-4554-7558-08d9921848d3
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0010.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB3215
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

+Sam,

On 10/18/21 10:42, Greg KH wrote:
> On Mon, Oct 18, 2021 at 01:50:00PM +0530, Shubhrajyoti Datta wrote:
>> Update the default number of uarts.
>> The commit b44b96a060f3 changed the default from 16 to 1 change it back to 16.
>>
>> Fixes: b44b96a060f3 (uartlite: Adding a kernel parameter for the number of uartlites)
>>
> 
> No extra line here please.
> 
> Also, your subject is odd, please make it more obvious what is
> happening.
> 
> But nost importantly, _WHY_ are you making this change?  What happened
> since that commit was made that now we should have the default be 16?
> Previously that commit said the default should NOT be 16, and here you
> are changing it back.  What changed to require this?

"The uartlite is used by FPGAs that support a basically unlimited number
of uarts so limiting it at 16 dosn't make sense as users might need more
than that."

He said that doesn't make sense to limit it to 16 and limit it to 256 by 
Kconfig range and set default to 1. Where it is also said that number 
should be unlimited.
And also no information why he setup default to 1 where it should be 
unlimited. I would say high number should be fine for the most of cases.
I have never seen any design with 256 uarts on it.

I think we could potentially find real maximum number for looking at the 
biggest fpga and setup this number but from my perspective 256 is big 
enough for a range. But default 1 sounds weird. And origin 16 written in 
driver should be quite reasonable default to cover 99% cases.

Thanks,
Michal
