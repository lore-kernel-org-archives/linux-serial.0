Return-Path: <SRS0=uqjK=7X=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7E78C433DF
	for <linux-serial@archiver.kernel.org>; Wed, 10 Jun 2020 15:23:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B3D8207C3
	for <linux-serial@archiver.kernel.org>; Wed, 10 Jun 2020 15:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591802586;
	bh=3tOvKZALFeC10KTluWq5qeYGwZcCp6/RMxk7/aiNMFc=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=ZUqvRHKVufWhnKCSKpvEbvI8CPWZ/yvjCsLlkEW1gOXMoApyvl44VDD8EXivJ+U5z
	 9po7AFdO9VUq1iYiciz0SnP1uM6O1fJ1jszJX7GndkapvMY/JJFBvbIQVcJCEZ96uj
	 w3z5ksDflTKDYtocsqgZzqCWOxxx38sO2X7qxDFI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730137AbgFJPXG (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 10 Jun 2020 11:23:06 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41652 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728331AbgFJPXF (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 10 Jun 2020 11:23:05 -0400
Received: by mail-lj1-f196.google.com with SMTP id 9so2979789ljc.8;
        Wed, 10 Jun 2020 08:23:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QRq2KlneLdvkgeGBvtIInEMf7/XC7XYNm4CS79Oqsg4=;
        b=abhvCwhEHlvz/aF/av8p7DmDbjWN9PH94N017tzz6gGagHr4ZQqC3DtFXXLyNaLpZ5
         +gEL/1xGKVm7vG0WEWoS3iMD27jStzGLF8h4ZYeiNk5gUr66kDD88M4HYjL6T/hYWzas
         TeeWg+k+h+4UVEk4yE+/SnwrwQDx8FDrrTj1/gRW3c0n+IshmcLcxPDPc2ZvwnETw4ik
         KTCQeksUFab67F57iddqUzA+rwyYDLCIH7sp0rh4DqA+w3FxHLv3ArKSMWvp198GefT4
         /dsfUJTRT/EFinOU2qoI5NbR+DHt72324VniLE7XXuMNB6vnk8PgvvlKJMjipqm6g7bB
         BPLQ==
X-Gm-Message-State: AOAM532pfHW+V8y+E0CJPplAFemAlf4XF88/v8J6n2RfkneRv4lJx2e8
        eMkPVaxgV8RM3nQFsrvpEnc=
X-Google-Smtp-Source: ABdhPJzcctVka+CvL+lqcnWENwKg+C6fHk331iDt6j+G8x1gzpyqy2MkkCfHZxfZ97erli7naaQwGA==
X-Received: by 2002:a2e:92d5:: with SMTP id k21mr2029404ljh.445.1591802583688;
        Wed, 10 Jun 2020 08:23:03 -0700 (PDT)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id u6sm9610ljk.109.2020.06.10.08.23.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 08:23:01 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@xi.terra>)
        id 1jj2Z8-0004Po-6c; Wed, 10 Jun 2020 17:22:58 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jslaby@suse.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH v2 0/3] serial: core: fix up sysrq regressions
Date:   Wed, 10 Jun 2020 17:22:29 +0200
Message-Id: <20200610152232.16925-1-johan@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This series fixes a few regressions introduced by the recent sysrq
rework that went into 5.6.

The fix for the unnecessary per-character overhead probably could have
been marked for stable but I left that decision to the maintainers as it
is a bit intrusive (although mostly shuffling code around).

Johan

Changes in v2
 - inline uart_unlock_and_check_sysrq() along with the other helpers
   (restoring the interrupt state in a helper was never an issue)


Johan Hovold (3):
  Revert "serial: core: Refactor uart_unlock_and_check_sysrq()"
  serial: core: fix sysrq overhead regression
  serial: core: drop redundant sysrq checks

 drivers/tty/serial/serial_core.c |  96 +----------------------------
 include/linux/serial_core.h      | 102 +++++++++++++++++++++++++++++--
 2 files changed, 100 insertions(+), 98 deletions(-)

-- 
2.26.2

