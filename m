Return-Path: <SRS0=yy8S=EB=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16CCAC4363A
	for <linux-serial@archiver.kernel.org>; Mon, 26 Oct 2020 17:57:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8AAA2075B
	for <linux-serial@archiver.kernel.org>; Mon, 26 Oct 2020 17:57:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=beagleboard-org.20150623.gappssmtp.com header.i=@beagleboard-org.20150623.gappssmtp.com header.b="RmpKg4D4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1782033AbgJZR5r (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 26 Oct 2020 13:57:47 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33575 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1782044AbgJZR5p (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 26 Oct 2020 13:57:45 -0400
Received: by mail-pl1-f195.google.com with SMTP id b19so5108404pld.0
        for <linux-serial@vger.kernel.org>; Mon, 26 Oct 2020 10:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WU3hID4rRFAfybLKsH6+3te5KdmTCS1oR9J+E9Kmf60=;
        b=RmpKg4D4H93vwtvZknkbx3qsbYiuQISLZRbZIAWleMErWgdkSz9mEdzY86om5DxhXm
         bNBM6juO4iHCKF5yrUxLgPtYo3WQ4t3bqLXEGzmXmPIPW/bilEXqnewaEqm3/QYI3uPo
         7TbvmANVW/D0I5a5Y+Z0lswVWE9pWzeJimBf3VWrM5GDxg9by513JLpsg+pvW2OMHNx/
         5IAeSY9tR+oewkEtWIiOPomZ11+kbstV+xIyja//xRgS9NRvMD+GIX4CftV0+DfflCLS
         57pq4KROnHZ+ykYHeQAB567OoTLDPANGzO7oB6haIPT85QKz7RxtNyslKuxevCakxUP4
         aLrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WU3hID4rRFAfybLKsH6+3te5KdmTCS1oR9J+E9Kmf60=;
        b=FLmkFOlTd2nLV/sqsNXn1QyPqgBlufQdElkzg26uGXI3mwYm/YbhUWggRHg191g3ED
         DGNZ8jgT5k9ANwxM00FKImxGBdIFCojErPVKbkWTEHMHgaJnG2GgMpfYjvCTmcsx7PVO
         ynNDeKHeFgZ/Nrf+cQrqMXMaf+FSV8O71rZBwVDLWH4yLpVL877MPQJ1jthN1xlwz0jG
         T6vYpxhPZGFLJiScT3JjO7qpYKT7XbWYXI7c1ogKFo9Tv2wp7seKCBHhL3zMN3hjBZtW
         xDvMBY1QJmKgsFpQ8CzAuZL9cYkzdMta+FAAjdx05xmQNtVS4xeNfGIfG7B5H0cQwP0p
         6u4w==
X-Gm-Message-State: AOAM530Yw3LHX64V+8nrRYsR2bJjhk/0aGOL/yofiZV3Cbxga4jm9P/u
        88LiFLIf/xPLo8V8CuXxjVEf
X-Google-Smtp-Source: ABdhPJzZvz44Tk4SHKhCGs9eVHRNgAAOnqgaIe89LtwV7lyl4vApI18Ycg1afAgRWbBo9/A0iBCJfw==
X-Received: by 2002:a17:90b:3598:: with SMTP id mm24mr22162836pjb.172.1603735064009;
        Mon, 26 Oct 2020 10:57:44 -0700 (PDT)
Received: from localhost.localdomain ([116.68.74.56])
        by smtp.gmail.com with ESMTPSA id o65sm11583088pga.42.2020.10.26.10.57.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 10:57:43 -0700 (PDT)
From:   Vaishnav M A <vaishnav@beagleboard.org>
To:     johan@kernel.org
Cc:     ribalda@kernel.org, robh@kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, masahiroy@kernel.org,
        andriy.shevchenko@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-kbuild@vger.kernel.org,
        jkridner@beagleboard.org, drew@beagleboard.org,
        robertcnelson@beagleboard.org, vaishnav@beagleboard.org
Subject: [RFC PATCH 0/5] Add serdev_device_id for platform instantiation
Date:   Mon, 26 Oct 2020 23:27:13 +0530
Message-Id: <20201026175718.965773-1-vaishnav@beagleboard.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This patch series aims to add serdev_device_id to the serdev drivers
so as to support platform instantiation of a serdev device.The first
two patches adding the serdev_device_id has already been once submitted
by Ricardo Ribalda Delgado(in CC) here:
https://lore.kernel.org/lkml/20180611115240.32606-1-ricardo.ribalda@gmail.com/

The problem currently trying to solved is bit different from dynamically
loading/removing serdev devices as addressed in the original patch series,
the aim now is to attach a serdev driver once to a device that is not a part of
the device tree or the ACPI table, Eg. a device on a greybus created gbphy uart.

The patches were tested with a set of uBlox GNSS Receiver Clicks on a PocketBeagle.
The serdev_device_id table is exported only for a single driver(drivers/gnss/ubx.c)
for reference.

Ricardo Ribalda (2):
  serdev: Add serdev_device_id
  file2alias: Support for serdev devices

Vaishnav M A (3):
  serdev: add of_ helper to get serdev controller
  gnss: ubx add MODULE_DEVICE_TABLE(serdev)
  gnss: change of_property_read to device_property_read

 drivers/gnss/serial.c             |  3 +-
 drivers/gnss/ubx.c                |  9 +++++
 drivers/tty/serdev/core.c         | 58 +++++++++++++++++++++++++++----
 include/linux/mod_devicetable.h   | 10 ++++++
 include/linux/serdev.h            |  5 +++
 scripts/mod/devicetable-offsets.c |  3 ++
 scripts/mod/file2alias.c          | 10 ++++++
 7 files changed, 90 insertions(+), 8 deletions(-)

-- 
2.25.1

