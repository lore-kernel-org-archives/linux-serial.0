Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45046C433EF
	for <linux-serial@archiver.kernel.org>; Fri, 26 Nov 2021 08:18:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353788AbhKZIV0 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 26 Nov 2021 03:21:26 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:50424 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353557AbhKZITZ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 26 Nov 2021 03:19:25 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 3B69B21923;
        Fri, 26 Nov 2021 08:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637914572; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=d074oInTejkFXY9rgF+E9NUJOneyB+3TLDkZb0cvCJU=;
        b=R1giVOXL1xA5GgHDbfcDSwJLhdCUrzPHQ548xav41aXTPtM2eEPbEpcmcGPcMPnzUKPy8h
        HmjjV6HcEavGr6l2kfJfp6l+y+PZtaYepMlYQoqxXS12bwsGfpC3R2nfQZyWOxdJFXgmv6
        ry8XoGEw8NcZ/Ln3w1CB0eywO6A7GPA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637914572;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=d074oInTejkFXY9rgF+E9NUJOneyB+3TLDkZb0cvCJU=;
        b=qc5PNXxMVOVu27nkiAE/0lWiXFVTWo2FKDfLrn3Ykwwr5D8vV0Cc2zewYWfcMbSV56KRJK
        bw1ajoh+9JsqtPAA==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 1152DA3B81;
        Fri, 26 Nov 2021 08:16:12 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 00/23] tty: documentation revamp
Date:   Fri, 26 Nov 2021 09:15:48 +0100
Message-Id: <20211126081611.11001-1-jslaby@suse.cz>
X-Mailer: git-send-email 2.34.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This series adds/updates:
1) kernel-doc documentation for most exported functions, and
2) adds a chapter to Documentation/tty to glue it all together.

I think it's a good base for further improvements. It deduplicates
and unify multiple documentation files.

Jiri Slaby (23):
  tty: finish kernel-doc of tty_struct members
  tty: add kernel-doc for tty_port
  tty: add kernel-doc for tty_driver
  tty: add kernel-doc for tty_operations
  tty: add kernel-doc for tty_port_operations
  tty: add kernel-doc for tty_ldisc_ops
  tty: combine tty_operations triple docs into kernel-doc
  tty: combine tty_ldisc_ops docs into kernel-doc
  tty: reformat tty_struct::flags into kernel-doc
  tty: reformat TTY_DRIVER_ flags into kernel-doc
  tty: reformat kernel-doc in tty_port.c
  tty: reformat kernel-doc in tty_io.c
  tty: reformat kernel-doc in tty_ldisc.c
  tty: reformat kernel-doc in tty_buffer.c
  tty: fix kernel-doc in n_tty.c
  tty: reformat kernel-doc in n_tty.c
  tty: add kernel-doc for more tty_driver functions
  tty: add kernel-doc for more tty_port functions
  tty: move tty_ldisc docs to new Documentation/tty/
  tty: make tty_ldisc docs up-to-date
  tty: more kernel-doc for tty_ldisc
  tty: add kernel-doc for tty_standard_install
  Documentation: add TTY chapter

 Documentation/driver-api/serial/index.rst |   1 -
 Documentation/driver-api/serial/tty.rst   | 328 --------
 Documentation/index.rst                   |   1 +
 Documentation/tty/index.rst               |  63 ++
 Documentation/tty/n_tty.rst               |  22 +
 Documentation/tty/tty_buffer.rst          |  46 ++
 Documentation/tty/tty_driver.rst          | 128 ++++
 Documentation/tty/tty_internals.rst       |  31 +
 Documentation/tty/tty_ldisc.rst           |  85 +++
 Documentation/tty/tty_port.rst            |  70 ++
 Documentation/tty/tty_struct.rst          |  81 ++
 drivers/tty/n_tty.c                       | 688 ++++++++---------
 drivers/tty/tty_buffer.c                  | 251 +++---
 drivers/tty/tty_io.c                      | 889 +++++++++++-----------
 drivers/tty/tty_ldisc.c                   | 292 ++++---
 drivers/tty/tty_port.c                    | 223 ++++--
 include/linux/tty.h                       | 153 +++-
 include/linux/tty_driver.h                | 572 ++++++++------
 include/linux/tty_ldisc.h                 | 278 +++----
 include/linux/tty_port.h                  | 131 ++--
 20 files changed, 2408 insertions(+), 1925 deletions(-)
 delete mode 100644 Documentation/driver-api/serial/tty.rst
 create mode 100644 Documentation/tty/index.rst
 create mode 100644 Documentation/tty/n_tty.rst
 create mode 100644 Documentation/tty/tty_buffer.rst
 create mode 100644 Documentation/tty/tty_driver.rst
 create mode 100644 Documentation/tty/tty_internals.rst
 create mode 100644 Documentation/tty/tty_ldisc.rst
 create mode 100644 Documentation/tty/tty_port.rst
 create mode 100644 Documentation/tty/tty_struct.rst

-- 
2.34.0

