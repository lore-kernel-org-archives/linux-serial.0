Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4762C4332F
	for <linux-serial@archiver.kernel.org>; Mon, 30 Oct 2023 07:35:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231483AbjJ3Hfx (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 30 Oct 2023 03:35:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjJ3Hfv (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 30 Oct 2023 03:35:51 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98512A7
        for <linux-serial@vger.kernel.org>; Mon, 30 Oct 2023 00:35:49 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5a7bbe0a453so35249747b3.0
        for <linux-serial@vger.kernel.org>; Mon, 30 Oct 2023 00:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698651349; x=1699256149; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ox/1zbaST3BD5MYMQYBwlJcwEmAcclBF5I6+IkAoPUg=;
        b=PmqBHZR3+cjnMFLhkZjwIygVdj7eGAco/cm6eSNtqoZe7F6qLolLvD3B/TYhp7RRZW
         ysSgnHW6nClmepBIU1bViBHKdS+BREdtovUGeLNoeYL+jc43QfsAll+xRdva8DpC4RKX
         GMhuJDFtNwnDxUANhiY6uNCz/NumyvWXVlW7TZlW8pxk0dDvgg1tbPRuE41nE9DL3I4m
         1JVW0niEgNenT6RhE8caX+jPc7wcIICH/su/dQiv57G/sfNQhMdOTsAli/vVhBceW7H+
         doJk1Rtg0Ot98cK2XMvMJlpxV26bc70MoVAJsoSK7VPjuly3o9Uaezn1LLxrA/kQLSAn
         kMOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698651349; x=1699256149;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ox/1zbaST3BD5MYMQYBwlJcwEmAcclBF5I6+IkAoPUg=;
        b=j6TiS9nMusUZn8ojaN9ssTRT4BHwlrZW9jRrZ/65j/z6NCmCmTSJW4/BrRdhRFFURn
         cen5YiHt7q0WQFQwrOrypWEwKztgIjWwrPCI6Fl9dsAfR0gi7PeewbnU3y9VQGHuBLMG
         58+hROq4K1Ifs5dV91ZyzCkVuUJxXgNWx0e6P4T3+m0dDI/WpTKseS0XoJu8taQF10C7
         qnO0Ji3moXvPjOj3Sx/wFPs4GdQCE+qiXPB2t6MU3bBVkLkt4AVtdklC50LoVewDHFGb
         3DsVOldVQN8MAJqMe45VJoXDv/Ig6RR7vVFdcQDphO0JSmaxZWJScIcWBGvK4+uBL+uB
         JYqw==
X-Gm-Message-State: AOJu0Yw2DFuPCyNbKpsNBXxs7B5X0eHNIkej/0YlU0jvY1ShUZWh0t1O
        RIxSjVZ/Yb1X3lLCMH5PK5chhu4W7U44X31GBCew
X-Google-Smtp-Source: AGHT+IGZvGiXRtnyMqYvh9R6Clqt7qLFE6PqQ3QVn+IDJJlecNyVHfV8DD+Bk7Ysi3aTRoK5XTCgTOL+xRlZgrJsyyS+
X-Received: from vamshig51.c.googlers.com ([fda3:e722:ac3:cc00:3:22c1:c0a8:70c])
 (user=vamshigajjela job=sendgmr) by 2002:a81:6c49:0:b0:5a7:ba09:44b6 with
 SMTP id h70-20020a816c49000000b005a7ba0944b6mr181888ywc.0.1698651348792; Mon,
 30 Oct 2023 00:35:48 -0700 (PDT)
Date:   Mon, 30 Oct 2023 13:05:40 +0530
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.820.g83a721a137-goog
Message-ID: <20231030073542.251281-1-vamshigajjela@google.com>
Subject: [PATCH v5 0/2] serial core type consistency and clean up
From:   Vamshi Gajjela <vamshigajjela@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        ilpo.jarvinen@linux.intel.com
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        manugautam@google.com, Subhash Jadavani <sjadavani@google.com>,
        Channa Kadabi <kadabi@google.com>,
        Vamshi Gajjela <vamshigajjela@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This patch series primarily focus on improving type consistency and
ensuring proper handling of timeout values. The changes aim to enhance
the redability and maintainability of the serial core.

Greg, sorry for the confusion.

I started the patch series with 3 patches. I submitted improvised
patches based on review comments for each patch in the series instead
of submitting all the patches at once. This may have caused confusion,
as each patch is now at a different version, with one patch at
v2 (NACKED) the second one ready for v2, and the third at v4.

From now on, I will increment the version for the whole series instead
of for individual patches.

I have now submitted the series as v5 to avoid duplicate version numbers.
In v5 it has two patches [v4 3/3] and [v2 2/3] while [v2 1/3] discarded.

Vamshi Gajjela (2):
  serial: core: Update uart_poll_timeout() function to return unsigned
    long
  serial: core: Clean up uart_update_timeout() function

 drivers/tty/serial/serial_core.c | 7 +++----
 include/linux/serial_core.h      | 4 ++--
 2 files changed, 5 insertions(+), 6 deletions(-)

-- 
2.42.0.820.g83a721a137-goog

