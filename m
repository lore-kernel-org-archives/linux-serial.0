Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F26A22578A
	for <linux-serial@vger.kernel.org>; Thu, 11 Sep 2025 10:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757585591; cv=none; b=DNpwoSIYAcWKOzDGin1NpYeE7oTAD9VHmO8rLJWaeQ1oVFpMeyTriG7868Bwc/DOVKeWr4p5QI+QnHFD/8jXMHeh/I1irPRTliFyZFawJm6qrIKPxnQpZmrNm6Q1WROM017BxusM6hQHaU+MYvmZKOF9OCSr50KD8ClBf0qoCH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757585591; c=relaxed/simple;
	bh=48+ZxPEa0REPYfoen7YU7JflpXOtYQK5ezyqK7B6pYQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sVUyExpKShUW8CM3FfGhX9pzdJ87y29wZvxJd/hm2WW8CnZzeHlud4AbJWa93FZS0H9mxgw6sVfZ7AkTQ2SPM3VyoC+JVjm93EWo4u4dh5ByIdF+mUD5j461gpG1sIaRDrnAqbPNan9bnh0binw5+FyX0s4PQtlTCjW5zjy4cWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk; spf=pass smtp.mailfrom=thegoodpenguin.co.uk; dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20230601.gappssmtp.com header.i=@thegoodpenguin-co-uk.20230601.gappssmtp.com header.b=sixqrNh/; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20230601.gappssmtp.com header.i=@thegoodpenguin-co-uk.20230601.gappssmtp.com header.b="sixqrNh/"
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3ffe6666f8dso2716515ab.2
        for <linux-serial@vger.kernel.org>; Thu, 11 Sep 2025 03:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20230601.gappssmtp.com; s=20230601; t=1757585589; x=1758190389; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=48+ZxPEa0REPYfoen7YU7JflpXOtYQK5ezyqK7B6pYQ=;
        b=sixqrNh/s9sSm9qWWe1Hee1ikTo4wBCFaVqEWNqYzO9sgtCZkg/JpxC1KVtN+EY4/i
         2+C+8ySF/TXXriNEzAMP8UxRgln8I7em2BAUCGXCZQHJX++bF7UdJKbZTxkm2Fa2Jo9+
         ivOqX1o3mGbPlo2BHikBSlpApyL34mUZtsNDNqSef8bJuLaA6mMxiN9gMMdNnQuPyorq
         7yMfmPIgJGF/2I2/cnsEOgJqSGsM1ZDB2tS6oCTSYOq3chUprAXSeToUfdQpnj22WVRn
         zL7ZZ+kwlIZBr42XLnicDDrwd6IvxYi+4M0YiAzJKnaFbPHO70b9+8UIHpoLos6odaBL
         I9uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757585589; x=1758190389;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=48+ZxPEa0REPYfoen7YU7JflpXOtYQK5ezyqK7B6pYQ=;
        b=J3Ma+44zdmvhx86mu7o+PL4yiwIrYb20fSW3HjgXTZqFXSwFhod/zK8b8LCPQNwOBe
         8qWa/etskyZkdDo7Z/VEeTzNUfCyIUUOK60VLx9aUgxapeJlmrW1+Ex00H02Yx4cUVsk
         o2GH5/H2q0M9y2RDLGgY769NsT4dQDVFvOampt+Sz+PrI5izyJl8cTLE1Hybuw99kSn5
         sAfklTqsIkETZ6Z6HR89nTM8R8F3rwbl85hwr4fwKKElOX1vh4MOADDIIF1ZVlaLXxMA
         4ryALxFm4DYFpwaOSu1jxvSoEYnxbQguw24QU24fLZ5tEQ4xLUXGw0pWtmako50+zRTb
         hYuw==
