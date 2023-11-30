Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92CA8482D2;
	Thu, 30 Nov 2023 13:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sNsqF9Xd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B7E7C433C8;
	Thu, 30 Nov 2023 13:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701352107;
	bh=2tPf+/3N0kX2qKIBtkb8qKUiUuJaNqMh/YALTgoUZoY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sNsqF9Xd/HHhAgJGyGP5ULvMaIvn9TdkEgBZpxvjpe+f0Fr/QXbnEYhxNGQmylxxC
	 xFxb9Ah4JurijcsgHid96kmgFj7R90pDrL6aeFewcg+sN6g0Qhv94VhkpguPum/YJT
	 IHdAeU8SGL6N6VPWpHdpcqJsarLv6/S/9dyEDwTQ=
Date: Thu, 30 Nov 2023 13:48:24 +0000
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Oliver Neukum <oneukum@suse.com>
Cc: Johan Hovold <johan@kernel.org>, Jiri Slaby <jirislaby@kernel.org>,
	USB list <linux-usb@vger.kernel.org>, linux-serial@vger.kernel.org
Subject: Re: question on correct error return from break_ctl()
Message-ID: <2023113055-molecular-backlands-6b3d@gregkh>
References: <7e649033-0e1d-4c21-a1f3-ceb2de894861@suse.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e649033-0e1d-4c21-a1f3-ceb2de894861@suse.com>

On Thu, Nov 30, 2023 at 02:09:48PM +0100, Oliver Neukum wrote:
> Hi,
> 
> it seems inconsistent. The tty layer
> in drivers/tty/tty_io.c::send_break()
> 
> static int send_break(struct tty_struct *tty, unsigned int duration)
> {
>         int retval;
> 
>         if (tty->ops->break_ctl == NULL)
>                 return 0;
> 
> not supporting break_ctl() is treated as the operation
> succeeding. Yet in drivers/usb/serial/usb-serial.c::serial_break()
> 
> static int serial_break(struct tty_struct *tty, int break_state)
> {
>         struct usb_serial_port *port = tty->driver_data;
> 
>         dev_dbg(&port->dev, "%s\n", __func__);
> 
>         if (port->serial->type->break_ctl)
>                 return port->serial->type->break_ctl(tty, break_state);
> 
>         return -ENOTTY;
> }
> 
> we are seeing that not supporting break_ctl() leads to returning
> -ENOTTY, which drivers/tty/tty_io.c::send_break() will return to user space.
> These reactions are at odds with each other. What is a driver supposed
> to do?

usb-serial should probably change, but given the fact that no one has
noticed this in the 20+ years it has been like this, is it really
needed?  :)

thanks,

greg k-h
