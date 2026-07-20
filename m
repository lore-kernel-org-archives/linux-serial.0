Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E845400E0F
	for <linux-serial@vger.kernel.org>; Mon, 20 Jul 2026 11:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784547969; cv=none; b=KOz8/qIkhlOR6YkMaRhhdIO0KIDT2S3R7rhHLEXvov7vaNDXGnD2y/pP2AR5IWknpn9wlF7OejUZRJJX1GkeWGiHMsidT9eij+zHfXyF/rmrMjBqzAsHVlIclLOkatVle6Gwfc7fmK/dCPsZtseHgrgUITT7FOXPAJe3CKGBNsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784547969; c=relaxed/simple;
	bh=fUp4cei3BPr8E914jW1LFi71X7u+EpY3vf8k/rOCOA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q82tAmu1PbuVnSYjyfr81HDzQADYBei4Gn16zatVpdrre2lh4+q4cxtsO8wy2h4LhogiqGX5yWZO6yRroVMHIHI5V0dfIj7HjKGWpeQEFB06IJmes+Fg5AHOYVBO5VPD884xLqtTfRJ1WyRIjrmvFE1aXfp2QJweSkp8e3enzrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=VkVnIS2H; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="VkVnIS2H"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-472326ca506so7712124f8f.2
        for <linux-serial@vger.kernel.org>; Mon, 20 Jul 2026 04:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1784547961; x=1785152761; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fsMxsXjpGTSr2po7Wxk96V1yFnPC/aTK9Y7JzwyoR2U=;
        b=VkVnIS2H5BufBwPLPEGC7BoPG8cuc+KdrzASdI+3t5OLH6rT+nV3I+0HAgKm9XeqeW
         lhVP9FYe89ZH7XCCaAQreJoXKvTJcDWKamSw407F+4StWo9bNxUr4/5Wp0e6LTS+XFEa
         V4/DaMuMrJngWP2WIaZYaBxZ3l6Z6oDPoIfQyiKnnzmCE+b2NYIusYXxYzLgLFL8I3Pg
         PcXG2+ChoD8K9D/6mgKmmV8fx+OMKM3P6C7T5ebV4gTzx2FlmUPZofLJYiRMwv7/dOxs
         KjDr+EUsLKk3qR94z1eMADNwEiGbXDIIWuT3rpv2LQo135URI/f9iwbqq4EMGQZ/ou8q
         nRLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784547961; x=1785152761;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fsMxsXjpGTSr2po7Wxk96V1yFnPC/aTK9Y7JzwyoR2U=;
        b=HyVgq0wjFj5WwZPe4kq5PplC1j/DnN+7mJ6/Xs9daI9pvzpC+vRVodIwswQSN9vUP7
         T7WlYUFDQ5evTH39vwbQ8jjx0M9cSONCyaDwogzy6LSkT9ecemn4xH2QAZNOcVt0pGDi
         3vYN/c08rtMadp+KtyP/pZoL8XlsVYrnmTMaFentwpFXBWfSGZrCIP8gHdyueC0WGpk6
         bW7D0mOfOoFERMZ935PhWs6Di7OM4eyfZLb1EssACW5GfC9Wcv4OuapjISz6S/hK/97x
         n25r8S+XlB9uIFm+dTrATROEyThrOTtEO2Imdqa9ec5Bq62sQauMUaAznsXT+Ei3m9j8
         1pxA==
X-Forwarded-Encrypted: i=1; AHgh+RrcHDXrzv4ua2Xhgp8HEQbSAQanwOTVCiKd0oCwH+Cjj0ShJX+9aFZfMP+739cJcSXRpEK1xS9Xu57XnTg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnQiZGnJIQVEEEIZVZ3Hgm21I/CIqDZF+Gc3O+aSEVUelV2E7O
	XTadR63cd7tE3G+tRYfgr1Jzrlh7+A2vOA3hh/fnJ3eRvLcD0k2xnu/ep075UC+/Mqu1In+GCwa
	A4J3WgmE=
