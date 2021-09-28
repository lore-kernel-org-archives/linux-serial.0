Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A1CBC43217
	for <linux-serial@archiver.kernel.org>; Tue, 28 Sep 2021 09:52:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4712C611CA
	for <linux-serial@archiver.kernel.org>; Tue, 28 Sep 2021 09:52:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240048AbhI1JyU (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 28 Sep 2021 05:54:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240031AbhI1JyS (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 28 Sep 2021 05:54:18 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98E23C061575;
        Tue, 28 Sep 2021 02:52:39 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id y5so11348972pll.3;
        Tue, 28 Sep 2021 02:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1oFSusJI3/4w4LcwiFfnzL/FpVuCk9BqeEaMfG2qsO0=;
        b=cP59Mo6e6iAmGTDdh9NUaV7ZtX2jgcEBKFYID2vUJlwrYSKIIBLI14xcoYQBrgvcwu
         BJvdENkAaGLhpLWjuANJlfxan2ETRKb81z/zi2MdNQMSwntwC0n1crdqJfnQ18wXVZnd
         6E73XsE0GcFXqo/71e1+bevdM1YRASdaGY409JeZqNUvEP4BPftqWT7Rrs0B9HF00Enj
         Ma7y/3KQJhIw9UERSbAk7djdkvqLW2H0dheoAgoVRlFPgnETCkZ/Eb6eP0HFRmOYDIlO
         Vn3KkXPm82Cvzj7pLuG5FOIMyyBDyPHqnKwc2jDqeDtrg7Mvd3TpYJ0ZDVgGtvxhOGhc
         w85g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1oFSusJI3/4w4LcwiFfnzL/FpVuCk9BqeEaMfG2qsO0=;
        b=YPPO53zpJWQMJxCI+pl0nT3lecG02g5JfYhggvmsriwfd8Y6T1sru+5lZnJVw6p2W/
         180OTnXKyP82m2OO1FvPMVMzzIuMnF0bD5dSsLKJnX5fyPCamKU6AMmUDWhUvMGtnWHN
         845DVzrxw+6Uz4nUiB6JUYOCezXBwcFq9+UZ19U9otsey5tjNNWL7/rg15mnienpdcnW
         jsUsCBcmo+zeOX2fIOleR9IkWGurffZFL2hyk7a6NbitMnYzpDgiVnUn/5/shgDhQxE0
         dbvxArwtCLtXi9a5T+F2NhT8yMnNH6OT9BKo7QLjBcfHpz9BLlxGgKvcaHCzjB+UgJkU
         un+Q==
X-Gm-Message-State: AOAM5332pby1oDZyQ38nBSHNGG8Sl+jATVT8F/MXHAm9Sc+DvHKiCOAg
        3jO+WRqXCKiwtYlH3/0G5yg=
X-Google-Smtp-Source: ABdhPJxGT9R0neBM/g3aGQgpfNkx0/tbfhcvWj9mpIFtTcdcsyWdSOC4EtOItum5KeBz7juVyrnXBg==
X-Received: by 2002:a17:90a:9404:: with SMTP id r4mr4519916pjo.240.1632822759162;
        Tue, 28 Sep 2021 02:52:39 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id v7sm1950517pjk.37.2021.09.28.02.52.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 02:52:38 -0700 (PDT)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        Baolin Wang <baolin.wang7@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/3] Add Unisoc's UMS512 support
Date:   Tue, 28 Sep 2021 17:52:26 +0800
Message-Id: <20210928095229.233572-1-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

Unisoc's UMS512 has Octa-core ARM Cortex A55 application processor.

Chunyan Zhang (3):
  dt-bindings: arm: Add bindings for Unisoc's UMS512
  dt-bindings: serial: Add a new compatible string for UMS512
  arm64: dts: Add support for Unisoc's UMS512

 .../devicetree/bindings/arm/sprd/sprd.yaml    |   5 +
 .../devicetree/bindings/serial/sprd-uart.yaml |   1 +
 arch/arm64/boot/dts/sprd/Makefile             |   3 +-
 arch/arm64/boot/dts/sprd/sc2730.dtsi          | 262 +++++
 arch/arm64/boot/dts/sprd/ums512-1h10.dts      |  69 ++
 arch/arm64/boot/dts/sprd/ums512.dtsi          | 919 ++++++++++++++++++
 6 files changed, 1258 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/sprd/sc2730.dtsi
 create mode 100644 arch/arm64/boot/dts/sprd/ums512-1h10.dts
 create mode 100644 arch/arm64/boot/dts/sprd/ums512.dtsi

-- 
2.25.1

