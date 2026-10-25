Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.125.188.122
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792893813;
	b=ivjh4j7zwNgZzbxiO5uQmjJ32b3aNtdF552d8/K4j6J0IIbWi7nc/GOTDwiIGG/7877K
	 DYyChOuBftcYeDxptxnPif+HQPsOQV1T94YFsN5IswnV+Mv4dtbnGbXl36mxOKyzc0Ap1
	 dhrzL/nlb5gRkD/IV3qMKgLE3CGhvJWHqc8KvgCjuBSjbWAkQIGaCkXXb9i9O2YKb5XOZ
	 xxVr4/Pe9SHnzGuTjDHBaJI7ZvRFNVW/xQ6JVL/IH653yYxgRo6EAbBpYhAWmssyK/5Pr
	 YUD3o/nzFq//bL422Q442YVvzM8zqOFsAJDB5wzrD5bZN34Wpa2P6/lIkBLTYCiHvLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792893813;
	h=DMARC-Filter:Received:DKIM-Signature:Received:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=nKU06tvEDhiEH3FF5h5I6jbuWJouTBUnSsYOyx81+iY=;
	b=h7iPoGJNYRdRPTHv2CtOCCthif05J0cHg0cYeCanKeqzKqGUZ75UIfmkxkW4bQoLGebC
	 DBUl4YpRV+UiTNlMhk8UGPKcuVI7r57xpQbJEQuad+5LEZOoMXgW7btYCSUhzN2Ya1/dM
	 d7O8MgGQAGQkQ2XQkNW8yGTXf+DvsUxBPI+n0U/Ror5RkN8j2ni9YCf99zpVwigaOh6XC
	 I+swmETDFkLY9wbNmtNcoqhhZD1mIaBq6Jxlx6yAuxhiCIY0o064qJ3z8fK29V0u5bo29
	 PDjjY8JkWKT0nbgntIILUCrJk6ebTyH9paZ2qtc1iPd6vQrttrmsdFTtP70Kk7rSplA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=canonical.com;
	spf=pass smtp.mailfrom=canonical.com;
	dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b="RucVvXW/";
	arc=none smtp.remote-ip=185.125.188.122
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D36A5606A31A
	for <linux-serial@vger.kernel.org>; Sun, 25 Oct 2026 02:03:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D36A5606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key, unprotected) header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=RucVvXW/
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id E4E953F322
	for <linux-serial@vger.kernel.org>; Sun, 25 Oct 2026 02:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1792893809;
	bh=nKU06tvEDhiEH3FF5h5I6jbuWJouTBUnSsYOyx81+iY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
	b=RucVvXW/RB1ZbtUcn7Y4nL1U4guLmw/ENPcMBzk/rSXDQdWoQQ8cgpDKzqY6FNqJa
	 JnpY+dNCgz5ChvFjaeYM7i3g6ILkQvKlSjSqzVD0z40PY6xUq5GBmkqBhFKVlk4YQJ
	 Y+XHN0SSzhMOfOb0TGJG6TG6Bt2jOLy2fMrt83zOwA9ZK+OucldOJGIDhFaSSds0KT
	 dcnV7uJS+x0O29TROVc2ikq9fGd2TFiBTcH1pQYduJeXfbxzUBae1magZNsYlcwP0f
	 t6ScMvutjXPf5krQIRtYr5wOxwWbSdqzwSPF0lHB1QTgJHRjuonuKFObSbnsFa1xeY
	 sZfY55oboXC+9uPdTWpIX3WIntuGtQ+NnzQcNb4vqL8g33YMPM8Ux3VxE8mu6RefzD
	 LJBOzRLrTWLUhFYUzJKEhL1Pw/9oHe2VNp11/lVKLNoKcJG8g16grB4u7k6+2RK12F
	 +wH/BIJtdvKopZf4j5ttrCtctpcMzzbSxl1EjlplUQh6bkjaYqsktX/C1GKbS9fpcP
	 KMJcIGRXf6/XJdpJBOecfCpGFkP+2htJsPKCVm+yIlMZwZNXLKRVY37C1peRU/NnVy
	 Jff2p9159BeFA5yfL4jWFUyiiBnpTRa1EL59OTV+5190gp3yW3Bu5JMtHJ6eCR0NKe
	 EFHbl+xcTf8EsLXfjRkPl6WU=
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3ad3bf3fe2fso780226a91.0
        for <linux-serial@vger.kernel.org>; Sat, 24 Oct 2026 19:03:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792893808; x=1793498608;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nKU06tvEDhiEH3FF5h5I6jbuWJouTBUnSsYOyx81+iY=;
        b=SZxXPox/yT4bA8U0urqp8le9YO1YVSsD6cTnXIWdjYKvQy19sBKSw2K434zTztTpiC
         sv0+xIETiiUK+VsxBjd7dC6guY0L/JTxdjErd78j4ypWJBEqCd8hod7Ui0aDb3+YUPqv
         mNiEqh4vyAUrZYhCTDkZ7hgVX45VBEBZ4/D+0vRu+d84y14kxdTm052pH/4FizbDtbCm
         t+4UYkRdmb8roP15BVk4rBzJlfnUX65KGk83FH9pm3eUXKlKhOuCXDnq3X6ofVL1X/Kn
         ev9x2yEbfcI+nIAkvbFz/tU8AkG+yEgHWmCXWhnj+qN8WVSTDPwnNf9cdnGZDaXWK6Nv
         wCIQ==
