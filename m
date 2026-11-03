Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793722280;
	b=QUKhXLntdBnQZSX940mFM8mKnproHGWYQd8oUQOS2m26GtUbKJ1qmwo21e7W/bIYSstm
	 IWdkGAv5cH4lm0zzUNdOYKuj0Lp2zHQDlH5rdZXDvLIFy5M/3bT4QEmlceV+ODqj5DrMa
	 eTjc9axWF4B05i+L6o3HpcX7oHTsdKnwWvnL4pSVn+yffQLl4Kbv71Ir5iAS7pHA9UBg3
	 uogYqJQbF77XRtkXAvN2+PLkIokog/FVuryL/MSASfnKyb3UIlTyQNnNU9RUC78SelC1M
	 sUBoDVLkO3zhM3R+bLxgb/6cNAqwk+MztlpJZaO3sZiyBJtD0gjuHqRMoWe8Hd2rUIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793722280;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=S9QmmCvTtJG0FWP5byFcRaRFelUpQGR0S1hSw8HKBvw=;
	b=GgfQVI0r0x/KEdGLx/nqJE/gKSchm9lZwPNY+hb3/2it2WcCn84nWtbajqU7NwlwzmCH
	 q4mdtPuscBMtfGwb+EPqtNsfhvFGc/Fl7u0IECA5nFCqS5pi/tzlDzoSJWTswDFeq8kSn
	 DLrtnUibhhmfLWgMQmyUBakEstQIc8S54dWiaMT26DLvwuqehFGkW3th0R9aFg8HA/Ect
	 qOMoa+Uw8xY+wA5GRo6owrFJQm4CyV6tTzdZ1d2xuW7+qMxigwosjQ+Rbmr7MZDUHQtrn
	 T9vtZw0hqmWvugHWaCxBp7jsYihI7nATGaPc7R+DgM2Pt85EgrmCqSDkSi+ALmOOZ8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=QbejB7A8;
	arc=none smtp.remote-ip=209.85.160.51
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DDEF6082BE5
	for <linux-serial@vger.kernel.org>; Tue,  3 Nov 2026 16:11:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7DDEF6082BE5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=QbejB7A8
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-4a76f63b243so711530fac.0
        for <linux-serial@vger.kernel.org>; Tue, 03 Nov 2026 08:11:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1793722279; x=1794327079; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=S9QmmCvTtJG0FWP5byFcRaRFelUpQGR0S1hSw8HKBvw=;
        b=QbejB7A8kljkTCasdabAllkMvn5P3rHgp1Di4wEbgiOZl6txqhxl+t4Z2fR4bYJEvr
         6hCOTWWcKLvbWZcReJ+ULtfCHUJn4+ihh249PhfIYTHbU0g2vbQp2+P11dUniXHy2wNS
         LfntX1auU/e8DpZi2UDdP7FJJxHmLiOFAWFi0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793722279; x=1794327079;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S9QmmCvTtJG0FWP5byFcRaRFelUpQGR0S1hSw8HKBvw=;
        b=N3ZjZe+zmv5OVgR1K1gaOzVtc5hbwCpg57E2bk1pSWNzvVVkqXjJrklZSwxshnui+i
         pK8/RJxAc+nUcOiIUffSs0unlotGa2B1E5xQmSkotwsGzxwvilNvbaoeiN/UdADsLjps
         9cnX6claWyudgvyopwJgk9SfuhBC7Wp9jgXjjaoL9pZAGZdTfCvmvFfAa3OJpoiOUZdB
         lHAb3ZLnLDB0X/aVBhWzXum/RlwG9PE31P7+RdqZrob2Pp7IVFCExEnDUCnsgUvnyD0Z
         PJxPlbQsDjV1AktSL3/yfu5z+PalI7iK739l7Ha2PsOL1wOBjVYhMNNMP8pvVePf8gij
         +sRg==
