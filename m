Return-Path: <SRS0=VMdU=AA=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86BA7C433E0
	for <linux-serial@archiver.kernel.org>; Fri, 19 Jun 2020 17:25:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 600DD208D5
	for <linux-serial@archiver.kernel.org>; Fri, 19 Jun 2020 17:25:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="APfopFZR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731286AbgFSRZY (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 19 Jun 2020 13:25:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731175AbgFSRZX (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 19 Jun 2020 13:25:23 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2D3AC06174E;
        Fri, 19 Jun 2020 10:25:22 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id u8so4323723pje.4;
        Fri, 19 Jun 2020 10:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OIGAZSabrhFgy3X+4oVeL5X78+6UeCl/BmE8pXuAxYE=;
        b=APfopFZRKxDNenAFDX8N8y2gNRPGw63S9Fo/wxCush+BUzDCx1IsYOrIsmlnqJWvJf
         6PffcoyW55FLPoI1OHOTtVUBhFyOM1a1W560fFXsqOBMKt6tw7TNy4p/icfX3+N0AUcX
         7r7VMuiH274BHevz78l03bSfVMo+1EboLjY/ijqHAWgoQqF8mjvVgmjDugT9aURnz0A5
         WD0NvDsoiuhN9U6jK6xcmhRiVwlAvurpkxUADyLJrHaY/IolKPkjVBgmYICQqqHG6Udq
         Gso4xXl+fyOm7goGcaLhQSXw1NVVbAsOuw+FaL5jc+ABVZ1A18xMC8vJ5u8E/3g/Mj7Q
         0pBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OIGAZSabrhFgy3X+4oVeL5X78+6UeCl/BmE8pXuAxYE=;
        b=SKBO9uMifl55JJ9SWconDXRP6A95Voh/D7x3a3Nsj8YN/BEDr5yQ16VyNjYtdomQv+
         vCU+2fRqDzs3X7FXKojxYZQpC3JCwnYhdQbm/igIBlWzFngWCTpDRoy57WtXs9DKk9NM
         fyvcZJMMZgqQnBqKXFxTPUP9ReV8kBJRlVSC7TBuZ7Ic2h7lLDniHpMuoOGGZfnzE49h
         1sAWL37xoHy8k6LyFNZKB6qzxwcJsRyhitzXBTWOx+1oVm28Zu0gsVOhL47eCKb2wQGI
         DZb9zpDQeqkPZ8nop3U0ELO4JCIlnL2MwJoxHPAQQ+wza/XFVNbVx3sLg8t+EVH3Ib1g
         cGbA==
X-Gm-Message-State: AOAM532b7klLByyaqkD3irSVHIHpbUtgPIMFAv6Og5mt+9B1NWZU/L7F
        RxPljbRBAieoruexbqZDHz8=
X-Google-Smtp-Source: ABdhPJxM2HsJThgQl1f7W+yXmwyvSlEtgzAVT2RQk+OmiyMzQieee/yq9elAEyvDireL8vfQwQ77uw==
X-Received: by 2002:a17:902:7288:: with SMTP id d8mr9332975pll.18.1592587522468;
        Fri, 19 Jun 2020 10:25:22 -0700 (PDT)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id m16sm6319376pfh.187.2020.06.19.10.25.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2020 10:25:21 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Sat, 20 Jun 2020 02:25:19 +0900
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org
Subject: Re: [PATCH v1 0/6] console: unify return codes from ->setup() hook
Message-ID: <20200619172519.GC310968@jagdpanzerIV.localdomain>
References: <20200618164751.56828-1-andriy.shevchenko@linux.intel.com>
 <20200619093917.GK3617@alley>
 <20200619094726.GD2428291@smile.fi.intel.com>
 <20200619102132.GB310968@jagdpanzerIV.localdomain>
 <20200619112638.GL3617@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200619112638.GL3617@alley>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On (20/06/19 13:26), Petr Mladek wrote:
> On Fri 2020-06-19 19:21:32, Sergey Senozhatsky wrote:
> > On (20/06/19 12:47), Andy Shevchenko wrote:
> > > On Fri, Jun 19, 2020 at 11:39:18AM +0200, Petr Mladek wrote:
> > > > On Thu 2020-06-18 19:47:45, Andy Shevchenko wrote:
> > [..]
> > > > I am going to push it the following week via printk tree unless
> > > > anybody complains.
> > > 
> > > Thanks, Petr, I guess you may also incorporate Sergey's patch
> > > he proposed. Sergey, are you going to submit it officially?
> > 
> > I can send a patch, unless Petr has objections.
> 
> Go ahead :-)

Oops, I just sent it, but I forgot to specify in-reply-to message-id :(

	-ss
