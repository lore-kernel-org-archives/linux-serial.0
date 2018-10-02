From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Re: [PATCH] tty:serial:imx: use spin_lock instead of
 spin_lock_irqsave in isr
Date: Tue, 2 Oct 2018 13:37:40 -0700
Message-ID: <20181002203740.GB2397@kroah.com>
References: <20180827144904.17226-1-hangdianqj@163.com>
 <20181001085212.wu7eba4eh7koy5jx@pengutronix.de>
 <5205c4b4.20a1.166326bb238.Coremail.hangdianqj@163.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5205c4b4.20a1.166326bb238.Coremail.hangdianqj@163.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?utf-8?B?6ZKx5ZCb?= <hangdianqj@163.com>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Barry song <21cnbao@gmail.com>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@pengutronix.de
List-Id: linux-serial@vger.kernel.org

On Tue, Oct 02, 2018 at 09:36:50AM +0800, 钱君 wrote:
> 
> 
> I have changed the description content, please refer to the patch file, thanks a lot

I can not apply patches from attachments like this, please resend it
properly and I will be glad to review it.

thanks,

greg k-h
