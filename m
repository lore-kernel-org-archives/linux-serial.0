Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793336341;
	b=ww8Yi5krqkBoyrp4OA4Oul1hSVD4vMsJjKDqobrEoLR7o+selun/9xw9mpSCOPOMX4t9
	 ukz86zvSGLWibpzVRtuZHNyIysm+yiQ8+F2oNR8iQkGdlJ0nMpLl8gJx1VkayPGctu/pG
	 AwVOR79fdUg9Tc3feF81vbOiqQibgiwQdDLjtnaU8T9bAZSE7bmDbG+VM8byE+HkPetcB
	 cZl7Ne0uCWmqWP/pcaqMiqOtmXrC6YUXRTh1cRJa1CXZ95/tM9YQfc+8g74d3yVJfLOLs
	 UobRjmUiP0YKFC5pPUDwwCPmrypGUQzAGJB+y3Bl0PjTouYuzmVKpXzK/sY3d2AIsfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793336341;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=uNwpVqDjROJGkszbWCt3hcbKnoADzVRF7vj0i9CDHdk=;
	b=uDgVrMp7sPCVCqKR8alMg+TI6DPeRfEo2M99QU6SUXVSr/6OHYjDZ8LFn6PT6tiMFxso
	 bPcAyiFX7AbQCI1Y7p47WhXSqtwB4/r6LAa8mxq1iWy3EzH9Q68YyugoqPlcOGwtFd8jE
	 pIcwExyQJegD2hAWK52CF4quGe9WFw/BOLBolA1EZyN+zsfZhq1Hv6M17wk94XT+y2D8p
	 XwGHE63g4jvM4VYzCP8QwrRbL28oRWBJfe561hU3uUaG4r/JyYxq37Q0TR6yocKLxkrWx
	 aigbpA8uOAr4aoBsspVGi20QpIO+G1dB2srJaYjM8VNnpzQwPxldKnLuuz1L28KZrsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VvQmqhyj;
	arc=none smtp.remote-ip=74.125.82.50
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5774606A31E
	for <linux-serial@vger.kernel.org>; Fri, 30 Oct 2026 04:59:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C5774606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VvQmqhyj
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-156cbe59622so179028c88.0
        for <linux-serial@vger.kernel.org>; Thu, 29 Oct 2026 21:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793336340; x=1793941140; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=uNwpVqDjROJGkszbWCt3hcbKnoADzVRF7vj0i9CDHdk=;
        b=VvQmqhyjoEfPElLInA0okpFRj8JJVpHzoDW7YpvlerOqYiY38kQKJgoIhcWf02E3vl
         +gmwDB7w2YZ+mUDUNLSYg6IlRdw+WxDPyiX6Y0EtxHtQeblklMDsnBl0mM/b9qH7cZfq
         X5qD+dgjfhZhWOil8lhpKmBCt9G/+qd9JIzKUY1YulKatrn3nQnJwIeqH8GFAq9b2ERy
         G0R7cvaldz3pSckXRcQYYWu/ww6vGToCTb/rVG67QkL/TohkYGUSkenl1VvTzmsn+lWg
         Fq2wx2T6Cl6hOdgHfC4M5sjrvHxK9+SFE0wPTF2pIO2FlURVj9m3GQVDWlv1Vxyp4/hU
         NmaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793336340; x=1793941140;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uNwpVqDjROJGkszbWCt3hcbKnoADzVRF7vj0i9CDHdk=;
        b=PMs1wEjt09DlYq7PQgsaopOAGHF5t5PJy+qxLspsLanwvhgW/Mlrn6yZgeb+f3JVGo
         ht2Rb13yWdyEWoqbe0SYgizqNWvv0hD037xnXbMxe87WsbIHwb+FIOaPFjiXzIofL/yB
         kmUhuVwgFDhuTiCcFY4VIgm8fjM/0biTdwzQ0U4/7nTN7bes1E9MIZxsW8f4MI2fTIE8
         WBeOCiSyvREqFfAcZsRvXndg8Yrd9kHQRaz9jFDRtl4ocRc7pVB3aB+7wMA4oR+Fh4j4
         6jn8EniTALDZs+/0OCeFlFG1f5acMVV+RrvB4rVm3IFi2myVqr0jtCZ8C244bPQjhZsR
         qG4w==
X-Forwarded-Encrypted: i=1; AKwUvBx6yg6WwkU2hg/fpazK+A3KPdEExf/FNry5u/a6O8zlrx5v0Zu245yumHtK97FTspZlR68qLezJzHht8LI=@vger.kernel.org
X-Gm-Message-State: AFq9FYJGHxnEAIradR/lLN6bigAO7lyVfudbjs9Dq82skbomBqSvVEP0
	rcTVdjluCwfEQ8e/u0LzxqiLbhjIx6koCIqFDY6ELW0/0QlcudPYmp6Y
