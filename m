Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794760607;
	b=HdQqzSf7px6y8lYWmDRCKttWvSOP6rBZ8tqr8VjTqPLX84LGUWy7r2zp3H5DK8w+W83g
	 Z0Y+rbVB0sWbR5Ux3BXhUlVCLh2+P4tNCTqAbay5L5TBC1OzYrmUi5FVaOIJrW7EEs2Gp
	 XKQ+SObRbEG5O5xu5Ed8ld5pqArEK+uqevFwfaaAzITtpv93gMLn4Nh+5kss5bfhZoJlA
	 mueSfwHvObt3rGYZOL0g0SmnpOgC3DDHHQPHNtdMf9+XMrmqYz60DEUJFiLyaZBK0EmeQ
	 YGO1ONnbd3VGLJ627OO28FPFY3ZLmfgiFkelrTvC0hrdxyttOOR+Y8EaMyMvNt3Gk8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794760607;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=KKb+d+ZaGGmKBJKMDQFVdGoOMQlb/jSR52em0tpyyQI=;
	b=EO5P7F4k9IGrBsXrYClUyDTIT2pNcEdJUq4+e4xwcNk6sQAGr0jWZKQQT1/VsKo2Ej4t
	 8LYIthPP7TzCopjzEVSofXhXcY1AAr3qdPUhHnYLXgcwCb0bQ7hES0WPE+b7LtEtWEPma
	 KxcCFWpr0k9x6ZJ4UatqB7/wIUn20qJj3sOidVoPD24FP6BAWhDJkhqnyBkbt4kCECRGW
	 S9UgPtCUE8CKCUiuZOeDVWW1Sx8ekQIQlouH2bthwkTKOe6qMdk+Z/j/Ua+JibDNVsMMG
	 OUe2zhkHwouBmO526640WqAlYCWBDPRvp2jtFJCxuAeAuF7asDb4tA90TAGi7SsxSqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZtMIdJJy;
	arc=none smtp.remote-ip=74.125.82.177
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF85606A31D
	for <linux-serial@vger.kernel.org>; Sun, 15 Nov 2026 16:36:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CAF85606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZtMIdJJy
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-36f8cdd30beso3678392eec.1
        for <linux-serial@vger.kernel.org>; Sun, 15 Nov 2026 08:36:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794760606; x=1795365406; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KKb+d+ZaGGmKBJKMDQFVdGoOMQlb/jSR52em0tpyyQI=;
        b=ZtMIdJJyVm+mFG2Qv9z6k7f12/DNmDmsO0hrkDl1xmBBO+AfmzBkd5ZSYmcEIkOCS9
         fFoMEhd5Lt+ReBKdDfshMrAZQH2Vu1R85HZpdyaWA34Q6VuyFVLPiLkPVgY7adFrN53I
         Aq3RUp96k9/fGYLrPki2HnYNNx7CL9OzSVlNp+pDZMqVnOlbqc8IpiljpLqTf119Km3P
         Ye3uwvS3cJC2oUx+GVMOp8D566vDFK7qyUCYNQvWwwslOwq830yZmC8l7M+kJa9yEHgw
         hi3GKiJjoCobPiWvh3wokw36T/++/z+XzA991y22AF9OJoIfuNhzAaygoW084ro9TPkf
         buNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794760606; x=1795365406;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KKb+d+ZaGGmKBJKMDQFVdGoOMQlb/jSR52em0tpyyQI=;
        b=wwU8GqRdzP/A1+hz2GPJBz5GHCNXImSN/uWbSGtd4u1LyN9TO/O9Y+RnQz/oSVVi0n
         +mJ1Q6zouE6OMZS/5b6hQ/PqkhFS4BLiOn5OSafEOrHErn4PS0IlGBZ2dISwuvwfuT1X
         5HSrZZZLQC7SF8bj7CbBMCgUfM7MJ3dkYE/qfZNiCd8LviPQQ9+2ILf+Q2QeBlE/fQj2
         KSP4pcRvUyGoBQjqi9Q7xi3XD3l/CDgyTunGKg/nhKXqp0gW68bjMatuBrWjcjv82XlP
         bC/Tbl7niJu4YcF2GrnBlO56gxhsOuOAgkwGWhzuuNck3p2DyPXjysv162VTGBPI2xZD
         g9nA==
