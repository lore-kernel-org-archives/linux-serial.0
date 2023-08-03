Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E84AEC001DF
	for <linux-serial@archiver.kernel.org>; Thu,  3 Aug 2023 07:00:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232607AbjHCHAk (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 3 Aug 2023 03:00:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbjHCHAj (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 3 Aug 2023 03:00:39 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EAEC10EA
        for <linux-serial@vger.kernel.org>; Thu,  3 Aug 2023 00:00:38 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4fe457ec6e7so1046345e87.3
        for <linux-serial@vger.kernel.org>; Thu, 03 Aug 2023 00:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691046036; x=1691650836;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7erNa/7gWtMsQuK3CJdRoDAQ+93nPpJWVI3LSRtGRa4=;
        b=mQnkfRlqHe6IyazSlgxiWMaDI8tkKvV4o3s97esAhHN6+uKLBZyWn8+1shPF0JFWU1
         /tTejz8jz4Tkvk3FxbgISZgrGAAs9qCsKlkl94LB8wJjdwJ+RWh6M1RfwjucgtNVxWds
         4wga04tS1n78Uvf9CGES8yMMfi19gdIbLJcCFCZwMsJt7Npee+kxwT8+P5XskoVnSM75
         jbvPcSteb5/HjD0yvrc5wYFEDcsXsQL0YYqsx2oiifjgTdcD23qolqZXhK6K2mSGvfve
         +VltL4q008xON7RjJYck+sko4uv45AeKVTWR1b4O58Ye5T02RcsGS7mj42OhpzdmVULy
         IoEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691046036; x=1691650836;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7erNa/7gWtMsQuK3CJdRoDAQ+93nPpJWVI3LSRtGRa4=;
        b=ijoq1ylWr3Y1ZbuPGOxLzVaMnvO82BrVzVqlt/ZdkD+k0goFVey+c8mIrsvHmBaPEO
         lx24cmmPt9hI9Nk3xfxMBtHijZqAJgqB27xX0vuSW9YLEJFM0IEhsGMle77zWzI5Zwpm
         F7ViqzZbAKojwQkUgoEvpN6+pg7s6zEfkdIK8islnwMmB/G1odnpEU0/NC+U1XiJ5tLc
         PrYgNsM9s3n9YwX328q8u46DV9Y10gXmstKb5RpZrIwTAKojI2i1xG1bnv6dZW9NPG6l
         XXycNEe2JRM47vOcCJTuwsA/4zVysp9p+Lw8zn828zGnwuIIHsqhAoEJxTqd8r8Cr4Nc
         aqhw==
X-Gm-Message-State: ABy/qLYq+xC7hi1shwvxm2ZGamcDkHWWPD41PdNks99AfkySSkE9+AYm
        vW/lhJ0h2W9MyeddAo4/NlitqQ==
X-Google-Smtp-Source: APBJJlHkEdhjr1rVmo/7mHQtWOp7mJcWbscH3LtniA47Nc5HyRJ36KbKTp6DFwTebvBO3SHtiVqULQ==
X-Received: by 2002:a19:e048:0:b0:4fe:5fc:9c4b with SMTP id g8-20020a19e048000000b004fe05fc9c4bmr5460612lfj.15.1691046036329;
        Thu, 03 Aug 2023 00:00:36 -0700 (PDT)
Received: from mutt (c-9b0ee555.07-21-73746f28.bbcust.telenor.se. [85.229.14.155])
        by smtp.gmail.com with ESMTPSA id 16-20020ac24850000000b004fbdba4b075sm3261049lfy.57.2023.08.03.00.00.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 00:00:35 -0700 (PDT)
Date:   Thu, 3 Aug 2023 09:00:33 +0200
From:   Anders Roxell <anders.roxell@linaro.org>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Dhruva Gole <d-gole@ti.com>,
        Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH] serial: core: Fix serial_base_match() after fixing
 controller port name
Message-ID: <20230803070033.GD411@mutt>
References: <20230802114846.21899-1-tony@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230802114846.21899-1-tony@atomide.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 2023-08-02 14:48, Tony Lindgren wrote:
> While fixing DEVNAME to be more usable, I broke serial_base_match() as
> the ctrl and port prefix for device seemed unnecessary.
> 
> Let's fix the issue by checking against dev->type and drv->name.
> 
> Fixes: 1ef2c2df1199 ("serial: core: Fix serial core controller port name to show controller id")
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

This fixes boot on e850-96.

Tested-by: Anders Roxell <anders.roxell@linaro.org>
