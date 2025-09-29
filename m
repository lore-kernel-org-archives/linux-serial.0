Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C94A27BF7C
	for <linux-serial@vger.kernel.org>; Mon, 29 Sep 2025 08:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759135843; cv=none; b=WRzApSkCwnswP2nB49n6MwdVWR8N27/6BcAG3dAyU7TBf8+pVmg4RZuGg7zYU2RHOSyKZ7uECJH95RnRKveoqJUWA/LpFQiNQcwcfCjBFdevV1tRm+BNqbg1pI1pYsi9mDlrnMElxZMAekRiMHdhXYdp7CvaAJVte7/SDgN0kLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759135843; c=relaxed/simple;
	bh=c+9Zr2OF83HBvaK+XqqJLlx3/W86r07CDhX3cEewtsM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jlOkjno5D6T8ko6T11HkDLjnBRrCd0teJoTFD6HUxpm2wSmL+a9ouqgBWcmiPGhA9QEQgs3O9ACfwjExDmMdRUHmSjhXCzv/W7lajJ30LRGsiG1ZoY6GUR61nV5IHs5yC4CwxdjCk0IcCBZoxd1oeeONH7JmeN7RCY4IcHywQ8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk; spf=pass smtp.mailfrom=thegoodpenguin.co.uk; dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20230601.gappssmtp.com header.i=@thegoodpenguin-co-uk.20230601.gappssmtp.com header.b=WSilErLV; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20230601.gappssmtp.com header.i=@thegoodpenguin-co-uk.20230601.gappssmtp.com header.b="WSilErLV"
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-8ca2e53c0d3so191902839f.1
        for <linux-serial@vger.kernel.org>; Mon, 29 Sep 2025 01:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20230601.gappssmtp.com; s=20230601; t=1759135841; x=1759740641; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=omySSYONQjyq4CRJmwEyfFKCPXkUZxqazybffU9Te1w=;
        b=WSilErLVg8cZKkL5QDR4LjFXj4GZt3WzGuYNgaB+WUecUemYLKVgmuZcmiPG2AzHK5
         n9OLKq2sPZE+jErqyk/ri76ocXPqPsXYITEPHKZsTQpktVL1qBrB23rsOYujbigUBHRr
         sdWZr/YyN1jNO8uoZ+D5okpEeTf4aVfq0PvNeHYK3frzHwScIcGZg2S7d5CIn5pVssuE
         DEMcmuUdsr7sBxcTpweh5f1YNI1M+bmH2X7ISPTdh9RTINLUPw7tXzdd/rgW+Jnf4Nel
         CCjA/CmEd0in9TBoJkk6/X5lXym7ES0C4wORBaniFuNTnZvy1fEUzw5qS6xP5LLmtkRb
         ZDRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759135841; x=1759740641;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=omySSYONQjyq4CRJmwEyfFKCPXkUZxqazybffU9Te1w=;
        b=HDMwz0hEaiGCEufzbxva0Nsn8EZSj+M1OL/WNx4kjqjl84ex/eGS0FAj3WqSmT3FAj
         jOhkeL/tQZpSH5ErzL3EWyHQcdbBmRLavMoXU3RS3SoQ8W+f4EfKta76m8xTrm3y7UOl
         HJPESwjy/P0wUhDIOwWSJv75aMs2Oeg4hEQWi1RW0aF/4RWimnQD+RYRBAc7bXN58ZJp
         AsY18ZVxKRaoERAYh0FHCOYju+hlShfjUmlAm20CKc21HDqUX/+lXNCGpdjCCV7GJ9nX
         Wza7pq/WiiFDAMJ1rm9FD38UnR+50gudLKI0Q/8V1iQ9Lbyv+Mx2HgX1XfdrAfSFmx+M
         +BOQ==
X-Forwarded-Encrypted: i=1; AJvYcCVD5qMOizCZj9A1WCa26ISyHeZLWRauxVnfGo4OvP3B87WPApUdnKL6wNznbgkjNLxEepTtx4SBArhfqM4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZabXsH3VVLGYi4uYzF9CzjHUKKBRzpj+04oyhem6wzXcBzx08
	Js7n2Q481ULKxfHhfMML3nmglDpKPwNdeJpBZh6LLzkkzZgWQkUwROGJN4FZZ4b0N4v1cMjy1gj
	nY4kpjB8cYOvpejtI8EZFdHL4NCi/fhCHN+JFYtjjyg==
