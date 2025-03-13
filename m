Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E68267B9A;
	Thu, 13 Mar 2025 12:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741867781; cv=none; b=dV9DvPQjebNFeLBGHwpCyi/HwP10+iCH9ahETVWcN9SYa6f9h9jPKAZ8R+H2nYyruVMbPn6s+OAcHlswZXqm55hLNG3Zm9QABmMGK1g4BgWRiaq8TkGMtff3+WbIiCkY8dLgV8jY4mI47dmEmqYHNKfrkCyJXYNmoYCtB51XZ2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741867781; c=relaxed/simple;
	bh=/jdmrrYLryvXv8srvg9uxHzbJWZOpIDvDn8UcNKJvRU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kchj63MhXbnaArDqydjvGI4QeaK93e2RWIpJqCTwSGxb3QCciqkMXVDyYfOh9wd+1w356ffvD2i2UoMxgNM03gM4ul8g+hyPXefkFFMmP40ik9ggo4l7Xvx8WNPYTSC+yL6nSWvviL/nkz/KiilytYeHbY76GuIgU3tBSnsFFkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BXj8mXD5; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BXj8mXD5"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7c5675dec99so101016585a.0;
        Thu, 13 Mar 2025 05:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741867779; x=1742472579; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3mAU+08l83PeGzw4/E2OYnPhEcr7Ovsn8UVQNoJ5/84=;
        b=BXj8mXD5ey3FQ6DsQ0dMKFE+CXyiscSwaiwOyuYoW4EMkUMq3bQnEVIkdzzIO8k2Oa
         4NIvkIiPbDu42p/UPnZkEPzrsAeH5lIiv1z1YL+TGvo+5rXxhUVjbiPb2HpHEtv7XSgV
         a2z7sd6rNMSL1WXl8RwS2MZN+uFgbFUtwtYPczn64WGLj0ux6SkkjVhtMh5qnPp6n6YS
         nmFcT2nvxuvUL8CDOFWOZ69/YFqVEN0dHX6FaLoN3PCOSbhNKREyGsUS3s+bAxfgaK6J
         95FO+rPdTGod+4px42KnJmIRCSgbG99lkV5UeEVHiTk27T75I3pKTpCyf/1PCYpyt7x/
         F6gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741867779; x=1742472579;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3mAU+08l83PeGzw4/E2OYnPhEcr7Ovsn8UVQNoJ5/84=;
        b=drW7b4hPoqVyjnWnMslxzK6fwSRskMpYqg0fP67QhZBrKxW2wXZoeWMwPTVgZPnqWS
         lmaL9n5qZRw51u7WdMR7bLvAioFFxOUa2B9oEpXBPPhTLQFxSVu8bhG1xfgRMsmwyvb/
         XLffvFomlg3pUKDvPnBvx7ilAf+o+K+2x9PHES732LdrBV3UTemkHmUjXAggWMIjG1V9
         8aiRhma9WqkjzCizkxdWhxx5wCTmsB0iStQC3vt2CzLlnUOejAWbc67aQ2+5Q2u4Qe2M
         ceD03AI/WTEG1a4yN7wC/i7pR5nyir2KToO6c7fYkiDejZzSH4p/5dus6DW6p1ZG8+Cc
         Ldlw==
X-Forwarded-Encrypted: i=1; AJvYcCULoxDrVIsPBmH2rvZDIcRkIK86i0RwI/8+AF7RinDmoOQ0rY9LROtTQ3mCHnX2miGhNxpXE1H9u09+OUo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2sJ0cpsIrsv8LaX2dga8UFEdxC32ok9YNLYgSZKdPdZPOE0eM
	0GGyIP+0wHza0/GbHP1HPbE+Kgd8vfIpZI42lWh4ophS9Lnue6ny
