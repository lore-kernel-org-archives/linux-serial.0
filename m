Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4C33D6498
	for <linux-serial@vger.kernel.org>; Mon, 10 Aug 2026 15:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786375606; cv=none; b=ioAWTf0sQzGjUUffaxRmMnHl/xIjvByUzLRtGIF0skucOC4TfQrQsP2fk2X5kCvrmeJ3ZROntL5LISPI8SbwMTUl211cGlRH4lcl0e2V7SE8Hgw00esvcp/2K94+TK7kM4LArecczfXdn/wnGy2OprxY1yfT8rhCdOUkgUS+Mas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786375606; c=relaxed/simple;
	bh=tCe5sL9UJxPqIv1FmE8Uu6kylYA2Gof1PUEPD3/FReA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=tnzagLOkZg80M4IHEx8NAygqnSjuwYCRXmgALLSAvgBEZ6qRQL5LH09dlv1uqulXm2YsEqK7rcvF6eAsJSW8s5twdqVP2ckRYJRgqTmAl2/4vvVvtViDigdvQuXAoAmWTjgXc1UcdEnf/GXyc7FV3FVaEH28IEgUpIk32iPhh+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XsO1ZqQ0; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XsO1ZqQ0"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-47fecbb7000so997840f8f.2
        for <linux-serial@vger.kernel.org>; Mon, 10 Aug 2026 08:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786375603; x=1786980403; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Y8SFe5FskJGVS8OAXxFiwxeNb2xSdeCITuphL9WXOk0=;
        b=XsO1ZqQ01hJCbr+9DuzkItlyE7F4zw7DLWm9IjV05LZAulW9JUvHbU7hNWkOip/OUE
         1MW2l1nlBLqFuClDJqWosdM+Zr8uTpdQR9905V83kFL9x7tPSdUmgifiLkNe0ZzhfEAs
         fhEojdbA+n7dt4b7WeRnbNxSrqqn6nM7SkekzHp749Rv0BFnfFv2WwRmuom3gg2NF3r0
         uQ7DbznbdDUkDwX5WndmA/4wwRY+Klx74pzyXDnNNCUn9yxT+V7YCBaWBKesx3YR1+Yd
         tROxCJbDyomibP3enc8ZyMmtP9uzajHUvSLzojfifdRmU2vMA0+2mX4qqcotAFwXdMJZ
         aJ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786375603; x=1786980403;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Y8SFe5FskJGVS8OAXxFiwxeNb2xSdeCITuphL9WXOk0=;
        b=tJIEiPM955FmqpO+6rUZ2Pcl/8DHWQNxwijngsx573jg5Zh2L5q+LKRSnGv6Swpz8t
         FxWzohExofgMlVGTHJjiD4mTm0mIy4JlZfq8kMQiNd96YVOXv/IQqH81i5OmJHm9cbjJ
         pF99fEd0zdf9KvQAUvoR2Pkmck/C02Ilu4+9UY3CcLI6EdkyVGt2Bvp5jr2XTYhp2z5D
         znqlVuJBfex8vkdvJjZsLW+9Mv/y/x7lkMi6OQAy1vcSyjMyXWk/mRCC6bTOeeDgVTj4
         szpm7GI7aO3eWVFo58vaOhVp3VMLRUK6HjsvF2Q5Jaappe38Fj3FIIGdwZ0JaXZXplXp
         rZlw==
X-Forwarded-Encrypted: i=1; AHgh+RrOoi3M4bUzDNQVujI8frgZwWUnX5DY/IV4zjYO7Inl0h9DUH4AMrs5RUnYcMBmCMlznAZ1pMm/AKayBks=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZDaurrTgHEk86olrRvfRIFaghVeFGcfA+K974sthjCdjarwUO
	kPC3BZPE27ptHOJq4/a8YGmFBSMxO79yhdZOw89+JaKT984c7aHszoEO
