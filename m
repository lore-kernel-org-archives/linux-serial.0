Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795035421;
	b=Nda7w6L9lTRUyrq5/TmoCzR3Lx8/ZWkvA01P69bXWW5df0Oi4Wc3H2aqPV4RNjm3q8XX
	 CU7LaEh4ygjcGf1ql7nnmXHtAkd3gmoxujUR5WrWf0Hd9qcwHXXpyOF0J8r2+34GdFHLX
	 D4mWTPlnO9FqnPv+huF9/xaVHj6Ohye7jU9tggNJiNk+FVJ18zVt93/RJXAuH5smsCkQs
	 ejBu06mwxsUqlE5iJZs4K9Bn6wWbABV3NbVm6AA/gjlAj9jsjV72EVM44g/dG15PTv3Sv
	 im/csuWyRqeUshQYDJ7mEpsIg3/MAGQHP6rvtUszaMoNwoeKjDlCN93toNYpZE5VoTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795035421;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=f3GNnuqRISLu8fzYE97bR6SxD+k6/PUka28NAKwn36Y=;
	b=sfmXJUP9dTdqncZA9fRiNjL7frokVpOQf1M9X7EP3isnf0aZ/twopp/y9yBIE3JhoK1Y
	 spQT1uPC1xAzDuJnoSx+XWRs9tyrHtvvH40CebBUdQF2nxT3VraEStpeJwEEJzUDXlLal
	 rldRRYddhIP5yooS9R9zHcInixH93IdQPKCHwVFL+3SoeFEdHIV4AITAL9TElMqpVSqYE
	 RN8k1sY6vzU9WybA3qlQlxooLg+g5TkxoCTF9oEUz9IOwJN1ChxhFDrz5Zp8tzX2liINO
	 dVDsgdkL0HPlGEtsluEftl5o+fgohhLvPTqVOj1WzgYUPVu9Fx3Rrw9mqo8zzYj1afw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ypaA5fWt;
	arc=none smtp.remote-ip=209.85.221.47
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E89606A31C
	for <linux-serial@vger.kernel.org>; Wed, 18 Nov 2026 20:57:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 57E89606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ypaA5fWt
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-491f34b4e0fso717311f8f.2
        for <linux-serial@vger.kernel.org>; Wed, 18 Nov 2026 12:57:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795035420; x=1795640220; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=f3GNnuqRISLu8fzYE97bR6SxD+k6/PUka28NAKwn36Y=;
        b=ypaA5fWtJcjY8vKmt6s6c+LO679nTEiOgmTbOKI92SmEDCzccPSsdZDznc3SYcjYul
         Lp315c8Z/0aLU5uH17V2gXGOOXzy7jch4VgWkJEixjuwdTQOFqRodGMjoY9mv+Ce5ogJ
         mjHjbB99afM1lD98oH1XKLpl/S3Kn7Yp1C7trsB9OQ/tMvx4fFKS80EA91HbXrUwNvAr
         e0cTIap6+2qoJQy5PN4ZOsF2Tw0l/bfKj7HmKbOLj1jNtceUZZuk/Jl3jeIMQBNJpvCY
         gpFpQerh68pep3rHkhXphr1VoYjesezupb/J2+5MARrk+nPqFnx8Skae4DXtpeBNHJHM
         1S1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795035420; x=1795640220;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=f3GNnuqRISLu8fzYE97bR6SxD+k6/PUka28NAKwn36Y=;
        b=E4WV7pzTISUeFKEPxfx4/STj1nJp0NeIARKlndT72dfirnbpUOB+2LfaAJ0l6lPKUf
         uyrtLUG4iL3GRedUrOUIDvHaBeY01KYHeWBJa0GMKzovaEr5qBFRzQmjxQttP2AmbPgD
         AdwL0yeGkhQDaksCEWKzESC1cV6hYFwDSNuAfT6CA0LZkwXWf5SJpv3LFXMRyanfWI/H
         BaamclOeEGXAuKF17PfoRzbbYl1gDCGXWIzdCfM6LGgMMFiZL5uNJUi9OpiFSCKYRYWJ
         S7y5/DLitEXqa+ms2w9+cEiQ0/fG6Sh+vUOlSX1trHWoz6d2cP4QRP1cM3RGmgoHQ0WV
         ORVQ==
