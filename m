Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B6B9C6FA82
	for <linux-serial@archiver.kernel.org>; Fri, 23 Sep 2022 15:30:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231406AbiIWPaM (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 23 Sep 2022 11:30:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232542AbiIWPaL (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 23 Sep 2022 11:30:11 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38189A025C;
        Fri, 23 Sep 2022 08:30:10 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id u16-20020a05600c211000b003b5152ebf09so981814wml.5;
        Fri, 23 Sep 2022 08:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date;
        bh=gg7c3+nPaOD0UzlmBSknHTXtYlfYqSbcyWP/vuEk7iw=;
        b=AdqWNyJmseV6WkMJUgNEnikY3m5LuH3gfZwjmnoZmqoNeG7+bJYlRYwdr3WDrFIDtp
         uWJCiknjsHSeVTL4PTPcH5pXuUt1EEmRw1uJdffkceAgBhE+VivNBfKFZFLuJrIMd8db
         xTuzchA6U2Z8C5R+GtV9smjSqJQzc1YkkfZJb9L32Gr2zlGz0DmYpyGKfumF9iFKgPPv
         nsswJBKkSBRXgsLrDEhcDxBr3HfYVqUGw6NVQbLcapstY0itJt63tn3e22h1beIodCoQ
         lgLJYFjR3M1HWM7sD59Rjryd2iKlu0scsSLKOCrHtB2mxRhuyGP+V+Aos5yvyDkfNY27
         2eCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=gg7c3+nPaOD0UzlmBSknHTXtYlfYqSbcyWP/vuEk7iw=;
        b=kfVa+LDvmHIviYFtwQpySNLhwzzwSA1Br9Rg4HFZbexcItlD7JMdxy3DT82HxwFs31
         scFtiurd/zd6udVtaKJfdPX8LJ3+zcLvCusX8U8unBdBrLfpnuo46f8T5JsVrtooewGK
         867rlnnnLCJv3Sxzy/PYuugyv2atSChwLjCYsQuVlN2YkgBNgVRkDizyflVScKiIB0+4
         SUY6/PyBugaU4gpb4hsvTLUHUJU9Vwdxu+wnTGLTJW8+2eXtPeCt3xwpcYXp4IA+APe3
         JjXmpXYIEcm/cwVoU+SytKN0agdSixXWf4JX1L1paVCuQd5zGBHN3WukBdUnu9nNWqik
         S6Cw==
X-Gm-Message-State: ACrzQf1y3WXa5s4j2L86/ISYOmCWkwtOM77CeefpGMrH+DfHL0/mBsfu
        ZyDoVxaV5V2OeBhTuDXTYL9BIxWaHLSEYl7CUAk395XyiuI=
X-Google-Smtp-Source: AMsMyM5RTWD4gU/b2HEuIL0niREH20lZYx8/WgJjmlRiiIZpt6drIFCBzdIEnFEi4AQh9EeHig0PGCUiPV7ptw59K/8=
X-Received: by 2002:a05:600c:4e44:b0:3b4:bed2:4f5e with SMTP id
 e4-20020a05600c4e4400b003b4bed24f5emr13737730wmq.193.1663947008663; Fri, 23
 Sep 2022 08:30:08 -0700 (PDT)
MIME-Version: 1.0
From:   Jeff Harris <jefftharris@gmail.com>
Date:   Fri, 23 Sep 2022 11:29:52 -0400
Message-ID: <CAGMfbUO=Zy_nXJ9wKV5r2xRBuK7_X3kL2TvM1jWB_hTPUvhnbw@mail.gmail.com>
Subject: serial: New xr20m117x driver questions
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

I have a driver for the MaxLinear XR20M117x family of UARTs that I'd like
to contribute but have a couple questions.  The driver is heavily based on
the existing sc16is7xx driver.  The driver started with the sample driver
from MaxLinear for Linux 3.x.x, but as the integration of their driver
proceeded into our 4.4 kernel, there were features and fixes missing that
were present in the current sc16is7xx driver.

The register set is similar, but there are a few places where the behavior
is different.  Would it be best to create a new driver or add the XR20M117x
UARTs to the sc16is7xx driver with a flag to choose one behavior or the
other?

I have developed and tested the driver as a back-port of the mainline
sc16is7xx driver to the 4.4 kernel used on our embedded platform.  I don't
have a ready method to test the driver with a newer kernel (other than
ensuring compilation success).  Is that a concern for accepting the driver?

Part link:
https://www.maxlinear.com/product/interface/uarts/i2c-spi-uarts/xr20m1172

Thanks,
Jeff