X-Gm-Gg: AR+sD12stPSz9u/0mqNq155EgyZQ9BUCpwieAcEJCfYUx9H7S5SiCH+zdJoTLVkuQDW
	6J/a5mu0gMUqdaVbULiSu3fY+s16IXbXsZm/mlH8W9e+EwIknoow9yJ5ntgeoKXhG4I8r8QS0wx
	W7fozLyNgvPqVq/2rVJ84+CC/TDhVgYUyBgXh/Lg+syyfr+he1rh/aPYmyk6b5loGjdnc411nlF
	P6zlJqbULjwxyVASw60TJirtgF3jND8mWeBSVpAMiPLv8mW+LrFxLlkqW9Fr+uluv80/MAqnKjB
	UUZov2MEgZ2unLy1pp66DmhghF12IJU7H+EfEm+fnszLZ9N0/IiaPTDPT5k6vN1HROwuZ9ojRE8
	9wble6R6VmoQrOfVVpufbLsYI7Ty4TU3CZK/44G7Xz+hXmSO9GnFy5jumO+ml0AL8yLgC/eTFi9
	GVUMndfmpk/vpsp9S0fRPRoWEZKyiiatcUeWhFcHxtZPK1KEFzSfCw8IYENJ+GZ13qeEh5pfnC0
	f0ulJ9X4KoPdDP9+vCrniI5jbJZoljoNmYo3bZpyoEHbkP6
X-Received: by 2002:a5d:6a8a:0:b0:47f:81af:1a3b with SMTP id ffacd0b85a97d-48130eea595mr23302846f8f.22.1786375603323;
        Mon, 10 Aug 2026 08:26:43 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (host-87-20-3-207.retail.telecomitalia.it. [87.20.3.207])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-480021e8cd0sm34952469f8f.17.2026.08.10.08.26.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 08:26:42 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Benjamin Larsson <benjamin.larsson@genexis.eu>,
	Christian Marangi <ansuelsmth@gmail.com>,
	John Ogness <john.ogness@linutronix.de>,
	Jacques Nilo <jnilo@free.fr>,
	Randy Dunlap <rdunlap@infradead.org>,
	Rong Zhang <rongrong@oss.cipunited.com>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Gerhard Engleder <eg@keba.com>,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Huacai Chen <chenhuacai@kernel.org>,
	Haowei Zheng <zhenghaowei@loongson.cn>,
	Lubomir Rintel <lkundrak@v3.sk>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH v5 0/3] serial: 8250: Add AN7581 UART support
Date: Mon, 10 Aug 2026 17:26:32 +0200
Message-ID: <20260810152636.658955-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a new version of [1] to support UART driver for
Airoha SoC.

One additional function was needed serial8250_get_baud_rate()
for the driver to work correctly for baud rate calculation.

While at it also try to clarify a long standing issue with
new UART driver when adding new ids for uart_config[].

[1] https://lore.kernel.org/all/20250209210241.2622309-1-benjamin.larsson@genexis.eu/

Changes v5:
- Improve 8250 YAML schema with enum
- Keep alphabetical order for YAML schema

Changes v4:
- Add Review tag
- Add errno and types header
- Drop redundant () from comment
- Use define for get_divisor

Changes v3:
- Address review from ai bot
- Add all missing kernel headers
- Improve divisor calculation
- Fix wrong uart config table
- Simplify divisor table handling

Changes v2:
- Drop intermediate patch
- Use .set_divisor OPs
- Use div_u64 instead of / 40 for 32 bit overflow
- Drop dedicated match table and use compatible for type

Changes compared to [1]:
- Fix all formal error
- Use better compatible names
- Drop unneeded header
- Drop usage of irq (it's filled by the generic function)
- General code cleanup and reorg
- Split to patch and add the UAPI map patch

Benjamin Larsson (1):
  dt-bindings: serial: 8250: Add Airoha compatibles

Christian Marangi (2):
  dt-bindings: serial: 8250: Reorganize compatible to single enum
  serial: 8250: Add Airoha SoC UART and HSUART support

 .../devicetree/bindings/serial/8250.yaml      |  32 +--
 drivers/tty/serial/8250/8250.h                |   6 +
 drivers/tty/serial/8250/8250_airoha.c         | 187 ++++++++++++++++++
 drivers/tty/serial/8250/8250_port.c           |  16 ++
 drivers/tty/serial/8250/Kconfig               |  11 ++
 drivers/tty/serial/8250/Makefile              |   1 +
 6 files changed, 240 insertions(+), 13 deletions(-)
 create mode 100644 drivers/tty/serial/8250/8250_airoha.c

-- 
2.53.0

