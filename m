Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A5E366548
	for <linux-serial@vger.kernel.org>; Mon, 23 Mar 2026 20:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774298365; cv=none; b=FQm5TRp1VNLP1469Kk93B7nBrf8ol181qbh3lrQYETcZKDedGBDeo0wbdSBjkqs09Qx2YUrmWU+vMkkJk1hq4ZfhgAKs/LwBLgy13LaPZjrzh2IO0FV2b+n2fmsipzjXlDqOxAUS5cZUtrX3paysFKEOjvcIZuzmD7fQX30YGHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774298365; c=relaxed/simple;
	bh=0xmenb6aIIU5aOWdsACoSakZivt5YyHtjdFv4mUSEeY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=geJqhSWQPONKQAX7uw0Boj0XZcT+AXZrTCjt+GkXf5AwR5KQw10Z78XUl3oPovtJCZ+VbpxdSbeya0tx29B0qPhKf2XE1EnhYd01TiGzGrA8FSetiZyrJWaciDEBjzGzxv3w4f+ET8wIsLYtGKCZZvMHXUh4JY2w1jAT6sueXfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lAMb8jYN; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lAMb8jYN"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-43b40fb7f95so554044f8f.3
        for <linux-serial@vger.kernel.org>; Mon, 23 Mar 2026 13:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774298363; x=1774903163; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mC7gQwHaf68U+1O41oE01F2p3Obu47zcwWwR1wJbIvE=;
        b=lAMb8jYNrY0zpJ9YkFjem50ysl0doowk1Wt21NNdiXolq/WzZrPJZuYaCaucnuEjLA
         bhtDEQvnccV8+4DuRp4d6tIBi07Y56d0XiwhlaSuBgJskX8IZb/Yupju3wluRkI90NpV
         XxfjkTa58L8peLIX4go06C4vlK9e57FIk6naYHKcQ1KEOt7dWUqtfyoQ3WfYuDIKyuHG
         Z79gSJhsvQ7Ypb3bdsjfyWwQHcpsDm84hujYTK6M54f/NZaZ3Mw/apUVJjTbVSchP0Zu
         lutpjyQfH9eVPB5PDODGdAhoeLQ9GeyL99HXeh02HkafaWy4Oeb6myt/W9DgeFTi7X02
         MAuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774298363; x=1774903163;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mC7gQwHaf68U+1O41oE01F2p3Obu47zcwWwR1wJbIvE=;
        b=XlIdadRdJMp3ieXn5G3zlGgEDxo39z5RJwt9loqj9TWWQVNFzr2/z1bBdJbuIN2XSb
         ueFde1QNpGTW4b85AVCemk+aRHqNFJr6LF+Yj3lTWXzIs8BJ9uFbtNq926Exhhm9bm/d
         yNaU1hkn/vOnVhmfowiB6G3PpOtIN8N05maQONgwTASTSM9nLwU1s5yxO86TuzzA2bvU
         C/aE4G63FKqeSy4SDYPWYVSZuTqZqNWHFjUhS8csK4S4DYj0/aYh2ZsDUB+9qJx9WynK
         RO/WaqdcJ32n10b0aAJT8JQA0pOyJAmM3cSnt/PdZ6bvHTd2IqjvWX2AnBCYNHG0TXGe
         vwYg==
X-Forwarded-Encrypted: i=1; AJvYcCVAd4WnXLgwDwT9kPOtOceoFNeKupm59vk8vjEr2/ZmztFr6z+t+TabA+bCWy0SnmzvQigLE8sOnzVOX1w=@vger.kernel.org
X-Gm-Message-State: AOJu0YydbbcXLRvg1D84Ps98o+th9gQ78CZPWqemYHC7u37FbvyrHQZ1
	vSfiwbqp5hrnmtSr8YC9UBV6H/KvY/AUdqktDp9XVHDQwDRmsBQiRLfWGL7rcw==
