Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537E8438FF4
	for <linux-serial@vger.kernel.org>; Tue, 22 Sep 2026 08:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790065919; cv=none; b=ufsKO6W4o968G7rWMcxME9vHtwEVQC3moJt+GIP1fBGRQzWmH/b2t1micmefGtsW72kSzs8+zzFqk9UzdqlZIejjeuaRQEcSSBzZ5RPf2+NRMHw814nMOHRL5L7/m6CycaaFd9uHHH58KnFQH/kr/2B5uzEuft8WuJAMwseFcoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790065919; c=relaxed/simple;
	bh=A7hEuCLZWRdGFblp///+ebIF29mgq6p9oSmiBLCXlLU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Hw0VMUYjFelsYDSQ+6Y5EMFxDzWOKY8tBlrG+WtA1+W4EoojkkVMM/a80ySpJV/FStZ9KmJBK+L+Wzrd+nHXThQGWUk/2qnnJQ3bUkTUEuchwsGdatMhk6Z/pOV7yjP84NUHwjOzTHolbuuDwkqf7e/vZidARC1hO0J0/c+LxmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LEKGXJEI; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LEKGXJEI"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d747eb79f6so25323715ad.0
        for <linux-serial@vger.kernel.org>; Tue, 22 Sep 2026 01:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790065915; x=1790670715; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fdu061GCn59M+R7cqh6VYjsrqQSSKRxNFPR4yXO2TzY=;
        b=LEKGXJEIzHeof7MqC3BR8w23MyReLogdSnB/KofytWBFWR0k9lXOtsI6gxFVo4vUkr
         J+gFmE1CDJtXiWx4qdL+N6dhRlZJKkpyxKz9VhCAH4MMZeKMBp28LiOTiA2b4kDcT1oT
         uRKVR/hiClQrtw6Yo7erb68yJtP8KkalSy8wdoA/WowCLbz0QFzouWa3YSGMRrFn9FJg
         U2khp9aL8NrEnDZK3oQZzN19XcuAGFBLdMQ8GSS8ketmgIiINoCL9mCcws08mkPLiiia
         k4TGcD4O19KZMH+9z/TjhHFC61Rr4IfN7EUIQOfH94DkZknww8wcb/l08BpcBcMORBs/
         Iw9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790065915; x=1790670715;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fdu061GCn59M+R7cqh6VYjsrqQSSKRxNFPR4yXO2TzY=;
        b=m0voHdbLWueVdu2IMN8PAazVRR4UINKVOqz8hszPIQYZ4cr77+h/roTN8ipCZORYdN
         Qq8A0nKamcpPUBLrTGhxs0rZEGCgdXGuZX0wr1fwu99aeNdmWvAN3LWl5+XLaj/whe9v
         Q/v794PE1Aut8v9gSwfKUmlZmOejeeUREKnN914wzhPWp6ogG62giZDTPrnySh4yQ5o0
         J2TSUip9lkudwTZabcAcYJGgSpHEVbNV7vTPC64OKRrVZ5y1DP8TTVPw994ipXuOUrOr
         vEmFbcnSw89clsFWJgX6nVxxTE8+CfqrCa5UTDVn6zWNQahtLIv9YqDT+4XeS1T+Lu/p
         7TgQ==
X-Forwarded-Encrypted: i=1; AKwUvBzdr+1ImOcxQhpMzyxYz+Rs08xzwZnPeTAFGVZ2TbGMOrKCHeQGKUOKIuJaNYFBw1+M2PZwrvYsRADoNkM=@vger.kernel.org
X-Gm-Message-State: AFuF++kG4Ypiwpg0B77d77rP651IS+e/YC5RIal9E0sBU0EsvvsnK1/z
	C3jEU+T/OU1T6SN9HHA50GKWCgFz0pGbJCBGLmfeMen8lJtUUu4uWeXy
