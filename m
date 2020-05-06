Return-Path: <SRS0=tlDI=6U=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2182C28CBC
	for <linux-serial@archiver.kernel.org>; Wed,  6 May 2020 11:21:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3A572070B
	for <linux-serial@archiver.kernel.org>; Wed,  6 May 2020 11:21:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q4zB0Rf9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbgEFLVx (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 6 May 2020 07:21:53 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39037 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726975AbgEFLVx (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 6 May 2020 07:21:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588764112;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=dyBeBM3FMukKdQkbDKzhstncX2ZdEJKF6/LgPra/QJA=;
        b=Q4zB0Rf9re8PfiEfAigdFDi/P7xTV0oUr87J6KVRQFtogeFnEJPEHfZAo38DmRJ8lhAbqR
        sujGTV4J2IPipeltMar0DZLlb4Zi0azH/3aNTL/rndIuqV4Xop+pgIKIcTPmsJCgAq7KvL
        qDS12/u218j+lMXnZ28oOMZbqWnfryk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-80-LzFkceDOOGinn2O2eXavkw-1; Wed, 06 May 2020 07:21:48 -0400
X-MC-Unique: LzFkceDOOGinn2O2eXavkw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5E749107ACCD;
        Wed,  6 May 2020 11:21:46 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 46C6B70549;
        Wed,  6 May 2020 11:21:45 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 046BLiJL027344;
        Wed, 6 May 2020 07:21:44 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 046BLhim027340;
        Wed, 6 May 2020 07:21:43 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Wed, 6 May 2020 07:21:43 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc:     linux-alpha@vger.kernel.org, Sinan Kaya <okaya@codeaurora.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-serial@vger.kernel.org,
        linux-rtc@vger.kernel.org
Subject: [PATCH 1/2] alpha: add a delay between RTC port write and read
Message-ID: <alpine.LRH.2.02.2005060713390.25338@file01.intranet.prod.int.rdu2.redhat.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The patch 92d7223a74235054f2aa7227d207d9c57f84dca0 ("alpha: io: reorder
barriers to guarantee writeX() and iowriteX() ordering #2") broke boot on
the Alpha Avanti platform.

The patch changes timing between accesses to the ISA bus, in particular,
it reduces the time between "write" access and a subsequent "read" access.

This causes lock-up when accessing the real time clock and serial ports.

This patch fixes the real time clock by adding a small delay between
outb_p and inb_p.

Note that we don't have to add the delay to CMOS_WRITE, because it
consists of two write accesses and they already have mb() between them.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Fixes: 92d7223a7423 ("alpha: io: reorder barriers to guarantee writeX() and iowriteX() ordering #2")
Cc: stable@vger.kernel.org	# v4.17+

---
 arch/alpha/include/asm/mc146818rtc.h |    4 ++++
 1 file changed, 4 insertions(+)

Index: linux-stable/arch/alpha/include/asm/mc146818rtc.h
===================================================================
--- linux-stable.orig/arch/alpha/include/asm/mc146818rtc.h	2020-05-05 20:48:30.000000000 +0200
+++ linux-stable/arch/alpha/include/asm/mc146818rtc.h	2020-05-05 21:05:53.000000000 +0200
@@ -15,9 +15,13 @@
 /*
  * The yet supported machines all access the RTC index register via
  * an ISA port access but the way to access the date register differs ...
+ *
+ * The ISA bus on Alpha Avanti doesn't like back-to-back accesses,
+ * we need to add a small delay.
  */
 #define CMOS_READ(addr) ({ \
 outb_p((addr),RTC_PORT(0)); \
+udelay(2); \
 inb_p(RTC_PORT(1)); \
 })
 #define CMOS_WRITE(val, addr) ({ \

