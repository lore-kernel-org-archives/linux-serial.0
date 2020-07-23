Return-Path: <SRS0=2ftc=BC=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 673EEC433E5
	for <linux-serial@archiver.kernel.org>; Thu, 23 Jul 2020 12:33:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38513206D7
	for <linux-serial@archiver.kernel.org>; Thu, 23 Jul 2020 12:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595507630;
	bh=yafdt/L+/c8WtubqlGnlrh8tMDAtkM861vx4x6jumyw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=snceca4Tz38DxecDTrsVVGs0ARocMAT0zO0W1uTDCdeA7Z66GJZN8rh2SgWVfZLcK
	 uFs+Fem7SppUDlL3fhu8UmhxsmLGRP0SIm+8LfPFwogszDvyMKxQfx6xxgQAkwkVYr
	 wzLUrz3bF7i0g7ZCF7F8FeJ4w29MCtrD91CIH4lY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728690AbgGWMdm (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 23 Jul 2020 08:33:42 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:35922 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726714AbgGWMdl (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 23 Jul 2020 08:33:41 -0400
Received: by mail-lf1-f65.google.com with SMTP id k17so3173135lfg.3;
        Thu, 23 Jul 2020 05:33:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RgoK4kANOOog4NgFMgyLLEn/I8CQdmvG2ET0K3WbRyc=;
        b=LSQ1wCBmJ3/jm0bNAbTqTlbrfOet+xi56DeqkAvVfonGsdZ23bHDq4t+Kxe2tDpejZ
         rSu8v852tpzZ606kaVhjr7mVSXspG4wfNnK1onFxxUferjMS4UIHuF8iPlqpTKaazh94
         bo2Cyf2AgADKETh/dv6sVaG+C4OCq6+v79wRBHmCeBv/+IP1Ji/6LnPTqPglZ4OFy5su
         Mo820azT257RnbESxy5FFJP32xCsirTQpgwId55xgunGReDs7srunZ4E69W9eTzN8Fk0
         hmgQII+oEHE3/SCO4MXmbniSH06l96McMq6TgiMsK0HMlsMkfBJsPPNAwfiD78/sCd18
         k/Iw==
X-Gm-Message-State: AOAM530+H6Z0ko0P/MCMWD+3ycfmiOWDYM3AwDfX5O8J2xROvBE38oHy
        tcc8R49biTnFH0A/xosfTHU=
X-Google-Smtp-Source: ABdhPJyolhNlVhCLc4LVaa2llaCC2EUR2vpuIjWWfxU2JlmgPqar+w2QmQ1zQbWLBX5iaX9MNSiVGA==
X-Received: by 2002:ac2:494c:: with SMTP id o12mr1375163lfi.181.1595507619215;
        Thu, 23 Jul 2020 05:33:39 -0700 (PDT)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id e12sm2630851ljk.74.2020.07.23.05.33.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 05:33:38 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@xi.terra>)
        id 1jyaPk-0001X3-MZ; Thu, 23 Jul 2020 14:33:32 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v2 1/2] serial: pmac_zilog: add sparse context annotation
Date:   Thu, 23 Jul 2020 14:33:26 +0200
Message-Id: <20200723123327.5843-2-johan@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200723123327.5843-1-johan@kernel.org>
References: <20200723123327.5843-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Add sparse context annotation to the receive handler, which releases and
reacquires the port lock, to silence a sparse warning:

	drivers/tty/serial/pmac_zilog.c:255:36: sparse: sparse: context imbalance in 'pmz_receive_chars' - unexpected unlock

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/tty/serial/pmac_zilog.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/pmac_zilog.c b/drivers/tty/serial/pmac_zilog.c
index ba65a3bbd72a..96e7aa479961 100644
--- a/drivers/tty/serial/pmac_zilog.c
+++ b/drivers/tty/serial/pmac_zilog.c
@@ -213,6 +213,7 @@ static void pmz_interrupt_control(struct uart_pmac_port *uap, int enable)
 }
 
 static bool pmz_receive_chars(struct uart_pmac_port *uap)
+	__must_hold(&uap->port.lock)
 {
 	struct tty_port *port;
 	unsigned char ch, r1, drop, flag;
-- 
2.26.2

