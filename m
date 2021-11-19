Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A864C433F5
	for <linux-serial@archiver.kernel.org>; Fri, 19 Nov 2021 05:19:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D0A061B30
	for <linux-serial@archiver.kernel.org>; Fri, 19 Nov 2021 05:19:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231190AbhKSFW3 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 19 Nov 2021 00:22:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbhKSFW3 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 19 Nov 2021 00:22:29 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C885DC061574;
        Thu, 18 Nov 2021 21:19:27 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id iq11so7033230pjb.3;
        Thu, 18 Nov 2021 21:19:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KISB2UCF9N58Kzcwx4fmrlziVOKyZyEUixevjaxGGE0=;
        b=JKUz/CuszSp9DlKTjWM5AUNoEZuIIS1ZjZtoR/10gKpq8/g6Zsjp8KAoH2axkEAcON
         iutq6EQJp2PlFSUFiyg52DdfkP88sb9o0OOGMDksLp3Uy9/2YmW+KvTi9bRtto9yvjsH
         BcyznVbJfSsQPbiZxpoOHB0IQk7MKQ9zfkNsL9/vGIev3/MXbBYNHWqyWRLzv3wCzpwU
         022VrfLwlbCpBF9QJKyNSvOgOGnp1CzJ/eZWDSNDyH8GS/tUjUOeiWXjkRcJzo2SPfuQ
         1xzrmjmCxUBmrEfBI6UddydAVgd7k7SOeovB2NF2njmPbQUFW3ydHlpdMl9p0/+qa4WY
         xEXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KISB2UCF9N58Kzcwx4fmrlziVOKyZyEUixevjaxGGE0=;
        b=L2Nzjm7fr+w/mg8Db2YfE44i5ZEPQcuxNkLpUUpjXRQ+aSSJb+x1S6LxitL0hpt8Ii
         MJBPGl3n65EdIGhxIk5BUM62KxYlOpFL+/NoXR3uRACwmGmvBuBFs65h5lYChsqoJO6S
         aZP+OPZKvOUnxoOy12CYOjCqiPZKg9T3p75i+7oYITtaRZ3YGNczs5C3fZ5kpcR72vMh
         K1ODqYJ0bB2FnEat7gUuBUA7lPZThuojVbAK0JUtUAjD0pZTR7bXw4pbsh2IwDZjlesp
         285K1ffzfX4PjwKQT4nQcB0OdVleH9CFXWCJzkX+ILx/Wv4cUF4qahuKD+9w+YB22j4u
         LS3g==
X-Gm-Message-State: AOAM531lu9x+D/Cgse18Ys/G8dJQfzmmlRTmss61iyZ5pmOqDTcOXCvk
        wlTJD/Yi+YeoQp3orlMG+IY=
X-Google-Smtp-Source: ABdhPJySDJY5YyW+4BpjmBL1dlXWoGgjG3ZTcFf6EcfL0HjjWRi9TZ9XXBwD6h9e4s4asmXnebHC7Q==
X-Received: by 2002:a17:90a:2843:: with SMTP id p3mr1367783pjf.176.1637299167425;
        Thu, 18 Nov 2021 21:19:27 -0800 (PST)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id c2sm1332935pfv.112.2021.11.18.21.19.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Nov 2021 21:19:26 -0800 (PST)
From:   Hammer Hsieh <hammerh0314@gmail.com>
X-Google-Original-From: Hammer Hsieh <hammer.hsieh@sunplus.com>
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, jirislaby@kernel.org,
        p.zabel@pengutronix.de
Cc:     tony.huang@sunplus.com, wells.lu@sunplus.com,
        Hammer Hsieh <hammer.hsieh@sunplus.com>
Subject: [PATCH v3 0/2] Add UART driver for Suplus SP7021 SoC
Date:   Fri, 19 Nov 2021 13:19:21 +0800
Message-Id: <1637299163-6460-1-git-send-email-hammer.hsieh@sunplus.com>
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

 .../bindings/serial/sunplus,sp7021-uart.yaml       |  58 ++
 MAINTAINERS                                        |   7 +
 drivers/tty/serial/Kconfig                         |  23 +
 drivers/tty/serial/Makefile                        |   1 +
 drivers/tty/serial/sunplus-uart.c                  | 903 +++++++++++++++++++++
 include/soc/sunplus/sp_uart.h                      |  93 +++
 6 files changed, 1085 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/sunplus,sp7021-uart.yaml
 create mode 100644 drivers/tty/serial/sunplus-uart.c
 create mode 100644 include/soc/sunplus/sp_uart.h

-- 
2.7.4

