Return-Path: <SRS0=rp3o=ZH=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E92F2C432C3
	for <linux-serial@archiver.kernel.org>; Fri, 15 Nov 2019 08:21:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B737E2073C
	for <linux-serial@archiver.kernel.org>; Fri, 15 Nov 2019 08:21:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="opY4eERh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726196AbfKOIVU (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 15 Nov 2019 03:21:20 -0500
Received: from mail-eopbgr680043.outbound.protection.outlook.com ([40.107.68.43]:34350
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726182AbfKOIVU (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 15 Nov 2019 03:21:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hl01bZl/cM1WRQa2Qz7X5hHCuk7pJKZma15YxCPLD2Vr+cp8EGpYxzciUjaaxMl45yWAh9NoPy/rhHJB/kjuZebpHqck+wQQX6Y3Cx78C7qf06zmBUq6bqiF+fsejRU7pybmMmzy4bYrKogHH6+0bJ0r7U73iY9M7V/qIWtnGKspwpRzvf/YBxovsoxviyxUUdjfCYhtUkLz6w26aqkpluy885IcmKzyC3h1eIcfvPX4Ci5h1efiecEuQ85o+bZENTDiDHO0Nka4uvwQAZUP56iwkzymS4bnhELH+VpFAUrBQG/PmF78bNtWhVwvFDSOUPVfBbYz+QfhL5h1iGroRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VXe5QCaAxHFxzWWZctO/FtJVXDn2CLLaEQsEsiXZXf4=;
 b=Rw4aLRniFUW/REHjpewdPOh8LEcrt3b0aril4M+P8Xx1CjhED5wqxZHJOVsbAWsJAk6xSnv2mxBcRfrs7TkGdmYxgrk8j6nWHwLK0C7FxHfAyiUh5d4qrJaHZvOn1xQFgHzX4Sxg8RRi9DmjPh+4zk2GAsLaykWVPGS8194q8JVMifpuYtla8cWNy8CmORyoQwrDxYe+ydvUqYH+t//n+ZvkuRTxGYvgx5M6DTa1QdAMo0vg5vqT2FTee4D1mEFsdWmtO1EEnsi+u8KMgTRofnVfXiVl88HBjBcVSrz6nVokHIBYiT9mmLJ+1Q1kzG+aRJtwyWGXRaiJ+cB7zViWmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VXe5QCaAxHFxzWWZctO/FtJVXDn2CLLaEQsEsiXZXf4=;
 b=opY4eERha7LXHHeRtiss/EAQRVRpnpHEM3UcTfjsA89AVbXR7MPIh+QoNtKqfHYmJ4TwCvBmwtKjgUxBQMJnodeE4sPL6Mbmjaw4qVc2B61p+TTzYe2AZC8JF2iAvg1UqVpTZ6oIPTCwyHMbpbxUCa6bQls4vDcbItWM4o18mKs=
Received: from BL0PR02CA0040.namprd02.prod.outlook.com (2603:10b6:207:3d::17)
 by DM6PR02MB3995.namprd02.prod.outlook.com (2603:10b6:5:a2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2451.27; Fri, 15 Nov
 2019 08:21:16 +0000
Received: from BL2NAM02FT052.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::208) by BL0PR02CA0040.outlook.office365.com
 (2603:10b6:207:3d::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2451.27 via Frontend
 Transport; Fri, 15 Nov 2019 08:21:16 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT052.mail.protection.outlook.com (10.152.77.0) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2451.23
 via Frontend Transport; Fri, 15 Nov 2019 08:21:16 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1iVWqx-0008JM-Um; Fri, 15 Nov 2019 00:21:15 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1iVWqs-0006rS-R8; Fri, 15 Nov 2019 00:21:10 -0800
Received: from xsj-pvapsmtp01 (mailhub.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id xAF8L51t025260;
        Fri, 15 Nov 2019 00:21:06 -0800
Received: from [172.30.17.107]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1iVWqn-0006pw-L0; Fri, 15 Nov 2019 00:21:05 -0800
Subject: Re: [PATCHv5] serial-uartlite: Remove ULITE_NR_PORTS macro
To:     Johan Hovold <johan@kernel.org>, shubhrajyoti.datta@gmail.com
Cc:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jacmet@sunsite.dk, git@xilinx.com,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>
References: <1573646408-392094-1-git-send-email-shubhrajyoti.datta@gmail.com>
 <20191113153846.GW11035@localhost>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <fbfa424b-6730-fae9-14bf-bf666e93ad28@xilinx.com>
Date:   Fri, 15 Nov 2019 09:21:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191113153846.GW11035@localhost>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(346002)(396003)(39860400002)(376002)(136003)(189003)(199004)(44832011)(316002)(36386004)(65956001)(5660300002)(486006)(76176011)(6306002)(478600001)(65806001)(31686004)(81156014)(4326008)(8676002)(31696002)(186003)(81166006)(26005)(6246003)(107886003)(23676004)(2486003)(356004)(58126008)(106002)(54906003)(9786002)(36756003)(2906002)(305945005)(50466002)(229853002)(47776003)(8936002)(966005)(426003)(70586007)(70206006)(336012)(476003)(126002)(2616005)(230700001)(446003)(11346002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB3995;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 26b1c5ac-c8d1-470f-72e4-08d769a4c927
X-MS-TrafficTypeDiagnostic: DM6PR02MB3995:
X-MS-Exchange-PUrlCount: 1
X-Microsoft-Antispam-PRVS: <DM6PR02MB39951236633F22EB560411D7C6700@DM6PR02MB3995.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 02229A4115
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iiMBQw8cWtvTeWyA+GCaUtFxfxQxRQ9msAkDTKE3UUjIREfU4tjJ6OuhJ8+X3U5omcszZOPSM9+npbvhgQGIVEfVj2ReK7LtPbooFaCt7VU5rFHfmOlhpCT7sC8tIMlOcc28CWG/1alODopBFUJi5PXEyYA81lf+/r2qjbzJOmALdx1c03NoivUHzqo0+RAzeidCYfQaVWw45sW5tqV5XEycTKC2pJVZq2HCzFD6fpkQF0EfR2a70IZoV5BLDAYWOvjVLw7FAfu6uGdHYK9iNacgJ7ofsBUUI9SJWfq0MCf2sZvn+xRL3EUluGKO3x92YfAZ8jd1s3K2nAYfB5zYXbUFJ4Z3wdVTbRyiB7hEMgK3E8nyBwm7YclZRQti5paHZy0jY1kEYQ4UQjmU7eUbC/QFgTZ33ygjfHmu3AbsKBRTyuvWNKo+dXEMVtgBblwWP8e+NGa53nO2KfdaydjEIPIFDByaGLfFGynx/GFoFi4=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2019 08:21:16.4831
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26b1c5ac-c8d1-470f-72e4-08d769a4c927
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB3995
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Johan,

On 13. 11. 19 16:38, Johan Hovold wrote:
> On Wed, Nov 13, 2019 at 12:00:08PM +0000, shubhrajyoti.datta@gmail.com wrote:
>> From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
>>
>> This patch is removing ULITE_NR_PORTS macro which limits number of
>> ports which can be used. Every instance is registering own struct
>> uart_driver with minor number which corresponds to alias ID (or 0 now).
>> and with 1 uart port. The same alias ID is saved to
>> tty_driver->name_base which is key field for creating ttyULX name.
>>
>> Because name_base and minor number are setup already there is no need to
>> setup any port->line number because 0 is the right value.
>>
>> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
>> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
>> ---
>> v4: patch addition
>> v5: Merge the patch so that all the patches compile
> 
> Greg, 
> 
> Please do not merge this. This is a hack which really needs to be
> reconsidered as I've pointed before
> 
> 	 https://lkml.kernel.org/r/20190523091839.GC568@localhost

I think it is quite a good time to start to talk about it.
Over the time I am aware about only one issue related to one way how to
handle console which came recently. I was looking at it 2 weeks before
ELCE but I need to get back on this.
Anyway I am ready for discussion about it.
What was said so far is that we shouldn't add Kconfig option for number
of uarts. We could maybe hardcode any big number in the driver as is
done for pl011 but still it is limitation and wasting of space for
allocation structures which none will use.
Then I have done this concept and it was merged where struct uart_driver
is allocated for every instance separately and I really tried to get
feedback on this as we discussed some time ago.

Anyway we are where we are and if this needs to be fixed then please
tell me how you think that this should be solved.

Thanks,
Michal


