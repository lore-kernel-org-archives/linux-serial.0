Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD7D53CA60
	for <linux-serial@vger.kernel.org>; Mon, 31 Aug 2026 15:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788189840; cv=none; b=pi5Hl108qI82TyZzL7VwcwUGmDTy1ni+IS05vbeA3+VwaJaNGfds1LIGL7eB69Kyx5S8Z+o3DRVEzS75MV+yLr9KiyxZQgJaxvBtdBXHEPGG0uHMYcBmG/Zv9fIWdJ09CHDRl287KdV1KVwFyfPo/onl7YokUtdgTqiZBJUntIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788189840; c=relaxed/simple;
	bh=lK+WjgYKOmiQpd41H6DamAs2XPSk2nxGNLfuWcUvOZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N9aUOCex4vpkrenc05z+a3nHeQZqtx2p0LMORExw7R6xnMdIjBo4EK7sSsJXx43f9lhn1SpLowRn3tkMC0/rr/YU5Ie/SyqzuvzhaOapLAchaQvGgrpBNsEE2szgfZ3Adk+OOZF+cZFhSyDvgTW0LTrXTmdhVL9yXBRF8kibnnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=M1wJs4GN; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="M1wJs4GN"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-49cd9add88aso4851115e9.3
        for <linux-serial@vger.kernel.org>; Mon, 31 Aug 2026 08:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1788189837; x=1788794637; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cBxrB3Hi/S4n9Zm3fzIKjMzQqgS1ovGA5rzSORByASQ=;
        b=M1wJs4GNKmF5NxbDO6YN4A0MtpvANeb51TGETujCk79Q011uMXRnkKRMlO6BuosGem
         mZbQblO7iEkrnbiMH54BK3AYwV9TGSU2KhB+GTHG0Yg+/H/qGnt87kxyqs7ZQUHTp3jl
         vGIaH4kItv+E9+b9YT2uoJBGpPsAP1+WY7/7xEgyp7vQL3cVOvl1emLLM2fDXTGHIo5z
         aKC21roMLZpsgvlYlUGgiQT0Y++PCxNe+fHSOzgJGUca9nd4toZz5gIBXfRz4eZZUdXy
         fmfLaJry98bCeflFTGneTiYnx5xOt5rqm8G6U9DNsO5zh2kRqGMFdJbmK9CXi4qSOpS8
         cIiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788189837; x=1788794637;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cBxrB3Hi/S4n9Zm3fzIKjMzQqgS1ovGA5rzSORByASQ=;
        b=STpWw+4nZqDB9NukDwJThmCyqeBKWdNVA5JqKhBhzOi8zIb9+6k83T9AzEdE8JVaKP
         jDscJfdHH4PpK5XTy6RPbtTAeYh6tyF+Dwe8TT03y5Uw113c89QmQBeAXvM3TBYCSJ1s
         ZkaqyX+fB7/fFuw26fgzkj58r+Y+k1atJ+5jCoX8SgaRW5sHVpZv/DXVBXjgY2zI3hq4
         nBlasuhH/6PfrxIkNZiLSIXs9s2DNBqK6qkgtFIT79I0ipA1jlePBPQTOpknOg/SU9br
         WQSkp4TuPw/JJO/KEW6DpSWUcqmTDZDmY4EtUDYlINmX/vDxTH4UsPJ+zkA1FeqgmSES
         BVbg==
X-Forwarded-Encrypted: i=1; AHgh+RrHInBaUa1Lhn7O4c67wHuLbduE3tzUWyMvR2CqNC3Dqt2+/ijP/tmW7iVm7YUsBekyIlMWEk4bUSYhLvQ=@vger.kernel.org
X-Gm-Message-State: AFuF++nbT5awF8rxI98nZ8t0CNgpfSZKCTdQ0bT3OsTKRuqC+Odd8+77
	3wAI1j7V3r7fygdWV/dbm6cB1L7udNmNstUj0Ug10I+vJ7LEaBKNMPAw2dQyk+Qko3E=
X-Gm-Gg: AR+sD11qdGD/SXa04iTD4xnOHWGnD3ameWLkdLJxXyjO729AKiIEu6S397bv3ik0Cas
	oD2sVqj2d2BaDlZ+nSOuD5VpK8ZUGvpNkQVs6yzxaeXkwS/3W+XYfz1FK/Id/iF0k0GgO2UcIK6
	1DsWvkNtiFdudC454yT/q4UyBDs5whOmqoYqaFmUBYrDnxlZfK4IGzYglOD3HJCC+bqyNwGBs+m
	RxrHLXZYanwsPjhXuLrGfRGj2D3wmPBGicWDGoL1ddQCfdyYUPFwhx9i77BNzU5x0gLlIfTkwfQ
	fMdZaabwIRtAqjAWYSAs/0yKwSQeBgIeQHKK9wb2CFVQWj2ZMTrwUDCTSkrS+hQPo/CZaSeFcxg
	U+3+0IXKAwBaQ5QPERnrc0XNDx7cFSyQoZdzXGdKPNNq2jnnOc9lJqerFVzdR6L0O52A4pKy5LU
	RDvRR3AH2XAgSq+ighaOj3oR54b3cZyJSgqXsgW88rxTPYNYgQuiGk9EREI+NRaQ==
X-Received: by 2002:a05:600c:8b6b:b0:49b:c8e:8e6 with SMTP id 5b1f17b1804b1-49b91bd99b7mr454334485e9.0.1788189836942;
        Mon, 31 Aug 2026 08:23:56 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48432022ab8sm16453982f8f.28.2026.08.31.08.23.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 08:23:56 -0700 (PDT)
Date: Mon, 31 Aug 2026 17:23:54 +0200
From: Petr Mladek <pmladek@suse.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: John Ogness <john.ogness@linutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Jon Hunter <jonathanh@nvidia.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	linux-kernel@vger.kernel.org,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Crescent Hsieh <crescentcy.hsieh@moxa.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH tty 1/1] serial: 8250: Change console_msr_work to
 IRQ_WORK_LAZY
Message-ID: <apWcikIof_6CRNNU@pathway.suse.cz>
References: <20260828155811.270462-1-john.ogness@linutronix.de>
 <20260828155811.270462-2-john.ogness@linutronix.de>
 <20260828160652.TQBsi8oO@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260828160652.TQBsi8oO@linutronix.de>

On Fri 2026-08-28 18:06:52, Sebastian Andrzej Siewior wrote:
> On 2026-08-28 18:04:08 [+0206], John Ogness wrote:
> > For some platforms it is a problem to queue irq_work when entering
> > cpuidle states. Since irq_work is used for deferred MSR handling,
> > any atomic console printing when entering cpuidle states can lead
> > to the affected hardware hanging. Tegra20 and Tegra30 are examples
> > of such platforms. Avoiding raising the irq_work IRQ has shown to
> > circumvent the problem.
> 
> > Change the console_msr_work to be IRQ_WORK_LAZY, thus not raising
> > an IRQ upon irq_work queuing. The irq_work is then handled on the
> > next interrupt (worst case, kernel tick).
>
> Not on the next interrupt, on the next jiffies tick. Should you run
> tickless and should the CPU have the tick switch off then it will raise
> the irq-work interrupt anyway.

This seems to be more precise. There is one more scenario. It would
run in a dedicated kthread with PREEMPT_RT.

I hope that nobody would run tickless system on the old
Tegra hardware. So, this change should be good enough in reality.

Anyway, I would prefer to get this "workaround" in for 7.3.
In each case, I would not want to revert the uart 8250 conversion
to nbcon because it did break the Tegra hardware.

Best Regards,
Petr
