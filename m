Return-Path: <SRS0=iWX9=B3=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B08B7C433E1
	for <linux-serial@archiver.kernel.org>; Mon, 17 Aug 2020 08:59:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81068206C0
	for <linux-serial@archiver.kernel.org>; Mon, 17 Aug 2020 08:59:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i1cf7fVm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbgHQI7d (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 17 Aug 2020 04:59:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbgHQI7c (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 17 Aug 2020 04:59:32 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36DCEC061388;
        Mon, 17 Aug 2020 01:59:32 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id l60so7491348pjb.3;
        Mon, 17 Aug 2020 01:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=bx+9jw6ytyN2nq5zZtUpkbcxEA3XsZV5v87yprlfMF8=;
        b=i1cf7fVmtsU62pUWcs3S9/X3XikVmkufQIofqkl+VqeYBRnctpwvzZUHnXYyePe/8G
         uOBU0kbmaC/7rMJzobh9nw6q/6TlelvkrYulLr8iQdopkDwhh2pOCq3c1CfZ9Jc80OVo
         v6K/ilzpdjyP4rqQadDMhvUTQQv04gZCy+B5cSQkbSVR2Ip+1QUJO49W+eWZkA6ubqY2
         0wuDdVtgVmp34iNsK8F4ESGMWf/X4kea/H1de1QsXrxutLMQJBS6HSaXKuO8GUDGuB8a
         iWre07NE6sH0QTA5F8d2aGWspg47fk5qbN311yihp+crIBycxtbQ8UvPscwIrO4RCKL3
         ZuWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=bx+9jw6ytyN2nq5zZtUpkbcxEA3XsZV5v87yprlfMF8=;
        b=ry3KoPWj2KjctcIULLt9LDf8ccmn2jMn41BTg9zLgQ00MnS/hCmy7SNIiLdf3I5Gev
         XbymhGkUi7z+59s+p5oj0lcDOdPz3K5fJeF0X70nj0RlVi8gxVCYPvN2wTn38tYEAiU0
         erqCs+28Exy6xxvrEbNjWnGlW3mSUrRlXI+V19okUcf05f1YyY8qdGsIuBj34PQ0QDo7
         9Xqq5ihFQ6tl8A7xg5yixLLArFYK2xIVLeN2iqR5gwxZ1ll3Emwm8xeVPcUl/tpDGaKw
         JKlxs1MA64L4G+LmqI+3XqpDCY6JL2PtSdjqLd4PkbamvhjjUlpd1P1UXKb1bnYX0MTA
         IIvg==
X-Gm-Message-State: AOAM531ZCdaQwxWmtJlePo3Myp+LpRj79LPPWsVb50/PBbdonIxMkIu1
        mT4jYD8YUrrDDfiNy5nwiSE=
X-Google-Smtp-Source: ABdhPJx6vtrAKpj+9yU9EB8zWFnO3jh/EVIVV91GXr/jfZMisbfaBRq0qYNoY08RFdKjxXvHL+C4Dg==
X-Received: by 2002:a17:90b:384b:: with SMTP id nl11mr11546138pjb.91.1597654771792;
        Mon, 17 Aug 2020 01:59:31 -0700 (PDT)
Received: from localhost.localdomain ([49.207.202.98])
        by smtp.gmail.com with ESMTPSA id j13sm18508547pfn.166.2020.08.17.01.59.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 01:59:31 -0700 (PDT)
From:   Allen Pais <allen.cryptic@gmail.com>
To:     richard.genoud@gmail.com, gregkh@linuxfoundation.org
Cc:     keescook@chromium.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Allen Pais <allen.lkml@gmail.com>
Subject: [PATCH 0/4] tty: convert tasklets to use new tasklet_setup()
Date:   Mon, 17 Aug 2020 14:29:17 +0530
Message-Id: <20200817085921.26033-1-allen.cryptic@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Allen Pais <allen.lkml@gmail.com>

Commit 12cc923f1ccc ("tasklet: Introduce new initialization API")'
introduced a new tasklet initialization API. This series converts 
all the tty drivers to use the new tasklet_setup() API

Allen Pais (4):
  tty: ipwireless: convert tasklets to use new tasklet_setup() API
  tty: atmel_serial: convert tasklets to use new tasklet_setup() API
  tty: ifx6x60: convert tasklets to use new tasklet_setup() API
  tty: timbuart: convert tasklets to use new tasklet_setup() API

 drivers/tty/ipwireless/hardware.c |  6 +++---
 drivers/tty/serial/atmel_serial.c | 20 ++++++++++----------
 drivers/tty/serial/ifx6x60.c      |  8 ++++----
 drivers/tty/serial/timbuart.c     |  6 +++---
 4 files changed, 20 insertions(+), 20 deletions(-)

-- 
2.17.1

