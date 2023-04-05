Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2484C7619A
	for <linux-serial@archiver.kernel.org>; Wed,  5 Apr 2023 11:19:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237706AbjDELTU (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 5 Apr 2023 07:19:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237801AbjDELTS (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 5 Apr 2023 07:19:18 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1EF135BE
        for <linux-serial@vger.kernel.org>; Wed,  5 Apr 2023 04:19:16 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id x20so36889342ljq.9
        for <linux-serial@vger.kernel.org>; Wed, 05 Apr 2023 04:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google; t=1680693555;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=72pc9vhyxIvuldDD9tgX3t3tikielO9csSBNDuIyf3o=;
        b=K6oEpw3Ow3MY/fIglFjdqs7nhBovJ0r5oo8cyRibK36zpeJpjRGoLS7cgvCWHIa9nF
         fuK7Im4DfoKzl13jtvCJPkvke1aMER4AkFs2ONuIQhUaVujKGb4on2TyBAnIEB/dAtxK
         HpOoJmobAOKP95UMTLXV2MIrbFYNOGb5aI2MBq5OLbvK/YuOqMNJsD1ZfIyMHwvyofdI
         PgkKrr0sPrWdKV8wkgnaEe2+sud3GoBYRiJ5d50+dBiQtsG5XRX5E/1CDz0e8MkDqdEC
         PmHs3opQgWj9ngvvEqs/aHWunR4WSCK4nnIx3Sa5sBo9C68kKTeR1qeXpe5ZfBNJr7/c
         JfeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680693555;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=72pc9vhyxIvuldDD9tgX3t3tikielO9csSBNDuIyf3o=;
        b=y3IsLraWMjV2JEgU7zMRqOQkyS0E5BgxN81nDzmNXR3Aw0b+Fdx7ho1nuvD2GZgFoa
         R6Lv4NHmGtZNy29SVf9tXQVLd4JXnG8tT9hzXtccos0oaZ89eE7KrU0T1Bb/aBnbLX6P
         tKySxZyqRx5yUo7iBO6NCzXbjKHIO6AFccl73r+f5Ih+rfMsVbwKfhCq/xk2D3hQdXeA
         ONbOHv0CcGaZWN36ZSj+PgkCeuUVAeTYRAm2I5xFbMgrD5PVkcG8BcZZSZEuj9pXngpm
         bLWEAhS+wMl6r/KcjCjF3LAn9XIJHgabnlJ/3eiWLp0UhQWdnF9MH6e6y0ywWzvM432K
         nwfA==
X-Gm-Message-State: AAQBX9dH+cRxqSRWUmSflHF7ZfWAKIrCZw7g/bFTon8kJxAb+YLHE13m
        RiOEE3+QtWuGFk+w3QtkTGmQuoDltepGgf/+/XI=
X-Google-Smtp-Source: AKy350aqpMgxzpiwXdM0m+GyuhcnrtO6q0xeQ4vOzynG0W8GswzngaH57R0hUCWQ9zYyklnBmvSXCA==
X-Received: by 2002:a2e:93c3:0:b0:2a6:3570:72d1 with SMTP id p3-20020a2e93c3000000b002a6357072d1mr1893217ljh.19.1680693554998;
        Wed, 05 Apr 2023 04:19:14 -0700 (PDT)
Received: from lmajczak1-l.roam.corp.google.com ([83.142.187.84])
        by smtp.gmail.com with ESMTPSA id i19-20020a2e8093000000b0029f3e2efbb9sm2817730ljg.90.2023.04.05.04.19.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 04:19:14 -0700 (PDT)
From:   Lukasz Majczak <lma@semihalf.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        upstream@semihalf.com, Lukasz Majczak <lma@semihalf.com>
Subject: [PATCH v2 0/2] serial: core: fix broken console after suspend
Date:   Wed,  5 Apr 2023 13:15:57 +0200
Message-Id: <20230405111559.110220-1-lma@semihalf.com>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This is v2 of a patch[1].
v1->v2:
* Fixed typos in commit message
* Tested[2] patch "serial: core: preserve cflags, ispeed and ospeed" on all
  current LTS kernels (4.14, 4.19, 5.4, 5.10, 5.15, 6.1) and on top of
  6.3-rc5 with positive results - console was working after resume
* During tests another issue was observed  on 6.1+ - FIFO not enabled after
  resume - and an additional change was needed ("serial: core: enable
  FIFO after resume")
* Test procedure:
  1) ensure the console output is ok
  2) suspend device with "echo freeze > /sys/power/state"
     (/sys/module/printk/parameters/console_suspend == N)
  3) resume device and check the console output
  4) suspend device with "echo freeze > /sys/power/state"
     (/sys/module/printk/parameters/console_suspend == Y)
  5) resume device and check the console output

[1] https://lore.kernel.org/lkml/20230301075751.43839-1-lma@semihalf.com/
[2] Test platforms: PC with i5-8400 + GB H370M D3H
		    HP Elite c1030 Chromebook Enterprise i5-10310U

Lukasz Majczak (2):
  serial: core: preserve cflags, ispeed and ospeed
  serial: core: enable FIFO after resume

 drivers/tty/serial/serial_core.c | 57 +++++++++++++++-----------------
 1 file changed, 27 insertions(+), 30 deletions(-)

-- 
2.40.0.577.gac1e443424-goog

