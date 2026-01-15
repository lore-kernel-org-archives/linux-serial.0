Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC03395242
	for <linux-serial@vger.kernel.org>; Thu, 15 Jan 2026 12:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768479285; cv=none; b=Q3oHVFzX1pgadFm+XnNCtf7Der1THHdDBiNGao1417HOT0Flpp8OwYrk8YQzNpRdMBQkQAt4WXWQea6caBGV4yXoK7ZTtCN9kkllOMF5u/3oN+F5q0XReHnvdzbP1lS/fOXac37C4HWo6J99gxyJXimKZ/cHAG8nVoL/w/peSJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768479285; c=relaxed/simple;
	bh=BMtROxTlhcEjGTvjLejFDk2Vbg7ExK2i/Mb0lDmT8j4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aJ6yYiIlLD4Oq/JMuDsZqB9qjUdln3WbVlO6Kl88P9DzIxHj5cEQsUW36KaQFnJuzFhcolZxMaf6UcIc8ebjz6sK7JciprWp8i1N8NvtFal5RoiLU0CtfHdgrCFXjVcEg86IqSIg0Ljf18pbVdb/lNynrnT4/G2ke5yqaIMnr/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=QC/gWSUS; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="QC/gWSUS"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-432d256c2a9so830073f8f.3
        for <linux-serial@vger.kernel.org>; Thu, 15 Jan 2026 04:14:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1768479281; x=1769084081; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zx4s5ogULMWiwAg3H50k8gmoVyZOh2DwfMGC+/dY5Co=;
        b=QC/gWSUSA0EAhwaYo46xYVQT8Y1ECjcpRFmmp8NFZI6gFeOCyv54QFoONL0zhD1tRb
         Wpjcalm58F07U7X6X3ElfdI2aMbZTcQHAaMqiDAUqfii1xPgbxHV2Rr+MHF/YquIzq19
         ugRBOmWQG091YmUU32AncGeAZWhNkTR6Mp48MmebVJnSiapVRAPhk0nmw029/JzlyLO2
         3wo7/niLOkIcJq11YHaoiZlxyk5NmQWmEdSgBJiPdg0jON0WU/DvEZu8cMJLNsZBeVtR
         QXw0tRC6Us8sGCxg174oOAPWPaE8M/fVUYQLmZ6JJA8mAowmTwqll4CNctmANwjapfcO
         OyuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768479281; x=1769084081;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zx4s5ogULMWiwAg3H50k8gmoVyZOh2DwfMGC+/dY5Co=;
        b=fXU439zC+DyHJSRwL8tc9X2VAa777YHhnprMU+Ec2VTC/YE6isYyJ0S3TlQAj2MywD
         DNEnKyvMCx+wJFCeeCPyhprUBQSUSHC5ThM3mU2JBLbefsAw0CU9D7RAoTBpRpYKQPj8
         vinpBntR1d71sj3BLl2uyJPWIOkCuk9TVoOoo+ce2hJHcuqVLhl9pvTZoKlgHX15/rO7
         3fNKngykGGx3qSSX6U0FRQGdQIqlQv5na3N50dTEhfARJlu8nsVpMH0rhtPX313czf9M
         53ZAKqSoqA4dChfQvqM8wBOdh0lSjrb7H6jjoYJcrwdu+l4uDvWjJRu3bLdp2ms+acP2
         mRxg==
X-Forwarded-Encrypted: i=1; AJvYcCWK0n2kc9GvcQbNLQbhX18caS8wogD6SLWOwPYdrc/fnT1FZcvrvpyNNRYZRBf0aL4JE22FJJzas6nKBWY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzM73Dzk5jyBKkBMPylYxo99gkPbJf2RWFxPt7XpPDHdajJofs3
	kAcIBaHEX5++WXozJG22qr0/dlNDXz6SCvQSYE/L2R4Px5CXIKRjaxrY9xTbtdyOOdE=
X-Gm-Gg: AY/fxX5cecaan1WM/2XLoz+eADpphEtVoIc79mMFoiARlXM/R6H2H83CTqqKQGCLRmT
	Og04R1sC2RyLm/CscEoij5FW+zsrx59ITnHcz5h4F7PXTtQQemovo/8K44v8ELbrlMatsMT5Pkg
	crFmiItf3q+VJFyeh/hfZt3XqO4l+7YzT6Fvl79g1MGAqiZsMf7B7F822wBx5Gtq+luifaKvxA5
	bJzMtQKxBAVI6109lNLQeyPEoRatjdPjPNnkl5ep4Pg4kXQOg1l54IGPFOXkpppKj32cubmCW+Y
	qYzLBAbZYNcM8jsB8GZc9uI9CyHMvm9QB85iOLkSfa/KZP0DcbMpHRQkGGyc9z1kCDiMhJLkyCg
	/F9N+B0JQ/8smwKVQBbxMagnoUarMCQCAMXnxSwFGU0UXykdyzs6eaI0lhZYPWTQ1xCS5jBaRc0
	Z2EoYcpxqN0jFeMw==
X-Received: by 2002:a05:6000:3101:b0:431:abb:942f with SMTP id ffacd0b85a97d-4342c557b93mr7715812f8f.54.1768479281353;
        Thu, 15 Jan 2026 04:14:41 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-434af64a778sm5591185f8f.3.2026.01.15.04.14.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 04:14:40 -0800 (PST)
Date: Thu, 15 Jan 2026 13:14:38 +0100
From: Petr Mladek <pmladek@suse.com>
To: Marcos Paulo de Souza <mpdesouza@suse.com>
Cc: Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jason Wessel <jason.wessel@windriver.com>,
	Daniel Thompson <danielt@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jiri Slaby <jirislaby@kernel.org>, Breno Leitao <leitao@debian.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Andreas Larsson <andreas@gaisler.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jacky Huang <ychuang3@nuvoton.com>,
	Shan-Chun Hung <schung@nuvoton.com>, linux-um@lists.infradead.org,
	linux-kernel@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net,
	linux-serial@vger.kernel.org, netdev@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org, linux-hardening@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 12/19] sparc: kernel: btext: Migrate to
 register_console_force helper
Message-ID: <aWjaLhzRoTLalIrM@pathway.suse.cz>
References: <20251227-printk-cleanup-part3-v1-0-21a291bcf197@suse.com>
 <20251227-printk-cleanup-part3-v1-12-21a291bcf197@suse.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251227-printk-cleanup-part3-v1-12-21a291bcf197@suse.com>

On Sat 2025-12-27 09:16:19, Marcos Paulo de Souza wrote:
> The register_console_force function was introduced to register consoles
> even on the presence of default consoles, replacing the CON_ENABLE flag
> that was forcing the same behavior.
> 
> No functional changes.
> 
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>

LGTM, nice cleanup!

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
