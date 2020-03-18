Return-Path: <SRS0=ll96=5D=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CD5CC10DCE
	for <linux-serial@archiver.kernel.org>; Wed, 18 Mar 2020 10:51:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C71A920768
	for <linux-serial@archiver.kernel.org>; Wed, 18 Mar 2020 10:51:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tI8x03gE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbgCRKvZ (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 18 Mar 2020 06:51:25 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43805 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbgCRKvZ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 18 Mar 2020 06:51:25 -0400
Received: by mail-pg1-f196.google.com with SMTP id u12so13455136pgb.10;
        Wed, 18 Mar 2020 03:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+T8jqrJiFE8MXB2JFZeGVn+grsmpYK2hVFCvI0CmrxU=;
        b=tI8x03gE3mQ+xMaCjxvNT/wHe1Fsg2mW8nniW+2h4igvInO0fd/YS253J8MFTuZX4+
         K962Dxih9pXwIY7xmBYS6se4WeG0a19U0chvkNE4/yCp+4ri2Yaj+G4uFuDZMTR5R4+a
         yvKfOUNAredhjDKEpuqO4fhXcIyYY5b1T/zSnEON7lwKftzdGhloEwefD4FA3HXf65Jy
         /qwPgTBdrMknS81dCs1clhqnNNaT0RLMzNB2xwoKj8src1S5ntxqvZs1s4RczjI3p3rw
         zuRkGmzO3cjGPWMgSfxYBBSrv1o4RusPif7m8CZFmKGHVcR81fisDwRATdHtIBkuKwvk
         PYqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+T8jqrJiFE8MXB2JFZeGVn+grsmpYK2hVFCvI0CmrxU=;
        b=pO1z2eI6hidJ12C0w4FqMcROwtQoRDpHjekw+uFrEEwcPiMpLigsXBQIqQUqvqgY6C
         hF+03OQ8VRFELljhnZQPEBCNLbk9rsJPujX9GFIfz0Vv92F2fQ4IXMMP6EE53KYw2ZjE
         ZeTpC5LBR/l7P5Eh6M96Oc0L32JxeZ0XJq2SnXKcU0GfghBjL7wjgYctBe8ZFqhB0sjy
         AseT6HROptdj6fHDwJlkP+s+L/GpWCCpYXuo1nLyvXyw07x/hUXwq6rDMkSvLi0KDBhn
         vzGTkN/szDCFiBrVlZIrwSWVU70zZPMYuh45IUOJ2f3GFYIqFyT1Bbd+UYhGnOY0fyef
         rmBQ==
X-Gm-Message-State: ANhLgQ3O3eUnWXgaHdnqZgI0I6uX4C4JbROtdsNEgITiwlwGgY9o6SYv
        mP3oCRU1m3dE3dncQNXylkw=
X-Google-Smtp-Source: ADFU+vtX6jV+UJkvP/lziezrvSGOizjPjmdwnY8OqD9PIrW+c6TCm6AepqIKFutMgysCZBWBzz7ViA==
X-Received: by 2002:a63:b4d:: with SMTP id a13mr3836712pgl.77.1584528682609;
        Wed, 18 Mar 2020 03:51:22 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id l25sm5799504pgn.47.2020.03.18.03.51.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 03:51:21 -0700 (PDT)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Subject: [PATCH v3 0/2] two fixes on sprd serial driver
Date:   Wed, 18 Mar 2020 18:50:47 +0800
Message-Id: <20200318105049.19623-1-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

Changes from v2:
* Return -EINVAL for both kinds of errors for calling of_alias_get_id(),
to avoid return a positive value as error number if index is larger
than the array size;
* removed cleanup for sprd_port.

Chunyan Zhang (2):
  serial: sprd: getting port index via serial alias only
  serial: sprd: remove redundant sprd_port cleanup

 drivers/tty/serial/sprd_serial.c | 40 +++++---------------------------
 1 file changed, 6 insertions(+), 34 deletions(-)

-- 
2.20.1

