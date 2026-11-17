Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794945904;
	b=Pa9g36bpu9gwjxG8iRVPIqmIGO3XRG1vtouAEuDUWdNL4ypCGsjoldduvCJi8Pj7J7pW
	 RvwnClyi8gyHAE/YBVWX5rgYjU1inorQomsqSxaRl15tUTakoAUJ4LGw3BYOklEnsKrLA
	 mKt1dMCoVMXgC1HxF0h+r2YbkAPaLAsMfYXToyTBTF0WAjtAKtSkG/7nusZnjTJ3oPDiS
	 s620gNr156VD3zx4yF3v0CDZpLfzeXmSwfy4w3xYMZujHzl8S6FrRlbzNVuEByS8Enhxv
	 G3fd4v62NW5nK+XHXN1KY3hILW7GQIiQOx1S931ZZMGJeLLJ6rHNq5xeX/MzPkhpLhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794945904;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=rbt3Rhy1XEaIZQdvDh/UUWSNfD774dI3KIhZaPLXG14=;
	b=D8TdlTcmFDYTbEsJ7UiN0DD5GmaEa9dg34YZyqYiQurHpsRplitU7RTD/5zYADUc9bxI
	 M2YnyO4qGUCEgKA5VUeQNpo2FlK0GLYWNcxRyJZFNcgIq968jvdf7ZrP+gNc5kzML4gKw
	 ZzJUlUYvcX6pb94lnEsB4BYlNd3jfe0YLKmuEpsIXICeejGJVDXQTFZ8Q0TUcwndMzaIv
	 OLVXHlqEXmlll8BkKeGH6CDu5uYT1u/vYJsKinTRwcLUd9/t4/Fex0aiOrdrLy9py0w5H
	 +fFh9qCZx02yDfpTX6Z1Hw5uCzUPxc5uqc2okZxCKC4h0J0OhsNOtvwhQwxG0lREVhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="Rl3RG/9/";
	arc=none smtp.remote-ip=209.85.221.45
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC1A606A8BD
	for <linux-serial@vger.kernel.org>; Tue, 17 Nov 2026 20:05:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5CC1A606A8BD
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Rl3RG/9/
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-490d59c3edaso51272f8f.1
        for <linux-serial@vger.kernel.org>; Tue, 17 Nov 2026 12:05:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794945902; x=1795550702; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=rbt3Rhy1XEaIZQdvDh/UUWSNfD774dI3KIhZaPLXG14=;
        b=Rl3RG/9/xZYVC0CxWmQNFvRhK2NwjXwdPqGVzkDVM0hVx4uVtIf5s+llV6tvNAe5sL
         j8sg1nBHfVJzwU3v7Iwkm35zWbvB+T0tWqMYr2HCVCV+MdEsTqArWfYtNK013VpVBtBw
         XB10U3MY58xqgocAUcU7JPFon23tpiyycY1uJjcp51uNugRdWgLxDKkVCYMwBCBXcTZ0
         MZcyqBKLsCj394UHMGmbX9LeIWI+tlSD65ls1aIOpa0wEmirfHKlDDJWrv5wEbNU/VvS
         Qbb2KAVJJLoavkN5TLKhapxwJPG9zZeQ8N9cAsic2igbnbSOM2SYO7ERc2hYjlNRqQyx
         DVAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794945902; x=1795550702;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rbt3Rhy1XEaIZQdvDh/UUWSNfD774dI3KIhZaPLXG14=;
        b=e4RLfJ+cvucc+UE4Cetn1lYMaEe7Ffs//BKo71yQfuIrbtA1scH28EkzCQEths5jB5
         64HpWh4+rhcNswded79ugpK5uRMoI1cY0ql7g0ymz0ekL88nBY9nPd/VS76JobROEerl
         7ObvaIEEF8yuAA37tK7w/L4q4TJhkJRjlohYDJv3FS6G942CoJHIOzu+ntz9+v97R1DU
         TaAlU+ZsOa5mFA6Edf/fNxKDYJ6b907i5STHICva1qsGGNAa/AL/wGPMFuNlbEYVCI9U
         +6AAgaOpOSpTYJlxTyoma4fSPMzKevOTCtMUo81BrGHKaDpG0UuMTvgt7cYu+wYFV8ZL
         Fiow==
