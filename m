Return-Path: <SRS0=DW7M=6V=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 101CAC54E49
	for <linux-serial@archiver.kernel.org>; Thu,  7 May 2020 20:09:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFE542173E
	for <linux-serial@archiver.kernel.org>; Thu,  7 May 2020 20:09:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="m5ylYMv8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728632AbgEGUJO (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 7 May 2020 16:09:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728625AbgEGUJN (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 7 May 2020 16:09:13 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC36DC05BD0A
        for <linux-serial@vger.kernel.org>; Thu,  7 May 2020 13:09:12 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id b8so2387453plm.11
        for <linux-serial@vger.kernel.org>; Thu, 07 May 2020 13:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JZVfMDRlaZxQ6qpzAMsiTzN4YCAYznWKH75NGk0mLe0=;
        b=m5ylYMv87Zesz+z8ZAznR4kWc9TIjqXmxiLRRY8QyOpCZOwt00FTXHCWaihQzLwGTB
         /kjZ0p7FzdVuwoHXJtcPF3yVROz9sUTpYmZCbApuKUmPUpqHuEyGNlO3TyZwioK9zYWZ
         M773j7obrswcIlQPjJ858TSOKYbtG52zYMVnA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JZVfMDRlaZxQ6qpzAMsiTzN4YCAYznWKH75NGk0mLe0=;
        b=ZRBiCVQOoEOPehFyiU9932soZCNUQzp/9Cf/MAjvENdYPHQJEelTdE8N09K6GxnL+4
         8ACESHCYBCU/nWm7FYlq0h2iA4t5XsUFsARUCINv4exZbxJPfcJo7pO+FGfi0wR+dNf+
         0mlrBPFB1guMvyxz4lG548lhTlNJvgT6+841se2V0HcZU4apeF8CSNwI3or//tCN7j0O
         x7icivw6pBgSGJlrx2wYR/WnJpBsCuL0y6XpojL28mP6jrrky6llZoyuKYyIR3yVzKQc
         HQr675lxlcAe0Xi2tU0ipaAV2LDk0BYwWzNpjVO7E4ksEY2OdkFqWgRmibVxOmRkw5XN
         fQPw==
X-Gm-Message-State: AGi0PuY951uhphDma7NCTNvTPjIv64PDIyeYS92SJSJE0bvEGRKuyaT+
        E8Awei9rirLRdKtX3n2XHq0UVw==
X-Google-Smtp-Source: APiQypJWVjHYI0dqkVdBU1DEnnSramGm6bwNGEmhZQc/6xZdlZXzI9QuauPG2Tcya5C3/lJNRD27RQ==
X-Received: by 2002:a17:902:c193:: with SMTP id d19mr15373854pld.60.1588882152281;
        Thu, 07 May 2020 13:09:12 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id d203sm5547601pfd.79.2020.05.07.13.09.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 13:09:11 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     jason.wessel@windriver.com, daniel.thompson@linaro.org,
        gregkh@linuxfoundation.org
Cc:     corbet@lwn.net, frowand.list@gmail.com, bjorn.andersson@linaro.org,
        linux-serial@vger.kernel.org, mingo@redhat.com, hpa@zytor.com,
        jslaby@suse.com, kgdb-bugreport@lists.sourceforge.net,
        sumit.garg@linaro.org, will@kernel.org, tglx@linutronix.de,
        agross@kernel.org, catalin.marinas@arm.com, bp@alien8.de,
        Douglas Anderson <dianders@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Juergen Gross <jgross@suse.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 09/12] Documentation: kgdboc: Document new kgdboc_earlycon parameter
