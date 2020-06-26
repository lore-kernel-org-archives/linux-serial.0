Return-Path: <SRS0=sLvH=AH=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C629C433E0
	for <linux-serial@archiver.kernel.org>; Fri, 26 Jun 2020 20:01:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A7C820720
	for <linux-serial@archiver.kernel.org>; Fri, 26 Jun 2020 20:01:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CpAQ2H2u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725916AbgFZUBA (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 26 Jun 2020 16:01:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725803AbgFZUA5 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 26 Jun 2020 16:00:57 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1136C03E97B
        for <linux-serial@vger.kernel.org>; Fri, 26 Jun 2020 13:00:56 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id o22so312489pjw.2
        for <linux-serial@vger.kernel.org>; Fri, 26 Jun 2020 13:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jMfv6nXK7pXE53b5JeZ3qPQRps5vJ9xWNq/0HbrUb9M=;
        b=CpAQ2H2udiH/DxH5k73Cwyduuat0KyUq+kl5yrWwSS+KOoxPZNPRnHakCrwVR1vhac
         CHhTpCltkDD/MK0BXGP1SYX1RN4UC+TfOxvRPRr8hiwwywM2IES/1oVQOLsoVKwnWOxe
         4ADPvrVMND13a+SvvgHzG5PzLLCMqFhuYEw8k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jMfv6nXK7pXE53b5JeZ3qPQRps5vJ9xWNq/0HbrUb9M=;
        b=DWXKWrt2PlYkMS8eJYFqpno+1zP7xCGnpR/5J/FlYPBnjEcnrsVBuT7TqfSbJCw7CP
         R0NcOJTGqv1UDha02V+NMsnOgVbo9gd4ADaf8SAIjS31ijWoPPhGrqHI0oF0H1Aqk5E7
         +LR/yYRzw/qNxkHZ/lvQ85olTtSnAcfaM0vg9VBSvaPnWOeATUpZVS7P5Mnho+Mz/a+J
         FRjAy2xK1BqDXZ78qGX6B4cYyfg+8eV6I90PCxh53xcaqMMme19b0YPiE0aa8Aug88p6
         r2Ne4DIYzM/GeSD5QGRlcvr1r4BZsCeBrSY6rbBcvNwkvimhYphzqUvL5wnxzkk+nDUn
         iT9A==
X-Gm-Message-State: AOAM531FLlf2bhnnEcBUb0R9Ef9+3sOEk2I0PzhiepxOVt+6f0srurD9
        4ZWdXOqe5DccSchBQzlFcRXpqg==
X-Google-Smtp-Source: ABdhPJy0YFaPET/B2NW9FwEvbgP3S2PwJhLr8+QIYcuGBkXXiDvrFI5Qn5U0UZYtVfnYkKW4HBdMdA==
X-Received: by 2002:a17:902:469:: with SMTP id 96mr3899228ple.93.1593201655931;
        Fri, 26 Jun 2020 13:00:55 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id p8sm23461610pgs.29.2020.06.26.13.00.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 13:00:55 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     gregkh@linuxfoundation.org
Cc:     evgreen@chromium.org, daniel.thompson@linaro.org,
        akashast@codeaurora.org, swboyd@chromium.org,
        kgdb-bugreport@lists.sourceforge.net,
        linux-arm-msm@vger.kernel.org, sumit.garg@linaro.org,
        vivek.gautam@codeaurora.org,
        Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: [PATCH 0/2] serial: qcom_geni_serial: Use the FIFOs properly for console
Date:   Fri, 26 Jun 2020 13:00:31 -0700
Message-Id: <20200626200033.1528052-1-dianders@chromium.org>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This series of two patches gets rid of some ugly hacks that were in
the qcom_geni_serial driver around dealing with a port that was used
for console output and dealing with a port that was being used for
kgdb.

While the character reading/writing code is now slightly more complex,
it's better to be consistently configuring the serial port the same
way and doing so avoids some corner cases where the old hacks weren't
always catching properly.

This change is slightly larger than it needs to be because I was
trying not to use global variables in the read/write functions.
Unfortunately the functions were sometimes called earlycon which
didn't have any "private_data" pointer set.  I've tried to do the
minimal change here to have some shared "private_data" that's always
present, but longer term it wouldn't hurt to see if we could unify
more.

Greg / Andy / Bjorn:

This series of patches is atop the current Qualcomm tree to avoid
conflicts.  Assuming it looks OK, presumably the best way for it to
land would be to get an Ack from Greg and then Bjorn or Andy could
land it.


Douglas Anderson (2):
  serial: qcom_geni_serial: Make kgdb work even if UART isn't console
  serial: qcom_geni_serial: Always use 4 bytes per TX FIFO word

 drivers/tty/serial/qcom_geni_serial.c | 129 ++++++++++++++++++--------
 1 file changed, 88 insertions(+), 41 deletions(-)

-- 
2.27.0.212.ge8ba1cc988-goog

