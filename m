From: Cestonaro Thilo <thilo.cestonaro@ts.fujitsu.com>
Subject: Re: is there a struct  uart_driver like struct i2c_driver
Date: Tue, 19 Aug 2014 14:25:57 +0200
Message-ID: <53F34255.8050600@ts.fujitsu.com>
References: <53F1CD68.9080901@ts.fujitsu.com> <20140818105307.GA5811@kroah.com> <53F1DF48.8000007@ts.fujitsu.com> <53F1E14D.7000408@ts.fujitsu.com> <53F202FF.5020809@ts.fujitsu.com> <20140818135046.GA927@kroah.com> <53F21418.80307@ts.fujitsu.com> <20140818150708.GA31497@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from dgate20.ts.fujitsu.com ([80.70.172.51]:5701 "EHLO
	dgate20.ts.fujitsu.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750806AbaHSMZB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 19 Aug 2014 08:25:01 -0400
In-Reply-To: <20140818150708.GA31497@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>

> You might want to step back and describe what you are wanting to do in
> the first place before wanting to add a new line discipline.
>
>
Ok.
Imagine you have two chips, one is the cpu and the other one is a device
which needs to be configured, accessed, talked to via uart.
The both chips are hardwired via uart.
Now I want to communicate from the kernel module with the device.
let the device be a RTC Device which has a UART interface.

And I don't want to rewrite all the uart device stuff of the cpu uart
device.

As a i2c client doesn't implement master_xfer or whatever the transfer
methods are called in the i2c controller module.
It just does a i2c->write(reg, value) and I need something equivalent
like uart->send(data, len); and uart->handle_recieved =
my_recieved_data_handler;

Something like that.
Hope this explains it better!

As far as I currently understood, this would be a line discipline.

Cheers,
Thilo


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


