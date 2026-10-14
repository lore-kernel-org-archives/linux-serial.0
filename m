Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2934BEE30
	for <linux-serial@vger.kernel.org>; Wed, 14 Oct 2026 09:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791971931; cv=none; b=Q8ZVYSSRVvVMNP1lUbkZXN7ajVCBVDezhdWO9foHvHjhRroS0pLdBMkE4w+tlHPvK5V+mbBeQPaLtV6raW3njhRSixdeeRw1eHpT7JCTx33oJnRzdckVjmJOP/L/0ItfVB9ke8tq+sSNldCbU8ASKyRgiTfkedvJA4ws/bUnacg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791971931; c=relaxed/simple;
	bh=BAQXLR2dkPzKchboXtcNoo/ogJj2WJd8NAUJtk9xOFY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R/G9ZgAMxxBkTCgmXfZwwF5UHWQp/fzXJz6GwBAQrJzC7Toty8E8PmfAi4mpRpwtvy4G8l1Tl1Q3c0hPGB1H3DTeLW1eoQ8akbwH+ia9FAuIDMgDDu7Srh5K1GrNIA2lokVTZ98vYmGqTuLQgRJs1/nheRfwbYpOb8BiUjrD7o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=es42qP96; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="es42qP96"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-48c411d6615so2814540f8f.3
        for <linux-serial@vger.kernel.org>; Wed, 14 Oct 2026 02:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1791971928; x=1792576728; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WG6+gwgE2I1qtYxzZ69xcwnm3jHk2auPi3T4llnIwQE=;
        b=es42qP965kfeQPS6hHYgPGA8/ql8EmwZhNqspWyYsCOXpcgV6qPgkGU786cltLkAfN
         YaHSh3EMUICvy+Oc9szcIgH1DfAmiO1/543nlH3WIdvN0kY4GL1b1NknZQ7QMgQNi0Z/
         oIUdV+xIrNd7CHIj5UkPkwYtZOMw3Q2ufu1bXoIy6DVSXT1VTDKHSX8WpyOi7+8zeVv+
         3Wgz2O0o/EQtUfmpsGWojasXeDuod8bweAU/A8HEe/N20GxmZuBj3fXC6vl0x8wkrKVY
         3yC7M3Y2vM7vZyUzMfUVgJ5qgQj00FGig06TTxwEnVXQuJtDMH3laCM+AgpIvKGHjCkL
         4hFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791971928; x=1792576728;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WG6+gwgE2I1qtYxzZ69xcwnm3jHk2auPi3T4llnIwQE=;
        b=v3qfBYvLNInpI8uBXp27/xJgz6h51mOEY/seFleyDM/eBO4+MnWDXZ3DeRfFUNJBg+
         M3uZxnfRQIM3sh5UMCOv1UKoKHBg66512gTC0KIzN0qF/iB58+myYeR6PCenYS+rUnfh
         5cI6a3FjRZcrgij7N3sDASoon6Qr6/x/yZKeEZH9ebm57Vr21f992b18WhGQLjL0hlwe
         FaFMi1C1FDWGEuOMli1seGgr9l/+YTXNKTvQdtwRDfkL0HmFRDEI0HNSWGLrcRYdfTOM
         yg2+a7mFKR5RCFjjRdRdJdiXTzTt2dzpZb3Xq22KJsqa5BL8qthPG1fRjgFd1s/e+uVS
         IXVg==
X-Forwarded-Encrypted: i=1; AKwUvBx55cpO2PmG9d6gPMkPcmk2DYhCtxmC8/S1HzjjUipGNdu4BvSsGqXGRIuI9kfe5QshwbToCoOZDuJvlRw=@vger.kernel.org
X-Gm-Message-State: AFq9FYI+xfZjMFCidiRAI1WryMqcjkqaur8rRRjVfw2lfkyh/OGT52fG
	J2OZU4dch6u7Ch45Cl2zbz26Bznb6fejigSpSBTruXHQuJyFvzNtE1pUAuNDWbL7uVc=
X-Gm-Gg: AYBFou3ow2tSN/iW+P6rJLZv2XsL39DPX4/MeqZnfbFTfN7nDuJoWExjBraFmsl+bvG
	OCuiMJeo9Clgh/6tLwd9RivQt6INExFNzPeJbR5jbk990Xtog3dUaMuyfnLqFS+/3qTTIu6laoF
	YdlOMs4ulZOeI+nXwOWDZF+9P2cuZzmzKdWhhjw8x0IpcelF9fAsWzfa/lS8NzOGWLe1Whecv8G
	mvLEKlIsMkGsohDCPPq2/1yWypDFVzh5cU7vBN2jWYrAYgJR9Spz/ucETLzxA8A/MJDjlK4/qL8
	Dw/6J/UWs7Uzk6+CCBIKs0Mvh8805cQ5uQkJpZYtmqCl3bSEPtF6VncEaIqBi6PX7UCOFz08JPR
	jDkSA9KbTykrokrCVf2qr+lWvjmy8nmtnarazBDCbDXPwrbKgH24E9a4AiwFw6itLfMXfpozx1n
	RjLs6i0oNyeGmhfVnBnxmy2Rft5GfzdYhEdfW4ktgqcJl3UQ5HuiwUWw1hpkSKKAjbT+aGwe+l
X-Received: by 2002:adf:f94e:0:b0:487:1256:ab80 with SMTP id ffacd0b85a97d-48dbad0d4fcmr22286473f8f.57.1791971927711;
        Wed, 14 Oct 2026 02:58:47 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de09693c7sm13559825f8f.4.2026.10.14.02.58.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 02:58:47 -0700 (PDT)
Date: Wed, 14 Oct 2026 11:58:45 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	oe-lkp@lists.linux.dev, lkp@intel.com, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] nbcon/reboot: Switch NBCON consoles into the
 emergency mode in emergency_restart()
Message-ID: <as9SVaRU7mEvcsVe@pathway.suse.cz>
References: <20261013154141.94016-1-pmladek@suse.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261013154141.94016-1-pmladek@suse.com>

On Tue 2026-10-13 17:41:41, Petr Mladek wrote:
> When the system is going down a normal way, the NBCON kthreads are
> flushed and stopped properly via a syscore shutdown callback, see
> printk_kthreads_shutdown().
> 
> One missing piece is emergency_restart() where the kthreads are not
> stopped. It might be called from several non-panic code paths,
> e.g. sysrq-o, kdb_reboot(), or some watchdogs.
> 
> Fix it by explicitly entering the emergency (atomic) mode and trying
> to flush the consoles there.
> 
> Note that printk_trigger_flush() must be used instead of pr_flush()
> because the later is not safe in an atomic context.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/all/202608061008.48a1e76e-lkp@intel.com/
> Suggested-by: John Ogness <john.ogness@linutronix.de>
> Signed-off-by: Petr Mladek <pmladek@suse.com>

JFYI, the patch has been committed into printk/linux.git,
branch for-7.3-hotfix.

I am going to give it a spin in linux-next and send a pull
request on Friday unless any blocker appears in the meantime.

Best Regards,
Petr
