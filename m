Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D109927A92C
	for <linux-serial@vger.kernel.org>; Wed, 14 May 2025 17:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747244144; cv=none; b=GwCwoWS6P3RWXIvmVnakaOsAfwmPmruAA3SZN5rCn9Y8oqZInLzVPRmR5pa9cCNYY+oJlE+KoFaI3gdwgW6zynsJxmIrY6O3Zsmg3Lj0jIuT47W0KXY0iGgBhwsqt/GfFjKikIOjazUNyrKDOHlgZiCg4eU7eMCIlDqxg6y6mnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747244144; c=relaxed/simple;
	bh=AL3ueqbO2hsVCFQ0zr+/NgG0bSR6IA4iWuxHNLNjI00=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NmbQ/uJcaXX2pvSdGzD66QcM6EQFusizx7ePSs40L+vKrq8q+j5a6CvMAaSf3eIVd22d5+ymlVq1ptv2HSOeDpCWYl8HRw2kXJKCj37+FZ3r+3YHTPJEgklFCtTJr/EOJN247VilHXSNnro8cph3hCW1wgJ/3zM2wn6eXXB2bAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk; spf=pass smtp.mailfrom=thegoodpenguin.co.uk; dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20230601.gappssmtp.com header.i=@thegoodpenguin-co-uk.20230601.gappssmtp.com header.b=olRNH9u9; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20230601.gappssmtp.com header.i=@thegoodpenguin-co-uk.20230601.gappssmtp.com header.b="olRNH9u9"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3a1f8c85562so29658f8f.1
        for <linux-serial@vger.kernel.org>; Wed, 14 May 2025 10:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20230601.gappssmtp.com; s=20230601; t=1747244140; x=1747848940; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SGx2YeQIx8TcF3nQGes8q+WbbJOWSWJi/JOcY/6JLgg=;
        b=olRNH9u9fiFIgjS9ZO9TRf7K8mfM9vETeNUCPHZi/ivZRRG5oT8nZ93lq/JbuKTJla
         q34+20pkXmvjbkY8V2YLge7Ik25MnqVfxoTPi5f0WyeM7BmIR3dy77DvHyhX6QIt25QZ
         eOLdojfbz0Mwm61sYLB2mfSN6ukpkOthpwVTeg5B9mlj2Fs9s5fmhrKGidcViMPWM/sU
         jKphVjdWvXFynOH9MsNNGSqEMBeEvYeepvdvIpr55IwiwRDJ7D9iWbkoT5CQMtU3oevr
         XZFW8AoPCee038cuJSDY3mq4KzGh7q7QgLmHjcwHwiE4SUP0qZ+E7llGiE6Yhb0QkZjJ
         9oxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747244140; x=1747848940;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SGx2YeQIx8TcF3nQGes8q+WbbJOWSWJi/JOcY/6JLgg=;
        b=Jy7Tjf+zKud70DY9uSnDe9sKy24q2v11liNZDIXZZlrLrTiADdRZ6Q20ub60Y4yyZT
         FfUDE5vUR8qmJ1mDox1vQBk9iXhEDQUHm/LrvQsFj6/T3HApYqv8tyMif9vcCJ4DC1tm
         4hciqUeAyAl5oXL2MO530X/BGztmPCYR4+uOANLRFs7QGHDwZroHGy/TTiGwG5gLr+OL
         nydRFoa32sSXSysm4O0exWqn8atsdoWADRSVRU0RVoLnziOW7myUbWvBE/4kvDW1iyAm
         WC8aABtfpkBazG6fEaDxe15Bv/p+9QgXBDsfVcRmyZtCYIvwo8ZKRoQ0/wNqolBepCCo
         C99A==
X-Gm-Message-State: AOJu0YxJOT7T5+iYTSLlxdHUkZmXiBsdegB/CzIukFZZ5t2rZOcPvlNI
	6wf0c51qp93RgQqfrnlRBGkHUcK2asgEhgbsgNhL5pwGWGLJZvqSZD4XrbKz8Uo=
X-Gm-Gg: ASbGncu5B5p9ESyc3jwCJO2qmKTmkEUrNm+pd63F7BCJsnYIs9jscdVVzm6ie5gPZnJ
	j2gcA5ai0RKNPRyDXcZCKWmXoNhKHBWN2gREl5l371oVhtTGixZGyxZApUz8mn3o7tY7qMUzTo4
	eorpa3g4h9V+okF7cNQ4EDjWn/5OEtkadnvzBQTdd01Iik1ZkoCLoS3Z4wCbA+vYqhYKrTHQzIM
	DvbfER+/3tH22Ea0hQaPpFHhxzdRwkuEMYvW97UEk6cKeDkpHngA3pYxxh3E/vgzTeQ6JbI3FyS
	z1dJgc02sgAbz3UoLqY/jmGv3NDqQDfAHuDX+kTyX7/U8VOrAXotQ4yLQyL4JQmHAGp3U0PrYVb
	/JGUD9aynhBcBYVOoBfHCXfD3rCBbMDz1S1YXvAx0vHtCi3+pwTCMd+spC8waS6CD57gv
X-Google-Smtp-Source: AGHT+IE4kbe0sn9JHHYe/vP4xooi+62/6rTqXHPY2oBreThyYBO6MG1RIeIePFrS+4m9aoV8igetBQ==
X-Received: by 2002:a05:6000:18ae:b0:391:253b:4046 with SMTP id ffacd0b85a97d-3a3496a4c72mr4089543f8f.16.1747244140052;
        Wed, 14 May 2025 10:35:40 -0700 (PDT)
