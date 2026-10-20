Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792493286;
	b=iPA/XLmagYGbcpGGqZ8LUNfX7bFBvg64K7G/WTVLkoT7anZeK2xsfUfEkpmEJT8exNm2
	 a+dPR0vI62PPrI9SiVo8l4TEi5tpi4IfW6icpkdoWGmW2FMaEQIJ0O4Xbqu+wohANeywz
	 bQXER2lRGN72GbcJqCR+gVop2ZPUzoXgQR4UCLX6MpQDBNOH9toBpHyxjPIqwwtEEF6vn
	 PNdoYW6OTRdC379thuciX5q0fonpor+StOLCS91b9+QqITs2uLgEv5oVPpwW3OsqE7vow
	 De32HamcrFsVE7teEs70ZJIixj+qxe8zoN0PetypEt0pRj1A4qRDbftxikMNFka1QLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792493286;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=6I3hZn5IrrtMWEjXHuQurKyJm+2cM5wqnfTX9gelMt0=;
	b=t21heN0BKC3YpyR//qWiSamyUvHCmawMVaCTf87BNqKid3vedH4jUQ6YR0dZl1sopYn7
	 PN9OYQslmUxrllQFyKwFMIHLQ/lsFVKIM6mECtaY+lFBCYu6J8K0D1tVuG2+W7vcvQt7F
	 mhFNHr0oA2t2/7SkQzWLL82etFn1j2bliwGnAW6Qs7okc9IKOrcVstgAI/PuIhdlIwgAo
	 Q+Wzlyys4oJPx6C1lamtyOV7nlXmIbIZ/6kHg9oukhWXJ5i0x0ysucHY3Y820Tchq8GQL
	 b5XJpyeAuHceCci9PzwHNIUhf68Exh9zxyLMuGrsuXtS8QJnDwB2VFUASKRd4y6EL5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=fiGsEbWV;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3172A60A2610
	for <linux-serial@vger.kernel.org>; Tue, 20 Oct 2026 10:48:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3172A60A2610
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=fiGsEbWV
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-36661f953e4so621799eec.1
        for <linux-serial@vger.kernel.org>; Tue, 20 Oct 2026 03:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792493285; x=1793098085; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6I3hZn5IrrtMWEjXHuQurKyJm+2cM5wqnfTX9gelMt0=;
        b=fiGsEbWV8Q8RM6j7ZxuVSvjNOICcG6msaUt4ksLEKv+iwv6d8mxyjI+a+1OU0I2GKw
         F6luj7kc9MNOSHVKmv+62GQZAdeQzjs0durajglBeRLj++pSzmkAq961oZr4j8SXZELj
         JXdXl+6PIKVfjB48KQKvWRtyW8qHoTRIiGHSLRi5EVhek3fVAbfA/y6+onr+iY2O/bHx
         KMmmpB8oRIDXzcsu3MVc8a1X9tfsNan5xDoWsVMKchyzXgoTALcRdTArn7Q0oDFxM1fp
         glTTGMeSvFQkiHXwWmnRf74xc/RdAusZLhgtR0DICZDjNauabVu08HwZiM4jWCxGQ19J
         SS/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792493285; x=1793098085;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6I3hZn5IrrtMWEjXHuQurKyJm+2cM5wqnfTX9gelMt0=;
        b=M/NeQEtka/tprM51jdotKs65S+2ZwzCdI/oVeKHbeQbhQUPus+AARI3Cca0/ryQNax
         5yGwTuj2BmNHEg0ANa1DqUCqB6O3dwDSnChf8jCDHirFOQ0eKCyUazhKDZMpsZ7JAlfm
         RmFbIa3uQsHXsXJYGy6F3rQA9r3oaZkIoiaDJ76KB/jVFDBSxOVPnwgR65gtMiEDhfMf
         6GB/zWa4UbY5IPEtPBbSsvwNKSvgTe9iinL4fxnaIAiPkJVLYPRB6AVBZJmba6W64qh2
         MYNHef6SbSkmAmQa2I1l6RKEx0/V1wsCV6rWjp2qbU3dyPpGZgCrF90MiPDzoe1/UJfe
         jMZQ==
X-Gm-Message-State: AFq9FYLCrjEMEW4mNjAncUJIdTELh04g4meRRdz2vgXlIEWWmxwZtnXz
	/T+ff5jsjLyuNuOlMYOIn10mMc7vFhKEATy0dbXo7rYFRjvwARnZDE75CI0n4yfoNaVLeQ==