X-Gm-Gg: ASbGncsXnjxBhwFoPQ2syWCtHemzP5SgVhXN76QvV6QQVyt4ur1aiwiFB9jLIfnI6VL
	aYPjqgqaD4qJmZRUdz29VE5tNnES+wh4mF4zH44oZFyODWwR4GYXjSiOXi9BPSYJ9QzvQEjJvZl
	l/Hc5EiOLdR4C7Gf/PHr83FUlG5e/IwNx7M3o/FHIqNuIbgW8vi+T2sTV2k/9X3Wzggah/Mzh6u
	Uz+cTBCJ1z7ZNQzbBWjqqKZ/dRW0COvQxua6829476KPOg7NLDJKZW9HgZiq4MSo87EUr+uRUUq
	OFQJIaTw3MZ/Zu1ucpDDui9FL+gPtr/sywfUW1vkSbRkgTMTHPrbzZq6xkJnhre3FA==
X-Google-Smtp-Source: AGHT+IGq64HwIW8ZLXRexo/Sl5uDNfM++bQIWTjMTwM82E+RoVIQzUTxWYCM+6Co70rfhftuvEqa8w==
X-Received: by 2002:a05:6214:daa:b0:6e6:646e:a0f8 with SMTP id 6a1803df08f44-6e9005f899emr405651506d6.16.1741867778783;
        Thu, 13 Mar 2025 05:09:38 -0700 (PDT)
Received: from nerdopolis2.localnet ([2600:4040:5e66:a800:1190:f8d0:801f:5e0a])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eade334d02sm8728466d6.80.2025.03.13.05.09.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 05:09:38 -0700 (PDT)
From: Adam Simonelli <adamsimonelli@gmail.com>
To: Petr Mladek <pmladek@suse.com>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jiri Slaby <jirislaby@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Andy Shevchenko <andy.shevchenko@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 John Ogness <john.ogness@linutronix.de>,
 Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH v8 1/4] ttynull: Always initialize console index to -1
Date: Thu, 13 Mar 2025 08:09:36 -0400
Message-ID: <4810112.n0HT0TaD9V@nerdopolis2>
In-Reply-To: <Z9Gcg-iMMCAhLUJf@pathway.suse.cz>
References:
 <20250311033133.1859963-1-adamsimonelli@gmail.com>
 <20250311033133.1859963-2-adamsimonelli@gmail.com>
 <Z9Gcg-iMMCAhLUJf@pathway.suse.cz>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday, March 12, 2025 10:38:59 AM EDT Petr Mladek wrote:
> On Mon 2025-03-10 23:31:30, adamsimonelli@gmail.com wrote:
> > From: Adam Simonelli <adamsimonelli@gmail.com>
> > 
> > This allows ttynull to be considered in console selection.
> 
> This is not true. It should be possible to register ttynull even
> when .index == 0.
> 
> The .index is important only for drivers which support more devices,
> e.g. the serial port or virtual terminal.
> 
> > 
> > Suggested-by: Petr Mladek <pmladek@suse.com>
> > Signed-off-by: Adam Simonelli <adamsimonelli@gmail.com>
> > ---
> >  drivers/tty/ttynull.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/tty/ttynull.c b/drivers/tty/ttynull.c
> > index 6b2f7208b564..d8b51edde628 100644
> > --- a/drivers/tty/ttynull.c
> > +++ b/drivers/tty/ttynull.c
> > @@ -57,6 +57,7 @@ static struct tty_driver *ttynull_device(struct console *c, int *index)
> >  static struct console ttynull_console = {
> >  	.name = "ttynull",
> >  	.device = ttynull_device,
> > +	.index = -1,
> 
> There is only one "/dev/ttynull". And its index is initialized to "0".
> At least it seems to be the last parameter in:
> 
> static int __init ttynull_init(void)
> {
> [...]
> 	tty_port_link_device(&ttynull_port, driver, 0);
> [...]
> }
> 
> So, I believe this it should be perfectly fine to keep the default "0"
> here. Note that it is special for ttynull because it is only one...
> 
> IMHO, this patch adds more harm than good :-)
> 
> Best Regards,
> Petr
> 
Understood, thanks for the explanation about that.