X-Gm-Gg: ASbGncsFPB4FV3wbHhrC4q83F4jwt+4slQWftgy7PZwM2iiYKydFOjOqerkv+yaH8BT
	1nikQ1G3kYLEEZFEJomkmUU8gmXdDKAot8PmfAoC29Upv6fOJ0ZHx53wTw5OD2fGB0ACDM1CWxS
	Ukw1frO5Nobi1ssXLP4PxCNjDYxaiptxiWOgRk8Xl4R0PJYqiHJe0gxQM7/KjsLEXRhF1a9bGvZ
	LQPeYU0NEAbYsX3M1Gd7sBp7Odf8w4v8yrCEXyo
X-Google-Smtp-Source: AGHT+IFe2KxVUzzK5sabl2rokVr2v696XAURYfuVjNJ5+CtdiRxH8OO6QdoW1deS8WHtLy12IJabmdlvZ2pPAjcgK3E=
X-Received: by 2002:a05:6e02:184e:b0:425:8857:6e3c with SMTP id
 e9e14a558f8ab-425955f47f9mr234725575ab.11.1759135841140; Mon, 29 Sep 2025
 01:50:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822142502.69917-1-pmladek@suse.com> <84qzwzbr90.fsf@jogness.linutronix.de>
 <aNFR45fL2L4PavNc@pathway.suse.cz> <84348eju8a.fsf@jogness.linutronix.de>
 <aNO7Qjv_iSUSifTv@pathway.suse.cz> <84348crpi3.fsf@jogness.linutronix.de> <aNQO-zl3k1l4ENfy@pathway.suse.cz>
In-Reply-To: <aNQO-zl3k1l4ENfy@pathway.suse.cz>
From: Andrew Murray <amurray@thegoodpenguin.co.uk>
Date: Mon, 29 Sep 2025 09:50:30 +0100
X-Gm-Features: AS18NWAWISHd5SmPiAf9UbtWDXG5PoO98UEAf0UXtMSVTMZ2nK4fH6wu2WCgNHE
Message-ID: <CALqELGycYx7GSVWwoBaWipoF84EG6iYu37F0pWif1MFVEkotaQ@mail.gmail.com>
Subject: Re: [RFC 0/1] serial: 8250: nbcon_atomic_flush_pending() might
 trigger watchdog warnigns
To: Petr Mladek <pmladek@suse.com>
Cc: John Ogness <john.ogness@linutronix.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Esben Haabendal <esben@geanix.com>, linux-serial@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>, 
	Tony Lindgren <tony@atomide.com>, Niklas Schnelle <schnelle@linux.ibm.com>, 
	Serge Semin <fancer.lancer@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 24 Sept 2025 at 16:32, Petr Mladek <pmladek@suse.com> wrote:
>
> Added Andred Murray into Cc.
>

Thanks for the CC.


>
> Well, releasing the console context ownership after each record
> might solve also some other problems [*]
>
> I am going to try implementing the 3rd solution and see how
> complicated  it would be.
>
> It would be possible to change it two 2nd easily just by
> using a global counter and updating it in emergency_enter/exit API.
>
>
> [*] Andrew Murray is trying to do similar thing with console_lock
>     and the legacy_kthread, see
>     https://lore.kernel.org/r/20250915-printk_legacy_thread_console_lock-v1-0-f34d42a9bcb3@thegoodpenguin.co.uk
>
>     He told me off-list that he saw similar problems also with nbcon_thread.
>     I am not sure but it will likely be related to
>     __nbcon_atomic_flush_pending_con() blocking a nbcon console context
>     for too long.

I replicated my 'slow serial causes delays boot via contention at
filp_open call in console_on_rootfs' test, both with and without the
last patch [1] in your "printk/nbcon: Prevent hardlockup reports
caused by atomic nbcon flush" series. Though I found no obvious
improvement from your patch. I found without the patch the delay at
filp_open (with 8250 nbcon and with PREEMPT_RT) would range from 1.6
second through to 40 seconds, and with the patch from 0.07 through to
26 seconds. Potentially promising, but the numbers are all over the
place, so there must be something else going on. I'll continue to
investigate. In any case, that's not the problem your series was
trying to solve.

[1] https://lore.kernel.org/all/20250926124912.243464-4-pmladek@suse.com/


>
> Best Regards,
> Petr

Thanks,

Andrew Murray
