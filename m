Return-Path: <SRS0=P72y=BW=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C167C433DF
	for <linux-serial@archiver.kernel.org>; Wed, 12 Aug 2020 15:48:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5363E207F7
	for <linux-serial@archiver.kernel.org>; Wed, 12 Aug 2020 15:48:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZsPXRCME"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726503AbgHLPsP (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 12 Aug 2020 11:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726456AbgHLPsP (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 12 Aug 2020 11:48:15 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D5ABC061383;
        Wed, 12 Aug 2020 08:48:15 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id d4so1337509pjx.5;
        Wed, 12 Aug 2020 08:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=RPkdRvskU2truT0RUlcYLxIYDKPHKWnkHlYw1K8+A0o=;
        b=ZsPXRCME8ozj9Auw/INQSSsAXDPCCWmixDmy4ujnjFh0XHZFprPbunvlf7H3/S/KlY
         RNGVuCRdb3MDfYY6gAsQU43MOhzl9XpvxwNzXTsVpm8ja8FxzNRoQfiNJ/i1axmZ9Ezw
         8xIxbiBp+AbctkmL10bPmkXb1jvQA7QYOJxCgLAnJBxFTcP3ijGiJCZTLmM9Px38iM+D
         fVMHKPd/L8fc57Pbl3AQ60wQ9JtFWl/S+/T6FuvZfsE2l4BXC/tiNLy0t0KoV3KGwC1a
         bxhUiTAuY42MzLEt0PUKeWM1YLnIg/6aYcyIy2Ik/7QgQbQCyzw6kVn+0PhPJx2Z8hV3
         WCqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=RPkdRvskU2truT0RUlcYLxIYDKPHKWnkHlYw1K8+A0o=;
        b=Leb5nxjfoXoblbxFPuTZdYoWqs4KYuBgy4SKLnTTf+v9CcI9nhZ5UsBrJe8/GYHtyV
         hTP1Em5rwMf0DDSupcniVsATCueS5sE6ghmX4bbA9ckYJLHXW7j46vJrDDo2mRcR1/9M
         e1Em8fVHqPEUFpPtEbdlH6PojIOZ/OnlEvc7ikfIiHGgShZgJ9zDzqvG1YTkJAohxc2o
         nLvJtXgAMV0mEpEs5CdplkWKN2HNTjDWj2bNPP8rm5QxWVmxxH9CrtLHhg8XVdCNgYBa
         ayyLEDV86pO3kRWC35LTJ0PwjICPID2Xax+2cxXaYvema4rCs4AHp5LUaZOkQTa/Eu8b
         wRoA==
X-Gm-Message-State: AOAM533ZjhjsN34UtXRL5sJuHxuKXIEn+0FcTJHmETLBmerHgXY8Zxw3
        5Z7hXoc0Zk3N8lXtMT4GeSzlZ4my
X-Google-Smtp-Source: ABdhPJwoMitfwG9v9rep6qlcSnpKnVNmBOxvkAwedHoQ8QFJrpE0IoAJ6shbn7uljx3iVFsWP4R8ZA==
X-Received: by 2002:a17:90a:e558:: with SMTP id ei24mr693158pjb.54.1597247294765;
        Wed, 12 Aug 2020 08:48:14 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q2sm2886179pff.107.2020.08.12.08.48.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Aug 2020 08:48:14 -0700 (PDT)
Date:   Wed, 12 Aug 2020 08:48:13 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Recursive/circular locking in
 serial8250_console_write/serial8250_do_startup
Message-ID: <20200812154813.GA46894@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi,

crbug.com/1114800 reports a hard lockup due to circular locking in the
8250 console driver. This is seen if CONFIG_PROVE_LOCKING is enabled.

Problem is as follows:
- serial8250_do_startup() locks the serial (console) port.
- serial8250_do_startup() then disables interrupts if interrupts are
  shared, by calling disable_irq_nosync().
- disable_irq_nosync() calls __irq_get_desc_lock() to lock the interrupt
  descriptor.
- __irq_get_desc_lock() calls lock_acquire()
- If CONFIG_PROVE_LOCKING is enabled, validate_chain() and check_noncircular()
  are called and identify a potential locking error.
- This locking error is reported via printk, which ultimately calls
  serial8250_console_write().
- serial8250_console_write() tries to lock the serial console port.
  Since it is already locked, the system hangs and ultimately reports
  a hard lockup.

I understand we'll need to figure out and fix what lockdep complains about,
and I am working on that. However, even if that is fixed, we'll need a
solution for the recursive lock: Fixing the lockdep problem doesn't
guarantee that a similar problem (or some other log message) won't be
detected and reported sometime in the future while serial8250_do_startup()
holds the console port lock.

Ideas, anyone ? Everything I came up with so far seems clumsy and hackish.

Thanks,
Guenter
