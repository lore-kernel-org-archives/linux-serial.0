Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794862689;
	b=wSStpBvriEHulQ1S4ZzOg/cOQVbaiC7oyw0LVmLaElLu1Of48+N4gwsNmlmvCSzxn8HL
	 DpYiVP91PYGwr+/2BxL7tBoZTM6XW+yVLK/4deK236+4LadzU54yLE6aY5NoKasPvK/sH
	 4qJaQZFnFMx36/0v5VcxNyMlVXIKN8fqCfX14B02AjJm6z1asJxvHla4db4lSaRmbSVy0
	 80X1PerDi2upiyD4yqu6F7E+hhdpkW01WBs3V0j64VhCnYHu8luSM7iHGqLniDbGVQ/Hu
	 B7Zzr/GriQpT2TszpEuiLTWezpN8SxzxejU34NNbsQziQyD3q8Vri2oIydoD1LIT61A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794862689;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Vr8LxlwRGl/SVKMwZ1OihzYbqfOG5qsqLHZawnVcpJg=;
	b=zjOgpPR5XpRjo2aShfJA+EoI76ZrteaWEK1b1u/PBoSfrE2CdxarlpNS0csS2qq7mBI/
	 c03Q41F1clTAhmG3IV/jTeH/IU4PiBxGd3pwSHC+SBTXXk/ZvCVWdv0CkieeJKYSdnG96
	 8mI5qQo/NnqjoOza5DIxG5dnMqtF46nxqCRPo5JersO7+159J1BgEwIgVzZHz7zh+vfWp
	 cU/i57ux8pbqRdu9sK5s1PrhSEtziw6C2SDi9ESvgQ5NcdzTsK+1ds9mnmU4kV7zYcKeG
	 OS2BtZv3Dkg3dl5ugzHvL4boNRJSm/XktQue+qLheivUaK6rywfZf8PecRTyLI96dXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="xhfpB4p/";
	arc=none smtp.remote-ip=209.85.221.45
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5608A606A329
	for <linux-serial@vger.kernel.org>; Mon, 16 Nov 2026 20:58:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5608A606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xhfpB4p/
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-4a34ffd3e39so184936f8f.0
        for <linux-serial@vger.kernel.org>; Mon, 16 Nov 2026 12:58:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794862688; x=1795467488; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Vr8LxlwRGl/SVKMwZ1OihzYbqfOG5qsqLHZawnVcpJg=;
        b=xhfpB4p/FLz4tPvQ4XDyzPJZhYbKdby9eMFjsG4ed6t2AZa3F7CPzOfipZSOTimeWe
         BcDpq6gokbNTxIQ9l4fnGfjfFt29zj3RD0h6lHh+vJ1bX552MblcNRz+J8927R5ZmjeF
         iKpG54++B5Tp/HqvgFsBZU/VNWRkvyP+JLjtw/G/z314VyLXrSJcxdPsDrmr/1FXdlvg
         DIdw/tMELU7KsErDToyfosjf4meSG+J1RxQySHwdKjVeXk503qOmotvoqiMa9MiZS+ON
         XrDB4pfb8+ohnHUAfF24YjeIm1F8rDtjJQd8EA/+blfE98B4+XJy/aO9+RNJN9y3qjfU
         QxfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794862688; x=1795467488;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Vr8LxlwRGl/SVKMwZ1OihzYbqfOG5qsqLHZawnVcpJg=;
        b=JIwy8j/Jt7pSMwoaJl38OX3ZGbe4Pen2tG6VEtBvu2hlIwtOrfykuSzcD1oL5S2ZBE
         sffHa+nJU4ysDPqca/cHgeYUpQpI12DK3AIzr9UqE5OHlc/Si4nIwCeJUJqfi8ILpKLt
         77xXQJDHnxVPcR99KuX7h890nW4mDXs6624MwhAk2Vl8IcOYicrYS62m6Tj0feBwGEmL
         co9gRsmyjCTKHcqlaBM7UXJHWDgHLt33OH1UrG0IV1frMsvFoMrFsTnZnzC6jXyvK4UY
         7mhe8uos+9+x+MWSkNpHFojF2DmQx6OhKMVRa3NgKO/myTS1dUzvZ329gDaMvudOaS73
         g8qw==
X-Forwarded-Encrypted: i=1; AL+hErEKETJHwiy9cTlI6f+Dc0VS9WqHRdygAU09XzTjTFtGoWms0rMPX8b0msrbmG98VuYov64wr93JgZRvXHY=@vger.kernel.org
X-Gm-Message-State: APuU4Z8vZE2oZ5B9MSbyQnZWejswiHYuAk+gKds85yRU9VrI0A5CdlgM
	gsjz+q4fneluckSPmzLYuGdUEaiGYOmLs5VOejlzvqglwKr4E4LbbiqT
