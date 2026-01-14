Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A40739B49C
	for <linux-serial@vger.kernel.org>; Wed, 14 Jan 2026 13:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768396821; cv=none; b=OBydUxkz0628vGr2kDyNQbV6GpcCULCuevQZDi83U7/Xjdb0rpY8pBvPkuOTwq0cC1Y7Mh89q9cFHJhItuFJm7N+Go4yU3C8/tEYFp+whdI5OqaJuza9GN39cwa8aTU8Gbx5F0iQ+2JNI64tVfeme/3jecr2ErboJY6SnyQ6puA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768396821; c=relaxed/simple;
	bh=tXOp5Q+91Ev71kEJDwNUHqTl/QTwmM0CMtRXuMN58II=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=es4PXDKi1uNty+1pc6M438JxMnvh1pWVZ1Ud4LvtJlEokgVqdapPrYaUcKtoa2NKZV2c1p7wV0RDqhbtd01ntIi2LxSOLfaaEualLIVgqoTNov+inUxSHkkAiuwFNV/SvTinfKiMk/B0U6JjweZdakLZNLZnWW8/gnB8Mp6gB2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=GlebQonK; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="GlebQonK"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-43284ed32a0so4500619f8f.3
        for <linux-serial@vger.kernel.org>; Wed, 14 Jan 2026 05:20:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1768396817; x=1769001617; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sWiGwjTB0ZEpbDkwRFO+MVJzM9uZpDrSFPQIlzRZfsU=;
        b=GlebQonK1BdB5DbGUyi9LiHoN8EziU92CFCkVI0QFOq3zEhwH6N5lbaRdR+rY/gCBJ
         Fg2NFXOcXLM1sjMYh2EL+pPASArlb7dn5JYQ7xAsAHxn9ooNPyk8HFEWSqJ0AKiLb8Jy
         OQSWVcr/+nNTLUeQmGlmWpTFmRkrVv42YP0mJNxo52tq3Z9CmAHgnisMw8pXZTj3j6iw
         W9dqlfWz3lgvzZ7jhta9fOBYyatVRtFEe5eB3muxZaEykIAOGsy8r+eNHdfFZhS6yWUF
         ROqkPhLwPP8lxjeZu4RqCxL6fdAD5MnzbZZlLD2XpYbBoT63LePeeYvof/5bXqQB6xDM
         DGoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768396817; x=1769001617;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sWiGwjTB0ZEpbDkwRFO+MVJzM9uZpDrSFPQIlzRZfsU=;
        b=n9FZGbNHvgpuhEPX+mNP4+ShASYyChuOQOGXTs2jGvlpIcExt/3PDhR8S1kpu80DLs
         PBlp3AfdLGPbxIaaWZNG47kNyj95FPxreEV5F35q2mShAi5kDG2ctH04lG8njpL2bYbQ
         iXzD7MMCFibHJaRl3yM8Qf1nys8YH9xVAUeXt4taa+c6PtSYHE9XTrVd1Lxkj57GlhiH
         pT0Tf9/L6faeM2beD0Ue99wscJEazAEegJpiD0a7QjitnSzyQwN9J04y7h8V8cTHmMS9
         sp+VkJW1DVMROnKYtL9xe7g8iW3ZcVZ6NsFacR914QZp9dFeWu4TMOO6Myxq3Cl1EGBm
         oz+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXjryrXy2cab9IfxhczN5HdsU3AdNALFWzAGaEsA0MF4toZ0eArSZjtAGpjQ+hWgJVh73DjGAYt8J+390s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBn+mMdlz85wgqGmUB+Mpj/d9vqQgB8O7XJbic4Iox5RsMrT9v
	igfiDO2KncYrwDM+Hgodcbc+dYgwuXpGTGVwWMf5i7k7JtxnZ6/AML3m1d/scQ6y970=
X-Gm-Gg: AY/fxX5fbZamIQ1Y7lGl+5LhWl5v4cG2Au6tXkR9C562YlPIT/+oHBGjvpONQwvT3VJ
	m7ut74HWUiB1MiBvRBOt7H4ADNqe44ds95X3Bylw5sAYjaoj8t276cCXvr2ev0+/bZNsaoY9Z/k
	fFSiHwkmvYtgJSVNV8u4ztLcKETl6Xb2xegctCxg1zxmtoZr5/qsAp4U+Lv5XeDqFFShwPSGgZP
	LqMCAMFixZdRxshyM2JBsSHrXWEGZDVMlttGgBH8Gx27lsvM0Owbw2ZKm4rSP8YQryMJr1xtIpg
	DIYtORxxicEBLk7on9aA4TOhjUNAC/DxMaJD/9amHzsIMrszirsUkiDy/Nw1CPILjoMdY1bG0Uh
	Ho3L0Fm4/pPMtIbQEziOROhj+sEGobUcJnpSgPb8Imbpwz6J11FB/4y6HJv5foMcDfvl64L/gDJ
	op2RdMOLOtPxqKAA==
X-Received: by 2002:a05:6000:2511:b0:431:9b2:61c0 with SMTP id ffacd0b85a97d-4342d5b2ab9mr2581603f8f.24.1768396817421;
        Wed, 14 Jan 2026 05:20:17 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd0dacd1sm49153435f8f.4.2026.01.14.05.20.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 05:20:16 -0800 (PST)
Date: Wed, 14 Jan 2026 14:20:14 +0100
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
	Shan-Chun Hung <schung@nuvoton.com>,
	Laurentiu Tudor <laurentiu.tudor@nxp.com>,
	linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
	kgdb-bugreport@lists.sourceforge.net, linux-serial@vger.kernel.org,
	netdev@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
	linux-hardening@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	sparclinux@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 05/19] printk: Add more context to suspend/resume
 functions
Message-ID: <aWeYDoMsdBNkJEqO@pathway.suse.cz>
References: <20251227-printk-cleanup-part3-v1-0-21a291bcf197@suse.com>
 <20251227-printk-cleanup-part3-v1-5-21a291bcf197@suse.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251227-printk-cleanup-part3-v1-5-21a291bcf197@suse.com>

On Sat 2025-12-27 09:16:12, Marcos Paulo de Souza wrote:
> The new comments clarifies from where the functions are supposed to be
> called.
> 
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>

The improved comments would have helped to understand the previous patch.
I would either merge it into the previous patch or switch the
ordering.

If this stays as a separate patch, feel free to use:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
