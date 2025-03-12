Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1DFF24EF8D
	for <linux-serial@vger.kernel.org>; Wed, 12 Mar 2025 14:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741790346; cv=none; b=cmDEvVcrPhgJ5tt8Jq5Kh7WbzzpJvExAuOhuwxMyvv+gGjBEyqFrmW1Ote2zQwQJPyTIOlJDcj9RiQcLJLouMFMkjz546mVWgcQ+HYbpjKmyLCW9mNcOiMHYykwOh8aEzxauvxXCN3dT3eq/qaI3zwyvYDUmLaTYcFrry/zdKkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741790346; c=relaxed/simple;
	bh=FAUfCbp/AnKGaM6PZxPP+wpMhZXTgWi6xhgNtSdDqeI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oNnHQkbRQU7aHq/wiFKqklgp+2fAyMKh2DEdEdtcAKFukojd8fPPctwqSBAX+On50u35oxvhxGNIA1sbtrWIxOqTANcO21yCOWuQtO+9gy7cH4l9fx6+VsArk2/6P9CpAvM7+z0KoQGtdNRYc2+72edgB8aO3+2fbOP4WJT/wys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=afE3EVzD; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="afE3EVzD"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-391342fc0b5so5825152f8f.3
        for <linux-serial@vger.kernel.org>; Wed, 12 Mar 2025 07:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741790342; x=1742395142; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vWxFu9RIVsjgs6Iiq7krzb57FVJUVJFMHJiej73kumo=;
        b=afE3EVzDHXtcc7XGIm3bpfgVCWrQQ3cUPsM+ppcMkp6myi7D5v7MhmpS70T3ewpVhN
         JeqDY6EUu04JY7HOIg+d1B5qHdilej1k7L5q96IRncAorh8Er5jWBpb+266jeO/JSWow
         +ZOBF/tPMMNsxOTn6Tc23G4vCXLQmKl2qyxZMT8rxCgJyvBIYdL4jy0cSJ5WzOUEdUTz
         skltmUf0U5lr8L39EgSJl6T6MDwafT/aGZhBwKTxJAHrdB3VUTHMrFs8ErEeWy6j/iR0
         BpgW9BvKliVLP9k1dX7Tn4IzL58WHIxyusDZUCcqMYuTns5fC0ZhzJAUVGq5iirizlKw
         Wrdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741790342; x=1742395142;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vWxFu9RIVsjgs6Iiq7krzb57FVJUVJFMHJiej73kumo=;
        b=aNsfppQgRFgO3VM5/N/GlRlUnguoIiJ4uY488gmnTzJHe0ICrxAvon3TDShNbwtjih
         nkDsH0S+LtqDYJpYP4fevyZpJsWl5p/OvQnPIj6YjvbZje00KUAL8qsciyaI/tnyIel5
         3Hb/N9cUUKyK9bAI1TYDUG72uFEORHEjmq+NEnuLjW07m6bQZpBjhwSKTEUOhkIASv1I
         lDynYjJAjOtmzxllkMPxutwQc8tBuGNxLn7msere4qLzpKMNwI41BbURJJkJlqI313ry
         dDaXKawtYYBPt7jaNGTeBSlP2pub+NwibtRfLosPiXOL5tUpLUfILoLy5V4MR+Ic+w19
         ehEQ==
X-Gm-Message-State: AOJu0YxV0VyoNKNbPbY3hl3MZZS4FhltnaGPC6h+7DrpI03xDdVJlbOj
	4W74+EYdbM06Z5q7x1uhd78aJtlYBOZISMU3AUUwky1sYdkS8f70XHHrmYgIsRQ=
X-Gm-Gg: ASbGncvA3ljNA7wnAMRiJ7cKoLerJhVlaZlmm1mEgY0mZgYTlaBmVkFnKMiADSN8dRr
	gfK4xvLnqQ0WoDG+DytjZShNdhvGGnxGQuL/PxDi0sfjgQD8rAHo+GmsmJVdo9rj3OF/NyxHfqI
	3UGEG7GqVDJ+5K0eJglklqf8sefLh2iq8A1Q4jUpT+1k+aTKGsDMqCeMe4TfoE7Cgvz8/LxgFb8
	aWJAVUdOOwyTqNOTgtwdDDmWqeN3kL4NqZqiM5E96awH2ZoEvLjESdvcGbXEuFfV6fRY84A214N
	cmSsZd8GmD2JCr49l0Q1u0yfLSbZgv9u37AcqamxNdDvsb4=
X-Google-Smtp-Source: AGHT+IHoIOUes9t+4PJaJSOShtSoQNf8xR0sgPlf7KhTetPd4sbTmZZtiCosAgW+sL2vPrB53Y+C+A==
X-Received: by 2002:a05:6000:1548:b0:390:ee34:228b with SMTP id ffacd0b85a97d-39132d465b1mr19862228f8f.24.1741790342035;
        Wed, 12 Mar 2025 07:39:02 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c0e2f10sm21405272f8f.65.2025.03.12.07.39.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 07:39:01 -0700 (PDT)
Date: Wed, 12 Mar 2025 15:38:59 +0100
From: Petr Mladek <pmladek@suse.com>
To: adamsimonelli@gmail.com
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jiri Slaby <jirislaby@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH v8 1/4] ttynull: Always initialize console index to -1
Message-ID: <Z9Gcg-iMMCAhLUJf@pathway.suse.cz>
References: <20250311033133.1859963-1-adamsimonelli@gmail.com>
 <20250311033133.1859963-2-adamsimonelli@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250311033133.1859963-2-adamsimonelli@gmail.com>

On Mon 2025-03-10 23:31:30, adamsimonelli@gmail.com wrote:
> From: Adam Simonelli <adamsimonelli@gmail.com>
> 
> This allows ttynull to be considered in console selection.

This is not true. It should be possible to register ttynull even
when .index == 0.

The .index is important only for drivers which support more devices,
e.g. the serial port or virtual terminal.

> 
> Suggested-by: Petr Mladek <pmladek@suse.com>
> Signed-off-by: Adam Simonelli <adamsimonelli@gmail.com>
> ---
>  drivers/tty/ttynull.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/tty/ttynull.c b/drivers/tty/ttynull.c
> index 6b2f7208b564..d8b51edde628 100644
> --- a/drivers/tty/ttynull.c
> +++ b/drivers/tty/ttynull.c
> @@ -57,6 +57,7 @@ static struct tty_driver *ttynull_device(struct console *c, int *index)
>  static struct console ttynull_console = {
>  	.name = "ttynull",
>  	.device = ttynull_device,
> +	.index = -1,

There is only one "/dev/ttynull". And its index is initialized to "0".
At least it seems to be the last parameter in:

static int __init ttynull_init(void)
{
[...]
	tty_port_link_device(&ttynull_port, driver, 0);
[...]
}

So, I believe this it should be perfectly fine to keep the default "0"
here. Note that it is special for ttynull because it is only one...

IMHO, this patch adds more harm than good :-)

Best Regards,
Petr
