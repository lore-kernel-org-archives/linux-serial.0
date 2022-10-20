Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAFBBC4332F
	for <linux-serial@archiver.kernel.org>; Thu, 20 Oct 2022 18:34:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbiJTSey (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 20 Oct 2022 14:34:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiJTSex (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 20 Oct 2022 14:34:53 -0400
Received: from first.geanix.com (first.geanix.com [116.203.34.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2216557E03
        for <linux-serial@vger.kernel.org>; Thu, 20 Oct 2022 11:34:48 -0700 (PDT)
Received: from [192.168.8.21] (85.184.138.169.dynamic.dhcp.aura-net.dk [85.184.138.169])
        by first.geanix.com (Postfix) with ESMTPSA id 3C22157A5E;
        Thu, 20 Oct 2022 18:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1666290885; bh=EdbJEZ/lE9f+qvnoiYCf4pZFsDGlERe9c2ZZVSh0OgY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=mBpSDhZ2km3OvUVr8HwdOWBBparFvXG8ZMIA0jzDJluIpwcUFkzBLzeHLSmS//yc0
         VCzyxqY4vMfL+ScXTN3JwDXEmiEn0ZJhH63ifHviAoSntx7UMWRB2LgItjOLaT+knT
         lQvq/nYLI6sPjIlj7z6KBOQ7QxpoviWcZB1bls8iFaNQJh0iLZQetxmjZyQ2NXibGu
         cZS55wFPuCz4sHV/lhsuXTtIu9YaIXE4BAUF3v3CdRQ6mbuAscEvj9H+bqG7wtSIEH
         aHw69ks6xy8bfskeNN7lvyCaOTbbEv/qVilxHE77aU25gMGJn2Fi5/ocWCjKxt9SnU
         u8DlojQE6cKZw==
Message-ID: <6206447f-83c2-cf81-3a10-73f7e7c54ef6@geanix.com>
Date:   Thu, 20 Oct 2022 20:34:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v2 1/3] serial: 8250: allow use of non-runtime configured
 uart ports
Content-Language: en-US-large
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-serial <linux-serial@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20221018133419.134110-1-martin@geanix.com>
 <7baa90-e168-4bbe-5ce1-12c7de2ee04e@linux.intel.com>
 <0B4E8D8F-8E89-4951-9B5C-AFDF6667A1CC@geanix.com>
 <4ecaa152-3fdc-be46-61a3-b026f4b36a61@linux.intel.com>
From:   =?UTF-8?Q?Martin_Hundeb=c3=b8ll?= <martin@geanix.com>
In-Reply-To: <4ecaa152-3fdc-be46-61a3-b026f4b36a61@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org



On 20/10/2022 16.14, Ilpo Järvinen wrote:
> On Thu, 20 Oct 2022, Martin Hundebøll wrote:
> 
>>
>>
>> On October 20, 2022 2:34:14 PM GMT+02:00, "Ilpo Järvinen" <ilpo.jarvinen@linux.intel.com> wrote:
>>> On Tue, 18 Oct 2022, Martin Hundebøll wrote:
>>>
>>>> The logic to find unused ports when registering new 8250 uart ports
>>>> searches only up to CONFIG_SERIAL_8250_RUNTIME_UART, which forces users
>>>> of external 8250 ports to increase the number of runtime ports
>>>> artificially.
>>>>
>>>> Fix this by initializing each allocated port structure with basic
>>>> settings like line number and uart operation callbacks, and by searching
>>>> the entire array of allocated ports to find an unused one.
>>>
>>> So nr_uarts no longer means "Maximum number of UARTs supported." ?
>>> Perhaps it should be reworded too.
>>>
>>
>> It never did. Confusingly, the module parameter name (nr_uarts)
>> corresponds to CONFIG_SERIAL_8250_RUNTIME_UARTS, and controls the number
>> of built-in (non-discoverable) ports. The other config,
>> CONFIG_SERIAL_8250_NR_UARTS, controls the maximum number of ports.
>>
>> We cannot change the module parameter name, so I'm not sure if we should
>> map it to another static variable in the source?
> 
> I meant that its description should be changed to match what it really
> does.

I see. Something like this?

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index f4a08fb74c31..cdac8f11194e 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -1261,7 +1261,7 @@ module_param_hw(share_irqs, uint, other, 0644);
  MODULE_PARM_DESC(share_irqs, "Share IRQs with other non-8250/16x50 devices (unsafe)");
  
  module_param(nr_uarts, uint, 0644);
-MODULE_PARM_DESC(nr_uarts, "Maximum number of UARTs supported. (1-" __MODULE_STRING(CONFIG_SERIAL_8250_NR_UARTS) ")");
+MODULE_PARM_DESC(nr_uarts, "Number of built-in (non-discoverable) UARTs to initialize. (1-" __MODULE_STRING(CONFIG_SERIAL_8250_NR_UARTS) ")");
  
  module_param(skip_txen_test, uint, 0644);
  MODULE_PARM_DESC(skip_txen_test, "Skip checking for the TXEN bug at init time");
