From: Denis Vlasenko <vda@ilport.com.ua>
Subject: Re: Moxa multi serial driver doesn't pass received chars up
Date: Thu, 2 Jun 2005 15:54:07 +0300
Message-ID: <200506021554.07316.vda@ilport.com.ua>
References: <200506021220.47138.vda@ilport.com.ua>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:24202 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S261407AbVFBM6h (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 2 Jun 2005 08:58:37 -0400
In-Reply-To: <200506021220.47138.vda@ilport.com.ua>
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc: rmk+serial@arm.linux.org.uk, alan@redhat.com

On Thursday 02 June 2005 12:20, Denis Vlasenko wrote:
> Hi,
> 
> I have to set up 8-port PCI multiport serial card.
> Everything seems okay except for receive side.
> 
> I added this to mxser.c: mxser_receive_chars()
> at the bottom:
> 
>         mxvar_log.rxcnt[info->port] += cnt;
>         info->mon_data.rxcnt += cnt;
>         info->mon_data.up_rxcnt += cnt;
>         spin_unlock_irqrestore(&info->slock, flags);
> 
> +if (verbose>1) {
> +int c = cnt;
> +unsigned char *p = tty->flip.char_buf;
> +printk("mxser_receive_chars:");
> +while(c--)
> +    printk(" %02x", *p++);
> +printk("\n");
> +}
> 
>         tty_flip_buffer_push(tty);
> }

No wonder... it directly stuffs chars into flip buffer,
but does _not_ update flip counter!

I am cooking a patch which will use

tty_insert_flip_char(tty, ch, flag);

instead...
--
vda

