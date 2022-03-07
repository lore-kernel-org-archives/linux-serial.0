Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FAB0C433EF
	for <linux-serial@archiver.kernel.org>; Mon,  7 Mar 2022 08:08:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236056AbiCGIJQ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 7 Mar 2022 03:09:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236047AbiCGIJP (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 7 Mar 2022 03:09:15 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B8251A387
        for <linux-serial@vger.kernel.org>; Mon,  7 Mar 2022 00:08:21 -0800 (PST)
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 888073F1C9
        for <linux-serial@vger.kernel.org>; Mon,  7 Mar 2022 08:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646640499;
        bh=sgZCTz7Fe6W/u7IUGDX3n8sJGTarRFqwDIQ3hjVamCE=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=J8YIp9RT3DaV71aYNq9J8mAxyFMdXoL2uFxtKzHtiSXxnRCKRaFa5getNNbu9k68y
         /qMEkB680m1PU8jKKYgIk8h7vsUYAAnFthi0Sr747tE8uJ9U45605MhPpqTFwahvQn
         wjAmVJ0yCf2tsDk5R8ruxcO+uC1WNZjowNhqwDkDNRbJyPBGW9ctrMxSk3NtjyaAkv
         tpm8KAfldXVULnZelqLOMCcWS/ZB8ky2ws03Et90KOZnerZxZLkUwnU2YzBEZloUww
         F91VjeAUDjtjLnMRJWoxmc83x/ehPiZIMkvY/bP5HWqtRADvUNHgZM8CFIXAtO8ZBP
         SQbJMIbTpckIA==
Received: by mail-ej1-f71.google.com with SMTP id ey18-20020a1709070b9200b006da9614af58so4572474ejc.10
        for <linux-serial@vger.kernel.org>; Mon, 07 Mar 2022 00:08:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sgZCTz7Fe6W/u7IUGDX3n8sJGTarRFqwDIQ3hjVamCE=;
        b=6UjKhbXaZMzSa1uvLK1fw/OkrA8eMSQ8cWFCV8L5bZeSOvJayTiAft36PZq1Hw5ITi
         ee9KuJVwcgVBWMoE/zmv1jde8Wezj2vVGXDzwCfhjcT8Xk5uW67Rv11BCtQCS90Vb+Fs
         N0VlABOKumSMN9gHCIMbxFZrEdoml+qi7wt5dU8XY0SXwn4FgurSblMGBcrMi4jeXaxy
         xLZLWBIvHkJofDjgZyDl7Vs0YLptZCX2uVQrYmIJQWC9FdyPlaYet+9Y4IRTduL7MEIK
         UfoCFbitIMWCQSt2uGswGIzPDBPNfYXXT1qEw3MWm3m9YIZT1atUo/aB2hlJY4lnt+y6
         4vKA==
X-Gm-Message-State: AOAM5327Bh/RZ5zo71yzBg7ehxKiY92+8UAqSxUyCfFQWuScvCJpdt8Q
        Hvd/a/Wk+R4wOq+LbBDSgDW8jvJTI1QBSn05FUbRnocTqVujYuxd5IQbm3HQQRebKyZni9gJnn+
        Q+XeFvDO6QmJnqib2nwuC6KeIRNCODIjvs2OHBGTk4g==
X-Received: by 2002:a05:6402:10d5:b0:408:f881:f0f3 with SMTP id p21-20020a05640210d500b00408f881f0f3mr9937656edu.112.1646640499311;
        Mon, 07 Mar 2022 00:08:19 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzKrQ1hAkY0V7VoNi5tDyMXCwOUq6E52GbFcMd0p9HOHtzn/DMrzsm+17bd370phdDA20dUhw==
X-Received: by 2002:a05:6402:10d5:b0:408:f881:f0f3 with SMTP id p21-20020a05640210d500b00408f881f0f3mr9937636edu.112.1646640499158;
        Mon, 07 Mar 2022 00:08:19 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-174-239.adslplus.ch. [188.155.174.239])
        by smtp.gmail.com with ESMTPSA id fs6-20020a170907600600b006da8ec6e4a6sm4444584ejc.26.2022.03.07.00.08.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 00:08:18 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/7] tty: serial: samsung: minor fixes/cleanups
Date:   Mon,  7 Mar 2022 09:08:03 +0100
Message-Id: <20220307080810.53847-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi,

Changes since v1:
1. Patch 3: remove unneeded parenthesis and module alias change (Jiri).
2. Patch 3: move unrelated "constify" bits to patch 6.
3. Patch 5: fix typo.
4. Add review tags.

Best regards,
Krzysztof

Krzysztof Kozlowski (7):
  tty: serial: samsung: embed s3c24xx_uart_info in parent structure
  tty: serial: samsung: embed s3c2410_uartcfg in parent structure
  tty: serial: samsung: constify s3c24xx_serial_drv_data
  tty: serial: samsung: constify UART name
  tty: serial: samsung: constify s3c24xx_serial_drv_data members
  tty: serial: samsung: constify variables and pointers
  tty: serial: samsung: simplify getting OF match data

 drivers/tty/serial/samsung_tty.c | 225 +++++++++++++++----------------
 1 file changed, 109 insertions(+), 116 deletions(-)

-- 
2.32.0

