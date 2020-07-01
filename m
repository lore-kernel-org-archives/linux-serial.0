Return-Path: <SRS0=INAG=AM=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B7EDC433DF
	for <linux-serial@archiver.kernel.org>; Wed,  1 Jul 2020 21:13:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09498208B8
	for <linux-serial@archiver.kernel.org>; Wed,  1 Jul 2020 21:13:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X4N13e+9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbgGAVNo (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 1 Jul 2020 17:13:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726937AbgGAVNn (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 1 Jul 2020 17:13:43 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B37FC08C5DD
        for <linux-serial@vger.kernel.org>; Wed,  1 Jul 2020 14:13:43 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 13so13070747ybx.9
        for <linux-serial@vger.kernel.org>; Wed, 01 Jul 2020 14:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=1693jLPCRTZKv04e3tT1L2R/SD/azULEZvoSLa7Hf7o=;
        b=X4N13e+9sePnsNX3KaC3ifEpq8r8prYY7zHclzCR5upKpuH+zMAIp0a3v81FRPNLSQ
         G/oEf3GoGKzfnImMohbfzdfak484FP/LerO7QfZnV6oiJy5RkPeJ4JGyaWW4d/KoT+og
         xaCTxxyLWdrK4Iy5oj1E4JZQLNCwWwFK+QmJ/rHwp8YgFpakYgrdyJcDKvQ7Hhutimdk
         veAa42QeTkaDOUzn9UlIWlC4KV+uT51zeVpLjn2F2l8a/oToAXzSKFN4laYPXVsvB7KO
         IWeEQJElTFTPPbn1R8LGZw8Vc3cSYrMYEomRY+SMbjXzjp+LawK0qruJeF/TCA8JmuqR
         92mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=1693jLPCRTZKv04e3tT1L2R/SD/azULEZvoSLa7Hf7o=;
        b=g0kk9lGjt1MZXhUyDUcbHfRCq5RkmjVV34d7T7rkHOZPI32u147AK5paqGjk7foDZR
         qs4zObKuk2IM2SvtjJyNXOA83GLnN8K6FDJW0KVN2w0JhVacR4vTMBxNJeyp8GGUV1Bd
         UEfXbS1BL2zZKwovnqA5sMobeERas7Z1FzKNUOFVRMIxjTBGySB9QLTa1ZXj7ET+M/uL
         5zEriqJsxvGoVLGa3q4Xf6Hy7NbBwfo03iQSI8ktyeZWUmgfwPWHne7pBBPLN2XoG7ZY
         6NywxHjbfq1z54sJ3evU9ZA5Ksp14Rq4699/X3+G1uqi9/UiorUBKcqoUYvTIur2e74x
         Qhzg==
X-Gm-Message-State: AOAM533QfhGWxO0g1pvLtlbIRJdECcXGyqmkxG99+mhGTlj0YVtCgRjy
        s8CMr/sFtdwMTiD6tichWKkWmaKKT5clCnUBX5fmP4KiywQCO36wZ4RgBExD3XrCkmfKfQ6kxDB
        flIn+4lSIhot7id5TtXZckm9wpMri9rrtoxWCEvKtj3sew5U3wL77zkXT9lj64i32XgDCsfmqu6
        2GN9PEm+0euWEa
X-Google-Smtp-Source: ABdhPJz8wsHLEwNJYlVtw6qZZkh7AGzr6LYq5q8mwTBXuA/WiMwNXf+RKMjvBio06uTM33Rt9QsVW8X11w5NfovFi+WJ
X-Received: by 2002:a25:c7d3:: with SMTP id w202mr29331301ybe.84.1593638022312;
 Wed, 01 Jul 2020 14:13:42 -0700 (PDT)
Date:   Wed,  1 Jul 2020 14:13:36 -0700
Message-Id: <20200701211337.3027448-1-danielwinkler@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
Subject: [PATCH v2 0/1] Revert "serial: 8250: Fix max baud limit in generic
 8250 port"
From:   Daniel Winkler <danielwinkler@google.com>
To:     linux-serial@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
Cc:     BlueZ <linux-bluetooth@vger.kernel.org>,
        chromeos-bluetooth-upstreaming 
        <chromeos-bluetooth-upstreaming@chromium.org>,
        stable@vger.kernel.org, abhishekpandit@chromium.org,
        Daniel Winkler <danielwinkler@google.com>,
        Aaron Sierra <asierra@xes-inc.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Lukas Wunner <lukas@wunner.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


This change regresses the QCA6174A-3 bluetooth chip, preventing
firmware from being properly loaded. Without this change, the
chip works as intended.

The device is the Kukui Chromebook using the Mediatek chipset
and the 8250_mtk uart. Initial controller baudrate is 115200
and operating speed is 3000000. Our entire suite of bluetooth
tests now fail on this platform due to an apparent failure to
sync its firmware on initialization.

The driver is in the cros tree at drivers/bluetooth/hci_qca.c
and uses the serdev interface. Specifically, this is the
QCA_ROME chipset.


Daniel Winkler (1):
  Revert "serial: 8250: Fix max baud limit in generic 8250 port"

 drivers/tty/serial/8250/8250_port.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

-- 
2.27.0.212.ge8ba1cc988-goog

