Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BA6AC2D0A3
	for <linux-serial@archiver.kernel.org>; Thu, 12 Nov 2020 10:59:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D6FF2223C
	for <linux-serial@archiver.kernel.org>; Thu, 12 Nov 2020 10:59:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HNdpyV7a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727920AbgKLK7V (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 12 Nov 2020 05:59:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727899AbgKLK7D (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 12 Nov 2020 05:59:03 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF163C0613D4
        for <linux-serial@vger.kernel.org>; Thu, 12 Nov 2020 02:59:01 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id j7so5536283wrp.3
        for <linux-serial@vger.kernel.org>; Thu, 12 Nov 2020 02:59:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aXOen+8cDvbkQAmhP2VMdvcfueqQPLwH4EHxkqna6XE=;
        b=HNdpyV7aDMczpSDYYNSu8DNyhoanVHdWF1+iMlkeFlWh8Vi59qRbIegaCiJEg7OOYz
         xSOUwM0NQpPHvI10pnr8hkHKkDAdqqBELcAONBmn3UHa61X5sthGM/R0y+SyhtLNPm+E
         gYNiSVovf3bxP2Sa+f1d/PuirJ/qykAjg4kL7LZHruOUvaUUzteXOrtfhanbTfbEm8VQ
         0fiBodMQHy9765SqRK/9bYJUs95xz2kDzfxaLdQchH/N/OEEMM6+/UcgaDAEp7miafWO
         fC2wo+XZMJZNZq8Bwuc4oMFKKhms4XevqlSWLwz5f4ipb20k5qAlS781pND0kvpyLA5i
         1j9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aXOen+8cDvbkQAmhP2VMdvcfueqQPLwH4EHxkqna6XE=;
        b=YpGaaNtRulCa27Qav9nbB+yRzrhPvOmY9uOFgeozjv/jDipn9J48CET22DHecjqbg9
         t2dmvk5brgCZEV8vNGfVRI7/tR9HGVcKdZ11hzx4G/N67GplownT4F6G+doU1tmJcNEf
         QdpfjE4E0duM8hquzDNRjxB7pHUq7NM93qvT/9dZVvzNHwdXw84BSUKjKL9dLWlxoKty
         d8pmub8WikgsssLasqfSWCygzDuUCtVIVNPpMFBmQJoSbJ/JqcKREm/iGFLurykDn1Pb
         FKmBtmbX+le4x9qykuCw6TpD9Rv4hOoy+3szJaNMl4X/qMWWv8b4HIdjS78TK5gSwhGD
         Thcg==
X-Gm-Message-State: AOAM531juaYEfhLXNcDoCa0kZkakSy/wGK7BcTxNMkK/5d41ahxxbPOo
        gWk62fNtiPWRMB5o9HDpcTccNw==
X-Google-Smtp-Source: ABdhPJxMBmN1sLHdVutKtUTzgvWnLK6EqMEP7/1MvsJFyNoEdtMm76qKxyP2yshYdjDAU3getCWXPw==
X-Received: by 2002:adf:8030:: with SMTP id 45mr34391429wrk.407.1605178740741;
        Thu, 12 Nov 2020 02:59:00 -0800 (PST)
Received: from dell.default ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id u5sm1167239wro.56.2020.11.12.02.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 02:59:00 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linuxppc-dev@lists.ozlabs.org, linux-serial@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Mike Hudson <Exoray@isys.ca>, Paul Mackerras <paulus@samba.org>
Subject: [PATCH v2 0/4] Rid W=1 issues from TTY
Date:   Thu, 12 Nov 2020 10:58:53 +0000
Message-Id: <20201112105857.2078977-1-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This set is part of a larger effort attempting to clean-up W=1
kernel builds, which are currently overwhelmingly riddled with
niggly little warnings.

v2:
 - Remove unused variable completely
 - Remove unnecessary 'extern' keyword

Lee Jones (4):
  tty: tty_ldisc: Fix some kernel-doc related misdemeanours
  tty: serial: 8250: 8250_port: Move prototypes to shared location
  powerpc: asm: hvconsole: Move 'hvc_vio_init_early's prototype to
    shared location
  tty: serial: pmac_zilog: Remove unused disposable variable 'garbage'

 arch/powerpc/include/asm/hvconsole.h     |  3 +++
 arch/powerpc/platforms/pseries/pseries.h |  3 ---
 arch/powerpc/platforms/pseries/setup.c   |  1 +
 drivers/tty/serial/8250/8250_early.c     |  3 ---
 drivers/tty/serial/pmac_zilog.h          |  8 ++++----
 drivers/tty/tty_ldisc.c                  | 10 +++++-----
 include/linux/serial_8250.h              |  5 +++++
 7 files changed, 18 insertions(+), 15 deletions(-)

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-serial@vger.kernel.org
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Mike Hudson <Exoray@isys.ca>
Cc: Paul Mackerras <paulus@samba.org>
-- 
2.25.1

