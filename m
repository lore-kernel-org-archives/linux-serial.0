Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505521D89FD
	for <linux-serial@vger.kernel.org>; Thu, 12 Jun 2025 11:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749728788; cv=none; b=HIygPkN8mKdoVrPk/6VbkPjToTg+g9qAIrA3zWJ11JlF2YBoZANQHMK/SNjzw0Qk0D/DY9NpCHOOszm5YBZO5UYGLOs0S5mcazUB5vEWehrTL3TfyYZNO+gE/2Jy4+OODd9JRrCmiDAnBjXC7vQHiV1bc867kQXVKn08/zSwN8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749728788; c=relaxed/simple;
	bh=lLCZoZNMy3Q3zpv+mA+EoiOjvX3DENCn4LWJlLw9slI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YGq24Oe/H0cFmj2dPbjXKZfnUioDZrbQ98m0j5TGemXdy9EPfHGvAov7l1O911108dN20XJ2b8tnY4bBarOAUqA0LkiGKdEpBgd+j/9dDp9prrQGFQ2in4u07CHuL1AYRtwjLkWkK0LuoBzFPru8Xszy4xJpVD6nHkgkMcMDQAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=azkPblft; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="azkPblft"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3a4f72cba73so1430548f8f.1
        for <linux-serial@vger.kernel.org>; Thu, 12 Jun 2025 04:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1749728785; x=1750333585; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VpdeBAczxDpMxHPi8ej3bXu0PaquJ+drDxjVDx3klZk=;
        b=azkPblfthaMsAYiVC3TGIUkA7B+KCXYBneQcDIdKHw3r66IxHcQ2bZ0sqlvGY+OQFz
         lnnOfB4N/lHO0GMa8hYSRfrTG4bst5icBtlCg4JWmEpaKU8arX2rc2LHhvCHg/Mg2KAa
         /NGn0kEdwTZgfVm7BbkpYSrvJp292WHscB63qK186206wjWvJbKRhN86eedM+Da3pgkx
         dW/bWHyzLTYfabAhpOeun5drulKTtPv2hi8vttJGXlIqbQgmEnSV/3CVuP55qNgfOqvO
         xZL4am0vXPEy05KRCzdQahYJCIR7f+ZvxMEPtF1UJUUhWt4UMByZ9S54Zl186UKZXqL1
         SisA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749728785; x=1750333585;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VpdeBAczxDpMxHPi8ej3bXu0PaquJ+drDxjVDx3klZk=;
        b=EZoaTHC7dskq+sMvldCXm9Luh3ZD/MOwjHxNKWhSM7x3+iWzsy0WtVUWNMB/jRBoUv
         nxe+3kcc2a6eP9Z0n6seZ6t+1tjkK6cF3YT84/EAQgdLpxM2H1EeCxvUBYPFBr/K0M3/
         QET68n9eVOjROCkh4+Sj+4prX0yRfWyepLaoCmWTfwe8LEPjLbVDLewmNnyjA3qMzf4y
         iD7FX/TTrdnHv2h77aa8ITYgc2DWV18jeZ4RZGKW9In28eRNN4/2GkajgAjxiZCDKqVa
         qZzjfrz6N7UCqdcVu/nw6pptVzPbbcuKyI6jLp58RWQlHw0RrnnIrOXeeSJpYHSN69Wx
         a2UQ==
X-Forwarded-Encrypted: i=1; AJvYcCUpnANS7GLz2pDC2u5YId6t3inO8PClCLdKoJI6SWf8T0IZmHMjhfnFL5q/gPzlGqhPcKcnXHX3Cakf0x8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbvjjSqtKzzDDs6Yv85MsddBkkmO3GAwqtxEVKy+h4nPrdLGyp
	wy9mB9EwbtmzgH7feUOBpyG4s4xhogtLE16Ca4XHEGXT9hhO7IyR6wYmxmUzoxSQFUc=
X-Gm-Gg: ASbGncs7Zub6981awRopxiwXABjoOH/TnwUPf40DUCN5RPHP1vfdgq5xbAqUGUdzDxd
	dlO7kbXv7AIFxuJy62bB9Deu7IpU4rFxyM7L63cZ2ZjFoszz7EJaq2/dk2OCko91FctD07hiC9F
	wJP5gfCs2r7wp3tsqUxG6d+JFEoKc/yoXLxfPxhhg0RtWfE5nDiYxYzm2Qw8bikjOfPQGHyy/mu
	v/LizjBU7FISjy6DDTTKpuNKF507ftVjVeVXeHXP42iFA6t6Xi+mXqHWCICZcVsdwE4pN9mvli4
	TPyG2iX7xepqD2QgsuQ3UuZdGENIJlnTxCsTmyrT9UhbcrLE4ZcdztiFqq/w35Cm
X-Google-Smtp-Source: AGHT+IF/248Rvx3CVC08UaAQ4P3dTeJa+QHLA+I/CORpcgGm1jvrTGpa+IJI7ILEeBXIza4gfGGQkg==
X-Received: by 2002:a05:6000:288e:b0:3a5:271e:c684 with SMTP id ffacd0b85a97d-3a560814897mr2780693f8f.24.1749728784595;
        Thu, 12 Jun 2025 04:46:24 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-313c19dcd05sm1406413a91.14.2025.06.12.04.46.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 04:46:23 -0700 (PDT)
Date: Thu, 12 Jun 2025 13:46:06 +0200
From: Petr Mladek <pmladek@suse.com>
To: Marcos Paulo de Souza <mpdesouza@suse.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Jason Wessel <jason.wessel@windriver.com>,
	Daniel Thompson <danielt@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	kgdb-bugreport@lists.sourceforge.net, linux-um@lists.infradead.org
Subject: Re: [PATCH 1/7] printk: Make console_{suspend,resume} handle
 CON_SUSPENDED
Message-ID: <aEq9_kOoLSQwuYBq@pathway.suse.cz>
References: <20250606-printk-cleanup-part2-v1-0-f427c743dda0@suse.com>
 <20250606-printk-cleanup-part2-v1-1-f427c743dda0@suse.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250606-printk-cleanup-part2-v1-1-f427c743dda0@suse.com>

On Fri 2025-06-06 23:53:43, Marcos Paulo de Souza wrote:
> Since commit 9e70a5e109a4 ("printk: Add per-console suspended state") the
> CON_SUSPENDED flag was introced, and this flag was being checked on
> console_is_usable function, which returns false if the console is suspended.
> 
> No functional changes.

I double checked potential functional changes. In particular, I
checked where the CON_ENABLED and CON_SUSPENDED flags were used.

Both flags seems to have the same effect in most situations,
for example, in console_is_usable() or console_unblank().

But there seems to be two exceptions: kdb_msg_write() and
show_cons_active(). These two functions check only
the CON_ENABLED flag. And they think that the console is
usable when the flag is set.

The change in this patch would change the behavior of the two
functions during suspend. It is later fixed by the 3rd and 4th
patch. But it might cause regressions during bisections.

It is probably not a big deal because the system is not much
usable during the suspend anyway. But still, I would feel more
comfortable if we prevented the "temporary" regression.

I see two possibilities:

   1. Merge the 3rd and 4th patch into this one. It would change
      the semantic in a single patch.

   2. First update kdb_msg_write() and show_cons_active()
      to check both CON_ENABLE and CON_SUSPENDED flags.

The 1st solution probably makes more sense because we are going
to remove the CON_ENABLE flag in the end. And even the merged
patch is small enough.

Best Regards,
Petr
