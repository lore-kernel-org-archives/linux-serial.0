Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833FB4119E5
	for <linux-serial@vger.kernel.org>; Tue, 11 Aug 2026 08:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786435804; cv=none; b=O6qn7rE+5GTDbJ88FWvAqajqei1DIcDwsdQiYnocj79IxNpyPakADgYubtYPcjY9Za/ybK1jh+g5NxZ8RUGDdLxqMgUz2bFurdjy/ud7iZb0s9hEplYpPaHNxRG9fZvi+zVgpd3qU/t9yV+g5MKSBku9aEnjm1nhmoGEUIqCK4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786435804; c=relaxed/simple;
	bh=uy1TWxecPrFpSI3RYQyi9bhEt8VMUIPKm1QoqnK5vac=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=H2o+QDTKLOY0sGtbYpk96eSRYib5FrW8E2G9HtlxbViLPXhSrx9DZASId/L6PRf6mQ1XSFUIJZDPDmXPYzH0kQBFws2vfg4DyqYORAg8tOIwOu3EPNpWV8A2pN/8KwxMVLjDpBIvPuWEcpcb/4I9/rzUTOS0+7pD++fxHxEOFmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ciimN4u3; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ciimN4u3"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4953e04ef16so24611035e9.2
        for <linux-serial@vger.kernel.org>; Tue, 11 Aug 2026 01:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786435801; x=1787040601; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=JfoJLqBVLFMTHWJaL28wXC95kEq7j2/28qxGblxnEic=;
        b=ciimN4u3lvVxFkvq3GYoXZ1D7EyfaoC8ngiR48VXaOtitzkQwny8YfwMsZ1Oh5ixx1
         qPJcApLzt0K5n3YFCBvHW0H4fYd5mp+nKy245yVsIz6wlsJHaariJjXpR+Z/99xzt63w
         NC3+BUSIVYlCYpV5A1PiOuX5yRPQXHkOGgdw4Du7xEfj50e3nSX+W5Rm9H3IHLS0MX8P
         HrHoR4k/GU+GqI2G/rPkEa1EGYf72CPkXRjv8UwaNrF3YlRdC2GeHvWPazI/WQxbPVEW
         kWOwzngFXp9IzYI6b/uIH40nPXfLLKqIbzbyE7i2HbejdlgvfySVsl8nxBlenQJp7yzc
         pdhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786435801; x=1787040601;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=JfoJLqBVLFMTHWJaL28wXC95kEq7j2/28qxGblxnEic=;
        b=Pm2GmEEpBYQRLQJ7UxITlz3pwucCLca6xsWXyvALMecVVCbIgsaaCh9eDoovNwB9bH
         LM6a5Elan59lGEZXNvMzlUQ9KsndYopB26b/MA3w+g/9hfXd9fWiqw7Sk9hKzScoHW59
         2OYhJOg+yvJzLJVMBI4W+bhN9Te8maZKpmh8lTlYspFL8rA5eur0rSwm1bkObHfL7KLT
         377uUW0gQlGCoTnmLG6bWfRMkxe4bBL4D3L7c8ldmu+Rc0ll4zlBnWcJymhqbdc7YP12
         OBnx/9lKRfEUJyioKTD+wVJwsrhql0x+ID1vkgodmnOxBS4HETd71bq+ysr0GvMMW8tS
         qtkg==
X-Forwarded-Encrypted: i=1; AHgh+Rq7peNYP5Woc7EgRb2DMeeWUJOKnvJ4R4NeKWyOi3xJgUqXU22f+yqeE+yPXtZJn2qMmDCDwZD5nhapzZM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZo+b9cjEB2S+B7PW4htltJ0HYMqlvMJOR5hAWVvfLmQim0ibx
	qbHT2dnjKJaWuApwaZAgclWVItRYN3fxrAuHkayNhyT294+kT12rvByb
