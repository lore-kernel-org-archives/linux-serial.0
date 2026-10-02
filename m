Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E713A7D7A;
	Fri,  2 Oct 2026 05:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790920467; cv=none; b=owqlwFNF0cIqfD67guX+F0KJROxHYLqSUPr06MhI3bPJEW7ezUlipy5wW57ZiaWNtRVOEFNtBNmmVAf/QFTTCUYXaUqBqDb1aBl8RYx/m5adr6VH73LprL3r76Ap1zJ1JO/1ikVN9zMACKGQvJlRVlBMMljUNv1d22thsHhjGkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790920467; c=relaxed/simple;
	bh=bzNZsBlQCJxoX1MoY6HPq63QQqpDxHsFGPUZiJkrvt0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KpI3zGSrOpkuzsfCTz31iUBTWIWan7YNUg00saM9y5IH3Ph5LZ58UkHj43KsoEOYLXg8bYSrBxLrLaO2tctNtVhtEHK+dsCuYKp1Kglt4AswjMNh6R3VgQOww8CxGSQYi8rMj1DUm4K4Ykpy8KXyQ38ZPfG5+LYfAD/humXlP4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=K1MU+ZWE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="K1MU+ZWE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CCE01F00893;
	Fri,  2 Oct 2026 05:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790920465;
	bh=RqAp8hHJdx3c2BC8/zNEkpVnQnzvCLGlk2FJowYho2M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=K1MU+ZWE3bfLtVoBQx9h+YJgFGrZWcNJacSRJGZEvK0dwWRyzqYjKsrp8id8BvWxY
	 21nb+iMa5OywBNEx3ej7NsyCJVF9+K7QBA4C+QWy1RxdCZrIHVZLhuO/d6IvbQ/nKw
	 d9NgXK19KIjSWpbSdanWh4xgeIY+XZyweluB6Zww=
Date: Fri, 2 Oct 2026 07:54:18 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-serial@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
	"open list:TTY LAYER AND SERIAL DRIVERS" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] serial: cpm_uart: use irq variable for platform_get_irq()
Message-ID: <2026100212-massager-hardware-db44@gregkh>
References: <20260925181530.52953-1-rosenp@gmail.com>
 <2026100157-unleash-anime-e2cf@gregkh>
 <DLTSHPPY40S4.1G7I24UTEFX9C@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DLTSHPPY40S4.1G7I24UTEFX9C@gmail.com>

On Thu, Oct 01, 2026 at 01:38:15PM -0700, Rosen Penev wrote:
> On Thu Oct 1, 2026 at 1:46 AM PDT, Greg Kroah-Hartman wrote:
> > On Fri, Sep 25, 2026 at 11:15:30AM -0700, Rosen Penev wrote:
> >> struct uart_port has its irq member as an unsigned int, which does not
> >> work when platform_get_irq() returns an error.
> >>
> >> Use a local irq variable to handle this and write to struct uart_port's
> >> irq member when platform_get_irq() succeeds. On success, it returns an
> >> IRQ >= 0, which is representable by unsigned int.
> >>
> >> Fixes: 831603b3e8aa ("serial: cpm_uart: replace irq_of_parse_and_map with platform_get_irq")
> >> Reported-by: kernel test robot <lkp@intel.com>
> >> Closes: https://lore.kernel.org/oe-kbuild-all/202609251916.1XlVHLwd-lkp@intel.com/
> >> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> >> ---
> >>  drivers/tty/serial/cpm_uart.c | 10 ++++++----
> >>  1 file changed, 6 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/drivers/tty/serial/cpm_uart.c b/drivers/tty/serial/cpm_uart.c
> >> index 39f54bb7b485..ca0acccd3dd8 100644
> >> --- a/drivers/tty/serial/cpm_uart.c
> >> +++ b/drivers/tty/serial/cpm_uart.c
> >> @@ -1517,6 +1517,7 @@ static int cpm_uart_probe(struct platform_device *ofdev)
> >>  {
> >>  	int index = probe_index++;
> >>  	struct uart_cpm_port *pinfo = &cpm_uart_ports[index];
> >> +	int irq;
> >>  	int ret;
> >>
> >>  	pinfo->port.line = index;
> >> @@ -1524,14 +1525,15 @@ static int cpm_uart_probe(struct platform_device *ofdev)
> >>  	if (index >= UART_NR)
> >>  		return -ENODEV;
> >>
> >> +	irq = platform_get_irq(ofdev, 0);
> >> +	if (irq < 0)
> >> +		return irq;
> >> +
> >>  	platform_set_drvdata(ofdev, pinfo);
> >>
> >>  	/* initialize the device pointer for the port */
> >>  	pinfo->port.dev = &ofdev->dev;
> >> -
> >> -	pinfo->port.irq = platform_get_irq(ofdev, 0);
> >> -	if (pinfo->port.irq < 0)
> >> -		return pinfo->port.irq;
> >> +	pinfo->port.irq = irq;
> >
> > Why did you move where platform_get_irq() is called?
> 
> So that platform_set_drvdata does not get called on failure.

Why does that matter?
