From: "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Subject: Re: [PATCH resend] serial: 8250: Add support for using
 platform_device resources
Date: Tue, 11 Jun 2019 20:11:06 +0200
Message-ID: <ef125e69-3128-255d-483e-14b50036905f@metux.net>
References: <20190430140416.4707-1-esben@geanix.com>
 <20190521113426.16790-1-esben@geanix.com> <20190521131131.GA19685@kroah.com>
 <878suzn9wx.fsf@haabendal.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <878suzn9wx.fsf@haabendal.dk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Esben Haabendal <esben@haabendal.dk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Jiri Slaby <jslaby@suse.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Darwin Dingel <darwin.dingel@alliedtelesis.co.nz>, Jisheng Zhang <Jisheng.Zhang@synaptics.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, He Zhe <zhe.he@windriver.com>, Marek Vasut <marex@denx.de>, Douglas Anderson <dianders@chromium.org>, Paul Burton <paul.burton@mips.com>, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 21.05.19 16:45, Esben Haabendal wrote:
> It sits here.  It is a rather big and clunky mfd driver, not ready for
> upstreaming in its current form.  I hope to get around to clean it up.
> But it is for a very specific hardware that is really available or
> usable for anybody else.  Does it make sense to spend effort on
> submitting such a driver?

Maybe you could post your queue w/ "RFC: " prefix and add a proper
introduction, so everybody knows that isn't meant to be upstreamed,
but instead a basis for discussions ?

Personally, I'd like to have a look at it and understand, what's the
actual problem you'd like to solve.


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
