Return-Path: <SRS0=3oyo=EK=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34E8BC4741F
	for <linux-serial@archiver.kernel.org>; Wed,  4 Nov 2020 19:35:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFA0C2080D
	for <linux-serial@archiver.kernel.org>; Wed,  4 Nov 2020 19:35:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tPpnG9Xq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbgKDTf5 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 4 Nov 2020 14:35:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726779AbgKDTf4 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 4 Nov 2020 14:35:56 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 331BBC061A4D
        for <linux-serial@vger.kernel.org>; Wed,  4 Nov 2020 11:35:56 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id 23so2544846wmg.1
        for <linux-serial@vger.kernel.org>; Wed, 04 Nov 2020 11:35:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jxJovM8uDqxzTsn9dVqfv0BrrWZVdtSmY0ZF8ZUveX8=;
        b=tPpnG9Xq0fL6ljrah9eqo6gIO+7EFirJIIvgiced9ycP88Q8KlHpshTpZKcvgizvJN
         DqVDEBLns8yBcUkmpYWgGUSuOeuHwc3TbeagV22ul0tUT7FGEaANe6mr2M3zH1Ec6Z05
         dCH6ia3+OS223SMvWzLLHuXpDFCNLMIVdigWev4DmGI1eXmNginogEzXPeMA79X1yVLV
         0qxxtJRnjyHJLEc/h2eBmqyGiNydmzfE3+aZSxanbJKMIY8u2keejYT051xW+oj82BfS
         wy+JhFXK6BjGfUjjwLP8W/PJD/RldyJXs3gJlou3nOdWUM0pUSiSA9aD3ga+L1YtZxim
         i6TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jxJovM8uDqxzTsn9dVqfv0BrrWZVdtSmY0ZF8ZUveX8=;
        b=NhjCoS+LlRvMdZ5eEUEWqeW9eJ7syjnr2Ci04/2CJKuOlB1WC9swI51naOcs7g/KS9
         hOdK1Ti0P7BXo/XIKfX3MesNFq1wJalfdfSYm4KZy7ofFAM1xXphXLa0YKcUzdGFlw8W
         hkL1/ztwDC1J4VcnctKcQ4vNckQFAIH2i6/rmsYYYhUNygcq8Bh3TpdlYlRGgmADtKFE
         tX4STw3BWCzTEnS4NkkSHEAcL7irCUVqM4WKlmIwBukDxz302uRbTJO/zI639TQu0VJe
         n3FuI/DSi9TT44j5ZwRqNq4I17vFVQYp+M+KB+DvwMpDaowwjDrSPAxDMG4rWARoHm0X
         THtA==
X-Gm-Message-State: AOAM5311s/8LH3qFzp8vhNtw4iK2PMIAB7M8veaR7jZ0P/srYWobFLYu
        QxZgxYw12XIlxzESx6MonFrqZA==
X-Google-Smtp-Source: ABdhPJwDg2lxqbHlNGOB+b3ejFgNnWIzk2D54Jbj3ObyHrWkPcl/d3c3TSyNOcinZAfD1+eqPp2ICw==
X-Received: by 2002:a1c:4e1a:: with SMTP id g26mr6283218wmh.98.1604518554550;
        Wed, 04 Nov 2020 11:35:54 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id x10sm4034444wrp.62.2020.11.04.11.35.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 11:35:53 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Torgue <alexandre.torgue@st.com>,
        "Andrew J. Kroll" <ag784@freenet.buffalo.edu>,
        Andrew Morton <andrewm@uow.edu.eu>,
        Andy Gross <agross@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Bill Hawes <whawes@star.net>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Colin Ian King <colin.king@canonical.com>,
        "C. Scott Ananian" <cananian@alumni.princeton.edu>,
        "David A. Hinds" <dahinds@users.sourceforge.net>,
        dri-devel@lists.freedesktop.org, Filip Aben <f.aben@option.com>,
        Gerald Baeza <gerald.baeza@st.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jakub Jelinek <jj@ultra.linux.cz>,
        Jan Dumon <j.dumon@option.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Joseph Barrow <d.barow@option.com>,
        -- <julian@uhunix.uhcc.hawaii.edu>,
        Kevin Wells <kevin.wells@nxp.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        linaro-mm-sig@lists.linaro.org, linux-arm-msm@vger.kernel.org,
        linux-media@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-serial@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-tegra@vger.kernel.org, Marko Kohtala <Marko.Kohtala@hut.fi>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Simek <michal.simek@xilinx.com>,
        Mike Hudson <Exoray@isys.ca>, Miloslav Trmac <mitr@redhat.com>,
        Nick Holloway <alfie@dcs.warwick.ac.uk>,
        Palmer Dabbelt <palmer@dabbelt.com>, paulkf@microgate.com,
        Paul Mackerras <paulus@samba.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        processes-Sapan Bhatia <sapan@corewars.org>,
        Robert Love <rlove@google.com>, Rob Herring <robh@kernel.org>,
        Roland Stigge <stigge@antcom.de>,
        Russell King <linux@armlinux.org.uk>,
        Russell King <rmk@arm.linux.org.uk>,
        Russ Gorby <russ.gorby@intel.com>,
        Stanislav Voronyi <stas@cnti.uanet.kharkov.ua>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Vladimir Zapolskiy <vz@mleia.com>