X-Gm-Gg: AR+sD10QyfzMULo0OKpPyzmqdFaVsDSTu46XQ5gHpUVNmYoDexqTTwYFsD0yv8SIlZ5
	Bx1+ZLpIu6Ai+ASoVcKZgnqbD9KLCPT8N3Z9B7U5tUvOScFCPkz162O5mqLXDZMtXKMuY4N8stC
	3xX/zZXmVzlSS8ywm+IqNqox+P5e0zhQvse6D7I34sfKtk9jgkQUT19w2mdXKlnh2rm4L4mfh5j
	69obqD7tnEnQVNPbAZmoyouLrxlRxSRdRYF+WYQy7+ZneTDgNivjvPAkx9vxJU7Jxn38ow/8JJB
	pnYk/XY9+ihSIYFPnkSAf0ifkxlILyRpcQkvvPIn6R+9R0R1cog1L9yJUkN4Qj6NxhsHeXpczSA
	Pb8IMtTmwvYsxin5kRfD1td8qq03xq1Ne+7ewkqqOghJbBdAuXMOy0qp9Pw8eaYgN/DF122Ad8b
	b8ksW/
X-Received: by 2002:adf:e351:0:b0:478:77c1:787c with SMTP id ffacd0b85a97d-47f6233bf07mr11020582f8f.56.1784547961445;
        Mon, 20 Jul 2026 04:46:01 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63e65644sm27955963f8f.16.2026.07.20.04.46.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 04:46:00 -0700 (PDT)
Date: Mon, 20 Jul 2026 13:45:58 +0200
From: Petr Mladek <pmladek@suse.com>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Russell King <linux@armlinux.org.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-devel@lists.linux.dev,
	Toshiyuki Sato <fj6611ie@aa.jp.fujitsu.com>,
	John Ogness <john.ogness@linutronix.de>
Subject: Re: [PATCH 2/2] serial: amba-pl011: keep console clock enabled for
 atomic writes
Message-ID: <al4KdsU9YLOmwDoV@pathway.suse.cz>
References: <20260719063502.18852-1-kmehltretter@gmail.com>
 <20260719063502.18852-3-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260719063502.18852-3-kmehltretter@gmail.com>

Adding ARM mailing list into Cc.

On Sun 2026-07-19 08:35:02, Karl Mehltretter wrote:
> pl011_console_write_atomic() runs from nbcon atomic context, where
> sleeping is not allowed. It calls clk_enable(), which takes the
> common-clk enable_lock. Under PREEMPT_RT that is a sleeping lock:
> clk_enable_lock() first tries spin_trylock_irqsave(), but on contention
> falls back to spin_lock_irqsave(), so an atomic-context printk on an RT
> kernel with a clk-backed pl011 can trip:
> 
>   BUG: sleeping function called from invalid context at spinlock_rt.c:48
>     __might_resched from rt_spin_lock
>     rt_spin_lock from clk_enable_lock
>     clk_enable_lock from clk_enable
>     clk_enable from pl011_console_write_atomic
>     ... from vprintk_emit
> 
> This was found and reproduced on 32-bit ARM with PREEMPT_RT. In
> addition, write_atomic() may be invoked from NMI context and is
> documented to avoid locking. Since clk_enable() acquires the
> common-clock enable_lock, removing it from the callback also avoids a
> potentially unsafe NMI lock acquisition.
> 
> An nbcon atomic-capable console must be printable from any context, so
> the clock cannot be gated between writes. Enable the clock while the
> console is registered: use clk_prepare_enable() in
> pl011_console_setup(), release it via clk_disable_unprepare() in the
> console .exit() callback, and drop the per-write
> clk_enable()/clk_disable() pairs from write_atomic() and
> write_thread().
> 
> Keeping UARTCLK enabled may increase idle power on platforms where it
> would otherwise be gated between console writes.

Just to be sure. Is this acceptable, please?

I have no idea what is the real life effect. It might be negligible.
Or maybe it does not effect production systems at all because
they do not have the serial console enabled.

I just wonder if it might considerably increase the battery usage
of some devices, e.g. watches or earbuds, just because of the possibility
to write emergency messages via the serial console.

Best Regards,
Petr
