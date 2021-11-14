Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B338C433F5
	for <linux-serial@archiver.kernel.org>; Sun, 14 Nov 2021 18:39:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E80B604DC
	for <linux-serial@archiver.kernel.org>; Sun, 14 Nov 2021 18:39:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234667AbhKNSmH (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 14 Nov 2021 13:42:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236127AbhKNSmG (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 14 Nov 2021 13:42:06 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A526C061746
        for <linux-serial@vger.kernel.org>; Sun, 14 Nov 2021 10:39:12 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id g28so12650194pgg.3
        for <linux-serial@vger.kernel.org>; Sun, 14 Nov 2021 10:39:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=accesio-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LxP+g5Ioi1pb9eoTaXk5Up+ffJb8vk+kmiMzXi7oz0Y=;
        b=tZDOmvU5CmzD/Qcxr3z803oTvdI1tYCUq7t0qc9dmcbIfxmVwvjmU3ySF0GBDMmxKs
         t1wAtudirXALwGQCq0KYpsAb9029icZSerlI/MvE9WbsLkueRMr/7siD6A1f1DIFklm3
         xxQdl+2UVyDbhQv3ewP5XBgWALR31UcK51lEmiES6bvvaFfOLayBc0O2bD6ybPBAcrgB
         tXCyEgnrtXoVx0WrfJBMYiABskZp6yCl75Jiih7sMK+Lh6wogA4VKoff2Mb0aWMgKK6H
         cZ/CZirCF1uJTc1hvye1+z44q4Bwmc5UqV5dQvTldd/psUZJrktgTyOlMnXAPAagC6r+
         m+vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LxP+g5Ioi1pb9eoTaXk5Up+ffJb8vk+kmiMzXi7oz0Y=;
        b=kiJpblgt/FBxTffEEe///ACNTIyrOSNpG855tTpqZidlzgDv2mfvvLx+RG4Du1xd28
         4gsBTQbDjPl8CQPw6Lf+w4nz3Pzc/0VHaMVypd/q5GYxTZpbXG2rUEFOd0qDhrcq9Py1
         orxWuF7gz09zXNKNi2hDX9hTHO8EQ1LshNKLefUVWvp/3KkioaFgeN92NYmVEB1hCdif
         tQefZiKjX8oMiSWNF4I70+tOCpKVscrQHYujFw+DCJT+Ik3Z8Jr3mbT7R5Fk4VM/XUdl
         6FgFsK4ptYhPSqtdtnp9c1LHV9S4brgVNssCqd6yNs3zFEpgWhoSd1cmkGSaCijizyAI
         XWLw==
X-Gm-Message-State: AOAM530VGUIRo23cUHE/bM3CUXV8aXsvMTUnoENZC6GV4BmGo6FPdpTH
        d3p7IffIZoy7RcMmAthXncqTEA1joyAJdCAKQJ52njymRBFlXqi1HboGWdCfJEr05CfHNJvJ0d6
        iEJs2QemQ9c+zPsaCYl+jc57aQp6kKhkihJfSeC3ttmAyTC+MWv4w4jmnQ6j55fZrJnm7kesaA2
        lxbUc=
X-Google-Smtp-Source: ABdhPJzC4Ey05mYRWnndSq8olTHv8Jyv9gP4B4LwFDikqE26Ap/0v5Rc4eo7p1fueK6PNUP8e7wnuQ==
X-Received: by 2002:a63:1c26:: with SMTP id c38mr19909421pgc.373.1636915151161;
        Sun, 14 Nov 2021 10:39:11 -0800 (PST)
Received: from work-laptop.dolannet.net ([98.149.220.160])
        by smtp.gmail.com with ESMTPSA id y130sm12551642pfg.202.2021.11.14.10.39.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Nov 2021 10:39:10 -0800 (PST)
From:   Jay Dolan <jay.dolan@accesio.com>
To:     linux-serial@vger.kernel.org
Cc:     Jay Dolan <jay.dolan@accesio.com>
Subject: [PATCH 0/3] serial: 8250_pci patches to address issues with pericom_do_set_divisor()
Date:   Sun, 14 Nov 2021 10:39:05 -0800
Message-Id: <20211114183908.444923-1-jay.dolan@accesio.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

A series patches to address three issues one customer managed to hit all at once.

1) Rewrite pericom_do_set_divisor() to always calc divisor and to use the
uartclk instead of a hard coded value. Always calculate divisor without passing
control to serial8250_do_set_divisor()
Tested with 14.7456 and 24 MHz crystals

2) Re-enable higher baud rates on Pericom chips.
serial8250_get_baud_rate() added range checking, but Pericom chips have a wider
range than what is being enforced. Make use of UPF_MAGIC_MULTIPLIER.
Tested with 14.7456 and 24 MHz crystals

3) Fourth port not being setup correctly on some Pericom chips.
Fix entries in pci_serial_quirks array


Jay Dolan (3):
  serial: 8250_pci: rewrite pericom_do_set_divisor
  serial: 8250_pci: Re-enable higher baud rates on Pericom chips
  serial: 8250_pci: Fix ACCES entries in pci_serial_quirks array

 drivers/tty/serial/8250/8250_pci.c | 44 +++++++++++++++++++++---------
 1 file changed, 31 insertions(+), 13 deletions(-)

--
2.25.1

