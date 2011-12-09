From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 2/2] serial: bfin-uart: Remove ASYNC_CTS_FLOW flag for
 hardware automatic CTS.
Date: Fri, 9 Dec 2011 11:12:05 +0000
Message-ID: <20111209111205.04780196@pyramind.ukuu.org.uk>
References: <1323410421-10465-1-git-send-email-sonic.adi@gmail.com>
	<1323410421-10465-2-git-send-email-sonic.adi@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1323410421-10465-2-git-send-email-sonic.adi@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sonic Zhang <sonic.adi@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, linux-serial@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, uclinux-dist-devel@blackfin.uclinux.org, Sonic Zhang <sonic.zhang@analog.com>
List-Id: linux-serial@vger.kernel.org

> +#ifdef CONFIG_SERIAL_BFIN_CTSRTS
>  			uart->port.flags |= ASYNC_CTS_FLOW;
> +#endif

As an aside could the cts/hard cts etc be passed as properties to the
platform device rather than ifdeffed ?

Alan
