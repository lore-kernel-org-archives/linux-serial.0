Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793722276;
	b=KovTpNnmYwYPSa25G3Bty96/fHHIFWp4ngmKYt5AU1zXWg+zmWfapXhl/obMvCrxrMRs
	 PTyFB0gdNeyqTOwRRjEK1U1kbagXMeEogCJ+/86neguVPgj5XpBqRNzJzjNgWcIQtuxl3
	 1zY3765R4P52hJVj55NtQuNVrLXp3gPFd00ryXMC2DjmR3NEwUiBznc9wIkVYc3Z1jqhm
	 sfm6ixV3i0n+d6k94HK7oehINR7BXiAGDv5tI4F8y0XBNXUNjG2qf1zsYnd+eDz3PtAMQ
	 6X+TGZTwMQpVoD8DwA0lw+0AaqYcAf4NgkF3ueWzZesiI/sT8aKT8QBREuReC10PiiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793722276;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=S9QmmCvTtJG0FWP5byFcRaRFelUpQGR0S1hSw8HKBvw=;
	b=Ayght9eAe5D0pqlWVqh624ppWWv3Y3WOUFlKagHEeiVbQAzPRipcOYi4nUPp9zBMTRFk
	 PfNA5wxH2SOQy053VqSMXHfjtS1Dt6yKudxTsQaxRJtL6OulwyHQNtaFligd/E8c5kZDG
	 T7L7EfkMwozLBFIpPRfw2SnjM3r0ToKsRSrB48afRikZ4exC1miNLqZsLp1X3dJtDsJHf
	 qShqL8DvnNHKBFkv9cONx5vDkM2eRsOJqhf0QrBUR8S8Iwh2NJWXA2PpdvKrRVvfE9bm3
	 pWTK2am1fHzYVFUIWq5feLts0b4ZkJgXvg03j4NX6XSIXwrEmPwGnEpa5jiRlvdpNFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=WIEnTsQy;
	arc=none smtp.remote-ip=209.85.167.180
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82AF5606D802
	for <linux-serial@vger.kernel.org>; Tue,  3 Nov 2026 16:11:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 82AF5606D802
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=WIEnTsQy
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-55e0090c580so1463267b6e.3
        for <linux-serial@vger.kernel.org>; Tue, 03 Nov 2026 08:11:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1793722274; x=1794327074; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=S9QmmCvTtJG0FWP5byFcRaRFelUpQGR0S1hSw8HKBvw=;
        b=WIEnTsQyUlITWJ6DDuNUwPqteFgESIRZ9iwjsbu7bWti4Sw411RaxavMDAf4nBIGgV
         MhUPPVb6OrDu+Bj7Hht+Uun70CP7UA/qTjCgDVDOTd7GAf9sh2Q3Vuc9yYbGFxKQuxD3
         QWVLQZLFfcV+cUFn5egcIE2Tq1Kh+aVNsAbnU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793722274; x=1794327074;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S9QmmCvTtJG0FWP5byFcRaRFelUpQGR0S1hSw8HKBvw=;
        b=NSZpfwmwHMNmxWO+OR9XRX/R9zfnJmSSGMSzmeRVthMnTt1dRh+15RSE+aJ0iu+TYr
         fn540pzzMBe5b7HWEg/wX41TUoaDTzW32thK3+8M0XA5SD9E+xhOFlC9Yrp+D6M7DBKm
         7y5JeNNTRCtsuEF0iVkiNuuNc2LYPmP6t1LRPg0NEtpkrvhlAxPEkefje+CBoGk/LtKz
         757/UnVbRQnUjca4628MkKWmU0kbOTIqpUe6fEnpmcHHytpXNgvt///vyv1qKbXiKzmW
         vPiPemq4mBV9AZKFAVOchKxMTGSTob7EnFcPcNvF3gA0Bm3iJ7q8MGNzVhVaOkQtkdYo
         eOLQ==
X-Forwarded-Encrypted: i=1; AKwUvBzaxO7OZlGWgLPR3+E7uHc1j8PWCo5BXYZTZR4jTucLewRv3Y+cAj/V/71glKzn23rbMYdSisf+IfUBCWw=@vger.kernel.org
X-Gm-Message-State: APuU4Z+CoZNw0v9+tnQ/MR7BOXSe3qk+OftjmNZbKmcWlr2PNs8I4+LI
	qJAXe33LFHM3UPUDNV7Iro7cL0Yb/iScTySdUQbabcjOqbVspXMURuDvWMpBNdXBfw==
X-Gm-Gg: AYBFou3L+C7f5EeGG6YHsDWHTcdGoOEGcR/0k/GsiMJgUlFrdZ1GaXoV3xWZv1alnWs
	fziQB1s+d6pHmJOcccfumqUVa3nfEKLeNmTMJ0i1pxRO6cKHKVTtjRkVmMyuTDY+q07Pg8IY6Cd
	IhRJOZJqnyaeP9s12zOWY/AuNqzDkFtD1wQ6HAUv/H3JwCe2TuKpuljQv6c8SMDcWJevtUmUgAQ
	KPnAQtcqeVpRBLIfMjtQPCP3yc7BBwtvZAMy1eTQvSGNFO7ftBcsxL6nGzcovReW4Q120Fdk9s/
	zvdGo/hj5uGWxLZAvClBH9BWHl8ly/uzq2ihKrJn1QR+YSm+waSZeIyucyup5lm+NIp16fPK+Er
	j7GPcIF85k35V4Sqzt5YGKneVn4ef8ejW+RaQjhPJhVqzeUW/oCq0JT2+2GlW7+rWikYnx0dkTF
	XiN7q57ffhQ47WpJlK4ndRdzFtXeSmRtDH0CRH/Tej05o17oCU5XqY3A1H0zw9BW7YRuRDUuVCT
	nTzTc3Dj2isFlSGeogSTy2B2r6hoeqglxRV7zx8+w0j4YEK6KzYein6N/Tza3xT71rq4nRkBzZs
	LREjSXvVm9DGFvuS2MbEVVv4xXXYF/1e4xQF2sOBcjCU5ubf7isHHY7z48mZ2yjzjSl5597zE/H
	dkSgBYMt21SNhks0=
X-Received: by 2002:a05:6808:17a9:b0:4f5:7723:4c9c with SMTP id 5614622812f47-5640dd9c160mr9485684b6e.30.1793722274540;
        Tue, 03 Nov 2026 08:11:14 -0800 (PST)
Received: from rrangel.c.googlers.com.com (194.246.27.34.bc.googleusercontent.com. [34.27.246.194])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-5640fd95dc0sm11688383b6e.6.2026.11.03.08.11.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 08:11:13 -0800 (PST)
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
Subject: Re: [PATCH v9 3/8] serial: 8250_omap: serialize RX DMA completion and flushing
Date: Tue,  3 Nov 2026 09:10:59 -0700
Message-ID: <20261103161104.2449407-3-rrangel@chromium.org>
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
In-Reply-To: <20261102-submit-serial-8250-dma-cancel-v1-v9-3-9159caade148@gmail.com>
References: <20261102-submit-serial-8250-dma-cancel-v1-v9-0-9159caade148@gmail.com> <20261102-submit-serial-8250-dma-cancel-v1-v9-3-9159caade148@gmail.com>
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
