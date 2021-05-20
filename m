Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D46FCC43461
	for <linux-serial@archiver.kernel.org>; Thu, 20 May 2021 12:53:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9ACA611AD
	for <linux-serial@archiver.kernel.org>; Thu, 20 May 2021 12:53:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242798AbhETMzE (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 20 May 2021 08:55:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243494AbhETMyj (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 20 May 2021 08:54:39 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A44AC068D8E
        for <linux-serial@vger.kernel.org>; Thu, 20 May 2021 05:19:11 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id h3-20020a05600c3503b0290176f13c7715so5093794wmq.5
        for <linux-serial@vger.kernel.org>; Thu, 20 May 2021 05:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uBYwcFKrYsCTbjbrQKTmoHLJiiSFsBd/2SYWAufez/Y=;
        b=Atv/WuyVLKexAPcuSkixUBWqY6CO0dK2gduGoLHaFLRvVIpwJ+MrtjaNBQvCnJ5nHr
         eHNTx15hB/n8yPeFfgA9Szrp5Us8P/SgN8aQQywqr9L5ncIee5wFPRDugk50O2JPvUOz
         EdNCZ2ypRZFTnQHuWPjqRkJV04zKL81xMmOz89RQPXgV+YgzJCPCDIxIBswnEiniBxVr
         Ux3T/PvLYDM4q6JEv3l7vFZYNbCs5hMnPMyygqx/eGv7gzuQbb2tRkTFda1RaW4dkCWq
         4Tcv2+jr0/Ynwa17LHaRx81KnPTEJXfLmiF80NjPlfagl4az3Q5Gk2dVly1HcfEAmBwL
         nqfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uBYwcFKrYsCTbjbrQKTmoHLJiiSFsBd/2SYWAufez/Y=;
        b=grmd2olyW5HVHURBiKCMq5bVi6lqhQKRL0EOLlJeQ62/kdR3iI9fM31GpMqbScT/wn
         ZF5mRtdfr7Zv7aZy1+u3Zr8+bqQk3mG5w4hODHMAeiebnHWdKbk1P6AiTfBCwUSw6gl8
         GgNJfkXX+ynQXbTQEvhWMZf21P6L937ESPtftL7jQIHToqAc60hFpttYc+hpcI/bI7LI
         DoXiHLLtlDHGAShiI71RNZn+oH9RMADNbxPQ1nP014AOF3w4YrAazDuenbkRPBskHkMM
         wI1XJ+SuODssjIDCovrucKYCX9HRVOzF0HEOfyYFyHJuU1JxE95S7GXzvCX3Lzh/l7K0
         DIQA==
X-Gm-Message-State: AOAM5322adY00AkCHewxNn8u8ydUG1RInorMqQpfb8Fnzo7PAoPntZbN
        9fGCIN0JvLGw6Q8P6bv04Gy48A==
X-Google-Smtp-Source: ABdhPJy3HAhGdYxDbgzvUXcIf+78K3LKutGvMz5lblmb8zzowzFLXzUCMmFB3EX/uNLAi9/rpRw1sg==
X-Received: by 2002:a7b:c0da:: with SMTP id s26mr1615481wmh.83.1621513149899;
        Thu, 20 May 2021 05:19:09 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id f16sm3061161wrm.47.2021.05.20.05.19.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 05:19:09 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Al Longyear <longyear@netcom.com>,
        "Andrew J. Kroll" <ag784@freenet.buffalo.edu>,
        Andrew Morton <andrewm@uow.edu.eu>,
        Bill Hawes <whawes@star.net>,
        "C. Scott Ananian" <cananian@alumni.princeton.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        -- <julian@uhunix.uhcc.hawaii.edu>,
        linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org,
        Marko Kohtala <Marko.Kohtala@hut.fi>,
        Michael Callahan <callahan@maths.ox.ac.uk>,
        Michal Simek <michal.simek@xilinx.com>,
        Nick Holloway <alfie@dcs.warwick.ac.uk>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Paul Fulghum <paulkf@microgate.com>,
        Paul Mackerras <Paul.Mackerras@cs.anu.edu.au>,
        processes-Sapan Bhatia <sapan@corewars.org>,
        Rob Herring <robh@kernel.org>,
        Russell King <rmk@arm.linux.org.uk>
Subject: [PATCH 00/11] Rid W=1 warnings from TTY
Date:   Thu, 20 May 2021 13:18:55 +0100
Message-Id: <20210520121906.3468725-1-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This set is part of a larger effort attempting to clean-up W=1
kernel builds, which are currently overwhelmingly riddled with
niggly little warnings.

Lee Jones (11):
  tty: vt: selection: Correct misspelled function sel_loadlut()
  tty: serdev: core: Fix misspelled function name
    __serdev_device_driver_register()
  tty: tty_io: Fix a few kernel-doc related misdemeanours
  tty: n_tty: Fix some misdocumented functions
  tty: tty_buffer: Fix incorrectly documented function
    __tty_buffer_request_room()
  tty: tty_jobctrl: Fix 2 incorrectly documented functions
  tty: pty: Fix incorrectly named function pty_resize()
  tty: n_hdlc: Fix a little doc-rot in n_hdlc_tty_read()
  tty: serial: st-asc: Demote a kernel-doc formatting abuse
  tty: n_gsm: Fix function naming and provide missing param descriptions
  tty: serial: xilinx_uartps: Fix documentation for
    cdns_uart_clk_notifier_cb()

 drivers/tty/n_gsm.c                |  6 ++++--
 drivers/tty/n_hdlc.c               |  4 +++-
 drivers/tty/n_tty.c                | 10 +++++-----
 drivers/tty/pty.c                  |  2 +-
 drivers/tty/serdev/core.c          |  2 +-
 drivers/tty/serial/st-asc.c        |  2 +-
 drivers/tty/serial/xilinx_uartps.c |  2 +-
 drivers/tty/tty_buffer.c           |  2 +-
 drivers/tty/tty_io.c               | 17 +++++------------
 drivers/tty/tty_jobctrl.c          |  4 ++--
 drivers/tty/vt/selection.c         |  2 +-
 11 files changed, 25 insertions(+), 28 deletions(-)

Cc: Al Longyear <longyear@netcom.com>
Cc: "Andrew J. Kroll" <ag784@freenet.buffalo.edu>
Cc: Andrew Morton <andrewm@uow.edu.eu>
Cc: Bill Hawes <whawes@star.net>
Cc: "C. Scott Ananian" <cananian@alumni.princeton.edu>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: -- <julian@uhunix.uhcc.hawaii.edu>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-serial@vger.kernel.org
Cc: Marko Kohtala <Marko.Kohtala@hut.fi>
Cc: Michael Callahan <callahan@maths.ox.ac.uk>
Cc: Michal Simek <michal.simek@xilinx.com>
Cc: Nick Holloway <alfie@dcs.warwick.ac.uk>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Paul Fulghum <paulkf@microgate.com>
Cc: Paul Mackerras <Paul.Mackerras@cs.anu.edu.au>
Cc: processes-Sapan Bhatia <sapan@corewars.org>
Cc: Rob Herring <robh@kernel.org>
Cc: Russell King <rmk@arm.linux.org.uk>
-- 
2.31.1

