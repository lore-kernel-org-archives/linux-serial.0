From: Thomas Weber <thomas.weber.linux@googlemail.com>
Subject: Re: SC16is752 I2c driver
Date: Wed, 23 Feb 2011 08:31:45 +0100
Message-ID: <4D64B7E1.7090708@gmail.com>
References: <4D63C80A.3070005@dawning.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-bw0-f51.google.com ([209.85.214.51]:46455 "EHLO
	mail-bw0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753149Ab1BWHcS (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 23 Feb 2011 02:32:18 -0500
Received: by bwz10 with SMTP id 10so4204937bwz.10
        for <linux-serial@vger.kernel.org>; Tue, 22 Feb 2011 23:32:17 -0800 (PST)
In-Reply-To: <4D63C80A.3070005@dawning.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
Cc: Pete Murray <pmurray@dawning.com>, linux-serial@vger.kernel.org, Manuel Stahl <manuel.stahl@iis.fraunhofer.de>

Hello Manuel,

Am 22.02.2011 15:28, schrieb Pete Murray:
> Hello,
> 
> I wrote an I2C  driver for the SC16is752 dual Uart chip, I see there is
> an SPI version now.  There was no SPI version when I was developing, if
> there was I would have tried to add I2C support to that driver instead. 
> Is this something I should post for review, or should I work on adding
> support to the existing SPI version?
> Thanks
> Pete
> 

do you have an updated version of your SC16IS752 driver, so that Pete
can add his I2C part?


Regards,
Thomas
