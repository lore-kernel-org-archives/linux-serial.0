Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BA4AC83013
	for <linux-serial@archiver.kernel.org>; Mon, 30 Nov 2020 15:39:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0842920725
	for <linux-serial@archiver.kernel.org>; Mon, 30 Nov 2020 15:39:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728321AbgK3Piv (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 30 Nov 2020 10:38:51 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45403 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727556AbgK3Pim (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 30 Nov 2020 10:38:42 -0500
Received: by mail-lj1-f193.google.com with SMTP id q8so9565166ljc.12;
        Mon, 30 Nov 2020 07:38:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=V16D1mpe9Pf31hyLO9sCMtyG6TpO+ajBviUQ5xQbPLg=;
        b=J3fkyRpSAyuhBCjMif3COhPDQMyhTCxvq9HWegCywYRYeQb/Ri3ohqrz0iFEkxKIzS
         fCwthLtRbQG6q6V09OW32aCDOeftr91/vTW5mXBk50bJX9MCbZg3qHZl57yZ8LraQfaI
         6SacZp4rkRQsfjAllM9vuZ4Hrs+jizx5AwIexqSKLbA+ObY0p0L8rFLP8/S+/DdcnJ42
         WCoPXELLxHUDUhSCCH1nFWQTQuBBkuOx3VeElEF9TUG6bBYY7hcckpusyHU7SIBDCFIh
         G014p5KJuoLiYcx5T85XCu3l9ymT+b6+GvzydGCb3HABZH5Sye864331G5UY83/mdsnc
         mSNw==
X-Gm-Message-State: AOAM530Uqw+FIOBXXfcgeLSw+xNGbCvchKD20GJiVvqNaXIbIKKxc1v1
        WVdwkPTTUa44IfwpF25kXZg=
X-Google-Smtp-Source: ABdhPJyHImnAjRzrMtjyzG2xYG1wRgEDp1Rp8P0C6gvLtSPb+CJ1350IW4Ys5W+BKMLvdVVnKi5gpg==
X-Received: by 2002:a2e:3608:: with SMTP id d8mr10503778lja.68.1606750673684;
        Mon, 30 Nov 2020 07:37:53 -0800 (PST)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id u18sm2491666lfq.145.2020.11.30.07.37.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 07:37:52 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@xi.terra>)
        id 1kjlFt-0002Od-Re; Mon, 30 Nov 2020 16:38:22 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        "Mychaela N . Falconia" <falcon@freecalypso.org>,
        linux-serial@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH 0/5] tty: add flag to suppress ready signalling on open
Date:   Mon, 30 Nov 2020 16:37:37 +0100
Message-Id: <20201130153742.9163-1-johan@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This series adds a new NORDY port flag to suppress raising the
modem-control lines on open to signal DTE readiness.
    
This can be used to implement a NORDY termios control flag to complement
HUPCL, which controls lowering of the modem-control lines on final
close.

Initially drivers can export the flag through sysfs, which also allows
control over the lines on first open. Such an interface is implemented
for serial core and USB serial.

The motivation for this is to allow for applications where the DTR and
RTS lines are used for non-standard purposes (e.g. generating power-on
and reset pulses) to open the port without undesirable side effects.

The final patches enables this flag by default for such a USB serial
device.

Greg, are you ok we me taking this through my tree? I'm planning on some
follow ups to the ftdi driver and the tty/serial changes are fairly
self-contained.

Johan


Johan Hovold (3):
  tty: add port flag to suppress ready signalling on open
  serial: core: add sysfs attribute to suppress ready signalling on open
  USB: serial: add sysfs attribute to suppress ready signalling on open

Mychaela N. Falconia (2):
  USB: serial: ftdi_sio: pass port to quirk port_probe functions
  USB: serial: ftdi_sio: add support for FreeCalypso DUART28C adapter

 Documentation/ABI/testing/sysfs-tty |  7 +++++
 drivers/tty/serial/serial_core.c    | 29 ++++++++++++++++++++
 drivers/tty/tty_port.c              |  2 +-
 drivers/usb/serial/bus.c            | 38 ++++++++++++++++++++++++--
 drivers/usb/serial/ftdi_sio.c       | 42 +++++++++++++++++++++++------
 drivers/usb/serial/ftdi_sio_ids.h   |  1 +
 include/linux/tty.h                 | 14 ++++++++++
 7 files changed, 122 insertions(+), 11 deletions(-)

-- 
2.26.2

