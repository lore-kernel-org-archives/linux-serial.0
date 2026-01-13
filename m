Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB43C2EBBB0
	for <linux-serial@vger.kernel.org>; Tue, 13 Jan 2026 16:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768321559; cv=none; b=rucerL4kCrkylc0nx+2HgQymmKs1Rr5M9/MsuSB5vKwJceuq5XEiSEqkisD0T0G7Tot4ReddQGbmA7cMoufrWZGKzBeUHqJB6WcsgoNymZrLiDeHY4ZWICQxW+ROL1HeDmDGMDQU3z6R+9a+dREPQHLkIzorIXIsXlKy6PAKtIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768321559; c=relaxed/simple;
	bh=tEU15hlDUcTJJO53/6hArpv/PNu5aaHiWIXc6QqAK0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LMLTVu/4ACUq95fYtFOxXwGtbMIeL0faIE/NoRQ60y3zp1HQlBB2gZjfUFkUJ8Is43cuafQGMDP00CB8ap5mi9Ypwzp1NaJRGE072+6aoj8rDwLkTh32hTIC/I5rMASFc38r+7DqhYiOE9W7vttZzVx1Q3XhqYuzkK3HXjg0+eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=FGSyEuus; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="FGSyEuus"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-47ed987d51aso8637325e9.2
        for <linux-serial@vger.kernel.org>; Tue, 13 Jan 2026 08:25:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1768321556; x=1768926356; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=y9kSWtn88k+QkPqpOG7NN6Fxk/gRH5gvJVVHZoYjlVA=;
        b=FGSyEuusFmgrT0XsAUYKc+T1x7+rMlFZ0ZDJ13+ibdAuF76j/kaYXC/4SYPu2aBOzQ
         sHeRusEJOZlBU4pbpvtBbiDdJoMZd1C8STFiLYT/KIQa14Sw1fkPw34aAflH83PLQL+E
         lQR4drZq8Q5FQW+pDM9NGGnj7rODVJPPGbaek9pMRPTC2JYDDJnEsSV1L3tmXyJFlBce
         BANRLJB0M7OgWSLC8LtB9994Q+ZAb/3YdsfFwDbFrYniG2Zs44fv05yeLk2yV47Q0SVz
         J5yGi5P/qBe7Gbq5lz2kCYqhMqNJ263/zAzb+Zz91mt6v9BC/otd7447j5yJTlJXGXt5
         VrqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768321556; x=1768926356;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y9kSWtn88k+QkPqpOG7NN6Fxk/gRH5gvJVVHZoYjlVA=;
        b=QrC8+bbhexAFC1ult42r2DydASwueMCy6qusNOQKqCn050v9H0F1iAFdlJJYTeYVqa
         w+ObCZmVN7VFPQtLTDcD28k43rlW59Ob0Trq6N+7epR4ZRfllqQX2YrXm+kSJ9Fwi6Gc
         la6TjhHTa+xYK/g077P7ZpRRCkLIm4M3rXMfviiatQMxSp9Bm+ksg9f7o5UstQWBxs8s
         I/WJ5sPdZG5jtQ8HpPQEijBxkq1eWgR2+X6fHwQ2emS90Ip78PqamyWso8aKcSPKtUKz
         rMOk2XNcYYw5zwNjvPKOiOv7Us6vFthpjyBc/1emmvrL5mGstEGqrTj14tC/d2iIzSPp
         Qh+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXM8AKs5EunobhZT4FS+c19nosUc5RfCMXLxMqmZeTTUwloBNsZXuEF0eF5Q5/1naTS2jskv0ZQ74iv1Jw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNzcFH3zNBxg9knL9Y89lN35Wm0Sos4Nmv3gzW51mllVga2fsn
	Om07qkG3kY8J0rXrBkqkVJ1Lsv/3eCM9PDSHTeh6Hk1FuFKZffZcYyCYyusMboRNj0Y=
X-Gm-Gg: AY/fxX5vNrS1nza9o7q4JSovLOTpO4dI201NUvkdo/m/RfzblQd364zxYqLKVxTbH0k
	oeF2PtVh+ecjhX37fFGdhJD04G1WWlJBzZDJqPFRDeVdEdEjJ1oxcCjOx31xkkGBYwgO021ykHY
	p03VETDYnyGoZdXVs0Sws1WRcp+JjsEJa0MxGyzhjMLrmat/w3GHENz8DtMCyrIw7lasfcR7WOh
	pazk+apcRLSDsRGEg5Xka7lq1/ikEVqBatJqOo+yP9bQXJ4y4FrYCfkehc1wUn1aV9ZrgJRIU3x
	+Pv9lnkzTwlmt7hcaThdQTLwNwSW01sScOQ7T8gLsWi+cVy9b2DZHEf5VdbaASzfCLfWe8QKAso
	kUc/S81kxGzeeJaHFK4nysmq1JgJpNmSoq7B9ikHIzAenpJKlz+7KhHi04rYyQHCVubvZFdnz+A
	LOTbxmU4+D2rv5w+NRLzi5w4yb