X-Gm-Message-State: APuU4Z80TqlYdXlVRZGL37o23xDQ7FNrDhjxwph7mV25AfyK88z4NAuf
	tXMxHpzfCEivyJxMq4wE+mbPaer7E4mEC4ckmx3Lqhf5h7O6kfHHMv9C
X-Gm-Gg: AYBFou39hwxAUGj711ArLug+bfQubXM69LAnCJnICTsUbPXeZeKPt6bqav/TWKGADhc
	vITTE2Ftsi3TdNCN0UYFVcT47uRTumEqGx3r4YgqYUY617+zDiQW8J0pBOnGBLuVLoKusECLzxW
	Dp7h9Jy293k7SRUrw5E/7ETNljbiKKeKpOA+Y8BktvO3cDOn6wapfT6VDBi62oaqGF+aiS0RBVj
	gJYj46OegBiz3yCTsv6+KNEDkxlr1dAS9wggA5PIpkEDp8+hAq4vz3Br0+OJVLoEW3tJAh/Zt8t
	6cMm/h8oVA9Y2xhislip4IBm3ds53m5H1yLhOzARgSPtwEuHjJjXXAx14HzJ1vrvjUDQOZ0xSoW
	iKg67P3WH7Ppg9P/6F0X/knnNFb0gF+iy6WEQYdLbbW1HsRaD/Vb4ObuwxSqoucDMyY6ELW0Lo3
	PkgBykibEnLO1fsjtGCwrSI+4SdoNAtVuyyccY93erbYSdwM3fPWaSrEhI0gepxsmt4IFnvlJqQ
	fU1p6Q3wXnJEd+qIHlD72Cwrlqf51f7dEnpvOpXwa0XA4POdyUsoB24DMPeDGP2vVGo6K1eeSCf
	cf+y/QkcKSMzUrUoVUByS3M0FUO9Win+7bfuvpQrBgM6ZMSC4ZFNaIEa6ANIBJn88fPh
X-Received: by 2002:a05:7301:1c18:b0:375:b560:a323 with SMTP id 5a478bee46e88-3796365f033mr7898443eec.1.1794760605833;
        Sun, 15 Nov 2026 08:36:45 -0800 (PST)
Received: from youngkk-vm.localdomain (67.216.200.102.16clouds.com. [67.216.200.102])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-379553316f2sm27292732eec.9.2026.11.15.08.36.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 08:36:45 -0800 (PST)
From: Cheng Yongkang <teel4res@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [BUG] tty: TCIOFF/TCION under TCOOFF lose the character on pty and vt
Date: Sun, 15 Nov 2026 08:36:38 -0800
Message-Id: <20261115163638.226086-1-teel4res@gmail.com>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Greg, Jiri,

I hit a small corner case in tty_send_xchar(). It only happens on a
pty or the vt console after output was suspended with TCOOFF, so it
may not be worth fixing.

Under TCOOFF, tcflow(TCIOFF) and tcflow(TCION) still send the STOP or
START character on most ttys. serial_core UARTs do it through
->send_xchar(). Drivers without ->send_xchar() go through
->write(): __start_tty() does nothing while tco_stopped is set, but
usb-serial, cdc-acm and u_serial do not check the stopped state in
->write(), so the character still goes out.

pty_write() and the vt console's write return 0 while the tty is
stopped, though. tty_send_xchar() ignores that and returns 0, so on a
pty or vt the call reports success but the character is never sent,
not even after TCOON.

On v7.3, with TCOOFF in effect, TCIOFF and TCION returned 0 on all of
these. 8250, ftdi_sio, cdc-acm and u_serial delivered the character
before TCOON. pty and vt delivered nothing, before or after TCOON.
The code is unchanged in next-20261113.

tty_send_xchar() could return an error such as -EIO when the write
took no byte. Since usb-serial and u_serial also return 0 when their
FIFO is full, that should probably be limited to the case where the
tty is stopped. I can send a patch if you want one.

Thanks,
Cheng Yongkang
