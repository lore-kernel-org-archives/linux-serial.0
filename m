From: Thomas Koeller <thomas.koeller@baslerweb.com>
Subject: Re: [PATCH] RM9000 serial driver
Date: Tue, 15 Aug 2006 23:15:54 +0200
Message-ID: <200608152315.55104.thomas.koeller@baslerweb.com>
References: <200608102318.52143.thomas.koeller@baslerweb.com> <44DCDCED.7000404@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail01.hansenet.de ([213.191.73.61]:51174 "EHLO
	webmail.hansenet.de") by vger.kernel.org with ESMTP
	id S1750715AbWHOVQl (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 15 Aug 2006 17:16:41 -0400
In-Reply-To: <44DCDCED.7000404@ru.mvista.com>
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: rmk+serial@arm.linux.org.uk, linux-serial@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org, Thomas =?iso-8859-1?q?K=F6ller?= <thomas@koeller.dyndns.org>

On Friday 11 August 2006 21:39, Sergei Shtylyov wrote:
>     I highly doubt this is how it should be done. Look at the Alchemy code
> as an example how the "partly-compatible" UART support should be written.
> Alchemy also has 32-bit MMIO and some registers mapped differently.
>
> WBR, Sergei

Seems I cannot find the code you are referring to - could you point me at
the particular file(s) to look at?

Thanks,
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
