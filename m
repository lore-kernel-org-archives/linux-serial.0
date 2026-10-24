Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.125.188.122
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792843496;
	b=pVai9vbi93uQfItNUJUSvWfJTj15uD7fx7q1X7N/udZCIv8Ib1Tx2oecN+UX6lZusTbJ
	 xje9MO96LC/i2Ex7ZsoC1kmLSEFZH6t22zMJKjLnhrEYqFOPe4HFTP/RxLyY+I5nav7Zy
	 d6zAWpb8dLQ+mi1ubKpeOHYq6i02qTcaaFVvKXXantY0CL2nbYArW7llqdqXppk0hZzoA
	 UYDYQa10hzFjQbfiTXFFZS4GQoC0Gmv2zOCzaYz4ST4pK562HAQr7GyrRP6wfddTO2+zW
	 efOuyEXxSaOk+g4KkDu4BAsmZ7Ivk/sIkoRMpCHFRXH1DLNPzDDLVRY3y6D+wamroVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792843496;
	h=DMARC-Filter:Received:DKIM-Signature:Received:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=/yYlcVbWauKdzvWIvsccZxgFQkxdIfYL+H0J9xQ3krg=;
	b=mxkyfsNR9C6kgNuW7FmKYTlU03JriQH2Vw6/viXRQDlf2F7q+JEj9isf2gvYbHShMiYL
	 bH8pmL7tZ1UjqAJ7WvTsXLlhJ8W0HfORS91eNPYXlSfeIuEvFAkNC6tkNtGkYBOdUadUP
	 FZ1CiRtpL1whUb9qdomdSUK1kfQ2UnMGZHKy2m4RhedFp4rc84b9qZwo+1aKYB5b/3NGr
	 EvEsqY5aR8CJtWQ/DODjG84V3VdWad0kIxsfdwh9CcJhbAs8x9zewFUbiO+jUp9mJoeni
	 sVnx2hCjluHtyGl9/SDAEG5WLVRWhitGBtjseVB92P/FA/evABOqs6C7uWJNJCoDW4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=canonical.com;
	spf=pass smtp.mailfrom=canonical.com;
	dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=P201Pd5s;
	arc=none smtp.remote-ip=185.125.188.122
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3BB606A31B
	for <linux-serial@vger.kernel.org>; Sat, 24 Oct 2026 12:04:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AD3BB606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key, unprotected) header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=P201Pd5s
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id F2146402DC
	for <linux-serial@vger.kernel.org>; Sat, 24 Oct 2026 12:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1792843493;
	bh=/yYlcVbWauKdzvWIvsccZxgFQkxdIfYL+H0J9xQ3krg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
	b=P201Pd5s0w4aw1aifwhAModYUBhN0vy0itF9/K2OE7dMg/x/hthPfzGxKqCraAS/U
	 3YXSiOWracxVeXftjIomUmzRmBhCAtISAy/NDYIYIlTK9OFQ+UlWZDfgaJiT+3I8aP
	 E7if4tbV+9J05mW9ZzZZsgSp7/97jFnSwRQTLxKvCkT8fgyUioPuh/TWB4W6tNbqeV
	 hZDso8pXe3x6dmLLjzBRqjGto9Uh2uOmCofH0DBkhTYb9jQ5SO9dmjNPbuOnGwi7dX
	 rWPB52T27S8E3qy4vNtuVumRlYlQL1dKfkfI5CZRTkwzanZXKCgwW93OmaBfrZGDV3
	 1glYoEAPf+8Mley/LQnDIr7MUftMOHGJYedtWi8myPZ/v9he5kn4lhRKoxv927pEH9
	 MXToKbaat6DPwROSnt8jCSZJEyRVFphfA2z1JJWtHI56aKTruwrK2kxX1yR1cTmYZ0
	 cIyOGtY/M65+dbpPApUC/yXPHNYyiSu2q14epSofX9+BRb5mMB+SxH9Taue6dZu9UD
	 tV0xuzJHmGxJGHFRaJ5SmFwR5F/axFhlLGGRCT/MwwwbqZVOvoqhb0zVbiAFsCkRo7
	 jPAtevTL4StCVVrkjt3sM0W+CqkOdepRy3yZG8mkw7FftQJtJ3NgthBTDjl9QEa641
	 XG49+MH/T+YIpoVs81i8XfLw=
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3aa8f8c2638so508369a91.3
        for <linux-serial@vger.kernel.org>; Sat, 24 Oct 2026 05:04:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792843491; x=1793448291;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/yYlcVbWauKdzvWIvsccZxgFQkxdIfYL+H0J9xQ3krg=;
        b=QaptBOkHlb2+OlKxAl+ga1aknricCcumPphtf5BsU7CSeU76jb8U6qzNqZZ8Iq+Kq+
         m4oyOsW5RRPlW37rdv5vCife8pe/EaAROjbpoYmNCUgT7Huf4T4oFWE5BA3C2XxO9jJO
         e38hi+WLnwbisroxGCkIxEFa3h4sy01C1Rik+khcyHoySeBis27eh8rx2/Noreup7++v
         27Fp5pR2fvtzlLjyLXbqI+PxLaeq44Wu8u93YFZZKAnQ9RXldoFtgqTc3KgigniJLNUp
         kCoOv1exrYuk+afMwH09Zj6iI20ikNMcDJhiq2dagxBX3hxJKxIIGDGFK1fh9yK143vW
         f/tQ==
