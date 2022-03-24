Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C0F5C433EF
	for <linux-serial@archiver.kernel.org>; Thu, 24 Mar 2022 12:44:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350246AbiCXMpz (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 24 Mar 2022 08:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231998AbiCXMpy (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 24 Mar 2022 08:45:54 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD2AF387B2
        for <linux-serial@vger.kernel.org>; Thu, 24 Mar 2022 05:44:22 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id o6-20020a17090a9f8600b001c6562049d9so5012919pjp.3
        for <linux-serial@vger.kernel.org>; Thu, 24 Mar 2022 05:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8wFC9YW3CcXhHcZMHwjsfj1QBnxz6LwcdW4DyRFF18o=;
        b=NriUdSWmBtsn2giAdLdLQosCmOxQLZXzbPd7FQNTkkKWxGAXPW5IbYGnHVT3uv/pKQ
         c9vV5NGvoPftOkpkblOSNEss9ttnP4VtpVnh3PPKYg0AvGHKqlkYfiBrcQf9j1p3NPRI
         ckb6dD6KT34nZIefAwhpuSghjR4woe+De/LkQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8wFC9YW3CcXhHcZMHwjsfj1QBnxz6LwcdW4DyRFF18o=;
        b=krxHzYPta9FbavO/bZpydS8YBshnkOol20hmEeRagHmHtoFCLk5wDkd9wQ4dD615Jx
         yMyihCl35X0S3IMyS/7PN2wIWjpOpsux35rvIbs9gUsus7oo4EYYlEZHAcRtoY2znxNr
         4lLKBZiYkmvR7O+J8U/gqrjV7zWuK/bGQQCjkRZevH5Awg83D+nsN94qMFjsJDl7FUml
         /zvy0MKCcIaVsVsmPXDbn9M8Eivvym3rmGnj9xRwVa13WaiJ9uwGb+d0UEHAmLieGPJX
         BLvtPlue0870E4aIsjdnESbNFW348Bt8jzzA+/sI7q9L9H9wQNtUFMq8XyuKYYbYrzkq
         Pu1A==
X-Gm-Message-State: AOAM533HLjUVH+WbBC9YwNaSuGg5PUjh7sm/FeBzNFCyUH/fR1raXFW2
        W+f0SIEhX43K5Wr3chticdSO7Q==
X-Google-Smtp-Source: ABdhPJxoIxB2KJaE6zI+VE6S+D0JuAd+6GyosC1La9J70sxiaH8rfa0ODvZ0LyxtMx6HRcM/TNgwaw==
X-Received: by 2002:a17:902:c40a:b0:154:2302:9b88 with SMTP id k10-20020a170902c40a00b0015423029b88mr5704334plk.165.1648125862129;
        Thu, 24 Mar 2022 05:44:22 -0700 (PDT)
Received: from shiro.work ([2400:4162:2428:2f01:7285:c2ff:fe8e:66d7])
        by smtp.googlemail.com with ESMTPSA id t10-20020a056a00138a00b004fa9c9fda44sm3786924pfg.89.2022.03.24.05.44.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 05:44:21 -0700 (PDT)
From:   Daniel Palmer <daniel@0x0f.com>
To:     devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
        robh+dt@kernel.org, andriy.shevchenko@linux.intel.com,
        jirislaby@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        romain.perier@gmail.com, Daniel Palmer <daniel@0x0f.com>
Subject: [PATCH 0/4] Add support for MStar MSC313 uarts
Date:   Thu, 24 Mar 2022 21:43:58 +0900
Message-Id: <20220324124402.3631379-1-daniel@0x0f.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This is a fairly simple series to add support for the MStar MSC313
uarts found in MStar/SigmaStar ARMv7 based SoCs.

I have been using this for years now but I held off sending it because
I wasn't entirely sure the uart was actually a DW based design.

We got documentation recently and it refers to this being a "DW UART"
so I'm pretty sure it is now.

Daniel Palmer (4):
  dt-bindings: serial: snps-dw-apb-uart: Add MStar MSC313 uarts
  serial: 8250_dw: Add MStar MSC313 quirk
  ARM: dts: mstar: Switch pm_uart to mstar,msc313-uart
  ARM: dts: mstar: Add second UART to base dtsi.

 .../devicetree/bindings/serial/snps-dw-apb-uart.yaml   |  3 +++
 arch/arm/boot/dts/mstar-v7.dtsi                        | 10 +++++++++-
 drivers/tty/serial/8250/8250_dw.c                      |  5 +++++
 3 files changed, 17 insertions(+), 1 deletion(-)

-- 
2.35.1

