Return-Path: <SRS0=071p=2J=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E2AAC43603
	for <linux-serial@archiver.kernel.org>; Thu, 19 Dec 2019 18:27:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 324AC24672
	for <linux-serial@archiver.kernel.org>; Thu, 19 Dec 2019 18:27:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="FLN6U0S/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbfLSS1w (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 19 Dec 2019 13:27:52 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54112 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726797AbfLSS1w (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 19 Dec 2019 13:27:52 -0500
Received: by mail-wm1-f66.google.com with SMTP id m24so6443545wmc.3
        for <linux-serial@vger.kernel.org>; Thu, 19 Dec 2019 10:27:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vcsq0pWA7X2zt/TboCLLWyP0ijGUk8xWBFv5EqjtRoY=;
        b=FLN6U0S/sBosA5Pby3t2zQQcnJRC2/CSl/nxKlhSs7O5GJIM1CSlA2SsMFB08Ygje8
         HJC4KUt5bcGF9myQRde+dmIhQbqdQmB3cF7EKIFbyBHMPk3yyXIyUy3BH0R9npAk6SIB
         QM9VTgzUAfgPVg0cOcrMv6FZ23siOOdg8Lc9LqfsZsoNCPJTQp7e/lKFmVpRmOB5PrMk
         ehWu/nDDow2Ibn+QQ1j82C2TUMTQJ/Kiqf70ta4z/ip1+K+nTV9aVfBlsth76Nimm2hz
         RBVHYIDLbPYQH2vJA3MZ9go9dbx9p2htsMSeXa11ZeAniq5g4FLw9m8KHX3XFsJ8Nxp0
         RNtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vcsq0pWA7X2zt/TboCLLWyP0ijGUk8xWBFv5EqjtRoY=;
        b=GQx4iT6VQPKGMJj6SAINIPz9fRPGdiyFKk6aBUB/wjNvQ2NYwMQJ01O9MWfw+f2YW6
         WzUumuxPphWCu0H6bwFNL93vEz5O+mKeaCZ5pG9CmpQskJmtL1PV4a6BE138gR93U9cE
         2Bygwl7Spqk9hq7D7KfwqP9Wnz6nqvrAfURXMTQtTFXZhDVEYL/2knZGAso8EGdnST+l
         VnTnbDTW7xhuhf6es2hKsNoqX8i3WKMxqddPsVTP012jpMQezicZd8I80hOUrfJbYbd5
         8iiJhpv0lrL5De9dgsL+dQxCdmujAAVulBXiWa2CKOBiU09iiGMxbiQMtGGlCbvKf5nw
         MZVg==
X-Gm-Message-State: APjAAAWPuFbzl8PxbgEfExXtRiKKaRPxeadcMTuk0XPnKpqrJxyKQTic
        s19pAJBxXRf8aRxwhgr0c1gZoDureGw=
X-Google-Smtp-Source: APXvYqyrvtcoRdL371Y6Npc6xJ20fyoh0H+EOa6gaEuxTGnh4SfLsHbltSq3XXWwt9A5aOg+zeE1YA==
X-Received: by 2002:a05:600c:145:: with SMTP id w5mr12387149wmm.157.1576780070055;
        Thu, 19 Dec 2019 10:27:50 -0800 (PST)
Received: from [10.83.36.153] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id z3sm7069703wrs.94.2019.12.19.10.27.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Dec 2019 10:27:49 -0800 (PST)
Subject: Re: [tty:tty-testing 23/75] drivers/tty/serial/21285.c:44:41: error:
 subscripted value is neither array nor pointer nor vector
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-serial@vger.kernel.org
References: <201912191529.6kIYPFPw%lkp@intel.com>
 <20191219073416.GA961893@kroah.com>
From:   Dmitry Safonov <dima@arista.com>
Message-ID: <833de605-ecd0-34e2-c2e7-5327ab04ca98@arista.com>
Date:   Thu, 19 Dec 2019 18:27:47 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191219073416.GA961893@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 12/19/19 7:34 AM, Greg Kroah-Hartman wrote:
> On Thu, Dec 19, 2019 at 03:24:01PM +0800, kbuild test robot wrote:
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
>> head:   82cfd2e62b354840af6a045e084f6e9e7c49584d
>> commit: 1997e9dfdc84c8f73d6fc318355cf9e313aba183 [23/75] serial_core: Un-ifdef sysrq SUPPORT_SYSRQ
>> config: arm-randconfig-a001-20191219 (attached as .config)
>> compiler: arm-linux-gnueabi-gcc (GCC) 7.5.0
>> reproduce:
>>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>         chmod +x ~/bin/make.cross
>>         git checkout 1997e9dfdc84c8f73d6fc318355cf9e313aba183
>>         # save the attached .config to linux build tree
>>         GCC_VERSION=7.5.0 make.cross ARCH=arm 
>>
>> If you fix the issue, kindly add following tag
>> Reported-by: kbuild test robot <lkp@intel.com>
>>
>> All error/warnings (new ones prefixed by >>):
>>
>>    In file included from include/linux/kernel.h:11:0,
>>                     from include/linux/list.h:9,
>>                     from include/linux/module.h:12,
>>                     from drivers/tty/serial/21285.c:7:
>>    drivers/tty/serial/21285.c: In function 'serial21285_stop_tx':
>>>> drivers/tty/serial/21285.c:44:41: error: subscripted value is neither array nor pointer nor vector
>>     #define tx_enabled(port) ((port)->unused[0])
>>                                             ^
> 
> Ugh, this driver did the same hack the samsung_tty driver did!  That's
> where samsung got the idea.
> 
> I'll go fix this up as well...

Sorry that you had to clean that up - I should have checked that, rather
than blindly believe that if something is called "unused" it's actually
unused.

Thanks again,
          Dmitry