X-Gm-Message-State: AFq9FYLV5Y6G8B3BYAOEmN6VWVkCA4GwCADZsHCM5oKpZJ7EL2rmo0qs
	CjZrn3P5psaG1m0OQ57J2Tn9qSjXCkEvDFbKF6e8W9LfNnxfGXJwaNme+qKD9RDpaCqA+MvqGr3
	259tQgW3vi6xFWf+t67uK01VqOd+0y5fSwBqoj6HCcXNSzPRkHvpTbx7WOSrHqlo4NYQ1yqyQLR
	8iE5qycImpTGrsBA==
X-Gm-Gg: AYBFou0Juvt6lnB/BLYyIMvwAwitEbmIhXXxOdnHTYcZ+3Wmv40W2Pz0jxg1hDKluCe
	Wn3lV0axlkgSLqSDgcP6UHPbA2JUbzDVeVQ2Gae6qblUbVsAD+B1eNadLlK2l8SyqAQLldAZxwP
	yvihkt3RzoUKWkQgInN/nk5cuCqC1jlJDdmJ8GWUeY10agCpJbLn4QTS2KOTCbraOiRekkokX+q
	WVRmS67JFGOmmLlh1UluBQnfAPndPVCt6g4BHkF6WcKlW7e5jUjrVZ9tSkyGfXvYMAXWvoyiULX
	3J9ql+vE0MLGGwUo5IWzt4NsfsYs/8+wl8LgUPW0yUZjwjgtWxWGvldjZ4u9ZmpdTZaayDLzaBb
	X52inTra7Ei+26g/K6WHjZxQt8cAZzSYjTG+OMDRz7RxOzBAFaUnaPabnK4C2jkVV+8iNPINOLJ
	nOHpe8kWROg60rklkRqwtAxPKQ/zV5npS1o2KJJvdCxjGQH3NxQc08m+oWfZOsNNLzyxkXZCuJs
	TsCGXJD3NUVwjrfhGTXG3VUwaqodJsWDaM3O/JG9Q==
X-Received: by 2002:a17:90b:2645:b0:3a6:e61f:749d with SMTP id 98e67ed59e1d1-3ade9b2ce6bmr2893145a91.1.1792843491091;
        Sat, 24 Oct 2026 05:04:51 -0700 (PDT)
X-Received: by 2002:a17:90b:2645:b0:3a6:e61f:749d with SMTP id 98e67ed59e1d1-3ade9b2ce6bmr2893103a91.1.1792843490725;
        Sat, 24 Oct 2026 05:04:50 -0700 (PDT)
Received: from an-XPS-15-9520.buildd (2001-b011-2008-445c-0e25-4b6d-1924-440d.dynamic-ip6.hinet.net. [2001:b011:2008:445c:e25:4b6d:1924:440d])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adebb24a04sm2893409a91.16.2026.10.24.05.04.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 05:04:50 -0700 (PDT)
From: ChunAn Wu <an.wu@canonical.com>
To: linux-serial@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	markus.probst@posteo.de,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	hansg@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	mpearson-lenovo@squebb.ca,
	derekjohn.clark@gmail.com
