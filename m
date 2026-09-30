Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC26D3644A0
	for <linux-serial@vger.kernel.org>; Wed, 30 Sep 2026 04:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790741542; cv=none; b=OkDfBvSePLe09HjDGGtC0oR1JfsuWKntxNHjo2lN3gvtSp28PgnykwdeZqzREL5MORldkhcy+GBGNwws2FKaY9E1raCTsGQikB4kSUVa0fynl2Iit8U86A8JujWkV5PG1zAyS1u1uWfrA/iftHFpvOREsd6twbfappG2wA/XhOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790741542; c=relaxed/simple;
	bh=Wp1kvu8ig+V1YLF872Wz1BqEimyjpUIdi0Dh8iuUZY0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=V2Qv7I2sG+JX/6Tb9LnQIC/FjpTdmBis0dVOmBL6MCTjYpb/3PazEpCC+PndsRfMMOFP+p50Tzj+TtMSeSzokvB4kOhpLo/w28TS1FHf6m87py80gYbLIbGgiIjRTXKFcu9PoZczVBW6sTDKBquJt/BZU373p8M95lEkSZ6HhOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ovxJ+Cy1; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ovxJ+Cy1"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2d747ee1f38so21830875ad.2
        for <linux-serial@vger.kernel.org>; Tue, 29 Sep 2026 21:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790741539; x=1791346339; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XaAMebMDjZordO4zemF+dXSXfiyMj2MDwrgVhO9zTiI=;
        b=ovxJ+Cy13JIF0KOLe63RpufsLPdgneU+mG1xwXUHliQbK3icqdAbG2aH7L+vQ8EEtZ
         gdBjGKIn48X6vEqvlGH3gY0ZRLDZg3CkbrI8EXxBwKNvlbAWHlmBa+qZcCwhY4lykGXt
         1mNrQd6cH1tZzpstCpsH4X6ydMpk3h5j3bZaIkuKlybR4VpZjbffvZ7LZeI59TdDi9xK
         3ji1Z1gd6jic1tX1Ad/bmL9iSRLrPe/oHnPlFNpPzOlRysJJUuhSPo+4b4IMttF5NTso
         XT/UIZq8qDbTCxKla9Vz1nuHryq7Ct/CewL29+ylbaBgIuk8IQZ2xJdR/MBvGn3RIYyk
         2uEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790741539; x=1791346339;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XaAMebMDjZordO4zemF+dXSXfiyMj2MDwrgVhO9zTiI=;
        b=HSOdhLmozB+pZLz6VmN25R+xZmIBWOlrEFTCPiVbZGnROW4wZrgPUUiiKlh2+jXKgi
         F5xXtnYynNJse+wD0wcvv4zjxEa56Y+NweUVnJxGYratrqKUAals07NM8p9ldgkAszCR
         rVbvwBrKC709x2T7G2w5rV+PmjH1mBPi05mrn5EfL8gw7WjiX85VpWbNiuFr99nwU5yI
         GYAUd406rDM47XflEYs2PDndPMwoIaN5kCz9VYdAOMKwZNBE3imp+3sQkO1l31QoxGrU
         g+Rd8EJmgD+hcgk0xamCcGIQeICDtmOc1vCcHJHo26ZbiY2M0vW48MDQjqMaOgLn8VhC
         iamQ==
X-Forwarded-Encrypted: i=1; AKwUvByR9wDoBYIfgtADZZ1fIe37Rq8+kNgl0S+HiCs5SjANK6iH0fYqA4ZPLns0kdFiXTtb9J7yX/6aB/g1Ac8=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ2uaQ2/QwVuQ1o0fUMR5eInXxLUIofQgMa19A5bTVq8zQIVSlF
	66NIK9bHW9bIGOzYTEch4m8kxMi+CYAK3rNS9Fytinj51eo5YKsz0KH3
X-Gm-Gg: AYBFou2ip72PrnHPKPyxJwT4GY5XnRScnEDb4UvVWTqEJoqYOFEBdtiK0TEQLNVSzRn
	+5wtA+7/n0M85OxcIAsFOE0J8WABGX6zF2YSnffO4Q9JfS0wDxnUBnasvXW3A7GgVfGWJFCsWDq
	A/fm8Rvt7bn7d5fsni4wDgC59SMOja3e5zDsr1mDQzkZg60TfiJnfqcJQ1GhfTtSZn8jAnhR6Is
	+dckB1X6BNQqa4c5DRnAJSNOfLnohcsKzW63dGcd/A2rUsaGurgxiRnbcebOR1XgocXsneo6wFw
	VlGXb3FMgNp2BNO+I1Y1+0CC8h3gsMamkdAg/gnjH4J0A1pAkUQbFC3mNufhlJhd2r/bG9nd3vU
	hMSCa18N07kdxDYaBEwDCzoNrvsLh2FpD4l/MHDSzXABcvooCjD8Jc94AXxsbkszis+RJEpx1eB
	2tZHPUoxB7kdQd4j7zjZciF/0Cdz0qGJ2hqPXR6oYYdbodds/+q1XG9FtnzgNvrMQKdpWZ5wEDK
	1/jvrfi094WQ8bLUoC+hmNrkqJVmzvCkbs8pnvCzbDZkBNtH7BFTjHrkkL464S/PF0YKGW8xXi5
	8WMwxeEA4KNl1p6ZNRE1
X-Received: by 2002:a17:902:cf4c:b0:2d8:de9f:9a44 with SMTP id d9443c01a7336-2e2e499dfe0mr1806435ad.19.1790741539055;
        Tue, 29 Sep 2026 21:12:19 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (25.187.82.34.bc.googleusercontent.com. [34.82.187.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e2e5c4a240sm160065ad.81.2026.09.29.21.12.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 21:12:18 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	John Ogness <john.ogness@linutronix.de>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hui Peng <benquike@gmail.com>
Subject: [PATCH v5 0/3] serial: fix IRQ chain race, baud fallback, and uartclk overflow
Date: Wed, 30 Sep 2026 04:12:13 +0000
Message-ID: <20260930041216.155911-1-benquike@gmail.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
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

Changes in v5:
- Rebased cleanly and tested for applicability against tip of upstream
  mainline commit 62f4c998b297 ("Merge tag 'parisc-for-7.3-rc5' of
  git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux").
- Dynamically verified all 3 issues in QEMU KVM with CONFIG_KASAN=y against
  unfixed vs fixed kernels, adding explicit test methods to commit bodies.
- Patch 1/3: Updated diff to align with upstream guard(mutex) refactoring.
- Patch 2/3: Trimmed kernel stack trace in commit message to 4 key lines,
  as suggested by Andy Shevchenko.
- Patch 3/3: Collected Reviewed-by from Ilpo Järvinen.
- Re-sending full series as a fresh standalone thread per Andy Shevchenko's
  feedback.

Changes in v4:
- Patch 3/3: Check new_info->baud_base > UINT_MAX / 16 before
  multiplying by 16, as suggested by Ilpo Järvinen.

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

 drivers/tty/serial/8250/8250_core.c | 10 ++++------
 drivers/tty/serial/serial_core.c    |  5 +++--
 2 files changed, 7 insertions(+), 8 deletions(-)
