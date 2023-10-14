Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 672FECDB465
	for <linux-serial@archiver.kernel.org>; Sat, 14 Oct 2023 10:49:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232994AbjJNKt4 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 14 Oct 2023 06:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232977AbjJNKt4 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 14 Oct 2023 06:49:56 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2ECABB
        for <linux-serial@vger.kernel.org>; Sat, 14 Oct 2023 03:49:54 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d9a5836ab12so4111452276.2
        for <linux-serial@vger.kernel.org>; Sat, 14 Oct 2023 03:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697280594; x=1697885394; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NAiku5347ZizUWkMfV4Tpm0aCJ6vyX6cDZT3shueHrI=;
        b=Xz/Ji1/iNeybrU3FIMIa2jzsgoOuhNVYCrUetsmuuq/f49zaoxvrKTtl+e4/x0xTbU
         +SaZqYnXMrJwt0Cy6RzdiiWRa6NWSXwGyyL8Z2eNH0lOVmXG8voWrSzCV8eh3cZY0+en
         11PbcBV4NJYX6RaqH6trXV9Z+UwhaIL3fEWtGce/41fopOlSlKp5xqyvCjr+wP8UW5d/
         hkIK5snyWt5QGlXCZeEWJH2znb6YomFR+TA45zoo5PFSg9VPyhWqs15j0uZZ3WdCwQHV
         C03X8YP661+pv7jKABFOG9znGqd9+ukq2+V7g4R2omioHMJxRyIpeVrA9L0znqRWDyn0
         yCmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697280594; x=1697885394;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NAiku5347ZizUWkMfV4Tpm0aCJ6vyX6cDZT3shueHrI=;
        b=PBIA0zntqsvNRfoXTwJuGkfSPASjM6dioSz63yb6eYf9yxMnOBqi21CX2eeo2GwXja
         6bOvrHIy1J/dfe/pr915SnM2CLHmHdTzSpLBKMY6SzmF5gegPkXpXvEixSQox3ZySSVe
         yXSZkqnWxgE8P3nQzkFHVqo/xsyOv5Tb9TvJw5yo8f29BRt7mKDSJBW9urZCF36TwUkz
         rtakPw6UoRV6IutJmO+6mpzwxT0Ui7Gjyye+PMwE++a2MDNEVyk+Wjx/xnvd4Ovb6CeU
         tmcTNJIGbUMzfe5GAOuJ25FOw4KXzEyUb2VGiAiNa8GrU2nKdcFKkWEksE+fCAgT02dG
         ZkWw==
X-Gm-Message-State: AOJu0YzZ0fyqzmxtlHs/U9e+TpypAjIZGPoaAECjtitouf42xHzFzbSo
        VB8vP1KmogAXuAbuqwL8OnU5GloXLykHP86gAB/k
X-Google-Smtp-Source: AGHT+IEguB8GfzrgDTM/AZnMoQZhepnfKiL/nsCmojqUSiWwL9t49ZooKOjA5lE1I2C0hekExVSysk98/FneNiNmuqqf
X-Received: from vamshig51.c.googlers.com ([fda3:e722:ac3:cc00:3:22c1:c0a8:70c])
 (user=vamshigajjela job=sendgmr) by 2002:a25:cf48:0:b0:d9a:3ebc:3220 with
 SMTP id f69-20020a25cf48000000b00d9a3ebc3220mr358048ybg.11.1697280593824;
 Sat, 14 Oct 2023 03:49:53 -0700 (PDT)
Date:   Sat, 14 Oct 2023 16:19:39 +0530
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
Message-ID: <20231014104942.856152-1-vamshigajjela@google.com>
Subject: [PATCH 0/3] serial core type consistency and overflow checks
From:   Vamshi Gajjela <vamshigajjela@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        ilpo.jarvinen@linux.intel.com
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        manugautam@google.com, Subhash Jadavani <sjadavani@google.com>,
        Channa Kadabi <kadabi@google.com>,
        VAMSHI GAJJELA <vamshigajjela@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: VAMSHI GAJJELA <vamshigajjela@google.com>

This patch series introduces a set of enhancements to the serial core,
primarily focusing on improving type consistency and ensuring proper
handling of timeout values. The changes aim to enhance the reliability
and maintainability of the serial core.

VAMSHI GAJJELA (3):
  serial: core: Potential overflow of frame_time
  serial: core: Make local variable size to u64
  serial: core: Update uart_poll_timeout function to return unsigned int

 drivers/tty/serial/serial_core.c | 4 ++--
 include/linux/serial_core.h      | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

-- 
2.42.0.655.g421f12c284-goog