Subject: [PATCH v5 0/3] serdev: handle devices without an ACPI or device tree node
Date: Sat, 24 Oct 2026 20:04:37 +0800
Message-Id: <cover.1792831564.git.an.wu@canonical.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Driver-created serdev clients without an ACPI companion or device tree
node currently have no modalias and cannot be matched to a driver:
their modalias sysfs read returns -ENODEV and their creators force a
bind with device_driver_attach().

Backlight function on dell-uart-backlight is not affected: that class
device is registered independently and gets its own add uevent. The
user-visible breakage is the failing modalias read on an existing
serdev child -- Checkbox dkms_info_attachment aborts with
"OSError: [Errno 19] No such device".

Resolve the two long-standing serdev-core TODOs by letting the creator
pass a modalias to serdev_device_add() and giving the serdev driver an
id_table, modelled on the SPI bus. ACPI and OF match first and are
unchanged. Convert dell-uart-backlight and the Lenovo Yoga Tab 2 Pro
fastcharger to this path and drop their force-attach workarounds.

Changes in v5:
- Patch 1: restore is_serdev_device() guard at the top of
  serdev_device_match(). Dropping it was correct when match only
  called acpi/of helpers, but Patch 1 also adds
  serdev_match_id(sdrv->id_table, serdev->modalias), which
  dereferences serdev_device-only memory. Since serdev_controller
  shares serdev_bus_type, the driver core calls .match on controllers
  too; without the guard, serdev->modalias on a controller reads bytes
  from inside host/nr/serdev/ops, and strcmp() can walk past the end of
  the controller struct. Reported by sashiko-bot on 2/3 and 3/3.

Changes in v4:
- Patch 1: drop the dead is_serdev_device() guard from the match
  callback, and dereference serdev once at the top
- Patch 1: drop the "large enough" comment on SERDEV_NAME_SIZE
- Patch 1: in struct serdev_device_driver, place id_table right under
  driver, next to driver->of_match_table and driver->acpi_match_table
- Patch 1: merge serdev_device_set_modalias() into serdev_device_add()
  so the modalias is set at the only point where forgetting it would
  matter; internal firmware callers pass NULL
- All three patches: tightened commit messages and moved the v2/v3
  changelog narrative out of Patch 1 into this cover letter

Changes in v3:
- Rename struct serdev_device::name to ::modalias; dev_name() is
  unchanged
- Model matching on the SPI bus: add struct serdev_device_id and
  id_table; drop driver->name matching
- Add serdev_device_set_modalias() helper and SERDEV_MODULE_PREFIX
- No MODULE_DEVICE_TABLE(serdev, ...) support: both in-tree
  firmware-less clients are created by the same module that provides
  their driver, so udev has nothing to autoload

Changes in v2:
- Instead of silently returning success with no modalias, use a
  creator-supplied name as a "serial:<name>" modalias fallback and as
  the matching key, so clients can bind through normal serdev matching

v4: https://lore.kernel.org/lkml/20261024022930.2704030-1-an.wu@canonical.com/
v3: https://lore.kernel.org/lkml/20261023052717.2577234-1-an.wu@canonical.com/
v2: https://lore.kernel.org/lkml/20261022032842.2492572-1-an.wu@canonical.com/
v1: https://lore.kernel.org/lkml/20261021092124.2306053-1-an.wu@canonical.com/

ChunAn Wu (3):
  serdev: handle devices without an ACPI or device tree node
  platform/x86: dell-uart-backlight: Bind through normal serdev matching
  platform/x86: lenovo-yoga-tab2-pro-1380-fastcharger: Bind through
    normal serdev matching

 MAINTAINERS                                   |  1 +
 .../platform/x86/dell/dell-uart-backlight.c   | 18 +++---
 .../lenovo/yoga-tab2-pro-1380-fastcharger.c   | 25 +++-----
 .../platform/x86/x86-android-tablets/core.c   |  2 +-
 drivers/power/sequencing/pwrseq-pcie-m2.c     |  2 +-
 drivers/tty/serdev/core.c                     | 62 ++++++++++++++++---
 include/linux/device-id/serdev.h              | 19 ++++++
 include/linux/serdev.h                        | 12 +++-
 8 files changed, 102 insertions(+), 39 deletions(-)
 create mode 100644 include/linux/device-id/serdev.h


base-commit: 9e947d96915af63e28896caae85a81b74855621b
--
2.34.1