X-Gm-Gg: AR+sD10ThNPtrVzH8thQCQdKa++NgFuN5fmxKlQQ7MJlxAanKaAFGi90DFgiTtAbeGS
	o47wNfNewInnAi6LV2jGPtVWVqkCaaLSjJVU0GL/XWv/GkF2Q8XdAJXYKi1mEwy3Z9sSKOVjn93
	6mXbkFB5EJcN3hhaosrUUluRcr9gd7uWdnLujjplxFE8XHV/idyAjCaEv5xIBnJ/+PU8Bz8ktc1
	avKkWXdyL4lShNAqBOF1JC5a2DHOGXCAqbUygSyklj9G/E7KZxLwybGkbiWa9Gd4s3q5U62i3BR
	lHVh9y7YVWstjBZZNUquQtoJidHomSazwSzEu9gR5agJ8Mb7FK7E243Y+sJqw1EemPj6KObPfnz
	UQ1hLU3CSeqq1538OpHXrz0WSE3B08SjmKCjdk93M2chtjIDPEMrAK4IVm+2RpzwtQca8TXRWAa
	loNOd9c+MwBzC/L0lcLt0JQ457ebN2zvxZZClnrO6Tbxc5O6gWE3E8EZwoOvQLJtEn5YsnepdIb
	nKtR3o1R8yUNSowGRqcMhAlwn2chofIk6iWPMwKI2JvjFfO
X-Received: by 2002:a05:600c:698e:b0:499:76c5:5855 with SMTP id 5b1f17b1804b1-4997846c127mr27025665e9.16.1786435800471;
        Tue, 11 Aug 2026 01:10:00 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (host-87-20-3-207.retail.telecomitalia.it. [87.20.3.207])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-49977df9489sm45336675e9.1.2026.08.11.01.09.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 01:09:59 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Benjamin Larsson <benjamin.larsson@genexis.eu>,
	Christian Marangi <ansuelsmth@gmail.com>,
	John Ogness <john.ogness@linutronix.de>,
	Manuel Lauss <manuel.lauss@gmail.com>,
	Haowei Zheng <zhenghaowei@loongson.cn>,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Rong Zhang <rongrong@oss.cipunited.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Gerhard Engleder <eg@keba.com>,
	Lubomir Rintel <lkundrak@v3.sk>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH v6 0/3] serial: 8250: Add AN7581 UART support
Date: Tue, 11 Aug 2026 10:09:45 +0200
Message-ID: <20260811080950.664379-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a new version of [1] to support UART driver for
Airoha SoC.

One additional function was needed serial8250_get_baud_rate()
for the driver to work correctly for baud rate calculation.

While at it also try to clarify a long standing issue with
new UART driver when adding new ids for uart_config[].

[1] https://lore.kernel.org/all/20250209210241.2622309-1-benjamin.larsson@genexis.eu/

Changes v6:
- Fix commit description for Documentation
- Add tag to Documentation commit

Changes v5:
- Improve 8250 YAML schema with enum
- Keep alphabetical order for YAML schema

Changes v4:
- Add Review tag
- Add errno and types header
- Drop redundant () from comment
- Use define for get_divisor

Changes v3:
- Address review from ai bot
- Add all missing kernel headers
- Improve divisor calculation
- Fix wrong uart config table
- Simplify divisor table handling

Changes v2:
- Drop intermediate patch
- Use .set_divisor OPs
- Use div_u64 instead of / 40 for 32 bit overflow
- Drop dedicated match table and use compatible for type

Changes compared to [1]:
- Fix all formal error
- Use better compatible names
- Drop unneeded header
- Drop usage of irq (it's filled by the generic function)
- General code cleanup and reorg
- Split to patch and add the UAPI map patch

Benjamin Larsson (1):
  dt-bindings: serial: 8250: Add Airoha compatibles

Christian Marangi (2):
  dt-bindings: serial: 8250: Reorganize compatible to single enum
  serial: 8250: Add Airoha SoC UART and HSUART support

 .../devicetree/bindings/serial/8250.yaml      |  32 +--
 drivers/tty/serial/8250/8250.h                |   6 +
 drivers/tty/serial/8250/8250_airoha.c         | 187 ++++++++++++++++++
 drivers/tty/serial/8250/8250_port.c           |  16 ++
 drivers/tty/serial/8250/Kconfig               |  11 ++
 drivers/tty/serial/8250/Makefile              |   1 +
 6 files changed, 240 insertions(+), 13 deletions(-)
 create mode 100644 drivers/tty/serial/8250/8250_airoha.c

-- 
2.53.0

