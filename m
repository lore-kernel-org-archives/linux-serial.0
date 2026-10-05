Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4294D4869
	for <linux-serial@vger.kernel.org>; Mon,  5 Oct 2026 17:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791221161; cv=none; b=JBsofciGnpVeneqwD2nDhIEh7MOoticU5tP61rLnhYBoPWIMflBQtQnC0CqOs95V9H6G+YV2ZMKWOktef73QM7y73urpG55jiQmWjP0Nw3xeiHJv4iflZFl+ZziUVeylkdR86rzOz945N3xZLhx3yvoOmCmoajLX5MsU3bVq/r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791221161; c=relaxed/simple;
	bh=1TovBGqb+S+doAvi0jZy2UcBL66zBbQNb/CjU/As8cs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N5wjc4DrmC5MX2dQNHgpvTFhkgH/OlWnlhCbfpnwaz/IZhbkc8VAL5n8zCsqp8y5RZxkj0nohU/rITU2q51oP8unrdEZSMbtkHhKxeDT4yOJnyygJeBIz80AD1Vcn5CkrJ3rETPjxZH6Yu5wqXiwD19M5JDt+xydwmiVKzqQQ0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZEXnOBIr; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZEXnOBIr"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-6714595153cso83599d50.0
        for <linux-serial@vger.kernel.org>; Mon, 05 Oct 2026 10:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791221157; x=1791825957; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=B2r0pjGElK1T1XiGX8hF3bDF5aD44JQI3Axp9h+wJZA=;
        b=ZEXnOBIrX+z2zkjroVD18Leemtz2cHybKvxWxyASXz9ZCU7Wsb+piwNNY8sQFipH+F
         Fi9x5Qx6/Dd+EcqBUZbQWG/xqH31DmYwwAfP7zzXHbIthCGhonzP0Au9RcMkWzCbbmQ+
         +PwZHZjBC//3UkOPRHoym2U2QRM7IMNvsI733bUwqqrFCDIqFKELVKvR/c3RF5kYeJ/7
         ED81X9IP0UKq2MTTOe5GeGpdOv7nffGGUTbE+kqs4YdaDh278MaGU/Y5BBPswLgbKuzw
         6ct+qFn4qcPhniQ0UbNzYkWkj1c8A5UCTdzDzsezUYAPe9AJFwjGO6xYh/+I/r7Zo52T
         cVUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791221157; x=1791825957;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=B2r0pjGElK1T1XiGX8hF3bDF5aD44JQI3Axp9h+wJZA=;
        b=ZJEHH2lq3s+bWRGJ5PMW4GHpJVloBLx0E2MrR1NZno8h2Jf3mkN/eziW7dd3hJu74u
         keUeDWrzW0trkSQMJ6WH1sjY1sUdGciK/y3x1oa2VGWYBi0PjUQQ7f0w6P/Ww5HPtd6E
         KsSdnhE81UNPJNXR9CXQ14E6cqpy1AbDxpOIqounce1tFTPH64/QaeE0ndWec92xOv6m
         rrf+JpJQUiQXD98m70jECkFc5w/8GqM5/Gt0Lk3WRz++1IBGS0+X2r+do0ijVjy7+FXD
         gu1I4ELvsCIpjQho6vHzLqr6mNCVCXpT5YMpwY6/ZvU8zYgEt3koRehC+/8BT0EfKm7H
         aBnA==
X-Gm-Message-State: AFuF++mjQU6DYjSs7olii31DPLmNoCHaqhbs0YyGWdV+MIPJj2S1vdmn
	8djad/AtQT9QBljd/20uKdIDL1OveTSVMai8p7s9C750X0NYEFNY2kjmtsCIY+9B4/4=
