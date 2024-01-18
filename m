Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93E71D523
	for <linux-serial@vger.kernel.org>; Thu, 18 Jan 2024 09:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705569877; cv=none; b=DAP6GaevKES3rQLGSMUL6b9crLhwUQZfx/SGiOhTsyEKjVaA9qsGciI5JwE/e7v9FImr94abO4B5a+wcezFBkHX5ISI5d7QwTWam4SShoNgsBo4ZvpcuMjvlbhWff56DRAZhg9tpGv3D+rCBxNPUvduKFTq4B+aOeGYdbPzFYiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705569877; c=relaxed/simple;
	bh=hAxBSB8jZGNGXkaDT5Gc0IOAwfXgI9zR287purl7LbA=;
	h=DKIM-Signature:Received:X-MC-Unique:Received:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Received:
	 X-Google-Smtp-Source:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 X-Mimecast-Spam-Score:X-Mimecast-Originator:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding; b=rpFOdtFnkdVprzXOc/SCR+Nixo9zP4RUfeJwI/6KOM4UHV4AUmDe3qyR1Y7NSyzEFU+Qv9CiFu9OMKebQCsQdSpwtQQVujA1FzMKSop190YxRl6Ugbn+Hv2ELYLutXuKqBWZ6ftC4CPcAJz93KMEMtJsAvisvQyegksx6QnoFyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Cfi5xP4Z; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cfi5xP4Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705569874;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RnEHhjCm6k/CZTLAzXdrHvCgybCqk5qE4sMq7XE6mNc=;
	b=Cfi5xP4ZF0pv0ExF9gJt5KdlFg/gm9H+0XtV0pGnwMdE9FpsH57uyog0vxdlSXhEScoI75
	5uEGjn6Eyr9aRZgs0JIQhsAXf7CrKJ0AwVWHk6KkTFKWP7xmKrttH1/Ln+EsKJ45DeITRJ
	cVoYFuAVIdty4C5USBzXnrZ5rtP4csA=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-550-huT4ET6SMFeB3_N6-sb_Zw-1; Thu, 18 Jan 2024 04:24:30 -0500
X-MC-Unique: huT4ET6SMFeB3_N6-sb_Zw-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-429be5ecc87so91945011cf.2
        for <linux-serial@vger.kernel.org>; Thu, 18 Jan 2024 01:24:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705569870; x=1706174670;
        h=content-transfer-encoding:content-disposition:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RnEHhjCm6k/CZTLAzXdrHvCgybCqk5qE4sMq7XE6mNc=;
        b=J8KnXny7FdBTDPmUYiX8VcsgSuUgsOFDMaB46yClPUjWO5/4Ak9c5+HeHQ8tgFnVJL
         fYy7JHi9H1LPOnuf7JfhdQ5wQn5VGgnkV7zE/+Mym3lptaVNYq9C+HvbsIetkf46jsd5
         L+s90oTN8l0pmBbqnrRO4KEDlECnSFjd57jYxYZ0hUKF/Uizs68FNGv4J+UBd4Bmv6CG
         Cr6eOTCncMdrIf3pF3qTV8FyZrHzVFy36y42zl/QV/Jay594E21cwQ+/N/Q6beE7QVr1
         WKlA6yMBchrdsuqDngoZbsPm8/LHesjH3bVkna3emV9hMwRR5tr20crgiaA/K+oUohSe
         W+MQ==
X-Gm-Message-State: AOJu0YwmzvMBV2Fazk6hw3eaotpT8Sl9r1JbYyx61xR54YQ0koUOjAur
	xLYSriclV3gRKsl2Yx4TqhxblgnjHyx5gLBSFoF3rKd7LANNyD+147Lf2cl/gYgxB1HfyEmVjib
	GKyxJdgKiVS4IcnOhSiXK2/CE4Bh7mMfvGFqmrXESYVNck6bBjOOd5c+t8uHg4Q==
X-Received: by 2002:a05:622a:41:b0:429:e741:6086 with SMTP id y1-20020a05622a004100b00429e7416086mr545588qtw.50.1705569870285;
        Thu, 18 Jan 2024 01:24:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE/aIlnaKaJDxIo0ryzXxRyNDirj7kD4P44SfvMq8LixI0qLxHxLgWyeoalljRIspXWt/d+Mg==
