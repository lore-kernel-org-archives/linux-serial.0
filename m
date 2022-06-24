Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3248CC433EF
	for <linux-serial@archiver.kernel.org>; Fri, 24 Jun 2022 08:28:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231739AbiFXI23 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 24 Jun 2022 04:28:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbiFXI2W (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 24 Jun 2022 04:28:22 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75CF1614A
        for <linux-serial@vger.kernel.org>; Fri, 24 Jun 2022 01:28:21 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id ej4so2380995edb.7
        for <linux-serial@vger.kernel.org>; Fri, 24 Jun 2022 01:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=XZQ65lNk17zDSRd2YPqlkvHsZ3QL7sF4KJSqUBX5CiI=;
        b=Ly47dX5Qd239wpiXPl6P0knkd0oNU+fRsNvXycWzzKNIpYpG9fxdDLHineeSzNoiga
         0Sds33eudLFhIThenrqdHJ2zFF22xScGG81bzW/EUbp40+RA0//Ni9FxLc0o9/57Tiob
         xIwxVCo7ugH045ibi7hN7hRY8l7KGq8HnYA4VK79jPklYil1e0Ec+lkFmlMoOh1rFfIQ
         q+8e8IuoIC6NvEcGcB0/pwRNpka7HRobRXN6BHt2csNh5CGH+z6fqpphly/HTTVo8UcW
         ooU6myzwLROifu76WD+lUSeH1Vz7VrH0zvNz/sr1wbX1CHnbeTTSmDU82aeYiSAfeiTg
         TL4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=XZQ65lNk17zDSRd2YPqlkvHsZ3QL7sF4KJSqUBX5CiI=;
        b=4+u0OBMZcEN3+bfcvsMon9oDGKiFsk3CpO4/FAJumS/WJMMIOgqnuaVQu0Me2QU3Os
         QbUWaOn7tpBOha6E8KJaJrlr1TQp534jA4ebZ7pt9miHOzM2JIzTQpMFwDQm8XAiWlEq
         18uTWeL5w8IlTsLtkKOr95fmBiUqxvzbiw8F2/zDMeaAgJa5dEtWyFJSwRPk8RPMfHBg
         cvIbMnWofmfNd+sV/30n6L0BAgZOX5JuoynZ9Y2KZZOYIrX4JcinU2eL0L7NKyyZoFvD
         vdI76gsheHMMvSWW/TKlz+NUDBQqH8uW4AJ2iepga+gPiVNtRxrbP7dwboPjyoqCDymb
         yzLQ==
X-Gm-Message-State: AJIora+hpbpYDQUUFkEHE+WxqYb3hUea0kwIN3CkWQzSCez4ThTiaQaG
        5KQixEBN+8IOnS9CLCi2CXICF6x1Qb4hvsXTo3jqIxr83Yw=
X-Google-Smtp-Source: AGRyM1tc9u4aiw9+fljgwlrErYn17SwTEH+r4AyDYdA2bl+ekvCltwQYj5gexZjlfDDCbn1xSPALM7W8czCRqJrMS38=
X-Received: by 2002:a05:6402:348e:b0:435:a912:355f with SMTP id
 v14-20020a056402348e00b00435a912355fmr15642155edc.326.1656059299648; Fri, 24
 Jun 2022 01:28:19 -0700 (PDT)
MIME-Version: 1.0
From:   Mohamed Ali Fodha <fodha.mohamed.ali@gmail.com>
Date:   Fri, 24 Jun 2022 09:28:08 +0100
Message-ID: <CAAcv5+4C6YekJmVzWqDnbp3O7MJ-Pny4MUp7uvqWzrbCweixTQ@mail.gmail.com>
Subject: Sending gnss data during suspend doesn't work
To:     linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hello,

I am not able to send data (serdev_device_write(gserial->serdev,
standby_cmd, strlen(standby_cmd), MAX_SCHEDULE_TIMEOUT)) to gnss in
suspend callback (from sta8089_set_power):

static const struct gnss_serial_ops sta8089_gserial_ops = {
.set_power = sta8089_set_power,
};

but it works during prepare. To do this I have to patch the following API:

@@ -21,10 +21,11 @@ struct gnss_serial {
  enum gnss_serial_pm_state {
  GNSS_SERIAL_OFF,
  GNSS_SERIAL_ACTIVE,
  GNSS_SERIAL_STANDBY,
+ GNSS_SERIAL_PREPARE,
 };

 static int gnss_serial_prepare(struct device *dev)
 {
- if (pm_runtime_suspended(dev))
- return 1;
+ struct gnss_serial *gserial = dev_get_drvdata(dev);

- return 0;
+ return gnss_serial_set_power(gserial, GNSS_SERIAL_PREPARE);
 }

Is it normal that sending data during suspend doesn't work?
I think there should be a solution to use prepare without patching
gnss_serial_prepare.
Any ideas please?

Best regards,
Mohamed Ali
