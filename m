Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8797FC433EF
	for <linux-serial@archiver.kernel.org>; Wed, 10 Nov 2021 07:51:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BEA961130
	for <linux-serial@archiver.kernel.org>; Wed, 10 Nov 2021 07:51:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbhKJHyE (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 10 Nov 2021 02:54:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbhKJHyE (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 10 Nov 2021 02:54:04 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 450F1C061764;
        Tue,  9 Nov 2021 23:51:17 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id nh10-20020a17090b364a00b001a69adad5ebso939974pjb.2;
        Tue, 09 Nov 2021 23:51:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=naq9MF8VV9kR5yKKUweSk1wqNShjMTU+aiaAK1E3uIo=;
        b=M52S9sUsP7zq985LPVexc9dx9ozf9ZKv0+XOTcINNCASGZAesIXU5atiDpQQYA2Ji8
         mCt/13zdzPrLerU7bR+NINdeu8vnob2+XuzOlKbT/d6+/z+oZm6+tA7MDs/2STIW8QCL
         cV/06IdB+d5BBMf6ghgEzxslEiwD8v+7vhyVo5RJgp9K9o4HOzwwvlQB1ae8V9QMXPeJ
         tbe8Xi2b/+cf11ZHQhoLqx6tthcpO9A8r34iJfjARtKrl0N+UXQkGgfxhY7XuqwzalrW
         wIwVtg55asR9CHwQon9iYsuF1CdasRV8mf+c/qVsI6FmhoTjopBPqgfZbQtpnb6kaPmo
         OUJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=naq9MF8VV9kR5yKKUweSk1wqNShjMTU+aiaAK1E3uIo=;
        b=MG45GOs8Ktszpm1iUJMXac4A9yWC/XF+xVHPzQALiTUN3ubAv3LXM7e15EjAonjgKc
         JgM5nB0BFJ1boi13J5WIFDWzre2iGaunmrpmZ4Dppu/5r2LbYQcCAguhI6qTcyI9LNln
         pUUKZzTQIrDm8kkxSW6qdKUDjDRTc6di+S8YMEGqIfOmJPf/gXlCmGWlGCz8g6LfldRk
         so7n4OggqpujtcmNcFd8WSYKnoBeOeT5mIlMoTu8fy41MqX8Lqvbm3IgT+jnq0/QlaUv
         tNVldGYTeWdalUvyAr1M9g20HTMAKf064fQBlSURKGM4ngFymPJgG50yZi+CkBk4INxS
         ltfw==
X-Gm-Message-State: AOAM531TKNzVJ9WzVGpcEOGQDkY5OODIi5sY31uQ9czm7bnAzCppCvTr
        uVydiy0X8lGTsCWw4Tfw6WM=
X-Google-Smtp-Source: ABdhPJy0U/HWn55vNaYDfCUGejAVVrdojykaWTUqjFUhX6Xi97YYOLKHePoF2OxpYWgyjIAK+NQLyg==
X-Received: by 2002:a17:902:7284:b0:142:728b:46a6 with SMTP id d4-20020a170902728400b00142728b46a6mr13984591pll.45.1636530676840;
        Tue, 09 Nov 2021 23:51:16 -0800 (PST)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id p20sm9131838pfw.96.2021.11.09.23.51.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Nov 2021 23:51:16 -0800 (PST)
From:   Hammer Hsieh <hammerh0314@gmail.com>
X-Google-Original-From: Hammer Hsieh <hammer.hsieh@sunplus.com>
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, jirislaby@kernel.org,
        p.zabel@pengutronix.de
Cc:     tony.huang@sunplus.com, wells.lu@sunplus.com,
        Hammer Hsieh <hammer.hsieh@sunplus.com>
Subject: [PATCH v2 0/2] Add UART driver for Suplus SP7021 SoC
Date:   Wed, 10 Nov 2021 15:51:08 +0800
Message-Id: <1636530670-6995-1-git-send-email-hammer.hsieh@sunplus.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1635752903-14968-1-git-send-email-hammer.hsieh@sunplus.com>
References: <1635752903-14968-1-git-send-email-hammer.hsieh@sunplus.com>
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

Hammer Hsieh (2):
  dt-bindings:serial:Add bindings doc for Sunplus SoC UART Driver
  serial:sunplus-uart:Add Sunplus SoC UART Driver

 .../bindings/serial/sunplus,sp7021-uart.yaml       |  157 ++
 MAINTAINERS                                        |    7 +
 drivers/tty/serial/Kconfig                         |   23 +
 drivers/tty/serial/Makefile                        |    1 +
 drivers/tty/serial/sunplus-uart.c                  | 1591 ++++++++++++++++++++
 include/soc/sunplus/sp_uart.h                      |  147 ++
 6 files changed, 1926 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/sunplus,sp7021-uart.yaml
 create mode 100644 drivers/tty/serial/sunplus-uart.c
 create mode 100644 include/soc/sunplus/sp_uart.h

-- 
2.7.4

