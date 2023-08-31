Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AF19C83F37
	for <linux-serial@archiver.kernel.org>; Thu, 31 Aug 2023 18:33:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233343AbjHaSdn (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 31 Aug 2023 14:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347088AbjHaSdm (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 31 Aug 2023 14:33:42 -0400
Received: from zproxy1.foxvalley.net (zimbra.foxvalley.net [212.78.26.134])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id E5976E72
        for <linux-serial@vger.kernel.org>; Thu, 31 Aug 2023 11:33:36 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zproxy1.foxvalley.net (Postfix) with ESMTP id 3CFB440EFB;
        Thu, 31 Aug 2023 13:33:36 -0500 (CDT)
Received: from zproxy1.foxvalley.net ([127.0.0.1])
 by localhost (zproxy1.foxvalley.net [127.0.0.1]) (amavis, port 10032)
 with ESMTP id cNXTA1Emtog0; Thu, 31 Aug 2023 13:33:34 -0500 (CDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zproxy1.foxvalley.net (Postfix) with ESMTP id CD28240FBC;
        Thu, 31 Aug 2023 13:33:34 -0500 (CDT)
X-Virus-Scanned: amavis at zproxy1.foxvalley.net
Received: from zproxy1.foxvalley.net ([127.0.0.1])
 by localhost (zproxy1.foxvalley.net [127.0.0.1]) (amavis, port 10026)
 with ESMTP id DHFq47AltzQd; Thu, 31 Aug 2023 13:33:34 -0500 (CDT)
Received: from [192.168.1.3] (unknown [161.97.241.227])
        by zproxy1.foxvalley.net (Postfix) with ESMTPSA id 9080E40EFB;
        Thu, 31 Aug 2023 13:33:34 -0500 (CDT)
Message-ID: <af06008a-f4d4-1c30-294a-b7af2d4cbc86@foxvalley.net>
Date:   Thu, 31 Aug 2023 12:33:33 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v3] tty/serial: create debugfs interface for UART register
 tracing
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        ilpo.jarvinen@linux.intel.com
References: <eb8a598c-414e-aecf-e903-e2c01db1979a@foxvalley.net>
 <ZPDXHy6L7nTRx63l@smile.fi.intel.com>
From:   Dan Raymond <draymond@foxvalley.net>
In-Reply-To: <ZPDXHy6L7nTRx63l@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 8/31/2023 12:08 PM, Andy Shevchenko wrote:
> Warning: This email is from an unusual correspondent.
> Warning: Make sure this is someone you trust.
> 
> On Thu, Aug 24, 2023 at 02:59:01PM -0600, Dan Raymond wrote:
>> Implement a UART register tracing facility using the debugfs.  This can be
>> used as a "serial port sniffer" to monitor UART traffic and line settings
>> with timestamps at microsecond granularity.  This can be useful for general
>> serial port debugging or to debug the UART driver itself.
> 
>>  drivers/tty/serial/8250/8250_debug.c | 530 +++++++++++++++++++++++++++
> 
> My gosh. Why trace points and trace events can't be used for that?
> 

I don't understand your post.  Are you saying there is already a way to
trace UART register reads/writes without this patch?  Can you elaborate?
