Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07AED1A0BF1
	for <linux-serial@vger.kernel.org>; Thu, 24 Apr 2025 14:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745504256; cv=none; b=DXAZJY/YnIBpNqcapBl1RT3VF8/j8vmnuoovtZZPAYDnF9rb/r70zmhz6UfAt0RcXlJKOFLGvKVBEzJ7NJrU+nCRvTSSezhx4bqZYYJn6Dn275OK1Q40Xgi+jfkdPDLtG0SFJ13AOrNzlZH6zbo5PYjK1Sapoth1bwPXdUWjivw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745504256; c=relaxed/simple;
	bh=35O+eXZY3DntnXcoScC+cgKTYZRl9WtcNpQPiQcipuU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o+HlGgAMhSqx5dRv2G1r0gXbYe4m4/IPOxUms8dGIXmHP/Li7mdS0jrJ+b8eAjiToe06m6nlPPNTC/AHB8deYIQ+6YsJmgKgrFEEZ5evgQP74JyOPPqx0EW9l+OWYMAnD5upLrcj914KSVTBTY0yyXGljYiiIs+uCHYPmvyPpic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CPBNdpJN; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CPBNdpJN"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-224341bbc1dso13618975ad.3
        for <linux-serial@vger.kernel.org>; Thu, 24 Apr 2025 07:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745504254; x=1746109054; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0z+evxns/Bjoiul5QbaAUNVJI+dR1D6acIWhDeMpntY=;
        b=CPBNdpJN3X9BLQxAkKI+0NWfYIO1FmXar3o2Cak2meJySPZN9rbYvNC1px6vrR5oDW
         VuBGwzOZtci4KvL2IufaghL3Ef81k+PnhXqqlH2A/C6ZwBxE9u2lMCZ/ew3+oXR56v4f
         +vGNl2t+pVyl/vYW0EvFw32qPhnC4Rc38lbZKesrPoPvgUB5sd8TCtvPxjryIH0bhWNM
         5YRtfZukfiR8zMOJQw8kY5sALOIouLurFiElRWsizPGJymbBp639Fj1T1wnjdCLAAMAh
         xvfQfNq8TTFgBke5aEeU7IjBDik1oAN0Bng11AJexgsRogshKhiYHo3MBHItgLSxeb01
         /Jzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745504254; x=1746109054;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0z+evxns/Bjoiul5QbaAUNVJI+dR1D6acIWhDeMpntY=;
        b=gqzWuQutJHNbayApNJXyMdIR5OxlP1MbZ3pe+6uqntDQfigBv5G1HpVfOEXnA6NnYb
         yXUhgWs8xibU4PvgJeqirOe6FAbDqXFQMqx2MSGqtX28FPNHnuw4YB4Y6QLuZrQOyqGD
         +05ggeDrUMjb0AUiMR51xHTdI8U8JDiFQiH4iXsVfLacHI7WWVLHbm1uUXRmadlyuuAD
         fe0n18iVUz8fNa5iz4NEcIjPUZoNrRQYBo9etHD1RUjwMlIULx5KJ4q6Rnk12Y7HPug8
         vLo6w0lFAvVu22BV6VtKy3ZTAy2ed7ltlS6D3iJFUjGfZLYvctVlvSQjzoT+7b/qQaKt
         wRWg==
X-Forwarded-Encrypted: i=1; AJvYcCVWKXgbOuOEkVh9agHhaYbIcJjdrv9nFo66iImTZnWne/miTgae3fMgxnsDq46n3cIB0uq7bUeTyz71Isk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxA5cg3rMrCda2bMV3sFJWu/ZN9HO5R4pgqlMP7BRvfvZayPPte
	Ak8Hm12bMWHT4fEJ1gwxHj1lJakU7dThX5eSYMw+EGyCOnvy0bZJ
X-Gm-Gg: ASbGncu1dAv10sB2ECI7Maqc5GdNxyDHO8Oomu2sXeWYQGXEyiLJtupES0kMZ1jEbFF
	azDKgDyTDSypx3VPgqCqcuRkmUyx1svGgjxk90os7x0E1rYylwo49yynaacJtsOJa/bZa8MJLbY
	N6a2QXQgUyKmC8hMNcBGlgWjYaJKKOALozobeDksAWVnIy/mrJrXly+sfb8DwbJiprF4uzsXAb3
	IXKIqMYNjQxCEovIUfRHmB90p+qm1cgsL4kiruku2/0CqKzEumn5Nknt50GE/CkCYPwq7MkE0mr
	J9pdaXc6oh4yEL5ppozJG+t5t6oT8TiyLFkAyYk5Fiqwj0VBj6t42Ury