X-Gm-Message-State: AFq9FYJAPtBQE2w6AVRX3LutuELyUdRFzU+bzUvoumuUtHDxfvbDvYls
	zImHhamOjXMft79+t+IfltSESPLKbA0aW45j66a/gWUs86XrLzK96Z9vtUtcqj+tqnXPfBxVgYU
	S43Ogdg/ctOvvoV/lXN80mQcuUyRIFYDupmz73r7fEcSmdIAIX7CHi6biaRnpjOABdJemxFXiHx
	UCa4W0Al4uRmz90g==
X-Gm-Gg: AYBFou3TJRqDYu+Mt2cCyqWiKqs0cNrdXLUV66/7E51kSA8av6tX7WoOF6hmIC4hRft
	ihGSjxow4f1qKKMbCRgCQFuzoS8bopLZK65RH+F9sXJY0EvM5rkqMPXyqN6CAQtPiDMMT2vVbHc
	5gHrgoytMCNvYn1trQB890dQC66XzBcoFbJexKD0neNV5Yf6hVlQ7CxAbftum1pEIAlfKaOITXl
	p3cJc4afr3j6mav12aKIFLyneusZXxC8MMv5HvLESB61t8LXMx4PpmUAlvN9e9ZEzqVMRLh0Jvd
	8y7wIFTid6U21TlpVuOEtCmy7/OjTaw3L2xpDFYVB9DHPb4T4bVvhuYxAq+MPPz1dICxFyi03o/
	UU+USRH4ZnxNJixqs8HjzvYJii16DU27GudtTowT+RzGj4nWTMGM/MTohuwvFekTrOXSWJEKbC8
	8Xn47o36eFA6qjEU/3LLSP2oFvNucjCU/oJOaduRhqpwdZ84/vx9+76jcbE9dOnGRZ/rsbfFzgX
	DPP1y+erdvGwpofGAPBW4pkLITq3XvF3BVIScf4uw==
X-Received: by 2002:a17:90b:2244:b0:3ab:a188:b898 with SMTP id 98e67ed59e1d1-3adea06d536mr5191392a91.2.1792893807874;
        Sat, 24 Oct 2026 19:03:27 -0700 (PDT)
X-Received: by 2002:a17:90b:2244:b0:3ab:a188:b898 with SMTP id 98e67ed59e1d1-3adea06d536mr5191366a91.2.1792893807472;
        Sat, 24 Oct 2026 19:03:27 -0700 (PDT)
Received: from an-XPS-15-9520.buildd (2001-b011-2008-445c-0e25-4b6d-1924-440d.dynamic-ip6.hinet.net. [2001:b011:2008:445c:e25:4b6d:1924:440d])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adebacbf5fsm4226044a91.6.2026.10.24.19.03.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 19:03:27 -0700 (PDT)
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
Subject: [PATCH v6 0/3] serdev: handle devices without an ACPI or device tree node
Date: Sun, 25 Oct 2026 10:03:14 +0800
Message-Id: <cover.1792856688.git.an.wu@canonical.com>
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

Changes in v6:
- Patch 1: switch dell-uart-backlight and yoga-tab2-pro-1380
  fastcharger over to the new serdev_device_add() signature with
  modalias=NULL so the tree keeps building through patch 1; patches
  2/3 then switch them to a real modalias. Fixes the bisect break
  that sashiko-bot flagged (true positive, Markus Probst confirmed).
- Patch 1: wire up struct serdev_device_id in modpost, modelled on
  the SPI bus: new DEVID() + DEVID_FIELD() entries in
  scripts/mod/devicetable-offsets.c, do_serdev_entry() and devtable[]
  entry in scripts/mod/file2alias.c, and the device-id/serdev.h
  include in include/linux/mod_devicetable.h. Also add
  serdev_device_id to scripts/coccinelle/misc/of_table.cocci.
  Reported by sashiko-bot; the two in-tree firmware-less clients do
  not need MODULE_DEVICE_TABLE(serdev, ...) because the same module
  creates and drives their serdev child, but the plumbing matches
  the other buses in case out-of-tree users want it. Markus Probst
  confirmed as true positive.
- Patch 1: drop the unused `#include <linux/string.h>` from
  include/linux/serdev.h. strscpy() is used only in core.c, which
  already pulls string.h transitively. Reported by Markus Probst.
- Patch 1: drop Markus's v5 Reviewed-by. The modpost wiring and the
  dell/yoga NULL-stub bisect fix are new code he has not seen; the
  tag belongs on code that was actually reviewed.
- Patch 3: drop the "serdev driver MUST be registered first" comment
  in yt2_1380_fc_module_init(). With id_table matching the order of
  driver_register vs device_add no longer matters. Reported by
  Markus Probst.

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

v5: https://lore.kernel.org/lkml/cover.1792831564.git.an.wu@canonical.com/
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
 include/linux/mod_devicetable.h               |  1 +
 include/linux/serdev.h                        | 11 +++-
 scripts/coccinelle/misc/of_table.cocci        | 16 ++---
 scripts/mod/devicetable-offsets.c             |  3 +
 scripts/mod/file2alias.c                      |  9 +++
 12 files changed, 120 insertions(+), 49 deletions(-)
 create mode 100644 include/linux/device-id/serdev.h


base-commit: 9e947d96915af63e28896caae85a81b74855621b
-- 
2.34.1

