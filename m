Return-Path: <SRS0=P72y=BW=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AABAC433E0
	for <linux-serial@archiver.kernel.org>; Wed, 12 Aug 2020 16:51:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00AF92076C
	for <linux-serial@archiver.kernel.org>; Wed, 12 Aug 2020 16:51:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LpTMZ0Ec"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726447AbgHLQvw (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 12 Aug 2020 12:51:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbgHLQvv (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 12 Aug 2020 12:51:51 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A3CAC061383
        for <linux-serial@vger.kernel.org>; Wed, 12 Aug 2020 09:51:51 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id y11so1336161qvl.4
        for <linux-serial@vger.kernel.org>; Wed, 12 Aug 2020 09:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=1UKrrQhU9ezgWiG9ra6rTW7eVrjGlPl6LTeDgYe+jdE=;
        b=LpTMZ0Ec2geGo8ri+miWiYaScukQahBdSFTgC5AUP69t7lVKu11l71KoQGWb1SZ4//
         IhyfKsgSulF7OzyZVBCH56ZLy0F6auMUBS9fCVpobSEABAkFju+npWmLeCfDLrvtWIp4
         tFC/nFjE4sTs1d09D6a44ljKXquBhR+eWV26i7tzU+9b+dzrZX1ozcpGGu2NCEJKnwP1
         sDpmsmwAMkWv0hh40a5ZKsOnlNqJLARqCjuaILEs40gnaafWDpZrOc1dP/+9F4u0pjtd
         ocVcuNrraMAz5BzryeaCK5r3gNbLlWaoIsdBEzbRWaQu4BroULkwb0atoZc62IITWdns
         DWDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=1UKrrQhU9ezgWiG9ra6rTW7eVrjGlPl6LTeDgYe+jdE=;
        b=EWObfm1uBKSfHB/SBEn8s1ZHZSVNMxtfAC+KOqhFDE4WcuhYKXKBsNJUvjSvjXzGs/
         YXJFatfeRsup2Nho9hfXlPt9/TwIZ3Rzg4oKbUZb+MNk3GZDxRMesw0udFuwH5rZUIwO
         kkylU2RNH7FxeK5GFMQgJLL2Y1K0rTAs/l9ShRMsztJxs2RO23xx/17boC/Mm74ztNAH
         636Oo8I/x8lK+KkPoU5PuG2vp6DH2zaUK+56TFyadC5Prnez6USVWWRxTrAp/kv5X7dR
         RngrP6oImfbXRA08NlE2Izsus7veBE/nemMJeDtMeKrtc6gBbMj0ZuMrX7RlRSBNBeLF
         PjDA==
X-Gm-Message-State: AOAM530a3BuZcOlrpdovo4RNy/TwlTk9vQvYvgZ71DBysiFGaoUVnSIH
        +zgD4jfW2q43wv1LvEDhRDwFzHqyZJyMDzJVL3Ig3i5YsFs=
X-Google-Smtp-Source: ABdhPJwWgU4jGVKjraT1M7+1J9i5JYu7DgAv6lk4wKv4PimjWHM4VD5knoo2p91lnGBeVZIQKhWOtth1GykQD0fM0rs=
X-Received: by 2002:a05:6214:11a8:: with SMTP id u8mr541071qvv.88.1597251110073;
 Wed, 12 Aug 2020 09:51:50 -0700 (PDT)
MIME-Version: 1.0
From:   Petr Slansky <slansky@gmail.com>
Date:   Wed, 12 Aug 2020 18:51:39 +0200
Message-ID: <CA+ww9hwAzFHCYhkQUev2_VBN=8gMsxBcnExG53_gCkC6++-ScA@mail.gmail.com>
Subject: Serial raw mode. Bug in serial driver in Linux kernel? Is
 documentation correct?
To:     linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Linux-Serial,

I was fixing "pirate-loader" for BusPirate device, firmware loader utility.
The design followed documentation for serial communication for "row"
serial mode but it was not working. I modified flags and utility works
now but my modification doesn't match documentation. That is strange
from my point of view. Have I discovered a bug in the kernel? Could
you check??

Details are here, second comment, the long one:
https://github.com/BusPirate/Bus_Pirate/issues/140

This is the core of my fix, I changed CSIZE flag:

        cfmakeraw(&g_new_tio);

-       g_new_tio.c_cflag |=  (CS8 | CLOCAL | CREAD);
-       g_new_tio.c_cflag &= ~(PARENB | CSTOPB | CSIZE);
-       g_new_tio.c_oflag = 0;
-       g_new_tio.c_lflag = 0;
+       g_new_tio.c_cflag |=  (CS8 | CSIZE | CLOCAL | CREAD);
+       g_new_tio.c_cflag &= ~(PARENB | CSTOPB);
+       //g_new_tio.c_oflag = 0;
+       //g_new_tio.c_lflag = 0;

When I write about wrong documentation, that information is on many
places including "man cfmakeraw":

           termios_p->c_iflag &= ~(IGNBRK | BRKINT | PARMRK | ISTRIP |
INLCR | IGNCR | ICRNL | IXON);
           termios_p->c_oflag &= ~OPOST;
           termios_p->c_lflag &= ~(ECHO | ECHONL | ICANON | ISIG | IEXTEN);
           termios_p->c_cflag &= ~(CSIZE | PARENB);
           termios_p->c_cflag |= CS8;

With regards,
Petr

BTW, I tried to send this email to Greg KH first but he asked me to
send my email to this group because his INBOX is full of unread
messages (912 messages in /home/greg/mail/INBOX/). That is not so bad,
I have more than 5000 unread messages in my INBOX... ;-)
