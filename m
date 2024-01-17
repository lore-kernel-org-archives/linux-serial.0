Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C05B286B4
	for <linux-serial@vger.kernel.org>; Wed, 17 Jan 2024 22:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705531600; cv=none; b=PybjL6rBwOxtakV+QWk81uj1CWm542r0megf3kKWGdxheHJ6Kjlx2p5jW45x3iZjGtGS18Ac2aBw1W7GbSqnEDO+nsA7YUgxSJko4HgAk+xuoShLCLjY5tJr4c2hvuzSZAji6zHv0OX3B0fAq0umaTFEgZ8skp3CNA9JbYb3V0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705531600; c=relaxed/simple;
	bh=mcEpWvsHsu6NkERYdnBFNgNTQ0oAv5x0CLAv8hfOsBg=;
	h=DKIM-Signature:Received:X-MC-Unique:Received:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Received:
	 X-Google-Smtp-Source:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 X-Mimecast-Spam-Score:X-Mimecast-Originator:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding; b=rQUBQyGhzwHqheJJRTRaHj1MwkiJaUcnemtkEe6Q0KZtzVwbDaC3DzLKr+xRyn7YnzJ058ADl38BJqy6lqnBOS5h+IXqnuQYfXsGFfZpVNVGGPscuBNUT+ZSfFffE4+81ZWTFXXJ9+aQ9R8LnNSz0yd/I9I8DKeT2wcZn/nkuA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CGJtiWvG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CGJtiWvG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705531597;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W9j/9lpyulEwJRZlqTpefpNQkNSsm5bXCYqRVisGqOs=;
	b=CGJtiWvGyWQpIq4jwZy4T6x5qxCXWYFoDufutLeXR/QH7RB88HgagPmb0G7VINBQli9/e7
	PV9CL4Eih0pWpsWTewUqQn1bRpfqBd/CLOOmsxVGuAvb9cbZXQO1Ml3GiCUrPVlCiSO9wt
	jail/vnz0QFMG2TL9Vvxl7e79ZnweAA=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-237-sDB2SybwNviN14_wDQ8q8Q-1; Wed, 17 Jan 2024 17:46:36 -0500
X-MC-Unique: sDB2SybwNviN14_wDQ8q8Q-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7830ab8fb5aso1218256985a.2
        for <linux-serial@vger.kernel.org>; Wed, 17 Jan 2024 14:46:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705531596; x=1706136396;
        h=content-transfer-encoding:content-disposition:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W9j/9lpyulEwJRZlqTpefpNQkNSsm5bXCYqRVisGqOs=;
        b=U2GuNoaMyEn+nNMs7nf19A7XZtgItN+eHm1Bv87yAag/hkp1iWt6OSmTAEum+cttV6
         PNifbT3VkdvDgACoaoAZTS6qN7dyN7i0ooAnNZVjGlgODm2PuADEpWzAF5O8wqnm6VFA
         HyPQ0CQU02vpIMFxuoXQO0i4a/BrKrW6nDJvc61a1VAJ5lZ+fFSiys6nsW4LBoslpziy
         D8zoBdfmMZrx64rHy9+zEF2vKXEq6c0Liy53HNM9YEO6rhzsF0wuvvIueeqQcvjOd4nT
         FpMHBKtq1U+BHyMW9JxqBzj/hs/lTNuxfxjUZ70YBzQ2KIpITooWS5NI6qTPkGPLGS6g
         6+UA==
X-Gm-Message-State: AOJu0YykvNspz8ncglztw2KSmv+bzQG4tZFRSTfgAerafqY20jRP2PZX
	/rEbdz1ucnqaLLDrs3wzSQAhxpvuYs85qFPXEjkI7CQuHBH7MyIvg49u5COvB2ZlSYdqmU2Lacy
	Ae4PS7IOQLtC4Hcv4b5kvwqY5ForafiAH
X-Received: by 2002:a05:620a:424f:b0:783:55c3:351b with SMTP id w15-20020a05620a424f00b0078355c3351bmr7944778qko.127.1705531595866;
        Wed, 17 Jan 2024 14:46:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEpyYARC8mlk0SE48gTlGHLEvnryGO4TpsYFWXqXdxHMenuLMcsWcc7NL/OkwyVvIL8r5mJLA==
