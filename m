Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4386BC3DA78
	for <linux-serial@archiver.kernel.org>; Fri, 13 Jan 2023 18:43:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229979AbjAMSnp (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 13 Jan 2023 13:43:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbjAMSnn (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 13 Jan 2023 13:43:43 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C149392F5
        for <linux-serial@vger.kernel.org>; Fri, 13 Jan 2023 10:43:42 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id j17so34352617lfr.3
        for <linux-serial@vger.kernel.org>; Fri, 13 Jan 2023 10:43:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rvVnDzmB7vtZ40bWPlhv9/lTTZEFrO1fNbWGIPYFVJQ=;
        b=MZNIG/PW0r4yIsr9HqFlVN0DnpDVVxQaVl5W6BvALYroCXLTuk1RlJz522URnpNfJ/
         R16aTZI4s5VATtTQ2cg+k6Me0rUhXuIeyLKlOz9YJNBenNlWEFXhSd/R4Op/CLL6q4zI
         v46vzhyU/bQajh+5VKscirj2WRPJDZC9TWpm1WU7gtrAU9Vu2dkCTQOvmB2fs41S049l
         sAHPUKHwMHJ59DxrhDmfJRmjR5uJ4bDgk/NOgw/AUKFqC2opv8gbtyfBbS4fkGTKx95e
         KIQGqHIC2TLVP9/eBbxNsY40/1uOsgqVtrchbbBaDK11WJscv4gqpT6fAIi4Yv1Mur5f
         e3aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rvVnDzmB7vtZ40bWPlhv9/lTTZEFrO1fNbWGIPYFVJQ=;
        b=jLa7zyqqgoANbv8htNEmHagpqpGE2/rjWPn5OEo51hRxYUXJDJkTHh/nYSEZz3pfsN
         lJidsST9VodXNOT1foZzkcYswGq+Vh50Iy1gs5S+Ib7SYyCbV9DljDsQQ1dNtQwk0BN1
         5CxMP/HKMwTbF03ogbZZ61Xx/SSe6vjUbTziHpK7aBFOtf0Enq1eCXdBMzrP6ZSB8kyo
         GMFQ6aV8HFj9ESl+VZMbGPRMV3roajP+5LZMPgsqDpgHtliuJPI3davEliWpYpfeJZwG
         Gbcejlh/2sGVW60EytjGgLDvhtPBx1cdAnW/WdV0OkSNi482WT98kLEU4nuTrf0zyZ96
         7DNw==
X-Gm-Message-State: AFqh2kp2qRw91Yk21y83JJX5i8FblfCOcdozsxfLsM1phlGpfPbnt+Xq
        Gpz2khAgaNAaqCmrftAli/HRPOCeJ1Y=
X-Google-Smtp-Source: AMrXdXv5Zpqy4SsYnG6NdqnaFGNGolU0laGYsdoGVyZUMtV7siQcvoJUH5DvQg5SYQbdNvbb3T3YBg==
X-Received: by 2002:a19:8c51:0:b0:4b6:ed1d:38e9 with SMTP id i17-20020a198c51000000b004b6ed1d38e9mr240411lfj.64.1673635420064;
        Fri, 13 Jan 2023 10:43:40 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id o11-20020ac2434b000000b004cc9ddce3adsm1261439lfl.82.2023.01.13.10.43.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 10:43:39 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     linux-serial@vger.kernel.org
Cc:     Fabio Estevam <festevam@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Richard Genoud <richard.genoud@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Tim Harvey <tharvey@gateworks.com>,
        =?UTF-8?q?Tomasz=20Mo=C5=84?= <tomasz.mon@camlingroup.com>,
        linux-arm-kernel@lists.infradead.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sergey Organov <sorganov@gmail.com>
Subject: [PATCH 0/8] serial: imx: work-around for hardware RX flood, and then isr improvements
Date:   Fri, 13 Jan 2023 21:43:26 +0300
Message-Id: <20230113184334.287130-1-sorganov@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <87bko4e65y.fsf@osv.gnss.ru>
References: <87bko4e65y.fsf@osv.gnss.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

These series contain a work-around for hardware RX flood in first 2
commits, and then further cleanups and optimizations of the receive IRQ
handler.

WARNING: the flood fix is extensively tested with older version of the
kernel with DMA turned off. The DMA path is tested only a bit, as DMA has
receive problems on my kernel version.

Sergey Organov (8):
  serial: imx: factor-out common code to imx_uart_soft_reset()
  serial: imx: work-around for hardware RX flood
  serial: imx: do not sysrq broken chars
  serial: imx: do not break from FIFO reading loop prematurely
  serial: imx: remove redundant USR2 read from FIFO reading loop
  serial: imx: stop using USR2 in FIFO reading loop
  serial: imx: use readl() to optimize FIFO reading loop
  serial: imx: refine local variables in rxint()

 drivers/tty/serial/imx.c | 227 ++++++++++++++++++++++++---------------
 1 file changed, 141 insertions(+), 86 deletions(-)

-- 
2.30.1

