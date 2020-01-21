Return-Path: <SRS0=m7Km=3K=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CE79C2D0CE
	for <linux-serial@archiver.kernel.org>; Tue, 21 Jan 2020 15:46:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E2E422314
	for <linux-serial@archiver.kernel.org>; Tue, 21 Jan 2020 15:46:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="he4bJsl5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729165AbgAUPq3 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 21 Jan 2020 10:46:29 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:1511 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729121AbgAUPq2 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 21 Jan 2020 10:46:28 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e271cc50001>; Tue, 21 Jan 2020 07:46:13 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 21 Jan 2020 07:46:27 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 21 Jan 2020 07:46:27 -0800
Received: from [10.21.133.51] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 21 Jan
 2020 15:46:24 +0000
Subject: Re: [PATCH] serial: 8250_tegra: Create Tegra specific 8250 driver
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Jiri Slaby <jslaby@suse.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, Jeff Brasen <jbrasen@nvidia.com>
References: <20200120160149.29072-1-jonathanh@nvidia.com>
 <20200121154102.GA588392@kroah.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <398367ec-be5b-417f-ce31-bfbe7c17c139@nvidia.com>
Date:   Tue, 21 Jan 2020 15:46:22 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200121154102.GA588392@kroah.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1579621573; bh=xQc1yW+0hwVpxw6u5G9+5S5OnHKxE1E8Y0k/M6DCpvE=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=he4bJsl54h7R2eIQhBSYgYCbmS2kgneqB+75CJg9ipC1AegZ2LwXqoyC2vEShGkJ0
         n9iWPJzsVQpbVI2zABca4/R0cC9rq0KOnOguVEG+iO9hsHg1P8OJDEZc84dvyfw+bq
         AHyjWy3Ed+yiNdKsojT4iYbPeYNw/fHTnbY2+XkV/q59uiPo9FdZfJjbVqMcrcEk/J
         YKRXBszpXSoGZINsW2TW2xSRfaLLWDqnyfaRUwvuoEHpInS8xlr2JgFELWgRORVzID
         OOMhhNN1A6kLOfC+LWFck3GxTFbAjcNDxcV4/l9JhfQU3KklWCMxTykTDgg6gYFDqQ
         G2tD7Gy35kaAw==
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


On 21/01/2020 15:41, Greg Kroah-Hartman wrote:
> On Mon, Jan 20, 2020 at 04:01:49PM +0000, Jon Hunter wrote:
>> diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
>> index f16824bbb573..432b47647677 100644
>> --- a/drivers/tty/serial/8250/Kconfig
>> +++ b/drivers/tty/serial/8250/Kconfig
>> @@ -500,6 +500,15 @@ config SERIAL_8250_PXA
>>  	  applicable to both devicetree and legacy boards, and early console is
>>  	  part of its support.
>>  
>> +config SERIAL_8250_TEGRA
>> +	tristate "8250 support for Tegra serial ports"
>> +	default SERIAL_8250
>> +	depends on SERIAL_8250
>> +	depends on ARCH_TEGRA
> 
> No COMPILE_TEST support so we can make sure we don't break the thing
> somehow?

Good point. Will add.

Thanks
Jon

-- 
nvpublic
