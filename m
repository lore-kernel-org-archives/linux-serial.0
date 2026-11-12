Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794497619;
	b=oNlypgZTmet5bfzpxytQBpQcl74tKq+2hu76+CpCUN1v2222KrxiPQ7xjR/2J4iGpHYX
	 JpgWoiFKR1vLZ6WwobQKRd7gradAnSm7TJyg9R9JEWbIoMjLfszQYvRk0TZFxgHmazw2m
	 xwWTVIHO9+1ZsQHh57mSPEwU2qVi/QLSB6slknqp/Vx55RVl3lSI9c5MO07hZpeD4CPjZ
	 +XpTcbuMoTRdtkoZOT/8c0yjuTr3A6z8RJ/BgD7570+M8GpjzCgouo18HwdBHqTVHAhf4
	 JttsWnS1MuQeTsBMeV5Ioi3vDM00tkMQfjREmWHkHM47ELOiUJN2oJ0YRq1kl3p9NmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794497619;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=z3BbB7EvRhTQxsA7XhxXSS2tjjNrAp5pTR6enOtvXX4=;
	b=nP4sJ3Z8k0KVupYtdJwg8MKJEeZ0f6FUhsStCw/COaOipLRAqIUkork+B8V8Hc0eRsxG
	 gCjyKYUyw8kYd1OYkl0fgJjP1KaAmRjkP2/8ia3McBlDWhGc/dTy25JWaQgsoR7hxKvs3
	 jZo8rfU4KwOQdgaQZl9dHX0u2/xGL2wTdWt5mM9G0a5CTC79ozHCmwAPKdT0QBDv26dhP
	 CwRBNRVaxWgZUlhHpqDnGvcKQ3+Xetu5D3hK5ZVm+kbTk4lvqhdUQkWMPKy2z5kLMWsLc
	 o5GDMsHqBwAOXNbjJ8R1dzU4CJhhQ7IW8YhmgEYs9uBwsFh+Hjy9zwuEvMan300mWVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=blkGwaC4;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F76606A336
	for <linux-serial@vger.kernel.org>; Thu, 12 Nov 2026 15:33:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E4F76606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=blkGwaC4
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4b4571ff080so48629295e9.1
        for <linux-serial@vger.kernel.org>; Thu, 12 Nov 2026 07:33:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794497617; x=1795102417; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=z3BbB7EvRhTQxsA7XhxXSS2tjjNrAp5pTR6enOtvXX4=;
        b=blkGwaC45pAUAFc/Wlj1uixQFN4RUlHtDjh9yZVXAuD4P2MKVCs57p1aE+XgBXNRhk
         AfNZDi226a4w/oOXHZa7dPbHDJ6oe61N/VmwylWp2RZkFqr1bOPPztXtS7Hyamburovc
         ViUDrACCcXvOjXXdZoqe0oUjFxYWn6hIKblLYJC4RklKszf5ZlVz+1SBuJ7jo+GiNezP
         Fv6RFXBkBeHqBU7zV7Q2Ov1qwlh3FmKI+Xb/R+puSpVVUOyQcZnytsBZQYoSrnM+zjEx
         rgXSxgNPLuugdYJhPRY3mTS7i/xFC5pLRnKwerU+HnqV2Kc1jBUTSsZsApY6SBp+7Are
         YX5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794497617; x=1795102417;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=z3BbB7EvRhTQxsA7XhxXSS2tjjNrAp5pTR6enOtvXX4=;
        b=wGl52oBbx4ka2ArXlgeTcfKMhWRTjzSbUVzaqyfLkCWJLBPKleSU3fg/Uc6w95tEr5
         pmp0Ax9I+EQk5SS9oOHScfwECR9dB5Xd+qXRm+cwlZnWSyR5eSZP2cMuCfro1J3lAuP4
         H6rCGY8q4wHLqU9Y+Nd9hCQYEII9XTEKQETS3/wAn8IiHDWSK5uAPwSx2zVq0L9EWvZw
         7BPj9tl7EzxCoSgGbRQTqbUERdW/uIcJD1WOHFoQ6NewXY7AnivF656pcOu3/V72oya3
         VHcfoeUBxA5xB17YyEijx5mZZf1F5hz0OflZKb39DqymBrnJnuXN0UGzwbCVKZDufFkH
         2RSw==
X-Forwarded-Encrypted: i=1; AL+hErH6U6iRJF23LDMUAbBFMHga7x7KkVoRRW199wVtLebOlrmE1/vHSGKYtkw0RRRxvYFyr9f8wXZjY+eYvpI=@vger.kernel.org
X-Gm-Message-State: APuU4Z/AoX6aSBUa5Wo97TcOhymIVNmZvofg//1aa/YFecWmx0n/FGBn
	tjGaPEYk+bYCWVJ/rayg26yFduPsZG5eSi8syvVxLMgKsTnCh8H7Uq7s
