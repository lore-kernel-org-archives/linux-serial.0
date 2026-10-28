Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793166892;
	b=XsyVUWm+rZj5j9IdHJA0CR9aOd7bc1hRZhFXjy+Hro1amAsSb0NTk8MnjnyXszg7VIIN
	 LnY+AInv7KTU2sVU0xCUALjPU21TG2IUH4n8h5VFy14O9BRRxlhGR2XAmH4eSgPTOv4A5
	 lA3wZHI2n0YvIbFKkNG7PdZuaLMpmzLY/Hyk+HCiqy1/24hEHHLF8k1udUVvx0dXVDk0x
	 OaWaQxJFzBufwMJoKoj0Pyc3oN3w2wED3tVauZ9hpEb8TpxNPnXJ1hJ7uQwndJt3Pyh+p
	 2VIv5LSHkrL34MboTAU48H5a5t9ICAAwWUBmlhu/q7ORegIX6R5sbkOAKU/o5KHwNKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793166892;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Content-Disposition;
	bh=iPIWf4CR+FySLK0WT2XKzaLbbIX8hP6nHSH1SwDADzw=;
	b=GQzzIf8JhhOw7dQSut7d+HqgzE7KElg+bn00aKMBnAWBa/RvgMXobe8xE+FbEAHU/Sil
	 QX/aHEMVfJRnBfGmeYAzKRwVNo11Z3HjOLLnkINFuuLUPDRuA6ZjzAZ/G26KFA48moX85
	 b9vceogmNXtulxPy6k7zXSFRrGU+zWXWsiD5ZoibnrQvwCwssaERawackHLe3ae5Vy5Dc
	 RAxXV0Jv59rDuwZORP1sepWjn46qGu1TijXZk0wWdAKfW/CGf6vcIFmOlN89fZ6sPFqgD
	 7UtPLaQW86qc+FqJhiIKa1kkb1WbQ5lQ+4bdRJ/XElUqlXvoOyDiG274+dnv8wiy2ZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=o0z69Qcf;
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394F4606A31E
	for <linux-serial@vger.kernel.org>; Wed, 28 Oct 2026 05:54:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 394F4606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=o0z69Qcf
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-3282db206d3so1236054eec.0
        for <linux-serial@vger.kernel.org>; Tue, 27 Oct 2026 22:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793166891; x=1793771691; darn=vger.kernel.org;
        h=content-disposition:content-transfer-encoding:content-type
         :mime-version:references:in-reply-to:subject:cc:to:from:message-id
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=iPIWf4CR+FySLK0WT2XKzaLbbIX8hP6nHSH1SwDADzw=;
        b=o0z69Qcfpdkp/p6Tn5NclGTKtl6MY/HW+BqKV80a4QaTrNGIg+jA8tKdXUH7KD1D8V
         xSReEm6u6evrxsh/6+S7Wn4Z6RPKeWj59oWsewcgLsAyFROJTovwFUETuLbg51IyiQIS
         zQBUF8/Wpb/kTL6ff+T+YB7v883/sjREJW32zIKl6C+fxc8Wr/PX5EA1gykfnyp9FP4S
         Vt2vCeOEIJCjkjKrarVaWzoJ7WKm8Wc7lxgaXwk2vGDTLIAkuPCODZHKaovK6/3WVkDY
         M73KDzIsQ/51UAvEu/nH3TnkTfOuu/SshBe/T584vy1hS40w48Xolvaa8/On56ahzmwk
         gCsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793166891; x=1793771691;
        h=content-disposition:content-transfer-encoding:content-type
         :mime-version:references:in-reply-to:subject:cc:to:from:message-id
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=iPIWf4CR+FySLK0WT2XKzaLbbIX8hP6nHSH1SwDADzw=;
        b=HPQ+/VLQd9SaaWFzgc56jO09cw2oDC/ZkZJaoqhY2bnuHN7pEUe5e/FYRp1tjEvjMj
         F76o6KbVXLQLECVgrqPgHWm2FayZRKhLp4NSQ3oHIQxzF9kmKJ/ZMrB8gnR+1sANq4iD
         asea4fOBpF/ttWkbjYXFMhCvhsvy9XMQcND8fs5mgCwsNm2vUNUTPeVLZHHkOCuZu5g5
         gDcgM9xyomY6m6vex9eW0jTsM9ddjkSm5EsStAIAM+YOWDj6dFbjptfL94MPSxmUDaSz
         za3moytThQDE73485d944eK3zdeQqmaT/k4/ii8N+gXrNK4NoFkqu5EgvxITJ0Z4wJYl
         yIYw==
