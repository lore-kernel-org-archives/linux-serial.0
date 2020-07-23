Return-Path: <SRS0=2ftc=BC=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90331C433E3
	for <linux-serial@archiver.kernel.org>; Thu, 23 Jul 2020 12:33:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 537F02086A
	for <linux-serial@archiver.kernel.org>; Thu, 23 Jul 2020 12:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595507621;
	bh=9HstnzmZcOCVCvgAC527JidOXxjBwfFmBGK/5Rpv/18=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=e6JejbHV8PrNkYzqwgFU2CFcRyDQFo26dSmEic0VPEKeCfQDAch99Hhm+1UIuRPLp
	 yof4z3Jk5ZmCcfIuog984yC1Kpb0Hu316cAB/F53mADSJ3m78QZQhIVPCnE3Z5xx7I
	 OB/uBwQvvTf32i2velUhYFHFAnL5TALkKwnR1ROE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728622AbgGWMdl (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 23 Jul 2020 08:33:41 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44678 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726678AbgGWMdk (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 23 Jul 2020 08:33:40 -0400
Received: by mail-lj1-f194.google.com with SMTP id s9so6111515ljm.11;
        Thu, 23 Jul 2020 05:33:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wMPlcuFyKdJLBiTEiO5YJmGRmI6e1gfKTxMuztQbyO0=;
        b=OhWbS3PMnMrAcV9jtFi+bkw5OHibH6JIEnfEeGg16IGJh8SdILL60k7f50J1AQOn6J
         ++nUED9nIM8a0QQIBW0AIOkSDpB445Nptp9/2snxuiRqohcYKwgLb9AfGNkJPJjn4QAI
         c0a0/w8HItIhVf5TQdVjSzaUuqBGoapOncREsM2A6uURXjYkB4XIM44dISYp7C9pBfln
         fxDGSa8TP85GWsNikpVy+7v4Uj/a+o2l1NiewGlQOTlWt4JMTRdbcSlMe3KcP2R5DDYe
         whsJ9DyOmJ4tmAl3oO+tU+qV6mHDUn7mRrtZo3xTVxYeQJqXyoatoY7b7OTSNlmy2dkq
         pVHg==
X-Gm-Message-State: AOAM531DO22oLFs3rlSY93VWUB69GtOT+0oFwn9Eri8kBAS+W+WnmCD4
        TjomU9tU8xJMPDjebYP2PW4=
X-Google-Smtp-Source: ABdhPJyoC4mBT/d9KVur1jULEN6NlGEFHQrgs23Yv/DCfWZjkoyuzoTvbMV72BCX1GBZfYC/+lwkzA==
X-Received: by 2002:a2e:9853:: with SMTP id e19mr1959498ljj.436.1595507618786;
        Thu, 23 Jul 2020 05:33:38 -0700 (PDT)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id r19sm2675192ljn.40.2020.07.23.05.33.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 05:33:38 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@xi.terra>)
        id 1jyaPk-0001X0-IM; Thu, 23 Jul 2020 14:33:32 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH v2 0/2] serial: add sparse context annotation
Date:   Thu, 23 Jul 2020 14:33:25 +0200
Message-Id: <20200723123327.5843-1-johan@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The Intel test robot reported a new sparse warning in pmac_zilog, which
wasn't actually new.

Add sparse annotation to the two drivers that release and reacquire the
port lock in their receive handlers to suppress these warnings.

Johan

Changes in v2:
 - let's use the right context expression even if sparse doesn't seem to
   care (add the missing ampersand)


Johan Hovold (2):
  serial: pmac_zilog: add sparse context annotation
  serial: msm_serial: add sparse context annotation

 drivers/tty/serial/msm_serial.c | 2 ++
 drivers/tty/serial/pmac_zilog.c | 1 +
 2 files changed, 3 insertions(+)

-- 
2.26.2

