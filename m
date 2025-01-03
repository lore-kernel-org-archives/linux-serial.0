Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C924C19D06E
	for <linux-serial@vger.kernel.org>; Fri,  3 Jan 2025 11:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735903139; cv=none; b=MOtE/Fq1EKqJ9n4vSNks/nx6OCxg8/ujCxgVHhAWsuK/FfAIXDGSN97XmO3v/nXndx/acbyT5/eM74XJ4HiyaXKV/Rob1r9xA5ChO9zLvOKU9enRm1SFWVjuIwUzoSIAwPVOJrMMfI5NSufa1cwJJmlzCmRI/aYyRNtll/k1vS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735903139; c=relaxed/simple;
	bh=iv1ecZ0oga8ifZpHznoElzsE/Av3WnNwxt7tjkScA7I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EofssRP3+DOoRT5r6hoZRWmfb8shCsmxEAg1xq1zv+11gKdRnXx3o+go5GtqRbZoemCRIsbeoIz1r/Fe8w3+9yxZpHFG1+gUzWgQO/UjEziQ4jAwb9lP2nbW0PTXUVNhZI/T92ui1Xq0iqWFSmJzrqqBX5BkjI/30fk91nGjCko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Il/KEJ19; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Il/KEJ19"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-436345cc17bso88352265e9.0
        for <linux-serial@vger.kernel.org>; Fri, 03 Jan 2025 03:18:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1735903136; x=1736507936; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OQppFz7LylosxCTW/9ZVy9Kacnt0MCt8fPDuV2Ypyb8=;
        b=Il/KEJ193Mub9mhr3l/8xWo6lR4z/1GUy/Lvgsgs6p0+2A3gT5hL+8C6whPo9nEsCJ
         BQE9frCJE9vpoq9v30eRJmGg0k9k1fBFdQ+xsxyVaEBxdW0nRPoyCIds3OiVwnlmnnAG
         al+7SondTYKHiP4Bd+KFwYGnlnIImtto5Z6h+xHmSge8w7EMgYQhi6a23cxKyG3ytjxW
         aFRoJwXm0kuw6TpPNWYNHza1fcKzW1SboRUgBx+aMrkn8+xUfZMxi8dlXMEfnAek5b7j
         Anjiss4vliPamYrnhAbcU9yuXMUJXB2Pgs1GsRYe1cVmltdXK1doiqonZs3K33SC9i0i
         mffA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735903136; x=1736507936;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OQppFz7LylosxCTW/9ZVy9Kacnt0MCt8fPDuV2Ypyb8=;
        b=Y2D6JXtyQ+jBZn5QWfdumDLfnGS54UCuVuqtgqyyzmtXIJai2qUfI91JYtGSrRwz4N
         9LDJ3I/uInDsSvQ5E4toJdnsl4tXGPMybgIPLnyfZ1wMRC9e3uE6eXMzCyXo+MAPcYPo
         Lr0FtfgYQaHiIg5H9YLvKZdXSR9mqkNWD2IToImGA+/N8ZnD5P/xmOfR1TZusS/QLD4d
         hsIKepDEUkSk0Z+xEVNTDiiMMDINthV547Ok2v7g1ILdRvrsRuoOMSWqonEG8zltjD2X
         ibqnuSj9baCgo0/Y91DJFZDZ29tkcxh6JMANs4PZkl25WYT1R6eG1x8BJpw/U7zTczhx
         7BUw==
X-Forwarded-Encrypted: i=1; AJvYcCUy1oFMX/i4HYBtBOI2559qCrSU74c/OIMR2ad9/6c8C6KO5h9RFrOFi/aehfpTsUmJpbU/HIpHoVueZe0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrbUYCXZuzXFSdna8u/xF/2pOboNkZJGc+KYgIH7W1oocl8jjD
	3nhpHub677VjyaVKCxolF8EiwNsHj6oEvcC6jcHbFJeXOmZ07zD+jYcNGHlEvGo=
X-Gm-Gg: ASbGncuAkxEGmLUFQjS842HbfYi6ATkH/Gs68aMUL47Mb9XnZQI+S0os1T4BHLniXak
	PGCGXS6jGZQhWE+NuQqiSeU44hfsm/3eEVpbWs2JCp7evX836N0Zpcw3kBqGHSzBn6ZQUnZa1DD
	UPd5q6B3pVsept940pxb5Dugg2lSYwYS3iIc3HYvvQLz6o/7c0f++gfYHK103fqKgZglFLRusIb
	esGB6XOjQkgVzBxO8ERvbInJJmzxtGDXGgpWSqrSXFT89hNzVi8zZjHmg==
X-Google-Smtp-Source: AGHT+IHIzKRySngKIdsX5MXXxtZ66zKTRho8isEjBhPejn+RjlVrqd8HJLW0nNhdNjbTY53Oz02ZIg==
X-Received: by 2002:a05:600c:35d2:b0:434:a929:42bb with SMTP id 5b1f17b1804b1-436686464cemr444893925e9.18.1735903135958;
        Fri, 03 Jan 2025 03:18:55 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4366128a44fsm478127005e9.43.2025.01.03.03.18.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2025 03:18:55 -0800 (PST)
Date: Fri, 3 Jan 2025 12:18:52 +0100
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
	Arnd Bergmann <arnd@arndb.de>,
	Rengarajan S <rengarajan.s@microchip.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Serge Semin <fancer.lancer@gmail.com>
Subject: Re: [PATCH tty-next v4 2/6] serial: 8250: Use frame rate to
 determine timeout
Message-ID: <Z3fHnAZFpnRk3OhR@pathway.suse.cz>
References: <20241227224523.28131-1-john.ogness@linutronix.de>
 <20241227224523.28131-3-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241227224523.28131-3-john.ogness@linutronix.de>

On Fri 2024-12-27 23:51:18, John Ogness wrote:
> Rather than using a hard-coded per-character Tx-timeout of 10ms,
> use the frame rate to determine a timeout value. The value is
> doubled to ensure that a timeout is only hit during unexpected
> circumstances.
> 
> Since the frame rate may not be available during early printing,
> the previous 10ms value is kept as a fallback.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

It makes sense and looks good to me with and even without
the changes proposed by Andy:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
