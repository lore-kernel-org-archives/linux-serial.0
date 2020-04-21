Return-Path: <SRS0=t3pX=6F=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABB0AC55185
	for <linux-serial@archiver.kernel.org>; Tue, 21 Apr 2020 21:15:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8418620747
	for <linux-serial@archiver.kernel.org>; Tue, 21 Apr 2020 21:15:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DJykRx+t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726245AbgDUVPn (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 21 Apr 2020 17:15:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726386AbgDUVP2 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 21 Apr 2020 17:15:28 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FE0DC061BD3
        for <linux-serial@vger.kernel.org>; Tue, 21 Apr 2020 14:15:28 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id n16so7372802pgb.7
        for <linux-serial@vger.kernel.org>; Tue, 21 Apr 2020 14:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aFTviJPrKuTMM7A/RFhxVuMj7vnHygi6BZ20JfR32qQ=;
        b=DJykRx+tWWAumEWwnSE3iLPH/LZN5hsuI9JxuBHfkBbrifQ+PTh/SAy2vB0gT+4ZGT
         41raTO+9jGi733au3YEoRUgZ+wWSdTJP4kiLGz5Yb/9nmsQWucxZEds8LBLzz7IE++R4
         rwed5Me4aZ97tVLFx2HbojUAkouKfjL/0tU3k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aFTviJPrKuTMM7A/RFhxVuMj7vnHygi6BZ20JfR32qQ=;
        b=qALddQ1j/rLJk5L3MLg/XP480Lg1liuG0xFBG06ghftVBaK3/QoPvmNVfHZQbKccgl
         IWkb/ObBmjwBbu8WsX6qhZQcZYUALKCwf8mm1XyjlUz3SoUBJ/9peZxziXaiUNG9XR5j
         KdWcoq2Wqipi5vQsxKm7484ShmIqslOScHftjq9ZNBQeGo4qwrMGFUJ9422DVhxKyX9G
         EEpH7jnx/Kyo6oGhyk0Z36AAp3zZyEfc4wRSbaU83k7nrj/kit+eH6emgz9RKVZaF8u6
         skNvNt9by2HoqYHjycq1C0U5Q05T0wBFIGHS5nb9uDNyLTJ+nrZ0aHoWnguTH1WYkqiG
         0Eug==
X-Gm-Message-State: AGi0PubMl+Tg82Nnvlaiym0R0mip6MfT/6ZU/JGsFjQ7RyJpNAJYWsgu
        eb05UyJAC0eXicJgkWGyar20zQ==
X-Google-Smtp-Source: APiQypLAD11AV9Mkwm3S1Q5SGQ1l09QLFYenxp/jtXM3LJz9RnpH2GYoSx8jPUB+F6dCGtfle08i1Q==
X-Received: by 2002:a63:1506:: with SMTP id v6mr24334707pgl.365.1587503728073;
        Tue, 21 Apr 2020 14:15:28 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id c1sm3287880pfo.152.2020.04.21.14.15.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 14:15:27 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     jason.wessel@windriver.com, daniel.thompson@linaro.org,
        gregkh@linuxfoundation.org
Cc:     kgdb-bugreport@lists.sourceforge.net, mingo@redhat.com,
        hpa@zytor.com, bp@alien8.de, linux-serial@vger.kernel.org,
        agross@kernel.org, tglx@linutronix.de, frowand.list@gmail.com,
        bjorn.andersson@linaro.org, jslaby@suse.com,
        catalin.marinas@arm.com, corbet@lwn.net, will@kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@suse.de>, Juergen Gross <jgross@suse.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 7/9] Documentation: kgdboc: Document new earlycon_kgdboc parameter
Date:   Tue, 21 Apr 2020 14:14:45 -0700
Message-Id: <20200421141234.v2.7.I7d5eb42c6180c831d47aef1af44d0b8be3fac559@changeid>
X-Mailer: git-send-email 2.26.1.301.g55bc3eb7cb9-goog
In-Reply-To: <20200421211447.193860-1-dianders@chromium.org>
References: <20200421211447.193860-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The recent patch ("kgdboc: Add earlycon_kgdboc to support early kgdb
using boot consoles") adds a new kernel command line parameter.
Document it.

Note that the patch adding the feature does some comparing/contrasting
of "earlycon_kgdboc" vs. the existing "ekgdboc".  See that patch for
more details, but briefly "ekgdboc" can be used _instead_ of "kgdboc"
and just makes "kgdboc" do its normal initialization early (only works
if your tty driver is already ready).  The new "earlycon_kgdboc" works
in combination with "kgdboc" and is backed by boot consoles.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v2: None

 .../admin-guide/kernel-parameters.txt         | 20 +++++++++++++++++++
 Documentation/dev-tools/kgdb.rst              | 14 +++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index f2a93c8679e8..588625ec2993 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1132,6 +1132,22 @@
 			address must be provided, and the serial port must
 			already be setup and configured.
 
+	earlycon_kgdboc=	[KGDB,HW]
+			If the boot console provides the ability to read
+			characters and can work in polling mode, you can use
+			this parameter to tell kgdb to use it as a backend
+			until the normal console is registered. Intended to
+			be used together with the kgdboc parameter which
+			specifies the normal console to transition to.
+
+			The the name of the early console should be specified
+			as the value of this parameter. Note that the name of
+			the early console might be different than the tty
+			name passed to kgdboc. If only one boot console with
+			a read() function is enabled it's OK to leave the
+			value blank and the first boot console that implements
+			read() will be picked.
+
 	earlyprintk=	[X86,SH,ARM,M68k,S390]
 			earlyprintk=vga
 			earlyprintk=sclp
@@ -1190,6 +1206,10 @@
 			This is designed to be used in conjunction with
 			the boot argument: earlyprintk=vga
 
+			This parameter works in place of the kgdboc parameter
+			but can only be used if the backing tty is available
+			very early in the boot process.
+
 	edd=		[EDD]
 			Format: {"off" | "on" | "skip[mbr]"}
 
diff --git a/Documentation/dev-tools/kgdb.rst b/Documentation/dev-tools/kgdb.rst
index d38be58f872a..c0b321403d9a 100644
--- a/Documentation/dev-tools/kgdb.rst
+++ b/Documentation/dev-tools/kgdb.rst
@@ -274,6 +274,20 @@ don't like this are to hack gdb to send the :kbd:`SysRq-G` for you as well as
 on the initial connect, or to use a debugger proxy that allows an
 unmodified gdb to do the debugging.
 
+Kernel parameter: ``earlycon_kgdboc``
+-------------------------------------
+
+If you specify the kernel parameter ``earlycon_kgdboc`` and your serial
+driver registers a boot console that supports polling (doesn't need
+interrupts and implements a nonblocking read() function) kgdb will attempt
+to work using the boot console until it can transition to the regular
+tty driver specified by the ``kgdboc`` parameter.
+
+Normally there is only one boot console (especially that implements the
+read() function) so just adding ``earlycon_kgdboc`` on its own is
+sufficient to make this work.  If you have more than one boot console you
+can add the boot console's name to differentiate.
+
 Kernel parameter: ``kgdbwait``
 ------------------------------
 
-- 
2.26.1.301.g55bc3eb7cb9-goog

