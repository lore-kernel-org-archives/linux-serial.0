Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6570D20DD5
	for <linux-serial@vger.kernel.org>; Mon,  5 Feb 2024 13:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707140899; cv=none; b=PHeaMoff7Rc8AgY/OJW5JkOZ7BuwauOpzvzlm9qeG7S3LNYXPLgTLkjkNZ/xQVojAEv5EhEyrEmDbztaaB+HK5vd3+83vtCG5G8gEZIh8VVxp4+XUinMwHnc4gxygxd3yAdNJ2jCHh8idC+/BlKuttpIlMWLDY6gcauI7J1JjW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707140899; c=relaxed/simple;
	bh=3NuNMJq9/U+OvHQ7oCbIc0HQwEjcijjQLPqIhCaiKXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s33ClPDAPgOewfQ5kMzHESlFGZH1BeUMBaznnULZzYwUe7JNRiZadFl/rCmz0hz3pjbReAISCERlvAU1ViLxAoyy/6jzKWUoWXQ6LS7AUdJELajQPyneB+zWWFxmuJvEWU4I2tPnnm9QZY2SD5xXSvA1GXLoziukFRDSPm2PC0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=JJ+YYIpG; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="JJ+YYIpG"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a271a28aeb4so627430266b.2
        for <linux-serial@vger.kernel.org>; Mon, 05 Feb 2024 05:48:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1707140895; x=1707745695; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BnLD/npCdr1tyW2eRfEXfxLqJrin7ZxFfEREBoHz6j0=;
        b=JJ+YYIpGzpFMv0Eo5pqmHMJdR2gp5BtvjLY002tC2FoJRL3cQd8iuHxc/+0Mv3Y6F5
         1+N5gK2OI77eWcLoSwlD6DoyEbi8pprnD23r9uFjDkG8KiYWxnABWG2yOAwfn9xMrp71
         z1orEVt+j7Olbe+DuVs9n9ztdZFzPU9XC8iUOlKnv9IcasU3mRPQ4pApJ3lP+fia2s1J
         eOT7g1MotLyaO1urdwm6CI8biuObOO1/zrRgljvtx9Q07YvEgEcNn3MlRLY2Lgrae4a2
         59BcY0XRlX+86KmrgQGVcFbpiyRlmKS19xiGNPm8AKobPasiiqdgjkJX6LtQSqAxgftH
         nW0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707140895; x=1707745695;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BnLD/npCdr1tyW2eRfEXfxLqJrin7ZxFfEREBoHz6j0=;
        b=QnmO2+IFi1ZRZcBiwTlgM6sClEE8QuOfOOInKy6oZlAgJkjQJpfVmfdr6rL9tWqQEX
         pZOk9gPXmXXbnsLlyDLULVL2mhgdaoVF5vgLlhZGGuEAFz1oGyNDgx0YxMMMDT5aRwF/
         C6lAU1a9GAiDNCzTU0wedA1v+aDcBZp3NXojjQzkNmDgtB6ZcPNn6fcYh0TnFBdEtTJ3
         4KrlRflHOeJ9S26/qTcRCGfeTE3uTdvDOoe6HPzpoCIcEInzonUGBK85+AHRizZDZptL
         6j+/jUAm0gkBXlU0DEIHBpq9UpgwGjyuIZ0CQ2pdDgya4aOmCELYsCFZHN1z3JyHX/6J
         uPLg==
X-Gm-Message-State: AOJu0YwsihgX//hVjvCq8vHt7Z9CAapbnnAWun6BvaM4PQWa3qM58X+p
	Sb1jDOfARGgKRrHjwnO7neeo4AWhiQCTZFAblu9+aeWFLGXdDc6LF5DKjFCRzKA=