Subject: [PATCH 00/36] Rid W=1 issues from TTY
Date:   Wed,  4 Nov 2020 19:35:13 +0000
Message-Id: <20201104193549.4026187-1-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This set is part of a larger effort attempting to clean-up W=1
kernel builds, which are currently overwhelmingly riddled with
niggly little warnings.

Lee Jones (36):
  tty: serdev: core: Remove unused variable 'dummy'
  tty: serdev: core: Provide missing description for 'owner'
  tty: tty_baudrate: Add missing description for 'tty'
  tty: tty_io: Move 'tty_sysctl_init's prototype to shared space
  tty: tty_buffer: Add missing description for 'limit'
  tty: tty_port: Demote obvious abuse of kernel-doc formatting
  tty: tty_jobctrl: Add missing function parameter descriptions
  tty: tty_ldisc: Fix some kernel-doc related misdemeanours
  tty: vt: consolemap: Demote weakly documented function header
  tty: n_tty: Add 2 missing parameter descriptions
  tty: serial: jsm: jsm_cls: Remove unused variable 'discard'
  tty: tty_io: Fix some kernel-doc issues
  tty: serial: 8250: 8250_port: Staticify functions referenced by
    pointers
  tty: serial: 8250: serial_cs: Remove unused/unchecked variable 'err'
  tty: tty_audit: Demote non-conformant kernel-doc headers
  tty: pty: Provide descriptions for the 'file' parameters
  tty: serial: amba-pl011: Mark 'sbsa_uart_acpi_match' as __maybe_unused
  tty: n_gsm: Demote obvious abuse of kernel-doc and supply other
    missing docss
  tty: serial: lpc32xx_hs: Remove unused variable 'tmp'
  tty: serial: msm_serial: Remove set but unused variable 'status'
  tty: serial: ifx6x60: Fix function documentation headers
  tty: serial: xilinx_uartps: Supply description for missing member
    'cts_override'
  tty: synclink_gt: Demote one kernel-doc header and repair another
  tty: serial: serial-tegra: Struct headers should start with 'struct
    <name>'
  tty: serial: sifive: Struct headers should start with 'struct <name>'
  tty: synclinkmp: Add missing description for function param 'txqueue'
  tty: synclinkmp: Mark never checked 'readval' as __always_unused
  tty: serial: stm32-usart: Remove set but unused 'cookie' variables
  tty: tty_ldisc: Supply missing description for 'tty_ldisc_get's 'tty'
    param
  tty: serial: serial-tegra: Provide some missing struct member
    descriptions
  powerpc: asm: hvconsole: Move 'hvc_vio_init_early's prototype to
    shared location
  tty: hvc: hvc_vio: Staticify function invoked only by reference
  tty: hvc: hvc_opal: Staticify function invoked by reference
  tty: serial: pmac_zilog: Make disposable variable __always_unused
  tty: synclink: Mark disposable variables as __always_unused
  tty: synclink: Provide missing description for 'hdlcdev_tx_timeout's
    'txqueue' param

 arch/powerpc/include/asm/hvconsole.h     |  3 +++
 arch/powerpc/platforms/pseries/pseries.h |  3 ---
 arch/powerpc/platforms/pseries/setup.c   |  1 +
 drivers/tty/hvc/hvc_opal.c               |  2 +-
 drivers/tty/hvc/hvc_vio.c                |  2 +-
 drivers/tty/n_gsm.c                      |  4 +++-
 drivers/tty/n_tty.c                      |  2 ++
 drivers/tty/pty.c                        |  2 ++
 drivers/tty/serdev/core.c                |  6 ++----
 drivers/tty/serial/8250/8250_port.c      |  4 ++--
 drivers/tty/serial/8250/serial_cs.c      |  9 +++------
 drivers/tty/serial/amba-pl011.c          |  2 +-
 drivers/tty/serial/ifx6x60.c             |  3 ++-
 drivers/tty/serial/jsm/jsm_cls.c         |  4 +---
 drivers/tty/serial/lpc32xx_hs.c          |  3 +--
 drivers/tty/serial/msm_serial.c          |  3 +--
 drivers/tty/serial/pmac_zilog.h          |  2 +-
 drivers/tty/serial/serial-tegra.c        |  7 ++++++-
 drivers/tty/serial/sifive.c              |  3 ++-
 drivers/tty/serial/stm32-usart.c         |  6 ++----
 drivers/tty/serial/xilinx_uartps.c       |  1 +
 drivers/tty/synclink.c                   |  5 +++--
 drivers/tty/synclink_gt.c                |  3 ++-
 drivers/tty/synclinkmp.c                 |  3 ++-
 drivers/tty/tty_audit.c                  | 12 ++++++------
 drivers/tty/tty_baudrate.c               |  1 +
 drivers/tty/tty_buffer.c                 |  1 +
 drivers/tty/tty_io.c                     | 12 +++++++-----
 drivers/tty/tty_jobctrl.c                |  3 +++
 drivers/tty/tty_ldisc.c                  | 11 ++++++-----
 drivers/tty/tty_port.c                   |  4 ++--
 drivers/tty/vt/consolemap.c              |  3 +--
 include/linux/tty.h                      |  1 +
 33 files changed, 73 insertions(+), 58 deletions(-)

