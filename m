From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: [PATCH 0/4] switch arc-uart to devicetree based probing
Date: Wed, 16 Jan 2013 11:46:56 +0530
Message-ID: <50F645D8.1080404@synopsys.com>
References: <1357885223-19243-1-git-send-email-vgupta@synopsys.com> <20130116061636.GA5680@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from alvesta.synopsys.com ([198.182.60.77]:34404 "EHLO
	alvesta.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757831Ab3APGRK (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 16 Jan 2013 01:17:10 -0500
In-Reply-To: <20130116061636.GA5680@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org

On Wednesday 16 January 2013 11:46 AM, Greg KH wrote:
> On Fri, Jan 11, 2013 at 11:50:19AM +0530, Vineet Gupta wrote:
>> Hi,
>>
>> As part of converting ARC Port to devicetree infrastructure, the following
>> series converts the arc-uart driver to DT.
>>
>> * The first patch is a bug-fix which showed up in the process as DT based
>>   platform devices by default have -ve id
>> * Next two prepare the driver for forthcoming DT changes.
>> * Last one contains the DT bindings and driver using those.
>>
>> Couple of points worth mentioning:
>> * The earlyprintk portion of driver still relies on static platform data
>>   we would need some earlyprintk handling in of_fdt_* to clean it up properly
>> * Two of the three platform data instances are now retrieved from DT.
>>   However one still needs to be dynamically passed by platform (using
>>   of_dev_auxdata) as we want to run same image in simulator and hardware
>>
>> Tested on in-works ARC 3.8 port.
>>
>> P.S. Greg, can this be treated as a bug-fix for 3.8
> No, because it is not a bugfix, but a new feature, sorry.
>
> greg k-h

NP. Thx a bunch for merging these.
-Vineet