X-Gm-Gg: AYBFou2EM2hTVJoBbo5RHHHxQOMupDhisTnukyvP8O1B2HAHRPi/rcetNhZsEs9MbV0
	U3W3p4gJ87HnDchpQfjuAE/NsNEDpyTfHNT/5CiM/UjmciH45j5KFL/jf1/Ilamk9fXWcXMay2H
	YWVqTO2uXtenX9LxlSTVHekIZEaJ6uQH2YA5vwvIWZgZ9CGn0pgq+D7Z36s1mqU7ERA8D2DKjB6
	K72TqD7+jrJGRtQxoA8EJdtFr/qwtw93/X4lsR6QOWXuUufnl+OlO8Sms4deCRSTpsvOfDA9sR2
	Yi7E/9mqxG8g6c/ZwrCDvKSxSFw28avJDfLGGtD8hsVHgS3XmTOi7K5KUj5Sd8YlLFsVhQ8kFzN
	AlHaQSTWJ6Xe7bXoaG9iKUwUwLcleoUCFH4f6FYsaKY1vsVkQBu5n7gWm0vzIz/cnX0qHwBB8Xg
	ee6/9wud4MyGFheCrjccetmEe4jQXDtVaFdKR5dCn6MOPScsrEPom6Qreh4z7/s5EeHeUqBFbkQ
	FwwzahNFhOtyq/mfht9sDmoVrN5gdwSfEh3zC7mwiS0SaBnbAyqmRorqIQ3cu5udcfGdJuLrDd+
	MaHxii45eQ==
X-Received: by 2002:a17:902:cccd:b0:2dd:c0ff:e724 with SMTP id d9443c01a7336-2df60b674b8mr5358005ad.54.1790065914611;
        Tue, 22 Sep 2026 01:31:54 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (78.123.83.34.bc.googleusercontent.com. [34.83.123.78])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df5d0197d3sm5848175ad.13.2026.09.22.01.31.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 01:31:54 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	John Ogness <john.ogness@linutronix.de>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Hui Peng <benquike@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/3] serial: fix IRQ chain race, baud fallback, and uartclk overflow
Date: Tue, 22 Sep 2026 08:30:48 +0000
Message-ID: <20260922083152.4055969-1-benquike@gmail.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series fixes three bugs in the 8250 and serial core drivers:

1. Hold hash_mutex across IRQ chain lookup, linking, and error-path
   unlinking in serial_link_irq_chain() to prevent a use-after-free race
   with concurrent serial_unlink_irq_chain().
2. Allow a third loop iteration (try < 3) in uart_get_baud_rate() so that
   when both the requested and old baud rates are out of range and try == 1
   clips the rate into termios, the clipped baud rate is evaluated and
   returned on try == 2 instead of returning 0 and causing a divide-by-zero
   in uart_get_divisor().
3. Reject baud_base > UINT_MAX / 16 in uart_set_info() alongside the
   uartclk == 0 check so that multiplying baud_base by 16 cannot wrap
   around in 32-bit unsigned arithmetic to a small non-zero uartclk.

Changes in v3:
- Patch 2/3: Collect Reviewed-by from Ilpo Järvinen.
- Patch 3/3: Add missing #include <linux/limits.h> for UINT_MAX and move
  the new_info->baud_base > UINT_MAX / 16 check to the uartclk == 0 check,
  as suggested by Ilpo Järvinen.

Changes in v2:
- Split the 8250_core.c and serial_core.c fixes into a 3-patch series,
  add Cc: stable@vger.kernel.org, and document how each patch was tested in
  QEMU, as requested by Greg Kroah-Hartman and John Ogness.

Hui Peng (3):
  serial: 8250: hold hash_mutex across IRQ chain linking in
    serial_link_irq_chain()
  serial: core: allow third iteration in uart_get_baud_rate() fallback
  serial: core: reject baud_base values that overflow port->uartclk in
    uart_set_info()

 drivers/tty/serial/8250/8250_core.c | 4 ++--
 drivers/tty/serial/serial_core.c    | 5 +++--
 2 files changed, 5 insertions(+), 4 deletions(-)

-- 
2.49.0
