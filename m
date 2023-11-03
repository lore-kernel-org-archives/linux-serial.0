Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16A01C4332F
	for <linux-serial@archiver.kernel.org>; Fri,  3 Nov 2023 11:13:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbjKCLN1 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 3 Nov 2023 07:13:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbjKCLN0 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 3 Nov 2023 07:13:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6BCA18B
        for <linux-serial@vger.kernel.org>; Fri,  3 Nov 2023 04:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699009961;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=EKotJyX83ZQaavHXcaSrvHRltZ/PTiWvZAqWNqbIC/E=;
        b=dP1lA0wXVllVPCB3f4apEs5lAuV3FpAUHHQwcquHvgmzQqIezPv7QCJoHlTy3xFJ8lWkJy
        +8mUzbQG1xxxxIj3+Nhgv8TfmIVNrPzcDK/680OH3CANwY3rB7pmNOyQomRMGJXK2JhnGm
        uL/JJP1y4wkZcqlaaOuZk81zoJ/ySSs=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-zXMrJ4JuNmef0FsLOw_pVw-1; Fri, 03 Nov 2023 07:12:39 -0400
X-MC-Unique: zXMrJ4JuNmef0FsLOw_pVw-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-9c39f53775fso29748766b.1
        for <linux-serial@vger.kernel.org>; Fri, 03 Nov 2023 04:12:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699009958; x=1699614758;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EKotJyX83ZQaavHXcaSrvHRltZ/PTiWvZAqWNqbIC/E=;
        b=CCrXnNnGfmHQiOiG2vt4rxwbM/RP38oxq8rvN/yO7aeSuSCP3nwVsqmVwUbhkXQ4wC
         Lhyqer4njihRUNpbXfDTga7Grwx3Z1WqZbzHic1zBWv4lyRFk8M5lLOzYNVZxp+tvLSG
         wLIRE6jp49U8uwdByc6IGqE9jVCzfumLEzD8JQGk6kWOoFLTZooMpYm+thO7PGd1teM2
         kO2sWa0M70KlkhKKAbDto7+DT0tLw4SpsxEj5JHzhoBnnZ2iTf4TiTyUzbI+dCq9TKMj
         PV7arbz/atnPVorytqm1fBOj02PQA+fhS4WAgg9uMos3Br1JE0Azb/6zfKltM/91DGnh
         nIng==
X-Gm-Message-State: AOJu0YyEy4SWZJJvEjBq9V6EnDYpiGxXNZNYMp1IXi7iensZiijJzls6
        amHkJBUzURaiYECYhnbwL1wDlCFRIOnN8TkaydhWkQlNb0k72BHBQEkA0pKHZ+UrzGRyTdHOPDJ
        xVUOkrBUJcKx0KuoICBuF93s9
X-Received: by 2002:a17:907:1c92:b0:9be:8de2:a56c with SMTP id nb18-20020a1709071c9200b009be8de2a56cmr19512557ejc.0.1699009958712;
        Fri, 03 Nov 2023 04:12:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQ97Ex9NOJxwu7cZf4ypToBcAvCkm8BR3IA1Z58ARKTni5k4nc2QCM9BdvMu0agZFpWc0fWA==
X-Received: by 2002:a17:907:1c92:b0:9be:8de2:a56c with SMTP id nb18-20020a1709071c9200b009be8de2a56cmr19512524ejc.0.1699009958376;
        Fri, 03 Nov 2023 04:12:38 -0700 (PDT)
Received: from pstanner-thinkpadt14sgen1.fritz.box ([2001:9e8:32d1:5200:227b:d2ff:fe26:2a7a])
        by smtp.gmail.com with ESMTPSA id gw14-20020a170906f14e00b009ae3d711fd9sm786814ejb.69.2023.11.03.04.12.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 04:12:38 -0700 (PDT)
From:   Philipp Stanner <pstanner@redhat.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Philipp Stanner <pstanner@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Tony Luck <tony.luck@intel.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Dave Airlie <airlied@redhat.com>
Subject: [PATCH v2] drivers/tty/vt: use standard array-copy-functions
Date:   Fri,  3 Nov 2023 12:12:08 +0100
Message-ID: <20231103111207.74621-2-pstanner@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tty/vt currently uses memdup_user() and vmemdup_array_user() to copy
userspace arrays.

Whereas there is no danger of overflowing, the call to vmemdup_user()
currently utilizes array_size() to calculate the array size
nevertheless. This is not useful because array_size() would return
SIZE_MAX and pass it to vmemdup_user() in case of (the impossible)
overflow.

string.h from the core-API now provides the wrappers memdup_array_user()
and vmemdup_array_user() to copy userspace arrays in a standardized
manner. Additionally, they also perform generic overflow-checks.

Use these wrappers to make it more obvious and readable that arrays are
being copied.

As we are at it, remove two unnecessary empty lines.

Suggested-by: Dave Airlie <airlied@redhat.com>
Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
Changes in v2:
- Remove two empty lines from keyboard.c
- Rephrase the commit message completely to make it obvious that we're
  not actually fixing a really possible overflow here. Emphasize the
  commit being about unifying array-copying. (Al Viro)
---
 drivers/tty/vt/consolemap.c |  2 +-
 drivers/tty/vt/keyboard.c   | 10 ++++------
 2 files changed, 5 insertions(+), 7 deletions(-)

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
index 1fe6107b539b..96f19ef360b5 100644
--- a/drivers/tty/vt/keyboard.c
+++ b/drivers/tty/vt/keyboard.c
@@ -1772,12 +1772,10 @@ int vt_do_diacrit(unsigned int cmd, void __user *udp, int perm)
 			return -EINVAL;
 
 		if (ct) {
-
-			dia = memdup_user(a->kbdiacr,
-					sizeof(struct kbdiacr) * ct);
+			dia = memdup_array_user(a->kbdiacr,
+						ct, sizeof(struct kbdiacr));
 			if (IS_ERR(dia))
 				return PTR_ERR(dia);
-
 		}
 
 		spin_lock_irqsave(&kbd_event_lock, flags);
@@ -1811,8 +1809,8 @@ int vt_do_diacrit(unsigned int cmd, void __user *udp, int perm)
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

