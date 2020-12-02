Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D1A1C64E7C
	for <linux-serial@archiver.kernel.org>; Wed,  2 Dec 2020 11:40:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9E7922203
	for <linux-serial@archiver.kernel.org>; Wed,  2 Dec 2020 11:40:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbgLBLkb (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 2 Dec 2020 06:40:31 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44535 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgLBLkb (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 2 Dec 2020 06:40:31 -0500
Received: by mail-lj1-f196.google.com with SMTP id s9so3164518ljo.11;
        Wed, 02 Dec 2020 03:40:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GXBq8+fXGiepnC5zHNH6qlr+czrZ3uLyy0ohWtOyg1I=;
        b=gkCK17WvC4UcblgAWLMeXGkrmImsTUJV2rgf3yHAbQBndkKhrykH4l0BhiNzZOULde
         Jq1gKeWFfwD/zkM8WxO7sb7pH2hs4hdF7RbZS8J0J10rDppJv52Dh2y/w8patyulapou
         GddHc/uA84FsaINN/hWTSp0zHqnklmiryhsLpHf2yQMSOesovyZS4FJ9fLAZrnasmZvl
         vFblPHURlA1PubMrWd6QTJCTosiK2ce+AynUCbKlqoE5bp4HnoILzfIJ3YYt9rJZcMru
         LearzvuHuJCc1EWL7M2M4uxJ9elnCh/71SfvPE7MgexlLDkYqXBIl4UG5EqLngHpeZT4
         6N0w==
X-Gm-Message-State: AOAM530tpk3+CFCzWqmw5yVFsPbQFkDpsvl3YRGQ0pu3YrDcKr+jEdNm
        PwqplWYJbRYYxh+JY8D2oo14zoM/S0m5rA==
X-Google-Smtp-Source: ABdhPJy2t3xX2Rtq9FJfKsAY8Eo6EMBOPARqfLMGnWr2/EuzEHjXYB8EJxT7wa6D6IdcvLbZojERvQ==
X-Received: by 2002:a05:651c:321:: with SMTP id b1mr957464ljp.387.1606909188051;
        Wed, 02 Dec 2020 03:39:48 -0800 (PST)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id r1sm398356ljg.20.2020.12.02.03.39.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 03:39:47 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@xi.terra>)
        id 1kkQUc-00072k-Go; Wed, 02 Dec 2020 12:40:18 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        "Mychaela N . Falconia" <falcon@freecalypso.org>,
        linux-serial@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH v2 0/7] tty: add flag to suppress ready signalling on open
Date:   Wed,  2 Dec 2020 12:39:35 +0100
Message-Id: <20201202113942.27024-1-johan@kernel.org>
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

Other examples include HAM-radio devices where DTR and RTS is used for
push-to-talk and continuous-wave control and various Arduino boards
which are reset on open unless a jumper is physically removed.

Greg, are you ok we me taking this through my tree? I'm planning on some
follow ups to the ftdi driver and the tty/serial changes are fairly
self-contained.

Also let me know if you prefer to hold this off for 5.12. The change is
minimal, self-contained and low-risk, but it is a new interface and late
in the release cycle as Andy pointed out.

Johan


Changes in v2
 - use assign_bit() in port-flag accessors (Jiri)
 - use const parameters in port-flag accessors (Jiri)
 - use kstrtobool() in attribute store (Andy, Greg)
 - fix "used" typo in commit messages (Andy)
 - use bool constant with port-flag accessor in ftdi quirk (Jiri)
 - add Mychaela's Reviewed-by tag to patch 3/7
 - mention a few more example applications in the cover letter

v1
 - https://lore.kernel.org/r/20201130153742.9163-1-johan@kernel.org


Johan Hovold (5):
  tty: use assign_bit() in port-flag accessors
  tty: use const parameters in port-flag accessors
  tty: add port flag to suppress ready signalling on open
  serial: core: add sysfs attribute to suppress ready signalling on open
  USB: serial: add sysfs attribute to suppress ready signalling on open

Mychaela N. Falconia (2):
  USB: serial: ftdi_sio: pass port to quirk port_probe functions
  USB: serial: ftdi_sio: add support for FreeCalypso DUART28C adapter

 Documentation/ABI/testing/sysfs-tty |  7 ++++
 drivers/tty/serial/serial_core.c    | 26 ++++++++++++++
 drivers/tty/tty_port.c              |  2 +-
 drivers/usb/serial/bus.c            | 35 +++++++++++++++++--
 drivers/usb/serial/ftdi_sio.c       | 42 ++++++++++++++++++-----
 drivers/usb/serial/ftdi_sio_ids.h   |  1 +
 include/linux/tty.h                 | 53 +++++++++++++----------------
 7 files changed, 125 insertions(+), 41 deletions(-)

-- 
2.26.2

