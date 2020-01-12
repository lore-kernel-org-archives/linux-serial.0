Return-Path: <SRS0=EMO6=3B=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7C32C33CA2
	for <linux-serial@archiver.kernel.org>; Sun, 12 Jan 2020 18:11:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A472214D8
	for <linux-serial@archiver.kernel.org>; Sun, 12 Jan 2020 18:11:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rYRQ9gfR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733090AbgALSL6 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 12 Jan 2020 13:11:58 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37473 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728211AbgALSL6 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 12 Jan 2020 13:11:58 -0500
Received: by mail-lj1-f194.google.com with SMTP id o13so7519950ljg.4;
        Sun, 12 Jan 2020 10:11:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Wk7Ak6kU1DxFZaH2IkQYiSLzwBzI4ulZa0ve89UBNdM=;
        b=rYRQ9gfR4DVB6VsvePCbuhGkkPMI2P/I5Xij0VxNDpQj7homrUvjumwwUDY4UW2pRY
         iku2G1cbkVkfifWz7lOMaL2Ji5P/TixrcNH3fx0N0ZNuuVihxk6mEqJqSRBL04ilJfKo
         ySAZFlUSkqh90dxQ81sIFLv1MFK3a5DTVIbHvVv9ABXH5iQs2dQ7JbAlps0VuTGvJIZA
         C/jmXy+4xwOoLXkV7yuIimyc/Rzy9k6zJGGQxQKynSmkOOWAN9iTNVqrYYZtukDRBeU8
         dRMsbXc9eHmPXwiILeJXdSRZQEtcC1MFU02jj8gRuuooc/+apNXSqYbj2u1ihlek7g0I
         /4zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Wk7Ak6kU1DxFZaH2IkQYiSLzwBzI4ulZa0ve89UBNdM=;
        b=DIiHGh+0tlpp8fRdnWISVh3Kjp1hk30NOzrAuUq+vHVbIoDpenNwOKJhAwGrXa8fMT
         U5UIUHUYKoy3pHFjt9pIdUgDHYkFXorroneciNS7GyEJPJysd+A3m+vvt5zRF1yFwY2j
         wKZnz8nTopEuhxHF78wfdAVc4EyWI9Wqlo7tvsxeK+OzIrWyM4bZ+SQimCfkKWQ9OdWC
         cMu3jepS3zGc2abOOtB+w71utc+J1qD1Bk508pMCiLP+P0SS8Rt80B6D0R0+qXWOTQcV
         /STgw5L5ElSlit7QoIMQg3jz1xlXLd861oKn5ugSa8r5O0w9tVre5IWVprbmmrlQOgFu
         oAAg==
X-Gm-Message-State: APjAAAWHPurvrSQT8gwteYgWKVvhGuNRWIx8HJQAJvflAjgcPWpdm5hb
        LuUWZSOAmKDxwy9/1kRG9WM=
X-Google-Smtp-Source: APXvYqwnRt9hIqF5ldWMJYF8oM9wgKv3fTLzx8EXRVWW24Thkgi0BlCjYpwBMrxZr/e//Tghy8kO5g==
X-Received: by 2002:a2e:b0f5:: with SMTP id h21mr8781711ljl.9.1578852716636;
        Sun, 12 Jan 2020 10:11:56 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id 195sm4542784ljj.55.2020.01.12.10.11.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jan 2020 10:11:55 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Laxman Dewangan <ldewangan@nvidia.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     linux-serial@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/2] NVIDIA Tegra serial driver improvements
Date:   Sun, 12 Jan 2020 21:09:17 +0300
Message-Id: <20200112180919.5194-1-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hello,

This series is a complement to [1], which changed APB DMA driver's runtime
PM to make DMA clock enabled only during of actual transfer activity.
Unfortunately turned out that it wasn't enough because serial driver keeps
RX DMA active all the time in practice and that's what the first patch of
this series addresses. Secondly, I noticed that DMA synchronization could
be improved, it is also addressed now. Please review and apply, thanks in
advance!

Dmitry Osipenko (2):
  tty: serial: tegra: Activate RX DMA transfer by request
  tty: serial: tegra: Optimize DMA buffer synchronization

 drivers/tty/serial/serial-tegra.c | 94 ++++++++++++++++++-------------
 1 file changed, 55 insertions(+), 39 deletions(-)

-- 
2.24.0

