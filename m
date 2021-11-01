Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78971C433EF
	for <linux-serial@archiver.kernel.org>; Mon,  1 Nov 2021 07:48:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C9AC610CA
	for <linux-serial@archiver.kernel.org>; Mon,  1 Nov 2021 07:48:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbhKAHvJ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 1 Nov 2021 03:51:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230289AbhKAHvI (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 1 Nov 2021 03:51:08 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5B6AC061714;
        Mon,  1 Nov 2021 00:48:35 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id n36-20020a17090a5aa700b0019fa884ab85so15420194pji.5;
        Mon, 01 Nov 2021 00:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=DPRUkN4UYJ4ehGU1vqGJvGY8spGKX1XTX7s3COdufkI=;
        b=qm+ktYv8bXscYQRV0A7pzu0ib/6IAexyGGI6+Tk/J2Rl0iPi/nu48H6qPq8x41xtD6
         g0X7nJk18PlV56xf8GhsclT5SVl6qXgH00rqkl7W+bKacepjnhYjwe3AAaHNZOqFnRfI
         +WgrCqPZ+O8ABWzKXrutKXCWk6hn+Fk9SB5ZGEFcSkL6T4yCEyosJO0W9lcB96FpT/Jy
         QoIT2tH+qWQet/vJ1lUtJN1hTDOwl+4+qiOG6GXCfmz46XNTQTJai09l+ZiMPZhAXw0k
         reGKXwhtBrQso6RTJ3KElE/hSSOZzYn4WKa+9EGwAA0IMuNpZcCNZtbXi/5LQGXwbHoG
         uf7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=DPRUkN4UYJ4ehGU1vqGJvGY8spGKX1XTX7s3COdufkI=;
        b=LSc/2V4oneABwDRWtR0tgsW9DrV0d+A+T9ExQh9rbAg8gZCw89NsmSLgcUDdp8XouV
         USom1RTaOYnGkX4uyNEWzbSFkm/io/lNwv7v0xAkjEE2/dTK2ZwOng25F5dDrbcv0pKn
         eSYMmNtThvxbNgHUEcoH+C05Z3J1pNQ9idvmp9JL4ZZdRiDvi40GXVj5LCtYrtrZdBU4
         5zUpvzEOsi2ETb19V9U3JULTyoTtUsTtsVajftGXx2D1FA0qiDp7A3SfxkFI603tk7M5
         p5C5lVLM55KZ5gA9ugkTiQ56pyonrymFqu/QO1rb+E+10MfGNo8SbXQ9k6VB4nYMZbua
         ohvg==
X-Gm-Message-State: AOAM531QPAXvEf6S6xnxv7ALUkmNSoOOEFU87kqEJibVlTpEcqcgEwEA
        k4JVFR1STgv/Ia0LUqfMqnk=
X-Google-Smtp-Source: ABdhPJzashpjmiiiaOPoe2dohnmPBrdJhtpYvw3ir0JpDlnlpNSQFlZP6q8FGEnb0Iqumcg9WLiChw==
X-Received: by 2002:a17:902:758b:b0:13f:974a:959f with SMTP id j11-20020a170902758b00b0013f974a959fmr23351751pll.40.1635752915487;
        Mon, 01 Nov 2021 00:48:35 -0700 (PDT)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id z14sm13639061pfe.78.2021.11.01.00.48.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Nov 2021 00:48:35 -0700 (PDT)
From:   "hammer.hsieh" <hammerh0314@gmail.com>
X-Google-Original-From: "hammer.hsieh" <hammer.hsieh@sunplus.com>
To:     gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        jirislaby@kernel.org, p.zabel@pengutronix.de
Cc:     tony.huang@sunplus.com, wells.lu@sunplus.com,
        "hammer.hsieh" <hammer.hsieh@sunplus.com>
Subject: [PATCH 0/2] Add UART driver for Suplus SP7021 SoC
Date:   Mon,  1 Nov 2021 15:48:21 +0800
Message-Id: <1635752903-14968-1-git-send-email-hammer.hsieh@sunplus.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This is a patch series for UART driver for Suplus SP7021 SoC.

Sunplus SP7021 is an ARM Cortex A7 (4 cores) based SoC. It integrates
many peripherals (ex: UART. I2C, SPI, SDIO, eMMC, USB, SD card and
etc.) into a single chip. It is designed for industrial control.

Refer to:
https://sunplus-tibbo.atlassian.net/wiki/spaces/doc/overview
https://tibbo.com/store/plus1.html

hammer.hsieh (2):
  dt-bindings:serial:Add bindings doc for Sunplus SoC UART Driver
  serial:sunplus-uart:Add Sunplus SoC UART Driver

 .../devicetree/bindings/serial/sunplus,uart.yaml   |  116 ++
 MAINTAINERS                                        |    7 +
 drivers/tty/serial/Kconfig                         |   23 +
 drivers/tty/serial/Makefile                        |    1 +
 drivers/tty/serial/sunplus-uart.c                  | 1848 ++++++++++++++++++++
 include/soc/sunplus/sp_uart.h                      |  158 ++
 6 files changed, 2153 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/sunplus,uart.yaml
 create mode 100644 drivers/tty/serial/sunplus-uart.c
 create mode 100644 include/soc/sunplus/sp_uart.h

-- 
2.7.4

