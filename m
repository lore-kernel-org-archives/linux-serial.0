From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: ARC fails to boot on linux-next of 20140711
Date: Fri, 25 Jul 2014 16:56:14 +0530
Message-ID: <53D23ED6.9010502@synopsys.com>
References: <C2D7FE5348E1B147BCA15975FBA230753C4B67CF@IN01WEMBXA.internal.synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <C2D7FE5348E1B147BCA15975FBA230753C4B67CF@IN01WEMBXA.internal.synopsys.com>
Sender: linux-next-owner@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: linux-next <linux-next@vger.kernel.org>, Rob Herring <robherring2@gmail.com>, Anton Kolesov <Anton.Kolesov@synopsys.com>, lkml <linux-kernel@vger.kernel.org>, greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Friday 25 July 2014 04:32 PM, Vineet Gupta wrote:
> 2014-03-27 a9296cf2d0b6 of: Create of_console_check() for selecting a console
> specified in /chosen 
> 2014-03-27 cfa9cacc5dd3 of: Enable console on serial ports specified by
> /chosen/stdout-path 
> 
> Is there a specific reason for dropping these patches (or perhaps a merge to be
> merged). I cherry-picked both but still doesn't work.

Correction - with these two, ARC boots again.

Thx,
-Vineet
