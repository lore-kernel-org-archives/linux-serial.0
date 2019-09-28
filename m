Return-Path: <SRS0=YdQh=XX=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71720C4360C
	for <linux-serial@archiver.kernel.org>; Sat, 28 Sep 2019 05:59:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A25E2082F
	for <linux-serial@archiver.kernel.org>; Sat, 28 Sep 2019 05:59:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TkWD/e7Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725283AbfI1F7n (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 28 Sep 2019 01:59:43 -0400
Received: from mail-wm1-f54.google.com ([209.85.128.54]:33828 "EHLO
        mail-wm1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725263AbfI1F7n (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 28 Sep 2019 01:59:43 -0400
Received: by mail-wm1-f54.google.com with SMTP id y135so9995531wmc.1
        for <linux-serial@vger.kernel.org>; Fri, 27 Sep 2019 22:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=n2xO5c46w+95Gq7+SFesfDxDDFkrFOl3zUP3wQECnks=;
        b=TkWD/e7QjjBglY/FzuySIkYImpfaBmcrskcYDnHo6S06jrhMMMG23LEPCD5Xv0rjJh
         tA9AGEA2E9cYLATo9959jIe1Csmrl1wawvcPqoUFe5vzHiQ5H90JMXY+fhu/T3VETaSK
         8hhcd1EOUSmKp6O/wDvblwXmuJZhYsowL+VqZkatw9TI9V5ueYW8yhyIQn8U6kifiILS
         P0JC5am7hJt1vdF5RM9bS4+yQ6UPWAy61jiNDYpP2o4WdoVn+MWjrWvd03p2UF1HB5gx
         Y2h5HilErbjjteAMoEst8WTo/XmRB7s/3g9ZWAGEV6Bw2haOdEsYtY2hI4E59Mr2i9FX
         aulA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=n2xO5c46w+95Gq7+SFesfDxDDFkrFOl3zUP3wQECnks=;
        b=sH4thEQT2i4Okh3RlodsrIFBdkIZLKYeZUd2ahh/HmaM2U9H8Yfhmnj6YAu8VBWDyy
         hHSC4Jym9Qj4UzaDUf8+fVQ+zNmivVIaeUrRG8vlsx5L3YVqWa+z0heKOaAkCyWeAH2Z
         WTw8ANqnq5eIpvT+BYXDYbmOYCBv/gqlx5phhdeDpwDkWCqf2+92CVu5aobqDAaNhbA1
         oOeDEGwReLhr6hoGIXy33VLkZPzAOhZDf1F4i6kryJlZEDsD5OHBGq6c8koi+FcfzqUe
         hQcsEEnXmRZTsDUsds/sBIgorevZsfxW9Gk6PN1k10+qZ9zBHScg4P2xYP5D/iuUAeA7
         KLIg==
X-Gm-Message-State: APjAAAV0LFDDMFLJfJYJ/gnzHFs2X6yjNtFQ4WFbZRyUSBtQRZ5KwB6g
        Tm1+TvBDl+76YFS3dikN2/sAuxcH9HD2kAw5MT9YT8j6
X-Google-Smtp-Source: APXvYqwzV7M0wl9tX2MzB4ZP+ir1HIYoFWsU4FfwNld+CUSfGkDyIkyNdFfVQTyI3j8rA9Oc9WW9l1l/VRb8xfbwRBU=
X-Received: by 2002:a1c:7c15:: with SMTP id x21mr8957413wmc.36.1569650380522;
 Fri, 27 Sep 2019 22:59:40 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?Q?Nuno_Gon=C3=A7alves?= <nunojpg@gmail.com>
Date:   Sat, 28 Sep 2019 07:59:29 +0200
Message-ID: <CAEXMXLRBpQcSq3SrvL4LkG8_7S0CWJFGqRCnjywjbUEPZg9XxQ@mail.gmail.com>
Subject: Regression since 4a96895f74c9633b51427fd080ab70fa62b65bc4
To:     linux-serial@vger.kernel.org, yegorslists@googlemail.com
Cc:     sr@denx.de, andriy.shevchenko@linux.intel.com,
        mika.westerberg@linux.intel.com, giulio.benetti@micronovasrl.com,
        gregkh@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 32 bit arm platforms (am335x and sunxi) I get unexpected bytes on
serial ports after this commit.

I use CTS (so: for input flow control).

I've observed two different issues, one where I get just a few missed
or added bytes about once a minute, and another where I get totally
unexpected chars until I reopen the port.

I will have a hard time to analyse and give a better description of
how exactly the port is failing, so maybe you have a idea of what is
the issue with this patch.

I've reverted this on top of 5.3.1 and consistently got the issue fixed.

Thanks,
Nuno

commit 4a96895f74c9633b51427fd080ab70fa62b65bc4
Author: Yegor Yefremov <yegorslists@googlemail.com>
Date:   Thu Jun 20 08:24:20 2019 +0200

    tty/serial/8250: use mctrl_gpio helpers

    This patch permits the usage for GPIOs to control
    the CTS/RTS/DTR/DSR/DCD/RI signals.

    Changed by Stefan:
    Only call mctrl_gpio_init(), if the device has no ACPI companion device
    to not break existing ACPI based systems. Also only use the mctrl_gpio_
    functions when "gpios" is available.

    Use MSR / MCR <-> TIOCM wrapper functions.

    Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
    Signed-off-by: Stefan Roese <sr@denx.de>
    Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
    Tested-by: Yegor Yefremov <yegorslists@googlemail.com>
    Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
    Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    Cc: Giulio Benetti <giulio.benetti@micronovasrl.com>
    Cc: Yegor Yefremov <yegorslists@googlemail.com>
    Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