X-Forwarded-Encrypted: i=1; AKwUvBwe9QAavsD7HVJo71q5SAg6M6Nn/Kl9Ag86N2aSjbAMK83CumeNewNXRptVzk+a/XZ/oy2JGXKSbh8o/Mg=@vger.kernel.org
X-Gm-Message-State: AFq9FYLajJEOxp7zt+0bzCtlSoAXSgkls7KMAz52WYg++T0i9U8kKFLl
	sqErRUhptkOZ92AEA8+OzQvAOu+Hvn6sS5vwON9iqvtZYjgi9KjooRbT
X-Gm-Gg: AYBFou3pSu8HhlHP6VpAr5SGhy/UPRB1Tw+j6lfBjoJwNysrpqDf0olXPL/c6N38HoA
	RvVKs1FH8gsPORjW+bOOQ/+aM2EmRTxxmbnlzfJyX6YHzYXwqwAA1FGVJWWD7d7nFJDHSaIxIJq
	nn5SqvT/kN2RnR4eHtapGIy+fMbg3SzLar0dBHTEWHbFF+m2FrSff0q6aHBbx/rXv5Ol1lBSTkq
	WaLGIBUEYd3VYNuH3TsN5aluB/8FXAkkU6vExqHOeqf7VwyFmblIrLp0XkzKB/cXsaVk4Qe2Izl
	kdN2JsvvwFqHEOnw/dkPdQiKBjxEeBPqiIx1AzpZRSQ4r7vuUFFcmFEWMuGmCjasGrlHK9ZCs4L
	bAxt5M/nRh6iB/u+AI4yaah9ia1sDdwYepRi4JbkhoZQPRQNxwcfKY9Oo2xBWVEWx+0epURBc6h
	K4p2ndP068+yGfQZN2L17UM06/pvFAzOGCMLl1G+T6QOVgh5DBX8CMqJHPIkCPi+Hg/hGDJbAyN
	IbCQnlQdoNZyFR6OMDrTUBAvoD5Pdu71/8R/7WTHBFHV9/ZInk13GBA113kKn6+NrBM1lHLiZy3
	Zk6hrUXtJAy6oXbk2pfjtwgoETyexB2q3iiGmNhUxz4KYx2P7CkgaZ12HEbN31MxCplh4A==
X-Received: by 2002:a05:7300:fe87:b0:36a:1b62:da with SMTP id 5a478bee46e88-36a203ace60mr2130750eec.12.1793166891207;
        Tue, 27 Oct 2026 22:54:51 -0700 (PDT)
