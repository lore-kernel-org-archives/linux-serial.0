From: Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH v2] serial: 8250: of: Fix the driver and actually compile
 the 8250_of
Date: Fri, 18 Dec 2015 16:57:32 +0000
Message-ID: <56743AFC.7000402@nvidia.com>
References: <1450443649-31654-1-git-send-email-peter.ujfalusi@ti.com>
 <3295738.CvTDrXdGbt@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3295738.CvTDrXdGbt@wuerfel>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org


On 18/12/15 13:16, Arnd Bergmann wrote:
> On Friday 18 December 2015 15:00:49 Peter Ujfalusi wrote:
>> The 8250_of never compiled since in the Kconfig we have SERIAL_OF_PLATFORM
>> but in the makefile we expect to have SERIAL_8250_OF...
>>
>> When the 8250_of.c is actually compiled we will have two errors:
>> missing linux/nwpserial.h and 8250/8250.h.
>> Fix those as well at the same time when enable the compilation of the
>> driver.
>>
>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>> Fixes: afd7f88f1577 ("serial: 8250: move of_serial code to 8250 directory")
>> CC: Arnd Bergmann <arnd@arndb.de>
>>
> 
> Thanks for fixing this, and sorry for the mess.
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>

Thanks, this fixes booting tegra 32-bit devices on -next.

Acked-by: Jon Hunter <jonathanh@nvidia.com>
Tested-by: Jon Hunter <jonathanh@nvidia.com>

Cheers
Jon
