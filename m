From: Nish Aravamudan <nish.aravamudan@gmail.com>
Subject: Re: [ patch 6/7] drivers/serial/jsm: new serial device driver
Date: Sun, 27 Feb 2005 17:45:06 -0800
Message-ID: <29495f1d05022717454bc81cfa@mail.gmail.com>
References: <42225A64.6070904@us.ltcfwd.linux.ibm.com>
Reply-To: Nish Aravamudan <nish.aravamudan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received: from rproxy.gmail.com ([64.233.170.196]:43999 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261533AbVB1BpH (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 27 Feb 2005 20:45:07 -0500
Received: by rproxy.gmail.com with SMTP id a41so792017rng
        for <linux-serial@vger.kernel.org>; Sun, 27 Feb 2005 17:45:07 -0800 (PST)
In-Reply-To: <42225A64.6070904@us.ltcfwd.linux.ibm.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Wen Xiong <wendyx@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

> diff -Nuar linux-2.6.9.orig/drivers/serial/jsm/jsm_driver.h linux-2.6.9.new/drivers/serial/jsm/jsm_driver.h
> --- linux-2.6.9.orig/drivers/serial/jsm/jsm_driver.h    1969-12-31 18:00:00.000000000 -0600
> +++ linux-2.6.9.new/drivers/serial/jsm/jsm_driver.h     2005-02-27 17:14:44.747952016 -0600

<snip>

> +#define jsm_jiffies_from_ms(a) (((a) * HZ) / 1000)

Please use the existing msecs_to_jiffies(), which has both a more
sensible name and is correct.

Thanks,
Nish