X-Forwarded-Encrypted: i=1; AKwUvBwIIOky884uTDJpLTh9oXBCLbZMWgkjI4ARJ6pUvRtIFevMLHzLwM+gOK5Uv/KceDlVVeObGKN5hrJYJBg=@vger.kernel.org
X-Gm-Message-State: APuU4Z8mmsdB+w5WGrzeSQGxrc+tpORWpyzf+g1xX5h7fTZUPbQPH+2o
	wEDVBOHquLRT8zBr6mWsHTFbsIq4v9VpiPBi+5GwquPop6ckeBg4PA8OSfWxUq/+SA==
X-Gm-Gg: AYBFou0gBwlj4QcDpNcNnTkLM2vs2U5d77fgVwVbF+USAthx777sgUDfg9xEZ5tOJDK
	FYuPAOxDoY6fvwhFR8YjJeKuwjRWgOrn50x/mLcXZuNT8VsdNCZf78LoklsAoR5bmxfdFI2XmjM
	U7QixLNaqdhFuCVQD4zeHJxc/63cwQLCrb5oCT4zJO/TsbB4t38SaU1DCWoHwYG1StveboPUTS6
	1tiFs0XfrFzXGYJ2KwmZ6fgoJhqyiWj+ldYueJ66WHTuZIvwWs+N/axA781FxokNALqGkWiBeuf
	HLzUjvJDOAyRoHk+X1D643v3dxiIneGszxmfxUu+dF75WBOx+pj2Q3ftlw/l+kzxJzi1nJn1KJQ
	R8yCzD269tvVudL5otzU8jOnGTtvsLC/2w8+mXiVNEodVWYlr2Q+lV/pa08hNNeU/FKwArZr8A2
	E4PHwj4iU9Nwq+uPYxbNe0ABW0ViPnDHO0aehisFQn/VRz8rm368ZQc4Dn99pMGs5ENtIlrTyyE
	kSRh91js9a6UhPA0EcbyRr1748U3/1UF/VVinUsOE5io77P2XD9zXXZzRz4wfby4L1TCO2XKHhq
	cFxQ+gBaVY6JR01L0HLzgbzUKdPLkiHsus1T0Yu6St2QrgLCuRrf5Ws7CeG6f4upQ1ECklGdeSv
	AJtrWALipaLVbU7s=
X-Received: by 2002:a05:6808:10ce:b0:4b8:46e3:e220 with SMTP id 5614622812f47-5640de87067mr5635130b6e.12.1793722279518;
        Tue, 03 Nov 2026 08:11:19 -0800 (PST)
Received: from rrangel.c.googlers.com.com (194.246.27.34.bc.googleusercontent.com. [34.27.246.194])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-5640fd95dc0sm11688383b6e.6.2026.11.03.08.11.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 08:11:18 -0800 (PST)
From: Raul E Rangel <rrangel@chromium.org>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Tony Lindgren <tony@atomide.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Richard Genoud <richard.genoud@bootlin.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Jacky Huang <ychuang3@nuvoton.com>,
	Shan-Chun Hung <schung@nuvoton.com>,
	=?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	"Maciej W. Rozycki" <macro@orcam.me.uk>,
	Timur Tabi <timur@kernel.org>,
	Peter Ujfalusi <peter.ujfalusi@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Patrice Chotard <patrice.chotard@foss.st.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v9 6/8] serial: 8250: drain canceled TX DMA before reusing its buffer
Date: Tue,  3 Nov 2026 09:11:02 -0700
Message-ID: <20261103161104.2449407-6-rrangel@chromium.org>
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
In-Reply-To: <20261102-submit-serial-8250-dma-cancel-v1-v9-6-9159caade148@gmail.com>
References: <20261102-submit-serial-8250-dma-cancel-v1-v9-0-9159caade148@gmail.com> <20261102-submit-serial-8250-dma-cancel-v1-v9-6-9159caade148@gmail.com>
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

Reviewed-by: Raul E Rangel <rrangel@chromium.org>