X-Received: by 2002:a05:620a:424f:b0:783:55c3:351b with SMTP id w15-20020a05620a424f00b0078355c3351bmr7944769qko.127.1705531595529;
        Wed, 17 Jan 2024 14:46:35 -0800 (PST)
Received: from LeoBras.redhat.com ([2804:1b3:a803:6ad1:9baf:f024:858c:2fee])
        by smtp.gmail.com with ESMTPSA id os7-20020a05620a810700b007815c25b32bsm4865097qkn.35.2024.01.17.14.46.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jan 2024 14:46:35 -0800 (PST)
From: Leonardo Bras <leobras@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Leonardo Bras <leobras@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	John Ogness <john.ogness@linutronix.de>,
	Tony Lindgren <tony@atomide.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [RESEND RFC PATCH v1 1/2] irq/spurious: Reset irqs_unhandled if an irq_thread handles one IRQ request
Date: Wed, 17 Jan 2024 19:46:28 -0300
Message-ID: <ZahYxOL2r7YbPvO7@LeoBras>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <87ttnbfw9f.ffs@tglx>
References: <20240116073701.2356171-1-leobras@redhat.com> <20240116073701.2356171-2-leobras@redhat.com> <87ttnbfw9f.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, Jan 17, 2024 at 11:08:44PM +0100, Thomas Gleixner wrote:
> On Tue, Jan 16 2024 at 04:36, Leonardo Bras wrote:
> > This IRQ line disable bug can be easily reproduced with a serial8250
> > console on a PREEMPT_RT kernel: it only takes the user to print a lot
> > of text to the console (or to ttyS0): around 300k chars should be
> > enough.
> 
> That has nothing to do with RT, it's a problem of force threaded
> interrupts in combination with an edge type interrupt line and a
> hardware which keeps firing interrupts forever.

Hello Thomas, thanks for your feedback!

I agreed it has nothing to do with RT.
I just mentioned PREEMPT_RT as my test case scenario, since it enables 
force-threaded IRQs.

> 
> > To fix this bug, reset irqs_unhandled whenever irq_thread handles at least
> > one IRQ request.
> 
> This papers over the symptom and makes runaway detection way weaker for
> all interrupts or breaks it completely.

This change is supposed to only touch threaded interruptions, since it will
reach the included line only if (action_ret == IRQ_WAKE_THREAD) and if 
desc->threads_handled changes since the last IRQ request.

This incrementing also happens only on irq_forced_thread_fn() and 
irq_thread_fn(), which are called only from irq_thread_fn().

But I get the overall worry about having this making runaway detection way 
weaker for all threaded interrupts.

I have previously worked on a solution that can be more precise and be an 
opt-in for drivers instead of a general solution:

It required a change in IRQ interface that let the handlers inform how 
many IRQs were actually handled (batching). This number would then be 
added to desc->threads_handle (in irq_*thread_fn(), just changing the 
atomic_inc() to atomic_add()), and then subtracted from irqs_unhandled
at note_interrupt().

In the serial8250 case, the driver would be changed to use that interface, 
since it's already able to process multiple IRQs, and the bug just 
vanishes.

This also solved the serial driver issue, but required a deeper change in 
the code, which caused me to consider a simpler solution first.

This solution sure does give better runnaway detection. Do you think it 
would be better that the one I sent in this patch?

> 
> The problem with edge type interrupts is that we cannot mask them like
> we do with level type interrupts in the hard interrupt handler and
> unmask them once the threaded handler finishes.
> 
> So yes, we need special rules here when:
> 
>    1) The interrupt handler is force threaded
> 
>    2) The interrupt line is edge type
> 
>    3) The accumulated unhandled interrupts are within a sane margin
> 
> Thanks,
> 
>         tglx
> 

Completelly agree, that's why I am suggesting dealing with threaded 
interruptions in a different way: reseting the unhandled count when it 
handles a request. 

I am not sure how force threaded and just threaded are different in this 
scenario. Could you help me understand?

Thanks!
Leo

