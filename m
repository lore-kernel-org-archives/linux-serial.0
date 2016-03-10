From: "Lu.Jiang" <lu.jiang@windriver.com>
Subject: Re: [v2] serial_core:recognize invalid pointer from userspace
Date: Thu, 10 Mar 2016 12:56:23 +0800
Message-ID: <56E0FE77.1020303@windriver.com>
References: <1457579843-29676-1-git-send-email-lu.jiang@windriver.com>
 <1457579843-29676-2-git-send-email-lu.jiang@windriver.com>
 <20160310033435.GA28983@kroah.com>
Reply-To: <lu.jiang@windriver.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="------------040500070609010803030101"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160310033435.GA28983@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

--------------040500070609010803030101
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit

On 2016年03月10日 11:34, Greg KH wrote:
> On Thu, Mar 10, 2016 at 11:17:23AM +0800, Jiang Lu wrote:
>> compat_ioctl use 0xffffffff as a magic number to mark invalid pointer
>> for iomem_base in serial_struct when truncating a 64bit pointer into
>> 32bit.
>>
>> Serial driver need recognize this invalid pointer when parsing
>> serial_struct from userspace.
>>
>> Signed-off-by: Jiang Lu <lu.jiang@windriver.com>
>> ---
>>   drivers/tty/serial/serial_core.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
>> index a5d545e..d293536 100644
>> --- a/drivers/tty/serial/serial_core.c
>> +++ b/drivers/tty/serial/serial_core.c
>> @@ -745,6 +745,9 @@ static int uart_set_info(struct tty_struct *tty, struct tty_port *port,
>>   	 * allocations, we should treat type changes the same as
>>   	 * IO port changes.
>>   	 */
>> +	if ((unsigned long)new_info->iomem_base == 0xffffffff)
>> +		new_info->iomem_base = (void *)(unsigned long)uport->mapbase;
> This looks really odd to me, why do we care about userspace issues here?
> Shouldn't the compat ioctl code have handled this already all for us?
When getting serial struct, compat ioctl code just set it to 0xffffffff 
when 64bit iomem_base is beyond 32bit in kernel.

Then when setting serial_struct, compat ioctl code for TIOCSSERIAL can 
not restore original value, it need serial_core to take care of this.
>
> And why set it to mapbase?  Just to keep it from being changed?

Serial_core just restore the invalid value with original value to make 
following code in uart_set_info() happy.

>
> this worries me...


Actually, This member introduce lots of trouble with 32bit/64bit 
conversion. For example,

When userspace get setting with TIOCGSERIAL,

1.On 64bit kernel + 32bit rootfs, compat ioctl code use 0xffffffff to 
mark invalid conversion.

2.On 32bit kernel with 64bit physical address, uart_get_info() in 
serial_core will truncate a 64bit address into 32bit pointer with 
following code:
     retinfo->iomem_base      = (void *)(unsigned long)uport->mapbase;

Then when setting with TIOCSSERIAL ioctl, application can not provide 
original value for iomem_base, it leads setserial can not work on such 
boards.

I don't know why kernel should expose this value to userspace, and seems 
no need for userspace application to update an physical address for driver.
Can we consider drop this member in handle for TIOCSSERIAL ioctl. Please 
see a rough patch in attachment.

Thanks
Jiang Lu
>
> greg k-h
>


--------------040500070609010803030101
Content-Type: text/x-patch;
	name="0001-serial_core-stop-updating-mapbase-in-uart_set_info.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename*0="0001-serial_core-stop-updating-mapbase-in-uart_set_info.patc";
	filename*1="h"

>From 9bad3c17ef447c5cf89a2465833bbabed2800fe7 Mon Sep 17 00:00:00 2001
From: Jiang Lu <lu.jiang@windriver.com>
Date: Thu, 10 Mar 2016 12:51:54 +0800
Subject: [PATCH] serial_core:stop updating mapbase in uart_set_info()

Stop updating mapbase with iomem_base in uart_set_info().

Signed-off-by: Jiang Lu <lu.jiang@windriver.com>
---
 drivers/tty/serial/serial_core.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index a5d545e..cda9f9e 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -747,7 +747,6 @@ static int uart_set_info(struct tty_struct *tty, struct tty_port *port,
 	 */
 	change_port = !(uport->flags & UPF_FIXED_PORT)
 		&& (new_port != uport->iobase ||
-		    (unsigned long)new_info->iomem_base != uport->mapbase ||
 		    new_info->hub6 != uport->hub6 ||
 		    new_info->io_type != uport->iotype ||
 		    new_info->iomem_reg_shift != uport->regshift ||
@@ -803,11 +802,10 @@ static int uart_set_info(struct tty_struct *tty, struct tty_port *port,
 	}
 
 	if (change_port) {
-		unsigned long old_iobase, old_mapbase;
+		unsigned long old_iobase;
 		unsigned int old_type, old_iotype, old_hub6, old_shift;
 
 		old_iobase = uport->iobase;
-		old_mapbase = uport->mapbase;
 		old_type = uport->type;
 		old_hub6 = uport->hub6;
 		old_iotype = uport->iotype;
@@ -824,7 +822,6 @@ static int uart_set_info(struct tty_struct *tty, struct tty_port *port,
 		uport->hub6 = new_info->hub6;
 		uport->iotype = new_info->io_type;
 		uport->regshift = new_info->iomem_reg_shift;
-		uport->mapbase = (unsigned long)new_info->iomem_base;
 
 		/*
 		 * Claim and map the new regions
@@ -846,7 +843,6 @@ static int uart_set_info(struct tty_struct *tty, struct tty_port *port,
 			uport->hub6 = old_hub6;
 			uport->iotype = old_iotype;
 			uport->regshift = old_shift;
-			uport->mapbase = old_mapbase;
 
 			if (old_type != PORT_UNKNOWN) {
 				retval = uport->ops->request_port(uport);
-- 
1.9.1


--------------040500070609010803030101--