X-Gm-Gg: AYBFou3ZTrtW39SBHmoAMLj1HRA3od6R4m/DxCEelWcWdtEzqseBROQAS1N3xjgUCPb
	LzJQLAwRF8Wyypa6oqvPQIAhIWgNvmIDgFnFv6SXKmMbbBx5Ar9oCi5Uwr79JWbScnZm4Dt3qyw
	keC9+6pVzSJq58znAJ4m6siUz/+PDlTDEH6Pn2xURByHmhmmpGz5cURkeBfPjlJl++OXj6o2rpb
	XjeI6U6g1aLAjpr0qjRYyKEMTTunG/s41cHxuTd4lVjSM0m0Ybpqj/sPxpmzmimFonLveXVnlvs
	M0UrX+Lzx6cmh0yckTNHsabkNNbjInnoJOjjDFoPVfhlzkq3wcqSCsestuEoXyQgUS1SGTF5SJp
	q854QD4V6y04LVN+cVXjtxjUcJEb252+7rWYchicg0PtL4qsRmn/7uIfeKpx+0mBCUeUXMOj0lz
	BIuDgxNyttFZVfzM13GTnffH3j62WvW9B6UeTsH7wLX2yjnT5hTTUnS0RRWZ8MObWoKqhmcq7LV
	SoJYum7Jff53jgI1PAP4u6WekLp97PY9Beqn69vgZLjf1nd41X+83OksCKWFw/FSY2JdzB8E7je
	jQ2U04ba6Xhof40dBLuoChIxfTDO+XWzcH9BNkWLv3ss5sPeNAnag62QbQUWoCodAbREluIG805
	Z/J3M6A==
X-Received: by 2002:a05:600c:4f4a:b0:4a1:f68a:9736 with SMTP id 5b1f17b1804b1-4ba0939726dmr133509675e9.26.1794497616817;
        Thu, 12 Nov 2026 07:33:36 -0800 (PST)
Received: from alchark-surface.localdomain (bba-86-98-194-229.alshamil.net.ae. [86.98.194.229])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb4e2593e4sm87105855e9.5.2026.11.12.07.33.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 07:33:34 -0800 (PST)
From: Alexey Charkov <alchark@gmail.com>
Subject: [PATCH v2 0/6] serial: vt8500: Clean up the probe using devm and
 new serial core helpers
Date: Thu, 12 Nov 2026 19:33:08 +0400
Message-Id: <20261112-vt8500-serial-cleanup-v2-0-36b258e0c0dd@gmail.com>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WNSw6CMBRFt0I69pm2iHxG7sMwKO0DnuGXFhoNY
 e+2uADv7CT33Lszh5bQsSrZmUVPjuYpgLwkTPdq6hDIBGaSy7sIAb8WGecQNTWAHlBN2wKm1WW
 eCjQm5yy4i8WW3ufus/6x25oX6jWOxUZPbp3t5zz2Ivb+fXgBHJo0zcqbkllb5I9uVDRc9Tyy+
 jiOL5E4i57MAAAA
X-Change-ID: 20261111-vt8500-serial-cleanup-dfc9731edd70
To: Alexey Charkov <alchark@gmail.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Tony Prisk <linux@prisktech.co.nz>, 
 Alan Cox <alan@linux.intel.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>, 
 Wentao Liang <vulab@iscas.ac.cn>, Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1926; i=alchark@gmail.com;
 h=from:subject:message-id; bh=8PpJS3y5hC3pEkcD/IutXHMoQpc5qWIJgmCmvXikxks=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWR9veP5PV5iUoGy76ensRUHhHWvxfbKKS60yGSMN3S0+
 yPpO0WnYyILgxgXg6WYIsvcb0tspxrxzdrl4fEVZg4rE8gQaZEGBiBgYeDLTcwrNdIx0jPVNtQz
 NNIx1jFi4OIUgKkWSWb4K9rzrGPTod57hzf3xLrv1/JYef1olm7KDG2OshviDyY5RzH8My6PCQ3
 fvbBfNFEw8l5M7xaxBJclqx+6nl57QO/apsRwDgA=
X-Developer-Key: i=alchark@gmail.com; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5

The driver has been carrying legacy vestiges in the form of a bitmask and
a local array to track which ports should be numbered which, both of them
not really needed anymore with DT aliases and existing in-core tracking.

Remove them altogether to simplify the driver and get rid of leaks Sashiko
found. While here, also convert the clock handling to use the resource
managed API, and propagate errors from uart_add_one_port().

This hinges upon two new reusable helpers in the serial core which allow
getting the console port for a given line number per driver, and another
one to auto-assign line numbers for which drivers currently keep an
assortment of local accounting boilerplate (some with locking and leaking
issues, such as vt8500 to date).

Signed-off-by: Alexey Charkov <alchark@gmail.com>
---
Changes in v2:
- Added a core helper to get the console port for a given line number per driver
- Added UART_LINE_AUTO support for automatic line number assignment when no OF
  alias is provided
- Link to v1: https://patch.msgid.link/20261111-vt8500-serial-cleanup-v1-0-b33594a25f87@gmail.com

---
Alexey Charkov (6):
      serial: core: Add uart_console_port()
      serial: core: Allocate a free line for UART_LINE_AUTO ports
      serial: vt8500: Look up console ports with uart_console_port()
      serial: vt8500: Drop the port index bitmap
      serial: vt8500: Use devm_clk_get_enabled()
      serial: vt8500: Handle uart_add_one_port() failure

 drivers/tty/serial/serial_core.c   | 89 +++++++++++++++++++++++++++++++++++++-
 drivers/tty/serial/vt8500_serial.c | 89 +++++++++-----------------------------
 include/linux/serial_core.h        |  5 +++
 3 files changed, 112 insertions(+), 71 deletions(-)
---
base-commit: aaa2f954c21b205a0bcd0961e5b2be4e82e58455
change-id: 20261111-vt8500-serial-cleanup-dfc9731edd70

Best regards,
--  
Alexey Charkov <alchark@gmail.com>

