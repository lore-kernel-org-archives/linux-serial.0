From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCHv2 0/3] serial: dw8250: ACPI tuning
Date: Thu, 25 Aug 2016 15:47:38 +0300
Message-ID: <1472129258.4887.301.camel@linux.intel.com>
References: <1471941208-27963-1-git-send-email-heikki.krogerus@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1471941208-27963-1-git-send-email-heikki.krogerus@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>, linux-serial@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Tue, 2016-08-23 at 11:33 +0300, Heikki Krogerus wrote:
> Hi,
> 
> Since we now have the build-in properties available, using those when
> ever possible to get the details the driver expects and when they are
> not being provided by the fw. Right now there is only one exception
> ACPI enumerated board where we have no means to provide the properties
> with build-in ones, so simply handling that as an exception in
> dw8250_quirks().

Looks good to me.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>


> 
> Changes since v1:
> - Fix a compiler error in acpi_apd.c found by kbuild test robot
> - ACK from Mika
> 
> 
> Heikki Krogerus (3):
>   ACPI / APD: Provide build-in properties of the UART
>   ACPI / LPSS: Provide build-in properties of the UART
>   serial: 8250_dw: Add quirk for APM X-Gene SoC
> 
>  drivers/acpi/acpi_apd.c           | 15 +++++++++++++++
>  drivers/acpi/acpi_lpss.c          | 17 +++++++++++++++++
>  drivers/tty/serial/8250/8250_dw.c | 15 ++++++++++-----
>  3 files changed, 42 insertions(+), 5 deletions(-)
> 

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
