From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 7/7] serial/8250: make PIO support optional
Date: Tue, 28 Jun 2011 11:11:05 +0100
Message-ID: <20110628111105.7126569f@lxorguk.ukuu.org.uk>
References: <1309211120-2803-1-git-send-email-arnd@arndb.de>
	<1309211120-2803-8-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1309211120-2803-8-git-send-email-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org


> -		p->serial_in = io_serial_in;
> -		p->serial_out = io_serial_out;
> +		p->serial_in = mem_serial_in;
> +		p->serial_out = mem_serial_out;
>  		break;


And this kind of stuff changing defaults is asking for trouble.