X-Gm-Gg: AYBFou01ZXL3nvUHQkugO7F9PC5/ieUMuwc2h3/2WDgHjV/zkIo1i2Bdj5HhqWnGOrJ
	J5cdJYNU0wMsBceQV323TH1v07OFNSytIED8H5BjyYta76BdMctS26mQwsin0fdAoYOrkeKv4Il
	Dn/nNwC4AvYlDk2zM6ge3TF6X0rxjBLzMxUl5kuY9imczapFQqxcq4RE3iwTZ+BXeCOaqxAB/yB
	qNbIIh7MmGA1l2anAa1Gi1NAq+kiRBNxVhVwLgQCDqBxKQu7EOuqlGRdL0zsEmooKSqP+uoBEbS
	TiZ5SDgZgwwEi94qKo30kwHRjJE4OLJcEz/yxTl/8rlU++4R+Lo0xakw+PQf6wHBE0Rkqi9NnHx
	TAPIzWBdJC70HOTG6MwE8AJc7axAwjQfIK9AgMuaMb0AbNmNNZz7lVAPDZWB8de7M+ljoMU7gbr
	DkSDmgHYeUo+HpumUbbzdOrPBQYHiWrd5UqWYZ3CKljVZT1rXwxcr1S5W+NHrXK61Gofb7pJmXs
	kpHrOfaC7/eiUN6C0PUfT2L7RnE4u4RcBi4Wala+doP6R+jmnLwiK+J/0NxeywHCnh6pzv+BK69
	A42Oyw==
X-Received: by 2002:a05:690e:4142:b0:677:d05a:4800 with SMTP id 956f58d0204a3-677f386139fmr150914d50.25.1791221157435;
        Mon, 05 Oct 2026 10:25:57 -0700 (PDT)
Received: from MaquinaLab.. ([179.179.237.181])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-677c1b1b585sm3449969d50.5.2026.10.05.10.25.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 10:25:57 -0700 (PDT)
From: Vinicius Pedrosa <vinicius.eduardo.pedrosa@gmail.com>
To: linux-serial@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andriy.shevchenko@linux.intel.com,
	ilpo.jarvinen@linux.intel.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-sunxi@lists.linux.dev,
	Enzo Adriano <enzo.adriano.code@gmail.com>
Subject: [PATCH 0/3] serial: 8250_dw: Allwinner A733 UART support
Date: Mon,  5 Oct 2026 14:25:35 -0300
Message-ID: <20261005172538.398522-1-vinicius.eduardo.pedrosa@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'm bringing up mainline on the Radxa Cubie A7Z (Allwinner A733). The
console worked until the first termios change from userspace, then
stopped taking interrupts.

Patch 1 fixes that in the generic driver: with a DLF register present,
dw8250_setup_port() replaces the BUSY-safe divisor hook, and the LCR
retry path then restores IER into DLH. It's tagged for stable.

Patches 2-3 add an A733 compatible with two quirks: no clk_set_rate()
around termios (the baud clock is a fixed bus gate), and no DLF probe
(offset 0xc0 is an RS485 control register).

Tested on a Cubie A7Z, with local DT and clock changes that aren't part
of this series. The console worked in both directions and a termios
stress loop ran without stalls or corrupted bytes. The no-DLF check in
patch 3 was reworked after that run (an if block in place of a goto),
and this exact revision hasn't been booted yet.

The A733 DTSI isn't in linux-next yet. Enzo Adriano's posted version
uses plain "snps,dw-apb-uart" for uart0, so it would need the new
compatible once this lands.

Based on tty-next.

Vinicius Pedrosa (3):
  serial: 8250_dw: Keep the BUSY-safe divisor hook when DLF is present
  dt-bindings: serial: snps-dw-apb-uart: Add Allwinner A733
  serial: 8250_dw: Add Allwinner A733 UART

 .../bindings/serial/snps-dw-apb-uart.yaml     |  1 +
 drivers/tty/serial/8250/8250_dw.c             | 25 ++++++++++++++++++-
 drivers/tty/serial/8250/8250_dwlib.c          | 22 ++++++++--------
 drivers/tty/serial/8250/8250_dwlib.h          |  1 +
 4 files changed, 38 insertions(+), 11 deletions(-)


base-commit: 36844ea19656fb41278799ef3d5cd52120d89149
-- 
2.43.0