X-Forwarded-Encrypted: i=1; AL+hErGcQ75d7ZCfw843xTp5BNujUN0Cu1xcl0DrA6oajEGOUfqw+o5nOlDG+gwDM/i1TF2skof3gwOsZvyesNI=@vger.kernel.org
X-Gm-Message-State: APuU4Z/8+r9gGsHHk38Wqaxdglb4pGld1WnlGaQwmhJjCNhBVgoS9EJU
	tMpMZRgHOMccZz0NgYMnJSAWc5P5uESabQDArizXh/4ThDi9ZL4lwsK6
X-Gm-Gg: AZFdTZddcAqJxj7086w5rjFwPzco7rUFB2WgAnNyMrRszsdFtQJHPuJ23brJ2xLACfu
	mg9kuFZoYeBSufp64OWuy95GkkhkmOEKg7cPwyMgzTTqaYhhLjIx6A5w6PVJ/kPjQv98PnN2i83
	ipWi39i6hvocZ/TQt4vVraNhPiyccuOZtaVGN6NYfT0tlK8Li3iPpreE4DSkwrqtdFFFHsReHlR
	hrlmgxNN82bgNMp7Gsz5U7jaQuOGoP4YhW7PoZLL96KLte2mCuvDG4bVRW3JVIYWeNoJ0GVWNct
	k1us8YS9OCGJfo1KjQv254pOg0q8KjNoUM9iKM4OoFsfyt5VGpsKr2poE0A3qPbCc4S9R/4iEO4
	hro6AZOjpNd61KbPSZ6nUCqg/92/OyhbB+XKO1GSLL1vmQXhVhmZ7Y6iXc520GqI5+42rG/W02Y
	hBlDAfUKMIK85Fs1JvmN/FdRwbdN2v7wB9dxzRGzApJeWf9JpOrlx2TdvHw8YgArU3aPdbxBsmz
	EkfvN5QbI8FnPpIyAArwoWx5wPecO/pxywWjSMMcBSte3Xne1H/nIo3mDY2lwRueXidREwuKR6x
	5Yvo17EmongPsiWlmkIGpmzLThLn
X-Received: by 2002:adf:e18a:0:b0:491:d721:548f with SMTP id ffacd0b85a97d-4a3735b4463mr8160153f8f.12.1794945901961;
        Tue, 17 Nov 2026 12:05:01 -0800 (PST)
Received: from m2.. ([37.142.154.208])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-4a64b60940csm625528f8f.0.2026.11.17.12.04.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 12:05:01 -0800 (PST)
From: Michael Zaidman <michael.zaidman@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Raman Varabets <kernel-linux-20260610-80b7ab08@raman.v1.sg>,
	Germain Hebert <germain.hebert@ca.abb.com>,
	Christina Quast <contact@christina-quast.de>,
	Rio Liu <rio@r26.me>,
	Bruno Giacomazzi <brunoceg1@gmail.com>,
	linux-input@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michael Zaidman <michael.zaidman@gmail.com>,
	Maarten Brock <Maarten.Brock@sttls.nl>
Subject: [PATCH v4 00/16] HID: ft260: add UART and GPIO support, plus I2C fixes
Date: Tue, 17 Nov 2026 22:04:06 +0200
Message-ID: <20261117200423.19561-1-michael.zaidman@gmail.com>
X-Mailer: git-send-email 2.43.0
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

Mainline supports only the FT260's I2C bridge. This series adds the
UART/TTY interface and GPIO on top of it, and carries the I2C fixes
made alongside them [1].

Patch 1 is Christina Quast's v4 serial driver, ported to the current
I2C code. Patch 2 holds the fixes it needed on hardware and the fixes
for the review findings in the patch 1 code. As agreed with Jiri, the
series keeps the order in which the code was developed, and each patch
keeps its own author. So the UART work is split: patches 7 and 8 add
flow control and the modem pins after the GPIO and I2C patches.

The v1, v2 and v3 threads:
https://lore.kernel.org/linux-input/20260822213941.98882-1-michael.zaidman@gmail.com/T/#t
https://lore.kernel.org/linux-input/20261030223637.86907-1-michael.zaidman@gmail.com/T/#t
https://lore.kernel.org/linux-input/20261114230800.1344401-1-michael.zaidman@gmail.com/T/#t

