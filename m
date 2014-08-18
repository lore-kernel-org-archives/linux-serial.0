From: Grant Edwards <grant.b.edwards@gmail.com>
Subject: Re: is there a struct  uart_driver like struct i2c_driver
Date: Mon, 18 Aug 2014 16:19:22 +0000 (UTC)
Message-ID: <lst92a$7lq$1@ger.gmane.org>
References: <53F1CD68.9080901@ts.fujitsu.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:52711 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751831AbaHRQTc (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 18 Aug 2014 12:19:32 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <lnx-linux-serial@m.gmane.org>)
	id 1XJPed-00027S-97
	for linux-serial@vger.kernel.org; Mon, 18 Aug 2014 18:19:31 +0200
Received: from dsl.comtrol.com ([64.122.56.22])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Mon, 18 Aug 2014 18:19:31 +0200
Received: from grant.b.edwards by dsl.comtrol.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Mon, 18 Aug 2014 18:19:31 +0200
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

On 2014-08-18, Cestonaro Thilo <thilo.cestonaro@ts.fujitsu.com> wrote:

> I need to write a driver which communicates with it's chip via uart.
> So I was wondering which the best way is to do this.

What I think you're talking about is usually called a "line
discipline":

http://www.linux-mag.com/id/1891/
http://en.wikipedia.org/wiki/Line_discipline
http://www.linux.it/~rubini/docs/serial/serial.html

[Some of those links are a bit out-of-date, but should provide a good
idea what a line discipline is.]

Line disciplines are kernel drivers that use a well-defined API to
talk to the tty/serial/uart drivers that exist at a lower layer.

-- 
Grant Edwards               grant.b.edwards        Yow! MERYL STREEP is my
                                  at               obstetrician!
                              gmail.com            

