Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56C08C43461
	for <linux-serial@archiver.kernel.org>; Wed, 21 Apr 2021 09:55:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23C5261456
	for <linux-serial@archiver.kernel.org>; Wed, 21 Apr 2021 09:55:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238627AbhDUJ4K (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 21 Apr 2021 05:56:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:52318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238563AbhDUJ4J (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 21 Apr 2021 05:56:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 134C86144B;
        Wed, 21 Apr 2021 09:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618998936;
        bh=D3CiZX5cVcDl+OdheHA4iQdvFSnetaDLj4pdQr4SlmI=;
        h=From:To:Cc:Subject:Date:From;
        b=ITKL0SF+lC1Kq/ARs1TaBsjht6azC17JSZBAkLXqYAjp2IyFZwhmvFyysvzxQr0hv
         spgu8aCxi6opSChVFrKNI/mly72VrGVdAGeWwjeo5AV/PsQRUUkDEiELMOxa8/ExUp
         OiBqcHcoC/CHlVI4vs4CUPMqYFRhAZihjBMjSFrYqsB5ewj8ol+OPlbu68LPVsT1oM
         wqhLhJHGYwMHRa4eORehaOkNT7C75ogKLb2ecZcn2QSGwLRsgVRxmHcrWTGZgAvRsW
         UcE2rqRNt5noA8Dp7/OrzdA63E+zP8QmuF9RF5fkrP2Mb98lOgavU+ZaVkzOlznB9m
         6oV8MrvIjy8aA==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lZ9a6-0000oI-Lo; Wed, 21 Apr 2021 11:55:38 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH 00/26] tty: drop low-latency workarounds
Date:   Wed, 21 Apr 2021 11:54:43 +0200
Message-Id: <20210421095509.3024-1-johan@kernel.org>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The infamous low_latency behaviour of tty_flip_buffer_push(), which
meant that data could be pushed to the line discipline immediately
instead of being deferred to a work queue, was finally removed in 2014.

Since then there's no need for drivers to keep hacks to temporarily drop
the port lock during receive processing but this pattern has been
reproduced in later added drivers nonetheless.

Note that several of these workarounds were added by a series posted in
2013, which ended up being merged despite having completely nonsensical
commit messages. As it turned out, it was just the RT patch set which
effectively enabled the low_latency flag for serial drivers that did not
handle it.

There's of course nothing wrong releasing the port lock before calling
tty_flip_buffer_push(), and some drivers still do after this series, but
let's get rid of the completely unnecessary unlock-and-reacquire
pattern.

Johan


Johan Hovold (26):
  tty: mxser: drop low-latency workaround
  serial: altera_jtaguart: drop low-latency workaround
  serial: altera_uart: drop low-latency workaround
  serial: amba-pl010: drop low-latency workaround
  serial: amba-pl011: drop low-latency workaround
  serial: apbuart: drop low-latency workaround
  serial: ar933x: drop low-latency workaround
  serial: arc_uart: drop low-latency workaround
  serial: atmel_serial: drop low-latency workaround
  serial: bcm63xx: drop low-latency workaround
  serial: icom: drop low-latency workaround
  serial: lpc32xx_hs: drop low-latency workaround
  serial: mcf: drop low-latency workaround
  serial: meson: drop low-latency workaround
  serial: mpc52xx_uart: drop low-latency workaround
  serial: msm_serial: drop low-latency workaround
  serial: owl: drop low-latency workaround
  serial: rda: drop low-latency workaround
  serial: rp2: drop low-latency workaround
  serial: sa1100: drop low-latency workaround
  serial: txx9: drop low-latency workaround
  serial: sifive: drop low-latency workaround
  serial: sunsu: drop low-latency workaround
  serial: timbuart: drop low-latency workaround
  serial: vt8500: drop low-latency workaround
  serial: xilinx_uartps: drop low-latency workaround

 drivers/tty/mxser.c                  |  7 -------
 drivers/tty/serial/altera_jtaguart.c |  2 --
 drivers/tty/serial/altera_uart.c     |  2 --
 drivers/tty/serial/amba-pl010.c      |  2 --
 drivers/tty/serial/amba-pl011.c      |  2 --
 drivers/tty/serial/apbuart.c         |  2 --
 drivers/tty/serial/ar933x_uart.c     |  2 --
 drivers/tty/serial/arc_uart.c        |  2 --
 drivers/tty/serial/atmel_serial.c    | 18 ------------------
 drivers/tty/serial/bcm63xx_uart.c    |  2 --
 drivers/tty/serial/icom.c            |  2 --
 drivers/tty/serial/lpc32xx_hs.c      |  2 --
 drivers/tty/serial/mcf.c             |  2 --
 drivers/tty/serial/meson_uart.c      |  2 --
 drivers/tty/serial/mpc52xx_uart.c    |  2 --
 drivers/tty/serial/msm_serial.c      |  4 ----
 drivers/tty/serial/owl-uart.c        |  2 --
 drivers/tty/serial/rda-uart.c        |  2 --
 drivers/tty/serial/rp2.c             |  2 --
 drivers/tty/serial/sa1100.c          |  2 --
 drivers/tty/serial/serial_txx9.c     |  4 ++--
 drivers/tty/serial/sifive.c          |  2 --
 drivers/tty/serial/sunsu.c           |  4 ----
 drivers/tty/serial/timbuart.c        |  2 --
 drivers/tty/serial/vt8500_serial.c   |  2 --
 drivers/tty/serial/xilinx_uartps.c   |  3 +--
 26 files changed, 3 insertions(+), 77 deletions(-)

-- 
2.26.3

