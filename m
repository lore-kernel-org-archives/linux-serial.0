From: Yazen Ghannam <yazen.ghannam@amd.com>
Subject: Re: [PATCH] ACPI / platform: Add support for build-in properties
Date: Thu, 3 Nov 2016 12:12:51 -0400
Message-ID: <20161103161250.GA25942@yaz-fedora.dyhomenet>
References: <20161102154139.GD11523@kuha.fi.intel.com>
 <20161103142126.87413-1-heikki.krogerus@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161103142126.87413-1-heikki.krogerus@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: =?iso-8859-1?B?Suly9G1l?= de Bretagne <jerome.debretagne@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kefeng Wang <wangkefeng.wang@huawei.com>, Feng Kan <fkan@apm.com>, linux-serial@vger.kernel.org, linux-acpi@vger.kernel.org, linux-bluetooth@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Thu, Nov 03, 2016 at 04:21:26PM +0200, Heikki Krogerus wrote:
> We have a couple of drivers, acpi_apd.c and acpi_lpss.c,
> that need to pass extra build-in properties to the devices
> they create. Previously the drivers added those properties
> to the struct device which is member of the struct
> acpi_device, but that does not work. Those properties need
> to be assigned to the struct device of the platform device
> instead in order for them to become available to the
> drivers.
> 
> To fix this, this patch changes acpi_create_platform_device
> function to take struct property_entry pointer as parameter.
> 
> Fixes: 20a875e2e86e ("serial: 8250_dw: Add quirk for APM X-Gene SoC")
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

I can confirm this patch fixes issues seen with AMD devices that were
introduced with 20a875e2e86e.

Please add:
Tested-by: Yazen Ghannam <yazen.ghannam@amd.com>

Thanks,
Yazen
