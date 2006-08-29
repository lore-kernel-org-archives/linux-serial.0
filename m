From: Thomas Koeller <thomas.koeller@baslerweb.com>
Subject: Re: [PATCH] RM9000 serial driver
Date: Wed, 30 Aug 2006 01:05:26 +0200
Message-ID: <200608300105.26921.thomas.koeller@baslerweb.com>
References: <200608102318.52143.thomas.koeller@baslerweb.com> <200608222227.20181.thomas.koeller@baslerweb.com> <44F459DD.8060902@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail01.hansenet.de ([213.191.73.61]:27049 "EHLO
	webmail.hansenet.de") by vger.kernel.org with ESMTP id S965039AbWH2XGy
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 29 Aug 2006 19:06:54 -0400
In-Reply-To: <44F459DD.8060902@ru.mvista.com>
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>, rmk+serial@arm.linux.org.uk, linux-serial@vger.kernel.org, ralf@linux-mips.org, linux-mips@linux-mips.org, Thomas =?iso-8859-1?q?K=F6ller?= <thomas@koeller.dyndns.org>

On Tuesday 29 August 2006 17:14, Sergei Shtylyov wrote:
> > Also, it seems to me that the whole register-mapping stuff conflicts with
> > autodetection, because autoconfig() uses serial_inp() and serial_outp()
> > before the port types, and hence the mapping requirements, are known.
>
>     Port types have nothing to do with this. Or at least they hadn't until
> your recent patch. :-)
>     iotype was used to identify the addressing scheme, and it's alsready
> known beforehand.

How so? If I do not yet know which hardware I am dealing with, how can I know
the iotype?

Thomas 
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
