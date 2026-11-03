Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793722277;
	b=NzxyNq2RsPna/lyHZLU6aLXr8NYP0Pk3oYZg2djA7KnpyCvDCD89QUplEkOwa85Ao5MO
	 iD1Y6f27vS0QKzo0LZR8l84WoAD3NX9KBZNcgN6lzfRqfvcRd1w4u9/61ZP2KwyY50Ryv
	 J46HJDq/jqNdeG06UudjDIPCTo/gtnMaOfZEcKraxb6S+W2t7IJix71pTosChX0swl/Oe
	 rIgsljV8DovPpZ/14JF68sSDJFEAOQkyuAvhz8iMp+CuDCevubTqBkNj0lf1NQUtXWQ1n
	 Z7lIeNLTRqUfN1xjfDXDlAjTQo6xjGrnKeB1wBWvFZB2+7XP20XqGfi4Lb3lIkkfPGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793722277;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=S9QmmCvTtJG0FWP5byFcRaRFelUpQGR0S1hSw8HKBvw=;
	b=f+JJ3jM0Pv7R+gFb453K7woM9ss96QYpGL7sm1E5elSqWGArLRT4ZFPc9InIKA64Rb7s
	 9iexwlYm9PcsgyiJXwM/MKdOUwutjn07aLXe/oKh9be0KnWPPWDXdA9sakiIkCixgqZTq
	 2aD35L+5b+CZyrGgqtdC0lGOtzcPujusvfxbjD2OWmVw53J9eRfHCRBrkkrMdCMilTYSq
	 9Lea3fg95/Hv6Kt7M1IWzYLeH7sXWFrsCknmITvanNWB8C+by+PZtuGfFBXycazBy+OEQ
	 FrCcSqg5Ncqhbbjp23QvyGwIxhOas2ulMA5jtcfzEcHCLI0KCsGUcqH0DGgQ2fqJAHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=Md7w44rP;
	arc=none smtp.remote-ip=209.85.167.169
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE73B606D801
	for <linux-serial@vger.kernel.org>; Tue,  3 Nov 2026 16:11:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DE73B606D801
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=Md7w44rP
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-4b190cdc9feso2979895b6e.0
        for <linux-serial@vger.kernel.org>; Tue, 03 Nov 2026 08:11:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1793722271; x=1794327071; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=S9QmmCvTtJG0FWP5byFcRaRFelUpQGR0S1hSw8HKBvw=;
        b=Md7w44rPOwSTNItGi+uTSGtO2nFLpUbbT9xVBdDZTMPeyCFmcPfrHwOcIhuf/mB1s9
         M8Kw0PvthUNf2TwGyfKZuDOtKv4LCpYvi7XR9K3NumIrC5TlXCdRgf8ifuFxWnDcTRkH
         UARmf51JS/SQOeYUJUJ4s0APvw5gdpnKbfSKk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793722271; x=1794327071;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S9QmmCvTtJG0FWP5byFcRaRFelUpQGR0S1hSw8HKBvw=;
        b=q7+emJuNehWxuPkPdk3img6k6s26JIYiUvmzq+U0GL+uWrqIkZyTULboWMoiRMYn5m
         ej7frxaezUwdG36k3tZtPgqpqBxarBQ1UoZfBLqrKO8jJXvwA5wsjILLiY0zB/ZD7f/i
         Td7eDLTM8tgcQ9xU+Xkupe6/00fqswGHJW1QV/gH7dgV7FUSWQwVhUY1YpXvxBTadHxt
         WuiN7l7Sl/ftDzcNVUmQC9ebQS5e9TK1Su3JGSnDA6fZaULDXgdTPys7zAnMEOjJOK+x
         2NViTEnRRnWHGOBM1HEhOwJMHygTKFXNpG2x8OkHeGOdZaKuNKVdiTMf5GKMz4b48uvM
         yzfQ==
X-Forwarded-Encrypted: i=1; AKwUvBw+uku1IWQy8daG5nd15z0nw1D23sksSKEmFaYms/q2L7bFIXSALvuu3W/poto2glBo4A0SdA2PWVAsZuA=@vger.kernel.org
X-Gm-Message-State: APuU4Z+zltlT66TJEV2RiLcAeRKiOTf8yPRi77Ce2BElRlvmm+roAw83
	rRsxrpOP6mE6AP5nQbxRGhC8pjilIyYXjHvgG525Dttiy+4SV1ILtCD2i3DVaroDNQ==
X-Gm-Gg: AYBFou0biGJ6mrChrCQKgdGHeVS236iWptUeXYZoEIl1zdOktOEEB+7HX5fOavPnipr
	Z44gj2rn/oe3eojJNtY4F/oah8zjM/BVxNyt4MtlsNvpz5bHF55NI3VwnqCk+jpaRJjbH3MZlmB
	yc8W/B3gRZGDEG6EJ4njUuSS9s3Xg4quXwqrnU1fxyN1FPUYPbnCxtX7t5VLXcZFyd1EheA/uyL
	I1L8szWaWAq8nwSn2JskEdsilVAJM0jSK9jSdwgobw9T6Mg0kUIraDKdaX4wlhzTy3AOIfKgs8b
	fnlgA9lerAqCArYNDMSp//zL0V/vDk7m2W/z55RamAyj1v1sFrrVi/NUYhPxsbryUqMQ8dBfLuO
	lMiHUpvB+ySWXFo6KLyzZLtP5Ibw04nZFq8Zfv3rooXqciobx2Zh0KOoWUKGZhfnlsr63Sl+4eb
	7GrmN7OVxUKMhhhwQzMVYIOmoWHdpYum/RHOceIkIGmeOZbR+zJMq07D3B08Ha6vqcRPflYXs2P
	iDsIjhnI4QXWjuPRP7Bf9WcxopgoyAuODAuCaX1XMOCAEwEoNbKAmf2cl4AK2MFzAtFKgSxkiM1
	Pzqi4FWUm7k6M1DpuA2GJjID/tp3Dq/jxNyDtTL5enN6GJIUUDIBErMitzeBmF8RtEd96yzfDG0
	CW3a/z6YrDN5G+dibjh+7CMj8GnbSwSzDuj23
X-Received: by 2002:a05:6808:3a0e:b0:4cb:f21b:6f8b with SMTP id 5614622812f47-5640dd9d763mr8688402b6e.30.1793722270713;
        Tue, 03 Nov 2026 08:11:10 -0800 (PST)
Received: from rrangel.c.googlers.com.com (194.246.27.34.bc.googleusercontent.com. [34.27.246.194])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-5640fd95dc0sm11688383b6e.6.2026.11.03.08.11.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 08:11:08 -0800 (PST)
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
Subject: Re: [PATCH v9 1/8] serial: 8250_omap: separate locked TX DMA completion processing
Date: Tue,  3 Nov 2026 09:10:57 -0700
Message-ID: <20261103161104.2449407-1-rrangel@chromium.org>
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
In-Reply-To: <20261102-submit-serial-8250-dma-cancel-v1-v9-1-9159caade148@gmail.com>
References: <20261102-submit-serial-8250-dma-cancel-v1-v9-0-9159caade148@gmail.com> <20261102-submit-serial-8250-dma-cancel-v1-v9-1-9159caade148@gmail.com>
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
