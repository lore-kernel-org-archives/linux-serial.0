Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8F544361
	for <linux-serial@vger.kernel.org>; Thu,  6 Jun 2024 19:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717703899; cv=none; b=CahgOLrS2+8mzyTDSFev7UE+GOkWd2wFJxh/IP1KnZCNGoi8NEcYPTLlV5Xs4iSjnmx/VuqW/qt5Q8XAqctHz0s+bI+xJ4OIYCa5EJZNZczzfSPyB89/tZq5Zh3mE7CbieOvOhBaplbU7DFrIGG5eMn6Gvs/wfuAk/u5cfx/CVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717703899; c=relaxed/simple;
	bh=XlerXq91GdgAsRzJWZ9lOnfrmJtdEDDhSrBbmzEhJu8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=A69N7X3QDrvhgc5GDE7n25oE0+D6uARnb9wh+0F3TTY3oqNtcGfuvdbeOFNp+EyFJdj2c4fYml+2H1wUdsJuGGMjh+Ks/xX7+goumzTAma/rdEUCNhxeeyQzxti8wC6NMEm4J/RZ53NjaMzyqrhMkLjmCQ66wNRy1MQmahNgPtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=schmorgal.com; spf=pass smtp.mailfrom=schmorgal.com; dkim=pass (1024-bit key) header.d=schmorgal.com header.i=@schmorgal.com header.b=ZQ7Sku5/; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=schmorgal.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=schmorgal.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=schmorgal.com header.i=@schmorgal.com header.b="ZQ7Sku5/"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-6c87835b8c5so170700a12.1
        for <linux-serial@vger.kernel.org>; Thu, 06 Jun 2024 12:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=schmorgal.com; s=google; t=1717703897; x=1718308697; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3o/J0UJ9ACwmzWlKh3CN5VJQYcVvkxTrq2dn4n2oDpA=;
        b=ZQ7Sku5/lY+VEbi7K+J5j8m4GU4NjHaspOkJlfWLkiNHyDW7e2Iu7tuapbutaAe9O1
         gJBsH+dfihRImeifdmhTPSzeW1dE57b4ZJHUYXsmAyGLZitQTvHrsU/dU93jD4hP6ur1
         JqrMPP6wKHJ6uEiiDNdlS7H1NKoaWcBu26SyE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717703897; x=1718308697;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3o/J0UJ9ACwmzWlKh3CN5VJQYcVvkxTrq2dn4n2oDpA=;
        b=jCdxEZTrLr+Gw4Ugplk37jjBPpUTU/7fIKR0hH+GID6SC45ZaJudVbxVmulOJA2LQK
         rTgPa8FgAHtcM6FnIZg5QgDLTacYYT1YHvTXTMekcOIjkweAO3SzNy/NpvxI0zqkSdvN
         P16p2ibk25YtJEVxmqGtA+jBZotASd1R0LV92eAk5uRGF/2+50dosKc+MFPBF0/5qZJ3
         KY0wxGkoONXaBrdrsuZSm3vjBLoSBVo9W5hjbjOKEWdS0AjbHlPKnYnulRYx6ypAuriz
         rQAFrlm3ogmHuwFeu6bWTpQUPH4cMArkaHfgQQV1iugxMVP57Byj9A9g7rDUU0Kr6qFF
         6+dQ==
X-Forwarded-Encrypted: i=1; AJvYcCWLbzgBQmmInJ6t8vZ3k4C71WI5mI8Jl7rW/Y2o/PhBGzzk+DJbKNmjBhx5Hs1wEfxrbloHdJR+p/2jMl9LMYqED/l0cD+DUHaLIdrB
X-Gm-Message-State: AOJu0YwbzWDS9xMiZGTjOCgdKMxC2JiulVc4YxytSCwDSCUH+itkN3JZ
	V9b0f+cFb9Kr7+SnCf/+8vx2bnBzW9SNWiLsNbyHzDF2pdoJhbfSKpmhAw7Fe7Q=
X-Google-Smtp-Source: AGHT+IHP3oJ5uiT5goiX/QRvbrVniUhcGYG1Aq8eRRpKWSxQWiEE3NOsD2jZep22X3z+xLy++gkDIA==
X-Received: by 2002:a05:6a20:9696:b0:1af:ce9c:6421 with SMTP id adf61e73a8af0-1b2f151f836mr598858637.0.1717703896970;
        Thu, 06 Jun 2024 12:58:16 -0700 (PDT)
Received: from doug-ryzen-5700G.. ([50.37.206.39])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-703fd394f20sm1446787b3a.55.2024.06.06.12.58.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 12:58:16 -0700 (PDT)
From: Doug Brown <doug@schmorgal.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Jonas Gorski <jonas.gorski@gmail.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-serial@vger.kernel.org,
	Doug Brown <doug@schmorgal.com>
Subject: [PATCH v2 0/3] serial: Fix regression in omap-serial and pxa
Date: Thu,  6 Jun 2024 12:56:30 -0700
Message-Id: <20240606195632.173255-1-doug@schmorgal.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes a problem observed starting with v6.9 on the PXA168
Chumby 8 and the OMAP3530 BeagleBoard. The UART would hang and stop
transmitting further data.

The root cause ended up being the change in commit 7bfb915a597a
("serial: core: only stop transmit when HW fifo is empty") that
restricted when tx_stop() could be called. It broke omap-serial and pxa.

The change was intended to fix an issue with bcm63xx-uart after commit
d11cc8c3c4b6 ("tty: serial: use uart_port_tx_limited()"). Instead, go
back to Jonas' original patch series that fixes the issue directly in
the bcm63xx-uart driver [1].

Changes since V1 [2]:

- Revert the broken commit and apply Jonas' patches for bcm63xx-uart
  instead of directly fixing the issue in the pxa driver (at the time, I
  didn't realize omap-serial was also affected).

[1] https://lore.kernel.org/lkml/20240225151426.1342285-1-jonas.gorski@gmail.com/
[2] https://lore.kernel.org/linux-serial/20240519193109.122466-1-doug@schmorgal.com/

Doug Brown (1):
  Revert "serial: core: only stop transmit when HW fifo is empty"

Jonas Gorski (2):
  serial: core: introduce uart_port_tx_limited_flags()
  serial: bcm63xx-uart: fix tx after conversion to
    uart_port_tx_limited()

 drivers/tty/serial/bcm63xx_uart.c |  7 +++++--
 include/linux/serial_core.h       | 21 +++++++++++++++++++--
 2 files changed, 24 insertions(+), 4 deletions(-)

-- 
2.34.1

