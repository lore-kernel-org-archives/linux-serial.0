Return-Path: <SRS0=SyHF=5B=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51263C0044D
	for <linux-serial@archiver.kernel.org>; Mon, 16 Mar 2020 10:19:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2285F2071C
	for <linux-serial@archiver.kernel.org>; Mon, 16 Mar 2020 10:19:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KkD8vVLi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730509AbgCPKTi (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 16 Mar 2020 06:19:38 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:51019 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730478AbgCPKTi (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 16 Mar 2020 06:19:38 -0400
Received: by mail-pj1-f65.google.com with SMTP id o23so2297937pjp.0;
        Mon, 16 Mar 2020 03:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FTxMGCg1EXBjuYMzFIDNhNCbTH4T4tBiBgAU3fWNvNs=;
        b=KkD8vVLiheShu/m/7z91tSrWFnGZmUY5TMPEaFGI8UhKt5HSL87EdI9xCOW8oKcKHU
         TtZDALJfebmdB/20UMiRnIe6U7sBh2WoS47u9+Uc7OQpDehKU27B87213jTyeu/LG7fY
         fy936CFBqZQhv2UTlw/71EIbh7elzSz7F7c4GxeabZ2Xa5OroDXjib+cuBuCnC35Oos+
         62sEVyDbkGlilxEB6+ojhcvmE42lkuN8mfgQN+5maGMhRm7FFYL/z5vw1iRf/j5UGUgl
         MHNgBu7lqUKYfxcdV3frxpDccz9LA9M2C7n2wRtP9NrtITtIM+EK2ZvYlrDlEAiiU2bz
         ep5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FTxMGCg1EXBjuYMzFIDNhNCbTH4T4tBiBgAU3fWNvNs=;
        b=qgCKqPRWCBMYANEE98S7ckNaQDHekqGWrPr866BIggTBWSXAdoiTl10fplM0ZHStCB
         PStEtQ94nVy5gu9dMmLbnIo51M+Kh2IHDbd7arLGfQ1hWl/+7mHc4Bdqj0xxldnd3Gro
         n8NbfUyfT6bmA9c+HuR3cAVzkBS0b2q6bgz2LtdiHrTPcti0zG3zy+jx159Ui7ewlwE3
         jQfnYqSmijkBW0WWAQkQdkjx7vvQ/HPafh7cAdZmSb0DT4MR0u/qXfMqFP1eGveP+OpF
         r1m/bbCDBV4ANw4OhQJG/4IRHtFh0ZmH/75YNLqP9QCtIYr1jSHnKSjYxzRUWpXXmgYi
         WLAw==
X-Gm-Message-State: ANhLgQ3qpKbIRF9WxQHVvSkMNT72LA20JVSbUXATHTFhWiV8iSv5JRK5
        3M0CROAg0JGKaFek5mNGAJE=
X-Google-Smtp-Source: ADFU+vvuMkbljRCjC0N3Tw2Yx/mySQ7kAU5MMNbsMubHcmirNnc6xqckhddhe5lh/nBJGFrZ+kMVkA==
X-Received: by 2002:a17:90a:a102:: with SMTP id s2mr24577980pjp.46.1584353977509;
        Mon, 16 Mar 2020 03:19:37 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id u3sm21676491pfb.36.2020.03.16.03.19.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 03:19:36 -0700 (PDT)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Subject: [PATCH 0/3] a few fixes for sprd serial driver
Date:   Mon, 16 Mar 2020 18:19:27 +0800
Message-Id: <20200316101930.9962-1-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

Recently I found that sprd serial driver has a few problems if the clock
drivers were built as modules which were needed by serial driver, and the
serial driver would be postponed until those clock modules were installed.

Chunyan Zhang (3):
  serial: sprd: check console via stdout-path in addition
  serial: sprd: remove __init from sprd_console_setup
  serial: sprd: cleanup the sprd_port when return -EPROBE_DEFER

 drivers/tty/serial/sprd_serial.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

-- 
2.20.1

