Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557B220B22
	for <linux-serial@vger.kernel.org>; Thu,  5 Jun 2025 09:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749116804; cv=none; b=GQw+4xnFURR4vTJ3kTgPU3P4AbzCdV8Pj0/u50TkM3FOxm5WWESpG95g2rNnii0cGdYjRmiUMUG9/p4afEz80mKEMPYiyGjwNAV/Rd+wjoOBI1IHS9G604hiBjcynNxUBClCtKPEgLi/yzKr43LhYNRWV4vrlrdbpjXbJoG4zRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749116804; c=relaxed/simple;
	bh=wnNS4HhULRyBFREAvZHyfSws5K9uvj//gUc7yGT6CpI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LeT2Q1YJgVjb9o0F0v23XLC1uyq4LQTD0qSIgKbCpx17OnpqC9obR0S8OILYqA8Fu/hGX2n30NhhebcxA+LdSTWCm6Bxnl83UkHqNYUT/5wpsBDFEYPBf3mgSzR9Bn4rvQjl967KtwVHhDwwot4c2KrZ6w5N9EVfBWujkvWJ+5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk; spf=pass smtp.mailfrom=thegoodpenguin.co.uk; dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20230601.gappssmtp.com header.i=@thegoodpenguin-co-uk.20230601.gappssmtp.com header.b=t24rVWWp; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20230601.gappssmtp.com header.i=@thegoodpenguin-co-uk.20230601.gappssmtp.com header.b="t24rVWWp"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-311a6236effso577530a91.2
        for <linux-serial@vger.kernel.org>; Thu, 05 Jun 2025 02:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20230601.gappssmtp.com; s=20230601; t=1749116802; x=1749721602; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wnNS4HhULRyBFREAvZHyfSws5K9uvj//gUc7yGT6CpI=;
        b=t24rVWWp60WwkOJ6moR2eXoU0A553vsmxVKAh8BDBQtUN8Wdr8hb+RuAQoKnj/jxG3
         zGP3zZcVuCXHNPdn3OJR94GNsPSc9b1FM8cWiu9wHkd6XdDImASxc0lUgWl1DT5SEKAn
         /dWLWtmOw33EfVDP9+dNBdFoZzmwZcqHvuXsb8clN6Xl5xAnvaQRibGyvrIllvYW5LbG
         JBcNUXyLz+UpPy2cRb0mnxcdoJVK68JCeoKR24+ZY/NqPuSEvGAH3FTYoMdlQU2/dhhj
         r7pKR6hMvznLjBH23y6oGjYaMgr6LqVt7nC8OD3c6YZCImsk7HEs6mJg1rB+6afCSGNe
         Tadg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749116802; x=1749721602;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wnNS4HhULRyBFREAvZHyfSws5K9uvj//gUc7yGT6CpI=;
        b=Hvmnzcf0voxushsr1lRsZQm6kO4+ykorg4G1EfkQOnS1njUdLL0WHwHLcruZEDtZPu
         18UnC+X2phXM6UclC17fLxI0WkoorqTR3sgw/njsmyU9dKK5oS0iSBLf0D+7ulifByTL
         qaCv4WgKZHO8XyN/io3ugxu04gqBy18TpLblpvGNfyMU4kVjpcMVWcDpnhhMEpNBgRyr
         AKUCJOy8D+X6/9rSnhNkCaNbdzQOKVGzXGFVCuPRYE/wNJbHOXyfFqLswUtKSd6y5lgY
         44P3yTD0PDkWSgr81BLTPY9J8NRLdZ8ltiYiimKjxCNWXdLzHG4a/3a7ODBTl5jlhftq
         MM6w==
X-Forwarded-Encrypted: i=1; AJvYcCU2Fyj+ZV5JZh66h9OlB4ZdNnkGMhZpDD3T3btNmeZERfLjWlT3Ux3SE49czl97wRDJusXihyNbhVMfL44=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaoWUmOSSsRINC2huRzttKgPlxhb0tSZtnGKAgm8hMlagk6h2i
	YWZCD4vU5FNUCSmjvA6DNYS/5jQGdGP0UXC6q+lZ2t27qX7pv1JlrH4Y5T8zQdsolvl+KnD7/mq
	eA4Od36Cng4WLNa+W59NRluCvq2XY2mOI7HgP+TvJlw==