X-Forwarded-Encrypted: i=1; AL+hErHdAnm7LH+wfv1bT2Twmq633mzRmlXNQdIHM8FcOZ+3X9w6+R3NlUTvkUn3v3Ev4Dw4r3/aJuIq5sNC3+E=@vger.kernel.org
X-Gm-Message-State: APuU4Z9OWYDyMoVMDSweZkAcTxhXbhL8ig7lnTngg5LCQLDLs5zLDImh
	T05k/ZQUOMWIdKSDwdXN5U0A0kI4BCLOC6Pav8QhXH7iMBBrE+xT/N0y7Gp9kkID
X-Gm-Gg: AYBFou0OedQqu8mkPfPLiMEogpBRw7D1nCX7iBYOwrzPpupj2Dt/TXqq1fxzXSzHP+D
	XnXxXcbcsKQJU7DQvyoy2Vk7FtU/TFld2JUQ6xh+1cojMPFaTDP4RAgs1C7yCyzOdTIeLLhOsSu
	J7JjH+5AFre6Bc5coflmXar9nq1avFa+gi9EEbraQMrXmouHzSwndcycSONwzSV+jwPwsVpxmrX
	Ilwk4g9CBpZ5TjLA9AI2fpbg7GVw3K4BDzrONR2YCeO7zHLrEKnIP5327kv8D63W8jn4L99rQ81
	/G2QH409rvUnkBV9UVTk4u6Lo6spoShmKB+54LGB2tZULF0TWav4V7uDnMgq6u+k1jlLgcQ555l
	t3BcvGMn5PD4opbQ3FfTZ35R7InzKAlNbmmUnpSldI5EhHoYkGX5h7XPk/pLDvor9ig2ZUhf/JD
	43gkGIb/9wOj0F1APg4JsexRmETpOEIyvxRBC3mSZMN+/GTqbcZFTY3Flmdmo80i2cZk2RJs9ci
	6cgo6FjIu60LLEfsahAXUBSO3m2Sg6fZJGhT3KoP56RP4CXu35Wq4sE5N84wZqqXtH4JmMF+eIU
	iDNsOXDK1do+H8gtpY9sUM0Yr8CQ
X-Received: by 2002:a05:600c:1d2a:b0:4a2:d99:3171 with SMTP id 5b1f17b1804b1-4bb7da34cc8mr92969645e9.23.1795035419433;
        Wed, 18 Nov 2026 12:56:59 -0800 (PST)
Received: from m2.. ([37.142.154.208])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4bb832625b5sm18265795e9.11.2026.11.18.12.56.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 12:56:58 -0800 (PST)
From: Michael Zaidman <michael.zaidman@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: Michael Zaidman <michael.zaidman@gmail.com>,
	linux-input@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	dmitry.torokhov@gmail.com
Subject: Re: [PATCH v4 03/16] HID: ft260: add GPIO support
Date: Wed, 18 Nov 2026 22:56:48 +0200
Message-ID: <20261118205650.49046-1-michael.zaidman@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <sashiko-outbox-219595@kernel.org>
References: <sashiko-outbox-219595@kernel.org>
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

On Tue, Nov 17, 2026 at 08:23:52PM +0000, sashiko-bot@kernel.org wrote:
> Is dev->gpio (along with this FT260_GPIO feature report read in
> ft260_gpio_init()) still needed now that ft260_gpio_set() and
> ft260_gpio_direction_set() read FT260_GPIO from the chip before modifying a
> pin?

No. v5 removes dev->gpio and the FT260_GPIO read in ft260_gpio_init(),
which only fills it.

> Also, FT260_GPIOCHIP and FT260_GPIO_WAKEUP are unused because
> ft260_gpio_init() formats dev->gc.label with devm_kasprintf() and checks
> enable_wakeup_int with FT260_GPIO_3 directly.

Right. v5 removes both macros.
