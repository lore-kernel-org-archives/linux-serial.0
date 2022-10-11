Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 014DDC433F5
	for <linux-serial@archiver.kernel.org>; Tue, 11 Oct 2022 09:50:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbiJKJut (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 11 Oct 2022 05:50:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbiJKJua (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 11 Oct 2022 05:50:30 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FC0267147
        for <linux-serial@vger.kernel.org>; Tue, 11 Oct 2022 02:50:18 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id d7-20020a17090a2a4700b0020d268b1f02so6061572pjg.1
        for <linux-serial@vger.kernel.org>; Tue, 11 Oct 2022 02:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZMcAAyBurX213ms++6fxs5yYshR15LQEWIK6Brhfq2U=;
        b=E30jldzjDUyedes4Dyz0G7M/yKxEwbf7zvDsjPTux3VYUTaiYNJwgckV4Afjq2WjOR
         KxgSgvDWZGcXxmegkYa5RqsqnsOFjsNCeN+f/N8/ujUHry2iOrtrN1AZs2RFLbjD4PEv
         Gois52svXqDPqXy3q+5GtSWlG2iN/KL4ewUZ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZMcAAyBurX213ms++6fxs5yYshR15LQEWIK6Brhfq2U=;
        b=I65D7d/OS++cpZ9W+vb8Xj4qyB5ftrPOUc3rdWP0kJ3Y6sM7DIXPsfsJJvqNfx9oRU
         MmZvG8AQ0Aqutz5KITYD02shnkOVWq8lhjh+w+jHDZgj9o4k04vAOMgnap8cGi7LwsCv
         HWv0gGha+FKcAolSJ70XY+SSfyk2odlX7a3rymqugK5iNNvEf3eJoXNbnlUQUcgf8lRu
         8dVSgjB2Qas5AbEi3N1XVxLsIsXCnT633L9VD1jyQ6rMl68+rgh54FM9x6kA9WroZg5i
         2Sd5Zm97AS+/ZbA8s+LutJepu+o8gZDmZBbTtYeg8iLqvOhTjU+LX8fy2mnqpRAO1WJr
         1pkA==
X-Gm-Message-State: ACrzQf3B7ZfCjdSmOWSsV874JBr/UI4bt2l9iXtQwv2JRBcBfdU0dalX
        h+KREIqealZwPyuGjtYtCUZKFA==
X-Google-Smtp-Source: AMsMyM64TKsLAdnHpm8xa6rVVP1WyAAfcvlvUT8VgjoPnhg8b/BQy8D8VLy5xVUWdI1nnoYKHjgoWw==
X-Received: by 2002:a17:902:d2c6:b0:17f:592b:35dd with SMTP id n6-20020a170902d2c600b0017f592b35ddmr23669488plc.172.1665481817725;
        Tue, 11 Oct 2022 02:50:17 -0700 (PDT)
Received: from google.com ([240f:75:7537:3187:9be2:d006:f7fe:8f60])
        by smtp.gmail.com with ESMTPSA id u6-20020a17090a3fc600b001faafa42a9esm7559083pjm.26.2022.10.11.02.50.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 02:50:17 -0700 (PDT)
Date:   Tue, 11 Oct 2022 18:50:12 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: Do not delay boot when printing log to serial console during
 startup?
Message-ID: <Y0U8VA7z/on3Hdbr@google.com>
References: <c87cc376-3b0d-8fda-7fc1-555c930faaf1@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c87cc376-3b0d-8fda-7fc1-555c930faaf1@molgen.mpg.de>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On (22/10/11 11:03), Paul Menzel wrote:
> 
> We boot our systems generally with the serial console enabled
> `console=ttyS0,115200n8`, and noticed that initializing the console takes at
> least one second.

[..]

> So it looks to me like, that the already recorded messages are printed out
> over the serial console first, before it continues. The documentation of
> `register_console()` in `kernel/printk/printk.c` confirms that:

I guess your console has CON_PRINTBUFFER flag set, so we flush all
pending kernel messages on this console after registration. Off the
top of my head, you might want to play with the default console loglevel
so that we will suppress printing of most of the messages.