X-Gm-Gg: ATEYQzxl2EoUAu75QgHMiED7KbqnKw2+G6UBqqTKNAx2gjWG2iq2UUntc/s8L8ZUKsR
	VuOlUN4imULpOnv/JXEAhYEuEhYpMZy6kDtE6xtlFEKwLlsRzpBaKDPT4YguUkGXF4ZhgiQF+1g
	eD99xo6oNgBojMsxaWmlORPAM4fhzdaUC1PVxdogNRQmsHry1pnsKkMRdZSEeCnjZoeXXIYXSwH
	qXc2bQ0nm1BlBXsk814AxgKgASxrRQmmLee/wy7zQ2VvxJSJE0d9iLL/y9rxNRuIhsdaco2vVSL
	E0wsPU87XsG36TK8hEm03BCiyO51yXBMMrlD/ZUx3Ts7jFU5PC7yy/QLrSdg5G+FEEFk4ujhWB7
	rZCkXXHHOfXupgJG+zZRiqeXX6OCeIuIlwKPn2YEZ0d6HSWe438lZ+5B181kLohAb5LCt9sA0VE
	+VHm9GjfBZbuzRMS7Ue2UWYU8o+u81s9SYHeQtl/bPFQgpJptnZQkJoHZu
X-Received: by 2002:a05:6000:2012:b0:439:b623:a9e9 with SMTP id ffacd0b85a97d-43b6423bde8mr22110394f8f.19.1774298362580;
        Mon, 23 Mar 2026 13:39:22 -0700 (PDT)
Received: from osama ([156.223.38.150])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b64703c27sm32155282f8f.18.2026.03.23.13.39.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 13:39:22 -0700 (PDT)
Date: Mon, 23 Mar 2026 21:39:15 +0100
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH] n_tty: add null check for tty->link in packet mode
Message-ID: <acGk84sMw-PwanbP@osama>
References: <20260314221044.148442-1-osama.abdelkader@gmail.com>
 <2026031501-recolor-runaround-0ed5@gregkh>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2026031501-recolor-runaround-0ed5@gregkh>

On Sun, Mar 15, 2026 at 07:57:53AM +0100, Greg Kroah-Hartman wrote:
> On Sat, Mar 14, 2026 at 11:10:44PM +0100, Osama Abdelkader wrote:
> > Add null check for tty->link before dereferencing in n_tty_read and
> > n_tty_poll. When the pty master closes, tty->link can be NULL while
> > the slave is still reading, causing a null pointer dereference.
> 
> How can that happen?
> 
> > Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
> > ---
> >  drivers/tty/n_tty.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
> > index e6a0f5b40d0a..dc04b87364f6 100644
> > --- a/drivers/tty/n_tty.c
> > +++ b/drivers/tty/n_tty.c
> > @@ -2232,7 +2232,7 @@ static ssize_t n_tty_read(struct tty_struct *tty, struct file *file, u8 *kbuf,
> >  	add_wait_queue(&tty->read_wait, &wait);
> >  	while (nr) {
> >  		/* First test for status change. */
> > -		if (packet && tty->link->ctrl.pktstatus) {
> > +		if (packet && tty->link && tty->link->ctrl.pktstatus) {
> >  			u8 cs;
> >  			if (kb != kbuf)
> >  				break;
> > @@ -2444,7 +2444,7 @@ static __poll_t n_tty_poll(struct tty_struct *tty, struct file *file,
> >  		if (input_available_p(tty, 1))
> >  			mask |= EPOLLIN | EPOLLRDNORM;
> >  	}
> > -	if (tty->ctrl.packet && tty->link->ctrl.pktstatus)
> > +	if (tty->ctrl.packet && tty->link && tty->link->ctrl.pktstatus)
> 
> What happens if link changes right after you test it?  Where is the
> lock?
> 
> And what changed to cause this to show up now?
> 
> thanks,
> 
> greg k-h

Hi Greg,

I was just thinking about null dereferencing possiblity in tty->link->ctrl.pktstatus. But, you are right
It’s reasonable to drop this patch and reopen it only if I get a solid reproducer or bug report.

BR,
Osama