X-Gm-Gg: AYBFou27v1lg3YOTXDXULbO5o9gwg3l/8eA7vEozIRppOcEc0UDqnyMBHDJb5CF3/so
	HThNeAFF6uJ9uKQQxL+3FPvIApJjGY+9Hex14Jz/fkyp1BJtajNohtIGmSrP4DZ5dxGtfaJVPjz
	o3N6H+G9OpJ6PolmxK5RWE6zNNcNa9d5my7UDgWz9BvEu7JKUKaKPGzcq7b1RmSd28q2wMBSr+8
	HfTf1CjQcQqwb1hxYM1elZ8+5+uL5ICnVJ9BdlUaMTN4P4HW5uWM4pfZit/L2Ar7P4M8Fp8aCqj
	s3NEWREyftY0iwKSz3lYyoziSGHZW7mlW1sTLg2SaGKSyRrTu4GsCiml3WeErva/knb9kc7zfq1
	+0qzpvKpB9KtTeeP7gyet6J8pM5YI/ODKOTIxf/yNSoXy+YPESlkRiJpUdU+vfUfwa03HFC83BV
	GHWAh+EFjgQn6ufQk0+26mC/no/TIWzyQsdB6kKBUFprL8WDacz5hfLMxTRSuz4kjYd2j10sVhG
	zGZKa9IRWk+dBIKp8/LxiV998EKzKDtKWL1Ksj0mN9LYs375Q17T6/qreZgrJjsVp7+hX4sofr0
	6zG1goqPNzA1cGmmm7bMGDIy/BgHJXBPpxD5ZKuJUCWxFkcbj33URD1kM4SIDyXQHlg=
X-Received: by 2002:a05:7022:3a03:b0:155:7721:3a4c with SMTP id a92af1059eb24-1ac5f18175fmr1949054c88.35.1793336339593;
        Thu, 29 Oct 2026 21:58:59 -0700 (PDT)
Received: from osman.mioffice.cn ([43.224.245.178])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac18458e07sm3433152c88.8.2026.10.29.21.58.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 21:58:59 -0700 (PDT)
From: Zhan Xusheng <zhanxusheng1024@gmail.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: dmitry.torokhov@gmail.com,
	mathieu.poirier@linaro.org,
	linux-serial@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhanxusheng@xiaomi.com
Subject: [PATCH v4 0/2] tty: sysrq: fix the reset sequence kept per input device
Date: Fri, 30 Oct 2026 12:58:52 +0800
Message-ID: <20261030045854.153556-1-zhanxusheng1024@gmail.com>
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

From: Zhan Xusheng <zhanxusheng@xiaomi.com>

v3 1/2 was wrong and is dropped.  It stopped a truncated parse from being
cached, but the parse still reached sysrq_detect_reset_sequence() in the
same call and could complete a reset.  param_array() publishes every
intermediate sequence with a fresh version, so no reader-side check can
tell them from the final one; 1/2 now parses the whole parameter in one
callback and replaces it under a seqlock.  2/2 is the same fix adapted to
the new 1/2, and depends on it.

Both fix bugs from the same 2013 commit and apply to every stable tree,
but 1/2 is over the 100-line limit in stable-kernel-rules.rst, so I left
the stable tags out.  The two have to go together.

Tested in QEMU with a uinput keyboard, one device per scenario so the
per-device state survives the parameter writes:

                                           before       after
  hold the full sequence                   reboots      reboots
  hold one key of two                      no           no
  hold the old sequence after a rewrite    no           no
  0x3b,0x3c                                reboots      reboots
  hold the new sequence after a rewrite    no           reboots
  release a stale key, then hold the new   no           reboots
  press key 1 while the write is mid-way   reboots      no

The last row needs a 500 ms delay to widen the window, in
sysrq_reset_seq_param_set() before the series and inside the seqlock
section after it.  Without 2/2's timer_delete() the armed reset survives
the replacement and fires.  Rejected input is the same apart from the
two cases listed in 1/2, and reset_seq reads back the same.

Changes in v4:
 - Dropped v3 1/2 and replaced it with the seqlock patch (Sashiko flagged
   the window on v3 1/2).
 - Reject KEY_RESERVED in the parameter instead of storing it.
 - Dropped the stable tags.
 - Tested in QEMU rather than by inspection only.

Changes in v3:
 - Added a first patch so that a truncated parse no longer sticks
   (Sashiko).
 - Added Fixes: to both patches.

Changes in v2:
 - Retitled from "Input:" to "tty: sysrq:" (Greg Kroah-Hartman).
 - Delete keyreset_timer, otherwise an already armed reset survives the
   reparse (Sashiko).

v3: https://lore.kernel.org/all/20261021022007.1717207-1-zhanxusheng1024@gmail.com/
v2: https://lore.kernel.org/all/20261016070636.2559899-1-zhanxusheng@xiaomi.com/
v1: https://lore.kernel.org/all/20261016032732.2328852-1-zhanxusheng@xiaomi.com/

Zhan Xusheng (2):
  tty: sysrq: don't expose a partially written reset_seq
  tty: sysrq: reset the per-device key state when reparsing reset_seq

 drivers/tty/sysrq.c | 142 +++++++++++++++++++++++++++++++++-----------
 1 file changed, 107 insertions(+), 35 deletions(-)


base-commit: c339f4010dea8b0d754f84ace70cd1b089878ef8
-- 
2.43.0

