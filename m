Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7534C3B19A9
	for <linux-serial@vger.kernel.org>; Thu,  6 Aug 2026 15:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786030941; cv=none; b=qE99/obgOip4fii0kDGqXqK9GK5e1IpJrGzA1i5fjXqIrwwnBDgcOkPFpw2hjBMrT0em85q3XHRgx/AO+LgndXWIGtG0ZKbXNobT5P+HTDidf5LPrIhXnTAi8xHsb9QftrE9BZ7OFLfQu1TwbJMawt/W1zIuElgduofWlaYTf+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786030941; c=relaxed/simple;
	bh=XE0tO9Jyx3J+gbaHw0TRRmHf2eQpcZ6fIKV1x2X0LPI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ThE8BfkfFAnhpwuq1Qaz/ZRO2AGACJerAvOLpszMiADMiaZ+xVjAMen7ExMATU1SYD7Rk/6BqZ4d7vhwFaphEPYfgeoMhZCG4FWyd5JvJNdo7JhxAXuagDVhIzCDrPKPRbNGzvcum3vCe7Ojjj6XpNq23CkidWZ4sOLFp1Tzu7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sairon.cz; spf=pass smtp.mailfrom=sairon.cz; dkim=pass (2048-bit key) header.d=sairon.cz header.i=@sairon.cz header.b=eRKlN/Bk; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sairon.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sairon.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sairon.cz header.i=@sairon.cz header.b="eRKlN/Bk"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-47f84023916so2133115f8f.3
        for <linux-serial@vger.kernel.org>; Thu, 06 Aug 2026 08:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sairon.cz; s=google; t=1786030937; x=1786635737; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0ThRgCkb2CvqeWusoxmgVEmTWKcE4SQ/2tb3yLJFfIQ=;
        b=eRKlN/Bk5pASHQGAgg6guZpkqN5IgCY5Ut6eDIl2C/EvTgJnLD20aAYRdftfPuzjWi
         ha7c0mgtd1FxICHL13g/Hfy7OdxsmWKeuV9ibdFS0sxSTE6QZZvdtUqM0e0QSpaWgJwf
         2S9S7wbNh/5kau9UAxNLsXTtWNWsxRw4qcgqc2bhAKtxcZ6b/ix9Rqq7Jn0mE16XVZR2
         2I3+0OXmEwz1YMaKHEzMPRx/0luTXPxpsafq6IYn6TufSW1KD0tbT6Wt4p0LgkWT68h5
         KXMVpu8kPbRqeg3MS3PTt8OeAUu5FZf1KCBtn6r2JQCuJ32dT9FV4PhxoLbcXzNX8Xsf
         XHdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786030937; x=1786635737;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0ThRgCkb2CvqeWusoxmgVEmTWKcE4SQ/2tb3yLJFfIQ=;
        b=bL7jwMcu2k2Du6QwuRIb/HP+NPOIS3UBjYwqBZXdRTLZuYw3/490/GGPqnzebLCvny
         sC1JFwHJ5zHJepWeS5qqGn6XqznipV4MVG9IAd7iAiMlJB4IuyHMYQZeGJHxNXjDCFpD
         fenn1v9WZKf7DPQxjD91nIi8XTh36kcNa5dzSTcDXHPuXg9TIYuLBU/0eBvyr1A6DlqI
         2VJZa9aOiZvapSZhZOMMlML90FMa6y+X2JXNUTT9Oc/kGuogg+YpVZkGDVOKAHzAIGlz
         tmHTi6NzY7uaLVAOnTRoIGbBAFPrmcgdsfTDcANXPuE+/DMtGiNwjrx2Nalln26DDYUH
         AxEA==
X-Forwarded-Encrypted: i=1; AHgh+RqHGYcH1BoadhEuDIG+GfekbMyH7J9HZ1FxnobNpifveVjq2x3W60/Oj+Z9hFAPQ+uVIyk+8KhB9qIRIrY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRn/9+WyMwt0wWddmxmQHCWzs8y9z506vb5QPNkkO0Gg20bDKV
	xI5TDg8aIwmGfM0Ctt0dDH6AoXk+u5v4A/Zi5Yr7g0AX7R5fIk6/jHfR3DO4RODVETA=
