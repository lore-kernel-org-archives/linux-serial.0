From: John Garry <john.garry@huawei.com>
Subject: Re: [PATCH] serial: 8250_of: Add IO space support
Date: Mon, 23 Apr 2018 10:22:40 +0100
Message-ID: <af71a628-d9c8-bfbd-5772-8fced7c51b6b@huawei.com>
References: <1524152268-228631-1-git-send-email-john.garry@huawei.com>
 <20180423081402.GA19169@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180423081402.GA19169@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: jslaby@suse.com, joel@jms.id.au, p.zabel@pengutronix.de, arnd@arndb.de, fcooper@ti.com, sergei.shtylyov@cogentembedded.com, yamada.masahiro@socionext.com, khoroshilov@ispras.ru, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, andriy.shevchenko@linux.intel.com, linuxarm@huawei.com
List-Id: linux-serial@vger.kernel.org

On 23/04/2018 09:14, Greg KH wrote:
> On Thu, Apr 19, 2018 at 11:37:48PM +0800, John Garry wrote:
>> Currently the 8250_of driver only supports MEM IO type
>> accesses.
>>
>> Some development boards (Huawei D03, specifically) require
>> IO space access for 8250-compatible OF driver support, so
>> add it.
>>
>> The modification is quite simple: just set the port iotype
>> and associated flags depending on the device address
>> resource type.
>>
>> Signed-off-by: John Garry <john.garry@huawei.com>
>
> This no longer applies to my tree due to a patch that was sent before
> yours that conflicts in the same area.  Can you rebase it against my
> tty-testing branch and resend?
>

Hi Greg,

OK, I'll do that. I will also make this small improvement to this patch:

+	if ((resource.flags & IORESOURCE_TYPE_BITS) == IORESOURCE_IO) {
+		port->iotype = UPIO_PORT;

	|
	V

+	if (resource_type(&resource) == IORESOURCE_IO) {
+		port->iotype = UPIO_PORT;

All the best,
John

> thanks,
>
> greg k-h
>
> .
>
