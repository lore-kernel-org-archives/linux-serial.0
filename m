Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 582BEC7EE2C
	for <linux-serial@archiver.kernel.org>; Thu, 24 Aug 2023 19:39:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232010AbjHXTil (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 24 Aug 2023 15:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243367AbjHXTiU (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 24 Aug 2023 15:38:20 -0400
Received: from zproxy1.foxvalley.net (zimbra.foxvalley.net [212.78.26.134])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id ABF111FD7
        for <linux-serial@vger.kernel.org>; Thu, 24 Aug 2023 12:38:14 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zproxy1.foxvalley.net (Postfix) with ESMTP id 1DF0740EE9;
        Thu, 24 Aug 2023 14:38:14 -0500 (CDT)
Received: from zproxy1.foxvalley.net ([127.0.0.1])
 by localhost (zproxy1.foxvalley.net [127.0.0.1]) (amavis, port 10032)
 with ESMTP id FbtAiz-2e5dm; Thu, 24 Aug 2023 14:38:13 -0500 (CDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zproxy1.foxvalley.net (Postfix) with ESMTP id A598940F27;
        Thu, 24 Aug 2023 14:38:13 -0500 (CDT)
X-Virus-Scanned: amavis at zproxy1.foxvalley.net
Received: from zproxy1.foxvalley.net ([127.0.0.1])
 by localhost (zproxy1.foxvalley.net [127.0.0.1]) (amavis, port 10026)
 with ESMTP id bryJAPB_dbCg; Thu, 24 Aug 2023 14:38:13 -0500 (CDT)
Received: from [192.168.1.3] (unknown [161.97.241.227])
        by zproxy1.foxvalley.net (Postfix) with ESMTPSA id 7928B40EE9;
        Thu, 24 Aug 2023 14:38:13 -0500 (CDT)
Message-ID: <b8aba427-295d-9532-451f-0b260925b0d9@foxvalley.net>
Date:   Thu, 24 Aug 2023 13:38:11 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] tty/serial: create debugfs interface for UART register
 tracing
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
References: <d00f1510-dd83-6fc1-f5e4-dc194b06aabc@foxvalley.net>
 <2023082435-swaddling-aloe-0077@gregkh>
From:   Dan Raymond <draymond@foxvalley.net>
In-Reply-To: <2023082435-swaddling-aloe-0077@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 8/24/2023 1:01 AM, Greg KH wrote:

> Your patch is somehow whitespace damaged with tabs stripped out and
> line-wrapped :(
> 
> And you forgot to document what changed, here's what my bot says:
> 
> 
> - Your patch is malformed (tabs converted to spaces, linewrapped, etc.)
>   and can not be applied.  Please read the file,
>   Documentation/process/email-clients.rst in order to fix this.
> 
> - This looks like a new version of a previously submitted patch, but you
>   did not list below the --- line any changes from the previous version.
>   Please read the section entitled "The canonical patch format" in the
>   kernel file, Documentation/process/submitting-patches.rst for what
>   needs to be done here to properly describe this.

Sorry about that.  I'll submit another (v3) patch and fix these problems.
