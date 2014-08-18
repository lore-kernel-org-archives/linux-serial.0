From: Cestonaro Thilo <thilo.cestonaro@ts.fujitsu.com>
Subject: Re: is there a struct  uart_driver like struct i2c_driver
Date: Mon, 18 Aug 2014 15:43:27 +0200
Message-ID: <53F202FF.5020809@ts.fujitsu.com>
References: <53F1CD68.9080901@ts.fujitsu.com> <20140818105307.GA5811@kroah.com> <53F1DF48.8000007@ts.fujitsu.com> <53F1E14D.7000408@ts.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from dgate20.ts.fujitsu.com ([80.70.172.51]:62533 "EHLO
	dgate20.ts.fujitsu.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751120AbaHRNmb (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 18 Aug 2014 09:42:31 -0400
In-Reply-To: <53F1E14D.7000408@ts.fujitsu.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>

Hey,

do I need to do something like:
----
f = filp_open("/dev/ttyS0", O_RDWR | O_NOCTTY | O_NDELAY, 0600);
fs=get_fs();
set_fs(KERNEL_DS);
---
Is there really no API for a uart attached device to communicate with it?

That would be the last thing I thought of :(.

Cheers,
Thilo


On 18.08.2014 13:19, Cestonaro Thilo wrote:
> Hmm or not :( ... at a first glance it was.
>
> But this is for a driver which implements the UART support but I want 
> to use the UART but not implement it's hw support.
>
> As a i2c_module doesn't implement the i2c controller support but uses it.
>
> Or do I miss something?
>
> Cheers,
> Thilo
>
> On 18.08.2014 13:11, Cestonaro Thilo wrote:
>> Thx Greg. This one I missed!
>>
>> But it's what I searched for.
>>
>> Cheers,
>> Thilo
>>
>> On 18.08.2014 12:53, Greg KH wrote:
>>> On Mon, Aug 18, 2014 at 11:54:48AM +0200, Cestonaro Thilo wrote:
>>>> Hey,
>>>>
>>>> I need to write a driver which communicates with it's chip via uart.
>>>> So I was wondering which the best way is to do this.
>>>>
>>>> For a i2c device there is the i2c subsystem with it's
>>>> "module_i2c_driver(foo_driver);" and so on.
>>>> But I couldn't find any equivalent for a uart device.
>>> Did you see include/linux/serial_core.h ?
>>>
>>
>>
>
>


-- 
With best regards
Thilo Cestonaro

FTS PSO PM&D CCD E EPC

Fujitsu Technology Solutions GmbH
Buergermeister-Ulrich-Str. 100
86199 Augsburg
Germany

Tel.: +49 (0)821 804 2328
Fax: +49 (0)821 804 82328
E-mail: thilo.cestonaro@ts.fujitsu.com

Web: http://ts.fujitsu.com
Company details: http://ts.fujitsu.com/imprint

