From: Michael Trimarchi <trimarchimichael@yahoo.it>
Subject: Re: [PATCH] atmel_serial: update the powersave handler to match serial core
Date: Fri, 19 Sep 2008 15:33:44 +0000 (GMT)
Message-ID: <393.6138.qm@web26208.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754828AbYISPeA@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Andrew Victor <linux@maxim.org.za>, Anti Sullin <anti.sullin@artecdesign.ee>, Haavard Skinnemoen <haavard.skinnemoen@atmel.com>
List-Id: linux-serial@vger.kernel.org

Hi,




> +    /* we can not wake up if we're running on slow clock */
> +    atmel_port->may_wakeup = device_may_wakeup(&pdev->dev);
> +    if (atmel_serial_clk_will_stop())
> +        device_set_wakeup_enable(&pdev->dev, 0);
> +
This is not true, the wakeup in the slow clock is possible, configure the
input pin of the serial device as a gpio, and wake up on gpio. Then you
must reconfigure as a serial pin, and you can wake up on slow clock.

Regards Michael

__________________________________________________
Do You Yahoo!?
Poco spazio e tanto spam? Yahoo! Mail ti protegge dallo spam e ti da tanto spazio gratuito per i tuoi file e i messaggi 
http://mail.yahoo.it 
