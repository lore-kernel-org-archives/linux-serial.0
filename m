Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA2B7F481
	for <linux-serial@vger.kernel.org>; Wed,  7 Feb 2024 15:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707318580; cv=none; b=c/nt5MVYkGRuapDapx+nGNYYIB/R3BHuwQ0qNVRiVCNXe3N6DrcwzWMxJgSzm+MOKZnJ+2JHzO6nptdQ4zLqGdwdYxvzJYYIgMajTAewdZsHmij/dEOnxneRAT/YPgp7UnVysH/hBjrAlTfp++6zL49Rxv7PBjIX+dYgsSX6PWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707318580; c=relaxed/simple;
	bh=289HaGYyUFlSBzdgaJPiX1tdAh3koUayV8L35fXtBMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eTTgN8S3t8YM1Lz/i0hHb9dfWZTLmcXf1RwHAsXrj9YOzQyaFqt45po6LPKr/m44kPstJmcJh6Zc0QhfVkABsA9Z1W+lUNVgvEzD7llzuzkrtRqJ26/RCKh0GpirbBvFN/CW2Wn3ybT41S4k8WSJvGHb5Rc+B8WqBgrE3sIl5UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=PY+GQVkB; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="PY+GQVkB"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a389a3b9601so34924166b.1
        for <linux-serial@vger.kernel.org>; Wed, 07 Feb 2024 07:09:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1707318577; x=1707923377; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3fOJyiQhDEQVM/OwkrnT+6+TKgKM76JkW083fWVVDBk=;
        b=PY+GQVkBbwxWwZNCfwCthRubJa9T++UD1BCfRZdMnhgRuWB0As4VvOuMekPlhPwVHH
         s+NMskSpxvlXsKzp0sCv+9SsErwtFOpIDfrmEhLRbLvsH7SEkG13VYhVUgQW+AbXsop0
         mQjQttud987Oh5DIrHXZXoAQzSSnEGV7n6apJLh13NJX22EkfFrXsUv54ORBs1yfM7YJ
         /vHcYbEJMKI9RsSlUvwOGPH4W7f76HYKeqX2UC/+0nzbCqozTFTHtxaBPdzlh2DpXazM
         +9azSiI7vdi2Kmj/P5vtqO0kPJCGN/LIgTwmTL9bkq2QBmpoHij1hb9MnFrrOrs8o5Cs
         gPlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707318577; x=1707923377;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3fOJyiQhDEQVM/OwkrnT+6+TKgKM76JkW083fWVVDBk=;
        b=uPxm71luPvw7/5p97nv8EQeg2Qtr4S/lA3hVyVLUcXuWyyjjM9mZYrzMfWrKMoxfha
         i9Mf06DaG0YuPEpP6bb2c9oY33JlUONnz1wiQGabqmfX2wXpDgopGH9/heFBel3L8ttX
         XpSwDuHPAPY8uQYtpPVqtTfUvYWiWXSOwFOACJIfvnAjR/OFX1WlJIPLs9IVe+dYBuLi
         0TwUgjjvqc4Tw/jBSBXIbv/GqbpXXSRPHLyIVQ3mmpGOWb2YlOG/q6V06bxWG4NQ1Lrp
         ZkaqpiMO3zD28iYEl8hdMx/AwiP/rzhEQzI3ZofJ5QS4knidpPs4jiwrV0StOwvHAlG+
         7kxQ==
X-Gm-Message-State: AOJu0YydxlMktBILUvQLgj2HkDLCt1Fu0DenGHyPnA7bA9fksqgy1wv+
	9MQFEGySRIM19+lbeOGuWT6k0yd9/Kp954qiZy+tZlR7yU52tTnxA6uRFuGiGfA=
