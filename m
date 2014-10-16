From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: Re: [PATCH] serial: atmel: add missing dmaengine header
Date: Thu, 16 Oct 2014 15:48:18 +0200
Message-ID: <543FCCA2.20003@atmel.com>
References: <1413445197-22304-1-git-send-email-vinod.koul@intel.com> <20141016091059.GA24374@kroah.com> <20141016085635.GD1638@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.243]:35600 "EHLO
	eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752351AbaJPNsX (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 16 Oct 2014 09:48:23 -0400
In-Reply-To: <20141016085635.GD1638@intel.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Vinod Koul <vinod.koul@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, dmaengine@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.jf.intel.com>

On 16/10/2014 10:56, Vinod Koul :
> On Thu, Oct 16, 2014 at 11:10:59AM +0200, Greg Kroah-Hartman wrote:
>> On Thu, Oct 16, 2014 at 01:09:57PM +0530, Vinod Koul wrote:
>>> The atmel serial driver uses dmaengine APIs but never included the dmaengine
>>> header as it was getting inculded thru one of driver headers.
>>>
>>> commit 3d588f83e4d6a5230d9094b97d38621cbaa9a972 - "dmaengine: dw: split
>>> dma-dw.h to platform and private parts" broke this as it moved headers
>>> around.  Fix this by doing the right thing to include the dmaengine header
>>>
>>> Reported-by: kbuild test robot <fengguang.wu@intel.com>
>>> Signed-off-by: Vinod Koul <vinod.koul@intel.com>
>>> ---
>>> Greg, since this is path which broke this is sitting in my next, would it be
>>> okay to carry this thru dmaengine tree as get it merged in current window.
>>> Planning to send pull request in day or so to Linus
>>
>> Sure, that's fine with me:
>>
>> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Thanks :)
> 
> Applied, and pushed now

Vinod, thanks a lot for having handled this issue.

For the record even if it's too late:

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

Bye,
-- 
Nicolas Ferre