Cc: Alexandre Torgue <alexandre.torgue@st.com>
Cc: "Andrew J. Kroll" <ag784@freenet.buffalo.edu>
Cc: Andrew Morton <andrewm@uow.edu.eu>
Cc: Andy Gross <agross@kernel.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Bill Hawes <whawes@star.net>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: Colin Ian King <colin.king@canonical.com>
Cc: "C. Scott Ananian" <cananian@alumni.princeton.edu>
Cc: "David A. Hinds" <dahinds@users.sourceforge.net>
Cc: dri-devel@lists.freedesktop.org
Cc: Filip Aben <f.aben@option.com>
Cc: Gerald Baeza <gerald.baeza@st.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jakub Jelinek <jj@ultra.linux.cz>
Cc: Jan Dumon <j.dumon@option.com>
Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: Jonathan Hunter <jonathanh@nvidia.com>
Cc: Joseph Barrow <d.barow@option.com>
Cc: -- <julian@uhunix.uhcc.hawaii.edu>
Cc: Kevin Wells <kevin.wells@nxp.com>
Cc: Laxman Dewangan <ldewangan@nvidia.com>
Cc: linaro-mm-sig@lists.linaro.org
Cc: linux-arm-msm@vger.kernel.org
Cc: linux-media@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-riscv@lists.infradead.org
Cc: linux-serial@vger.kernel.org
Cc: linux-stm32@st-md-mailman.stormreply.com
Cc: linux-tegra@vger.kernel.org
Cc: Marko Kohtala <Marko.Kohtala@hut.fi>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Michal Simek <michal.simek@xilinx.com>
Cc: Mike Hudson <Exoray@isys.ca>
Cc: Miloslav Trmac <mitr@redhat.com>
Cc: Nick Holloway <alfie@dcs.warwick.ac.uk>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: paulkf@microgate.com
Cc: Paul Mackerras <paulus@samba.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: processes-Sapan Bhatia <sapan@corewars.org>
Cc: Robert Love <rlove@google.com>
Cc: Rob Herring <robh@kernel.org>
Cc: Roland Stigge <stigge@antcom.de>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Russell King <rmk@arm.linux.org.uk>
Cc: Russ Gorby <russ.gorby@intel.com>
Cc: Stanislav Voronyi <stas@cnti.uanet.kharkov.ua>
Cc: Sumit Semwal <sumit.semwal@linaro.org>
Cc: Sylvain Lemieux <slemieux.tyco@gmail.com>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Vladimir Zapolskiy <vz@mleia.com>
-- 
2.25.1

