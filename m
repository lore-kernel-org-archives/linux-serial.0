Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A334B0E32
	for <linux-serial@vger.kernel.org>; Tue, 13 Oct 2026 06:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791873440; cv=none; b=IMPVthXn+0P0xs/XtRdXBxx/XJ9jtcJMMj/tORbBZzhQXsGpPA2MrkSJBxg8mw7Upr0Jgi/ceYcVB/LbnGhkESoBn9OvLpi4g4n3iN3Gh7GugK7Wd67QKaciXNeCQbli+uYqTqxiPVpkzz39noUNrnqXxfyiNaaIQx/ocwPMReM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791873440; c=relaxed/simple;
	bh=1/TE8jVp1mgIX3w95Qd56lz15ABuBS61Pi2gCb8R3Ds=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fSkzpgfzDtygGO/gln9YJSMvL6xOkZu6c0pLsMjEg6jfPz8EW53Gge1OXNQvOJBJqdDEJl9ibsvd3NqKGVkJNMxZku/EenS5YukTv7qDUe95Z6ZPI4nxQ25WRTTDr4xizcSdX7mKwSDIvo+w7SLcNPNIP8suN0I+4PpiAkiN/tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g+2o1y3/; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g+2o1y3/"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a16aaf2067so30867355e9.0
        for <linux-serial@vger.kernel.org>; Mon, 12 Oct 2026 23:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791873438; x=1792478238; darn=vger.kernel.org;
        h=content-type:mime-version:content-transfer-encoding:message-id:date
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1/TE8jVp1mgIX3w95Qd56lz15ABuBS61Pi2gCb8R3Ds=;
        b=g+2o1y3/Qb+VFogNhJTLfABPi3jNMKJ8xDV3ARSQIFY1DuLSfvLolbZ1FGtslUHRYj
         KUrE7CDXlybFIxxhdzDdOJotwrstec6NDm0xEe5LYkgZYByhGBX8uGJ8JMMgDINDFRbB
         4lkGuMmS/8jnVzEw4OE88EZFWY8VWxK4qmeRlsOkimvxVfyMI0lkAVLgkqGMcm/KsLZ5
         2wFB9jowc5OUk/mzxXfpuZT592XIasSP2ZUXFilXM7UAGDc3hfmywsF70JqggBBCLHeM
         qy6g/BDhtAoPDhNI+Kv9NBiDtVVvlvOPcT357LCftrYJwiBP5qYHY+lxWfbOpITnXhU4
         Yn2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791873438; x=1792478238;
        h=content-type:mime-version:content-transfer-encoding:message-id:date
         :references:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1/TE8jVp1mgIX3w95Qd56lz15ABuBS61Pi2gCb8R3Ds=;
        b=QYXSDaOnhHmuFUeG33llN9ooCC+bUkke+UxIiqpi5GYmh2zDw1jy6v/b2136ITaWaT
         hscdXb9TNmr2MWf6IlLLwzK6SrxMrIs/K2zw0xuugicJNvxrsnkPVPTvmIYV88eo3Fau
         2ENYunc0QXbQZDlHbn4eyKxtvIWeyoO3Zal/NHxaG8FTQZ4P9az/Fyvia1gb6ivI8ctm
         ctBTbWFviap6WENFysEAX2XG11Vj+/YES2124M8TIZipdtpREEzRiqWRs1JaAddedsgB
         +PFVLRUu+19Ax8T2B0rR0N99PeeWH8oL/k0qhAHpxfikPGT/AjX9GRzBkndcdp9YK8Gb
         vDug==
X-Forwarded-Encrypted: i=1; AKwUvBz8ABWkwVvBsha26kp0LtdQmCneklEfqMTgXdfqMngfbeOTdmyLfnwmNXVHStHsu1AWW+avSlqc2y9PRZ8=@vger.kernel.org
X-Gm-Message-State: AFq9FYL9p86IkodIL+t1Zo/XM869VzNhETE0j/13LTfO8APTRWXCMGlk
	15/nJ/FUk/lWH6pUyr5rUGP2EFotvxKEGPm5CXrRRIDP8yL60xC5ZzlF
X-Gm-Gg: AYBFou1GD06rPJDL9HbHd/FpZV9Rh3dIPZlBcNikQvWlF6fwmOE+ZKvuwsZ8k0jiAvj
	lr/KpvhJMv4Q06vCqfVA5v80pIzI5TS7O0wB3fwr7PEmt2LjjH0tO445D/hgrgotxZumXQqccFH
	+umujk4DnUXvHwIf25YPArJ9pi9roqfHUeLIYnzVsdsDGRjrmSYy2y4stBqUxhLmCz3SeA+mESk
	sPL6AhgNC0kz99LyZx3KBIZF2YYA5uIDIo08LxkbcYEanDhzBuBvJY6FnBu2T6aTPa3NinA3Ul6
	Ujofh7E2KDsKwdiPX5RerM/EpjeJfa9BSQaGLrCsJ9h+a/+6+aMZkWZ77eCEG8iSapujl7sjQJU
	WOXQRzX1Idzw3TgpcCV6oKmgUNmZms3TwTxLgS8aePcB3vU8hV95JQfXkgMxIm2+eM3W0ky93St
	3Isr4vZiQFigSbhhhumoHupayWmDrKaKr0hdkE5OMt6LXyh601aU82A1DXZYdGBD+9ZGlWGpuOg
	zpPex5Jxg/GBCX12qEkPxL9V/HCznNwFDzxUul05jENk5aYlxVeKSNaDg==
X-Received: by 2002:a05:600c:348f:b0:49c:fc6e:8caf with SMTP id 5b1f17b1804b1-4a18e4c05e5mr229014865e9.19.1791873437754;
        Mon, 12 Oct 2026 23:37:17 -0700 (PDT)
Received: from [127.0.1.1] (ip-024-215.users.dtel.ru. [91.210.24.215])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a19471edd5sm434795675e9.11.2026.10.12.23.37.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 23:37:17 -0700 (PDT)
From: Fil Dunsky <filipp.dunsky@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Linus Walleij <linusw@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Russell King <linux@armlinux.org.uk>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Drew Fustini <fustini@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 Jason Li <jason.li@cortina-access.com>,
 Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v6 00/10] ARM: Add support for Cortina Systems CS75xx and
 Securifi Almond+
In-Reply-To: <971b67a9-7e3a-4fde-a8a1-e5a78f8d6436@kernel.org>
References: <20261013-b4-cs75xx-v6-0-37e8f3969b7c@gmail.com>
 <971b67a9-7e3a-4fde-a8a1-e5a78f8d6436@kernel.org>
Date: Tue, 13 Oct 2026 09:37:14 +0300
Message-ID: <179187343453.3124451.12229499654368455627@gmail.com>
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="fixed"

On 13/10/2026 08:18, Krzysztof Kozlowski wrote:
> Way too many versions of huge patchsets. I already counted 4 today.

Sorry about that, my mistake. I will leave this series alone for at
least 48 hours now and collect all comments before the next version.

Thanks,
Fil

