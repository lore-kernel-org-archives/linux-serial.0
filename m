From: Heiko Schocher <hs@denx.de>
Subject: Re: [PATCH] tty: 8250_of: Use software emulated RS485 direction
 control
Date: Fri, 13 Sep 2019 16:51:30 +0200
Message-ID: <51a21dde-a471-6e8e-8048-50437d740f7f@denx.de>
References: <20190913050105.1132080-1-hs@denx.de>
 <20190913102409.GF2680@smile.fi.intel.com>
Reply-To: hs@denx.de
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190913102409.GF2680@smile.fi.intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-serial@vger.kernel.org, Alexander Sverdlin <alexander.sverdlin@nokia.com>, Darwin Dingel <darwin.dingel@alliedtelesis.co.nz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, John Garry <john.garry@huawei.com>, Linus Walleij <linus.walleij@linaro.org>, Lubomir Rintel <lkundrak@v3.sk>, Rob Herring <robh@kernel.org>, Thierry Reding <treding@nvidia.com>, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hello Andy,

Am 13.09.2019 um 12:24 schrieb Andy Shevchenko:
> On Fri, Sep 13, 2019 at 07:01:05AM +0200, Heiko Schocher wrote:
>> Use software emulated RS485 direction control to provide RS485 API
>>
>> Currently it is not possible to use rs485 as pointer to
>> rs485_config struct in struct uart_port is NULL in case we
>> configure the port through device tree.
> 
> Thank you for the patch, few recommendations for the future submissions.
> 
>> Patch is based on:
>> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>> commit:
>> 505a8ec7e11a - Revert "drm/i915/userptr: Acquire the page lock around set_page_dirty()"
> 
> More reliably is to base on corresponding subsystem tree, i.e. tty-next for
> this case.

Ok, should I send a rebased v2 (I tend to wait for other comments)?

>> checkpatch output:
>> $ ./scripts/checkpatch.pl 0001-tty-8250_of-Use-software-emulated-RS485-direction-co.patch
>> total: 0 errors, 0 warnings, 43 lines checked
>>
>> 0001-tty-8250_of-Use-software-emulated-RS485-direction-co.patch has no obvious style problems and is ready for submission.
> 
> There is no need to mention this. It's supposed that submitter did that
> themselves.

Hmm... ok.

> When you gather people to send the patch to, I recommend to use some threshold,
> e.g. `scripts/get_maintainer.pl --git --git-min-percent=67 ...`

Ah, good tip, thanks!

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
