Return-Path: <SRS0=6WdS=ZF=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3368C47414
	for <linux-serial@archiver.kernel.org>; Wed, 13 Nov 2019 16:16:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33D5D2248B
	for <linux-serial@archiver.kernel.org>; Wed, 13 Nov 2019 15:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573659521;
	bh=xiijqc6sxMdUhjGiDVt2wLp1FYdGEjXrUs2kHGurt8E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YEpEf7nHlAF0tpVmqVmCDglqOMGvWKV+oJaG/dxVWszq2EIm+rhGlbADFdy9RKW/Z
	 ejTKKfRxVANVtSh3nv0t7SoT/BpYpIf2lVyHV4Y7Nh5t4Bn7tFGXV+dha1UzHiFFRD
	 YP+rHI2pfSSfY//ry1RdTX907W8YKOGYfqBzGnIA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727963AbfKMPik (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 13 Nov 2019 10:38:40 -0500
Received: from mail-lj1-f171.google.com ([209.85.208.171]:43234 "EHLO
        mail-lj1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726335AbfKMPik (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 13 Nov 2019 10:38:40 -0500
Received: by mail-lj1-f171.google.com with SMTP id y23so3057764ljh.10
        for <linux-serial@vger.kernel.org>; Wed, 13 Nov 2019 07:38:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1kiWOxfY5UIlzRxB19J70vkuSv6tH7qGcWYRtg+UY5I=;
        b=mlz+ij+xS2D8a35PC5N9mtT+9YRuwn7aE9sbMllavJtE89AUoJM0YZrT3Y8St+ahPG
         0D1udKembqU8wIoYmdIXUPPs+9XL+RaDa6vgTsq3ggA0pxCCBogZ5411gEI6q65DbJh1
         TgLHD7yr9/HfOdLdW12dCroKeNSW/CTNk9rehc/C548S8TXsklQgpswes3+1TV22cK+Y
         iV157oXCiQ4MQ8Y3O4Mr+3s5vMXvvOX/vdMPJX48Y5i1eCSkCoZlvP2mxWES8v4Z5emg
         hYiwsWwaO9ZsTkYR5jdbpMa4wAvsvOoEbz5PYuf5XDf0BDfRyZIw0b0phfmap+VM1zVC
         O8Bw==
X-Gm-Message-State: APjAAAUd/V/f+uaSfl2hUt9hgyF/0t7g23Qo6jGR1+5ECe9YkqpCaMhO
        3yoZRXQewNlizcHVxOENnQo=
X-Google-Smtp-Source: APXvYqzWHllHeCVBPrcKmBoPM2JRT2j327XBrMle2XUMvntmDHax+Bafij3/QKkvsYKDLRxAqTHeAw==
X-Received: by 2002:a2e:b0e3:: with SMTP id h3mr2971393ljl.193.1573659518599;
        Wed, 13 Nov 2019 07:38:38 -0800 (PST)
Received: from xi.terra (c-51f1e055.07-184-6d6c6d4.bbcust.telenor.se. [85.224.241.81])
        by smtp.gmail.com with ESMTPSA id s28sm1245337lfp.92.2019.11.13.07.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2019 07:38:37 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.92.3)
        (envelope-from <johan@kernel.org>)
        id 1iUujG-0001yy-HR; Wed, 13 Nov 2019 16:38:46 +0100
Date:   Wed, 13 Nov 2019 16:38:46 +0100
From:   Johan Hovold <johan@kernel.org>
To:     shubhrajyoti.datta@gmail.com
Cc:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jacmet@sunsite.dk, git@xilinx.com,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATCHv5] serial-uartlite: Remove ULITE_NR_PORTS macro
Message-ID: <20191113153846.GW11035@localhost>
References: <1573646408-392094-1-git-send-email-shubhrajyoti.datta@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1573646408-392094-1-git-send-email-shubhrajyoti.datta@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Nov 13, 2019 at 12:00:08PM +0000, shubhrajyoti.datta@gmail.com wrote:
> From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> 
> This patch is removing ULITE_NR_PORTS macro which limits number of
> ports which can be used. Every instance is registering own struct
> uart_driver with minor number which corresponds to alias ID (or 0 now).
> and with 1 uart port. The same alias ID is saved to
> tty_driver->name_base which is key field for creating ttyULX name.
> 
> Because name_base and minor number are setup already there is no need to
> setup any port->line number because 0 is the right value.
> 
> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
> v4: patch addition
> v5: Merge the patch so that all the patches compile

Greg, 

Please do not merge this. This is a hack which really needs to be
reconsidered as I've pointed before

	 https://lkml.kernel.org/r/20190523091839.GC568@localhost

I suggest you also drop the first two patches that you applied to
tty-testing earlier today.

Shubhrajyoti, please keep on CC with these changes. I'll try to review
this again and get back to you shortly.

Johan
