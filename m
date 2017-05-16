From: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Subject: Re: [V2, 2/6] tty: serial: lpuart: add little endian 32 bit register
 support
Date: Tue, 16 May 2017 14:15:08 +0300
Message-ID: <fb9fe0cd-5ca7-74e6-33dc-7638e205b2e3@cogentembedded.com>
References: <1494834539-17523-3-git-send-email-aisheng.dong@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1494834539-17523-3-git-send-email-aisheng.dong@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dong Aisheng <aisheng.dong@nxp.com>, linux-serial@vger.kernel.org
Cc: fugang.duan@nxp.com, dongas86@gmail.com, gregkh@linuxfoundation.org, yangbo.lu@nxp.com, linux-kernel@vger.kernel.org, stefan@agner.ch, Mingkai.Hu@nxp.com, jslaby@suse.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

>  static u32 lpuart32_read(void __iomem *addr)
>  {
> -	return ioread32be(addr);
> +	return lpuart_is_be ? ioread32be(addr) : readl(addr);
>  }
>  
>  static void lpuart32_write(u32 val, void __iomem *addr)
>  {
> -	iowrite32be(val, addr);
> +	if (lpuart_is_be)
> +		iowrite32be(val, addr);
> +	else
> +		writel(val, addr);
>  }

What if this is ever executed on big endian system?
