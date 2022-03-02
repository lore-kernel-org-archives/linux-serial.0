Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80D88C433EF
	for <linux-serial@archiver.kernel.org>; Wed,  2 Mar 2022 18:47:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244726AbiCBSsW (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 2 Mar 2022 13:48:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244733AbiCBSsT (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 2 Mar 2022 13:48:19 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D66A21FCE7
        for <linux-serial@vger.kernel.org>; Wed,  2 Mar 2022 10:47:30 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id a5-20020a05600c224500b003832be89f25so1859054wmm.2
        for <linux-serial@vger.kernel.org>; Wed, 02 Mar 2022 10:47:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=MpvCyxznyLabHDrCm6rxmu/VcYL7AfSNQy5WoDg3Fdk=;
        b=ayveQov114rzdlOFH4/hjKrRzVe1xWuYzjAycj5mqqFmad/+jLmn8y7Hm27dj5+bmx
         mngdcgnWBq9/ixt1F9pWhhsJ6V4O13Cc8nY5l4Pr6fdpd1NDtgqSYyNOE7Ob1HQoIEHp
         HuDdCoxkgOOzZBoO/nV8uCgUKGyzndhKvOrNt3iapEndCmv40LEJ2+A5ujVOUIDUqeos
         QOO+y9ZnZkFCAvTXGC9EP3Aa8rZFzjc3cRa4dj716mFq9Ov0BkpJQsF7whbLzJP2Yen0
         6jv89ovTeF/503euJDjpIdsxn7G1khf7WDTeJNHdRlL0wjxZ6PGWO2RO2E71mkWnGrt0
         4Ebw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=MpvCyxznyLabHDrCm6rxmu/VcYL7AfSNQy5WoDg3Fdk=;
        b=X7C2/njCDVJsDg1bJltfXAxMTBcdFoATHbX0X7eiW7Z1Cdlse/2QU676FouHUd4zM2
         HJWKhFuiYuUQOXqCNC/QmO4Y6tasQtHSJU5JFNOGkqgOknoKUDjrV/Q0diRqqQfjqD/R
         z3wL2lv9YRiaMKKFalBG0HvT17IU02clSvemP7VTJnX2cqKeJjzgQYQmvaf3oOSgSuQQ
         AGva9iZs1GkTbVsRoRh6eemygPD/1ZO/B5jqxdtJ+dLfryzrBTayb3cz8XOGwnI3Fj0p
         hwRwgzOOsmQGZUoryJEx78nP5RqWlbZ1O44iHQETV3CTInl8x6xBMQdie1111Tg+OaZL
         uNyA==
X-Gm-Message-State: AOAM532+DoF9+q5w9q3iR+CWaAQBG4sbqrY/n+lj+yYcIjCM4QxiN3nQ
        Tc6mKmpf0JGpQQsAfg7qXwv0Y+/hXZ+vu7zXZoFWnuGj0UM=
X-Google-Smtp-Source: ABdhPJx4VlG1uLw1X5Man8cUwPPgKNcGQCipMiyzRhUmmZmAGg1kwq3n154Io85dgiVJFX0rFT0PS9EC9zejVXlq1dE=
X-Received: by 2002:a05:600c:4f11:b0:381:84d3:c9b5 with SMTP id
 l17-20020a05600c4f1100b0038184d3c9b5mr967793wmq.34.1646246848798; Wed, 02 Mar
 2022 10:47:28 -0800 (PST)
MIME-Version: 1.0
From:   Dawid Buchwald <buchwald.dawid@gmail.com>
Date:   Wed, 2 Mar 2022 19:47:17 +0100
Message-ID: <CAHxGD_vXqJS-6W6AS2hc7H-2ht8Ofy16faSpgaqoDArk3CY0Qw@mail.gmail.com>
Subject: [PATCH] Support for new variant of PL2303GS adapter
To:     linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This is the issue I have with recently acquired PL2303 adapter:

[   70.502848] usb 1-2: new full-speed USB device number 5 using xhci_hcd
[   70.652523] usb 1-2: New USB device found, idVendor=067b,
idProduct=23f3, bcdDevice= 6.05
[   70.652533] usb 1-2: New USB device strings: Mfr=1, Product=2,
SerialNumber=3
[   70.652538] usb 1-2: Product: USB-Serial Controller
[   70.652540] usb 1-2: Manufacturer: Prolific Technology Inc.
[   70.652543] usb 1-2: SerialNumber: CJAKj19B616
[   70.674558] usbcore: registered new interface driver usbserial_generic
[   70.674578] usbserial: USB Serial support registered for generic
[   70.677490] usbcore: registered new interface driver pl2303
[   70.677498] usbserial: USB Serial support registered for pl2303
[   70.677510] pl2303 1-2:1.0: pl2303 converter detected
[   70.677513] pl2303 1-2:1.0: unknown device type, please report to
linux-usb@vger.kernel.org

Signed-off-by: Dawid Buchwald <buchwald.dawid@gmail.com>
---
diff --git a/drivers/usb/serial/pl2303.c b/drivers/usb/serial/pl2303.c
index a70fd86f735c..1072f8eb6ab9 100644
--- a/drivers/usb/serial/pl2303.c
+++ b/drivers/usb/serial/pl2303.c
@@ -435,6 +435,7 @@ static int pl2303_detect_type(struct usb_serial *serial)
                case 0x105:
                case 0x305:
                case 0x405:
+               case 0x605:
                        /*
                         * Assume it's an HXN-type if the device doesn't
                         * support the old read request value.
