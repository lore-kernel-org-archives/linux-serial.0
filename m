Return-Path: <SRS0=bNnH=52=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF952C2BB85
	for <linux-serial@archiver.kernel.org>; Fri, 10 Apr 2020 22:18:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79DBE20801
	for <linux-serial@archiver.kernel.org>; Fri, 10 Apr 2020 22:18:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Nyq6OxaN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbgDJWSg (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 10 Apr 2020 18:18:36 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:36780 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726776AbgDJWS0 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 10 Apr 2020 18:18:26 -0400
Received: by mail-pj1-f66.google.com with SMTP id nu11so1227231pjb.1
        for <linux-serial@vger.kernel.org>; Fri, 10 Apr 2020 15:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JjUK3hCgG4ZVP2cWUyMCGx3upUSYjvrftcm9fZ76CII=;
        b=Nyq6OxaN+zvvfmKkmfqed97hvOgJeuG7t2F2hgQMntVcHfYzVmfCZSA0sofUwi4fc2
         MVFsZr6W1J2Au1LTfMzh7i4sXkhJe2l6FDr5qfSZgpI4sZhvz2oOWhjK0554O8NF1ahh
         JmfHga1PW8S9Ow9Y6sfCb2wkM0/FrwWdqxhwk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JjUK3hCgG4ZVP2cWUyMCGx3upUSYjvrftcm9fZ76CII=;
        b=H9h5FcLmuGePEXqjkLmvO1u2gEUfi0BRv0Sb2oFWpeAZPZGXUAvvrM74mGp7S816gn
         pp3MsQwVM9902fsPPYVkp6mRIM3EViDEz4hLPPBPDobOZSrvAtdiTf8yK5qGNLxopZAh
         qyfuHAMeVp+tx2OnyWnVnvZws7kcGTrZaaSpYMZstRvmax80v+E4+9sTrNIk6x5JCpJQ
         ZrWN6qNVT7RLQ6YS4podcgcjMdOJNSBIxw8vPftzlAG3TGFOJ8YfEzoIPzJ80QEYGA8l
         oA75vEpb4ndswjG7XRraTS6nF9o/yOk+V3tW0JanOSLAdQDttHk8dTGyRnfBFpaD5uWN
         fM1w==
X-Gm-Message-State: AGi0PuaiMqTKdx0k/6U8G1jzAQhd6G+/RsBmc/jINjzSXeIzXsuwYMNQ
        gjotxrrpyicylHyQhyItsFQwvQ==
X-Google-Smtp-Source: APiQypI1k7F2ESHdo89rqD3FVQ7JzUVJ9BLRyRi3u53jOxnBFX8vHZpXSD/dycmaKpD8jRimhbe90w==
X-Received: by 2002:a17:902:70c1:: with SMTP id l1mr6294862plt.298.1586557106006;
        Fri, 10 Apr 2020 15:18:26 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id x2sm2646600pfq.92.2020.04.10.15.18.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2020 15:18:25 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     jason.wessel@windriver.com, daniel.thompson@linaro.org,
        gregkh@linuxfoundation.org
Cc:     hpa@zytor.com, kgdb-bugreport@lists.sourceforge.net,
        corbet@lwn.net, frowand.list@gmail.com, tglx@linutronix.de,
        jslaby@suse.com, linux-serial@vger.kernel.org, mingo@redhat.com,
        will@kernel.org, bjorn.andersson@linaro.org, agross@kernel.org,
        bp@alien8.de, catalin.marinas@arm.com,
        Douglas Anderson <dianders@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Oliver Neukum <oneukum@suse.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/7] Documentation: kgdboc: Document new earlycon_kgdboc parameter
Date:   Fri, 10 Apr 2020 15:17:24 -0700
Message-Id: <20200410151632.5.I7d5eb42c6180c831d47aef1af44d0b8be3fac559@changeid>
X-Mailer: git-send-email 2.26.0.110.g2183baf09c-goog
In-Reply-To: <20200410221726.36442-1-dianders@chromium.org>
References: <20200410221726.36442-1-dianders@chromium.org>
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

 .../admin-guide/kernel-parameters.txt         | 20 +++++++++++++++++++
 Documentation/dev-tools/kgdb.rst              | 14 +++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index c07815d230bc..37dc2db13743 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1124,6 +1124,22 @@
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
@@ -1182,6 +1198,10 @@
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
2.26.0.110.g2183baf09c-goog

