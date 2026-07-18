Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9BA348C4A
	for <linux-serial@vger.kernel.org>; Sat, 18 Jul 2026 12:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784376314; cv=none; b=RoBzlW7vpms0rmm6NdhA2XDZfeVRX3JFa9P1qmK7MoFSVhPyJNFVSO4Nw1f/9LiFEBSxw/EtFsyRtb2C7CD6Dh2Yn6N6DZqehNn1w1IQW7TfEzVnzoMThX5C6QwMm6GH0820JQtrwjFB1W3opWwPp2KJal19h7z8/C16c5b/tXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784376314; c=relaxed/simple;
	bh=UVQD7xZC19STANRHQeLYYOB6lofOMAO1isLrdP9clP8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kHnIccrSYveibMdcJlr2EmuMPbYubJwyDCEDtsSpEEd8dh0g+J4wosBmUtfR8JU13qa8nbenJ60zM+T3+fAMnf3okf0jj9lZKHpq0Nq+7MmEWnUIaIhTyo9ge68RYgblnFUCFNJdkIqvmHnFxLYVvizM+nY1LVYWevTQFZgDwoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b44ecTjp; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b44ecTjp"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-920f33347f5so663081985a.3
        for <linux-serial@vger.kernel.org>; Sat, 18 Jul 2026 05:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784376312; x=1784981112; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3Up2YZHFeIMQmB6EqO7RZlnVeEM60lSIwrWpc7fQrQg=;
        b=b44ecTjp4hdjoe+OOrr4kGpa4Q7ndKzI09TU3MlJ72kQCbjsOq9TCyCPHKM2AUbbHD
         lgupABa4+TLiROvIwAuwyPb29i/3IP687gMvUGwp500bxFxb1AhulwPC8wa1qfB24YBi
         lX8zijbNiehqhMJp1p58kcHcWXAehwnNEVuGbGX5KI64MJsj4Pqvu4ULzou5/aAdTljw
         vnErVcA/Lpe0Ju0oqMIrwhwClHKS/EwpI35lbU/vzRZpl0/P6hfrs8of2gRfPNFt5c+f
         lpPKobDzYm5aDkWLs6oaBzvMt2wsKFUPtVeP2G5FwCuJnNgne72zZrVpc0VhBryMD6Ik
         oFzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784376312; x=1784981112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3Up2YZHFeIMQmB6EqO7RZlnVeEM60lSIwrWpc7fQrQg=;
        b=pfxk4x+IiIIsVqZKzthR7MFPoMxpHKsPhb9N9vk9YxyWMWHSf6zqKCCKNP0enRxOcP
         y1Ns8WdkrOJdE7aLGeq7wOV0U8SZZ5hJxEKtzAY60/kHNiAIomRY78ZygmGxf6c7Lbpn
         N0tyyAgc+q521UEkOjhLLukWL2so3/TbKK6NRxPebphHfr6ggCmU443STFdKHhyd31ZN
         LKCgFVJrKF0vVPl2GNZY7ima90qOsgyRvetRa013IUVfichu+H9wPaAGN+0R/uAsvGCc
         qUdv7hIbi+g+SHYlDQpvkpLppLBehmXlQGHMRaK48BG0miYLSKM+Bbu/LuGhXKndbuwj
         1JSA==
X-Forwarded-Encrypted: i=1; AHgh+Rop91SLmbZTIQvKh3YvBWBf/Mib9CsbZIl1NdOTo58X18WqqeZbrFtceTfb2zJPPxWP4rB3HXIxAtjAQ1M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYeH0SpdpD4emErHNEuPw2J1Sjay0u3BCu+lAjL5giFOvXh7vm
	yLYxYKhi255woa1ZTpCw0uKPYe7XN0bjxbh65i9e93FZOwT8e7YnpJETgT7sDI8=
X-Gm-Gg: AfdE7cklZaBMwQX7CmhGxHCdS/U6CvSkDSq16vo0uzuYzKCWRedlgn/xZ8B38+hUEhH
	P6gN479TgwxZh2GWoQJ5kdj0VHdZLV0UPrUXLSD7AV5WGFQuFxJsVERl/QQBtZIKvXc/DvcIgCb
	RD+EqYqaSeNI6tvOebuD135kZjHe9k6qPAbAhSSqQxD28HAFBcLTrmqoUOHcLj0WCIgnIHsMvEE
	1X6VqCrfTJHTZtPKUkPxon53seP4Hg610gRwdylftDjtwxtnULsFOFBlNSG1bLny404RI7qvUXE
	hCxltb2bsMEfxlja+DBzqAKlj1Ah3cIt1GFWcX54COYtprk199UaFaRZkGzg/W4Ib813RlL+CUP
	WimVUwpdcVsn9FiJJuwKZnXRcwuJyEym0MAGNvjON0ck9WH03IGK1JuhEHcp8M0krz+4y6o64oq
	FZZ0pLyk1yehCfyhbzJY6MMLja290IVFsI3Ls3nkeGN7Tc0Db9fqQtRzI=
X-Received: by 2002:a05:620a:198a:b0:915:f27f:e70e with SMTP id af79cd13be357-930b3ee61a0mr648064685a.23.1784376311790;
        Sat, 18 Jul 2026 05:05:11 -0700 (PDT)
Received: from NAUTEL-9N0B043.nautel.com (host-76-11-42-59.public.eastlink.ca. [76.11.42.59])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-930b549629dsm389690485a.47.2026.07.18.05.05.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2026 05:05:11 -0700 (PDT)
From: Ryan Wilbur <rwilbur633@gmail.com>
To: andriy.shevchenko@linux.intel.com
Cc: gregkh@linuxfoundation.org,
	hvilleneuve@dimonoff.com,
	ilpo.jarvinen@linux.intel.com,
	jirislaby@kernel.org,
	john.ogness@linutronix.de,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	manuel.lauss@gmail.com,
	rwilbur633@gmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] serial: 8250: clear stuck RX-timeout interrupt on LPC32xx (PORT_LPC3220)
Date: Sat, 18 Jul 2026 09:04:36 -0300
Message-Id: <20260718120436.20196-1-rwilbur633@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <alpsOr5ZVqa_eLs9@ashevche-desk.local>
References: <alpsOr5ZVqa_eLs9@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, Jul 17, 2026 at 20:54:02 +0300, Andy Shevchenko wrote:
> > +      * Same bug worked around for other 8250 cores (8250_dw, 8250_omap, 8250_bcm7271).
>
> This is 8250-port.c.
>
> > +   if (port->type == PORT_LPC3220 &&
>
> Why do we have this then?

dw/omap/bcm7271 handle their variants of this in their
own drivers. LPC32xx (PORT_LPC3220) has no dedicated 8250 glue driver.
  
I gated it on port->type because LPC32xx is the only hardware I can test
on, and I wanted to avoid changing behaviour on 8250 variants I can't
verify. That said, the read only fires on a bogus IIR=RX_TIMEOUT with LSR.DR
clear, which a healthy 16550 never reports, so it's harmless on other
parts. Unless you object, I'll drop the PORT_LPC3220 gate to allow for generic
handling.


