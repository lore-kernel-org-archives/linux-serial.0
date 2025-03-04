Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BAD71F4622;
	Tue,  4 Mar 2025 06:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741068472; cv=none; b=U4c9LXIYrtw8OD+7x01zJiae2kYIvU7tf5DrFgIs1Ezs4QGJPkwNSEOxcCUY0uSh5a3RCQZUwnMn+dXBEIr9z5xNNMUgOh3tgUia7mOMlT6uXl5g7neHm7T0o8nhEk03kYDEk/pQZUyLtDMEoTvT96rAODRxRDzNW14N6CTe15E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741068472; c=relaxed/simple;
	bh=Y4J5kNPdn31vbKWpYhcJQtNAfF5XqIdmKd1v5R5JRS4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WxJLwzBHjiqZL8ju9OLR7srgxRIWB2h0HKnulzXDdYPhBdJv04ztQlBcnbNk4pNYEEcXwK6SRBYMEXMmP6ArV4Vi4xeq0+hpcFUzAJVK9TzHeKBl0CHhKS7wrJyf9dsogGw4t5O56rd1lprWJawbc0I4K+2xP9wYTvHTul4gwb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lnRT8g5N; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lnRT8g5N"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-aaecf50578eso996957266b.2;
        Mon, 03 Mar 2025 22:07:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741068469; x=1741673269; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aIxZQD6EiobOPlS8qnte96hg7t0Clugw1BVd4bOewtU=;
        b=lnRT8g5NaGWFfazibFqJZ/MVLYRMwvebDVfsQtEA/0Oc4a+dVPYyiYKDzlwlebcLyS
         4qQyNSMmKBHe6lFSowrP2r7+N+Q3nl9P7agpSndLtUvQFq76bWj9BwOmsrCw4VEigB9f
         OJV6EP8duOLzdGcljnei48TYwfY1ukU2w/EBOQCb7ZOIPYkYXrkCeMBTJ4dvv9qslzWF
         J440wNk7TmmtzWdizS4FILGFqFXeSZ2F2pmhMgh3YTcD0uKQh8ag4xWS2tVBqYJi65Lk
         672ofVPwYLoKXUI9VrY5VvauiIrlGeVfHwAedj88MP5KxKZto8C0w4X0JUeeYGXI5xIL
         /fOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741068469; x=1741673269;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aIxZQD6EiobOPlS8qnte96hg7t0Clugw1BVd4bOewtU=;
        b=W3FMrjmWfWK5XaxvxYyRKUJvIKJJszsZ58SvMoEEANQew74iX98Z5mZHgM3eIQ9SBA
         Z7bXnZioknZ6stnGKKVXvNoCVA0bXPom8oAsZ/Z2IIhlZQLcKPugV06m26amESQQW03S
         wlIdqIcDNA3UY8Dcm1VMeOo1aKEk8e7raJCDTEA4j0L23rChKMgapaSaEw7pVaCF4EWR
         FfL98PHR01wx90WGRyA8BHD4I/s+bGMY2HQKYsR8x3TkSYrWIZ52y6QG1/tsm2MLwibA
         6Oj9ipxO/1IiV2KBQ17x2i/aEove2CWgACWw9ZHIUihpPDtQMS7Z/N6wLXP6dhR2Plac
         5oWw==
X-Forwarded-Encrypted: i=1; AJvYcCWE7kK9HufFzcyebpJVEX3+n19BSlQX9yCUfGTz/bjd8slgQ4bBLPKJG/f8+xhbz4F43TC78VkDrTre7d4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEhFPxOfDdweZEwy2dt4jwDHnXZOORkIvB4YMlSIPjUM+2282j
	Jt2YD0bRImjtX7eQLc+7mHiU1wpIvGfhqwNfkvKUSpAOB7KPRoA6Bxv+cbcqQhwD2TTi2p/XMMB
	n6ZbA5eQ5g7aTfOEWKPa9u5pmvNvPLQqr