Received: from localhost ([2a00:79e0:2ebe:8:9958:9525:7799:82b5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a239198c9sm2765953eec.15.2026.10.27.22.54.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 22:54:50 -0700 (PDT)
Date: Tue, 27 Oct 2026 22:54:49 -0700
Message-ID: <03029b6324e9e95ad794ca57d187d52a@gmail.com>
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	linux-serial@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: serport - defer write wakeups to a worker
In-Reply-To: <20261023-submit-serport-write-wakeup-v1-v1-1-74e7311638a2@gmail.com>
References: <20261023-submit-serport-write-wakeup-v1-v1-1-74e7311638a2@gmail.com>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi James,

On Fri, Oct 23, 2026 at 10:23:44PM -0600, James Hilliard wrote:
> Defer the serio notification to a work item, as required for transmitting
> from a line discipline's write-wakeup path. Keep the SERPORT_ACTIVE check
> and callback under serport->lock to serialize with serio close. Cancel the
> work before freeing serport in line-discipline close, where the TTY layer
> has already excluded further line-discipline callbacks.
...
> @@ -66,6 +68,16 @@ static void serport_serio_close(struct serio *serio)
>  	clear_bit(SERPORT_ACTIVE, &serport->flags);
>  }
>  
> +static void serport_write_wakeup(struct work_struct *work)
> +{
> +	struct serport *serport = container_of(work, struct serport, write_wakeup);
> +
> +	guard(spinlock_irqsave)(&serport->lock);
> +
> +	if (test_bit(SERPORT_ACTIVE, &serport->flags))
> +		serio_drv_write_wakeup(serport->serio);
> +}
> +
>  /*
>   * serport_ldisc_open() is the routine that is called upon setting our line
>   * discipline on a tty. It prepares the serio struct.
> @@ -85,6 +97,7 @@ static int serport_ldisc_open(struct tty_struct *tty)
>  	serport->tty = tty;
>  	spin_lock_init(&serport->lock);
>  	init_waitqueue_head(&serport->wait);
> +	INIT_WORK(&serport->write_wakeup, serport_write_wakeup);
>  
>  	tty->disc_data = serport;
>  	tty->receive_room = 256;
> @@ -101,6 +114,7 @@ static void serport_ldisc_close(struct tty_struct *tty)
>  {
>  	struct serport *serport = tty->disc_data;
>  
> +	cancel_work_sync(&serport->write_wakeup);
>  	kfree(serport);
>  }
>  
> @@ -249,10 +263,8 @@ static void serport_ldisc_write_wakeup(struct tty_struct * tty)
>  {
>  	struct serport *serport = tty->disc_data;
>  
> -	guard(spinlock_irqsave)(&serport->lock);
> -
> -	if (test_bit(SERPORT_ACTIVE, &serport->flags))
> -		serio_drv_write_wakeup(serport->serio);
> +	/* A serio driver may write to the TTY, so defer the callback. */
> +	schedule_work(&serport->write_wakeup);
>  }

Thank you for the patch. Deferring write_wakeup() in serport makes sense
(it also breaks a port->lock -> serport->lock -> input_dev->event_lock ->
port->lock lock ordering cycle with input event callbacks that call
serio_write()), however could we tighten the lifecycle and avoid scheduling
work when the bound serio driver does not implement write_wakeup()?

Right now serport_ldisc_open() sets TTY_DO_WRITE_WAKEUP unconditionally
(and never clears it), which means tty_wakeup() will invoke
serport_ldisc_write_wakeup() and schedule work on every TX wakeup even when
no serio driver is bound or the driver has no write_wakeup() callback
(every driver except iforce).

Instead, we can initialize serport->write_wakeup in serport_ldisc_open()
and immediately disable it with disable_work(), without setting
TTY_DO_WRITE_WAKEUP there. Then in serport_serio_open(), if
serio->drv->write_wakeup is set, call enable_work(&serport->write_wakeup)
and set TTY_DO_WRITE_WAKEUP on serport->tty->flags; and in
serport_serio_close(), if serio->drv->write_wakeup is set, clear
TTY_DO_WRITE_WAKEUP and call disable_work_sync(&serport->write_wakeup).

With serport_serio_close() draining the work before serio->drv or
serport->serio is torn down, serport_write_wakeup() will not even need to
acquire serport->lock or check SERPORT_ACTIVE before calling
serio_drv_write_wakeup(serport->serio).

Also, in serport_ldisc_hangup(), please clear TTY_DO_WRITE_WAKEUP and call
disable_work_sync(&serport->write_wakeup). tty_ldisc_hangup() explicitly
invokes ld->ops->write_wakeup() right before ld->ops->hangup(), while
TTY_DO_WRITE_WAKEUP and low-level driver TX wakeups remain active until
after tty_ldisc_hangup() finishes waiting for serport_ldisc_read() to
unregister the serio port. Disabling and draining the work in hangup
ensures we stop TX wakeups immediately on hangup and keep the work disabled
even if an asynchronous driver probe races with hangup.

Thanks.

-- 
Dmitry
