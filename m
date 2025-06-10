Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED62280A5A
	for <linux-serial@vger.kernel.org>; Tue, 10 Jun 2025 09:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749547343; cv=none; b=LQ3Hm6WLM0+1PgxDCiT2WT1ZPelFvngReXJYaV3euNXkR7Klj39+5iuZ+Ox75M+84kUjcmyPmqSb2aVBR9OM0Q63MBx8CHZNCS7fANDtRJvA3bdm0dIfG1wHiCrsNYedczN2M0NUKpLjkfEYMIYblEgg+2yO7lC65p4dIwFFLwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749547343; c=relaxed/simple;
	bh=cATACb8sN8cNcczyAIiEaT1QEMtdiASGjKJQEhCOIrw=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=dFaWpG3tEZ33sUryo9gzixC8S02pj/kzA1cYgTnhMDRaNLWM0x1Cpg3pGyfnuZltVSklctSDNSKZIE/qhZS9icuuhKkhh4VFwPiQFzyPQUl8yU9YqF9YUqd0WGC/3YrCKFJbJVJO+XjGrsVWyVGEou1932p4/OISleGOOQOLflw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=bRZYLdWI; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="bRZYLdWI"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-235f9e87f78so47387645ad.2
        for <linux-serial@vger.kernel.org>; Tue, 10 Jun 2025 02:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1749547341; x=1750152141; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Pb6EngWFKRCsJhFoXh+Ur7EFw4RWtzKIhB5znZycEX4=;
        b=bRZYLdWI9/M9UF181eTtfnL/Z8z8WTAjv5QYVMtU8lcKv9H1wkLnZP8sntT1f/seS+
         lqNtdkDZPrstPDTLNNUVlhnvX7cWrqIEMNhYfw4T8ZWA4rzYCVl0TuWGS+aOYtZEsb26
         Cs9jvUTHi3mht793IN22iE0MTB4Fgj4KMhpAjA5vVJHNkuaup7Bu/fFXgQpPYIj+NxSJ
         40P6PGoZXRjVs/lsMLPVb3gOsloZXTJxxAiqemb1mUxRg7pB5qsWUP/F+NolXH16OcU7
         on1N4u4vty1HJNTc2a4Zc8tB1gJvX/FZqFarhe+EKAAdqK/bLz+IORFX+WONmq+Ggx7X
         vDzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749547341; x=1750152141;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pb6EngWFKRCsJhFoXh+Ur7EFw4RWtzKIhB5znZycEX4=;
        b=qjb1+xVYxlZfxtviAtKXAgk8pjSwp+udzHnUvEZVzQklNPAkxd8C76xClfceuq+W9t
         w5y6RDoJo84maisAHG9XOVTXAcfvdN2nUSV/NomEvkwYdTTpvGNe/Pkq8gGaQUUvqhTV
         BC5NVW5EZe8SOfRMhH29z5F3y80DmfM7ulgmmNwlMMhURT5kv2kPAEQLA5kJZmF731Ew
         vunZFMAGPkSkuGwNpNYxwGsXMdjNWXODvVd5dhsjMWw+kwXFdWNx3/cYZn0qZi4tJp0x
         BNlnDNVh/xKfdbOnylvlktK8MLagU+46mSyWIH/1CsnR4vdOwi8WBxMioW5XJkh9iprv
         pREA==
X-Forwarded-Encrypted: i=1; AJvYcCV9uWsoUoG5WZA9XPD+lfMuHCNRdvfDVCtM45fhd87c+Bz1zJOrAWG76wLGrxtFjDmpwQjRIqM9j1JAQRw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0ekNHJdX0vI09DbTxcmabtMNNEsLoYKXMWClL6dqr4AftbhHB
	SvIDf724UOfo2PLZuuxFHGhBlTTo4fB/PNjV1ZAUl/kfYiz298MiF00RCCV88u776Ow=
X-Gm-Gg: ASbGncvnvX/0FCA3bmELrcZASLlzHb6ssTWgmM1m3FwNt628BTgQSxqBSsEhF861LeO
	L94fnQRGQqSbOJNCLhXDzMI99vh5WnLiSSGlzkqPTQVWGaG+Cr9ZYPdzN9VsOnC4lSY1d441V4j
	6c0lpqWCrcLNX63b4ncw/BOh//i2SkX5NrujjlxQOpqA2TrfFlFb38u2e0IioOlwU1E+TVbSk/z
	dn5TRUfxZ1UvAba6viAh2y5HeGTE08lJevkKwHe/blcvqmFUTU2mhpTZC3Y57sw4qRagzCltPPG
	IKX8tyj89KsKsCKif6gLbA/kYjP6YhfZFHK4/JIUMm+lXBDFtQ2zmiPG4wMw+0mXHJWR1ZF4I4U
	yyJaAqH/r15AutMwyHLkVk7YkxKlXO4GLe2EAauxl4AS8pLg9shxO
