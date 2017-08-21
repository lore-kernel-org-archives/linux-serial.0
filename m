From: Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH v3] serial: 8250_of: Add basic PM runtime support
Date: Mon, 21 Aug 2017 17:50:58 +0530
Message-ID: <1e3ad33d-882e-d4a0-6295-ac06397b11d2@ti.com>
References: <20170816205536.19634-1-fcooper@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170816205536.19634-1-fcooper@ti.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Franklin S Cooper Jr <fcooper@ti.com>, gregkh@linuxfoundation.org, jslaby@suse.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, vigneshr@ti.com, joel@jms.id.au, khoroshilov@ispras.ru, arnd@arndb.de, robert.jarzmik@free.fr, tthayer@opensource.altera.com
Cc: Murali Karicheri <m-karicheri2@ti.com>
List-Id: linux-serial@vger.kernel.org

On Thursday 17 August 2017 02:25 AM, Franklin S Cooper Jr wrote:
> 66AK2G UART instances are not apart of the ALWAYS_ON power domain.
> Therefore, pm_runtime calls must be made to properly insure the appropriate
> power domains needed by UART are on. Keep legacy clk api calls since other
> users of this driver may not support PM runtime.

Do we really have users like that? And even if there are, cant they use
PM clock handling support available in drivers/base/power/clock_ops.c ?

The clock enable support itself was added pretty "recently" - about 5
years back with 0bbeb3c3e84b ("of serial port driver - add
clk_get_rate() support"). So I doubt any really legacy platforms relied
on clock support being there. It was added by Murali, I assume for
Keystone devices. Keystone devices can work with runtime PM using the PM
clock support pointed to above.

Perhaps linux-arm-kernel list should be copied on this submission too,
since most users of this driver are likely to be there on that list.

> 
> Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>

Thanks,
Sekhar