Date:   Thu,  7 May 2020 13:08:47 -0700
Message-Id: <20200507130644.v4.9.I7d5eb42c6180c831d47aef1af44d0b8be3fac559@changeid>
X-Mailer: git-send-email 2.26.2.645.ge9eca65c58-goog
In-Reply-To: <20200507200850.60646-1-dianders@chromium.org>
References: <20200507200850.60646-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The recent patch ("kgdboc: Add kgdboc_earlycon to support early kgdb
using boot consoles") adds a new kernel command line parameter.
Document it.

Note that the patch adding the feature does some comparing/contrasting
of "kgdboc_earlycon" vs. the existing "ekgdboc".  See that patch for
more details, but briefly "ekgdboc" can be used _instead_ of "kgdboc"
and just makes "kgdboc" do its normal initialization early (only works
if your tty driver is already ready).  The new "kgdboc_earlycon" works
in combination with "kgdboc" and is backed by boot consoles.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
---

Changes in v4:
- s/The the/The/

Changes in v3:
- Added example in kgdb.rst
- Removed unneeded sentence in kerenel-parameters doc.
- Renamed earlycon_kgdboc to kgdboc_earlycon.
- Suggest people use kgdboc_earlycon instead of ekgdboc.

Changes in v2: None

 .../admin-guide/kernel-parameters.txt         | 20 ++++++++++++++++
 Documentation/dev-tools/kgdb.rst              | 24 +++++++++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 7bc83f3d9bdf..2cbde9ea476d 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1190,6 +1190,11 @@
 			This is designed to be used in conjunction with
 			the boot argument: earlyprintk=vga
 
+			This parameter works in place of the kgdboc parameter
+			but can only be used if the backing tty is available
+			very early in the boot process. For early debugging
+			via a serial port see kgdboc_earlycon instead.
+
 	edd=		[EDD]
 			Format: {"off" | "on" | "skip[mbr]"}
 
@@ -2105,6 +2110,21 @@
 			 kms, kbd format: kms,kbd
 			 kms, kbd and serial format: kms,kbd,<ser_dev>[,baud]
 
+	kgdboc_earlycon=	[KGDB,HW]
+			If the boot console provides the ability to read
+			characters and can work in polling mode, you can use
+			this parameter to tell kgdb to use it as a backend
+			until the normal console is registered. Intended to
+			be used together with the kgdboc parameter which
+			specifies the normal console to transition to.
+
+			The name of the early console should be specified
+			as the value of this parameter. Note that the name of
+			the early console might be different than the tty
+			name passed to kgdboc. It's OK to leave the value
+			blank and the first boot console that implements
+			read() will be picked.
+
 	kgdbwait	[KGDB] Stop kernel execution and enter the
 			kernel debugger at the earliest opportunity.
 
diff --git a/Documentation/dev-tools/kgdb.rst b/Documentation/dev-tools/kgdb.rst
index d38be58f872a..61293f40bc6e 100644
--- a/Documentation/dev-tools/kgdb.rst
+++ b/Documentation/dev-tools/kgdb.rst
@@ -274,6 +274,30 @@ don't like this are to hack gdb to send the :kbd:`SysRq-G` for you as well as
 on the initial connect, or to use a debugger proxy that allows an
 unmodified gdb to do the debugging.
 
+Kernel parameter: ``kgdboc_earlycon``
+-------------------------------------
+
+If you specify the kernel parameter ``kgdboc_earlycon`` and your serial
+driver registers a boot console that supports polling (doesn't need
+interrupts and implements a nonblocking read() function) kgdb will attempt
+to work using the boot console until it can transition to the regular
+tty driver specified by the ``kgdboc`` parameter.
+
+Normally there is only one boot console (especially that implements the
+read() function) so just adding ``kgdboc_earlycon`` on its own is
+sufficient to make this work. If you have more than one boot console you
+can add the boot console's name to differentiate. Note that names that
+are registered through the boot console layer and the tty layer are not
+the same for the same port.
+
+For instance, on one board to be explicit you might do::
+
+   kgdboc_earlycon=qcom_geni kgdboc=ttyMSM0
+
+If the only boot console on the device was "qcom_geni", you could simplify::
+
+   kgdboc_earlycon kgdboc=ttyMSM0
+
 Kernel parameter: ``kgdbwait``
 ------------------------------
 
-- 
2.26.2.645.ge9eca65c58-goog

