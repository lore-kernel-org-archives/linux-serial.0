Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D99D396B7D
	for <linux-serial@vger.kernel.org>; Thu, 15 Jan 2026 12:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768479891; cv=none; b=D4BCahj9U+7+6aoJfOmEsmpiYqBdcrLQDDETqlhVNE/qb79x9MMxzN0tEhfjFpco4vPo6Gv/T6at37cPzs5Ww70q2DebjU8Fgg2wJZGaRguUH8PZLFCQFHu+yyKxONlh/XuDXFQ7jCjNnXFS3XEJLg1F7AhDZtQYa8iUjflxKgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768479891; c=relaxed/simple;
	bh=L1TTyH0HQfm7i7n+eqeYhrSGiuwmELmvtw7QQ3GNH2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i3DbBdfD7wRTyk+Gq7U/G/9GyyHVBL25CjrEdYKvAVglhv7yiwoJ47nbfjFUHpYzBIlN4sC8UZIYMi6LVXbocjaEDXWjsk2Wj9WI6yrUaS/aF0kcWit3s5djnunDNKSEJpeSeZU62HKAtrZvs0Q2rCw5OCYpHgJ29qHAwgZOsEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=AavSW8zD; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="AavSW8zD"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-430f57cd471so530312f8f.0
        for <linux-serial@vger.kernel.org>; Thu, 15 Jan 2026 04:24:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1768479883; x=1769084683; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jS491F7pY/6VV44vwrzsFaAyA9RjAqjEAkamZCNInAE=;
        b=AavSW8zDa7wyUQOrKCsE5mEiLhCbCgtNLUJDLiygsCIz5MtcNfL5qg5hmiFSH/hnLF
         dY1NM5kxU9pSW9DgohxUfSzAVt+iLYuHkRY/WkdFE1XVmgvI8pljiAwerID8UL6g7PU/
         eolJwYFX6Yj0B7yZch1EvVk8qqbK6y7rtIhghbakTGjeNT0IeZm0hOjwyUU0ncWi7Ohd
         fORx/nYcwlXu0aeT6z2nysNJs2vxMwjVnQi03RkyIvPvmebQbr0uJa/GOMbQXodXURQ6
         +ZErOfCH6CKBneuJM1DXIQJeb7qxioDN+X5ZyEYo1486PL/QTstgRmV32S5n4c6fMV9G
         3dqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768479883; x=1769084683;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jS491F7pY/6VV44vwrzsFaAyA9RjAqjEAkamZCNInAE=;
        b=vCI3I3u1vINE5QhZXSh0JtYh2ZCJy2JW91LcOHvx/AaPjpWKeGJYd0oLcJvpeaAlyL
         Qqsy2SjmSqCSGOvPRuRrs96GUIOw/TKcyQwpxB4ZZJiKFnrPFgL7y8eaLWdaOETibGpf
         788vBn5g51mNzOFItjlCK1y3D+Jr03b/q8O7IsSFKx4iFuXAxoDuTi+fGTbgtWs4GNtS
         6c1sC5cbMjW68yan6Y3oTTeiYhX2JwkyRx5hBP2DkJA9tq1BNiMheuZuKB87wvtfkC8l
         clqU8t/zVWsKnAfIUt5lcjFE2DXMLG1kU/lzCDkhIxeo1HxDWaXlCXcEEz3YTkYK1V+D
         6PbQ==
X-Forwarded-Encrypted: i=1; AJvYcCXcDPV1RIFC2I+JZE3Wns5Op0U0yHlbqTrBARvUwzpfSEN5ueJx6iwVRxG3I1+qOTlo+x+8aNMiPx9W7ts=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhjiVIjQqk6hDuECv2tBXmaQuC8BmJMvnZIVvNbOfgCDTpvm2z
	fuKViL+B38d9PTl7TbALhJ9LnGw2x84sT2UFB6ZHVK1I6ytm0tKO0uMqSnZ6iPo9uBQ=
X-Gm-Gg: AY/fxX6UakfzIQTLgTRMcqckN5nM4P/piobh/D1Y3+INgSuczT7gciWEhPtsg0IODTC
	7is2lgdfqJNJXAw3xIssjmLUi5ZrNahXa7ULPT/xRa/yTTgsIJ2H3cFR/CB29Czl6+tvuUkm1HM
	sUARkHb2yMHK8C3ADBHKdTugaaBShciiZ1SdgDes9P9yWxe5m4fRnkZ/AjB33EFWOJP0zAIE3hX
	/el05uZs7YFMuiXq7CmD+gvcOLBYG5tPsLhTvSrCy3Ho7F6gRtQN5uj/96g7WR+100j9ekdBdhi
	BPOBpUYnDLuxgHrJEKkVQEuKLOTf59c65aiMnC91QE7VqfmYKsdAZIu2c9KoiC/YUTNY6WoCJuP
	BjqRxj/B3kF0rvzX/Tw3gAAOuvcD8+LBSh5wGiSNDnDL8ZuzSVU76E5ErXl+lrnM2wFWLVPpGwy
	dc+gWZsMlKVFn84g==
X-Received: by 2002:a05:6000:1789:b0:432:5c43:64 with SMTP id ffacd0b85a97d-4342c547aa9mr7495008f8f.41.1768479882771;
        Thu, 15 Jan 2026 04:24:42 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-434af64a650sm5653238f8f.4.2026.01.15.04.24.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 04:24:42 -0800 (PST)
Date: Thu, 15 Jan 2026 13:24:39 +0100
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
Subject: Re: [PATCH 13/19] um: drivers: mconsole_kern.c: Migrate to
 register_console_force helper
Message-ID: <aWjch-EcYm7tkF0t@pathway.suse.cz>
References: <20251227-printk-cleanup-part3-v1-0-21a291bcf197@suse.com>
 <20251227-printk-cleanup-part3-v1-13-21a291bcf197@suse.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251227-printk-cleanup-part3-v1-13-21a291bcf197@suse.com>

On Sat 2025-12-27 09:16:20, Marcos Paulo de Souza wrote:
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
