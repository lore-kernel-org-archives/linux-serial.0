Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794344720;
	b=GTBH8uDCYf1uzI7/MXQezVKhaaX5zs+kTY2f8ZuRjgLDnGN5c3nETG6otGKjMeujvWzf
	 1R+gr13xMHEX72zYZjuW+JcEXWY8mdqp93jdXcTZSYtEGw93SSLzJVmoN32kECTHbIzJJ
	 Ei1RJmvn+Q9jMYqDSGb9631NxjHbhW8q0bsJrbUlu9EKtzepP5yjLeOjALjg9XuBIsshz
	 dOnPmxw7z24sZ26hZ2qdtGWTTTabSBU13zj+JlPVJKm196pc3YyGAAm8McuBdmj5AUiwi
	 BYbIu+RQxKP+5HF/+NxsmY1eDdZDHHpTaZf/yyC2BrQkEcU9Cuyws9HlLZ45kBmOZbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794344720;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=r0F/G1/cCd6YtCyJox781fOcwZWIec41wc+ColCaqik=;
	b=VVT4JenNYSRIyW5gtbZfBI4aw8+uXyxI+ir2+cQRFb5dVg+xZ/+3ztGASSsIcdORLr15
	 H8jIzbOlvP3HpwL6Bs0PSrB5LcD7O4g7CvYMt0zFozjQ3Za256l/vNozLIvJdqiOqTqBj
	 Y9QKuPxshfdNBStiK2wXVMxKmVYE9pckKOkAMvv9FEeXzQIhjPGDBv0ohQuoJ4N86eQIi
	 XnB82eij/8MJAgmZ82Q1xIErYgonZ7U3BqobosfB1NYnFbo+lD1cyg/t4lf6wf7fOWBTQ
	 2q+N7/xvWTA+kIXL5Ew3iJxBSwvBOccKQURWb5uNF4ryxQGLkLSQqUEKk4UZxIxZr6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b="PZdH/bDB";
	arc=none smtp.remote-ip=209.85.161.47
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538F3606A320
	for <linux-serial@vger.kernel.org>; Tue, 10 Nov 2026 21:05:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 538F3606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=PZdH/bDB
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-70b875f6f1fso1912105eaf.2
        for <linux-serial@vger.kernel.org>; Tue, 10 Nov 2026 13:05:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1794344719; x=1794949519; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=r0F/G1/cCd6YtCyJox781fOcwZWIec41wc+ColCaqik=;
        b=PZdH/bDBU0lpZSlz4yodAHwL9jtp4rhFJ8Q1un4mwvO/Ewao3DxkA1kNgF5+cfG5o3
         LufBZBRx1MhkyneStZl7gy+ur90mFuYctHSOJeuoc/CscRm/3ELlZtO49Twv/eVa60LP
         Hqnk9yTRpBGM4BiBsPW15Ac9x6q6bxrizHrKg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794344719; x=1794949519;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=r0F/G1/cCd6YtCyJox781fOcwZWIec41wc+ColCaqik=;
        b=Ptbf1WToiLozFvDNCpxY5Ayz6dK/m3OB9wA//ITIQRu3pcjqBidAIt+M6ju7OWYDPj
         C8XUcXOKBRUdRBSSKP9f4jnfNO1+Io1iUF/bjR5PS1zq/W32uk9SeDL3ur90wv0x0UjZ
         zprCHacABwi2EDqDo1zqglWAhiFd2c9WIVIo7615s1XR/OZ0WwepGmhRrgGYPbJGZdCY
         kebFOfCf7TY+Etg8puorwsdq80Ozg9s2EmvShw1tuodBkH/jX1zEq6JHnnugyf8wurbv
         OE0Eb4Qnd4hYPTLGK3HrgE+eK6zn8jZP2x8u+E2/4v49g84OuFDkH4KUFdzP5nUFAQfe
         +Cyw==
