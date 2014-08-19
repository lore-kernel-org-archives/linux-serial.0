From: Cestonaro Thilo <thilo.cestonaro@ts.fujitsu.com>
Subject: Re: is there a struct  uart_driver like struct i2c_driver
Date: Tue, 19 Aug 2014 14:45:47 +0200
Message-ID: <53F346FB.5020101@ts.fujitsu.com>
References: <53F1CD68.9080901@ts.fujitsu.com> <20140818105307.GA5811@kroah.com> <53F1DF48.8000007@ts.fujitsu.com> <53F1E14D.7000408@ts.fujitsu.com> <53F202FF.5020809@ts.fujitsu.com> <20140818135046.GA927@kroah.com> <53F21418.80307@ts.fujitsu.com> <20140818150708.GA31497@kroah.com> <53F34255.8050600@ts.fujitsu.com> <20140819123923.GA7791@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from dgate10.ts.fujitsu.com ([80.70.172.49]:55003 "EHLO
	dgate10.ts.fujitsu.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751827AbaHSMot (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 19 Aug 2014 08:44:49 -0400
In-Reply-To: <20140819123923.GA7791@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>

On 19.08.2014 14:39, Greg KH wrote:
> On Tue, Aug 19, 2014 at 02:25:57PM +0200, Cestonaro Thilo wrote:
>>> You might want to step back and describe what you are wanting to do in
>>> the first place before wanting to add a new line discipline.
>>>
>>>
>> Ok.
>> Imagine you have two chips, one is the cpu and the other one is a device
>> which needs to be configured, accessed, talked to via uart.
>> The both chips are hardwired via uart.
>> Now I want to communicate from the kernel module with the device.
> Why within the kernel?  Why not do the communication from userspace?
Cause it's a rtc, and I don't know of a way to have a /dev/rtc from
userspace

>
>> let the device be a RTC Device which has a UART interface.
> How do you talk to this UART?  Through a "normal" serial chip that the
> kernel already has a driver for, or through some other hardware control
> interface?
Jup, via normal serial chip.

>
>> And I don't want to rewrite all the uart device stuff of the cpu uart
>> device.
> What do you mean by this?
As it is via a normal serial chip, one option would be to write a
sperate driver which includes all the register stuff from the original
serial chip module.
But this, I don't want to do.
>
>> As a i2c client doesn't implement master_xfer or whatever the transfer
>> methods are called in the i2c controller module.
>> It just does a i2c->write(reg, value) and I need something equivalent
>> like uart->send(data, len); and uart->handle_recieved =
>> my_recieved_data_handler;
> Do that in userspace :)
Is there a way to have a HW Clock support from userland?


> thanks,
>
> greg k-h
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