X-Google-Smtp-Source: AGHT+IE+9a4WnFHCBab8LsHsj8nbPcCH0VfJEDuthQy/iEC931PqiVC1U8rW1rxKbtCGqBEgxxdnmA==
X-Received: by 2002:a17:902:db03:b0:235:f18f:2911 with SMTP id d9443c01a7336-23601ced3f9mr234532115ad.2.1749547341420;
        Tue, 10 Jun 2025 02:22:21 -0700 (PDT)
Received: from L6YN4KR4K9.bytedance.net ([61.213.176.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-236032fc9ebsm66968605ad.106.2025.06.10.02.22.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 10 Jun 2025 02:22:20 -0700 (PDT)
From: Yunhui Cui <cuiyunhui@bytedance.com>
To: arnd@arndb.de,
	andriy.shevchenko@linux.intel.com,
	benjamin.larsson@genexis.eu,
	cuiyunhui@bytedance.com,
	gregkh@linuxfoundation.org,
	heikki.krogerus@linux.intel.com,
	ilpo.jarvinen@linux.intel.com,
	jirislaby@kernel.org,
	jkeeping@inmusicbrands.com,
	john.ogness@linutronix.de,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	markus.mayer@linaro.org,
	matt.porter@linaro.org,
	namcao@linutronix.de,
	paulmck@kernel.org,
	pmladek@suse.com,
	schnelle@linux.ibm.com,
	sunilvl@ventanamicro.com,
	tim.kryger@linaro.org
Subject: [PATCH v9 0/4] Serial: 8250: Fix PSLVERR related issues
Date: Tue, 10 Jun 2025 17:21:31 +0800
Message-Id: <20250610092135.28738-1-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Cause of PSLVERR:
When the PSLVERR_RESP_EN parameter is set to 1, the device generates
an error response if an attempt is made to read an empty RBR
(Receive Buffer Register) while the FIFO is enabled.

Patch[1]: Fixes a panic caused by PSLVERR due to concurrent UART access.
Patch[2]: Fixes a panic caused by PSLVERR during RX_TIMEOUT conditions.
Patch[3] & Patch[4]: Improvements to minimize the occurrence of PSLVERR.

v1 -> v2:
Added UART_LSR_DR check in shutdown() to avoid PSLVERR issues.
Added Fixes: tag to reference upstream issues.
v2 -> v3:
Added lock protection in more functions (e.g., autoconfig_irq()) to
ensure atomicity.
Used lockdep_assert_held_once to detect potential deadlock risks early.
v3 -> v4:
Introduced serial8250_discard_data() to unify data read logic and avoid
code duplication.
Addressed PSLVERR caused by RX_TIMEOUT.
Split complex fixes into multiple patches (1/4 to 4/4).
v4 -> v5:
Removed reads from UART_FCR, using up->fcr to determine FIFO enable status.
Removed return value from serial8250_discard_data().
v5 -> v6:
Based on latest linux-next code: Resolved redundant dont_test_tx_en code.
Updated comments and git commit descriptions.
v6 -> v7:
Reverted PSLVERR-related changes in serial8250_get_poll_char().
v7 -> v8:
Added Cc: stable@vger.kernel.org to patch[1] and patch[4].
v8 -> v9:
Reordered the patches: bugfixes as 1-2, improvements as 3-4.

Yunhui Cui (4):
  serial: 8250: fix panic due to PSLVERR
  serial: 8250_dw: fix PSLVERR on RX_TIMEOUT
  serial: 8250: avoid potential PSLVERR issue
  serial: 8250_dw: assert port->lock is held in dw8250_force_idle()

 drivers/tty/serial/8250/8250.h      | 13 +++++++++++++
 drivers/tty/serial/8250/8250_dw.c   | 14 +++++++++++++-
 drivers/tty/serial/8250/8250_port.c | 29 +++++++++++++++++------------
 3 files changed, 43 insertions(+), 13 deletions(-)

-- 
2.39.5

