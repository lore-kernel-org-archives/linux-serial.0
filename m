Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793722275;
	b=xwHmOYr+JQF9hBvh1ePvRZoWbpQsPeEWpz6LALvmg/q2/7EX5PcwszSs08KVneddVSZY
	 RggJIJV3tw10P6M1Hnsrt3qwx6uvBjtUmgnCuTlZ1mylF6EhPTGeRZ7CAWTHTy9PutDOr
	 zONAoUXaOFFEDTZuao2UlkXJr+vkZC2YK98M/w8TI27kA7ltZbj332Vae4NMpzWgshrYC
	 a2Y4HVqCTULaRtmYI/W7pm1+WO4RYfXKRX8BYvi5xdWQNZINEu+emlGcFL+Oy8wwvsfXA
	 +m44KNJMKggdw/g4hRbaDYqA1ZGBtrkR6KvAGgVFFkNMfKgEmV/oUQee57liFbpokRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793722275;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=S9QmmCvTtJG0FWP5byFcRaRFelUpQGR0S1hSw8HKBvw=;
	b=Qn1AdhCzciqKCjTctXdqhyr3eRQX49xEwHmSBYNnDukd1QALH6RQJOi1rL2LYuk0/B+y
	 1IN8790YBRbXeth/swJn8Pbeywt4wxf0n5dxMwjrhQ1Hvzu4Y2pP4Q5GiSvL81Bsrp7r1
	 FbO8FUktPylHvQglbjyA1pfHIWLdrQYkfMSZOP/K71Dk7dh3DRej09BnI1uRg1LOKpDl1
	 iV1oGr0WJwFB99OGsQKEgWzRSKzAYf4i8Mtn9q7o2dQksM/2HIwXz5AHiUanE5nNw6s9Q
	 Hp9QdqnzX8LgHlHa2iyMe1PL5h09x5exXxusIqKawo7mX8huPJ5x1mIHsOkskSJ0Z3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=IugDAkXq;
	arc=none smtp.remote-ip=209.85.167.178
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D64F606D82A
	for <linux-serial@vger.kernel.org>; Tue,  3 Nov 2026 16:11:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3D64F606D82A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=IugDAkXq
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-53aa0802881so2184199b6e.0
        for <linux-serial@vger.kernel.org>; Tue, 03 Nov 2026 08:11:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1793722273; x=1794327073; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=S9QmmCvTtJG0FWP5byFcRaRFelUpQGR0S1hSw8HKBvw=;
        b=IugDAkXqOR0z/mkKCABIIFLRhPVDb6fstTz6r7Lu44SpE5PMioN7eMJ2Bz53YWUO6B
         BZptQRMnzL0fF/nwfs6PK8JwAXt6NMWJhfmD2TE1bx2r4/DXnEQqrYkEd2AR6EvfyrT6
         D0RTzho5sgqOTey2jp3qO5IImQxei5n7SKggA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793722273; x=1794327073;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S9QmmCvTtJG0FWP5byFcRaRFelUpQGR0S1hSw8HKBvw=;
        b=RpAbGyK/5DHoIFTjVAxpPOGphoBnIH9gKBqBRgNsmsnjKkvoLVvQqzJNimrOSFEFZd
         7nwq6LqrBb/ZpUvrl052YIrN9jcrHW0ANMroMK9lPCmg1yW4N5m2X0b8v658D5RnMwbg
         asmFHCLmYgV2gDtMIfeITgtwuMGrXHAuOVFP+4hFKynPM8kizYUNn7D905VqOEz6PSXn
         yPpYjWQR/tb3r0YRiFgJDhsRRAfEsEgMpayOSSJCcCFhjRrQ5ZtLo+/o75U8bp1eXBRD
         F7LwP/hHv46UBPnJeSJ7owEYY5P+r7H51P3WKKn/vlN26AsNqOKb/QNQsZxz/hEWNsqE
         erkA==
X-Forwarded-Encrypted: i=1; AKwUvBy4Jb/F9XFV9bMK6hmgw0Lsvb3meVYtQpEhRwpQHvqMvkQOZ5ZmcxdVJKeuSvDZaVLBfltD2kaQ87HWEjA=@vger.kernel.org
X-Gm-Message-State: APuU4Z8kdI8nLSxWYtx/6LqmAsjZtxYEEtblMkWkk1BNZPwz770/4LxJ
	SaKRMbFP54rIYqhCpybOfxfLFfhaUYHY/f1xEA5IBjzYg7/jejBWyOugugZNkCfh6w==
X-Gm-Gg: AYBFou33LaQ5y0HFXWLvyeVohOl2m6kjRgypslcRrPy7Kw5MQdSWGFwaJ58WWuFxNZi
	Kd6mCCN8pX8rKaf7QgHKqyRbIYwqbRYx8U0RxzST7WlGQbDdjxrWoF9L+ABt0WvoShlUx4sMZ94
	7bP1n+PPBzvMBI8vlWxNtud7VcBZ4+Ecmn8ssrzVyx7c9bN77qQVVjUWDvFlM0UoS6+XgFJsZga
	N8uSnAVpbxf7m6l12xvQC0fsZldy55VjTF7k+Rklveha9kw/AFkcg0KTKxxM1fVUmzKAX3dgCwW
	LgOGV1rTO8USrDascnHd1xfMdRww1Y+ebK+3teZbvtCRXBeMx8XATrQ/A9BVcPOdDonzSJtujrr
	4uW1UCwfNJu4hq5JabHTD7f7wOcHXdYSmQG+JotFF4/UhnAfxBI3Z7RHvVMR16rE+xouX1c5/CT
	dHS9jPFCreKvzLnazBGnbOlULsSmKjh1a44ecG4QriZ5yGp7ZNNo+YvO4EH4XF6rdnYUQuQuvnE
	PbO3UwVW8XbBoufbXaX+Dm+n2n2RAT+AWAdUDveyCTd7i6D5ucsNZAsYhfHDKRQ0qNJnlGSm3Cb
	ARe+lZWufonCCG1U/Inq37S0eSXpX8Nrhowc8stxnprBfNbh2iENO3vEcLP3ZooEPmUkMLvSYrs
	DAF89EAoLbQ3kv7ci
X-Received: by 2002:a05:6808:3a0d:b0:4b9:e6ab:d085 with SMTP id 5614622812f47-5640dd277b1mr9216799b6e.37.1793722273221;
        Tue, 03 Nov 2026 08:11:13 -0800 (PST)
Received: from rrangel.c.googlers.com.com (194.246.27.34.bc.googleusercontent.com. [34.27.246.194])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-5640fd95dc0sm11688383b6e.6.2026.11.03.08.11.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 08:11:12 -0800 (PST)
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
Subject: Re: [PATCH v9 2/8] serial: serialize asynchronous write wakeups with the port lock
Date: Tue,  3 Nov 2026 09:10:58 -0700
Message-ID: <20261103161104.2449407-2-rrangel@chromium.org>
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
In-Reply-To: <20261102-submit-serial-8250-dma-cancel-v1-v9-2-9159caade148@gmail.com>
References: <20261102-submit-serial-8250-dma-cancel-v1-v9-0-9159caade148@gmail.com> <20261102-submit-serial-8250-dma-cancel-v1-v9-2-9159caade148@gmail.com>
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
