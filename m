Return-Path: <SRS0=CVbj=7E=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B770AC433E0
	for <linux-serial@archiver.kernel.org>; Fri, 22 May 2020 05:57:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8640F20757
	for <linux-serial@archiver.kernel.org>; Fri, 22 May 2020 05:57:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fqfi1mU6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727992AbgEVF5t (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 22 May 2020 01:57:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727924AbgEVF5t (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 22 May 2020 01:57:49 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4FA2C061A0E
        for <linux-serial@vger.kernel.org>; Thu, 21 May 2020 22:57:48 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id p12so7457500qtn.13
        for <linux-serial@vger.kernel.org>; Thu, 21 May 2020 22:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=YjgtjdzgOt5xSWhbyThffOgIzedODiryOgrfEwykMhU=;
        b=fqfi1mU6xmdqplej5cXjZ7Xs+bJ0lw0Hx4feUN7TLiNdN3ok+HMlpLqulDVcI1/K98
         u3xEmb+V70tEvQH1ToWn1MGLzzKQiXAcvA45W2MqTfJpjRyoNNlzkwiBtTqrFRkWHdGA
         PXkLE1NDzwTTnRqmz9ZuRMCbYIUNJCkGaRdDeEB2a5uRcJiISnHRr1T5CZplReZZsgVS
         oNqbCXd6dK48G3B9MlPsow+oDPCQZz+/JQN0y4D7nZS5XE5I6mZUZ7o9T3WqP+OHebMN
         92oS6FhVWe5wD4tEbjc5V+4n7f+Qy5eLZt4HFcepXOviDQp1sh/Yp8d6FZ7xmO9Ec4Fj
         qeCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=YjgtjdzgOt5xSWhbyThffOgIzedODiryOgrfEwykMhU=;
        b=H2a0+/0opRhlbmHAXgfpLFhS9nU1cJQlQcCn9lII7Y/7RpC97GB4vxF9SOPvsQiwUK
         Sm856pVet/lPMdn6+bug88LUVWFg8/ehYQiqhfC47foU/6IM0QwFk3lSi3VZOD7slNNx
         J1p6GSt4UuJ/RYuPYLxPlUE8LKzH118xz6+SUMKSn+I8acAVuyN7AtvSpEvOeESLZlb5
         jM4ZEq3SF+602NI/z9ONCN3AfULwJx9F21zQcGvMoba92gG758JSOn6T0vY+0dlfvnJt
         Yd0vaJcQ9iOUgZswRDCPf38OZnGeEq7RX3v3Z4wWJOn2tXlKIOB1G8QtYrhdp+ZBT/Ia
         AfsA==
X-Gm-Message-State: AOAM532J0dVk/Bd8pybTwtLDA/+rD+FP1G9YFb5H4jlO4SyhA9uFB83k
        +vL3x620imNeUa0/lwUVh5azAwcw5q2nLkv/5F9Ne4pWd5c=
X-Google-Smtp-Source: ABdhPJzlA8Qn5m+PcsarJALelzgoVwciM0f2STYFIpvx5h6AVBWg/IjA703Z98qAKQS00IvhH9Fd7srm7FPm9Z8pFL0=
X-Received: by 2002:ac8:518f:: with SMTP id c15mr13700133qtn.142.1590127067582;
 Thu, 21 May 2020 22:57:47 -0700 (PDT)
MIME-Version: 1.0
From:   Zoran Stojsavljevic <zoran.stojsavljevic@gmail.com>
Date:   Fri, 22 May 2020 07:57:36 +0200
Message-ID: <CAGAf8Lw_BBOCsvZok-Fc6SB56XG1OCUbbeT=1N1_OKaiCkp63A@mail.gmail.com>
Subject: Generic CONFIG_SERIAL_DEV_CTRL_TTYPORT to be disabled to enable BBB
 overlay /dev/ttySC0
To:     linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hello list,

I have an interesting problem, which is described here:
https://www.spinics.net/lists/linux-serial/msg22566.html

I experienced the same problem on BeagleBone Black platform (armv7 A8:
am335x silicon), and the overlay is shown here:
https://github.com/ZoranStojsavljevic/MikroE_BeagleBone-Black_BSP-Integrati=
on/blob/master/BBB-debian_buster/Master_Example_i2c2_sc16is740.md

And the overlay written for /dev/ttySC0 is given here:
https://github.com/ZoranStojsavljevic/MikroE_BeagleBone-Black_BSP-Integrati=
on/blob/master/BBB-debian_buster/overlay_examples/i2c2_sc16is740/BB-I2C2-SC=
16IS740-00A0.dts

In order to solve this problem, I disabled the following option in
kernel .config:
## CONFIG_SERIAL_DEV_CTRL_TTYPORT is not set

But I am unsure why keeping enabled generic serial tty bus, and
disabling the generic serial tty device driver enables /dev/ttySC0 on
the target BBB platform.
https://github.com/ZoranStojsavljevic/MikroE_BeagleBone-Black_BSP-Integrati=
on/blob/master/BBB-debian_buster/overlay_examples/KERNEL.md

Just disabling CONFIG_SERIAL_DEV_CTRL_TTYPORT gives a working /dev/ttySC0 :

      =E2=94=82 Symbol: SERIAL_DEV_CTRL_TTYPORT [=3Dn]
      =E2=94=82 Type  : bool
      =E2=94=82 Prompt: Serial device TTY port controller
      =E2=94=82   Location:
      =E2=94=82     -> Device Drivers
      =E2=94=82       -> Character devices
      =E2=94=82 (1)     -> Serial device bus (SERIAL_DEV_BUS [=3Dy])
      =E2=94=82   Defined at drivers/tty/serdev/Kconfig:14
      =E2=94=82   Depends on: TTY [=3Dy] && SERIAL_DEV_BUS [=3Dy]=3Dy

Again, appears that the generic serial tty bus is enabled, but the
solution of the problem is to disable generic tty driver (not sure
why)!

I hope somebody already encounter this problem from this list.

Thank you in advance,
Zoran Stojsavljevic
