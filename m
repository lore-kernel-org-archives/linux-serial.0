Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793722279;
	b=kBi/6FyCbXzO423nJgMfc/pmyYzj7pfLw9/9oCmoE9cPOxtpD9YnOr45LELHF1IOxTDP
	 tfTXnCG7XwigQ4F33eJ4Pn9itpfiX1F+M1yr0HR6fWul90rRFWt1QA7uxpyhRkIv3QRsd
	 P2+k4C9tbMOuus2zE+0pza9+MrW+p1vf/NUjOV3nweqm9M8SDOdFWkTXpdWoDBxl8BEpi
	 xUJFU+v3KaCKtNBkSEZxflsJVAbeFNiUH6r0EIE3JZh6XjMue4yl4Pc+5PYrQuzX8GRQu
	 4jUeva8G7qZlQ5Y7bEau6mvToeeo+1hv+ElZGuKmv+Kj0N8f4jHEZrPca40U7ZC2WNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793722279;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=S9QmmCvTtJG0FWP5byFcRaRFelUpQGR0S1hSw8HKBvw=;
	b=U/Qac0rhJvQgfMttchbtxP5CRW8p9G5Wwh0VSLlNnvN2Wo8+21JqtBAp1J80lOReyARE
	 ttdrP2p/mfiuGUsgfEqlCrHka7KXnQqRTgFz9tICuwxH3LfqeL8P4OyF9AlC2HEUNiX1G
	 xqnYJ6wYHeW+r0/NlMw2TozL9gM40eVyC+yBVJBB+1m2HuCBdwn9HOrS7d5oS07yNA8G9
	 Jfq+AFVB7eFL7sGc2gOxHly1ouOfAsc/GN6k7ngVR/9NbW30cLlpvb0z8MwS8ll8Tjq8l
	 KZaXk5SylC7K4hcsekDYxA2uolfTtY5Uh0jGo2fM9qRIZXnuAxIORiOpW+pIuL81Ogg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=ExHrAVAw;
	arc=none smtp.remote-ip=209.85.210.46
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007CE6082BD9
	for <linux-serial@vger.kernel.org>; Tue,  3 Nov 2026 16:11:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 007CE6082BD9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=ExHrAVAw
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-847ac7ccd85so2831948a34.3
        for <linux-serial@vger.kernel.org>; Tue, 03 Nov 2026 08:11:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1793722278; x=1794327078; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=S9QmmCvTtJG0FWP5byFcRaRFelUpQGR0S1hSw8HKBvw=;
        b=ExHrAVAwB7Dp5zUHBPNW1zuHYke8J7wH6CuoUZmTpvtgaFiRytAZNVD8L5YWdYWSgj
         r3wn5s26gzhyjTX8HiF7hwzC2+rPexv+aAiWCcucQnGBrxeswRA7fZsUcgoFxMR4HkTT
         EOXEATf8xSszlJ5OGB5SnCZiECHLNJcxCELzQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793722278; x=1794327078;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S9QmmCvTtJG0FWP5byFcRaRFelUpQGR0S1hSw8HKBvw=;
        b=ZR1nvROZMlyAxzA7uje7Lut1K0nAy9KfPGcUHfv/tRH9Dv9Sxg8vEcNF1Z0820T8aP
         UND4hWoWxW+g6yxCh16nVYUnT7mnaFJAKRUQwP2xHD7NXwpXgWjuBuRk1YzNnStO+v2Y
         rXAgzjrpg3yasmBckXHjeYIAnQj1wcu8EtvWgOjiNWjHAKPl76zx+Eb4V5sM9xbEy017
         zAn7UNNqTxSERLqYyPKaxWfl7YZk+18DqiR+k3WQBjFsbLU/BR/l0gJdh94q1x2KmXxv
         CE7zhsr3rz7TFhxrJrUwTsQETjcGTM6NfhK2cmiOJ3xl4QBQWt4tqakVPyFfr5SsRDp9
         ll0g==
X-Forwarded-Encrypted: i=1; AKwUvBzUm76tF+pScFFIhTWweh/z5jfiR6j0fcIBy0saTQnWurAdhEyW+qAsgV7SWPvDAnUGF43cjNnS/CvsCaE=@vger.kernel.org
X-Gm-Message-State: APuU4Z8FLWsvZTb7emJIafE1P3mv+dPQZDaST0BNJ+0BGc4PrXQJyftT
	hdj09UJX8bSzggbloudd0fIwHKuSCxSo34M1gWSxp8OTyJ+W3mPZSPeYQJ8XoRTv4w==
X-Gm-Gg: AYBFou0IrbpHCQGGW7gVY+tKbUFQ0lHt0ZT4p21gQ8CBeaXGBOkbMvRzvY4rw08888D
	b2bV40aC8ySfjJmQ/SuwWkImeicroy9HqKeNToRHR2n2VGjoHn0A05oEQPvUIgBTD1vBzspDXji
	9lUqra2YLXjtBOvn3io+qyf6StBf/eCUYeaxwRTDEUNTrCWjzT5WlxXPsP6hfh5kn5fu0N74aCc
	jZspdLkPi5yZo8LXf9R5Loy3varrUpT6SJvOAcMAR1A9EjZuC4u11VkFAdaMVqT2gVygZCjgW8d
	hnLq9B3k9arRrxc08ZxZEt0mZsK2woR74bmd64hkZqTbGN4H7ytiaKDfpNapqOdcu2AqLHlgtMj
	eEn1GXT3Zdc6haQz8LK4mEMCVKfSut7aCHi/bm3jrC/DuQ/KOWHfFsNTw7gC58HcuMRnxUjGymn
	2CYdUgdimhi3hGK9EL04N+ZR6ur9du4YgsAMtv8jNfVQXJD803tCiIqjbnpp3xnvoc1C2ADX50e
	uWfin2GY0DUTJiu6B30JOnp2CohC+egK7+9EXvO7fH+p/dTNCc1QvlCAAfZkzgTdB3CSbPRrx2C
	7WzfwUbBemn4K6xtpS+cUrdAd84a1WocOueRQFeXKPTq/16luhmlEkkJuw4dQIezurIjTyf2l5d
	Gp+zHnH0H563qcjU=
X-Received: by 2002:a05:6808:1793:b0:540:5827:6d8c with SMTP id 5614622812f47-5640e032a52mr8860527b6e.57.1793722278097;
        Tue, 03 Nov 2026 08:11:18 -0800 (PST)
Received: from rrangel.c.googlers.com.com (194.246.27.34.bc.googleusercontent.com. [34.27.246.194])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-5640fd95dc0sm11688383b6e.6.2026.11.03.08.11.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 08:11:17 -0800 (PST)
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
Subject: Re: [PATCH v9 5/8] serial: core: allow drivers to reserve flushed transmit storage
Date: Tue,  3 Nov 2026 09:11:01 -0700
Message-ID: <20261103161104.2449407-5-rrangel@chromium.org>
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
In-Reply-To: <20261102-submit-serial-8250-dma-cancel-v1-v9-5-9159caade148@gmail.com>
References: <20261102-submit-serial-8250-dma-cancel-v1-v9-0-9159caade148@gmail.com> <20261102-submit-serial-8250-dma-cancel-v1-v9-5-9159caade148@gmail.com>
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
