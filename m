Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E66B3271EB
	for <linux-serial@vger.kernel.org>; Thu, 24 Sep 2026 06:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790229915; cv=none; b=hY82b6pBwWHDYktrMUcoG3Z7oje3Bgnmqqw3KsBrLLSWSFu5wILwGn4C66goIEzvFeFcIGdTKwDRnhXr32Wx6Eu46a/a+Pr4WvNuqfVjyw7oMVnihWHzEEftkS9UXNJQR8qPKu5oHjtR8eGvNyx4sxIeMdYgEEAs1OFKz96ccsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790229915; c=relaxed/simple;
	bh=A7hEuCLZWRdGFblp///+ebIF29mgq6p9oSmiBLCXlLU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=euve+/99+1hqiKCnX69sLIHtIcKHIKpdCbEyip6vtK9KfTre/GvmN4a1QjxAr8dVqYJMcflzYJrRF2GgkD1KKDYYpjSzJTkm01CBE3aPmV9IbNWWHR70h/oCntW/QVnnYa2yHE9UZf+Exb5M6Caj+g90puiR0D9JLUCJcOoz3AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iNVaI0c1; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iNVaI0c1"
Received: by mail-pz2-f12.google.com with SMTP id d2e1a72fcca58-85469d20963so889769b3a.1
        for <linux-serial@vger.kernel.org>; Wed, 23 Sep 2026 23:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790229914; x=1790834714; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fdu061GCn59M+R7cqh6VYjsrqQSSKRxNFPR4yXO2TzY=;
        b=iNVaI0c1wZvy54ZslA0TjSDz9/QCiCUi14vYktLovQy2XOMJZ7HahsdBwO90aRDyJH
         BXYYhHOye8Lkgve4HRgRCLnF3AL4O7YJZj2EEHAYcSXmeWzmdL8VvRHi5gR+hEgxzdWb
         XE4+lwbT4fmEY0SzkOp/fmtSxDGq5lYwrLmarz7PBEfGdSRhnH6dwztOw8wt2lm3Qbfr
         bGXiKECid38f99sFJ+Iw3bg2koYe11w9WSZ8V5dZqs4bvLEAuj4d2RVWR6CftHgTKpSL
         5IONVlAsAS9TnTivphbpBR9/SWnvv0BPWHxwQkMKBVTUzX/IpGqyg+HmCcZUvfOJb4qI
         VKXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790229914; x=1790834714;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fdu061GCn59M+R7cqh6VYjsrqQSSKRxNFPR4yXO2TzY=;
        b=oy4HbMOKhnM37MQoevRVlmObBhLYxf8uUJ40wPjkVEhFELPriBF9DAHIGIfHuyIqQU
         CtfPZn3MWjgBxUzbYNIKY5BaCQHjFV9YtHUjnmMZxKccNsA9AOXZwThiuvzDUXQ3UEjm
         Su3cOyP4MwXQZoO8vwRdl1qWWr5jZUuj0dr5nDgcjCP9LzVREBkQax5uIsZ0yl2C6ive
         U9EjYVa2hEt7f4BU1Wj2ElWCDImZ0/GDskn571/5GW8GWiUWKNf0ZEgzvxS9+I2uO43n
         xPho8ebsjf13uoB3Pq+v3BZyVfn0VSvMT69leg4q5rZfdDtZkUJKYTU0AFF/twxqgDjt
         FRcg==
X-Forwarded-Encrypted: i=1; AKwUvByh3PZTkXsKl12DtE6ClaIRDX1x/bVSx+qHpbBu5qiXteFllD2b+WX+wRtbaXo3ik5LLY00Gmvgd305JZM=@vger.kernel.org
X-Gm-Message-State: AFuF++n4lw2FhckmZ1zZ0JWMrlYqLEOUz6xPcZBCopxZEju4ipdYyEuV
	4hJcj8LpSGZKDevGnzLT8abWYGPXR3JLq9rMYB0usdAtEDcwHuKS1O3T
X-Gm-Gg: AYBFou3St4J+iuOgjMIG3OJ1A9hi5SlsMbyw4SR1HD24aByxYCbQbg7oIxc72055ZLR
	1YLu/h/oFRd6kQSkXkY3g9eeAeUhZ1kOqALnbVc8lShycUU7z0QeeB9DRYn59o3xHLdMJwgt8NF
	+l7nzHtk3N8Xj087hN6vGFch5/NcjtKas4RkBHRnDmKvWWZsD5dSrsEjvjxbwhsdnLhR41HHuoo
	ScPz36C9BXIHVRkiEDzJlN374INJSWTVYhko1V660KDX4/s/MdxH+pnYJnpBomzbZ4YeZ+r6fpv
	BkywE8sOEhDULH5K0uoWhpe1x5CnC3ETtFhQX5shimpnn966zANyAzBunQsFI6ai5BOT9GXKC9x
	90m4jWrK1C8AS6chklosS/dUwVxCaG7fISOvDtjDztSJ2/Cp0AKFnu5klq1h0xqb4AqOsqDbkFi
	woF7ETNYHlwSLLCRiOyvjU1moIdS1VRTfuo7BLxgChfE/Or4qTBmXuQzZ4MyN0mJ3ZRdzc1a7eo
	Inn+nr5XTm41f+kpkdm8pe6pf2OteNTfmkAv7BlGx9og1YREmvlchseNEhwDUb55USo+Th9UO8Z
	AXhVYpneCw==
X-Received: by 2002:a05:6a20:d49b:b0:3d3:af85:eb98 with SMTP id adf61e73a8af0-3de0e790e6emr1523337637.26.1790229913520;
        Wed, 23 Sep 2026 23:05:13 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (67.51.127.34.bc.googleusercontent.com. [34.127.51.67])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc75f2228a2sm2056710a12.4.2026.09.23.23.05.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 23:05:13 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	john.ogness@linutronix.de,
	ilpo.jarvinen@linux.intel.com
Cc: andriy.shevchenko@linux.intel.com,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hui Peng <benquike@gmail.com>
Subject: [PATCH v4 0/3] serial: fix IRQ chain race, baud fallback, and uartclk overflow
Date: Thu, 24 Sep 2026 06:04:43 +0000
Message-ID: <20260924060511.2364717-1-benquike@gmail.com>
X-Mailer: git-send-email 2.56.0.rc1.310.g51773c2048-goog
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
