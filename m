Received: from sym2.noone.org (sym.noone.org [178.63.92.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B7819A297
	for <linux-serial@vger.kernel.org>; Tue,  3 Dec 2024 13:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.92.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733231681; cv=none; b=hIQayTWifkYDsobOIgDA/CYgfnhg/UpM6zywKiEMA65gUWmhflWfuVVfMo2bVmkA9ck4Quu54CgBczva5yUO0CcXi0vTr8Ier3d7nQj1vmLzVakzy8I+uvmEv97sev4R7ushBBNgsXNN7IRUbfe76+PBjYBaCtg/nG33a+WHyF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733231681; c=relaxed/simple;
	bh=UI5yL2mswcg3S5yhCNxiO4vt1ZBpNhs47PMvtWMQ2uY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c+8RpvE4uH4W98I33IsMOb4pr36MNv3ZwQdLkv/eWJka63Qv7RCSyKTpZviX2kk+8Q819Q2SaXe6CFyDZ84Az32zFNbVbMwAToIn32DG8+Gkrf7wAsepK3K44t+ELW8k5yOLRu4IciUhGV2X1GKWrvCUnnxphs3KCHZQsSOjTno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=distanz.ch; spf=none smtp.mailfrom=sym.noone.org; arc=none smtp.client-ip=178.63.92.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=distanz.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sym.noone.org
Received: by sym2.noone.org (Postfix, from userid 1002)
	id 4Y2h2N6KBwz3j1c2; Tue,  3 Dec 2024 14:14:34 +0100 (CET)
Date: Tue, 3 Dec 2024 14:14:34 +0100
From: Tobias Klauser <tklauser@distanz.ch>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH] serial: altera_jtaguart: Use DRV_NAME to initialize
 uart_driver.driver_name
Message-ID: <20241203131433.e4rmvbsc3prtvkje@distanz.ch>
References: <20241203125654.29657-1-tklauser@distanz.ch>
 <2024120337-unending-renewed-8e7e@gregkh>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024120337-unending-renewed-8e7e@gregkh>
User-Agent: NeoMutt/20170113 (1.7.2)

On 2024-12-03 at 14:03:03 +0100, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> On Tue, Dec 03, 2024 at 01:56:54PM +0100, Tobias Klauser wrote:
> > Use the DRV_NAME constant instead of the verbatim string.
> 
> Why?
> 
> > 
> > Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
> > ---
> >  drivers/tty/serial/altera_jtaguart.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/tty/serial/altera_jtaguart.c b/drivers/tty/serial/altera_jtaguart.c
> > index b9c3c3bed0c1..9657c3bb8e66 100644
> > --- a/drivers/tty/serial/altera_jtaguart.c
> > +++ b/drivers/tty/serial/altera_jtaguart.c
> > @@ -365,7 +365,7 @@ OF_EARLYCON_DECLARE(juart, "altr,juart-1.0", altera_jtaguart_earlycon_setup);
> >  
> >  static struct uart_driver altera_jtaguart_driver = {
> >  	.owner		= THIS_MODULE,
> > -	.driver_name	= "altera_jtaguart",
> > +	.driver_name	= DRV_NAME,
> 
> Why don't we just use KBUILD_MODNAME here and get rid of DRV_NAME
> entirely?

Thanks, I didn't know about KBUILD_MODNAME. Sent a new patch to get rid
of DRV_NAME.
