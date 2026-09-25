Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8334C2251
	for <linux-serial@vger.kernel.org>; Fri, 25 Sep 2026 15:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790350897; cv=none; b=P7Xq24KJJaCcwKhVWqxtsLYAAIb31W14EnG/uf5bdORwDKtjovrYQ7lG85/omdsF0GqyebjhA7SIkUZmJgSKd8UpSZbvhGXHjyGs0T5RPzOGtI6X6ZGEac1g0RgBkWtpCp3vdZPRlWDboBjRwIGp6CZyim9dtlC/KLAF45X0mug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790350897; c=relaxed/simple;
	bh=3R6CO7ae6XgFsFygK7xExQ3Bpgoz6R34BruMnh6urg8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pa5wTo6E05KzmNaWZoBiiaZ4gyPzWGq8AGCVoAFuvK+vO+OEQTeiaxO3H9XtGKWY2DDJZlLu87khXlCoKil7H4sDiYgOQZgjeHZAEHbPlDhKe2Or8bA3C3GSGpwG42aNo17RriElBLhNCYuMFWRYlsyN6LD1nr1yLdgW1ToqSxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Jm4JXdeX; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Jm4JXdeX"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-485933b24c3so667399f8f.0
        for <linux-serial@vger.kernel.org>; Fri, 25 Sep 2026 08:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1790350889; x=1790955689; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=N+5FVubCF+Zu5SZLI3VcWmoWT2YqUlyln8LNS2KK86o=;
        b=Jm4JXdeXXacQBmCIref6ErV+1cb0X8oc12UIr5d6SWYaFHyHLBw/JwVhexrU9pXKi7
         Wwy+lC5VN4l5MNM0RSXKvetGSrSm/Me+IZRKBkxG27VywRWyhoQSv9jEmYFF6puIVMiy
         6/IQdG/fvjOK2GhPNzYIyI8dUcJIo+6E7tXmbgdaHjeMpAlYdF9mSI5QVT5GW2k3zJDC
         7TriBu4pFwCjpAWyEsyniVgjk83/05ErIG8RYk1rpu8fZs/6SwQ0gR+PCMZlBlb8Axlx
         rJ36pnxXT+IRj3pFOsNMsgSXC/XmkrzYhZ7dKRQdvZ3tohH2D7HS235q2rAIJmk9HKug
         X6xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790350889; x=1790955689;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=N+5FVubCF+Zu5SZLI3VcWmoWT2YqUlyln8LNS2KK86o=;
        b=vUsE+S2niqQpoxOAFEVjh5slAp7IWcEnFv7PIG2FQNGX+TqHUNfh0eu9ZpAdYx8yM2
         +vv98aIo27mslAhUU8NX0ozubISn7AXVIsqCOO9kXMpu7pgMOYqg2OvvFozhbGMzWvMV
         bp8k5AcgjWmzEBv+hgox+/aEKcxXli8VyIabS7iuRCHXcPWWgQt79WSN0NxzEWpxA8Qs
         5klVZerbsVeaNxQD9atD0MKKgIsv3Is3aew0dPa7fsEGWFTd2Dqeg1xshgQFJCHx9S4V
         VnvXC+vQ4aQPEZ2ZUiu74/bxyFd8fEQxa1ls51a7PZmOC2AT/CrKZ+QsPQ7mTkvjxGGk
         XHdA==
X-Forwarded-Encrypted: i=1; AKwUvByUbkFYjaHnz+fGpaaqoYtr5dWcrLxaGop2tgA8bpzgefJAD/Y5rnyVsdn0udvTDKpOy+Llqvo/Ag0walg=@vger.kernel.org
X-Gm-Message-State: AFuF++n6NNZkQ7OJNB++rRFeOhYIGQhnmvs6idKYa9Qs6X6a74NkyEVf
	D46AtCnq5VuVEbE2+c6sCI1BbDyGYVNqgZM0Wy6NwGGOYx4ywOvo2CwdFJXo6ZbRaGA=
X-Gm-Gg: AYBFou360UanLNc6UMp6efnrVDA+k5wn4A3gXXqHGSjiPPBUDtKls0mIcZ3P/iApxLf
	3u7YKyEMgus3f49+ng5SXH1B+0/E6Ce4CHy53hNlfF97DgxBXDAVqyMS1xiMqbdQ33k9uIE/QSK
	nlK5HxWwf9M9eK7xD8LCIgbJE3m/7LdxtH1keVSWk4qebcBSayzNgtZHjA/om39gtpXEYhI4BVe
	6JsxZYsQQ+hJ3vzz9lZGU78wXtXgMiUqT39CbYD0+QgvcvPW+P/oIyt954eG1d1wnpdylIWNVi/
	OQ7PN8Lp1+pTiHoXlQHfdWdPC8zBURHdQ1zu2oNkfRcSDl21T5sbXgrwAMQiKVLCIpW76mnTThF
	t0VOG7ICi1/NoUrbO0zPwjCOXceLCLGUDT4ywou/m0SbqDnqrjRtztx4z9o5i7AhPFzWetozCpk
	KUIB1lkMParFe945axNEbxjr6teG/l3/iBLQMmHDScjC+0ptXLSc4QBEoEqsHVqkDNqQhdo4Ox
X-Received: by 2002:a05:6000:1888:b0:487:2777:6354 with SMTP id ffacd0b85a97d-488717166dfmr14312566f8f.48.1790350888733;
        Fri, 25 Sep 2026 08:41:28 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a2acb4dsm8108936f8f.0.2026.09.25.08.41.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 08:41:28 -0700 (PDT)
Date: Fri, 25 Sep 2026 17:41:26 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Marcos Paulo de Souza <mpdesouza@suse.com>,
	Samuel Thibault <samuel.thibault@ens-lyon.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Fushuai Wang <wangfushuai@baidu.com>, Kees Cook <kees@kernel.org>,
	Stepan Ionichev <sozdayvek@gmail.com>, linux-serial@vger.kernel.org,
	Manuel Lauss <manuel.lauss@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] braille: nbcon: Allow using a serial driver
 converted to nbcon API as a Braille console
Message-ID: <araWJhKdVZnfCQcg@pathway.suse.cz>
References: <20260922072558.98854-1-pmladek@suse.com>
 <87ik3tiim7.fsf@jogness.linutronix.de>
 <araAvkIB5XatHPNk@pathway.suse.cz>
 <87a4p5iejg.fsf@jogness.linutronix.de>
 <araJ-EBntyqOGPkT@pathway.suse.cz>
 <877bk9id6f.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877bk9id6f.fsf@jogness.linutronix.de>

On Fri 2026-09-25 17:11:44, John Ogness wrote:
> On 2026-09-25, Petr Mladek <pmladek@suse.com> wrote:
> >> > This shows that braille_write() is called form printk() even when
> >> > braille_co is not in console_list. It is called via vt_console_print()
> >> > because the graphical console driver (ttyX) is registered.
> >> 
> >> But isn't that a bug? I thought Braille consoles were not supposed to be
> >> handled by printk(). Even in this new series you added that exact
> >> comment.
> >
> > I believe that it is not a bug. I understand it the way that the
> > Braille device should show everything that is shown on the virtual
> > terminal. It should show the printk() messages when they are
> > printed there by the related console driver.
> >
> > It is just that printk() is only one source of messages shown
> > on the terminal. The vt code maintains what is displayed.
> 
> But how do you register "the terminal" so that printk messages appear
> there?

I used on the command line:

	console=brl,ttyS0,115200 console=tty0

The serial console driver is not in console_list. But it shows
all printk() messages because tty0 is in console_list and
the messages are shown there.

Best Regards,
Petr