X-Forwarded-Encrypted: i=1; AJvYcCUu3ZdtYwQf+uElsjIuxrI0MO0BlDe5WptQtqNnuba+XF/f5x/TJ3Q6H/lgJIbeG1I3rlKIBc/PIo1qWGg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzso4RYBjiStIRktIJrg6oydoWepoZ3pAE1TCLZoOZf6Eu1cqQt
	KiNbB/2E/sI3eNTaCwTjpN/SecplJncHqeTkdaAGAF/x/TxgRMWDSwnwz1a1NtfzQQNr1NCFtJ0
	BfuVSBbkoFSsmfZdoPptQHMYaEyrXzHtp2uK/rnxTog==
X-Gm-Gg: ASbGnct1sPuST42yJZOjmZuEIlkfwdlxCErqsdj/b0MKzW9wLtagc3Z4VX41ZTjvvkr
	+Fa17FYkDeIFRsHas8NQBfO3CKLCaf1u6nHWi/Nc5nCEeA/YBZrIMtOvNy1OiQAVozyvx+XQ/1x
	TY0zY+u9cOD0UfGQvRuUPTAf7VhSOIRggoVBY1/MIJAArXfhR9WH4WhhZ6dLutjhR1Sm+PP6o0y
	0FBp/exXxfqei7PYnmJfT5IYML9xFubjaCgBMEkB5piznSGTEI=
X-Google-Smtp-Source: AGHT+IGw8aTxlnsGfKaK9iC+HgjTpsXWo1/llJVRrnK435bvzVgvtwr7b1jKzOLHbCeRA3UgqmZdCE6Q9JvM7Z6K5vI=
X-Received: by 2002:a05:6e02:441a:20b0:3fe:33d4:8890 with SMTP id
 e9e14a558f8ab-3fe33d48949mr237795595ab.17.1757585589121; Thu, 11 Sep 2025
 03:13:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALqELGwr=XWA2iD-7wa1jOigx3pfEnTnaGWUMQX_A5MWe3DN_g@mail.gmail.com>
 <aMFBWJWqv3KsaaZU@pathway.suse.cz> <84a5326405.fsf@jogness.linutronix.de>
In-Reply-To: <84a5326405.fsf@jogness.linutronix.de>
From: Andrew Murray <amurray@thegoodpenguin.co.uk>
Date: Thu, 11 Sep 2025 11:12:58 +0100
X-Gm-Features: Ac12FXySUCMZawrb7bBpTfedzUnBnN0M_lhOXQ0H1Q-FSRGu86QSvqJb5Zyam8o
Message-ID: <CALqELGyysUyikGWozeNR0S87a3HtNBA8zVa8u4bHZ5rdCY5eBA@mail.gmail.com>
Subject: Re: Lock contention with console kthreads
To: John Ogness <john.ogness@linutronix.de>
Cc: Petr Mladek <pmladek@suse.com>, senozhatsky@chromium.org, rostedt@goodmis.org, 
	linux-serial@vger.kernel.org, Michael Cobb <mcobb@thegoodpenguin.co.uk>
Content-Type: text/plain; charset="UTF-8"

Hi Petr, John,

On Wed, 10 Sept 2025 at 10:39, John Ogness <john.ogness@linutronix.de> wrote:
>
> On 2025-09-10, Petr Mladek <pmladek@suse.com> wrote:
> >> Since commit 5f53ca3ff83b ("printk: Implement legacy printer kthread
> >> for PREEMPT_RT"), and only when PREEMPT_RT is enabled, legacy consoles
> >> use a kthread to write out to the device. This is beneficial for boot
> >> time when using a slow console such as a serial port. However, this
> >> gain can be short-lived as console_on_rootfs in init/main.c appears to
> >> act as a synchronisation point.
> >>
> >> legacy_kthread_func holds console_lock when flushing, and is held for
> >> a long period of time during boot.
>
> [...]
>
> > I would suggest to modify legacy_kthread_func() and flush one
> > record-per-cycle and get/release the console_lock() in each cycle.
>
> Agreed. This is an excellent suggestion!
>

Thanks for your quick feedback and suggestions.

I'll see if I can make some magic happen :)

Thanks,

Andrew Murray
