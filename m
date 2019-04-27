From: "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Subject: Re: [PATCH 1/2] serial: 8250: Allow port registration without
 UPF_BOOT_AUTOCONF
Date: Sat, 27 Apr 2019 13:57:57 +0200
Message-ID: <7a1fd6cc-050f-a077-6169-03552a89c563@metux.net>
References: <20190426084038.6377-1-esben@geanix.com>
 <20190426084038.6377-2-esben@geanix.com>
 <20190426143946.GX9224@smile.fi.intel.com> <871s1og11u.fsf@haabendal.dk>
 <20190426215103.GD9224@smile.fi.intel.com> <87tvejakot.fsf@haabendal.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87tvejakot.fsf@haabendal.dk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Esben Haabendal <esben@haabendal.dk>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Darwin Dingel <darwin.dingel@alliedtelesis.co.nz>, He Zhe <zhe.he@windriver.com>, Jisheng Zhang <Jisheng.Zhang@synaptics.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 27.04.19 10:58, Esben Haabendal wrote:

Hi folks,

> That said, the purpose of UPF_BOOT_AUTOCONF (for 8250 driver) is to> request and map the register memory.  So when that is already done by>
the parent MFD driver, I think it is silly to workaround problems
caused> by UPF_BOOT_AUTOCONF being force setted, when it really shouldn't.
I tend to agree. Maybe we should give serial8250_register_8250_port()
some flags for controlling this, or add another function for those
cases.

A minimal-invasive approach could be introducing an
serial8250_register_8250_port_ext() with extra parameters, and let
serial8250_register_8250_port() just call it.


By the way: the mem-mapping code pathes in serial8250 are a bit strange
anyways, eg. serial8250_port_size() is always called when map/unmap is
done, and this function does special logic for certain devices.
IMHO, it this should be called only once on device init and later just
use the already computed value:

https://github.com/metux/linux/commit/7ec63b699c910228b92cfb27eb8edfda90fdfd63

(haven't sent this queue yet, but feel free to cherry-pick if you like)


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