X-Gm-Gg: ASbGncvctxrA3XgA249hnqhdcadtCdWm7zKQz9bPcfSZx/rEQ6pIUFjuDFECK2FVEy8
	jnp0Cy/8y/2QaFkC1FDsBLt36OPe9C0qeKA4RPU5EXALFbPrjSS94wKnfUCpMujtspM7sxy+pni
	ZOK5+4usZ5MDpzdtoOqSQHtE/W+6Zx0PY8
X-Google-Smtp-Source: AGHT+IFGGi6RW+Ple5Wj2uUthdfC6mUCtgiFUSAwFtEXZ2lvtu6VqU7yOVFh2lRK8DXTZ1sibCEWgX3LcQt6ubIiNGI=
X-Received: by 2002:a17:90b:4fc9:b0:311:b413:f5e1 with SMTP id
 98e67ed59e1d1-3130cd7b12emr7162901a91.32.1749116802568; Thu, 05 Jun 2025
 02:46:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250604142045.253301-1-pmladek@suse.com>
In-Reply-To: <20250604142045.253301-1-pmladek@suse.com>
From: Michael Cobb <mcobb@thegoodpenguin.co.uk>
Date: Thu, 5 Jun 2025 10:46:31 +0100
X-Gm-Features: AX0GCFsGRKoKjDpzuaKJUW8xRoFbxRydeDfH7Jd7KKAH6uvxjps5xknvmV5dIko
Message-ID: <CAC251sX=FezWGmZ==hAJg+8sbe-MS_CVSx8HwJfFthiAh2-L5g@mail.gmail.com>
Subject: Re: [PATCH] printk: Allow to use the printk kthread immediately even
 for 1st nbcon
To: Petr Mladek <pmladek@suse.com>
Cc: John Ogness <john.ogness@linutronix.de>, rostedt@goodmis.org, 
	senozhatsky@chromium.org, linux-serial@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 4 Jun 2025 at 15:21, Petr Mladek <pmladek@suse.com> wrote:
>
> The kthreads for nbcon consoles are created by nbcon_alloc() at
> the beginning of the console registration. But it currently works
> only for the 2nd or later nbcon console because the code checks
> @printk_kthreads_running.
>
> The kthread for the 1st registered nbcon console is created at the very
> end of register_console() by printk_kthreads_check_locked(). As a result,
> the entire log is replayed synchronously when the "enabled" message
> gets printed. It might block the boot for a long time with a slow serial
> console.
>
> Prevent the synchronous flush by creating the kthread even for the 1st
> nbcon console when it is safe (kthreads ready and no boot consoles).
>
> Also inform printk() to use the kthread by setting
> @printk_kthreads_running. Note that the kthreads already must be
> running when it is safe and this is not the 1st nbcon console.
>
> Symmetrically, clear @printk_kthreads_running when the last nbcon
> console was unregistered by nbcon_free(). This requires updating
> @have_nbcon_console before nbcon_free() gets called.
>
> Note that there is _no_ problem when the 1st nbcon console replaces boot
> consoles. In this case, the kthread will be started at the end
> of registration after the boot consoles are removed. But the console
> does not reply the entire log buffer in this case. Note that
> the flag CON_PRINTBUFFER is always cleared when the boot consoles are
> removed and vice versa.
>
> Closes: https://lore.kernel.org/r/20250514173514.2117832-1-mcobb@thegoodpenguin.co.uk
> Signed-off-by: Petr Mladek <pmladek@suse.com>

Tested-by: Michael Cobb <mcobb@thegoodpenguin.co.uk>

With this patch, on Raspberry Pi 3B+, I'm seeing the kernel will reach
userspace in ~1.5s, which is consistent with a boot with no console
output (loglevel=1) and at slower baudrates too. For reference, I was
seeing ~5s to reach userspace at 115200 baud and ~15s with
initcall_debug turned on.

Thanks for your work on this Petr and John for your support!

Kind regards,

Michael Cobb
