Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C0F38DD1
	for <linux-serial@vger.kernel.org>; Tue,  3 Jun 2025 16:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748968732; cv=none; b=PqZjIIatlIMEmn1+VdzuAF5BO+YTsJxaI6CryWPZdNFNE+o8r4NoE192xjKDDQFp5e13JY6lbBQSR/IQWwGu7SxhaF5gy4puQZZ+L9oo4bD3mYx55druBn1yDfT6TU99EmRIhzFd5UgP2zEoLKpJImTZr/RUJFHDdHjcH/5Gz2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748968732; c=relaxed/simple;
	bh=21ebxQPVxT/ww7UQNAT5KOqEC4d8ef+gfXcxIrxqSXk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JxN3QhyzHRdyNHzyYGqKQXG7mok3R+bcCbqeWtsnkizwNmFqq7MAFbEkikAROJodqmUAg+PAFaBO90yZM8Memwsl6mBZxg3fpLInVIjzdxeL4GqOfdOfblUoxranRZGVocIJ1QilMCNk22S8odInDnINSeyqXFvbRf1hz52F2RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk; spf=pass smtp.mailfrom=thegoodpenguin.co.uk; dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20230601.gappssmtp.com header.i=@thegoodpenguin-co-uk.20230601.gappssmtp.com header.b=UV3/abas; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20230601.gappssmtp.com header.i=@thegoodpenguin-co-uk.20230601.gappssmtp.com header.b="UV3/abas"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-23035b3edf1so53007735ad.3
        for <linux-serial@vger.kernel.org>; Tue, 03 Jun 2025 09:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20230601.gappssmtp.com; s=20230601; t=1748968730; x=1749573530; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=21ebxQPVxT/ww7UQNAT5KOqEC4d8ef+gfXcxIrxqSXk=;
        b=UV3/abas2gHxeAogJzktvsVXcPv8BlJdMhdLeQAvL63vWyIfFTJShxDtbBiGQd+yKI
         orNchJh7YCrDibi3JvBR6RmwOCTuM2r6VVK9sWMWGsrhV3PP1vOtOLyVf9bsdAMo7bMc
         UfzRZbGFkZEH5L+0oVlTb0HmymM0Y2VA3PKB27uHxxJ9Oj2vrJj1FQnldnu+EV2J+pUX
         fUJSfuHIkkWVb26O3OUtJ4j93N/ezyJImuEMYNIpVixPojbRHYB+ZRYHU5yw7UA48kjd
         oTF1UExYdJzglNRyfRlHqGinMeyDqYoPoU5WcILXcoaLMk+9Iv7DEVUAUT/jJXil8YLt
         YhPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748968730; x=1749573530;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=21ebxQPVxT/ww7UQNAT5KOqEC4d8ef+gfXcxIrxqSXk=;
        b=fpSoyfiGbp2Jfp7OHI51StOe9UgO9cvJnPZ/XYXdgYkhjyxya4KouR2cgZ6qlo76mc
         +FFSRnhpH1o+ojMIVuyvOL8djNuKMdtOrT1LzoWEYEip71LnulfmbIoBCmYBfpIqUie3
         ZC0rg8XYN20Z5R1o9tSVRE7uncuXl4bzLXpe7wOHxfHNxJWO9jFkw9osqbTf6Crt9JNc
         8yFqZ/XS2KtUYaY9mVDeq7CRunJm6q1P9PwMhw0CtVYLBhDVtdAAFUoyCz9cZGxEUj0W
         BbG8A1toPOovJ6Oj5LRBhLULaAPU3OhP6Tq6vURpR9auq0Me2WYqVRtaLb1tbGPm1Zfu
         JGMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxFwD61hg3PyQRq/ifVHjhERYix4tHwwjpOq/iS8jnik3PDv+pHDwT0vbrF3lcD52lawenv3mWPWCBg+s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwqoXUlnQp8U/FAQmdL1zDUwAPlLJBnu3CtE0VvGcZR61hJpVq
	I6NbpflNkFvHs+AFLr1xLCRMX3OIcoJLZ/VolIuLuE3miAcrYRPP3nUhMPHSzwALoFccJOfNi3A
	GbhdvIdWdAFJQfpkmcE1rjuWRRV7cwElGl6A/mSuTdUJsj21RaSqJE5fHxg==
X-Gm-Gg: ASbGncuiXwKUvGqQT10sviYVF5Ql8pZnnp72yI35sp/GNFMuUfsEXPd/nHdKY9bPPc7
	Jl0kRCm+/mG5O/K1vdMMpahQ0RzXh83Q2xx8BQ2NHVdLZWRcUm/WjvA4jysGE9UwriB2ZNY8N3x
	oW7kac6FOZWTuY9NvMyg+NgJ0H2A1cbNeSdf9Vs6w/jy4=
X-Google-Smtp-Source: AGHT+IE/lntDiMYoq7FRCcQWBwouaKzFURPvKbd9gnFy698MpqhWNKzgpFG/AGpL6nP2WvpCNiuw5FW0sdf0Sm+moz4=
X-Received: by 2002:a17:903:234d:b0:234:9375:e07c with SMTP id
 d9443c01a7336-23529b463a2mr273624215ad.46.1748968730062; Tue, 03 Jun 2025
 09:38:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250514173514.2117832-1-mcobb@thegoodpenguin.co.uk>
 <84jz6gdh5r.fsf@jogness.linutronix.de> <CAC251sUpHHU26wDgBuOGdxNGvE=2M22+b5E4Y+Lc9Ow63fOidw@mail.gmail.com>
 <847c1xrzib.fsf@jogness.linutronix.de> <84iklerw1i.fsf@jogness.linutronix.de>
 <aD8JOlDVP4ufgv44@pathway.suse.cz> <84msao6c37.fsf@jogness.linutronix.de>
In-Reply-To: <84msao6c37.fsf@jogness.linutronix.de>
From: Michael Cobb <mcobb@thegoodpenguin.co.uk>
Date: Tue, 3 Jun 2025 17:38:38 +0100
X-Gm-Features: AX0GCFs3y5z_KNZ_VvDYzWSVxdXLX9z236_VOcmLbqdsutZruZkwFJQfe5rWOnA
Message-ID: <CAC251sUp=mwaw2=CmGGxnBn-rAHO6u-MdSe6mDgcbbCKi3UPMA@mail.gmail.com>
Subject: Re: [PATCH RFC 0/3] printk: Don't flush messages using write_atomic
 during console registration if kthreads have not been started yet.
To: John Ogness <john.ogness@linutronix.de>
Cc: Petr Mladek <pmladek@suse.com>, rostedt@goodmis.org, senozhatsky@chromium.org, 
	linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi John, Petr,

Thanks for your time on this. I've had a look at John's suggestions
and I had a go at trying to remove the need for adding an additional
flag. Though I think Petr's solution is better than what I had come up
with.

On Tue, 3 Jun 2025 at 15:40, Petr Mladek <pmladek@suse.com> wrote:
>
> I hope that I have covered all the cases. Note that I haven't tested
> it with nbcon console though.
>
> What do you think, please?

Applied and tested this patch with an nbcon console, and I can see
that it's not causing an atomic flush. (Tested both with and without a
boot console/earlycon).

On Tue, 3 Jun 2025 at 17:09, John Ogness <john.ogness@linutronix.de> wrote:
>
> Note that LKML is not CC. I can offer my reviewed-by when the patch is
> posted on LKML.

I can also offer my Tested-by for this patch.

Kind regards,

Michael Cobb