X-Gm-Gg: AYBFou0XwXpZaKM0nc+PYogzDnbeDDrdaUN27niBsd/GNPMIoemWjTHt67Wco1vUa6X
	1okNvC2hHP8Bx1rmFhvLmQc+LOmi7NuyMTgZsrUZRKXUMkjpCTmbqqn3PUYk/iVUDul7sKiYxau
	UP1PZ2NqMBlYLclWiJczdFVAd7npWQut5cd3q1YwMTYEIy5jnbnJUIA0FLqtBIiSKo8wka44yvo
	Gs5SCSZm7nvo7eZXbrEZJGtor7lq+o+I9uM4XDG9FD7GjmBbT5tTNGd2MkgackNVCi4XEIx3LK2
	XYyA/tz1oX7b69yS64UGgGPKW5h0Tw6+mG6CSibPYv2BhPjmnBlHOkCHttC59YGnhiaosP8oQ0T
	tp/HW6AvdZ4yooVGAGlrAYKI6PXQkiNeGDQsDW1fX1jJlHam7G0MKz7nbIjOngioiqOYxxAYAGL
	IkXGmKCJKHQsOa/rhGiIO7YlowJkxnaCuDLeMNHlc0HR59OYchjnUDZltX5wLvEmSr3m0WHd7H1
	DHr0tNxp5cpR6qYPyLB1RVZr9aF09llNK2qDPHuLv1xz0+bnwBGbnLNPlpyh61QwbQoCd+UCbe3
	1qLgSk7TowMTzowa/4VXE2OlpMo=
X-Received: by 2002:a05:600c:a00d:b0:4bb:693e:4c8e with SMTP id 5b1f17b1804b1-4bb693e4d5dmr149922355e9.21.1794862687584;
        Mon, 16 Nov 2026 12:58:07 -0800 (PST)
Received: from m2.. ([37.142.154.59])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4bb78418853sm20499255e9.8.2026.11.16.12.58.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 12:58:06 -0800 (PST)
From: Michael Zaidman <michael.zaidman@gmail.com>
To: Maarten Brock <Maarten.Brock@sttls.nl>
Cc: Michael Zaidman <michael.zaidman@gmail.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
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
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 08/16] HID: ft260: uart: add modem pins control via ioctl
Date: Mon, 16 Nov 2026 22:57:50 +0200
Message-ID: <20261116205752.18800-1-michael.zaidman@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <GV2PR05MB119417E6491EEDE07003C52D6837C2@GV2PR05MB11941.eurprd05.prod.outlook.com>
References: <GV2PR05MB119417E6491EEDE07003C52D6837C2@GV2PR05MB11941.eurprd05.prod.outlook.com>
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

Hi Maarten,

On Mon, 16 Nov 2026 11:47:46 +0000, Maarten Brock wrote:
> > TIOCMGET and TIOCMSET work only while the modem pins are GPIOs, and
> > return -EINVAL otherwise.
>
> Without checking if it is possible at all, I am wondering why it would be an
> invalid operation to TIOCMGET the modem pin states when they are not
> GPIOs.

Thanks for catching this. There is no good reason for TIOCMGET to
fail there. The -EINVAL came from the Sashiko review of v1. In v1
both ioctls returned 0 when the pins were not GPIOs, so TIOCMGET
reported every line as inactive. v2 changed that to -EINVAL, which
fixed the wrong answer but made TIOCMGET fail.

The chip does the RTS/CTS and DTR/DSR flow control in hardware, and
no HID report gives the level of these pins while they are in UART
function. Two things I checked on hardware:

- For a pin in UART function, the GPIO report (0xB0) reads 0. With
  RTS/CTS flow control, the CTS bit stayed 0 while the peer toggled
  RTS. With DTR/DSR flow control, the DSR bit did the same.
- With flow control on and no data, the chip drives RTS (or DTR)
  active. I read this on the peer.

For v4 I am changing TIOCMGET so that it does not fail. Lines whose
pins are GPIOs are read from the chip, as now. A line in UART
function is reported as the get_mctrl() comment in serial_core.h
asks: CTS, DSR and DCD active, RI not active. RTS (or DTR) under
flow control is reported active, as measured.

TIOCMSET does not return -EINVAL any more either. It ignores RTS
while RTS/CTS flow control owns the pin, and DTR while DTR/DSR flow
control owns it, and it sets the other line. So DTR can be used
together with CRTSCTS.

Thanks,
Michael