X-Gm-Gg: ASbGncsCBFDxdE4kIq8RcUp/cL3SspEuQ5LuB75rgfCizw+lU9TEihq3ej+AO4sjpmz
	tRuX+xli2pWM49l1F7Ickxw/enqxNZkuo97uU1BcmxQRHzB8zQLvjXXCAinq6WxCMjqdsZBQoDq
	wOW7Hva2k/oGW33rA339AhKwBHVQ==
X-Google-Smtp-Source: AGHT+IHiq+pDlrJy7nC5i+QKpFa4VzADHCerDO5gvGYEncIXUDBKDIBbGpG/ztTBO6CkwXj27M6FDqdI95h9ldSeJ1E=
X-Received: by 2002:a17:907:9816:b0:abf:56e3:e899 with SMTP id
 a640c23a62f3a-abf56e497d3mr1327215566b.40.1741068468891; Mon, 03 Mar 2025
 22:07:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250304035447.3138221-1-adamsimonelli@gmail.com> <20250304035447.3138221-3-adamsimonelli@gmail.com>
In-Reply-To: <20250304035447.3138221-3-adamsimonelli@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 4 Mar 2025 08:07:12 +0200
X-Gm-Features: AQ5f1Jp4apRDDfOHT1-ImwZ6vl-zTonZ9ToEQ6lUMnYoIGGXDnGxEz8HWIb3MIs
Message-ID: <CAHp75VeMm3rmPto_31vWCVKh0z76h2zFjpjLUaiZ-gS8REEG+Q@mail.gmail.com>
Subject: Re: [PATCH v6 2/3] ttynull: Add an option to allow ttynull to be used
 as a console device
To: adamsimonelli@gmail.com
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jiri Slaby <jirislaby@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Steven Rostedt <rostedt@goodmis.org>, John Ogness <john.ogness@linutronix.de>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Petr Mladek <pmladek@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 4, 2025 at 5:55=E2=80=AFAM <adamsimonelli@gmail.com> wrote:
>
> From: Adam Simonelli <adamsimonelli@gmail.com>
>
> The new config option, CONFIG_NULL_TTY_DEFAULT_ CONSOLE will allow
> ttynull to be initialized by console_initcall() and selected as a
> possible console device.

...

>           In order to use this driver, you should redirect the console to=
 this
> -         TTY, or boot the kernel with console=3Dttynull.
> +         TTY, boot the kernel with console=3Dttynull, or enable
> +         CONFIG_NULL_TTY_DEFAULT_CONSOLE.
> +
> +         If unsure, say N.
> +
> +config NULL_TTY_DEFAULT_CONSOLE
> +        bool "Support for console on ttynull"
> +        depends on NULL_TTY=3Dy && !VT_CONSOLE
> +       help
> +         Say Y here if you want the NULL TTY to be used as a /dev/consol=
e
> +         device.
> +
> +         This is similar to CONFIG_VT_CONSOLE, but without the dependenc=
y on
> +         CONFIG_VT. It uses the ttynull driver as the system console.

I'm now at the non-monospace font mail client, but it looks like you
have a TAB/space mix in the above for the indentation. Please, double
check that all lines, except the first in the option starts with a
single TAB and help lines (after the 'help' keyword) additionally
indented by 2 (two) spaces.

>           If unsure, say N.

...

> +#ifdef CONFIG_NULL_TTY_DEFAULT_CONSOLE
> +static int __init ttynull_register(void)
> +{
> +       if (!console_set_on_cmdline)

Invert this. It might be that we want more in the future and this
conditional is not-scalable for that. Inverted does the trick. To be
precise, do like the fb driver for xen does:

  /* User defined console is present, avoid registering "ttynull" */
  if (..._set_on_cmdline)
    return 0;

> +               add_preferred_console("ttynull", 0, NULL);;
> +
> +       return 0;
> +}
> +console_initcall(ttynull_register);
> +#endif

--=20
With Best Regards,
Andy Shevchenko
