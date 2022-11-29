Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BDEEC4321E
	for <linux-serial@archiver.kernel.org>; Tue, 29 Nov 2022 11:00:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232420AbiK2LAV (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 29 Nov 2022 06:00:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232360AbiK2LAU (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 29 Nov 2022 06:00:20 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11ED45CD30
        for <linux-serial@vger.kernel.org>; Tue, 29 Nov 2022 03:00:19 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id a11-20020a05600c2d4b00b003cf6f5fd9f1so10509073wmg.2
        for <linux-serial@vger.kernel.org>; Tue, 29 Nov 2022 03:00:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=d+09qXh0NhML0ghMdZ0DgbukyltRXuBwI2pHrmUWaEg=;
        b=aSquoMEBUfqqZNx/uEVzgl071VU0ZOwyQWPRpbeEXU96Y3avMpBFlRUq1Rpid5Yxao
         fMT0/rjff15nWSXDg9YySgo1iaxKkNGGGhV3q6ObZIT+5ijZmN/oc//F9Mv6tfemKakN
         rh8+q5gmIZkHaIV73wUOu9gVQnCHElEn0+Mkxr1UzbDKB6/bcnFa7TGDG5u52tuVX/sP
         ND9tVSfB3ITk729cxtnq7ix5GV/zGY7c2HzZSmI+re3SFMkQtMpywYpkyA2l3IrfxC5w
         Tc+Vt7PDAAxHyTNmqAINR8mjJw/+qL7RMofvBVc70HtePpeKoAOKcDr2tDBJwON6jyIK
         Lmvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d+09qXh0NhML0ghMdZ0DgbukyltRXuBwI2pHrmUWaEg=;
        b=rTwXbqELwSx5U08Oqf9e9+Aqg6ZJwODILGD4O2TE2vsu8aoqbz6WdAmYrZjuRowrUG
         SpKJ88tFQJ+oeDfiK/NBOESPqtvkESZvXtyNDkP7KyK0xtS9RnrFS+z/ahbFa/AHNRlI
         y6lNKOVeqgDQNiepY1U9ieS8GXan95lhD9o3MI3uZjyJKFSa1+sSMkzh9tbyKV8MP5QC
         qeboWfVdiLavLXqaX1VM5SlUr71DIcuMtoQ+oyRP0y2qY8qsxVfHGDY+tizrHFirXG1E
         p/ojZC+wZnKwMDdGN2maMujOw8fi5dMzVuc8lisewSB6SGyJjUIMX8+HEAql8OUSfrLT
         DegQ==
X-Gm-Message-State: ANoB5pkQqhBJF/KihZEGoZOxIpmyz+cqayGMhHzHh15yiu4p40lbhjJQ
        XxTbC2Uf5jXcI1hvPPEMZJTylA==
X-Google-Smtp-Source: AA0mqf7AmoGP2gkcGOaBgu5TQ1VPz68+jGVyk5jZ7736C57Co5tY9pi6tibJNnULTszACJAzbfqSuA==
X-Received: by 2002:a05:600c:22c4:b0:3cf:71b7:7a41 with SMTP id 4-20020a05600c22c400b003cf71b77a41mr42246508wmg.31.1669719617513;
        Tue, 29 Nov 2022 03:00:17 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:6b19:1d8e:fbca:fd02])
        by smtp.gmail.com with ESMTPSA id q19-20020a1cf313000000b003a3170a7af9sm1617658wmq.4.2022.11.29.03.00.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 03:00:17 -0800 (PST)
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
Subject: [PATCH v4 00/13] serial: qcom-geni-serial: implement support for SE DMA
Date:   Tue, 29 Nov 2022 11:59:59 +0100
Message-Id: <20221129110012.224685-1-brgl@bgdev.pl>
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

v3 -> v4:
- don't assign NULL (even cast) to variables of type dma_addr_t
- refactor checking the SE_GENI_STATUS into two inline functions
- drop min_t() in favor of regular min() after adding some consistency to types
- check if the abort command was successful and emit a message if not when
  stopping TX in DMA mode

v2 -> v3:
- drop devres patches from the series

v1 -> v2:
- turn to_dev_uport() macro into a static inline function
- use CIRC_CNT_TO_END() and uart_xmit_advance() where applicable and don't
  handle xmit->tail directly
- drop sizeof() where BYTES_PER_FIFO_WORD can be used
- further refactor qcom_geni_serial_handle_tx_fifo()
- collect review tags

Bartosz Golaszewski (13):
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
  soc: qcom-geni-se: add more symbol definitions
  tty: serial: qcom-geni-serial: add support for serial engine DMA

 drivers/tty/serial/qcom_geni_serial.c | 628 +++++++++++++++++---------
 include/linux/qcom-geni-se.h          |   3 +
 2 files changed, 415 insertions(+), 216 deletions(-)

-- 
2.37.2

