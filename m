From: "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Subject: Re: [PATCH 1/8] drivers: tty: serial: 8250_bcm2835aux: use
 devm_platform_ioremap_resource()
Date: Wed, 13 Mar 2019 18:13:40 +0100
Message-ID: <0458c818-085f-53f3-4078-557fa752854b@metux.net>
References: <1552402660-31730-1-git-send-email-info@metux.net>
 <1552402660-31730-2-git-send-email-info@metux.net>
 <20190312163356.GB13549@kroah.com>
 <947da751-bbce-4364-a1bf-5487908e59a5@metux.net>
 <20190313143654.GA7489@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190313143654.GA7489@kroah.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: "Enrico Weigelt, metux IT consult" <info@metux.net>, jslaby@suse.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 13.03.19 15:36, Greg KH wrote:

> Also, usually RFC like patches and series are ignored, I know I almost
> always ignore them because if the author doesn't think they are ready to
> be reviewed, why would I spend time on them compared to other patches
> that their authors think are ready for review.

Okay, but then, how is the best way to ask for help ?

In my case here, there're several things still unclear to me, eg:

* struct uart_port -> mapbase:

=> seems to be used by most drivers, but some also clear it later, eg.
   uartlite does so when uart_add_one_port() call failed. is that
   really necessary ?

* struct uart_port -> mapsize:

=> seems to be used only rarely. most drivers use either fixed params
   on the memory mapping functions, or take it from some function.
   wouldn't it be better if all would fill out that field and later
   use it consistently ?


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
