Return-Path: <SRS0=tlDI=6U=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47F69C47256
	for <linux-serial@archiver.kernel.org>; Wed,  6 May 2020 04:50:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27BD0206F9
	for <linux-serial@archiver.kernel.org>; Wed,  6 May 2020 04:50:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725862AbgEFEuB (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 6 May 2020 00:50:01 -0400
Received: from mga14.intel.com ([192.55.52.115]:6958 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725824AbgEFEuB (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 6 May 2020 00:50:01 -0400
IronPort-SDR: lQvoyz6/dMNd3c7VwliJIrBA19aIgG8XBOI9n5rpAPH93k7tz0ysL35B5/hngjNcdksG2XR0bb
 4Or9Os78d4TQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2020 21:49:59 -0700
IronPort-SDR: eK/QP5LYGQoMkJEtBPf/KZ045KB1pglMGxS4TWondVqVPK4sw2Iky+msWBbRjRJu0FWGWBQTDv
 DI+FLtLJ+BuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,357,1583222400"; 
   d="scan'208";a="304688353"
Received: from linux.intel.com ([10.54.29.200])
  by FMSMGA003.fm.intel.com with ESMTP; 05 May 2020 21:49:59 -0700
Received: from [10.215.165.195] (rtanwar-mobl.gar.corp.intel.com [10.215.165.195])
        by linux.intel.com (Postfix) with ESMTP id 67C45580609;
        Tue,  5 May 2020 21:49:58 -0700 (PDT)
Subject: Re: [PATCH] serial: lantiq: Add x86 in Kconfig dependencies for
 Lantiq serial driver
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        andriy.shevchenko@intel.com
References: <96fd193c0a8939d27641ff93573545c02313048f.1588577002.git.rahul.tanwar@linux.intel.com>
 <20200505142504.GA832370@kroah.com>
From:   "Tanwar, Rahul" <rahul.tanwar@linux.intel.com>
Message-ID: <3aa4aac0-a9d2-5ab2-e9c9-c7f3bd16da96@linux.intel.com>
Date:   Wed, 6 May 2020 12:49:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200505142504.GA832370@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


On 5/5/2020 10:25 pm, Greg KH wrote:
> On Mon, May 04, 2020 at 04:03:52PM +0800, Rahul Tanwar wrote:
>> Lantiq serial driver/IP is reused for a x86 based SoC as well.
>> Update the Kconfig accordingly.
>>
>> Signed-off-by: Rahul Tanwar <rahul.tanwar@linux.intel.com>
>> ---
>>  drivers/tty/serial/Kconfig | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
>> index 0aea76cd67ff..4b0a7b98f8c7 100644
>> --- a/drivers/tty/serial/Kconfig
>> +++ b/drivers/tty/serial/Kconfig
>> @@ -1035,7 +1035,7 @@ config SERIAL_SIFIVE_CONSOLE
>>  
>>  config SERIAL_LANTIQ
>>  	bool "Lantiq serial driver"
>> -	depends on LANTIQ
>> +	depends on (LANTIQ || X86) || COMPILE_TEST
>>  	select SERIAL_CORE
>>  	select SERIAL_CORE_CONSOLE
>>  	select SERIAL_EARLYCON
>> -- 
>> 2.11.0
>>
> Any reason this can't also be a module?

Thanks a lot for accepting the patch. This driver is also used for
console during bootup so we always have it as built in.

Regards,
Rahul

> thanks,
>
> greg k-h

