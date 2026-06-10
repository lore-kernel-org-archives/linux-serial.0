Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0981E330330
	for <linux-serial@vger.kernel.org>; Wed, 10 Jun 2026 17:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781111043; cv=none; b=ZT00m5iPYjjgRrLygxlNpeQ5OmfJvV0lxILhw7On+nNiS8jaf7cr8BAwXbyJD+mFZo5YaDdBmgmh7d11wLfVCc1RMz4EpwcYLaSF/8XXQkMqYPzZe9OZFbPN6WYwJKLb0wlQZc3oczdLDQq1P7CTnZfZQYgYpBJzc1f43mj/s+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781111043; c=relaxed/simple;
	bh=TVW9575YcKLG0bHn7A6LJowba0uRlJHWjHvsONl4INQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KsbNTKZg0lJrqv7TPyqYBinzDln3tnxQaCA3v1fYaxzi2YeWm8Z+PSYPfGMZ4bAgXuBYiuTukyooQaNWnsi8ce4UNeOnGe9xiv+Phy2BCw3b0xJLBLhp/lZn0L+hhrMF+/SsgvVCJDrByeaEWrs3102q0LfV3Rw8h8vwvE5PDWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZzsHds8k; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZzsHds8k"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-307263ad0cbso9778629eec.0
        for <linux-serial@vger.kernel.org>; Wed, 10 Jun 2026 10:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781111041; x=1781715841; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=J93QDWWtLOTX1wvAB+lhHDAb2H6FMZC29/IawhQbAQA=;
        b=ZzsHds8kr9lM7kT8mMeCi1V86B8GCn+NH0KGiztCdGWEdWMhof1tAv5jSODGHbSnLu
         xcfSHGUBXuXPBo8twjdS0MSToCqbbesVYPqr19pu1yNznMULfnhvtjvSgLm30brIzqpQ
         EDETPOBRRkqZzClK6lSh7b2BUbYVdlo8y/ff/WVWdOGgoqLbEX13emNEQjdq8BJ+7i+k
         Dny8ff/CLiohJ20Whz15cxzX3G2uIiUdbR/0hlQkH8RCm2oxZKqd6y9X9HMkJw5PWTd0
         QGTy1Y8JL9Ig7eoVqsXkJSe6yOYNs91rDgKClnx0gcN+bnOpIi6RpOJNPUmoV+cucel8
         xgjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781111041; x=1781715841;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J93QDWWtLOTX1wvAB+lhHDAb2H6FMZC29/IawhQbAQA=;
        b=CGYJwbcmA3NilwY8e4QhPQ61G6uR9RSFRIJEqQuK6VzyIcgCsC9t0C7NA7tqohkDTk
         OF7m4ZXzrZ/a0qLbKTSXTZW4QyijY72LqdL4maFcS5xOkrUatP5h3GJdsvcb2pRgE1Go
         wTauZqVTng6OYPyYAW89zEP+4LETpjb1Ntf6lCVC1rQ+/bUTHSlUa3g1b7TMWEwJCen4
         oI6td6po2DsTctRxQafDIKozKpLZKxLhCUs3+yQgLD+LLkywZSS9yverVEGEMNwSesE1
         cFRtKoVfUG/zO3zfslgAu237xzPZ09cScrpkGRi3EicQ9IZWx8dBAxaNEDMSCDB1T7yb
         6Xiw==
X-Forwarded-Encrypted: i=1; AFNElJ8yWUxHC3XquDvrEQMMcDaWo/EvIJqwifedEsfnkqgPobhx1UDSSF+SbeXi6v0MJexVmQwpfTN1PvRnHLU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzd0l/9HMMFgaZP4PuM1nVFqYlKrUSjDhtU1zyALsJMvEQQgfHn
	XDIvcCwtTRqJxEeTYQNpppVJ3TsAx6QR3jtb/po8sFoBWdmYaD+TQGCp
X-Gm-Gg: Acq92OEPjqQ6C2y9zfOGdBnTT1SBQAn9Ss/F+7z21WPXPDfbizlJsApTpf3R5300bu4
	VXx1w/wtmr8UNYl83O+jslqTTGv0atbuC93bOgc/xXMygAAfEvx/cPYYKb+ZoWZ3k4fz8M3uQy9
	VPRpiP8NnbF/ea3edL2lNiTG9p4vYa9CoPJ73nTPMmsYs5wAdA98K1tLkmqRzTJmP+/ENHXr0/n
	CgE6qjS6AhcOlocaaDdyIgiVjI88uN+UYIu91IhJFv67pbN1ZG9bldlVk24+dAnVuOJb0+HPfWG
	sIycdv+5vxjBwp6i4WKjKPFZEi77foI5F2xm9j3w3lyRejkuDENvmxw7A26hYvcsLitnd0fc9jX
	AllaPEBzA16IzEAjGnRGztZ0GyzGe2PMlV6qoGRKmpCYktZG0QJJNzH2MbgqTdDpgtIHGMNdIdv
	CuGEhhqhSf/zQL3iLTkmGJp0Yi5XSb0+YC0UPgeKJB9MVe92HnNrflfwrQE/9ET67KhZd0PYBIv
	Js=
X-Received: by 2002:a05:7300:7313:b0:2be:7fc2:fc38 with SMTP id 5a478bee46e88-3077ae89f68mr16554448eec.5.1781111040802;
        Wed, 10 Jun 2026 10:04:00 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:ae0e:e075:91c8:6570])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30791f9da69sm18610159eec.31.2026.06.10.10.03.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 10:04:00 -0700 (PDT)
Date: Wed, 10 Jun 2026 10:03:56 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, 
	linux-input@vger.kernel.org, linux-serial@vger.kernel.org, 
	Russell King <linux@armlinux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Russell King <rmk+kernel@armlinux.org.uk>, 
	Linus Walleij <linusw@kernel.org>, Kees Cook <kees@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Steven Rostedt <rostedt@goodmis.org>, 
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] ARM: footbridge: convert to sparse IRQs
Message-ID: <aimYkTdIAoye5sEG@google.com>
References: <20260510052107.555825-1-enelsonmoore@gmail.com>
 <aibz3auoiq4CFa9l@google.com>
 <86765df4-0d2d-435e-85d8-b9bd4f3ea85d@app.fastmail.com>
 <CADkSEUhh1NdOMTHVsErhqzyCpDGFA-FkNFaWp94e9LnB3njxqw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADkSEUhh1NdOMTHVsErhqzyCpDGFA-FkNFaWp94e9LnB3njxqw@mail.gmail.com>

On Mon, Jun 08, 2026 at 10:13:50AM -0700, Ethan Nelson-Moore wrote:
> Hi, Arnd,
> 
> On Mon, Jun 8, 2026 at 10:11 AM Arnd Bergmann <arnd@arndb.de> wrote:
> > I think this is correct, as footbridge is the only one that selects
> > CONFIG_ARCH_MIGHT_HAVE_PC_SERIO and defines I8042_KBD_IRQ on arm.
> 
> I came to the same conclusion.

I see. In this case:

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com> # for input

Thanks.

-- 
Dmitry
