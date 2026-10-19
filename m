Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792440405;
	b=kMWBF+Ubqb+NOmVXENYS8nCrmNM1rXyGB+SqGLJAUt9meytyE1fe6xbHW7Ise6+4ciFS
	 Op7Ecye47M77L5yFxqqdkqeLbo1DOD4D2UQ1+Twbt3cjrC/OYSwSOXVorTORhvCzvdI4Y
	 1XaJM4ARs5LbaHA1WkGDrzlJJShkofS0Z24mTFvCTCDFIKtAp95U4Sf82+NYqL8jt9WYQ
	 Blh9Mj0Sy3vp3azA1adX/R066pnCTObWhQVVwimBg1cXeQCZf71ruyTzLIm8NI2G1cmLg
	 whookx67ioBOCvdQKcsY62KA2c57ZBxeAzFao0dK0UlcnIeoz/vQp2f5QKE2uEfRpaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792440405;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=frV23sLLMWKOP7RPngYOwxGFd6AYAuODJoFiW6amCkw=;
	b=SVF6suihvZEXTSbWSAGPsxFPWqKhv6DrCJE3ERXrlrSRLZ2iiMNnyQBZjHxcFCRoA03B
	 yi+Q3/55vXmlZUGLENKTSaMjh7T9KSyJq75yDhLCBYL7CfBhwPWCL46uYF7JzQwHSPSXr
	 P7F0vlvEnTGoPmXIsn16TVQDeIQv7vTnZgUlkZM7FiDKF5wfpVl+PFPm7z436IbPJz6sI
	 HpMOIGi7zFNs/OnF6B0z2B5b99iFTpATZ9kZ/1jbk9jINuFQ+XgjyhpcYfz5RDZnafylF
	 8Z7vXnoOw8CmjTh+YtA0oeKgU6YzhKrZrjaoa/f2LZjmYo0eAKEFcV8BKpjgRJMsUvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PBaHncv2;
	arc=none smtp.remote-ip=209.85.221.170
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E120C606A319
	for <linux-serial@vger.kernel.org>; Mon, 19 Oct 2026 20:06:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E120C606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PBaHncv2
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-5e6b5794d26so33087e0c.1
        for <linux-serial@vger.kernel.org>; Mon, 19 Oct 2026 13:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792440404; x=1793045204; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=frV23sLLMWKOP7RPngYOwxGFd6AYAuODJoFiW6amCkw=;
        b=PBaHncv2C/SQ69nWsr/zLDVNh2lK7XdICLF19nDfb8YMaBogX/aWKO6bRkOGm3yhKi
         dvmTVqoMJCV2PiYdJ6FjgJ92EwklarYmNbQk7bf9v0zLMuWs+iDY2rs6f23qhYkse5W1
         6juCkIIhUkFnbA++Se09SNCDag/5VqCsnQiWfjwvGb6RnpbsqkX4ZKdQBlcBYJFGv5u6
         l//nCG2acpj1EMI3UmNz8IJadekxE2EJOPXTzSOA4lFQRFOYmWdXbTbmXSYBy3Z1M27j
         9RmT1jR698t8jFqII4Uc+wLDHX5suF3hP/eXcIexOTR11DDOFyBS/pnnvnKgXqDR5Ivt
         3FAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792440404; x=1793045204;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=frV23sLLMWKOP7RPngYOwxGFd6AYAuODJoFiW6amCkw=;
        b=SuNwfB/kP9A3py6zSswzM6gXkYSDFJ9lkwjGRzPf/HYFx9PqjlXraC9BKeKiH8nlJ/
         G7bQLQkqT0zKZ9UGRdZKMAOI7O8CrmY26XlvkIPpOuoTv9zDtPYS/sbq1Fva41VG801/
         IifMYM8W5Lih59jP+VwWQAU/T5j06EelgNZYXQQxdgDG8XK/K91P6cyTIlTIJFP/RWwV
         l11ZsXk6UE2fFdY9cVHTMfMFVrDtmPBTlb5U1sZ64bkG1owjS+tiUQMhTe0vpqQB6I67
         VnD7O6wn2XzO7V6O/J89UduBrpVa9fRtHpHSOC6n2ex4pgL2SfbdqOfK/iXfop8GAdk8
         fUCw==
X-Gm-Message-State: AFq9FYIB7eaROrPybEYVJUXqrcGuegQ9XujFfBZEvx4iaWOCwjFeO8VB
	HL0mZJa4d11hQ3LN+IIVfqaJkEf7CQfQuovoPdBJ+1zxCDPxnFDB7772OYe9YhqLfryMRQ==