X-Google-Smtp-Source: AGHT+IF8usctblLAnINg4TnTnQrVnn39vt8hoeGJDJEx4okN1SFMxnOPPtCRy6Y/LdW4YicZvSuIUw==
X-Received: by 2002:a17:902:d2cb:b0:22c:2492:b96b with SMTP id d9443c01a7336-22db3bde36bmr39814175ad.15.1745504254192;
        Thu, 24 Apr 2025 07:17:34 -0700 (PDT)
Received: from fedora.flets-east.jp ([2400:4050:a0e1:7d00:529e:8ad4:796c:105b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db4d74c93sm13760085ad.11.2025.04.24.07.17.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 07:17:33 -0700 (PDT)
From: Ryo Takakura <ryotkkr98@gmail.com>
To: pmladek@suse.com
Cc: Jason@zx2c4.com,
	gregkh@linuxfoundation.org,
	john.ogness@linutronix.de,
	linux-serial@vger.kernel.org,
	lkp@intel.com,
	oe-lkp@lists.linux.dev,
	oliver.sang@intel.com,
	ryotkkr98@gmail.com
Subject: Re: [linux-next:master] [serial]  b63e6f60ea: BUG:soft_lockup-CPU##stuck_for#s![modprobe:#]
Date: Thu, 24 Apr 2025 14:17:28 +0000
Message-ID: <20250424141728.7949-1-ryotkkr98@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <aAn-PkxRAz34tTPR@pathway.suse.cz>
References: <aAn-PkxRAz34tTPR@pathway.suse.cz>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 24 Apr 2025 11:02:54 +0200, Petr Mladek wrote:
>On Thu 2025-04-24 17:11:01, Ryo Takakura wrote:
>> Hi Petr and John!
>> 
>> On Tue, 22 Apr 2025 14:15:01 +0200, Petr Mladek wrote:
>> >On Mon 2025-04-21 12:41:50, Ryo Takakura wrote:
>> >> Hi!
>> >> 
>> >> I would like to follow up the last email that I sent.
>> >> 
>> >> First, I'm sorry that I later realized that I should have tested
>> >> the rslib test as an inserted module, as how the robot does, by
>> >> choosing CONFIG_REED_SOLOMON_TEST=m.
>> >> Not as a boottime test by enabling CONFIG_REED_SOLOMON_TEST=y.
>> >> 
>> >> Running the rslib test as an inserted module without the John's series
>> >> was less prone to softlockup. Without the John's series, softlockup shows
>> >> up once in a test or not at all. With the John's series, softlockup can
>> >> be observed constanly over the test.
>> >
>> >> >>Thanks Ryo for looking into this! I think we need to have a technical
>> >> >>explanation/understanding of the problem so that it is clear how my
>> >> >>series triggers or exaggerates the issue.
>> >> 
>> >> As mentioned earlier, I'm sorry that I should have run the test as
>> >> inserted module... It seems the series does make the test more prone
>> >> to softlockups.
>> >
>> >IMHO, the main difference is that the patch "serial: 8250: Switch to
>> >nbcon console" removes touch_nmi_watchdog() from
>> >serial8250_console_write().
>> >
>> >The touch_nmi_watchdog() resets the softlockup watchdog. It might
>> >hide that the CPU did not schedule for a long time.
>> >
>> >The touch_nmi_watchdog() was there because the console_lock() owner,
>> >used by the legacy loop, was responsible for flushing all pending
>> >messages. And there might be many pending messages when new ones
>> >were added by other CPUs in parallel. And the legacy loop
>> >could not call cond_resched() when called from printk() because
>> >printk() might be called in atomic context.
>> 
>> I see. Without the John's series, the cond_resched() in the mention
>> code path should be called during the rslib test as it's not in atomic
>> context in addition to the touch_nmi_watchdog().
>
>Just to be sure. The right fix is to add cond_resched() to rslib test.
>The code should allow scheduling and do not block the CPU for too
>long.
>
>touch_nmi_watchdog() just hides the problem. It was used in printk()
>because there was no better solution.

Understood!

>> I used this kernel[1] which is for raspberry pi. Let me recheck
>> with some other machine with Linus' master and linux-next to see
>> if the behavior is raspberry pi specific.
>
>John explained why the emergency context helped. I think that we have
>a pretty good understating of what is going on there.
>
>I believe that the problem will be the same in all code streams.
>It might be enough to check one of them (Linus' tree or linux-next)
>just to be sure that the fix applies and it has not been already
>fixed.

Thanks for clarifying.
I'll make sure that the problem can also be observed on either of
Linus' tree or linux-next and they still needs the fix.

Sincerely,
Ryo Takakura

>Best Regards,
>Petr
