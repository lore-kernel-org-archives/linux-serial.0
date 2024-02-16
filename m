Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B64D12FF60
	for <linux-serial@vger.kernel.org>; Fri, 16 Feb 2024 20:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708114707; cv=none; b=in5gwlB4rQBJlJ/+N+SZnwO2lHsFev6Z8xlwMHqC8Hhi3mSThZDLdL8KJV3nyaMBccRe8WnGUebUNPgMoILnyekqJHnDHT1MAdTWBVJYP3V7PQJb0fmrBgw4g9h5aDBTG2NoquoaWYG4gjid+58L3iNovt695hzcZgVV3qGx2Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708114707; c=relaxed/simple;
	bh=02fBze+VPiN2IlWJArLIcZJnV5U0/kJfFuoQ8de5peM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Disposition; b=sZOrNJcx1FvwUQuF99JYi0yp88TKMBldEovCg4hm5kDUZEbeZ0WBFoFIdWZ54V7Yqxau6pL1RsoKnzu81gR+derySgT2ZvfkYPG/5jpNQ5ENNh+O7vVnrASBNacJz4B0lMqTfT6H54ATg2RzMSiY2il16EpD4pqpG1fZOHpHfzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ODJ+UIRH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ODJ+UIRH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708114705;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eEAq0tKZP/23jzaMIN60ZwyZvpQxftOTebhwinddGfA=;
	b=ODJ+UIRHnWqVoFOjIX2g9mgT685gkR3iqcOQJLabRoqTMfpjYVrq49vm241hnFsiBq8iIk
	7hdr3R/5R20Jnr1vjEwP3Ww+xjYSlgu8bgU+g79f8QfLgEoYjZsEWSMjFHjb7nySb1gQWH
	fHCylqGsBVTMOfeWIr7hWH3ksLBwS8s=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-1L3EL2HjNByoGguqKHbJXg-1; Fri, 16 Feb 2024 15:18:23 -0500
X-MC-Unique: 1L3EL2HjNByoGguqKHbJXg-1
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-3bd66680a39so2509344b6e.2
        for <linux-serial@vger.kernel.org>; Fri, 16 Feb 2024 12:18:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708114702; x=1708719502;
        h=content-transfer-encoding:content-disposition:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eEAq0tKZP/23jzaMIN60ZwyZvpQxftOTebhwinddGfA=;
        b=bh5n4NtVo2pdIEUSxokhfpkiZhtvGuwVa4rA3/bOvygZlD3FwstWcu2eS5BSMHCt3P
         xrtMa/3pOJkvTzmQkH/JQofMORUZvcwaFGHVC+M/d9ojxpqcDCCsXky5TNYDUD8L5qZ+
         2J6N90Q2fzBkUutqptW782FryE8vXY/3RK3DhJwfBV8h4tOasYdSsTo4AKhgFwlr3Fno
         NcNudaiFvr8upxnNAuBoZJr5L/763CnuhXzbAalug7WBoRvuPdFq4aV8g0K9vaEFKQ3c
         OhczY9qYBY8UPEPvfXcnUiRA9Igwr4LGulMplZ29A2K2YXEgLVaBEYGW7VGtICpzLgJu
         c+6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUKczw+i962vqiUgZdjW3RuO+Rmdcplbj+ZUuuUG0Sdhdc4Sxw35fDlICnM0UZNLLUSqRanW/tf0RROkekbz0Tmm4S1JUs2GoUKsvwx
X-Gm-Message-State: AOJu0YzD3j9tlJ0Nh8U3UP45O49LQ28UB7H+y+DHBOE0i3ibe4MVm8Wm
	pqbeEcvpy8G2nIwo5zCn4/qEv0IrCnuWuZ+lXbaQKquA4hnKo8DzIaODxhHanMqXm/uET1hwRbr
	CIxbUMo7tp8QsNmh5XA3dkzVUOohlNHacZ2wgsMF14ic2hZYHgJTbmFtQLzkKYA==