X-Gm-Gg: AR+sD107ZKNhXm5VDP1OPSib7wULqUzmMDvcoVKpWAgHFIABM+jcAy0RDkupu+HjkFf
	3gEMuC0aUsOhOa6orUp0ohZ1rCODoo6ou/9P4IgtHHuL2pk03wmP0hmpMrH8IWcoc85ySdvbKBJ
	ASeFhfar3sPCKgPKaQJgflaQdvjkr4zzBhuLX8C/+tNvCtxdW3q46POjtnGiIfCxb5m9Zb/XbKA
	BaEtcPFP6h/aHh2kGD2bJOcdkwrTx4jfQNDLy2YMxYfUk65PlR5T+g3neAPB/9a7/4WkRI01oja
	7hTPE4L6HSooVU6QdnFMvzKObAzKLe3+9OlGDeFIAMH+MQpqmn9+0HkcEd8Vqa5O5v7IOQwYAUc
	8pdQled7chsIKnXv1l/CANqpLhHjPR0WdEADjPVvr8E4+cKNvbk/5w18K/xJw3NgKUawc2Fp9Ib
	4+YEru8dN3KU4VqI4xEzoMO7PRq5xXRJPvbxm3xa6xI441zUbV9xiFhQdk1js4rBvexwggxONOm
	s/ng0hR+kSDL5zRyf78yhRj3RtEmiwu9FshDq79JkXCba2uFB7W78yb9+x/LVsS7uoOzzsl/MFk
	Vw==
X-Received: by 2002:a05:6000:2988:20b0:47f:eb80:ff42 with SMTP id ffacd0b85a97d-47fec4e2975mr22971101f8f.4.1786030936542;
        Thu, 06 Aug 2026 08:42:16 -0700 (PDT)
Received: from krabice.lan (ip-89-103-66-201.bb.vodafone.cz. [89.103.66.201])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47ff7b25c01sm6605380f8f.29.2026.08.06.08.42.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 08:42:15 -0700 (PDT)
From: =?UTF-8?q?Jan=20=C4=8Cerm=C3=A1k?= <sairon@sairon.cz>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	florian.fainelli@broadcom.com,
	rjui@broadcom.com,
	sbranden@broadcom.com
Cc: =?UTF-8?q?Jan=20=C4=8Cerm=C3=A1k?= <sairon@sairon.cz>,
	phil@raspberrypi.com,
	stefan@agner.ch,
	bcm-kernel-feedback-list@broadcom.com,
	linux-serial@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/1] Implement BCM2835 AUX RTS/CTS auto flow control
Date: Thu,  6 Aug 2026 17:42:03 +0200
Message-ID: <cover.1786030659.git.sairon@sairon.cz>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi everyone,

this is my attempt at adding hardware flow control to the BCM2835 AUX UART
driver. The hardware supports it and the driver source has always noted
that, but it was never implemented.

The driving factor for this contribution was that this peripheral is used
on Raspberry Pi as the alternative muxable UART for the BCM43455 Bluetooth
chip, should the user decide to use the "full" PL011 UART on the pin
header. But this always led to some compromises, as the mini UART wasn't as
robust as PL011, mainly because of the missing flow control. We use it for
Home Assistant Yellow, which is essentially a carrier board for CM4/CM5,
and with the recent update of the (downstream) Linux kernel to 6.18, the
Bluetooth started to be significantly flaky and failing to initialize on
boot [1]. Diagnostics showed that these failures are caused by RX buffer
overruns during the initialization, which were probably always present, but
some other changes apparently added up to greater instability of the
driver, leading to overrun errors in approximately 40% of boots when using
the mini UART for the Bluetooth link at 230400 baud.

I've originally tested this patch applied in the downstream rpi-6.18.y
branch, using the mini UART for Bluetooth, which improved stability of the
Bluetooth initialization greatly and allowed clean initialization even when
bumping the baud rate to 1.5M. Then I applied this patch to latest mainline
and did a couple of simulations forcing the UART to throttle by filling the
LDISC buffer, with an FTDI adapter connected on the other side of the line.

Note that for this to come into effect, the uart-has-rtscts property needs
to be present in the DTS. No in-tree device tree sets it on uart1 - the
property only appears on the PL011 nodes (uart0 on bcm2711, uarta on
bcm2712) used for the Bluetooth link. Raspberry Pi has the CTS and RTS
lines hooked up and muxable though, so it can be easily enabled when
wanted.

At this point, the implementation seems to be fully working in my tests,
but there may be some subtle issues I don't see, as I'm not fully familiar
with the subsystem. I used an LLM extensively during the implementation (as
I properly disclose with the Assisted-by tag) though at this point I hope
the patch is far from a one-shot vibe-coded mess, but please review
carefully.

Regards,
Jan

[1] https://github.com/home-assistant/operating-system/issues/4898

Jan Čermák (1):
  serial: 8250_bcm2835aux: Add support for RTS/CTS auto flow control

 drivers/tty/serial/8250/8250_bcm2835aux.c | 160 +++++++++++++++++++++-
 1 file changed, 156 insertions(+), 4 deletions(-)


base-commit: 0d839570765118029aa8bf4a95444c6a11aacf85
-- 
2.55.0

