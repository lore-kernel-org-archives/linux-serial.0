From: =?UTF-8?B?SmFudXN6IFXFvHlja2k=?= <j.uzycki@elproma.com.pl>
Subject: Re: [PATCH 1/4] serial: mxs-auart: use mctrl_gpio helpers for handling
 modem signals (v2.2)
Date: Wed, 17 Sep 2014 11:50:29 +0200
Message-ID: <54195965.10007@elproma.com.pl>
References: <1410945333-26250-1-git-send-email-j.uzycki@elproma.com.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from v032797.home.net.pl ([89.161.177.31]:61208 "HELO
	v032797.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753617AbaIQJuZ (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 17 Sep 2014 05:50:25 -0400
In-Reply-To: <1410945333-26250-1-git-send-email-j.uzycki@elproma.com.pl>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, devicetree@vger.kernel.org


W dniu 2014-09-17 11:15, Janusz Uzycki pisze:
>   static struct platform_device_id mxs_auart_devtype[] = {
> @@ -417,6 +431,34 @@ static void mxs_auart_set_mctrl(struct uart_port *u, unsigned mctrl)
>   
>   	s->ctrl = mctrl;
>   	writel(ctrl, u->membase + AUART_CTRL2);
> +
> +	mctrl_gpio_set(s->gpios, mctrl);
> +}

@@ -429,7 +429,12 @@ static void mxs_auart_set_mctrl(struct uart_port 
*u, unsigned mctrl)
                         ctrl |= AUART_CTRL2_RTS;
         }

+#if 0
         s->ctrl = mctrl;
+#else
+       s->ctrl &= ~(TIOCM_RTS | TIOCM_DTR);
+       s->ctrl |= mctrl & (TIOCM_RTS | TIOCM_DTR);
+#endif
         writel(ctrl, u->membase + AUART_CTRL2);

         mctrl_gpio_set(s->gpios, mctrl);

Does tty layer modify mctrl for input lines and code above is required?

best regards
Janusz

