From: "Chen, Rong A" <rong.a.chen@intel.com>
Subject: Re: [kbuild-all] Re: [PATCH] serial: sh-sci: Use
 platform_get_irq_optional() for optional interrupts
Date: Wed, 2 Oct 2019 22:20:52 +0800
Message-ID: <26cf2dd9-2788-bc23-03c4-beb8ed68ef97@intel.com>
References: <20191001180743.1041-1-geert+renesas@glider.be>
 <201910021701.JBV8khAI%lkp@intel.com>
 <CAMuHMdWQhvWOMjEpJrXV0nuKUc=wT6Zi_ZLjKco0Lkgeis8NyQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdWQhvWOMjEpJrXV0nuKUc=wT6Zi_ZLjKco0Lkgeis8NyQ@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>, kbuild test robot <lkp@intel.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, kbuild-all@01.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Stephen Boyd <swboyd@chromium.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Hi Geert,

Thanks for your clarification. we are on vacation this week, and we'll 
take a look asap.

Best Regards,
Rong Chen

On 10/2/2019 7:28 PM, Geert Uytterhoeven wrote:
> Hi Kbuild test robot,
>
> On Wed, Oct 2, 2019 at 11:53 AM kbuild test robot <lkp@intel.com> wrote:
>> I love your patch! Yet something to improve:
>>
>> [auto build test ERROR on tty/tty-testing]
>> [cannot apply to v5.4-rc1 next-20191001]
> Strange, this patch applies to all of v5.4-rc1, tty/tty-testing, and
> next-20191001?
>
>> url:    https://github.com/0day-ci/linux/commits/Geert-Uytterhoeven/serial-sh-sci-Use-platform_get_irq_optional-for-optional-interrupts/20191002-171547
> Oh, this is still the old tty/tty-testing before it was rebased to v5.4-rc1,
> i.e. still based on v5.3-rc4.  That explains the build failure.
>
> That does not explain why you couldn't apply this patch to v5.4-rc1 and
> next-20191001, though.
>
>> base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
>> config: sparc64-allmodconfig (attached as .config)
>> compiler: sparc64-linux-gcc (GCC) 7.4.0
>> reproduce:
>>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>          chmod +x ~/bin/make.cross
>>          # save the attached .config to linux build tree
>>          GCC_VERSION=7.4.0 make.cross ARCH=sparc64
>>
>> If you fix the issue, kindly add following tag
>> Reported-by: kbuild test robot <lkp@intel.com>
>>
>> All errors (new ones prefixed by >>):
>>
>>     drivers/tty/serial/sh-sci.c: In function 'sci_init_single':
>>>> drivers/tty/serial/sh-sci.c:2899:24: error: implicit declaration of function 'platform_get_irq_optional'; did you mean 'platform_get_irq_byname'? [-Werror=implicit-function-declaration]
>>         sci_port->irqs[i] = platform_get_irq_optional(dev, i);
>>                             ^~~~~~~~~~~~~~~~~~~~~~~~~
>>                             platform_get_irq_byname
>>     cc1: some warnings being treated as errors
> FTR, not reproducible on sparc on v5.4-rc1, current tty/tty-testing, and
> next-20191001.
>
> Gr{oetje,eeting}s,
>
>                          Geert
>
