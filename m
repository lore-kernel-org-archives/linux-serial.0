Received: from valentin-vidic.from.hr (valentin-vidic.from.hr [116.203.65.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13AE9270023;
	Thu, 27 Feb 2025 18:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.65.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740681655; cv=none; b=XxQQUkHJVZyzq5/iYrhtiG36ZG0eAA4JksTzZTd1biHJ/LdbKlQcvxhrE3OzXvj0CPAMk8k6kpFp5D/fvLldd2tNkyDY1+X/3USzGHwXDm2BNzb49GVkoXuLq/Z1iCeaTXD8xdhmD3eL6e0aTAWnz6E3bSjIn4i7AdYURf7NJ9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740681655; c=relaxed/simple;
	bh=3OffKzEDazgHk2DMS3TSy5nHESANR3JLuAHyR5OcAH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bjqt/cwd7tIg1bWqehFodKQgwGG1zdrm6U9GKGwqvyv/TFuRohF6Fvq6/wV3e52fORmTLwU7V9JGONd09ddrob/4r+s8qkQRUyfEIrjQ9Ti/3K5ZLXJu7MoYancNns9Y4vb8fYnRtavFfnjDp4P1zly1e1F9GnAchpzIrLUYCh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=valentin-vidic.from.hr; spf=pass smtp.mailfrom=valentin-vidic.from.hr; dkim=pass (4096-bit key) header.d=valentin-vidic.from.hr header.i=@valentin-vidic.from.hr header.b=jzd1jcNw; arc=none smtp.client-ip=116.203.65.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=valentin-vidic.from.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valentin-vidic.from.hr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=valentin-vidic.from.hr header.i=@valentin-vidic.from.hr header.b="jzd1jcNw"
X-Virus-Scanned: Debian amavis at valentin-vidic.from.hr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=valentin-vidic.from.hr; s=2024; t=1740681645;
	bh=3OffKzEDazgHk2DMS3TSy5nHESANR3JLuAHyR5OcAH4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jzd1jcNwt7Sb4GQl62MFaN8kv3b0y6DgScpWOL+TEppayqTwnuu0fPWHWWL4YdSmI
	 Z+/c/Qe7cpq5sJZ0n0DW5Vy55LE2059ehKQZuOuLc0MEDIIoXqRfciZYdhPIGZj6+1
	 cg0UNaDKpxu50fq8D2to5cfzzI0ed14j6k8hAIyIdDquNSbRDeQQniahr4iXpAm8X7
	 X8CSQwpScFr2ce5od1dbAtRPw7Ai4S7OlcbxS3T/W6aIy7Fz1dtpM/SSAikAtUQIUo
	 SqypYR/kx58KrUmlVC5koznk6aJg8fAa7bMKrk3UGfLx7ImsaGtfpQ+qEpqy/uBXfT
	 Kqs4eMLrvPxWU0PUC9k+1Wzsz8CQSYiYuzGGYcetFAmEzx1+Sn7X1ey10VM1kGCfKx
	 PJof1rIs9R89buOcsiENvIQFqvTbNY0hk8Ni52h/JL4+NX26Dc3xt2APrZnls4sEUV
	 CJBDP2KibaXgIrTkY33Ep9w/+AmJU/3aP4XGfOp4Yo6YcQtDDsqoUpanNKmyoNjVI1
	 Lu8aKzlcpb1c2/FuMr5Dzqh1j1H7LoDgGrDV6l03bpgMqZHbEj1n8cPxrnp3hwk021
	 WwNqeaEI7HS02yhZH2ePz1gCR5Al94bHIJpCDyC20H1b4I5tr1LEDbWD4fAdVWn3RK
	 ILijXKhg79hdpQdn+NDlB0bQ=
Received: by valentin-vidic.from.hr (Postfix, from userid 1000)
	id AACC330A58; Thu, 27 Feb 2025 19:40:45 +0100 (CET)
Date: Thu, 27 Feb 2025 19:40:45 +0100
From: Valentin =?utf-8?B?VmlkacSH?= <vvidic@valentin-vidic.from.hr>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH] tty: pty: remove redundant local variable
Message-ID: <Z8CxraJaTBFuKSIQ@valentin-vidic.from.hr>
References: <20250226204707.1941274-1-vvidic@valentin-vidic.from.hr>
 <2025022632-syrup-regretful-79df@gregkh>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025022632-syrup-regretful-79df@gregkh>

On Wed, Feb 26, 2025 at 04:49:45PM -0800, Greg Kroah-Hartman wrote:
> On Wed, Feb 26, 2025 at 09:47:07PM +0100, Valentin Vidic wrote:
> > The value of to is only used once, so no need to store it in a
> > variable.
> > 
> > Signed-off-by: Valentin Vidic <vvidic@valentin-vidic.from.hr>
> > ---
> >  drivers/tty/pty.c | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> > 
> > diff --git a/drivers/tty/pty.c b/drivers/tty/pty.c
> > index df08f13052ff..c6eb711500b6 100644
> > --- a/drivers/tty/pty.c
> > +++ b/drivers/tty/pty.c
> > @@ -110,12 +110,10 @@ static void pty_unthrottle(struct tty_struct *tty)
> >  
> >  static ssize_t pty_write(struct tty_struct *tty, const u8 *buf, size_t c)
> >  {
> > -	struct tty_struct *to = tty->link;
> > -
> >  	if (tty->flow.stopped || !c)
> >  		return 0;
> >  
> > -	return tty_insert_flip_string_and_push_buffer(to->port, buf, c);
> > +	return tty_insert_flip_string_and_push_buffer(tty->link->port, buf, c);
> 
> does this actually change the resulting code any?
> 
> "to" actually means something here, the tty is the "from" and the link
> is the "to" where the data is going, so having it be "to" makes the code
> easier to understand by humans, which is the first goal of code.
> Maintaining it for long periods of time is key.
> 
> Otherwise your change "tty->link->port" doesn't make it all that obvious
> that the this is being written not to the tty device itself, but to
> somewhere else, right?

Right, the resulting code does not change, it only simplifies the
function. For example, already the next one is very similar and does not
use the helper variable:

static unsigned int pty_write_room(struct tty_struct *tty)
{
        if (tty->flow.stopped)
                return 0;
        return tty_buffer_space_avail(tty->link->port);
}

-- 
Valentin
