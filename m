Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A99B9C4332F
	for <linux-serial@archiver.kernel.org>; Thu,  9 Nov 2023 06:34:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231161AbjKIGe2 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 9 Nov 2023 01:34:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231146AbjKIGe1 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 9 Nov 2023 01:34:27 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B8662685
        for <linux-serial@vger.kernel.org>; Wed,  8 Nov 2023 22:34:25 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d81e9981ff4so642967276.3
        for <linux-serial@vger.kernel.org>; Wed, 08 Nov 2023 22:34:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699511664; x=1700116464; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cLnjAgoVfswUxIoFV0K4fzcOHC1F9ghlhp68grXoQ9k=;
        b=aGy0w3OADYznzx8VXQZ+rU6NwHU1fKOnOFGAm8WdBpcdjFLUzvWenJEZCW7bFsnSx/
         LFSsx0pxwPp3o0z5jswWbX9a2QPBzPeE42Q9ZQRs9XPLe2CC8sUzhMpSY2PpJZUMBzLM
         NzW0+nv/iJ436MRqYCZVSPGWSfog0FuGoqIeOp91veYeUaNsNMFagTmrwcEZqEFslmwi
         XZ//1a7DCIWPWZG5yW2LbHbyXFa2XLAFunwnhfsGhoETg6dcmlftUGysm6Og5frmWQJL
         oGkEuHiitXfTRlSSoaRMpP3ydAKzTrTgaxARzieYrmpBTPyHRc5cbn5LJIfXpjM+JRHx
         A0qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699511664; x=1700116464;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cLnjAgoVfswUxIoFV0K4fzcOHC1F9ghlhp68grXoQ9k=;
        b=AjZRwieXrgLloazQQIlTJeZLNTrUzDof73R1rGECYs+feLWMM/aT2eSXI2lD4oJviw
         pJNzARYBEBeghqdWMM6VmoHvMMjUqLu+aJ8LF24n4891yxkrKmY6wEgcfJNwWnVumUig
         GFghRZnQsiFCtbJkIMDNxt7lCqEj9BUGYLbhGOkHwLioX/w4NKYPFL1FPEMqBDyM7QoJ
         APaTTJTybZHNTov4rxsrpIdNTh/01NmmbIl1Up66JlsRoJKWdlEmdKpbPMKpCUpcmrOE
         FYuUEPT3WWa3Z8d7rmEyhST8GiGK4BdP1iWGUHyWgLL2/PXYZjKF0oVGBH6ncWpmkE0I
         7CwA==
X-Gm-Message-State: AOJu0YzW3Mzm9QZy+h3GCKhbwn0NTAgTl4CABJjwoom/tRbhglsDK++S
        vlmNwK1aXwc3DODjmBUzF8Q/FQXoldwn3PqxgylG
X-Google-Smtp-Source: AGHT+IHt7rFMay7LO40mRqdDaP6ZD3WZv5mpiJscbJ+prTBu4yEvsRI5aZRWLsHb0zfChQTB47czu3pqk+06kFFTIstw
X-Received: from vamshig51.c.googlers.com ([fda3:e722:ac3:cc00:3:22c1:c0a8:70c])
 (user=vamshigajjela job=sendgmr) by 2002:a05:6902:102:b0:da3:723b:b2a4 with
 SMTP id o2-20020a056902010200b00da3723bb2a4mr94869ybh.7.1699511664016; Wed,
 08 Nov 2023 22:34:24 -0800 (PST)
Date:   Thu,  9 Nov 2023 12:04:15 +0530
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231109063417.3971005-1-vamshigajjela@google.com>
Subject: [PATCH v6 0/2] serial core type consistency and clean up
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

Vamshi Gajjela (2):
  serial: core: Update uart_poll_timeout() function to return unsigned
    long
  serial: core: Clean up uart_update_timeout() function

 drivers/tty/serial/serial_core.c | 7 +++----
 include/linux/serial_core.h      | 4 ++--
 2 files changed, 5 insertions(+), 6 deletions(-)

-- 
2.42.0.869.gea05f2083d-goog

