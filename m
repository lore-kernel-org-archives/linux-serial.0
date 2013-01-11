From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: [PATCH 4/4] serial/arc-uart: switch to devicetree based probing
Date: Fri, 11 Jan 2013 17:25:22 +0530
Message-ID: <50EFFDAA.6060204@synopsys.com>
References: <1357885223-19243-1-git-send-email-vgupta@synopsys.com> <1357885223-19243-5-git-send-email-vgupta@synopsys.com> <201301111133.43507.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from us01smtp3.synopsys.com ([198.182.44.81]:36458 "EHLO
	hermes.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753699Ab3AKL5p (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 11 Jan 2013 06:57:45 -0500
In-Reply-To: <201301111133.43507.arnd@arndb.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Grant Likely <grant.likely@secretlab.ca>, Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, devicetree-discuss@lists.ozlabs.org, Rob Herring <rob.herring@calxeda.com>, Rob Landley <rob@landley.net>

On Friday 11 January 2013 05:03 PM, Arnd Bergmann wrote:
> On Friday 11 January 2013, Vineet Gupta wrote:
>> * DT binding for arc-uart
>> * With alll the bits in place we can now use DT probing.
>>
>> Note that there's a bit of kludge right now because earlyprintk portion
>> of driver can't use the DT infrastrcuture to get resoures/plat_data.
>> This requires some infrastructre changes to of_flat_ framework
>>
>> Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
>> Cc: Grant Likely <grant.likely@secretlab.ca>
>> Cc: Arnd Bergmann <arnd@arndb.de>
>> Cc: linux-serial@vger.kernel.org
>> Cc: Alan Cox <alan@linux.intel.com>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Cc: devicetree-discuss@lists.ozlabs.org
>> Cc: Rob Herring <rob.herring@calxeda.com>
>> Cc: Rob Landley <rob@landley.net>
>> Cc: linux-serial@vger.kernel.org
> Acked-by: Arnd Bergmann <arnd@arndb.de>
>
> Quick question about the name though: is this UART only used
> on ARC, or is it something that synopsys licenses to other
> parties as well? If the latter is true, we might want to 
> add a more generic "compatible" value for those that use
> it on another architecture.

It's not licensed as standalone IP - since its not a standard 8250. It is only
(but actively) used on the internal FPGA flows from ARC days.

Thx,
Vineet

> 	Arnd

