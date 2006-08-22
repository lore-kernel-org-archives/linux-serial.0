From: Thomas Koeller <thomas.koeller@baslerweb.com>
Subject: Re: [PATCH] RM9000 serial driver
Date: Tue, 22 Aug 2006 22:27:20 +0200
Message-ID: <200608222227.20181.thomas.koeller@baslerweb.com>
References: <200608102318.52143.thomas.koeller@baslerweb.com> <200608220057.52213.thomas.koeller@baslerweb.com> <20060822095942.4663a4cd.yoichi_yuasa@tripeaks.co.jp>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail01.hansenet.de ([213.191.73.61]:63673 "EHLO
	webmail.hansenet.de") by vger.kernel.org with ESMTP id S932079AbWHVU1v
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 22 Aug 2006 16:27:51 -0400
In-Reply-To: <20060822095942.4663a4cd.yoichi_yuasa@tripeaks.co.jp>
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
Cc: sshtylyov@ru.mvista.com, rmk+serial@arm.linux.org.uk, linux-serial@vger.kernel.org, ralf@linux-mips.org, linux-mips@linux-mips.org, Thomas =?iso-8859-1?q?K=F6ller?= <thomas@koeller.dyndns.org>

On Tuesday 22 August 2006 02:59, Yoichi Yuasa wrote:
>
> If you have an another standard 8250 port. this driver cannot support it
> You should do as well as AU1X00.
>
> Yoichi

The AU1X00 code obviously assumes that every port that is not an AU1X00 is
a standard port requiring no register mapping. However, this is of course
not necessarily true in the most general case. There could be platforms
with multiple ports, all non-standard, but in different ways. Handling this
would require per-port mapping functions, which could be achieved by adding
function pointers to struct uart_8250_port. However, this would add the
overhead of a real, non-inlined function call to every register access.

Also, it seems to me that the whole register-mapping stuff conflicts with
autodetection, because autoconfig() uses serial_inp() and serial_outp()
before the port types, and hence the mapping requirements, are known.
This is not a problem for me, however, since the correct port type is
set up by the platform using early_serial_setup().

-- 
Thomas Koeller, Software Development

Basler Vision Technologies
An der Strusbek 60-62
22926 Ahrensburg
Germany

Tel +49 (4102) 463-390
Fax +49 (4102) 463-46390

mailto:thomas.koeller@baslerweb.com
http://www.baslerweb.com
