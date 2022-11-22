Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36336C4332F
	for <linux-serial@archiver.kernel.org>; Tue, 22 Nov 2022 10:22:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233208AbiKVKWN (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 22 Nov 2022 05:22:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233498AbiKVKVr (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 22 Nov 2022 05:21:47 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 589411DA7A
        for <linux-serial@vger.kernel.org>; Tue, 22 Nov 2022 02:21:42 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id l39-20020a05600c1d2700b003cf93c8156dso10916807wms.4
        for <linux-serial@vger.kernel.org>; Tue, 22 Nov 2022 02:21:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KCYmUoNLEWECSxLiDeK3zZweGQLAcBJOoW4I6ZR1gew=;
        b=7qzSmY3gSjeDV3Y94wgusDWy2XGVnwPFbkeSC5S4ylmgG1n4TowscBx+PjSl/Wflk7
         oWZqY8YGIVZ7do5yzReenaNh/xCrcPE/7+9cSU7nD53NAhHGo37KuiiPdi6Vq6qZMjpp
         CjKHnqGQR+NaR8XJYpYkzf/GAysJiKEel4J8yyis6V1dIXBaF8DfZ2c9I5WRLIzZpQGY
         7tRlhRF0Ui+sg+nTHd2Pys5B9gUATUqwSr0PllrsYtogcKzpbsZria+6tS8kstWM5hft
         YZksrmwUrK6kX9I9F0+cY/zDetDJhr2m30E69ccGr0q5bwNUmzas9JPX85WT0FUcRZ1I
         CeMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KCYmUoNLEWECSxLiDeK3zZweGQLAcBJOoW4I6ZR1gew=;
        b=Jk0N9xRAX6pcQ8XZzhrEJE5jccXKrr4kFyfER66kJ0wycIgVS/ZDmqRg+G0c+h93iA
         XV6F+Wd+hDGLikkaeW8bddnA2F+Eb3Ft5R2Dof0e8BaaZdjxCJ/JTPzwzytzGFkreqkT
         zDdUpInBoPs4P5Hrs7eu4H3OCFrf8jNS8zVX+MNvR5eEsNfUBzKut8KV0mg44db2A3dg
         UP27UCWVGi4/Uo0ENse/n7HTFnIEAx5nQaqwTzpNC70wZi4VK9mS9iFD7dJ8ubh4u5qT
         JGEiZflknE0FOohomCe8zXDOVSGvgr/JAY8KGTobR4V4jRiAgqFD2PozHl8Lzv0yTzzh
         bBdA==
X-Gm-Message-State: ANoB5plJUxCbnpOiG6ENXk1+AQgcKWAAeCiTxYYujyVinxlGygW4AZq6
        s4WbBMPdwU+XJmX73gcDyAuzCQ==
X-Google-Smtp-Source: AA0mqf7NHroE0cWTu2dxNSfxoeMDbw0wykM8B35qUHrtjNz23OEmkw3G+wIZ04aVmVQJuixcwvZlyw==
X-Received: by 2002:a7b:c852:0:b0:3c6:a8c7:755e with SMTP id c18-20020a7bc852000000b003c6a8c7755emr5023586wml.167.1669112500866;
        Tue, 22 Nov 2022 02:21:40 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:e011:9e81:66f1:3415])
        by smtp.gmail.com with ESMTPSA id o3-20020a5d4083000000b002366e8eee11sm13432873wrp.101.2022.11.22.02.21.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 02:21:40 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Alex Elder <elder@kernel.org>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v2 00/15] serial: qcom-geni-serial: implement support for SE DMA
Date:   Tue, 22 Nov 2022 11:21:10 +0100
Message-Id: <20221122102125.142075-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

The goal of this series is to update the qcom-geni-serial driver to use
the DMA mode of the QUPv3 serial engine. This is accomplished by the last
patch in the series. The previous ones contain either various tweaks,
reworks and refactoring or prepare the driver for adding DMA support.

More work will follow on the serial engine in order to reduce code
redundancy among its users and add support for SE DMA to the qcom GENI
SPI driver.

v1 -> v2:
- turn to_dev_uport() macro into a static inline function
- use CIRC_CNT_TO_END() and uart_xmit_advance() where applicable and don't
  handle xmit->tail directly
- drop sizeof() where BYTES_PER_FIFO_WORD can be used
- further refactor qcom_geni_serial_handle_tx_fifo()
- collect review tags

Bartosz Golaszewski (15):
  tty: serial: qcom-geni-serial: drop unneeded forward definitions
  tty: serial: qcom-geni-serial: remove unused symbols
  tty: serial: qcom-geni-serial: align #define values
  tty: serial: qcom-geni-serial: improve the to_dev_port() macro
  tty: serial: qcom-geni-serial: remove stray newlines
  tty: serial: qcom-geni-serial: refactor qcom_geni_serial_isr()
  tty: serial: qcom-geni-serial: remove unneeded tabs
  tty: serial: qcom-geni-serial: refactor qcom_geni_serial_handle_tx()
  tty: serial: qcom-geni-serial: drop the return value from handle_rx
  tty: serial: qcom-geni-serial: use of_device_id data
  tty: serial: qcom-geni-serial: stop operations in progress at shutdown
  tty: serial: provide devm_uart_add_one_port()
  tty: serial: qcom-geni-serial: use devres for uart port management
  soc: qcom-geni-se: add more symbol definitions
  tty: serial: qcom-geni-serial: add support for serial engine DMA

 .../driver-api/driver-model/devres.rst        |   3 +
 drivers/tty/serial/qcom_geni_serial.c         | 614 ++++++++++++------
 drivers/tty/serial/serial_core.c              |  36 +
 include/linux/qcom-geni-se.h                  |   3 +
 include/linux/serial_core.h                   |   6 +
 5 files changed, 455 insertions(+), 207 deletions(-)

-- 
2.37.2