X-Gm-Gg: AYBFou2odLQS5ART6OAVksbPsm5SFh+nvxU2yEqVM8d5YdM6ILWuyOZUWLDMJJD3BM+
	iWweBTkJvDihv+XKscHPxp+CatxGbm1N64jrs6oXA/Mhb2VKbmDV+DguIa1FnMPtF8ctn9eWwWR
	s3c6xTTvgsLKvZ7RTlRCxvBquT7X4g4HLc8pgmT9Xv8V1S+ly+HHy72LXEHXdYbsnJGTDtaszLM
	W1fc3IhfmITrROBZj1V2t5vtSZIxmr5f3Nu9azuXIUrJ5rx6u36qkJTHWHI67HmrNyj3G3WSgc8
	wwZ+KvD7QVbMbgMHhed+0EPRXM/Mv3Z8xOc9NXR1CBNSHPiRqQ2dDdvu/kY4CdpAwJ6psYwLblf
	Mi85tie4X7FEa3ZbQEwvrl2bgN+u+UtJZg4oEqhJuAeGSEd5HHKN90WON8M4BPBaTU7TyoTpb5a
	CVx+ePCVhBeLpfq7n4YGhBeAJ5I3FOYEMuWehgwZFu6gbJuHVnVwuRzJ9xovffHnYKvWV7gt5/R
	TWlZbodeEJyLgG5faFcWGnBap9MoANQxx62txnjLxo84y10Buhy48KXL6HE8fAGndVr7izd6Str
	VhO6O9w=
X-Received: by 2002:a05:6122:1297:b0:5ea:d2d7:37e4 with SMTP id 71dfb90a1353d-5eadcbbef0emr35405e0c.5.1792440403756;
        Mon, 19 Oct 2026 13:06:43 -0700 (PDT)
Received: from MaquinaLab.. ([179.179.244.163])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ea9b4776b5sm10451611e0c.3.2026.10.19.13.06.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 13:06:43 -0700 (PDT)
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
	Andre Przywara <andre.przywara@arm.com>,
	Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Enzo Adriano <enzo.adriano.code@gmail.com>
Subject: [PATCH v2 0/4] serial: 8250_dw: Allwinner A733 UART support
Date: Mon, 19 Oct 2026 17:06:09 -0300
Message-ID: <cover.1792439398.git.vinicius.eduardo.pedrosa@gmail.com>
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

While testing the A733 UART, the console stopped taking interrupts at
the first termios change from userspace. Termios changes during console
output could also corrupt characters even when the baud rate did not
change.

Patch 1 is an independent fix for the DesignWare 8250 divisor path.
When DLF is detected, dw8250_setup_port() can replace the BUSY-safe
divisor hook with one that does not provide that protection. If the LCR
write is then dropped while the UART is busy, the retry path can try to
restore IER while DLAB is still selected, causing the value to be
written to DLH instead of IER.

Patch 2 takes Andre's suggestion to only accept a DLF readback when it
is a contiguous 2^n - 1 mask. On the A733, offset 0xc0 is the RS485
control register and reads back 0x19f; Andre observed 0x9f on the A523.

Patches 3 and 4 add the A733 compatible and select SKIP_SET_RATE for
it. Stopping the UART clock from set_termios while TX is active corrupts
output on this board. Skipping redundant reclocking in general was tried
in e5d6bd25f93d and reverted by 7dfae6cbadc1 after regressions on Bay
Trail and Cherry Trail, so the change stays specific to the A733.

Tested on a Radxa Cubie A7Z (PCB V1.11, 1 GiB) on top of tty-next
1184f87e2790e8af9be3116f608d2e86b4792d7d, using local A733 DT and
clock changes that are not part of this series.

With patch 1 alone and the generic fallback, repeated termios changes
no longer stalled the console and hardware IER remained equal to
up->ier, while the false DLF was still detected (dlf_size=9).

With the complete series and the A733 compatible, three clean runs of
both the CLOCAL and CSTOPB stress tests completed without corrupted
output. dlf_size remained 0 and offset 0xc0 remained 0 after the tests.
dlf_size and up->ier were read through a temporary debugfs test patch
which is not part of this series.

I do not have hardware with a real DLF, or Bay Trail/Cherry Trail, to
test those paths.

Changes in v2:
- rework patch 1 around a dwlib divisor helper and preserve an existing
  set_divisor hook, following Ilpo's review
- add a separate check for contiguous DLF readback, following Andre's
  suggestion
- drop the A733-specific NO_DLF quirk
- keep the generic DT fallback
- keep only SKIP_SET_RATE in the A733 platform data
- retain Conor's Acked-by on the binding
- rebase and retest on tty-next 1184f87e2790

Link to v1:
https://lore.kernel.org/all/20261005172538.398522-1-vinicius.eduardo.pedrosa@gmail.com/

Vinicius Pedrosa (4):
  serial: 8250_dw: Keep the BUSY-safe divisor hook when DLF is present
  serial: 8250_dw: Only accept a contiguous DLF readback
  dt-bindings: serial: snps-dw-apb-uart: Add Allwinner A733
  serial: 8250_dw: Add Allwinner A733 UART

 .../bindings/serial/snps-dw-apb-uart.yaml     |  1 +
 drivers/tty/serial/8250/8250_dw.c             |  3 +++
 drivers/tty/serial/8250/8250_dwlib.c          | 22 ++++++++++++++++---
 drivers/tty/serial/8250/8250_dwlib.h          |  1 +
 4 files changed, 24 insertions(+), 3 deletions(-)


base-commit: 1184f87e2790e8af9be3116f608d2e86b4792d7d
