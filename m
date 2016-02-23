From: Romain Izard <romain.izard.pro@gmail.com>
Subject: Re: [PATCH v1] serial: mctrl_gpio: Add missing module license
Date: Tue, 23 Feb 2016 17:05:55 +0100
Message-ID: <CAGkQfmMRXYZmE=jkfLPiDisjySRUiPdJhanQjh5+ej1=pU_nAQ@mail.gmail.com>
References: <1456239294-28342-1-git-send-email-romain.izard.pro@gmail.com> <CAOMZO5C1rBmwERkVo051UK8sYH_Pap_DDB_ykB4hSCy522Vi8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAOMZO5C1rBmwERkVo051UK8sYH_Pap_DDB_ykB4hSCy522Vi8w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

2016-02-23 16:21 GMT+01:00 Fabio Estevam <festevam@gmail.com>:
> On Tue, Feb 23, 2016 at 11:54 AM, Romain Izard
> <romain.izard.pro@gmail.com> wrote:
>> As the mctrl_gpio driver can be built as a module, it needs to have its
>> license specified with MODULE_LICENSE. Otherwise, it cannot access
>> required symbols exported through EXPORT_SYMBOL_GPL.
>>
>> Signed-off-by: Romain Izard <romain.izard.pro@gmail.com>
>> ---
>>  drivers/tty/serial/serial_mctrl_gpio.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/tty/serial/serial_mctrl_gpio.c b/drivers/tty/serial/serial_mctrl_gpio.c
>> index 226ad23b136c..02147361eaa9 100644
>> --- a/drivers/tty/serial/serial_mctrl_gpio.c
>> +++ b/drivers/tty/serial/serial_mctrl_gpio.c
>> @@ -20,6 +20,7 @@
>>  #include <linux/gpio/consumer.h>
>>  #include <linux/termios.h>
>>  #include <linux/serial_core.h>
>> +#include <linux/module.h>
>>
>>  #include "serial_mctrl_gpio.h"
>>
>> @@ -249,3 +250,5 @@ void mctrl_gpio_disable_ms(struct mctrl_gpios *gpios)
>>         }
>>  }
>>  EXPORT_SYMBOL_GPL(mctrl_gpio_disable_ms);
>> +
>> +MODULE_LICENSE("GPL");
>
> Shouldn't it be "GPL v2" instead to match the licensing text in the
> top of the file?

According to include/linux/module.h, "GPL" means "GNU Public License
v2 or later",
which is the license text in the file header.

-- 
Romain Izard