X-Google-Smtp-Source: AGHT+IEll9oUuMXPJPEKfzna/H4NBKn3iyg+La3JeQgNI7lqzBIfxefGwoDNHHhuwYO4qQW6EQqgRQ==
X-Received: by 2002:a17:907:7803:b0:a34:96e9:f46c with SMTP id la3-20020a170907780300b00a3496e9f46cmr4162025ejc.31.1707318576821;
        Wed, 07 Feb 2024 07:09:36 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUvxcgxBYzEwqY+Jl6A6mhH/kPpsJosFYLwZCqbchnZsHhP6c7ZxGSU2Pz3grVJ8cfjhumSW1VdAs+UJ7Ul6fU9s+A8UAlJhMYDdt5sCHZXd9AkWmm89A7S103tkhQ0bM9wY75FZeNX0J3e9OmLVhp5lX7s3NXsfoeD0jbChoB4GHnMC7EFZ09KXxuUag+NW2zXpd7bqdGZAQO0c5Ez/YDspt5lkcAoDjZdJJXG4Gan82yImyk3HveUAmh+IVRwaM9UxblyfwczOHmc4CSEqPIAGLoupgSWYtWvzbjXCRaR9AQXdG5d4IQIHvuwlzDnJIYTkZuZkXwsg5WUxAyMXlCDn/idLyxAzGsobpp+2fJXPKVCYSvRiibxgisv/q2wgrJ/QKOAwY0cS1PDQ+hccitcgvV2it8taIHfieBe/MRrQ54D4GGb0RkYECSF9EGJ3bo3LOJ1jC6QxXWNXbe8zCqFEYO22V2DwySm
Received: from alley ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id cw9-20020a170907160900b00a388e24bd2fsm428980ejd.162.2024.02.07.07.09.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 07:09:36 -0800 (PST)
Date: Wed, 7 Feb 2024 16:09:34 +0100
From: Petr Mladek <pmladek@suse.com>
To: Sreenath Vijayan <sreenath.vijayan@sony.com>
Cc: john.ogness@linutronix.de, corbet@lwn.net, gregkh@linuxfoundation.org,
	jirislaby@kernel.org, rdunlap@infradead.org, rostedt@goodmis.org,
	senozhatsky@chromium.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	taichi.shimoyashiki@sony.com, daniel.palmer@sony.com,
	anandakumar.balasubramaniam@sony.com
Subject: Re: [PATCH v4 2/2] tty/sysrq: Dump printk ring buffer messages via
 sysrq
Message-ID: <ZcOdLrOPiPJmCec5@alley>
References: <cover.1706772349.git.sreenath.vijayan@sony.com>
 <ca8dd18e434f309612c907d90e9f77c09e045b37.1706772349.git.sreenath.vijayan@sony.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca8dd18e434f309612c907d90e9f77c09e045b37.1706772349.git.sreenath.vijayan@sony.com>

On Thu 2024-02-01 13:12:41, Sreenath Vijayan wrote:
> When terminal is unresponsive, one cannot use dmesg to view printk
> ring buffer messages. Also, syslog services may be disabled,
> to check the messages after a reboot, especially on embedded systems.
> In this scenario, dump the printk ring buffer messages via sysrq
> by pressing sysrq+D.

I would use sysrq-R and say that it replays the kernel log on
consoles.

The word "dump" is ambiguous. People might thing that it calls
dmesg dumpers.

Also the messages would be shown on the terminal only when
console_loglevel is set to show all messages. This is done
in __handle_sysrq(). But it is not done in the workqueue
context.

Finally, the commit message should explain why workqueues are used
and what are the limitations. Something like:

<add>
The log is replayed using workqueues. The reason is that it has to
be done a safe way (in compare with panic context).

This also means that the sysrq won't have the desired effect
when the system is in so bad state that workqueues do not
make any progress.
</add>

Another reason might be that we do not want to do it in
an interrupt context. But this reason is questionable.
Many other sysrq commands do a complicate work and
print many messages as well.

Another reason is that the function need to use console_lock()
which can't be called in IRQ context. Maybe, we should use
console_trylock() instead.

The function would replay the messages only when console_trylock()
succeeds. Users could repeat the sysrq when it fails.

Idea:

Using console_trylock() actually might be more reliable than
workqueues. console_trylock() might fail repeatably when:

    + the console_lock() owner is stuck. But workqueues would fail
      in this case as well.

    + there is a flood of messages. In this case, replaying
      the log would not help much.

Another advantage is that the consoles would be flushed
in sysrq context with the manipulated console_loglevel.

Best Regards,
Petr