X-Gm-Gg: AYBFou0zT1AzyiNCw4WyorwMDzL9WdrPd0QzlkoqlePCeatmhweBskOd2Mk9f1a2YVZ
	RYeSWXfdNyPAbNMBRIvLvdbQP03R6AEY+fvgYV0jbEE0BJKk9l7n4xDVmc54TsOWrmgfG96Vj9H
	OW2hlsT27sx6sF3ZngbMa1WCOUALM3iqY0HN8HaOeYTMph0w9Y+dVFnyrK0TvogqNN+p4tlkcsV
	/A1QY+M8GYeL9tCPQt13fKRZ9T8T9t7tqhb9ohTDD2G9gXFU+ZAa5BSO/SDVBDw9GUI3EFBxrj6
	7eBHZ1BXpfXcrPG0wr1T2psVVojwXvyINQ+OOnKr3WogGcD4l9T9xm2IHNVIc3oq52zEppBKUaq
	GaRnhIbdzkkjsKiepT//lxm1O/JQ+f3Mcg0dA4KBwwtmqjxM6uDX07z3kWm+N/VBFa2ogpeA8EU
	yJhDD2uKVorYr/YQSynVHl2Iu+XkYfVkaY3yhO20FizbcYMHtfACw7CHZov1vpptPxfgc66nbIS
	56uYEq6AvbEvMDTfqOfUcgkd2ZUj3/HZ4mGZf4/NXQViTPt39hqpNamQMpMSpDqU7iPf3IpkPkC
	ifVAR24=
X-Received: by 2002:a05:7301:4305:b0:35f:227b:f8bc with SMTP id 5a478bee46e88-361a1465355mr13074342eec.11.1792493285129;
        Tue, 20 Oct 2026 03:48:05 -0700 (PDT)
Received: from MaquinaLab.. ([179.179.238.247])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36081bafa7asm39596320eec.14.2026.10.20.03.48.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 03:48:04 -0700 (PDT)
From: Vinicius Pedrosa <vinicius.eduardo.pedrosa@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-serial@vger.kernel.org,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-sunxi@lists.linux.dev,
	Andre Przywara <andre.przywara@arm.com>,
	Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Enzo Adriano <enzo.adriano.code@gmail.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 1/4] serial: 8250_dw: Keep the BUSY-safe divisor hook when DLF is present
Date: Tue, 20 Oct 2026 07:47:53 -0300
Message-ID: <20261020104753.28703-1-vinicius.eduardo.pedrosa@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <atcrpTI_R4kRM8pb@ashevche-desk.local>
References: <cover.1792439398.git.vinicius.eduardo.pedrosa@gmail.com> <cc358c2be6b0b4ea0323e4f694a581ffb667112d.1792439398.git.vinicius.eduardo.pedrosa@gmail.com> <atcrpTI_R4kRM8pb@ashevche-desk.local>
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

Hi Andy,

On Tue, 20 Oct 2026, Andy Shevchenko wrote:

> > +		/* Keep a hook the driver has already installed */
> > +		if (!p->set_divisor)
> > +			p->set_divisor = dw8250_set_divisor;
>
> On top of my previous reply, why is this hunk needed?

dw8250_probe() installs the BUSY-safe dw8250_set_divisor() before
dw8250_setup_port() runs. Without the !p->set_divisor check, detecting
DLF replaces it with the dwlib setter, which is the BUSY problem
described in the commit message.

> In the case of existing _set_divisor, do we want to keep the possible set
> _get_divisor as well? Shouldn't we introduce a respective _get_divisor in
> 8250_dw.c?

8250_dw.c doesn't install a get_divisor, so there's no existing getter
to preserve. The dwlib getter is still needed when DLF is present,
because it computes the fractional part used by the preserved BUSY-safe
setter.

> But now I see that we have same function name in two files. Can we rename
> those in dwlib to, for example,
> dw8250_get_divisor --> dw8250_get_dfl_divisor
> dw8250_set_divisor --> dw8250_set_dfl_divisor

I'll also clean up the naming in v3: dw8250_update_dlf() with a frac
parameter, static inline after dw8250_writel_ext(), and the dwlib-local
helpers renamed to dw8250_get_dlf_divisor() and
dw8250_set_dlf_divisor().

Thanks,
Vinicius