X-Received: by 2002:a05:622a:41:b0:429:e741:6086 with SMTP id y1-20020a05622a004100b00429e7416086mr545580qtw.50.1705569869975;
        Thu, 18 Jan 2024 01:24:29 -0800 (PST)
Received: from LeoBras.redhat.com ([2804:1b3:a803:6ad1:9baf:f024:858c:2fee])
        by smtp.gmail.com with ESMTPSA id cn3-20020a05622a248300b00429c8ae9b94sm6362366qtb.85.2024.01.18.01.24.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 01:24:29 -0800 (PST)
From: Leonardo Bras <leobras@redhat.com>
To: Leonardo Bras <leobras@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
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
Date: Thu, 18 Jan 2024 06:24:25 -0300
Message-ID: <ZajuST2EHSPCwA1m@LeoBras>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <ZahYxOL2r7YbPvO7@LeoBras>
References: <20240116073701.2356171-1-leobras@redhat.com> <20240116073701.2356171-2-leobras@redhat.com> <87ttnbfw9f.ffs@tglx> <ZahYxOL2r7YbPvO7@LeoBras>
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

On Wed, Jan 17, 2024 at 07:46:28PM -0300, Leonardo Bras wrote:
> On Wed, Jan 17, 2024 at 11:08:44PM +0100, Thomas Gleixner wrote:
> > On Tue, Jan 16 2024 at 04:36, Leonardo Bras wrote:
> > > This IRQ line disable bug can be easily reproduced with a serial8250
> > > console on a PREEMPT_RT kernel: it only takes the user to print a lot
> > > of text to the console (or to ttyS0): around 300k chars should be
> > > enough.
> > 
> > That has nothing to do with RT, it's a problem of force threaded
> > interrupts in combination with an edge type interrupt line and a
> > hardware which keeps firing interrupts forever.
> 
> Hello Thomas, thanks for your feedback!
> 
> I agreed it has nothing to do with RT.
> I just mentioned PREEMPT_RT as my test case scenario, since it enables 
> force-threaded IRQs.
> 
> > 
> > > To fix this bug, reset irqs_unhandled whenever irq_thread handles at least
> > > one IRQ request.
> > 
> > This papers over the symptom and makes runaway detection way weaker for
> > all interrupts or breaks it completely.
> 
> This change is supposed to only touch threaded interruptions, since it will
> reach the included line only if (action_ret == IRQ_WAKE_THREAD) and if 
> desc->threads_handled changes since the last IRQ request.
> 
> This incrementing also happens only on irq_forced_thread_fn() and 
> irq_thread_fn(), which are called only from irq_thread_fn().
> 
> But I get the overall worry about having this making runaway detection way 
> weaker for all threaded interrupts.
> 
> I have previously worked on a solution that can be more precise and be an 
> opt-in for drivers instead of a general solution:
> 
> It required a change in IRQ interface that let the handlers inform how 
> many IRQs were actually handled (batching). This number would then be 
> added to desc->threads_handle (in irq_*thread_fn(), just changing the 
> atomic_inc() to atomic_add()), and then subtracted from irqs_unhandled
> at note_interrupt().
> 
> In the serial8250 case, the driver would be changed to use that interface, 
> since it's already able to process multiple IRQs, and the bug just 
> vanishes.
> 
> This also solved the serial driver issue, but required a deeper change in 
> the code, which caused me to consider a simpler solution first.
> 
> This solution sure does give better runnaway detection. Do you think it 
> would be better that the one I sent in this patch?

For reference, this is the alternative:
https://gitlab.com/LeoBras/linux/-/commits/serial8250

Please let me know it you think this one is better.

Thanks!
Leo

> 
> > 
> > The problem with edge type interrupts is that we cannot mask them like
> > we do with level type interrupts in the hard interrupt handler and
> > unmask them once the threaded handler finishes.
> > 
> > So yes, we need special rules here when:
> > 
> >    1) The interrupt handler is force threaded
> > 
> >    2) The interrupt line is edge type
> > 
> >    3) The accumulated unhandled interrupts are within a sane margin
> > 
> > Thanks,
> > 
> >         tglx
> > 
> 
> Completelly agree, that's why I am suggesting dealing with threaded 
> interruptions in a different way: reseting the unhandled count when it 
> handles a request. 
> 
> I am not sure how force threaded and just threaded are different in this 
> scenario. Could you help me understand?
> 
> Thanks!
> Leo

