Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D44D2C4332F
	for <linux-serial@archiver.kernel.org>; Thu,  2 Nov 2023 19:22:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345944AbjKBTWx (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 2 Nov 2023 15:22:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345380AbjKBTWx (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 2 Nov 2023 15:22:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9A59188
        for <linux-serial@vger.kernel.org>; Thu,  2 Nov 2023 12:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698952923;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=gMbvaW7xFMUV0KcreKNTNoj1dffs08hfun7sVblosFo=;
        b=ZxwDsT9SfH8luO/AopZkYVnQJK4JiZW4EtT+qElWn7asFGZ6HZuFgOioq7ZoWcLqg/jIXF
        UAO8Rb54SxRFP1TvuTMS/ddjeKmKEwbUWYnAaXG2O0LGcmyh860XQzG6XAmsvB+qpJgk4c
        /Kzgzh1TRqzBS8HIvN5JyjuFraqhrA4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-166-IANsogjWOqmIlsqW3YWHNg-1; Thu, 02 Nov 2023 15:22:00 -0400
X-MC-Unique: IANsogjWOqmIlsqW3YWHNg-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-40856440f41so2739925e9.1
        for <linux-serial@vger.kernel.org>; Thu, 02 Nov 2023 12:22:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698952919; x=1699557719;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gMbvaW7xFMUV0KcreKNTNoj1dffs08hfun7sVblosFo=;
        b=c+o1VBLwyav2kNe9V9YdS3pvyCC7ELt7O5fJ4QGIiablP+2VCo0B636blHmQrLQrDp
         M3ASTLDFoob+tmP1qjwQoIEyTzrlNfUTCthmMQiDNfqLTHipbh4gJNBZ6jiU2aGNZnOT
         Pie6oM3o7nBFrGDm3dMID9VK1c4t0hr5nCBVB3sLh1drnDf9MKD3tAQkiAqkD34KHsz+
         PY9EQhVGGwpxg9135eu24GZnnJ6Qf8TKISm59Sq+gAL+lYLDsXCp5dihWzix+q89Ulb5
         d1Fs/fVk8W05BlvfiuZaCOysoviSKNrubOWJx+cN8276IwOjy2rTamGA8A0t5FvS7BfW
         X0mw==
X-Gm-Message-State: AOJu0YwpPewHhdhsKQoIWVOtGzRaEqtRh3vNuOl8MDSZoAoUI2bnJRtC
        cAroMMZic4RcHJ6E/MMyOF1V99LPmSBWkFLfsEF1A8TygcdHi6NxoRXv/S98Bkx6fTWpkqDQ0dF
        RDk1diZXe1x7/csxZMx1SQvWc
X-Received: by 2002:a5d:6b06:0:b0:32f:7648:18b6 with SMTP id v6-20020a5d6b06000000b0032f764818b6mr9906428wrw.6.1698952919700;
        Thu, 02 Nov 2023 12:21:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF3mjA4NEtrXUS/d0Brl+TuRNJcpgXcLj1pTDEgegrB7GTIvz59l85VBE10bZg+13/IBsEvHA==
X-Received: by 2002:a5d:6b06:0:b0:32f:7648:18b6 with SMTP id v6-20020a5d6b06000000b0032f764818b6mr9906408wrw.6.1698952919393;
        Thu, 02 Nov 2023 12:21:59 -0700 (PDT)
Received: from pstanner-thinkpadt14sgen1.remote.csb ([2001:9e8:32c5:d600:227b:d2ff:fe26:2a7a])
        by smtp.gmail.com with ESMTPSA id c18-20020a5d5292000000b0032da87e32e2sm119892wrv.4.2023.11.02.12.21.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 12:21:59 -0700 (PDT)
From:   Philipp Stanner <pstanner@redhat.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Philipp Stanner <pstanner@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Tony Luck <tony.luck@intel.com>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Dave Airlie <airlied@redhat.com>
Subject: [PATCH] drivers/tty/vt: copy userspace arrays safely
Date:   Thu,  2 Nov 2023 20:21:35 +0100
Message-ID: <20231102192134.53301-2-pstanner@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The functions (v)memdup_user() are utilized to copy userspace arrays.
This is done without overflow checks.

Use the new wrappers memdup_array_user() and vmemdup_array_user() to
copy the arrays more safely.

Suggested-by: Dave Airlie <airlied@redhat.com>
Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/tty/vt/consolemap.c | 2 +-
 drivers/tty/vt/keyboard.c   | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/vt/consolemap.c b/drivers/tty/vt/consolemap.c
index f02d21e2a96e..313cef3322eb 100644
--- a/drivers/tty/vt/consolemap.c
+++ b/drivers/tty/vt/consolemap.c
@@ -644,7 +644,7 @@ int con_set_unimap(struct vc_data *vc, ushort ct, struct unipair __user *list)
 	if (!ct)
 		return 0;
 
-	unilist = vmemdup_user(list, array_size(sizeof(*unilist), ct));
+	unilist = vmemdup_array_user(list, ct, sizeof(*unilist));
 	if (IS_ERR(unilist))
 		return PTR_ERR(unilist);
 
diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
index 1fe6107b539b..802ceb0a5e4c 100644
--- a/drivers/tty/vt/keyboard.c
+++ b/drivers/tty/vt/keyboard.c
@@ -1773,8 +1773,8 @@ int vt_do_diacrit(unsigned int cmd, void __user *udp, int perm)
 
 		if (ct) {
 
-			dia = memdup_user(a->kbdiacr,
-					sizeof(struct kbdiacr) * ct);
+			dia = memdup_array_user(a->kbdiacr,
+						ct, sizeof(struct kbdiacr));
 			if (IS_ERR(dia))
 				return PTR_ERR(dia);
 
@@ -1811,8 +1811,8 @@ int vt_do_diacrit(unsigned int cmd, void __user *udp, int perm)
 			return -EINVAL;
 
 		if (ct) {
-			buf = memdup_user(a->kbdiacruc,
-					  ct * sizeof(struct kbdiacruc));
+			buf = memdup_array_user(a->kbdiacruc,
+						ct, sizeof(struct kbdiacruc));
 			if (IS_ERR(buf))
 				return PTR_ERR(buf);
 		} 
-- 
2.41.0

