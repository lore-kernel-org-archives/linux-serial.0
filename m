Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41371C0015E
	for <linux-serial@archiver.kernel.org>; Wed,  9 Aug 2023 13:51:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbjHINvJ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 9 Aug 2023 09:51:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjHINvJ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 9 Aug 2023 09:51:09 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B84292113
        for <linux-serial@vger.kernel.org>; Wed,  9 Aug 2023 06:51:04 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-686be3cbea0so688411b3a.0
        for <linux-serial@vger.kernel.org>; Wed, 09 Aug 2023 06:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1691589064; x=1692193864;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=XZSZbnMxGCAQaiOpSsvGGxA9SQHJTADmzlPQy3XEacw=;
        b=gRYaeUtIwG7Vsj6K1gs1mw8g0NKm027QxgPMpJN3XS83Of3CN0gDtXTRiqfP2LUnTS
         MpezfI1H7RLZHUXUCJYiYNKU1Iv/CPcbmf5GD5ql/EjLssB/yM4Diz7haopmI4H4we1/
         E58q0yyDy8Y9M/ByN8h3EoEfOwpnlYyJH8YoLZorF6Q/dH+e4LmW4D6L0l0ld3Z3MuUi
         dVk/l2hAXWz1lmEzr3Ps2R4yAcqOIWdmRQk2sFSig8h/PH5M3j7GsZiZbgcAOgG9LpaY
         SBwV/De7DUvsQ1MtQ8MoH3lkmF88u7NaLVDtd97+0GG1h++3hPmyiHR1rwAGBrXxGSaj
         +GmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691589064; x=1692193864;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XZSZbnMxGCAQaiOpSsvGGxA9SQHJTADmzlPQy3XEacw=;
        b=Bq/iy31vUq2mDkzUDlJvUt9egPM1H1i4cst4If0IQdFztns49i9/BNqZ5pacFxglXV
         /1hkEuaVDazuZR0i90ui7t621gUNCQI1/HOmnyC2qwv1qVHcXov7agXRw4QMj/Q/G7Zp
         M0zoKYxtn1BsoP9BgWyebxgcDuXfXkaH1m9mfNFIxrXgtN349vDuRWRJXWJYSr/LEx/Z
         hQIDiqHbGkR6oIUziHu5/GqkXyhA37bDJWPw061RbTZ5cLYTMOYwACnk2c5mR/AXReM6
         +njwlZvZr1C6KkibtRPkCv3R9ZuEz8UPjJoihno8ixkA2hoMeywtdO0yORn7PKdC9Uho
         iT1g==
X-Gm-Message-State: AOJu0YwPK4xYvA5k+9Am23f3Cuw2eJLe9e4dxrcQorDtN9NryY9SHVGo
        VaB9byn8sgq/bTWNfl+KKbjDuA==
X-Google-Smtp-Source: AGHT+IGyRd7WJudjB3NASLPZ4tgpVvTHKIUwDcteCrieyWhPuWEJw66UxEJgD77KWtV9WrOp4w7wbg==
X-Received: by 2002:a17:90a:6e43:b0:267:f1d7:ed68 with SMTP id s3-20020a17090a6e4300b00267f1d7ed68mr3848999pjm.14.1691589064187;
        Wed, 09 Aug 2023 06:51:04 -0700 (PDT)
Received: from work.. (1-161-169-231.dynamic-ip.hinet.net. [1.161.169.231])
        by smtp.gmail.com with ESMTPSA id p12-20020a17090a284c00b00262ca945cecsm1542677pjf.54.2023.08.09.06.51.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 06:51:03 -0700 (PDT)
From:   Nick Hu <nick.hu@sifive.com>
To:     nick.hu@sifive.com, zong.li@sifive.com, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, palmer@dabbelt.com, paul.walmsley@sifive.com,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH v2 0/1] Add Sifive uart suspend and resume
Date:   Wed,  9 Aug 2023 21:50:41 +0800
Message-Id: <20230809135042.2443350-1-nick.hu@sifive.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Add Sifive uart suspend and resume functions for system suspend.

Changes in v2:
- Change Signed-off-by: Ben Dooks to Reviewed-by: Ben Dooks
- Remove the unnecessary check

Nick Hu (1):
  serial: sifive: Add suspend and resume operations

 drivers/tty/serial/sifive.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

-- 
2.34.1

