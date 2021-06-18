Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BBA5C48BDF
	for <linux-serial@archiver.kernel.org>; Fri, 18 Jun 2021 06:15:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3725861154
	for <linux-serial@archiver.kernel.org>; Fri, 18 Jun 2021 06:15:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232847AbhFRGR1 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 18 Jun 2021 02:17:27 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:58836 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232270AbhFRGR0 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 18 Jun 2021 02:17:26 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 27A7221B4D;
        Fri, 18 Jun 2021 06:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623996917; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=iTlXNLY1hVeCTSB8MQPOYJ/EWyrK25cvEopPUb2EKbc=;
        b=Tc17wV5rDas2tTR+8UYJyMZ6kBdLgZMyNrcYIVughNTSIaEx2/HrEdjVxHfDq3UMq/5bVd
        +QjecrinpFtsO0BfzbkKT/W0T8Ds9283uD3RLtCk2osacEOOkhMB33NyeTAjndq44W8fH4
        f6PA7n1CmPjbr+HJ2OIRN0e1J+u8g20=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623996917;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=iTlXNLY1hVeCTSB8MQPOYJ/EWyrK25cvEopPUb2EKbc=;
        b=gBEaaBOT5/CZ4F2MmMM5ebYfZBxIQjkeEj0X+Bab6xfL3Mi880pzelLSjnwQUQED2tDTem
        9HNidL+mpHpHvzBw==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id EE06AA3BBC;
        Fri, 18 Jun 2021 06:15:16 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 00/69] mxser: cleanup
Date:   Fri, 18 Jun 2021 08:14:06 +0200
Message-Id: <20210618061516.662-1-jslaby@suse.cz>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

I was given a few cards from MOXA (thanks a lot). So I cleaned up the
driver and can continue maintaining it.

A long term goal is to convert the driver to serial_core.

Jiri Slaby (70):
  mxser: drop ISA support
  mxser: renumber mxser_cards
  mxser: remove info printout from init
  mxser: integrate mxser.h into .c
  mxser: cleanup Gpci_uart_info struct
  mxser: rename CheckIsMoxaMust to mxser_get_must_hwid
  mxser: rename mxser_board::chip_flag to must_hwid
  mxser: introduce enum mxser_must_hwid
  mxser: drop constant board::uart_type
  mxser: move max_baud from port to board
  mxser: remove nonsense from ISR
  mxser: cleanup LSR handling in mxser_receive_chars
  mxser: extract port ISR
  mxser: simplify mxser_interrupt and drop mxser_board::vector_mask
  mxser: extract mxser_receive_chars_new
  mxser: extract mxser_receive_chars_old
  mxser: remove else from LSR bits checks
  mxser: correct types for uart variables
  mxser: make xmit ring buffer variables unsigned
  mxser: drop UART_MCR_AFE and UART_LSR_SPECIAL defines
  mxser: drop unused MOXA_DIAGNOSE macro
  mxser: remove MOXA_GET_MAJOR deprecated ioctl
  mxser: remove MOXA_SET_BAUD_METHOD ioctl
  mxser: remove MOXA_ASPP_MON and friends
  mxser: remove MOXA_ASPP_LSTATUS ioctl
  mxser: remove MOXA_CHKPORTENABLE ioctl
  mxser: remove MOXA_GETDATACOUNT ioctl
  mxser: remove MOXA_GETMSTATUS ioctl
  mxser: remove MOXA_ASPP_OQUEUE ioctl
  mxser: remove MOXA_HighSpeedOn ioctl
  mxser: remove cnt from mxser_receive_chars
  mxser: don't allocate MXSER_PORTS + 1
  mxser: drop unused mxser_port::normal_termios
  mxser: remove unused mxser_port::stop_rx
  mxser: drop mxser_port::baud_base
  mxser: drop mxser_port::custom_divisor
  mxser: cleanup mxser_change_speed
  mxser: extract mxser_ioctl_op_mode
  mxser: simplify mxser_ioctl_op_mode
  mxser: dedup mxser_must_set_enhance_mode
  mxser: introduce mxser_must_select_bank and use it
  mxser: clean up the rest of MUST helpers
  mxser: move board init into mxser_initbrd
  mxser: inline mxser_board_remove into mxser_remove
  mxser: pci, switch to managed resources
  mxser: move request irq to probe and switch to managed
  mxser: remove info message from probe
  mxser: remove mxser_cardinfo
  mxser: cleanup mxser_process_txrx_fifo
  mxser: rework and simplify mxser_open
  mxser: make mxser_board::idx really an index
  mxser: alloc struct mxser_board dynamically
  mxser: alloc only needed # of ports
  mxser: remove pointless ioaddr checks
  mxser: cleanup mxser_rs_break
  mxser: cleanup mxser_dtr_rts
  mxser: don't start TX from tty_operations::put_char
  mxser: extract and dedup CTS handling
  mxser: introduce and use start/stop_tx helpers
  mxser: remove xmit_cnt < 0 tests
  mxser: decrypt FCR values
  mxser: fix typos around enhanced mode
  mxser: access info->MCR under info->slock
  mxser: use port variable in mxser_set_serial_info
  mxser: rename flags to old_speed in mxser_set_serial_info
  mxser: introduce mxser_16550A_or_MUST helper
  mxser: Documentation, remove traces of callout device
  mxser: Documentation, make the docs up-to-date
  mxser: Documentation, fix typos
  MAINTAINERS: add me back as mxser maintainer

 .../driver-api/serial/moxa-smartio.rst        |  496 +----
 MAINTAINERS                                   |    3 +-
 drivers/tty/Kconfig                           |    2 +-
 drivers/tty/mxser.c                           | 1950 +++++------------
 drivers/tty/mxser.h                           |  151 --
 5 files changed, 622 insertions(+), 1980 deletions(-)
 delete mode 100644 drivers/tty/mxser.h

-- 
2.32.0