Received: from ubuntu-dell-xps.thegp.cloud (shef-16-b2-v4wan-169484-cust3641.vm3.cable.virginm.net. [92.236.206.58])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f58f2a79sm20058436f8f.48.2025.05.14.10.35.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 May 2025 10:35:39 -0700 (PDT)
From: Michael Cobb <mcobb@thegoodpenguin.co.uk>
To: pmladek@suse.com,
	rostedt@goodmis.org,
	john.ogness@linutronix.de,
	senozhatsky@chromium.org
Cc: linux-serial@vger.kernel.org,
	Michael Cobb <mcobb@thegoodpenguin.co.uk>
Subject: [PATCH RFC 0/3] printk: Don't flush messages using write_atomic during console registration if kthreads have not been started yet.
Date: Wed, 14 May 2025 18:35:11 +0100
Message-ID: <20250514173514.2117832-1-mcobb@thegoodpenguin.co.uk>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


Hello all,

When using a legacy console, there is a large amount of time during boot
that is spent printing boot messages to the serial port. I have spent time
looking at nbcon and the potential effects the new interface should have on
boot times. We should expect a significant reduction in boot times as this
work is now offloaded to a dedicated kthread.

With some slight tweaks to the behaviour of nbcon during console
registration, it is possible to reduce boot times significantly.

During initial console registration, we mainly rely on two flags,
`have_nbcon_console` and `printk_kthreads_running`, to handle the glboal
state of nbcon and to determine the appropriate method to handle flushing
messages.

In the case of nbcon, when calling `printk()`, messages are either flushed
by the caller using `write_atomic`, or this work is offloaded to the
console's printk kthread. As can be seen in
`printk_get_console_flush_type()`, under normal (i.e. non-emergency or
panic) priority, we check the value of `printk_kthreads_running` to
determine if nbcon consoles should be flushed via `write_atomic` or not.

When `register_console()` is called to register the first nbcon console
during boot, we know that `printk_kthreads_running` will be false as:
- before the `printk_set_kthreads_ready` initcall, no kthreads have been
  started since `printk_kthreads_ready` will be false.
- after the `printk_set_kthreads_ready` initcall, `printk_kthreads_running`
  will be false since we have not yet registered any nbcon consoles. As we
  are registering an nbcon console, `register_console()` will set
  `have_nbcon_console = true`. At this point, we are now in an intermediate
  state - we have registered an nbcon console but a kthread for it has not
  yet been started.

In effect, this means that any calls made to `printk()` after
`have_nbcon_console` has been set but before
`printk_kthreads_check_locked()` has set `printk_kthreads_running` will use
`write_atomic` on nbcon consoles. As `vprintk_emit()` calls
`nbcon_atomic_flush_pending()` in this situation, we see that the newly
registered console has all boot messages flushed in this manner.

This RFC patch introduces a new flag, `printk_kthreads_pending_start`, to
handle this intermediate state. This flag is set when an nbcon console is
registered and cleared once `printk_kthreads_running` is set to true. We
then check this flag under `printk_get_console_flush_type()`, so that
printk's are deferred in this state, relying on the fact that a kthread is
about to be started. This does not affect behaviour under panic and
emergency priorities which are flushed via `write_atomic`.

With this change applied, the flushing of printk messages on a newly
registered nbcon console is now fully handled by the console's kthread. On
my test hardware (Raspberry Pi 3B+), I have seen a reduction in the time
taken to boot into userspace when using nbcon consoles from ~9s to ~1s:

Using an nbcon console (115200 baud):

[    8.377111] probe of 3f215040.serial returned 0 after 8090191 usecs
...
[    9.316964] Run /sbin/init as init process

With this patch applied:

[    0.302173] probe of 3f215040.serial returned 0 after 7479 usecs
...
[    1.096505] Run /sbin/init as init process

This patch has been tested on master branch of the printk kernel repository
(kernel/git/printk/linux.git), Commit
af54a3a151691a969b04396cff15afe70d4da824 ("Merge tag 'printk-for-6.15-2' of
git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux")

As the 8250 nbcon driver patches [0] have been applied and then reverted
upstream [1], this patch requires those driver patches to be reapplied. For
completeness, patches 2, 3 in this series reapplies them, but these patches
should not be considered as part of this RFC.

Kind regards,

Michael

[0] https://lore.kernel.org/lkml/20250107212702.169493-1-john.ogness@linutronix.de/
[1] https://lore.kernel.org/linux-serial/Z5jn5M5bdV5u21GB@kroah.com/

Signed-Off-By: Michael Cobb <mcobb@thegoodpenguin.co.uk>

Michael Cobb (3):
  printk: Don't flush messages using write_atomic during console
    registration if kthreads have not been started yet.
  Reapply "serial: 8250: Switch to nbcon console"
  Reapply "serial: 8250: Revert "drop lockdep annotation from
    serial8250_clear_IER()""

 drivers/tty/serial/8250/8250_core.c |  35 +++++-
 drivers/tty/serial/8250/8250_port.c | 183 ++++++++++++++++++++++------
 include/linux/serial_8250.h         |  13 +-
 kernel/printk/internal.h            |   4 +-
 kernel/printk/nbcon.c               |   2 +
 kernel/printk/printk.c              |   3 +
 6 files changed, 198 insertions(+), 42 deletions(-)

-- 
2.45.2