X-Forwarded-Encrypted: i=1; AL+hErFTKmLDteAXqhBvQtZmVBcfLBhd9Yuru+Sz3npiK7v8q7ecXVM9i25OWPKUIA6jWp+bQPM826zX90augtc=@vger.kernel.org
X-Gm-Message-State: APuU4Z+mbRMaQpCSjDlZbecKCUGpc6Eh6nbDvmrxQ/OPWnMsEUGeRi0P
	kD9FByIINa+u+6P6iXc8+/bSpNgg+yWE0BF+33Ckv9UijO0It1P6RHqH3My6IeIWVQ==
X-Gm-Gg: AYBFou3AkFyAhQM0hMu+emNgW9qtXusYBY3RjCqGzuWi22CvyqCQ/yT2RPOpzuND9+j
	Vz0WJRAq1pkAyZJkkqhwdlPy+sy+9qSInaEDqUfzgYs0B4qbq+/4BIrqHH2uMwR6gaX8UBELR7x
	lzB/378W0wCTAvbHM/XD+5sRg0gJtmFkP0M1bklFaJQSQhA2rDOyYOIPAQSRfwUdlvcKaIAFYP+
	AVZsQpADAsgpjDOwDqReZ4Ozl1vGG31HZDN/kysCHnfOnlPCno8S+Zo/BnjCXKO2jQc/1vBbw7W
	/RhGEIJFrWwWipEiniEIQQjsYq0yKl1JBnwRrAOZnk9fjVDWh3GX1IWsfvF3odlbEvZxE8efRc1
	i+R6CDBv9+Tkb0HmLPw0Bs7Bxy8xt+pTADdYRWF5rEX+ReAF7v5214f86pZibngCsRM/DDB52nv
	E1UtOWFC+sVMb2XxVpVjPrUGlN310lxhC3GY6MU8gH1ILCxRWmZx2p9LJg9L6guDIaUL0KMq7km
	+PeOkd2WrBDezj66Z3JTKQpIwWsB1FBn57xlvwnigPaAd3+WN5QncI2qBnR/yMvhUWXMcv8NkBf
	5T/TaEeJDcerOsMIVRt1nYYdII+3AdwzWldLuN+s1FKx/2g3u1P/jA9dnjJfShEPtF9ibx6DDbi
	vsHcg9epYgcw/j7Fx1fCd7VU0CwY2ZTi7cvjB9Q==
X-Received: by 2002:a05:6820:c44a:20b0:6d9:979e:22ad with SMTP id 006d021491bc7-71917934e44mr119108eaf.54.1794344719257;
        Tue, 10 Nov 2026 13:05:19 -0800 (PST)
Received: from rrangel.c.googlers.com.com (57.128.170.34.bc.googleusercontent.com. [34.170.128.57])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-860dcb62443sm2856553a34.6.2026.11.10.13.05.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 13:05:17 -0800 (PST)
From: Raul E Rangel <rrangel@chromium.org>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: Raul E Rangel <rrangel@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
Subject: Re: [PATCH v11 7/8] serial: 8250: retire canceled RX DMA before reusing the receive buffer
Date: Tue, 10 Nov 2026 14:05:14 -0700
Message-ID: <20261110210514.1091741-1-rrangel@chromium.org>
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
In-Reply-To: <20261109-submit-serial-8250-dma-cancel-v1-v11-7-6364edca63d6@gmail.com>
References: <20261109-submit-serial-8250-dma-cancel-v1-v11-0-6364edca63d6@gmail.com> <20261109-submit-serial-8250-dma-cancel-v1-v11-7-6364edca63d6@gmail.com>
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

On Mon, Nov 09, 2026 at 09:00:22PM -0700, James Hilliard wrote:
> After one second of unsuccessful pause retries, stop the transfer with
> dmaengine_terminate_sync() outside the port lock. An indefinite wait could
> otherwise leave a request/response peer waiting for data that is stuck in
> a partial DMA buffer. Report that recovery discards the pending payload:
> without a stable residue it cannot safely be copied. Keep rx_running,
> rx_pause_pending and rx_terminating set until termination has stopped DMA
> and drained its callbacks. Then restore receive handling and allow another
> DMA descriptor, without latching a permanent PIO fallback for a pause
> timeout. This trades the stalled transfer's data for continued reception.

Reviewed-by: Raul E Rangel <rrangel@chromium.org>
