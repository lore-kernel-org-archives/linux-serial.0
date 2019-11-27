Return-Path: <SRS0=S98g=ZT=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 404C6C432C0
	for <linux-serial@archiver.kernel.org>; Wed, 27 Nov 2019 14:16:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16381206F0
	for <linux-serial@archiver.kernel.org>; Wed, 27 Nov 2019 14:16:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jPO/2txu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbfK0OQc (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 27 Nov 2019 09:16:32 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:41804 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726664AbfK0OQc (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 27 Nov 2019 09:16:32 -0500
Received: by mail-yw1-f65.google.com with SMTP id j190so8386083ywf.8
        for <linux-serial@vger.kernel.org>; Wed, 27 Nov 2019 06:16:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=w6PGv6Jf1cx74rxehqb96+ueBxnXCDdC1t93l0UKtKc=;
        b=jPO/2txu3KAjmDmWJccJ1Nzi2WbPvk59kkcnQUPnCvfhcIDVdKkQoN8tfV3H1puWQL
         fS3nkamfS25d/iUO4MK9RWi9McJEXGAVx+erFYTC5gpaJ4hGx+giIIeO+BpKjxTnajPr
         D/1zowgirFfYnDwSmbXAEWeUojRPsCvTUqbBKxM992d+h6DVIGACF5NcB9T4PybSkoFi
         M3KirYdaRgLCarjxYU5qlRT/rePkV+bw6M+Qdv1f+KV7rwRBjpDq89kSFDKiV7FVPgJ1
         a5f500b2B72qTUiHB9aFy8dd/McrMMOLF2XjrMhaQ7z+1wjeDp9Ik25VAWY2ZyXj14bo
         SyNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=w6PGv6Jf1cx74rxehqb96+ueBxnXCDdC1t93l0UKtKc=;
        b=LMAcX2oJVcJtLOi9EjadF+qyn9xt83LB2BcZhOyWHnBcdQZfbLZpWdsszFmCyNU8sk
         avKp7Ce8TwjZ2lccrE8lNt6r0XffVHuANmWUzuVb52I7JMgMTQMZuAkXzke2cfZpT3Db
         Fms1w6oKVpy8gGn3lzMghmoVHdsUSJjQp30FDIbgmZv5BVrMAAIqmmij42bsxONxQL6g
         nPuQeDmMu+CguOBXIicgs8hFc6PTPBb6voHht+G3y05UusVXv12lnSDy36604CYg2c0o
         KGfvsUCYk/0/nuDxXBZOAzwb97+l8RHJdoM8LiQNdZBW/IrGsIrImVvF2ygJpyvdr9/x
         QW7w==
X-Gm-Message-State: APjAAAXO2Yb8uHQkbotCCdbIiXp+RR+z2GAi2AX/C77GBdM5gFAK1vml
        wEUpqF3a8N9DuP5AIBHj9TmkjQ==
X-Google-Smtp-Source: APXvYqzWr3WjVFNlWvvG1saJi5xfchjW8dcSq+uJItC3O3wshE9qK53GCaqXqUX0gvKmv1xOiCHXjA==
X-Received: by 2002:a81:c609:: with SMTP id l9mr2926079ywi.37.1574864191414;
        Wed, 27 Nov 2019 06:16:31 -0800 (PST)
Received: from localhost.localdomain (li2093-158.members.linode.com. [172.105.159.158])
        by smtp.gmail.com with ESMTPSA id u123sm6911115ywd.105.2019.11.27.06.16.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2019 06:16:30 -0800 (PST)
From:   Leo Yan <leo.yan@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Nicolas Dechesne <nicolas.dechesne@linaro.org>,
        Jeffrey Hugo <jeffrey.l.hugo@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v2 0/2] tty: serial: msm_serial: Fix lockup issues
Date:   Wed, 27 Nov 2019 22:15:42 +0800
Message-Id: <20191127141544.4277-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This patch set is to address two msm serial driver's lockup issues.

The first lockup issue is a well known and common issue which is caused
by recursive locking between normal printing and the kernel debugging
facilities (e.g. sysrq and oops).  Patch 0001 follows up other drivers
general approach to fix this lockup issue.

The second lockup issue is related with msm serial driver's specific
implementation.  Since the serial driver invokes dma related operations
after has acquired spinlock, then the dma functions might allocat dma
descriptors and when the system has very less free memory the kernel
tries to print out warning, this leads to recursive output and causes
deadlock.  Patch 0002 is used to resolve this deadlock issue.

These two patches have been tested on DB410c with backported on 4.14.96,
they also have been verified with mainline kernel for boot testing.

Changes from v1:
* Added 'Fixes' tags for two patches (Jeffrey Hugo).
* Added cover letter for more clear context description (Jeffrey Hugo).


Leo Yan (2):
  tty: serial: msm_serial: Fix lockup for sysrq and oops
  tty: serial: msm_serial: Fix deadlock caused by recursive output

 drivers/tty/serial/msm_serial.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

-- 
2.17.1