X-Received: by 2002:a05:6808:23c6:b0:3c0:4bf1:b5a6 with SMTP id bq6-20020a05680823c600b003c04bf1b5a6mr7162884oib.2.1708114702663;
        Fri, 16 Feb 2024 12:18:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFIzTp9rWVLDjQHfPe/31aF2/OhORAsPOJi3O5mQOLuN1b8kQlFOth9/cWEAuTxyAiepvFRzg==
X-Received: by 2002:a05:6808:23c6:b0:3c0:4bf1:b5a6 with SMTP id bq6-20020a05680823c600b003c04bf1b5a6mr7162868oib.2.1708114702447;
        Fri, 16 Feb 2024 12:18:22 -0800 (PST)
Received: from LeoBras.redhat.com ([2804:1b3:a800:4770:9d0:4bac:1782:4637])
        by smtp.gmail.com with ESMTPSA id pf2-20020a056214498200b0068f2aba4842sm239481qvb.129.2024.02.16.12.18.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 12:18:21 -0800 (PST)
From: Leonardo Bras <leobras@redhat.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Leonardo Bras <leobras@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Tony Lindgren <tony@atomide.com>,
	John Ogness <john.ogness@linutronix.de>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Shanker Donthineni <sdonthineni@nvidia.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [RFC PATCH v2 2/4] irq/spurious: Account for multiple handles in note_interrupt
Date: Fri, 16 Feb 2024 17:18:15 -0300
Message-ID: <Zc_DBym2GuwPmAne@LeoBras>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <Zc-BBQGauwIEJJXy@smile.fi.intel.com>
References: <20240216075948.131372-2-leobras@redhat.com> <20240216075948.131372-4-leobras@redhat.com> <Zc-BBQGauwIEJJXy@smile.fi.intel.com>
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

On Fri, Feb 16, 2024 at 05:36:37PM +0200, Andy Shevchenko wrote:
> On Fri, Feb 16, 2024 at 04:59:44AM -0300, Leonardo Bras wrote:
> > Currently note_interrupt() will check threads_handled for changes and use
> > it to mark an IRQ as handled, in order to avoid having a threaded
> > interrupt to falsely trigger unhandled IRQ detection.
> > 
> > This detection can still be falsely triggered if we have many IRQ handled
> > accounted between each check of threads_handled, as those will be counted
> > as a single one in the unhandled IRQ detection.
> > 
> > In order to fix this, subtract from irqs_unhandled the number of IRQs
> > handled since the last check (threads_handled_last - threads_handled).
> 
> ...
> 
> > +static inline int get_handled_diff(struct irq_desc *desc)
> > +{
> > +	unsigned int handled;
> > +	int diff;
> > +
> > +	handled = (unsigned int)atomic_read(&desc->threads_handled);
> > +	handled |= SPURIOUS_DEFERRED;
> > +
> > +	diff = handled - desc->threads_handled_last;
> > +	diff >>= SPURIOUS_DEFERRED_SHIFT;
> > +
> > +	/*
> > +	 * Note: We keep the SPURIOUS_DEFERRED bit set. We are handling the
> > +	 * previous invocation right now. Keep it for the current one, so the
> > +	 * next hardware interrupt will account for it.
> > +	 */
> 

Hello Andy, thanks for reviewing!

> > +	if (diff != 0)
> 
> 	if (diff)

Sure

> 
> > +		desc->threads_handled_last = handled;
> > +
> > +	return diff;
> > +}
> 
> ...
> 
> > +			diff = get_handled_diff(desc);
> > +			if (diff > 0) {
> 
> diff may not be negative as you always right shift by 1 (or more) bit.

Agree

> Hence
> 
> 			if (diff)
> 
> will suffice (also be aligned with the similar check inside the helper) and
> making the helper to return unsigned value will be clearer. Am I correct?

Sure, you are correct.

I just think having it be (diff > 0) makes it clear that we only do the 
subtraction if diff is bigger than zero, while (diff) could mean diff being 
valid, and would require the reader to go back in code to see that diff is 
an int. 

Does it make sense?

Other than that, I agree the negative half of diff is never going to get 
used, and it's better to go with unsigned int in both cases.

That will be changed on the next version.

Thanks!
Leo

> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

