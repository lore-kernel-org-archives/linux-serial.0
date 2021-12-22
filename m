Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB271C433EF
	for <linux-serial@archiver.kernel.org>; Wed, 22 Dec 2021 11:29:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbhLVL3N (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 22 Dec 2021 06:29:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:21606 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244667AbhLVL3M (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 22 Dec 2021 06:29:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640172552;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=eDLeUiZSABtTmlXy3YKAfBDOP4a6oovLCCYMT/MLLEA=;
        b=IlphFf9e/KXmMqG8zwc5zPvhNzk2l97r5qMGPss3v5w9IL+zpncvU6cwI0fEebFyd+Dz9O
        RVd4tB5bVh39mDOhNcRYGxKsitCr033s6+kxC1FPGxE/U3XNmBQ9trHfVcvTYG5W896iT8
        sk9tz9lgTQwiJWKk8s8yfLqilq9vpH4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-196-R3J2MwKJP_ynC8JQkhRXKw-1; Wed, 22 Dec 2021 06:29:08 -0500
X-MC-Unique: R3J2MwKJP_ynC8JQkhRXKw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0007F801AAB;
        Wed, 22 Dec 2021 11:29:06 +0000 (UTC)
Received: from wcosta.com (ovpn-116-93.gru2.redhat.com [10.97.116.93])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BCD145E4AF;
        Wed, 22 Dec 2021 11:28:57 +0000 (UTC)
From:   Wander Lairson Costa <wander@redhat.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Johan Hovold <johan@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Wander Lairson Costa <wander@redhat.com>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Lukas Wunner <lukas@wunner.de>,
        linux-serial@vger.kernel.org (open list:SERIAL DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 0/1] tty: serial: Use fifo in 8250 console driver
Date:   Wed, 22 Dec 2021 08:28:29 -0300
Message-Id: <20211222112831.1968392-1-wander@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This version restores the v1 version of the patch (without the UART_CAP_CWFIFO flag),
but fixes the "checkpatch -strict" warnings caught in review.

Wander Lairson Costa (1):
  tty: serial: Use fifo in 8250 console driver

 drivers/tty/serial/8250/8250_port.c | 61 ++++++++++++++++++++++++++---
 1 file changed, 55 insertions(+), 6 deletions(-)

-- 
2.27.0

