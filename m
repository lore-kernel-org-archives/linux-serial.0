Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34FB7C47096
	for <linux-serial@archiver.kernel.org>; Thu,  3 Jun 2021 08:59:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1095B6138C
	for <linux-serial@archiver.kernel.org>; Thu,  3 Jun 2021 08:59:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbhFCJBJ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 3 Jun 2021 05:01:09 -0400
Received: from mleia.com ([178.79.152.223]:43340 "EHLO mail.mleia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229486AbhFCJBJ (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 3 Jun 2021 05:01:09 -0400
Received: from mail.mleia.com (localhost [127.0.0.1])
        by mail.mleia.com (Postfix) with ESMTP id 1C96771A8;
        Thu,  3 Jun 2021 08:59:24 +0000 (UTC)
Subject: Re: Need suggestion for 'access_type' of AMBA pl011 serial driver
To:     Raviteja Narayanam <rna@xilinx.com>
Cc:     "jslaby@suse.com" <jslaby@suse.com>,
        Michal Simek <michals@xilinx.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        git <git@xilinx.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>
References: <SN6PR02MB40936F8F2879AD5CFDFC80D2CA3C9@SN6PR02MB4093.namprd02.prod.outlook.com>
From:   Vladimir Zapolskiy <vz@mleia.com>
Message-ID: <2b602d2f-db48-515c-2904-7b84b31928ce@mleia.com>
Date:   Thu, 3 Jun 2021 11:59:19 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <SN6PR02MB40936F8F2879AD5CFDFC80D2CA3C9@SN6PR02MB4093.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-49551924 
X-CRM114-CacheID: sfid-20210603_085924_139076_8213E3E5 
X-CRM114-Status: GOOD (  13.51  )
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hello Raviteja,

On 6/3/21 10:03 AM, Raviteja Narayanam wrote:
> Hi,
> 
> The uart peripheral on Xilinx Versal platform is ARM primecell. Our
> environment is 32-bit access type but the ARM primecell uart in pl011
> driver has default 16 bit access type. 
> (https://github.com/torvalds/linux/blob/master/drivers/tty/serial/amba-pl011.c#L2665
> access_32b is false for 'vendor_arm') This is causing asynchronous
> abort on our platform when any UART register is written from the
> pl011 driver.
> 
> Need suggestion on how we can address this issue and if the below
> approach is fine.

Check drivers/tty/serial/amba-pl011.c code, there are quite many
controllers with 32-bit access, for instance ZTE UART and SBSA UART.

In other words this case is already well covered in the code, nothing
extraordinary is required or have to be invented here.

> As this is platform specific issue, we can have a new device tree
> property (memory_access_type), specifying the 32 bit type. In the
> probe function, override the behavior (uap->port.iotype) if this
> property is present in DT. In this way, we can have support for our
> SOC, without breaking any legacy ones.

No, there is totally no need for this kind of a device tree property.

Instead please introduce a new compatible of your controller, just
like it's been done for the SBSA UART controller:

   compatible = "arm,sbsa-uart", "arm,pl011", "arm,primecell";

Then based on a match against your new compatible select a proper
configuration of the device driver, as I've said above similar cases
are already found in the code.

--
Best wishes,
Vladimir
