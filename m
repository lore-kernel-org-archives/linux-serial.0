Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65627361DD9
	for <linux-serial@vger.kernel.org>; Thu, 15 Jan 2026 10:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768472199; cv=none; b=GFLM5yfwacwusqOIl7+1LE6hlWkIDCxaZwxw50Y+ULm1+Qas0O35YlVE8K9ZpA/RgoP/TGQOmgGwIeSeGP9jjCSXA8o9Rc5P5uAaKf7BxpDTi63CLry1AqcF8fT3wd1jBVqRiSzIOi+P6Slqs89ogYsUL0sxFyL1aIMtTsay43w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768472199; c=relaxed/simple;
	bh=zwLrvsF0GMvPSCBeAjAWQZcmbWMJVYh05GZu4CqMmyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CMhv5+QntyXBXCxUqPs7/LkivwGsU88DPtceyyu5MXjawqTXU+ZOLwOcTOPblTit+UOXIeeJoySuEhwEmHpW+R+O01hA6Y+rqyDclNvkEblrgXK5w4yEEQwDuXL75zSecboWnGUp2YCzDdFzrmdEWNCekBtnmGj0S9LaBidyvkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=O1AfzI1f; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="O1AfzI1f"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-47ee2715254so3279455e9.3
        for <linux-serial@vger.kernel.org>; Thu, 15 Jan 2026 02:16:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1768472195; x=1769076995; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zwLrvsF0GMvPSCBeAjAWQZcmbWMJVYh05GZu4CqMmyk=;
        b=O1AfzI1fLMDVa3SD3LO45cvIiavE+LKVM93UrB7hJYcD0m6yOptHdhokkT8bTYka6C
         3sXJ7mv88zLWCKOA1K4tTNEUpgl5sRbxQkPkY/JxJ39NJl8UGOMFq8kcmDmf/klRNfzu
         nJ2y1cuRJKr4oZuTg+fls6YXgf7Cmk8scFvR14UdHkOvJCMLVgfHdOWaDArlFHS8i+in
         /rjDe30x+8k/vU2nriXmVzYvgsK75zbtsHQliWEWoqaCQIzSRCmZBSVIuTAHgBAk/qqa
         BhvMnVF7Ni7MX4Rr/TPuFFrwopkxq3IhJQiQJ1qEZjzsylkwRiXGFMLOKcT5/GAwd0bX
         FnhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768472195; x=1769076995;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zwLrvsF0GMvPSCBeAjAWQZcmbWMJVYh05GZu4CqMmyk=;
        b=HGDhUkMWTqomt5DoHWRfRzeXe+u+qbPlZB0IGWoROzON8n76vGitsZL9bOBbfZbei7
         w5nYiGKLNERFbc8BmYiCHsF+MWVXZ5WxRXUeq04bN+XboliWY+lPZ30hU53rzfuEPLph
         RW6bHOzNiYuqytMdMcsLgYcbmw2aS3UQODdYCj3pqxzlBVV/rcYKttbVU0frdG4qQhMv
         52Lu4uv1ERw4d3cihNFudqYUF69VUqtRSYjevuFSBbOhFmGQ7DjBHo2apeC6wpjh4riV
         tKBW/Em1pjzFjihQ/jMUMNywclcy2Z2syVJcOb44Vb5jlrdTJGtAV4CXsLnZuI8z9BQB
         i1pg==
X-Forwarded-Encrypted: i=1; AJvYcCXLkLMpna61CLqbF1ng4i4n703r1/xYpbBfsEan+6Q6sNFX0u0L6fPmiPA95LofH9Jymx2wwlE/KoIRACI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4Sz9bTX1/S0nQwk4bqXeGdTIGsEQOgABc8kwki02aITr5g7Gv
	FLBKw1rU5l71nBfKuw44I//HD1cRDdfZq4xhY+pj+lLDpIs52JDGTx835sBEgNu0kkY=
X-Gm-Gg: AY/fxX7IK1oFk8wKOM1b12yUWBF+yXmVDih+0uQsX53vDh1E7TTakowgfyId08H8AIB
	NRnVM5ds8s52lhXl0dWSHtQ02p9uOWfVpH1DS8dI9F1aKAT4VMrMdztjAuRVa/2o0MJ2tUQcA2s
	G1j46owxhTFnGsdqufVxYgwmikbD08QfcG/TcMVwKAyYPhv5zFhTHDj5nukVcXIUSbaOvB5Lgc9
	MFoWeLLyaY8WECMiEf2jOmcT412sW3eCzb4XpL1iPsSvNq0n3nZrOa3N3jDkCwRRdRaEfNGnY1A
	gskOcyNsSR+fF/WlqtFoZfRgh4XjBv709yKc4soq1dJSuH0MZwM+X040Sh0KsHanUEOgFPLlvA4
	wfp9DDSmtuhPkiV1x6ZKrFJVNlyOdJGgFIKtRXI09WwqdBvIwcXecQdUuyvJKbHROV0E8ZIGT8n
	kRt2Ssk4/MLndb/EcB5F+7qDy/
X-Received: by 2002:a05:600c:608c:b0:477:a246:8398 with SMTP id 5b1f17b1804b1-47ee32e0829mr58296485e9.2.1768472195426;
        Thu, 15 Jan 2026 02:16:35 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47ee28144aasm39739585e9.11.2026.01.15.02.16.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 02:16:34 -0800 (PST)
Date: Thu, 15 Jan 2026 11:16:31 +0100
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
Subject: Re: [PATCH 07/19] drivers: netconsole: Migrate to
 register_console_force helper
Message-ID: <aWi-f9LBJtxGWgWs@pathway.suse.cz>
References: <20251227-printk-cleanup-part3-v1-0-21a291bcf197@suse.com>
 <20251227-printk-cleanup-part3-v1-7-21a291bcf197@suse.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251227-printk-cleanup-part3-v1-7-21a291bcf197@suse.com>

On Sat 2025-12-27 09:16:14, Marcos Paulo de Souza wrote:
> The register_console_force function was introduced to register consoles
> even on the presence of default consoles, replacing the CON_ENABLE flag
> that was forcing the same behavior.

I would add "No functional changes." like you did in the other
similar patches ;-)

> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>

Nice clean up!

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
