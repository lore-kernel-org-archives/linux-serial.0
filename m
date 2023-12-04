Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545A72E848
	for <linux-serial@vger.kernel.org>; Mon,  4 Dec 2023 21:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="He1rYRwh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CB14C433C7;
	Mon,  4 Dec 2023 21:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701724940;
	bh=E3kR7szeQvWZH9f+PSfsN2nZEpjZ+60jm9ah3uJYyx8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=He1rYRwhhTdSOsaUKjay5086grIOyZ84zHzt8FMFjWkTsHxXFisG1xejkBwFzsST/
	 bTfy0GweK9iA6mBnHsr/dxcE2ZSCuHtMVrfRguDURk8YF9x4tzxhSBndNni5Wzuusc
	 sRa//IWB/LTWS3dd6xtPxl/wfNK0mXP0tuAFH+Wn2O2s8LnHOSeUg6iyO9A0T/3Smk
	 4Ja/95BDvwOvT0JSB1pyTB86h8F5nqpD4/V8NKz4PV5fA4kLrvpuKesoyY39EXs99K
	 RjdEuBm/Bp3WWvOrTyrIlGeXv8WdEm9oVjveGjWRgfURlmvEzrv0hvFkhWJy8Ke0T/
	 bLUoix4OGGM2g==
Date: Mon, 4 Dec 2023 22:22:12 +0100
From: Andi Shyti <andi.shyti@kernel.org>
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: Jacky Huang <ychuang3@nuvoton.com>, Shan-Chun Hung <schung@nuvoton.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org
Subject: Re: [PATCH 2/2] serial: ma35d1: Improve logging for out-of-bound
 console setup
Message-ID: <20231204212212.p7dfi4xrwx65rqgz@zenone.zhora.eu>
References: <20231204163804.1331415-1-andi.shyti@kernel.org>
 <20231204163804.1331415-3-andi.shyti@kernel.org>
 <20231204154742.3aec6ab62378df433677102b@hugovil.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231204154742.3aec6ab62378df433677102b@hugovil.com>

Hi Hugo,

> Andi Shyti <andi.shyti@kernel.org> wrote:
> > An out-of-bound index results in an error and should not be
> > logged merely as a debug message; it requires at least a warning
> > level. Therefore, use pr_warn() instead of pr_debug.
> > 
> > Additionally, the log message itself has been improved for
> > clarity.
> > 
> > Signed-off-by: Andi Shyti <andi.shyti@kernel.org>
> > Cc: Jacky Huang <ychuang3@nuvoton.com>
> > ---
> >  drivers/tty/serial/ma35d1_serial.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/tty/serial/ma35d1_serial.c b/drivers/tty/serial/ma35d1_serial.c
> > index 21b574f78b861..bcc402b4c0b2f 100644
> > --- a/drivers/tty/serial/ma35d1_serial.c
> > +++ b/drivers/tty/serial/ma35d1_serial.c
> > @@ -599,7 +599,8 @@ static int __init ma35d1serial_console_setup(struct console *co, char *options)
> >  	int flow = 'n';
> >  
> >  	if ((co->index < 0) || (co->index >= MA35_UART_NR)) {
> > -		pr_debug("Console Port%x out of range\n", co->index);
> > +		pr_warn("Failed to write on cononsole port %x, out of range\n",
> > +			co->index);
> 
> Hi,
> I do not see why this improves clarity...

I came here from the previous patch (which, by the way, needs a
little change) as I noticed that the same check was being
performed elsewhere, but with a different message. I decided I
prefer my version more because if the id is 18, 'Console Port18
out of range' doesn’t mean much to me, and I don't know what the
driver is trying to do.

Another improvement to the message would be to print out the
failing function.

Of course, I can live without changing the message.

> 
> You also introduced a syntax error "cononsole".

that's unwanted, thanks.

Andi

> Hugo.
> 
> 
> >  		return -EINVAL;
> >  	}
> >  
> > -- 
> > 2.43.0
> > 
> > 
> 
> 
> -- 
> Hugo Villeneuve
