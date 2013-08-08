From: John Crispin <blogic@openwrt.org>
Subject: Re: [PATCH 1/2] serial: MIPS: lantiq: add clk_enable() call to driver
Date: Thu, 08 Aug 2013 16:56:51 +0200
Message-ID: <5203B1B3.3010304@openwrt.org>
References: <1375968687-8704-1-git-send-email-blogic@openwrt.org> <5203AF83.30101@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from nbd.name ([46.4.11.11]:45548 "EHLO nbd.name"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965294Ab3HHPDz (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 8 Aug 2013 11:03:55 -0400
In-Reply-To: <5203AF83.30101@imgtec.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: James Hogan <james.hogan@imgtec.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, linux-mips@linux-mips.org, Thomas Langer <thomas.langer@lantiq.com>

On 08/08/13 16:47, James Hogan wrote:
> On 08/08/13 14:31, John Crispin wrote:
>> From: Thomas Langer<thomas.langer@lantiq.com>
>>
>> Enable the clock if one is present when setting up the console.
>>
>> Signed-off-by: Thomas Langer<thomas.langer@lantiq.com>
>> Acked-by: John Crispin<blogic@openwrt.org>
>> ---
>>   drivers/tty/serial/lantiq.c |    3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/tty/serial/lantiq.c b/drivers/tty/serial/lantiq.c
>> index 15733da..ce1ea35 100644
>> --- a/drivers/tty/serial/lantiq.c
>> +++ b/drivers/tty/serial/lantiq.c
>> @@ -636,6 +636,9 @@ lqasc_console_setup(struct console *co, char *options)
>>
>>   	port =&ltq_port->port;
>>
>> +	if (ltq_port->clk)
> I think that should be !IS_ERR(ltq_port->clk)? The same problem appears
> to be elsewhere in that file too.
>
> Cheers
> James
>
>


Thanks, i will send an updated series

