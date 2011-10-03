From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: Re: [PATCH 3/3] tty/serial: atmel_serial: __devinit_p for probe function
Date: Mon, 03 Oct 2011 10:56:43 +0200
Message-ID: <4E8978CB.1000807@atmel.com>
References: <b371e80a96a36d962fb8806c2bd7aa20bb688b88.1317634987.git.nicolas.ferre@atmel.com> <cd489c1d28c26624d6b68399d222aec371045e53.1317634987.git.nicolas.ferre@atmel.com> <20111003085029.GA11710@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from newsmtp5.atmel.com ([204.2.163.5]:59083 "EHLO
	sjogate2.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751852Ab1JCI47 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 3 Oct 2011 04:56:59 -0400
In-Reply-To: <20111003085029.GA11710@n2100.arm.linux.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, alan@linux.intel.com, linux-serial@vger.kernel.org, plagnioj@jcrosoft.com, linux-kernel@vger.kernel.org

On 10/03/2011 10:50 AM, Russell King - ARM Linux :
> On Mon, Oct 03, 2011 at 11:46:16AM +0200, Nicolas Ferre wrote:
>> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
>> ---
>>  drivers/tty/serial/atmel_serial.c |    2 +-
>>  1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
>> index a652f8f..453cdb5 100644
>> --- a/drivers/tty/serial/atmel_serial.c
>> +++ b/drivers/tty/serial/atmel_serial.c
>> @@ -1789,7 +1789,7 @@ static int __devexit atmel_serial_remove(struct platform_device *pdev)
>>  }
>>  
>>  static struct platform_driver atmel_serial_driver = {
>> -	.probe		= atmel_serial_probe,
>> +	.probe		= __devexit_p(atmel_serial_probe),
> 
> That doesn't match the patch description (and is probably wrong.)

Yes, indeed.
Sorry for the noise!
-- 
Nicolas Ferre


