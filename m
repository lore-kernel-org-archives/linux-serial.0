From: Martin Fuzzey <mfuzzey@gmail.com>
Subject: Re: Serial: sc26xx device name
Date: Sat, 21 Nov 2009 15:23:32 +0100
Message-ID: <4B07F7E4.1070207@gmail.com>
References: <4B07F068.1090801@gmail.com> <20091121140911.0e7ef3fd@lxorguk.ukuu.org.uk>
Reply-To: mfuzzey@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.26]:60224 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754642AbZKUOX3 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 21 Nov 2009 09:23:29 -0500
In-Reply-To: <20091121140911.0e7ef3fd@lxorguk.ukuu.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-serial@vger.kernel.org, tsbogend@alpha.franken.de, linux-kernel@vger.kernel.org

Alan Cox wrote:
>> 2) How are device name conflicts handled?
>>     
>
> Badly - they should never occur but if someone didn't properly reserve
> the namespace they can and then whoever forgot to reserve the namespace
> loses.
>   
Currently this can't happen because the sc26xx driver uses ttySC205
in contradiction to ttySC0 shown in devices.txt

However if the driver were to be  "fixed" to use the name registered
in devices.txt a conflict could occur if a sc26xx chip were used on
a superH system.

The problem seems to be that while the major/minor numbers in devices.txt
are unique (and the drivers are correctly using their registered numbers),
the _names_ are not unique (at least in this case - I haven't checked for
others).