X-Google-Smtp-Source: AGHT+IG4o2sMRbjal/wNqE1AyBhrQEhgOmuQP9i1Wb50Y85ZgDNaJvwCCbv/cl0e10bMkrsnwOfPLQ==
X-Received: by 2002:a05:600c:1e1c:b0:477:58af:a91d with SMTP id 5b1f17b1804b1-47d84b0aa4bmr229523325e9.5.1768321556267;
        Tue, 13 Jan 2026 08:25:56 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd0dad8bsm45637605f8f.8.2026.01.13.08.25.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 08:25:55 -0800 (PST)
Date: Tue, 13 Jan 2026 17:25:52 +0100
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
Subject: Re: [PATCH 01/19] printk/nbcon: Use an enum to specify the required
 callback in console_is_usable()
Message-ID: <aWZyEHsOJFLRLRKT@pathway.suse.cz>
References: <20251227-printk-cleanup-part3-v1-0-21a291bcf197@suse.com>
 <20251227-printk-cleanup-part3-v1-1-21a291bcf197@suse.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251227-printk-cleanup-part3-v1-1-21a291bcf197@suse.com>

On Sat 2025-12-27 09:16:08, Marcos Paulo de Souza wrote:
> The current usage of console_is_usable() is clumsy. The parameter
> @use_atomic is boolean and thus not self-explanatory. The function is
> called twice in situations when there are no-strict requirements.
> 
> Replace it with enum nbcon_write_cb which provides a more descriptive
> values for all 3 situations: atomic, thread or any.
> 
> Note that console_is_usable() checks only NBCON_USE_ATOMIC because
> .write_thread() callback is mandatory. But the other two values still
> make sense because they describe the intention of the caller.
> 
> --- a/include/linux/console.h
> +++ b/include/linux/console.h
> @@ -202,6 +202,19 @@ enum cons_flags {
>  	CON_NBCON_ATOMIC_UNSAFE	= BIT(9),
>  };
>  
> +/**
> + * enum nbcon_write_cb - Defines which nbcon write() callback must be used based
> + *                       on the caller context.
> + * @NBCON_USE_ATOMIC: Use con->write_atomic().
> + * @NBCON_USE_THREAD: Use con->write_thread().
> + * @NBCON_USE_ANY:    The caller does not have any strict requirements.
> + */
> +enum nbcon_write_cb {
> +	NBCON_USE_ATOMIC,
> +	NBCON_USE_THREAD,
> +	NBCON_USE_ANY,

AFAIK, this would define NBCON_USE_ATOMIC as zero. See below.

> +};
> +
>  /**
>   * struct nbcon_state - console state for nbcon consoles
>   * @atom:	Compound of the state fields for atomic operations
> @@ -622,7 +635,8 @@ extern void nbcon_kdb_release(struct nbcon_write_context *wctxt);
>   * which can also play a role in deciding if @con can be used to print
>   * records.
>   */
> -static inline bool console_is_usable(struct console *con, short flags, bool use_atomic)
> +static inline bool console_is_usable(struct console *con, short flags,
> +				     enum nbcon_write_cb nwc)
>  {
>  	if (!(flags & CON_ENABLED))
>  		return false;
> @@ -631,7 +645,7 @@ static inline bool console_is_usable(struct console *con, short flags, bool use_
>  		return false;
>  
>  	if (flags & CON_NBCON) {
> -		if (use_atomic) {
> +		if (nwc & NBCON_USE_ATOMIC) {

This will always be false because NBCON_USE_ATOMIC is zero.
I think that it was defined as "0x1" in the original proposal.

Let's keep it defined by as zero and use here:

		if (nwc == NBCON_USE_ATOMIC) {

Note that we do _not_ want to return "false" for "NBCON_USE_ANY"
when con->write_atomic does not exist.

>  			/* The write_atomic() callback is optional. */
>  			if (!con->write_atomic)
>  				return false;


Otherwise, it looks good to me.

Best Regards,
Petr
