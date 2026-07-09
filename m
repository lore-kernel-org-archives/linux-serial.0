Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759D530CD82;
	Thu,  9 Jul 2026 09:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783588065; cv=none; b=ZPmucQbtc9CV2xpthx+yovwd2Rf73CRL86vZwz0hHcDBCT6B3B4sz+RuyJ06RmsNJ2wKjs6zjSV2naIfktSquRZ+HNx4prwVdUUxB/qYPa7RY+cBMOWghTDkW6f2n+1mZnzvnNsthMSdnQ2E+IGBkXSjdt9cnEcZafz0XrSEa6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783588065; c=relaxed/simple;
	bh=KhMlqsR5ueaPuu1yTHwXyYD7oLk5fxjSlakmxsbwHlM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mZaDADh1XPRgA1Mc9whsBU+hBnvbhTJNBZLIFtVIFopps6ipeP5FPq2y153R40XAJadysqH/Py2jvqHx19nvkuPM7dtytyzqcCXvaP8a+3NTsuRtKpOzuwA/9cm18ladVAYvOr5oLd2n2AaTNJKxFfW98SGkm2mua8l0qhZ/i08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ikoi6Ikv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ikoi6Ikv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2818E1F000E9;
	Thu,  9 Jul 2026 09:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783588064;
	bh=gs9lFJzb/kX5ou22oeAzqrJFsvIK7semat8UR13MP5Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Ikoi6IkvC8M7DamoYw/4s1S9Hg2dToWzolNtCaGKb72kXyL6VVArUOg5ZC1wmXGxF
	 DE0HXTFHraPd9x1qMtITAHOES2sFO8e+Ftqdn/i+uJVcnP8HeJ5o5Hnk9NF4VEfbuS
	 nYdMlWHZbUMjETXTaxE5+kkZjL0+jOFh6Afx02jy7sUrtEQ13bJjPw70FUPTfN18KF
	 z8Y8zXGZDUV1AciRJZvpxr5g8ouvKcXZFh9jvg+iIrYVKyEquLg7P1PdJ16XWPf27S
	 kZmTbBk1kOBLXAlBqHZUorNQrcMhvjs3kyJsQZbJC1zu3KonJWMS2XZpy6u1Ymq3/T
	 iIT5D97d7qgFw==
Date: Thu, 9 Jul 2026 12:07:38 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v2 2/4] tty: amiserial: replace get_zeroed_page() with
 kzalloc()
Message-ID: <ak9k2oRDa-fhPk16@kernel.org>
References: <20260531-b4-tty-v2-0-f7149947d4ef@kernel.org>
 <20260531-b4-tty-v2-2-f7149947d4ef@kernel.org>
 <CAMuHMdWrLhDOFeeKJ573pvnmf0cNDsPJKEUQ_g+_+sawLEC6AQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdWrLhDOFeeKJ573pvnmf0cNDsPJKEUQ_g+_+sawLEC6AQ@mail.gmail.com>

Hi Geert,

On Thu, Jul 09, 2026 at 10:03:53AM +0200, Geert Uytterhoeven wrote:
> Hi Mike,
> 
> On Sun, 31 May 2026 at 09:04, Mike Rapoport (Microsoft) <rppt@kernel.org> wrote:
> > rs_startup() allocates a transmit ring buffer that is used to buffer reads
> > and writes from/to serial data register.
> >
> > This buffer can be allocated with kmalloc() as there's nothing special
> > about it to go directly to the page allocator.
> >
> > kmalloc() provides a better API that does not require ugly casts and
> > kfree() does not need to know the size of the freed object.
> >
> > Replace use of get_zeroed_page() with kzalloc() and free_page() with
> > kfree().
> >
> > Link: https://lore.kernel.org/all/635405e4-9423-4a25-a6e7-e03c8ea0bcbe@redhat.com
> > Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> 
> Thanks for your patch, which is now commit d26ed502d0c7c05c ("tty:
> amiserial: replace get_zeroed_page() with kzalloc()") in tty/tty-next
> 
> > --- a/drivers/tty/amiserial.c
> > +++ b/drivers/tty/amiserial.c
> > @@ -443,23 +443,23 @@ static int rs_startup(struct tty_struct *tty, struct serial_state *info)
> >         struct tty_port *port = &info->tport;
> >         unsigned long flags;
> >         int     retval=0;
> > -       unsigned long page;
> > +       void *buffer;
> 
> "char *", to match the type of info->xmit.buf?
 
Does it really matter that much to respin? ;-)

-- 
Sincerely yours,
Mike.
