Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com [209.85.208.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940863E009B
	for <linux-serial@vger.kernel.org>; Mon, 10 Aug 2026 13:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786367201; cv=none; b=KebHEwJZGopfwfOv5itRs4By1XoTJihO1KRD6EWYH00ES9riuxRRB1LpdMvM42IrLZI1bIczzUN5TqZ8pwxe6pe10FEO182k8DEetHKrCR76OabiG6fGTCzqhzGE8zWR1SMI/4gENVRkKT+pO5lo5BrPvGPJkh/0txe+XDb3+c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786367201; c=relaxed/simple;
	bh=tQTTUSW7eUWfh15MDV5ZX7e6q64R5S4/Oqee01xSP2s=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=FnpAn8FpRB3FHUi/sKlPI2pfZUGyMNNiImyoBZQm9AlVxI7XynpATm1RKrdFsLvVxEYoffz0sXY9Wxo4gnIbLZwdVSazEcWJJRQWhuhzmmgP3k+PlYeoI5I1CBu6wLfiOVxDYTjcJYXUK+kXTwEUn0jNBOI6fmJ3R9/PsLbtcwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mkmkl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NmXPU0La; arc=none smtp.client-ip=209.85.208.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mkmkl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NmXPU0La"
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-39f6a02edacso5160691fa.2
        for <linux-serial@vger.kernel.org>; Mon, 10 Aug 2026 06:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786367197; x=1786971997; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:mime-version:date:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=95XcyuahfruBLeOEab+HwcmrCQNnVz9pT3RpyBKiDUY=;
        b=NmXPU0Lad6lCZaJrpbVNx4xxpalTRW9the7mhqbHsFDRHuHK6nBEQv6dMwA6n6eL1L
         ZeHJ3eQn38VcC2byGebImq0oUGI2gaRhkR8fasIKCrKQMiVkI2C9gVz4pXI/yJL+Rn3D
         CL8JnnlsmwBOtpwMKdpU0qT4RimephFMhr6vGVfQqCdusiHeC8pd3Z3oekbICbLLo8Xm
         yXOU2JytQo8wHPr83dauMMSPbZgynw+i3r9oNaQZs3fGYdBUxOK03ld/wFYpBMJNOHy9
         A1XRevjWUN3x30ZQm75CDBc1eycZReSM3iZD9CgXouzXjXLv/sikCorAngdJluUP0BUI
         AIsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786367197; x=1786971997;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:mime-version:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=95XcyuahfruBLeOEab+HwcmrCQNnVz9pT3RpyBKiDUY=;
        b=NkTRgaSsTmsHXiPx+BSWjzJsS4GB+WCJ+3cnXTiSFpbgDo8zrGxDMLzLTVmBBVxD9h
         7e7bEGDyXNws4OkMJ5NFRbSzj7ju9j4lNyoXNxLSoJXKOt6QoXaaTqZp4HzjaDKViUnR
         d7+RKVTrX96OYwAB9EhZaH8OP69Lznuw/vSpI8YNVYBY4uLVM6MvjqAc1+UGnfHlvxLd
         IwBmJ3HFsY3oSlH9AIoiGZp6nJauUtEqmEXD7EpJFICCOLUXDexKP3KQQvOrImoCIHjh
         7PMjQj70bZ3UbdQYaizQ8j21Zyhel7hmxr816PLDfcwPT0jLLTCk0BAYnJYAGXyne9S6
         22gg==
X-Forwarded-Encrypted: i=1; AHgh+RqTBw6vgGa7kSXKS7ptzIZLF2pg4OTZ4VmG7Ruju385cgkNkWqmwUcBVzljNcYbQIdq+SOSITLMjJVKmW4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiXZpq8+jQplXL4ZVJLJ/k2nSdUlvCbuN3KnX4j0+0TZmg2w+p
	zUtzaBXcbrl3W1JFOpBmshEYCj+KsckABrqpCVrgHlzbOn87ETFDsJqy/7QNey1qdkqCaGCIU0K
	zqw==
X-Received: from ljjo19.prod.google.com ([2002:a2e:9b53:0:b0:39b:50cf:4a26])
 (user=mkmkl job=prod-delivery.src-stubby-dispatcher) by 2002:a05:651c:54e:b0:39a:fa7c:b152
 with SMTP id 38308e7fff4ca-39fe5648f40mr20830661fa.4.1786367196243; Mon, 10
 Aug 2026 06:06:36 -0700 (PDT)
Date: Mon, 10 Aug 2026 13:06:33 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.654.g21b8a5bc05-goog
Message-ID: <20260810130635.1166626-1-mkmkl@google.com>
Subject: [PATCH v1 0/2] pinctrl / 8250_dw: Allow drivers to keep init pinctrl
 state until first open
From: "=?UTF-8?q?Micha=C5=82=20Karda=C5=9B?=" <mkmkl@google.com>
To: Linus Walleij <linusw@kernel.org>, 
	"=?UTF-8?q?Ilpo=20J=C3=A4rvinen?=" <ilpo.jarvinen@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Douglas Anderson <dianders@chromium.org>, Vic Huang <vich@google.com>, linux-gpio@vger.kernel.org, 
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"=?UTF-8?q?Micha=C5=82=20Karda=C5=9B?=" <mkmkl@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

During device probe, pinctrl_bind_pins() binds pins to their "init" state
if specified in Device Tree. When probe finishes, pinctrl_init_done()
automatically transitions the pins from "init" to "default" state.

While this auto-transition works well for devices that are immediately
active upon driver binding, certain peripherals (such as power-sequenced
devices connected over UART, SPI, or other buses) remain unpowered until
userspace explicitly opens the device node or attaches a protocol driver.

On board designs where the connected peripheral is kept unpowered during
boot, auto-selecting "default" pin states (where signals such as TXD or
RTS may be driven high or pulled up) can cause parasitic back-powering
into the unpowered peripheral through its ESD protection diodes.

To address this without requiring new Device Tree binding names, this
series extends the existing "init" pinctrl state mechanism (introduced
in commit ef0eebc05130 ("drivers/pinctrl: Add the concept of an "init"
state")):

1. Patch 1 (pinctrl core):
   Adds pinctrl_keep_init_state(dev). When called during probe,
   pinctrl_init_done() opts out of the automatic "init" -> "default"
   transition, allowing the driver to keep pins in the safe "init" state
   upon probe completion. Updates Documentation/driver-api/pin-control.rst.
   Board configurations that do not define an "init" state are completely
   unaffected.

2. Patch 2 (8250_dw serial driver):
   Updates 8250_dw so that when an "init" state is defined for the port,
   the driver calls pinctrl_keep_init_state() and preserves the "init"
   state until the port is first opened via dw8250_do_pm(), at which point
   it transitions to "default" state and resumes normal operation.

Testing:
- Built and verified with CONFIG_PINCTRL=3Dy and CONFIG_PINCTRL=3Dn on
  upstream tree.
- Verified zero checkpatch warnings (`checkpatch.pl --strict`).
- Note: Functional hardware testing was performed on a downstream kernel
  tree where the physical back-powering issue was reproduced and verified
  fixed. The underlying UART pinctrl lifecycle issue and core logic apply
  identically to upstream.

Micha=C5=82 Karda=C5=9B (2):
  pinctrl: core: Allow drivers to keep "init" pinctrl state after probe
  tty: serial: 8250_dw: Keep init pinctrl state until first open

 Documentation/driver-api/pin-control.rst | 10 ++++++----
 drivers/pinctrl/core.c                   | 20 ++++++++++++++++++++
 drivers/tty/serial/8250/8250_dw.c        | 13 ++++++++++++-
 include/linux/pinctrl/consumer.h         |  6 ++++++
 include/linux/pinctrl/devinfo.h          |  2 ++
 5 files changed, 46 insertions(+), 5 deletions(-)

--=20
2.55.0.654.g21b8a5bc05-goog