Changes in v4:

All 5 issues Sashiko reported on v3 are fixed, and patch 8 changes
after Maarten Brock's question on it. The v4 note of each patch lists
its changes, with the same words as below. Patches 7, 9, 11 and 15
change only in the context lines that patches 2 and 8 changed. The
other patches are unchanged from v3.

Patch 2:
Fixes for the issues reported by Sashiko:
- Port marked as removed at unplug; port get, activate and the speed
  change refuse it, so an open that races with the unplug does not
  use the freed HID device.
- Port taken off the list only in ->destruct, so a new device does
  not get the index of a tty that is still open.
- FIFO reset after a failed output report, and .flush_buffer added,
  so tcdrain() and TCSETSW do not wait for data that is never sent.
- Probe fails with -ENOSPC when all tty indexes are in use, in place
  of a WARN_ON in tty_port_link_device().

Patch 3:
ft260_uart_change_speed() does not take port->lock here any more,
because patch 2 takes it for the whole function since v4.

Patch 8:
TIOCMGET does not fail while modem pins are in UART function. It
reports such a line as serial_core.h asks, and RTS or DTR under flow
control as active (Maarten Brock).

TIOCMSET ignores the line that flow control owns and sets the other
one, in place of -EINVAL.

The removed flag is now added and set by patch 2, in
ft260_uart_port_remove() before the hangup. This patch only checks it.

Patch 16:
The scoped_guard() list follows the patch 2 changes of v4:
ft260_uart_port_get() and ft260_uart_port_destroy() added,
ft260_remove() removed.

Fix for the issue reported by Sashiko:
- The i2c_exit and smbus_exit labels removed, so goto and guard are
  not mixed in one function.

Testing:

The kernel is built from hid/for-next 720806515cb6 with KASAN,
PROVE_LOCKING and DEBUG_ATOMIC_SLEEP. The driver is built as a module
from the last patch.

The pytest suite [2] passed: 198 tests passed and 22 were skipped,
with no KASAN or lockdep report. 5 of the skipped tests need fault
injection; they passed with a test-only build of the driver that adds
it. Without the patch 2 FIFO fix, the two new UART TX error tests
fail: the data stays queued, and the unbind waits for the TCSETSW
caller.

For the TN_189 workaround, a HW setup that resets the FT260 chip by
its RESETN pin ran 7,781 cycles. 101 of them hit the endpoint STALL,
and each of these recovered with one USB reset (details in patch 11).

Every patch builds with W=1 without warnings. checkpatch --strict
reports no errors. It warns once, in patch 15, for a quoted kernel log
line.

[1] https://github.com/MichaelZaidman/hid-ft260
[2] https://github.com/MichaelZaidman/hid-ft260/tree/main/tests

Christina Quast (1):
  HID: ft260: add serial driver

Michael Zaidman (15):
  HID: ft260: uart: fix serial driver
  HID: ft260: add GPIO support
  HID: ft260: i2c: reduce driver module loading time
  HID: ft260: fix sysfs store failure notice for big numbers
  HID: ft260: i2c: reduce bus-error message severity
  HID: ft260: uart: enable flow control
  HID: ft260: uart: add modem pins control via ioctl
  HID: ft260: group sysfs attrs per HID interface
  HID: ft260: i2c: fix large write transaction failure
  HID: ft260: workaround for TN_189 errata endpoint STALL after
    enumeration
  HID: ft260: i2c: abort in-flight transfers with STOP before reset
  HID: ft260: i2c: reject an I2C clock outside the supported range
  HID: ft260: i2c: fix i2c_reset sysfs store return value
  HID: ft260: i2c: recover a bus held by a slave
  HID: ft260: use lock guards

 drivers/hid/Kconfig     |   10 +-
 drivers/hid/hid-ft260.c | 2667 ++++++++++++++++++++++++++++++++++-----
 2 files changed, 2390 insertions(+), 287 deletions(-)


base-commit: 720806515cb6921ab05caaa6f470f7054b56385e
-- 
2.43.0

