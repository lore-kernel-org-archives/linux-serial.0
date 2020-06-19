Return-Path: <SRS0=VMdU=AA=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22F72C433DF
	for <linux-serial@archiver.kernel.org>; Fri, 19 Jun 2020 10:21:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E74C32080C
	for <linux-serial@archiver.kernel.org>; Fri, 19 Jun 2020 10:21:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gxw0YkMG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731804AbgFSKVj (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 19 Jun 2020 06:21:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729195AbgFSKVg (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 19 Jun 2020 06:21:36 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A88D1C06174E;
        Fri, 19 Jun 2020 03:21:36 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id k1so3770285pls.2;
        Fri, 19 Jun 2020 03:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VDgnugb2CfGt3bUYZDqOMdc5K2WdlITSMtpr2WMgIQk=;
        b=Gxw0YkMGFFlUAfxi+H2GeiY0SMotDXQV2unlQJpfrz+VAWp6WXBfkS0QWXz+OpUN57
         5whyNR2mhL8N4hQsSJc8CPNzASO7USsO827S4pidIlN4RtRTvORKCkyUA7KK4jpte0ir
         FlszD9T+l9oECvPSzc8muP1YbPkipToRR25IDZxFIT6ufbNmzuBTvZjHUfTxKUOGQEb0
         mbkLbzmE5wQEjLphu9VrI/5whdR8zO85m9eRiH7azOyNjl1/hiIqOBDUe8/NJ4NjrJhy
         gLHXp4j7jHxJlGZgad4+hUiTutvkHkjpIxPAG5aVd+j5VRVMT7lLgQJT3DueJR47HG3c
         uW0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VDgnugb2CfGt3bUYZDqOMdc5K2WdlITSMtpr2WMgIQk=;
        b=sA40/ExyX5IQ8LuphmO/OBDi9ICoxp8avF4h1ReDO4BhrGql5A0dv50AMS0XOd7MPU
         RXQirAHwPy61flCe7GCotu9G5y7i/dtatNsD2RLi/brVVEl0VdhYetkooPbvqutIrgM7
         K8tBXFYt1LJ1z+815yv3TEp4ZRqPQDz++f7W/4CwCFdDvuIY/ZD1Yxezwg35qP50zBlq
         Q/ty5CMdAIKoZtDyRAF2bOOb8EjUsvz1zRGOU1XFBjtALqtbz6bBHgSgYlw73JGyiPyi
         oj+7AbBSWQZn2FQXCUs95AUVXg1JfE5ZOgOGCLijduHD/0/d2Af+wJmXNAHogCwvnHD2
         VgcA==
X-Gm-Message-State: AOAM5301WBRHG/BwS9SIgBJk9e/3wOOaiJ6I5lhzpK0MM6sJE4/yovzN
        Ov9X/w8FRCzY0RNHWsa7qCQ=
X-Google-Smtp-Source: ABdhPJySZmZUheczzUUdNhskXaNolTLzBWtGhah6JUkwzXvdPP05AlmWVmDWTfjEWIkEeMcyZmXgUw==
X-Received: by 2002:a17:902:fe01:: with SMTP id g1mr7714083plj.254.1592562095934;
        Fri, 19 Jun 2020 03:21:35 -0700 (PDT)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id o207sm5609202pfd.56.2020.06.19.03.21.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2020 03:21:35 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Fri, 19 Jun 2020 19:21:32 +0900
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org
Subject: Re: [PATCH v1 0/6] console: unify return codes from ->setup() hook
Message-ID: <20200619102132.GB310968@jagdpanzerIV.localdomain>
References: <20200618164751.56828-1-andriy.shevchenko@linux.intel.com>
 <20200619093917.GK3617@alley>
 <20200619094726.GD2428291@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200619094726.GD2428291@smile.fi.intel.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On (20/06/19 12:47), Andy Shevchenko wrote:
> On Fri, Jun 19, 2020 at 11:39:18AM +0200, Petr Mladek wrote:
> > On Thu 2020-06-18 19:47:45, Andy Shevchenko wrote:
[..]
> > I am going to push it the following week via printk tree unless
> > anybody complains.
> 
> Thanks, Petr, I guess you may also incorporate Sergey's patch
> he proposed. Sergey, are you going to submit it officially?

I can send a patch, unless Petr has objections.

	-ss
