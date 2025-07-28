Received: from smtp1.iitb.ac.in (smtpd9.iitb.ac.in [103.21.126.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1CC338F9C
	for <linux-serial@vger.kernel.org>; Mon, 28 Jul 2025 05:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.21.126.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753680715; cv=none; b=puBt7T8RMCUdmd8TmXxyaS1fTM5r3a7l9p/9nN/4buEIaJ/8ED3odfUii4xpNn5IEGDDZm3wFXzb0k4gUuAt3EXN1PCv9mgnNMLrEfT96uajS3lzqXwZ+3i5D2kAkZL7fTM0JaZDp1jxDr/nMadYHZlLXw2Y5ZjqegMR1GhDwqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753680715; c=relaxed/simple;
	bh=xsovHFmFZz4ZVIsR/kFcDv+maxVHaOLgUGsuwMwZh8M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fnn0OOfVMmw119Bc0d1l5D8tMeAt1HVJrVm//CLIYPcgsnv2Lknbo+Lleeex7esewYcN02oKqm5g3TVXg9jDY/5LEuzPTYdnLC9LTgf/3nVCu2p+CJg36vFaCP1ZZfzv/Di2HlfwCWN5V0qK47toG6+SuWusjQALUzAYflFp+wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ee.iitb.ac.in; spf=pass smtp.mailfrom=ee.iitb.ac.in; dkim=pass (1024-bit key) header.d=iitb.ac.in header.i=@iitb.ac.in header.b=OVjajOh5; arc=none smtp.client-ip=103.21.126.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ee.iitb.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ee.iitb.ac.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iitb.ac.in header.i=@iitb.ac.in header.b="OVjajOh5"
Received: from ldns2.iitb.ac.in (ldns2.iitb.ac.in [10.200.12.2])
	by smtp1.iitb.ac.in (Postfix) with SMTP id B30AC101C924
	for <linux-serial@vger.kernel.org>; Mon, 28 Jul 2025 11:01:44 +0530 (IST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.iitb.ac.in B30AC101C924
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=iitb.ac.in; s=mail;
	t=1753680704; bh=xsovHFmFZz4ZVIsR/kFcDv+maxVHaOLgUGsuwMwZh8M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OVjajOh5q4lbdIPsNIo2Y0PKT4z8D1TFvijaXayeuSr8ufMJXM4AsBsh8y5mMaYhY
	 X+OfK0kNl5m5+tQogUFb3H0fpX3JcU3eZNCGNtq/ccd3sksUZWN1tsZbv94NjWl8SG
	 xqXN+rCtgjgg49vMFEtOhAvB8czTfXnzcr3i2Agk=
Received: (qmail 7314 invoked by uid 510); 28 Jul 2025 11:01:44 +0530
X-Qmail-Scanner-Diagnostics: from 10.200.1.25 by ldns2 (envelope-from <akhilesh@ee.iitb.ac.in>, uid 501) with qmail-scanner-2.11
 spamassassin: 3.4.1. mhr: 1.0. {clamdscan: 0.100.0/26337} 
 Clear:RC:1(10.200.1.25):SA:0(0.0/7.0):. Processed in 5.178536 secs; 28 Jul 2025 11:01:44 +0530
X-Spam-Level: 
X-Spam-Pyzor: Reported 0 times.
X-Envelope-From: akhilesh@ee.iitb.ac.in
X-Qmail-Scanner-Mime-Attachments: |
X-Qmail-Scanner-Zip-Files: |
Received: from unknown (HELO ldns2.iitb.ac.in) (10.200.1.25)
  by ldns2.iitb.ac.in with SMTP; 28 Jul 2025 11:01:39 +0530
Received: from bhairav.ee.iitb.ac.in (bhairav.ee.iitb.ac.in [10.107.1.1])
	by ldns2.iitb.ac.in (Postfix) with ESMTP id CBC4E3414E2;
	Mon, 28 Jul 2025 11:01:38 +0530 (IST)
Received: from bhairav-test.ee.iitb.ac.in (bhairav.ee.iitb.ac.in [10.107.1.1])
	(Authenticated sender: akhilesh)
	by bhairav.ee.iitb.ac.in (Postfix) with ESMTPSA id 91D1B1E8127E;
	Mon, 28 Jul 2025 11:01:38 +0530 (IST)
Date: Mon, 28 Jul 2025 11:01:33 +0530
From: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: jirislaby@kernel.org, andriy.shevchenko@linux.intel.com,
	john.ogness@linutronix.de, pmladek@suse.com, johan@kernel.org,
	namcao@linutronix.de, timur@kernel.org,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, akhileshpatilvnit@gmail.com,
	skhan@linuxfoundation.org
Subject: Re: [PATCH] tty: serial: ucc_uart: use WARN_ON() instead of BUG()
Message-ID: <aIcLNXkXG3UFbSrv@bhairav-test.ee.iitb.ac.in>
References: <aIbV+WbhFMDamaiW@bhairav-test.ee.iitb.ac.in>
 <2025072814-splicing-sassy-f33a@gregkh>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025072814-splicing-sassy-f33a@gregkh>

On Mon, Jul 28, 2025 at 06:07:22AM +0200, Greg KH wrote:
> On Mon, Jul 28, 2025 at 07:14:25AM +0530, Akhilesh Patil wrote:
> > Replace BUG() with WARN_ON() as recommended in
> > Documentation/process/deprecated.rst
> > Fix system entering into unstable/break/undebuggable state due to use
> > of BUG(). Follow strict suggestions as per [1] [2].
> > 
> > Link: https://lore.kernel.org/lkml/CA+55aFy6jNLsywVYdGp83AMrXBo_P-pkjkphPGrO=82SPKCpLQ@mail.gmail.com/ [1]
> > Link: https://lore.kernel.org/lkml/CAHk-=whDHsbK3HTOpTF=ue_o04onRwTEaK_ZoJp_fjbqq4+=Jw@mail.gmail.com/ [2]
> > Signed-off-by: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
> > ---
> >  drivers/tty/serial/ucc_uart.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/tty/serial/ucc_uart.c b/drivers/tty/serial/ucc_uart.c
> > index 0613f8c11ab1..6214ab1b67cb 100644
> > --- a/drivers/tty/serial/ucc_uart.c
> > +++ b/drivers/tty/serial/ucc_uart.c
> > @@ -223,7 +223,7 @@ static inline dma_addr_t cpu2qe_addr(void *addr, struct uart_qe_port *qe_port)
> >  
> >  	/* something nasty happened */
> >  	printk(KERN_ERR "%s: addr=%p\n", __func__, addr);
> > -	BUG();
> > +	WARN_ON(1);
> >  	return 0;
> >  }
> >  
> > @@ -242,7 +242,7 @@ static inline void *qe2cpu_addr(dma_addr_t addr, struct uart_qe_port *qe_port)
> >  
> >  	/* something nasty happened */
> >  	printk(KERN_ERR "%s: addr=%llx\n", __func__, (u64)addr);
> > -	BUG();
> > +	WARN_ON(1);
> >  	return NULL;
> >  }
> 
> You can't just do a search/replace for these types of things, otherwise
> we would have done so a long time ago.
> 

Hi greg, Agree. Let me dive deep to understand this BUG() -> WARN()
recommendation and come back after detailed analysis for this change.
> How did you test this patch?  The BUG() here assumes that if this ever

I have done only build check with NXP p1025rdb configuration as I do not
have this particular hardware handy.
> fires, the system is really broken, how have you recovered from that
> broken state?
> 
> thanks,
> 
> greg k-h

Thanks for the review :) 

Regards,
Akhilesh

