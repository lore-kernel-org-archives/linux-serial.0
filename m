Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3B638399C
	for <linux-serial@vger.kernel.org>; Thu,  3 Sep 2026 04:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788409511; cv=none; b=u+b0xbSKKVjrpiIQ1N3F32Mtkd2f/pZduygzBCVxoJzyfwtqaD/V5hjzRwMcJdUGqJ7TudCCxWT23iS/iUNkHZkQfi/GNERzbaA2jOYUbceuD26mcC+77CMO+L14GdwSSIfk/n/lJZLkulHQPMn4QnMhS9VWCGWbAr7K0sjSBog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788409511; c=relaxed/simple;
	bh=ZFx3Q9CVV7DenPP95PrnXW2mBbZp6+X+qUC2c0AEvuY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WKyt7v2/3G3wTvBrqQrpUifYyiulLTwkVuJznh/eqA7OsXfXozKtleqOuMLBIELCICHNH/N/UForb1isAFc4juvB6xkCchtFrgvNunnLbEpRbyLZO8kXj1dTlA9YJ2OfdaqQyuGnrAM+KyIDfGkmhbbrCEcs8aCe6Gej77a0VXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CGiv2+J2; arc=none smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CGiv2+J2"
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-78a220b5778so594174137.1
        for <linux-serial@vger.kernel.org>; Wed, 02 Sep 2026 21:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788409506; x=1789014306; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IlvKvqaox0NfebLUVzqa94KBTGlj+HyEivmqV8xa538=;
        b=CGiv2+J2ds8eE3Fqt3zG+/vRNNp/a5A9D/qTfBLWBrfHM17TuPmjWp94fombTzNQfY
         rAA+ffSGXB8xCwH6H2zr4qxlfZ8nh894DP5zyc+9wNysuNMC6wuuqp76udu0bUpfd9Wu
         L2Pko2Z1dOqpWgFy3x5Vlmyv4ftibEWMP46jrvZZItwAO7xBkzJ/HKCkiXtTVHoOLmVi
         zMCdqvydUVRD6rjytC0oqaLT0wDJGG8OlH6A2QSiksIjHnOLG4e4s43j1y/b1cPmFb4Y
         TkqxVqS219OMtV7EqLBhS5T7uR1ARojOKzvofNpuPFwSi0BWvy6HUb+ExL1H1HDs4xNH
         22Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788409506; x=1789014306;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IlvKvqaox0NfebLUVzqa94KBTGlj+HyEivmqV8xa538=;
        b=c3rggAF1IFFaHwgMn1s3M45dVgPm2Lh2liVOmp5+MNu+je4Q13z+HykNO2DwlFWqLy
         bzCDiQIETSdj99nMy5tzAHEcvk8cQ61lwfWseQ5oy1BVt3/FV79nNjU1TbY/YuzhWxGK
         Frugg/oA8Yi/GPdGu10rxmpI/FcXhRnTxD6aMkzjt56TxqgMZQk7a8trY2ZkORanhYp5
         xvsfHVG4aZwxPO1qiZ79a/jsvKD9TnU/3fx41pVOOWUYTcTCTIhLqInvEXXqTAJxvuDx
         BXpwINCqwsYb4PJ/VAP3gLWb+OIJ43upsJmgDKpJvUQNcnIhEGGbPSgzv4lDYTXuSIj+
         jrDA==
X-Forwarded-Encrypted: i=1; AKwUvBzgtuhp8vdNnftSCSjmxQm1mhQS2+mPR9emGc8IEkQIL/KKU00A3WSe+wYtRLmMzn3iwmfAs8sMEEOCKVw=@vger.kernel.org
X-Gm-Message-State: AFuF++n75VZoqBQp85YgMBk2i6URMQfnP7AHgbTTOGjPAxLxHTowtrWD
	urVrOgTR4EvSEi8iTpByszTMyan2Mr57EVp7dSWmGPACW+N0Thw9QjvYlDqukU77xhU=
X-Gm-Gg: AYBFou3bDby3TzgHtZsHsObHfT2l6CvtRwHUDfei4yKez3cR53RcZjzd2fys6HAmjtY
	Q8P8mdlqcdlOgu0fX3zPn3DeWVTbpdtk6njGi3uS8rc6lvqckBDGX0kwKdsIlWc/1z0p7saZFi7
	2ZWfmAIxSt0AmYOvj62B+EejWULPA+w3mDSk4FBBRrBU7/H9yBN0nALRIEg3KmEZ+SNXNRE0lr0
	XpCM3Wg3hHoTmjl+hkG0JBc6+s/dkGXBiGib7t14SC0HNL1jWYR2bnTDr+dDnEI+jLc0qbSroj8
	3EJ+BF8rgg/agKGZRNBkk4jwm2vTrR+vwIvtUeNyt2sC4gd1liROEdoHPoIL0dBrQ2ugxs70Jhs
	/3sxjpUN9AKg9DJRC0jgUEp3nOCm0+l+cN54mM3laooKfeSvbDUlAknITA82VRUBNRk2Nc7iiqR
	l1Ji/JqgvUAFFudgB7BSfNznBvIZS93rAPMi+BtDoX9qoA6qgXtwjPSADIBzpnLeQ=
X-Received: by 2002:a05:6102:291f:b0:786:cdba:8f6d with SMTP id ada2fe7eead31-78a2edc5af5mr988472137.1.1788409505843;
        Wed, 02 Sep 2026 21:25:05 -0700 (PDT)
Received: from adriano ([190.215.95.120])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-78a1a4b1143sm3857241137.7.2026.09.02.21.25.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 21:25:05 -0700 (PDT)
From: Adriano Cordova <adrianox@gmail.com>
To: gregkh@linuxfoundation.org
Cc: johan@kernel.org,
	jirislaby@kernel.org,
	linux-usb@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Adriano Cordova <adrianox@gmail.com>,
	syzbot+473d7477c523b41d4046@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: [PATCH v2 1/2] USB: serial: fix break_ctl() NULL-pointer dereference
Date: Thu,  3 Sep 2026 00:24:28 -0400
Message-ID: <20260903042429.130320-2-adrianox@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260903042429.130320-1-adrianox@gmail.com>
References: <20260903042429.130320-1-adrianox@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Don't call into the driver after disconnect, just like serial_write()
already does.

Fixes: 9e98966c7bb9 ("tty: rework break handling")
Reported-by: syzbot+473d7477c523b41d4046@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?extid=473d7477c523b41d4046
Tested-by: syzbot+473d7477c523b41d4046@syzkaller.appspotmail.com
Cc: stable@vger.kernel.org
Signed-off-by: Adriano Cordova <adrianox@gmail.com>
---
 drivers/usb/serial/usb-serial.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/serial/usb-serial.c b/drivers/usb/serial/usb-serial.c
index 17edc057a311..5f42bfe39212 100644
--- a/drivers/usb/serial/usb-serial.c
+++ b/drivers/usb/serial/usb-serial.c
@@ -532,6 +532,9 @@ static int serial_break(struct tty_struct *tty, int break_state)
 {
 	struct usb_serial_port *port = tty->driver_data;
 
+	if (port->serial->dev->state == USB_STATE_NOTATTACHED)
+		return -ENODEV;
+
 	dev_dbg(&port->dev, "%s\n", __func__);
 
 	if (port->serial->type->break_ctl)
-- 
2.51.0