X-Google-Smtp-Source: AGHT+IFWABZ0qeyCjyQoWq6QAO5OSdVAT3GW2jIOB2V+qxSo9kQyktadwG+z6OKvTR78VHoGHV4oXw==
X-Received: by 2002:a17:907:762d:b0:a36:c478:32c9 with SMTP id jy13-20020a170907762d00b00a36c47832c9mr7518684ejc.1.1707140895540;
        Mon, 05 Feb 2024 05:48:15 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXsy4v1BD7fDRmPpnzHDIgnYgYLdFmJBM1XZW7ctqzqxH+21gTjTmePHQ08oJFMkcqSGld1EEGpcVxwpepj79S4qRFPmte4PEDpyADVRD9+DtETXZAcFjX7wJEoHwiwaUwaf29NZpFRkGVdqAAuoJX7qAKgfhOqvnsS9lkbFvgF5MKqBd0u4V+8Ai/9nKTVRQR1hqEbxL5ztg+BuiGIAeqXQLdAJlOgOSsy+cMmPv3S5RLi0aISBDP47u9DV+wA3WxZ8uHYMNlwCwebHcX5/TRfbFtwGmW+wuYDVizVcO1elXCdvkdmEoexBVejXniW06qHH6TrKWZSzbu/C6rnzaJExRpFcWv0uDm5ROcEG94SQ3nKpbwh8KNDD/KlJT4fYOzdRllhqqfCrbOWYi/qhEMcsNSaR+6wCY23p893EIf0KjqbxoB6U6MEGgqR5gCRRZSmWPvo14o7nTXK7g857KKwcQKA+zc+cm7IBZf7mwbHEMS4wENLmvwAe3/RBX9owySiaZpqNwUL0fr3vYYGl27tsNHmhaOMPaLGxMoYMWR1u49R56FtxrSjJqQjD2Q/6MUA6FaajkIYRloUdsAizORTbsFNFjkinNoAZjX8eVMBVQ6Zxxzw9oCpe1dpL1SY5T9x/nHWwNzpQLioMcqP84V5vmRwrYQXUc7YeLVefIqmY7bugrm9tnoGJefVT1D+xXegjEgL0xZv0GkGR1Ahjvo5gEjknNBs91YZ0UGczR7XEzIx1gUhpl8Y40hANCXzWudTdUZj
Received: from alley ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id f1-20020a170906560100b00a37b795348fsm1253036ejq.127.2024.02.05.05.48.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 05:48:15 -0800 (PST)
Date: Mon, 5 Feb 2024 14:48:13 +0100
From: Petr Mladek <pmladek@suse.com>
To: Yoann Congal <yoann.congal@smile.fr>
Cc: linux-fsdevel@vger.kernel.org, linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	x86@kernel.org,
	=?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
	Borislav Petkov <bp@alien8.de>, Darren Hart <dvhart@infradead.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
	Jiri Slaby <jirislaby@kernel.org>,
	John Ogness <john.ogness@linutronix.de>,
	Josh Triplett <josh@joshtriplett.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Subject: Re: [PATCH v3 0/2] printk: CONFIG_BASE_SMALL fix for
 LOG_CPU_MAX_BUF_SHIFT and removal
Message-ID: <ZcDnHfrgq9I4iKLk@alley>
References: <20240204232945.1576403-1-yoann.congal@smile.fr>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240204232945.1576403-1-yoann.congal@smile.fr>

On Mon 2024-02-05 00:29:43, Yoann Congal wrote:
> This series focuses on CONFIG_BASE_SMALL.
> The first patch fixes LOG_CPU_MAX_BUF_SHIFT when CONFIG_BASE_SMALL is
> used.
> The second patch globally replace CONFIG_BASE_SMALL usages by the
> equivalent !CONFIG_BASE_FULL.

Nit: I would personally do it the other way around and get rid of
     CONFIG_BASE_SMALL.

     CONFIG_BASE_FULL is the default and is used by most users. It is
     the CONFIG_BASE_SMALL which needs special treating.

     That said, I do not want to block this patchset because
     of my preferences.

Best Regards,
Petr
