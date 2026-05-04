Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6790526980F
	for <linux-serial@vger.kernel.org>; Mon,  4 May 2026 06:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777877441; cv=none; b=dQFJkg5u7hL6E1QuVXf2BoBr10An+4L55WKD4eHENPCh+es0FkhQk3moJEf/GnxkjrRA5Nios58mDwC3Njma1Ll8aA4N6TFEHugYf7AnNsjTjEv9PTgVZRnBu3GWt2xFihciI3VZrMQkKIgD/vW/rt6Fp/SKcD0lzsXkJvOylMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777877441; c=relaxed/simple;
	bh=8oCkiUNWGUjv8T4lNm2WKxxqF2Crlj0ofA034rWzhpg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eJcLgfLMwZsLUm8eDJ2YLv8kykDAKV7PJay6XBzVquPAC7fsX3f4u2GOYxHqvhbzMPhCnuTtTTeMtqQqXpnLPpwiqHKKOhh6car0XF4ZPTvi+HCbsWfMXm2E7NjMJYHDuZ1D0zFMzeqDpNyrVt84/3zJ2Q5vDNd1dcgDim1A5Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kii8qtsQ; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kii8qtsQ"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-364ff382b0bso2401907a91.2
        for <linux-serial@vger.kernel.org>; Sun, 03 May 2026 23:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777877440; x=1778482240; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dGJ477HuI1WPg+LRgbwSNS5n5sfdYQDEeJHoHa7Wyzs=;
        b=Kii8qtsQM5A2J5Gt/edz9P+f/0n5z6Dc/ATOAt9R0aDRYcHUgWQ4HDlKvEf40wslEp
         mcQW/FEi5ErRDyy/ca28ETJyDs6akXUzMvChZlpJ5Uf+xQg6q0j3Eb/Inns5TdJfXS/S
         a76tvmfjSByjnQA+UsDbKOAlk9xq6p5Zy55H7U1ouKD6X79YKZUYsniTkWc1NBP5cQzx
         Jb1x5n6VCnJV1FOamAPR4ds9Q+IAKaA1J1xLYbK8wG8kdhkpaue66d0+q0mVynTXKZsD
         tigH5Fs6FZsCVcT6H8SQ5+Qxce2vnTC63DBtpcYonA3OF8RBaOoWXh4/e8Utk5Q3oZKG
         sb5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777877440; x=1778482240;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dGJ477HuI1WPg+LRgbwSNS5n5sfdYQDEeJHoHa7Wyzs=;
        b=Gy28FXh3CrzKQ4nPHRzIk087EYESiN7leqjxc2YSq6mz157uqJfwmBQQ0yuxDFnQno
         xEj901E7zxNLsYvuIdtRLEC3/m5iXsgHoJXmMfZAtgw/S3VH2i8+slejBkoSrc1n1c1Q
         HRMiiupMExGZIHM0ppT+GDXg2SaCdr3l9zHHbhBIPRk30Qw+IjsUvcWNW1vLqDtyV8TX
         7ziqVbt8OrCvq+9oDdknHhXkHBPzjQsUrbCpn8rNuHMwcXrmpWY4MLQ/W6VzvvAiclPm
         cQZSjsnuGyzAkSCEcxUWEdDxCVn/UgEanZ39PikQxMnxRalFhC9ymb2o4phbMU0tQohC
         i8Tg==
X-Forwarded-Encrypted: i=1; AFNElJ9/+bh13pMEYbrxe3tGLtY8o2NF1ci3H0iI0gwQdQSQdQf84p2XSz9XYkZOqBWpOO34fULEsGjqLG15THY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yycz2vLFd7JOoIldghR61ifkSYENl+AM7JDBVFBKoluGluz5ZHj
	F08qAHx0I5XnanO6wmCDoaCKFMumgHPWMPbIMU9dIsPPRU0qcP2R+JmC
X-Gm-Gg: AeBDies8/NUDaOBkEc3TxUYZe4u0xKQPAS7p8btnii7byvVcmjD6dxrxdgsacJHvjk7
	cNE2Xw5vu1AB80gkcTanf8vv4e4vVmX7kvTRaUYOFfimhK/qfjL4+Vl1v4eUR1+zTMz2JeIURB8
	eG4X4hzN/EL5O0pdUZ4H7jJriQW8occu1DJ2iq3YGre62GYfTrgZCbEgLSX4JiwU50HUxKCx9D9
	sZg7i+4bSoeSdcXtrtcnn2n+AF2Y3DJmRXr1i/LLk2sDZApXZmmtE92xw2b7YukvnY56n/E1D/Q
	RQB2gt+1rsw4l1ai91qRAn4M5DGVHjXoRj8iYTJeERsqRi3NGzEDqXfR8ZipmXD2dU25YOxHMvl
	0oaI/k2pF92tS13rwm5RIn6hyo9s2tkTlYUS7yWIeQi3H0e+ABqPmihifKpncT72Yw0a62smv1S
	FlKRFaxEknbQirj111MhEIRoVT4HxNN91EMNhWtEHWtUxBqx9VV3NmFGrvKOZT8NB+6kAMIs2M
X-Received: by 2002:a17:90b:5808:b0:364:d994:da00 with SMTP id 98e67ed59e1d1-3650cf15bf5mr8689925a91.25.1777877439686;
        Sun, 03 May 2026 23:50:39 -0700 (PDT)
Received: from localhost.localdomain ([115.110.225.242])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-364f4859530sm3918712a91.10.2026.05.03.23.50.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 23:50:39 -0700 (PDT)
From: Shitalkumar Gandhi <shital.gandhi45@gmail.com>
X-Google-Original-From: Shitalkumar Gandhi <shitalkumar.gandhi@cambiumnetworks.com>
To: gregkh@linuxfoundation.org
Cc: Frank.Li@nxp.com,
	bhuvanchandra.dv@toradex.com,
	imx@lists.linux.dev,
	jirislaby@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	peng.fan@nxp.com,
	sherry.sun@nxp.com,
	shital.gandhi45@gmail.com,
	Shitalkumar Gandhi <shitalkumar.gandhi@cambiumnetworks.com>
Subject: Re: [PATCH] serial: fsl_lpuart: fix rx buffer and DMA map leaks in start_rx_dma
Date: Mon,  4 May 2026 12:19:41 +0530
Message-Id: <20260504064941.3460658-1-shitalkumar.gandhi@cambiumnetworks.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <2026050410-frozen-fondue-5476@gregkh>
References: <2026050410-frozen-fondue-5476@gregkh>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, May 04, 2026 at 08:24:20AM +0200, Greg Kroah-Hartman wrote:
> > Any update on this? It has Frank's Reviewed-by but I don't see
> > it queued in tty-next or tty-testing yet.
>
> What is "this"?  I see no context here :(

Sorry for the missing context. The patch is:

  serial: fsl_lpuart: fix rx buffer and DMA map leaks in start_rx_dma

Fixes three error paths in lpuart_start_rx_dma() that leak ring->buf
and the DMA mapping. Sent April 20, Frank Li gave Reviewed-by on
April 21.

Lore: https://lore.kernel.org/linux-serial/20260420135903.2062024-1-shitalkumar.gandhi@cambiumnetworks.com/

Happy to resend with Frank's Reviewed-by added if that helps.

Thanks,
Shital
