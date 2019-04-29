From: "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Subject: Re: [PATCH 1/2] serial: 8250: Allow port registration without
 UPF_BOOT_AUTOCONF
Date: Mon, 29 Apr 2019 14:56:58 +0200
Message-ID: <a84da0ff-8f61-75a9-e91f-550fb70a3f5a@metux.net>
References: <20190426084038.6377-1-esben@geanix.com>
 <20190426084038.6377-2-esben@geanix.com>
 <20190426143946.GX9224@smile.fi.intel.com> <871s1og11u.fsf@haabendal.dk>
 <20190426215103.GD9224@smile.fi.intel.com> <87tvejakot.fsf@haabendal.dk>
 <CAHp75VfZMuQ3xagGSt6dXv1tZbSfanUdaw0SgjTqq3YET5YBKQ@mail.gmail.com>
 <87y33tz5oz.fsf@haabendal.dk>
 <CAHp75Vc6cLnLztXtvTcWisjAqDUTEWBBgv20CA34ZQmBEAvpbA@mail.gmail.com>
 <87ef5lxiqm.fsf@haabendal.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87ef5lxiqm.fsf@haabendal.dk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Esben Haabendal <esben@haabendal.dk>, Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Darwin Dingel <darwin.dingel@alliedtelesis.co.nz>, He Zhe <zhe.he@windriver.com>, Jisheng Zhang <Jisheng.Zhang@synaptics.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On 29.04.19 11:29, Esben Haabendal wrote:

> So maybe we should go down that direction intead, extending 8250 driver
> to replace mapbase with a resource struct instead?

Yeah, I already was up to do that. But that would be a pretty massive
change, as the actual use of fields like mapsize/mapbase in the drivers
is so diverse. Some even don't use mapsize.

That's why I started harmonizing that step by step. In little steps,
that are easier to review (unfortunately, don't have the corresponding
hardware to do real tests).

Finally, I'd like to have all drivers just use appropriate helpers to
declare their IO area and let the core do all the mapping stuff. Then we
IMHO could easily switch to struct resource internally.

> No, I actually try to do the right thing in relation to Linux device
> resource model.  But 8250 is just not behaving very well in that
> respect, not having been made really aware of the resource model.

I see it the same way. The serial (especially 8250) drivers are a tricky
thing, and I'd like to make it simpler / easier to understand.

But I can understand that Greg is pretty reluctant to any changes, as
some actual hardware seems to be hard to get. (OTOH, if it's so rare,
could we risk some potential breaks and just wait for anybody
complaining ?)


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
