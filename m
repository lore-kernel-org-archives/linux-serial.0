Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F277D1DE3DB
	for <linux-serial@vger.kernel.org>; Mon, 16 Jun 2025 14:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750082582; cv=none; b=YalsLc8rkJdpxTrV+B4fo5/zlhr6oiWHKcvHVbKr3v48muYUc0GyGJr9+Pd2VYJrODsKN+Cfy/XOH8eIL6lMlvkbbn9O2VlSkiGppPnGKcz8UMBKCxETqAYUsgE8lNq8bV1tAy0X344e/mXbug3bqDMDh5shty8PBv46vKN9VSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750082582; c=relaxed/simple;
	bh=lbevI24s0PcQlyhZvC9TEbrNV1GfInZjLjxZx9MLu40=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hb7TvUhzSzLrb1ODAB9wXnlhwNyC8PwYOwPIu0GQFEkmdfkEkD4573Lzn4GUAiAbYjjoSIdGRgbv7bZtqAUHx95BlUSQzgWbs+UV4LeREwfiJt0uKek0FKklYIGLS7HnfkOYVuiEaFoq12Tyg/3cF5YjD4cKA/3G7jfT5ko8efY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=H2LZB1DK; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="H2LZB1DK"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6084dfb4cd5so10652708a12.0
        for <linux-serial@vger.kernel.org>; Mon, 16 Jun 2025 07:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1750082578; x=1750687378; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NezTSsyMagu8zLGwg6DhObhL/nAKADWh56tKSWG5+zE=;
        b=H2LZB1DK9b1oV0sOfzBXvPxiInhgRgy4NQsI9P8I2mS5UgGEYJEwSPFdx+PQYsTO3h
         /UcnFVx9L/V98lqeA6lGg69sEqOs5HwdFn5+eExxreSkf31z1CBc5ob0x6VKcaDBCxNp
         etdmyH+KL2D54wMTcRCRA6QevpW8a07miiRPInySdAODpp8ERrBB2Nse2PY+pmLmm5Ka
         QoiQIfB1tS9523E6urOWT4OkY7P/kbpXOeYauI8ZDpKRpx4dsE3VEcwdvRUQ7XE7c+pc
         gjz4SngbWG4otyMvx5yiLKqtMJUW/yY+/yNWPQqavgwik5C+ORX2MypGajplaif/dyfv
         qzQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750082578; x=1750687378;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NezTSsyMagu8zLGwg6DhObhL/nAKADWh56tKSWG5+zE=;
        b=N4tG/I31jLiDmUtkhUzfqftc3KJU731xc8iVm45HzcL/XV5weiO1FT7uk7W1sHHBdM
         mTQT70vIDwSx/MmlQRScYamEqgi+eqAJdyjHVHS7NZFbTO2UiOuy64VWfYkNNX7bZ9k7
         J32tGzz3Zbm2RLTv8rQwJ1JM3dsW9ygCTJL6OXg70rWYiXdVfWrZAepbKjb8GFbB7S9l
         YQeuiIskEZIhekJ9qTdqcJeLvCHd19Z1j4psudVquANfc9LgyhB5JslYC2FE5jtbo4sx
         dU3rP3q69xDVlmHoJuHemgCOrzJenlY9tgTugpxYVSD1z+2s1HuQ0cEH8cS8t7Sirh4+
         u6VQ==
X-Forwarded-Encrypted: i=1; AJvYcCVTlqEXep1Blli+USqmQm4E1uz7GsHHdMhFrHsdfbl32BlSRc4r2SmyrpvMopFVJwoInd+DB/FnlQrmjdQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjA1XrBkNRYH+Nx6Twpb2Qtw4EWAz+atCKOgoFTdoxgsayTXHy
	g64K83SryXaNFsFFK0sKzVFK9JOUabbsxgJGao15b4sb3C2JWo0xtPvxQ3pbcIKnZKA=
X-Gm-Gg: ASbGncvYb8cg1sxPB8ybUoVf1VCGyq0fuSd2YA7uIw74JwV2Az/c0cu50tGptxwCo7F
	YFVCg2tR3QAJ201A9TqHoVn9CaFKoda8xp8bN3MO33WzwbGyTGoCSDJz85isxaWlIHvr7wFySA0
	xxk50cdqYR4FFXUFeZJkPI9mFXmDUDDJ7z9BXsgO0Ibo5l8561W5vNzCdiiXbDXlO6HOdhDoRKM
	L0liia9jdjtWFUPpS4PSWxjtxAWkKYlujeDt+/NiZKIVQIfeT4i48id+riEHv2SmdF2SWowYD4H
	XmS0+BeaorUJiNg9rSxoI3J7bRYxSFOpIp/VF1/PhtNO2jPANc+oXuYk5l7u/CfX
X-Google-Smtp-Source: AGHT+IGQKt/OCARGss+vM72Zy1ByQz9dfh+HKXz/EINJ++KGru6AYFAdN86jIyZYD5v+8Ya81pTKAg==
X-Received: by 2002:a17:907:3f97:b0:ade:3a1b:88b2 with SMTP id a640c23a62f3a-adf4fa9117fmr1057658266b.29.1750082577978;
        Mon, 16 Jun 2025 07:02:57 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-adec81b8e38sm674489766b.50.2025.06.16.07.02.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 07:02:57 -0700 (PDT)
Date: Mon, 16 Jun 2025 16:02:55 +0200
From: Petr Mladek <pmladek@suse.com>
To: Marcos Paulo de Souza <mpdesouza@suse.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Jason Wessel <jason.wessel@windriver.com>,
	Daniel Thompson <danielt@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	kgdb-bugreport@lists.sourceforge.net, linux-um@lists.infradead.org
Subject: Re: [PATCH 7/7] printk: Don't check for CON_ENABLED on
 console_unblank
Message-ID: <aFAkD2i0ceH6qYQz@pathway.suse.cz>
References: <20250606-printk-cleanup-part2-v1-0-f427c743dda0@suse.com>
 <20250606-printk-cleanup-part2-v1-7-f427c743dda0@suse.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250606-printk-cleanup-part2-v1-7-f427c743dda0@suse.com>

On Fri 2025-06-06 23:53:49, Marcos Paulo de Souza wrote:
> All consoles found on for_each_console_srcu are registered, meaning that all of
> them are already CON_ENABLEDed.
> 
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> ---
>  kernel/printk/printk.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 658acf92aa3d2a3d1e294b7e17e5ee96d8169afe..8074a0f73691cfc5f637361048097ace1545c7c0 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -3360,7 +3360,7 @@ void console_unblank(void)
>  		if (flags & CON_SUSPENDED)
>  			continue;
>  
> -		if ((flags & CON_ENABLED) && c->unblank) {
> +		if (c->unblank) {

It might actually make sense to check is_console_usable() here.
The reason is similar as for the 5th and 6th patch, see
https://lore.kernel.org/r/aFAdGas9yGB4zhqc@pathway.suse.cz
https://lore.kernel.org/r/aFAiq3IEic8DuATR@pathway.suse.cz


>  			found_unblank = true;
>  			break;
>  		}
> @@ -3402,7 +3402,7 @@ void console_unblank(void)
>  		if (flags & CON_SUSPENDED)
>  			continue;
>  
> -		if ((flags & CON_ENABLED) && c->unblank)
> +		if (c->unblank)
>  			c->unblank();

Same here.

>  	}
>  	console_srcu_read_unlock(cookie);
> 
> -- 
> 2.49.0
