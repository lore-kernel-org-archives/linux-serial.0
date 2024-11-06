Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E69193094
	for <linux-serial@vger.kernel.org>; Wed,  6 Nov 2024 10:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730890487; cv=none; b=CLtnuloIdx8Q/EWXSRvmuDld/qhhdIaO1ikIKsx1COtkCwfhRR6+xtVqRNgncES/VKbFP1dWgUwUu8a115iJO84RP54HXL6rrsm66CVwsyhtIs0Y/hnO72n7yUzmTt1bGlU460574zr7s2bI6REJUJNyeFUjua49o4ogG6d6BZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730890487; c=relaxed/simple;
	bh=N/mfT96fJ+//zql7k0BXSP3lhvY+yTvkuqwFMCe1mzc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TU3OOd4aUi4+rHgXYFYBGEGxHcuByI+vKVXZhABeHtvTNGdji4EeAgH1f6t17ndJX6gg1EqaFWfGVVeyWlHngETGOs6FmOTPDwHAd4Zxg0Jt9k/lhNIiY23afsSt5yDDocyKRXDbG+zNcMaCsUtnuBi/m38tRmNwz98lc+TkPxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=TlJLvxXw; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TlJLvxXw"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-431ac30d379so53257355e9.1
        for <linux-serial@vger.kernel.org>; Wed, 06 Nov 2024 02:54:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1730890484; x=1731495284; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vDyuLzj58C6IoALVweU82QLSkgc6OnhufpYdJ1qavYI=;
        b=TlJLvxXwhH2oQOGaxNS/XQCsJEYAKAVqAfwu22i3iXH0n+TYXC2jCubq5mKkXLulC0
         W+NkSNpRXzNhBtUTjznYpd9v3zb0HwO1E83b/4Vs03agdpTihEOz8/3H8r3m5hli3mo0
         Fzmru1lN/fI0pywJ/Bue/NrxIK6cFSos/iW7CDDx/UGjM15YvmPK+6TIpc1ebcC5jGVO
         us9R793YENijr/fCk3RKn5VwbIDCpnHT6WT433HGyQiKYmV3/jScrBGKQVQqNgcK8RX7
         jVP4GeguXekeRuaCcv7I3JzCq30tWLY3vQ+k8Ca6oVdgThoA5OatWReEovZ9/jQr/jDb
         qqmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730890484; x=1731495284;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vDyuLzj58C6IoALVweU82QLSkgc6OnhufpYdJ1qavYI=;
        b=FM1NX3s9lUy4N684/JT5H5UNfEW0eG02u37rc4IYdfC3/9o1OMv6KmtxL4XfPnI5Oc
         CgLd6ymDJz95RXSlO49wdhEHSCtc+4QCiKUpdpUKL+SWNfeFHUI2xYrgAyOWcQq8w0DY
         cHdKvZfGlE9PojigfWpZN6xVfaSxqUeUPGcduPTX5FWMh098oskVYICInLwshAYQBLqg
         TL0Ni+7nC/fNi/fBoOLZCP4FPipelHJHvl/D4BMkzd7FurtSlt/tBT3OzdaIyAiFbLtS
         BKu1d8xiFDQsaTJc4d894j80GnPR1yVdv2WRnYUil9VjjVVCxisktPDOnS2xwClV4eZj
         Pf1g==
X-Forwarded-Encrypted: i=1; AJvYcCVaL/gUFc9dGfwxyeUkLwbARYNR6WUsoCCSP1AVT2d2CUttZJrNvlmIQjV9YhKSsZTa4rivlbzg/VFlddc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzji9TleCuhznZb+g9uHKNNTInHKvsmbakmB5tXkYZSJrpXx85t
	4JCz9vkGnuBkB1LowJxJ28eXRFFvl9WEZZnnUkx/23G3cgf896c+4p8YMOfvoQ8=
X-Google-Smtp-Source: AGHT+IFRGeHu6E+URPpjvGEsTdqLtd8SLISeViKJag+OPHvFn7/cF9Befbus7KR8aShFD/K/Gip29A==
X-Received: by 2002:a05:600c:4f15:b0:430:5654:45d0 with SMTP id 5b1f17b1804b1-4319acb104dmr361528865e9.14.1730890483618;
        Wed, 06 Nov 2024 02:54:43 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432aa5b5e8dsm18521635e9.6.2024.11.06.02.54.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 02:54:43 -0800 (PST)
Date: Wed, 6 Nov 2024 11:54:40 +0100
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Esben Haabendal <esben@geanix.com>, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rengarajan S <rengarajan.s@microchip.com>,
	Peter Collingbourne <pcc@google.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Lino Sanfilippo <l.sanfilippo@kunbus.com>
Subject: Re: [PATCH tty-next v3 3/6] serial: 8250: Split out rx stop/start
 code into helpers
Message-ID: <ZytK8JzooLsn6SdG@pathway.suse.cz>
References: <20241025105728.602310-1-john.ogness@linutronix.de>
 <20241025105728.602310-4-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025105728.602310-4-john.ogness@linutronix.de>

On Fri 2024-10-25 13:03:25, John Ogness wrote:
> The rx stop/start callbacks also disable/enable interrupts. This
> is not acceptable for the console write callback since it must
> manage all interrupt disabling/enabling.
> 
> Move the interrupt disabling/enabling/masking into helper
> functions so that the console write callback can make use of
> the appropriate parts in a follow-up commit.
> 
> This is essentially refactoring and should cause no functional
> change.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

The changes look reasonable and do what described:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
