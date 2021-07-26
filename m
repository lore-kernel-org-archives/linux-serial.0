Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE74FC4320A
	for <linux-serial@archiver.kernel.org>; Mon, 26 Jul 2021 14:19:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8F50608FB
	for <linux-serial@archiver.kernel.org>; Mon, 26 Jul 2021 14:19:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233408AbhGZNj1 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 26 Jul 2021 09:39:27 -0400
Received: from mail-dm6nam10on2057.outbound.protection.outlook.com ([40.107.93.57]:14017
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233206AbhGZNj0 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 26 Jul 2021 09:39:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jEfsJub4iw2ienZC9jQ294C6CmHnzcs2wiGa+7vRWTIkgXud4qtz6sPmZ1eAVrwRuusBIm3m8L9bDcqx2wGp0sXYgBOs7QU4jxHhrgzT+OEBrItiZfPmMI+wwMBGeHiJvq8pnTuptG74DmINWzG520tJN4Io11Qf7Wtwl3tAMC9JC0DSJx2EyBQ3gNejudU5e3uMEaYJCgiA+o4CIkWSpyv1dUiFQE2PAx25DCPUYj3zkO7lHxLUtkdnU0iTdPSqJ/HegF0OtcEQhLNDDTmKlrojDGt45Ow+KT4eJRi9CK83E6uHajQ72WPCGkqMnfLDpuTIdY0jL47tZHqc3sh7Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NDjKhKOPJst+rj5i1L/dYbB0fYqxjDGNmUGSStsB9C0=;
 b=a0draFQqYqNDH2Kff9ylsL802gw/p3wr6MdSA3Z6kM/A2WxgX6rMD53dUidpGAhtdaT4onHEfW6aWMJE6wEeOI5Z3wH7ovZaI4z8Ei2QfXRoV55qUWMYSqHKCktSn7e8pWzadsSPck5rZzeOmALzs310GC+37IfwDwQ07rkbyW+SvizEC9kFzN1v2ogbNu+KcOTfK2ZB76SqxRpLGIhX2ARRB5ntXDw8scehPcyj/VKsnFCkHi2ABDUxWk8manIXU7bhtQDh0zgoaUwjYVQ+UQewRXdpO8tAinNf+hSjd9131ihMsnTDyhNBP8E57kr12dsuPh3GsWmNfWelyCJ02Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NDjKhKOPJst+rj5i1L/dYbB0fYqxjDGNmUGSStsB9C0=;
 b=XkcKE8G6Kynmf8bnNwZGEDIBUgj2O/2j60J0hJQFJlWKNN91FXaMmOHYYwjiLDXXdQmGtP48geyrfZ5U3sqzDce85RI3xRCb/V/hVK4OtBZHhvULORjb4IWJ1vO/9T5q6jJdL1LZ7qXGrub4WPjSz9nGd+jdTHK2eYXaMDQFhdY=
Received: from DM6PR02CA0072.namprd02.prod.outlook.com (2603:10b6:5:177::49)
 by CO1PR02MB8380.namprd02.prod.outlook.com (2603:10b6:303:153::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.26; Mon, 26 Jul
 2021 14:19:54 +0000
Received: from DM3NAM02FT019.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:177:cafe::82) by DM6PR02CA0072.outlook.office365.com
 (2603:10b6:5:177::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.26 via Frontend
 Transport; Mon, 26 Jul 2021 14:19:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT019.mail.protection.outlook.com (10.13.4.191) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4352.24 via Frontend Transport; Mon, 26 Jul 2021 14:19:53 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 26 Jul 2021 07:19:53 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Mon, 26 Jul 2021 07:19:52 -0700
Envelope-to: devicetree@vger.kernel.org,
 ysato@users.sourceforge.jp,
 robh@kernel.org,
 dalias@libc.org,
 alexander.sverdlin@nokia.com,
 gregkh@linuxfoundation.org,
 linux-serial@vger.kernel.org,
 peter@korsgaard.com,
 peter.korsgaard@barco.com,
 sean.anderson@seco.com
Received: from [172.30.17.109] (port=59096)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1m81SS-0000bp-Nw; Mon, 26 Jul 2021 07:19:52 -0700
Subject: Re: [PATCH 0/5] tty: serial: uartlite: Disable changing fixed
 parameters
To:     Sean Anderson <sean.anderson@seco.com>,
        Peter Korsgaard <peter.korsgaard@barco.com>,
        Peter Korsgaard <peter@korsgaard.com>,
        <linux-serial@vger.kernel.org>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Rich Felker <dalias@libc.org>, Rob Herring <robh@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        <devicetree@vger.kernel.org>
References: <20210723223152.648326-1-sean.anderson@seco.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <d2570d88-9f2a-2589-d264-1bdb2b2744a5@xilinx.com>
Date:   Mon, 26 Jul 2021 16:19:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210723223152.648326-1-sean.anderson@seco.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dd8aa420-cbb5-4f79-b76d-08d950406fec
X-MS-TrafficTypeDiagnostic: CO1PR02MB8380:
X-Microsoft-Antispam-PRVS: <CO1PR02MB83809F986536DE2C6208D3B8C6E89@CO1PR02MB8380.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J4xkcXLdJLeTQ4Y0Y9u3q9Rw/BRta9zRZZmSZ5MrW4aKU8tnGIm8NXjXqvX/RRdXxCnmp+X6P6ZqVGuWhekjsWFS0d2XEbANzEobAZSJQ3vm2VRx+otSBcbEbYmhAPNnRVZi3pg/+xExbtwkPIkwhhfSQ5brjwNNOU+MqyNC3BLmiW1f0y4a0n8vyC2xrYH2qaKRgZIjFkVvgFtxjc6pSxyXoWRtmxMqRY2aN3C+6leN7Nn4tEZofwu45Q5wUlqN1Z5V7MLPSYzbvmiob85zu9oH2UkiecWQoho0jdFvdU8OlMU1LLCq+7DDNA18VzGps1lrCZMKzIhvkpOAb4OK0XjQccICXDVsRe9p9pve+JMaLIM1Vkr4Ys1vRd/gglBZpvGoLVMp4oGjCuXj/837WFKWME1YVrmBs6OdnMVLo3PIOpYaD7K5W3G9l3nVeo4E7xhiFx0oELF2QuKxYrZaggMxyPU3p3Jic75GjQK3e83RMbFjzeuicdHlq2TK7BAwCN/HxNVeErl09bJewbKgL8rTJVN82+tcYI+pbWs6OwIbI4BK0RvZF8iemMl8LDuWojQN0JNy4qX/HutElIrKauur8LSFOOwzPbpUx0KAgjwhpfrRAgB/PlSJZ21xmiHaTtJQjWyNStrW3gXsQJ6ED5zRVXP76p6+Tz741ZEHpUFuvXnekaiuq+zcF/5Hsu9180/a7EygzB1f2PIN/0c7wm2yc8yxLYyYxDbr7I0K2dDdR3jBiu2BCEsmkYNDcV4TOvs5wetr0uwQOBdGyUzCnQ==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(136003)(396003)(39860400002)(346002)(376002)(46966006)(36840700001)(7636003)(356005)(36860700001)(336012)(6666004)(83380400001)(47076005)(26005)(31686004)(44832011)(53546011)(5660300002)(186003)(2906002)(82310400003)(31696002)(6636002)(8676002)(82740400003)(4326008)(9786002)(110136005)(54906003)(36756003)(426003)(70206006)(478600001)(70586007)(8936002)(7416002)(36906005)(316002)(2616005)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2021 14:19:53.4659
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd8aa420-cbb5-4f79-b76d-08d950406fec
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT019.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR02MB8380
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

+Shubhrajyoti

On 7/24/21 12:31 AM, Sean Anderson wrote:
> The uartlite device is a "soft" device and certain parameters (such as
> data bits, parity, and baud) are configured at synthesis time, and
> cannot be discovered at runtime. Fortunately, bindings for this device
> typically include some of these parameters (especially baud rate).
> Instead of silently letting Linux's termios drift away from what the
> hardware is actually doing, make the termios reflect the hardware, and
> prevent them from being changed. With this series applied, the user
> recieves an error message the first time they try and change these
> termios:
> 
>     # stty parity
>     [    7.221696] uartlite 84000000.serial: only 'n' parity supported
>     [    7.222139] uartlite 84000000.serial: only 8 data bits supported
>     stty: standard input: cannot perform all requested operations
> 
> In addition, the configured baud/parity/bits/etc. are exposed through
> the standard termios ioctls, instead of using the default termios for
> unconfigured ttys.
> 
> 
> Sean Anderson (5):
>   dt-bindings: serial: uartlite: Convert to json-schema
>   dt-bindings: serial: uartlite: Add properties for synthesis-time
>     parameters
>   sh: j2: Update uartlite binding with data and parity properties
>   tty: serial: uartlite: Initialize termios with fixed synthesis
>     parameters
>   tty: serial: uartlite: Prevent changing fixed parameters
> 
>  .../bindings/serial/xlnx,opb-uartlite.txt     |  23 ----
>  .../bindings/serial/xlnx,opb-uartlite.yaml    |  92 ++++++++++++++
>  arch/sh/boot/dts/j2_mimas_v2.dts              |   2 +
>  drivers/tty/serial/uartlite.c                 | 118 ++++++++++++++++--
>  4 files changed, 203 insertions(+), 32 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/serial/xlnx,opb-uartlite.txt
>  create mode 100644 Documentation/devicetree/bindings/serial/xlnx,opb-uartlite.yaml
> 
