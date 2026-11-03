Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793722277;
	b=R0oQs/uemDK4o1YtbQ5rI1Kf9fRzIC9UJjPNJCg9Oagzjfh7BpQs/akhoqNcw0i6rsz8
	 m3wGzoICbbtnqJq2Gxn1dHeNF3Ud97detMVEj2JVBVQTeTYOzWUKzjp2SFBJkjwxuUqX3
	 4Qmv6ETDhgdsUPTZk/WFL43kpKAyzt0fdDwkT3dXi5A9DRd1DzTFiTZp/Y8j/Sy8YjayS
	 pogwT+FYavDPrDVHI2a5efqU6VN+WDMJFlOPYNUvXDB0dmnd5KaljQFqqtO28HwcB5Y0p
	 e33s5uUBopixQc79SIPXsmmAtx004pKqCq+YXTL+7kL/2LOqxGDG14xb/0D2MYqB20g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793722277;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=S9QmmCvTtJG0FWP5byFcRaRFelUpQGR0S1hSw8HKBvw=;
	b=a51LCH2wWe6vN9tPK1fo3LwjbxRPTEbLkgguMTfP2L9ab5e37aMgEeP6YOJZVPLPjKIl
	 b3+E+5SHjkrb62/LWgBnm4E089GES+cKF/KUtrOIh8kRihAXwtpSVv5LyrSBChIfczxbs
	 cOKPSBLpe5cGmJUaSwlUFmT4w8kgJnoxzUOG/Khu1q1EfNxwIQilC/mGqooFSWX6YoaNu
	 S/t+wOgzntp3pvEFWIm0+Y/3mnPR8rBhIAp/LrAr+ce6YExa8sK14j9Joexbf7ytCQkZR
	 y3rsLUA1Qpc0K6Uwg220qvtuixGQ7LNkvq97H7gCnggASSay/ZHcEpanLylTRcK3wnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b="J4FgjV/w";
	arc=none smtp.remote-ip=209.85.160.45
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EBE66082BC6
	for <linux-serial@vger.kernel.org>; Tue,  3 Nov 2026 16:11:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3EBE66082BC6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=J4FgjV/w
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-4a77dcc4ca0so2387385fac.2
        for <linux-serial@vger.kernel.org>; Tue, 03 Nov 2026 08:11:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1793722276; x=1794327076; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=S9QmmCvTtJG0FWP5byFcRaRFelUpQGR0S1hSw8HKBvw=;
        b=J4FgjV/w8TSOM00kK846ON0fXJV4OU7ISP/fmG/R7LO4vobYs6uqc+EAXT5M4+/TX8
         IaztWyaQ1QZqPYYcFco9ig0lcHQj1M0eEqiz8nZ+RzVNNmbH3kuMfA2bthy+k4Ij/aZn
         rCkho9sVuYOODh/kW5ZH6R+cG/OU8AAX4Ti00=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793722276; x=1794327076;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S9QmmCvTtJG0FWP5byFcRaRFelUpQGR0S1hSw8HKBvw=;
        b=eovXkJLgHmF3qM+/bONzfROfckOEUHKfuV90lJOrP29P30vQWpOy6llaZ0aUP6eofN
         QObJxRhEWbtYAiJa/48TYMgA4V/E1cCEigByybDtnEzvyAfzwFZefOlZ0XTybUZzxthr
         pK3/DzLHbylv2Ao63JPo87U6+aJ3qiUpq7gl8EiYsOuiqJSA83c8MUcsd4wvS75JA7lu
         E4FnVVswBHr5I2EbpRALwFqj9NKhz6iqDalH1b05ziUYgnKXBVFbrH9G+6HC+hCI2JQ3
         SqWnrZyuKUidr5UNkjrh0c0ZnvWfjAXfTluytuyR9Lisa5R2DObCSkXVaTbDuD9IFuo3
         +J2g==
X-Forwarded-Encrypted: i=1; AKwUvBzP32DFCNbqDTW7mRdOa1e5jxS5wGOtnlsMOmxalRIg88VCTu5lYXG2W2B3b8WKdOrnhMQRwLFZh1yO7L8=@vger.kernel.org
X-Gm-Message-State: APuU4Z+qkl2rtK9CtMsFCebkvbmJ2lmwHNYfmHB/eIOh8eSS9vXyVEXy
	2nH6QFET/wzWdBTeHEpRmoezuPzVC7CJ4ZN8pvlO5QC8XCLziL7XWgioAHFxnfyASg==
X-Gm-Gg: AYBFou34Fdh2AaNpCf8BgSVT6b74qk9IT5M81cFXhmjmpTvJHV3+TGxYYTMr/JopeLT
	uOOT5Fyz6uvOtcXlDnjDLWo/dycHBdnNKFDI3gV2GdEm75TK6cLpAjiSG9x+nSXn4KeXG3SfQ9L
	pZkGA2pXLxtZtOB0YpcX08ix8Ht/qs+ee6BnYpDeIm9pPkQGvh0Drwa/lc2Iftk/IRDIghAGv5l
	rUO4OVOsssBJ8LjcRv1bTFgHXaZljvNvzgtV3EAgzDUi3qpfL886Fkk4MBxHrb8nu4IbxjZx2TQ
	ZEhKpCfjNn8cyRPvuqyrWC0HahTM4DgTb4m4HnNJ68PfaQXQicoHkN5DfTUe7YZtRIWxDRNT/cu
	6wq3Zv1FrziJemTrpQdS/IocgWxZyKQMuWh6ZtNxm3LfFwrsaJdXhEiAfdY7RdlzmywsX8VVXcL
	BPM9fSPVjQ1JgqfT17MESGvkpipj22ZWIxrvF83TOl7Ic6OEW3jeklfAMVAyG5g8YhosoiQNlNy
	1KKQVYSyuQJPgkkDWVRKbh01s5eDTk5sD8ZIb1YqqnncUvXsYqGUZu9xDtesOpvhTlj+FZOFOIv
	1s6ca18OttBE23zwE9p2ZZw+qcl36q/27j0Fl4KdzVK/W8MJU8+gEhWcOrZ/Bv7pq3+6AIsGDDK
	+1wXhvdpo1DTkNKE=
X-Received: by 2002:a05:6808:1691:b0:4f1:7c39:8a7c with SMTP id 5614622812f47-5640df628e8mr8758951b6e.62.1793722275736;
        Tue, 03 Nov 2026 08:11:15 -0800 (PST)
Received: from rrangel.c.googlers.com.com (194.246.27.34.bc.googleusercontent.com. [34.27.246.194])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-5640fd95dc0sm11688383b6e.6.2026.11.03.08.11.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 08:11:15 -0800 (PST)
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
Subject: Re: [PATCH v9 4/8] serial: 8250_omap: quiesce DMA IRQ handling before shutdown
Date: Tue,  3 Nov 2026 09:11:00 -0700
Message-ID: <20261103161104.2449407-4-rrangel@chromium.org>
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
In-Reply-To: <20261102-submit-serial-8250-dma-cancel-v1-v9-4-9159caade148@gmail.com>
References: <20261102-submit-serial-8250-dma-cancel-v1-v9-0-9159caade148@gmail.com> <20261102-submit-serial-8250-dma-cancel-v1-v9-4-9159caade148@gmail.com>
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
