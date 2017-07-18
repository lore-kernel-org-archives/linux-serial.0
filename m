From: Alexey Khoroshilov <khoroshilov@ispras.ru>
Subject: Re: [PATCH] serial: 8250: fix error handling in
 of_platform_serial_probe()
Date: Tue, 18 Jul 2017 10:33:06 +0300
Message-ID: <032e9a8b-8013-fe60-4a49-11cbf5cc28ed@ispras.ru>
References: <1498862969-4919-1-git-send-email-khoroshilov@ispras.ru>
 <20170718072732.GA15573@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170718072732.GA15573@kroah.com>
Content-Language: ru-RU
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>, Arnd Bergmann <arnd@arndb.de>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org
List-Id: linux-serial@vger.kernel.org

On 18.07.2017 10:27, Greg Kroah-Hartman wrote:
> On Sat, Jul 01, 2017 at 01:49:29AM +0300, Alexey Khoroshilov wrote:
>> clk_disable_unprepare(info->clk) is missed in of_platform_serial_probe(),
>> while irq_dispose_mapping(port->irq) is missed in of_platform_serial_setup().
>>
>> Found by Linux Driver Verification project (linuxtesting.org).
>>
>> Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
>> ---
>>  drivers/tty/serial/8250/8250_of.c | 20 +++++++++++++-------
>>  1 file changed, 13 insertions(+), 7 deletions(-)
> 
> I've had to drop this from my tree due to the obvious build warning it
> adds to the system.  Always test-build your patches before sending them
> out, it makes maintainers grumpy when you do not do that :(
> 
> greg k-h
> 

The problem is in conflict with e2860e1f62f2 "serial: 8250_of: Add reset
support" that was not in the Linus tree when the patch was developed.
I will rebase the patch and resend it.

--
Alexey
